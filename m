Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9B415D70
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2019 08:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfEGGdn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 May 2019 02:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfEGGdn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 May 2019 02:33:43 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6C092087F;
        Tue,  7 May 2019 06:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557210822;
        bh=oBFyk7fpihJdB0jCxegQVyX+6vGmLC1DK9IvU35itFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RyPsl6lmqvcCnKl41VkY/GHW2+ETy7nDPo8Tpqc6bp7gDCBLdqWePFxG5B2Wa9vwT
         R3/WlBSqCc8Bj3KtWz9uGTPPZS6ordaRPlQ/fveMibMSWfgfc4tq1AglaAlmwW4kMa
         oMxOIvxG2cStHRR+RV/gLi/uVrPbQ27CrKcpR2aA=
Date:   Tue, 7 May 2019 09:33:37 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
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
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v15 13/17] IB, arm64: untag user pointers in
 ib_uverbs_(re)reg_mr()
Message-ID: <20190507063337.GP6938@mtr-leonro.mtl.com>
References: <cover.1557160186.git.andreyknvl@google.com>
 <66d044ab9445dcf36a96205a109458ac23f38b73.1557160186.git.andreyknvl@google.com>
 <20190506195020.GD6201@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506195020.GD6201@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 06, 2019 at 04:50:20PM -0300, Jason Gunthorpe wrote:
> On Mon, May 06, 2019 at 06:30:59PM +0200, Andrey Konovalov wrote:
> > This patch is a part of a series that extends arm64 kernel ABI to allow to
> > pass tagged user pointers (with the top byte set to something else other
> > than 0x00) as syscall arguments.
> >
> > ib_uverbs_(re)reg_mr() use provided user pointers for vma lookups (through
> > e.g. mlx4_get_umem_mr()), which can only by done with untagged pointers.
> >
> > Untag user pointers in these functions.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  drivers/infiniband/core/uverbs_cmd.c | 4 ++++
> >  1 file changed, 4 insertions(+)
>
> I think this is OK.. We should really get it tested though.. Leon?

It can be done after v5.2-rc1.

Thanks

>
> Jason
