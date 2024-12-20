Return-Path: <linux-kselftest+bounces-23699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A0F9F98B7
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 18:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24E7164EF7
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 17:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4003E22F3A6;
	Fri, 20 Dec 2024 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QgP/edTA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7AA21E094
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716093; cv=none; b=MVJZ4KvE31N/C5jfXCGMtjTYxKPIn8BpQXhd2PHXLl66nb0Vkx8+5I0qSE4YVEdPkz7plkI/V/Q55eKn/mSg6uBxtWIWu9nF7foQ+JexTN5b3Bd97lD0/5raEoSbXO9tYPh0SP8tUy5wR3D1b7SzrXqCxXh9erk52bHFbVJuFQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716093; c=relaxed/simple;
	bh=sB4Qa9trk67pIn3qtj324FrHhU4l0JkYAxP9D1po14A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvV2VJz4FjI+kpn6cni4E6cta+WeLlRncjM8R4z+LmEK5XlOEJD+Ps2xsMqN+6PaB/wOe5FfUaVbQ839QDwmhGV8R8sZDJgb3P74+gQdX48be+R5KRlIIYYRBNrPafyYfeeMShuZe/x/ptS6zANCavnktKfANKLguiFfC8DUXN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QgP/edTA; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-844e12f702dso76067139f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 09:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734716089; x=1735320889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3bfcorNm0/Wj5y3Z7wXjeJrt/2j0lA2cfaU6IiYz2hU=;
        b=QgP/edTAI2iPUeMWgdjmt566rpXfMMDIAMFJh+8uz6MQHwtSoax9n8W6Im3a88pLtR
         iPRjn+ADmlt2wbUUozVgOHlCIF/6kvmqKnDqFwn3Zxb+rqRZbUvigHrCzaBAyY9QPxGT
         ecDDZ6rsLKJkXT3FqBjPaydKnwfvyKCtfwVW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734716089; x=1735320889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3bfcorNm0/Wj5y3Z7wXjeJrt/2j0lA2cfaU6IiYz2hU=;
        b=NmXwKpL1SIxgGv/VPpJBINegvcu/s95G6S3ClbRJ+eNTyFdmEt/UOABqeDY4IUJvMt
         ANciToM9XTlSeRPPqGC/OSAXmU7Gr3CyLQ5KCMtoxHT/CEY0pNNhXm8H9gbt8wj6KOe2
         nQR+ISzt2dIjXn1cpvxv/0UICYiUZJuC061ZV/ZOMCTZBiKtFiJ1gIPDjQ5yH1eenDDq
         ZPKWNDiSym6PmJLlnsmjjibssRslo8VeONW7AO8KKBt6PVyczL6xybEqgf2oNwGXn8ZL
         C5nVt5eOXxxjGFCyInPqOfqzTet03p4wKtIJtRotZY6ivJvkBmoBy2AdaXJf9jQHDwLU
         xazg==
X-Forwarded-Encrypted: i=1; AJvYcCX36WgbLpiXUJLYn4J3qRouxC4Ptf9hBdaRJ1CoKsIp3q4V980xCDBVbeuXTNABET2d7CvWN3fH+tDbc9ABi1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbrahzgWbjdzlNRqbT541ozOqBpRmCNiN9IYUJ+L28WUCwnZnz
	lE23Wh/Z9g8g8Td8ytUwjOjBIUnBHVS3vDD3NCYT+jKIL0K600PmF2ZGWI1+3bs=
X-Gm-Gg: ASbGncvvDDw0MCgMw3OLlpPdZgUUoNjzrg3uwZH3jKcMfSTq7IFRVwe9pPQqVXg3a8O
	rzECXMznUpTfqqsuT46q/5XBjBUhOLqqJXO7Luk+p1xOjfeZtNb4SrfOE6zf0dH4tYuTd7Wk0AY
	/2T1hJ6PGGIejjVZZjVV8tfalQiU4T/xNFykgPra89Kiz/sqPPw3i4VEswxsjuy30ZgQ7uK2eaO
	PJkwL67YaiktxB2LROWUugG9i9dI4TZqsb5qMOmnIXPPY8ggxl9bKu1KpmFzxVjraE8
X-Google-Smtp-Source: AGHT+IERS0XEXKu0zBuSlavwD3/LW9dk/OiT/DTiE5qVaR8PsSVflTcP0RFBZdkYhG6Y0jZ2zzcTYA==
X-Received: by 2002:a05:6602:3c7:b0:841:9d3d:ea14 with SMTP id ca18e2360f4ac-8499e61e2f1mr450577139f.6.1734716089630;
        Fri, 20 Dec 2024 09:34:49 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68c1df18bsm874192173.137.2024.12.20.09.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 09:34:49 -0800 (PST)
Message-ID: <df114243-822a-44a0-9991-d5d51a0dd91b@linuxfoundation.org>
Date: Fri, 20 Dec 2024 10:34:48 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drivers: base: test: Add ...find_device_by...(...
 NULL) tests
To: David Gow <davidgow@google.com>, Brian Norris <briannorris@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Maxime Ripard <mripard@kernel.org>, linux-acpi@vger.kernel.org,
 Rae Moar <rmoar@google.com>, Rob Herring <robh@kernel.org>,
 linux-kselftest@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241216201148.535115-1-briannorris@chromium.org>
 <20241216201148.535115-4-briannorris@chromium.org>
 <CABVgOSkL3iCA9j553GM8pX_SZ80Xx+BWGZ_qaL0jHAY69-WMmg@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOSkL3iCA9j553GM8pX_SZ80Xx+BWGZ_qaL0jHAY69-WMmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/24 22:45, David Gow wrote:
> On Tue, 17 Dec 2024 at 04:12, Brian Norris <briannorris@chromium.org> wrote:
>>
>> We recently updated these device_match*() (and therefore, various
>> *find_device_by*()) functions to return a consistent 'false' value when
>> trying to match a NULL handle. Add tests for this.
>>
>> This provides regression-testing coverage for the sorts of bugs that
>> underly commit 5c8418cf4025 ("PCI/pwrctrl: Unregister platform device
>> only if one actually exists").
>>
>> Reviewed-by: Maxime Ripard <mripard@kernel.org>
>> Signed-off-by: Brian Norris <briannorris@chromium.org>
>> ---
>>
> 
> Thanks. This looks good to me.
> 
> Reviewed-by: David Gow <davidgow@google.com>
> 
> 
>

This one also can go through Greg's drivers tree:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

