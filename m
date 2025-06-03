Return-Path: <linux-kselftest+bounces-34190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFB9ACBE14
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 03:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B01BC7A7D29
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 01:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3992172627;
	Tue,  3 Jun 2025 01:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxW00P2m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A832A18E1F;
	Tue,  3 Jun 2025 01:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748913220; cv=none; b=CXyPaY6lF+mLQDxivWW+Ewc1FZ2MAUCLEu7MuqRF+ihBb6dFoMs05TYucZa9Z/j93ey2EOhc+30yYIv0GKo1IVYfpcXuMItgVQX4qZxDjkqtCtQwgFbUj6Dg67qA6n7aGH5+VmycQj6fBHjmb6F3Y8Md5XN71plQXzfrs98f1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748913220; c=relaxed/simple;
	bh=7gW/dRisZqbtC8go1YjHU5L3xN47zBsjlDB9d4iq/c0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnUvA/19glW4fc9V2ob9IhOPnO3hzKHvNlQnnnOLLEqVuO+7n9gIS6ch64Wcc01jhXvopMML9eZibBXLSFJRTsMgKhrecpfEDvsrcmNdoqEaDE/8JB/dZM8wDevMtxUCswSSptcATNS8ToXjg3wqbJTsJ8M7XAKB5edVUJhh5/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxW00P2m; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22e16234307so41650365ad.0;
        Mon, 02 Jun 2025 18:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748913218; x=1749518018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MLsnidusTvR2g2p7JxRCWvRNvNPCXXCDIPIAxQbtlsg=;
        b=NxW00P2m5t3DZKZmm/5YvueJlwh2ep3kaJFgiaNZ4E1NTQU9K5qQYHCyix95f5CXhP
         kkwXwJYYasdK+8S5YR4whETjnl7FRLckJrOImtcRye2u0kJcR/UrNV7iiskCQQytF65a
         C382FsXiXfZjHBW9Z1mv8+mD7xHgeWEsdDwQxM1j1dVb0kA8EXDDu/1UmyoTRiDPMnxN
         5D/cf2tuBqtDw4033h1sR5lyql3Xl+mfGXAtYy6U+uUFjtHL0B9RP2Fdewpix07BsdGH
         RMkn1OQGVT6TfoM/Vxe/DeM3nagX7Lbg9eG1ztB5jwdddNpCOalDHAJhXN1NK9DVhHZz
         WEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748913218; x=1749518018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MLsnidusTvR2g2p7JxRCWvRNvNPCXXCDIPIAxQbtlsg=;
        b=FIALOMfvH2RwWa3G43OfxHVaLACF67NwZ8pfvg5h5oQPN3CuQ6xZS2VMEztR/mHrO0
         9fqxJiF0ni/aqi6K8Ojnjy2Jne203yFX5ehaHenDy6kKFKq8XbmvCTJ1YnXSvyu8iyCV
         BWhjNRMze3PXy5WUjNiaSMjmYPK81gV3nHlJZtQljFKqutQmatUgMrDaMpZyFMEjjTY+
         zltyU6i8Nes0E6M8pYP2GRFf9xYByCucemtQqZy9MaYK5vIouxn3yRXeVUya93C7IhFq
         XgDzRo3Ftysb08l/dSF6pDSoLHMjM5q1bCOcdCpHqqicZ3GTdKMU/5YyqI3i1Hc7EvnT
         515A==
X-Forwarded-Encrypted: i=1; AJvYcCXAjaBWKrFXmJ0X9pVP0X8HODuheEdPP1Tv5D+VuHUToH5ccwfvzzs8i27KEiT/txWKdMt1vLhCTdEVD6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr3YhqWxjRkvccsvXfxtuJn/7EWef0u0pFsNhvt638T1d5LLyX
	HduLTKdkWH2QBhjK/tvvzSYnsU0i+Nxi1DGgRSt0DP/+pmmQOu4ltDUT
X-Gm-Gg: ASbGncv8OdtYV+nENQIt1yRbO/MEGMMRtTisNmNZ2E9qFxXozLr2OCZMVcHW3NE4V2T
	US6gUWYD0Y0nXS16Iqk7a/o58esQc36qqE+A3WcRmnJzsdZZHGvMicEtfP4oVDjI2YQir75dw0U
	FqgV5G5eAbpsIrNokXrLPLFFm6IJ4fhjgrRD61/HUvu+yKHnFo6Cb3SdsJrgiMX8ii1p7hQMGDq
	K/6QA/mowGSwLOMIGxS6dsgmwijL2awcRZm/GDJgCXQ8Lzjx0QcQ5NtLrTKnYpFvPNKQn9une/v
	CZNi2/JyKF8Mj7WkNXuHZ1wnj/sqe8nvjML+FWMhwa2nxPt6RlxcBpKjXxeeBYtpZuJfqPDYPvX
	fj7r60wCTk+TrJGhSrjVh6iY3yIGgUUek
X-Google-Smtp-Source: AGHT+IFQvZb3YCe5mONSwwMrv/moJQOEwSytvKy8rOoLUr+Yx17u6dqL4dCaKJzozptQM8fXjFvkqw==
X-Received: by 2002:a17:903:2611:b0:234:a05f:46df with SMTP id d9443c01a7336-235c9adf362mr7411335ad.7.1748913217538;
        Mon, 02 Jun 2025 18:13:37 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:a:8ca:52cd:33e8:b9b8? ([2620:10d:c090:500::4:6528])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e2c29b8sm6238975a91.13.2025.06.02.18.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 18:13:37 -0700 (PDT)
Message-ID: <11d3be92-a934-439e-be36-6d898b437681@gmail.com>
Date: Mon, 2 Jun 2025 18:13:33 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: Add version file to kselftest installation dir
To: Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250529003417.468478-1-1997cui@gmail.com>
 <4a28c302-b37e-4963-86c2-87c5793c2661@linuxfoundation.org>
Content-Language: en-US
From: Tianyi Cui <1997cui@gmail.com>
In-Reply-To: <4a28c302-b37e-4963-86c2-87c5793c2661@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/2/25 3:48 PM, Shuah Khan wrote:
> On 5/28/25 18:33, Tianyi Cui wrote:
>> As titled, adding version file to kselftest installation dir, so the user
>> of the tarball can know which kernel version the tarball belongs to.
>>
>> Signed-off-by: Tianyi Cui <1997cui@gmail.com>
>> ---
>>   tools/testing/selftests/Makefile | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/tools/testing/selftests/Makefile b/tools/testing/
>> selftests/Makefile
>> index a0a6ba47d600..246e9863b45b 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -291,6 +291,12 @@ ifdef INSTALL_PATH
>>           $(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET
>> COLLECTION=$$TARGET \
>>               -C $$TARGET emit_tests >> $(TEST_LIST); \
>>       done;
>> +    @if git describe HEAD > /dev/null 2>&1; then \
>> +        git describe HEAD > $(INSTALL_PATH)/VERSION; \
>> +        printf "Version saved to $(INSTALL_PATH)/VERSION\n"; \
>> +    else \
>> +        printf "Unable to get version from git describe\n"; \
>> +    fi
>>   else
>>       $(error Error: set INSTALL_PATH to use install)
>>   endif
> 
> Why not use "make kernelrelease" to get the version?

Thank you for your attention for my first patch! There are mainly two
reasons:

 1. We'd like to have the `VERSION` file written to to the tarball. This
is because driver hardware tests needs to be run on specific hardware so
that tarball is copied onto the DUT and we can compare the running
kernel version and the test version.`make kernelrelease` only print it
on screen, so we still need a way to store it into the tarball.

 2. `make kernelrelease` requires the kernel repo to be configured and
prepared, while `make -C tools/testing/selftests` can run standalone. As
a result, I don't want above to depend on `make kernelrelease`, which
may break compatibility of people's existing CI systems.

> thanks,
> -- Shuah


