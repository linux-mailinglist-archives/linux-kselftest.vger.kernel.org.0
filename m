Return-Path: <linux-kselftest+bounces-20506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E1D9AD568
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 22:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66EBCB22C30
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 20:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11561E7678;
	Wed, 23 Oct 2024 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f1DwpIO/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273871E5735
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Oct 2024 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729714577; cv=none; b=kRtxiXASoiHe4vS6m8wRCgc3fH6E8mRQIoMTygyuHA7jewsjlo2L/YZvOupWkZPnsy2QKg898JDFoCxFU74KYK2kcSbqxCB+HLoLRd7UFneG3PJ6T5q2IWWuwObnqWp7XuP+WGeGToFWpgxiMugbYa7ELWz3wIRnT4M4OmFamEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729714577; c=relaxed/simple;
	bh=t+pBwRES099gjbIXm7AKphItx7J8kvYpUlt7TQ7aHTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J41ncCW1Frn2xCtbYTOdMHyX0IlGMWFHopn3lXtez6poAha3HTEW+mMOymjL73R3T54vHQuIk2DcI0/boCmT8uOX8+GKXcbfOJWOKpPhXzOUwY7C4wS1UsLzTD6wCQzdA5sLAGAp+RPd4vLQ7EjVPr2n+HRbjGh+oJD3PHUHtf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f1DwpIO/; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-83ab94452a7so6799539f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Oct 2024 13:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729714574; x=1730319374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8kDCSZhRA7POBerNB1e7kbi71ZsjNfGfCME90BjKh8U=;
        b=f1DwpIO/aOuuk/h5qA/YXkBI+HjnYIuH5SCbgaiXXzKGIlzvPT59WPMSoqf85kaCeD
         gmFatEdohan57nZBqC74W9mRbKO+yGb20Rmt+UT8240/7Fj7pqQ5CG0xWgpf0ccKVrR7
         sX39l8GcufjrYRI62+pSi4OTTwPXv6F+7HmN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729714574; x=1730319374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kDCSZhRA7POBerNB1e7kbi71ZsjNfGfCME90BjKh8U=;
        b=nmD2/6r4Bk+mFBmNwZ7FUZXLiFpNIcfTH+cTSD1bWE9HAcOFJu3r2pDdwGwiA5GwDw
         Iz8TCjVzdEeEM2oVs/Y4t2xjkHqGTQQUkzbwJayQRfgxF+idXYv/BWAVLsRyastAGH/y
         DJEBRSh/NtaUHs+Uli0f2P7+0145AJhepdBEdl+5pm+Wlb66vestDpbHe0Ktj6VYMN2l
         SUfdddR/USXdayL2ONVXJ/9aSCI/zEDSsSxffX2KQwqu75jjiYsUhyPMLtBjl24KFBRE
         5ThszxuJ6Veldr8L7jdrcCZtxiE+GFOApzjiqY5DLK4n7r9wYlESccyOmz+f7oGu6i/Q
         uS+g==
X-Forwarded-Encrypted: i=1; AJvYcCVc6a9vXB8/gY4Ry2EyL2RzerhIvHOuCUmLvZ2QvTsL2iWZcYgFIvB0ye8qs/CsaDhgjgvxhfOBy2m/U1I9eds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/gD8HQ7lxH81Cr1xeqC8JMOwMZYpyaKsaf445moxxkecLDxFN
	Oj9nyug8bZO7T5yXG4wecNYHn1RS5AijBo314AxRBbh+aXFxjWQiCXBP1ptaptQ=
X-Google-Smtp-Source: AGHT+IFxlWgPQhu1E+mBKyy2YSke5qTMx4jKDLlyDjXa5E0AFKuVNbwNPENGDajCm726+x5G05keqA==
X-Received: by 2002:a05:6602:2c94:b0:82d:16fa:52dd with SMTP id ca18e2360f4ac-83af6192782mr301558139f.7.1729714574207;
        Wed, 23 Oct 2024 13:16:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a65e512sm2226878173.156.2024.10.23.13.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 13:16:13 -0700 (PDT)
Message-ID: <2b3052bb-1235-4785-a7bb-a993332b4d83@linuxfoundation.org>
Date: Wed, 23 Oct 2024 14:16:12 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] selftest: rtc: Add to check rtc alarm status for
 alarm related test
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Joseph Jang <jjang@nvidia.com>
Cc: shuah@kernel.org, avagin@google.com, amir73il@gmail.com,
 brauner@kernel.org, mochs@nvidia.com, kobak@nvidia.com,
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-tegra@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241021032213.1915224-1-jjang@nvidia.com>
 <202410221601561f631bc7@mail.local>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <202410221601561f631bc7@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/22/24 10:01, Alexandre Belloni wrote:
> On 20/10/2024 20:22:13-0700, Joseph Jang wrote:
>> In alarm_wkalm_set and alarm_wkalm_set_minute test, they use different
>> ioctl (RTC_ALM_SET/RTC_WKALM_SET) for alarm feature detection. They will
>> skip testing if RTC_ALM_SET/RTC_WKALM_SET ioctl returns an EINVAL error
>> code. This design may miss detecting real problems when the
>> efi.set_wakeup_time() return errors and then RTC_ALM_SET/RTC_WKALM_SET
>> ioctl returns an EINVAL error code with RTC_FEATURE_ALARM enabled.
>>
>> In order to make rtctest more explicit and robust, we propose to use
>> RTC_PARAM_GET ioctl interface to check rtc alarm feature state before
>> running alarm related tests. If the kernel does not support RTC_PARAM_GET
>> ioctl interface, we will fallback to check the error number of
>> (RTC_ALM_SET/RTC_WKALM_SET) ioctl call for alarm feature detection.
>>
>> Requires commit 101ca8d05913b ("rtc: efi: Enable SET/GET WAKEUP services
>> as optional")
>>
>> Reviewed-by: Koba Ko <kobak@nvidia.com>
>> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
>> Signed-off-by: Joseph Jang <jjang@nvidia.com>
> 
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
>> ---
>> Changes in v2:
>> - Changed to use $(top_srcdir) instead of hardcoding the path.
>>

Thanks.

Applied to linux-kselftest next for Linux 6.13-rc1

thanks,
-- Shuah


