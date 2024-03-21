Return-Path: <linux-kselftest+bounces-6457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71090881A5A
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 01:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4F31C20B93
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 00:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F10370;
	Thu, 21 Mar 2024 00:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5JBMlxg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CF3181;
	Thu, 21 Mar 2024 00:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710979795; cv=none; b=uoREIlOC5pRvkcQsgkjUnSGPc3SnvVj9mcg5VvI3x4hxe7w51OxlGnoPMDCRp+zUKa5DmPP0e8Aw4yYJqxFPiaigOtI7hYWuPSAKYXX4CTEs7gvk788oR6KXDKtNZJHZ+grHhVT6zQZh6JM5+UuLj1b6EF4dzOJSgAY7FKR6yAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710979795; c=relaxed/simple;
	bh=b3fhj+Y7w7mTM1r4m4zFP7hvSeXi94xhvksGojllfeE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Cn+6uktzEXDk07SjBPOmJtuDoNPsLs+uJcls6tx4yhkGhOne81hxiRe0H0jlYE5oZyjfchYteyH9vSlqvJLj8pCkMh9bQhIHxbR5wPSiJeK/k9NFuQxT75wCGdtmAL6/jiVptmW/YRdP+b7nThzBqtNsuKeDofHIA4FDKsczipw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5JBMlxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0044C433C7;
	Thu, 21 Mar 2024 00:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710979795;
	bh=b3fhj+Y7w7mTM1r4m4zFP7hvSeXi94xhvksGojllfeE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h5JBMlxgOO95XUSpRnjuxOaSJWSOW6PvFVxLcsQJc2TKZqox67ZeBeWenDNV6dbP5
	 U9ZWZ0Du5boyQXO4nvOqWGeLrJHoxKCffcliKILYTwNg8ypkRVxxn1rg74//f1VuOV
	 wwMyYqIXuFL9TwxiCizAhFju8iQNv8kukYMJTAfhuVsBLGQ8YeLT08Jbhj8QKduFsj
	 TqKF5cRoM9nu1uuoqc5n0rM666rrSpqjNm8biVLRKblDxojQQj7PreieWV9Ja079kH
	 75r/dztXpOVYwPPVbovWK11jQ3Xsyy1EGx5l93mtz7AjJSofbe6BU3Dsr9iM03Iacr
	 +PbU1GtKp618g==
Date: Thu, 21 Mar 2024 09:09:50 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, aishwarya.tcv@arm.com,
 linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH] selftests/ftrace: Fix event filter target_func
 selection
Message-Id: <20240321090950.f96e6b3918bb2dfd121db138@kernel.org>
In-Reply-To: <20240320141844.1779984-1-mark.rutland@arm.com>
References: <20240320141844.1779984-1-mark.rutland@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Mar 2024 14:18:44 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> The event filter function test has been failing in our internal test
> farm:
> 
> | # not ok 33 event filter function - test event filtering on functions
> 
> Running the test in verbose mode indicates that this is because the test
> erroneously determines that kmem_cache_free() is the most common caller
> of kmem_cache_free():
> 
>   # # + cut -d: -f3 trace
>   # # + sed s/call_site=([^+]*)+0x.*/1/
>   # # + sort
>   # # + uniq -c
>   # # + sort
>   # # + tail -n 1
>   # # + sed s/^[ 0-9]*//
>   # # + target_func=kmem_cache_free
> 
> .. and as kmem_cache_free() doesn't call itself, setting this as the
> filter function for kmem_cache_free() results in no hits, and
> consequently the test fails:
> 
>   # # + grep kmem_cache_free trace
>   # # + grep kmem_cache_free
>   # # + wc -l
>   # # + hitcnt=0
>   # # + grep kmem_cache_free trace
>   # # + grep -v kmem_cache_free
>   # # + wc -l
>   # # + misscnt=0
>   # # + [ 0 -eq 0 ]
>   # # + exit_fail
> 
> This seems to be because the system in question has tasks with ':' in
> their name (which a number of kernel worker threads have). These show up
> in the trace, e.g.
> 
>   test:.sh-1299    [004] .....  2886.040608: kmem_cache_free: call_site=putname+0xa4/0xc8 ptr=000000000f4d22f4 name=names_cache
> 
> .. and so when we try to extact the call_site with:
> 
>   cut -d: -f3 trace | sed 's/call_site=\([^+]*\)+0x.*/\1/'
> 
> .. the 'cut' command will extrace the column containing
> 'kmem_cache_free' rather than the column containing 'call_site=...', and
> the 'sed' command will leave this unchanged. Consequently, the test will
> decide to use 'kmem_cache_free' as the filter function, resulting in the
> failure seen above.
> 
> Fix this by matching the 'call_site=<func>' part specifically to extract
> the function name.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

I think this should be a fix because test task name can have ':'.

Fixes: eb50d0f250e9 ("selftests/ftrace: Choose target function for filter test from samples")
Cc: stable@vger.kernel.org

Shuah, can you pick this as a fix?

Thank you,

> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-trace-kernel@vger.kernel.org
> ---
>  .../selftests/ftrace/test.d/filter/event-filter-function.tc     | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc b/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
> index 2de7c61d1ae3..3f74c09c56b6 100644
> --- a/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
> +++ b/tools/testing/selftests/ftrace/test.d/filter/event-filter-function.tc
> @@ -24,7 +24,7 @@ echo 0 > events/enable
>  echo "Get the most frequently calling function"
>  sample_events
>  
> -target_func=`cut -d: -f3 trace | sed 's/call_site=\([^+]*\)+0x.*/\1/' | sort | uniq -c | sort | tail -n 1 | sed 's/^[ 0-9]*//'`
> +target_func=`cat trace | grep -o 'call_site=\([^+]*\)' | sed 's/call_site=//' | sort | uniq -c | sort | tail -n 1 | sed 's/^[ 0-9]*//'`
>  if [ -z "$target_func" ]; then
>      exit_fail
>  fi
> -- 
> 2.39.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

