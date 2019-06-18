Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 147D049CED
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2019 11:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbfFRJSU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jun 2019 05:18:20 -0400
Received: from foss.arm.com ([217.140.110.172]:58798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729137AbfFRJSU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jun 2019 05:18:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D19DC344;
        Tue, 18 Jun 2019 02:18:18 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BBBB3F246;
        Tue, 18 Jun 2019 02:18:14 -0700 (PDT)
Date:   Tue, 18 Jun 2019 10:18:12 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
        Christian Koenig <Christian.Koenig@amd.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        dri-devel@lists.freedesktop.org,
        Kostya Serebryany <kcc@google.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Lee Smith <Lee.Smith@arm.com>, linux-kselftest@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dmitry Vyukov <dvyukov@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        linux-media@vger.kernel.org,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        linux-kernel@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        enh <enh@google.com>, Robin Murphy <robin.murphy@arm.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v17 03/15] arm64: Introduce prctl() options to control
 the tagged user addresses ABI
Message-ID: <20190618091811.GC2790@e103592.cambridge.arm.com>
References: <cover.1560339705.git.andreyknvl@google.com>
 <a7a2933bea5fe57e504891b7eec7e9432e5e1c1a.1560339705.git.andreyknvl@google.com>
 <20190613110235.GW28398@e103592.cambridge.arm.com>
 <20190613152632.GT28951@C02TF0J2HF1T.local>
 <201906132209.FC65A3C771@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201906132209.FC65A3C771@keescook>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 13, 2019 at 10:13:54PM -0700, Kees Cook wrote:
> On Thu, Jun 13, 2019 at 04:26:32PM +0100, Catalin Marinas wrote:
> > On Thu, Jun 13, 2019 at 12:02:35PM +0100, Dave P Martin wrote:
> > > On Wed, Jun 12, 2019 at 01:43:20PM +0200, Andrey Konovalov wrote:
> > > > +static int zero;
> > > > +static int one = 1;
> > > 
> > > !!!
> > > 
> > > And these can't even be const without a cast.  Yuk.
> > > 
> > > (Not your fault though, but it would be nice to have a proc_dobool() to
> > > avoid this.)
> > 
> > I had the same reaction. Maybe for another patch sanitising this pattern
> > across the kernel.
> 
> That's actually already happening (via -mm tree last I looked). tl;dr:
> it ends up using a cast hidden in a macro. It's in linux-next already
> along with a checkpatch.pl addition to yell about doing what's being
> done here. ;)
> 
> https://lore.kernel.org/lkml/20190430180111.10688-1-mcroce@redhat.com/#r

Hmmm, that is marginally less bad.

Ideally we'd have a union in there, not just a bunch of void *.  I may
look at that someday...

Cheers
---Dave
