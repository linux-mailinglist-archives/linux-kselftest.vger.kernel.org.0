Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596A07D052F
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 00:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbjJSW44 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Oct 2023 18:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjJSW4z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Oct 2023 18:56:55 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F5A115;
        Thu, 19 Oct 2023 15:56:53 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-7743448d88eso9015485a.2;
        Thu, 19 Oct 2023 15:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697756213; x=1698361013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CP2THLW7eHytlPbt5BfwCcXMf/R2fQdouS9d2T2WxRc=;
        b=k8pWnrd2XDBKSQrZsOce0wWmdWD4NuuoM8713NzvK44dqGORSZwgwP/iRYlXBD7ztf
         28d2Mj2PSMgKP4PTzjcmODUViGyazUSa9DYfRsBoNYWFXpVPxNQBPxWGkcIzsG5MC5N6
         UvGNaeO+zVzgcnZOFFxp5nmDDJ8i+jqGkgEdzNaZ6PYiBgpSk3bGNoJuF05ZxU+kjzEO
         VJXBlXSSIZfbCRGDHg53bnpQH0HN7KasO+IDYPkMztqXV6HsG09WTPRKoEu3+oSHo+YZ
         uERz2J7lIHb4eVh1Cyn6qpbxoHJIBOuwmoaZAqimfPh45XKDsqWRRYiGMnKCCsE/dNeg
         W2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697756213; x=1698361013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CP2THLW7eHytlPbt5BfwCcXMf/R2fQdouS9d2T2WxRc=;
        b=S3DwZoibSaSzHs6BdJhjjUc4/abysR/XgIpfbhTE0UIQ3EUMDdFt3eCbprIS3054FO
         UDpm4zCqcvMPqrRmOGKhAWXQ/6Si6ory2caAkymXgNThqprZqYtTwyimUieXo3v5k/3s
         C58bvq8JA48psnHa16MVe/Dy2ULApv6JHflCuowCwivXtxF/TXPdjFqHg/zCilp6CTsL
         PlfBXBnP06JzTdodCoYbdQZxTOoPKr9atbfHoihFvthsbBW1CeNwh0DN60Vx8Y+OjpPT
         DJnV1Vd5fwPGQPw0JAvSDYmTXoaGEWBydkwHHN0HDxW4+NAeyllhcr48klHNi15O+L6i
         cBtA==
X-Gm-Message-State: AOJu0YxT7XqaXYdmIIBKWZnp0n3KQx75AFH0z5/iDEk2I7ayKfYrfjDk
        jJDk3C2FzU2EMZ5SLjLll1iNWbnTkV7Ep6EX0Tu4kSG1jcsPyg==
X-Google-Smtp-Source: AGHT+IHciFs/BQ6U6a7rjOnDJ2Xq+ukEzpkuMKRLiU5U69JMH0j5zohwipplwWO5SP4nlGF81WuRLROHWoNhvgHtxmc=
X-Received: by 2002:a67:a209:0:b0:457:b85e:a9fe with SMTP id
 l9-20020a67a209000000b00457b85ea9femr91187vse.27.1697755677500; Thu, 19 Oct
 2023 15:47:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231016143828.647848-1-jeffxu@chromium.org> <ZS1URCBgwGGj9JtM@casper.infradead.org>
 <CAKbZUD2A+=bp_sd+Q0Yif7NJqMu8p__eb4yguq0agEcmLH8SDQ@mail.gmail.com>
 <CALmYWFtOgMAQDGNoM6k2Ev4kMHD396wwH+rVDODaSjsyVMDogg@mail.gmail.com>
 <CAKbZUD2j1jbomCAVxUX_JmG1rfa8udc=5SqVOpDgc-3GnSTbAQ@mail.gmail.com>
 <CALmYWFv7jzOj5HPcYct=UzYKPrwwvtN1EQeHioQHDPwGFvL5Ug@mail.gmail.com> <CALmYWFt71Vi6ySiZhW+tmE-LZL7Tnu-dQ1uMO10DUkASUTxzKA@mail.gmail.com>
In-Reply-To: <CALmYWFt71Vi6ySiZhW+tmE-LZL7Tnu-dQ1uMO10DUkASUTxzKA@mail.gmail.com>
From:   Pedro Falcato <pedro.falcato@gmail.com>
Date:   Thu, 19 Oct 2023 23:47:46 +0100
Message-ID: <CAKbZUD12pEaDCLysOpT3yL3064=P28Pm3c=UBqhOZYeBP026WA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
To:     Jeff Xu <jeffxu@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>, jeffxu@chromium.org,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 19, 2023 at 6:30=E2=80=AFPM Jeff Xu <jeffxu@google.com> wrote:
>
> Hi Pedro
>
> Some followup on mmap() + mprotect():
>
> On Wed, Oct 18, 2023 at 11:20=E2=80=AFAM Jeff Xu <jeffxu@google.com> wrot=
e:
> >
> > On Tue, Oct 17, 2023 at 3:35=E2=80=AFPM Pedro Falcato <pedro.falcato@gm=
ail.com> wrote:
> > >
> > > > >
> > > > > I think it's worth pointing out that this suggestion (with PROT_*=
)
> > > > > could easily integrate with mmap() and as such allow for one-shot
> > > > > mmap() + mseal().
> > > > > If we consider the common case as 'addr =3D mmap(...); mseal(addr=
);', it
> > > > > definitely sounds like a performance win as we halve the number o=
f
> > > > > syscalls for a sealed mapping. And if we trivially look at e.g Op=
enBSD
> > > > > ld.so code, mmap() + mimmutable() and mprotect() + mimmutable() s=
eem
> > > > > like common patterns.
> > > > >
> > > > Yes. mmap() can support sealing as well, and memory is allocated as
> > > > immutable from begining.
> > > > This is orthogonal to mseal() though.
> > >
> > > I don't see how this can be orthogonal to mseal().
> > > In the case we opt for adding PROT_ bits, we should more or less only
> > > need to adapt calc_vm_prot_bits(), and the rest should work without
> > > issues.
> > > vma merging won't merge vmas with different prots. The current
> > > interfaces (mmap and mprotect) would work just fine.
> > > In this case, mseal() or mimmutable() would only be needed if you nee=
d
> > > to set immutability over a range of VMAs with different permissions.
> > >
> > Agreed. By orthogonal, I meant we can have two APIs:
> > mmap() and mseal()/mprotect()
> > i.e. we can't just rely on mmap() only without mseal()/mprotect()/mimmu=
table().
> > Sealing can be applied after initial memory creation.
> >
> > > Note: modifications should look kinda like this: https://godbolt.org/=
z/Tbjjd14Pe
> > > The only annoying wrench in my plans here is that we have effectively
> > > run out of vm_flags bits in 32-bit architectures, so this approach as
> > > I described is not compatible with 32-bit.
> > >
> > > > In case of ld.so, iiuc, memory can be first allocated as W, then la=
ter
> > > > changed to RO, for example, during symbol resolution.
> > > > The important point is that the application can decide what type of
> > > > sealing it wants, and when to apply it.  There needs to be an api()=
,
> > > > that can be mseal() or mprotect2() or mimmutable(), the naming is n=
ot
> > > > important to me.
> > > >
> > > > mprotect() in linux have the following signature:
> > > > int mprotect(void addr[.len], size_t len, int prot);
> > > > the prot bitmasks are all taken here.
> > > > I have not checked the prot field in mmap(), there might be bits le=
ft,
> > > > even not, we could have mmap2(), so that is not an issue.
> > >
> > > I don't see what you mean. We have plenty of prot bits left (32-bits,
> > > and we seem to have around 8 different bits used).
> > > And even if we didn't, prot is the same in mprotect and mmap and mmap=
2 :)
> > >
> > > The only issue seems to be that 32-bit ran out of vm_flags, but that
> > > can probably be worked around if need be.
> > >
> > Ah, you are right about this. vm_flags is full, and prot in mprotect() =
is not.
> > Apology that I was wrong previously and caused confusion.
> >
> > There is a slight difference in the syntax of mprotect and mseal.
> > Each time when mprotect() is called, the kernel takes all of RWX bits
> > and updates vm_flags,
> > In other words, the application sets/unset each RWX, and kernel takes i=
t.
> >
> > In the mseal() case, the kernel will remember which seal types were
> > applied previously, and the application doesn=E2=80=99t need to repeat =
all
> > existing seal types in the next mseal().  Once a seal type is applied,
> > it can=E2=80=99t be unsealed.
> >
> > So if we want to use mprotect() for sealing, developers need to think
> > of sealing bits differently than the rest of prot bits. It is a
> > different programming model, might or might not be an obvious concept
> > to developers.
> >
> This probably doesn't matter much to developers.
> We can enforce the sealing bit to be the same as the rest of PROT bits.
> If mprotect() tries to unset sealing, it will fail.

Yep. Erroneous or malicious mprotects would all be caught. However, if
we add a PROT_DOWNGRADEABLE (that could let you, lets say, mprotect()
to less permissions or even downright munmap()) you'd want some care
to preserve that bit when setting permissions.

>
> > There is a difference in input check and error handling as well.
> > for mseal(), if a given address range has a gap (unallocated memory),
> > or if one of VMA is sealed with MM_SEAL_SEAL flag, none of VMAs is
> > updated.
> > For mprotect(), some VMAs can be updated, till an error happens to a VM=
A.
> >
> This difference doesn't matter much.
>
> For mprotect()/mmap(), is Linux implementation limited by POSIX ?

No. POSIX works merely as a baseline that UNIX systems aim towards.
You can (and very frequently do) extend POSIX interfaces (in fact,
it's how most of POSIX was written, through sheer
"design-by-committee" on a bunch of UNIX systems' extensions).

> This can be made backward compatible.
> If there is no objection to adding linux specific values in mmap() and
> mprotect(),
> This works for me.

Linux already has system-specific values for PROT_ (PROT_BTI,
PROT_MTE, PROT_GROWSUP, PROT_GROWSDOWN, etc).
Whether this is the right interface is another question. I do like it
a lot, but there's of course value in being compatible with existing
solutions (like mimmutable()).

--=20
Pedro
