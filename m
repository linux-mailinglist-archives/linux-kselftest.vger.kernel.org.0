Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 991AE698CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2019 18:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbfGOQBm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Jul 2019 12:01:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36046 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731011AbfGOQBl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Jul 2019 12:01:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so7928259pgm.3
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jul 2019 09:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lChEEghQFkJA0ae9eAwhZ0QJmvdqy/WLUOFz361BXCQ=;
        b=m3ylaWA1nfDKOLFQBZbi5lVR91/hvH9n6ddTo7/UGe/KLQTke6nfJGGnTYTOxi8VCA
         HfS0hKS7p+bVQo6gCnikJZrIRnFAsBOo76vo66MNNR76VN9RpCPaB5uiN9mXzb/wKBaC
         2YPMCtyHAVUy8c0n2Hy0noVhGDDAso8pOP+OWaQofcmHPvFQjxyIKXwz5wkCf0bTrn7S
         NzX5/+eAUp4zqkWQrLjg7UELrWGHhufD8/uShStHD6i3q1aY9KquzAKDzGkmcTnssS5F
         Z3nCiKnfqdcqBaEFScvEV6fXgwg7XscQvG1/2qeAbDEIc8Yoj5aguZfuLCcnlHXlWZQG
         m73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lChEEghQFkJA0ae9eAwhZ0QJmvdqy/WLUOFz361BXCQ=;
        b=lNSJ2jrFSCdnH4EL0gJiuTaWPbP5Fa8ggWtJSliAsyJ+eTJIWpWwf/x8Kdp6KZY5Mm
         svKLYV7yiUFrbaaa1k/M4gYEstCss+cn4ruwUGN8KSW7Ik6JfA3LGppKXm57bfuzAtjA
         smNGbkFAfrjFKzTxu88i7PF41yzh5PHhkLelSYwcrMtrqaT9RfiemtJkWhYQJ69dF1gC
         anjzTV4qBpQ4Op1m7XLBMZNpv5/gLfyRXQ5j084/RV42nrsoD58dfjTH2UWpWS1/O/z8
         Fl9X03iDp8Z+M1xrD5bqAuYIrFW4z0JQOrTBlfuEmRA5eZWk8MRIn5kr7oTCVEun4MzM
         sEPg==
X-Gm-Message-State: APjAAAUdC4onWJOrZCydIcsMFc2h5PLlH3xNExw7v35JOzjPRhySmfqN
        dm1v3dcqu02dIrr/fFAd7wG2bvw1hiJ5C9Asy6sOwA==
X-Google-Smtp-Source: APXvYqyLZ0wS0QgBngEcy3YbbCLzw5RatJ3FtyfhyqUYHKhFv456jIze9R6yuxvC6+RP9cmNsJEN8HfxXPuILyhJ/1w=
X-Received: by 2002:a17:90a:a116:: with SMTP id s22mr29861239pjp.47.1563206500702;
 Mon, 15 Jul 2019 09:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561386715.git.andreyknvl@google.com> <ea0ff94ef2b8af12ea6c222c5ebd970e0849b6dd.1561386715.git.andreyknvl@google.com>
 <20190624174015.GL29120@arrakis.emea.arm.com>
In-Reply-To: <20190624174015.GL29120@arrakis.emea.arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 15 Jul 2019 18:01:29 +0200
Message-ID: <CAAeHK+y8vE=G_odK6KH=H064nSQcVgkQkNwb2zQD9swXxKSyUQ@mail.gmail.com>
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

On Mon, Jun 24, 2019 at 7:40 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Jun 24, 2019 at 04:32:56PM +0200, Andrey Konovalov wrote:
> > This patch is a part of a series that extends kernel ABI to allow to pass
> > tagged user pointers (with the top byte set to something else other than
> > 0x00) as syscall arguments.
> >
> > mlx4_get_umem_mr() uses provided user pointers for vma lookups, which can
> > only by done with untagged pointers.
> >
> > Untag user pointers in this function.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  drivers/infiniband/hw/mlx4/mr.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>
> This patch also needs an ack from the infiniband maintainers (Jason).

Hi Jason,

Could you take a look and give your acked-by?

Thanks!

>
> --
> Catalin
