Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8166DA967
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Apr 2023 09:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjDGHYY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Apr 2023 03:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239674AbjDGHYW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Apr 2023 03:24:22 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20480900F
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Apr 2023 00:24:20 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id cw23so6607065ejb.12
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Apr 2023 00:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680852258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kshOPFJfjBG6SX0RPJIED8tn+j6nke6HbR8Ev65KzHg=;
        b=e9YSrHu8QfotxaTp0VSJrOYN8lvoaNBzYB1yE1FND2Mew00Kvx1zEtD8Kmu57MKHsr
         F18FA4woc2StB2z5UQnQh/yb4pesTpJIk139MbLhz3VxRcvTngFFfZ++pa7hOc4NB9Kr
         PXR2G38oHc2SfmP+aKPAex1cJJGAPhA52Cudtv4juAil5pWu7QV4r4UQkhJXcxJFz4CS
         IK2+PO1U0GlT4ewKtSDc0GIUP/DyWZqGpOtMoGA4OUlqMZQo4DTHiPxnEfi2ZP5UAyd9
         EBZnlZKv+FfeSeZxDXJtEe+by7dpmrkvLCxJdX0u56z4aAJGt+S77YFrDqxoWVRt5NQk
         hrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680852258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kshOPFJfjBG6SX0RPJIED8tn+j6nke6HbR8Ev65KzHg=;
        b=cAovvsESUrNe6x+LEnk+NrrbwMJKwcglDIXKSsd4XIPzxuve+q59ESeaWCZakwjzrE
         bW5d9r4CfgftRboHSDDuA4T4hTEJpfe++e5XuDLPgzfBpZcHWV7ucD8j9R1xyyeSxgzA
         xupKFz9k6WGJfdcvXJTstEFVbiRtf5KyhtXn/oujc0Z+zvd2lW/2sXCfFUgnSIjzxpr9
         QhxgO2KZ+mm37FGO9L+HOs5sMBmVMIQr0RGCdlK6CNTGUZTdLnzNOf9xOPPMxAaMmIXg
         XZwNzr1avpnwrtkzUeDjeN+eZGHnlClMddpZUfeXoPmDgLzTvbBWlCVPnkS2WfE3MCz+
         EZ2A==
X-Gm-Message-State: AAQBX9d4/r/ictPYPxo2szZKu/IcpZpD8u3dleYbYBCKgA1ITxdJ3vLE
        0vYytGpiXCqFCLDaUeasplBnuutQVBTN/EAVGcqv1aob8ICnqOUwTzFaOB5H
X-Google-Smtp-Source: AKy350Z+HM2JQIElrXH+tranSxHGmwPxG7Kcw1s9qWFBSYaElU2RfJUIJoVCyc7GhnBwrECWa+fSX/N0dWNEYF5+JpE=
X-Received: by 2002:a50:cd01:0:b0:501:d3a2:b4ae with SMTP id
 z1-20020a50cd01000000b00501d3a2b4aemr470507edi.7.1680852246994; Fri, 07 Apr
 2023 00:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230406074005.1784728-1-usama.anjum@collabora.com>
 <20230406074005.1784728-3-usama.anjum@collabora.com> <CABb0KFFTb3LCbyPWLSodtntw=tizYki-pc4nSHBmQOFhKoNYfA@mail.gmail.com>
 <b737dceb-a228-7ffe-0758-421505f1a61d@collabora.com>
In-Reply-To: <b737dceb-a228-7ffe-0758-421505f1a61d@collabora.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Fri, 7 Apr 2023 09:23:55 +0200
Message-ID: <CABb0KFF+sKSv7jdxBbXpt5A2WO83tKb9viq-kKurXN_e1VcFhQ@mail.gmail.com>
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

On Thu, 6 Apr 2023 at 23:12, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
> On 4/7/23 1:12=E2=80=AFAM, Micha=C5=82 Miros=C5=82aw wrote:
> > On Thu, 6 Apr 2023 at 09:40, Muhammad Usama Anjum
> > <usama.anjum@collabora.com> wrote:
> > [...]
> >> --- a/fs/proc/task_mmu.c
> >> +++ b/fs/proc/task_mmu.c
> > [...]
> >> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
> >> +                                 unsigned long end, struct mm_walk *w=
alk)
> >> +{
[...]
> >> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >> +       ptl =3D pmd_trans_huge_lock(pmd, vma);
> >> +       if (ptl) {
> > [...]
> >> +               return ret;
> >> +       }
> >> +process_smaller_pages:
> >> +       if (pmd_trans_unstable(pmd))
> >> +               return 0;
> >
> > Why pmd_trans_unstable() is needed here and not only after split_huge_p=
md()?
> I'm not entirely sure. But the idea is if THP is unstable, we should
> return. As it doesn't seem like after splitting THP can be unstable, we
> should not check it. Do you agree with the following?

The description of pmd_trans_unstable() [1] seems to indicate that it
is needed only after split_huge_pmd().

[1] https://elixir.bootlin.com/linux/v6.3-rc5/source/include/linux/pgtable.=
h#L1394

Best Regards
Micha=C5=82 Miros=C5=82aw
