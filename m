Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996AE7CD29F
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 05:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjJRDT2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 23:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJRDT1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 23:19:27 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD25FE
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 20:19:24 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-41cb7720579so108171cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 20:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697599163; x=1698203963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvCHuca5gqFmVX6ADoD31L9497cKfFiOdWSXxTUJEiA=;
        b=QY3qE0VzxA3ucSbBUlVveWXY8K9AlCJP48QeM9NUFNAZW0JKdNze4OmybzBUO9fIYA
         PGob+9UvTwMsCK7nTCqeoOZq/XDizS1In/Ms2aXqvdbjB0tLblYXNhOtJrCWM37fY+fY
         XuU8JNu4w3WRg3L1zeqU5zf6jU5otHpWuY8Ltfqpyq0nC0K5QaNkNZ67PpTbxeOWpY9b
         oKFN6IwwIilrRwcl/v+/gU6HT0G+fkyJBOZXXogaxnCuBiDJlXnHRHVEIzkLkdaj1ZVv
         4poD0RQv01avcJPqlFiXYYKhy49Ae9YWh5EAzyvdhkp0hAB75T0NAELQm+NelC0zBfTS
         eLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697599163; x=1698203963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MvCHuca5gqFmVX6ADoD31L9497cKfFiOdWSXxTUJEiA=;
        b=GaF6+CyS8A5PW6/N9T/KBNnsYV74LEldWc8ZsKHtHj87EHXRly899wWKdj+OPXfnmp
         7Zs0jg5/vSvbLUNUecz9Ywty9eRwSvWyrO7osugpwI535M1eI5VSjr2kiIfc4ygI4T9n
         3Sfey3PQLSJ0C4ENcdz0C3LSTMGqEiCHLAofk47kNSoST+loEqRFzMnWcmU4++FQe+Ps
         YKKs20+OYOMPIg3horV+Yg8TwYs7vDpJComgnLa7mPAYizT/wEASdQ+sv4uU70FNjzTQ
         iWiGAH/YkoIMFSNKt2RZkQHTOgVdEN4B4lj4GQ49lSJdCsduicge6USX77ALVnMi3K7D
         ew8Q==
X-Gm-Message-State: AOJu0YyAUuRZI6eI2BTiTcYoejpsInbiycaHFW6bR8CQomLusvePnDmX
        FotkQamIwbWIyvLdwj4sxhJU0g6zESkOd2Km3YvBMw==
X-Google-Smtp-Source: AGHT+IFbrTIOd7jXyx4T/7x0hZgOMDWQr7Q9EqHck7tw9KSmrv7NOpfHSsir3EFhTZNg03S0BFf0TIJLP9jvzPk3rKE=
X-Received: by 2002:a05:622a:2c0e:b0:417:944a:bcb2 with SMTP id
 kk14-20020a05622a2c0e00b00417944abcb2mr89662qtb.13.1697599163303; Tue, 17 Oct
 2023 20:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231016143828.647848-1-jeffxu@chromium.org> <CAHk-=whFZoap+DBTYvJx6ohqPwn11Puzh7q4huFWDX9vBwXHgg@mail.gmail.com>
 <CALmYWFtTDAb_kpZdAe_xspqwNgK1NWJmjTxaTC=jDEMzfe297Q@mail.gmail.com>
 <CAHk-=wj87GMTH=5901ob=SjQqegAm2JYBE7E4J7skJzE64U-wQ@mail.gmail.com>
 <55960.1697566804@cvs.openbsd.org> <CALmYWFs81T=XnT=AXQTo0+9FXo=OBAV_4rrYPSn9-16O-gBTZg@mail.gmail.com>
 <95482.1697587015@cvs.openbsd.org>
In-Reply-To: <95482.1697587015@cvs.openbsd.org>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 17 Oct 2023 20:18:47 -0700
Message-ID: <CALmYWFtQX57Z7ttKxrdXQH4QupFn4vi5KfizUBH9NkmP-S1JDw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
To:     Theo de Raadt <deraadt@openbsd.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 17, 2023 at 4:57=E2=80=AFPM Theo de Raadt <deraadt@openbsd.org>=
 wrote:
>
> Jeff Xu <jeffxu@google.com> wrote:
>
> > May I ask, for BSD's implementation of immutable(), do you cover
> > things such as mlock(),
> > madvice() ? or just the protection bit (WRX) + remap() + unmap().
>
> It only prevents removal of the mapping, placement of a replacement
> mapping, or changing the existing permissions.  If one page in the
> existing sub-region is marked immutable, the whole operation fails with
> EPERM.
>
> Those are the only user-visible aspects that an attacker cares about to
> utilize in this area.
>
> mlock() and madvise() deal with the physical memory handling underneath
> the VA.  They have nothing to do with how attack code might manipulate
> the VA address space inside a program to convert a series of dead-end
> approaches into a succesfull escalation strategy.
>
> [It would be very long conversation to explain where and how this has
> been utilized to make an attack succesfull]
>
> > In other words:
> > Is BSD's definition of immutable equivalent to
> > MM_SEAL_MPROTECT|MM_SEAL_MUNMAP|MM_SEAL_MREMAP|MM_SEAL_MMAP, of this pa=
tch set ?
>
> I can't compare it to your subsystem, because I completely fail to
> understand the cause or benefit of all the complexity.
>
> I think I've explained what mimmutable() is in extremely simple terms.
>

Thanks for the explanation, based on those, this is exactly what the
current set of patch does.
In practice: libc could do below:
#define MM_IMMUTABLE
(MM_SEAL_MPROTECT|MM_SEAL_MUNMAP|MM_SEAL_MREMAP|MM_SEAL_MMAP)
mseal(add,len, MM_IMMUTABLE)
it will be equivalent to BSD's immutable().

> And I don't understand else you are trying to do anything beyond what

> mimmutable() offers.  It seems like this is inventing additional
> solutions without proof that any of them are necessary to solve the
> specific problem that is known.
>
> > I hesitate to introduce the concept of immutable into linux because I d=
on't know
> > all the scenarios present in linux where VMAs's metadata can be
> > modified.
>
> Good grief.  It seems obvious if you want to lock the change-behaviour
> of an object (the object in this case being a VA sub-region, there is a
> datastructure for that, in OpenBSD it is called an "entry"), then you
> put a flag in that object's data-structure and you simply check the flag
> everytime a change-operation is attempted.  It is a flag which gets set,
> and checked.  Nothing ever clears it (except address space teardown).
>
> This flag must be put on the data structure that manages VA sub-ranges.
>
> In our case when a prot/mapping operation reaches low-level code that
> will want to change an "entry", we notice it is not allowed and simply
> percolate EPERM up through the layers.
>
> > There could be quite a few things we still need to deal with, to
> > completely block the possibility,
> > e.g. malicious code attempting to write to a RO memory
>
> What?!  writes to RO memory are blocked by the permission bits.
>
> > or change RW memory to RWX.
>
> In our case that is blocked by W^X policy.
>
> But if the region is marked mimmutable, then that's another reason you ca=
nnot
> change RW to RWX.  It seems so off-topic, to talk about writes to RO memo=
ry.
> I get a feeling you are a bit lost.
>
> immutable() is not about permissions, but about locking permissions.
> - You can't change the permissions of the address space region.
> - You cannot map a replacement object at the location instead (especially
>   with different permission).
> - You cannot unmap at that location (which you would do if you wanted to
>   map a new object, with a different permission).
>
> All 3 of these scenarios are identical.  No regular code performs these 3
> operations on regions of the address space which we mark immutable.
>
> There is nothing more to mimmutable in the VM layer.  The hard work is
> writing code in execve() and ld.so which will decide which objects can
> be marked immutable automatically, so that programs don't do this to
> themselves.
>
> I'm aware of where this simple piece fits in.  It does not solve all
> problems, it is a very narrow change to impact a problem which only
> high-value targets will ever face (like chrome).
>
> But I think you don't understand the purpose of this mechanism.
>

In linux cases, I think, eventually, mseal() will have a bigger scope than
BSD's mimmutable().  VMA's metadata(vm_area_struct) contains a lot
of control info, depending on application's needs, mseal() can be
expanded to seal individual control info.

For example, in madvice(2) case:
As Jann point out in [1] and I quote:
"you'd probably also want to block destructive madvise() operations
that can effectively alter region contents by discarding pages and
such, ..."

Another example: if an application wants to keep a memory always
present in RAM, for whatever the reason, it can call seal the mlock().

To handle those two new cases. mseal() could add two more bits:
MM_SEAL_MADVICE, MM_SEAL_MLOCK.

It is practical to keep syscall extentable, when the business logic is the =
same.

I think I  explained the logic of using bitmasks in the mseal()
interface clearly with the example of madvice() and mlock().

-Jeff


[1] https://lore.kernel.org/lkml/CAG48ez3ShUYey+ZAFsU2i1RpQn0a5eOs2hzQ426Fk=
cgnfUGLvA@mail.gmail.com/


> > If, as part of immutable, I also block madvice(), mlock(), which also u=
pdates
> > VMA's metadata, so by definition, I could.  What if the user wants the
> > features in
> > madvice() and at the same time, also wants their .text protected ?
>
> I have no idea what you are talking about.  None of those things relate
> to the access permission of the memory the user sees, and therefore none
> of them are in the attack surface profile which is being prevented.
>
> Meaning, we allow madvise() and mlock() and mphysicalquantummemory() beca=
use
> those relate to the physical storage and not the VA permission model.
>
> > Also, if linux introduces a new syscall that depends on a new metadata =
of VMA,
> > say msecret(), (for discussion purpose), should immutable
> > automatically support that ?
>
> How about the future makingexcuses() system call?
>
> I don't think you understand the problem space well enough to come up wit=
h
> your own solution for it.  I spent a year on this, and ship a complete sy=
stem
> using it.  You are asking such simplistic questions above it shocks me.
>
> Maybe read the LWN article;
>
>     https://lwn.net/Articles/915640/
>
> > Without those questions answered, I couldn't choose the route of
> > immutable() yet.
>
> "... so I can clearly not choose the wine in front of you."
>
> If you don't understand what this thing is for, and cannot minimize the
> complexity of this thing, then Linux doesn't need it at all.
>
> I should warn everyone the hard work is not in the VM layer, but in
> ld.so -- deciding which parts of the image to make immutable, and when.
> It is also possible to make some segments immutable directly in execve()
> -- but in both cases you better have a really good grasp on RELRO
> executable layout or will make too many pieces immutable...
>
> I am pretty sure Linux will never get as far as we got. Even our main
> stacks are marked immutable, but in Linux that would conflict with glibc
> ld.so mprotecting RWX the stack if you dlopen() a shared library with
> GNUSTACK, a very bad idea which needs a different fight...
