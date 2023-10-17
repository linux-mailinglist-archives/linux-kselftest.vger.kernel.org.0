Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42A97CBE90
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 11:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbjJQJI7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 05:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbjJQJIe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 05:08:34 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4100AFA
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 02:08:30 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4195fe5cf73so187771cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 02:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697533709; x=1698138509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJB/KZh+XHTSt6vkeQK0/vvYJ6jT49v2mbim13MB91k=;
        b=1Q6IB1K7kfX6FD+TAsOt515pSgbSbgHII3hwaz1jqBU2SQ67E9ilBBWm6IiPn96f5G
         BLetLBbt9iFQg97UGMPVB6woX7+wF7V0vWoLn0Uv7sx6JLYf44zzgKQpWsEOuBf/DF7H
         gxojVtHnMb7Q5aF5tLfab1L7P98C2BKaCyCrmglchipc31+U9RSJeiNJ8QKvL3H6gkwR
         iYU2EJQVLMiYIK7yASUnuZY9x6fwHQxxvY9f+NBvohb1u/bxWPPNWIQjYEci8t+jdMMY
         wg4Ypf+KpXkCzcxHGmpMuyWPdN8hCImhZbbXe+EjCSHfrbPLpRA+uSXBKJaYjTyEFCdb
         UvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697533709; x=1698138509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJB/KZh+XHTSt6vkeQK0/vvYJ6jT49v2mbim13MB91k=;
        b=Mfef9QKPLcMI25qMQ8ULJIsIilLf5uWPubaRuDE9QrqdUSngk34oEEj6R4B0awkJ6+
         DreZvgMdUMC2fMonEBC2iOKVN0nqc63J2X8cfsWkY6ogDJ24hjDKw7oOfNsBm1oA4CgR
         F68s7SdMMvssVvh1u2WbmMF0SjMwoZg53aU1OlbWjPi0wB+gy73ejcGWDS0Bke5S48Sl
         AqWVgjbHhklcRNLTrV2atSORN1cb3gs3doG5V/IhuhpwUWrHyEQK9cT79FnTepkePhQk
         3uPcA0cuZQnQkCOLvmwsqZ648ymBGsP1FlnURoOeWU8bAAhJ1vS+QaOi69/SfjnShSqW
         LvQQ==
X-Gm-Message-State: AOJu0Yy0WmRAiWA4DNF1F+7d7+jM/YhF/OXTOIRLM1vGtJq2OdcO8q81
        rnhPL1MMRxoOt6px31YHxhSo9XuplEcqlNizGCApVg==
X-Google-Smtp-Source: AGHT+IG1Wm4mK6Xhs/lc9gPqJBN7fbtaCLDjWvydeqel3QbWoveJj6PDGxuKsHLuwo955YiGUPJxiyZoROusg2wo3Ts=
X-Received: by 2002:a05:622a:288f:b0:419:6cf4:2474 with SMTP id
 ke15-20020a05622a288f00b004196cf42474mr188894qtb.2.1697533709123; Tue, 17 Oct
 2023 02:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231016143828.647848-1-jeffxu@chromium.org> <CAHk-=whFZoap+DBTYvJx6ohqPwn11Puzh7q4huFWDX9vBwXHgg@mail.gmail.com>
In-Reply-To: <CAHk-=whFZoap+DBTYvJx6ohqPwn11Puzh7q4huFWDX9vBwXHgg@mail.gmail.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 17 Oct 2023 02:07:52 -0700
Message-ID: <CALmYWFtTDAb_kpZdAe_xspqwNgK1NWJmjTxaTC=jDEMzfe297Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     jeffxu@chromium.org, akpm@linux-foundation.org,
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Linus,

Thank you for the time reviewing this patch set.

On Mon, Oct 16, 2023 at 10:23=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 16 Oct 2023 at 07:38, <jeffxu@chromium.org> wrote:
> >
> > This patchset proposes a new mseal() syscall for the Linux kernel.
>
> So I have no objections to adding some kind of "lock down memory
> mappings" model, but this isn't it.
>
> First off, the simple stuff: the commit messages are worthless. Having
>
>    check seal for mmap(2)
>
> as the commit message is not even remotely acceptable, to pick one
> random example from the series (7/8).
>
> But that doesn't matter much, since I think the more fundamental
> problems are much worse:
>
>  - the whole "ON_BEHALF_OF_KERNEL" and "ON_BEHALF_OF_USERSPACE" is
> just complete noise and totally illogical. The whole concept needs to
> be redone.
>
> Example of complete nonsense (again, picking 7/8, but that's again
> just a random example):
>
> > @@ -3017,8 +3022,8 @@ SYSCALL_DEFINE5(remap_file_pages,
> >                 flags |=3D MAP_LOCKED;
> >
> >         file =3D get_file(vma->vm_file);
> > -       ret =3D do_mmap(vma->vm_file, start, size,
> > -                       prot, flags, pgoff, &populate, NULL);
> > +       ret =3D do_mmap(vma->vm_file, start, size, prot, flags, pgoff,
> > +                       &populate, NULL, ON_BEHALF_OF_KERNEL);
> >         fput(file);
> >  out:
> >         mmap_write_unlock(mm);
>
> Christ. That's *literally* the remap_file_pages() system call
> definition. No way in hell does "ON_BEHALF_OF_KERNEL" make any sense
> in this context.
>
> It's not the only situation. "mremap() as the same thing. vm_munmap()
> has the same thing. vm_brk_flags() has the same thing. None of them
> make any sense.
>
> But even if those obvious kinds of complete mis-designs were to be
> individually fixed, the whole naming and concept is bogus. The
> "ON_BEHALF_OF_KERNEL" thing seems to actually just mean "don't check
> sealing". Naming should describe what the thing *means*, not some
> random policy thing that may or may not be at all relevant.
>

I apologize that I didn't think of a better name for ON_BEHALF_OF_XX
and I should have written a more clear commit message.

I prepared a V2 patchset with a more detailed commit message, hopefully
that will help to explain the design.

Indeed, the ON_BEHALF_OF_XX is confusing, especially with
remap_file_pathes(). remap_file_pathes(2) is not supported
in this patch set, this covers mprotect(2), mmap(2), munmap(2),
mremap(2) as the first feature set. I could extend the sealing
to more syscalls, if it is determined necessary from the outcome of
this discussion. The initial set of 4 syscalls was chosen based
on Chrome's initial wish list.

Regarding the ON_BEHALF_OF flag, my intention is to have a flag,
set at syscall entry points of mprotect(2), munmap(2), mremap(2),
mmap(2),  pass the flag along the call stack, till reaching
can_modify_mm(), can_modify_mm() does the actual check for
the sealing type.

It is probably worth noting that I choose to check one and only
one sealing type per syscall. i.e. munmap(2) checks
MM_SEAL_MUNMAP only. With this approach, sealing can be
implemented incrementally. For example, When implementing
sealing for munmap(2), I don't need to care that mremap(2)
can also call internal functions to unmap the VMAs.
The mremap(2) will be sealed by MM_SEAL_MREMAP(), and
be dealt with separately.

This approach also allows dev to expand the sealing to madvice(),
mlock(), or whatever syscalls or cases that modify VMA's meta data.
As Yann points out, There is a list of cases that we might care about.
Having all of those implemented will take time. Using bitmasks will
help to add those incrementally. An application will  be backward
compatible when a new sealing type is added, i.e. It has to set the
new sealing type explicitly.

>  - the whole MM_SEAL_xx vs VM_SEAL_xx artificial distinction needs to go =
away.
>
> Not only is it unacceptable to pointlessly create two different name
> spaces for no obvious reason, code like this (from 1/8) should not
> exist:
>
> > +       if (types & MM_SEAL_MSEAL)
> > +               newtypes |=3D VM_SEAL_MSEAL;
> > +
> > +       if (types & MM_SEAL_MPROTECT)
> > +               newtypes |=3D VM_SEAL_MPROTECT;
> > +
> > +       if (types & MM_SEAL_MUNMAP)
> > +               newtypes |=3D VM_SEAL_MUNMAP;
> > +
> > +       if (types & MM_SEAL_MMAP)
> > +               newtypes |=3D VM_SEAL_MMAP;
> > +
> > +       if (types & MM_SEAL_MREMAP)
> > +               newtypes |=3D VM_SEAL_MREMAP;
>
> Sure, we have that in some cases when there was a *reason* for
> namespacing imposed on us from an API standpoint (ie the "open()"
> flags that get turned into FMODE_xyz flags, or the MS_xyz mount flags
> being turned into MNT_xyz flags), but those tend to be signs of
> problems in the system call API where some mixup made it impossible to
> use the flags directly (most commonly because there is some extended
> internal representation of said things).
>
> For example, the MS_xyz namespace is a combination of "these are flags
> for the new mount" (like MS_RDONLY) and "this is how you should mount
> it" (like MS_REMOUNT), and so the user interface has that odd mixing
> of different things, and the MNT_xyz namespace is a distillation of
> the former.
>
> But we certainly should not strive to introduce *new* interfaces that
> start out with this kind of mixup and pointless "translate from one
> bit to another" code.
>
The two namespaces can go away, that means the bitmap will be stored
as is by vm_seals in VMA struct. (1/8) Copied below.

+++ b/include/linux/mm_types.h
@@ -660,6 +660,13 @@ struct vm_area_struct {
+       unsigned long vm_seals;         /* seal flags, see mm.h. */

My original considerations are:
1. vm_seals is a new field, and mseal() currently uses 5 bits.
vm_seals can be repurposed to store other VMA flags in future,
having two namespaces (API and internal one) can be useful.
2. vm_flags is full and it seems to me there is pending work on expanding
vm_flags. [1]  if that happens, we will need translation logic.
[1] https://lore.kernel.org/linux-mm/4F6CA298.4000301@jp.fujitsu.com/

I might have over-engineered this, so I removed the VM_SEAL_XX in V2.

>  - And finally (for now), I hate that MM_ACTION_xyz thing too!
>
> Why do we have MM_ACTION_MREMAP, and pointless like this (from 3/8):
>
> > +       switch (action) {
> > +       case MM_ACTION_MPROTECT:
> > +               if (vma->vm_seals & VM_SEAL_MPROTECT)
> > +                       return false;
> > +               break;
>
> when the sane thing to do is to use the *same* MM_SEAL_xyz bitmask and
> sealing bitmask and just say
>
>         if (vma->vm_seal & vm_action)
>                 return -EPERM;
>

Make sense. My original thought is that can_modify_vma() will check one
and only one seal type, and having an enum type will enforce that.  This
restriction feels unnecessary. I removed the action type in V2.

> IOW, you have pointlessly introduced not *two* different namespaces,
> but *three*. All doing the exact same thing, and all just causing
> pointless and ugly code to "translate" the actions of one into the
> model of another.
>
> So get rid of the "MM_ACTION_xyz" thing. Get rid of ther "VM_SEAL_xyz"
> thing. Use *one* single "these are the sealing bits".
>
> And get rid of "enum caller_origin" entirely. I don't know what the
> right model for that thing is, but that isn't it.
>
> *Maybe* the right model is some MM_SEAL_OVERRIDE bit that user space
> cannot set, but that the kernel can use internally - and if that is
> the right model, then dammit, the *uses* should be very very obvious
> why the override is fine, because that remap_file_pages() use sure as
> hell was *not* obvious.
>
> In fact, it's not at all obvious why anything should override the
> sealing bits - EVER. So I'm not convinced that the right model is
> "replace ON_BEHALF_OF_KERNEL with MM_SEAL_OVERRIDE". Why would we
> *ever* want to override sealing? It sounds like complete garbage. Most
> of the users seem to be things like "execve()", which is nonsensical,
> since the VM wouldn't have been sealed at that point _anyway_, so
> having a "don't bother checking sealing bits" flag seems entirely
> useless.
>
Would the new commit message and comments in V2 help to
explain the design better ? (will send shortly)

Another code change I can make to help the readability (not in v2),
is to set and pass checkSeals flag from syscall entry point, all the
way to can_modify_vma(). Currently, I didn't do that if I checked the
internal function is only used by syscal entry point, e.g. in
do_mprotect_pkey(), mremap_to(), ksys_mmap_pgoff() cases.
Doing that does increase the size of the patch set though.

Thanks.
-Jeff


-Jeff

> Anyway, this is all a resounding NAK on this series in this form. My
> complaints are not some kind of small "fix this up". These are
> fundamental issues.
>
>             Linus
