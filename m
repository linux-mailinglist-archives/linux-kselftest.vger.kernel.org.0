Return-Path: <linux-kselftest+bounces-14873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0AF94951A
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 18:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227B31C23608
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 16:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6393A267;
	Tue,  6 Aug 2024 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VFOJCTf+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5130238F91
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Aug 2024 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960039; cv=none; b=i38hlAyFDCf/SqPXI1+iRmlF0ZBXryPosVeVVsY9QAd2YF1Y+nBWZCuUglHxiOcGeLCqokDfBkU2s7Xh0FqK3PxPEp5xBx/zFNvLw79YV05PmOxV9Gphzix1JPHP75J1haHLHlgoWyBmCYcbRw42L+NVBwLTj0XGCa5L3Tb0ihI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960039; c=relaxed/simple;
	bh=G2dFHbwQlABEbn7C/wHN9BFrhR5+2PlXMiREOnZ8MQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKI2IG76sDXoYsnPJrerEsn4PF/P5VTz+nKH0WvAoSTWaU1EHinaPQCZ1VYb1By6RpCmn/FtauLecA83AlL1qZrRvpH01DznWHE/b/GtJwNly5SGsqlpwO65VlcKbyV0NwP8I5m64r0Cow8gwekUzrWKm8koIoLhiD9/RIEW3c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VFOJCTf+; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-26456710cfdso170552fac.0
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Aug 2024 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722960036; x=1723564836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=utkiIdj88F+G+vP4WL7Umx3nVwa48ZRhAzXQxTEoHOE=;
        b=VFOJCTf+mMXWRUO8LnuRgJQsQucOlijtux8CmADQ/7FiSA1BCOhDgHszV1w4Cpp2wB
         cBOJQchPQWSj87YwfqsbAzURgmeNzS59l4UcD2T+nqS7fMBVVKoMVVzC1FRf1KI1zmvr
         8maHH6OKgxm/5jAEbsjUxyHqEM7Vf3/DfI2YE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722960036; x=1723564836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=utkiIdj88F+G+vP4WL7Umx3nVwa48ZRhAzXQxTEoHOE=;
        b=VwDgBAcyUfR8nC925JwUChfj6yNZMbPuMbN5e64bkPtoTCMr7y75+QJgPYpJCc7fxV
         idYwIKvfSQivE0qjJBWvyCiLTtiHh4LcA0BgbNsfKR0KBFV4s6o7bUUFjEPI3DamH73x
         Ax1BlP1e0EYazOjmyYRqj7EsVikzsQUb4Ep5hPcjHA6mNx64Mnevxs64ELUbT6b1gHeu
         WljSfuEyCBwLWWB05/CkiEh8geAsnznOxUv8fcw16FeUS+J3Bdis1VqD3Y4wTVIehP3L
         dTziegV5FpRL2M2W89pXPD+Rvnhb6IkZGg3HKJn5SQKTRfHoZRRykESz7UmfT1A7Zl/3
         2jIg==
X-Forwarded-Encrypted: i=1; AJvYcCVa8kp8JuLiZzMvtly+YBmtvp1dlQNbAq0RXcv01wxlb13A3fGFP/u5Y3x2tx0eOFUcozhVbEl28b+nFiXCa5odU5LitG3MP0EQVPboUA7K
X-Gm-Message-State: AOJu0YyX3U6kikuuave1nJCU64k0twQbNvHoO6HiBiRQIeKnLR3WbH8C
	OYTO9otzIsF9sqhZrJbr3EgXJdUMAt8oiT6yY4xZ9Mr1xDtZTceBtQyNHMner24=
X-Google-Smtp-Source: AGHT+IGrBYXn93GiNjPAMz6Efo4Ui0+eYh9UkvImYpLmBkriv1OTC2hCb+Yboc/erVeCc1w6GJHdjw==
X-Received: by 2002:a05:6871:4d17:b0:268:97cb:f367 with SMTP id 586e51a60fabf-26897cbfc9amr6125173fac.2.1722960036286;
        Tue, 06 Aug 2024 09:00:36 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2689a629a83sm3286314fac.45.2024.08.06.09.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 09:00:35 -0700 (PDT)
Message-ID: <6a3b2f3c-b733-4f64-a550-2f7dcbaf7cb7@linuxfoundation.org>
Date: Tue, 6 Aug 2024 10:00:33 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: kvm: fix mkdir error when building for
 non-supported arch
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240806121029.1199794-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240806121029.1199794-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/24 06:10, Muhammad Usama Anjum wrote:
> The mkdir generates an error when kvm suite is build for non-supported

built
unsupported

> architecture such as arm. Fix it by ignoring the error from mkdir.
> 
> mkdir: missing operand
> Try 'mkdir --help' for more information.

Simply suppressing the message isn't a good fix. Can you investigate
a bit more on why mkdir is failing and the architectures it is failing
on?

This change simply suppresses the error message and continues - Should
this error end the build process or not run mkdir to begin with by
checking why $(sort $(dir $(TEST_GEN_PROGS)))) results in an empty
string?

> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   tools/testing/selftests/kvm/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 48d32c5aa3eb7..8ff46a0a8d1cd 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -317,7 +317,7 @@ $(LIBKVM_S_OBJ): $(OUTPUT)/%.o: %.S $(GEN_HDRS)
>   $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
>   	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -ffreestanding $< -o $@
>   
> -$(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
> +$(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))) > /dev/null 2>&1)
>   $(SPLIT_TEST_GEN_OBJ): $(GEN_HDRS)
>   $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
>   $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)


thanks,
-- Shuah

