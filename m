Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC246BBB1
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2019 13:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbfGQLoT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Jul 2019 07:44:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41112 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731076AbfGQLoT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Jul 2019 07:44:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id x15so697354pgg.8
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jul 2019 04:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s96tbUHAJa/3W+S33QuecksVNxzPE4B+rwrtGBTPIRg=;
        b=YNTzEvLokDKfBiND0F2uTRtNbbscQoeYlRAIZ4D4gm+fPunaVpSxT9yFu1P0pJ6lio
         xWTqHSLTx3ZiQsVVIdfvcsAEZX+UwZ3GwnRk6z/9j+jj49uvH9o3OWPLDccY+IbVHGze
         VX/w7SlL3Vzx+t0xrwbctuweCHGIlBKbcd05Q0zBlUJIzL3VkiYxJwnzmtUL5R2SnxIl
         RhMYnRo7T8e4Wl/4YHx7n44SfOzOXvvpPCN5gZKipQVyiczav3qSb50tsdB3ZZ0CfrCh
         dofC27Pihb8FLt/R6YXAogt8ZfxAC6UrwAQzPlEU0+w5SGEaRflsRUqY/qTdnOsoVA2h
         liiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s96tbUHAJa/3W+S33QuecksVNxzPE4B+rwrtGBTPIRg=;
        b=m9oxl0EbQ2b55cLu7h/34xtKmEAQ3l2m7CewZ5FbtwLTtTj9vyDmz+vukMQL/T5c8C
         O6EEel9+HHwe49xjy6jdmjjhmC9N0Rc5Ai0Ysrkawy22J1iykPt77ixeXo5LGTcZf/vD
         z3LCN8kN9lqwI28YylUAt8utpWsYQ8aMOSBBQ1nkIKkarOFYFRNkW/Zlkc3r2F7gxO3c
         BUEh66v3b8HIZho6dzuyMzWzCLuRHTpUtgIFLr0cKU/KoYP6I3iB3WNOlrp4h0a3qyO9
         XUR85cIIl+548LQmb1G6DFMFMsp2Vi7C3YLqBuSsvgFo2RUZEuxpbHdMiSycxD0361yI
         2rTA==
X-Gm-Message-State: APjAAAW4B/stddmMBCnkUZVYSssgG2nxulJakhpTGtev1NDfxOexHluE
        BUoy+JuFsEJDt5Qw9ZAsFvfL/Z6c0fUyuXSy0dkqOg==
X-Google-Smtp-Source: APXvYqxCr99MNxoD8F3ipCKfGH5Ic+wArEB2kJiBZjN+Ft8BlSUogLYhlY5cWCf0y3NDyGKfQgFMQFiKtGoY4M7YZGQ=
X-Received: by 2002:a63:c442:: with SMTP id m2mr41068862pgg.286.1563363858315;
 Wed, 17 Jul 2019 04:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561386715.git.andreyknvl@google.com> <ea0ff94ef2b8af12ea6c222c5ebd970e0849b6dd.1561386715.git.andreyknvl@google.com>
 <20190624174015.GL29120@arrakis.emea.arm.com> <CAAeHK+y8vE=G_odK6KH=H064nSQcVgkQkNwb2zQD9swXxKSyUQ@mail.gmail.com>
 <20190715180510.GC4970@ziepe.ca> <CAAeHK+xPQqJP7p_JFxc4jrx9k7N0TpBWEuB8Px7XHvrfDU1_gw@mail.gmail.com>
 <20190716120624.GA29727@ziepe.ca>
In-Reply-To: <20190716120624.GA29727@ziepe.ca>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 17 Jul 2019 13:44:07 +0200
Message-ID: <CAAeHK+xPPQ9QjAksbfWG-Zmnawt-cdw9eO_6GVxjEYcaDGvaRA@mail.gmail.com>
Subject: Re: [PATCH v18 11/15] IB/mlx4: untag user pointers in mlx4_get_umem_mr
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        kvm@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 16, 2019 at 2:06 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Jul 16, 2019 at 12:42:07PM +0200, Andrey Konovalov wrote:
> > On Mon, Jul 15, 2019 at 8:05 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Mon, Jul 15, 2019 at 06:01:29PM +0200, Andrey Konovalov wrote:
> > > > On Mon, Jun 24, 2019 at 7:40 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > >
> > > > > On Mon, Jun 24, 2019 at 04:32:56PM +0200, Andrey Konovalov wrote:
> > > > > > This patch is a part of a series that extends kernel ABI to allow to pass
> > > > > > tagged user pointers (with the top byte set to something else other than
> > > > > > 0x00) as syscall arguments.
> > > > > >
> > > > > > mlx4_get_umem_mr() uses provided user pointers for vma lookups, which can
> > > > > > only by done with untagged pointers.
> > > > > >
> > > > > > Untag user pointers in this function.
> > > > > >
> > > > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > > > >  drivers/infiniband/hw/mlx4/mr.c | 7 ++++---
> > > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > >
> > > > > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > > > >
> > > > > This patch also needs an ack from the infiniband maintainers (Jason).
> > > >
> > > > Hi Jason,
> > > >
> > > > Could you take a look and give your acked-by?
> > >
> > > Oh, I think I did this a long time ago. Still looks OK.
> >
> > Hm, maybe that was we who lost it. Thanks!
> >
> > > You will send it?
> >
> > I will resend the patchset once the merge window is closed, if that's
> > what you mean.
>
> No.. I mean who send it to Linus's tree? ie do you want me to take
> this patch into rdma?

I think the plan was to merge the whole series through the mm tree.
But I don't mind if you want to take this patch into your tree. It's
just that this patch doesn't make much sense without the rest of the
series.

>
> Jason
