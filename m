Return-Path: <linux-kselftest+bounces-30911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67522A8ABA9
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 00:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB13F3BB1B8
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 22:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673272C2ABA;
	Tue, 15 Apr 2025 22:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hH5pwmgS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D5623D289;
	Tue, 15 Apr 2025 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744757917; cv=none; b=CH/sGrk6+1xzT8QNtQuDA+mIanjA1NfmjTZJRwERzFOsIC3+MvtC5yOax71W3bntSbo3RoZmI6ZpppAml4lTiuO4YUnuDow2rc5Q8+7bT9LvTQnQoqba3WAYzR25e+oX0aVSQnkbe1DttPTWg2vbIH4fVFkBsI7qVWRX4zJ1sgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744757917; c=relaxed/simple;
	bh=PQncLWSp8vRGUs7I1MsLblxC/UpK+WOGWqJsvx3Sq8c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ru6ICTNdKcjyLTDjGDEXQXEeI2qwwS0QE/EEn8V9e0UGz425bSjij09jRFd7Ua3jHc/DUUL8Jl9+boPpv5N4A6OvRmqg+uiA1KjFJW2IsZ6IUAec5ctm+P7DeiGn8YsqYKjCHRkjI6MThU0xp2q1G3ELDRyNspixyief6qn8i5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hH5pwmgS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAF8C4CEE7;
	Tue, 15 Apr 2025 22:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744757916;
	bh=PQncLWSp8vRGUs7I1MsLblxC/UpK+WOGWqJsvx3Sq8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hH5pwmgSxfq+VoEhSL5scVumpahKB/YEGsZoOCs8XkbGyk9d9UD7PCrluz8BVphAd
	 DqX7lLZRDwRObVjVX9YkuOD6kXlt1g7GtNEbw6BC+WSzPXREvYHB8PU8x+1YoytRjt
	 2NVERi74WurTWwdX5RcnlUUb1TeyD3kDMj+P5WVfCakbhRujk+2YSpvwVwT0FcNYvL
	 kSrdkvMYiRZZwuzm9Ak+nmC3hTiTFI24M2V3qdso0Te+dQzL64mYqvQXU4MYWcieYS
	 9AyYJFjACfDuW9zS6zQaxY9WGzhzY35vdqJ4NmL5EK/GcSnkoY51H2eX1h+5GMdpQX
	 bNM7ROTxP7RgQ==
Date: Wed, 16 Apr 2025 07:58:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Shuah
 Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Differentiate bash and dash in
 dynevent_limitations.tc
Message-Id: <20250416075832.cd27bcb52b7e31d0f5717273@kernel.org>
In-Reply-To: <20250414210900.4de5e8b9@gandalf.local.home>
References: <20250414210900.4de5e8b9@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Apr 2025 21:09:00 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> bash and dash evaluate variables differently.
> dash will evaluate '\\' every time it is read whereas bash does not.
> 
>   TEST_STRING="$TEST_STRING \\$i"
>   echo $TEST_STRING
> 
> With i=123
> On bash, that will print "\123"
> but on dash, that will print the escape sequence of \123 as the \ will be
> interpreted again in the echo.
> 
> The dynevent_limitations.tc test created a very large list of arguments to
> test the maximum number of arguments to pass to the dynamic events file.
> It had a loop of:
> 
>    TEST_STRING=$1
>    # Acceptable
>    for i in `seq 1 $MAX_ARGS`; do
>      TEST_STRING="$TEST_STRING \\$i"
>    done
>    echo "$TEST_STRING" >> dynamic_events
> 
> This worked fine on bash, but when run on dash it failed.
> 
> This was due to dash interpreting the "\\$i" twice. Once when it was
> assigned to TEST_STRING and a second time with the echo $TEST_STRING.
> 
> bash does not process the backslash more than the first time.
> 
> To solve this, assign a double backslash to a variable "bs" and then echo
> it to "ts". If "ts" changes, it is dash, if not, it is bash. Then update
> "bs" accordingly, and use that to assign TEST_STRING.
> 
> Now this could possibly just check if "$BASH" is defined or not, but this
> is testing if the issue exists and not just which shell is being used.
> 

Thanks for fixing this issue!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> Fixes: 581a7b26ab364 ("selftests/ftrace: Add dynamic events argument limitation test case")
> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://lore.kernel.org/all/ccc40f2b-4b9e-4abd-8daf-d22fce2a86f0@sirena.org.uk/
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  .../test.d/dynevent/dynevent_limitations.tc   | 23 ++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc b/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc
> index 6b94b678741a..885631c02623 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/dynevent_limitations.tc
> @@ -7,11 +7,32 @@
>  MAX_ARGS=128
>  EXCEED_ARGS=$((MAX_ARGS + 1))
>  
> +# bash and dash evaluate variables differently.
> +# dash will evaluate '\\' every time it is read whereas bash does not.
> +#
> +#   TEST_STRING="$TEST_STRING \\$i"
> +#   echo $TEST_STRING
> +#
> +# With i=123
> +# On bash, that will print "\123"
> +# but on dash, that will print the escape sequence of \123 as the \ will
> +# be interpreted again in the echo.
> +#
> +# Set a variable "bs" to save a double backslash, then echo that
> +# to "ts" to see if $ts changed or not. If it changed, it's dash,
> +# if not, it's bash, and then bs can equal a single backslash.
> +bs='\\'
> +ts=`echo $bs`
> +if [ "$ts" = '\\' ]; then
> +  # this is bash
> +  bs='\'
> +fi
> +
>  check_max_args() { # event_header
>    TEST_STRING=$1
>    # Acceptable
>    for i in `seq 1 $MAX_ARGS`; do
> -    TEST_STRING="$TEST_STRING \\$i"
> +    TEST_STRING="$TEST_STRING $bs$i"
>    done
>    echo "$TEST_STRING" >> dynamic_events
>    echo > dynamic_events
> -- 
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

