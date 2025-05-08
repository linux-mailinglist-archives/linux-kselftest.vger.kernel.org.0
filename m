Return-Path: <linux-kselftest+bounces-32684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31869AB05A8
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 23:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F571BA2343
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 21:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB802248B5;
	Thu,  8 May 2025 21:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="hMDnF7Bx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C8124B28
	for <linux-kselftest@vger.kernel.org>; Thu,  8 May 2025 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746741556; cv=none; b=qy/wPHnYivmlX/6trtUN4UxFgPfLNPJC2fOnKgSLFEqEl8m88YbTu6vKkabBLzTlaUPonBfmISLt+ZBMTmFmZU/Ft0uCeYvbj9w9fagg0ZTtq5u+RYiaGyRWhv2B5PaM8eamOuGRhn/UFmSYRDJO26w8r1Uw4kie+1Yf6im2y8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746741556; c=relaxed/simple;
	bh=RcMpxjM0SBsWiUvaLtv7ypt2hc1LOWKx7i2yRwa9bbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSsxmKd2OGdKc8soGeSTlxGqQEogk6kODDNJUj6BKKfcpQhd+Z9mK2r51SwjZ0dzDl5mx1+fGnWEt067HwPMCAGiVlwTIF6ovNvQve5J95Dbo83Yhw8Xh3nRgtmHdKcgz5Z4DWwKRRiAia9uH0+F7vMAk8d9uAztLh1SYPEaoyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=hMDnF7Bx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22e730c05ddso15276945ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 08 May 2025 14:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1746741555; x=1747346355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mEDc2EtJgKPJGqy02JAFGdLWN2lNiFsVQXcu8wIsSmw=;
        b=hMDnF7BxMJ2T6w68R9N+CTQrRmepW4Z0cnOdDJhQhW5aRt2a/pNgvTv/0yRfUBgvSl
         Chgy1OODk+vhK1LD0GLnrSfHMst6ZaLwwiCsqUvOq2B9ODUVdgyIB7ajPgIM5B31yJyT
         Ak6b5G9AZwS8UMQT8mb5jMv7IMweNO7V0O9P1Z2o1VCNcjKghKNVOuY78y+p08GduEJY
         V0GW0MR/d9lMr+Q9VHyE17iYCuOKOEmkqW8lLb7tvmmQBGZLyarkrCufsNMl0h9JWIxz
         GyJGqke8TLPef5g0hOfQpPNNnucr324ftKS2kQ18DuFmsggGZCdABHPkYvUaAGCzD9W2
         3Ewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746741555; x=1747346355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mEDc2EtJgKPJGqy02JAFGdLWN2lNiFsVQXcu8wIsSmw=;
        b=OHAAI5whnkAeiRffwr8WKrG3r6/zKdaDZYHMrA9b8rR60lo0Nn5MxRyQswAyWMZ4vp
         lFEPBtl10eQvvUERmPaehx5obOPqb+k9rYWX3bPOqFY6c3ziRHPnWHrzf9kvcknNhwd/
         bTKyp0BWshtjbgEAeYjxJ2vY05+S0uj4mq9gSJW2/V8Pfp7GUTXyZvSKL/DOXubQ5oyo
         Y0yF9dShd+9OQ1tdMqzJAYfRaKivTTtLapbCJxLqo0cASf6kVQZUt0BWIFu5tg7rxalK
         CCJwF/31gf+9f6kE0BBRB55CyvWsO4+dqOx0GLDsKuNyi/zzIwOUPT7/eU7BPNUUSwYd
         XeDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/sDLfjv2f71M0L3IIoq9DojHWANW8l/+izegbdljLcjv5SfoIafb75Y4FB9kw+51+vxpkt12qBClNYAaOH20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+M3pDZz7WyCBFMKjprlJZnmhJ4G53V4YBId2azU1TDk8g4fXX
	zTJOuMyiLqKMaYL7BJyhOWAKYdjFIqbFiMwdfp3vs6Vs98kUM5+t1XBM991GJzk=
X-Gm-Gg: ASbGnct4ywZM/Vg35bT6JD318ncvxKQvLw4bTmASDjM2YooZE1owo7NA+xVmViuEstl
	q0AH/bbfDAhCG6kp1iMqONetkoTMh6nlrZol3hcdtbRPrxp2fsk9H6IwgKvTX6oFJpwK2tKnUQV
	nbovxplXHDxiLpEYHpT06jvIflWS5mHqOs1j1Bik/Mbgix47qyPmhDhf0Dasv76iZoTmqxn8Y1T
	Jr+RxHQFvpwwredDi8wVFzt8LQT0bPKI2zgI3bAfM9rL8yW4H/LmwtHdN/IStgt4y7glow3xcJB
	6mSC9Ur0aduk2tZqb0xER9vnWya2o5I9aV96HvWTtY3ZRBup2IsM3IjG40N//eK6SOMCiY9RbTQ
	gZlo=
X-Google-Smtp-Source: AGHT+IEQc8Chr3MQouZYg+naSTE2nFIyRZdRZh97Oepc5jfMUidKqI1wUYOzkkoyAHeAUOkCkEvLrA==
X-Received: by 2002:a17:902:e84d:b0:22e:8183:1fae with SMTP id d9443c01a7336-22fc8e94b54mr14491915ad.41.1746741554770;
        Thu, 08 May 2025 14:59:14 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1079:4a23:3f58:8abc? ([2620:10d:c090:500::5:2fc5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc828a3a5sm4337645ad.161.2025.05.08.14.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 14:59:14 -0700 (PDT)
Message-ID: <e339c382-c0f5-40dd-994e-34b388c68181@davidwei.uk>
Date: Thu, 8 May 2025 14:59:12 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: drv-net: ping: make sure the ping
 test restores checksum offload
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250508214005.1518013-1-kuba@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250508214005.1518013-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/25 14:40, Jakub Kicinski wrote:
> The ping test flips checksum offload on and off.
> Make sure the original value is restored if test fails.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>   tools/testing/selftests/drivers/net/ping.py | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
> index af8df2313a3b..e0f114612c1a 100755
> --- a/tools/testing/selftests/drivers/net/ping.py
> +++ b/tools/testing/selftests/drivers/net/ping.py
> @@ -50,6 +50,16 @@ no_sleep=False
>           cmd(f"echo {test_string} | socat -t 2 -u STDIN TCP:{cfg.remote_baddr}:{port}", shell=True)
>       ksft_eq(nc.stdout.strip(), test_string)
>   
> +def _schedule_checksum_reset(cfg, netnl) -> None:
> +    features = ethtool(f"-k {cfg.ifname}", json=True)
> +    setting = ""
> +    for side in ["tx", "rx"]:
> +        f = features[0][side + "-checksumming"]
> +        if not f["fixed"]:

I checked and found that "fixed" is a ternary:

         "rx-checksumming": {
             "active": true,
             "fixed": false,
             "requested": true
         },
         "tx-checksumming": {
             "active": true,
             "fixed": null,
             "requested": null
         },

Python loads this JSON as False and None types respectively, and `not
f["fixed"]` is true for both False and None. Maybe this doesn't matter
but flagging it.

> +            setting += " " + side
> +            setting += " " + ("on" if f["requested"] or f["active"] else "off")
> +    defer(ethtool, f" -K {cfg.ifname} " + setting)

This does rx/tx-gro too even if not explicitly requested. I assume that
is okay?

