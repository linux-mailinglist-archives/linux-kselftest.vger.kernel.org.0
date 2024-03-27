Return-Path: <linux-kselftest+bounces-6718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E81A88EAF5
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 17:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 600921C31DD4
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 16:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AB712F393;
	Wed, 27 Mar 2024 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eTOccIel"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD60512F58B
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Mar 2024 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711556320; cv=none; b=poGUafzU4dh/Gb88vBbQTR64vKWGaGHnsoNOyTMsZAt4b28AyVQ5W7YlEwS1+g/pMzbj1RWRjS0VQVK434ThyNSYqsx58rljrA0avoUAqY3nsfmNzDb4uBBXUc3PG1IJIFY5TaGQ3knV6Ppca/Xsl6v4V1OOEYDXcy77yVGXIZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711556320; c=relaxed/simple;
	bh=2mlVydQJmeDZD0C210CqOG3B6PFVjqqc5l12YwGy1jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SET2BHihU5QuoB8Jm6ig9aJvR8Jz36mo9KdAbtD14Unds5tf0gzNGY1crK+FhMuj9TNZHepTCznl+47X/5i1dLXvbwgyGp4KQBbD7WF3s0XA/ugYAtYwAl1n7AIrMP51K+W55o5V6BiiNP6jxOREy9oYPoZFiB2pJs+xapWK4To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eTOccIel; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3685acaa878so3940995ab.1
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Mar 2024 09:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711556318; x=1712161118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A3n7vo3IDDksA0EyXBWwDk90r432Y6GahhgJq9RLXhk=;
        b=eTOccIel0gv9NCDLPwZ8ZF+n5k5rog3msuprLfq0mjf5DwNRx5m3093ma07/lj+gNC
         BdQ6Gj7vdVRX/UG2oxGynqxknYkMKWMN3RM/oHADMijOyePGgUtnhKmsAcaVTYHJe7Xz
         3/MTTz4P6py7av2PwKjJ8uxU7OZoRyXBlkrKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711556318; x=1712161118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3n7vo3IDDksA0EyXBWwDk90r432Y6GahhgJq9RLXhk=;
        b=jh4pQQi0I1hJ4Hzqyx/2lav8GxznizzhcL5cy7c/Q2XojPK/SQ5I+ed+6aUYgzxzAj
         dUgytl0zBVGB7eMD34DmFgSYKalRZs17iTK070b7RcyM+W3DLoeg+TzsA37larB61f19
         vy8b2O6ZjU/hMkul6Hn9mvUdb7YMyuOph37YCEf4j8JDtecuQO0nEoUtLZJ4EMjpbJpt
         fDAWz1pjM+X8H8CQHNIBV17xL5+AGEOn3By5juGH3R+gbri35+AoSG2Zedm+nH86l5y3
         oDDSZy1R/rJY3Eqap0RUwN2QcyTmnCZYQYMe84ZAv56LJwaGSWey58HcLYqXlu4gVRhN
         a4Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUyn4Qj0Kh0q8EMw81WscggO1YAuua9wT112kNce3ow6YtpywXyvSNuU/x/MgcvIrUzqMbv0dRydBEw64oYWpX/I83kyr2l5t0pMnCL1keV
X-Gm-Message-State: AOJu0Yw5BMZKuQtXhFYeh/wl7XtkDda9yovcXHQtAGYn6ivy7CsC0xVY
	YmziA8v+mx3lwtlGPymJu3hpJSAyDf7vk7NB94GeefWhEAduQbcftWvDyFrbnJ8=
X-Google-Smtp-Source: AGHT+IF7yIh3uN51oX9Uv2Qm743DenbAnFk7aOHkg5zmiVoM2zf/D2qzzwRJyzdHl8poXARbs/VXTg==
X-Received: by 2002:a5e:8c15:0:b0:7d0:6728:66eb with SMTP id n21-20020a5e8c15000000b007d0672866ebmr609391ioj.1.1711556317589;
        Wed, 27 Mar 2024 09:18:37 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id r23-20020a5e9517000000b007cf05417adbsm3598725ioj.22.2024.03.27.09.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 09:18:37 -0700 (PDT)
Message-ID: <646effc4-c67d-4248-8e69-4279a3d7ec28@linuxfoundation.org>
Date: Wed, 27 Mar 2024 10:18:36 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: x86: skip the tests if prerequisites aren't
 fulfilled
To: "Chang S. Bae" <chang.seok.bae@intel.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Weihong Zhang <weihong.zhang@intel.com>, angquan yu <angquan21@gmail.com>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240314114502.466806-1-usama.anjum@collabora.com>
 <9b30d5a7-1a23-4f48-b6c3-4908535a998b@linuxfoundation.org>
 <a2b8e7b3-2f38-40a7-9e3e-c2cfa2ba8892@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <a2b8e7b3-2f38-40a7-9e3e-c2cfa2ba8892@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/24 15:20, Chang S. Bae wrote:
> On 3/26/2024 1:51 PM, Shuah Khan wrote:
>>
>> show that there are bo backwards compatibility issues
> In older kernels lacking AMX support [1], arch_prctl() returns EINVAL. With AMX support, the kernel will properly set 'features'.
> 
> It is also worth noting that this simplification was previously acknowledged [2], albeit some time ago.
> 
> Thanks,
> Chang
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=db8268df0983adc2bb1fb48c9e5f7bfbb5f617f3
> [2] https://lore.kernel.org/lkml/de61ffdb-638a-ca84-31b5-55f6a8616597@linuxfoundation.org/
> 
> 

Thanks. This can be included in the change log so it is
clear.

thanks,
-- Shuah

