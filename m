Return-Path: <linux-kselftest+bounces-31599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10187A9B8C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 22:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A82F1B63714
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 20:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCDB1F3BBF;
	Thu, 24 Apr 2025 20:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gm0p5CoW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708911F1506
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 20:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745525198; cv=none; b=PMSm/QCwWEWxWyc3OB+G/bDzfBxlFfguBujvLyZ6gO4F3fMDf2RkA35atUHqKnn9qGtlCi/LbZrKNOZAUF1Vq1zJDiIWsBq5//JPi13nyrmi9QCmEYQ72rx85w5MrqapH3JibfcakF13OxOP+A6ZzPobSwE9N/REN2VYCz0+7Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745525198; c=relaxed/simple;
	bh=fJZ8eKDZ9o5rn9QbNxG8GevlAeOb3Z+jUEwwBAI5lyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aawf7NxXYoc7GBu0WzIR0te8X/J0VE6dTX1N7f+v56NXButH8d9tyWv/s7vm2l5PDVD4yMWIU3vu66dHtMlQdPjkngklonRMXCoAcfBvdVfTI//CqMD3nLBKZqJhvnWCVS48qOBLmjG/3ahK07KOVCB40PwnXssrK60lNk97cfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gm0p5CoW; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d81ca1d436so11762045ab.2
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 13:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1745525195; x=1746129995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AVRzGmjV/0HEkYKJof5klQF5ybqq+AWOWOrrwLxCS5s=;
        b=gm0p5CoWDR6svlb4/p2vpfOLvlPvaJEtFmgmpIhznzn7sYkhgXuHCA8TPMsKj/c9FX
         xJsV3QtXXWXG+nbMXS4f9ZG93QNqVwIMXS5JgSfp2q5BJHFAjMYygwPp7pnqoBB+coyZ
         iVgFfAwq5xgD08dXORl3+cabVntMEyC6Tb4Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745525195; x=1746129995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVRzGmjV/0HEkYKJof5klQF5ybqq+AWOWOrrwLxCS5s=;
        b=E0UQ3luVzqS82p9aW44QbC7/nnxcTNAGz+AD1/hix6rXdEbU5Kitc7A0g4L3rlo2iU
         9ILU+6lrrRA/bzMWFHcDJ10iUbbqGdXP586HcKizVGc6UJxcp98pDpEO2KcQUhSF2xY2
         odg3M5uXaZhdsyKht8//yEj29+AULbtRMSaqVmAx0OO3H70oXqKwDwITQktOGs5hGdNh
         bKWSpWr809Cu0zDaEMBhYB/8SM1gph9NL+wMALCg6Ea2XPjxI7swTDyIXbr0VnM2xY4H
         NYi7KECa9GYD94Rftkm1CECiwKNi4cFfWk2x1FRdzRzejyy/DAds3m0joBl9B3wahSbC
         O3Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUlFeKyXiAq+eC8WAGRURuwY0g9TxJEQYI7tsfDtqXsbbcK9vYCjIbTU0D6HECx971OI/3WOrnU39MK851bQaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWpoJhDZy6aV3VxmZw3zvPv0aPFgZSRJvN82fbs5Gj6loVmhEY
	bxMIgNzBHfY7asVnZf4YNb5l8usb/O8SrKik/4pkrZvDSSzIxZlh6w62g+7ChdY=
X-Gm-Gg: ASbGncs4NHbWzwm2FDyhZBCUP8OnXSEgeIrdin2obSvncAXhIiuFo3feS0KKUR4P30e
	GU+df/dKaUUcJNFvVLdN4mTYqDgl5Euel61bEF7bbZ3wCdnKbd9odmS4se5Qu1S8n0e9Yaojhbw
	wktzGOsaIKQ9Z1StRtIPsIisPdX5F+vh7wKrC3mikVX7Q+rhfvFauwk2SVkG3auap5kzVx05egn
	s62CgrMmebPznUrpmSfkAn6bsq4oE2SYJQ85VhqoAdaOE0ySWgze/69z2Q9oYVZ+9yZm2vLPqAK
	muQLOunQ5PIul3AnNI2Y9uZB414ogVzt78v0IBhehzlzjFFGZU5S8LZRyOtduA==
X-Google-Smtp-Source: AGHT+IEnIfhb/3XAPN8NZ7jNfoQ9CFtr9L+M7azIzh0uX0z5p73hBrxt+gDpy3w/mCwwPOrWpaTF+g==
X-Received: by 2002:a05:6e02:1687:b0:3d4:6fb7:3a36 with SMTP id e9e14a558f8ab-3d930441b28mr48438715ab.20.1745525195470;
        Thu, 24 Apr 2025 13:06:35 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f824bc590bsm418232173.137.2025.04.24.13.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 13:06:34 -0700 (PDT)
Message-ID: <7bb64160-103c-4882-a69b-9bc054e62db8@linuxfoundation.org>
Date: Thu, 24 Apr 2025 14:06:34 -0600
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
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250422085145.GB14589@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/22/25 02:51, Willy Tarreau wrote:
> Hi Thomas,
> 
> On Tue, Apr 22, 2025 at 10:48:28AM +0200, Thomas Weißschuh wrote:
>> Hi,
>>
>> On Fri, Apr 11, 2025 at 11:00:24AM +0200, Thomas Weißschuh wrote:
>>> Nolibc is useful for selftests as the test programs can be very small,
>>> and compiled with just a kernel crosscompiler, without userspace support.
>>> Currently nolibc is only usable with kselftest.h, not the more
>>> convenient to use kselftest_harness.h
>>> This series provides this compatibility by adding new features to nolibc
>>> and removing the usage of problematic features from the harness.
>>>
>>> The first half of the series are changes to the harness, the second one
>>> are for nolibc. Both parts are very independent and should go through
>>> different trees.
>>
>> I need a few nolibc bits of this series (snprintf() and prep patches) to base
>> further patches on. For that I'd like to pick up all the nolibc patches from
>> this series through the nolibc tree. They got Acks from Willy.
>>
>> Any objections?
> 
> No objection on my side!
> 

Thanks.

Kees, do you have any comments on this series? If you are okay
with it, I would like to apply this for next.

thanks,
-- Shuah


