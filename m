Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF11738583
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 15:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjFUNmg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 09:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjFUNme (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 09:42:34 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EAD199A
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Jun 2023 06:42:32 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so3213a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Jun 2023 06:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687354951; x=1689946951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acPAMDZruYemX8TV6cTFFhShCBAic/MFb6BfUxW/eJ8=;
        b=sIctj19+4iS+N71smDAtyzFiXlzPZiOW+G6z39xane6Zv//qrUMsCz6nAa7J6rV7AC
         b9Jkx0V70uzOFA8gjwzskpQqkQ4Ukl3fYwTxBHAEaFMtCEOImHM7hEt+2d/UvfLorHs0
         4E1pwirARjhBK//tyNLrThGOxKwhf8L7gVbhpGvtGoDCGkas9ROaw3nofqrra8OREG1m
         aC+ioXYVUWJA9heR/2mhaSbQMckdie99gPv4K3MUVGFZVhmZLWUa4UscoMWhoa08jzae
         PCAeOpYXF+j2zdZD0b/8Q/x7fn08yK7Tm3Q0H2oFC/DCBLrlrhJpxBsjUT9YlpgTarMt
         d/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687354951; x=1689946951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acPAMDZruYemX8TV6cTFFhShCBAic/MFb6BfUxW/eJ8=;
        b=eQtIQbhQ7nI6LTnbbtaNZ6FqPhOqKX+7+fJsqm7NZIbt2AH8B7Tfb5H17eSYag69Sl
         /bCji3UtQf27MKjFkLDs4oD9JoVFrYvRfjM35gL+7BRXUjk2YtYpV4sWCah+xO902VLD
         9LZYpLh+130nhOOFHR2oKSY8dYU0vy4jgz1pJRFnU8JzTNOo1AA8K1opTI1wy5hsbzw6
         vQ4WQZ+ReOkrYw/2WpdosBcTNYEQAPbw06rVRyMNVSUg+p1g6P2VCKhOv53OPSW3/naJ
         QAkNp5TwQRWVTuKuBPHs2oxt7a2e1WPnAfW6ONKV4kiJCQzAS1uWr44tVkjPWodE1BkF
         /2HQ==
X-Gm-Message-State: AC+VfDydZkG38hvTJpI4TBfj4LUWl6X5UKOmAoZAdH849a6KpGhGwf0D
        o0+2YUD4bzi0nEIsqxgDnLfYOdA4mKkgIt2q0KYaFg==
X-Google-Smtp-Source: ACHHUZ5UHF11eJAlQXvvGM7fzyvA2yQYbNg05LXVZvb+ql5FzKqus823wT1co33vViD1konnn7jxrblfw3QsQIOgWL8=
X-Received: by 2002:a50:d59a:0:b0:51a:1fd1:952f with SMTP id
 v26-20020a50d59a000000b0051a1fd1952fmr632263edi.1.1687354951319; Wed, 21 Jun
 2023 06:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230621072404.2918101-1-usama.anjum@collabora.com> <20230621072404.2918101-3-usama.anjum@collabora.com>
In-Reply-To: <20230621072404.2918101-3-usama.anjum@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Wed, 21 Jun 2023 15:42:20 +0200
Message-ID: <CABb0KFGhSLAHAsa3nk-pyMe2j9MU4u3xkQR21HOoS65ZB2dKsw@mail.gmail.com>
Subject: Re: [PATCH v20 2/5] fs/proc/task_mmu: Implement IOCTL to get and
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 21 Jun 2023 at 09:24, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
[...]
> +static int pagemap_scan_test_walk(unsigned long start, unsigned long end=
,
> +                                 struct mm_walk *walk)
> +{
> +       struct pagemap_scan_private *p =3D walk->private;
> +       struct vm_area_struct *vma =3D walk->vma;
> +
> +       if ((p->flags & PM_SCAN_REQUIRE_UFFD) && (!userfaultfd_wp_async(v=
ma) ||
> +           !userfaultfd_wp_use_markers(vma)))
> +               return -EPERM;
> +
> +       if (vma->vm_flags & VM_PFNMAP)
> +               return 1;
> +
> +       return 0;
> +}

This could actually short-circuit all vma flags (e.g. IS_FILE): if
(required_mask & IS_FILE && vma is not file-backed) return 0;

Best Regards
Micha=C5=82 Miros=C5=82aw
