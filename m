Return-Path: <linux-kselftest+bounces-31926-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520EEAA1AF1
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 20:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7457A7ABD1A
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 18:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82B52512C6;
	Tue, 29 Apr 2025 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZK8ydnkJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F75248871
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745952781; cv=none; b=PpNtLsbccDhkote0XYewVKyWqSIzPcOAyCFIaCVrQ41MhuT/eIUu8jhCxOMsO6H7esW6afqWoPmWM8GyvckWO7J1YA0F2V+2rgMbuhhJAdZ3wlA+2tZ2z68k+lUQzitwKEkiBU65JtoOBZYlqROYYnkgBuJr6oar3Dc4PFnfCWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745952781; c=relaxed/simple;
	bh=QK6Ymfa95GtyUuSHfuI4LiDezyinKpzbQUwdqooUatI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhAI/RDE7IWMS45RJUaxABBbUCWfCL0nyCaaDfIn1LWtFnQgk6gfto8r2m/D1zz8LrF9AXuE9ZoWUp8Kd06RvEQojzfGDqCrschX5kHfsLU2E6jZY2m+GnLBT99h3//DSmYNMED8GGlSE2SeSdCMVYbmV9ybUq+bPsjt4tW79VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZK8ydnkJ; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-86192b64d0bso554045939f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 11:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1745952778; x=1746557578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z4yPNijB8LHnY5DZirk/kjkGFS1gFcodp+LjleefMUg=;
        b=ZK8ydnkJfqk1i9aKMKIyviyxEgj7Zg3VXwimeCo3DH7bVp6RMhC1/T2LhK58zXH+yo
         x28nWacXLhOCvO9evB2n8VZqTR2rwLWJ1qvvN33qmwRa46j62dumVpH3fqW/TVhbhd2o
         bYM6K8ii/b8MiP+ABtPTMAuE5r07KPW8CFh90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745952778; x=1746557578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z4yPNijB8LHnY5DZirk/kjkGFS1gFcodp+LjleefMUg=;
        b=esG6KKfAJxs1x04e59yobRJVGUtvy8HngeeXtFk1NH7FnIh3Z/IvBxYIVQjreKOEGN
         BNd88epuPNIwfOofyNDrS5Zqgg8RZS0Y4qVsw5YcnsiOz46xr4aet2oahTYdslz3uBxZ
         pyc21ICM6f640aNOo3Z2uObIcJuXZempgQLmxantQ6UXUoJmRuQx5qJrWAwbefEVQw64
         kIMsFmkf+HKB15+S3q2YuzYLPhU6CsuJwnLnlb+ToWsVo9OvHZXKUesTSyBD5bTxLukb
         9euK/T6mTM8ljRnXzQstJ4UjBTAYyhMKtkv2hv8/Ua9Ai33V7dXT2i7DIMTBN/mlsAfY
         855g==
X-Forwarded-Encrypted: i=1; AJvYcCWlhJ7NRQsYd2XRmins5TjQrWnZ/bXh+gGVYLVRZTVh/Zyezt8GGoN1QCIgJAUelK7NiVZeqe14BG36ZrryAXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YySCjQqWP+eUxRZJpWyKxAWeu6U3X5wCZKBVsf+Gv8BQfNfKoiu
	YYmRU7uda3mKLEfU0oJSf6s+4norGlO2gGY/YPWStWqJ222QZPkhnGLrKUuL5Q8BJiH8geUI6oB
	Q
X-Gm-Gg: ASbGncsytAy9Xbc4T+l7GRmFqX6ElRNt7FBxgW6XRM6kaRt9eo91HQV5awaBw02qU08
	o/Y8molhEU0y7HZ25c6tFPAB4ikCPtSE5Hmcb1HZk36sr5uH9XuJtWwFWm0ZAeCPyk9EjCrU1GB
	ILJ2phfzCJhIlMpf7vlpAmUfQq1sJBMVGgPuG2gRJcDthn5hr1JVBMD9vmx5FL5x8rQkgPDQkWK
	V0PZmldSmnQ+ncbZ4O9PkuuZyWtFbyha2RE3C9Ag1Kasv6HJrEHjaKY1faqanyWvEy5wsouNKA5
	gSNDyx5XWl0HQXxQV1CK+m4UkA73D1dMcqVsildaNr0Qd6IRcIQ=
X-Google-Smtp-Source: AGHT+IFUibPOjHr1A15bkj6HHuP+OSD5vPAsxUFRFKdm4ZJbzf5xV4+dCjqTUUtJoV5mzYv98EokRA==
X-Received: by 2002:a05:6e02:2307:b0:3d9:39f3:f250 with SMTP id e9e14a558f8ab-3d9676b66f4mr3103995ab.3.1745952778078;
        Tue, 29 Apr 2025 11:52:58 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d95f2a2ffbsm4559515ab.7.2025.04.29.11.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 11:52:57 -0700 (PDT)
Message-ID: <329e186d-50e9-46b6-b0ea-ee22ad6e88cb@linuxfoundation.org>
Date: Tue, 29 Apr 2025 12:52:56 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/32] kselftest harness and nolibc compatibility
To: Willy Tarreau <w@1wt.eu>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Kees Cook <kees@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
 <20250422103612-64ea71dd-d51d-487e-b387-508c372af07c@linutronix.de>
 <20250422085145.GB14589@1wt.eu>
 <7bb64160-103c-4882-a69b-9bc054e62db8@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <7bb64160-103c-4882-a69b-9bc054e62db8@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/24/25 14:06, Shuah Khan wrote:
> On 4/22/25 02:51, Willy Tarreau wrote:
>> Hi Thomas,
>>
>> On Tue, Apr 22, 2025 at 10:48:28AM +0200, Thomas Weißschuh wrote:
>>> Hi,
>>>
>>> On Fri, Apr 11, 2025 at 11:00:24AM +0200, Thomas Weißschuh wrote:
>>>> Nolibc is useful for selftests as the test programs can be very small,
>>>> and compiled with just a kernel crosscompiler, without userspace support.
>>>> Currently nolibc is only usable with kselftest.h, not the more
>>>> convenient to use kselftest_harness.h
>>>> This series provides this compatibility by adding new features to nolibc
>>>> and removing the usage of problematic features from the harness.
>>>>
>>>> The first half of the series are changes to the harness, the second one
>>>> are for nolibc. Both parts are very independent and should go through
>>>> different trees.
>>>
>>> I need a few nolibc bits of this series (snprintf() and prep patches) to base
>>> further patches on. For that I'd like to pick up all the nolibc patches from
>>> this series through the nolibc tree. They got Acks from Willy.
>>>
>>> Any objections?
>>
>> No objection on my side!
>>
> 
> Thanks.
> 
> Kees, do you have any comments on this series? If you are okay
> with it, I would like to apply this for next.
> 

Thomas,

Can this be part of no libc pull request for 6.16-rc1 which I will
be fielding this time around?

If so here is my Ack
Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


