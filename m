Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E107B0BE7
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 20:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjI0SZl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 14:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjI0SZl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 14:25:41 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4904CF4
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Sep 2023 11:25:39 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3231df68584so7749753f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Sep 2023 11:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695839138; x=1696443938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFhF8RUb+Bu9+rM6xrYeWt5o4VbnL73BwlvF+/CLnlY=;
        b=i7u+UY0KrNjq6vDldMk8ty0loVs6CbAY6lTBad8iVEAe+ruNxpbZzMB1qpVIlcHTNu
         SbnxmXFRRIi3SbvtoKaKRjH6/fGSIC+Xi50ND8yqDQDMmW6Qm5Z8WZPmPbYhoX8yow65
         h8vXcfhvbs40rT2d6AgZcSj4/xD/zrDsKV43NKoebcTxRN3sAttqs6MJdktmAoupf6Fo
         CpesRK/xckk+KvYc/T1C5gaiOmrktJj1JxuJM75Z00ZFoCToNrzpotGk0GKeeykxYs1Y
         B0DezaZYLQjPrT2un8ufM2oYQEXV1qIItS4nctCpPAj9Hujwsdto6F4Sz320a4k+5w1C
         phrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695839138; x=1696443938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFhF8RUb+Bu9+rM6xrYeWt5o4VbnL73BwlvF+/CLnlY=;
        b=VwB2UN/sjv35Ok8BonRqn8C/jCBf7J/K4tCAJnKrpX+MXWMTorqSqaWkKoR5A/Sbtr
         bs4VRjxaMgFA0o5h8t7PlgRHCBH68KWvXWBIa5Pvk6PenUyloyAFZvqcdvSPWfjnbR+P
         0VTmIuZ0M46g0a4/6WvXOMjk/IwW+F+SUTuCa3W1BmjavMSivPP/F2Zs26N0HVv5LdXz
         M095MIr5s4GZXome5wuMmsUtER/AdQko+BxCfmQQcY1YrUiRBxAE47NCCmd6rNAZD9PG
         hG79BZ8W9hpUXOyLh9t4lSruSFIGHZJjEHW2v3CHqsq6uXUIGx6/6pKfYGCMeA/eNDyD
         SmaQ==
X-Gm-Message-State: AOJu0YwlLA8gEd/Ut/uRjIlP0r/UKuaomUrwpBRg9fC5tXHz1Svwis94
        LeHtohSCU/2j4PfGoQ4uyQFcARltkLeisKRdNgzr+w==
X-Google-Smtp-Source: AGHT+IHIYVkQLwWoPb+88gb1yMyqkYxT1InPOY5PMBoDofZ8kX8dESzReiqpG2SpAsaSdlnLjgyCI6biew8zpQzuFIY=
X-Received: by 2002:adf:f986:0:b0:322:5d58:99b4 with SMTP id
 f6-20020adff986000000b003225d5899b4mr2685547wrr.0.1695839137441; Wed, 27 Sep
 2023 11:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230923013148.1390521-1-surenb@google.com> <20230923013148.1390521-3-surenb@google.com>
 <CAG48ez1N2kryy08eo0dcJ5a9O-3xMT8aOrgrcD+CqBN=cBfdDw@mail.gmail.com> <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com>
In-Reply-To: <03f95e90-82bd-6ee2-7c0d-d4dc5d3e15ee@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 27 Sep 2023 11:25:22 -0700
Message-ID: <CAJuCfpHf6BWaf_k5dBx7mAz49kF5BwBhW_mUxu4E_p2iAy9-iA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] userfaultfd: UFFDIO_REMAP uABI
To:     David Hildenbrand <david@redhat.com>
Cc:     Jann Horn <jannh@google.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
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

On Wed, Sep 27, 2023 at 6:29=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> >> +static int remap_anon_pte(struct mm_struct *dst_mm, struct mm_struct =
*src_mm,
> >> +                         struct vm_area_struct *dst_vma,
> >> +                         struct vm_area_struct *src_vma,
> >> +                         unsigned long dst_addr, unsigned long src_ad=
dr,
> >> +                         pte_t *dst_pte, pte_t *src_pte,
> >> +                         pte_t orig_dst_pte, pte_t orig_src_pte,
> >> +                         spinlock_t *dst_ptl, spinlock_t *src_ptl,
> >> +                         struct folio *src_folio)
> >> +{
> >> +       struct anon_vma *dst_anon_vma;
> >> +
> >> +       double_pt_lock(dst_ptl, src_ptl);
> >> +
> >> +       if (!pte_same(*src_pte, orig_src_pte) ||
> >> +           !pte_same(*dst_pte, orig_dst_pte) ||
> >> +           folio_test_large(src_folio) ||
> >> +           folio_estimated_sharers(src_folio) !=3D 1) {
>
> ^ here you should check PageAnonExclusive. Please get rid of any
> implicit explicit/implcit mapcount checks.

Ack.

>
> >> +               double_pt_unlock(dst_ptl, src_ptl);
> >> +               return -EAGAIN;
> >> +       }
> >> +
> >> +       BUG_ON(!folio_test_anon(src_folio));
> >> +
> >> +       dst_anon_vma =3D (void *)dst_vma->anon_vma + PAGE_MAPPING_ANON=
;
> >> +       WRITE_ONCE(src_folio->mapping,
> >> +                  (struct address_space *) dst_anon_vma);
>
> I have some cleanups pending for page_move_anon_rmap(), that moves the
> SetPageAnonExclusive hunk out. Here we should be using
> page_move_anon_rmap() [or rather, folio_move_anon_rmap() after my cleanup=
s]
>
> I'll send them out soonish.

Should I keep this as is in my next version until you post the
cleanups? I can add a TODO comment to convert it to
folio_move_anon_rmap() once it's ready.

>
> >> +       WRITE_ONCE(src_folio->index, linear_page_index(dst_vma,
> >> +                                                     dst_addr)); >> +
> >> +       orig_src_pte =3D ptep_clear_flush(src_vma, src_addr, src_pte);
> >> +       orig_dst_pte =3D mk_pte(&src_folio->page, dst_vma->vm_page_pro=
t);
> >> +       orig_dst_pte =3D maybe_mkwrite(pte_mkdirty(orig_dst_pte),
> >> +                                    dst_vma);
> >
> > I think there's still a theoretical issue here that you could fix by
> > checking for the AnonExclusive flag, similar to the huge page case.
> >
> > Consider the following scenario:
> >
> > 1. process P1 does a write fault in a private anonymous VMA, creating
> > and mapping a new anonymous page A1
> > 2. process P1 forks and creates two children P2 and P3. afterwards, A1
> > is mapped in P1, P2 and P3 as a COW page, with mapcount 3.
> > 3. process P1 removes its mapping of A1, dropping its mapcount to 2.
> > 4. process P2 uses vmsplice() to grab a reference to A1 with get_user_p=
ages()
> > 5. process P2 removes its mapping of A1, dropping its mapcount to 1.
> >
> > If at this point P3 does a write fault on its mapping of A1, it will
> > still trigger copy-on-write thanks to the AnonExclusive mechanism; and
> > this is necessary to avoid P3 mapping A1 as writable and writing data
> > into it that will become visible to P2, if P2 and P3 are in different
> > security contexts.
> >
> > But if P3 instead moves its mapping of A1 to another address with
> > remap_anon_pte() which only does a page mapcount check, the
> > maybe_mkwrite() will directly make the mapping writable, circumventing
> > the AnonExclusive mechanism.
> >
>
> Yes, can_change_pte_writable() contains the exact logic when we can turn
> something easily writable even if it wasn't writable before. which
> includes that PageAnonExclusive is set. (but with uffd-wp or softdirty
> tracking, there is more to consider)

For uffd_remap can_change_pte_writable() would fail it VM_WRITE is not
set, but we want remapping to work for RO memory as well. Are you
saying that a PageAnonExclusive() check alone would not be enough
here?

Thanks,
Suren.

>
> --
> Cheers,
>
> David / dhildenb
>
