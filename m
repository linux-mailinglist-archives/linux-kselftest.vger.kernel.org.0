Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FED6708592
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 18:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjERQGE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 May 2023 12:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjERQGD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 May 2023 12:06:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B661AD
        for <linux-kselftest@vger.kernel.org>; Thu, 18 May 2023 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684425914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dxoCY1idzW72cG8lj4UwFyENZYdTkejsmFcoUP3trcY=;
        b=RLV/jFmc1VyYcj3ZZBhpXGse2yhcwG3UqsDiPzz44TeXjllyWSiWU/FeYc1sBR3fK64mUS
        zSkdzI7W80yn7cY5Knhtm7MLmSqI7ZuzQ2/1rysCtHSxsg5MNq9TydUxLNkv53R4jkyJM8
        ybGLlJaLaAO8emGIuP0ujJ1EqZWvoMo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-Zwtl_LS5OqqHtwwtrIWzwQ-1; Thu, 18 May 2023 12:05:13 -0400
X-MC-Unique: Zwtl_LS5OqqHtwwtrIWzwQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f393bf5546so4498841cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 18 May 2023 09:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684425912; x=1687017912;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dxoCY1idzW72cG8lj4UwFyENZYdTkejsmFcoUP3trcY=;
        b=h4pmBcbBVNUNwY20m3EgOeMM5l0FNsTBT4K4V9NolgytiizsYIDfLQJGSFmjfhzDUF
         1RzAu5NTOLwhyx6dROETAHcDhXs2ZUmIShTE7XLFixFReYjvqI8nalAIoe/byyi8pRaD
         Z1olP+OWHhfCzx00tkBhLhmLg+4ywsY12I7fCNwChRJdEojzchfBgrqukhJE5G024xTk
         qWB5IzRiMOo9GJJ7hwBdcGZtD9KqNMlWJxNR/wqnWLkuBMrYO0wyM2z+AOv0d/tcHdi8
         kB0Qfv2A7HJdYHfsgVQ36eMtvNT09yvi7Z9BRzbb24Me5ZEllHAPWvPx82TS0HP7LnMa
         J4Kw==
X-Gm-Message-State: AC+VfDxcgPoKjbELmxb3VzzQCht7wjhFAmdBhjbeymQo49R46w1Zz58u
        90452YQdJ2SsFoJyKLOZtp8O5OH2ZtOrQo/QBMl6AjViZVL8hKZu3xKjgG/Ek5GGcG3UVMs7Hkh
        Pazh1ll2gE7wSC9sClUfcIRDe6cS8
X-Received: by 2002:ac8:7d06:0:b0:3f5:29b9:59e3 with SMTP id g6-20020ac87d06000000b003f529b959e3mr12767392qtb.3.1684425911768;
        Thu, 18 May 2023 09:05:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6MThlIG8MkjsWiWPRuNlJRUj+J7W48kgRW4lartjNEX9g+DjGZeayuZK5PtQ7wZWYOKk2yMA==
X-Received: by 2002:ac8:7d06:0:b0:3f5:29b9:59e3 with SMTP id g6-20020ac87d06000000b003f529b959e3mr12767348qtb.3.1684425911419;
        Thu, 18 May 2023 09:05:11 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id fg9-20020a05622a580900b003f3963d24ebsm598380qtb.30.2023.05.18.09.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 09:05:10 -0700 (PDT)
Date:   Thu, 18 May 2023 12:05:08 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jiaqi Yan <jiaqiyan@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Huang Ying <ying.huang@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Anish Moorthy <amoorthy@google.com>
Subject: Re: [PATCH 1/3] mm: userfaultfd: add new UFFDIO_SIGBUS ioctl
Message-ID: <ZGZMtK6PzoTuLZ1b@x1n>
References: <20230511182426.1898675-1-axelrasmussen@google.com>
 <CADrL8HXFiTL-RDnETS2BUg_qH8CvcCMZiX-kutsrS1-8Uy25=w@mail.gmail.com>
 <ZGVRUeCWr8209m8d@x1n>
 <ZGVTMnVKNcQDM0x4@x1n>
 <CAJHvVcgXynHcuoS6eCfOAB2SgzqYy_zMGrRMR2kFuxOtSdUwvQ@mail.gmail.com>
 <CACw3F52MNOVv6KA5n7wRYDT2ujwYkco=aYngbo-zGA3zW1yq+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F52MNOVv6KA5n7wRYDT2ujwYkco=aYngbo-zGA3zW1yq+w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 17, 2023 at 05:43:53PM -0700, Jiaqi Yan wrote:
> On Wed, May 17, 2023 at 3:29 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
> >
> > On Wed, May 17, 2023 at 3:20 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Wed, May 17, 2023 at 06:12:33PM -0400, Peter Xu wrote:
> > > > On Thu, May 11, 2023 at 03:00:09PM -0700, James Houghton wrote:
> > > > > On Thu, May 11, 2023 at 11:24 AM Axel Rasmussen
> > > > > <axelrasmussen@google.com> wrote:
> > > > > >
> > > > > > So the basic way to use this new feature is:
> > > > > >
> > > > > > - On the new host, the guest's memory is registered with userfaultfd, in
> > > > > >   either MISSING or MINOR mode (doesn't really matter for this purpose).
> > > > > > - On any first access, we get a userfaultfd event. At this point we can
> > > > > >   communicate with the old host to find out if the page was poisoned.
> > > > > > - If so, we can respond with a UFFDIO_SIGBUS - this places a swap marker
> > > > > >   so any future accesses will SIGBUS. Because the pte is now "present",
> > > > > >   future accesses won't generate more userfaultfd events, they'll just
> > > > > >   SIGBUS directly.
> > > > >
> > > > > I want to clarify the SIGBUS mechanism here when KVM is involved,
> > > > > keeping in mind that we need to be able to inject an MCE into the
> > > > > guest for this to be useful.
> > > > >
> > > > > 1. vCPU gets an EPT violation --> KVM attempts GUP.
> > > > > 2. GUP finds a PTE_MARKER_UFFD_SIGBUS and returns VM_FAULT_SIGBUS.
> > > > > 3. KVM finds that GUP failed and returns -EFAULT.
> > > > >
> > > > > This is different than if GUP found poison, in which case KVM will
> > > > > actually queue up a SIGBUS *containing the address of the fault*, and
> > > > > userspace can use it to inject an appropriate MCE into the guest. With
> > > > > UFFDIO_SIGBUS, we are missing the address!
> > > > >
> > > > > I see three options:
> > > > > 1. Make KVM_RUN queue up a signal for any VM_FAULT_SIGBUS. I think
> > > > > this is pointless.
> > > > > 2. Don't have UFFDIO_SIGBUS install a PTE entry, but instead have a
> > > > > UFFDIO_WAKE_MODE_SIGBUS, where upon waking, we return VM_FAULT_SIGBUS
> > > > > instead of VM_FAULT_RETRY. We will keep getting userfaults on repeated
> > > > > accesses, just like how we get repeated signals for real poison.
> > > > > 3. Use this in conjunction with the additional KVM EFAULT info that
> > > > > Anish proposed (the first part of [1]).
> > > > >
> > > > > I think option 3 is fine. :)
> > > >
> > > > Or... option 4) just to use either MADV_HWPOISON or hwpoison-inject? :)
> > >
> > > I just remember Axel mentioned this in the commit message, and just in case
> > > this is why option 4) was ruled out:
> > >
> > >         They expect that once poisoned, pages can never become
> > >         "un-poisoned". So, when we live migrate the VM, we need to preserve
> > >         the poisoned status of these pages.
> > >
> > > Just to supplement on this point: we do have unpoison (echoing to
> > > "debug/hwpoison/hwpoison_unpoison"), or am I wrong?
> 
> If I read unpoison_memory() correctly, once there is a real hardware
> memory corruption (hw_memory_failure will be set), unpoison will stop
> working and return EOPNOTSUPP.
> 
> I know some cloud providers evacuating VMs once a single memory error
> happens, so not supporting unpoison is probably not a big deal for
> them. BUT others do keep VM running until more errors show up later,
> which could be long after the 1st error.

We're talking about postcopy migrating a VM has poisoned page on src,
rather than on dst host, am I right?  IOW, the dest hwpoison should be
fake.

If so, then I would assume that's the case where all the pages on the dest
host is still all good (so hw_memory_failure not yet set, or I doubt the
judgement of being a migration target after all)?

The other thing is even if dest host has hw poisoned page, I'm not sure
whether hw_memory_failure is the only way to solve this.

I saw that this is something got worked on before from Zhenwei, David used
to have some reasoning on why it was suggested like using a global knob:

https://lore.kernel.org/all/d7927214-e433-c26d-7a9c-a291ced81887@redhat.com/

Two major issues here afaics:

  - Zhenwei's approach only considered x86 hwpoison - it relies on kpte
    having !present in entries but that's x86 specific rather than generic
    to memory_failure.c.

  - It is _assumed_ that hwpoison injection is for debugging only.

I'm not sure whether you can fix 1) by some other ways, e.g., what if the
host just remember all the hardware poisoned pfns (or remember
soft-poisoned ones, but then here we need to be careful on removing them
from the list when it's hwpoisoned for real)?  It sounds like there's
opportunity on providing a generic solution rather than relying on
!pte_present().

For 2) IMHO that's not a big issue, you can declare it'll be used in !debug
but production systems so as to boost the feature importance with a real
use case.

So far I'd say it'll be great to leverage what it's already there in linux
and make it as generic as possible. The only issue is probably
CAP_ADMIN... not sure whether we can have some way to provide !ADMIN
somehow, or you can simply work around this issue.

> 
> > >
> > > >
> > > > Besides what James mentioned on "missing addr", I didn't quickly see what's
> > > > the major difference comparing to the old hwpoison injection methods even
> > > > without the addr requirement. If we want the addr for MCE then it's more of
> > > > a question to ask.
> > > >
> > > > I also didn't quickly see why for whatever new way to inject a pte error we
> > > > need to have it registered with uffd.  Could it be something like
> > > > MADV_PGERR (even if MADV_HWPOISON won't suffice) so you can inject even
> > > > without an userfault context (but still usable when uffd registered)?
> > > >
> > > > And it'll be alawys nice to have a cover letter too (if there'll be a new
> > > > version) explaining the bits.
> >
> > I do plan a v2, if for no other reason than to update the
> > documentation. Happy to add a cover letter with it as well.
> >
> > +Jiaqi back to CC, this is one piece of a larger memory poisoning /
> > recovery design Jiaqi is working on, so he may have some ideas why
> > MADV_HWPOISON or MADV_PGER will or won't work.
> 
> Per https://man7.org/linux/man-pages/man2/madvise.2.html,
> MADV_HWPOISON "is available only for privileged (CAP_SYS_ADMIN)
> processes." So for a non-root VMM, MADV_HWPOISON is out of option.

It makes sense to me especially when the page can be shared with other
tasks.

> 
> Another issue with MADV_HWPOISON is, it requires to first successfully
> get_user_pages_fast(). I don't think it will work if memory is not
> mapped yet.

Fair point, so probably current MADV_HWPOISON got ruled out.
hwpoison-inject seems fine where only the PFN is needed rather than the
pte. But same issue on CAP_ADMIN indeed.

> 
> With the UFFDIO_SIGBUS feature introduced in this patchset, it may
> even be possible to free the emulated-hwpoison page back to the kernel
> so we don't lose a 4K page.
> 
> I didn't find any ref/doc for MADV_PGERR. Is it something you suggest
> to build, Peter?

That's something I made up just to show my question on why such an
interface (even if wanted) needs to be bound to userfaultfd, e.g. a
madvise() seems working if someone sololy want to install a poisoned pte.

IIUC even with an madvise one may not need CAP_ADMIN since we can limit the
op to current mm only, I assume it's safe.

Here you'd want to return VM_FAULT_HWPOISON for whatever swap pte you'd
like to install (in do_swap_page) with whatever new interface (assuming
still a new madvise). As James mentioned, I think KVM liked that to
recognize -EHWPOISON from -EFAULT.  I'd say we can even consider reusing
PTE_MARKER_SWAPIN_ERROR to let it just return VM_FAULT_HWPOISON directly if
so.

Thanks,

-- 
Peter Xu

