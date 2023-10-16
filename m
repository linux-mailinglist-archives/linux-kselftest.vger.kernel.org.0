Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5EC7CAD2B
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 17:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjJPPSq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 11:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbjJPPSp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 11:18:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDF1F1;
        Mon, 16 Oct 2023 08:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q1mk0edZzBzeqvaBvILL9fveNRk2O03GLgP3WO+MmcU=; b=EV9tZnQJGPjQ2XN7YaG1iFBGwU
        CVhmKPs4rfB0vzIIjYWOAFfuD8Lclxxb3kH9GuUcHbzKvVXDibGUns84n44sJwba/b5OZXYMzpfgc
        Dg3+GrFpKnF/FDc20y8fLmw/tWdZbWw7RZsmvQoWmOhZCj4gAoOA9oajpabnWYYOpQUagNYIbtKWU
        sGfpICUov4sq+UCTadpy86PtxT8/LdcX+L9mItkitNc1hiT0ERHcMCKmrXX2UsbrO7bsGd6AbXmMX
        AXNe8drk59YS8DwfBT4C8y+gASl7XiGxQ5RaNLDQisdytnXdQNpebca/HI2dFRVHE8UWOo+ePROth
        daal4R4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qsPMS-006lo3-BB; Mon, 16 Oct 2023 15:18:28 +0000
Date:   Mon, 16 Oct 2023 16:18:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     jeffxu@chromium.org
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        sroettger@google.com, jeffxu@google.com, jorgelo@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, surenb@google.com, alex.sierra@amd.com,
        apopple@nvidia.com, aneesh.kumar@linux.ibm.com,
        axelrasmussen@google.com, ben@decadent.org.uk,
        catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk,
        ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com,
        corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, torvalds@linux-foundation.org,
        lstoakes@gmail.com, mawupeng1@huawei.com, linmiaohe@huawei.com,
        namit@vmware.com, peterx@redhat.com, peterz@infradead.org,
        ryan.roberts@arm.com, shr@devkernel.io, vbabka@suse.cz,
        xiujianfeng@huawei.com, yu.ma@intel.com, zhangpeng362@huawei.com,
        dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
Message-ID: <ZS1URCBgwGGj9JtM@casper.infradead.org>
References: <20231016143828.647848-1-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016143828.647848-1-jeffxu@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 16, 2023 at 02:38:19PM +0000, jeffxu@chromium.org wrote:
> Modern CPUs support memory permissions such as RW and NX bits. Linux has
> supported NX since the release of kernel version 2.6.8 in August 2004 [1].

This seems like a confusing way to introduce the subject.  Here, you're
talking about page permissions, whereas (as far as I can tell), mseal() is
about making _virtual_ addresses immutable, for some value of immutable.

> Memory sealing additionally protects the mapping itself against
> modifications. This is useful to mitigate memory corruption issues where
> a corrupted pointer is passed to a memory management syscall. For example,
> such an attacker primitive can break control-flow integrity guarantees
> since read-only memory that is supposed to be trusted can become writable
> or .text pages can get remapped. Memory sealing can automatically be
> applied by the runtime loader to seal .text and .rodata pages and
> applications can additionally seal security critical data at runtime.
> A similar feature already exists in the XNU kernel with the
> VM_FLAGS_PERMANENT [3] flag and on OpenBSD with the mimmutable syscall [4].
> Also, Chrome wants to adopt this feature for their CFI work [2] and this
> patchset has been designed to be compatible with the Chrome use case.

This [2] seems very generic and wide-ranging, not helpful.  [5] was more
useful to understand what you're trying to do.

> The new mseal() is an architecture independent syscall, and with
> following signature:
> 
> mseal(void addr, size_t len, unsigned int types, unsigned int flags)
> 
> addr/len: memory range.  Must be continuous/allocated memory, or else
> mseal() will fail and no VMA is updated. For details on acceptable
> arguments, please refer to comments in mseal.c. Those are also fully
> covered by the selftest.

Mmm.  So when you say "continuous/allocated" what you really mean is
"Must have contiguous VMAs" rather than "All pages in this range must
be populated", yes?

> types: bit mask to specify which syscall to seal, currently they are:
> MM_SEAL_MSEAL 0x1
> MM_SEAL_MPROTECT 0x2
> MM_SEAL_MUNMAP 0x4
> MM_SEAL_MMAP 0x8
> MM_SEAL_MREMAP 0x10

I don't understand why we want this level of granularity.  The OpenBSD
and XNU examples just say "This must be immutable*".  For values of
immutable that allow downgrading access (eg RW to RO or RX to RO),
but not upgrading access (RW->RX, RO->*, RX->RW).

> Each bit represents sealing for one specific syscall type, e.g.
> MM_SEAL_MPROTECT will deny mprotect syscall. The consideration of bitmask
> is that the API is extendable, i.e. when needed, the sealing can be
> extended to madvise, mlock, etc. Backward compatibility is also easy.

Honestly, it feels too flexible.  Why not just two flags to mprotect()
-- PROT_IMMUTABLE and PROT_DOWNGRADABLE.  I can see a use for that --
maybe for some things we want to be able to downgrade and for other
things, we don't.

I'd like to see some discussion of how this interacts with mprotect().
As far as I can tell, the intent is to lock the protections/existance
of the mapping, and not to force memory to stay in core.  So it's fine
for the kernel to swap out the page and set up a PTE as a swap entry.
It's also fine for the kernel to mark PTEs as RO to catch page faults;
we're concerned with the LOGICAL permissions, and not the page tables.
