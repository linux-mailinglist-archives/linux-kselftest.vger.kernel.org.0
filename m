Return-Path: <linux-kselftest+bounces-31616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FCCA9BB5D
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 01:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D00C4668CB
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 23:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9A828DF14;
	Thu, 24 Apr 2025 23:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VJQg784L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F1928D850
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 23:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745537645; cv=none; b=QMHmCTrqf/7tAXcsmeibWEK4McUomsFdqo96zHp0aKTdHl+9RAcEFuBFEdbHsrNKaXvEXOq6w4SkNvRkXPobYCRiNToqanjzP+/qJZu7RWgbsWNwWOWuz1fChW3Is9CVHPg8HJ1Oh+m4kaaPQELEJ4gPnhbQ+at/VCn6atjwsLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745537645; c=relaxed/simple;
	bh=645Cr+11HOu7caSwajQ+fcQB6zjlFuO0uiN9ygi8GPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBkdBtzNMF2Xs7AYtWwWqHDgK4oP9WYnWbDsZDxkBeS5MmgKnnUP9XFt2VipB1ARoOlechu1/nBqjuaCT4Z6MQoVWHRI0lx+/YkosI+nUmFyW+fzw6WxZ9UOgDh6GrbESaHoiy3FfBsFS7WxrQLGK1608Y0myav0w2f3sWWvRxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VJQg784L; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d91db4f0c3so8065655ab.3
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 16:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745537642; x=1746142442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WLSPdguY12OklzlGtECMN7dzaPzmkE8I+rLCggfy6Pw=;
        b=VJQg784LwPvzSfk4RcvtWjEXtz7PsyfeuKnNwEFjAANomevFvAip50wjfwzwV4T5BT
         EY9Escy0m/vi6R+qtvJVLStwzNTyJwcGd3jsXJAnooA0ajSlxBJBPjYlmutbKdDKpVrs
         91Cci7pTUpqo62C2lHvEU14tflDqRycAun4ic3e1AqU26Gl9IikGISAdfWO3yqDGh8EU
         EFYQESwQhK1hmQ5zprujmS3iAWF97U1ap2JZ+JBfo2TKoB6U28O6jFMCbPUMfjqOYwjv
         16cpU1MFsGNR1ZPelJjXaSBK/ueMS8wK9yJBOwoY4thCC/d57KWV+kIfyqT7Gq5GaIGD
         GCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745537642; x=1746142442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WLSPdguY12OklzlGtECMN7dzaPzmkE8I+rLCggfy6Pw=;
        b=smGMhdHhVTTfAE4NdNCzF3LTgAEqHLncj9Eqpjn+4SydHb/ibWu60utzvxH80+vk7h
         MvLqSk063Sr0RL/hL8sSSgok5EtXn59HPMfDQPPeB4I1W9fvJ+6J86dT7sO6tCJIYKyb
         uJv6QS2O5aETulG+AABfFUfr2R3TgiU1M7+5cX/mV+XS2If1S44QwO7pWuP3kef6VVSt
         EEhdeYcXzNe0rO6b/qAODycyT4Gt5eFMjnF0THB4/JHjsx/ID6taQVYQb8+lxGLOzcRD
         9tk9uhzNM5sySvXH0YpCY7mdTTkgMTXCWoYShJHvJZT/XMgy9OifAYQHRMRk1wajD4Sa
         eBaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTeOWnpqghUjGuUmNMwYn9oOG5fhv3Z43hC7hE/UPcwKB7cB2OSA6STSPCpmNNpikHboonaIcPzvqUwVed4WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YznBTdrH2Sr0e+JzkoCp+DjfrwgOdvv2+SbcBUrR6rdA5ZnNAxk
	iZVZROGU+hj5ODTYVpi7iOgJYboI/ik6cJP2/XKoSa9UAijWa8kXh6lgOZixz7k=
X-Gm-Gg: ASbGncuaTIRXWZL5v789Y+Wdv7xtr1q+CynuaNVW69kZYV+tAZRM00csHL39IN45sh+
	XaioffXvrxbNWRabH4yw0ShK2XgzL5FRrhPPpxpuc1DAUilGjYcj71xXqALbNSvbLwW0j81XSTm
	Lv2jtsmSioht2aPQ5BjNPMw7hcQr3Rb32mhNMuEdFyYQgZqMP7C1q+PzxXxoLBiWaYrpzH65s61
	Lh0zc+9rETgYRro742XnIUaEqD8/XB/lFhUEexan4GwDZJnyzEUNGHsqW+DKYWDQnDECVLvkdTT
	1habGgsiqBJyYVrLWLzolJktzgu6Smm+okkdfQ==
X-Google-Smtp-Source: AGHT+IHaXi2Gk8r4y/6xRxbhajXXa7YziQlK1Lp6d2KP4QYQkmwMHqQavhWqFld8XuKb8/iluMFHUQ==
X-Received: by 2002:a05:6e02:b24:b0:3d8:1a41:69a9 with SMTP id e9e14a558f8ab-3d93b453d9cmr2642865ab.12.1745537641971;
        Thu, 24 Apr 2025 16:34:01 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f824a3ba4fsm495331173.38.2025.04.24.16.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 16:34:01 -0700 (PDT)
Message-ID: <46deb974-5e60-477e-8f0c-9eb358369d73@kernel.dk>
Date: Thu, 24 Apr 2025 17:34:00 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests: iou-zcrx: Get the page size at runtime
To: Jakub Kicinski <kuba@kernel.org>
Cc: io-uring@vger.kernel.org, Haiyue Wang <haiyuewa@163.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250419141044.10304-1-haiyuewa@163.com>
 <174553616879.1018402.4580438030053211278.b4-ty@kernel.dk>
 <20250424162923.3a0bdfc4@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250424162923.3a0bdfc4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/25 5:29 PM, Jakub Kicinski wrote:
> On Thu, 24 Apr 2025 17:09:28 -0600 Jens Axboe wrote:
>> On Sat, 19 Apr 2025 22:10:15 +0800, Haiyue Wang wrote:
>>> Use the API `sysconf()` to query page size at runtime, instead of using
>>> hard code number 4096.
>>>
>>> And use `posix_memalign` to allocate the page size aligned momory.
>>>
>>>   
>>
>> Applied, thanks!
>>
>> [1/1] selftests: iou-zcrx: Get the page size at runtime
>>       commit: 6f4cc653bf408ad0cc203c6ab3088b11f5da11df
> 
> Why are you applying this, Jens?

Nobody else had picked it up so far, and I already did the equivalent
one on the liburing side.
> 
> tools/testing/selftests/drivers/net/hw/iou-zcrx.c
>                         ^^^^^^^^^^^
> 
> This is a test which runs in netdev infra, and which we asked for.
> It was incorrectly initially routed via io-uring trees and then
> we had to deal with the breakage during the merge window because
> net/lib has diverged.

Come on, it was a one line conflict due to another added test, the
simplest of all conflicts. If that's "breakage" worth mentioning,
well...

> Please revert.

Sure, I can drop it. Doesn't matter to me, as long as gets merged.

-- 
Jens Axboe

