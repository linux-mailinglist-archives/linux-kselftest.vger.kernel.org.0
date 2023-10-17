Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819E87CBD9F
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 10:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbjJQIfQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 04:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbjJQIfQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 04:35:16 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8255E8
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 01:35:13 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-419b53acc11so185911cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Oct 2023 01:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697531713; x=1698136513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJSddZ0dGB6k3S6Wf36lPI8PKwn536bSm0E7Nwxx8qM=;
        b=wkq/1Kot3rNqHeT4HmUbhoGYAdDXmwDCwcVo/A9t8u30E91iqnTpZ6BhkBLD8yc1vF
         13rBLjfH0cPCIl0xpEwybwbUWkovt5CLn8/L0sxhoJByVh71tmyx3jQfAf7YXgLipFEG
         qCpFxLoQYKXikI6pnFlxOQDGM672AfavCs8wyWCTpo3UrubZfRJg+lkQSnY7C11LQ1UA
         TE0GMWSGkdXr/zSKt2o2R7oItTIhceIhK8tIc26Q2yIoJAx0zCvNX1RW1MzSqsPuunIH
         iMgeWr3DDk1trxj4F7CKf+WrVWmLqXa1NZtTBdI/GOQlVgp6lc3i6eevgBHdCaRa4lTN
         XgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697531713; x=1698136513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJSddZ0dGB6k3S6Wf36lPI8PKwn536bSm0E7Nwxx8qM=;
        b=egXmxgu0Rgob15lMEBu3QLnHXM9QA4AlCSkHBYSzUwXgAKU8qim3qfFQH8Hp9xXBVI
         6jH8ekBjP+XKX2ZKCYg/VVh7Ck8wDSXFW4/NBY2gwaDKs7mAnKpI/zOqG7Wsxe33DWqr
         e9jPqqZceSKbnA0v2fhrLQ6FQ4o5uInB0E3foFC6VEyvFTUjy1Rxbi4RDtQUvAxGC2AV
         /R0PmEPIYbOw7/9+WtzrJRQl5MsKeD75RnLxI3Bv+io0zgAJ3s0RH8lhc2qEzu1EJ2t6
         gzFN0qTcdTWclIgpWYJdX5ZrOiICG7R0nvgstFxIYIEQZpp3+KC0w6LN3SNFgt5bFCD1
         5JUA==
X-Gm-Message-State: AOJu0Yz1RT0QL2kbO0nDYbqwyrpEkNWkWXwWzG+aNiLmJhCRBf5q08ia
        OwE5+LXCVvkJpn2VWyqzG0jngXFcaCwi27vf4ltBdQ==
X-Google-Smtp-Source: AGHT+IGdaallY0/Z0dk1uumP4gP3TI0PsofLDJ8x7UN64T/PbxNrhMxhrOA0/Iq+hFcVA8qb3CsR8jlHXjTnqg3B9Ek=
X-Received: by 2002:ac8:7753:0:b0:417:9238:5a30 with SMTP id
 g19-20020ac87753000000b0041792385a30mr137245qtu.29.1697531712820; Tue, 17 Oct
 2023 01:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231016143828.647848-1-jeffxu@chromium.org> <ZS1URCBgwGGj9JtM@casper.infradead.org>
In-Reply-To: <ZS1URCBgwGGj9JtM@casper.infradead.org>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 17 Oct 2023 01:34:35 -0700
Message-ID: <CALmYWFu58LYuSn8DqiU8NjPJzTQuLXu4mg7dHaP1ZW2z3jaaXQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
To:     Matthew Wilcox <willy@infradead.org>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Matthew.

Thanks for your comments and time to review the patchset.

On Mon, Oct 16, 2023 at 8:18=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Oct 16, 2023 at 02:38:19PM +0000, jeffxu@chromium.org wrote:
> > Modern CPUs support memory permissions such as RW and NX bits. Linux ha=
s
> > supported NX since the release of kernel version 2.6.8 in August 2004 [=
1].
>
> This seems like a confusing way to introduce the subject.  Here, you're
> talking about page permissions, whereas (as far as I can tell), mseal() i=
s
> about making _virtual_ addresses immutable, for some value of immutable.
>
> > Memory sealing additionally protects the mapping itself against
> > modifications. This is useful to mitigate memory corruption issues wher=
e
> > a corrupted pointer is passed to a memory management syscall. For examp=
le,
> > such an attacker primitive can break control-flow integrity guarantees
> > since read-only memory that is supposed to be trusted can become writab=
le
> > or .text pages can get remapped. Memory sealing can automatically be
> > applied by the runtime loader to seal .text and .rodata pages and
> > applications can additionally seal security critical data at runtime.
> > A similar feature already exists in the XNU kernel with the
> > VM_FLAGS_PERMANENT [3] flag and on OpenBSD with the mimmutable syscall =
[4].
> > Also, Chrome wants to adopt this feature for their CFI work [2] and thi=
s
> > patchset has been designed to be compatible with the Chrome use case.
>
> This [2] seems very generic and wide-ranging, not helpful.  [5] was more
> useful to understand what you're trying to do.
>
> > The new mseal() is an architecture independent syscall, and with
> > following signature:
> >
> > mseal(void addr, size_t len, unsigned int types, unsigned int flags)
> >
> > addr/len: memory range.  Must be continuous/allocated memory, or else
> > mseal() will fail and no VMA is updated. For details on acceptable
> > arguments, please refer to comments in mseal.c. Those are also fully
> > covered by the selftest.
>
> Mmm.  So when you say "continuous/allocated" what you really mean is
> "Must have contiguous VMAs" rather than "All pages in this range must
> be populated", yes?
>
There can't be a gap (unallocated memory) in the given range.
Those are covered in selftest:
test_seal_unmapped_start()
test_seal_unmapped_middle()
test_seal_unmapped_end()
The comments in check_mm_seal() also mentioned that.

> > types: bit mask to specify which syscall to seal, currently they are:
> > MM_SEAL_MSEAL 0x1
> > MM_SEAL_MPROTECT 0x2
> > MM_SEAL_MUNMAP 0x4
> > MM_SEAL_MMAP 0x8
> > MM_SEAL_MREMAP 0x10
>
> I don't understand why we want this level of granularity.  The OpenBSD
> and XNU examples just say "This must be immutable*".  For values of
> immutable that allow downgrading access (eg RW to RO or RX to RO),
> but not upgrading access (RW->RX, RO->*, RX->RW).
>
> > Each bit represents sealing for one specific syscall type, e.g.
> > MM_SEAL_MPROTECT will deny mprotect syscall. The consideration of bitma=
sk
> > is that the API is extendable, i.e. when needed, the sealing can be
> > extended to madvise, mlock, etc. Backward compatibility is also easy.
>
> Honestly, it feels too flexible.  Why not just two flags to mprotect()
> -- PROT_IMMUTABLE and PROT_DOWNGRADABLE.  I can see a use for that --
> maybe for some things we want to be able to downgrade and for other
> things, we don't.
>
Having a seal type per syscall type helps to add the feature incrementally.
Applications also know exactly what is sealed.

I'm not against types such as IMMUTABLE and DOWNGRADEABLE, if we
can define what it seals precisely. As Jann pointed out, there have
other scenarios that potentially affect IMMUTABLE. Implementing all thoses
will take time. And if we missed a case, we could introduce backward
compatibility issues to the application. Bitmask will solve this nicely, i.=
e.
application will need to apply the newly added sealing type explicitly.

> I'd like to see some discussion of how this interacts with mprotect().
> As far as I can tell, the intent is to lock the protections/existance
> of the mapping, and not to force memory to stay in core.  So it's fine
> for the kernel to swap out the page and set up a PTE as a swap entry.
> It's also fine for the kernel to mark PTEs as RO to catch page faults;
> we're concerned with the LOGICAL permissions, and not the page tables.

Yes. That is correct.

-Jeff Xu
