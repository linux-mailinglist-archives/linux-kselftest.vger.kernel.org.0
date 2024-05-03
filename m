Return-Path: <linux-kselftest+bounces-9426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B543C8BB445
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 21:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67991C221C0
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 19:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFC9158A3E;
	Fri,  3 May 2024 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IrXHQso/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C28D51A
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 19:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714765333; cv=none; b=XE+9wifXH7WY+QYoGHrVfg413geKAGZBu08YNlIt96WUjr0lYbtli7ZMo2d4P4TwE55wvd98fl3+U0H0ulUqhbzwwokK3Ol+s/FMi5bsSPMitMr+Vtn2gnDP2HpxV9Bp4U/xAuPqakEBNveDI/E0ZPFNDtMQtxeXMEmiaGuhm+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714765333; c=relaxed/simple;
	bh=lmgSiRO/qeWY2rx3mwtsVmBlqWlnJWkwnyepOJ7YHs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iE9+vj+rTq+ME4p0arTqOWL3eCclQ3+HqLNWGuJ3VMF/2CJlznMgm2ZZmkmrIF/kYQ0oFH6AtRjvqOaxrXbuvs0pofqTgDOFDhglmirJD+HiszHGUnd3ltLCjbGqLlRxKCUQGEuftfl6RhjGvfdsoK8M/6uuuloT+felo7eDCeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IrXHQso/; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7dee034225eso182339f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 03 May 2024 12:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714765329; x=1715370129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=isnNwgzpej5QkXxVDz6RxdNZolwJVMQ0OEWi8JJK3c8=;
        b=IrXHQso/djxTaGVRQVaL6eY7k0DqNt4AQj4iPIdo/DBGq1/waMHcvBjmHfkge53yoA
         Xm5pkX6X5wjaJNw34/ydyZJkohHgcpUdxtbooDLLi3pOItibFjWOgYQOxI47pYRf4O9e
         Y0qiAidljMSuNVuSTnhT2+C3qBZJe9VfFn38o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714765329; x=1715370129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=isnNwgzpej5QkXxVDz6RxdNZolwJVMQ0OEWi8JJK3c8=;
        b=K7VZvwrZLFHLCccLZdTiDA+0Kk4tVt42M7rLHo01+oi+1Q9fAKM9S0Dj0q8e3vTE6w
         dHKJyEn2yfddUMjUDaXCHD1bybSmS6E4182qFrC4vebY4M48ICZcKcKpLIttwuj0rRMg
         QqSAI/ApWRu0GOuj+MoS2Dqgavlwm2sIetMJsutGIcc9Q99/53M/dmmYs8/+dTdISgfZ
         rT/ZSDhha5NP6/6GSAWUkfEO1r7TXyHJ0kvm5CeNzGNgALHJylS2hKF1tk1c0cZD+u5j
         7dGpfS3oizhzYmIYSz+CAfwTJTh82tl0sp7GXWoLj9ubt7I0r6qNb4jD8CzuB2Ya2qXO
         b9ig==
X-Forwarded-Encrypted: i=1; AJvYcCVKYy31161qr8KnC44jOW+1XKyQqB0claStwk+RsXWNo7Uml9yHgWijGWFSVK8DotLVnSVr2tmzjEmmmvv62LYuBNuc4KBTnsqz+0eRfHaG
X-Gm-Message-State: AOJu0Yw563oqXj21ZUfz4ca+Yn1Ouy9xCcZxE6BcjOmfwSf64g9i0s/6
	RQyTuh4xNnhnw7/qx6s4mmnUvFaZJPcTALPb7lKVu1Zw9ngO+6L9FVHr6g9QYPg=
X-Google-Smtp-Source: AGHT+IGDzFDyA3HpFHwZS3KljRezBBycS88K71+0k0BMI8DZsfKR3K6BNeDKfqhfDL+rDMO2Aw6qnA==
X-Received: by 2002:a05:6e02:219c:b0:36b:15e0:de18 with SMTP id j28-20020a056e02219c00b0036b15e0de18mr4188255ila.0.1714765329490;
        Fri, 03 May 2024 12:42:09 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id i8-20020a056e021b0800b0036c6ad53d1dsm790397ilv.50.2024.05.03.12.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 12:42:09 -0700 (PDT)
Message-ID: <a8811c10-692e-411f-bc08-c25c38f824fe@linuxfoundation.org>
Date: Fri, 3 May 2024 13:42:08 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest/tty: Use harness framework in tty
To: Shengyu Li <shengyu.li.evgeny@gmail.com>, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240430150508.82467-1-shengyu.li.evgeny@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240430150508.82467-1-shengyu.li.evgeny@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 09:05, Shengyu Li wrote:
> Similarly, this one is based on automated tools and a very
> small percentage of manual modifications to automatically refactor
> the version that uses kselftest_harness.h, which is logically clearer.
> 

Similar to what? How does refactoring help?


Follow the imperative mood to write change logs:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

> Signed-off-by: Shengyu Li <shengyu.li.evgeny@gmail.com>
> ---

thanks,
-- Shuah


