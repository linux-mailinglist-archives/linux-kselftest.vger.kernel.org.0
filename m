Return-Path: <linux-kselftest+bounces-34339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A263ACE5EF
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 22:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE8D3A8DC5
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 20:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DA320D517;
	Wed,  4 Jun 2025 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BT45kjOZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBB31991B2
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 20:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749070737; cv=none; b=DQe7l/QiQEyYaVVZG1V1y90J/tHPRjlNiKk31RWUtM+bzmNrRnVc8WUclF0EmEqBCvd8IPNiAIodN+m2Yt5b4JO1gNVVc9T/NC7+ay+rsFpOt6JlPnOmvqyiz9L/b5uEnJAXdDg0F6Gf05WPTue2zPRtymiHRjmpZeWzwZ0AyQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749070737; c=relaxed/simple;
	bh=zYGIV8gUJFeESoLXphcUN3VcBCSW38+M6xGL/Gy3T2E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IECteawGkACyM4+9UROl74un4geiOd0m7RhXF2iWecftqpcd0uVTWBz87MiVnd2cguEb0cu4dNA2ngon0pk9WBERSFt0GUfnjkPiyQhPYC/Tv8QVc6XLEiZ5kgO+BLCO4Tz/mjxOsxjqwqF3PMnhM4YUYOUgrrYG+gwmVxQ/tUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BT45kjOZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749070734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IjFlZ2/sUA2L86ngL9b3sMgbK1PseoDFjEohelsa5Jg=;
	b=BT45kjOZ/t8XRGtsMv07oy8VY8A3mim2WMd3Ot9oKOTNJBjVpjIF91NCWbyJe/UlDgFjpm
	wkwneqLK96MTgHVHzZU0eFbm6+Iwi5vyFBXDQCCQ/9o2ZID+OLUh5zfvj6ePgSGijklMOt
	ZrJVMBKlg+FjDlkWYdXqKBSxT3FfcEw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-PfrLoTkMOlKMj05N5HzjUQ-1; Wed, 04 Jun 2025 16:58:51 -0400
X-MC-Unique: PfrLoTkMOlKMj05N5HzjUQ-1
X-Mimecast-MFC-AGG-ID: PfrLoTkMOlKMj05N5HzjUQ_1749070730
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4e6d426b1so685141f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Jun 2025 13:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749070730; x=1749675530;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjFlZ2/sUA2L86ngL9b3sMgbK1PseoDFjEohelsa5Jg=;
        b=UGQzIsT61uBZ84oo25gTjhUPlsBXPgB+9PWmG5jOxCrvyCI6oh7rLGP10b7y1q0XEu
         QI1+XpNV6vWhWOgBHHk5hwuxr/V3N6iFj2WO1mV9ZIMywurZUJgnYYuY30idmdoZog6z
         WRisHgVYiacH1mndAjMBVboZriL6m30Koym8vgpgF+BHTFXbkBPlZKWhZdbRtkbTMsVm
         9EyETUebnKZEgVyYr+Uz+EpPpVCg5X2Cyla+j7fnjBasO1hLbHsKz9rzJjNvrlI15RJy
         cBgr3ynOfKV6LTsHLSwrvG+g0cDiozg8Z6qxrryZR49KbvyIO70xAnjBq1fIEKLs0uuU
         VpKw==
X-Forwarded-Encrypted: i=1; AJvYcCXtw7C86Ad6yfGGGCHLXdPNvkkwKBLsxdaxwkpolUtVsN5WuXBT8e5XjzDvxArInlus9LL6CuoWT55uIx2cC9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHX3AR0txQ1ppCZ7duJfJElaB49Z339U9DkVU7pb4MJbv13QzO
	FgkGVUCRSe/3xYJdTkt7ioBjbV7RI3mnpFVtlCqcYWYwC9G9oIX9hvPFtqhW8uciW3Ar3LOWNiw
	+S+arGWnZwWNGNHP9YfzD6Np1yiy9aO4p6UtGEDBJEou5N0zIG66Rb074kjou3Y7Pe973QA==
X-Gm-Gg: ASbGncsDbC6EtwpkfdKF6SVaJCR06mR3XvBeSd4KyX7rAFmMqNsXaku/6c4Y8v7GfRu
	RVN1jUHGwy2fLEFxwkOTmKF8gCpyeZSQquHgevkCtYVsDrGwzShCEEfYHkxhp9G9bjJx3VaWOAm
	S2GGa20tO6iWszo32vcZJI2psNiwC1ctHOkYuLrnObM1Q2pkKF8ZR58xKOevDsWE3fp7+SmUMon
	PtjIDGF4kYCenbIlKcIFEU25fv/sT+HbKE0E0BNYqbx2HDBpZyYTSRJxAIOgkIz76Cgi8AHn2/O
	8K/UGn23SN5cBhiWDCl7yjtXf7L+oE/k/goN4Tp2MxTIB2bQX4t/MMuE6EVt
X-Received: by 2002:a05:6000:2890:b0:3a4:e603:3d2 with SMTP id ffacd0b85a97d-3a526a84717mr847210f8f.0.1749070730443;
        Wed, 04 Jun 2025 13:58:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEa+Gezp8iiTLoB/KqZ3gWK809er5J18zOcbOHxYhrjEk3yJTf+o6JBeAedMNn9aSfhfWFJMQ==
X-Received: by 2002:a05:6000:2890:b0:3a4:e603:3d2 with SMTP id ffacd0b85a97d-3a526a84717mr847196f8f.0.1749070730088;
        Wed, 04 Jun 2025 13:58:50 -0700 (PDT)
Received: from rh (p200300f6af1bce00e6fe5f11c0a7f4a1.dip0.t-ipconnect.de. [2003:f6:af1b:ce00:e6fe:5f11:c0a7:f4a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe754acsm23052362f8f.59.2025.06.04.13.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 13:58:49 -0700 (PDT)
Date: Wed, 4 Jun 2025 22:58:48 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Zenghui Yu <yuzenghui@huawei.com>
cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
    Colton Lewis <coltonlewis@google.com>, 
    Ricardo Koller <ricarkol@google.com>, Joey Gouly <joey.gouly@arm.com>, 
    Suzuki K Poulose <suzuki.poulose@arm.com>, Shuah Khan <shuah@kernel.org>, 
    linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
    linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 0/3] KVM: arm64: selftests: arch_timer_edge_cases
 fixes
In-Reply-To: <adf8b877-7ca2-f60b-fb59-578c70d0e3c0@huawei.com>
Message-ID: <9b9f7099-4e81-9b74-a1ac-37cd4965675b@redhat.com>
References: <20250527142434.25209-1-sebott@redhat.com> <adf8b877-7ca2-f60b-fb59-578c70d0e3c0@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi Zenghui,

On Tue, 3 Jun 2025, Zenghui Yu wrote:
> On 2025/5/27 22:24, Sebastian Ott wrote:
>> Some small fixes for arch_timer_edge_cases that I stumbled upon
>> while debugging failures for this selftest on ampere-one.
>>
>> Changes since v1: modified patch 3 based on suggestions from Marc.
>>
>> I've done some tests with this on various machines - seems to be all
>> good, however on ampere-one I now hit this in 10% of the runs:
>> ==== Test Assertion Failure ====
>>   arm64/arch_timer_edge_cases.c:481: timer_get_cntct(timer) >= DEF_CNT + (timer_get_cntfrq() * (uint64_t)(delta_2_ms) / 1000)
>>   pid=166657 tid=166657 errno=4 - Interrupted system call
>>      1  0x0000000000404db3: test_run at arch_timer_edge_cases.c:933
>>      2  0x0000000000401f9f: main at arch_timer_edge_cases.c:1062
>>      3  0x0000ffffaedd625b: ?? ??:0
>>      4  0x0000ffffaedd633b: ?? ??:0
>>      5  0x00000000004020af: _start at ??:?
>>   timer_get_cntct(timer) >= DEF_CNT + msec_to_cycles(delta_2_ms)
>>
>> This is not new, it was just hidden behind the other failure. I'll
>> try to figure out what this is about (seems to be independent of
>> the wait time)..
>
> Not sure if you have figured it out. I can easily reproduce it on my box
> and I *guess* it is that we have some random XVAL values when we enable
> the timer..

Yes, I think so, too.

> test_reprogramming_timer()
> {
> 	local_irq_disable();
> 	reset_timer_state(timer, DEF_CNT);

My first attempt was to also initialize cval here

>
> 	/* Program the timer to DEF_CNT + delta_1_ms. */
> 	set_tval_irq(timer, msec_to_cycles(delta_1_ms), CTL_ENABLE);
>
> 	[...]
> }
>
> set_tval_irq()
> {
> 	timer_set_ctl(timer, ctl);
>
> 	// There is a window that we enable the timer with *random* XVAL
> 	// values and we may get the unexpected interrupt.. And it's
> 	// unlikely that KVM can be aware of TVAL's change (and
> 	// re-evaluate the interrupt's pending state) before hitting the
> 	// GUEST_ASSERT().
>
> 	timer_set_tval(timer, tval_cycles);

Yes, I stumbled over this as well. I've always assumed that this order is
becauase of this from the architecture "If CNTV_CTL_EL0.ENABLE is 0, the 
value returned is UNKNOWN." However re-reading that part today I realized
that this only concerns register reads.

Maybe somone on cc knows why it's in that order?

I'm currently testing this with the above swapped and it's looking good,
so far.

> }
>
> I'm not familiar with the test so I'm not 100% sure that this is the
> root cause. But I hope this helps with your analysis ;-) .

It did, thanks!

Sebastian


