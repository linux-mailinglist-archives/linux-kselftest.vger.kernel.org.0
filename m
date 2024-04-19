Return-Path: <linux-kselftest+bounces-8443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C698AB231
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 17:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C9A1C23044
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 15:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A790413049F;
	Fri, 19 Apr 2024 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXq2LmeR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE46012FF73;
	Fri, 19 Apr 2024 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541465; cv=none; b=MC5f5xxllDugXNUMS0t0qNYJCIyvU+0etKl+TU8HNU7pKkd+Lr3exccYKRDi4uSmz4JehNhlO5GBefb5ohqox+oykOqKhp3IfVyKzTuXFwQni+3RSnXUYrynNNMPw75LBa1W0l0xft/EhLcjpM//F+4GnGTBEUsaXq8WarfxJcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541465; c=relaxed/simple;
	bh=lYDUng3zyDugK8BrflMA/jnRdbV5oE26tBqySkDKEiQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hR6g+oAKpRQNv2x2bWq5B53GGrfFalIVanimetGikkSeEB1aBffsqe+6c9Xg3jK4VJTt52IWY1jOB3OGEDLepl2flsQ3bs9pCrk3at7gVJubrFqK7nc88mziREe/FP4uxSFTgUbiD5ICQPMmC2zTnw4wd2nIodng9XRU96jsk0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXq2LmeR; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-347c197a464so1511751f8f.2;
        Fri, 19 Apr 2024 08:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713541462; x=1714146262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iwR4/zvoUZaMVzb1AoLxvMh/sYoHHxpsQAJ6TJC4TqI=;
        b=OXq2LmeR+4Ebc4mAsKcF5EDA0S96QS2bt+sU3iwywGeoQNjaL7d2Ed2qMajVdYdaKe
         nMPsXo9gPiusdeLVXjsyzpIvmPO0ceuD9ki7PsVJnEIXioO7gKot4M7Lle4chkp9SzZK
         4DeCNGacdNWRNBNnr2cq49HKDQ41S6Sr3fgawZAav0ZDnJCtYXNy6Mk4zfZRD9wLxva3
         XAt3bhSW9T+u+XM/f6cS2zfAhbSTIChQHGyH4xtDqWz2hE2gNqqCiBXjRYsHEIyjDYcC
         W7rJn+RguP+4CaRCZeTQ355nPfD8nqTaQCHwMlRosHfDfOIz8m2SyCUQb/SqUWVFIJRn
         If2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713541462; x=1714146262;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwR4/zvoUZaMVzb1AoLxvMh/sYoHHxpsQAJ6TJC4TqI=;
        b=OA6aA/Yf2IXw4BLBeEnLA1l7Bsx+ex2nENkjfxuUqL/eMNbfCdlxk/E/azsjuzK4RA
         EV5oQcV8XE435pTd4MTKMT4FH2Z1Td9i2+iCMt4K9jNiFXEJ6HgDPz8i1fFMx8Pms5QF
         LCAnEx2SYu963h+2hhsp3mBErzeF4+dIOu019ebmUBDQbzWIPp70W/597tpDSqQFr/dW
         k76OPPrhi47C73OPlikHtwb62EPNaBWeM0YnJHaPJpAmi7waYwkvSo1Mv0xQmnIe3AgS
         2oMXsWbW5yiY4ANmQDaXA9JBGC0v2g6ncGCi3XaVtzeaz9MINeQAaGrGaQwk6TsUtsKx
         rj5A==
X-Forwarded-Encrypted: i=1; AJvYcCVuuCVIo6zpHMFpXzwXcqoKxV8dNlPROxiWMWMs8Q9R/FFIwmkRVJjCLWhV8S/RkpPIyaxKWJQKERYtmLTxGT1gNsEc0+TLaLf92craQk0ZoR4lOt+X/JtC18WHx/GRJ4AkIxuIoh0/LWkcrpnwFhUm7kI0QVo96KltM/MCp2/JoUbsX4Yrt2r3pLmOOIIJl06So4QryKmLvbi9md8R
X-Gm-Message-State: AOJu0YwtoToV4A96Ryd9ZvQg5LPKP5RsEFAmRe9mjgLsvQK6pMNIkaLS
	954gb4jLrQ6rCZjXvLjZl6nrh47H2KCBtoH3fGHiS01zl7uI8oQx
X-Google-Smtp-Source: AGHT+IFoa4JkwAbOryKRhP1sG+WC+Z1aqdpD7RZxKj3isiQJ+N1R1tBcBqjmCln8bkMKVlDA1NqtMA==
X-Received: by 2002:a5d:4082:0:b0:343:b5f0:f511 with SMTP id o2-20020a5d4082000000b00343b5f0f511mr1431301wrp.12.1713541462144;
        Fri, 19 Apr 2024 08:44:22 -0700 (PDT)
Received: from [192.168.18.253] (54-240-197-236.amazon.com. [54.240.197.236])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d62cc000000b00349c42f2559sm4720095wrv.11.2024.04.19.08.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 08:44:21 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <8f793f1b-5080-4b0e-a41d-5fee769c0d5a@xen.org>
Date: Fri, 19 Apr 2024 16:44:20 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH 04/10] KVM: selftests: Add KVM/PV clock selftest to prove
 timer correction
To: David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Oliver Upton <oliver.upton@linux.dev>, Marcelo Tosatti
 <mtosatti@redhat.com>, jalliste@amazon.co.uk, sveith@amazon.de
References: <20240418193528.41780-1-dwmw2@infradead.org>
 <20240418193528.41780-5-dwmw2@infradead.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <20240418193528.41780-5-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/04/2024 20:34, David Woodhouse wrote:
> From: Jack Allister <jalliste@amazon.com>
> 
> A VM's KVM/PV clock has an inherent relationship to its TSC (guest). When
> either the host system live-updates or the VM is live-migrated this pairing
> of the two clock sources should stay the same.
> 
> In reality this is not the case without some correction taking place. Two
> new IOCTLs (KVM_GET_CLOCK_GUEST/KVM_SET_CLOCK_GUEST) can be utilized to
> perform a correction on the PVTI (PV time information) structure held by
> KVM to effectively fixup the kvmclock_offset prior to the guest VM resuming
> in either a live-update/migration scenario.
> 
> This test proves that without the necessary fixup there is a perceived
> change in the guest TSC & KVM/PV clock relationship before and after a LU/
> LM takes place.
> 
> The following steps are made to verify there is a delta in the relationship
> and that it can be corrected:
> 
> 1. PVTI is sampled by guest at boot (let's call this PVTI0).
> 2. Induce a change in PVTI data (KVM_REQ_MASTERCLOCK_UPDATE).
> 3. PVTI is sampled by guest after change (PVTI1).
> 4. Correction is requested by usermode to KVM using PVTI0.
> 5. PVTI is sampled by guest after correction (PVTI2).
> 
> The guest the records a singular TSC reference point in time and uses it to
> calculate 3 KVM clock values utilizing the 3 recorded PVTI prior. Let's
> call each clock value CLK[0-2].
> 
> In a perfect world CLK[0-2] should all be the same value if the KVM clock
> & TSC relationship is preserved across the LU/LM (or faked in this test),
> however it is not.
> 
> A delta can be observed between CLK0-CLK1 due to KVM recalculating the PVTI
> (and the inaccuracies associated with that). A delta of ~3500ns can be
> observed if guest TSC scaling to half host TSC frequency is also enabled,
> where as without scaling this is observed at ~180ns.
> 
> With the correction it should be possible to achieve a delta of ±1ns.
> 
> An option to enable guest TSC scaling is available via invoking the tester
> with -s/--scale-tsc.
> 
> Example of the test output below:
> * selftests: kvm: pvclock_test
> * scaling tsc from 2999999KHz to 1499999KHz
> * before=5038374946 uncorrected=5038371437 corrected=5038374945
> * delta_uncorrected=3509 delta_corrected=1
> 
> Signed-off-by: Jack Allister <jalliste@amazon.com>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> CC: Paul Durrant <paul@xen.org>
> CC: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>   tools/testing/selftests/kvm/Makefile          |   1 +
>   .../selftests/kvm/x86_64/pvclock_test.c       | 192 ++++++++++++++++++
>   2 files changed, 193 insertions(+)
>   create mode 100644 tools/testing/selftests/kvm/x86_64/pvclock_test.c
> 

Reviewed-by: Paul Durrant <paul@xen.org>


