Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E9B6A10FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Feb 2023 21:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjBWUGJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 15:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjBWUGI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 15:06:08 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EA654A3A
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Feb 2023 12:06:07 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536bf649e70so142692877b3.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Feb 2023 12:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6N1IAbMZXgFwFEOkFJcbYB8nDboKn/68jPGNYqSKxI0=;
        b=q2Js9Cld34qqjbO7Zg63Ee9ul39CuXnk+1EubK3O1slRp1637n2G1k5Qj6pMMNIGPq
         i09Rld7gESiFAbyGF1RrQ5RrivQbz/6CBEgK+dupU4HlnFR98rUT3WVtcBm1zN7ez+lY
         TUy0VmFPbm5Jeb5FDt//XHD34hjAFBxzvqrRxplaU10IYR3XARq52zbUA0EoawjueX5A
         6h1L7kc4k7L9ZsfxYMkxpRzMH7TBF9/sNA8B2an4svtD6TL+zHAcsWwob7pnoYJ9tOZ9
         fsXUED7Tv+pkN2EruxLUEZoo77QEMSU5Av3ZjsDyyXAGYXqQ+sCHA6AXMQNwsMcQzqxp
         294Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6N1IAbMZXgFwFEOkFJcbYB8nDboKn/68jPGNYqSKxI0=;
        b=Ai9DTDxn/B9uuErZnJpmJPnvErI+NM59+WshboaWC+kbwnX/een9idrdjaC69Yj+uN
         9VIbi1G0bifKS1hLuHckiZ+x+v/peUnxhXn61/5NeBcTd2Gh655TCQpJsAFFMuQBWETW
         z1a87z2Paf5qCU2JG0mMTgD5cL2OGsSVxdHb9yAdodI+hXSplDlQhIihEvqdYFvyW/WQ
         KSuXoXjYf5p6TPxj+XcEBdlqq1/Sso2Gjy5y1ig96sw1iYteq+6MxNiyvcbakGTRbl9k
         HSLbzX0IDSDOfdYJ5k2UBJo6PApTtHGTsTED7w+JsjcUt68nxnVZnyYC42ibITKJZIYP
         PSYg==
X-Gm-Message-State: AO0yUKVHAfVz9ceV9O6hn4g0gFdyj5kroSs2hbnwUdAveUo/laetwkxj
        b+jX4fNkbYgWyLHGMvg9G9r6cey+8JQ=
X-Google-Smtp-Source: AK7set8zNfJDzrThhh/Jx4CC8+hGZexDHztCADdftejm653o2aDDXf3Brf36Bz7ctvay6KYVJfM9/MY4sWA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4509:0:b0:52e:ee55:a81e with SMTP id
 s9-20020a814509000000b0052eee55a81emr2912465ywa.7.1677182766817; Thu, 23 Feb
 2023 12:06:06 -0800 (PST)
Date:   Thu, 23 Feb 2023 12:06:05 -0800
In-Reply-To: <32866e5d00174697730d6231d2fb81f6b8d98c8a.1676659352.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <32866e5d00174697730d6231d2fb81f6b8d98c8a.1676659352.git.ackerleytng@google.com>
Message-ID: <Y/fHLdvKHlK6D/1v@google.com>
Subject: Re: [PATCH 1/1] KVM: selftests: Adjust VM's initial stack address to
 align with SysV ABI spec
From:   Sean Christopherson <seanjc@google.com>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     pbonzini@redhat.com, shuah@kernel.org, dmatlack@google.com,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, erdemaktas@google.com,
        vannapurve@google.com, sagis@google.com, mail@maciej.szmigiero.name
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 17, 2023, Ackerley Tng wrote:
> Align stack to match calling sequence requirements in section "The
> Stack Frame" of the System V ABI AMD64 Architecture Processor
> Supplement, which requires the value (%rsp + 8) to be a multiple of 16
> when control is transferred to the function entry point.

To make it slightly more clear what is wrong:

  Align the guest stack to match calling sequence requirements in section
  "The Stack Frame" of the System V ABI AMD64 Architecture Processor
  Supplement, which requires the value (%rsp + 8), NOT %rsp, to be a
  multiple of 16 when control is transferred to the function entry point.
  I.e. in a normal function call, %rsp needs to be 16-byte aligned
  _before_ CALL, not after.

> This is required because GCC is already aligned with the SysV ABI
> spec, and compiles code resulting in (%rsp + 8) being a multiple of 16
> when control is transferred to the function entry point.

I'd leave out this paragraph, any sane compiler, not just gcc, will adhere to the
SysV ABI.

> This fixes guest crashes when compiled guest code contains certain SSE

Nit, explicitly call out that #GP behavior, e.g. if/when KVM installs exception
handlers by default, there will be no crash.

E.g.

  This fixes unexpected #GPs in guest code when the compiler uses SSE
  instructions, e.g. to initialize memory, as many SSE instruction require
  memory operands (including those on the stack) to be 16-byte aligned.

> instructions, because thes SSE instructions expect memory
> references (including those on the stack) to be 16-byte-aligned.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
> 
> This patch is a follow-up from discussions at
> https://lore.kernel.org/lkml/20230121001542.2472357-9-ackerleytng@google.com/
> 
> ---
>  .../selftests/kvm/include/linux/align.h        | 15 +++++++++++++++
>  .../selftests/kvm/lib/x86_64/processor.c       | 18 +++++++++++++++++-
>  2 files changed, 32 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/kvm/include/linux/align.h
> 
> diff --git a/tools/testing/selftests/kvm/include/linux/align.h b/tools/testing/selftests/kvm/include/linux/align.h
> new file mode 100644
> index 000000000000..2b4acec7b95a
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/linux/align.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_ALIGN_H
> +#define _LINUX_ALIGN_H
> +
> +#include <linux/const.h>
> +
> +/* @a is a power of 2 value */
> +#define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
> +#define ALIGN_DOWN(x, a)	__ALIGN_KERNEL((x) - ((a) - 1), (a))
> +#define __ALIGN_MASK(x, mask)	__ALIGN_KERNEL_MASK((x), (mask))
> +#define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
> +#define PTR_ALIGN_DOWN(p, a)	((typeof(p))ALIGN_DOWN((unsigned long)(p), (a)))
> +#define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) == 0)

I agree it's high time align.h is pulled into tools/ but it belongs in
tools/include/linux/, not in KVM selftests.

For this fix specifically, tools/include/linux/bitmap.h already #defines IS_ALIGNED(),
so just use that, and pull in align.h (and remove the definition in bitmap.h) in
a separate patch (and let us maintainers will deal with the conflicts).

> +
> +#endif	/* _LINUX_ALIGN_H */
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index acfa1d01e7df..09b48ae96fdd 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2018, Google LLC.
>   */
> 
> +#include "linux/align.h"
>  #include "test_util.h"
>  #include "kvm_util.h"
>  #include "processor.h"
> @@ -569,6 +570,21 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
>  				       DEFAULT_GUEST_STACK_VADDR_MIN,
>  				       MEM_REGION_DATA);
> 
> +	stack_vaddr += DEFAULT_STACK_PGS * getpagesize();
> +
> +	/*
> +	 * Align stack to match calling sequence requirements in section "The
> +	 * Stack Frame" of the System V ABI AMD64 Architecture Processor
> +	 * Supplement, which requires the value (%rsp + 8) to be a multiple of
> +	 * 16 when control is transferred to the function entry point.
> +	 *
> +	 * If this code is ever used to launch a vCPU with 32-bit entry point it
> +	 * may need to subtract 4 bytes instead of 8 bytes.
> +	 */
> +	TEST_ASSERT(IS_ALIGNED(stack_vaddr, PAGE_SIZE),
> +		"stack_vaddr must be page aligned for stack adjustment of -8 to work");

Nit, for the message, tie it to the allocation, not to the usage, e.g.

	TEST_ASSERT(IS_ALIGNED(stack_vaddr, PAGE_SIZE),
		    "__vm_vaddr_alloc() did not provide a page-aligned address");

The assert exists to verify an assumption (that the allocator always provides
page-aligned addresses), and the error message should capture that.  Explaining
what will break isn't as helpful because it doesn't help understand what went
wrong

> +	stack_vaddr -= 8;
> +
>  	vcpu = __vm_vcpu_add(vm, vcpu_id);
>  	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
>  	vcpu_setup(vm, vcpu);
> @@ -576,7 +592,7 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id,
>  	/* Setup guest general purpose registers */
>  	vcpu_regs_get(vcpu, &regs);
>  	regs.rflags = regs.rflags | 0x2;
> -	regs.rsp = stack_vaddr + (DEFAULT_STACK_PGS * getpagesize());
> +	regs.rsp = stack_vaddr;
>  	regs.rip = (unsigned long) guest_code;
>  	vcpu_regs_set(vcpu, &regs);
> 
> --
> 2.39.2.637.g21b0678d19-goog
> 
