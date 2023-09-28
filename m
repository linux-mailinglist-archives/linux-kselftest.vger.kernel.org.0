Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF807B2154
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 17:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjI1Pai (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 11:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjI1PaW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 11:30:22 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303361A5
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 08:30:20 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c6052422acso166465ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 08:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695915019; x=1696519819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gW3bQkxv5ZlVvPDaRZ7GOUnQxOQtKH5unki4YKmOzgQ=;
        b=pBn+H+ni9EOJ4jKn6TpZfhqkcqfY9Z3xCfaTO2FkB9Rr47Z3RVSxDst6po7Ai6tsZ0
         OjxwbRaWaDzGUsiEcJzZn+NeDek3XxVqGI3wY7yXK/fwBCyLE0vriydhOpPUUL+3sFCN
         PheLGrNP2ShN0JP5IMyXM2mL1HB7PpeE8epZJKr0YnmY6ezexGUiuhAw3HyZngrK2tbY
         oRRsizqyE7PvQvOdqiKojUT0LSaASlXpV3hg6E5QH08Y/9Yp47+HfAkA+vNRPQ4c3N20
         OMrVGTo8mV145JYxvRBnesRPr2Qzh9pLZZWvLu8djV3+OVOIBM8jXi6i1EApMS/rR5sI
         GdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695915019; x=1696519819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gW3bQkxv5ZlVvPDaRZ7GOUnQxOQtKH5unki4YKmOzgQ=;
        b=ejOR9vywS+IHGf7z3QGx88cZhthVRnfsm392d99W06ZhkjbPrmeu+/VsEPW0C2HIhN
         aTUDg9WOBczibyOuykvdCBtbZU/bG6uaivFqCc7F29L1sH8BSuV4zeDWHdqsH3WqDFz7
         1hFL1Lb2BRaeqNGWASK8HZprEGgXq+tS175jzvKB2ug/TQmkjSSRvWugqM9FjQPunESX
         m3tfy5B2Lls87qSPDZZVhR8XHtWcOE/Zgcu89UNd9ZGanL0tPKwGZ+Ms41K1pFxOlkh7
         VYz4FlNZxk62yN4qNniTikV+NzBYuhWCO+dLHRL7RK9tdWtW/hvlAVAPXm+eLUoQnpfn
         nDpg==
X-Gm-Message-State: AOJu0YyQji3cC7B1s5RrHZoJ/eYEPr8M6nhK+P8Gq6HrjEpkG0zCYAJi
        ldh30PE/6NpISqjGyOk8CGDd6nlMQLMZj2NabLm91w==
X-Google-Smtp-Source: AGHT+IHHyfIM/7h2yPICm3uZHEnv53ZDC4+2b2+nBKsf/B6JPSxSiNPVillmryDthljWo4bey1UqJpEOBpTCWBBBy5E=
X-Received: by 2002:a17:902:9a85:b0:1c4:1392:e4b5 with SMTP id
 w5-20020a1709029a8500b001c41392e4b5mr686821plp.21.1695915019275; Thu, 28 Sep
 2023 08:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230923013148.1390521-1-surenb@google.com> <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez11FdESrYYDLmtZEgZ7osDi-QDYpk+Z0p=qjpCks++7rg@mail.gmail.com> <CAJuCfpG1sjJdEoxtYFk9-r_5kutss_C3breJVFz99efsKKXzqg@mail.gmail.com>
In-Reply-To: <CAJuCfpG1sjJdEoxtYFk9-r_5kutss_C3breJVFz99efsKKXzqg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 28 Sep 2023 17:29:43 +0200
Message-ID: <CAG48ez2uMXLigojbF3HD20Q5jL4ZMSZf6GS-5Y7P=jiB7gibpQ@mail.gmail.com>
Subject: Re: potential new userfaultfd vs khugepaged conflict [was: Re: [PATCH
 v2 2/3] userfaultfd: UFFDIO_REMAP uABI]
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, brauner@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@kernel.org>, willy@infradead.org,
        Liam.Howlett@oracle.com, zhangpeng362@huawei.com,
        Brian Geffon <bgeffon@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Nicolas Geoffray <ngeoffray@google.com>,
        Jared Duke <jdduke@google.com>, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
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

On Wed, Sep 27, 2023 at 7:12=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Sep 27, 2023 at 3:07=E2=80=AFAM Jann Horn <jannh@google.com> wrot=
e:
> >
> > [moving Hugh into "To:" recipients as FYI for khugepaged interaction]
> >
> > On Sat, Sep 23, 2023 at 3:31=E2=80=AFAM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > > From: Andrea Arcangeli <aarcange@redhat.com>
> > >
> > > This implements the uABI of UFFDIO_REMAP.
> > >
> > > Notably one mode bitflag is also forwarded (and in turn known) by the
> > > lowlevel remap_pages method.
> > >
> > > Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > [...]
> > > +/*
> > > + * The mmap_lock for reading is held by the caller. Just move the pa=
ge
> > > + * from src_pmd to dst_pmd if possible, and return true if succeeded
> > > + * in moving the page.
> > > + */
> > > +static int remap_pages_pte(struct mm_struct *dst_mm,
> > > +                          struct mm_struct *src_mm,
> > > +                          pmd_t *dst_pmd,
> > > +                          pmd_t *src_pmd,
> > > +                          struct vm_area_struct *dst_vma,
> > > +                          struct vm_area_struct *src_vma,
> > > +                          unsigned long dst_addr,
> > > +                          unsigned long src_addr,
> > > +                          __u64 mode)
> > > +{
> > > +       swp_entry_t entry;
> > > +       pte_t orig_src_pte, orig_dst_pte;
> > > +       spinlock_t *src_ptl, *dst_ptl;
> > > +       pte_t *src_pte =3D NULL;
> > > +       pte_t *dst_pte =3D NULL;
> > > +
> > > +       struct folio *src_folio =3D NULL;
> > > +       struct anon_vma *src_anon_vma =3D NULL;
> > > +       struct mmu_notifier_range range;
> > > +       int err =3D 0;
> > > +
> > > +       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, src_mm,
> > > +                               src_addr, src_addr + PAGE_SIZE);
> > > +       mmu_notifier_invalidate_range_start(&range);
> > > +retry:
> > > +       dst_pte =3D pte_offset_map_nolock(dst_mm, dst_pmd, dst_addr, =
&dst_ptl);
> > > +
> > > +       /* If an huge pmd materialized from under us fail */
> > > +       if (unlikely(!dst_pte)) {
> > > +               err =3D -EFAULT;
> > > +               goto out;
> > > +       }
> > > +
> > > +       src_pte =3D pte_offset_map_nolock(src_mm, src_pmd, src_addr, =
&src_ptl);
> > > +
> > > +       /*
> > > +        * We held the mmap_lock for reading so MADV_DONTNEED
> > > +        * can zap transparent huge pages under us, or the
> > > +        * transparent huge page fault can establish new
> > > +        * transparent huge pages under us.
> > > +        */
> > > +       if (unlikely(!src_pte)) {
> > > +               err =3D -EFAULT;
> > > +               goto out;
> > > +       }
> > > +
> > > +       BUG_ON(pmd_none(*dst_pmd));
> > > +       BUG_ON(pmd_none(*src_pmd));
> > > +       BUG_ON(pmd_trans_huge(*dst_pmd));
> > > +       BUG_ON(pmd_trans_huge(*src_pmd));
> >
> > This works for now, but note that Hugh Dickins has recently been
> > reworking khugepaged such that PTE-based mappings can be collapsed
> > into transhuge mappings under the mmap lock held in *read mode*;
> > holders of the mmap lock in read mode can only synchronize against
> > this by taking the right page table spinlock and rechecking the pmd
> > value. This is only the case for file-based mappings so far, not for
> > anonymous private VMAs; and this code only operates on anonymous
> > private VMAs so far, so it works out.
> >
> > But if either Hugh further reworks khugepaged such that anonymous VMAs
> > can be collapsed under the mmap lock in read mode, or you expand this
> > code to work on file-backed VMAs, then it will become possible to hit
> > these BUG_ON() calls. I'm not sure what the plans for khugepaged going
> > forward are, but the number of edgecases everyone has to keep in mind
> > would go down if you changed this function to deal gracefully with
> > page tables disappearing under you.
> >
> > In the newest version of mm/pgtable-generic.c, above
> > __pte_offset_map_lock(), there is a big comment block explaining the
> > current rules for page table access; in particular, regarding the
> > helper pte_offset_map_nolock() that you're using:
> >
> >  * pte_offset_map_nolock(mm, pmd, addr, ptlp), above, is like pte_offse=
t_map();
> >  * but when successful, it also outputs a pointer to the spinlock in pt=
lp - as
> >  * pte_offset_map_lock() does, but in this case without locking it.  Th=
is helps
> >  * the caller to avoid a later pte_lockptr(mm, *pmd), which might by th=
at time
> >  * act on a changed *pmd: pte_offset_map_nolock() provides the correct =
spinlock
> >  * pointer for the page table that it returns.  In principle, the calle=
r should
> >  * recheck *pmd once the lock is taken; in practice, no callsite needs =
that -
> >  * either the mmap_lock for write, or pte_same() check on contents, is =
enough.
> >
> > If this becomes hittable in the future, I think you will need to
> > recheck *pmd, at least for dst_pte, to avoid copying PTEs into a
> > detached page table.
>
> Thanks for the warning, Jann. It sounds to me it would be better to
> add this pmd check now even though it's not hittable. Does that sound
> good to everyone?

Sounds good to me.
