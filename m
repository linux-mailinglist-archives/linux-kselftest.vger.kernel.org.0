Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB7A7CCA9B
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 20:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbjJQS0v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 14:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbjJQS0v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 14:26:51 -0400
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Oct 2023 11:26:45 PDT
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C43695;
        Tue, 17 Oct 2023 11:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=0vFOoOA2DO
        SeMlsOMQTQm68lyM381k3f90VCwzU3xik=; h=date:references:in-reply-to:
        subject:cc:to:from; d=openbsd.org; b=cIkCOZ/43MKoljVmU3oRIB4u6WYxtaE7o
        HZOM2BZ8S56HfUIZsfnpEjQlT6nX8BjUvl337ZyDmbEBR3FpWbSEpIlQhSH5efoMABMvJu
        fPt7B7kxCc9BiJcGMLspMoq2n0fp0t4vNihP+GRYwnQ+PXtGXD00kbiv6GNtzR0gKbGJ2n
        nYXtaGErAXUWTKCJkCh6yf0nMOHJTEbyc9d6WznvhkM317NdEQJ0MO3xpLbqrwJ5qQRKZ+
        v2DSU4O5x8TQLQ5B2gVSWAEkpok4RBLhTzp2/vt9wlc0QkWf+E2fBCJ4Ld1tjjxZ7uC/EA
        Y8rLsgyMD35PthyzgC6BHgpnpp5Ag==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
        by cvs.openbsd.org (OpenSMTPD) with ESMTP id f82c6e56;
        Tue, 17 Oct 2023 12:20:04 -0600 (MDT)
From:   "Theo de Raadt" <deraadt@openbsd.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Jeff Xu <jeffxu@google.com>, jeffxu@chromium.org,
        akpm@linux-foundation.org, keescook@chromium.org,
        sroettger@google.com, jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com, surenb@google.com,
        alex.sierra@amd.com, apopple@nvidia.com,
        aneesh.kumar@linux.ibm.com, axelrasmussen@google.com,
        ben@decadent.org.uk, catalin.marinas@arm.com, david@redhat.com,
        dwmw@amazon.co.uk, ying.huang@intel.com, hughd@google.com,
        joey.gouly@arm.com, corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, lstoakes@gmail.com, willy@infradead.org,
        mawupeng1@huawei.com, linmiaohe@huawei.com, namit@vmware.com,
        peterx@redhat.com, peterz@infradead.org, ryan.roberts@arm.com,
        shr@devkernel.io, vbabka@suse.cz, xiujianfeng@huawei.com,
        yu.ma@intel.com, zhangpeng362@huawei.com, dave.hansen@intel.com,
        luto@kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
In-reply-to: <CAHk-=wj87GMTH=5901ob=SjQqegAm2JYBE7E4J7skJzE64U-wQ@mail.gmail.com>
References: <20231016143828.647848-1-jeffxu@chromium.org> <CAHk-=whFZoap+DBTYvJx6ohqPwn11Puzh7q4huFWDX9vBwXHgg@mail.gmail.com> <CALmYWFtTDAb_kpZdAe_xspqwNgK1NWJmjTxaTC=jDEMzfe297Q@mail.gmail.com> <CAHk-=wj87GMTH=5901ob=SjQqegAm2JYBE7E4J7skJzE64U-wQ@mail.gmail.com>
Comments: In-reply-to Linus Torvalds <torvalds@linux-foundation.org>
   message dated "Tue, 17 Oct 2023 10:22:16 -0700."
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <35552.1697566804.1@cvs.openbsd.org>
Date:   Tue, 17 Oct 2023 12:20:04 -0600
Message-ID: <55960.1697566804@cvs.openbsd.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, 17 Oct 2023 at 02:08, Jeff Xu <jeffxu@google.com> wrote:
> >
> > It is probably worth noting that I choose to check one and only
> > one sealing type per syscall. i.e. munmap(2) checks
> > MM_SEAL_MUNMAP only.
> 
> Yeah, this is wrong.
> 
> It's wrong exactly because other system calls will unmap things too.
> 
> Using mmap() to over-map something will unmap the old one.
> 
> Same goes for mremap() to move over an existing mapping.
> 
> So the whole "do things by the name of the system call" is not workable.
> 
> All that matters is what the system calls *do*, not what their name is.

I agree completely...

mseal() is a clone of mimmutable(2), but with an extremely
over-complicated API based upon dubious arguments.

I designed mimmutable(2) [1] in OpenBSD, it took about a year to get all
the components working correctly.  There were many intermediate API
during development, but in the end the API is simply:

     int mimmutable(void *addr, size_t len);

The kernel code for mimmutable() traverses the specified VA range.  In
that range, it will find unmapped sub-regions (which are are ignored)
and mapped sub-regions. For these mapped regions, it does not care what
the permissions are, it just marks each sub-region as immutable.

Later on, when any VM operation request upon a VA range attempts to
      (1) change the permissions
      (2) to re-map on top
      (3) or dispose of the mapping,
that operation is refused with errno EPERM.  We don't care where the
request comes from (ie. what system call).  It is a behaviour of the
VM system, when asked to act upon a VA sub-range mapping.

Very simple semantics.

The only case where the immutable marker is ignored is during address space
teardown as a result of process termination.


In his submission of this API, Jeff Xu makes three claims I find dubious;

> Also, Chrome wants to adopt this feature for their CFI work [2] and this
> patchset has been designed to be compatible with the Chrome use case.

I specifically designed mimmutable(2) with chrome in mind, and the
chrome binary running on OpenBSD is full of immutable mappings.  All the
library regions automatically become immutable because ld.so can infer
it and do the mimmutable calls for the right subregions.

So this chrome work has already been done by OpenBSD, and it is dead
simple.  During early development I thought mimmutable(2) would be
called by applications or libraries, but I was dead wrong: 99.9% of
calls are from ld.so, and no applications need to call it, these are the
two exceptions:

In OpenBSD, mimmutable() is used in libc malloc() to lock-down some data
structures at initialization time, so they canoot be attacked to create
an invariant for use in ROP return-to-libc style methods.

In Chrome, there is a v8_flags variable rounded out to a full page, and
placed in .data.  Chrome initialized this variable, and wants to mprotect
PROT_READ, but .data has been made immutable by ld.so.  So we force this
page into a new ELF section called "openbsd.mutable" which also behaves RW
like .data.  Where chrome does the mprotect  PROT_READ, it now also performs
mimmutable() on that page.

> Having a seal type per syscall type helps to add the feature incrementally.

Yet, somehow OpenBSD didn't do it per syscall, and we managed to make our
entire base operating system and 10,000+ applications automatically receive
the benefits.  In one year's effort.  The only application which cared about
it was chrome, described in the previous paragraph.

I think Jeff's idea here is super dangerous.  What will actually happen
is people will add a few mseal() sub-operations and think the job is done.
It isn't done.  They need all the mseal() requests, or the mapping are
not safe.

It is very counterproductive to provide developers a complex API that has
insecure suboperations.

> Applications also know exactly what is sealed.

Actually applicatins won't know because there is no tooling to inspect this --
but I will argue further that applications don't need to know.  Immutable
marking is a system decision, not a program decision.


I'll close by asking for a new look at the mimmutable(2) API we settled
on for OpenBSD.  I think there is nothing wrong with it.  I'm willing to
help guide glibc / ld.so / musl teams through the problems they may find
along the way, I know where the skeletons are buried.  Two in
particular: -znow RELRO already today, and xonly-text in the future.


[1] https://man.openbsd.org/mimmutable.2

