Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE6B7CCF59
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 23:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343885AbjJQVeI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 17:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjJQVeI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 17:34:08 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3434AB
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 14:34:04 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-41b813f0a29so47061cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 14:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697578444; x=1698183244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMXGhkJDs7eDT4ZOO41ZpDvjS9DBH4hMrhhJ0DjwM1k=;
        b=yJxn2o7MWJoPCpBvwRDcfiFAQXwz/HAnNxWwq+OturXWiC0UVy0kaaPL30iD7Dg7Af
         el6Ft+9nH7nscGSEvsTrxrJ8eifqdIh7kXeShlKUjNcbQVSdo3GUkjOHBlO3LX89kIAu
         kofj9qAb8X5T5pXUC9GRxnYfEAY5PC2pXQvqf4JPu4EGDxE5w2QjsXVlzzm+QNxAVsEr
         /wveG8nldTm+2OAQ3O3T6Aur4Uo2UKQz87JLcRU8IqO4vbigNcyO3CvuYyUyDGEVkZS5
         gGDBQZ+zEbGky4hct2WY+OVGBzIBEiXQSSHznkDa3n7q+kyJ557DCpM9ZnlcaeSsjwyV
         KLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697578444; x=1698183244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMXGhkJDs7eDT4ZOO41ZpDvjS9DBH4hMrhhJ0DjwM1k=;
        b=WlE46g1EXwc6wa2k6n6xmI5c2/fWnigW766zJSPIsI1PuWd0M0RnUMwEca9uMRhABm
         LQ0/JqExj2ZRZ+8yUu72zoz+Vb9gwb9HdhdWjJkfq2J2Y6RskOiMj1WFYYMPn5qu8xoC
         pS7UHUEMBjYjzWz2kPN12QacxDMk3sktKFkSgx25DjgBXQqJK0Os3+KFCiuXSsYvB/6n
         GDhxrRDWL8Vd5ppstwp+YLZ6K0/0GTv5Z97MP+NAFHYmnhZSKQj+3kQ6nVW3kElVrgrP
         XoqbMJQmnzC3XKysoQtEYYIfR/NIlOtDYcsv8duWOjzQxm+7h5RBqwME+RrY569blMee
         7ROg==
X-Gm-Message-State: AOJu0Yx98an1qm0LtK2nvW21iQWH7GTcYwiGOx2GxGhgohVYPnKsgajX
        FGvQZQ/EeCODlIqRSb8JSxJGC/4O0Old1qSmuTVsNQ==
X-Google-Smtp-Source: AGHT+IFUwVtlYfLi7JKZSCUz0Jiosx6BPQWeV/rvZGaP3zfq+4NyIM/XBBrwOPaKmQ5mtz+XiIwCd4QxV0UKqN6/gis=
X-Received: by 2002:a05:622a:68ce:b0:41b:834e:1b24 with SMTP id
 ic14-20020a05622a68ce00b0041b834e1b24mr94058qtb.6.1697578443767; Tue, 17 Oct
 2023 14:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231016143828.647848-1-jeffxu@chromium.org> <ZS1URCBgwGGj9JtM@casper.infradead.org>
 <CAKbZUD2A+=bp_sd+Q0Yif7NJqMu8p__eb4yguq0agEcmLH8SDQ@mail.gmail.com>
In-Reply-To: <CAKbZUD2A+=bp_sd+Q0Yif7NJqMu8p__eb4yguq0agEcmLH8SDQ@mail.gmail.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 17 Oct 2023 14:33:25 -0700
Message-ID: <CALmYWFtOgMAQDGNoM6k2Ev4kMHD396wwH+rVDODaSjsyVMDogg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
To:     Pedro Falcato <pedro.falcato@gmail.com>
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

On Tue, Oct 17, 2023 at 8:30=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> On Mon, Oct 16, 2023 at 4:18=E2=80=AFPM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Mon, Oct 16, 2023 at 02:38:19PM +0000, jeffxu@chromium.org wrote:
> > > Modern CPUs support memory permissions such as RW and NX bits. Linux =
has
> > > supported NX since the release of kernel version 2.6.8 in August 2004=
 [1].
> >
> > This seems like a confusing way to introduce the subject.  Here, you're
> > talking about page permissions, whereas (as far as I can tell), mseal()=
 is
> > about making _virtual_ addresses immutable, for some value of immutable=
.
> >
> > > Memory sealing additionally protects the mapping itself against
> > > modifications. This is useful to mitigate memory corruption issues wh=
ere
> > > a corrupted pointer is passed to a memory management syscall. For exa=
mple,
> > > such an attacker primitive can break control-flow integrity guarantee=
s
> > > since read-only memory that is supposed to be trusted can become writ=
able
> > > or .text pages can get remapped. Memory sealing can automatically be
> > > applied by the runtime loader to seal .text and .rodata pages and
> > > applications can additionally seal security critical data at runtime.
> > > A similar feature already exists in the XNU kernel with the
> > > VM_FLAGS_PERMANENT [3] flag and on OpenBSD with the mimmutable syscal=
l [4].
> > > Also, Chrome wants to adopt this feature for their CFI work [2] and t=
his
> > > patchset has been designed to be compatible with the Chrome use case.
> >
> > This [2] seems very generic and wide-ranging, not helpful.  [5] was mor=
e
> > useful to understand what you're trying to do.
> >
> > > The new mseal() is an architecture independent syscall, and with
> > > following signature:
> > >
> > > mseal(void addr, size_t len, unsigned int types, unsigned int flags)
> > >
> > > addr/len: memory range.  Must be continuous/allocated memory, or else
> > > mseal() will fail and no VMA is updated. For details on acceptable
> > > arguments, please refer to comments in mseal.c. Those are also fully
> > > covered by the selftest.
> >
> > Mmm.  So when you say "continuous/allocated" what you really mean is
> > "Must have contiguous VMAs" rather than "All pages in this range must
> > be populated", yes?
> >
> > > types: bit mask to specify which syscall to seal, currently they are:
> > > MM_SEAL_MSEAL 0x1
> > > MM_SEAL_MPROTECT 0x2
> > > MM_SEAL_MUNMAP 0x4
> > > MM_SEAL_MMAP 0x8
> > > MM_SEAL_MREMAP 0x10
> >
> > I don't understand why we want this level of granularity.  The OpenBSD
> > and XNU examples just say "This must be immutable*".  For values of
> > immutable that allow downgrading access (eg RW to RO or RX to RO),
> > but not upgrading access (RW->RX, RO->*, RX->RW).
> >
> > > Each bit represents sealing for one specific syscall type, e.g.
> > > MM_SEAL_MPROTECT will deny mprotect syscall. The consideration of bit=
mask
> > > is that the API is extendable, i.e. when needed, the sealing can be
> > > extended to madvise, mlock, etc. Backward compatibility is also easy.
> >
> > Honestly, it feels too flexible.  Why not just two flags to mprotect()
> > -- PROT_IMMUTABLE and PROT_DOWNGRADABLE.  I can see a use for that --
> > maybe for some things we want to be able to downgrade and for other
> > things, we don't.
>
> I think it's worth pointing out that this suggestion (with PROT_*)
> could easily integrate with mmap() and as such allow for one-shot
> mmap() + mseal().
> If we consider the common case as 'addr =3D mmap(...); mseal(addr);', it
> definitely sounds like a performance win as we halve the number of
> syscalls for a sealed mapping. And if we trivially look at e.g OpenBSD
> ld.so code, mmap() + mimmutable() and mprotect() + mimmutable() seem
> like common patterns.
>
Yes. mmap() can support sealing as well, and memory is allocated as
immutable from begining.
This is orthogonal to mseal() though.
In case of ld.so, iiuc, memory can be first allocated as W, then later
changed to RO, for example, during symbol resolution.
The important point is that the application can decide what type of
sealing it wants, and when to apply it.  There needs to be an api(),
that can be mseal() or mprotect2() or mimmutable(), the naming is not
important to me.

mprotect() in linux have the following signature:
int mprotect(void addr[.len], size_t len, int prot);
the prot bitmasks are all taken here.
I have not checked the prot field in mmap(), there might be bits left,
even not, we could have mmap2(), so that is not an issue.

Thanks
-Jeff

> --
> Pedro
