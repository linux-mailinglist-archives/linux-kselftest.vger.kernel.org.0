Return-Path: <linux-kselftest+bounces-3212-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AAE831E1A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 18:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F423283BFF
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 17:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDBC2C6AB;
	Thu, 18 Jan 2024 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="E91rWm+Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E492C841
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Jan 2024 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705597471; cv=none; b=HGjX1n/+7HAqTOgQW0l/IJqW4eC88UplMQLBS1y77RAaya5zm1NQ8249D5PV+8PYxMJqDbUjp/tO3dFBBuam7di0Kn5Sa86I8XSmxvHgcSgkVu940pjh1bXyQM3m5i3GNy3Jp6MUHZHZSQ0IaTHDbmdvSXgsp2bsMQPdNLrFZ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705597471; c=relaxed/simple;
	bh=g/rRRWlnTFqnEs2SFfwruUS/ClIg0NzA+8JMI1zfBgU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=WOFZpmzqwAgkmjaxoFtgtqpwvfLgGEVrLLvJkSQ+jG58CkG/mQ4e+BxL5iF6I83kCDyeM/8TepC6OrlBnc/YOWl4WHsUapBXJ8FQwrTW+ZBDSYINXuUplss7KDLkRxZsyE0namb5leXyMOD+GnD0rpkndmfz/6HP2RrorEqbqNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=E91rWm+Y; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-337b8da1f49so2748603f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jan 2024 09:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1705597468; x=1706202268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Spf2iYyM2yyAQqYpbtyryjRjyyX6h/O61i58Cf5ljuM=;
        b=E91rWm+YSP/bcx6/NlUa7zuWBMkAjpAEWdGYFu6Af5yqV4m8rAIxry8YlglUil0uxx
         MYo39f/7mQwFeRZOpN+tMq/4ncpUN3RbaahUCesR/7OvHi/5QGMoPoXNngCCbDFJGaos
         XvkteUP4JQVjtbJFZ3FlaYimXL4Xr/27Ue5PVvJuowQnmumggxdgelzgEPOYGCHUPQUJ
         mMzu3C3o4cmCzORgMvTn9/4U+1ZsF3aj2x0Z5ifkE2eaZoFKWpIzAwyt6e8jmrm1Bxfb
         eCULs6JOovXx/w5nDJyGMoAq0WBid3G/keE0ZyKfd4URbwdTNG/Olvz1zEe6B7cC9Fsv
         gmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705597468; x=1706202268;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Spf2iYyM2yyAQqYpbtyryjRjyyX6h/O61i58Cf5ljuM=;
        b=aEuP0HqcGkhg+cMnio5ZZyDJx4WO7pWdeEIitql2M9rSEG3aysnT/pbTTwTHJzvCDM
         qLh8jYG+NtwhQLyDBSCrkaTcgrlSGV6amiJoknaHV9wFORGSjtAcMhYaiWbIxGrd5qMm
         3YhH8nz5Auq8rGw6jukaUQgsedyjR5DRJPwAuS2ItpRfeom7SHvqJUMoqKOkbEPxTJBp
         1VlM6Ww9/FcsGuZGt+XNJ+FyY3dlnUtPrSJiaiGNWqQYYMJYWMfW0CjhDfXFAAlwycQL
         YSxKdVlaXe0GPPY93TN3Ej2qsjkiDvyZTxeVNhMOlc3JjFIfcUXnqpzKDHEiotGch2rP
         oP4w==
X-Gm-Message-State: AOJu0YwqmoouBLw5pQ6Gtc+0YUIPvGhKg8DYqbWTuEdK7k5EDSDQQ8b/
	JP3499W3MbZB8/4svsjZUcMt2TOsuxz3mMqm16x1jhZvnMyx8QKBy+wldpzpYw==
X-Google-Smtp-Source: AGHT+IH3FQC5AzBxXr/WrOnNom9+bRpYrvzb1p86jgCnhI7ov37Cf1NcCipvj61hKcTHgrF3bHv7XA==
X-Received: by 2002:a05:6000:18a:b0:337:b057:c1d4 with SMTP id p10-20020a056000018a00b00337b057c1d4mr474170wrx.215.1705597468020;
        Thu, 18 Jan 2024 09:04:28 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id q9-20020adff789000000b00337d6aa3912sm1021082wrp.10.2024.01.18.09.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 09:04:27 -0800 (PST)
Message-ID: <358faa27-3ea3-4e63-a76f-7b5deeed756d@arista.com>
Date: Thu, 18 Jan 2024 17:04:25 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] selftests/net: A couple of typos fixes in
 key-management test
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>,
 Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com>
 <20240118085129.6313054b@kernel.org>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <20240118085129.6313054b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/18/24 16:51, Jakub Kicinski wrote:
> On Thu, 18 Jan 2024 02:51:33 +0000 Dmitry Safonov wrote:
>> Two typo fixes, noticed by Mohammad's review.
>> And a fix for an issue that got uncovered.
> 
> Somewhat unrelated to these fixes but related to the tcp_ao selftests
> in general - could you please also add a config file so that it's
> easy to build a minimal kernel for running the tests?
> 
> Something like:
> 
>   make defconfig
>   make kvm_guest.config
>   make tools/testing/selftests/net/tcp_ao/config

Yep, sounds good to me.
I'll take as a base tools/testing/selftests/net/config and add any
needed config options on the top.

> should give us a suitable config. Differently put it'd be great to have
> a config we can pass to vmtest or virtme-ng and run the tests.

Will check that it works with them.

Thanks,
             Dmitry


