Return-Path: <linux-kselftest+bounces-18240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0FC97EF62
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 18:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E021BB217AA
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 16:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCF019F105;
	Mon, 23 Sep 2024 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IsO97jAt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8096819D063
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109722; cv=none; b=BV+FEaMp4gBc0XMj5/QBE+NNYD2zk2thISv+wqwScz5C9jCy61qd52xdAhmVAFIMS8K9QyjeXzDsBC1Y/TzPOhqj1J6Szs1gtVrY0PptvjIqZktOb1kLz7pBzVwscTrdpr9WprBhkkTnd2CWvgvXryUfnGpV6+p2g3ifqIaROOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109722; c=relaxed/simple;
	bh=DQVh8rorEIaN5XRsyz8Jajm8FH4JKVpC+hD7uP+mbPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IRxbqPqkrTIOs0jJNjYIhTJBmvLHrz23zPuCrV358tOpI7DFrJoZx2mIESUOHDoLdD12RR2u06c+UAwugh/M0CycbmDucT9yYcuhS6+1dJ8Ju7AnLd3+0ZbiBF1kqnnCzr+IjKRZsoPUW6wnSYDCrw8FhVBiYn4EhaE+8f0ynv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IsO97jAt; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a09c977dfbso14901865ab.2
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 09:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727109719; x=1727714519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s8gqv2eowHj85pzs6ZWmgd41DevM081eQ5WDs2QG19o=;
        b=IsO97jAtvZVLRXjhuJbGDMudK/3N3+zeTdi/3Hk62dPdruU0lwAJDvoufYN+1lJRFc
         Bhd9bZSgabUxQnyYjYVlhGsNlPMUIJ3f5At6QwYrraD9GjqvvWEUNtkc2h08m8usBU9t
         Ih7PlO2niS/l5OFwPVu+FLK4chspk1Vn1Q0Sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727109719; x=1727714519;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8gqv2eowHj85pzs6ZWmgd41DevM081eQ5WDs2QG19o=;
        b=r4uJb4NBIlET/KwtCgDgXZs+MnpV32FQB51pFWYc24UtE6i0AzEpAAIBpVBigfXE1e
         MiK79SODy0WLuTpmMDqWwu2HtMuUF87xDEswXIxXBvo6+ksSG/E4LbsDik2j1TqCCyIo
         mU784QwMpXaB1tZQTnb1mdUAWIt2mRZ6I+Dhef0/yCp51CnmdTOS1vSeICGUxlyw/OMR
         RGgoztkhm3nLVSqozAnMOxocucAhKSFaGmNOnXZykbeb5j7mvQosa1GHLrS+37dlDQuO
         VTG6jNCA2l9ogm5UvFIjjnRmUtj6wRDdQMG5Uc8RV4oVWvBVbN6Q9t3Uc4KFzlwW40DV
         fdcg==
X-Gm-Message-State: AOJu0YxxaCmH0PP3YQyJERbgAjE0f93CJeL+RF+BldKgfxaigXpZkrJ+
	jlOitftaqArTXxPog54bqo2koNqzmwid5JiOk3Rs09NzwFItT6o/b02Cq8TH1z8=
X-Google-Smtp-Source: AGHT+IHkpyU2eJOyncFOkKO5cBBSHIjMz8n76rSmIWkvqHjxBuxcSVtIO7r3zlQzrsOEO0XhY1RmVg==
X-Received: by 2002:a05:6e02:1a63:b0:3a0:9f85:d74e with SMTP id e9e14a558f8ab-3a0c8d0ba04mr101903675ab.16.1727109719585;
        Mon, 23 Sep 2024 09:41:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a092e10b83sm62252175ab.31.2024.09.23.09.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 09:41:59 -0700 (PDT)
Message-ID: <4efa70b8-3a46-4950-b6da-c5d4c22c38a8@linuxfoundation.org>
Date: Mon, 23 Sep 2024 10:41:57 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] unicode: kunit: refactor selftest to kunit tests
To: Pedro Orlando <porlando@lkcamp.dev>,
 Gabriela Bittencourt <gbittencourt@lkcamp.dev>,
 Gabriel Krisman Bertazi <krisman@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht,
 dpereira@lkcamp.dev
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240922201631.179925-1-gbittencourt@lkcamp.dev>
 <53395c4b-8e7e-4871-aeed-cf56215a3c26@lkcamp.dev>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <53395c4b-8e7e-4871-aeed-cf56215a3c26@lkcamp.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/23/24 09:42, Pedro Orlando wrote:
> +CC linux-kselftest
> 
> -------
> 
> On 22/09/2024 17:16, Gabriela Bittencourt wrote:
>> Hey all,
>>
>> We are making these changes as part of a KUnit Hackathon at LKCamp [1].
>>
>> This patch sets out to refactor fs/unicode/utf8-selftest.c to KUnit tests.
>>
>> The first commit is the refactoring itself from self test into KUnit, while
>> the second one applies the naming style conventions.
>>
>> We appreciate any feedback and suggestions. :)
>>
>> [1] https://lkcamp.dev/about/
>>
>> Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
>> Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
>> Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
>> Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
>> Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
>>
>> Gabriela Bittencourt (2):
>>    unicode: kunit: refactor selftest to kunit tests
>>    unicode: kunit: change tests filename and path
>>
>>   fs/unicode/Kconfig                            |   5 +-
>>   fs/unicode/Makefile                           |   2 +-
>>   fs/unicode/tests/.kunitconfig                 |   3 +
>>   .../{utf8-selftest.c => tests/utf8_kunit.c}   | 152 ++++++++----------
>>   4 files changed, 76 insertions(+), 86 deletions(-)
>>   create mode 100644 fs/unicode/tests/.kunitconfig
>>   rename fs/unicode/{utf8-selftest.c => tests/utf8_kunit.c} (63%)
>>
> 

Please resend the series with linux-kselftest on the cc.

thanks,
-- Shuah

