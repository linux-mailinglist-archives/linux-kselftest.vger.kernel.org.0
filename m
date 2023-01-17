Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673F6670E13
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 00:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjAQXwM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Jan 2023 18:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjAQXvy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Jan 2023 18:51:54 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002204FACA
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 15:03:20 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id v6so47222481edd.6
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 15:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S0Utky4CcDja9H/9iX4tDNCU4emwig6oC4agaGJhUUc=;
        b=OHrC/QTQCvGHxvqsw4stPInLZeBh5zNkTPdbPyqckyBMvQu5n2I6oZxzOIVhCDH1lA
         AMLMW2FuQYBuhwNIPGrwCh+lOtyGPyVNw3XMv0+hq9AevSLYzjvpRLbjA2e+gQ6eY6p5
         BGkfkbshhEUd7TJeK6SEp3JmXMv7y0aLAejGGYrMdRThup5OXqITNGZVNtmNooFkr2T7
         HpwMLi6MiMZel6nw2TbZ5FniIwmyBLDQnZywjBGmcPLaDLxuDGvUcBdvnExBrUlW3HGC
         3Pvsg+QvnFJ8QSesDm5Y3TgPw+FeR04hHsqGZiMUAd2z0LyvdvLwN4QNX+fWbz3SYiYs
         9PVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0Utky4CcDja9H/9iX4tDNCU4emwig6oC4agaGJhUUc=;
        b=I9gY1ZP//IzoLLLtSEf6fAML6dbO6E8JCLsFtoCx3wL0P1Fooc6x1dJLKx1jMMmoJp
         0YdTTI9nQCblXfe+Ku5Q+By7++C5GoinXgtT2oH8ztWWq8R+qMhPtm1/qt4QTpYImz4X
         FUPBhBS2MgVlI9jWMIeBphagrdkiTGoymv7Dzl8gkn8aXn4ZPlPd+xzGycdg+nUqfGyV
         VwWhc2ktMhaAxX5yfNovhseT6BmfKS5JDenivFnPTqfZXWmsJJaZ2HjfKuNNT+XpEk1h
         pf6NG8wCu5yCtCAgTnC8vrPz0cLSW7CxGLjRgJDSTLPGRDVqfqgObleL9fdw9uOAb+2c
         UhkQ==
X-Gm-Message-State: AFqh2kpbE/Pz7e2MPp4CGoGO8sZXItPvGogPuN3dVuc9YEimcknGfMgK
        /vadW+ANxTHcwfUvwuxLBPF+RmmSQX8qqzckWD0WJQ==
X-Google-Smtp-Source: AMrXdXvkOyq5MZjBOOsq4MiLIkJKFeCxVaiXzr1XNoCLZy3kjB0ruBBffvwH30VV28c3JrcgVvzIPJNOcBc7xKb7WeY=
X-Received: by 2002:a05:6402:3d4:b0:491:6a35:9852 with SMTP id
 t20-20020a05640203d400b004916a359852mr627295edw.182.1673996599128; Tue, 17
 Jan 2023 15:03:19 -0800 (PST)
MIME-Version: 1.0
References: <20221205232341.4131240-1-vannapurve@google.com>
 <20221205232341.4131240-3-vannapurve@google.com> <Y8cXMCBzNcuzniXS@google.com>
In-Reply-To: <Y8cXMCBzNcuzniXS@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Tue, 17 Jan 2023 15:03:06 -0800
Message-ID: <CAGtprH-jXuYs4MqNupxi2aEQ3ohp0PyqpNZd0UDu8yqF+57aXw@mail.gmail.com>
Subject: Re: [V2 PATCH 2/6] KVM: Selftests: Add support for private memory
To:     Sean Christopherson <seanjc@google.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        shuah@kernel.org, yang.zhong@intel.com, ricarkol@google.com,
        aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, chao.p.peng@linux.intel.com,
        yu.c.zhang@linux.intel.com, jun.nakajima@intel.com,
        dave.hansen@intel.com, michael.roth@amd.com, qperret@google.com,
        steven.price@arm.com, ak@linux.intel.com, david@redhat.com,
        luto@kernel.org, vbabka@suse.cz, marcorr@google.com,
        erdemaktas@google.com, pgonda@google.com, nikunj@amd.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com, ackerleytng@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 17, 2023 at 1:46 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Dec 05, 2022, Vishal Annapurve wrote:
> > Add support for registering private memory with kvm using
> > KVM_SET_USER_MEMORY_REGION ioctl.
> >
> > Helper function to query extended userspace mem region is introduced to
> > allow memory conversion.
> >
> > vm_mem_backing_src types is extended to contain additional guest memory
> > source types to cover the cases where guest memory can be backed by both
> > anonymous memory and restricted memfd.
> >
> > Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> > ---
> >  .../selftests/kvm/include/kvm_util_base.h     | 12 +++-
> >  .../testing/selftests/kvm/include/test_util.h |  4 ++
> >  tools/testing/selftests/kvm/lib/kvm_util.c    | 58 +++++++++++++++++--
> >  tools/testing/selftests/kvm/lib/test_util.c   | 11 ++++
> >  4 files changed, 78 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> > index c7685c7038ff..4ad99f295f2a 100644
> > --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> > +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> > @@ -31,7 +31,10 @@ typedef uint64_t vm_paddr_t; /* Virtual Machine (Guest) physical address */
> >  typedef uint64_t vm_vaddr_t; /* Virtual Machine (Guest) virtual address */
> >
> >  struct userspace_mem_region {
> > -     struct kvm_userspace_memory_region region;
> > +     union {
> > +             struct kvm_userspace_memory_region region;
> > +             struct kvm_userspace_memory_region_ext region_ext;
>
> As discussed in the UPM series, we're trending towards adding an entirely new
> struct+ioctl(), kvm_userspace_memory_region2, instead of extending the existing
> struct.  The == -> >= hack you had to add in kvm_do_ioctl() below is one of the
> reason for that change.
>

Ack.

> > +     };
> >       struct sparsebit *unused_phy_pages;
> >       int fd;
> >       off_t offset;
> > @@ -196,7 +199,7 @@ static inline bool kvm_has_cap(long cap)
> >
> >  #define kvm_do_ioctl(fd, cmd, arg)                                           \
> >  ({                                                                           \
> > -     static_assert(!_IOC_SIZE(cmd) || sizeof(*arg) == _IOC_SIZE(cmd), "");   \
> > +     static_assert(!_IOC_SIZE(cmd) || sizeof(*arg) >= _IOC_SIZE(cmd), "");   \
> >       ioctl(fd, cmd, arg);                                                    \
> >  })
> >
> > @@ -384,6 +387,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
> >  void vm_mem_region_set_flags(struct kvm_vm *vm, uint32_t slot, uint32_t flags);
> >  void vm_mem_region_move(struct kvm_vm *vm, uint32_t slot, uint64_t new_gpa);
> >  void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot);
> > +
> >  struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id);
> >  vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
> >  vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
> > @@ -715,6 +719,10 @@ struct kvm_userspace_memory_region *
> >  kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
> >                                uint64_t end);
> >
> > +struct kvm_userspace_memory_region_ext *
> > +kvm_userspace_memory_region_ext_find(struct kvm_vm *vm, uint64_t start,
> > +                              uint64_t end);
> > +
> >  #define sync_global_to_guest(vm, g) ({                               \
> >       typeof(g) *_p = addr_gva2hva(vm, (vm_vaddr_t)&(g));     \
> >       memcpy(_p, &(g), sizeof(g));                            \
> > diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
> > index 80d6416f3012..aea80071f2b8 100644
> > --- a/tools/testing/selftests/kvm/include/test_util.h
> > +++ b/tools/testing/selftests/kvm/include/test_util.h
> > @@ -103,6 +103,8 @@ enum vm_mem_backing_src_type {
> >       VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB,
> >       VM_MEM_SRC_SHMEM,
> >       VM_MEM_SRC_SHARED_HUGETLB,
> > +     VM_MEM_SRC_ANONYMOUS_AND_RESTRICTED_MEMFD,
> > +     VM_MEM_SRC_ANON_HTLB2M_AND_RESTRICTED_MEMFD,
>
> There's no need for a dedicated flag in the backing type, vm_userspace_mem_region_add()
> already takes the memslot's flags and can simply key off KVM_MEM_PRIVATE.
>

I switched to using a dedicated flag thinking that it might be handy
when private memory can be backed by huge pages. For now it makes
sense to avoid adding it.

> > @@ -881,6 +915,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
> >       struct userspace_mem_region *region;
> >       size_t backing_src_pagesz = get_backing_src_pagesz(src_type);
> >       size_t alignment;
> > +     int restricted_memfd = -1;
>
> No need to initialize to -1, KVM is supposed to ignore the restrictedmem fd if
> !KVM_MEM_PRIVATE, and if KVM_MEM_PRIVATE is set, selftests must provide a valid fd.
>
> >       TEST_ASSERT(vm_adjust_num_guest_pages(vm->mode, npages) == npages,
> >               "Number of guest pages is not compatible with the host. "
>
> This is what I ended up with after splitting out the conversion to
> KVM_SET_USER_MEMORY_REGION2 to a separate patch.
>
> --
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 7c1f81f93ba3..26c6830c1aa1 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -32,6 +32,11 @@ int open_path_or_exit(const char *path, int flags)
>         return fd;
>  }
>
> +static int memfd_restricted(unsigned int flags)
> +{
> +       return syscall(__NR_memfd_restricted, flags);
> +}
> +
>  /*
>   * Open KVM_DEV_PATH if available, otherwise exit the entire program.
>   *
> @@ -980,6 +985,15 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
>         }
>
>         region->backing_src_type = src_type;
> +
> +       if (flags & KVM_MEM_PRIVATE) {
> +               region->region.restricted_fd = memfd_restricted(0);
> +               region->region.restricted_offset = 0;
> +
> +               TEST_ASSERT(region->region.restricted_fd >= 0,
> +                           "Failed to create restricted memfd");
> +       }
> +
>         region->unused_phy_pages = sparsebit_alloc();
>         sparsebit_set_num(region->unused_phy_pages,
>                 guest_paddr >> vm->page_shift, npages);
> @@ -992,9 +1006,10 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
>         TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION2 IOCTL failed,\n"
>                 "  rc: %i errno: %i\n"
>                 "  slot: %u flags: 0x%x\n"
> -               "  guest_phys_addr: 0x%lx size: 0x%lx",
> +               "  guest_phys_addr: 0x%lx size: 0x%lx restricted fd: %d\n",
>                 ret, errno, slot, flags,
> -               guest_paddr, (uint64_t) region->region.memory_size);
> +               guest_paddr, (uint64_t) region->region.memory_size,
> +               region->region.restricted_fd);
>
>         /* Add to quick lookup data structures */
>         vm_userspace_mem_region_gpa_insert(&vm->regions.gpa_tree, region);

Ack.
