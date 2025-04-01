Return-Path: <linux-kselftest+bounces-29988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A85A77DC1
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 16:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27DE21890A56
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 14:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0E0204C20;
	Tue,  1 Apr 2025 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="zpLBVqoX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF859204C1D
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Apr 2025 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743517762; cv=none; b=isJs9FI/6DpgGdMB1nDDbBU5pdao02k3P1VFoA8hfQ07AQCTIz/HaHVRSbI/9hzu4P2Xf76XnXHqNnzS6n5+tBI2zvY1eAJpwKo64hqkK8IN7jSEmQcjNdnk2MXw/DTqFblu3LtVpPOmL/qgUlGAW63zQ1kx2solnVO4n6yl330=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743517762; c=relaxed/simple;
	bh=XX6oOUemsawBL+SQdwNjm1O0/5SaihaOSkbclmz4J4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Py+0gAzIQCvL1dEjBMr2/HSMyf4/TBMNkEbttIUUMKxDNC24bM3O5zp5xQxNWTYm4FiukwrmdFi6Tr22bWn5UgdXPE5DUmslQQHhyAgkVFi5S+pJbQ0o+9WGT2c6YFpMscaUX/NMgLTJNXCDPpjQMWRo0L2iUjbuBYGK6Nfq2Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=zpLBVqoX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-227b650504fso112338735ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Apr 2025 07:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1743517760; x=1744122560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n6BkKDZgFevCmNfmsTeyIWH988WzbqqfzHgPc2ecmlM=;
        b=zpLBVqoXsnYHhlLLSwIo8MwhAY7HXcLKKEDtBpTCECwck663RV9JC3A6pKTTgUKE/V
         YxrzvNHJ3cj0vEGHMsXKf++Z2lV0gzc6kWJpHwe8Emdxf8GdZTZp89mTxn3fwqm68tNd
         DQ5nBpDMYKhMuGdt+OHq4kTFQExBJ3UfM7g+xGMqUAGPMk+gnO6IyW4MoHRJWKkPGwsc
         ZYyDrnfqgklpQbCLjwT708X6pvp67ggKlAe0FhEof97asm50/FZHUcaTet7DOM11js0V
         KH7DRJqQGaixFCnN2KkkOkQYQVfjl+IZI9lcJ0qRaU6IKpcmufPCanWMVeEVB0IOm77m
         aBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743517760; x=1744122560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6BkKDZgFevCmNfmsTeyIWH988WzbqqfzHgPc2ecmlM=;
        b=nNqstqvduzFAjNRLLphQ43YqOZjz4R15lFtasBUuw8Go5Ab9WoC4PmGS8uiYJhjx4+
         +gsadHCywdRG6Yt+xUMCcicjjtCZtEKwmr/WvVRABt5qt9I+9E+E06K0e5htSa3x2eNd
         iO4I2TPj+VzFtgGmDIrlBXHzpZYGS4hWrUNbzGr/BkCC77HB3CINtWDr9VKQQnmaGZUi
         vFtSr4lcDMUfAy2XFhq+8xQNPUsBdAWKINnpUNVWzCS2RYWhhWKhAi96A9keIkjvDVJm
         7sJrY7EVOL18rWOzNsskwADtUYHBIkHX5irlSi+U7vFDse7KcwJMb7ROQM1DnMkRA5xT
         knRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0uKjUTKAwSxAJbgIvq+4OMSoe3XmMav36ySmjr6b5wnvsv9hTdCGuj4vWvFyUapYEa/ybFTWW9hjtRxTctx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1CZr98ITtwCgRMYmgq60CKRsYH6iiMOo1QiAcA14Wgs8ACWcb
	Nac0IZgs4EDY9JGCUa5g2lCBe/8QFMcI3QMcw4fkOWb+F3dgm9AIjDcuf89KxA==
X-Gm-Gg: ASbGncsFytM0YAouXBolalxH0lCp3EUrKfzEE6ACU5ArMlwNxY+wgs+CeEShSl1nBkA
	DbPETPPsr0mGjcJ4HK9tUsH+5R4wM5qBBUY7RNp/0eoDhLuJ8yrNtN1n4ryYid5/4raj2Z9YLWy
	LbNM9J1whpxM3SKgrA5Tjhb8HvAJZMUocvb3uTl7g1+J24SWYDsJaOheC+3RHObMG5ElTaPKEjL
	B/98WDK/YucWrhZh62Svog7ek9YDf10r/LKmb7wlbwgBlXrtr27iqMs+9AZcz38szCFRHR3GpDN
	qECe/g+DIBmGptsl0rkoUcnR6e0mm7Pmr8EhOeksouzE4+gWm9qZbmZs199/7ric
X-Google-Smtp-Source: AGHT+IFpBZsmg7PjdBnd0C9b5R1nD+BfWySEnglDXheprt5qViicZNJCWLtqLXYmefKJWINu74z1aA==
X-Received: by 2002:a05:6a00:3927:b0:736:6ac4:d204 with SMTP id d2e1a72fcca58-739803a62dfmr18569914b3a.11.1743517759743;
        Tue, 01 Apr 2025 07:29:19 -0700 (PDT)
Received: from [192.168.50.25] ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970def16esm8949518b3a.5.2025.04.01.07.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 07:29:19 -0700 (PDT)
Message-ID: <a32b8916-616f-4e50-848f-c657bb7494b4@mojatatu.com>
Date: Tue, 1 Apr 2025 11:29:15 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: tc-testing: fix nat regex matching
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20250331195618.535992-1-pctammela@mojatatu.com>
 <20250401095349.GC214849@horms.kernel.org>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <20250401095349.GC214849@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/04/2025 06:53, Simon Horman wrote:
> On Mon, Mar 31, 2025 at 04:56:18PM -0300, Pedro Tammela wrote:
>> In iproute 6.14, the nat ip mask logic was fixed to remove a undefined
>> behaviour. So now instead of reporting '0.0.0.0/32' on x86 and potentially
>> '0.0.0.0/0' in other platforms, it reports '0.0.0.0/0' in all platforms.
>>
> 
> Hi Pedro,
> 
> As a fix for 'net' usually a Fixes tag would go here.
> But perhaps that isn't appropriate in this case for some reason?
> 
>> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> 
> I am assuming that you are referring to this fix:
> 
> - [PATCH iproute2-next] tc: nat: Fix mask calculation
>    https://lore.kernel.org/netdev/20250306112520.188728-1-torben.nielsen@prevas.dk/
> 
> If so, it might be nice to include a reference to it in the commit message.

Will do, thanks!

> 
> And also, if so, this change looks good to me:
> 
> Reviewed-by: Simon Horman <horms@kernel.org>


