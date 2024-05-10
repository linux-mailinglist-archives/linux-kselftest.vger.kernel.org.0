Return-Path: <linux-kselftest+bounces-10054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80F38C2B5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 23:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9117B1C224F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 21:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EB313B2BC;
	Fri, 10 May 2024 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZ/hCwhW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD1E10965;
	Fri, 10 May 2024 21:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715374972; cv=none; b=rQioD25ZuXiYA5xbfOvNTw7ZNYpn6T2QguaY6h2K85sePfPEfURVjxsWDMKwo51axqZ5r5Ost3yguU1KM2pHfBtVzoeHTtS//hpchZed3bKjwrnIdE5nOoAIU78v9goLiMgxLhu8jCJnHp/KfrIzTMFhqjeXnWJz1DEo0iUOOzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715374972; c=relaxed/simple;
	bh=jHXYkEPgEyhZ/WyWKa/w+U8J4lDHPmHuACT4eVgS5r4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gK7TW9RjkA++V5YX+WoGA6KMl8jBjHQIIcfaV1JPUEeUXgMVR/ZAAiSLh2j4wrw6up2nq4/gq47J0ATMGLW9btSHAAYnco3zsQl5m7wrtEtiRmDwTJ8jE5h4Wz1MFPiJbpvIyKMvkstTPKI2i9iDwVhvGCv5D5Fi7nSZDhwnvi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZ/hCwhW; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a5a13921661so555348566b.2;
        Fri, 10 May 2024 14:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715374969; x=1715979769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YDvZ5R+LQhpGtWSzN6NAhLHMXd7fuJCWZQdp4HYbgM0=;
        b=lZ/hCwhWTTDf+fuCdCrqiXhTuWM3Nauw6Od2phKvC1fewjEX6n8sfOIfdV5o3DrdGL
         6hwnT6we+/dNh0uknk5iLQbcurZdjx06bDo9g+TeOZDsQsO6kmCX+Nff13Iotj6ZAa++
         lpUAYNJC+FWlVfKvWlzk/LHTFO+UrFpa5jgeRhmBGBMEGQo8JKZtEZ8GkYy/s76Q4Gba
         UK9nG5UpIQXTJVkL5FjgxRWM1O38Zhs+qHgFQBy0QsndS0ah2hNWQSw5lNFa3FwRh6LQ
         qY81nBeAXzrHr81FcweBrDTko6RJY/taOIgdSj87WpgvQYo8Km8wCB/HDM2T+q3+LeW8
         YkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715374969; x=1715979769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YDvZ5R+LQhpGtWSzN6NAhLHMXd7fuJCWZQdp4HYbgM0=;
        b=wyIEicUk+aAsL7ad/oma+XbcrdV+2ctUJCkzpqfcqKNOhofedWTl5vnScoKlhwWWmu
         413bU6tMn5PYHBHkw6baAEMB0raysUejpFtEq0VsookFuswxrX+p0mjcQ6u9CnGscsAn
         EvTIjm10ISkjUCwo/nFH5th05cCG4z4m0YPK9NOsT0XYK+w9A8ZaZxW+BrbqI7o8mnkX
         YtIzRON3xHNSbzkR2qjURJ1tDyRq16lOtQuJ0V9i2XH+yUwfy78fhM+Vjdo4SosRV4ON
         kntwLZLXYyEGRBKtdMlLuiFe2Ut7CG2U1xmwbTU8RqUS39GJYKKlFlpux9pYZoYgz3uV
         SCWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoPrP0u00EPRxRozJ10Z/Rci7s9xr6jDFb6y00zn4Xj/XVbvzh3bZoapPyTixcTQ/bVIWE4IQt+DNSPGJr/xignqJw/HrjBXEOUZmSYywSc3DHsIkc9BZyOhKeZ1EqXAaVblUY7/GxSVSj0yBEoM69j5dzXYLIZkiHTCGdkzkhdQA8jZi6xXS0
X-Gm-Message-State: AOJu0Yxw91SPmEVIFkkeWWhLg0pZtZVmMqRQFWnw7I48Cw/5S4StFxGS
	NY2jJnDTnXL6xLS5RfpCCiKAZ9O8jVaB+sqKD2N55d2/VFyWIP9w
X-Google-Smtp-Source: AGHT+IE/P5ZYwxXIWnlB74aOUnIqe7XNxlXpvHHjLPb18camh5mYeVY5//b3+JStG+0BRlhM6g3OSg==
X-Received: by 2002:a17:907:9710:b0:a5a:2d30:b8c1 with SMTP id a640c23a62f3a-a5a2d54c038mr318797366b.14.1715374968818;
        Fri, 10 May 2024 14:02:48 -0700 (PDT)
Received: from [192.168.178.20] (dh207-42-221.xnet.hr. [88.207.42.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b015f7sm225995166b.146.2024.05.10.14.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 14:02:48 -0700 (PDT)
Message-ID: <65a79654-90e8-42b9-a840-e2ef404fe1f2@gmail.com>
Date: Fri, 10 May 2024 23:02:47 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] selftests/sgx: Fix the implicit declaration of
 asprintf() compiler error
To: John Hubbard <jhubbard@nvidia.com>, linux-kselftest@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Shuah Khan <shuah@kernel.org>,
 linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
 Edward Liaw <edliaw@google.com>
References: <656c3b4a-0481-4634-9dd4-19bb9e4cd612@gmail.com>
 <4dcd5fca-c200-42d1-a8f2-3045d5430fd6@nvidia.com>
Content-Language: en-US
From: Mirsad Todorovac <mtodorovac69@gmail.com>
In-Reply-To: <4dcd5fca-c200-42d1-a8f2-3045d5430fd6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/10/24 22:52, John Hubbard wrote:
> On 5/10/24 1:37 PM, Mirsad Todorovac wrote:
> ...
>> The fix defines __USE_GNU before including <stdio.h> in case it isn't already
>> defined. After this intervention the module compiles OK.
> 
> Instead of interventions, I believe the standard way to do this is to simply
> define _GNU_SOURCE before including the header file(s). For example, the
> following also fixes the compilation failure on Ubuntu:
> 
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> index 9820b3809c69..bb6e795d06e2 100644
> --- a/tools/testing/selftests/sgx/main.c
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*  Copyright(c) 2016-20 Intel Corporation. */
>  
> +#define _GNU_SOURCE
>  #include <cpuid.h>
>  #include <elf.h>
>  #include <errno.h>
> 
> 
> However, that's not required, because Edward Liaw is already on v4 of
> a patchset[1] that fixes up the _GNU_SOURCE problem for all selftests.
> 
> [1] https://lore.kernel.org/all/20240510000842.410729-2-edliaw@google.com/
> 
> thanks,

Hi,

Yes, I actually like Ed's solution more, because it solves the asprintf() prototype
problem with TEST_HARNESS_MAIN macro for all of the tests.

Sorry for the noise and the time wasted reviewing. 8-|

Best regards,
Mirsad Todorovac

