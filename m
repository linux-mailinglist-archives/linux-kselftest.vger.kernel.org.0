Return-Path: <linux-kselftest+bounces-21647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524A19C10F7
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 22:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09AE91F22E0B
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 21:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA1A21830A;
	Thu,  7 Nov 2024 21:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SkWie1fv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976561CF7BB
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Nov 2024 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731014775; cv=none; b=fBL3PEaTlv+FHR+5yi6kRtQMK0WFvo0XpEW6orqp2vuToWcSEEeT8s/c7tdIRCnfo0XktYvpa2IvRMWRbBfqg4wM1UisEAxWnV6BpWgXnVID6mxvtWdCj3veQOztyyz0lnc6FPMsAow0USN+a/RhE5hyZm+AdyP4mLQKaRNsXlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731014775; c=relaxed/simple;
	bh=JK2Mq1tCflrs5SZhoBpudHBToT640T5P+A437Xkwwtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LC94bezNUXrRLxNM650kku96UBTudp5pZPt+aZ3JMk80kItoYmFGx0Yr2wC3TJ/o1VjpWF8jriyyWxq/d9RLU5X+zo+VFtYuEwbZolfPtLAQt0G++RdyTQI9TD+ENKfrz+7GcaxyUO4YV8F9bmCzRRke/vK718s1jUexajaXh4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SkWie1fv; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-83aff992087so51793539f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Nov 2024 13:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1731014773; x=1731619573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SbJO3dbXNpQnR3iJHZxSHK7iyUPlFTSlGwkLGcjOHeE=;
        b=SkWie1fvga/z2K2GQbLH1hJsg09EXVyuX3/LpwIt9OhJYSJXZfoJupZi81JWoDaOO1
         TxYCMI7TFCwBjJGY+VtEQnvATDEHLZEhcKAL89O+SL4sTwSafE2hllRwJj+lXSUdr4xp
         JTbcjgVVWe06RUxe0Fkq+NtEAOvjxSuMbO/rE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731014773; x=1731619573;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SbJO3dbXNpQnR3iJHZxSHK7iyUPlFTSlGwkLGcjOHeE=;
        b=YUaHYU3o+TDKzhkLDFuKpNSYedtfMk3S0ixlW4HGDNGsvyJxs75oLdn3AgHePizm6Z
         FRinI9P6a1daw5CaLX9JgoIeECDZQbEllg2SJMEMez/UO7Btpn8VGRX4/UcQHS1ajDce
         DUsZcpf94Enm2uHFQFhemIf/EEl/gSEwkBUC4mrkDKqhuav1Es+rucOtbAjxv+QqxBSv
         Mioeb/YV6puL1Zq9umdd5dhkF4kbZJTys4hU3/N3GDEw8kCjb0mOGsr8UOhejmQQmvCU
         2niVIJw1R4WIgJqUcUnUa1hU9irZbN/BdtRj6Yy8mrFA5jzfKve6e494tSHOh2Lrgasl
         GDNA==
X-Forwarded-Encrypted: i=1; AJvYcCWHbthYsij2Cnw4dJyyuJntG1pbyZhIyiZ6O+RP1CltevjIhJ51k9Yb9Sg/E5R443/bXFDg6IO2My682n9P0b4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCkQl4CyHKYnSJmwdg2q89x2sCb+ywYgFnGe/dHd/Nd01FY+Bo
	Qe2HnfQxlxYIhL4HoEIzdwpT3G1UbJblt9iClSBUBKiesejWqxB95ZhNrwC0fo8=
X-Google-Smtp-Source: AGHT+IGv1W0IBGbUb1SRVApID2NMF4i/V9ewtBGRHdjk7cvd+POlTLdWckQhOcqpxXqpRi1WIif7Yg==
X-Received: by 2002:a05:6602:13c1:b0:832:480d:6fe1 with SMTP id ca18e2360f4ac-83e03069279mr58064539f.0.1731014772676;
        Thu, 07 Nov 2024 13:26:12 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83df50670fdsm48482339f.23.2024.11.07.13.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 13:26:12 -0800 (PST)
Message-ID: <50f87b47-e326-4e87-a1d4-cc24ea70f432@linuxfoundation.org>
Date: Thu, 7 Nov 2024 14:26:11 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Define PKEY_UNRESTRICTED for
 pkey_sighandler_tests
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
 linux-arm-kernel@lists.infradead.org, dave.hansen@linux.intel.com,
 yury.khrustalev@arm.com, will@kernel.org, linux-kselftest@vger.kernel.org,
 Aishwarya TCV <aishwarya.tcv@arm.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20241107131640.650703-1-kevin.brodsky@arm.com>
 <96cc8ce1-1f64-45d5-8567-eb2adba1b47a@linuxfoundation.org>
 <Zy0AQnqIWRM8s9kb@arm.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <Zy0AQnqIWRM8s9kb@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/24 11:00, Catalin Marinas wrote:
> On Thu, Nov 07, 2024 at 09:50:20AM -0700, Shuah Khan wrote:
>> On 11/7/24 06:16, Kevin Brodsky wrote:
>>> Commit 6e182dc9f268 ("selftests/mm: Use generic pkey register
>>> manipulation") makes use of PKEY_UNRESTRICTED in
>>> pkey_sighandler_tests. The macro has been proposed for addition to
>>> uapi headers [1], but the patch hasn't landed yet.
>>>
>>> Define PKEY_UNRESTRICTED in pkey-helpers.h for the time being to fix
>>> the build.
>>
>> What does mean to say "time being" - can this be removed in the
>> future. If so please add a FIXME so this define can be removed
>> later.
> 
> There's a dependency on this series:
> 
> https://lore.kernel.org/r/20241028090715.509527-2-yury.khrustalev@arm.com/
> 
> Which I did not notice. Typically the uapi patches are picked by Arnd
> but first that series needs to be reposted with the comments addressed.
> 
> I think for now we either merge this fix from Kevin (happy to add a
> FIXME comment when applying), change the kselftest to use 0 instead of
> PKEY_UNRESTRICTED or revert the top two patches here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/pkey-signal
> 
> I'm fine with all options really, it's not essential that we get the
> kselftest patches above merged in 6.13.
> 

I am good with taking this patch as is with a FIXME to cleanup
later.

thanks,
-- Shuah



