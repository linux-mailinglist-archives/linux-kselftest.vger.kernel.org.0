Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 397FF6A6B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2019 12:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733267AbfGPKmU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jul 2019 06:42:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44138 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732524AbfGPKmT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jul 2019 06:42:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so8903008pfe.11
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2019 03:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pcaSKUptakKKj3J2cwfnG8UjZ2PIKf/cDSDsIedAL2o=;
        b=s+OFL3WXkvuRlzxrd5bE1Ngy+XgzRf65DCow2JPQVmoncUwZbVCqMBlaegEFH9OjoE
         hGCT+agVZt6o7c1dpbisMO2uuxLS4ocd2/ZDN7N4RlgjJBFJVqurL7o3Ajgq9RawIe5i
         iUUC4MErBeuJi9C5qq1rXWHueETWBI6Hzy/jstfQMgqGCotgu8bx7AIz25MV6uvB/uMd
         AEZz6pOzM1SLevN2MhBCQnN+Ls0p0A8Ke9oO9L3/oytDbjyhFG4BNaIQGs6zmciV6uIC
         B6Z1DPnQPaMXlwFS2CsRvlNBpOj4ZTVcwcFW3en9/NlOTRMUXcMVVd3220XqOCAD3ZI0
         4G+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pcaSKUptakKKj3J2cwfnG8UjZ2PIKf/cDSDsIedAL2o=;
        b=aI0cDb7AE3KghfdRrCK1GN4dxz64wYzOpcGN5nJ3vwvIOz9EfumOYCuLp6lE6qvRM1
         eEQZrIjWiO3SzD+QNkfe8DiL51Ur10A7W2XAx/ZaXJ5GZbl2LMTAIR6ZOetJIndkUVpQ
         PaHPY34pi4An5n253/HvmIlSZ6TCLZbmg7oSs1JzwmPvLJ3UiJ55pRrXqg6lwr3PTuHn
         nfu5647HbwQmtQlczM3+3HUyZtoaZlsy9kaQVUoGV5atwCtdGIxFNiPk8sVno0etfviR
         qQlmdqKK15wwYlhxc2CKg+c1wLcPaqcP2oVSjGwxoYW78ZaygvDAdbfeiFVfWbeS6xT+
         FEKA==
X-Gm-Message-State: APjAAAW3rI4Nmt12FHrTcIgZHPzcwggvH+7kd+1hZzcV/B8mlyxdIxsf
        Mxed+H02hNVEegIzH2UCLbuOuTxsBxqgXzVFHDpwbQ==
X-Google-Smtp-Source: APXvYqxbAU3TJ3lRd6aOUwZ5wuALN9pC6/wjaLV/0rVHNmhI9zipeP18fROsGNN7fnnNJ7wIdpoSB0T+fWzH5C49P+M=
X-Received: by 2002:a65:4b8b:: with SMTP id t11mr32488026pgq.130.1563273738850;
 Tue, 16 Jul 2019 03:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561386715.git.andreyknvl@google.com> <ea0ff94ef2b8af12ea6c222c5ebd970e0849b6dd.1561386715.git.andreyknvl@google.com>
 <20190624174015.GL29120@arrakis.emea.arm.com> <CAAeHK+y8vE=G_odK6KH=H064nSQcVgkQkNwb2zQD9swXxKSyUQ@mail.gmail.com>
 <20190715180510.GC4970@ziepe.ca>
In-Reply-To: <20190715180510.GC4970@ziepe.ca>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 16 Jul 2019 12:42:07 +0200
Message-ID: <CAAeHK+xPQqJP7p_JFxc4jrx9k7N0TpBWEuB8Px7XHvrfDU1_gw@mail.gmail.com>
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

On Mon, Jul 15, 2019 at 8:05 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Jul 15, 2019 at 06:01:29PM +0200, Andrey Konovalov wrote:
> > On Mon, Jun 24, 2019 at 7:40 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > >
> > > On Mon, Jun 24, 2019 at 04:32:56PM +0200, Andrey Konovalov wrote:
> > > > This patch is a part of a series that extends kernel ABI to allow to pass
> > > > tagged user pointers (with the top byte set to something else other than
> > > > 0x00) as syscall arguments.
> > > >
> > > > mlx4_get_umem_mr() uses provided user pointers for vma lookups, which can
> > > > only by done with untagged pointers.
> > > >
> > > > Untag user pointers in this function.
> > > >
> > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > >  drivers/infiniband/hw/mlx4/mr.c | 7 ++++---
> > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > >
> > > This patch also needs an ack from the infiniband maintainers (Jason).
> >
> > Hi Jason,
> >
> > Could you take a look and give your acked-by?
>
> Oh, I think I did this a long time ago. Still looks OK.

Hm, maybe that was we who lost it. Thanks!

> You will send it?

I will resend the patchset once the merge window is closed, if that's
what you mean.

>
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
>
> Jason
