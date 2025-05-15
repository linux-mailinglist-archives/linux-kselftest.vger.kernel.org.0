Return-Path: <linux-kselftest+bounces-33065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97332AB8189
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 10:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE403BB4E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 08:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F692918FF;
	Thu, 15 May 2025 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XcMCj7gs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F9428D8D7
	for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747299089; cv=none; b=ayjrNx1Pc6zoW8Otg6/Vyf9Axf+o3gG7pTkSd5OSTfxbsc9XUSRyer2dWBIXv5aM6jBeM4Mhr5BmPHP45BHYRiBcQFIV2HqNgT9ZFIBBCKhUZlNXiScGVM+C9n84OrJ5xOsxUbfzshZOXHKlNLf4OG++YYlI/RV3AklPgXji+E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747299089; c=relaxed/simple;
	bh=cRaLKFS/ocOSt0LrfepYH/n4LjEiQxhtD/kKJKa7j+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IOGZyYUQR7zUu7GbrmUgkc6qJQBmn25SI9dcW/AyN4/c8xuYu5EcNMnQNZhaQ30sqZnY3+sVI6ajPI67eDqDtBuXw4oLHFSRaKL6mh4KChJl4qD97CmYrQG3BbsROWs7U4Hdp4a93BaNbdu7piZ39Ymmumss6Y+uv32y7iDg6r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XcMCj7gs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747299086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KOj3E0hi0DP4y3uOIqOU1f5cPS83JsYc9D6Xvq8dj04=;
	b=XcMCj7gsPvT4Q9y4ysmP+tcwkIWgeiwhTZ1gHJs3vyAYywDhgHJ7JnYml3Su3RITstpjWD
	+qEO92ckbJZsKjkpyGaVti5BGolpq52vU5Bo7sj/YPbdIH37KR3HdtQuO9uMjwyNWotZtN
	wspJAe7G+xBzKa1WCJxqP6YBHXcGO2o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-laG2MXgZMG6n3598m_BUkQ-1; Thu, 15 May 2025 04:51:25 -0400
X-MC-Unique: laG2MXgZMG6n3598m_BUkQ-1
X-Mimecast-MFC-AGG-ID: laG2MXgZMG6n3598m_BUkQ_1747299083
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cec217977so4053245e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 01:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747299083; x=1747903883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KOj3E0hi0DP4y3uOIqOU1f5cPS83JsYc9D6Xvq8dj04=;
        b=r2emrfUqbd78gLrsXt60Q5UYTSOMmPxtQXxwmFQjPWgE/0zkATMhfghIMzBwgsnXuB
         j3CGBeq+rpzX+XHjsLOtnrQYBCeEECWMIGQi2ZpVnS902WjxCklBAXZdoR3FhLUeuax8
         pprXt+Cck0WNuaPGBuuVy0/h+/C+jTQmDnP3Hx27rl3x+qs+lev0XEgPTHFSkCYvGU71
         I7STlK02ti+WkVU85PKHNPl3c7cVKNzJxauJBobpsxO1TW8iXbg6O1rFSIBv6jcEc8dA
         00lR9Z9Au/Z47vFsWK32uXlI9j42wKpPrwhn+835B2i2D8IysIa43iOi4c3urDaSrg3u
         bevA==
X-Forwarded-Encrypted: i=1; AJvYcCUe4qa+BbZBrI/CDY9CMbmunzhfvDSQZJtiaa21Pej2UBsoNF8A9JI9L1rzsJDhQoDvohpYO9D1thU0S5nVITA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHwQtzeTE9iuwCDZgdYPNg28ehEV3W5+zt6KKS2xxYiEnl6YUk
	DCEFxFRNV5eW3498KytBBvkzxpqBPWUuh4imv98preHH/aWQyKnYDsL9fCoWghqwQp95wfAqyjx
	6ll2nBVMBWUgNJ325ZX2H2A0ukokRpNuTkhTFb+GlJ2y7K9qjVfifrRyahBvK6+VYJw==
X-Gm-Gg: ASbGncuGyg36gIO0jwUt6g7Dc/PMJapn6mrVgleP3hrbVOygHZSW/qPVvlYhwGmt+rr
	tO9kgxcZ9NbUcSefVuuzlab1d/p7iCR5DiABbiLeQxrYwlMq/EdLesMv9jLsyIu0MI+rP0f7oDc
	iwNe2/2tp8sLU3pafGJUs7bnBLNLrNLRisUjhnSr0YpME8+HhKjhhu4P/qCYfzKOmkRKiIP+fUM
	ocsk3v9d8i5AVbu+9glkrdkBPR/AnhPL1HbClzxZcc/GuA0mryJwpiRXftdlEPQnJdrdCb+HvaI
	MhECuKu8fv/0ZOSrHdYIPRmRHjzqzZ+edFi7y8E5Am3MaXNQILe0XcEVcmk=
X-Received: by 2002:a05:600c:4ed3:b0:43c:e7a7:1e76 with SMTP id 5b1f17b1804b1-442f96e6f53mr12410605e9.1.1747299083426;
        Thu, 15 May 2025 01:51:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK1IDiAKMJgGPDA6+WopmhoDhZGpoHt2rO7LudOPFoe7c++mdWYWTOkVWXB6G/HeyCcgPa9w==
X-Received: by 2002:a05:600c:4ed3:b0:43c:e7a7:1e76 with SMTP id 5b1f17b1804b1-442f96e6f53mr12410285e9.1.1747299083028;
        Thu, 15 May 2025 01:51:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2440:8010:8dec:ae04:7daa:497f? ([2a0d:3344:2440:8010:8dec:ae04:7daa:497f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ebd47d39sm59873815e9.1.2025.05.15.01.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 01:51:22 -0700 (PDT)
Message-ID: <44cd376a-8fee-4d82-a465-a0e80e67135c@redhat.com>
Date: Thu, 15 May 2025 10:51:20 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 net-next 1/5] sched: Struct definition and parsing of
 dualpi2 qdisc
To: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org,
 donald.hunter@gmail.com, xandfury@gmail.com, netdev@vger.kernel.org,
 dave.taht@gmail.com, jhs@mojatatu.com, kuba@kernel.org,
 stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20250509214801.37306-1-chia-yu.chang@nokia-bell-labs.com>
 <20250509214801.37306-2-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250509214801.37306-2-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/25 11:47 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> +struct dualpi2_sched_data {
> +	struct Qdisc *l_queue;	/* The L4S Low latency queue (L-queue) */
> +	struct Qdisc *sch;	/* The Classic queue (C-queue) */
> +
> +	/* Registered tc filters */
> +	struct tcf_proto __rcu *tcf_filters;
> +	struct tcf_block *tcf_block;
> +
> +	/* PI2 parameters */
> +	u64	pi2_target;	/* Target delay in nanoseconds */
> +	u32	pi2_tupdate;	/* Timer frequency in nanoseconds */

AFAICS this can be written from user-space, without any upper bound,
causing an integer overflow after converting the frequency from seconds
to nsec.

> +static enum hrtimer_restart dualpi2_timer(struct hrtimer *timer)
> +{
> +	struct dualpi2_sched_data *q = from_timer(q, timer, pi2_timer);
> +
> +	WRITE_ONCE(q->pi2_prob, calculate_probability(q->sch));

This runs without acquiring the qdisc_lock(). The state accessed by
calculate_probability() could be inconsistent. You likely need to
acquire the qdisc_lock here.

/P


