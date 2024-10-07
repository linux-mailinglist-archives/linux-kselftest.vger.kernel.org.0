Return-Path: <linux-kselftest+bounces-19182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A53993896
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 22:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93F4285000
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 20:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F5C18B49C;
	Mon,  7 Oct 2024 20:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cul49IPV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD47F81727
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Oct 2024 20:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728334420; cv=none; b=ORFyooJQ4C5I9sJMehypiD0UH3YQ5HeuqReqWmet8V4tYZOq1HRZELeaNU8lARaFxfiGHomZGyEriaAgxtXklwbhilqHBOoyRBCw36XI/ulH6KzvCZKIBPMrI9fgBC8uUV9q7zsKyT1JGlftGnPipwxOkHBKj8xW/+dHZpm0h/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728334420; c=relaxed/simple;
	bh=ci/dn4u4g3R5TTJs/FuTbwCsvXXau4D4vDibzSJlm0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=j/SJ9/ibVG8VJL2MxyVRp2xxg+UB/RA/lOUIfG8zzLAzPee/5GXmNPxjnUsfp+snYmdM6RAAfxCdmb/220Yj/w/V6ZJnKuBMNV4iZ2XuRoAdRjsyGY3Q6Kz7jPiJouCW6/di7gxRacVlFjPXMsz9FfqdnkIiu/t2OkBfWxSTCS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cul49IPV; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a363706905so14492675ab.3
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Oct 2024 13:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728334418; x=1728939218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WR1XeCCURwYupV6wfUt8ns3TQ4z1Qf5Dp2tCaM+ohog=;
        b=Cul49IPV2Ue/1UJYoKKxH1we0B6WQIvaL0x/x2NQqlytH5s/Rev2UZkkrlbGXW4Rgp
         J/qeYzt5ujV/+mCvPLvyEh8sRM4B3GR9jP5P7EnKcPR3lvX3rEtNF/xkBJxi4VunvqTy
         tdi5MwHB+EuCaveyi1IbCUU7SaGdrlVy3wy80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728334418; x=1728939218;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WR1XeCCURwYupV6wfUt8ns3TQ4z1Qf5Dp2tCaM+ohog=;
        b=xCK7WufNW4IyJvXpy3TsPR79nKUch6AxE3X8x10jCYACffbYTRvif4GYKmuhpR/aG3
         larJcl0+P1FQGHQv8ZOdY7okEX9NTWe+GF37yVJG++UZ00ZGEBPd/RvCuBzY2htDRKkM
         PQCJ69VemVtiEecbM3gNQ7tD8CJ534NPEtftcgo7wfvuKJMKHLwTecfk0JOPUmeiVdDO
         LZyVpvNaMF3xO/39m51aJ3K6goi2kHackghTGazkTzg/c0XDGR39+S8WEnkiyDbYHKR0
         UMD3Ggcz7oSzUKQ6cikellsVmxZoLyOVznwqQMs9nEWntsnnbYTDXiwLNlfPMXeG3krk
         2zRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv+7W46XTq0PpX9nKyOA7MpraTa3Kjx8xWDv5yRQEOH12p2QtfJdXYExYcOd9YFz8vCBjCE0B1fYSsMOkXsqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGEE7BS18IZU5sqaJY8+V0lojYUocXX8aTcyqld2ChVzIrPXQN
	Qdht8cUb4+9Vp3HM86ZJMIjIcMJ6XNWahat1asMxE56mxZtB6jV4w2UvOiFStbDJS761oSFB4Xy
	N
X-Google-Smtp-Source: AGHT+IEdyqcUrftetg5QeCh1UGoKHvAVT+tBrwi/WV5g1/VJ0qNJPhoPyENXMaUz+15YwRda92XyNA==
X-Received: by 2002:a05:6e02:1c8a:b0:39d:1ca5:3904 with SMTP id e9e14a558f8ab-3a375b9fb25mr100067315ab.14.1728334417811;
        Mon, 07 Oct 2024 13:53:37 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db6eb56904sm1316487173.66.2024.10.07.13.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 13:53:37 -0700 (PDT)
Message-ID: <6d8c0894-f3c4-42ff-9794-03d675142a7c@linuxfoundation.org>
Date: Mon, 7 Oct 2024 14:53:36 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kselftest v2 4/4] selftests: vDSO: unconditionally build
 chacha test
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kselftest@vger.kernel.org
References: <CAHmME9qEp8Emg88wWR_oOT39hSaooLDd2L5YPetFrH3O-CgkBQ@mail.gmail.com>
 <20241006044017.2417623-1-Jason@zx2c4.com>
 <20241006044017.2417623-4-Jason@zx2c4.com>
Content-Language: en-US
Cc: Shuah Khan <skhan@linuxfoundation.org>, greg@kroah.com
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241006044017.2417623-4-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/24 22:40, Jason A. Donenfeld wrote:
> Rather than using symlinks to find the vgetrandom-chacha.S file for each
> arch, store this in a file that uses the compiler to determine
> architecture, and then make use of weak symbols to skip the test on
> architectures that don't provide the code.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>   tools/arch/arm64/vdso                            |  1 -
>   tools/arch/loongarch/vdso                        |  1 -
>   tools/arch/powerpc/vdso                          |  1 -
>   tools/arch/s390/vdso                             |  1 -
>   tools/arch/x86/vdso                              |  1 -
>   tools/testing/selftests/vDSO/Makefile            |  6 +-----
>   tools/testing/selftests/vDSO/vdso_test_chacha.c  |  6 ++++++
>   .../selftests/vDSO/vgetrandom-chacha-finder.S    | 16 ++++++++++++++++
>   8 files changed, 23 insertions(+), 10 deletions(-)
>   delete mode 120000 tools/arch/arm64/vdso
>   delete mode 120000 tools/arch/loongarch/vdso
>   delete mode 120000 tools/arch/powerpc/vdso
>   delete mode 120000 tools/arch/s390/vdso
>   delete mode 120000 tools/arch/x86/vdso
>   create mode 100644 tools/testing/selftests/vDSO/vgetrandom-chacha-finder.S

Jason,

I am seeing a few checkpatch warnings on this patch. They are
worth looking at.

WARNING: Prefer __weak over __attribute__((weak))
#176: FILE: tools/testing/selftests/vDSO/vdso_test_chacha.c:81:
+__attribute__((weak))

WARNING: Improper SPDX comment style for 'tools/testing/selftests/vDSO/vgetrandom-chacha-finder.S', please use '/*' instead
#191: FILE: tools/testing/selftests/vDSO/vgetrandom-chacha-finder.S:1:
+// SPDX-License-Identifier: GPL-2.0

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#191: FILE: tools/testing/selftests/vDSO/vgetrandom-chacha-finder.S:1:
+// SPDX-License-Identifier: GPL-2.0


thanks,
-- Shuah

