Return-Path: <linux-kselftest+bounces-5387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420F7861FC6
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 23:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7370E1C23946
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 22:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C402814CAC3;
	Fri, 23 Feb 2024 22:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZbkQ+s5k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D46142623
	for <linux-kselftest@vger.kernel.org>; Fri, 23 Feb 2024 22:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727353; cv=none; b=AdoLP7EUeYnu79XM0CjUD/xuaxcsKRzAppAl+x4eW4aqTNBTekyj5W36TacsVxUBYb8dretSJN/l18+tp8+4HACe1Nfe2v6yfqrTTotvwEaskv/CjjSWGeI76IHhGfPEWL3lgn0wT24J7gFsUq4OBiKTU2Uw1J8gemDqhMtCL2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727353; c=relaxed/simple;
	bh=tA4eLcKdYfrGfQv9sAUAbE8BGpNDKOdb+D+R4L5JWg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IboOFuPuNwecnJq28JgPq7tDSlBnZ9dqCnA0W43ukMEKpOXx5EbQVreVZ1BjRmfqGv0gOewVJuO+PfgA1QxszvOkjGDV2LiHfGu3fHL3IQR2ZVNELUoOR5a7+vsvbi9nhQq3l2FomV8YO1KtjXDQoacn1fImqLbHe0FAXjYDFww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZbkQ+s5k; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso23520739f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Feb 2024 14:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708727351; x=1709332151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZUfyc1Tqy9u/qIjvbCkoS9IsGCnttWBtbO+/mjQP5eU=;
        b=ZbkQ+s5kpG6X8GdHAHdAYxzAX93+TZsCDdgDbRrHi/rAeK6c5hY6Do/vcHRHOcr1dX
         XE2No0YZSOuydYb1BvSnLcuuYxPr2tJOoLVTCe5RXMS+GCAz65elvUPz+BYaARor9dii
         DCFn3Cr5nQwUqDXdqN/RE9kX8CeMCHb61Pnwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708727351; x=1709332151;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUfyc1Tqy9u/qIjvbCkoS9IsGCnttWBtbO+/mjQP5eU=;
        b=lBPLzgOc2+XPg87hJ8xdZNcjVuMy2/mv1cZ4cPwKCDddUdq3raCluqU9C2EQkJlXdZ
         389/14F4+WYmR2ZQzJ1cf+xmHPZYuVh/o6fx2nsFY3mu9ThA2IQtMWNaZPjisoh3fQeB
         Wx21RkqbEKZgWLh909sV4GmbA/SdkLNf/J4mfrGr/5uuW/a2S8scEiWN4mU6r4LY/IFN
         iAOJyLgwpeWmb9hZDpCCzkfbg871T/UMV3a3GwYB2auF48roC2E+3FLJKk27IyNT6Xod
         Q6LXHHGNl9KKplT29w4Xfqm8Ub1IJ1IyKQYCf9PBkGqCA2v+BA3Jg0COch7NAXTMQOzn
         l1KQ==
X-Gm-Message-State: AOJu0Yx+WAeiwS9WKsYM10JdP99yH73EBL8MZmuPR4ynU0t/SFd8119X
	jzB6CrfoI0JEMotH3UePDhfsfe5kNK+UYeSjskXaHcD2lRY3l+2WyEstuRV+omM=
X-Google-Smtp-Source: AGHT+IFTGRuyv+74PtsRdT4HXvYBSReCMdPJ8cZ/xY4yZWeoo09FNCF4ofRRE/IzrJdzLqU5K2aQYA==
X-Received: by 2002:a6b:6501:0:b0:7c7:7f73:d1a with SMTP id z1-20020a6b6501000000b007c77f730d1amr1314032iob.1.1708727351288;
        Fri, 23 Feb 2024 14:29:11 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id u27-20020a02cbdb000000b004744e5a6877sm1401950jaq.160.2024.02.23.14.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 14:29:10 -0800 (PST)
Message-ID: <685828ed-06d2-4a2c-9911-05145e55ea1a@linuxfoundation.org>
Date: Fri, 23 Feb 2024 15:29:09 -0700
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
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <f8886683-4f24-47ce-a0c6-ef28466bfec9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/22/24 10:05, Reinette Chatre wrote:
> Hi Shuah,
> 
> Could you please consider this series for inclusion?
> 
> Thank you very much.
> 
> Reinette
> 
> On 2/16/2024 12:34 AM, Maciej Wieczor-Retman wrote:
>> Non-contiguous CBM support for Intel CAT has been merged into the kernel
>> with Commit 0e3cd31f6e90 ("x86/resctrl: Enable non-contiguous CBMs in
>> Intel CAT") but there is no selftest that would validate if this feature
>> works correctly. The selftest needs to verify if writing non-contiguous
>> CBMs to the schemata file behaves as expected in comparison to the
>> information about non-contiguous CBMs support.
>>
>> The patch series is based on a rework of resctrl selftests that's
>> currently in review [1]. The patch also implements a similar
>> functionality presented in the bash script included in the cover letter
>> of the original non-contiguous CBMs in Intel CAT series [3].
>>
>> Changelog v6:
>> - Add Reinette's reviewed-by tag to patch 2/5.
>> - Fix ret type in noncont test.
>> - Add a check for bit_center value in noncont test.
>> - Add resource pointer check in resctrl_mon_feature_exists.
>> - Fix patch 4 leaking into patch 3 by mistake.
>>

Applied to linux-ksefltest next for Linux 6.9-rc1

thanks,
-- Shuah


