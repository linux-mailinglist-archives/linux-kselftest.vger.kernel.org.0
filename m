Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACF27CD115
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 01:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjJQX5B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 19:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjJQX5A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 19:57:00 -0400
Received: from cvs.openbsd.org (cvs.openbsd.org [199.185.137.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B8C90;
        Tue, 17 Oct 2023 16:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=selector1; bh=mQNHZDPQvu
        ASJotD/Odo+8JawxYjAz7b0WRb1xLoD38=; h=date:references:in-reply-to:
        subject:cc:to:from; d=openbsd.org; b=SLsc7qmIriF/7tGRoVuFVjym+4yzHDcvm
        2WYSeVfK5NvQoQHwxNjVKEVEFeqtPqLcFRtrNqprVXUEN19o1IoqL3nLWCiVAFKfTPMCnh
        gzppXtIR8ioKMjzfQjsCxG92iPn3mUIQ3mRGdLMD40TmbICajARhcH8/jVe7zmTmvFIBZh
        1Un0sWpK+8HVju+PDUNaT8DYdAdCoWLOg2fLc8yk1aYV+TJYqjrHflepmmet5wCuy9CCVy
        KvUQHZkA+jk9cfaeJzFAD0+6BfmA5ThqEvZoElGxyF4fcSw6O7Ti5gFQf5grAvrvqI4Xj4
        dDCefAMtLy4K1vH5F59NJ7ZeXGeJw==
Received: from cvs.openbsd.org (localhost [127.0.0.1])
        by cvs.openbsd.org (OpenSMTPD) with ESMTP id d383b937;
        Tue, 17 Oct 2023 17:56:55 -0600 (MDT)
From:   "Theo de Raadt" <deraadt@openbsd.org>
To:     Jeff Xu <jeffxu@google.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        jeffxu@chromium.org, akpm@linux-foundation.org,
        keescook@chromium.org, sroettger@google.com, jorgelo@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, surenb@google.com, alex.sierra@amd.com,
        apopple@nvidia.com, aneesh.kumar@linux.ibm.com,
        axelrasmussen@google.com, ben@decadent.org.uk,
        catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk,
        ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com,
        corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, lstoakes@gmail.com, willy@infradead.org,
        mawupeng1@huawei.com, linmiaohe@huawei.com, namit@vmware.com,
        peterx@redhat.com, peterz@infradead.org, ryan.roberts@arm.com,
        shr@devkernel.io, vbabka@suse.cz, xiujianfeng@huawei.com,
        yu.ma@intel.com, zhangpeng362@huawei.com, dave.hansen@intel.com,
        luto@kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
In-reply-to: <CALmYWFs81T=XnT=AXQTo0+9FXo=OBAV_4rrYPSn9-16O-gBTZg@mail.gmail.com>
References: <20231016143828.647848-1-jeffxu@chromium.org> <CAHk-=whFZoap+DBTYvJx6ohqPwn11Puzh7q4huFWDX9vBwXHgg@mail.gmail.com> <CALmYWFtTDAb_kpZdAe_xspqwNgK1NWJmjTxaTC=jDEMzfe297Q@mail.gmail.com> <CAHk-=wj87GMTH=5901ob=SjQqegAm2JYBE7E4J7skJzE64U-wQ@mail.gmail.com> <55960.1697566804@cvs.openbsd.org> <CALmYWFs81T=XnT=AXQTo0+9FXo=OBAV_4rrYPSn9-16O-gBTZg@mail.gmail.com>
Comments: In-reply-to Jeff Xu <jeffxu@google.com>
   message dated "Tue, 17 Oct 2023 16:01:13 -0700."
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <44926.1697587015.1@cvs.openbsd.org>
Date:   Tue, 17 Oct 2023 17:56:55 -0600
Message-ID: <95482.1697587015@cvs.openbsd.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Jeff Xu <jeffxu@google.com> wrote:

> May I ask, for BSD's implementation of immutable(), do you cover
> things such as mlock(),
> madvice() ? or just the protection bit (WRX) + remap() + unmap().

It only prevents removal of the mapping, placement of a replacement
mapping, or changing the existing permissions.  If one page in the
existing sub-region is marked immutable, the whole operation fails with
EPERM.

Those are the only user-visible aspects that an attacker cares about to
utilize in this area.

mlock() and madvise() deal with the physical memory handling underneath
the VA.  They have nothing to do with how attack code might manipulate
the VA address space inside a program to convert a series of dead-end
approaches into a succesfull escalation strategy.

[It would be very long conversation to explain where and how this has
been utilized to make an attack succesfull]

> In other words:
> Is BSD's definition of immutable equivalent to
> MM_SEAL_MPROTECT|MM_SEAL_MUNMAP|MM_SEAL_MREMAP|MM_SEAL_MMAP, of this patch set ?

I can't compare it to your subsystem, because I completely fail to
understand the cause or benefit of all the complexity.

I think I've explained what mimmutable() is in extremely simple terms.

And I don't understand else you are trying to do anything beyond what
mimmutable() offers.  It seems like this is inventing additional
solutions without proof that any of them are necessary to solve the
specific problem that is known.

> I hesitate to introduce the concept of immutable into linux because I don't know
> all the scenarios present in linux where VMAs's metadata can be
> modified.

Good grief.  It seems obvious if you want to lock the change-behaviour
of an object (the object in this case being a VA sub-region, there is a
datastructure for that, in OpenBSD it is called an "entry"), then you
put a flag in that object's data-structure and you simply check the flag
everytime a change-operation is attempted.  It is a flag which gets set,
and checked.  Nothing ever clears it (except address space teardown).

This flag must be put on the data structure that manages VA sub-ranges.

In our case when a prot/mapping operation reaches low-level code that
will want to change an "entry", we notice it is not allowed and simply
percolate EPERM up through the layers.

> There could be quite a few things we still need to deal with, to
> completely block the possibility,
> e.g. malicious code attempting to write to a RO memory

What?!  writes to RO memory are blocked by the permission bits.

> or change RW memory to RWX.

In our case that is blocked by W^X policy.

But if the region is marked mimmutable, then that's another reason you cannot
change RW to RWX.  It seems so off-topic, to talk about writes to RO memory.
I get a feeling you are a bit lost.

mimmutable() is not about permissions, but about locking permissions.
- You can't change the permissions of the address space region.
- You cannot map a replacement object at the location instead (especially
  with different permission).
- You cannot unmap at that location (which you would do if you wanted to
  map a new object, with a different permission).

All 3 of these scenarios are identical.  No regular code performs these 3
operations on regions of the address space which we mark immutable.

There is nothing more to mimmutable in the VM layer.  The hard work is
writing code in execve() and ld.so which will decide which objects can
be marked immutable automatically, so that programs don't do this to
themselves.

I'm aware of where this simple piece fits in.  It does not solve all
problems, it is a very narrow change to impact a problem which only
high-value targets will ever face (like chrome).

But I think you don't understand the purpose of this mechanism.

> If, as part of immutable, I also block madvice(), mlock(), which also updates
> VMA's metadata, so by definition, I could.  What if the user wants the
> features in
> madvice() and at the same time, also wants their .text protected ?

I have no idea what you are talking about.  None of those things relate
to the access permission of the memory the user sees, and therefore none
of them are in the attack surface profile which is being prevented.

Meaning, we allow madvise() and mlock() and mphysicalquantummemory() because
those relate to the physical storage and not the VA permission model.

> Also, if linux introduces a new syscall that depends on a new metadata of VMA,
> say msecret(), (for discussion purpose), should immutable
> automatically support that ?

How about the future makingexcuses() system call?

I don't think you understand the problem space well enough to come up with
your own solution for it.  I spent a year on this, and ship a complete system
using it.  You are asking such simplistic questions above it shocks me.

Maybe read the LWN article;

    https://lwn.net/Articles/915640/

> Without those questions answered, I couldn't choose the route of
> immutable() yet.

"... so I can clearly not choose the wine in front of you."

If you don't understand what this thing is for, and cannot minimize the
complexity of this thing, then Linux doesn't need it at all.

I should warn everyone the hard work is not in the VM layer, but in
ld.so -- deciding which parts of the image to make immutable, and when.
It is also possible to make some segments immutable directly in execve()
-- but in both cases you better have a really good grasp on RELRO
executable layout or will make too many pieces immutable...

I am pretty sure Linux will never get as far as we got. Even our main
stacks are marked immutable, but in Linux that would conflict with glibc
ld.so mprotecting RWX the stack if you dlopen() a shared library with
GNUSTACK, a very bad idea which needs a different fight...
