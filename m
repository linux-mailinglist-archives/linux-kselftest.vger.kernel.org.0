Return-Path: <linux-kselftest+bounces-25348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F70BA214E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 00:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77FBC3A6D6C
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 23:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528BE1E7C27;
	Tue, 28 Jan 2025 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m67mpdc5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9FA1DF72C
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738105698; cv=none; b=OHRLcD1HXRMHK6tad0Dnhkcr6TLysijdtLWMXhHqAXExRXDfXW8qr/op1FI9+0/M2XX/hsXES73VhHcV/hBObzbnxonMrA2ozQKlFiBAAid09/ZTwYim3dcjrKRlrZTQw03KVe/ZiQBrrBbNOmM5Ee03q0CEE9x4K8WA4nsqvqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738105698; c=relaxed/simple;
	bh=c1f9GAm+Tfh1fyQTBlChMqr4dttyOYyLRGgVPWFsuGQ=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=XPV1FROi4c+4lW83O1HIo3xoUPb7ECDb9ZKFHTJRxEYI/lCSwVML1fp0LwAjnP4r/jbv9cfAUpWatfqWhrByGiL7eBt0q7AeThWVV6RvbSCVFozlfiUaENcLoYDPcb0Ps+QFSqPeJp1ItXAzjWnpwvLVY18daWSzX0+IogZvvdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m67mpdc5; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-71e27669befso3891600a34.2
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 15:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738105696; x=1738710496; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zFo6TxttEqFIalCsIspeo8mg648WKT4oP0eEXrQLVXM=;
        b=m67mpdc5t5WFFfJatIz8iPL8m/vEM+4NI/pL5Wx9XXoLsKovlY9mLlcpca8tD1ymDc
         OHl0VF+tt+rIwVACdrvbsBbVFCcVpx4W8DPxkforIwOh0I6VH2P8O7TrHHWCiWrEbpm5
         MoXL4pxI5wFSYcRPNsuAUgHdQKhDbDT4KujoTTpQbDV+KJoFRnDyh8EtsNkmmQEw7lMg
         Z2KU8DcVT/U9guv7XYnmeWQsl7VH/UwW92CG16Buh/8TFKnzllkx7uPwwwAxFvI4bEpO
         boHm6ky0nhdQHfQIGgKjZxjS3lEMLhjXUzNT/fEJUuag4diC61CmqOFfmjVI1bCRWID9
         SgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738105696; x=1738710496;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFo6TxttEqFIalCsIspeo8mg648WKT4oP0eEXrQLVXM=;
        b=arRd332RObB+3yPYDozMdkFvj3RGvcjfGogz9DV3ejfIsMn4+LuReKbeswfkOHN0V0
         O0JHZzWDbZHZ0gXsw/OI42SdhJm66IAplMt2/9m2jkB3ck2SpR98+TyB51lta/5Lzh/m
         XfsaV/QWcKxIX8v7+bwHxaxX9cZQQtHLW+00WoS5M2kQip2jLbohIK9FSNlyMNONOR1D
         epBcqNRECkfipd2jWxk0Kq+JACtEboMwaHrSaUw+Cmgdk55CidXdeuitjbyjf4COxWFB
         4mQLyms+TBdJeXeKFa22eQkFMlVgFhByY1oVMJwuHhocOrrVWc6b8frL2Wp/6Ty9E2qU
         ynuw==
X-Forwarded-Encrypted: i=1; AJvYcCWsNaY5yo9vLmYCCUV55mx8CTD6c+qlincVJeAkuswC6+fE+OwBcAjkVY4xXLdhmB+N1IbTxfFLI3Dy6OKEw1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIj3Y0bLVNaZobaFbyos9qW8VrIgwhKXScwumCnNY4DhHh4Iba
	8o5jhyBOLMFh8/4MKj32Jl0n3xVW1aJlRgAwjbMysm4PQPQS/PoG/fmiT4llgNFUZHCGBIkJHzC
	5+daG+xwAAhlYbU+yijf8og==
X-Google-Smtp-Source: AGHT+IG5ddnY6/iHSVzZPnfbt3FF1yw2VhaZJBEOVScosdSTNCWOaSf0V1Rutk3fTReV5GNpySjV/C49wUzgPhrdpA==
X-Received: from oocx8.prod.google.com ([2002:a05:6820:8188:b0:5fa:a33d:6240])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6830:670f:b0:71e:1c5:4f9a with SMTP id 46e09a7af769-726568f8258mr618751a34.25.1738105695853;
 Tue, 28 Jan 2025 15:08:15 -0800 (PST)
Date: Tue, 28 Jan 2025 23:08:14 +0000
In-Reply-To: <gsntbjvq382s.fsf@coltonlewis-kvm.c.googlers.com> (message from
 Colton Lewis on Tue, 28 Jan 2025 22:08:27 +0000)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnt34h235b5.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [RFC PATCH 1/4] perf: arm_pmuv3: Introduce module param to
 partition the PMU
From: Colton Lewis <coltonlewis@google.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: maz@kernel.org, kvm@vger.kernel.org, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, pbonzini@redhat.com, shuah@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes


Colton Lewis <coltonlewis@google.com> writes:

> Hey Marc, thanks for looking.

*for the review

> Marc Zyngier <maz@kernel.org> writes:

>> On Mon, 27 Jan 2025 22:20:27 +0000,
>> Colton Lewis <coltonlewis@google.com> wrote:

>>>    	/* Read the nb of CNTx counters supported from PMNC */
>>> -	bitmap_set(cpu_pmu->cntr_mask,
>>> -		   0, FIELD_GET(ARMV8_PMU_PMCR_N, armv8pmu_pmcr_read()));
>>> +	bitmap_set(cpu_pmu->cntr_mask, 0, pmcr_n);
>>> +
>>> +	if (reserved_guest_counters > 0 && reserved_guest_counters < pmcr_n) {
>>> +		cpu_pmu->hpmn = reserved_guest_counters;
>>> +		cpu_pmu->partitioned = true;

>> Isn't this going to completely explode on a kernel running at EL1?

> Trying to access an EL2 register at EL1 can do that. I'll add the
> appropriate hypercalls.

>> Also, how does it work in an asymmetric configuration where some CPUs
>> can satisfy the reservation, and some can't?

> The CPUs that can't read their own value of PMCR.N below what the
> attempted reservation is and so do not get partitioned. Nothing changes
> for that CPU if it can't meet the reservation.

My mistake. That does not happen. I originally did these comparisons in
armv8pmu_reset which runs for every CPU but __armv8pmu_probe_pmu
doesn't.

