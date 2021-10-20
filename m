Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E5E434F47
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Oct 2021 17:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhJTPuY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Oct 2021 11:50:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230369AbhJTPuY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Oct 2021 11:50:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 887DD61212;
        Wed, 20 Oct 2021 15:48:08 +0000 (UTC)
Date:   Wed, 20 Oct 2021 11:48:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/5] tracing: Fix operator precedence for hist
 triggers expression
Message-ID: <20211020114805.3fbb7d94@gandalf.local.home>
In-Reply-To: <20211020013153.4106001-4-kaleshsingh@google.com>
References: <20211020013153.4106001-1-kaleshsingh@google.com>
        <20211020013153.4106001-4-kaleshsingh@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 19 Oct 2021 18:31:40 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> @@ -2391,60 +2460,61 @@ static int check_expr_operands(struct trace_array *tr,
>  static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
>  				     struct trace_event_file *file,
>  				     char *str, unsigned long flags,
> -				     char *var_name, unsigned int level)
> +				     char *var_name, unsigned int *n_subexprs)
>  {
>  	struct hist_field *operand1 = NULL, *operand2 = NULL, *expr = NULL;
>  	unsigned long operand_flags;
>  	int field_op, ret = -EINVAL;
>  	char *sep, *operand1_str;
>  
> -	if (level > 3) {
> +	if (*n_subexprs > 3) {

Why limit the sub expressions, and not just keep the limit of the level of
recursion. We allow 3 levels of recursion, but we could have more than 3
sub expressions.


If we have:  a * b + c / d - e * f / h

It would break down into:
              -
       +            /
   *       /     *     h
 a   b   c  d  e  f


Which I believe is 6 "sub expressions", but never goes more than three deep
in recursion:

   "a * b + c / d - e * f / h"

Step 1:

  op = "-"
  operand1 = "a * b + c / d"
  operand2 = "e * f / h"

Process operand1: (recursion level 1)

  op = "+"
  operand1a = "a * b"
  operand2a = "c / d"

Process operand1a: (recursion level 2)

  op = "*"
  operand1b = "a"
  operand2b = "b"

return;

Process operand1b: (recursion level 2)

  op = "/"
  operand1b = "c"
  operand2b = "d"

return;

return;

Process operand2: (recursion level 1)

  op = "/"
  operand1c = "e * f"
  operand2c = "h"

Process operand1c: (recursion level 2)

  op = "*"
  operand1c = "e"
  operand2c = "f"

return;

return;



> +
> +	/* LHS of string is an expression e.g. a+b in a+b+c */
> +	operand1 = parse_expr(hist_data, file, operand1_str, operand_flags, NULL, n_subexprs);
>  	if (IS_ERR(operand1)) {
>  		ret = PTR_ERR(operand1);
>  		operand1 = NULL;

I wonder if we should look for optimizations, in case of operand1 and
operand2 are both constants?

Just perform the function, and convert it into a constant as well.

-- Steve
