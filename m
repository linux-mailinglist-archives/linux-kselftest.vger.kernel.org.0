Return-Path: <linux-kselftest+bounces-19428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C2099813C
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 11:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6881282A2B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 09:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253841BDAA8;
	Thu, 10 Oct 2024 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/Sz14si"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA091BDA88
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2024 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550665; cv=none; b=Rw5Q364LxJmX/Wa4RmmBdOJgIhfBRhjSJrbAjFwQ8liCMIfHRL9vo4u2D1V76Y5AhP5K8Ib4iOvHbAJXt3zGvSAuSxkeAzDSd65+Yq7ePF9QI8+CoRAPZTsxkHMKIqiramyUgWldXxNzWy+rfTKlGTLJabZv/K5POR/okBvNG1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550665; c=relaxed/simple;
	bh=jzd87EcNDbdw6bw+ZOELD0fitbOeuelfZ1tFytR59eg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ANGcZp3B5cV+EHdlIsUJZDaggyNIHZ7b8b+cVPa56J0jlb9P49Yabsp46GMtFuuxIVu3u7m6JUCo414bw84KMrXsfV0yAdLv3ffx1oUe//KnqJyjuPQTMbuy+PL/FM8+fkVUawSSg3PPWN389XuVOAqrb3JSKlNNI3bEDV4VAW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C/Sz14si; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728550662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TVThSOvoNxV/KE/0q+DXcUSmpgIScmqPjQ+ixsvMJSM=;
	b=C/Sz14siaonqfMB4M3oDyacGLgRYo5OO8MNZ0eBKe+qiqOtHYRt6+aMJLqjtUbutSl2B67
	Ip+Jzu0HCIyaXSzLIodXCls4BgBlZsULjv/trh9SN6oQY0h4flrE430XBiAHCpStx3ZDu+
	dXxG+5bt2f+a+9hTONjHcAjLFJKx/gg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-_pS0X6CmN5WB9yQEHUoIqQ-1; Thu, 10 Oct 2024 04:57:41 -0400
X-MC-Unique: _pS0X6CmN5WB9yQEHUoIqQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cceb06940so4415065e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2024 01:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728550660; x=1729155460;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TVThSOvoNxV/KE/0q+DXcUSmpgIScmqPjQ+ixsvMJSM=;
        b=BfSD8DnaP/YjQP4VuoNhg62oLcHIyvoRdD3e5FpLH4eIeNN+ZgKEBY+FhKfoU/tuRH
         rna8DfAnk2X4KWGpQs576vtWBqpYFgGyuSxuXnysnd1l0L598N2IKY3exUD0dGlFTWJv
         KZwM2I7q09iVtL6nf7yPVOh3cx4dOhOUblrNjn0ST0F3iOh1r5ULs4n/q0HjKH2Cyfm1
         HCIlUMmaXn7q5CguR/Ez/LhIi96fVHdkRPOE+vPr53cyDqxkHcLruWAoiPsN7Dsa7i52
         feyO0dEQ0n54/dFncXVDeenoBXw46INPEoBK0Aie0Gn0kAv6kIwDSiXRdVXC/uVuGRCV
         MOBA==
X-Forwarded-Encrypted: i=1; AJvYcCWDJDs2aqJjnhk9Yu9iPyLjVlGiSNWVjx2QI1wE+xzxmW9ZVzndC/fpNufXH4fbYCP/8LTyOpwn64T1sxRbBgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdlpfZYR237n23uEq/7iTfPhrnRkRzx2/5CPJFi3bqLCyEwxdp
	iUdSD/92aJeAZjGuwuuPjoKke+z+/LuZZcNU19UiJ368fC8QjzU2k4XFHFCZ833iXQdkodDzFPL
	kGNZ45Wr4v/XeRM2OI48aMTfcVUgHjM6XRWnY6TLokJT/gN5/GWMqJ/81iux4YmbnLg==
X-Received: by 2002:a05:600c:384c:b0:42c:ba1f:5475 with SMTP id 5b1f17b1804b1-430d5d89857mr49079565e9.26.1728550660382;
        Thu, 10 Oct 2024 01:57:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg1fwLzWN7F6wE7fj226buZ5WpkZAnIyD5LIz/nUpwxzScWIAB3w1FhioDK5Do+tAdTOoEZw==
X-Received: by 2002:a05:600c:384c:b0:42c:ba1f:5475 with SMTP id 5b1f17b1804b1-430d5d89857mr49079225e9.26.1728550659967;
        Thu, 10 Oct 2024 01:57:39 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf51770sm42504825e9.22.2024.10.10.01.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:57:39 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Nikolas Wipper <nikwip@amazon.de>
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>, Alexander Graf
 <graf@amazon.de>, James Gowans <jgowans@amazon.com>,
 nh-open-source@amazon.com, Sean Christopherson <seanjc@google.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Nikolas Wipper <nik.wipper@gmx.de>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, Nikolas Wipper
 <nikwip@amazon.de>
Subject: Re: [PATCH 4/7] KVM: Introduce KVM_HYPERV_SET_TLB_FLUSH_INHIBIT
In-Reply-To: <20241004140810.34231-5-nikwip@amazon.de>
References: <20241004140810.34231-1-nikwip@amazon.de>
 <20241004140810.34231-5-nikwip@amazon.de>
Date: Thu, 10 Oct 2024 10:57:38 +0200
Message-ID: <877caggwsd.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nikolas Wipper <nikwip@amazon.de> writes:

> Introduce a new ioctl to control whether remote flushing via Hyper-V
> hyper-calls should be allowed on a vCPU. When the tlb_flush_inhibit bit is
> set, vCPUs attempting to flush the TLB of the inhibitied vCPU will be
> suspended until the bit is clearded.
>
> Signed-off-by: Nikolas Wipper <nikwip@amazon.de>
> ---
>  include/uapi/linux/kvm.h | 15 +++++++++++++++

I guess we can merge this patch with documentation (PATCH1) or even
implementation (PATCH5) as I don't see why separation helps here.

>  1 file changed, 15 insertions(+)
>
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 637efc055145..3bc43fdcab88 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -933,6 +933,7 @@ struct kvm_enable_cap {
>  #define KVM_CAP_PRE_FAULT_MEMORY 236
>  #define KVM_CAP_X86_APIC_BUS_CYCLES_NS 237
>  #define KVM_CAP_X86_GUEST_MODE 238
> +#define KVM_CAP_HYPERV_TLB_FLUSH_INHIBIT 239
>  
>  struct kvm_irq_routing_irqchip {
>  	__u32 irqchip;
> @@ -1573,4 +1574,18 @@ struct kvm_pre_fault_memory {
>  	__u64 padding[5];
>  };
>  
> +/* Available with KVM_CAP_HYPERV_TLBFLUSH */
> +#define KVM_HYPERV_SET_TLB_FLUSH_INHIBIT \
> +	_IOW(KVMIO,  0xd6, struct kvm_hyperv_tlb_flush_inhibit)
> +
> +/* for KVM_HYPERV_SET_TLB_FLUSH_INHIBIT */
> +struct kvm_hyperv_tlb_flush_inhibit {
> +	/* in */
> +	__u16 flags;
> +#define KVM_HYPERV_UNINHIBIT_TLB_FLUSH 0
> +#define KVM_HYPERV_INHIBIT_TLB_FLUSH 1
> +	__u8  inhibit;
> +	__u8  reserved[5];
> +};
> +
>  #endif /* __LINUX_KVM_H */

-- 
Vitaly


