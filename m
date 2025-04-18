Return-Path: <linux-kselftest+bounces-31123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B60E7A93346
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 09:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623A01899283
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 07:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3F5269AF9;
	Fri, 18 Apr 2025 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpVt9SZh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656BF268698;
	Fri, 18 Apr 2025 07:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744960447; cv=none; b=h7Q89eFfbKNDXVl+JsjoZZmLXhb2xwE2ZnEVbzGp04Dz8zrhCpyX8aUjw2WNaaOGOAQ+91LYwcrrhqlGwEYjJtfjri3C40FLLTBw14uT6A8Zt3hysnyrI/kWl8wwhz53VFONly8XtBfOAbQYSXbU/DEy+wTP/FpicPNPF9qCj0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744960447; c=relaxed/simple;
	bh=OtbMZAQC1Yc9fSrGOF8eIeJqO6sSg/QCb7u+/K+8ask=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Wp3R812umGcC1fnZ/t2f2YcsCVKQMdBc6VF0i0k7tFIE8dF7n69QAvn8zOXELD1Dvbe4NEeIlq1THZrwyPfMLHTV/LYp0YMJwa5S99zZXTrN12KSgZYTgfUG1XZ0IiHs4qCK6IR3q50axvkHmsbV+nbP5gPNWWcueC0T2fJegEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpVt9SZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F81CC4CEE2;
	Fri, 18 Apr 2025 07:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744960446;
	bh=OtbMZAQC1Yc9fSrGOF8eIeJqO6sSg/QCb7u+/K+8ask=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NpVt9SZhjnP2p6F4bm9bGFQSpD1XtBI0S+uqpw4ntj5He35B8ahfwrVs8hdxhFHJX
	 6yRVSxiTwuaRwzip5fT6UXcfii87DUwJ2UM3qfdx3PTYnDJELR7/T7fcBBGqB0D9PT
	 n7Cxslzb71HUy4BySYpltNvVwN91rFgxuSLd868viHlDtYZPK4sruNkPsMan6k/zHP
	 Ha1FsiOtefrTKTvXt9GH1EhYIzc9Zh0Z59E6Mw4w0lXud+WZQpx9a0IPN3yQvGSlJU
	 hYOHUn79a0eFhkBecVfvSKNZhfpPuK2g6/TF4uDV+tWTqjpRMC4X455YQkaVl5eIuD
	 GUXlkTSnKbgMA==
Date: Fri, 18 Apr 2025 16:14:04 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tracing: selftests: Add testing a user string to
 filters
Message-Id: <20250418161404.04771abaeafec2dce3413247@kernel.org>
In-Reply-To: <20250417223323.3edb4f6c@batman.local.home>
References: <20250417223323.3edb4f6c@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 22:33:23 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Running the following commands was broken:
> 
>   # cd /sys/kernel/tracing
>   # echo "filename.ustring ~ \"/proc*\"" > events/syscalls/sys_enter_openat/filter
>   # echo 1 > events/syscalls/sys_enter_openat/enable
>   # ls /proc/$$/maps
>   # cat trace
> 
> And would produce nothing when it should have produced something like:
> 
>       ls-1192    [007] .....  8169.828333: sys_openat(dfd: ffffffffffffff9c, filename: 7efc18359904, flags: 80000, mode: 0)
> 
> Add a test to check this case so that it will be caught if it breaks
> again.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Shuah, I'm Cc'ing you on this for your information, but I'll take it
> through my tree as it will be attached with the fix, as it will fail
> without it.
> 
>  .../test.d/filter/event-filter-function.tc    | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc b/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
> index 118247b8dd84..ab449a2cea8c 100644
> --- a/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
> +++ b/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
> @@ -80,6 +80,25 @@ if [ $misscnt -gt 0 ]; then
>  	exit_fail
>  fi
>  
> +# Check strings too
> +if [ -f events/syscalls/sys_enter_openat/filter ]; then
> +	echo "filename.ustring ~ \"*test.d*\"" > events/syscalls/sys_enter_openat/filter

I think it is better to use a $TMPDIR for the test script,
instead of reusing the $TEST_DIR. Since $TMPDIR has been
introduced to be used for this purpose.

DIRNAME=`basename $TMPDIR`

echo "filename.ustring ~ \"\*$DIRNAME\*\"" > events/syscalls/sys_enter_openat/filter

> +	echo 1 > events/syscalls/sys_enter_openat/enable
> +	echo 1 > tracing_on
> +	ls /bin/sh
> +	nocnt=`grep openat trace | wc -l`
> +	ls $TEST_DIR

and `ls $TMPDIR` ?

Does that work?

Thank you,

> +	echo 0 > tracing_on
> +	hitcnt=`grep openat trace | wc -l`;
> +	echo 0 > events/syscalls/sys_enter_openat/enable
> +	if [ $nocnt -gt 0 ]; then
> +		exit_fail
> +	fi
> +	if [ $hitcnt -eq 0 ]; then
> +		exit_fail
> +	fi
> +fi
> +
>  reset_events_filter
>  
>  exit 0
> -- 
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

