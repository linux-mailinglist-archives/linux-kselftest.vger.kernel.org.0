Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045DD7652B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 13:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjG0Lkv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 07:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjG0Lks (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 07:40:48 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FD5271F
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 04:40:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbd33a1819so57855e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 04:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690458042; x=1691062842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ph+T+bMJj5qPDZ5PD7H/7htn5wjLlAl0f0VpKLrvh6M=;
        b=Hkxkwm02Od+vXqQN98JCAu61H1aNjPJs2zWZs6eEprDoT7GUpW3cvPh9/GCBEoiWJv
         ADkiPRNFo1/2PKKMmAndwoKPh+rjvAOwLlEtuyZbaJG90u2GOk0cLoyPhX0xwxiJCbKX
         pHV3eJRPsqxXCpiBCKqJN+8YmH8osH4l2sh+1Fd9XsFf0M+vAI4G+nrK0VgrDEn+ECtu
         rxL+CHHQ8HWUye2yzC54EOszbNX/VdBOEmWTBMDNwDoZo2E6RlJWqbZtyn0bcxfmTgV0
         542RVvI83Yr0K/WopxZlNaETzSn8ELkPQaUHdiTt5xg0oF22UaCJy11CwE66aV9yhu/5
         3o5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690458042; x=1691062842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ph+T+bMJj5qPDZ5PD7H/7htn5wjLlAl0f0VpKLrvh6M=;
        b=Ci748VzWm8G2xUF27K1ifM4ETNOlZlXV1X9dzVrhQDGCOmKydypcRHd0xEKbXSIUIl
         LWVzmRleeRAv2z7X9iwp7WXiKhclhcBQchud4usmshO8yDyW8vGz4hLgnEZ1DIhcla0p
         SW6pDDXRJ40FPkw1jwdRGZQEMbyGBXzEyxsBLhGvzUegmJ3Qd57cn9TJbCydTwyvV8w7
         rLSoXFDzhLob4+2/BFWyeJBbYBVTCcmloPn7jLo7kHAdvSZByjPkYwYINOzzT11k42vZ
         grXCvNn58Ac+Vda5bsssaCfX9PpB6A/jzGsdDBejb0WkdaDALAwSR8PdTaimY6p361nx
         9msQ==
X-Gm-Message-State: ABy/qLYF1nUDmIzIpf2Bh0Y3oFTH3wFZxzlelx8/E78E873WL1ipoD92
        qds05I/kLYb5DGjHp805EJ2HJNJad+vN1SuG/WZYqA==
X-Google-Smtp-Source: APBJJlGwCp+6u1RpzRTossFaboM1iyX+LT63lVnVimEXhyrxu43sILR/KnygiHidSJUVZBmyzkf2aC+fg1HsHe2Aw94=
X-Received: by 2002:a05:600c:6023:b0:3fd:e15:6d5 with SMTP id
 az35-20020a05600c602300b003fd0e1506d5mr94340wmb.2.1690458042138; Thu, 27 Jul
 2023 04:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230727093637.1262110-1-usama.anjum@collabora.com> <20230727093637.1262110-3-usama.anjum@collabora.com>
In-Reply-To: <20230727093637.1262110-3-usama.anjum@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Thu, 27 Jul 2023 13:40:30 +0200
Message-ID: <CABb0KFFtjTve+uM=CTPChzUbJvJ=Tr3Q8espo_Rr_hutZPPAiw@mail.gmail.com>
Subject: Re: [PATCH v26 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 27 Jul 2023 at 11:37, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
> This IOCTL, PAGEMAP_SCAN on pagemap file can be used to get and/or clear
> the info about page table entries. The following operations are supported
> in this ioctl:
> - Get the information if the pages have Async Write-Protection enabled
>   (``PAGE_IS_WPALLOWED``), have been written to (``PAGE_IS_WRITTEN``), fi=
le
>   mapped (``PAGE_IS_FILE``), present (``PAGE_IS_PRESENT``), swapped
>   (``PAGE_IS_SWAPPED``) or page has pfn zero (``PAGE_IS_PFNZERO``).
> - Find pages which have been written to and/or write protect
>   (atomic ``PM_SCAN_WP_MATCHING + PM_SCAN_CHECK_WPASYNC``) the pages
>   atomically. The (``PM_SCAN_WP_MATCHING``) is used to WP the matched
>   pages. The (``PM_SCAN_CHECK_WPASYNC``) aborts the operation if
>   non-Async-Write-Protected pages are found. Get is automatically perform=
ed
>   if output buffer is specified.
>
> This IOCTL can be extended to get information about more PTE bits. The
> entire address range passed by user [start, end) is scanned until either
> the user provided buffer is full or max_pages have been found.
>
> Reviewed-by: Andrei Vagin <avagin@gmail.com>
> Reviewed-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Thanks for all the work!

Small request below.

> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
[...]
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static unsigned long pagemap_thp_category(pmd_t pmd)
> +{
> +       unsigned long categories =3D 0;
> +
> +       if (pmd_present(pmd)) {
> +               categories |=3D PAGE_IS_PRESENT;
> +               if (!pmd_uffd_wp(pmd))
> +                       categories |=3D PAGE_IS_WRITTEN;
> +               if (is_zero_pfn(pmd_pfn(pmd)))
> +                       categories |=3D PAGE_IS_PFNZERO;
> +       } else if (is_swap_pmd(pmd)) {
> +               categories |=3D PAGE_IS_SWAPPED;
> +               if (!pmd_swp_uffd_wp(pmd))
> +                       categories |=3D PAGE_IS_WRITTEN;
> +       }
> +
> +       return categories;
> +}
[...]
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
> +#ifdef CONFIG_HUGETLB_PAGE
> +static unsigned long pagemap_hugetlb_category(pte_t pte)
> +{
> +       unsigned long categories =3D 0;
> +
> +       if (pte_present(pte)) {
> +               categories |=3D PAGE_IS_PRESENT;
> +               if (!huge_pte_uffd_wp(pte))
> +                       categories |=3D PAGE_IS_WRITTEN;
> +               if (!PageAnon(pte_page(pte)))
> +                       categories |=3D PAGE_IS_FILE;
> +               if (is_zero_pfn(pte_pfn(pte)))
> +                       categories |=3D PAGE_IS_PFNZERO;
> +       } else if (is_swap_pte(pte)) {
> +               categories |=3D PAGE_IS_SWAPPED;
> +               if (!pte_swp_uffd_wp_any(pte))
> +                       categories |=3D PAGE_IS_WRITTEN;
> +       }
> +
> +       return categories;
> +}

Could you add PAGE_IS_HUGE for THP and HugeTLB pages? This would help
maintaining checkpointed process'es page sizes by CRIU when THP is
used.

Best Regards
Micha=C5=82 Miros=C5=82aw
