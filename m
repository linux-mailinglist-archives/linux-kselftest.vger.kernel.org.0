Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D03174CC8
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2019 13:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403895AbfGYLRq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Jul 2019 07:17:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33441 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403878AbfGYLRq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Jul 2019 07:17:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id f20so13651950pgj.0
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jul 2019 04:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ceQemw0wuGQ3uiCqTlyBUwO60vemC2ljY3rBL1bAUvc=;
        b=PFlEvXsHYv4lFKGCCfXZ2BH9B+e/+FJBGpnFm58EL07XzmLkrfPE7grKe+lK7OJ+3q
         abjryupEyT3OpTe6vXeYbGcL1BUr5elNwdNVi9kwG5uLVwrmRNAlILwAOBEDWE3BDhoL
         wa/mA/jPR9b/azqkL/67D+Mm2vUNeUnKTr67F6b6zVcvZzUWDrGmaUvbPo48izoM48MU
         N0VWZj0yxfEFkbETpli1M4tpWnMK/JyQnFJyyMLRYouRu9gpM1Vf3XJFNTnOwCnTu9Ld
         itsx5ZgymWeM6DKM8q2cX7rBLN4FseRE3aGipc8TJcBEDMtdp1GaAUz+JB2Q86Y09iS0
         iOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ceQemw0wuGQ3uiCqTlyBUwO60vemC2ljY3rBL1bAUvc=;
        b=D8ZLlg0vQMmH7UPNOhVvatRiUp5x5kdQs8UWqT9NAernagmRqabdxbeQazC3Rn8KYJ
         yd+1gR6aeOObfXsj7NJCj6oi9GSgBGoDvGdJrGNh1euq0eipf6+TnqcbVL0BEfx1osmp
         bKLhC+bJ0JBhLYZL/lp0DG6rC9bkwJDcriOCGIelgfCUQnX49edqi798v3X//F+iIuYM
         e3CR9UYlo7V7UjQ6KLGXzOS1a8Pg9U4vtiRhTgRqePrzh1qm8u87xH3uSdAbf7zbWcAR
         TJXUkK+uylGUPQUAwu5I4/gARXJgFWLbFiDMp56sH9YjZeZ4/vmDsoZH3OjEplv4dlwo
         KbJQ==
X-Gm-Message-State: APjAAAWgi5Jac3id6JZkUSdbcJspAfNcS6Kx9V0Exh7Mc3QKvOgwzuCP
        CiGoo+mp60uvawro5gZkFWtHnGz2VUo712AP1Tv4Uw==
X-Google-Smtp-Source: APXvYqzUlCi07nILNklNsNS4HJ/lH+Efr4GjVTNZTHkDEiuYwLiGivIelhkfNGv3x1TCnih2kaTB3NQT1G7052KvmkQ=
X-Received: by 2002:a17:90a:a116:: with SMTP id s22mr91662102pjp.47.1564053464334;
 Thu, 25 Jul 2019 04:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563904656.git.andreyknvl@google.com> <7969018013a67ddbbf784ac7afeea5a57b1e2bcb.1563904656.git.andreyknvl@google.com>
 <20190724192504.GA5716@ziepe.ca>
In-Reply-To: <20190724192504.GA5716@ziepe.ca>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 25 Jul 2019 13:17:32 +0200
Message-ID: <CAAeHK+x5JFgkLLzhrkQBfa78pkyQXLhgOfXOGuHK=AfwFLHntg@mail.gmail.com>
Subject: Re: [PATCH v19 11/15] IB/mlx4: untag user pointers in mlx4_get_umem_mr
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        kvm@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 24, 2019 at 9:25 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Jul 23, 2019 at 07:58:48PM +0200, Andrey Konovalov wrote:
> > This patch is a part of a series that extends kernel ABI to allow to pass
> > tagged user pointers (with the top byte set to something else other than
> > 0x00) as syscall arguments.
> >
> > mlx4_get_umem_mr() uses provided user pointers for vma lookups, which can
> > only by done with untagged pointers.
> >
> > Untag user pointers in this function.
> >
> > Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  drivers/infiniband/hw/mlx4/mr.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
>
> Applied to rdma-for next, please don't sent it via other trees :)

Sure, thanks!

>
> Thanks,
> Jason
