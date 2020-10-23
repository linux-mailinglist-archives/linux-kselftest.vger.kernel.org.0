Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500E72970B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Oct 2020 15:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375119AbgJWNf0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Oct 2020 09:35:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgJWNf0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Oct 2020 09:35:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61CEE208E4;
        Fri, 23 Oct 2020 13:35:25 +0000 (UTC)
Date:   Fri, 23 Oct 2020 09:35:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] selftests/ftrace: remove _do_fork() leftovers
Message-ID: <20201023093523.65c495f8@gandalf.local.home>
In-Reply-To: <1603443123-17457-1-git-send-email-agordeev@linux.ibm.com>
References: <1603443123-17457-1-git-send-email-agordeev@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 23 Oct 2020 10:52:03 +0200
Alexander Gordeev <agordeev@linux.ibm.com> wrote:

> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
> index acb17ce..0ddb948 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-notrace-pid.tc
> @@ -39,7 +39,7 @@ do_test() {
>      disable_tracing
>  
>      echo do_execve* > set_ftrace_filter
> -    echo *do_fork >> set_ftrace_filter
> +    echo kernel_clone >> set_ftrace_filter
>  
>      echo $PID > set_ftrace_notrace_pid
>      echo function > current_tracer
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
> index 9f0a968..71319b3 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-pid.tc
> @@ -39,7 +39,7 @@ do_test() {
>      disable_tracing
>  
>      echo do_execve* > set_ftrace_filter
> -    echo *do_fork >> set_ftrace_filter
> +    echo kernel_clone >> set_ftrace_filter
>  
>      echo $PID > set_ftrace_pid
>      echo function > current_tracer

The issue I have with this, is that I run these tests on older kernels too,
and tests that use to work on older kernels should still work. In fact,
this fails on the kernel I'm currently adding new changes to!

Perhaps we should have:

	# older kernels have do_fork, but newer kernels have kernel_clone
	echo kernel_clone >> set_ftrace_filter || echo *do_fork >> set_ftrace_filter

The above still seems to work for me.

-- Steve
