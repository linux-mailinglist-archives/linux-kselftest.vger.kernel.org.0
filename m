Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FC33D7F72
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jul 2021 22:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhG0Urv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jul 2021 16:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhG0Uru (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jul 2021 16:47:50 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47814C061764
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jul 2021 13:47:49 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so994581pjh.3
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Jul 2021 13:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ulRmjv7IfUJ8xaaiDrXlOeC6Qs3mklI7DmEPnQK7Q1c=;
        b=XI0IetnWWZ05LKL4Vf7VF6An6gIrdn84rTLduJk6E7XiDLeFpI2dvQpog5YotjB5vF
         33JF5enpnAiBF3abXhAOY8Xk7Zzu2BOHGCQ2BGIpkMDko6ykK+nCmJL3cwdHsNipk+2m
         sXJUAG5rGui9Q4ZPkGou6Tf4hRT4Z2yNrv4Pyn/ZesdHL/s6sicXx5g9giJv7+NJrp0r
         +JqW5N61bZuOtJ57mSESUYOYfgvAgrTl6sRQu0GiPf/1sEH4UWLVzueIp5LEIWDRvKuu
         A9GQgjeurX6r4Zy/ivFaTftawHeEeoYUJvESKj/dNfOFdXtxQLItyiTwcH9PHGc8xd/j
         bXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ulRmjv7IfUJ8xaaiDrXlOeC6Qs3mklI7DmEPnQK7Q1c=;
        b=rCXI3nkRSSZeH8yFU0vvxuLFEK6ZBK/I7PJGsv+DgEJYCwhpIA7JW9fj4aTfEwk0ga
         DeIzgpnJX4XrG22YwLLwEXXZE1VWtT1n0vhRdlm8d3NT+R0ix3oHWi1OdAa0qzhhv30K
         YrWa7DLIgYKpDeAbTPuqTuXQfyaVGWe/ocay8fikYdwL2S1KkSRve0cX3D1jc+389rBf
         Dn0wgrVXWM1u/5xlahcSRoDIuW6pcvZTBRMBiVV12OfrQveTtnTdVY1iQyC5LhOOFXYX
         57cZ5MXNHRBarSDHxJzeKrjTDtjWSxIisA9qVuF0c6VfFsvf4Io0pV2x0unw2C05rzS+
         qvVQ==
X-Gm-Message-State: AOAM532l0Ac1OUyC3QFeE8X8Vi4sfusZm6ysNFUbGHXyUvVN8eALIoMO
        /YiON4vQisWT9Y4kiXdEFue8UXkV0aXFfQ==
X-Google-Smtp-Source: ABdhPJwrUkS53JCh0qWbCYkGs1YKZKK6uB6gcZSywe1TXZiEKau8wexD8v/NG6WZwZx/OO+ppXUDUw==
X-Received: by 2002:aa7:80d9:0:b029:2ed:49fa:6dc5 with SMTP id a25-20020aa780d90000b02902ed49fa6dc5mr24606114pfn.3.1627418868558;
        Tue, 27 Jul 2021 13:47:48 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id b18sm3563591pji.39.2021.07.27.13.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 13:47:48 -0700 (PDT)
Date:   Tue, 27 Jul 2021 20:47:44 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Matlack <dmatlack@google.com>
Cc:     Erdem Aktas <erdemaktas@google.com>,
        linux-kselftest@vger.kernel.org, Peter Gonda <pgonda@google.com>,
        Marc Orr <marcorr@google.com>, Sagi Shahar <sagis@google.com>,
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
Message-ID: <YQBw8BIcCAq5ybHr@google.com>
References: <20210726183816.1343022-1-erdemaktas@google.com>
 <20210726183816.1343022-2-erdemaktas@google.com>
 <YP82iIe3vM/+fRAh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YP82iIe3vM/+fRAh@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 26, 2021, David Matlack wrote:
> On Mon, Jul 26, 2021 at 11:37:54AM -0700, Erdem Aktas wrote:
> > Currently vm_create function only creates KVM_X86_LEGACY_VM type VMs.
> > Changing the vm_create function to accept type parameter to create
> > new VM types.
> > 
> > Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> > Reviewed-by: Sean Christopherson <seanjc@google.com>

*-by tags should not be added unless explicitly provided.  IIRC, our internal
gerrit will convert +1 to Reviewed-by, but I don't think that's the case here.
This applies to all patches in this series.

See "Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:" in
Documentation/process/submitting-patches.rst for more info.

> > Reviewed-by: Peter Gonda <pgonda@google.com>
> > Reviewed-by: Marc Orr <marcorr@google.com>
> > Reviewed-by: Sagi Shahar <sagis@google.com>
> 
> Reviewed-by: David Matlack <dmatlack@google.com>
> 
> (aside from the nit below)
> 
> > ---
> >  .../testing/selftests/kvm/include/kvm_util.h  |  1 +
> >  tools/testing/selftests/kvm/lib/kvm_util.c    | 29 +++++++++++++++++--
> >  2 files changed, 27 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> > index d53bfadd2..c63df42d6 100644
> > --- a/tools/testing/selftests/kvm/include/kvm_util.h
> > +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> > @@ -88,6 +88,7 @@ int vcpu_enable_cap(struct kvm_vm *vm, uint32_t vcpu_id,
> >  void vm_enable_dirty_ring(struct kvm_vm *vm, uint32_t ring_size);
> >  
> >  struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm);
> > +struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm, int type);
> 
> nit: Consider using a more readable function name such as
> vm_create_with_type().

Ha!  This is why I don't like doing internal reviews :-D

Erdem originally had vm_create_type(), I suggested __vm_create() as the double
underscore scheme is more common in the kernel for cases where there's a default
wrapper and an inner helper that implements the full API.

Convention aside, the argument againsts ...with_type() are that it doesn't scale,
e.g. if someone adds another parameter parameter for which vm_create() provides a
default, and it doesn't self-document the relationship between vm_create() and
the inner helper, e.g. by convention, based on names alone I know that vm_create()
likely is a wrapper around __vm_create().

Compare that with the existing

  vm_create_default_with_vcpus()
  vm_create_default()
  vm_create_with_vcpus()
  vm_create()

where the relationship between all the helpers is not immediately clear, and
vm_create_with_vcpus() is a misnomer because it does much more than call vm_create()
and instantiate vCPUs, e.g. it also instantiates the IRQ chip and loads the test
into guest memory.
