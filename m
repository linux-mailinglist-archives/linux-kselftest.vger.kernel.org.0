Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328A33D697E
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jul 2021 00:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbhGZVpy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jul 2021 17:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbhGZVpx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jul 2021 17:45:53 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55304C061760
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jul 2021 15:26:21 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c16so7846567plh.7
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jul 2021 15:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/+BJHwQCEyZHcaZdbprSZPe+y/dzPxjT0mqjzI4mft8=;
        b=XOJ4As13Ddv1Zv4Si7aLITV2FNguggs9creN7NCAOdJd2JF1ie5suTQ4egOzyTjaIa
         Hl03gr+MUKSixpTDfESt41Oa3w7ZSO8SE1bBV5CEJDM9XXjwljH1ju+CukWQI2QA+Szp
         0QMWPQfGn4fOJmzugVf6Q+dDjuIuqolyhzxS37dqEhZsAYP9qCoX2VTwT3U6bbV8dghG
         EYr4ojU2daMUKvsrk+/UqV2Pl+kEr97qTAubdYzr2+WOKVxn1hGHlcrAvY53oJi3DKz+
         E6qODtV39JkV9ddgkitlEIWvlby+eNxoMft+bxN0OGC7YUwNi9UnWmIn+ZTeLNJK0vuz
         mq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/+BJHwQCEyZHcaZdbprSZPe+y/dzPxjT0mqjzI4mft8=;
        b=jN6ZQlZ9xA3wQlGvioNEeSnt4wlhdxGfBbUNfsq5OyI1IGoH9jjfxiRLsJkocNqvSL
         v4bZEikcRpP8fHPB74SF9rmWb+1o8dCKNRAdAyNETf+QvzngJkBgvG48/Ir+e7YmUr8v
         YvbcWilx3p8diBtLVkLXpKgAnJQFTp6uEB090irHC6Bg4D0ii//mrB6EvZqq8RsDiepE
         PZs2SZCG+qcG9Xtl9WQ3dvCmiXi1ySs8khqzzKmtYX9xKXNf+8cyw8Slug9635KtQri6
         o5lOx+kEDNmDM7ECcLwQa7ewMYB0Z1oTt9ADudH1V4toTmfQeHd9czDPQAZvc/6HxGTm
         /S2Q==
X-Gm-Message-State: AOAM5312vw6/+WnVnQHgWOMO4ioUiHVd901+J0/X8pp4wdNg/QZZzC4+
        unNNy+LXA+TXxQKqUx9tqvgTVQ==
X-Google-Smtp-Source: ABdhPJw/Gh8+1NKDnRtUWhULZWuiVZb6OyXZ9UngoYoN+DX3SJ++9aiaqB5a3wtleH0WP6vP5l1VFQ==
X-Received: by 2002:aa7:9e5c:0:b029:32b:4e2a:e549 with SMTP id z28-20020aa79e5c0000b029032b4e2ae549mr20136064pfq.68.1627338380586;
        Mon, 26 Jul 2021 15:26:20 -0700 (PDT)
Received: from google.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id h9sm597057pjk.56.2021.07.26.15.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 15:26:19 -0700 (PDT)
Date:   Mon, 26 Jul 2021 22:26:16 +0000
From:   David Matlack <dmatlack@google.com>
To:     Erdem Aktas <erdemaktas@google.com>
Cc:     linux-kselftest@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Peter Gonda <pgonda@google.com>, Marc Orr <marcorr@google.com>,
        Sagi Shahar <sagis@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Ben Gardon <bgardon@google.com>, Peter Xu <peterx@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ricardo Koller <ricarkol@google.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yanan Wang <wangyanan55@huawei.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Jim Mattson <jmattson@google.com>,
        Oliver Upton <oupton@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Shier <pshier@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Zhenzhong Duan <zhenzhong.duan@intel.com>,
        "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
        Like Xu <like.xu@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE (KVM)" <kvm@vger.kernel.org>
Subject: Re: [RFC PATCH 1/4] KVM: selftests: Add support for creating
 non-default type VMs
Message-ID: <YP82iIe3vM/+fRAh@google.com>
References: <20210726183816.1343022-1-erdemaktas@google.com>
 <20210726183816.1343022-2-erdemaktas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726183816.1343022-2-erdemaktas@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 26, 2021 at 11:37:54AM -0700, Erdem Aktas wrote:
> Currently vm_create function only creates KVM_X86_LEGACY_VM type VMs.
> Changing the vm_create function to accept type parameter to create
> new VM types.
> 
> Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> Reviewed-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Peter Gonda <pgonda@google.com>
> Reviewed-by: Marc Orr <marcorr@google.com>
> Reviewed-by: Sagi Shahar <sagis@google.com>

Reviewed-by: David Matlack <dmatlack@google.com>

(aside from the nit below)

> ---
>  .../testing/selftests/kvm/include/kvm_util.h  |  1 +
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 29 +++++++++++++++++--
>  2 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index d53bfadd2..c63df42d6 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -88,6 +88,7 @@ int vcpu_enable_cap(struct kvm_vm *vm, uint32_t vcpu_id,
>  void vm_enable_dirty_ring(struct kvm_vm *vm, uint32_t ring_size);
>  
>  struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm);
> +struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm, int type);

nit: Consider using a more readable function name such as
vm_create_with_type().

>  void kvm_vm_free(struct kvm_vm *vmp);
>  void kvm_vm_restart(struct kvm_vm *vmp, int perm);
>  void kvm_vm_release(struct kvm_vm *vmp);
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index e5fbf16f7..70caa3882 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -180,13 +180,36 @@ _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params)
>   * Return:
>   *   Pointer to opaque structure that describes the created VM.
>   *
> - * Creates a VM with the mode specified by mode (e.g. VM_MODE_P52V48_4K).
> + * Wrapper VM Create function to create a VM with default type (0).
> + */
> +struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
> +{
> +	return __vm_create(mode, phy_pages, perm, 0);
> +}
> +
> +/*
> + * VM Create with a custom type
> + *
> + * Input Args:
> + *   mode - VM Mode (e.g. VM_MODE_P52V48_4K)
> + *   phy_pages - Physical memory pages
> + *   perm - permission
> + *   type - VM type
> + *
> + * Output Args: None
> + *
> + * Return:
> + *   Pointer to opaque structure that describes the created VM.
> + *
> + * Creates a VM with the mode specified by mode (e.g. VM_MODE_P52V48_4K) and the
> + * type specified in type (e.g. KVM_X86_LEGACY_VM, KVM_X86_TDX_VM ...).
>   * When phy_pages is non-zero, a memory region of phy_pages physical pages
>   * is created and mapped starting at guest physical address 0.  The file
>   * descriptor to control the created VM is created with the permissions
>   * given by perm (e.g. O_RDWR).
>   */
> -struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
> +struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint64_t phy_pages,
> +			    int perm, int type)
>  {
>  	struct kvm_vm *vm;
>  
> @@ -200,7 +223,7 @@ struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
>  	INIT_LIST_HEAD(&vm->userspace_mem_regions);
>  
>  	vm->mode = mode;
> -	vm->type = 0;
> +	vm->type = type;
>  
>  	vm->pa_bits = vm_guest_mode_params[mode].pa_bits;
>  	vm->va_bits = vm_guest_mode_params[mode].va_bits;
> -- 
> 2.32.0.432.gabb21c7263-goog
> 
