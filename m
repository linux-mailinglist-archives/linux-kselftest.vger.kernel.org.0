Return-Path: <linux-kselftest+bounces-19679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A967299D9AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 00:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462DF1F236DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 22:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE381D220A;
	Mon, 14 Oct 2024 22:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QCdeFQbJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221B01474B7
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 22:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728943759; cv=none; b=N1nNDWFDU7S8afURgVJT9bIfu1iCkBEN5RunodKs6hp7he4rPbbqzaiUHZa0mCZixtkt6WoEeK447arwxRZE6IFkOkgOOXdZY7Bu42OBlp+gr3u7ZSJgvQr84Vyovy9ufo9RCQuc48uXJWQMRrfexnyT5ulJLfn0O0k5bUGn6xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728943759; c=relaxed/simple;
	bh=IoN2ym/fezho3R++5iArP0rzFinCh83Zm/Xd9RAA9RE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NpNslL85aSAyiN3h5PDQWUcxdCGvkUaz4/BLuNrqvUZ8jW/vPAKhlYXFhiLNsGFGSNWSDm86yABHsmrkiqgS1iGSqfvTRdss1lUy5p9g6PvddUtGFnV26yuvLl53WYigGjh3kqKYSV24h19nk6RXpgNnTIbxSDMYMzrGFRPzU2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QCdeFQbJ; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-8354b8df4c9so169083939f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2024 15:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728943757; x=1729548557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9dwyDNpcI2CKP85q7LmDN5/gxxFMH+zbq0M9yIwSLk=;
        b=QCdeFQbJQ0viZRtqdGth/tNh0M54pM7BSwpVLgi63qwSfQzNKSzI1o+mWJonerKgK8
         g1EqlumXLAjEdhIlCnuS3uMQJkduvxvX5aTUW5V4nhtmeLfxdbC21ejog9d9PvZspfQU
         +so7A95+ajcqLPBSbApeXX/I8gd21naT3Cp04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728943757; x=1729548557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9dwyDNpcI2CKP85q7LmDN5/gxxFMH+zbq0M9yIwSLk=;
        b=H3Qbz7Jp/Njs/VO631AIf/lZ0oQdXnle+XvTRwns7d/Td+Vh+XiQt9G4kKrx4FLFOH
         mkSiMDO9untYV+jxwEUL1qyWCeQPP/7UweSOKsYQzd9vg6vutuym5yAeZDQvRVmOLRJ7
         vWfgaEdrILL8yQXjpEaxwCp2zIWxoQv/WGLCziHIaDjMYxeN2pi0vYu1yIlqz9STsQuR
         /x6HdiZ07whpTAYHWgbcDipda35biLvVtd/aMyhbny1+r+dk3bo1ZasOwu4udkwY0gPt
         5lmHQCXW5Kogo9Ib6plzelCEyzRlEBGhuMXVhQYFF74TPGubbh2cgudKGRkaLvfJn2ny
         gAng==
X-Forwarded-Encrypted: i=1; AJvYcCXc66ohV5XzeAfPvYGW3COJixhFpn9PgOH9tGNoUMoywkUcALYS1G4zFh69RIMYIqroYkY4TXN7CYBY1bfd7U0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd2we5XCeOkQ+Gx8dbchZ5Cc8UAwVt49qK6WezLKTqmBnp/cCF
	dy1jtQ/HJBvRdcR+RXHBOIwAnUSDoGudGyLGG/HHvXWTz+Rl8lhTYUGxR0gsCrY=
X-Google-Smtp-Source: AGHT+IFzjgPeJcnUWunnpkrcZpJhLGLQYeiI9hikhqjsBSfaiTa5/JLqQQ2w6k7ZaTiFxrdW7VGiUg==
X-Received: by 2002:a05:6602:164a:b0:82c:fdc2:e25a with SMTP id ca18e2360f4ac-83a64bfd806mr926954639f.0.1728943757278;
        Mon, 14 Oct 2024 15:09:17 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbec96340csm10151173.18.2024.10.14.15.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 15:09:16 -0700 (PDT)
Message-ID: <0cb46443-1f32-4fb2-90c4-6f9dc834601c@linuxfoundation.org>
Date: Mon, 14 Oct 2024 16:09:16 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests:timers: remove local CLOCKID defines
To: John Stultz <jstultz@google.com>
Cc: tglx@linutronix.de, sboyd@kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241011225236.27677-1-skhan@linuxfoundation.org>
 <CANDhNCo5q05xUgdXQaDfxUGbiKaV2mXmfttA-=oVrftBF0PERA@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CANDhNCo5q05xUgdXQaDfxUGbiKaV2mXmfttA-=oVrftBF0PERA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/11/24 18:49, John Stultz wrote:
> On Fri, Oct 11, 2024 at 3:52 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> timers tests defines CLOCKIDs locally. Remove all local CLOCKIDs except
>> CLOCK_HWSPECIFIC and use defines from time.h header file.
>>
>> CLOCK_HWSPECIFIC and CLOCK_SGI_CYCLE are the same and CLOCK_SGI_CYCLE
>> is deprecated,
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> Thanks for doing this cleanup!
> 
> Acked-by: John Stultz <jstultz@google.com>

Thank you. Applied to linux-kselftest next for Linux 6.13-rc1.

thanks,
-- Shuah

