Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1459670BA3
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jan 2023 23:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjAQW31 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Jan 2023 17:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjAQW3K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Jan 2023 17:29:10 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3E78103C
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 14:07:00 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so294815pjg.4
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 14:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VJRxdhIH1ei+8E9XvKSd+3xhLQMFnFsZgxlpSYok93A=;
        b=AxTejcJhAV5uqM6nwNX4/8W/dC62kMHt47pu6LkWJkYBQ+CazfpjLysRcdPEeD7J7R
         Ab82K6BZiG9T8tN4ylw6fC6k7Zf7mYuHC6tgFlQxOA90kcFRuTfTJy/3sqkyKnj7xlZV
         msfEbi10sjs1UrnObHLZ2oICh8nWyZ5vxf3q0N4kngC9RJU7Ez6BeiDuoXWdoYmgTB8z
         0oGvaHE5JwIw+W8WZssQh5JCuvTlsabDt7q1QFp/2Y8oIYK8QCh3cS9C+AOPDj9GSa6n
         N3gOrunFRToMDvoJl73VjJKmEx3zcRkIDP+n8mJ+18bJxyHLkOxU2OXA9SaK4zscuktw
         /JuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJRxdhIH1ei+8E9XvKSd+3xhLQMFnFsZgxlpSYok93A=;
        b=pP+Rq9JCen51/b9Mfe2l9R0Kol0B4QODMZX8DhdMm+O5b1ErCtKRjgQf2XxsCylNIb
         84+K6nSl4KM/P8WRT3jUs7QVE3nikIO5Bsb9DbHkQQvvMoY+kFZoAtiBKODdEMjT+uYQ
         3GVCwmTzrw39Dm9IcgqHYvBRllqaVRXXBrNq5YlgIZt/0+cySqRDg9kWU9Dt0D9c30On
         Iq4ArfNrVLzTLEfjeEXmFiKSYp5OafOi/yqO/Z6GfrFmmvX7enfYLW36/WgD0Ntdst3f
         9Pyz8LbiRQXel9KBmrNuQFKkM8VvtDxdypAr/kWdzWRHfNBb9QBY7pu9dNOj01SXotRt
         X8qw==
X-Gm-Message-State: AFqh2koDSTL8n2mqvSVOTBFwXCLb6BJWXsH7Y++nurBnc/lDDfXSXgwq
        xT00tl6SBNnmtWMau/NK/efR2A==
X-Google-Smtp-Source: AMrXdXu82aDcnqFZtAav3ieEPMc/umOMQz5EXpr+Sf0yV9xRA5h5tXwktjdgLqtV0+s2sklRjexODw==
X-Received: by 2002:a17:902:b10e:b0:191:4367:7fde with SMTP id q14-20020a170902b10e00b0019143677fdemr2358411plr.0.1673993218276;
        Tue, 17 Jan 2023 14:06:58 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e80600b0019251e959b1sm21609801plg.262.2023.01.17.14.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 14:06:57 -0800 (PST)
Date:   Tue, 17 Jan 2023 22:06:54 +0000
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
Subject: Re: [V2 PATCH 4/6] KVM: selftests: x86: Add helpers to execute VMs
 with private memory
Message-ID: <Y8cb/i/jcUAJvM+M@google.com>
References: <20221205232341.4131240-1-vannapurve@google.com>
 <20221205232341.4131240-5-vannapurve@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205232341.4131240-5-vannapurve@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 05, 2022, Vishal Annapurve wrote:
> Introduce a set of APIs to execute VM with private memslots.
> 
> Host userspace APIs for:
> 1) Executing a vcpu run loop that handles MAPGPA hypercall
> 2) Backing/unbacking guest private memory
> 
> Guest APIs for:
> 1) Changing memory mapping type
> 
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../kvm/include/x86_64/private_mem.h          |  24 +++
>  .../selftests/kvm/lib/x86_64/private_mem.c    | 139 ++++++++++++++++++
>  3 files changed, 164 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/include/x86_64/private_mem.h
>  create mode 100644 tools/testing/selftests/kvm/lib/x86_64/private_mem.c

Given that we _know_ private memory isn't always going to x86 specific, I don't
want to bury any helpers in x86_64 that aren't strictly x86 only.  E.g. helpers
for doing Intel+AMD hypercalls is ok, but "generic" private memory helpers belong
elsewhere.

I experimented with extracting memslots/mmu helpers out of kvm_util.c as prep work,
e.g. to avoid bloating kvm_util.c, but I couldn't come up with an obviously "good"
naming scheme and/or split.  At this time, the common bits are fairly small, so
I think the best approach for now is to simply put vm_mem_map_shared_or_private()
in kvm_util.c.

> +static inline uint64_t __kvm_hypercall_map_gpa_range(uint64_t gpa, uint64_t size,
> +	uint64_t flags)
> +{
> +	return kvm_hypercall(KVM_HC_MAP_GPA_RANGE, gpa, size >> PAGE_SHIFT, flags, 0);
> +}

This can go in tools/testing/selftests/kvm/include/x86_64/processor.h.

> +static inline void kvm_hypercall_map_gpa_range(uint64_t gpa, uint64_t size,
> +	uint64_t flags)
> +{
> +	uint64_t ret;
> +
> +	GUEST_ASSERT_2(IS_PAGE_ALIGNED(gpa) && IS_PAGE_ALIGNED(size), gpa, size);
> +
> +	ret = __kvm_hypercall_map_gpa_range(gpa, size, flags);
> +	GUEST_ASSERT_1(!ret, ret);
> +}
> +
> +void kvm_hypercall_map_shared(uint64_t gpa, uint64_t size)
> +{
> +	kvm_hypercall_map_gpa_range(gpa, size, KVM_MAP_GPA_RANGE_DECRYPTED);
> +}
> +
> +void kvm_hypercall_map_private(uint64_t gpa, uint64_t size)
> +{
> +	kvm_hypercall_map_gpa_range(gpa, size, KVM_MAP_GPA_RANGE_ENCRYPTED);
> +}
> +
> +static void vm_update_private_mem(struct kvm_vm *vm, uint64_t gpa, uint64_t size,
> +	bool unback_mem)

s/unback_mem/map_shared.  "unback memory" is going to be super confusing to someone
who isn't familiar with UPM.  map_private would be the obvious alternative, but
I like not having to invert the param in the helper.

> +{
> +	int restricted_fd;
> +	uint64_t restricted_fd_offset, guest_phys_base, fd_offset;
> +	struct kvm_memory_attributes attr;
> +	struct kvm_userspace_memory_region_ext *region_ext;
> +	struct kvm_userspace_memory_region *region;
> +	int fallocate_mode = 0;
> +	int ret;
> +
> +	region_ext = kvm_userspace_memory_region_ext_find(vm, gpa, gpa + size);

I forget if I've already mentioned this somewhere, but I'd prefer to use the
"private" userspace_mem_region_find() and delete the existing
kvm_userspace_memory_region_find().

> +	TEST_ASSERT(region_ext != NULL, "Region not found");
> +	region = &region_ext->region;
> +	TEST_ASSERT(region->flags & KVM_MEM_PRIVATE,
> +		"Can not update private memfd for non-private memslot\n");
> +	restricted_fd = region_ext->restricted_fd;
> +	restricted_fd_offset = region_ext->restricted_offset;
> +	guest_phys_base = region->guest_phys_addr;
> +	fd_offset = restricted_fd_offset + (gpa - guest_phys_base);
> +
> +	if (unback_mem)
> +		fallocate_mode = (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE);
> +
> +	printf("restricted_fd %d fallocate_mode 0x%x for offset 0x%lx size 0x%lx\n",
> +		restricted_fd, fallocate_mode, fd_offset, size);

Don't put prints in common helpers, except _maybe_ for error paths.  It's fine
for development and/or debug, but for the final product it ends up being noise 99%
of the time.  If you really, really want printing checked in, then pr_debug() is an
option, but I would generally discourage even that for selftests.  E.g. strace can
give you all the information printed here without needing to rebuild the binary,
and without maintenance burden.

> +	ret = fallocate(restricted_fd, fallocate_mode, fd_offset, size);
> +	TEST_ASSERT(ret == 0, "fallocate failed\n");

Use whitespace to differntiate operations/blocks.

> +	attr.attributes = unback_mem ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE;
> +	attr.address = gpa;
> +	attr.size = size;
> +	attr.flags = 0;

Add a helper to do KVM_SET_MEMORY_ATTRIBUTES, e.g. to fill the appropriate struct.

> +	if (unback_mem)
> +		printf("undoing encryption for gpa 0x%lx size 0x%lx\n", gpa, size);
> +	else
> +		printf("doing encryption for gpa 0x%lx size 0x%lx\n", gpa, size);
> +
> +	vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES, &attr);
> +}


void vm_mem_map_shared_or_private(struct kvm_vm *vm, uint64_t gpa,
				  uint64_t size, bool map_shared)
{
	struct userspace_mem_region *region;
	uint64_t end = gpa + size - 1;
	off_t fd_offset;
	int mode, ret;

	region = userspace_mem_region_find(vm, gpa, gpa);
	TEST_ASSERT(region && region->region.flags & KVM_MEM_PRIVATE,
		    "Private memory region not found for GPA 0x%lx", gpa);

	TEST_ASSERT(region == userspace_mem_region_find(vm, end, end),
		    "Private/Shared conversions must act on a single memslot");

	fd_offset = region->region.restricted_offset +
		    (gpa - region->region.guest_phys_addr);

	/* To map shared, punch a hole.  To map private, allocate (no flags). */
	mode = map_shared ? (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE) : 0;

	ret = fallocate(region->region.restricted_fd, mode, fd_offset, size);
	TEST_ASSERT(!ret, "fallocate() failed to map %lx[%lu] %s, fd = %d, mode = %x, offset = %lx\n",
		     gpa, size, map_shared ? "shared" : "private",
		     region->region.restricted_fd, mode, fd_offset);

	vm_set_memory_attributes(vm, gpa, size,
				 map_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE);
}
