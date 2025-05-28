Return-Path: <linux-kselftest+bounces-33935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836ABAC6A64
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 15:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76ABFA23B3E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 13:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FAF2882A8;
	Wed, 28 May 2025 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqKNbQGq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B5928642C
	for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748438894; cv=none; b=jGEHVMQxZH3NlLHmV0sn9sh4+nY9XyrqYVVWXh17nmfUZk9RgR47tP290l9f2aHRL55z6z5UMenK6Sg+lwcAokQ9khnzfy/UZal+kS5wu+U+lzEAPruKNOd/WOGfKAr/exHbRfAu8e+KfCr2JAfFSQn3h7K/n/MxXfHem3WEb6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748438894; c=relaxed/simple;
	bh=U8qomunlThM/3D2+2iMrsHuOsKr3NIw4n9pmpjV816I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPyJ4LVxTmNjYwCmRUAkmEqE/3Q+0d8An21JPrumo8Xdv3ZMKxYnHw0NLumd5TFmtJAwZStm8M/40ffiFJS/ETjtgxVsock7OWaAaA2xdABXixMMhvWJXpGYA1Hmk+5nH0nwhFmL59wtkQ5dyDGM+ziDxpwQUjqdAK8F8mVGuxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WqKNbQGq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748438891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UQ9g5LYyLjb8/iVLB1DcVfsrw8TL+AlPQukLnrUz7KA=;
	b=WqKNbQGqXHMPojkzFZzexUioP1T1hLWNGueHBZ39Y5EKlXQfutHKiRBDgYf6ZLZ1yHjHKk
	O4qiWI96m6jaS4EsMY7kkpOfFeS34UtD9WjX2tZu0dcNHYuQy2MYFQxz16DC8udILZ7ZKM
	4g2aqO7CmMUwMZvjOSUDlN66rbdk7dI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-2NmU2J39MCOlrGpySNICnw-1; Wed, 28 May 2025 09:28:09 -0400
X-MC-Unique: 2NmU2J39MCOlrGpySNICnw-1
X-Mimecast-MFC-AGG-ID: 2NmU2J39MCOlrGpySNICnw_1748438889
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4eb9c80deso299393f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 06:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748438888; x=1749043688;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQ9g5LYyLjb8/iVLB1DcVfsrw8TL+AlPQukLnrUz7KA=;
        b=DuNtk6cq5DAqQul/4KQot6iidY3nse0KqgXoiR9fxG/8FOKdtdQ1Z2gfEYkz7YakVD
         zKeTHTXS1wqOkTXFOa3e+rjlj4lbi2PEGLAR2xs6WVnSr8um5yRDgvjw5mktyKacaIx4
         kF97ehn0KuxprWQk7VF9keBCQ4FslLQjmVsCbQRTV5DmG9PwD/6kQCF4SZMJ3Xt6UAPH
         drRcJi9SXYTltRsd9pSsdsM8yqegFulp75g38sDWHUN4RY2wddZ2zsqFvFZeQ7PGTkSH
         DI11EIM7TUKNNOA6LzSqLKiHzK4usasvCLpaLwQd5foF3G7YQNAauvH4T+PlO1vrPfug
         yGYg==
X-Forwarded-Encrypted: i=1; AJvYcCWoAuANLFUd1JNf+uOxD9yXDpUYBw5YYAxC5ZWLpVEvNamvcblTKDNDh/BVMMoc10MYH9YINIQyEwPT2V/YwuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS9NaeU2IrscQlpAWKCw1TrAgQehetuiZldpKR4JTjZ449KU4m
	uRqn2b35h5IX1VN2f/q0tK1L3u2Vc1c1gWrkrGYLzJ/W0SUcCN0DSxBKwuiWuLtrdANrThBEg1h
	NtwNVAApOJUgz/x1BPCXXx7d+koz4mgsnKlZMa4PsMzWWEeHZm3hq7ioTYC5VqiV/xKCapw==
X-Gm-Gg: ASbGncseugBYHGbArPs/OVACgAwAmZEuv/SRj2MGVB9l5TGGUNXFUbfL3dXUoV858cf
	Hc9lAYCJsuvHY0ibz5noeCDkF6GQYSbTzHqNgJ9+7eINT/RfVDdSK7Bi3YNdr+Rpa2x3lS03fvP
	V3vaDZQWL2JM+djNa0uCYUa84Agqze8CKQIpJ3VJlmSjf6yal5D1CDiPSchCWjtqvD5FXn/LXWI
	RoeRB1dvhCAIlIrCyP9R8/sCSqrBkMQQtvhxCTXIPheTGVlAxRbN2PU2b0i5P9rCrFRVIXOrCn5
	KHSlnvjc1m2wOAW5MxH/mT68ZKDQfUBuhx1ON8EmOIxFboTrbqKrlg==
X-Received: by 2002:a05:6000:250f:b0:3a4:eac6:e320 with SMTP id ffacd0b85a97d-3a4eac6e4cfmr2302675f8f.3.1748438888524;
        Wed, 28 May 2025 06:28:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbyayzrF6O0WPxMeyUA9UrtC3EPJ8bgX9wDZpJ1+cDqAh15SKbYxky+R1yioFLQpmt8Yx37g==
X-Received: by 2002:a05:6000:250f:b0:3a4:eac6:e320 with SMTP id ffacd0b85a97d-3a4eac6e4cfmr2302654f8f.3.1748438888177;
        Wed, 28 May 2025 06:28:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45072555885sm17994055e9.17.2025.05.28.06.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 06:28:07 -0700 (PDT)
Message-ID: <92c7e99c-5574-422c-92f1-62d5cde58fec@redhat.com>
Date: Wed, 28 May 2025 15:28:06 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/9] KVM: Enable Nested Virt selftests
Content-Language: en-US
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
 suzuki.poulose@arm.com, yuzenghui@huawei.com, seanjc@google.com,
 darren@os.amperecomputing.com
References: <20250512105251.577874-1-gankulkarni@os.amperecomputing.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20250512105251.577874-1-gankulkarni@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ganapatrao,

On 5/12/25 12:52 PM, Ganapatrao Kulkarni wrote:
> This patch series makes the selftest work with NV enabled. The guest code
> is run in vEL2 instead of EL1. We add a command line option to enable
> testing of NV. The NV tests are disabled by default.

For commodity, I would add in the coverletter that for all tests
enhanced with vEL2 testing "-g 1" option shall be added to force that mode.

I don't really get how you chose tests capable to run at vEL2 and
excluded others? Wouldn't it make sense to have a way to run all tests
in either mode?

Thanks

Eric

> 
> Modified around 12 selftests in this series.
> 
> Changes since v1:
> 	- Updated NV helper functions as per comments [1].
> 	- Modified existing testscases to run guest code in vEL2.
> 
> [1] https://lkml.iu.edu/hypermail/linux/kernel/2502.0/07001.html 
> 
> Ganapatrao Kulkarni (9):
>   KVM: arm64: nv: selftests: Add support to run guest code in vEL2.
>   KVM: arm64: nv: selftests: Add simple test to run guest code in vEL2
>   KVM: arm64: nv: selftests: Enable hypervisor timer tests to run in
>     vEL2
>   KVM: arm64: nv: selftests: enable aarch32_id_regs test to run in vEL2
>   KVM: arm64: nv: selftests: Enable vgic tests to run in vEL2
>   KVM: arm64: nv: selftests: Enable set_id_regs test to run in vEL2
>   KVM: arm64: nv: selftests: Enable test to run in vEL2
>   KVM: selftests: arm64: Extend kvm_page_table_test to run guest code in
>     vEL2
>   KVM: arm64: nv: selftests: Enable page_fault_test test to run in vEL2
> 
>  tools/testing/selftests/kvm/Makefile.kvm      |   2 +
>  tools/testing/selftests/kvm/arch_timer.c      |   8 +-
>  .../selftests/kvm/arm64/aarch32_id_regs.c     |  34 ++++-
>  .../testing/selftests/kvm/arm64/arch_timer.c  | 118 +++++++++++++++---
>  .../selftests/kvm/arm64/nv_guest_hypervisor.c |  68 ++++++++++
>  .../selftests/kvm/arm64/page_fault_test.c     |  35 +++++-
>  .../testing/selftests/kvm/arm64/set_id_regs.c |  57 ++++++++-
>  tools/testing/selftests/kvm/arm64/vgic_init.c |  54 +++++++-
>  tools/testing/selftests/kvm/arm64/vgic_irq.c  |  27 ++--
>  .../selftests/kvm/arm64/vgic_lpi_stress.c     |  19 ++-
>  .../testing/selftests/kvm/guest_print_test.c  |  32 +++++
>  .../selftests/kvm/include/arm64/arch_timer.h  |  16 +++
>  .../kvm/include/arm64/kvm_util_arch.h         |   3 +
>  .../selftests/kvm/include/arm64/nv_util.h     |  45 +++++++
>  .../selftests/kvm/include/arm64/vgic.h        |   1 +
>  .../testing/selftests/kvm/include/kvm_util.h  |   3 +
>  .../selftests/kvm/include/timer_test.h        |   1 +
>  .../selftests/kvm/kvm_page_table_test.c       |  30 ++++-
>  tools/testing/selftests/kvm/lib/arm64/nv.c    |  46 +++++++
>  .../selftests/kvm/lib/arm64/processor.c       |  61 ++++++---
>  tools/testing/selftests/kvm/lib/arm64/vgic.c  |   8 ++
>  21 files changed, 604 insertions(+), 64 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/arm64/nv_guest_hypervisor.c
>  create mode 100644 tools/testing/selftests/kvm/include/arm64/nv_util.h
>  create mode 100644 tools/testing/selftests/kvm/lib/arm64/nv.c
> 


