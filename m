Return-Path: <linux-kselftest+bounces-20894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 795F39B411B
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 04:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2525D1F2278E
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 03:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B53E1FCF49;
	Tue, 29 Oct 2024 03:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cVAmbBPP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8BF376
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 03:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730173173; cv=none; b=uYaG5LGvtQVBCuFblUG4CYR3hvYyR1ldLhHZSifIPOFQaqwlH4Ju/FEgpg/RL39y91VItolaTkT9JQv9mPyM+LUBhRNs9w1DyTh52ZKWWoOYHwTFK7MZY7Lc5KpORwfBKA4R4t5i777fyRJt9ElQGc+wC4UUmTCxXvuouF4DS9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730173173; c=relaxed/simple;
	bh=7MTEDU/9KSAVKWqOtGz0SMhvzWL4F3+EUhfaTE/fXb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1uZr/yuXFWVlz90wr49PPem0RySVjGf/285VwzxuUZFbsvo8ox7JOaAya7BZMIWvjAHrmSL+4Gzu25thM2tBAYTxs/bNStNlaQ2wesP9G48bQuz16ryQqmxrHmRrCEM368jGtiPs7fDpqae1d/D0BOFFuxttDOi2k1JCjet0J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cVAmbBPP; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-71807ad76a8so2966560a34.0
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Oct 2024 20:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730173170; x=1730777970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9gWeiUgOpqvVG172Cf4CPPhJE+kydeiEANPZ1xGY/Xg=;
        b=cVAmbBPPCBjvSAkHo4i8xRRhrN2b1z2Ien+ra2YKGTPc8RCGlMyG15aFEVydjX0Wf3
         Yy+7HC1WOJPK4uq4mJCIDZqVj7MAOHSjBwnKm91+0SFIAI0yCZV3fsqIfIMr6kPTInv4
         o7Aze8AqgFu7LmhwlWPZlYZTPQzYGlugWQvQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730173170; x=1730777970;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9gWeiUgOpqvVG172Cf4CPPhJE+kydeiEANPZ1xGY/Xg=;
        b=d32e1z7hEqLkA0H1dHUlosseeJdXSn3It6Y7Q0GEQBEwgKBmgepfayb/8iKFSx5LPF
         jmkJ970RCr7RDrBrBoPVCJbbhvElIbUmzXFTECBdlDpKv4+ZEEY69umr4Xt5htVJrFUv
         7S6idpHeru5l379wbMzjP3yzjkM0V2X29lknwsIyCNdttdohtKNAIjwf9ViRab3vXROW
         b5NxRn/Lq3lGL6Lg7VAwU7dSbEo7N+KeDxf0w4wiYM1rrj1xfO2yRJYB8TmGFtDmLP4t
         SjbMKxuUUUxtaT6nmYU27EA965Nd/6feOSlMgL/XqPpGa7PzGC2NXR7C8I73xqntUAOB
         lzcA==
X-Forwarded-Encrypted: i=1; AJvYcCXAMXYFiWcG2BVxYhgs16quxcWhROUVhR71v1xAE/0K7AZEDcp7GFwsgu2/yX3rVcR8o24B+BQyWTFyTR2x5yA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcflklariA1UfOHGVXDhUNZbZS8aJ1DLkxJBJ/VesBZzDx4m1o
	Cf2YankFyuzPh2fGK+QW8k57kn+C3CcQ+rzl9e5enp5ORfdLYuhmmPzzPsrH+kE=
X-Google-Smtp-Source: AGHT+IFVFjxSPDCFIqOm9TkyhztXbygtp6FgdfjFTfr/YQK7P48YubWfGMFc6tYAcGYM8Y/shO+ngQ==
X-Received: by 2002:a05:6830:700a:b0:717:d012:a513 with SMTP id 46e09a7af769-7186822c96fmr9756363a34.19.1730173169752;
        Mon, 28 Oct 2024 20:39:29 -0700 (PDT)
Received: from [10.200.3.216] (p99249-ipoefx.ipoe.ocn.ne.jp. [153.246.134.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0cf9fsm6537368b3a.124.2024.10.28.20.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 20:39:29 -0700 (PDT)
Message-ID: <f9d8f7a6-22a4-4d03-ab1e-e488dfdbbd51@linuxfoundation.org>
Date: Mon, 28 Oct 2024 21:39:26 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/watchdog-test: Fix system accidentally reset
 after watchdog-test
To: Li Zhijian <lizhijian@fujitsu.com>, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241029031324.482800-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241029031324.482800-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/24 21:13, Li Zhijian wrote:
> When running watchdog-test with 'make run_tests', the watchdog-test will
> be terminated by a timeout signal(SIGTERM) due to the test timemout.
> 
> And then, a system reboot would happen due to watchdog not stop. see
> the dmesg as below:
> ```
> [ 1367.185172] watchdog: watchdog0: watchdog did not stop!
> ```
> 
> Fix it by registering more signals(including SIGTERM) in watchdog-test,
> where its signal handler will stop the watchdog.
> 
> After that
>   # timeout 1 ./watchdog-test
>   Watchdog Ticking Away!
>   .
>   Stopping watchdog ticks...
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   tools/testing/selftests/watchdog/watchdog-test.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
> index bc71cbca0dde..a1f506ba5578 100644
> --- a/tools/testing/selftests/watchdog/watchdog-test.c
> +++ b/tools/testing/selftests/watchdog/watchdog-test.c
> @@ -334,7 +334,13 @@ int main(int argc, char *argv[])
>   
>   	printf("Watchdog Ticking Away!\n");
>   
> +	/*
> +	 * Register the signals
> +	 */
>   	signal(SIGINT, term);
> +	signal(SIGTERM, term);
> +	signal(SIGKILL, term);
> +	signal(SIGQUIT, term);
>   
>   	while (1) {
>   		keep_alive();


Thank you applied to kselftest fixes for next rc.

thanks,
-- Shuah

