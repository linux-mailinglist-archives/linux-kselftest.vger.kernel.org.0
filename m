Return-Path: <linux-kselftest+bounces-14679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2850945397
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 21:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CFE21F23FC6
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 19:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FC414A60E;
	Thu,  1 Aug 2024 19:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TeA60Ndj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5606B13C832
	for <linux-kselftest@vger.kernel.org>; Thu,  1 Aug 2024 19:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722542236; cv=none; b=VrZxmhcUo9kvQE4tgE4jBbyfFozqFot2mVmahOLc5FIqwkjl1RYP+gPaqboJMNIdkA6cEqUVL7faPsX+LuyUrJoBBo1cPukNa2Q4GkoUEtcX15B0S0Qza0EfCoGJwb+MM/D7sGHXn+OCaIelCZ+OQWtOfbHRssxJXkgE6NaG9Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722542236; c=relaxed/simple;
	bh=VfRggyGIBzKBJ9AABP1WIR6ZJX3zg2RU1KS/LjIGzXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJ2DuROcQQIre+SM9ehg56tbWOiOKaEYK7wqgv3OaHnaT+COYwSUCRIJTCO2Z/tjS9YqpZRrWHZRSJ2tIcJWF2+i+OKVDkeGJrdCUHB/HZ7uOZrBNxewR1ULgT2CIh/4PnAuh26zVQOjD1zzAjpTvnH3OkVZXGiymkbuANHDZjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TeA60Ndj; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-81f86cebca3so46960239f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Aug 2024 12:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722542232; x=1723147032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gRUG/+szalZ1Dtn2W2ib+B4QSFmDogip9WPagZdhULc=;
        b=TeA60NdjzfwR4zACqD82jwr9N1hBr0yXI7Ub+I7nuvhocRkyJp5Ws30P3+T8/6EuMv
         d99OVvOrVJN09cVqW+PUGHF43wBRgciM6sHLx6w8Shqs8H4CfOONdza48W+4wjNgltOc
         8NtSaKLIOY85D2i4lN4xSdOd4lILyPFx7E7ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722542232; x=1723147032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gRUG/+szalZ1Dtn2W2ib+B4QSFmDogip9WPagZdhULc=;
        b=OJ0jivSZDyuDmwWNzIfdZkhU3HUSPy6NfrxZzbS2cRL9xwHEYDOjvz/g3OvDFLrBvW
         Et08HsN0Btr2dE0cf2RApSA/xInAiBmXiDlOYfabpSe719KevYEk54X0TODTMo0X6cNX
         Km4ciIcKc7eFnri69Ntazl2D5495rBNOOQocNqNQo9F0GDM9yLN1DDP2+FVoM7NIVaOS
         0teRelksb/JI17IuAgzpWqYvft5WjsOequUOR93xNUyzjPmFuVtKVmhbXJYz6RsuaNNj
         4GKv5tXS2voG2vwgVTJtcxs0NK6vMPGv/UKfT08chX/qFvg5liRh9SH89XM8tTJsN6wz
         P6Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWa8aV0RMnxReWSlL6t5FNRJhR1KVemg6u/IsWZd5FIGSKlbPhxd7x381YHOXz8u46pZ24Q952hErzuF9AkY1izjPqMdfYr5TB6vRdOLA7D
X-Gm-Message-State: AOJu0YxZucjbkMUOa17wJImK/qYaU19qJPyrLUP/ATXU8aJ3jrV4yctZ
	EKpdiYnlRWnhpn1WwoZBZiVvezTQH0NojLO/fCT5znvWAU5CzvYDrkYiejz6PW0=
X-Google-Smtp-Source: AGHT+IFsxENrq11/dXSM1og7GcrNwd2Jfjtj7nddGSwMMIPtERTjp96wBjG64b7g2K2vekcseFaUnQ==
X-Received: by 2002:a5d:8185:0:b0:80a:9c66:3842 with SMTP id ca18e2360f4ac-81fd43d5bf1mr89031639f.3.1722542232301;
        Thu, 01 Aug 2024 12:57:12 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a59c89sm87300173.168.2024.08.01.12.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 12:57:11 -0700 (PDT)
Message-ID: <e03c9a30-bddd-4620-bd4f-024dc29d6328@linuxfoundation.org>
Date: Thu, 1 Aug 2024 13:57:11 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add selftests/x86 entry
To: Peter Zijlstra <peterz@infradead.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel@collabora.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240610052810.1488793-1-usama.anjum@collabora.com>
 <83d0c57a-dd87-42eb-935a-e4104c17a5ed@collabora.com>
 <3518e3ef-3444-419d-94ce-331f4e7fb391@collabora.com>
 <257c9106-c33a-46c1-9761-111505309176@linuxfoundation.org>
 <20240731212325.GY40213@noisy.programming.kicks-ass.net>
 <a32a8cdf-b488-4b6f-a0d9-d709b9beb769@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <a32a8cdf-b488-4b6f-a0d9-d709b9beb769@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/1/24 13:27, Shuah Khan wrote:
> On 7/31/24 15:23, Peter Zijlstra wrote:
>> On Wed, Jul 31, 2024 at 12:14:16PM -0600, Shuah Khan wrote:
>>> On 7/31/24 07:42, Muhammad Usama Anjum wrote:
>>>> Kind reminder
>>>>
>>>> On 7/2/24 3:17 PM, Muhammad Usama Anjum wrote:
>>>>> Kind reminder
>>>
>>> Top post ???
>>>
>>>>>
>>>>> On 6/10/24 10:28 AM, Muhammad Usama Anjum wrote:
>>>>>> There are no maintainers specified for tools/testing/selftests/x86.
>>>>>> Shuah has mentioned [1] that the patches should go through x86 tree or
>>>>>> in special cases directly to Shuah's tree after getting ack-ed from x86
>>>>>> maintainers. Different people have been confused when sending patches as
>>>>>> correct maintainers aren't found by get_maintainer.pl script. Fix
>>>>>> this by adding entry to MAINTAINERS file.
>>>>>>
>>>>>> [1] https://lore.kernel.org/all/90dc0dfc-4c67-4ea1-b705-0585d6e2ec47@linuxfoundation.org
>>>>>>
>>>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>>>> ---
>>>>>>    MAINTAINERS | 1 +
>>>>>>    1 file changed, 1 insertion(+)
>>>>>>
>>>
>>> Applied to linux-kselftest next for Linux 6.12-rc1.
>>
>> You are applying things for the x86 entry, without an x86 ack, srsly?
> 
> People are having problems with s86 selftests not making it to x86 lists.
> I figured it will make it easier for the x86 team.
> 
> I don't have issues dropping this patch.
> 

Dropped from my tree

thanks,
-- Shuah


