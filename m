Return-Path: <linux-kselftest+bounces-37216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEAAB032B2
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 21:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD443BB298
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 19:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065862882D9;
	Sun, 13 Jul 2025 19:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeUg0r2T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458E14A00;
	Sun, 13 Jul 2025 19:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752433780; cv=none; b=Ln7BLtJIV1a0Qs05lmTp7bje9b3oisbB7nbVF/QD2U1jQusBvyP4o7grzCTR67uvbG5cEyNKQCQjM1l9UqTyCxkA9iHBgRCIgGXwRHMMRv6KHpZXayj2K5BoQo0/IjGEpI0y9kSeHCRM8Orjh35AjAubykEwZVGF2wSdAqzyNlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752433780; c=relaxed/simple;
	bh=han/c3slgAWnDIgZ7bkqXfUW3hLPfy/faR54gsokMHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tKOhI8sFBzrj0cPrcyvpV2QrMB2mWnsftudUEJk2sH98kbgP3atrkNRvKlfbQenTPai72fF/q3VnKBvRwOV0Advgw/rSt7J2K8nuWu3OoKx2Vr7CpuqTbepOu1VLAdDggyYn4sN9JUt4goz/9eFmMFlKEuJHtZV5qp5GFwvsjt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeUg0r2T; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-235ef62066eso53278055ad.3;
        Sun, 13 Jul 2025 12:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752433778; x=1753038578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EDc9aR00osa5Emdot8QtTV6vcWwFrQHMrJLAp3Npe1w=;
        b=EeUg0r2THGLVcEKO2IuZLPGdUouuZWiEcNnYU3EjkZJsMNvVL0tBaPhMfv1te19Pi5
         9jFafRnaX8FBZ1mhFvsjHPzrAIkYWuDy6KsOS+WPs6b4hhArC+ljXpPBaIpsRwB0YXMO
         DkrPTA2jzYd5nrYOza8K4s3ctsUfV+1tDc3EkvSdIlxU/OMd3yzNofSGTUPmwss2jkdr
         JBdCdZy+2+T2YIMVj/u6r+9XsV40UPW5LNI8KhMQalU6J7zI5lk7afnSMIRLBsAFKQCn
         k9AyDNq/ufbz4QSdULpRCTsllepV4Mfjz4dAf2/D7gA/99MgnBiCnQXFtTeOTEulf/Ix
         ldPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752433778; x=1753038578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EDc9aR00osa5Emdot8QtTV6vcWwFrQHMrJLAp3Npe1w=;
        b=kUyYhhykAXAOHomUpmG0t/mgAZPCAlCCQ8MiSbyMm8XeAEtWwqMSg69hXckBI44X5/
         QWe1FAKerswKzq089dFMZNdeoLCVWw+nTVw8BSClLDRdnwJ0w8WftJkHDtuj1LQqEuVa
         VJlStLn1JK0hBm7U0ObPyl66kGJsqPr14JimCI/mx7ykHu3lyFq6l1RjTvHCkJqBTjdE
         Z+IlvesjFuJYEZ5C8TpW3anhzPZjSHMntiQetOmZcuT4Px4XMt+l2B+vpDLQeZnsZwb6
         YTrzsif+/1aQMpglm1iA+aJLil1V5dcieClnS9P2sBweIYNZdb6e6B4DkKv48U6aLTMy
         oNeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+nPY7FfJVyCw/Ej6hPX3V7y6vKsEmLB7K4cIJbjJEX3+DEq2FymnDX67CayfsyzUxY3I=@vger.kernel.org, AJvYcCUmZ3v4oDHFfCeDkDf9fInvrw5BMesXvOiV4qvT18zT088ww21m6n7+25zWZeRm+vRRWJRE5Ux7JTVQ/hOhUBLI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1wMKCKKN2DDuEDZhbAnIy0YC/XZPFMlRHcXqGdTYCKhDHuduK
	lKBHAUJIwU5Oq9aiKRhBdRNSoH5HuNfwwQfTPQvM+eRDapc/eEPBZyQw
X-Gm-Gg: ASbGnctToZX+rFxn2F+mppLdto8cB/IsaxPWWFnb7qAmPeIISOmOPIKtq1jL0u2dLK6
	UCGQN5RyEc/b9Q1IafuzaZYsN4VEm/kvN7prS1cJO+nnz4Kw9kEpZQKurKZz6dS7/3pAwKnRuoD
	n+ljAKUvioP0DHR+op56f+eT1Mg4XXbd5a+MIHTiT4IqEuH8KsOc0VwOEOWk/pNa71Ai+laA5Pc
	36zwBbvJ0vpVuZIhaoAcf9PlcMSgWNz3LLphfTHipr2UvWfnsLULGVhQO3idEf9wffFw//7Fbp0
	L/pPiglMNZaj/sb6wHwDRqEMlhtSnZ/Cy9j0ypIYvm4ZyI6rUp67C+M1ev9MfIScnN8S1sH5yZs
	3HvUh0LssFQkar2J19c8WJ0dKjw6qI1iPnBui5OnGysxKrsS8U+an/ClO1kPLCySVaYNLGI6j3P
	uEJU8bnoU=
X-Google-Smtp-Source: AGHT+IHRGGJcxpkghvO4Z/yTYfIs/Eu5/W2MFS7+wCA+xhbkuHP3w5vRJrBDNR/4gabXXfQEBxRAeg==
X-Received: by 2002:a17:902:c402:b0:236:6f43:7051 with SMTP id d9443c01a7336-23dede52bd2mr115523805ad.23.1752433778366;
        Sun, 13 Jul 2025 12:09:38 -0700 (PDT)
Received: from ?IPV6:2601:646:8f04:30:c0e:994c:1a00:bb33? ([2601:646:8f04:30:c0e:994c:1a00:bb33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3008f29esm11678504a91.21.2025.07.13.12.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 12:09:37 -0700 (PDT)
Message-ID: <6274b090-18b9-44ca-bf3e-872951c1fd2e@gmail.com>
Date: Sun, 13 Jul 2025 12:09:35 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 1/4] selftests: drv-net: Test XDP_PASS/DROP
 support
To: Jakub Kicinski <kuba@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 cratiu@nvidia.com, noren@nvidia.com, cjubran@nvidia.com, mbloch@nvidia.com,
 jdamato@fastly.com, gal@nvidia.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250712002648.2385849-1-mohsin.bashr@gmail.com>
 <20250712002648.2385849-2-mohsin.bashr@gmail.com>
 <8b37460c-8812-4427-ad54-2bab02058413@collabora.com>
 <20250712075859.1667219a@kernel.org>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20250712075859.1667219a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/12/25 7:58 AM, Jakub Kicinski wrote:
> On Sat, 12 Jul 2025 14:25:58 +0500 Muhammad Usama Anjum wrote:
>>> ./drivers/net/xdp.py
>>> TAP version 13
>>> 1..6
>>> ok 1 xdp.test_xdp_native_pass_sb
>>> ok 2 xdp.test_xdp_native_pass_mb
>>> ok 3 xdp.test_xdp_native_drop_sb
>>> ok 4 xdp.test_xdp_native_drop_mb
>> n exit a summary of passed and failed tests should be printed. Probably
>> a exit api call is missing?
>> # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> It's there when we run it in the CI, I think he just missed quoting it
> in the commit msg.
> 
> # # Totals: pass:0 fail:9 xfail:0 xpass:0 skip:0 error:0
> 

Yeah. summary is printed.

