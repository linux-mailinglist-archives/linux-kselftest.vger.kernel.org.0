Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C28A6DA25F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 22:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjDFUMT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 16:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjDFUMS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 16:12:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAE3B0
        for <linux-kselftest@vger.kernel.org>; Thu,  6 Apr 2023 13:12:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id j22so4126141ejv.1
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Apr 2023 13:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680811935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfXQEoCgBqadpu6FRThsZsy1nkY1OVsi1rMIvATBeoI=;
        b=eLh2M2ox7ujSVvQ6g9xvjw/WemChY3P4HRSOdHrdgai9GlQKCSmP0BGwnq2lSAjYEP
         Fapb2AbNv5Gfj16ljxDNnlAMyzI5zF8Gopik9TnFJMJrPhvTMNEQSsUPsivu74u7bYBh
         PVi8jp/K5KOpIq2YvkU+sUAuMuZutnSno/fRPjRnq+3Znlb1v3jpvhteI4OL0vRVE4fX
         Of4a8TIzoVa5/AykJda6kyFA0VO9w3Wul3dP+No2oOAG+TUCa2d9G+ytndgPJ0y1Qqs6
         bm09CvYM1UsyGT0YIHH82BvLeQ/dp5BFc+bZLy6J7hbPX/WK/sxIQoDiBcjt9kf3j8cf
         1ijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680811935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfXQEoCgBqadpu6FRThsZsy1nkY1OVsi1rMIvATBeoI=;
        b=rXBCrsIxyxjUi2M1ft0mjLef7RLvDSn2NvN6N34xoQEo31ckG4XqDAY+SUaa0hsit+
         NSCDi0dzxY2xfnFP6QkRbS4GK0E6myDbo8Zdd+OEkl8RiP/kDzhVCREB9iiJuMdJCRxt
         rJadcgyLdW9GuJlMzocfc2WCQVVogffJUoGLQFd2W1QMJGrAIHSPfuHzx5LW+NP+Fe2P
         BFzEJUqSPE/1o0qz6hflbVpzU/uiQ6Z9AvitjAa2j8/CfaadFbSdAAjNiDoOZlzBvgjJ
         eg1ilh05az4bzKCjN7jfFYY+ABJO4iMwfqCk66uVKKXHRH7X/4NOesrEdZWkduxcX4uY
         ljHQ==
X-Gm-Message-State: AAQBX9fZkC1lCJj8dYUcEC7DH0pHd8Nk+3W0zamNBwC9g8TN42q9drid
        tB7tDSeyMmQiKdiGbkKq7+j9xy2kI0M4NPgTs3Dj6Q==
X-Google-Smtp-Source: AKy350YWTiBKhF69rS3s7/XUdyc2hKHku2MPzilut5tCz5P9UctIFCxaz2a8OpRCWENJH0p1saUwx/M1YK9rBFquknE=
X-Received: by 2002:a17:906:138c:b0:93e:186f:ea0d with SMTP id
 f12-20020a170906138c00b0093e186fea0dmr22597ejc.15.1680811935410; Thu, 06 Apr
 2023 13:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230406074005.1784728-1-usama.anjum@collabora.com> <20230406074005.1784728-3-usama.anjum@collabora.com>
In-Reply-To: <20230406074005.1784728-3-usama.anjum@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Thu, 6 Apr 2023 22:12:03 +0200
Message-ID: <CABb0KFFTb3LCbyPWLSodtntw=tizYki-pc4nSHBmQOFhKoNYfA@mail.gmail.com>
Subject: Re: [PATCH v12 2/5] fs/proc/task_mmu: Implement IOCTL to get and
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
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 6 Apr 2023 at 09:40, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
[...]
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
[...]
> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
> +                                 unsigned long end, struct mm_walk *walk=
)
> +{
> +       struct pagemap_scan_private *p =3D walk->private;
> +       bool is_written, is_file, is_present, is_swap;
> +       struct vm_area_struct *vma =3D walk->vma;
> +       unsigned long addr =3D end;
> +       spinlock_t *ptl;
> +       int ret =3D 0;
> +       pte_t *pte;
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +       ptl =3D pmd_trans_huge_lock(pmd, vma);
> +       if (ptl) {
[...]
> +               return ret;
> +       }
> +process_smaller_pages:
> +       if (pmd_trans_unstable(pmd))
> +               return 0;

Why pmd_trans_unstable() is needed here and not only after split_huge_pmd()=
?

Best regards
Micha=C5=82 Miros=C5=82aw
