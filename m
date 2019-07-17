Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFD06BBF9
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2019 13:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfGQL6b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Jul 2019 07:58:31 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36432 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfGQL6b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Jul 2019 07:58:31 -0400
Received: by mail-qt1-f194.google.com with SMTP id z4so23008744qtc.3
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jul 2019 04:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CtIW38CyixiEAESJE2x/hR6vvP9ZY7lyz3jE6erJEA4=;
        b=WsXmWAFNLS9Y5gyPmjyVBufuKshUnoz9oYQO3m2Kyy2wMtQLDRqxhz084Ma4sggKxA
         VrwuLzOtiAy8rszSQKzE18fvnWZV7M1q7YnEAmJigLzdicTLpZGoNiZ3Gar/CFdANUGQ
         +gt0fDflhj1oNluiZIVGuibWAh1JTcQepAsHP/YRP7PCiQsEbkufbX49wfrYCtAj9p/q
         ZpOMd9vVDGljJ+MPyoKgDKJFbWpQx34cZ14/YkYB9E0gHWhEQolXuspRkMtBiWOO9Km7
         Ew1EzqQInlJf4dxI+ivorIznpDm2P9V/p9lWf5oiX205bEqIkGxkVFU6X6xClAOP44Zp
         QzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CtIW38CyixiEAESJE2x/hR6vvP9ZY7lyz3jE6erJEA4=;
        b=KvrpAPMaa0/ALZlHro8l08sDth5L62TT8pjswjp3eWDFIhwvX/eu+z2DW1lIlHVKR3
         0R50fCZo96lGFVgv4q7CDV9UOIEs10N17ObfvxWmrLCLuUHG1oJvwm0BryaCxbYuBmPF
         ejOlYFWoHJ+oUmSsIpUEhCH37KGzhmddY1Ag70+zeNxVJtaXe/E6QCTGtqfXiQwj2Ooq
         7sybhIP577GUAD7BuyyFFH61Lin/HTuaxoOhGtJ0MxueFFMy4oP5XNgm96dO5lbm+9Gc
         TEXBY2FKUXQlgqfRQvN5IlsZG/DJlfu6fDYLhFH+RSNmw4mqNtWzpo9/hO6p3NejSZ+i
         1dIg==
X-Gm-Message-State: APjAAAXIBzP5dnTStrRAwihWi0eW3MUGJbH/VKmvwKj9xoSED3g/TA7g
        35+o3Bwsf4Fon0FMX1w+NNYGoA==
X-Google-Smtp-Source: APXvYqx+j7x9Tmvjx0AtdL0JLRa2IEARVY42fsMnhsZXPsgl7xwQHvLdp4tWEgHcwSJhOki+ORlGpQ==
X-Received: by 2002:ac8:394b:: with SMTP id t11mr26922427qtb.286.1563364709720;
        Wed, 17 Jul 2019 04:58:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id n18sm10459998qtr.28.2019.07.17.04.58.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Jul 2019 04:58:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hniZo-0003Vz-Og; Wed, 17 Jul 2019 08:58:28 -0300
Date:   Wed, 17 Jul 2019 08:58:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Andrey Konovalov <andreyknvl@google.com>
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
Subject: Re: [PATCH v18 11/15] IB/mlx4: untag user pointers in
 mlx4_get_umem_mr
Message-ID: <20190717115828.GE12119@ziepe.ca>
References: <cover.1561386715.git.andreyknvl@google.com>
 <ea0ff94ef2b8af12ea6c222c5ebd970e0849b6dd.1561386715.git.andreyknvl@google.com>
 <20190624174015.GL29120@arrakis.emea.arm.com>
 <CAAeHK+y8vE=G_odK6KH=H064nSQcVgkQkNwb2zQD9swXxKSyUQ@mail.gmail.com>
 <20190715180510.GC4970@ziepe.ca>
 <CAAeHK+xPQqJP7p_JFxc4jrx9k7N0TpBWEuB8Px7XHvrfDU1_gw@mail.gmail.com>
 <20190716120624.GA29727@ziepe.ca>
 <CAAeHK+xPPQ9QjAksbfWG-Zmnawt-cdw9eO_6GVxjEYcaDGvaRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+xPPQ9QjAksbfWG-Zmnawt-cdw9eO_6GVxjEYcaDGvaRA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 17, 2019 at 01:44:07PM +0200, Andrey Konovalov wrote:
> On Tue, Jul 16, 2019 at 2:06 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Jul 16, 2019 at 12:42:07PM +0200, Andrey Konovalov wrote:
> > > On Mon, Jul 15, 2019 at 8:05 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Mon, Jul 15, 2019 at 06:01:29PM +0200, Andrey Konovalov wrote:
> > > > > On Mon, Jun 24, 2019 at 7:40 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > > >
> > > > > > On Mon, Jun 24, 2019 at 04:32:56PM +0200, Andrey Konovalov wrote:
> > > > > > > This patch is a part of a series that extends kernel ABI to allow to pass
> > > > > > > tagged user pointers (with the top byte set to something else other than
> > > > > > > 0x00) as syscall arguments.
> > > > > > >
> > > > > > > mlx4_get_umem_mr() uses provided user pointers for vma lookups, which can
> > > > > > > only by done with untagged pointers.
> > > > > > >
> > > > > > > Untag user pointers in this function.
> > > > > > >
> > > > > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > > > > >  drivers/infiniband/hw/mlx4/mr.c | 7 ++++---
> > > > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > > > > >
> > > > > > This patch also needs an ack from the infiniband maintainers (Jason).
> > > > >
> > > > > Hi Jason,
> > > > >
> > > > > Could you take a look and give your acked-by?
> > > >
> > > > Oh, I think I did this a long time ago. Still looks OK.
> > >
> > > Hm, maybe that was we who lost it. Thanks!
> > >
> > > > You will send it?
> > >
> > > I will resend the patchset once the merge window is closed, if that's
> > > what you mean.
> >
> > No.. I mean who send it to Linus's tree? ie do you want me to take
> > this patch into rdma?
> 
> I think the plan was to merge the whole series through the mm tree.
> But I don't mind if you want to take this patch into your tree. It's
> just that this patch doesn't make much sense without the rest of the
> series.

Generally I prefer if subsystem changes stay in subsystem trees. If
the patch is good standalone, and the untag API has already been
merged, this is a better strategy.

Jason
