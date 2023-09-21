Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826A67A9D42
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 21:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjIUTaV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 15:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjIUT3s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 15:29:48 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA6CADF1F
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Sep 2023 11:04:44 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-59bc956b029so15266217b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Sep 2023 11:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695319484; x=1695924284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdMCh/+yCsduMbxg3dBOP8pPO/0inss321VX5z7Cslw=;
        b=4cF7X2KPVdvj/7607ekIQaEkhcmXERPq1+VVvEJRyxyWaezd5rbC9thCnzqB94ztKQ
         +TfEJjXpFjfWkyJ7KrTjFUq/3rbF6WwXPHNTkgibkgKgzTNtmgz6JLTqCy7o63154Lw3
         JkijIXtRuB5qgVnzVQDXUkKyg8OcoA9NjUM5tN1WkyYYZ/MTOyy3tiwOJUzqcpq7ffVi
         mppntYxKiaZkni8p7pmOPe1W7cLQWJ6GIpyVeefZ94o1e7MaT8OitlV73/fewMZGB8gU
         ec6vw1Nrqc9ThSRrDbZO2GoHt7qiX1QK5AIYPua8zhISucW8WmL7bZS3PgjfWV60lQU2
         Ip4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319484; x=1695924284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdMCh/+yCsduMbxg3dBOP8pPO/0inss321VX5z7Cslw=;
        b=XyQS5WgzQCcSG5gKMdfcnkb2PV1Z+2ilBS/Y1wCPuxXuiJN0j4TiNf7kF2WMD//Y0I
         uAyVDCWqI09J+TcDLZ+fud2/Ebv0VaHmy7IV7tIhnO1zecLmGrBcHflMxIaeQllpjoR9
         13yVorBTkjgz1Dn+9tmeo858CCRQaj25Jbswc8RzCG0gnS4YZ+Ie7O/te0HYr3wPZdVg
         Q0QwqR9IWGv7CN9Q7ndpriHgkmjIp7VDjDga1+vXLTrwnq2+3Q8BraRI9wC1Sh5c4PXA
         oC2z67V35DDCNz5olcQmmtvndwwaMrXByLZpE1PCSp+ec9b+O4TXubz2TKAWFfOI+egF
         vBxw==
X-Gm-Message-State: AOJu0YyHclP6BdQKQmgTqKEgHnYbs/XpBobkWWhjJl/Fvxr9O48BbEUH
        wiB1nrchnQhztivIwJ3xEtWVhyGhB3/MNZYCZhA/rg==
X-Google-Smtp-Source: AGHT+IFlXUKdQWPSBHJn1j/MDvMjTmPT/VMWQg4H/xOs81/J/jwuJ8JJXX1pfb+Adw8urZJBbplJpBr1hxqfZ6IXHLI=
X-Received: by 2002:a25:dbca:0:b0:d5c:ce73:6528 with SMTP id
 g193-20020a25dbca000000b00d5cce736528mr5584392ybf.35.1695319483599; Thu, 21
 Sep 2023 11:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230914152620.2743033-1-surenb@google.com> <20230914152620.2743033-3-surenb@google.com>
 <ZQNMze6SXdIm13CW@casper.infradead.org> <e77b75f9-ab9e-f20b-6484-22f73524c159@redhat.com>
 <f6e350f4-1bf3-ca10-93f8-c11db44ce62b@redhat.com>
In-Reply-To: <f6e350f4-1bf3-ca10-93f8-c11db44ce62b@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 21 Sep 2023 18:04:30 +0000
Message-ID: <CAJuCfpGqt1V5puRMhLkjG6F2T4xtsDY8qy--ZfBPNL9kxPyWtg@mail.gmail.com>
Subject: Re: [PATCH 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 14, 2023 at 6:45=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 14.09.23 20:43, David Hildenbrand wrote:
> > On 14.09.23 20:11, Matthew Wilcox wrote:
> >> On Thu, Sep 14, 2023 at 08:26:12AM -0700, Suren Baghdasaryan wrote:
> >>> +++ b/include/linux/userfaultfd_k.h
> >>> @@ -93,6 +93,23 @@ extern int mwriteprotect_range(struct mm_struct *d=
st_mm,
> >>>    extern long uffd_wp_range(struct vm_area_struct *vma,
> >>>                       unsigned long start, unsigned long len, bool en=
able_wp);
> >>>
> >>> +/* remap_pages */
> >>> +extern void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
> >>> +extern void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
> >>> +extern ssize_t remap_pages(struct mm_struct *dst_mm,
> >>> +                      struct mm_struct *src_mm,
> >>> +                      unsigned long dst_start,
> >>> +                      unsigned long src_start,
> >>> +                      unsigned long len, __u64 flags);
> >>> +extern int remap_pages_huge_pmd(struct mm_struct *dst_mm,
> >>> +                           struct mm_struct *src_mm,
> >>> +                           pmd_t *dst_pmd, pmd_t *src_pmd,
> >>> +                           pmd_t dst_pmdval,
> >>> +                           struct vm_area_struct *dst_vma,
> >>> +                           struct vm_area_struct *src_vma,
> >>> +                           unsigned long dst_addr,
> >>> +                           unsigned long src_addr);
> >>
> >> Drop the 'extern' markers from function declarations.
> >>
> >>> +int remap_pages_huge_pmd(struct mm_struct *dst_mm,
> >>> +                    struct mm_struct *src_mm,
> >>> +                    pmd_t *dst_pmd, pmd_t *src_pmd,
> >>> +                    pmd_t dst_pmdval,
> >>> +                    struct vm_area_struct *dst_vma,
> >>> +                    struct vm_area_struct *src_vma,
> >>> +                    unsigned long dst_addr,
> >>> +                    unsigned long src_addr)
> >>> +{
> >>> +   pmd_t _dst_pmd, src_pmdval;
> >>> +   struct page *src_page;
> >>> +   struct anon_vma *src_anon_vma, *dst_anon_vma;
> >>> +   spinlock_t *src_ptl, *dst_ptl;
> >>> +   pgtable_t pgtable;
> >>> +   struct mmu_notifier_range range;
> >>> +
> >>> +   src_pmdval =3D *src_pmd;
> >>> +   src_ptl =3D pmd_lockptr(src_mm, src_pmd);
> >>> +
> >>> +   BUG_ON(!pmd_trans_huge(src_pmdval));
> >>> +   BUG_ON(!pmd_none(dst_pmdval));
> >>> +   BUG_ON(!spin_is_locked(src_ptl));
> >>> +   mmap_assert_locked(src_mm);
> >>> +   mmap_assert_locked(dst_mm);
> >>> +   BUG_ON(src_addr & ~HPAGE_PMD_MASK);
> >>> +   BUG_ON(dst_addr & ~HPAGE_PMD_MASK);
> >>> +
> >>> +   src_page =3D pmd_page(src_pmdval);
> >>> +   BUG_ON(!PageHead(src_page));
> >>> +   BUG_ON(!PageAnon(src_page));
> >>
> >> Better to add a src_folio =3D page_folio(src_page);
> >> and then folio_test_anon() here.
> >>
> >>> +   if (unlikely(page_mapcount(src_page) !=3D 1)) {
> >>
> >> Brr, this is going to miss PTE mappings of this folio.  I think you
> >> actually want folio_mapcount() instead, although it'd be more efficien=
t
> >> to look at folio->_entire_mapcount =3D=3D 1 and _nr_pages_mapped =3D=
=3D 0.
> >> Not wure what a good name for that predicate would be.
> >
> > We have
> >
> >    * It only works on non shared anonymous pages because those can
> >    * be relocated without generating non linear anon_vmas in the rmap
> >    * code.
> >    *
> >    * It provides a zero copy mechanism to handle userspace page faults.
> >    * The source vma pages should have mapcount =3D=3D 1, which can be
> >    * enforced by using madvise(MADV_DONTFORK) on src vma.
> >
> > Use PageAnonExclusive(). As long as KSM is not involved and you don't
> > use fork(), that flag should be good enough for that use case here.
> >
> ... and similarly don't do any of that swapcount stuff and only check if
> the swap pte is anon exclusive.

I'm preparing v2 and this is the only part left for me to address but
I'm not clear how. David, could you please clarify how I should be
checking swap pte to be exclusive without swapcount?

>
> --
> Cheers,
>
> David / dhildenb
>
