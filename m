Return-Path: <linux-kselftest+bounces-14561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2255F94351E
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 19:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBBA21F22F75
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 17:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A491CF96;
	Wed, 31 Jul 2024 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LdVO2YAl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6566317543
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722447931; cv=none; b=B5E/+EB01FP4RWJT1Ch/cYVf4amto4LpcE7Dk1KoWgeegGHzmCN4uU3zWTASE7fzzU1zW4gxviMz7KhDU7b7vCuDeqUPghcpBW5sf/iIJN5Q3CmaFHtEpExnoOXymspzNkC9jIM4LYQAZhxJxmHljukkhMD9naLo9frNgyEwuA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722447931; c=relaxed/simple;
	bh=uu38UeVuWeQxn11k7eYvpVyA4qCCVtoxEkbcIXDmeBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/8asAsHvk8989cWNv0GHRy0BNIvQVQsLkRrhzUiqwqv+WetJS26oynG5mXojLzhvkn+I4Q4CtAMjvl3msLVvJBH6QLS28nxqAAtJpWIQnHGVlt+DBzd1guigriVMmV4dDymoqEcRET0mFT5J/w4DXmYKMpVq89sVQazh4F8v+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LdVO2YAl; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-398041b6e3dso1861145ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 10:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722447929; x=1723052729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gKjIl2NyA76Ap6Ri9WultJJTbl2LafKjHjLFOLlGol8=;
        b=LdVO2YAl29z4LwHoEBTg6oZ7mQzFXvvf51+pScKXSseJUV3Ulu5m/N/CkeCb0KBw+S
         LktBPQWVJ79DCWyZMqTaMmY4OttYkDLz3dr+4TxiSY6W/LU8M2IHNAQCLxRuC5ABIvNH
         roa6uoxUET35H1xX1gefejb7zRrdGctrnKGwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722447929; x=1723052729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gKjIl2NyA76Ap6Ri9WultJJTbl2LafKjHjLFOLlGol8=;
        b=pxl6sI2KUBQaYcyXNCuo1uBhBC7sVgaeWZ7QI5MZFwmeE15CkF2zExZI1nmPg7+azw
         YJ1l1YRatgDeliMwciG/KN21ey+rAyrjzVOdK+xSbNXo8G+iwMHfVvTuYEY1kDoYOO4w
         Cj0RjgbNh4Qnst828+JCql6kNsc+cP8zzBy2EzlnHquXq8UqjhzU0BIS7qo5ZgnVuFRU
         L82xKgYO0LJQD6DuxmHvddf8dzyI1f/uYaHINWUdSxD2NSJbDInz4Rw0v0DAAz7EJvUq
         i0iNEY6DVghPgVdeUv4I6GwKzzusJ7RcwgV5r3JWPlVHxOgFqJkwyxXk3V28X7J2P0ea
         mrPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7xL2qSsu6lUSDbrE6IDqAstCXBFKtz9g2PVyUI3FvC7UwH2j96TyHyU9n8dkfdRisoY9rqxb5ogJ1DRtel/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4w6mlpTIZdwO7jZ0VQoMLYysOsTRRo4f2Y7oFeodmg1/vCx5J
	NzxXcl+13wrZJ9KsUWbEWB7DxPRISkahPalghzOe4fZHcteOXrS0Wlu3+nkzFpI=
X-Google-Smtp-Source: AGHT+IF9D8RaHtGbstnwGffEywKhxqDSCv45KeTpLutSLyuGo1KAlqXKjX7Uav0Wx6LiAnsE9rw57A==
X-Received: by 2002:a05:6602:1ccb:b0:81f:bf02:fd0a with SMTP id ca18e2360f4ac-81fbf0301ccmr348720239f.3.1722447929592;
        Wed, 31 Jul 2024 10:45:29 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fc66b83sm3274393173.179.2024.07.31.10.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 10:45:29 -0700 (PDT)
Message-ID: <8696338c-fcd7-4c0f-87ec-9303c9c1ce88@linuxfoundation.org>
Date: Wed, 31 Jul 2024 11:45:28 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: tpm2: redirect python unittest logs to stdout
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240710081539.1741132-1-usama.anjum@collabora.com>
 <47ea7423-3aae-4bb3-a41f-1fcb5c07e74b@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <47ea7423-3aae-4bb3-a41f-1fcb5c07e74b@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 07:42, Muhammad Usama Anjum wrote:
> Reminder
> 

top post???

> On 7/10/24 1:15 PM, Muhammad Usama Anjum wrote:
>> The python unittest module writes all its output to stderr, even when
>> the run is clean. Redirect its output logs to stdout.
>>
>> Cc: Jarkko Sakkinen <jarkko@kernel.org>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>   tools/testing/selftests/tpm2/test_async.sh | 2 +-
>>   tools/testing/selftests/tpm2/test_smoke.sh | 2 +-
>>   tools/testing/selftests/tpm2/test_space.sh | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>

Applied to linux-kselftest next for Linux 6.12-rc1

thanks,
-- Shuah


