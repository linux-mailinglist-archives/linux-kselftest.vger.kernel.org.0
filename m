Return-Path: <linux-kselftest+bounces-42973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD9BBCE724
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 22:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02FBF4E2387
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 20:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FECD30214E;
	Fri, 10 Oct 2025 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DGqpZBGG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1E92F6171
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Oct 2025 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760126834; cv=none; b=ifCBplJX4BMevP4JP7M25Kn4nTTwp6KXf+yFH3v+GZ7LeF+Lw5G3xDlnEfdpCqUSv1kfFDF6tYZ4tvTasclkJpo08QSe98TuLl2xH2tUd44G67Lscsx/ndr33pkmkFjEw0OMxIVOvE7FBqNHtIr8aYRf8nG37JK2lPUWnEEauTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760126834; c=relaxed/simple;
	bh=qJNQginXw33OCL6otz/mio9dtPI95vuO0c28D6VMtAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJMKTWZ9PBDWDEEi2oHUow3aZxvGe6Q3RMG2/rgbWN1WF8p7kg97e0irjT/LzEgTzIqdrd/xWaGy5m3MU2rZ5cz9iP7C1bNRiVeiNKwNv7UOUkTAy5XP8WvVrw9Xw9akwCowG0tU+uWtu4LQUVBMaorNNwESxOtuPL9YMwuR4Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DGqpZBGG; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-92aee734585so95531039f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Oct 2025 13:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760126830; x=1760731630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1C9TGYFUXxVemAwR89Ulh9sGzSp7qA+8XlrADAfHgVc=;
        b=DGqpZBGGjcYvuhn3d1qtBAPuwV6HidoG/f9LxCAAAM2hziVAae/CJyC0oigmkXLzvv
         Ga93rLuSxyVYcz+j0LAzOKF7KT8i792q8WG9oCm5pY5IIhe0RU9bzaDIWhdtWGQyABwn
         RA3hdEC1ygms6StQIxlZy+OsIfJnfgZPhRi+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760126830; x=1760731630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1C9TGYFUXxVemAwR89Ulh9sGzSp7qA+8XlrADAfHgVc=;
        b=iU5sft46PF30Qwd+Y2d47FpkJzuIpvhpXJsK5QEZh5xp2I8VfQHoXrK9Frsnj8uyOG
         mcEnx8LyzmWeTE1pg9mRK078cTtLw71ArAZRrBHUNplwOU7qzmZTc8Li5osW2Pto8+3J
         qyrTMEzhfGwZCdRdE+2HRI0Tqs4LjRIZ1lB1/YLyBivTL/c0kt+Xyh0vcDo77cDx+GR8
         EIqGMNIcTW8QimFUgocjG21ER61uECMxdq5f83artsagHmx0wYW/Z5lWq7E7YGNwtUBd
         Al6Sjr90HO0F1jG3q+3pSxGRyFmyCw/ND68X1nb5NUJ7twT/sk3ff50HUaLinQ8hsePb
         r6Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWX3syxBAZaPhXhV6uDetzy1m3gWBrw29VHsrCDbShvjnwgCDY+bLAw0fBBaISidqigYe9A694wirBvtPioJmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQcX/ECrSx5mPzWz4tA8wMVQ0eWsGE/9W1+BZ2L/8yE6OQukfB
	EWpqXeZn9fA+xtVb/lpgMBZOFxCd72xG44sMJQoBiA9cjzDlbXu1p3cmPA9vnyqj2yI=
X-Gm-Gg: ASbGncvT1+AkaLHnTEd8y5tEIQ3J4eMYsyjhJi5hLuqqawvIqCriDQ6JuBnbh73Jphs
	daVMTLZlxY3RlGXjAnj820Il5Yi+yMesRnqBpNKpnV0yoNOWsA3R3PUyoXhx55YUtwGk0n8IWuT
	6DQYGk2VOLdoS5zBSG2Ft7Thlp/o8RJm+yOjBEVMgBVSy8ETIlmvDzk+RAP8GXO/FMp12gY+BKp
	mQfOHosUMiw0pTmy8dhix3FlV5PrW+1AGOYRzodhwhAPqmGOmB8OX6wehNYqsrCTmyC3mCGMi79
	b10B0Fyk2jUgMXE/7JZenu+CvC2fTlk4Czzo/A6FRdD1fG9xsy4ZLn6fVqlUHlbECJIYe3qDGD5
	rcTAuuEl2lX7bpGbG4cfSrAYFBqf2+okoCJnlWrDynuKbai7Cf0v2/g==
X-Google-Smtp-Source: AGHT+IF47OBorJnDZLxogs92bg9DbP41Re55bcWPxH2LtcWYwZh2W54OFZb8SOadJVjAyPp0dDz4Zg==
X-Received: by 2002:a05:6e02:2186:b0:42e:6e45:e0a3 with SMTP id e9e14a558f8ab-42f873544bfmr138691105ab.2.1760126829993;
        Fri, 10 Oct 2025 13:07:09 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f9036cee5sm23494755ab.32.2025.10.10.13.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 13:07:09 -0700 (PDT)
Message-ID: <75584276-6d30-4e35-9e59-e084c60d1c5f@linuxfoundation.org>
Date: Fri, 10 Oct 2025 14:07:08 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests: cachestat: Fix warning on declaration under
 label
To: hannes@cmpxchg.org, nphamcs@gmail.com
Cc: nathan@kernel.org, shuah@kernel.org, morbo@google.com,
 justinstitt@google.com, nick.desaulniers+lkml@gmail.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, david.hunter.linux@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>,
 Sidharth Seela <sidharthseela@gmail.com>, SeongJae Park <sj@kernel.org>
References: <20250929172724.75108-1-sj@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250929172724.75108-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/29/25 11:27, SeongJae Park wrote:
> On Mon, 29 Sep 2025 17:24:06 +0530 Sidharth Seela <sidharthseela@gmail.com> wrote:
> 
>> Fix warning caused from declaration under a case label. The proper way
>> is to declare variable at the beginning of the function. The warning
>> came from running clang using LLVM=1; and is as follows:
>> --
>> -test_cachestat.c:260:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
>>    260 |                 char *map = mmap(NULL, filesize, PROT_READ | PROT_WRITE,
>>        |
>>
>> Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> 

Johannes and Nhat,

Assuming this will go through cachestat tree

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Let me know if you would like me to take this through my tree.

thanks,
-- Shuah

