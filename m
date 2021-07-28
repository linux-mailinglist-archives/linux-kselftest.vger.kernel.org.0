Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2263D966A
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 22:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhG1ULt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 16:11:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40567 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231312AbhG1ULt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 16:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627503106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qUsQUoIIPoW4dgda1D/9HQ9hF2FFxCPZK19cH6im2dg=;
        b=Qivo5PvJ07Mj31KMn5M7PNZt3o17FyuDCXak2Iql/kxmJr08zrnTkYMvHrLdtLgxzKkWJZ
        dNVIzUzpNDQwNqfVmGqmc1ueP1sv1PNt9Qg1sWK+OeOoq1csNN8BllqpIyI0EvpvZDYF/G
        sO5meuoq88631TZMfWDgRT67laGzouk=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-IukZr21bNQqFrYCkxXfVFQ-1; Wed, 28 Jul 2021 16:11:45 -0400
X-MC-Unique: IukZr21bNQqFrYCkxXfVFQ-1
Received: by mail-io1-f71.google.com with SMTP id q137-20020a6b8e8f0000b02904bd1794d00eso2412561iod.7
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Jul 2021 13:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qUsQUoIIPoW4dgda1D/9HQ9hF2FFxCPZK19cH6im2dg=;
        b=TdoMhwl6pQ3dnJBZDzWDpV1rTN8nMVKdCHsEuYlGMZCGUw7g7CwAnq99T+ngBN3ING
         qLeka/yx6AGYNLvJVdhLl5IIpHNSgAWUV/sJEI+OnZu28YU3ZmNi0b3HWnWgIWAxvEpB
         mLlbOozQbduQVF/biBdI5UBx7KhjNyEy2yNBIefTNqtdDrVDWGgDAQuBgq4eBjy6uJ7L
         SBtO2E61pdETYO7yHk2O0EnVsiE8rajcrXG41KlrduhumrAlFuqTFGkwbcHnCAtMot/p
         3iulxOTABZwMfcxF/ZxZ1YG/Elo7ecKnKbRwTRwROflsiRnAlHViiMvcUZR81eVodAif
         UxIQ==
X-Gm-Message-State: AOAM531diMfjq5gqeiExxKQ1b5Tlg373XZaYjVYtkdxYeAgcyZ1APksx
        sfhLS/9FoCW9HYgJavFV4wrBzVzNvFOzU2M4oOjTG3GKM/dBUdDV9HUt6ESYJVIU5zcT003YRwj
        RUtBF6ltNeAhk17MsXXMgB1K5vk0m
X-Received: by 2002:a6b:ee16:: with SMTP id i22mr959861ioh.37.1627503105079;
        Wed, 28 Jul 2021 13:11:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMQJRdU4pH9RAQQm9qKo+05k8MtHsgzdwghey+IZenbQlKpVuZIRcPZqnSTzguZ0t0TkLrQQ==
X-Received: by 2002:a6b:ee16:: with SMTP id i22mr959842ioh.37.1627503104862;
        Wed, 28 Jul 2021 13:11:44 -0700 (PDT)
Received: from gator ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id m23sm873807ioj.5.2021.07.28.13.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 13:11:44 -0700 (PDT)
Date:   Wed, 28 Jul 2021 22:11:41 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     David Matlack <dmatlack@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        linux-kselftest@vger.kernel.org, Peter Gonda <pgonda@google.com>,
        Marc Orr <marcorr@google.com>, Sagi Shahar <sagis@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Ben Gardon <bgardon@google.com>,
        Peter Xu <peterx@redhat.com>,
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
Message-ID: <20210728201141.6quhfym7tbg2dier@gator>
References: <20210726183816.1343022-1-erdemaktas@google.com>
 <20210726183816.1343022-2-erdemaktas@google.com>
 <YP82iIe3vM/+fRAh@google.com>
 <YQBw8BIcCAq5ybHr@google.com>
 <YQGAtxWqBhBUYWBN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQGAtxWqBhBUYWBN@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 28, 2021 at 04:07:19PM +0000, David Matlack wrote:
> On Tue, Jul 27, 2021 at 08:47:44PM +0000, Sean Christopherson wrote:
> > On Mon, Jul 26, 2021, David Matlack wrote:
> > > On Mon, Jul 26, 2021 at 11:37:54AM -0700, Erdem Aktas wrote:
> > > > Currently vm_create function only creates KVM_X86_LEGACY_VM type VMs.
> > > > Changing the vm_create function to accept type parameter to create
> > > > new VM types.
> > > > 
> > > > Signed-off-by: Erdem Aktas <erdemaktas@google.com>
> > > > Reviewed-by: Sean Christopherson <seanjc@google.com>
> > 
> > *-by tags should not be added unless explicitly provided.  IIRC, our internal
> > gerrit will convert +1 to Reviewed-by, but I don't think that's the case here.
> > This applies to all patches in this series.
> > 
> > See "Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:" in
> > Documentation/process/submitting-patches.rst for more info.
> > 
> > > > Reviewed-by: Peter Gonda <pgonda@google.com>
> > > > Reviewed-by: Marc Orr <marcorr@google.com>
> > > > Reviewed-by: Sagi Shahar <sagis@google.com>
> > > 
> > > Reviewed-by: David Matlack <dmatlack@google.com>
> > > 
> > > (aside from the nit below)
> > > 
> > > > ---
> > > >  .../testing/selftests/kvm/include/kvm_util.h  |  1 +
> > > >  tools/testing/selftests/kvm/lib/kvm_util.c    | 29 +++++++++++++++++--
> > > >  2 files changed, 27 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> > > > index d53bfadd2..c63df42d6 100644
> > > > --- a/tools/testing/selftests/kvm/include/kvm_util.h
> > > > +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> > > > @@ -88,6 +88,7 @@ int vcpu_enable_cap(struct kvm_vm *vm, uint32_t vcpu_id,
> > > >  void vm_enable_dirty_ring(struct kvm_vm *vm, uint32_t ring_size);
> > > >  
> > > >  struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm);
> > > > +struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm, int type);
> > > 
> > > nit: Consider using a more readable function name such as
> > > vm_create_with_type().
> > 
> > Ha!  This is why I don't like doing internal reviews :-D
> 
> +1 :)
> 
> > 
> > Erdem originally had vm_create_type(), I suggested __vm_create() as the double
> > underscore scheme is more common in the kernel for cases where there's a default
> > wrapper and an inner helper that implements the full API.
> > 
> > Convention aside, the argument againsts ...with_type() are that it doesn't scale,
> > e.g. if someone adds another parameter parameter for which vm_create() provides a
> > default, and it doesn't self-document the relationship between vm_create() and
> > the inner helper, e.g. by convention, based on names alone I know that vm_create()
> > likely is a wrapper around __vm_create().
> 
> True, although with __vm_create() is not solving the scalability
> problem, it's just preventing scaling altogether (you can only have 1
> wrapper function, vm_create). So if any caller wants to override one of
> the defaults they have to override all of them.
> 
> I agree with you though in this case: __vm_create() is a better choice
> (especially given the existence of vm_create_with_vcpus).
> 
> A better option than both (but would involve more work) would be to
> create an options struct with all optional arguments. Unfortunately C
> makes working with options structs a bit clumsy. But it's something to
> consider as the number of options passed to __vm_create increases.
> 
> For example:
> 
> struct vm_options {
>         enum vm_guest_mode mode;
>         uint64_t phy_pages;
>         int perm;
>         int type;
> };
> 
> struct kvm_vm *vm_create(const struct vm_options *options)
> {
>         ...
> }
> 
> static const struct vm_options default_vm_options = {
>   .mode = VM_MODE_DEFAULT,
>   .phy_pages = DEFAULT_GUEST_PHY_PAGES,
>   .perm = O_RDWR,
>   .type = DEFAULT_VM_TYPE,
> };
> 
> /* Create a VM with default options. */
> vm = create_vm(&default_vm_options);
> 
> /* Create a VM with TDX enabled. */
> struct vm_options options = default_vm_options;
> options.type = VM_TYPE_TDX;
> vm = create_vm(&options);

I like this.

Thanks,
drew

