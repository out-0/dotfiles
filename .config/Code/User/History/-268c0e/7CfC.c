/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: aarid <aarid@student.1337.ma>              +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/29 09:54:33 by aarid             #+#    #+#             */
/*   Updated: 2025/12/09 11:37:26 by aarid            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

int main(int argc, char **argv)
{
	t_gc_node		*gc_head;
	t_stack_node	*stack_a;
	t_stack_node	*stack_b;
	int				size;
	int				*arguments;

	if (argc < 2)
		return (1);
	gc_head = NULL;
	size = 0;
	arguments = parse_input(argc, argv, &gc_head, &size);
	stack_a = NULL;
	stack_b = NULL;
	push_stack(&stack_a, arguments, size, &gc_head);
	if (size == 3)
		sort_3(&stack_a);
	else if (size == 2)
		sort_2(stack_a);
	else if (size <= 5)
		sort_5(&stack_a, &stack_b);

	ft_print_string("\n");

	print_stack_nodes(stack_a);
	(void)stack_a;
	garbage_cleaner(gc_head);
	return (0);
}
