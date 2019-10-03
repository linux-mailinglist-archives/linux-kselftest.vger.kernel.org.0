Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABFA7C9988
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2019 10:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbfJCIKR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Oct 2019 04:10:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfJCIKQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Oct 2019 04:10:16 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6655C300BEA4;
        Thu,  3 Oct 2019 08:10:16 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B529819C6A;
        Thu,  3 Oct 2019 08:10:12 +0000 (UTC)
Date:   Thu, 3 Oct 2019 10:10:10 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 7/9] KVM: selftests: Add parameter to _vm_create for
 memslot 0 base paddr
Message-ID: <20191003081010.shestpcaqc7knoct@kamzik.brq.redhat.com>
References: <20190927161836.57978-1-bgardon@google.com>
 <20190927161836.57978-8-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927161836.57978-8-bgardon@google.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 03 Oct 2019 08:10:16 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 27, 2019 at 09:18:35AM -0700, Ben Gardon wrote:
> KVM creates internal memslots between 3 and 4 GiB paddrs on the first
> vCPU creation. If memslot 0 is large enough it collides with these
> memslots an causes vCPU creation to fail. Add a paddr parameter for
> memslot 0 so that tests which support large VMs can relocate memslot 0
> above 4 GiB.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  tools/testing/selftests/kvm/demand_paging_test.c | 2 +-
>  tools/testing/selftests/kvm/dirty_log_test.c     | 2 +-
>  tools/testing/selftests/kvm/include/kvm_util.h   | 3 ++-
>  tools/testing/selftests/kvm/lib/kvm_util.c       | 7 ++++---
>  4 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> index fe6c5a4f8b8c2..eb1f7e4b83de3 100644
> --- a/tools/testing/selftests/kvm/demand_paging_test.c
> +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> @@ -171,7 +171,7 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, int vcpus,
>  	pages += (2 * pages) / PTES_PER_PT;
>  	pages += ((2 * vcpus * vcpu_wss) >> PAGE_SHIFT_4K) / PTES_PER_PT;
>  
> -	vm = _vm_create(mode, pages, O_RDWR);
> +	vm = vm_create(mode, pages, O_RDWR);

Eh, we should have removed/renamed _vm_create() with 12c386b23083 ("KVM:
selftests: Move vm type into _vm_create() internally")

>  	kvm_vm_elf_load(vm, program_invocation_name, 0, 0);
>  #ifdef __x86_64__
>  	vm_create_irqchip(vm);
> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
> index 5614222a66285..181eac3a12b66 100644
> --- a/tools/testing/selftests/kvm/dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
> @@ -252,7 +252,7 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, uint32_t vcpuid,
>  	struct kvm_vm *vm;
>  	uint64_t extra_pg_pages = extra_mem_pages / 512 * 2;
>  
> -	vm = _vm_create(mode, DEFAULT_GUEST_PHY_PAGES + extra_pg_pages, O_RDWR);
> +	vm = vm_create(mode, DEFAULT_GUEST_PHY_PAGES + extra_pg_pages, O_RDWR);
>  	kvm_vm_elf_load(vm, program_invocation_name, 0, 0);
>  #ifdef __x86_64__
>  	vm_create_irqchip(vm);
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index 29cccaf96baf6..4f672c00c9e9b 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -69,7 +69,8 @@ int kvm_check_cap(long cap);
>  int vm_enable_cap(struct kvm_vm *vm, struct kvm_enable_cap *cap);
>  
>  struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm);
> -struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm);
> +struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t guest_paddr,
> +			  uint64_t phy_pages, int perm);

But now we need it again. Or do we? How about just documenting that if
phy_pages is >= some-limit then the base address will be 4G, otherwise
it will be zero? The documentation (comment above _vm_create()) needs to
be updated with this patch regardless. Either the behavior changes or a
new parameter is added.

If you go with my suggestion to just use 4G when phy_pages are large, then
please rename _vm_create to vm_create.

Thanks,
drew

>  void kvm_vm_free(struct kvm_vm *vmp);
>  void kvm_vm_restart(struct kvm_vm *vmp, int perm);
>  void kvm_vm_release(struct kvm_vm *vmp);
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 80a338b5403c3..7ec2bbdaba875 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -132,7 +132,8 @@ _Static_assert(sizeof(vm_guest_mode_string)/sizeof(char *) == NUM_VM_MODES,
>   * descriptor to control the created VM is created with the permissions
>   * given by perm (e.g. O_RDWR).
>   */
> -struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
> +struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t guest_paddr,
> +			  uint64_t phy_pages, int perm)
>  {
>  	struct kvm_vm *vm;
>  
> @@ -229,14 +230,14 @@ struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
>  	vm->vpages_mapped = sparsebit_alloc();
>  	if (phy_pages != 0)
>  		vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
> -					    0, 0, phy_pages, 0);
> +					    guest_paddr, 0, phy_pages, 0);
>  
>  	return vm;
>  }
>  
>  struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
>  {
> -	return _vm_create(mode, phy_pages, perm);
> +	return _vm_create(mode, 0, phy_pages, perm);
>  }
>  
>  /*
> -- 
> 2.23.0.444.g18eeb5a265-goog
> 
