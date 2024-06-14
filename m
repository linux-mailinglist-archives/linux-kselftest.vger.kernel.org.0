Return-Path: <linux-kselftest+bounces-11971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F5A9090B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 18:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E08BB21686
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 16:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0991190072;
	Fri, 14 Jun 2024 16:43:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD6D181B91;
	Fri, 14 Jun 2024 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718383405; cv=none; b=hcrjxva/fwxfgr4uRsQY4wmZGoTfBV9md7JTNoMuVq2DuKUvIA0/iocPYXGyZQsW0yMFpD8T6Xm75PArQLrhWfM4PxGfg8ig/WL0vdYZNd4n007qdcAmAZ6siGis0aPQtGk5yHvKE28DjKH4nGaqPArS4Z8XaL+HRL90kt8wCaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718383405; c=relaxed/simple;
	bh=jjK16E41dr1jwYKnMEUEtk5I3mLh25F5pNmx0OCJsxY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GVBjYXJV1wQ2VESIhP8uWLLipygj/VkPcE4Gux+jG5bULqLwZh5gKKjP3h7bG6y4G3hVQYuARAw1HsisNWYl4gSCLbKZMT8xr+ZO2hEL4W8vgMVbDMfU9Fo9kf87xA56jjit8PwuvXuKOuV1jN10Q95p3gUMD/kv/IbR8h3M6dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1109AC2BD10;
	Fri, 14 Jun 2024 16:43:23 +0000 (UTC)
Date: Fri, 14 Jun 2024 12:43:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@kernel.org>, Shuah
 Khan <shuahkhan@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Fix test to handle both old and new
 kernels
Message-ID: <20240614124322.36ad7652@rorschach.local.home>
In-Reply-To: <20240515013620.098cb37a@rorschach.local.home>
References: <20240515013620.098cb37a@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Shuah,

Can you take this through your tree?

Thanks,

-- Steve


On Wed, 15 May 2024 01:36:20 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The function "scheduler_tick" was renamed to "sched_tick" and a selftest
> that used that function for testing function trace filtering used that
> function as part of the test.
> 
> But the change causes it to fail when run on older kernels. As tests
> should not fail on older kernels, add a check to see which name is
> available before testing.
> 
> Fixes: 86dd6c04ef9f2 ("sched/balancing: Rename scheduler_tick() => sched_tick()")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  .../ftrace/test.d/ftrace/func_set_ftrace_file.tc         | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
> index 073a748b9380..263f6b798c85 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
> @@ -19,7 +19,14 @@ fail() { # mesg
>  
>  FILTER=set_ftrace_filter
>  FUNC1="schedule"
> -FUNC2="sched_tick"
> +if grep '^sched_tick\b' available_filter_functions; then
> +    FUNC2="sched_tick"
> +elif grep '^scheduler_tick\b' available_filter_functions; then
> +    FUNC2="scheduler_tick"
> +else
> +    exit_unresolved
> +fi
> +
>  
>  ALL_FUNCS="#### all functions enabled ####"
>  


