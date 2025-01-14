Return-Path: <linux-kselftest+bounces-24534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BE6A11556
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 00:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F201163FAE
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 23:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D122139D2;
	Tue, 14 Jan 2025 23:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c4kcu39H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8D61D47BD
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736897123; cv=none; b=Ac3HE54mMZ2j7rhMgICXQh5uCQRIs5TowjVB833DhkY54eBUFGpTRr608yQGWMzIr2sEIPpG/JizpdlMg9zfg+a5kMupVa9X39hvLJO8nwFiHX3VH3deutIx6HXpK3/lI/nP1NPOFkNR1pbac3HI+XzdNGN2YXwrZ/LGWHwUEg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736897123; c=relaxed/simple;
	bh=ZcfviinQO+0kc1WQxYkrN3+DK+TMPOH8Z3wD01p0d2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pcebJI5ckd9Txv8/5WpEaSkD373PmfVspytDp8PskP9XGz5jTJYKWfpa2f7ruowM2ItsPcBgEIMBBL1WjH2s80cCIPeIAd+XRKKmXraKrLHMc1T2MB/BGKoq57tpOAaSQG1O7ejUHSn3qRWHeLU4fbm279ZOOQzEUEliZJB4vYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c4kcu39H; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3eb8db8ae9aso2663972b6e.1
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 15:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1736897120; x=1737501920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/cvqNRlBXxHebrvfKmyqV0RsKP7kEcGSK5ApVll7CyI=;
        b=c4kcu39H0f4ZSE0pI+77neCyc9mEW5tJ1cWBx407wCHB+QXLMYygm4zeefXy188ayf
         0I93JJVEt0UTH6T1Sp6rtgw5sQ5Kp4BihI45coaFvrXnBemGF2OhHiLt2/X0ZkHYlVnz
         k/8jl9tQkjXd7FvGcc44g2emJQ2j16+IlRgFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736897120; x=1737501920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/cvqNRlBXxHebrvfKmyqV0RsKP7kEcGSK5ApVll7CyI=;
        b=EMTcxSHFDFBSVlUksqIlA2CTc/7tB6oSNSBm/P/rXg8WfauNfi3Lv0TCmKfkklelj8
         djGQrRlTdvqRLvq2Cu23eP+5LEAPqvVYu1z9Xx02BMVX57QHsniI9EMkjHT5Sv3I2ReH
         GlYRwBS2/ZBDPqxX8wvQasY6dYpkfbDSZyk9asN2ZO0H6xZo3H8Kjx44Jsfb+P+1tr8C
         puag4QMC5g3F16s52mTcrvUHC+F/Wg0g1x9HihgOFBCKjRYsZMr+VNM9kxT/fEhYefbP
         On0yw3REinY9BGoh4LvtIFZqx+6kxv55bWifCRG3Vu73nQ50DGUzFPaU1WnZlBqDVhhw
         jQkQ==
X-Gm-Message-State: AOJu0Yz/v87d30QVn2V65qR+q9qMX7Lv2wAywuZBV2doR6G24z5gZ+HN
	DhQq/wM5VykGIOdIXE3KDLA8JoRE+7ojEqpeEQJ68PVCdixbcyBM88dnWMNOVSw=
X-Gm-Gg: ASbGncvpVy6A8jkTXZKsiL5WH6pzndSsM8mwvNFONyKQMC6bMnR5wAuunPEI+5Uz5QN
	sWZXmT3NQhLqZZbwNtoQzdrOUse7IxNXlpS1E7a55Z+SBKNYJjuRW3II9T+Hh067wuaDhR4U4ju
	QXqc3CMrdnitacOFMafsOztuXUTmiMHe/dpQvb1oq5SURxByBk3t4QkdEDZrGyZW7iUEttrNdzP
	yafbrptc6yMVtD7RqoDauR9RM1D0YM8q0Olq0sJeR2N30BlR0vYc6Ear3+PwsXxM2k=
X-Google-Smtp-Source: AGHT+IFE4nAIPDC+aBt0vS8yiiTOW6ZXv1s1d0s/btAWBQzkM7+Q5yXNBrIpHLdmAXCqS1osunKtJw==
X-Received: by 2002:a05:6808:2f05:b0:3eb:63c9:fe87 with SMTP id 5614622812f47-3ef2ec267ecmr16830353b6e.16.1736897120559;
        Tue, 14 Jan 2025 15:25:20 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f882756dd0sm4643531eaf.32.2025.01.14.15.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 15:25:20 -0800 (PST)
Message-ID: <c1fd1a9a-ead7-4203-af55-5eeddef76f2d@linuxfoundation.org>
Date: Tue, 14 Jan 2025 16:25:19 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] selftests/resctrl: SNC kernel support discovery
To: Reinette Chatre <reinette.chatre@intel.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 fenghua.yu@intel.com, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, tony.luck@intel.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1734361935.git.maciej.wieczor-retman@intel.com>
 <808036fb-9a2c-44c3-ac6c-5406313a232a@intel.com>
 <9223d698-d16a-43c8-95c1-9839b81c2c23@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <9223d698-d16a-43c8-95c1-9839b81c2c23@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/25 15:30, Reinette Chatre wrote:
> Hi Shuah,
> 
> On 12/19/24 10:35 AM, Reinette Chatre wrote:
>> Hi Shuah,
>>
>> On 12/16/24 7:18 AM, Maciej Wieczor-Retman wrote:
>>>
>>> Sub-Numa Clustering (SNC) allows splitting CPU cores, caches and memory
>>> into multiple NUMA nodes. When enabled, NUMA-aware applications can
>>> achieve better performance on bigger server platforms.
>>>
>>> SNC support was merged into the kernel [1]. With SNC enabled
>>> and kernel support in place all the tests will function normally (aside
>>> from effective cache size). There might be a problem when SNC is enabled
>>> but the system is still using an older kernel version without SNC
>>> support. Currently the only message displayed in that situation is a
>>> guess that SNC might be enabled and is causing issues. That message also
>>> is displayed whenever the test fails on an Intel platform.
>>>
>>> Add a mechanism to discover kernel support for SNC which will add more
>>> meaning and certainty to the error message.
>>>
>>> Add runtime SNC mode detection and verify how reliable that information
>>> is.
>>>
>>> Series was tested on Ice Lake server platforms with SNC disabled, SNC-2
>>> and SNC-4. The tests were also ran with and without kernel support for
>>> SNC.
>>>
>>> Series applies cleanly on kselftest/next.
>>>
>>
>> Could you please consider this series for inclusion?
>>
>> Thank you very much.
>>
>> Reinette
>>
> 
> (bumping visibility of request made close to holidays)
> 
> This series still applies cleanly to kselftest/next. Could you please
> consider it for inclusion?
> 
> Thank you very much.
> 
> Reinette
> 

Thank you for bumping it up to top of my Inbox.
I will apply these for 6.14-rc1 now.

thanks,
-- Shuah


