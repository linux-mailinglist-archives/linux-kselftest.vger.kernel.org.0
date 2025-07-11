Return-Path: <linux-kselftest+bounces-37139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159F6B0245B
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 21:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF08A65FB9
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 19:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4002ECEA5;
	Fri, 11 Jul 2025 19:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="LgV75rzR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2381621504E
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261233; cv=none; b=Q5eMThVHql7aWtfKxa0bjthpDlgi8wIPV+mySJBr1cd6TIpioS1F8P84eTlXUKsrTWSuFjORPlKCjNHe4tRoSLniCQOH29pvN4rwBFwd8FAlLcVRrb3XpmRoAs6hKDPs6u9UrjI0FpdWYH+pGR/d0g2F/ZHG9e30zrxp9vlmjEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261233; c=relaxed/simple;
	bh=8BcgoOo7d/63OSh4rLBJxxOjFAkETtCGtPh9tO6j+qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bBWXeAGZutxZosoxVkc3sBkfDAdy3qRKr9yYa3G1o5SY1d3oWXWZRNtUDy7lMcSYM2uLqY/HKOUPeetMgB6Qezf0ZvtgX0AzSgRDqFOTZ4/SIbDA/kTv5y/B0twINaEHPEUxCLWur9tCTpYxmeW2qbVV7GorgikqdxY6JVzrZVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=LgV75rzR; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso1537159b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 12:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1752261231; x=1752866031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pw8tMXj6rdfFqpDgsVOf13IKaNoTZhX9xFiQLvS94yg=;
        b=LgV75rzRHB2Fdyj5hHJ7d9m/lI+WGAhFn02MxEeEdIKicncdN0ARzLJsqZOMNnPi2w
         sYxPHSQ1MXfX0a7gjNd8AozqriuISyCTgrDxB4/ghRZRN2N8MOD5JVnSBEOlERygKLVm
         +7gFkDp4D5EK8L08fKTK5CWoQRn73vVgjiqJKQ53Z4ZpmEY3xlA1/23QoAk/O26GcqNB
         asqDMB9IKQ/KhTLsI5N/PCWFqFlRpYzRqc6821bJiXlcIvbzCG/OLUxDS1XJRdtw6yaf
         jgA5psXfEw6AEmn4Iww4ynyiIlC3/tVWWbAcO+UwWNikB7UPegYHnmiopGniR8xN23wG
         SPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752261231; x=1752866031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pw8tMXj6rdfFqpDgsVOf13IKaNoTZhX9xFiQLvS94yg=;
        b=FRHq2eCw1o/gbJW1eVcVgIKCHvZEL+n9//2lrlGYyyz38/deT/oEKO8a6QQAPHgqQM
         664gMWRtXtL1InN0RZAZYffNVOD83ManD/A12fYSOIb9p5pWzg9Xrv3XBJPcBsTvqwIP
         IDGatju2Rgfk/dibfEjR7DSbi2Wt2fCQ/epTXnCrKY2BNpE1a6u1sMLJa1yZlKY8zmU9
         JYm94fWrXX9O1tk72dsCqhN8l4h/QaUgcUcj3tGufIzmsyibWhYXNdBYOHd+SYkk98vW
         E3VwNrbAfupThI5o+N73denwZ/zwtMmx9fNATqifISc8Cr+FZgTSRWpeXSFMQXm+WlEs
         JKjw==
X-Forwarded-Encrypted: i=1; AJvYcCWBZGx84xKL9hQCQiyWRny8qVh2x4GH+0X4DYJc+uCqqccoItpbN8MvuUHTyar3lNJeFKsfXo9P5X6Bc99/bfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw52m2mDHj4SREXynjqHCb8F/oNojhGEf+0J8ERWRZhigIST1Ko
	K+JI0aYWJ5QqnIFIu3sJ1aqZ0csEqwBkY57MTonMxXSqU5jDo39nq7EHESXIVgsyMA==
X-Gm-Gg: ASbGncuAZ4HquxfblY4jxbm/cPzqn6nUMGbo76a0V9lOjg1t4NOLFvKb8XNRAgSEQx3
	YCS3x7XzjyyTxSjW7eL3M57Cym5myAkNlh1u0Q66nACqney5P74i1nXTe9mntsovADNPy6S+1wu
	2Dd+UD6fXDZhODBPc0U0Z0shbo1BDBxuzdJPxxQCzWnWkzKLk6A36IJJxRS1stjxuw92WptBU+T
	LzKLAqLi42tWVp2O7RNglurPJUi6NoS3zWuVTZ1SCHBcyBcUEAqJUa4bMtSY7ai+Ouh1WP5pKkc
	AiyDlO/IdjVU81V1D9ja/PSXtb1dArFMhppZRsdUrVHH1focCc+emXuJ8FpmBTgvH8sEptMggba
	UahnfOVc9mga/t4vZnWoCoGl6t7jd4QXdPzidPKAixLXrjlgQSG5AR1zQrIUl0uo=
X-Google-Smtp-Source: AGHT+IEzJq7kKuHcKxI7SDNUkv1XPsZWGFsK3Uidxo93DA1wc2S/2yvIBurC0Sbg+3Bd5W2zZyl8hw==
X-Received: by 2002:aa7:8886:0:b0:73e:23be:11fc with SMTP id d2e1a72fcca58-74ee3237980mr5280760b3a.22.1752261231255;
        Fri, 11 Jul 2025 12:13:51 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c2:381b:47:222f:5788:dacb? ([2804:7f1:e2c2:381b:47:222f:5788:dacb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f9762esm6198861b3a.148.2025.07.11.12.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 12:13:50 -0700 (PDT)
Message-ID: <01a580b4-0c8d-4d22-a3e4-264335d7a947@mojatatu.com>
Date: Fri, 11 Jul 2025 16:13:42 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 net-next 5/6] selftests/tc-testing: Add selftests for
 qdisc DualPI2
To: chia-yu.chang@nokia-bell-labs.com, alok.a.tiwari@oracle.com,
 pctammela@mojatatu.com, horms@kernel.org, donald.hunter@gmail.com,
 xandfury@gmail.com, netdev@vger.kernel.org, dave.taht@gmail.com,
 pabeni@redhat.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20250711143208.66722-1-chia-yu.chang@nokia-bell-labs.com>
 <20250711143208.66722-6-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20250711143208.66722-6-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/11/25 11:32, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Update configuration of tc-tests and preload DualPI2 module for self-tests,
> and add following self-test cases for DualPI2:
> 
>    Test a4c7: Create DualPI2 with default setting

This test case is failing now:

Test a4c7: Create DualPI2 with default setting
exit: 2
exit: 0
Error: sch_dualpi2: Dualpi2 options are required.

cheers,
Victor

