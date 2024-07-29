Return-Path: <linux-kselftest+bounces-14393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BF593FE38
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 21:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8BBF1C21B46
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 19:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9685E187336;
	Mon, 29 Jul 2024 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CvaUuqao"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146B018732C
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Jul 2024 19:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722281232; cv=none; b=Db6e2nCp5WhTdEnJ0h26/wuOtid/qnptjCchiIeOjabvttn55ibwaZ0LhZrp5vdlxoH04UEWCCHLKyEltA68faq9ZWUmvdMX6EOCLr2tsYdt/aMcvvOluPnRqQj/Gi3KggNf5B7MdEBB4kXaLRXYOHNRuaHdOdPveawC0JKeB7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722281232; c=relaxed/simple;
	bh=KPAl0JCyGgkO27w8Km3wJa2M5W0ST6/UnzvgrZeKc4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hQM5uecY/FQ8/bVieQag4yCyH0UreufmkmrvwuBcOxSBdLmqiauS0p2d0EXoGxWaYSw4YI3+y68mfwTeejJfokoNJYVHhMI9UPxrPs3FM4ItTCri2DRNkioUV6Xm2HAn228S42aXuWR6Ki4g1t2+Tu/a7/lW+PEvYB5dMwQ7+1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CvaUuqao; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-81f902e94e6so15994039f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Jul 2024 12:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722281230; x=1722886030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5cW8vdpmHZjx4o0iwoSWJOQySAtf51wBr3QE0Onm+KQ=;
        b=CvaUuqaoxvv3nNLioYdZQDv4ION/+4NRb1CIt0jamvo3hqqrRDpoR6h/s4ZhbPPxWZ
         kA9hp4k8ygjVVXqwg9JIZVCl32pWykBOwpnx3n3bpLi/aQ9ezF5FkIsTVrY2VuBSFYgR
         7XJ8ZknuOAsRS6yd5dKfkH+bfO3JRSbCAmGIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722281230; x=1722886030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5cW8vdpmHZjx4o0iwoSWJOQySAtf51wBr3QE0Onm+KQ=;
        b=xOevPy+/Fes3A8fg9djETBy2RE0/fjQR8TMD4EJnL9mtt5lmmbMsJul62Dd+8jWTpq
         uTnFySNsOsi9X8eHm11gvHCDk4xgJGfnZe17iu2l20VXvjVWfjbF0EtLGkVMIiF8oUwO
         T23PVwVNUU5G3D4nPoVf5D57E6WbpW41WzyOdFfTD1opK7uWNQ1ML8RwZEK6YzIKQjhP
         BKYcIRb8fdjYJonga82V96KCu+piHDBUf1L7qiQVvO8Iie15W7RRpzdvBlhHnp2H905h
         Z7VThHmvzv0RJm5ZPzbW0D4sV3sQ1mvZQjyko2NRaiQS7YHCJWpbB+iDSN20XfNNmLag
         s77w==
X-Forwarded-Encrypted: i=1; AJvYcCVJvarjbsmQGhoGYuhnIU0+T9W0GVG4Hc/7PVeNwsCH53c0Y4qc6z5W4xKr8loce3b3sZ8/KiRdmDabEVhI8KZl9J+iMF9Ru2BcWr2JFATn
X-Gm-Message-State: AOJu0YwjbU2pS2Yz6VbAZVS8/NtLfU2mXkpV+K6SHw4hd0ZulxwjiHbJ
	02TtFQGUmw11GuwDjLKirDIFfKCB1Ww+aqK7ZkghKyCIir6ykQj2Ib7rZe88Uxo=
X-Google-Smtp-Source: AGHT+IHUZkdFsVsNGpZDf2aO8T0ZaQZI+ZlmK97a9tJrrCNC6Ki8EhoG0g0kiTt63koA21WlEGn5OQ==
X-Received: by 2002:a05:6e02:1a09:b0:39a:f26b:3557 with SMTP id e9e14a558f8ab-39af26b37cemr28705455ab.5.1722281230233;
        Mon, 29 Jul 2024 12:27:10 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39a22f13f81sm41185415ab.70.2024.07.29.12.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 12:27:09 -0700 (PDT)
Message-ID: <abc8b199-694c-42b8-a2cf-7d34f45f51de@linuxfoundation.org>
Date: Mon, 29 Jul 2024 13:27:09 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] tools/nolibc: improve LLVM/clang support
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
 <120ddb22-34c4-4d18-8238-306485680c5a@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <120ddb22-34c4-4d18-8238-306485680c5a@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/29/24 13:26, Shuah Khan wrote:
> On 7/28/24 04:09, Thomas Weißschuh wrote:
>> The current support for LLVM and clang in nolibc and its testsuite is
>> very limited.
>>
>> * Various architectures plain do not compile
>> * The user *has* to specify "-Os" otherwise the program crashes
>> * Cross-compilation of the tests does not work
>> * Using clang is not wired up in run-tests.sh
>>
>> This series extends this support.
>>
>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>> ---
>> Thomas Weißschuh (12):
>>        tools/nolibc: use clang-compatible asm syntax in arch-arm.h
>>        tools/nolibc: limit powerpc stack-protector workaround to GCC
>>        tools/nolibc: move entrypoint specifics to compiler.h
>>        tools/nolibc: use attribute((naked)) if available
>>        selftests/nolibc: report failure if no testcase passed
>>        selftests/nolibc: avoid passing NULL to printf("%s")
>>        selftests/nolibc: determine $(srctree) first
>>        selftests/nolibc: setup objtree without Makefile.include
>>        selftests/nolibc: add support for LLVM= parameter
>>        selftests/nolibc: add cc-option compatible with clang cross builds
>>        selftests/nolibc: run-tests.sh: avoid overwriting CFLAGS_EXTRA
>>        selftests/nolibc: run-tests.sh: allow building through LLVM
>>
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

For the selftest changes.

thanks,
-- Shuah

