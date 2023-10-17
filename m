Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B967CD02C
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 01:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjJQXCD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 19:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbjJQXCA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 19:02:00 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716B211C
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 16:01:52 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-41b813f0a29so64991cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 16:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697583711; x=1698188511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImnM3gTgvQUDZbbKNrv2s4PovNIFWxZGTx+tFBxEKCA=;
        b=A7yO6MSch9D1Y7KGob8X8JTG8G9ij12MKR7I7utx1DUsTtuuQWiuYuFCPD/qg/hq0E
         edj2wqPSVvbGNpHCl9278UUmDyxBzdgwkINhWwXbB1lYZ+pTcQbqOWFZLLqF2nbX+8k/
         j4llB2vEaFCGO5SETUEoIzd6x1zdt4U8wkYTniL8fsrXJ/mAfFWF6igxbRUysywevlBs
         QhzlhES29vTjn26T6zpTxlwPR0Wdke62227H/gnmSwAqLc4y2MvnRMLGWkEKAXhkKKhw
         H6ULLh0h55BWIxoPVIGTeuYChQLfhXUY0/w3pfQeW4QLBS7nlyKHB2ltDx8v1Ib+YkWb
         zcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697583711; x=1698188511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImnM3gTgvQUDZbbKNrv2s4PovNIFWxZGTx+tFBxEKCA=;
        b=GAyDWHPsRvqHjL3LNYC8Df9EWK1Ohi5YupLwoJCsvL9Yc2KaY/P3nHOvzzj0Vj151F
         lm0PySrXvY6lgrWYrpoJVYSGigOeqBMuVzP4lEXdV7FH/AnjFZj9f4mFv6hJ/Jv/EgVk
         hpZv7+TEJ9d3uxXSBdauS3lPxX8aQClLceWOwZHGj/KO/dcronRL0ib4cJ/BRyvMMytx
         bSK8C+o5qfhi1mKKRwONn4wsesqYRUmUbAeOAy9obSM5cKTkyUqbM4JSNkl8CrQ1ikJc
         sk95aADn5JZASWDn8JRxK8/cHZuSQl2iAIfuNoHrV8ecIawSkS2fcSbJAl0CaThkPzNk
         VXBg==
X-Gm-Message-State: AOJu0Yxxy44yWRD8inwdpaZyQwYPf6Rg8lThlt9lDFiCnYqQAC3MavEV
        LqPju7v6MPc0uEt7v+BrC8DoXUBZDo3uCa40PRMSMg==
X-Google-Smtp-Source: AGHT+IFRiCphE8SGRZza9wFnaYv5dtjuDGiQxMHSXLNnXD68r7Tsnp6XlmaQHLEDn/NPKGLCG14R2gjFx0iFXzfE8zw=
X-Received: by 2002:a05:622a:a047:b0:41b:ef8f:dcbc with SMTP id
 ju7-20020a05622aa04700b0041bef8fdcbcmr149648qtb.0.1697583710994; Tue, 17 Oct
 2023 16:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231016143828.647848-1-jeffxu@chromium.org> <CAHk-=whFZoap+DBTYvJx6ohqPwn11Puzh7q4huFWDX9vBwXHgg@mail.gmail.com>
 <CALmYWFtTDAb_kpZdAe_xspqwNgK1NWJmjTxaTC=jDEMzfe297Q@mail.gmail.com>
 <CAHk-=wj87GMTH=5901ob=SjQqegAm2JYBE7E4J7skJzE64U-wQ@mail.gmail.com> <55960.1697566804@cvs.openbsd.org>
In-Reply-To: <55960.1697566804@cvs.openbsd.org>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 17 Oct 2023 16:01:13 -0700
Message-ID: <CALmYWFs81T=XnT=AXQTo0+9FXo=OBAV_4rrYPSn9-16O-gBTZg@mail.gmail.com>
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

On Tue, Oct 17, 2023 at 11:20=E2=80=AFAM Theo de Raadt <deraadt@openbsd.org=
> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > On Tue, 17 Oct 2023 at 02:08, Jeff Xu <jeffxu@google.com> wrote:
> > >
> > > It is probably worth noting that I choose to check one and only
> > > one sealing type per syscall. i.e. munmap(2) checks
> > > MM_SEAL_MUNMAP only.
> >
> > Yeah, this is wrong.
> >
> > It's wrong exactly because other system calls will unmap things too.
> >
> > Using mmap() to over-map something will unmap the old one.
> >
> > Same goes for mremap() to move over an existing mapping.
> >
> > So the whole "do things by the name of the system call" is not workable=
.
> >
> > All that matters is what the system calls *do*, not what their name is.
>
> I agree completely...
>
> mseal() is a clone of mimmutable(2), but with an extremely
> over-complicated API based upon dubious arguments.
>
> I designed mimmutable(2) [1] in OpenBSD, it took about a year to get all
> the components working correctly.  There were many intermediate API
> during development, but in the end the API is simply:
>
>      int mimmutable(void *addr, size_t len);
>
> The kernel code for mimmutable() traverses the specified VA range.  In
> that range, it will find unmapped sub-regions (which are are ignored)
> and mapped sub-regions. For these mapped regions, it does not care what
> the permissions are, it just marks each sub-region as immutable.
>
> Later on, when any VM operation request upon a VA range attempts to
>       (1) change the permissions
>       (2) to re-map on top
>       (3) or dispose of the mapping,
> that operation is refused with errno EPERM.  We don't care where the
> request comes from (ie. what system call).  It is a behaviour of the
> VM system, when asked to act upon a VA sub-range mapping.
>
> Very simple semantics.
>
> The only case where the immutable marker is ignored is during address spa=
ce
> teardown as a result of process termination.
>
May I ask, for BSD's implementation of immutable(), do you cover
things such as mlock(),
madvice() ? or just the protection bit (WRX) + remap() + unmap().

In other words:
Is BSD's definition of immutable equivalent to
MM_SEAL_MPROTECT|MM_SEAL_MUNMAP|MM_SEAL_MREMAP|MM_SEAL_MMAP, of this patch =
set ?

I hesitate to introduce the concept of immutable into linux because I don't=
 know
all the scenarios present in linux where VMAs's metadata can be
modified. As Jann's email pointed out,
There could be quite a few things we still need to deal with, to
completely block the possibility,
e.g. malicious code attempting to write to a RO memory or change RW
memory to RWX.

If, as part of immutable, I also block madvice(), mlock(), which also updat=
es
VMA's metadata, so by definition, I could.  What if the user wants the
features in
madvice() and at the same time, also wants their .text protected ?

Also, if linux introduces a new syscall that depends on a new metadata of V=
MA,
say msecret(), (for discussion purpose), should immutable
automatically support that ?

Without those questions answered, I couldn't choose the route of
immutable() yet.

-Jeff



>
> In his submission of this API, Jeff Xu makes three claims I find dubious;
>
> > Also, Chrome wants to adopt this feature for their CFI work [2] and thi=
s
> > patchset has been designed to be compatible with the Chrome use case.
>
> I specifically designed mimmutable(2) with chrome in mind, and the
> chrome binary running on OpenBSD is full of immutable mappings.  All the
> library regions automatically become immutable because ld.so can infer
> it and do the mimmutable calls for the right subregions.
>
> So this chrome work has already been done by OpenBSD, and it is dead
> simple.  During early development I thought mimmutable(2) would be
> called by applications or libraries, but I was dead wrong: 99.9% of
> calls are from ld.so, and no applications need to call it, these are the
> two exceptions:
>
> In OpenBSD, mimmutable() is used in libc malloc() to lock-down some data
> structures at initialization time, so they canoot be attacked to create
> an invariant for use in ROP return-to-libc style methods.
>
> In Chrome, there is a v8_flags variable rounded out to a full page, and
> placed in .data.  Chrome initialized this variable, and wants to mprotect
> PROT_READ, but .data has been made immutable by ld.so.  So we force this
> page into a new ELF section called "openbsd.mutable" which also behaves R=
W
> like .data.  Where chrome does the mprotect  PROT_READ, it now also perfo=
rms
> mimmutable() on that page.
>
> > Having a seal type per syscall type helps to add the feature incrementa=
lly.
>
> Yet, somehow OpenBSD didn't do it per syscall, and we managed to make our
> entire base operating system and 10,000+ applications automatically recei=
ve
> the benefits.  In one year's effort.  The only application which cared ab=
out
> it was chrome, described in the previous paragraph.
>
> I think Jeff's idea here is super dangerous.  What will actually happen
> is people will add a few mseal() sub-operations and think the job is done=
.
> It isn't done.  They need all the mseal() requests, or the mapping are
> not safe.
>
> It is very counterproductive to provide developers a complex API that has
> insecure suboperations.
>
> > Applications also know exactly what is sealed.
>
> Actually applicatins won't know because there is no tooling to inspect th=
is --
> but I will argue further that applications don't need to know.  Immutable
> marking is a system decision, not a program decision.
>
>
> I'll close by asking for a new look at the mimmutable(2) API we settled
> on for OpenBSD.  I think there is nothing wrong with it.  I'm willing to
> help guide glibc / ld.so / musl teams through the problems they may find
> along the way, I know where the skeletons are buried.  Two in
> particular: -znow RELRO already today, and xonly-text in the future.
>
>
> [1] https://man.openbsd.org/mimmutable.2
>
