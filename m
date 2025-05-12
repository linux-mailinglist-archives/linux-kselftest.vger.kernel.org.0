Return-Path: <linux-kselftest+bounces-32878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A676EAB4684
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 23:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2EB463D83
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 21:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C6529ACF9;
	Mon, 12 May 2025 21:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QMSMi6OV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AFE29B224
	for <linux-kselftest@vger.kernel.org>; Mon, 12 May 2025 21:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747085565; cv=none; b=HJpGKiS3B0zTBeCJBOagBVuuaQUIfXdlux3ev4wD/zO+9I7W5cIPLY9iaO9Nun/MNmgoxZAh5irTVsGNAeHYcPAog3bGbjtHHhUsRNgngP/E2Hl09Kjz5wkq0+lvhXmO1eQwGpV8SdiRuvDozG2c6diyFA8yWkYxsCcp0Fwi5e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747085565; c=relaxed/simple;
	bh=f2MCs4lM3l4FrlvQEABriuyhhX5RlGGLRAtIDhd82lY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gCuZZKJxq4VPdC+TztF4bSEW1HL9WCkvp8tqR9mrdUj97ZDZC9LuJSlD6f+FsNL4RDd1Ojlg0IZOZp3cYWwkFzmxJOimHDNClcmPBfFzo3S7RHrlT14vdq0a+9gXa+cHet9Z9tH7/blYnBE76H0oJSbPK+qL9sF9q0ZYtZ6C0dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QMSMi6OV; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-85b41281b50so151489539f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 12 May 2025 14:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747085562; x=1747690362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aVC8CIn+kAUJC5QRXx6Je5lGhZlJWHJlDC4Z0lsVmlk=;
        b=QMSMi6OVn9ARSr1nASQvdrzUNOqd4paa0IYSoqzEBBNDWjFaqMkYmUtzAMVSCpBCq9
         rFZzefecxsgovMxhsXpozyE2z1KUtwslwwFX4slOvbKNbAZOeT78qXZ4yllObnb6D15d
         IYnDImt8w3tuPbLuu5sFp0+E3cQfZQEPMjlrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747085562; x=1747690362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aVC8CIn+kAUJC5QRXx6Je5lGhZlJWHJlDC4Z0lsVmlk=;
        b=kFvejwzwUnODUkaw8clGrQojPuOmGyemedFWkU9PC0UXUxJ8A2/W+fCyVUym1EJuZ3
         s1m0dmdq1+U5T5xfXiiUSprHU8wha0TpeZKTWFe276wRa3IKcnjXZsSScHHbnUkc/LMb
         G1SW1pbn+W8VhdiW364gzjuSeAFK0vEgPvYtAAmlgjx7ApwqwKHBenowLboPSk/HZhqb
         3yMqF6HxRpB7AUDoTmI+VkrOnqqNywkTFbvjkwozPMCUh4OFfPRmbPb5YWcLK0wYYvp4
         loJjBUUzb8NzgZkHXqA5/xVv1igZhkh6JXaUrLpocjZPZiRhzIXBzRKOiQWin3VUaAKu
         DePw==
X-Forwarded-Encrypted: i=1; AJvYcCVzEMKyPr8m/OQoIZa6CL/5zKLdlfqkKG4vJuiAM/GWM9PWpaDXRuAd9XobwhycTUnEqQFJJTevZ3t7VjP2+P8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyesvr39kFOwi4tq0m2pFsHFnlcPfGoVIDgzb143c5Fviuygnrg
	67gaVo2kcYnku/m1iRZGvpY4zUwLSUlzXakDPb6is0HoR5Y86SQOScfp8D9x4ak=
X-Gm-Gg: ASbGncvXVUEj1BXPhHlsKmyOqeD2+mvpDe+OCPjr1/W/s75nwvIkwjMq57fBRI4AY9p
	oS56piS9gdfa5TILdfr5j+dcZS9niPKODPVp2x9ERZR/YgFkLjgIo3J39ycGs0e5k7Ddg85S/BV
	C+zYaSNepPv6bmuZb8aIvbP55sw6+Sxz0u+RTbcgH0SVulkEN05Wh3rJwNUPk9BtHHXr5DCua5l
	B36UV5XDWKCbEidhIAVH8+BLKu9U/H/U4nKk5X2tfPAC5jv+xIU4KhUMTvHNmQ5fGDpI11HUBxd
	CIy1UHt89GhRL3g3u5DHYNoc6RXE+hUOQxMk7WfFVbZwphKmQ/LTXcffOn1OkQ==
X-Google-Smtp-Source: AGHT+IFUmfEbqs2iqJ2yUBrpmIaYJEyYGMrVR1JpfUOwjb3bm//xzfZQbCP9wt/2h1O8OE8V+0AWaQ==
X-Received: by 2002:a05:6602:13c4:b0:85b:4ad1:70e with SMTP id ca18e2360f4ac-86763575d30mr1787891339f.6.1747085562361;
        Mon, 12 May 2025 14:32:42 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fa2ec25bccsm1521170173.90.2025.05.12.14.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 14:32:41 -0700 (PDT)
Message-ID: <a699b6d0-f028-43d1-93c9-250b6c8c4a6b@linuxfoundation.org>
Date: Mon, 12 May 2025 15:32:40 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] kselftest harness and nolibc compatibility
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Willy Tarreau <w@1wt.eu>, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>, Mark Brown <broonie@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250505-nolibc-kselftest-harness-v4-0-ee4dd5257135@linutronix.de>
 <d8d36e51-9456-49a3-88c4-44cffdcc5c0a@t-8ch.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <d8d36e51-9456-49a3-88c4-44cffdcc5c0a@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/10/25 00:54, Thomas Weißschuh wrote:
> Hi Shuah and Kees,
> 
> On 2025-05-05 17:15:18+0200, Thomas Weißschuh wrote:
>> Nolibc is useful for selftests as the test programs can be very small,
>> and compiled with just a kernel crosscompiler, without userspace support.
>> Currently nolibc is only usable with kselftest.h, not the more
>> convenient to use kselftest_harness.h
>> This series provides this compatibility by removing the usage of problematic
>> libc features from the harness.
> 
> I'd like to get this series into the next merge window.
> For that I'd like to expose it to linux-next through the nolibc tree.
> If you don't have the time for a review or issues crop up, I will drop
> the patches again.
> 
> Are you fine with that?

Didn't I respond to v13 saying you can include in your nolibc PR?
If I didn't here is my Reviewed-by.

> 
> The issues reported by Mark have been fixed and tests have been written
> for them.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

