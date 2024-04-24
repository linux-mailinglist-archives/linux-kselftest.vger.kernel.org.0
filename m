Return-Path: <linux-kselftest+bounces-8770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A7A8B0B76
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 15:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E031F27FC2
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 13:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A111515CD7B;
	Wed, 24 Apr 2024 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ILc4bfp8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9BA15CD51
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966576; cv=none; b=pTc9PAnecrRgDj5uJd2UzlB+CIx8mV26SH4tE22CDJIHKbufYuyA/M7lhHpff/REN0ib69ktFsEWkWkTqi7zwL9PczInibruQf0PFHQVWtaAJ5uu7oNuSvoYaxvxMwUOZUXIM3Nr1+a4Dj3Z2qM8J4ZJlH5ePg9phQzS3cItlT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966576; c=relaxed/simple;
	bh=BnENuuyvSSnIAyXgtHVPeaIV5FuuSZ0qrZUG3zD7EJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhejNB3f35GsdL5nmPpkUBK+Ac7doVrdDz2nCDk5JUttODevXpdN6jkOdkC5Ucs5pyZHge6slLRakbMvlv5ZP5kMunOUNCRulvxN5AjkUP8twvLpegcmyMQfnadNiWs9SDtlvG/p+wbID1aGOLZCAsGNDUBX2ppZ1vQLTVyTcTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ILc4bfp8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e85055aebfso1516775ad.3
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 06:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1713966574; x=1714571374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JCs36F0PWzr7cYBSvNxUQg6C6ceYxo7oYx4QjH9HBWk=;
        b=ILc4bfp8fUrmB+qMM2c9nlvnNBFqIbkhrCEgX2YFwXXNsTL91XDTDGAK53fhHBsf9G
         UUdmj1Xl8+D1HoazinJIsNm4qZyJiCBtM1SnX7zVFDOPlmNqdYphGzuBoELhKQxhmnlB
         ubU24Wk2X4BQDrefkCPFSt2Ow7Y9EI28TdudM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713966574; x=1714571374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JCs36F0PWzr7cYBSvNxUQg6C6ceYxo7oYx4QjH9HBWk=;
        b=TA7IzBxPlLhAMPnSRxYP8bNKgoAmS/f+IGjOkof3IoeMx4Jp1656LxG735wrdhjtmm
         jXZCNOmwcLWSxMDVJFRS1dPqbC+eKFV6k+l0NpIf/e8E0RuMKrzszjHhVuiqjOGw2uIX
         QwXjcX5usUNbGy/5sfThuCeKjWwnddhSLk2KL+Jmb9Dz+K/qpoZuccDP9/tBGbbiM/yg
         ltrrSLeG7FwR4BUEKgfiUDifYm7NNRKOPBAPiFPXOs3VOMzZD2DrfFP+/m+Yal/sqvlw
         olZdKpT64EctdDbqBwqmXvt/050/HVh9S76tIYPUUVzAlft8g7L6WQUvypjd5IbIXdUj
         4ckQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuHGLbkmiDgc1XAH9D71oi25Ic2yqNpFmUPJjFgPz04T4MlXoOeBjQ3cIp1oKNceOphpW1tAzSM/y3r4nVE+K+rWpek8Dvm8GXCaik2Eqq
X-Gm-Message-State: AOJu0Yy7Z+ip4mMMtZJ5HjIPEsmbnRLHNxsUHCvxtGEht9J4+fFV+YhY
	jpUYRXk7ZONGO7phXv8WwdZY2Z/9vZUEuO8qhMTsDlAMrfd+D7KtEtiUztwBC7AR1/ed6uBUXMR
	rZuZGSQ==
X-Google-Smtp-Source: AGHT+IFiRaCL23pbSU0/Yn84eBCvHp/itg92YZttsTK+6l+gegZ0L2tqoYX/jbPAg4iNh82grdXwqw==
X-Received: by 2002:a17:902:8495:b0:1e9:9ffb:bab with SMTP id c21-20020a170902849500b001e99ffb0babmr2583007plo.5.1713966574470;
        Wed, 24 Apr 2024 06:49:34 -0700 (PDT)
Received: from [192.168.43.82] ([223.185.79.208])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902780300b001e7b8c21ebesm12087790pll.225.2024.04.24.06.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 06:49:33 -0700 (PDT)
Message-ID: <cc46c002-c771-499d-96f7-38db978ae975@linuxfoundation.org>
Date: Wed, 24 Apr 2024 07:49:27 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/16] selftests/resctrl: resctrl_val() related
 cleanups & improvements
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-kselftest@vger.kernel.org, Reinette Chatre
 <reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>,
 Babu Moger <babu.moger@amd.com>,
 =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240408163247.3224-1-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240408163247.3224-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/8/24 10:32, Ilpo Järvinen wrote:
> Hi all,
> 
> This series does a number of cleanups into resctrl_val() and
> generalizes it by removing test name specific handling from the
> function.
> 
> One of the changes improves MBA/MBM measurement by narrowing down the
> period the resctrl FS derived memory bandwidth numbers are measured
> over. My feel is it didn't cause noticeable difference into the numbers
> because they're generally good anyway except for the small number of
> outliers. To see the impact on outliers, I'd need to setup a test to
> run large number of replications and do a statistical analysis, which
> I've not spent my time on. Even without the statistical analysis, the
> new way to measure seems obviously better and makes sense even if I
> cannot see a major improvement with the setup I'm using.
> 
> This series has some conflicts with SNC series from Maciej (Maciej has
> privately agreed to base his series on top of this series) and also
> with the MBA/MBM series from Babu.
> 
> --
>   i.
> 
> v3:
> - Rename init functions to <testname>_init()
> - Replace for loops with READ+WRITE statements for clarity
> - Don't drop Return: entry from perf_open_imc_mem_bw() func comment
> - New patch: Fix closing of IMC fds in case of error
> - New patch: Make "bandwidth" consistent in comments & prints
> - New patch: Simplify mem bandwidth file code
> - Remove wrong comment
> - Changed grp_name check to return -1 on fail (internal sanity check)
> 

I can apply these for Linux 6.10-rc1 once I get an Ack from Reinette.

thanks,
-- Shuah


