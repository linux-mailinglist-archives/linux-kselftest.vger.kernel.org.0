Return-Path: <linux-kselftest+bounces-13478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC0092D59E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 18:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE8928A036
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 16:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867E5194A65;
	Wed, 10 Jul 2024 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e9SKrC+m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA144193444
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2024 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627219; cv=none; b=iKixsopfm8KmicB/KQ5Pn72kYuY/8gG/CvQ0bAGBg4ZaKPYH1VLnIkoNifwIY4VyUTdt5sAhQQ/khl/4wkBbTGjrOLf9TN9zST+80DLI/qRi4Q2Mdg/r/U8Fo0RH13rf2H0ZPi7vF+PFvVaAPh5hNQidQEX0dO7jM+C+1yZ1zEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627219; c=relaxed/simple;
	bh=3h57l/y6Mvn1rG8ezXrXhQIZRIOJHBI21s0g0oMIXdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Is0ctw+AcZz22b/lMdLo9ePIkDmnW4jYXffCzY1OTyHUZs7nTZY33GAIZvcn+sOh+sqo+VGNVeuH79O6EwnupOXiGgNwQB5B5DkQPWmzgC3T4x+X6fj/WPIyKH9AH1p1OOoWZ3T8PHerdHpScLG0sBqs2bZkcEUts8PgATN4NAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e9SKrC+m; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8045e14c32bso4691739f.2
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2024 09:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720627217; x=1721232017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1gbmGNAwMwrZPiyjPeTzrjzknJ3xgxQs7BtZS2IrL3g=;
        b=e9SKrC+mmKPaz+ZDPQRSM7jVa45VafcKj7nA2zyTM3IkBOglEYrn/2tF7nCE/YkDpq
         3Mi66j/dCfVsSTVIf9FfOC53sHF8xUCxLrYdv/8xQGkfYOd30PBmXSewImcGSWPCnrbN
         RFiPJqebetZwuwIvnpaMSN+dlCcEqNeXF0+Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720627217; x=1721232017;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gbmGNAwMwrZPiyjPeTzrjzknJ3xgxQs7BtZS2IrL3g=;
        b=BT18H78zkFktnRXDQftDKhlxUISinyM6IAcCU1zbZxvXiu5Dvy8XCVXa+IeRf48KGs
         FdHlIMa5f8hxAiL1NS/qIdFDSDjbHU5r4c21MF/XuNhfZ6tZVJpfOS7ogL5mcpGi15C3
         kCF8QEdAeIFXu2BoOqZad6V6gG5MjnPPiS9Ft8TDnR5RfDG4E5uV0TXLydhlFpMR49WT
         njyWCL1mTG2SSY/ACAMEE0R8hbqfaUNgDDcwalXBdx+aRsrBRbOE83AKX/pmtOlbSptm
         X6Kc0rVKF0mQIsHJN81yscM00vRD3/yzC+Ro3iEM2DQCJlbFhNEtnOjcZDa0eqfa46iK
         NsBA==
X-Forwarded-Encrypted: i=1; AJvYcCWQF4ghAKxfUU1pRzsqbKUXZC40RLDA7GIm5JYrkh+VgnESJL50BA9TWPnJdhxLmHvqJld7MzAdtqXf7IS4h5sexqoY7fvRLokT+YnPnim/
X-Gm-Message-State: AOJu0Yw93NlGXhEiARM1Ip6b9tJeIX11rOAqlxb9s8yP5hDb7FFi+SiR
	/foHnWqdqZxkN1XaniRdbAurwQdvN/meZADpuwWSazs4SEJMYTyY/5iaRr6ggx4=
X-Google-Smtp-Source: AGHT+IE9+Wnqh1spYJTooseA0lSNUqCfK7Pe1jdrMZSx8SbhIcReIP8jiY3PtdkaoIvnEKyUOYV+gg==
X-Received: by 2002:a6b:d117:0:b0:7eb:2c45:4688 with SMTP id ca18e2360f4ac-8000311edffmr535758439f.2.1720627217027;
        Wed, 10 Jul 2024 09:00:17 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1af8763sm1221907173.9.2024.07.10.09.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 09:00:16 -0700 (PDT)
Message-ID: <8e4d88f3-a45b-4d30-bec6-75636c854d43@linuxfoundation.org>
Date: Wed, 10 Jul 2024 10:00:16 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/rtc:Fix a resource leak
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rtc@vger.kernel.org, shuah@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240710071650f7265b40@mail.local>
 <20240710074309.6647-1-zhujun2@cmss.chinamobile.com>
 <20240710075513332c564f@mail.local>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240710075513332c564f@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 01:55, Alexandre Belloni wrote:
> On 10/07/2024 00:43:09-0700, Zhu Jun wrote:
>> The opened file should be closed before exit, otherwise resource leak
>> will occur that this problem was discovered by code reading
> 
> The question is still why should it be closed before exit as it will be
> closed on exit?
> 

Zhu Jun,

+1 on this. I have responded to your other patches that do the same
in other tests. There is no need to make such changes.

thanks,
-- Shuah


