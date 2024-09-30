Return-Path: <linux-kselftest+bounces-18690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 550CD98AEC4
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 22:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0588F1F2413B
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 20:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2831A2541;
	Mon, 30 Sep 2024 20:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="To4/C4W9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF6917BB38
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 20:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727729851; cv=none; b=nqv1La4MYFP/jFc/x08SDAxnXWAel+UWhZIDkBGEMzBGESpn5oIoqRlZq3ARVckdlTkc0sPagUA0xKJGmHM8K8nx8cb1qo7Slm55WXuQa+ms1TdAu9GXakTLoqKjaPlSlwn0qZ90VWqrYoi2NrnnaunXq4K36ZMf9tiWYs+PF0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727729851; c=relaxed/simple;
	bh=DSHUum/B8b3jGdeFXxORM8MingRk2dWycd/+sDgEp48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZ728x3K5ldfZv7F3N+T0Amfj+l89sgLgFAtTwiB/ZGejEN/kYD72T44v9Z8Tum4/oegV8nIc1NOTimuPA4syFQ80mbWpUT/pZgXzrjI+8frD3bVvx9n9kQMn3qY5Ut0SR5NqGFn0vXNlw4YuF0Xk55U0ivKm57WSfnP7DIZOTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=To4/C4W9; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82ce603d8daso165705939f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 13:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727729848; x=1728334648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AW12f3fV0hnyKGmmmTzPeXu+IfjPN42/qOVSHOfH93Y=;
        b=To4/C4W9F5fCVeeE8Jzy/DgGTkxNOscGYGXrwH753pNJZt5EZtj2treow+A1wb5HYv
         QOGkjMKa1sIbpXV4jUs+E9nTAMX5OIbIt/9bCEmZa/O94rNY0jC1RXG6ekQ+lHKbopfl
         MOK3sLFmJMUJf8GeT0CIYo1WyH5ZYsyBqQthI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727729848; x=1728334648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AW12f3fV0hnyKGmmmTzPeXu+IfjPN42/qOVSHOfH93Y=;
        b=pYTCxihPOgwsBoUn0fI1+SgFKL2q0s7iV2Q2BmHlh3IY/KLgMn1sfdCYH+wGjIgwet
         4rs61RVzXNEPBp3XFWXeW6Sc2dlid6ppnKeHXpPAqD9QOnQ/hiyjw1xxCwclWCHkR0Ka
         kOzKrD5uHGQbUDyXsQb8jH9ikkwkFHMsH6w1OKy1N7PNMIvG0vFAyfIof55jA14Us0ds
         nVTlrcqEIh930tRFAunnttSEc4V0Ia+aYonbBEIEWqw5Zl2dvN6DEEWqqju9u1SK6GuN
         qSx+qlTOfR70rjP/b5Q+Qd93Ga707rS2Jivy+PNUWGiCKDXNjpCux/8iWql06gLZ5ljc
         Nr2g==
X-Forwarded-Encrypted: i=1; AJvYcCWrX9SPew3NCeNoBpNIlLCjiNxqwf8/Zo8bUrD/BWgAZByx2OdfhQFPIu3BUegBVYoddoPCuKaI1wRTC10GFSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVJ3w71EG3z7gMyz8eMOdIppOJMp7sifpdWfR3CBYCV9r46cGD
	dIKywZhhva31ovF6CT0y6h7qAWmb+NY814dmzYQonvAEtW5YoF36rlCCwzw5FFFY+WzfdGkG+Yi
	z
X-Google-Smtp-Source: AGHT+IH6+aml0RNiH7eTsWsGVqK93eOEN3UEu1k2nN3+MRDt4bFti+AQepgmBbNSpbK5JtsjZIb4sA==
X-Received: by 2002:a92:ca0c:0:b0:3a2:aed1:12a6 with SMTP id e9e14a558f8ab-3a345166cd6mr105578745ab.6.1727729847981;
        Mon, 30 Sep 2024 13:57:27 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a344df41a8sm26488915ab.88.2024.09.30.13.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 13:57:27 -0700 (PDT)
Message-ID: <7910784d-18c2-4e72-9dd8-6b8bd1b9dd0b@linuxfoundation.org>
Date: Mon, 30 Sep 2024 14:57:26 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: hid: add missing run-hid-tools-tests.sh
To: Benjamin Tissoires <bentiss@kernel.org>, Yun Lu <luyun@kylinos.cn>
Cc: jikos@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240929085549.3528293-1-luyun@kylinos.cn>
 <mimf5cv52q747fwhafr7pv6lgxyyt3rauz373e7hoinpqycmha@2oncke2rw2sc>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <mimf5cv52q747fwhafr7pv6lgxyyt3rauz373e7hoinpqycmha@2oncke2rw2sc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/24 02:38, Benjamin Tissoires wrote:
> On Sep 29 2024, Yun Lu wrote:
>> The HID test cases actually run tests using the run-hid-tools-tests.sh
>> script. However, if installed with "make install", the run-hid-tools-tests.sh
>> script will not be copied over, resulting in the following error message.
>>
>>    make -C tools/testing/selftests/ TARGETS=hid install \
>>    	  INSTALL_PATH=$KSFT_INSTALL_PATH
>>
>>    cd $KSFT_INSTALL_PATH
>>    ./run_kselftest.sh -c hid
>>
>> selftests: hid: hid-core.sh
>> bash: ./run-hid-tools-tests.sh: No such file or directory
>>
>> So add the run-hid-tools-tests.sh script to the TEST_FILES in the Makefile.
>>
> 
> I assume we probably also want:
> 
> Cc: stable@vger.kernel.org
> 
>> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> 
> Not sure about the timing regarding our next PR to Linus, so in any cases:
> 
> Acked-by: Benjamin Tissoires <bentiss@kernel.org>

Thank you. This commit appears to be right one for Fixes tag?

Is this the right commit for Fixes tag:

Fixes: commit ffb85d5c9e80 ("selftests: hid: import hid-tools hid-core tests")

Will apply with this tag added to linux-kselftest fixes for next rc
once I get conformation.

thanks,
-- Shuah

