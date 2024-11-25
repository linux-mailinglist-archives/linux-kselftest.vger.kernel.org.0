Return-Path: <linux-kselftest+bounces-22509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161E39D89E4
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 17:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E783B64BF2
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 14:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4D61B392B;
	Mon, 25 Nov 2024 14:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1hqq0yr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91142746C;
	Mon, 25 Nov 2024 14:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732545728; cv=none; b=pPGPJ7oCNYSmD0gMdXcq637SetPj2x8Fp2REg39hRLL5dx37EzZXdcmdgaxgy3vCLEqHF9BkBg7MiIjb8GCXh8p13K5sJvVhXSuK6GaoEVkhbMeI2k5Y1SbrjvRMvZkbZk1N7iyxKotv+JdrAUYLUZaToZnw4aKkja6VMa+wPB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732545728; c=relaxed/simple;
	bh=oJk7x9HfjhAfqB0sW8vL7sBsXD4HhmzDvdF/ryf/YQw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sdr9O+hgWXsO4xL7Dx6TgUIonXGBGheGwFkV4UFNB3p+FxvE0nbUxMxCmhOTSGacEhkU2KVMMq/gK3C4ZayuZPtlNgvzeYLQm2vc5pL+n7XrJwazMVCuajGA/LLHn1Q68zzMbbDYpCp/P8CFYZlsDw5+W+84r+k0oWcMOau94Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1hqq0yr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so41298165e9.1;
        Mon, 25 Nov 2024 06:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732545725; x=1733150525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBSTyw+3pECnN6rp5cUNGh7LycqS04fO9owfiayYG4U=;
        b=B1hqq0yrfMAHKwMiIix22NPzjQxAZ7OVOhHRPZ2Wz+TWmtTni/BEGKTxRqrBOKZNeE
         Whfly8Y2Vk0JyNLVaX5axEl/gbejEm378aHFNmltk1+xChMsrVp32VEp1FpHiZ+PMs/H
         fiCneAysg9Wf1Le3pHcRbfo45qZG4nMFzqFI+6gx/YKadKYLii86pu52QEl0wF0XnoHZ
         Ry6IzW3mda27S8+7mv2YWkWrQOSShkNFRz0v4lfQhtKopat9bzGeUPjpUxaN7eKDYOKe
         4juNOeJ7b6y+FlZSQNsnzaTQbbRgcXbzoqq9pMt3kpFlEOABWtbE00IaWPny8xZYTbcw
         txKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732545725; x=1733150525;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UBSTyw+3pECnN6rp5cUNGh7LycqS04fO9owfiayYG4U=;
        b=buYX8Pa2566BeHwtZ41SICMSJav/mFedeUOR5liAtsqWAkR67j6XefoMeOVmRQS3pR
         meq0IOCEnL8EyZ+YFuZkDhk/AVky96YN7nYn9ySZHEwMbLJTcl08X1GVdYIIgNlCrZ3e
         Puc+a7Hel/BMTFuJtAnZ+2NVLCAL4QPhZ5xTTTTTdFCXgaOUp5b1TvgqI+K4w3eWg0y+
         5J8v5wwBA7bHeKsSLU/r0FAgjSeI42gI7UmND5DhpBI91XcBB//a5D6EccC44YCbqwBk
         EAQR8GMoeCFuQr07rYfAckw9TEaKsRpbfG29ayb/IIxdkN2efyVvQX0bzu8r8+zD0shJ
         8d7w==
X-Forwarded-Encrypted: i=1; AJvYcCX5oP9y6fwnuEott+2azkfDbKZHTERAsEUYmXP3QPE9M2QGJ6C8A/fSr/bP/KZlzxWqamZiOUOJG+PAfajQDCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBoS03KdxhISGGBUq6NMH29FnSx25dGCru10NWyXNRwUC/cUQ6
	P3KtSE++WAhklJdIyx4ThwT+yj1s7IuO/5eOxdCqlt2j2MqyoRzjopBX0g==
X-Gm-Gg: ASbGncty8bazeA0rlVBWj8mILJMSA6PGBCabI/jHw6xzO56qf5mlHnpp9MGOa4YTScy
	pCSCG5f/+PAA5b+Ubqm0FMwQLniaJbWq5f+7SnTLn8bqUVWeHHNFH5UG8G7H+GtrYK1Ziipxef3
	KZ3wb1F54Ds3rofXxsTW4fVZuPyUHxzJzFEgHbtgQvwaTNbL/dwIB0fJfiJLDQBlUbUqExzZB/n
	lfox41xHkpKkURcjpqnXULlCQJUilyqO5UQZnPtYnJG0fuPZBZH4ko8LmM2OD4t8b9atCckFv5G
	C8vitbxoeWS2hxRwqDzXZZsYIzWJvRZX8Jpl2A==
X-Google-Smtp-Source: AGHT+IGH+Puy+RBFtMVwvoCG8TOeW3mzQi1dCyjoHbgCdorC7tTvJeqhydb6Sn5+vJAKow6grW7Gug==
X-Received: by 2002:a05:6000:1a8e:b0:382:4a35:aafa with SMTP id ffacd0b85a97d-38260b672a1mr9185917f8f.23.1732545724931;
        Mon, 25 Nov 2024 06:42:04 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbedfb2sm10542152f8f.105.2024.11.25.06.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 06:42:04 -0800 (PST)
Subject: Re: [PATCH net-next 1/5] net: ethtool: only allow set_rxnfc with rss
 + ring_cookie if driver opts in
To: Ahmed Zaki <ahmed.zaki@intel.com>, Gal Pressman <gal@nvidia.com>,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com
Cc: netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
 linux-net-drivers@amd.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1731499021.git.ecree.xilinx@gmail.com>
 <cc3da0844083b0e301a33092a6299e4042b65221.1731499022.git.ecree.xilinx@gmail.com>
 <871a9ecf-1e14-40dd-bbd7-e90c92f89d47@nvidia.com>
 <b0f84914-c4bf-9071-b72d-cc2cc4a517f9@gmail.com>
 <d986d2ad-3ac6-4357-a8dc-e83e3622efb2@nvidia.com>
 <6ab56991-1415-4009-a630-14a0b709583d@intel.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <1caf318c-db83-0335-4580-2ee21ff8940f@gmail.com>
Date: Mon, 25 Nov 2024 14:42:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6ab56991-1415-4009-a630-14a0b709583d@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

On 25/11/2024 14:20, Ahmed Zaki wrote:
> On 2024-11-25 7:10 a.m., Gal Pressman wrote:
>> On 25/11/2024 15:21, Edward Cree wrote:
>>> Also, the check below it, dealing with sym-xor, looks like it's only
>>>   relevant to ETHTOOL_SRXFH, since info.data is garbage for other commands.
>>>   Ahmed, is my understanding correct there?
>>>
>>
>> Speaking of the below check, the sanity check depends on the order of
>> operations, for example:
>> 1. Enable symmetric xor
>> 2. Request hash on src only
>> = Error as expected, however:
> 
> Correct. The check below is to make sure that no ntuple that does not cover symmetric fields is added if symm-xor is enabled.
But symm-xor is about hashing, and is only relevant to traffic being
 directed by RSS.  The user should still be allowed to, and the NIC
 should be able to handle, setting an ntuple filter (SRXCLSRLINS)
 that is asymmetric, to override the symmetric hashing for selected
 traffic.
symm-xor should only constrain RXFH settings.  And in fact even if
 you wanted to block asymm ntuple filters, the current code does not
 do that, since the info.data fields it looks at aren't populated for
 ntuple filters (whose filter fields are defined by info.fs).
So the xfrm check should be under `if (info.cmd == ETHTOOL_SRXFH)`.

