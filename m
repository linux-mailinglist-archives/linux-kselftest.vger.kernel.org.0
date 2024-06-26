Return-Path: <linux-kselftest+bounces-12824-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7A0919841
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 21:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4952E283D21
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 19:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E791922CA;
	Wed, 26 Jun 2024 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dt5sSxXd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2925C14D6E0
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2024 19:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719429937; cv=none; b=df3hmglBxvep+gU0ZKB3E1GyLGiA1xsnMPRdeOO8JrkkabZ4E8Y2g8yLzRaOnIKqS3MhKtZPSOCTsadcjyirwH4cAKCv1H3XJIeLFuOf46mnnepFDTudWyaIvQT/jgvbIEOjURPr0z/p7BY4/SjOAP7otsWciNfpLEBxLKH1yvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719429937; c=relaxed/simple;
	bh=Xx0UgYqXqz8oX6S2jDQnTn7hCBO131a23udEubagAuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWDrzX6O1aS5OGHhue5zub6FKUJ4GmTUwlaQesIvnOp/DBYmP2HLw6BAoFqqhJYFwZjXjnxGPaL8mxaEGcC/Ljlvl/6ATMVpvYCNHKEd4zce83cMdTRDKbgfAVrdyPX/CQHDmUZrMVoyyHDzIAg+/Mrk3BpaH4DDvzy4GpVBaN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dt5sSxXd; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3764dd53b5aso1894255ab.2
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2024 12:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719429934; x=1720034734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9AuhQXICJYgi+8HhiIxGyyUjo5Wfz9/NG9/QSsLxyyk=;
        b=Dt5sSxXdQ0UlzBU0DG1d+I1X7NYowjhR8L9aXdmERSrgRWtScDBcfTKblq3ueZaBx8
         Ni6DEK/So1AY+1FaUxA5Fo9v9UY9lRdrg/lxhYMTrRSLGAMdVyWQYMDEslxq6+zERYtF
         IP4syj4rfM2uVSyJB6q2LCNoLVdM7jJK2PBhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719429934; x=1720034734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9AuhQXICJYgi+8HhiIxGyyUjo5Wfz9/NG9/QSsLxyyk=;
        b=oqSN9E3cWlh7MjK+iPVl1mx9ldKKkZ/Ry08fX9ZYOT8SUcYDBydsoANDPQFIES0SNq
         qz5jW500BBOBerjUz9BGfo6wQIeDv+ll1sPLbKLlCU296/YsmOHzNM89BFMRRPG007gO
         wsWrwopCbwftU3xGMnVE/llIzSoNe6QJPaygQsJ8a+HtQisUN1amchkqPhjJWMpD9E69
         4ULv2rd0kpjvTSZH1ETBq8hsjqqGyaR6QtsW8ksyTRzI+sqtfUDCT1Gwn1Zv9b6FA58U
         2ci61hPcLlPgGJAhyWwhiapdLCHGrROsGOBfzO65HQu8Gm60vQTMroEXm//2/dvlpO/Z
         4VsA==
X-Forwarded-Encrypted: i=1; AJvYcCV96zJI2rYJmECu62hOf1Imxvyv/sRQM33KZ0T9uh7nLDRUA8y+sBi1CgtrzSlzW4Nng1+TwV5hJkvaf0EX9Oy/UCPRBVZMI1kaa6u6ogqd
X-Gm-Message-State: AOJu0YzKxtXurqFzFlrJfxbYwl4xVnkFAwfj0oDN2mYCQk7DzOqespfs
	l6l4AA/I1SFNwuMuZAPDxqh8qwUzU4J1q1sq0rTpwlVfNWGNNLBFWxwgp/hKpIE=
X-Google-Smtp-Source: AGHT+IHc7cNmqC8XQ1K7MI9KHdiJjhxNl9Nr1dtw6UpPt16PdnXhfW9pac2d9TdCfRhJQqg1tX73ZQ==
X-Received: by 2002:a05:6602:3148:b0:7f3:9ef8:30a4 with SMTP id ca18e2360f4ac-7f39ef8334dmr1257790239f.1.1719429934165;
        Wed, 26 Jun 2024 12:25:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9d11e98b8sm3320562173.114.2024.06.26.12.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 12:25:33 -0700 (PDT)
Message-ID: <7275eb85-67ae-4d70-84ae-702a478eb98a@linuxfoundation.org>
Date: Wed, 26 Jun 2024 13:25:33 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests/resctrl: Fix non-contiguous CBM for AMD
To: Reinette Chatre <reinette.chatre@intel.com>, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 peternewman@google.com, eranian@google.com, fenghua.yu@intel.com,
 Babu Moger <babu.moger@amd.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <3a6c9dd9dc6bda6e2582db049bfe853cd836139f.1717622080.git.babu.moger@amd.com>
 <96d276c11e69cfb1e29d50a12c8043555c06b404.1718144237.git.babu.moger@amd.com>
 <4be0449a-1337-4fc6-8ed6-fec10cc74bd6@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <4be0449a-1337-4fc6-8ed6-fec10cc74bd6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/26/24 10:55, Reinette Chatre wrote:
> Hi Shuah,
> 
> Could you please consider this fix for inclusion into kselftests?
> 
> Thank you very much.
> 
> Reinette
> 
> On 6/11/24 3:18 PM, Babu Moger wrote:
>> The non-contiguous CBM test fails on AMD with:
>> Starting L3_NONCONT_CAT test ...
>> Mounting resctrl to "/sys/fs/resctrl"
>> CPUID output doesn't match 'sparse_masks' file content!
>> not ok 5 L3_NONCONT_CAT: test
>>
>> AMD always supports non-contiguous CBM but does not report it via CPUID.
>>
>> Fix the non-contiguous CBM test to use CPUID to discover non-contiguous
>> CBM support only on Intel.
>>
>> Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT test")
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
>> v3: Reworked changelong.
>>
>> v2: Moved the non-contiguous CBM verification to a new function
>>      arch_supports_noncont_cat.
>>
>> v1: This was part of the series
>>      https://lore.kernel.org/lkml/cover.1708637563.git.babu.moger@amd.com/
>>      Sending this as a separate fix per review comments.
>> ---
>>   tools/testing/selftests/resctrl/cat_test.c | 32 +++++++++++++++-------
>>   1 file changed, 22 insertions(+), 10 deletions(-)
>>

Applied to linux-kselftest fixes branch for 6.10-rc6

thanks,
-- Shuah


