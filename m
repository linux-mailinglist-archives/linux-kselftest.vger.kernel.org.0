Return-Path: <linux-kselftest+bounces-10963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B648D546D
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 23:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5DE1F24117
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 21:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61B2183980;
	Thu, 30 May 2024 21:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KVM+6TUw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED924DA10
	for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 21:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103623; cv=none; b=MS5K7dRpQzUbwuChlHL98P6tFel9GpGW5FMXIqDutLH64Nv2mtKEuYesmXhEkD87Bb83fduVrBE71W4o7dsQyu3fJV9UmZanfDD4bNwPkmOPjy6gsncLirv4N8gRGsBlVnlsN/xRP4/9eIq04YtpwQylF9HcIZh55d3Jx3cBDjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103623; c=relaxed/simple;
	bh=KF2KZFt7KqXZHK0uvHeIz9ZPa10L9lrpUZ+5YMf1XCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXPbGmBYi3tjCC9BAgwVIGZHJx13pjrE8BMvjjM94TrerM3YSw+8XWm4oaSLyMl4sfFZArOIj6yf3tXuF76aimDEVPqUGTkyHvtgBmlGnPQGwZ1Oemc00WFVF/Ix5zdDU1O9YfQ/CGRi7hQP2qvkkVGaAC56EyQd/G04LpRnOLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KVM+6TUw; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3737ee27cb9so748125ab.2
        for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 14:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717103621; x=1717708421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cc22q3I70MPueAnmKsTkHjW1R6pGbLRcvceT5HSMS2c=;
        b=KVM+6TUw6xdnmceVB0rErUcS9g/1AO1COXURsAf1VgLUtQO5dT0QmULqG8z+aM8M2U
         7+INoD6TSlybTgr97yQ/BQ1zfl6lKOnHMO+Omhj64+mG0fFYEBd9Cbj2DKEbYwzb8dU1
         69/xwTzULZB/JpOhb3YDvUjwxob13AdMEQ89g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717103621; x=1717708421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cc22q3I70MPueAnmKsTkHjW1R6pGbLRcvceT5HSMS2c=;
        b=BvFG4x08SvHYsUWNzEzvTWYaTojnB2Wf+2UGEf9VPWImUdyeb9EalwmkWWXlbB+Aah
         onGxlRgRGQQuUgZwdJZNaoDS4F4d2eQed/kQmmwbEyYNhVeOhPE7G3CnyP+w/BaIyobm
         jpFnDWhLHmDJ4salA0LDA7K4LAHbl012cXUI/JCYLuSLmALL9uFEqXrv8G7sV9VbjTxQ
         zLcUPndYM6e9XZ4a7Ym5E22g1MgpWqKD4li/q8TBK4YjiuEiRegG9EitaIIJzqfNAPkn
         DZnWHXin7uujkWg5biIPpn1IfDcC7xnSIjMfxHO8ydtfI/+YUyVdg+aAI5TCa7jheupf
         5nFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYqIGCjffHSyvjwtueCjHFmmJWqDQGo+ytbgHN1lC48C8mwdir8YGS9x/fOD1ttK9TwjifzE+git5eoRfMhvJKfDflPV0HwG1c/4xqN7cM
X-Gm-Message-State: AOJu0YyC52LuTrg83qGHwEjR0Cj/f8kY1qV5F0S9umYKod2/BSpwKsrV
	d7fN0JkvRMBAbDs3xyfBLGorDakzDF+NoIt345k/UMD79Goq1L2cZOaX+rCgOlY=
X-Google-Smtp-Source: AGHT+IEpQILx8LWmHPHqM2sy4iJv5pqIjurHEv49PTQSqq85xRqucuPLELtBfibS3cv3oIO0UwlOVQ==
X-Received: by 2002:a05:6e02:1d07:b0:374:88c6:385b with SMTP id e9e14a558f8ab-3748b9d096bmr894325ab.2.1717103621456;
        Thu, 30 May 2024 14:13:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b48cd014dcsm115065173.157.2024.05.30.14.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 14:13:41 -0700 (PDT)
Message-ID: <b245cd0a-8a87-4169-b0de-e4f6ce6984c6@linuxfoundation.org>
Date: Thu, 30 May 2024 15:13:40 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] selftests/futex: don't pass a const char* to
 asprintf(3)
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Edward Liaw <edliaw@google.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Nysal Jan K . A" <nysal@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240529022938.129624-1-jhubbard@nvidia.com>
 <20240529022938.129624-3-jhubbard@nvidia.com>
 <94fe2649-8def-4f2a-ba5f-19ae8a4226bf@linuxfoundation.org>
 <f0a1ca78-f94e-4f02-a5e0-ef9d610fac07@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <f0a1ca78-f94e-4f02-a5e0-ef9d610fac07@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/30/24 13:16, John Hubbard wrote:
> On 5/30/24 12:04 PM, Shuah Khan wrote:
>> On 5/28/24 20:29, John Hubbard wrote:
>>> When building with clang, via:
>>>
>>>      make LLVM=1 -C tools/testing/selftests
>>>
>>> ...clang issues a warning, because test_name is passed into asprintf(3),
>>> which then changes it.
>>
>> Please include the warning in the commit log.
> 
> Ah, OK, the warning is:
> 
> futex_requeue_pi.c:403:17: warning: passing 'const char **' to parameter
> of type 'char **' discards qualifiers in nested pointer types
> [-Wincompatible-pointer-types-discards-qualifiers]
> 
> 
> Please let me know if you'd prefer a v3, or if you'd rather fix it
> up, whatever seems easiest for you.
> 

Yes please send me v3.

thanks,
-- Shuah


