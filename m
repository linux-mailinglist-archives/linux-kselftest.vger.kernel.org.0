Return-Path: <linux-kselftest+bounces-6042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 660C6874AB5
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 10:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C4F1F25F78
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 09:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1874583A18;
	Thu,  7 Mar 2024 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="g5fCY2Rk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D8B839E2;
	Thu,  7 Mar 2024 09:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803324; cv=none; b=qvFKs3/VWlY/P+JSgPBdzMr06/FeFAGpGBAfo0576o6NqjbuRwovn7RTYnn4nKLGOsbuUoOTwuwgBv6IwGlVmZNSGffOczucjQMzWe7kpSdzEYcZf9U/7BgKgPvbks+wXWt2OhizHwYF02ngkmphz0VXgCz6lX0cfmitpg3rkpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803324; c=relaxed/simple;
	bh=6iqoDRc9RjwEw4cRyfIUcA4bB68ye1om5KId/6dzsa8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S3Dslg2CRQFqTxwJ1osoMkySE8WvGyq5+B6JR/SJfxYoFfhZc6UScQ7h8KxKybBdl0bW3OV2x93GO/o/Y/gAvo9jciAngDOo0dwC6maKek27w1OvAzXPR0KFsnnPfhrPLM/9+mm0cNkh26zlFliiDccxHlcYwJgD0jteveZd7Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=g5fCY2Rk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709803320;
	bh=6iqoDRc9RjwEw4cRyfIUcA4bB68ye1om5KId/6dzsa8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=g5fCY2Rkol6ztpSrz/yatNxAFRhYOzdVjBa7zly9pDCklbhxF04LXgpu2LJdaJtMY
	 n4zZzYJ3LBGhQse1dCkcl0YwDMfe3c+tesu/pnBV+bJ7/VMIDlD/qw+Mq+iOldFtIb
	 d1UCQwY9G9rkBwrw/TXk+YUXqag/WBPvfh9ExjNDUgobn+uBFXMdpNsBaIF+gTa+bf
	 IbWIlJU0AuWocasWpLcOMIuLlj7Qo07ev7CTeyN5tu1Bdl06c1XheWBoDI9skT8r70
	 Z0WX6B/AQoIY33ayCS8XxxJp4klj4GOiHoNCcoRLKPQXEdzo2NJwAHEcV3wAnWIXTy
	 TvgINlSx5m5Cw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 85F8D3780624;
	Thu,  7 Mar 2024 09:21:58 +0000 (UTC)
Message-ID: <fd210d04-cc98-4e29-a051-bdb7e1367494@collabora.com>
Date: Thu, 7 Mar 2024 14:22:27 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Eric Biederman <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>,
 Mark Brown <broonie@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [Test Failure Report] exec: Test failures in execveat
To: Kees Cook <keescook@chromium.org>
References: <02c8bf8e-1934-44ab-a886-e065b37366a7@collabora.com>
 <202403051256.7A50FE28E7@keescook>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <202403051256.7A50FE28E7@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/24 2:00 AM, Kees Cook wrote:
> On Tue, Mar 05, 2024 at 07:20:27PM +0500, Muhammad Usama Anjum wrote:
>> Hello,
>>
>> I've been running execveat (execveat.c) locally on v6.1 and next-20240228.
>> It has flaky test case. There are some test cases which fail consistently.
>> The comment (not very clear) on top of failing cases is as following:
>>
>> /*
>>  * Execute as a long pathname relative to "/".  If this is a script,
>>  * the interpreter will launch but fail to open the script because its
>>  * name ("/dev/fd/5/xxx....") is bigger than PATH_MAX.
>>  *
>>  * The failure code is usually 127 (POSIX: "If a command is not found,
>>  * the exit status shall be 127."), but some systems give 126 (POSIX:
>>  * "If the command name is found, but it is not an executable utility,
>>  * the exit status shall be 126."), so allow either.
>>  */
>> The file name is just less than PATH_MAX (4096) and we are expecting the
>> execveat() to fail with particular 99 or 127/128 error code. But kernel is
>> returning 1 error code. Snippet from full output:
>>
>> # child 3493092 exited with 1 not 99 nor 99
>> # child 3493094 exited with 1 not 127 nor 126
>>
>> I'm not sure if test is wrong or the kernel has changed the return error codes.
> 
> The error code is actually coming from the script interpreter (in this
> case, "/bin/sh"). On my system, /bin/sh is /bin/dash, and I see the
> failure. If I manually change "script" to use "#!/bin/bash", the test
> passes for me.
> 
> Since lots of other selftests appears to depend on /bin/bash, I think
> the right fix is simply:
> 
> 
> diff --git a/tools/testing/selftests/exec/execveat.c b/tools/testing/selftests/exec/execveat.c
> index bf79d664c8e6..0546ca24f2b2 100644
> --- a/tools/testing/selftests/exec/execveat.c
> +++ b/tools/testing/selftests/exec/execveat.c
> @@ -393,7 +393,7 @@ static int run_tests(void)
>  static void prerequisites(void)
>  {
>  	int fd;
> -	const char *script = "#!/bin/sh\nexit $*\n";
> +	const char *script = "#!/bin/bash\nexit $*\n";
>  
>  	/* Create ephemeral copies of files */
>  	exe_cp("execveat", "execveat.ephemeral");
> 
> 
> Can you test this and let me know if this fixes it for you?
I've tested this patch. Still getting same failures.

> 
> Thanks for the report!
> 
> -Kees
> 

-- 
BR,
Muhammad Usama Anjum

