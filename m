Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3AD33C697
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Mar 2021 20:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhCOTOC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Mar 2021 15:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhCOTNp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Mar 2021 15:13:45 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635E7C06174A;
        Mon, 15 Mar 2021 12:13:45 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id e19so68266462ejt.3;
        Mon, 15 Mar 2021 12:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8qEOkKhwQbkxiaXP+ET3E50R00QFcMPFpL5ciT7yT2k=;
        b=iMJIoGAIXDjtSWFph7/xZWaO0KgCXh2khhFmEXwV1p5D3L1JORup4xY89kDngh6+CE
         tGPnz0cZqsH3rADcYPQm3yC4aPD3S6ZUeYr6hze0VdGUAeP6kINCsa6YWsDys6lqFunF
         A5s/g0BGmPuF8IvGy7uRTsTp1FDfdmWLDgtynl3+ZzoA/pEtp8SKOXNop1QOR48vzXvC
         MertbfiPuo0GAtrtnlxKfXFYoBgQvRgfEkkh8e3Wqf8o3Qh4NeRiN/HThzAHBKtvLdZ+
         TjXrcjoyjPfWTD+3uCUSTv0OJ/UwJ78H3MlgBlGbO6PMpWG2nbV+6W3PV6FxAVLHvM7+
         Vfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8qEOkKhwQbkxiaXP+ET3E50R00QFcMPFpL5ciT7yT2k=;
        b=rEKcoM0p4fmk2tgxheBHw1QLUbJ2rHYVnkYHSoaGLdlp134Zwa23XhMGpUT9dMFW1X
         m+7XnTgFbtK+muLvqd3Ee7vkRXZhrUNLZtMfYZfE/WfWc8FJ33Jr/x6IGFEtPwDroh5s
         dyROl68Pnh1Xr7yS3z9mA9Ne/NnpTlTdHj0ZyDYp8MV2v3q3ZnT74xQAOCeZe68/EudK
         IQFuNxEL1/AEtpKjTzmlWrlaXxlvhijwLp5z1nBWSg5N+SenAUfPlDGIqHTR/xARtaIV
         eiXaT09qt/tcHZdjz+35ZlSY87vk1Rn56kkuyIuvkImaqePBSznMV2Gl1I7P1wmIuMvK
         1KrA==
X-Gm-Message-State: AOAM530+TyT0ibwxs9CQfZ+VxXSCWwjCIg6OVm/s30A/VLpqBf+WPQDc
        02v4Ryv+vsag/KlvmPDZoMdccH2n6ftCuCqnvxY=
X-Google-Smtp-Source: ABdhPJwKQtdZQiYSw5cMrPvlDg91AxqsCaYoclTOCFQWgemokJwVy2XqGjqttPRYkoj+YTOYFrDNCiQU1mLMUR/vEOY=
X-Received: by 2002:a17:906:bcfc:: with SMTP id op28mr25039371ejb.238.1615835624119;
 Mon, 15 Mar 2021 12:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210312005712.116888-1-zi.yan@sent.com> <20210315120748.nuw5vk6grmfacact@box>
 <D3A202E7-6F74-4937-A160-199032E15AC4@nvidia.com>
In-Reply-To: <D3A202E7-6F74-4937-A160-199032E15AC4@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 15 Mar 2021 12:13:32 -0700
Message-ID: <CAHbLzkqQTTf1YZu0nkYyWfKR0+kQD6FzVYzT-r6gdf3uTCTk+g@mail.gmail.com>
Subject: Re: [PATCH v3] mm: huge_memory: a new debugfs interface for splitting
 THP tests.
To:     Zi Yan <ziy@nvidia.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Mika Penttila <mika.penttila@nextfour.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 15, 2021 at 11:37 AM Zi Yan <ziy@nvidia.com> wrote:
>
> On 15 Mar 2021, at 8:07, Kirill A. Shutemov wrote:
>
> > On Thu, Mar 11, 2021 at 07:57:12PM -0500, Zi Yan wrote:
> >> From: Zi Yan <ziy@nvidia.com>
> >>
> >> We do not have a direct user interface of splitting the compound page
> >> backing a THP
> >
> > But we do. You expand it.
> >
> >> and there is no need unless we want to expose the THP
> >> implementation details to users. Make <debugfs>/split_huge_pages accep=
t
> >> a new command to do that.
> >>
> >> By writing "<pid>,<vaddr_start>,<vaddr_end>" to
> >> <debugfs>/split_huge_pages, THPs within the given virtual address rang=
e
> >> from the process with the given pid are split. It is used to test
> >> split_huge_page function. In addition, a selftest program is added to
> >> tools/testing/selftests/vm to utilize the interface by splitting
> >> PMD THPs and PTE-mapped THPs.
> >>
> >
> > Okay, makes sense.
> >
> > But it doesn't cover non-mapped THPs. tmpfs may have file backed by THP
> > that mapped nowhere. Do we want to cover this case too?
>
> Sure. It would be useful when large page in page cache too. I will send
> v4 with tmpfs THP split. I will definitely need a review for it, since
> I am not familiar with getting a page from a file path.

We do have some APIs to return pages for a file range, i.e.

find_get_page
find_get_pages
find_get_entries
find_get_pages_range

They all need address_space, so you need to convert file path to
address_space before using them.

The hole punch of tmpfs uses find_get_entries(), just check what
shmem_undo_range() does.

>
> > Maybe have PID:<pid>,<vaddr_start>,<vaddr_end> and
> > FILE:<path>,<off_start>,<off_end> ?
>
> Or just check input[0] =3D=3D =E2=80=98/=E2=80=98 for file path input.
>
>
> =E2=80=94
> Best Regards,
> Yan Zi
