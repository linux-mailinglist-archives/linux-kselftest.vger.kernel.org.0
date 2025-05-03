Return-Path: <linux-kselftest+bounces-32274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3EAAA7E84
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 07:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEADA5A2ED0
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 05:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4EC18C011;
	Sat,  3 May 2025 05:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="jxuzrMw4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CA013B58A
	for <linux-kselftest@vger.kernel.org>; Sat,  3 May 2025 05:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746248566; cv=none; b=XZxV+GwVkBN9O3jxALjCk7lyFvCR7tXptk3/xiCLiAeMW9EozQnIMmmeK1HCVtqygHZRnU0Fk8QHwV9Bt1+TfaScUvUA7m8wRiis8fGk2MbhGzL3xF8b3nHiAI0ZgxYcx1lIdqxpIg2OzGr9qpNskvIjXJjYRIUEvm6/38fcKjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746248566; c=relaxed/simple;
	bh=/FeAjfKSsNKZDBIn7q27QhPpREatRn501qwA0FqjSew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iAVocpk1JJ4/uvhV+7DzIOuYj2D8X0TIWcE6gLqkEs2Mzq8sBEr6vDMkKdR+tBi7PX8Vnz9Fme9lxavEqJCsitNrYwIdK/ScRHaR1WcbM0sCL5VjzR6vLUWd+TtsE9rlyi//Sx3r6CmDqlco3HFQ1osq7t9tfwaWsv2ddOjFZAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=jxuzrMw4; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-739be717eddso2372427b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 02 May 2025 22:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1746248564; x=1746853364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nJmKIybgyno9tM7G9yPdUvju7uxJBADyl86GZguQyb4=;
        b=jxuzrMw4QKolT1FX+Z8+k3YvM5zwbltY+cxWOLANEjTUCQgyADeL4YZTJdJe/Sv3tJ
         GW1TyBcfctQo66NXPan5bO4BC+s2giS6ajHleiYokcv9lTTvSweLzuBpQvgJJ1RAqVwU
         yvmw3DJiiHhv8Wosk5qeHaiMnaVyCDvz0OOaqbe7Eb0u/Z7RtCwNjbysWfzRwxRtxhze
         8t3i9U90vwls0E0CguzG7/oly6EQj5YDe6P/EvW0TJVyDvEvUcR7onvQYmFIg/mZT+UJ
         jfVROpvxcqojRhOLaCX73JWU584RxSX+J+dnkr64d4HWWwMBA+ZuL6XI3yBDsUCao0WA
         pbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746248564; x=1746853364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nJmKIybgyno9tM7G9yPdUvju7uxJBADyl86GZguQyb4=;
        b=cDSRmWqGK3MejwX8tpR9HcV6CN6kSl09Rq/AyySgCGxvopkes0+NR/yV8YJoE4mr4D
         39ML0/df9UhrPNGuvVWp895vkZWFjQoqzyJ/Sv2NRCEATMWzYQHLgeBeRNbOwCRFtFoT
         iFhcIeJBhrc2XnbfEVTWAHioHvOemOml5qFBfn9gB74fxv0NAnTMn+9a46eFu+atlV07
         UCJkUsvjYAwxyue9dpk7Rza5GvHwYl1bXINa+l9rZjlaHnyRIOxtdlCtl1e8f/xtFgvm
         7M2NTgKx1W8nndWiXQbKDwwm2mlNRVCI1I7LhjPHXsVqd8M/ix8+8kezDaSJfQ1JWX5p
         x21g==
X-Forwarded-Encrypted: i=1; AJvYcCUB217Y3L7f/RkbAkiFHIgo8WvF71OS8JkoFUz6ME7OGKyCHVQk2kS/u9JKB80BZ2MdSBHIS1023i3e6FXRdls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWrWw570WfS3UvHLNG0tRZTxUGunkrMRTC9SEduyGX8tprzZjy
	1Vv4/kZ1i4KecZP3G9n/jztaNYlodcU0q6sufiZcH5Qfb1LUo1LQnRzu1KoHrW8=
X-Gm-Gg: ASbGnct7jZrLRZd9ZAcwl/QGRpETI7HAuJqMz5PkOY+5ZKm7rEBnPmADWpOa9IVh/FJ
	jZPY8ThHUyzrVHI/vdHoLSbEcsyK3S0MKWgdz+FlaJwHRf7BJrZzd2SesZZicRPxq7M/cE2BJBF
	Y/a2nE+cAFMyOIWHTkItrpAVceHRWMQBebVRprJJezmLFMkOcHj/b8PZ4NmUc6UcQci5L0pAMyj
	qHUNxuoJm3P378Tg9/7X6c2lh99Zwa/O3qMwDtSlLLTe8H0j8ksqymMl+QlkV7SQywc3fDpu2ri
	lwequGYN1tCxdgPL/AsLMnuE18LiKAqH8Db0xB+0922oFhk=
X-Google-Smtp-Source: AGHT+IFmCc2NF1Mv5FDfQS53ClaSppoeYSXJuDO1x/4ObzmvJyWdu4LBrqUPe8nt98XKFtCWUqJKKA==
X-Received: by 2002:a05:6a00:3305:b0:736:476b:fcd3 with SMTP id d2e1a72fcca58-7406742a606mr2733574b3a.24.1746248564172;
        Fri, 02 May 2025 22:02:44 -0700 (PDT)
Received: from [192.168.1.21] ([97.126.136.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059020955sm2614646b3a.101.2025.05.02.22.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 22:02:43 -0700 (PDT)
Message-ID: <a8c17a58-67fe-4cba-ad4a-a1822554c459@davidwei.uk>
Date: Fri, 2 May 2025 22:02:43 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] selftests: drv: net: add version indicator
To: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 ap420073@gmail.com, linux-kselftest@vger.kernel.org
References: <20250503013518.1722913-1-mohsin.bashr@gmail.com>
 <20250503013518.1722913-4-mohsin.bashr@gmail.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250503013518.1722913-4-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/25 18:35, Mohsin Bashir wrote:
> Currently, the test result does not differentiate between the cases when
> either one of the address families are configured or if both the address
> families are configured. Ideally, the result should report if a
> particular case was skipped.
> 
> ./drivers/net/ping.py
> TAP version 13
> 1..7
> ok 1 ping.test_default_v4 # SKIP Test requires IPv4 connectivity
> ok 2 ping.test_default_v6
> ok 3 ping.test_xdp_generic_sb
> ok 4 ping.test_xdp_generic_mb
> ok 5 ping.test_xdp_native_sb
> ok 6 ping.test_xdp_native_mb
> ok 7 ping.test_xdp_offload # SKIP device does not support offloaded XDP
> Totals: pass:5 fail:0 xfail:0 xpass:0 skip:2 error:0
> 
> Fixes: 75cc19c8ff89 ("selftests: drv-net: add xdp cases for ping.py")
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---
>   tools/testing/selftests/drivers/net/ping.py | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/ping.py b/tools/testing/selftests/drivers/net/ping.py
> index 16b7d3ab0fc8..af8df2313a3b 100755
> --- a/tools/testing/selftests/drivers/net/ping.py
> +++ b/tools/testing/selftests/drivers/net/ping.py
> @@ -136,13 +136,23 @@ def set_interface_init(cfg) -> None:
>       cmd(f"ip link set dev {cfg.ifname} xdpoffload off", shell=True)
>       cmd(f"ip link set dev {cfg.remote_ifname} mtu 1500", shell=True, host=cfg.remote)
>   
> -def test_default(cfg, netnl) -> None:
> +def test_default_v4(cfg, netnl) -> None:
> +    cfg.require_ipver("4")

With this patch, is the previous patch and this hunk still needed? I
think you can drop patch 2/3 or both.


