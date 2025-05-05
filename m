Return-Path: <linux-kselftest+bounces-32422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359D2AA9B46
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 20:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA163A5E52
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 18:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB1426F44E;
	Mon,  5 May 2025 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Q0pgeGa0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7E02561A6
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746468777; cv=none; b=YLywImP2xkNNIxRa78AGPcJqMWwbPW2+tfyzwUfzRQBJaGRFnuDv7VXTDs4CsGBSOZ4nba++2a4zt0WxZHF6qCeU3LQqYHwtK4zjF8BZH9shEGrCzX4n1uJPwQ+G0kw93p+6kkxDqSDIBHPllSr+a4wKZHzOdGMmBd389+zMvq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746468777; c=relaxed/simple;
	bh=r6zL691xyXDc/NYPMzcgtrOHkUdYXfPK6zMjb7J4m50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHWAv825ZRg05YdlFIkzMwH4042VUMIeNjFItY4CVttkgcvBMELMVytxfgcX9U8HCDQGk0r1fOCfsAwKKZxl6jlI51xaCRtaWP5DX5l56vomaAExCcFL3XAk+bk/G/8jYfYdj4YI9LPloN+02vpGiudSFzZWtqqZB7aT345BWME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Q0pgeGa0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22e331215dbso1107255ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 May 2025 11:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1746468774; x=1747073574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kn/zibkomLWdf7PKFOzDAAA5I89jlaYGeX44MmTKrlM=;
        b=Q0pgeGa0T5kG2YxFOEwmRQyN+ikX5zbkAf1Pw7dFZs4ad2sG5TXbekhrrOl1Mr/bMm
         vkAd3B3SuFl08jJfcmRUwfObgGLDMSS6H8KekWNievh98rg98CBmtxRVTTe/CHaiMeOc
         cvxp/556Qvc/kpMMBxMYD9cgqQw6TT6nkYJHLpiLKycWUYh3Ol+w2ODq3kjqVHiOP0AT
         Kop+T4i0nImzsrgJ2xX241Red7YdXN3CyXTJ9IwuqBuEaA9FbLohCkkpf7evYUpiw2z3
         BuytWeZEYDmJCkSYHPt3Ta/OKdsXEkV7AQN42PrhVC8s7sc/+TNBlqlX5v6d+1zrIPv8
         eaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746468774; x=1747073574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kn/zibkomLWdf7PKFOzDAAA5I89jlaYGeX44MmTKrlM=;
        b=Gtz8oMWDIKpl68AFU6d8sVUDOQ3suL75PCHEgHk3cXUidHuNwTRwvEKHmmHpJ72MXb
         gjbb7VCy0za5+xOfARJkQMBAyNSMvMDi8erbdUXwSYqr0giq7hxzC1zi7pNtfIMsM2B7
         9et6eaV8bdUSihe+Mzt2lp46FbW1V5RgLWhF8Q8ZS2etqtqoYVBFvGPtrY/uVJ67Mk1n
         wXqifxMR4t+p220yIGul7QsWmVNwCLVAzD5Tu9oapal+KIgxgERmEfU7/WPUN6KVTAc5
         WIdtdADHqWPBbXTQ2X7h5J2mSbx+oBcfBfzTHYx/znAKRvId8B95XXmB4/etpJG7IGD0
         q0UA==
X-Forwarded-Encrypted: i=1; AJvYcCXowTBOaPgUWy1gDR6L4Y1A4ObZY/aHB6h3//UHZ0lhSBfQeKt4yGXgkRsrYy3s+mcumXYNjltNv+J24QaykQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdfN8Hzi0HI5mWK6iJmg6i6WMuZG5QY6mSCaOLrMf7sev5HZAP
	EUq3gbTBhCdyNxNUPfiHjiuaKGkaDi84IKZZHFNxrY08aVCDEJC0LEhALvRsiEQ=
X-Gm-Gg: ASbGnctIbLaoa2aaRXgpitLAooUOUe6N3JAYTt+NPopoLgT/aid2k0/9wJK5kjzhXj9
	yxNcOTHL1/uxfIB74jBtqr+Jf/a7hcr3pckeM4Pz6th0mXyJ0+zuJJSv3D4KY5VDSNQ12FUs1kq
	/JuKHWK+14Bd2rome09J2K5Asxmy7U15ykFHccqcR9kQ0V005bsxwVeVGG2CcQHsaEIsu53iTUj
	wc9HwB1jiDSi8uCzAc8dt1asRevMdiPCidnREIsr2mTJeS8lBYBrjOdhT5nsy+PRPJVHVQe2tEJ
	6RJMmFrUVJxcnCH4kq2BnIZTI81BczMdSZK5u401vLlo+zSmDv867lHZvCrR6hg6DUvlkk95tTc
	YXe0BWJRF
X-Google-Smtp-Source: AGHT+IFcDMpZFbSC2cA6HXuHWJG/1gn3lj+yUO7wc1CEnrvnUO+JYcSjzB8buk5n0CphdfJMlqY/jQ==
X-Received: by 2002:a17:903:19cf:b0:215:6c5f:d142 with SMTP id d9443c01a7336-22e327e57b2mr5750795ad.20.1746468774651;
        Mon, 05 May 2025 11:12:54 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1079:4a23:3f58:8abc? ([2620:10d:c090:500::4:906f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1522054esm58324445ad.118.2025.05.05.11.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 11:12:54 -0700 (PDT)
Message-ID: <39a3d71e-2463-494d-9530-80fcaad0b208@davidwei.uk>
Date: Mon, 5 May 2025 11:12:52 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] selftests: drv: net: avoid skipping tests
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, ap420073@gmail.com,
 linux-kselftest@vger.kernel.org
References: <20250503013518.1722913-1-mohsin.bashr@gmail.com>
 <20250503013518.1722913-3-mohsin.bashr@gmail.com>
 <0db1b7f0-028c-44e9-bf98-81468dee32f0@davidwei.uk>
 <20250505104701.10d3eb14@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250505104701.10d3eb14@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/5/25 10:47, Jakub Kicinski wrote:
> On Fri, 2 May 2025 21:54:11 -0700 David Wei wrote:
>>>    def _test_v4(cfg) -> None:
>>> -    cfg.require_ipver("4")
>>> +    if not cfg.addr_v["4"]:
>>> +        return
>>
>> What if cfg.remote_addr_v['4'] doesn't exist?
> 
> Not sure if its super pythonic but it's set to None in the lib
> if user doesn't provide the config.

Ah okay. I'm concerned about the next line:

>         cmd("ping -c 1 -W0.5 " + cfg.remote_addr_v["4"]) 

If cfg.remote_addr_v["4"] is None by default then Python will complain:

   >>> a = "foo test bar" + None
   Traceback (most recent call last):
     File "<stdin>", line 1, in <module>
   TypeError: can only concatenate str (not "NoneType") to str

