Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD20A76EE06
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 17:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237097AbjHCPZa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 11:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbjHCPZ2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 11:25:28 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E895C358D
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Aug 2023 08:25:26 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so13313a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Aug 2023 08:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691076325; x=1691681125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3i6erIjjtN6lPgXcEJaSwL8Ki+NeE4iek/Jz08H42Eg=;
        b=1/JqHb/LG7PoqyNlz01wER9UTCkrpH9M2FU4Vbd6r/CQI4UW/uMBfpHnxSvH72WDZa
         17EGkY/9+0GvLunkXQuT7Fj49JG1SV574d0CzUHATzQilyCkac+gLSTBBXJIZaVwWa8s
         cpGdP8Hx/x2GWYeMp4ndHvJGpBnn6RxkjNP6yBq0qKblG8zGXopTU7sKzKEIb2z2fZkO
         BdPPCqQxqGQIeeNv0DmWgOhQUsoK2E/MGim7smaG3/IvHHUGhOOYRpcldpDLCveM/scO
         t0H6kHpbTnshhZS2Vd+Rog+eB2YM23VKEVtMN5/XEaDpvaH5k2NGGFIFniZnJgDxkngD
         M2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691076325; x=1691681125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3i6erIjjtN6lPgXcEJaSwL8Ki+NeE4iek/Jz08H42Eg=;
        b=lJTxQL3cvn3VSsqAc7J5BG9Ky11u3YjSkmv9c1JYYwQeB9sG49EHiutt8D6Iyn0Xh9
         +Bxp3o/i6PqVPce9sTUQAuV+oBOfIJOYYu3+Td+luSYtVIYfEc4j2O8y0cmue8FkQR++
         4tzKcctS3Y05+x9fAysUrxbvtVJzLipaS7belE9wl5r2C+4SLhQKjfVbQRcpVW9gzohL
         AEvZ332zCfJZ+xgKsxbSrjpv3mM1Z1vwHVdMB49ngVV96w7AtyHPZdLcmEu903T4w804
         O0UmR5d6TyS9a2oCxDq520PHXdWuj+QaGcsyI7PZJPeH3CDTUzFbSPHa/UprNXGOJAyS
         D4JA==
X-Gm-Message-State: ABy/qLbcCgEvvD8eM9Ed+vvCve6dme8doVAghzKKZbjioHyqwxD1I29T
        zQGZxo0zod8CeMqZHrxwLiP4D69RWNOU3RiVR3ACMg==
X-Google-Smtp-Source: APBJJlHEkuDfzpxiBsrJVo+Ct415MwqYT9+g40+EOyv9eJZgbwZFuwhEjHnaDyGp8XxHI0wEbUXhD/X+RM4zDUX956g=
X-Received: by 2002:a50:8e16:0:b0:51e:16c5:2004 with SMTP id
 22-20020a508e16000000b0051e16c52004mr528078edw.6.1691076325295; Thu, 03 Aug
 2023 08:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230727093637.1262110-1-usama.anjum@collabora.com>
 <20230727093637.1262110-3-usama.anjum@collabora.com> <ZMvDCeUN8qrUmnJV@gmail.com>
In-Reply-To: <ZMvDCeUN8qrUmnJV@gmail.com>
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Date:   Thu, 3 Aug 2023 17:25:13 +0200
Message-ID: <CABb0KFF7K2SHvSwXMheVAgd3VcJf_twuRsc=P-uTJW9HGQcqfA@mail.gmail.com>
Subject: Re: [PATCH v26 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Thu, 3 Aug 2023 at 17:09, Andrei Vagin <avagin@gmail.com> wrote:
> On Thu, Jul 27, 2023 at 02:36:34PM +0500, Muhammad Usama Anjum wrote:
[...]
> > +     n_pages =3D (*end - addr) / PAGE_SIZE;
> > +     if (check_add_overflow(p->found_pages, n_pages, &total_pages) ||
> > +         total_pages > p->arg.max_pages) {
>
> why do we need to use check_add_overflow here?
>
> > +             size_t n_too_much =3D total_pages - p->arg.max_pages;
>
> it is unsafe to use total_pages if check_add_overflow returns non-zero.

Since we're adding unsigned integers, this is well defined even after overf=
low.

Best Regards
Micha=C5=82 Miros=C5=82aw
