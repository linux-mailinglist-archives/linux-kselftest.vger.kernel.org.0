Return-Path: <linux-kselftest+bounces-10456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D05C8CA5F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 03:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253D91F21A5D
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 01:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E3979F3;
	Tue, 21 May 2024 01:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAG9M4aM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8477134A9;
	Tue, 21 May 2024 01:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716256164; cv=none; b=W89mSbR9rn64J8gsSc8QX4lK3DL/oCheX0w/NKA4FYK3Bc9tw+KLgEqZMsaUwmu3AjNkJrVTlYZBSVat8EPcejgSupcyictFCgD3WOblS70G2b99baIrghTG8L6i5p1q1u5VAxTvsksjYKbMPOM3H7iNpmenHqErrIdZhgnABgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716256164; c=relaxed/simple;
	bh=6AoE8JrRf/P2Kp0T9FcUF8+twx+EGC02wSh/BOevY7c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=F/4BbOPNsM7L80+vJeaGvC/vnBUJ0LN7Pixf5NShx12ipyKfnnbgpFWXH29fhksWQlcWdm8jEsweKL7QXL0u2dKB/50dxFA74S9+GrHNAZG6LTA5gn8x1psxjR6dhUUgXOnTi2fjL+7FLSgcTShAxjQRsApZXkogSAf3Kvi4GCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAG9M4aM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C44BC2BD10;
	Tue, 21 May 2024 01:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716256163;
	bh=6AoE8JrRf/P2Kp0T9FcUF8+twx+EGC02wSh/BOevY7c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hAG9M4aMDyFTI9gkzPQ9lsVer3t+/x+zzxo2s+B5leazONUK9lv+B24U/aIUrb9NP
	 y498FfWhHbVtU+IHh/b1apxA6NBMUGnaTq9/sEJJd8S7R25GIltcUBNXSLDLw30ZRI
	 nMK7162iHL566J/vX8JlQwGTXRgOt/FPbXhtROdUt7Y4Pk8Z6lgRMgwjurxcF/ZzgC
	 bouY8lkIstj4h4HRx3SviNGOUEDThbKU7hXjoOrRlF+pEcCShh+UzKPFvuEEkvGyQa
	 8DdINs0a5ClV80tAB6wLOSJMjvI/J4qMGJz0DksPM3tprAVlXceFEVmlsdzEKCC4xI
	 9xUsOOV7Qn36w==
Date: Tue, 21 May 2024 10:49:19 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tracing/selftests: Fix kprobe event name test for
 .isra. functions
Message-Id: <20240521104919.c8fd7a91b4a9c0435d17017b@kernel.org>
In-Reply-To: <20240520205737.5085e53a@gandalf.local.home>
References: <20240520205737.5085e53a@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 May 2024 20:57:37 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The kprobe_eventname.tc test checks if a function with .isra. can have a
> kprobe attached to it. It loops through the kallsyms file for all the
> functions that have the .isra. name, and checks if it exists in the
> available_filter_functions file, and if it does, it uses it to attach a
> kprobe to it.
> 
> The issue is that kprobes can not attach to functions that are listed more
> than once in available_filter_functions. With the latest kernel, the
> function that is found is: rapl_event_update.isra.0
> 
>   # grep rapl_event_update.isra.0 /sys/kernel/tracing/available_filter_functions
>   rapl_event_update.isra.0
>   rapl_event_update.isra.0
> 
> It is listed twice. This causes the attached kprobe to it to fail which in
> turn fails the test. Instead of just picking the function function that is
> found in available_filter_functions, pick the first one that is listed
> only once in available_filter_functions.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Cc: stable@vger.kernel.org
> Fixes: 604e3548236de ("selftests/ftrace: Select an existing function in kprobe_eventname test")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  .../testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> index 1f6981ef7afa..ba19b81cef39 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> @@ -30,7 +30,8 @@ find_dot_func() {
>  	fi
>  
>  	grep " [tT] .*\.isra\..*" /proc/kallsyms | cut -f 3 -d " " | while read f; do
> -		if grep -s $f available_filter_functions; then
> +		cnt=`grep -s $f available_filter_functions | wc -l`;
> +		if [ $cnt -eq 1 ]; then
>  			echo $f
>  			break
>  		fi
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

