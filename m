Return-Path: <linux-kselftest+bounces-34808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981BBAD6DFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 12:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA25165C94
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 10:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF4221B9D6;
	Thu, 12 Jun 2025 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="jfXzAsN7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC60224B07
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Jun 2025 10:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724723; cv=none; b=ic0lkoaBnjiFG7pDe84BkKGaKZidyvyITaRtJQHO2bDuFq0fnO6KratXVW8cI7gkysXgw31Kjmky0I3i7bkYxMYEYnIBf4WXzYRE3RGpfGZUsPzva1/0536xjjkbDtwwe0uU0QgQ+L2dEvcvphVb5IOAnZFy7Z0UVEVGdcf7lnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724723; c=relaxed/simple;
	bh=Dxl77DbUFGK7O2Y+toGQAH36dP1XAvme2IiKzEhonNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9w+BYJtvprM3B+CGjD0qR0uknqQrn6+v6gn3dx4EbrrAsicEf3EELxpIKlAu6rImrj9k179ZO7SLVR7EoYkoFmiKy16GNESr8DZL9y8b4MOCe935OlkubQI8hAM6Jq39+Tv+4C/Cs3PtdL7YIrMXLIgbYlwzrKJ4IGsbNnTye4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=jfXzAsN7; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-552206ac67aso702333e87.2
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jun 2025 03:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749724720; x=1750329520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GvTpPQ9lrVJYF3xLC4PEE8D1vqkgVuuEEGD9w4gNmVw=;
        b=jfXzAsN73gJU4R/hqGf5oGp9CGmC+4K6Dd9m+kPUtMW0nuGg+IUAVevYDpZGlZoslS
         G+E0zVSYfnHVDvZCd7AjkYBq9gd0iMsWkmC7gDf3gt1m0IYr980nQmzb/RCdfVTbtdgr
         NIiGARDU4nINS7BoOyJBblyzNCq3yT1XQQ2H3IBBsgOXZVQPg/R6cGDd1OXId7MTTpLR
         2Ux8xrOoE1A7yUnbQPKTB747Vj/sFmN+gaXdj+3z7Urba+lojKot42XXvdGRDv2aR2jv
         5neBBVExgc10w/Ay5gGq4yHQKQuQ9P7QVR4rd9HpQsZ4BW7E3LHJaVAfRtlK7gQ0R34j
         qu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749724720; x=1750329520;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvTpPQ9lrVJYF3xLC4PEE8D1vqkgVuuEEGD9w4gNmVw=;
        b=uc583P2sAvic/sqDicf1lqlRGcoPmxIefS5SlZ7j/NYvZngbFsZs05izjL+x2SK5/0
         4g5ykN8Ku+pqfF9Orc7Eiqgn/8XbRJGgP+Mya66Z/Yns1IVdq7dNzcSH4MmyIlx5npQ8
         xAZYD7B4Zskma/XpEm9fmPPxuuRvXa6fg2AeNensDoCWdoQaWtnBC1qV/q7LQJnyxSOr
         FgDJENtVjQWymW0ZszJ0UXA7WEa2DZ0hQp4EDxc1w+vsl+OECMwrfM7EPDhpqm9etLyO
         n/wzqnsflT6sJ+nTfqSBYVHdN3P2zN15PYdH8RGS1JE7qKnRjWUMHrF8yu48X+11wya5
         bSnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMEkx6AXt0XJIlkAcMuaGR6ORbcAd5lOPe61jnJEd61VTKpBLvDf0KJFzwCx0/tkzhu2/NmyHBk9puVoIORvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLH5PCtBUDRC+y58sAK3lbCliGoJg3FCOBpPc+U5UZMfqLYOv+
	349zFbbRqtC0ia9xcqAt1At26TuE1nazHMIbuCU8heScrR3I4qbXFJxM3v4rkzDsD8A=
X-Gm-Gg: ASbGncunOdIw79S4BCTl17y4KdVBOpTwaGi98Uj4rgzMFwUgDvvkWjQA3YKUaT/5PCS
	b/dGOk3pLoTQ5cPJo6Z76HWJisH//xybpTfAR7IvvuJpBdGqyVj73GCji3MIuLD301mBV9wrxKD
	OSakLRO3SZCoiVZJEuRo0ZHxxMu6IJVrD/dkIaVBCcs7bA+zrxraU2BOntbZAonD+BfY/bE2HGY
	SOZ0pWtzqeQQw9G8eKPoI8ACQvtUfeFscw1PgCyTMnMEWVSmuIqxDMAPbl1GsFRHtR5E4dKENIY
	C8u2DgMByOOtILwNkOlRjRJJbDqnTzuzpd/YYy3jd1QQKdQRos5b6udEOyI3ENtIKMNMLQaGxlr
	i7eZJnkxwWRibroTYSFm4I4/kS3S0gpQ=
X-Google-Smtp-Source: AGHT+IFes2kLZDGZq979B/RGOBu95QnEAstptKdXBQPpJhdagQxdRARFx1bnJlxzM+/Imeis4MYrlA==
X-Received: by 2002:a05:6512:4028:b0:553:51a2:4405 with SMTP id 2adb3069b0e04-553a55fdb36mr792090e87.45.1749724720212;
        Thu, 12 Jun 2025 03:38:40 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b3316fbe1sm1572271fa.73.2025.06.12.03.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 03:38:39 -0700 (PDT)
Message-ID: <1ffa6fa1-b178-4452-b443-266b46495408@blackwall.org>
Date: Thu, 12 Jun 2025 13:38:38 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 13/14] selftests: forwarding: adf_mcd_start():
 Allow configuring custom interfaces
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
References: <cover.1749499963.git.petrm@nvidia.com>
 <29c1dfbb4882222661fa1546f125d55d72aa74ab.1749499963.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <29c1dfbb4882222661fa1546f125d55d72aa74ab.1749499963.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 23:50, Petr Machata wrote:
> Tests may wish to add other interfaces to listen on. Notably locally
> generated traffic uses dummy interfaces. The multicast daemon needs to know
> about these so that it allows forming rules that involve these interfaces,
> and so that net.ipv4.conf.X.mc_forwarding is set for the interfaces.
> 
> To that end, allow passing in a list of interfaces to configure in addition
> to all the physical ones.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
> 
> Notes:
> CC: Shuah Khan <shuah@kernel.org>
> CC: linux-kselftest@vger.kernel.org
> 
>   tools/testing/selftests/net/forwarding/lib.sh | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


