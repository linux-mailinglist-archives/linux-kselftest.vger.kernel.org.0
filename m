Return-Path: <linux-kselftest+bounces-136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C366B7EC74F
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 16:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D54928120E
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 15:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF7D39FCF;
	Wed, 15 Nov 2023 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZktU7jr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35102C84E
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 15:31:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71A41A1
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 07:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700062303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/U++RP8J87fTpffNLluzx5XIExdTU9ynmak8Mre+P4=;
	b=RZktU7jr49koGscOk+YZGcJZn45sRaj4nqUQEDdRqRhmo/X9YFfVy/E0vjCxK0+zXp8/wX
	V5kQhgoa2VVligDeznTggXjrL9525P5RhbYNwu10beVLdiKVC+wZqPtcMyQAW/0hmCvOph
	n+OCKWcVE7Tr/aFrqvZjbFgEUA63I7A=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-9vbQP1HNOBWaAePt4QJ2EQ-1; Wed, 15 Nov 2023 10:31:41 -0500
X-MC-Unique: 9vbQP1HNOBWaAePt4QJ2EQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6bdc140103bso1690482b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 07:31:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700062300; x=1700667100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D/U++RP8J87fTpffNLluzx5XIExdTU9ynmak8Mre+P4=;
        b=BVdE9NwYYZuiXRikZ8Gc4H3Yp6mheUjI987FIw5izpjLuiWHjrfZ/Umsgq2Zz8DbN/
         YMHJJYYPdZEMQSrQpeOfl4U/ZVK+wFjjRrDI++J/3P9Qs3VImdKyosEnsDw6WcppZFak
         SW+nhyYEaCv55hllAk3DbDALczadkEyb/Pbb23hkUwOQvLyxQwA8n/IZc3f16D7T3epY
         dpJI5D3OkvKAd8iZiqEICUVmfEuQ8LaZEvWZ5L3HGB9lDIzWNBBRBbRwxP3Y43xU3qNU
         V9TtvnuPnSOjjsUbEIAO1frRDc54OJut0+4eHS8vBv1VV9y5j+TLSDpTrIsvLClHdFu4
         sEcg==
X-Gm-Message-State: AOJu0Yz/PJzfaOCjwv9B0yp4ftKpegTufQVEbO23cghrIzhVOD09Tczz
	W1kj62G8LDOYKfSvH5YMlurpSJCwM2wYgoC0y0TzV7yToMDVUsNLy82CfKFkFRbMUwgrBXI1YXs
	XapTmipoB8YFiIDAuOtifLpq2eItk
X-Received: by 2002:a05:6a00:6894:b0:6c0:81a3:fe4c with SMTP id hr20-20020a056a00689400b006c081a3fe4cmr2631601pfb.3.1700062299857;
        Wed, 15 Nov 2023 07:31:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6wTglBWhG4nljh27JjPWJF2LXSzDl20T4s5YweTj0uHIb6TdJ4bD03xIAZOHx+3l4vNETfQ==
X-Received: by 2002:a05:6a00:6894:b0:6c0:81a3:fe4c with SMTP id hr20-20020a056a00689400b006c081a3fe4cmr2631564pfb.3.1700062299414;
        Wed, 15 Nov 2023 07:31:39 -0800 (PST)
Received: from [10.72.112.25] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e12-20020a6558cc000000b0058ee60f8e4dsm1174195pgu.34.2023.11.15.07.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 07:31:39 -0800 (PST)
Message-ID: <f3f467bf-40d7-dd4d-7ee1-eef95eeed36d@redhat.com>
Date: Wed, 15 Nov 2023 23:31:35 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] KVM: arm64: selftests: Clean up the GIC[D,R]_BASE_GPA
Content-Language: en-US
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231115104757.15710-1-shahuang@redhat.com>
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20231115104757.15710-1-shahuang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/15/23 18:47, Shaoqin Huang wrote:
> The GIC[D,R]_BASE_GPA has been defined in multiple files with the same
> value, define it in one place to make the code clean.
> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>   tools/testing/selftests/kvm/aarch64/arch_timer.c   | 3 ---
>   tools/testing/selftests/kvm/aarch64/vgic_irq.c     | 3 ---
>   tools/testing/selftests/kvm/dirty_log_perf_test.c  | 3 ---
>   tools/testing/selftests/kvm/include/aarch64/vgic.h | 3 +++

Oops. Forget the kvm/aarch64/vpmu_counter_access.c. I will update a new one.

>   4 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/aarch64/arch_timer.c b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> index 274b8465b42a..818854007bfd 100644
> --- a/tools/testing/selftests/kvm/aarch64/arch_timer.c
> +++ b/tools/testing/selftests/kvm/aarch64/arch_timer.c
> @@ -59,9 +59,6 @@ static struct test_args test_args = {
>   
>   #define msecs_to_usecs(msec)		((msec) * 1000LL)
>   
> -#define GICD_BASE_GPA			0x8000000ULL
> -#define GICR_BASE_GPA			0x80A0000ULL
> -
>   enum guest_stage {
>   	GUEST_STAGE_VTIMER_CVAL = 1,
>   	GUEST_STAGE_VTIMER_TVAL,
> diff --git a/tools/testing/selftests/kvm/aarch64/vgic_irq.c b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
> index 2e64b4856e38..a48aff110fb6 100644
> --- a/tools/testing/selftests/kvm/aarch64/vgic_irq.c
> +++ b/tools/testing/selftests/kvm/aarch64/vgic_irq.c
> @@ -19,9 +19,6 @@
>   #include "gic_v3.h"
>   #include "vgic.h"
>   
> -#define GICD_BASE_GPA		0x08000000ULL
> -#define GICR_BASE_GPA		0x080A0000ULL
> -
>   /*
>    * Stores the user specified args; it's passed to the guest and to every test
>    * function.
> diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> index d374dbcf9a53..4971e8f77a0a 100644
> --- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> @@ -22,9 +22,6 @@
>   #ifdef __aarch64__
>   #include "aarch64/vgic.h"
>   
> -#define GICD_BASE_GPA			0x8000000ULL
> -#define GICR_BASE_GPA			0x80A0000ULL
> -
>   static int gic_fd;
>   
>   static void arch_setup_vm(struct kvm_vm *vm, unsigned int nr_vcpus)
> diff --git a/tools/testing/selftests/kvm/include/aarch64/vgic.h b/tools/testing/selftests/kvm/include/aarch64/vgic.h
> index 0ac6f05c63f9..9dbb342fd808 100644
> --- a/tools/testing/selftests/kvm/include/aarch64/vgic.h
> +++ b/tools/testing/selftests/kvm/include/aarch64/vgic.h
> @@ -33,4 +33,7 @@ void kvm_irq_write_isactiver(int gic_fd, uint32_t intid, struct kvm_vcpu *vcpu);
>   
>   #define KVM_IRQCHIP_NUM_PINS	(1020 - 32)
>   
> +#define GICD_BASE_GPA		0x08000000ULL
> +#define GICR_BASE_GPA		0x080A0000ULL
> +
>   #endif // SELFTEST_KVM_VGIC_H

-- 
Shaoqin


