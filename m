Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE277670C05
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jan 2023 23:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjAQWrO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Jan 2023 17:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjAQWqm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Jan 2023 17:46:42 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D3A4DCEB
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 13:46:29 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id d8so2615030pjc.3
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 13:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rC8/tQUk41CuZwxwlH46s3W2aYILb1S2xKjt3FVwjWk=;
        b=cgVGR5vSZjy20eYRrtrqp3/gNV7N5qRXpunzl2yBirUn0JTyXcu5pj0b67ubvvuZm3
         ruZ51Q2QsAxw6Uk65xO3YnKjFDlnhAL+r0wRNQYgPdT3/+v7gX3AF8R4Tjbjwc3/laCp
         2IY43BlasoahYjElBb5lir0+fGGPpL3VRiUqyk0M+ITHQSMuwaqVkWZGZsLHnuzuI2aY
         NmissgdaoKJgTLZFraaEkoHeXOMdHQQj45gAnz2/a7B7G/Q9dxDQWSrm0BOwyldEJFul
         22sQlEUQB1V9QUDV5ZKMg8fg7mie5PCtSLhFixnns23qpRHFuqZGUshwYsVPKiv/Nj47
         sNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rC8/tQUk41CuZwxwlH46s3W2aYILb1S2xKjt3FVwjWk=;
        b=drd/VKAtR+TmpP4QfPnnwh7W++guUhmlWo+V8vyTpiDBDHw2h7s0kLyKJ4mV4VqdIr
         TeieWZ2Qk352KVD8+fXxImvl3tuvXzi3lHqRCI2KxUk0uRG6zFv/dkPvyctPL4RHlSK6
         SI3zIazxd5tLI1Dw/8tryJ+bgNxV6+JoKJjVre/0jriCuN9Z30lNvDx+6fPPFcZyjjBY
         LlzoHSux0fV117tgrRcpt1NL8Jca9B2pnFGBfQS9dJJGMAA0sR+p+rmv1sBPG3QXh1YC
         Rlq+WCp5XmsylPMAqCW7zuOqDOB9/LzJiHNMi3WddcplKxIzc3coHcPhI2kN8Ni+H2X2
         PzAA==
X-Gm-Message-State: AFqh2kpIXF2v0G+OLCsW0bY1NkDDixlFR2rPmTeApau7qf9P49Rr2gau
        RRAzuLJTfUtNau4D2GG/sreLow==
X-Google-Smtp-Source: AMrXdXvcjlIzPDJ2H/BqBCU66i//6UERLaf1dN+GVL16Z85jBzFgvROsbL8JNeDZ6Z/+o4RJ4ZSD6A==
X-Received: by 2002:a05:6a20:c183:b0:b8:ca86:f3ab with SMTP id bg3-20020a056a20c18300b000b8ca86f3abmr359209pzb.2.1673991988781;
        Tue, 17 Jan 2023 13:46:28 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u127-20020a626085000000b00580fb018e4bsm16785535pfb.211.2023.01.17.13.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 13:46:28 -0800 (PST)
Date:   Tue, 17 Jan 2023 21:46:24 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
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
Subject: Re: [V2 PATCH 2/6] KVM: Selftests: Add support for private memory
Message-ID: <Y8cXMCBzNcuzniXS@google.com>
References: <20221205232341.4131240-1-vannapurve@google.com>
 <20221205232341.4131240-3-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205232341.4131240-3-vannapurve@google.com>
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

On Mon, Dec 05, 2022, Vishal Annapurve wrote:
> Add support for registering private memory with kvm using
> KVM_SET_USER_MEMORY_REGION ioctl.
> 
> Helper function to query extended userspace mem region is introduced to
> allow memory conversion.
> 
> vm_mem_backing_src types is extended to contain additional guest memory
> source types to cover the cases where guest memory can be backed by both
> anonymous memory and restricted memfd.
> 
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>  .../selftests/kvm/include/kvm_util_base.h     | 12 +++-
>  .../testing/selftests/kvm/include/test_util.h |  4 ++
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 58 +++++++++++++++++--
>  tools/testing/selftests/kvm/lib/test_util.c   | 11 ++++
>  4 files changed, 78 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
> index c7685c7038ff..4ad99f295f2a 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util_base.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
> @@ -31,7 +31,10 @@ typedef uint64_t vm_paddr_t; /* Virtual Machine (Guest) physical address */
>  typedef uint64_t vm_vaddr_t; /* Virtual Machine (Guest) virtual address */
>  
>  struct userspace_mem_region {
> -	struct kvm_userspace_memory_region region;
> +	union {
> +		struct kvm_userspace_memory_region region;
> +		struct kvm_userspace_memory_region_ext region_ext;

As discussed in the UPM series, we're trending towards adding an entirely new
struct+ioctl(), kvm_userspace_memory_region2, instead of extending the existing
struct.  The == -> >= hack you had to add in kvm_do_ioctl() below is one of the
reason for that change.

> +	};
>  	struct sparsebit *unused_phy_pages;
>  	int fd;
>  	off_t offset;
> @@ -196,7 +199,7 @@ static inline bool kvm_has_cap(long cap)
>  
>  #define kvm_do_ioctl(fd, cmd, arg)						\
>  ({										\
> -	static_assert(!_IOC_SIZE(cmd) || sizeof(*arg) == _IOC_SIZE(cmd), "");	\
> +	static_assert(!_IOC_SIZE(cmd) || sizeof(*arg) >= _IOC_SIZE(cmd), "");	\
>  	ioctl(fd, cmd, arg);							\
>  })
>  
> @@ -384,6 +387,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
>  void vm_mem_region_set_flags(struct kvm_vm *vm, uint32_t slot, uint32_t flags);
>  void vm_mem_region_move(struct kvm_vm *vm, uint32_t slot, uint64_t new_gpa);
>  void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot);
> +
>  struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id);
>  vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
>  vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
> @@ -715,6 +719,10 @@ struct kvm_userspace_memory_region *
>  kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
>  				 uint64_t end);
>  
> +struct kvm_userspace_memory_region_ext *
> +kvm_userspace_memory_region_ext_find(struct kvm_vm *vm, uint64_t start,
> +				 uint64_t end);
> +
>  #define sync_global_to_guest(vm, g) ({				\
>  	typeof(g) *_p = addr_gva2hva(vm, (vm_vaddr_t)&(g));	\
>  	memcpy(_p, &(g), sizeof(g));				\
> diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
> index 80d6416f3012..aea80071f2b8 100644
> --- a/tools/testing/selftests/kvm/include/test_util.h
> +++ b/tools/testing/selftests/kvm/include/test_util.h
> @@ -103,6 +103,8 @@ enum vm_mem_backing_src_type {
>  	VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB,
>  	VM_MEM_SRC_SHMEM,
>  	VM_MEM_SRC_SHARED_HUGETLB,
> +	VM_MEM_SRC_ANONYMOUS_AND_RESTRICTED_MEMFD,
> +	VM_MEM_SRC_ANON_HTLB2M_AND_RESTRICTED_MEMFD,

There's no need for a dedicated flag in the backing type, vm_userspace_mem_region_add()
already takes the memslot's flags and can simply key off KVM_MEM_PRIVATE.

> @@ -881,6 +915,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
>  	struct userspace_mem_region *region;
>  	size_t backing_src_pagesz = get_backing_src_pagesz(src_type);
>  	size_t alignment;
> +	int restricted_memfd = -1;

No need to initialize to -1, KVM is supposed to ignore the restrictedmem fd if
!KVM_MEM_PRIVATE, and if KVM_MEM_PRIVATE is set, selftests must provide a valid fd.

>  	TEST_ASSERT(vm_adjust_num_guest_pages(vm->mode, npages) == npages,
>  		"Number of guest pages is not compatible with the host. "

This is what I ended up with after splitting out the conversion to
KVM_SET_USER_MEMORY_REGION2 to a separate patch.

--
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 7c1f81f93ba3..26c6830c1aa1 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -32,6 +32,11 @@ int open_path_or_exit(const char *path, int flags)
        return fd;
 }
 
+static int memfd_restricted(unsigned int flags)
+{
+       return syscall(__NR_memfd_restricted, flags);
+}
+
 /*
  * Open KVM_DEV_PATH if available, otherwise exit the entire program.
  *
@@ -980,6 +985,15 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
        }
 
        region->backing_src_type = src_type;
+
+       if (flags & KVM_MEM_PRIVATE) {
+               region->region.restricted_fd = memfd_restricted(0);
+               region->region.restricted_offset = 0;
+
+               TEST_ASSERT(region->region.restricted_fd >= 0,
+                           "Failed to create restricted memfd");
+       }
+
        region->unused_phy_pages = sparsebit_alloc();
        sparsebit_set_num(region->unused_phy_pages,
                guest_paddr >> vm->page_shift, npages);
@@ -992,9 +1006,10 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
        TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION2 IOCTL failed,\n"
                "  rc: %i errno: %i\n"
                "  slot: %u flags: 0x%x\n"
-               "  guest_phys_addr: 0x%lx size: 0x%lx",
+               "  guest_phys_addr: 0x%lx size: 0x%lx restricted fd: %d\n",
                ret, errno, slot, flags,
-               guest_paddr, (uint64_t) region->region.memory_size);
+               guest_paddr, (uint64_t) region->region.memory_size,
+               region->region.restricted_fd);
 
        /* Add to quick lookup data structures */
        vm_userspace_mem_region_gpa_insert(&vm->regions.gpa_tree, region);
