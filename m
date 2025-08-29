Return-Path: <linux-kselftest+bounces-40346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B38E6B3C557
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 00:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5960A18963FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 22:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82742DE71E;
	Fri, 29 Aug 2025 22:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sxHn+asV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199452DCF43
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Aug 2025 22:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507617; cv=none; b=HwSCP4VawLw5WwzhG9PMZVPRqL+olOhcUjM6TaigrIuLMnCVvEfH5jJ74gjHKnNVmH/kT7FbUwpgvdJfvPpPvNUouyI/Q+Y7F1ou67sopVN/+Hue8FiUyyuxCl/oiaZcLCXFRNHnVfDc5oSlOL8Xb7h8J5d+Gr9XXq9HJWsMZRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507617; c=relaxed/simple;
	bh=7iKeOMQFOEEVd5ETUGweiy0cPrlfaMl1uc16FWLXC+U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dnxs2F56vYx2NIurb3HtJ7v8w7hIZJKQGVJ9+bd2Gcob6uA80xnCVWT0XKeMJ61Xl2AKEQaZcAMU3Hux7a/r2l4o6D0QtxB+MVkFcRNb/dACsY+4P9de/iMwEs+kQFOyXaqaUmmxaxFJAAsHBDb6Ctk16lyHjHanFH4Y9uHM/SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sxHn+asV; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24868b07b5bso44876325ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Aug 2025 15:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756507615; x=1757112415; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=osO9EdDK8ULTUCgyPclw9xxVN7HnxTjhwUYL0zf8SiE=;
        b=sxHn+asVQ4idbSkIMokYYwHvX5BKlIjEvztTGbGtxWdMJq8Dpm+UN+LyhbvYzDiN3V
         ztqGH568RSndTnBePn/2H89LBuxwGBBLYVm20Bx0OUJ9Gx5ClnA3J0KHD4p9HOjXWPoR
         05bO05UHpZ9lPQnHYlUvc2/nC1BcyqSFeYXmC8rCVRLM3fnrA2QUsTOGR8NOg36MZijs
         U4iGMhwUpBt0h62fy5Dey8vrUM3nicKF2PZ14bzUNliT2i0wY55ri5zYBjUt/ojmDHyH
         PZbN0MCJqVLVD6lKWSD4xvO/EGZ3nB5VaMbMFEO0cKYZZlpZWO44Vtpqn2stNE+34Xbq
         tnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756507615; x=1757112415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=osO9EdDK8ULTUCgyPclw9xxVN7HnxTjhwUYL0zf8SiE=;
        b=cF4oNOsIBp99QZtS1ORVd+5MmJMNyHw4XFJOS2o/C2u9hyiuN4nfEbETwQFju3IfpT
         +mVCuQBAQMwkh4O+VlkFABPbQQ0+u10WZc5o9LiRS6geXsRh65TuDxgW8R9YZ0TyPUv8
         eKqi/QMNSv2G5R+niIAI0w2KIMouYt0AZm9oQcuUYw3E58Pux72N64HJ/b4vRVFru/z7
         60HS3KS+TiqKcBynmenIoFDFfMF91dKVXQaNhKUbB2Zshu5Gb/DjigLJcSoUGYT6rV6t
         /gz6Y3cPCbqFiBVd43GQfbJB+cFRt+4kk3RC3dfTCuiSO06dcMzyQcSGhLrFy3engyES
         pPxw==
X-Forwarded-Encrypted: i=1; AJvYcCVxDMwGOlwB+SWebeviC55wY1pPpNZXUE7jNhxSsJtnl1QGJ/smup4dhoSXNbfnHMa1KHG45osGx8PIk1DBh0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Cqzlx38rNdFA49RBjPspqOs7F1d+lHI4ReeGJcsLMYKFzI3p
	c7QBRS/8GI4amO+pA13bvY2Z49qiwGgg7GJKqlz2Dv3l7DrN/0PsrjTiPwmRO6BeeY9t/t3CDwA
	ER/FUqw==
X-Google-Smtp-Source: AGHT+IGkt/EAn947SVVMGSrEgo9yvNr3e4MeFQSbN7ad+YrLR9BbTewsN8HKmFTWK3fVBIpRGYfyACOyUfY=
X-Received: from plbkq13.prod.google.com ([2002:a17:903:284d:b0:246:a8c3:9a07])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1448:b0:248:c5d7:1b94
 with SMTP id d9443c01a7336-24944b695e6mr2556105ad.53.1756507615340; Fri, 29
 Aug 2025 15:46:55 -0700 (PDT)
Date: Fri, 29 Aug 2025 15:46:53 -0700
In-Reply-To: <20250829142556.72577-3-aqibaf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829142556.72577-1-aqibaf@amazon.com> <20250829142556.72577-3-aqibaf@amazon.com>
Message-ID: <aLIt3bm0uxSh8I1j@google.com>
Subject: Re: [PATCH 2/9] KVM: selftests: Add __packed attribute fallback
From: Sean Christopherson <seanjc@google.com>
To: Aqib Faruqui <aqibaf@amazon.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nh-open-source@amazon.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 29, 2025, Aqib Faruqui wrote:
> Kernel UAPI headers use __packed but don't provide the definition in
> userspace builds.
> 
> Add a fallback definition matching the kernel's implementation. This
> follows the same pattern used by BPF and SGX selftests.

Ugh.  No, this needs to be fixed in a central location, not splattered all over
random subsystem selftests.  My first choice would be to copy (and keep synchronize)
all of the include/linux/compiler*.h headers to tools/include/linux/.

If for some reason that's not a viable option, we should yank the __packed and
similar #defines out of tools/include/linux/compiler-gcc.h and place them in
tools/include/linux/compiler.h.  AFAICT, none of them are actually GCC-only.

> Signed-off-by: Aqib Faruqui <aqibaf@amazon.com>
> ---
>  tools/testing/selftests/kvm/include/kvm_util.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 23a506d7e..7fae7f5e7 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -5,6 +5,10 @@
>  #ifndef SELFTEST_KVM_UTIL_H
>  #define SELFTEST_KVM_UTIL_H
>  
> +#ifndef __packed
> +#define __packed __attribute__((__packed__))
> +#endif
> +
>  #include "test_util.h"
>  
>  #include <linux/compiler.h>
> -- 
> 2.47.3
> 

