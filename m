Return-Path: <linux-kselftest+bounces-15570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 786919551CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 22:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058041F230D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 20:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68821C3F30;
	Fri, 16 Aug 2024 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CJwC2KM/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29905137747
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723839681; cv=none; b=Z6egyKYHg1FDtSYc5YuEBJjUckXSZpmHM5J/ydsegpbjP9G67aCh+M5JME55deickSp1+bXAekhY2zaWYwLAJW0hpior+Tgh5g44YMh7fO4IVvjOYornjBPteDxHkfQJfF1qQ/ZeyrDqy2z0oSUkYCJXZWwc95PbmC1Tcn9UqLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723839681; c=relaxed/simple;
	bh=RoxnupCzUJOlpAhtqFKUUXI5xaHaw4zPnWSvdo8kXEA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TBMpX0RFFi6JuW6zNQG0Jct/Y28tmHlYQq6H+MIKSQwf2fQFKXYq5PTZBARC2ZDENDCGtXj8KxFMsudALN+xDWDlz4ziBYk7dklYj54I+ziC6nO83DpKnEOPK/+CeJShclbjyIKTi/7+HZjKNl85Kc8h+jQJXnIdSMoTh+YwSCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CJwC2KM/; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2d3e42ef85eso1231779a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 13:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723839679; x=1724444479; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ml/zrxgslqXooti6qi/7d+TVeFAnkInp/7O9MVydVgA=;
        b=CJwC2KM/pqChuCXAri5t/b2G00a9DsJ8SGfE0U09MCDdblJg28GVrPt2dtjdhuN89g
         /lGSP6MtcMuk1vxKg830TfQQozSiYe+SxDznB7qudGJMD99e1CZOzvjxjlEn+yiM3PN4
         Uv6HzkiuT1huIyZCXYtzgrwKJqpHWw51CRCjuFLorTsSJw7/7RGh76qiuTLnztkfzAGC
         b2LOLkchshuAsjwdcuH29BHODhhPxqvh7wN1OzZpEHd3X6VzKiiWwlMvb9VCKaWYFajz
         NWRbLFCjKj3pPo7QZ1FGOFcLWGjTsKu2WhwD+KyGh7VzdLj3mVmMx5linoGaSflW/CNy
         FuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723839679; x=1724444479;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ml/zrxgslqXooti6qi/7d+TVeFAnkInp/7O9MVydVgA=;
        b=K5oOG3j1ECBhW/CqaIoRxU2HXXGbfIducSp/aA424+L61zBxOUtN6zBQapNnpXhCz4
         smf5tT0gLODpliNttUsYiSFWMLL3zZ7ExS/eV24jTqN4gO1p2ekFwjEBXaQajUKfLm+7
         KSyCcUTY6+KjtickVhgknYqPAC5TgrxoB3h4Pw5EToylamjY/NsFU3MjxpdKIDfa0tZU
         4iiWHV9/eaaI1xPoLenUUfIvsVPiio/c+oKi2f4RcedeMaN9VQUSdevyuEPaTv9EOQjV
         hFbKsAgyH3eXkKFtkXOw+GXc7geSvT3u2nQZfstyYMRgtUs+RBMBvSIgqW9uWvQkAx6H
         XPpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbWt7g6fuy3ub0+EF/6byDw2uK40sxSYY2KWaTRngqpe3pHP6GILuPHj7U2O99c6gnYz/2CTy4deBf21gLcvTnSZjTs6lv/OW9CwsQVpMJ
X-Gm-Message-State: AOJu0YydUTrU0fPUxy6M+hq6ElD6uShSODT5j8/c8/o+j8wChs3MYtvW
	JKNao09zecldAhC700WMbNi3Q6STBiulsr92zIvns1/KUNZSwcE0L23CGs5VIJ35yIJtVGg6hKw
	Itw==
X-Google-Smtp-Source: AGHT+IFE7Hb7GuPDt7biLsqGWREW3/8zJ3I3cOi53aNTPw9eNpkaFNskEMqAJ4gAR3ybyxYczKq7LZE55/o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:ad98:b0:2d3:b7c7:d682 with SMTP id
 98e67ed59e1d1-2d3dffdb498mr9761a91.3.1723839679171; Fri, 16 Aug 2024 13:21:19
 -0700 (PDT)
Date: Fri, 16 Aug 2024 13:21:17 -0700
In-Reply-To: <20240709175145.9986-5-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240709175145.9986-1-manali.shukla@amd.com> <20240709175145.9986-5-manali.shukla@amd.com>
Message-ID: <Zr-0vX9rZDY2qSwl@google.com>
Subject: Re: [RFC PATCH v1 4/4] KVM: selftests: Add bus lock exit test
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com, 
	vkuznets@redhat.com, bp@alien8.de, babu.moger@amd.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 09, 2024, Manali Shukla wrote:
> From: Nikunj A Dadhania <nikunj@amd.com>
> 
> Malicious guests can cause bus locks to degrade the performance of
> a system.  The Bus Lock Threshold feature is beneficial for
> hypervisors aiming to restrict the ability of the guests to perform
> excessive bus locks and slow down the system for all the tenants.
> 
> Add a test case to verify the Bus Lock Threshold feature for SVM.
> 
> [Manali:
>   - The KVM_CAP_X86_BUS_LOCK_EXIT capability is not enabled while
>     vcpus are created, changed the VM and vCPU creation logic to
>     resolve the mentioned issue.
>   - Added nested guest test case for bus lock exit.
>   - massage commit message.
>   - misc cleanups. ]

Again, 99% of the changelog is boilerplate that does nothing to help me
understand what the test actually does.

> 
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> Co-developed-by: Manali Shukla <manali.shukla@amd.com>
> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/x86_64/svm_buslock_test.c   | 114 ++++++++++++++++++
>  2 files changed, 115 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86_64/svm_buslock_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index ce8ff8e8ce3a..711ec195e386 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -94,6 +94,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/smaller_maxphyaddr_emulation_test
>  TEST_GEN_PROGS_x86_64 += x86_64/smm_test
>  TEST_GEN_PROGS_x86_64 += x86_64/state_test
>  TEST_GEN_PROGS_x86_64 += x86_64/vmx_preemption_timer_test
> +TEST_GEN_PROGS_x86_64 += x86_64/svm_buslock_test
>  TEST_GEN_PROGS_x86_64 += x86_64/svm_vmcall_test
>  TEST_GEN_PROGS_x86_64 += x86_64/svm_int_ctl_test
>  TEST_GEN_PROGS_x86_64 += x86_64/svm_nested_shutdown_test
> diff --git a/tools/testing/selftests/kvm/x86_64/svm_buslock_test.c b/tools/testing/selftests/kvm/x86_64/svm_buslock_test.c
> new file mode 100644
> index 000000000000..dcb595999046
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86_64/svm_buslock_test.c

I would *very* strongly prefer to have a bus lock test that is comment to VMX
and SVM.  For L1, there's no unique behavior.  And for L2, assuming we don't
support nested bus lock enabling, the only vendor specific bits are launching
L2.

I.e. writing this so it works on both VMX and SVM should be quite straightforward.

> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * svm_buslock_test
> + *
> + * Copyright (C) 2024 Advanced Micro Devices, Inc.
> + *
> + * SVM testing: Buslock exit

Keep the Copyright, ditch everything else.

> + */
> +
> +#include "test_util.h"
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "svm_util.h"
> +
> +#define NO_ITERATIONS 100

Heh, NR_ITERATIONS.

> +#define __cacheline_aligned __aligned(128)

Eh, I would just split a page, that's about as future proof as we can get in
terms of cache line sizes.

> +
> +struct buslock_test {
> +	unsigned char pad[126];
> +	atomic_long_t val;
> +} __packed;
> +
> +struct buslock_test test __cacheline_aligned;
> +
> +static __always_inline void buslock_atomic_add(int i, atomic_long_t *v)
> +{
> +	asm volatile(LOCK_PREFIX "addl %1,%0"
> +		     : "+m" (v->counter)
> +		     : "ir" (i) : "memory");
> +}
> +
> +static void buslock_add(void)
> +{
> +	/*
> +	 * Increment a cache unaligned variable atomically.
> +	 * This should generate a bus lock exit.

So... this test doesn't actually verify that a bus lock exit occurs.  The userspace
side will eat an exit if one occurs, but there's literally not a single TEST_ASSERT()
in here.

