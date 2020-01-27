Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8AC914A108
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2020 10:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgA0Jmf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jan 2020 04:42:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57799 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729714AbgA0Jmf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jan 2020 04:42:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580118153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=Q6YN4hW4JTvSsXGjrvs6v5fpmdU5j7t9SYzgLeHUpT8=;
        b=IQ8rtfCmcOzyRy0Ajvy5h7z4zuU82Q9F0NLRM8hJEVTRb2sJEZ25r85XE6igHsWbrZ4bpG
        drw8nSEAq3e8IikKVbxA/AFeDIIpGLucssgZSa7wV9acOSKCPj+HCdAYN4LC/kc1QZfD9v
        C/aYqR1byqldr/ky+5PMd4Yr3W/gjFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-oLDz0EByPDyQNbm6YkINZg-1; Mon, 27 Jan 2020 04:42:31 -0500
X-MC-Unique: oLDz0EByPDyQNbm6YkINZg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA607800D41;
        Mon, 27 Jan 2020 09:42:29 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-94.ams2.redhat.com [10.36.117.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC83F87025;
        Mon, 27 Jan 2020 09:42:24 +0000 (UTC)
Subject: Re: [PATCH v4 10/10] KVM: selftests: Move memslot 0 above KVM
 internal memslots
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20200123180436.99487-1-bgardon@google.com>
 <20200123180436.99487-11-bgardon@google.com>
From:   Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f6aa338c-3942-b09f-863b-3725483de909@redhat.com>
Date:   Mon, 27 Jan 2020 10:42:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200123180436.99487-11-bgardon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 23/01/2020 19.04, Ben Gardon wrote:
> KVM creates internal memslots between 3 and 4 GiB paddrs on the first
> vCPU creation. If memslot 0 is large enough it collides with these
> memslots an causes vCPU creation to fail. Instead of creating memslot 0
> at paddr 0, start it 4G into the guest physical address space.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 5b971c04f1643..427c88d32e988 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -130,9 +130,11 @@ _Static_assert(sizeof(vm_guest_mode_string)/sizeof(char *) == NUM_VM_MODES,
>   *
>   * Creates a VM with the mode specified by mode (e.g. VM_MODE_P52V48_4K).
>   * When phy_pages is non-zero, a memory region of phy_pages physical pages
> - * is created and mapped starting at guest physical address 0.  The file
> - * descriptor to control the created VM is created with the permissions
> - * given by perm (e.g. O_RDWR).
> + * is created, starting at 4G into the guest physical address space to avoid
> + * KVM internal memslots which map the region between 3G and 4G. If tests need
> + * to use the physical region between 0 and 3G, they can allocate another
> + * memslot for that region. The file descriptor to control the created VM is
> + * created with the permissions given by perm (e.g. O_RDWR).
>   */
>  struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
>  {
> @@ -231,7 +233,8 @@ struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
>  	vm->vpages_mapped = sparsebit_alloc();
>  	if (phy_pages != 0)
>  		vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
> -					    0, 0, phy_pages, 0);
> +					    KVM_INTERNAL_MEMSLOTS_END_PADDR,
> +					    0, phy_pages, 0);
>  
>  	return vm;
>  }

This patch causes *all* tests on s390x to fail like this:

# selftests: kvm: sync_regs_test
# Testing guest mode: PA-bits:52,  VA-bits:48,  4K pages
# ==== Test Assertion Failure ====
#   lib/kvm_util.c:1059: false
#   pid=248244 tid=248244 - Success
#      1	0x0000000001002f3d: addr_gpa2hva at kvm_util.c:1059
#      2	 (inlined by) addr_gpa2hva at kvm_util.c:1047
#      3	0x0000000001006edf: addr_gva2gpa at processor.c:144
#      4	0x0000000001004345: addr_gva2hva at kvm_util.c:1636
#      5	0x00000000010077c1: kvm_vm_elf_load at elf.c:192
#      6	0x00000000010070c3: vm_create_default at processor.c:228
#      7	0x0000000001001347: main at sync_regs_test.c:87
#      8	0x000003ffba7a3461: ?? ??:0
#      9	0x0000000001001965: .annobin_init.c.hot at crt1.o:?
#     10	0xffffffffffffffff: ?? ??:0
#   No vm physical memory at 0x0
not ok 2 selftests: kvm: sync_regs_test # exit=254

AFAIK the ELF binaries on s390x are linked to addresses below 4G, so
generally removing the memslot here seems to be a bad idea on s390x.

 Thomas

