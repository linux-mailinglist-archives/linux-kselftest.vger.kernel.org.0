Return-Path: <linux-kselftest+bounces-34340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4F2ACE613
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 23:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968B83A8FC4
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 21:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC451DC9BB;
	Wed,  4 Jun 2025 21:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ln9ByfMW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4989111BF
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 21:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749071843; cv=none; b=vBZqUsk4147frSi97kVDr4c9GJ1NvwZUbT5SNfWyp3+u1FpCBwqDHt1vyoWmYZzgXiq6sViOgC47PGzoxRP+nrpoQ5KwtSZ14MRL28q/p7kXlqtuezsLUwZbnzZqadvxZ/8RIm6n71JtcquGJRQQxxrSbSKJnTcgTwDnR4yCEPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749071843; c=relaxed/simple;
	bh=CXCvGL5hSf5ngZ4A2BceMmShZkAeoCIwyR3G4t932uk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qtVoKOaEN9qF+L72fJ20R2PIx4pimJhfZjMKwflH610WKuYnlzX9qsRtYFmNS5fRjaTNxCN8RmJ2CuOn87g8zXSbUQzBkJ2AuUj8QnL3RuxbijsEihB/UP5ZVbydxHx5qVAFnzgQg/kWjrbECX+lI4KfMP2tWEj7EY8WDIHmmCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ln9ByfMW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749071840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3eaIlD6SgIwBKzFRuDf45UmSCQNYGCKtzx7DOTC83A8=;
	b=Ln9ByfMWAeev3KPElUgbTjACOGbHqbAKXJtYDpAP63/M9bK3QGTkq1CYZaYvW0+xWsnqOt
	9doYLhmzw5y9QiZBwzDTNesmW/VSw0ADnKXHwaSH54aUMKRvGFevyUjwmbFz1oc7+VKvPO
	2b+Bz06anbmkAYN1RASE9S0IJuHCxqs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-Llf0-FVnOIW-XZ_gSCgOiA-1; Wed, 04 Jun 2025 17:17:19 -0400
X-MC-Unique: Llf0-FVnOIW-XZ_gSCgOiA-1
X-Mimecast-MFC-AGG-ID: Llf0-FVnOIW-XZ_gSCgOiA_1749071838
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a50049f8eeso212778f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Jun 2025 14:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749071837; x=1749676637;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3eaIlD6SgIwBKzFRuDf45UmSCQNYGCKtzx7DOTC83A8=;
        b=cggB6ehuxGmpoq7RC44o/4xWMiAmlNqRwKmP2fIhK5h2genoOY4elaLRFBflgfJSjT
         //HqJuUSkkKmDaJ1o8fyxt4w6A6D+HbNfgdTFLYfWomRIMOlRLw+GLWAOzJqxo0M/7nv
         0Jk7isNJ7kow+sLFNRaWzOXkB062uvhN0zd1mS6HI7JG4kxo6n/yTJJh2LGrSurEN230
         foLo6Ax5UOgs2AccYF1yTjhp4zrqANQ2zwzmCb2xpxj2ePbokbqDf7eyrb884UIz29TO
         z88FRIIuO26oyAgkJo9kIT8ro3WNnOs49U0vRDcpUjXlgw4FH4v470gnqeaYn/rVpRtI
         lWtw==
X-Forwarded-Encrypted: i=1; AJvYcCXp4Dr5z7P7+d90hiv8cg9lN/IXoGD2pCi58CLLP/I0K6SFZVv2xA3d45K/yir/BXgINxJ2O+ErMB7sgqiw6gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZM1gjLNKQOh/skL6WGIqfMKVdw7JILRuAjyAn2PFmceC8G4AD
	55uMi4+v1Aai0k+uam/Q4Du1QeBwo20eXSy9kpYRQts/7lBqOHP4CvIBQGyiEch1XIB2o0gAI95
	BIemeyqQOmB3p7MpzwFC/JTlzrC90KJXSBBkWSzStFXlSPPHAOusuNhnl+KvjHhr3Fgc1HvUMlc
	jX8Q==
X-Gm-Gg: ASbGncvu4qF5He/GC5XPDWQSQkytDQ7S2Vjmtn9qKeg6s1do5HxW+shyei8sexJoh+d
	f6LRB/UDIEv1Y1nQuDwmumWAYBxFi5uiLabZJHipEL1EdoqP7aBmJ8yaLg06bBfqNWFCw/w+hHo
	QzrY+7fHU4cbuK68ycwdLkjJZ1ZMDLGhpzPV5xVfMe1oRuJSAcAvBSKAWqjV0/Ce3NkvvF+TX4W
	djDsvMaOaGsoT952tMCsw1ftq7aRdQfo9LfD13JRCmlfs/EpVUynsHiyJ1YHsfflSsAJDT3mTmD
	s6FuR1KTUL5Q9kA6NGgpIICrBSTQ9ajt0LKnJmdUZ9q8zq1Yq0IQlkfDDjbs
X-Received: by 2002:a05:6000:2512:b0:3a4:d274:1d9b with SMTP id ffacd0b85a97d-3a51d92f84amr3541711f8f.25.1749071837465;
        Wed, 04 Jun 2025 14:17:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/w3mTJC6PzaXkAlaJcofTyt+hL5Id0Z9sQ5spOyW0fO3Rb3p4l0Y62I6sWoWE4eFRofNvzg==
X-Received: by 2002:a05:6000:2512:b0:3a4:d274:1d9b with SMTP id ffacd0b85a97d-3a51d92f84amr3541694f8f.25.1749071836994;
        Wed, 04 Jun 2025 14:17:16 -0700 (PDT)
Received: from rh (p200300f6af1bce00e6fe5f11c0a7f4a1.dip0.t-ipconnect.de. [2003:f6:af1b:ce00:e6fe:5f11:c0a7:f4a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6c842sm22506811f8f.29.2025.06.04.14.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 14:17:16 -0700 (PDT)
Date: Wed, 4 Jun 2025 23:17:15 +0200 (CEST)
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
In-Reply-To: <9b9f7099-4e81-9b74-a1ac-37cd4965675b@redhat.com>
Message-ID: <77f07e94-82a2-5dc4-2483-e2ecff151e66@redhat.com>
References: <20250527142434.25209-1-sebott@redhat.com> <adf8b877-7ca2-f60b-fb59-578c70d0e3c0@huawei.com> <9b9f7099-4e81-9b74-a1ac-37cd4965675b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 4 Jun 2025, Sebastian Ott wrote:
> On Tue, 3 Jun 2025, Zenghui Yu wrote:
>>  On 2025/5/27 22:24, Sebastian Ott wrote:
>>>  Some small fixes for arch_timer_edge_cases that I stumbled upon
>>>  while debugging failures for this selftest on ampere-one.
>>>
>>>  Changes since v1: modified patch 3 based on suggestions from Marc.
>>>
>>>  I've done some tests with this on various machines - seems to be all
>>>  good, however on ampere-one I now hit this in 10% of the runs:
>>>  ==== Test Assertion Failure ====
>>>    arm64/arch_timer_edge_cases.c:481: timer_get_cntct(timer) >= DEF_CNT +
>>>    (timer_get_cntfrq() * (uint64_t)(delta_2_ms) / 1000)
>>>    pid=166657 tid=166657 errno=4 - Interrupted system call
>>>       1  0x0000000000404db3: test_run at arch_timer_edge_cases.c:933
>>>       2  0x0000000000401f9f: main at arch_timer_edge_cases.c:1062
>>>       3  0x0000ffffaedd625b: ?? ??:0
>>>       4  0x0000ffffaedd633b: ?? ??:0
>>>       5  0x00000000004020af: _start at ??:?
>>>    timer_get_cntct(timer) >= DEF_CNT + msec_to_cycles(delta_2_ms)
>>>
>>>  This is not new, it was just hidden behind the other failure. I'll
>>>  try to figure out what this is about (seems to be independent of
>>>  the wait time)..
>>
>>  Not sure if you have figured it out. I can easily reproduce it on my box
>>  and I *guess* it is that we have some random XVAL values when we enable
>>  the timer..
>
> Yes, I think so, too.
>
>>  test_reprogramming_timer()
>>  {
>>   local_irq_disable();
>>   reset_timer_state(timer, DEF_CNT);
>
> My first attempt was to also initialize cval here

Forgot to mention that I did this because my tests have shown
that the interrupt didn't only trigger early (like before the
reprogrammed delta) but instantly. This seemed to work but I think
the order in set_tval_irq() is the actual issue.


>
>>
>>   /* Program the timer to DEF_CNT + delta_1_ms. */
>>   set_tval_irq(timer, msec_to_cycles(delta_1_ms), CTL_ENABLE);
>>
>>  	[...]
>>  }
>>
>>  set_tval_irq()
>>  {
>>   timer_set_ctl(timer, ctl);
>>
>>   // There is a window that we enable the timer with *random* XVAL
>>   // values and we may get the unexpected interrupt.. And it's
>>   // unlikely that KVM can be aware of TVAL's change (and
>>   // re-evaluate the interrupt's pending state) before hitting the
>>   // GUEST_ASSERT().
>>
>>   timer_set_tval(timer, tval_cycles);
>
> Yes, I stumbled over this as well. I've always assumed that this order is
> becauase of this from the architecture "If CNTV_CTL_EL0.ENABLE is 0, the 
> value returned is UNKNOWN." However re-reading that part today I realized
> that this only concerns register reads.
>
> Maybe somone on cc knows why it's in that order?
>
> I'm currently testing this with the above swapped and it's looking good,
> so far.
>
>>  }
>>
>>  I'm not familiar with the test so I'm not 100% sure that this is the
>>  root cause. But I hope this helps with your analysis ;-) .
>
> It did, thanks!
>
> Sebastian
>


