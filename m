Return-Path: <linux-kselftest+bounces-7343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 551B889ACF8
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 23:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA077B211BC
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 21:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF5E4DA0D;
	Sat,  6 Apr 2024 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bkzzQIg0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C9818C1F;
	Sat,  6 Apr 2024 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712437408; cv=none; b=XkUAxECSUrkkWIXGFPp0g0vs7unsND+1zlRlbZNLWhOxYTEj2hDXv1pcKQCXXvOvErlX7hUOupNNU4/BNyNE86wwqPMi3mzO7iXBqgIBJ1vcg1UDG4DkgPSt8CqdSBRbP1poI+SlPLttGpEvm8Zp/7JaHxJcn3ptEhB+tW7KOqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712437408; c=relaxed/simple;
	bh=A8BJK3Oe1zSGgXiPyuCYKnKgW30Ve5xxBJ6RBGK1zDE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MWL+yn2ejMdKWCvpxAJdGJzGMyOJdySsu1mwRjvTDjYEOfhTVtIQGbbfa1VNMSi0vOpdhzrgfy60ulNseTMrEOlx/tTlsDFEcUHM0m9cFZlEiMh55Ec0/6Uz+POBHTfZJDRV+NLEzWReCxr4Xq9rhYPK+ZwB3exUcMU+fZX3X3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bkzzQIg0; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712437405;
	bh=A8BJK3Oe1zSGgXiPyuCYKnKgW30Ve5xxBJ6RBGK1zDE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=bkzzQIg0smSimHntMjIJ6vUaiVP5KCXOXyBu8vD8Scp53TA3KywyPzOy5ZgHz/LxA
	 /DyUMLstesbmcWXcg7+3012UHz4DGCC7xDfOimoPYRdmszKppDmaYsk4zdS9ABivYX
	 /Q3MzZAegXQgC21VMP9ljbDU3Gd/Ascms+aCyNUlumz4rj3zMa2A9GwxHWfsqtvo1/
	 ifWAxglR1YkbwaITYydPddE+seG3OQaf1sdp2VREZxvE5g3S35oH4BvYvSsBbtsD7U
	 aFrOWSIZvMcvX8UiF3pyr+yQhLPNgoGVb4QNQMEK4Hfmvd2aKdQnN+ipuY0/f8DfMz
	 tmtgES1WNcBoQ==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 756843780894;
	Sat,  6 Apr 2024 21:03:20 +0000 (UTC)
Message-ID: <0beb942b-e16b-4006-ab24-bb11eeb8ee3e@collabora.com>
Date: Sun, 7 Apr 2024 02:03:52 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Mark Rutland <mark.rutland@arm.com>, Aishwarya TCV <aishwarya.tcv@arm.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing/selftests: Support log output when generating
 KTAP output
To: Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>
References: <20240325-kselftest-ftrace-ktap-verbose-v1-0-3785199809da@kernel.org>
 <20240325-kselftest-ftrace-ktap-verbose-v1-1-3785199809da@kernel.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240325-kselftest-ftrace-ktap-verbose-v1-1-3785199809da@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/24 9:15 PM, Mark Brown wrote:
> When -v is specified ftracetest will dump logs of test execution to the
> console which if -K is also specified for KTAP output will result in
> output that is not properly KTAP formatted. All that's required for KTAP
> formatting is that anything we log have a '#' at the start of the line so
> we can improve things by washing the output through a simple read loop.
> This will help automated parsers when verbose mode is enabled.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/ftrace/ftracetest | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> index 25d4e0fca385..cce72f8b03dc 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -255,7 +255,13 @@ prlog() { # messages
>    [ "$LOG_FILE" ] && printf "$*$newline" | strip_esc >> $LOG_FILE
>  }
>  catlog() { #file
> -  cat $1
> +  if [ "${KTAP}" = "1" ]; then
> +    cat $1 | while read line ; do
> +      echo "# $line"
> +    done
> +  else
> +    cat $1
> +  fi
>    [ "$LOG_FILE" ] && cat $1 | strip_esc >> $LOG_FILE
>  }
>  prlog "=== Ftrace unit tests ==="
> 

-- 
BR,
Muhammad Usama Anjum

