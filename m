Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0023C3688D6
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Apr 2021 00:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbhDVWG2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Apr 2021 18:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbhDVWG1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Apr 2021 18:06:27 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF51DC06138C
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Apr 2021 15:05:51 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id b10so47086400iot.4
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Apr 2021 15:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AFk7BH45ORIdrkfNh1F4hyVbR2dk8H/UC2K3JhS/KUs=;
        b=VUzn1MHbSHNAy7Ei+9InpDkS65ICvIJKxEJLWPTDS0ijRuQAzd11Rpzlj3MSVWVMjv
         xve9ML4hEvVzJU7+zMUHrDmZC3kqHCsiP1/ct8ERTY0ju5i5ekjH8RkF7Ei8iIARwbe1
         ac0WqS88RUUAv6BwhAYU54vL36l2IJwW5+CneLDm1/wPihJKPDOrxeoJ9KpJCBS081W2
         uci7pHXo5JdisDqtWNnxRCviYma1yYJPWplAW1iZU3RIxrVrx4BheuYp7BiEAI1WmUTy
         bjAPTtnJz9MJURkVYnY6cLXvxniMP897bu8yPuK5DzRDCI5SPwq9vnUBjCwd3VKgmU5D
         1e4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFk7BH45ORIdrkfNh1F4hyVbR2dk8H/UC2K3JhS/KUs=;
        b=F/Uce1diLmCHcxQkv9+5FEnwYjGU8H13d3kKV8LgcYjQDPX+g51vutStbI/uJdJ6/U
         Qqn+QagxV6Ly0wbNbsNM6F3dgOA4RWzwGTbG8Zv1S+yOa504xciDc7EFisfr41YqZqNx
         nm8mzNEGsz2t4j7IMcvwAIG6ItMgMdlGEXK+pBhenPiVu6P/5zI7JZ6nAtJK23SdsHDl
         BKJnj+vD7w6itCks3ZaYjVLnVb3dhhVxOIbc7FXyLd6zTo6VjwarVYPZa4YhpESPDx2B
         DxhiWTMJwwUXgv1CwExg9berVw3BsHjWNj+osuIT1UplW0KJntQfLkThWo0HMxR3crIi
         Fz6g==
X-Gm-Message-State: AOAM533myKSaUwCZKM8NNwp0XtUULyWeUzxRgQATpqp34r/T3qt/y4l6
        8rN9Cw4BvQrEVWRxUTYBiL+N/dNIewc1ZG0QzmsynQ==
X-Google-Smtp-Source: ABdhPJxBGb1P3MtuTKhDCA2eTGl9jzdfgCFgq1+C3DBoGvJw068w+BypVdPyLeyurB1t52k5rpStyCAVc85KqUpzqKc=
X-Received: by 2002:a5e:8a47:: with SMTP id o7mr883885iom.57.1619129150741;
 Thu, 22 Apr 2021 15:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210420220804.486803-1-axelrasmussen@google.com>
 <20210420220804.486803-4-axelrasmussen@google.com> <CAJHvVchQk1zrgah08n_P3sHUVzQLZUXHSMbkpd9rG-w5jUGNdw@mail.gmail.com>
 <20210422211847.GF6404@xz-x1>
In-Reply-To: <20210422211847.GF6404@xz-x1>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 22 Apr 2021 15:05:14 -0700
Message-ID: <CAJHvVchBeYG1g-EXCVAF2k1uxUeaUn_nC_KxfLK5S5JLwYv20Q@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] userfaultfd/shmem: support UFFDIO_CONTINUE for shmem
To:     Peter Xu <peterx@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 22, 2021 at 2:18 PM Peter Xu <peterx@redhat.com> wrote:
>
> Axel,
>
> On Thu, Apr 22, 2021 at 01:22:02PM -0700, Axel Rasmussen wrote:
> > > +       if (page_in_cache)
> > > +               page_add_file_rmap(page, false);
> > > +       else
> > > +               page_add_new_anon_rmap(page, dst_vma, dst_addr, false);
> > > +
> > > +       /*
> > > +        * Must happen after rmap, as mm_counter() checks mapping (via
> > > +        * PageAnon()), which is set by __page_set_anon_rmap().
> > > +        */
> > > +       inc_mm_counter(dst_mm, mm_counter(page));
> >
> > Actually, I've noticed that this is still slightly incorrect.
> >
> > As Hugh pointed out, this works for the anon case, because
> > page_add_new_anon_rmap() sets page->mapping.
> >
> > But for the page_in_cache case, it doesn't work: unlike its anon
> > counterpart, page_add_file_rmap() *does not* set page->mapping.
>
> If it's already in the page cache, shouldn't it be set already in e.g. one
> previous call to shmem_add_to_page_cache()?  Thanks,

Ah, of course. Sorry for the noise. This should have been obvious to
me from how page_in_cache is defined.

I had run into the same "Bad rss-counter state" warning while applying
my patches to an earlier kernel version, and got concerned about this
line after looking at page_add_file_rmap().

But, you're right that this ought to work, and indeed I can't
reproduce the warning when the patches are based on the mm snapshot
mentioned in the cover letter. So, it seems the problem lies with this
other unrelated merge I'm doing, not the series itself. :)

>
> --
> Peter Xu
>
