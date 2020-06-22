Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5013B2044CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jun 2020 01:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbgFVXzP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 19:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730227AbgFVXzO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 19:55:14 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED98BC061573;
        Mon, 22 Jun 2020 16:55:13 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p20so19700983ejd.13;
        Mon, 22 Jun 2020 16:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NjMcZXprv/nOI4forFhKBTk/9F1/kItqecbA0f3zzT8=;
        b=MK3YZsIqGYoDjbxLtQy2a2wo4ruMmS1w9QUl9/b2H1N34YqISWMm4seVahEk6vXpOI
         SgBWMKclzauV/+pl9tGCeOaTNW0t2+0vC53zrCUIN6UO6sMVq+xOis8Nnm32NMx8suxR
         UhCmTiQTZQhtWbpw2vcER4mouZPvsT8VZEXNEeATbbrxzozgbjOPBthCdAw+infZucxe
         zkUG4Enjj+ZXGXRDXzuhcOIhk127PUmHwYCqIOvVFSxdxnzVTp8DEZ/aH2mR5XH5+Ans
         xmUT27IlXZQdKBsq/7FrGNFly2GxAGf/6aYN5rJVJtKl2tow0KSBSoBWJGhErIvYIYDX
         NbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NjMcZXprv/nOI4forFhKBTk/9F1/kItqecbA0f3zzT8=;
        b=iz8GU/l3NxK4TsbnTMNwgaDarjy1L9LOGjCR1pcHIW/nTG4WNpeeE7TAhYUbu6wuCm
         j+cbnoAsfvgJzEeTObyt4Q2DpldZl23ZdnDwMO3kYK7W6BxSGnzTA6x1TLX915SDrhYg
         wLpoxne/F6L6EHOME3y+DuGZlJ8lnHZXpsDgmG9DAD5FUggUq0B6OeaSZJs0PhR6vClK
         QycyLbO+3gtBloZl3ItHDLLrqlBE9WMoj9qtvvm2eVqBbre9ytmQuMXPRYRuUhuuRih6
         bCNDbByNXWAJmDgDhIyYA45mlHwdJ4c8oRMvj36BIWUzBjJs/NA8IwHO0fz/V6NR4NFB
         A/uw==
X-Gm-Message-State: AOAM530HVXwuEnhUsIEiN6Mn6VPfp0ajpHrXzUrEeEBvx1WidJPfkSt9
        OLgH+2G1IBsF8ewUrsocW+J1umsjnbzATn8s0xY=
X-Google-Smtp-Source: ABdhPJwQzUdtQVA8N+epe6jO74BqD4xLZlDw/rWnWRA1sAy4igezZryH7Kv9srM9ru85/edGlgH35lOeiLAECSYhKcc=
X-Received: by 2002:a17:906:2b81:: with SMTP id m1mr17303645ejg.488.1592870112660;
 Mon, 22 Jun 2020 16:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200619215649.32297-1-rcampbell@nvidia.com> <20200619215649.32297-14-rcampbell@nvidia.com>
 <F1872509-3B1F-4A8A-BFF5-E4D44E451920@nvidia.com> <b6eed976-c515-72d6-a7be-2296cab8f0d4@nvidia.com>
 <C7BEB563-3698-442C-A188-1B66CBE4CF63@nvidia.com> <a5f502f8-70cd-014b-8066-bbaeb8024a29@nvidia.com>
 <4C364E23-0716-4D59-85A1-0C293B86BC2C@nvidia.com> <CAHbLzkqe50+KUsRH92O4Be2PjuwAYGw9nK+d-73syxi2Xnf9-Q@mail.gmail.com>
 <CAHbLzko=BqtPhxgf7f1bKKqoQxK9XCCPdp4YdL80K_uXFfcETQ@mail.gmail.com> <fa056e5e-ca87-aef1-e66e-58e8ebe5403e@nvidia.com>
In-Reply-To: <fa056e5e-ca87-aef1-e66e-58e8ebe5403e@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 22 Jun 2020 16:54:45 -0700
Message-ID: <CAHbLzkrR4-s+ye1F3XDV_0q+iyZOcyMQNHTggDY3Mn_e2yOZ7g@mail.gmail.com>
Subject: Re: [PATCH 13/16] mm: support THP migration to device private memory
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Zi Yan <ziy@nvidia.com>, Ralph Campbell <rcampbell@nvidia.com>,
        nouveau@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 22, 2020 at 4:02 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2020-06-22 15:33, Yang Shi wrote:
> > On Mon, Jun 22, 2020 at 3:30 PM Yang Shi <shy828301@gmail.com> wrote:
> >> On Mon, Jun 22, 2020 at 2:53 PM Zi Yan <ziy@nvidia.com> wrote:
> >>> On 22 Jun 2020, at 17:31, Ralph Campbell wrote:
> >>>> On 6/22/20 1:10 PM, Zi Yan wrote:
> >>>>> On 22 Jun 2020, at 15:36, Ralph Campbell wrote:
> >>>>>> On 6/21/20 4:20 PM, Zi Yan wrote:
> >>>>>>> On 19 Jun 2020, at 17:56, Ralph Campbell wrote:
> ...
> >>> Ying(cc=E2=80=99d) developed the code to swapout and swapin THP in on=
e piece: https://lore.kernel.org/linux-mm/20181207054122.27822-1-ying.huang=
@intel.com/.
> >>> I am not sure whether the patchset makes into mainstream or not. It c=
ould be a good technical reference
> >>> for swapping in device private pages, although swapping in pages from=
 disk and from device private
> >>> memory are two different scenarios.
> >>>
> >>> Since the device private memory swapin impacts core mm performance, w=
e might want to discuss your patches
> >>> with more people, like the ones from Ying=E2=80=99s patchset, in the =
next version.
> >>
> >> I believe Ying will give you more insights about how THP swap works.
> >>
> >> But, IMHO device memory migration (migrate to system memory) seems
> >> like THP CoW more than swap.
>
>
> A fine point: overall, the desired behavior is "migrate", not CoW.
> That's important. Migrate means that you don't leave a page behind, even
> a read-only one. And that's exactly how device private migration is
> specified.
>
> We should try to avoid any erosion of clarity here. Even if somehow
> (really?) the underlying implementation calls this THP CoW, the actual
> goal is to migrate pages over to the device (and back).
>
>
> >>
> >> When migrating in:
> >
> > Sorry for my fat finger, hit sent button inadvertently, let me finish h=
ere.
> >
> > When migrating in:
> >
> >          - if THP is enabled: allocate THP, but need handle allocation
> > failure by falling back to base page
> >          - if THP is disabled: fallback to base page
> >
>
> OK, but *all* page entries (base and huge/large pages) need to be cleared=
,
> when migrating to device memory, unless I'm really confused here.
> So: not CoW.

I realized the comment caused more confusion. I apologize for the
confusion. Yes, the trigger condition for swap/migration and CoW are
definitely different. Here I mean the fault handling part of migrating
into system memory.

Swap-in just needs to handle the base page case since THP swapin is
not supported in upstream yet and the PMD is split in swap-out phase
(see shrink_page_list).

The patch adds THP migration support to device memory, but you need to
handle migrate in (back to system memory) case correctly. The fault
handling should look like THP CoW fault handling behavior (before
5.8):
    - if THP is enabled: allocate THP, fallback if allocation is failed
    - if THP is disabled: fallback to base page

Swap fault handling doesn't look like the above. So, I said it seems
like more THP CoW (fault handling part only before 5.8). I hope I
articulate my mind.

However, I didn't see such fallback is handled. It looks if THP
allocation is failed, it just returns SIGBUS; and no check about THP
status if I read the patches correctly. The THP might be disabled for
the specific vma or system wide before migrating from device memory
back to system memory.

>
> thanks,
> --
> John Hubbard
> NVIDIA
