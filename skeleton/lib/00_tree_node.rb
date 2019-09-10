class PolyTreeNode
    attr_reader :children, :parent

    def initialize(value)
        @value = value
        @parent = nil 
        @children = [] 
    end 

    # child_node.parent=(parent_node)
    def parent=(node) 
        if node.nil? 
            @parent = nil
        elsif @parent.nil? 
            @parent = node 
            @parent.children << self 
        else  
            if @parent.children.include?(self)
                @parent.children.delete(self)
            end 
            @parent = node
            @parent.children << self
        end 
    end 


    def value 
        @value
    end 

    # parent_node.add_child(child_node)
    def add_child(child_node)
        child_node.parent=(self)
    end 


    def remove_child(child_node)
        if !self.children.include?(child_node)
            raise "This node is not a child node"
        else  
            child_node.parent=(nil)
        end
    end 


    def dfs(target_value)
        return self if self.value == target_value

        self.children.each do |child_node| 
            search_result = child_node.dfs(target_value)
            if search_result != nil 
                return search_result 
            end 
        end 
        nil
    end 


    def bfs(target_value)
        queue = []
        queue << self 
        until queue.empty? 
            node = queue.shift 
            if node.value == target_value 
                return node 
            else  
                node.children.each { |child| queue << child }
            end 
        end 
        nil
    end 

end