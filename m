Return-Path: <linux-kselftest+bounces-18367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195279865DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 19:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497071C24503
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 17:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A193084A31;
	Wed, 25 Sep 2024 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S7E9AvB8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD9082D94
	for <linux-kselftest@vger.kernel.org>; Wed, 25 Sep 2024 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727286247; cv=none; b=pBN8oeYqiaulXvK39dvSSrinRaWfrlNeORDFN3kGbT3QFLG1eImyBBirLBwnaN732yrbOHMb6Q1HnhJoGgrotdq9tdbTPxGFFdBlYkduHPODOeOrYef1A+B2qbrOIevFRjzprIVim7JUH2/qaX8IpSC3ta5eWFbPUUGIuDTOskI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727286247; c=relaxed/simple;
	bh=mdOJO1T2SXtgXhpZ8IXEcyfGOLgVnBuAE9fSfJICRmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0YkgLc3d7rZVOmtjDzLq5hu+xEoLEuHroseKXWUMsLgZd4ezvF6CyyRaCIQNOQc+FC5YkmfqoyXvudeKQcI2ydXGtCzQfTbtmq0uRc9D4uFfUX9RC0tEfRzsYQGXNk9iFW6rsq0FSCSbi0hxKG/Vvo7pImkePQl7urku/y9gfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S7E9AvB8; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-39f52e60a19so391105ab.3
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Sep 2024 10:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727286245; x=1727891045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S1NOQIHvoS1b32+JnBJFUorwn4fOby0JeQc5DVFR9XI=;
        b=S7E9AvB8z9vhEKVxqeOY3EdmweLKcSMceSz9dRv4NyFaQbru0zdCiB1lzgxnqoKW4M
         HxKWfW1ecyDsEZxPxQBrPPMxwQVgJrzsQ8g81PThpkCF2/kt5A3bUtxIAjNf0jLAXRvY
         R3rnJy+A8XnIt7aSrbivsyU67NaF+rE3JZFjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727286245; x=1727891045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1NOQIHvoS1b32+JnBJFUorwn4fOby0JeQc5DVFR9XI=;
        b=sL4XIpM3yjsde/muwwbCYGSRV/pcby2TkYsF5Aw4Lxy05WQ/ZVkQl138unD4Elc0hP
         L9+AmcAw/qK1wkg9wHnKhhJzLsYyPsianOUo1bYSM04xK7tF7OllA5EXq5LKBgZgXIAP
         1cx4jk3KDwZNSKSqAGIeAXwAHMRaWdWJhPZw5tawvb1tr5IyZoIiCHMCgL4mPZwtS1yF
         WQt6Gu9tSnLTw+xPzGoZaKL6+Eq62nzjra3yKyEuMOeZMTA1FQKQZETub5I1jQcNOeoG
         Um/MS60T0DHQ1fOCPSTn8Wlq74aMmDhyqkCS8j7gYnhUo3YBtotgWAO5ZrVHfl77q82P
         3OVQ==
X-Gm-Message-State: AOJu0Yw8Qzqz2iOIxyCCVnG3O3JwqfOtugnmogYDN5lTTwy/gdTMzpzD
	nnC3c3QOPMJhhvGnNk6lIoOvwjZS+G1YTzpUCBgu4zXTx2NcTwV/ViGVVdsD4n0=
X-Google-Smtp-Source: AGHT+IGU2iXvHZXBx7d7MTmHzpaHRYoM0isbxb+yjYZRM40BVKEyJurIZQMglgYHXU0dupnd4jnbLw==
X-Received: by 2002:a05:6e02:13aa:b0:39d:4c8a:370d with SMTP id e9e14a558f8ab-3a26d7a0ed1mr37529425ab.18.1727286245036;
        Wed, 25 Sep 2024 10:44:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a1a5713ac4sm12296485ab.68.2024.09.25.10.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 10:44:04 -0700 (PDT)
Message-ID: <576dd993-1428-4be0-9e5d-abec44a039c5@linuxfoundation.org>
Date: Wed, 25 Sep 2024 11:44:03 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests: exec: update gitignore for load_address
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Allison Henderson <allison.henderson@oracle.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-mm@kvack.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240924-selftests-gitignore-v1-0-9755ac883388@gmail.com>
 <20240924-selftests-gitignore-v1-4-9755ac883388@gmail.com>
 <e537539f-85a5-42eb-be8a-8a865db53ca2@linuxfoundation.org>
 <70864b3b-ad84-49b2-859c-8c7e6814c3f1@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <70864b3b-ad84-49b2-859c-8c7e6814c3f1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/25/24 10:25, Javier Carrasco wrote:
> On 25/09/2024 17:46, Shuah Khan wrote:
>> On 9/24/24 06:49, Javier Carrasco wrote:
>>> The name of the "load_address" objects has been modified, but the
>>> corresponding entry in the gitignore file must be updated.
>>>
>>> Update the load_address entry in the gitignore file to account for
>>> the new names.
>>>
>>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>>> ---
>>>    tools/testing/selftests/exec/.gitignore | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/
>>> selftests/exec/.gitignore
>>> index 90c238ba6a4b..4d9fb7b20ea7 100644
>>> --- a/tools/testing/selftests/exec/.gitignore
>>> +++ b/tools/testing/selftests/exec/.gitignore
>>> @@ -9,7 +9,7 @@ execveat.ephemeral
>>>    execveat.denatured
>>>    non-regular
>>>    null-argv
>>> -/load_address_*
>>> +/load_address.*
>>
>> Hmm. This will include the load_address.c which shouldn't
>> be included in the .gitignore?
>>
>>>    /recursion-depth
>>>    xxxxxxxx*
>>>    pipe
>>>
>>
>> thanks,
>> -- Shuah
> 
> 
> Hi, the kernel test robot already notified me about that issue, and I
> sent a v2 to fix it shortly after. Please take a look at the newer
> version where I added the exception for load_address.c.
> 

Thanks. I saw your v2 after sending this email. I have a comment
on v2 to split core and net patch

thanks,
-- Shuah


