Return-Path: <linux-kselftest+bounces-35241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89701ADDFD4
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 01:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6AF4189C218
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 23:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBAE2147E6;
	Tue, 17 Jun 2025 23:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnqDH46O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB33D2F5312
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 23:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750204359; cv=none; b=LlWszl+4mCEqYhlxNEgcEspzVJ4Fc4CiQFoAvngMH3J5HV4exJXxd4zasj74+3YGzM1pSKyoE+MNEbUFEb3jn4c7w3fMTRyxoMPHZm3v7vtOSHzxapx0h1jjLkaYS9zZ8ROZrecjrRuwlgGrHTA5dwyrTA5pf4+7wkS8pkE70HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750204359; c=relaxed/simple;
	bh=rgR29pMq5Hx0nvb/2ImYD8t/0U2W1RhW14djxapdnOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Df5sSenTgCpa7d4XA/7BQySplV8MR9tOadqKSI7GMEvTQZHdmWjZ3jjD97fPBWW92w7bvIJP44cjx5P3IIET9H2PaJW0Rq6OXGsrXn26WW/robUcIOVVlmfunp8ZVL+BFEhn0aup+Xr60nbpfZyKdcUlrV1zo/wRN5jYcZiisYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnqDH46O; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo12187850a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 16:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750204356; x=1750809156; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3qTVOHYcv9hMU3WbM6i+X2CVlYkgOutG0/fL8tJ71vc=;
        b=JnqDH46OQP3NdkeOFd1X5LOpRQQCDfwvhN7xSYnWLAymwb3LWR4CCWqkZDDYKPt0vn
         diAydRD178NH1SNYSPhqoOUr0uRkQWAP7Nnpq+h99XRLL7DQJ5IL80jXSUUHUYK6VL0J
         yuzsy78riaIw7XekCMosz8SGHA/fv9VbQorM6fOrSAN6xT0ExLHpjnhcEj0OqVOc77OD
         mb3c7aYYSI3qK4VO+57jIFlrDjeLV19ioPVQBFTHhYzD8bsM6FQp6w7l9LzdaECUMq0m
         llekv5qAFFg7cRnGBlABqTLjk5GNr+9zXZjKv2IteWKfv1d3oLVkib3VsFz30hbFXne7
         lWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750204356; x=1750809156;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qTVOHYcv9hMU3WbM6i+X2CVlYkgOutG0/fL8tJ71vc=;
        b=qkC1t35Mg+6hj3DXh99NNI36kUoSgjZeC3w6YwyVcMO9qEC4YQe4mCiH5i6BxaOUx8
         eOZqv5X6znbJWZyOTzp1cGNL6xrvL4Qyr/UJBRVPii7G5VukSNLguaZhr0XQw4vgBxzY
         70c/lK+n2Ry3cfUmVR5InHD+PPj/TstCfJS0q78oX6ujI9+zu9M0dfG98HBw4LxO7ZEU
         kXOrT2pCnaDl80cvrBHydqXUvsR6Bh9fBDbahF0G3Md/HvHlt0apn/CB57/yigMnfPnG
         ON6aEtsQSf9OuYFpyf7flOudnFbzPsG7rWl5mzHw/PqMZOhrE5dwppdl3UCujoRWDPrb
         1f0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9nNMcbCvqWwpMscSBkWQx1P5JpT4OluQEMbca1H7tny9he2xuqBi/sMlJhsB1OJUfnqpYlVEkz4BlEU7SdhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQBdUcBMrxzgunX3sHABuwuWzVqdaqY9nc5ueSYlgyJKezsNpS
	h1Lq64C1+65TTNmmE2P/t3NTzvcAv0ELuCJiH5dmyy0ZqFMHmk+YQ4Wp5c90uw==
X-Gm-Gg: ASbGncvCePoPflnCzZ6xDKFtL1CNkZjadvwuBTlsseqLggGNfni4gb2mvLr2kGjkozb
	KW/nFDbKi69BCldaBPDpSLhJrO354hm+DvDZPGxuWEESijXpnGKMch7eKLbHpRyQ2zB4zvGCxIy
	n/pBo93WPK0icMZGAX6/Y1r3xw5WlFVPtfXmXBhp6j+vcN06gYwicxbcobbWYcOZ51+MTlHaQgc
	y/A3YJbrx/+ek0O6Qv3des7pgowNPon1VkumRnGPhSye/NNZLaBpVVxrVLLNFe3WUjGWAwTrQfp
	QJjDnbbndvBF1VfbOjjfjoE5uvu1GV7GRc3mm8wjAb6zBTIUGYG9TknnI5qoqg==
X-Google-Smtp-Source: AGHT+IEueuizqPfGdcAI4nZxuSpwarNS2tiSJNcfXdU02d5Kv7COTMHMF7uhuOPxQs2CV9/mbxG1HA==
X-Received: by 2002:a17:907:1c15:b0:ad8:a329:b4a9 with SMTP id a640c23a62f3a-adfad3832aemr1617924066b.25.1750204355889;
        Tue, 17 Jun 2025 16:52:35 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88fda18sm949595866b.92.2025.06.17.16.52.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jun 2025 16:52:35 -0700 (PDT)
Date: Tue, 17 Jun 2025 23:52:34 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Wei Yang <richard.weiyang@gmail.com>, shuah@kernel.org, kees@kernel.org,
	luto@amacapital.net, wad@chromium.org,
	linux-kselftest@vger.kernel.org, usama.anjum@collabora.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH 1/3] selftests: correct one typo in comment
Message-ID: <20250617235234.z3e7gb3qbnnxpyu5@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250616122338.32678-1-richard.weiyang@gmail.com>
 <20250616122338.32678-2-richard.weiyang@gmail.com>
 <20250617092923-28ce37f3-5b4d-4922-83a5-ae6bf6a67fbe@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250617092923-28ce37f3-5b4d-4922-83a5-ae6bf6a67fbe@linutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Jun 17, 2025 at 09:31:52AM +0200, Thomas Weiﬂschuh wrote:
>Please use "selftests: harness:" as subject prefix for the patches.
>Also mention the specific typo to make the subject more unique.
>

Thanks.

Will adjust it.

>On Mon, Jun 16, 2025 at 12:23:36PM +0000, Wei Yang wrote:
>> The name is __constructor_order_forward.
>>
>> Just correct it.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>
>With the above comments addressed:
>Reviewed-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
>
>> ---
>>  tools/testing/selftests/kselftest_harness.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
>> index 2925e47db995..674a6112e6e1 100644
>> --- a/tools/testing/selftests/kselftest_harness.h
>> +++ b/tools/testing/selftests/kselftest_harness.h
>> @@ -936,7 +936,7 @@ static inline bool __test_passed(struct __test_metadata *metadata)
>>   * list so tests are run in source declaration order.
>>   * https://gcc.gnu.org/onlinedocs/gccint/Initialization.html
>>   * However, it seems not all toolchains do this correctly, so use
>> - * __constructor_order_foward to detect which direction is called first
>> + * __constructor_order_forward to detect which direction is called first
>>   * and adjust list building logic to get things running in the right
>>   * direction.
>>   */
>> -- 
>> 2.34.1
>> 

-- 
Wei Yang
Help you, Help me

