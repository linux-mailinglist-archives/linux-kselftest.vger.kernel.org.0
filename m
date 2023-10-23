Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D1E7D3E12
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Oct 2023 19:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbjJWRnR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 13:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjJWRnQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 13:43:16 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C1ED79
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Oct 2023 10:43:12 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-5840bb16101so2171767eaf.3
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Oct 2023 10:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698082991; x=1698687791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bw5zQKp06M21UFu8ml4r7q055LQP16Jqvc/bc2xTyYM=;
        b=jP2SUTivaPPJKbyfVNTEkeB6BIOZZmfuB9elArgHzop1qTls73CY44uqW9EXCdBe51
         j9S8d2z7gs8H6KEdNi8pPWe+SJlxenzyDLfNBXhWp1t+FwB9Hx04aG1E1K2x6IRqX90P
         qtmlW1PXVuO/DBT/DHVWvl0A0Oah/Qprpg6mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698082991; x=1698687791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bw5zQKp06M21UFu8ml4r7q055LQP16Jqvc/bc2xTyYM=;
        b=S4hqSgUtFUPO82wMH9BxE462vaozvtmaesMcQXTGlJN50CLHDdUr8dxTOTgZ5TqVQf
         TECWSNZ5D5tj1syHX3dnKTycQfKsKMibNyNr+FruolvHv+MaSJXHAbwyvXrzfTbEuL/I
         2hPDjNM6I2tGmYH00TzidtulUrCboK7QgxjOJgleCRsdpzv76g+7JUsIV+JyW0c/c+xQ
         yEZiK6cYPwLKRtqK+axyjEftRu3faxXnx6TxDpdFdk+QGad3vKSaW7lBVCc1Ujl3edp1
         /hhwcEU21NaoBpSnqOXuQmCqGjmj/cJPTMOw/ypxaofFbHvW2lmh0qAQUvr9CqpSS7Wt
         ac7A==
X-Gm-Message-State: AOJu0YwexKW74WYODdx+jqunmLRrASDqag0bTCvu3wcVHr3gKVCzdWNQ
        YoS6eH058xxuKy8H7UNrXOulHYlPXXpWX2XtFoiN7A==
X-Google-Smtp-Source: AGHT+IEeNjIGnwNtnVhYa1lFz777xw6hLiHMZcj8JhoqUJZpWbbhwHupLYIGAuEzb4uauzqq6rgdBqXJgVB7IP29TwY=
X-Received: by 2002:a05:6870:610b:b0:1e9:8b78:899c with SMTP id
 s11-20020a056870610b00b001e98b78899cmr11960747oae.55.1698082991197; Mon, 23
 Oct 2023 10:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231016143828.647848-1-jeffxu@chromium.org> <ZS1URCBgwGGj9JtM@casper.infradead.org>
 <CAKbZUD2A+=bp_sd+Q0Yif7NJqMu8p__eb4yguq0agEcmLH8SDQ@mail.gmail.com>
 <CALmYWFtOgMAQDGNoM6k2Ev4kMHD396wwH+rVDODaSjsyVMDogg@mail.gmail.com>
 <CAKbZUD2j1jbomCAVxUX_JmG1rfa8udc=5SqVOpDgc-3GnSTbAQ@mail.gmail.com>
 <CALmYWFv7jzOj5HPcYct=UzYKPrwwvtN1EQeHioQHDPwGFvL5Ug@mail.gmail.com>
 <CALmYWFt71Vi6ySiZhW+tmE-LZL7Tnu-dQ1uMO10DUkASUTxzKA@mail.gmail.com> <CAKbZUD12pEaDCLysOpT3yL3064=P28Pm3c=UBqhOZYeBP026WA@mail.gmail.com>
In-Reply-To: <CAKbZUD12pEaDCLysOpT3yL3064=P28Pm3c=UBqhOZYeBP026WA@mail.gmail.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Mon, 23 Oct 2023 10:42:59 -0700
Message-ID: <CABi2SkWNGEw=f63WDYZ1WNqkGsYUK-Hws9WwC0ZoeJQsRQ6GRg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     Jeff Xu <jeffxu@google.com>, Matthew Wilcox <willy@infradead.org>,
        akpm@linux-foundation.org, keescook@chromium.org,
        sroettger@google.com, jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com, surenb@google.com,
        alex.sierra@amd.com, apopple@nvidia.com,
        aneesh.kumar@linux.ibm.com, axelrasmussen@google.com,
        ben@decadent.org.uk, catalin.marinas@arm.com, david@redhat.com,
        dwmw@amazon.co.uk, ying.huang@intel.com, hughd@google.com,
        joey.gouly@arm.com, corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, torvalds@linux-foundation.org,
        lstoakes@gmail.com, mawupeng1@huawei.com, linmiaohe@huawei.com,
        namit@vmware.com, peterx@redhat.com, peterz@infradead.org,
        ryan.roberts@arm.com, shr@devkernel.io, vbabka@suse.cz,
        xiujianfeng@huawei.com, yu.ma@intel.com, zhangpeng362@huawei.com,
        dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 19, 2023 at 3:47=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> On Thu, Oct 19, 2023 at 6:30=E2=80=AFPM Jeff Xu <jeffxu@google.com> wrote=
:
> >
> > Hi Pedro
> >
> > Some followup on mmap() + mprotect():
> >
> > On Wed, Oct 18, 2023 at 11:20=E2=80=AFAM Jeff Xu <jeffxu@google.com> wr=
ote:
> > >
> > > On Tue, Oct 17, 2023 at 3:35=E2=80=AFPM Pedro Falcato <pedro.falcato@=
gmail.com> wrote:
> > > >
> > > > > >
> > > > > > I think it's worth pointing out that this suggestion (with PROT=
_*)
> > > > > > could easily integrate with mmap() and as such allow for one-sh=
ot
> > > > > > mmap() + mseal().
> > > > > > If we consider the common case as 'addr =3D mmap(...); mseal(ad=
dr);', it
> > > > > > definitely sounds like a performance win as we halve the number=
 of
> > > > > > syscalls for a sealed mapping. And if we trivially look at e.g =
OpenBSD
> > > > > > ld.so code, mmap() + mimmutable() and mprotect() + mimmutable()=
 seem
> > > > > > like common patterns.
> > > > > >
> > > > > Yes. mmap() can support sealing as well, and memory is allocated =
as
> > > > > immutable from begining.
> > > > > This is orthogonal to mseal() though.
> > > >
> > > > I don't see how this can be orthogonal to mseal().
> > > > In the case we opt for adding PROT_ bits, we should more or less on=
ly
> > > > need to adapt calc_vm_prot_bits(), and the rest should work without
> > > > issues.
> > > > vma merging won't merge vmas with different prots. The current
> > > > interfaces (mmap and mprotect) would work just fine.
> > > > In this case, mseal() or mimmutable() would only be needed if you n=
eed
> > > > to set immutability over a range of VMAs with different permissions=
.
> > > >
> > > Agreed. By orthogonal, I meant we can have two APIs:
> > > mmap() and mseal()/mprotect()
> > > i.e. we can't just rely on mmap() only without mseal()/mprotect()/mim=
mutable().
> > > Sealing can be applied after initial memory creation.
> > >
> > > > Note: modifications should look kinda like this: https://godbolt.or=
g/z/Tbjjd14Pe
> > > > The only annoying wrench in my plans here is that we have effective=
ly
> > > > run out of vm_flags bits in 32-bit architectures, so this approach =
as
> > > > I described is not compatible with 32-bit.
> > > >
> > > > > In case of ld.so, iiuc, memory can be first allocated as W, then =
later
> > > > > changed to RO, for example, during symbol resolution.
> > > > > The important point is that the application can decide what type =
of
> > > > > sealing it wants, and when to apply it.  There needs to be an api=
(),
> > > > > that can be mseal() or mprotect2() or mimmutable(), the naming is=
 not
> > > > > important to me.
> > > > >
> > > > > mprotect() in linux have the following signature:
> > > > > int mprotect(void addr[.len], size_t len, int prot);
> > > > > the prot bitmasks are all taken here.
> > > > > I have not checked the prot field in mmap(), there might be bits =
left,
> > > > > even not, we could have mmap2(), so that is not an issue.
> > > >
> > > > I don't see what you mean. We have plenty of prot bits left (32-bit=
s,
> > > > and we seem to have around 8 different bits used).
> > > > And even if we didn't, prot is the same in mprotect and mmap and mm=
ap2 :)
> > > >
> > > > The only issue seems to be that 32-bit ran out of vm_flags, but tha=
t
> > > > can probably be worked around if need be.
> > > >
> > > Ah, you are right about this. vm_flags is full, and prot in mprotect(=
) is not.
> > > Apology that I was wrong previously and caused confusion.
> > >
> > > There is a slight difference in the syntax of mprotect and mseal.
> > > Each time when mprotect() is called, the kernel takes all of RWX bits
> > > and updates vm_flags,
> > > In other words, the application sets/unset each RWX, and kernel takes=
 it.
> > >
> > > In the mseal() case, the kernel will remember which seal types were
> > > applied previously, and the application doesn=E2=80=99t need to repea=
t all
> > > existing seal types in the next mseal().  Once a seal type is applied=
,
> > > it can=E2=80=99t be unsealed.
> > >
> > > So if we want to use mprotect() for sealing, developers need to think
> > > of sealing bits differently than the rest of prot bits. It is a
> > > different programming model, might or might not be an obvious concept
> > > to developers.
> > >
> > This probably doesn't matter much to developers.
> > We can enforce the sealing bit to be the same as the rest of PROT bits.
> > If mprotect() tries to unset sealing, it will fail.
>
> Yep. Erroneous or malicious mprotects would all be caught. However, if
> we add a PROT_DOWNGRADEABLE (that could let you, lets say, mprotect()
> to less permissions or even downright munmap()) you'd want some care
> to preserve that bit when setting permissions.
>
> >
> > > There is a difference in input check and error handling as well.
> > > for mseal(), if a given address range has a gap (unallocated memory),
> > > or if one of VMA is sealed with MM_SEAL_SEAL flag, none of VMAs is
> > > updated.
> > > For mprotect(), some VMAs can be updated, till an error happens to a =
VMA.
> > >
> > This difference doesn't matter much.
> >
> > For mprotect()/mmap(), is Linux implementation limited by POSIX ?
>
> No. POSIX works merely as a baseline that UNIX systems aim towards.
> You can (and very frequently do) extend POSIX interfaces (in fact,
> it's how most of POSIX was written, through sheer
> "design-by-committee" on a bunch of UNIX systems' extensions).
>
> > This can be made backward compatible.
> > If there is no objection to adding linux specific values in mmap() and
> > mprotect(),
> > This works for me.
>
> Linux already has system-specific values for PROT_ (PROT_BTI,
> PROT_MTE, PROT_GROWSUP, PROT_GROWSDOWN, etc).
> Whether this is the right interface is another question. I do like it
> a lot, but there's of course value in being compatible with existing
> solutions (like mimmutable()).
>

Thanks Pedro for providing examples on mm extension to POSIX. This
opens more design options on solving the sealing problem. I will take
a few days to research  design options.

-Jeff


> --
> Pedro
