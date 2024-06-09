Return-Path: <linux-kselftest+bounces-11514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974D09017EB
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Jun 2024 21:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F09FCB2099B
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Jun 2024 19:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C640C41C71;
	Sun,  9 Jun 2024 19:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b63hlcB9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2126E1B28D;
	Sun,  9 Jun 2024 19:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717959691; cv=none; b=HUwlcleHDvmb1wNETQouiZPdi/6i+E5q4Z7YJiaxpDDcjHL5wenmyJ4cXjObO/5pGCAZvIAQYkCmZGIS6FPFfvEEa2jlMD8nlGnnjWT1gFRvShzWtkcS66v2idT+CsHh6mlDVRrOcam83dneAJg6+zd1Emcz5J11xPR18Vv4ZoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717959691; c=relaxed/simple;
	bh=ocoRvi11iBtziByojGeenMr4D6A+yGo/xCifrTlDuUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZNPtR0z3rLUadaTjbcvGsdUyOT/BSxDVojqaFmVbtKIW2LYoJxv2kzrJoF3HeH4U3WGBc/S3rvAE21aQIKwqhr5PRzipjWkN5+JnHOIHpECOwvtO5WDQZfj9f2alDYX6OqvJ2T40mMeepVSnEfudzr4CjR0avksBDVvs/lqkZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b63hlcB9; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52b7ecafe05so678083e87.3;
        Sun, 09 Jun 2024 12:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717959688; x=1718564488; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EPmBBYLT5yNnrcbl92wdFUaVe7Q/yxC54IFQQ0drxFU=;
        b=b63hlcB9bWCs8JtfivCd/EXRYv0ut7dLaXNAnb9VzJeMvtpNRz086lTBRD3anerXPv
         isx53cv/i2EacUuRwZYXbr8ElkLN2vKXv6G6n88UbCBnuFUJtqlisHpRKb1I6jcsrrkI
         4pd5kIbDASfVY+BJGiYpxafjKiQgHelR0JXNzcPlWFejoVweESwzt6TylAR947Gs3our
         Hc5fEpVRLGrZ7X7JtZB+IVQbFvGyWKBS4OQTG1UvDQ3Y89ALvhl/+PQ3PQMPPh0QC628
         /UNmL0ENh7oneohL5i2w4e2+1t6xHPhYyA4kf/F11nGnrTy1mn49ViWm3S+cIRYhR1cA
         VuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717959688; x=1718564488;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EPmBBYLT5yNnrcbl92wdFUaVe7Q/yxC54IFQQ0drxFU=;
        b=ro9XDkUyo8FeS9zbstWA4qVY4+d2roTW4kwfsdX32IdWSOoon39D6UFdCLGAj9T95/
         imuutooFn2/yjPfMLsKX2Rjkdrb029bFPeG27xgFa0CJ0eClFR7iAwrzqf2FPM5HjKM3
         EqgZ8C4scablVFdoJQFXlrS+Ux6JDpD5t7gv142YdFxBHnWqjYvzcc06WSSIcMn0AUNF
         uXRgDGcT3WZWRuuUifZkUVLHoNlE/8PsybgbtchfFH2hgwe1bvaoYFAQmGG/FZMqmuil
         HQW/wt3wpiooqv1TQVHmGW3elnZ0oahV4aPOH24wt8k8o0poEjJ++uXVTZMpAELz0+Jn
         Levw==
X-Forwarded-Encrypted: i=1; AJvYcCV168gvUEYGYY5DVvgoZOvvR20xRUqVziHLmdcjm7/FhnXOOfb0uo+/mz7lA6sz+jzGc31QhyCBdieAWis3Yag3culg/QUHRDsnIZKux9EGaudgpCsZP2L/Q9VcSpn65YgAV3hvc54VTp661w93
X-Gm-Message-State: AOJu0YyyJDGxhQWwPuLQxG1RSHT3EKSgSOVNRxi0sMskxqiRr1e3p0xH
	XLnWBcpAIPfZwARijsgxqox8QNQJKXzl5LKt+VyZQpvMFruqgBs1
X-Google-Smtp-Source: AGHT+IEjro3Dz3nO6tBHGOASiHqbEGbQmhynRdtvs5TGYPk7MFePTUMw3KmMNSMRWSdBoWOmGd/9/A==
X-Received: by 2002:a05:6512:551:b0:52b:8325:6eed with SMTP id 2adb3069b0e04-52bb9f76f7dmr4617590e87.2.1717959687981;
        Sun, 09 Jun 2024 12:01:27 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:d20e:7300:4c17:8e3c:d4d8:5918? ([2a01:4b00:d20e:7300:4c17:8e3c:d4d8:5918])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1f109346sm2387028f8f.27.2024.06.09.12.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jun 2024 12:01:27 -0700 (PDT)
Message-ID: <655c6a80-53d0-4a9c-b242-25936646e49c@gmail.com>
Date: Sun, 9 Jun 2024 20:01:26 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] kunit: string-stream: export non-static functions
To: David Gow <davidgow@google.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org
References: <20240604123204.10412-1-ivan.orlov0322@gmail.com>
 <20240604123204.10412-2-ivan.orlov0322@gmail.com>
 <CABVgOSnNLmmMDHin=mvrAmN3m6mJmWsntcc_JvV03pCzXUEX+w@mail.gmail.com>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <CABVgOSnNLmmMDHin=mvrAmN3m6mJmWsntcc_JvV03pCzXUEX+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/8/24 10:20, David Gow wrote:
> On Tue, 4 Jun 2024 at 20:32, Ivan Orlov <ivan.orlov0322@gmail.com> wrote:
>>
>> Export non-static functions from the string-stream.c file into the KUnit
>> namespace in order to be able to access them from the KUnit core tests
>> (when they are loaded as modules).
>>
>> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
>> ---
> 
> Looks good to me, thanks.
> 
> It's very slightly hilarious to use EXPORT_SYMBOL_IF_KUNIT() here,
> because _of course_ KUnit is enabled, but I think it's the right idea
> nevertheless.
> 
> Reviewed-by: David Gow <davidgow@google.com>

Hi David,

Thank you for the review.

Yes, the name of the EXPORT_SYMBOL_IF_KUNIT macro in this case is a bit 
confusing... It is used not only to export the symbol conditionally (if 
CONFIG_KUNIT is enabled), but also to export the symbol into the KUnit 
namespace (so I used it as a shortcut for this action here) :)

-- 
Kind regards,
Ivan Orlov


