Return-Path: <linux-kselftest+bounces-14588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E1D943915
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 00:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E381F22A1D
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 22:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F0D16D9B3;
	Wed, 31 Jul 2024 22:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g2Td5CnR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4C516D4E5
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 22:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722465645; cv=none; b=tdW471uQKmDO1elqCr/jTPk/ebKOJoemh/A58S0pYdym9fvI6Kd0bIVU9dHTPxltz/atcs+fkYpscSX9rSydSu1R1gmz3dHba+1g0gUslBekQiT0KjY0XMYarfAv5Eha8fhU9amhvGGnTrR/eynt25yULf2VYbOH+OwhoUwh4Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722465645; c=relaxed/simple;
	bh=7EsdgnAfL7dScs6OStTlA3BjgaVxQvcvyR7o8SiBSy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=RqNwIIdBHPTsEDCosEXpG21zhvQW0AseBVN6kC3H1awzPnerzt2ymftZuQ0g7May/BZRWYql8xtCk/bSPvxfWOCfwZJndNUFyx+8PZ1TgrTui9T1k9yeeTTaYieafk2g2R3rL20MjFBxVq7KjHnmePIxWnS2TNZZ6aD6odcC9ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g2Td5CnR; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-81f902e94e6so27038039f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jul 2024 15:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722465642; x=1723070442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nulRHwW4K/r9gJr7P4RUNvbSWB0QEf89MBtNt+olasU=;
        b=g2Td5CnR8puvgDPonSG9IrBwfjGmL2kmH25uKKy/YnDZoieVLGtdzxV3smLGgfBHWS
         2VAy8cqdo1IdFYc3SBjAnPZpTlR2CPxIiRi4N8biVXin6waac/ANGa/BC/p+QdHK1VG2
         venMO3VDVhIzPRV6esg43JV8e0Oy+OVwUNvfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722465642; x=1723070442;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nulRHwW4K/r9gJr7P4RUNvbSWB0QEf89MBtNt+olasU=;
        b=H0dWtq0UmO6TrrEbg/Sh4E8zT+pxZ3JE9KKW93b+4cRgZZyd4WYVoJFzJWtUDkP4hp
         0FLjhBY/F6wDqc0TvZN5hufmKO0E9btGmDFYFEgH7wa9QH3PUfXNipRQlOj5aap1gtYT
         fBr7A4GzXXPlVkdntsTq+8ldk3s27FGO4ukd8Q6AG7wn2KNU2r/J620ZYux99YXvB3VG
         dN45x2/kEci7P8Pc8GGlQPFpB5urV6Olto+oTVBG0owBXt3QyXzhpVG1cMxwgtk3rxNL
         WegWibuBe0Ot1tJfF33E8+BCSXwXEQD4wNM3lIc2qhFO/CSyWd8eCNuxpW2yuxB7YtdY
         ocDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUogLzWARNoLvUCqcIBULUVhuajyr6CvVu3iB0k7XJ7vXTqADZMnpFHXrgegY+Qlbeez7aa/USA7JHnl+bP95Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkfK3xYh4BQvut31z3OU5Z51Jgbb7v9W4+R3lDbz10JvlVU802
	txqVzgcLQTnyUY8B+G2ylmouWMi7jPfVjHpxUF/mmqsCBdlQmP0Qrl64Sysgb0E=
X-Google-Smtp-Source: AGHT+IGiS8PG3qlGAAXs41evym16DSdHih2v9E5fWVKK2HmhqZaZz9un1eoELsEBm0AgadXl7c9frg==
X-Received: by 2002:a5d:93da:0:b0:81f:9748:7376 with SMTP id ca18e2360f4ac-81fcc0ae074mr59275339f.0.1722465642105;
        Wed, 31 Jul 2024 15:40:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fc64330sm3385085173.175.2024.07.31.15.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 15:40:41 -0700 (PDT)
Message-ID: <76477240-7412-42f4-a014-074297ade30e@linuxfoundation.org>
Date: Wed, 31 Jul 2024 16:40:41 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kselftest/next kselftest-lib: 1 runs, 1 regressions
 (v6.11-rc1-6-g38cde27f74d8)
To: "kernelci.org bot" <bot@kernelci.org>, kernelci-results@groups.io,
 linux-kselftest@vger.kernel.org, shuah@kernel.org
References: <66aab8d7.170a0220.188ef7.5d6f@mx.google.com>
Content-Language: en-US
Cc: Shuah Khan <skhan@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <66aab8d7.170a0220.188ef7.5d6f@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/24 16:21, kernelci.org bot wrote:
> kselftest/next kselftest-lib: 1 runs, 1 regressions (v6.11-rc1-6-g38cde27f74d8)
> 
> Regressions Summary
> -------------------
> 
> platform                    | arch | lab         | compiler | defconfig                    | regressions
> ----------------------------+------+-------------+----------+------------------------------+------------
> stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defconfig+kselftest | 1
> 
>    Details:  https://kernelci.org/test/job/kselftest/branch/next/kernel/v6.11-rc1-6-g38cde27f74d8/plan/kselftest-lib/

Above link give me 404 - page not found - bad link?
> 
>    Test:     kselftest-lib
>    Tree:     kselftest
>    Branch:   next
>    Describe: v6.11-rc1-6-g38cde27f74d8
>    URL:      https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
>    SHA:      38cde27f74d8bbe2f705fb1f80384acab9762e9e
> 
> 
> Test Regressions
> ----------------
> 
> 
> platform                    | arch | lab         | compiler | defconfig                    | regressions
> ----------------------------+------+-------------+----------+------------------------------+------------
> stm32mp157a-dhcor-avenger96 | arm  | lab-broonie | gcc-12   | multi_v7_defconfig+kselftest | 1
> 
>    Details:     https://kernelci.org/test/plan/id/66aab22e093b574a087e706f
> 
>    Results:     0 PASS, 1 FAIL, 0 SKIP
>    Full config: multi_v7_defconfig+kselftest
>    Compiler:    gcc-12 (arm-linux-gnueabihf-gcc (Debian 12.2.0-14) 12.2.0)
>    Plain log:   https://storage.kernelci.org//kselftest/next/v6.11-rc1-6-g38cde27f74d8/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-lib-stm32mp157a-dhcor-avenger96.txt
>    HTML log:    https://storage.kernelci.org//kselftest/next/v6.11-rc1-6-g38cde27f74d8/arm/multi_v7_defconfig+kselftest/gcc-12/lab-broonie/kselftest-lib-stm32mp157a-dhcor-avenger96.html
>    Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bookworm-kselftest/20240313.0/armhf/initrd.cpio.gz
> 
> 
>    * kselftest-lib.login: https://kernelci.org/test/case/id/66aab22e093b574a087e7070
>          failing since 1 day (last pass: v6.10-rc7-29-gdf09b0bb09ea, first fail: v6.11-rc1)
>    

thanks,
-- Shuah

