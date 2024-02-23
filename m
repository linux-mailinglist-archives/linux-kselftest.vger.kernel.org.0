Return-Path: <linux-kselftest+bounces-5391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4290861FE3
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 23:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B141F234AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 22:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4FA249F3;
	Fri, 23 Feb 2024 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OKzXKJ69"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DBB2EB09
	for <linux-kselftest@vger.kernel.org>; Fri, 23 Feb 2024 22:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727834; cv=none; b=RhXOkfUEOvdAXAVj/dzKcfaBJoFqORAzza78p8Hd92QVIFX2uSNIxpFNQhueI2FMtRWm7bTPeNU63gM05wZhlZrOigVKlt98VG7mrcvlZvTcPWKvCGewFrywVFS3gzscnSuIh8+cRxUNV6GXiFj802UKbrXILXUyxJQgdB9roGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727834; c=relaxed/simple;
	bh=j0GdMvnu7Pyz5qABJdX7jRCrOkSnK2DF53Fqgk9EPYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJFmeiBSQdvm2iKzLO8v2QSKbqSEi/cZS/W0mYCdeMwftm/ylkJT+M9XdcIxu8EneT+8wUvi2aWwq+PjskO0TU9zSY8ZXnc+qjppqk5n5RLbgI3mfpCawmxO3AIn6gfLe/ZuS1fXXmv/t7ZWJmLgFOXcoT8eDgq3z5HTS430Of8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OKzXKJ69; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c787eee137so14366139f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Feb 2024 14:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708727832; x=1709332632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ttxmMzeVk7v+hmJEhpx2SOa2Fr3dSf/g1MsOLQuRp2Q=;
        b=OKzXKJ690E321dO+QzxSh0CtElX4EM7sRDuYufQJlPXfKb2XSXYmQbwGN4pwflSCn2
         izTMWA9CjPo+yOf7JbNN8wRvnMvt6KtpOpR3gOdG1QJyGmQyhX0FimQOt2MmWVedlMiV
         UqIZggnGkejgotODJSSZWjPAVK4aH7W5yHoxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708727832; x=1709332632;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ttxmMzeVk7v+hmJEhpx2SOa2Fr3dSf/g1MsOLQuRp2Q=;
        b=u8TCReh4A/ZunYVS08o6gFKPbqLNPMCd2/vW0Dyit50aX3/G86ij3TFH3hr5JHX9ZK
         UYbTOSUn2l/lhBccVDh4LZ6TOAGggM3/EwIWvtb3j9CSJwJ+POmBRklXDYYz85Q5Che1
         4O1CF8mvrhlQp5bkbxmbkFDRQPAeFdp5/rpIj89pUx3FuYsZyOjFV2S7Rvpu3KvRRGaS
         QUfYH9mNgKPDm/fFLqMScJM9D+NnRaq3yzIEmI48v6oveErZiuibvJBELPdiIEOSXs/B
         OTvME6ISBRmJevjLIC0TIHAx/AORIxDy68/tBLbtkbTSzETBcuPcVvX1kFCWeWoC/WJ2
         /W7w==
X-Gm-Message-State: AOJu0YzEyhHWL4d6F12dchB11xbtMJjeJqmrW/CORS2vCptn0qtBtq2c
	v5qmHBoMgL8e+DnSUhyvlsJfgrSmwn4YN9K0jMd/lCcZu9pzJVPnVOTXlX31f1c=
X-Google-Smtp-Source: AGHT+IFBjTd/GNKQisoDA+gu++dNtQyn3/Eg9HxcPZdwqTYtxi1xl023O9HnvlAnNYTJheZq6ZeRqQ==
X-Received: by 2002:a05:6e02:1d86:b0:363:b545:3a97 with SMTP id h6-20020a056e021d8600b00363b5453a97mr1257091ila.0.1708727832392;
        Fri, 23 Feb 2024 14:37:12 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id g15-20020a92c7cf000000b00363c8e5a1a1sm4866810ilk.44.2024.02.23.14.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 14:37:11 -0800 (PST)
Message-ID: <a8f1f104-c5c1-400c-873e-99b01cde1d88@linuxfoundation.org>
Date: Fri, 23 Feb 2024 15:37:11 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] selftests/resctrl: Add non-contiguous CBMs in
 Intel CAT selftest
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, shuah@kernel.org,
 fenghua.yu@intel.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1708072203.git.maciej.wieczor-retman@intel.com>
 <f8886683-4f24-47ce-a0c6-ef28466bfec9@intel.com>
 <685828ed-06d2-4a2c-9911-05145e55ea1a@linuxfoundation.org>
 <48dab897-162d-4075-baa9-f5391a23d31d@intel.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <48dab897-162d-4075-baa9-f5391a23d31d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/24 15:33, Reinette Chatre wrote:
> 
> 
> On 2/23/2024 2:29 PM, Shuah Khan wrote:
> 
>>
>> Applied to linux-ksefltest next for Linux 6.9-rc1
>>
> 
> Thank you very much Shuah.
> 
> Reinette
> 

Hi Reinette,

Okay ran a quick test. Why does this test leave "/sys/fs/resctrl"
mounted when it exits. Can we fix this to unmount before the test
exits?

Please send a patch on top of linux-kselftest next.

thanks,
-- Shuah

