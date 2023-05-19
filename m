Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52496709E37
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 19:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjESRdS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 13:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjESRdQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 13:33:16 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E341110D2
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 10:32:51 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-6238386eb9cso28683076d6.1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 10:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684517569; x=1687109569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28CIrmSeW20zxT1lrEW3DjvASU36Pu1EBFA82UM2iKs=;
        b=1Iyutpx1ohuULHbEgEiXeeQ1FIPdxRvYDFE5PYOWHG5EX1xjrOwlqkkaUlN+7l8TzD
         szXzmjvzth53x9OKnK+vbmrjVx2S/TQI1MVGqVpSZJ6b50XxZ57wRuiglgYZ5X3eElYM
         U14n6OeUEtrMvHAiSeRKLqNhiYLDX4PpmHF0WSYKVa/jqWU52r+Q6mf2TnlXpKAu/tEt
         Cd3PRltGv5+jf/a0H2dXDXUz2W4VV/N4y5oyaMzn8RMP5DPh7hhH1kRhUsQ+MO6KgFPN
         aEYdn0/kvp6XECDLQmzu/PZqZYwMJLAqGKgQOeoR4Xk0MlAFFTRUeMpzldu9/WztkDu1
         iU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684517569; x=1687109569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28CIrmSeW20zxT1lrEW3DjvASU36Pu1EBFA82UM2iKs=;
        b=Nskj336yecCmYRmJZBR5OE90yc8ddQfasM/rnPOwy44eHnscj6xGfJi2omf03iNgJE
         2RLZMgLXw9fpe8XiFosMEEvoVe8+bK/rG+4zjshL3RvPkRI6N19GKZfORJpKE4KeKNkg
         n94+BRtGafhFsSa9yZZtVh7c5XerToKhm2gddQ/Dvoevn8BjJbRMAc5A1EP9V9TgVRUP
         KPkFasK3S8rjg/mz4Zd00+PCzJ6QQeaSZbfxyl2o36aHK075MuQRGI8Za0XQnmcUGA1Y
         2UigMrSh1JQxuCTH8VzvQgpOemIKPp5xmcBYldND6Z1dSGfPyBKR5+WhL0MNAryvuFwC
         Fv2w==
X-Gm-Message-State: AC+VfDzcQn/fU3rmL+rT7E0OSeEjiJdvZFNYsGiVAVMpJXzJZ7MbUjyE
        e8LvTpajRuKL4IPY2Q95U00XDzpQnxtUExSG+IFnlA==
X-Google-Smtp-Source: ACHHUZ5W2Po65BFI15eOheYTJXgbEStDZirigUQta6i+5d+3xwpd1LAe8DNgWb3cpBxGrqqPIWfWd9RLNhg+JZrFyKw=
X-Received: by 2002:a05:6214:416:b0:621:7d4:e059 with SMTP id
 z22-20020a056214041600b0062107d4e059mr6079776qvx.10.1684517569077; Fri, 19
 May 2023 10:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230511182426.1898675-1-axelrasmussen@google.com>
 <CADrL8HXFiTL-RDnETS2BUg_qH8CvcCMZiX-kutsrS1-8Uy25=w@mail.gmail.com>
 <ZGVRUeCWr8209m8d@x1n> <ZGVTMnVKNcQDM0x4@x1n> <CAJHvVcgXynHcuoS6eCfOAB2SgzqYy_zMGrRMR2kFuxOtSdUwvQ@mail.gmail.com>
 <CACw3F52MNOVv6KA5n7wRYDT2ujwYkco=aYngbo-zGA3zW1yq+w@mail.gmail.com>
 <ZGZMtK6PzoTuLZ1b@x1n> <CAJHvVcgcYPu-G3RDVrkrM_J48NUiUY0SH0G1sd+=X9BDgnQEuQ@mail.gmail.com>
 <32fdc2c8-b86b-92f3-1d5e-64db6be29126@redhat.com> <CACw3F50qvf13-fUx4XrL1jkhbo2mQ5sPV=E_i7_Gt2NaWXJfnQ@mail.gmail.com>
 <ZGehyTCtAtTneiE8@x1n>
In-Reply-To: <ZGehyTCtAtTneiE8@x1n>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 19 May 2023 10:32:13 -0700
Message-ID: <CAJHvVcgVcGigruVdCyOZ2gyrOMboHjuMBwyx9+9LFiv_xH2Q5A@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: userfaultfd: add new UFFDIO_SIGBUS ioctl
To:     Peter Xu <peterx@redhat.com>
Cc:     Jiaqi Yan <jiaqiyan@google.com>,
        David Hildenbrand <david@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Huang Ying <ying.huang@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Anish Moorthy <amoorthy@google.com>
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

On Fri, May 19, 2023 at 9:20=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> Hi, Jiaqi,
>
> On Fri, May 19, 2023 at 08:04:09AM -0700, Jiaqi Yan wrote:
> > I don't think CAP_ADMIN is something we can work around: a VMM must be
> > a good citizen to avoid introducing any vulnerability to the host or
> > guest.
> >
> > On the other hand, "Userfaults allow the implementation of on-demand
> > paging from userland and more generally they allow userland to take
> > control of various memory page faults, something otherwise only the
> > kernel code could do." [3]. I am not familiar with the UFFD internals,
> > but our use case seems to match what UFFD wants to provide: without
> > affecting the whole world, give a specific userspace (without
> > CAP_ADMIN) the ability to handle page faults (indirectly emulate a
> > HWPOISON page (in my mind I treat it as SetHWPOISON(page) +
> > TestHWPOISON(page) operation in kernel's PF code)). So is it fair to
> > say what Axel provided here is "provide !ADMIN somehow"?
> >
> > [3]https://docs.kernel.org/admin-guide/mm/userfaultfd.html
>
> Userfault keywords on "user", IMHO.  We don't strictly need userfault to
> resolve anything regarding CAP_ADMIN problems.  MADV_DONTNEED also dosn't
> need CAP_ADMIN, same to any new madvise() if we want to make it useful fo=
r
> injecting poisoned ptes with !ADMIN and limit it within current->mm.
>
> But I think you're right that userfaultfd always tried to avoid having
> ADMIN and keep everything within its own scope of permissions.
>
> So again, totally no objection on make it uffd specific for now if you gu=
ys
> are all happy with it, but just to be clear that it's (to me) mostly for
> avoiding another WAKE, and afaics that's not really for solving the ADMIN
> issue here.

How about this plan:

Since the concrete use case we have (postcopy live migration) is
UFFD-specific, let's leave it as a UFFDIO_* operation for now.

If in the future we come up with a non-UFFD use case, we can add a new
MADV_* which does this operation at that point. From my perspective
they could even share most of the same implementation code.

I don't think it's a big problem keeping the UFFDIO_* version too at
that point, because it still provides some (perhaps small) value:

- Combines the operation + waking into one syscall
- It allows us to support additional UFFD flags which modify / extend
the operation in UFFD-specific ways, if we want to add those in the
future

Seem reasonable?

If so, I'll send a v2 with documentation updates.

>
> Thanks,
>
> --
> Peter Xu
>
