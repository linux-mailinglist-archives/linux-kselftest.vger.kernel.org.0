Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1CD132A3E
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2020 16:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgAGPml (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jan 2020 10:42:41 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23692 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727559AbgAGPmh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jan 2020 10:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578411756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4wLEHGHPhIC5q6TMsrDGtuJlxvXE4KzHLl3MK2FPWK8=;
        b=i59dRoyFr6LLXXSTv7k5nsHKeTjTSawOnIlmKvQwSPby0SAaQZ+LmE3HPhLNAtACHpQsCO
        cjAbyGRY3/ZjHyynD1e+WhmufBTupMWPSD9zsfsh29u+zlmDYB7ImPhwVAIiV8+WxfZwbK
        uhoY1hJlWlDnQtnJ0ios1y5j88gLMAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-wutgYkhiOu2XDKVMUqeJlQ-1; Tue, 07 Jan 2020 10:42:35 -0500
X-MC-Unique: wutgYkhiOu2XDKVMUqeJlQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 096CE800D4E;
        Tue,  7 Jan 2020 15:42:34 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 029CC10842AB;
        Tue,  7 Jan 2020 15:42:29 +0000 (UTC)
Date:   Tue, 7 Jan 2020 16:42:27 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v3 8/8] KVM: selftests: Move large memslots above KVM
 internal memslots in _vm_create
Message-ID: <20200107154227.tvex5natt7a64nzj@kamzik.brq.redhat.com>
References: <20191216213901.106941-1-bgardon@google.com>
 <20191216213901.106941-9-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216213901.106941-9-bgardon@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 16, 2019 at 01:39:01PM -0800, Ben Gardon wrote:
> KVM creates internal memslots between 3 and 4 GiB paddrs on the first
> vCPU creation. If memslot 0 is large enough it collides with these
> memslots an causes vCPU creation to fail. When requesting more than 3G,
> start memslot 0 at 4G in _vm_create.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 41cf45416060f..886d58e6cac39 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -113,6 +113,8 @@ const char * const vm_guest_mode_string[] = {
>  _Static_assert(sizeof(vm_guest_mode_string)/sizeof(char *) == NUM_VM_MODES,
>  	       "Missing new mode strings?");
>  
> +#define KVM_INTERNAL_MEMSLOTS_START_PADDR (3UL << 30)
> +#define KVM_INTERNAL_MEMSLOTS_END_PADDR (4UL << 30)
>  /*
>   * VM Create
>   *
> @@ -128,13 +130,16 @@ _Static_assert(sizeof(vm_guest_mode_string)/sizeof(char *) == NUM_VM_MODES,
>   *
>   * Creates a VM with the mode specified by mode (e.g. VM_MODE_P52V48_4K).
>   * When phy_pages is non-zero, a memory region of phy_pages physical pages
> - * is created and mapped starting at guest physical address 0.  The file
> - * descriptor to control the created VM is created with the permissions
> - * given by perm (e.g. O_RDWR).
> + * is created. If phy_pages is less that 3G, it is mapped starting at guest
> + * physical address 0. If phy_pages is greater than 3G it is mapped starting
> + * 4G into the guest physical address space to avoid KVM internal memslots
> + * which map the region between 3G and 4G. The file descriptor to control the
> + * created VM is created with the permissions given by perm (e.g. O_RDWR).
>   */
>  struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
>  {
>  	struct kvm_vm *vm;
> +	uint64_t guest_paddr = 0;
>  
>  	DEBUG("Testing guest mode: %s\n", vm_guest_mode_string(mode));
>  
> @@ -227,9 +232,11 @@ struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
>  
>  	/* Allocate and setup memory for guest. */
>  	vm->vpages_mapped = sparsebit_alloc();
> +	if (guest_paddr + phy_pages > KVM_INTERNAL_MEMSLOTS_START_PADDR)
> +		guest_paddr = KVM_INTERNAL_MEMSLOTS_END_PADDR;
>  	if (phy_pages != 0)
>  		vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
> -					    0, 0, phy_pages, 0);
> +					    guest_paddr, 0, phy_pages, 0);
>  
>  	return vm;
>  }
> -- 
> 2.24.1.735.g03f4e72817-goog
>

I feel like this function is becoming too magic and it'll be more
complicated for tests that need to add additional memory regions
to know what physical addresses are available. Maybe we should assert
if we can't allocate more than 3G at offset zero and also provide
another interface for allocating at an offset input by the user,
as long as the offset is 4G or above (asserting when it isn't)?

Thanks,
drew

