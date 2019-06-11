Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15F813D494
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2019 19:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406678AbfFKRuq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jun 2019 13:50:46 -0400
Received: from foss.arm.com ([217.140.110.172]:39188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406260AbfFKRup (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jun 2019 13:50:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D236337;
        Tue, 11 Jun 2019 10:50:45 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18BF83F73C;
        Tue, 11 Jun 2019 10:50:39 -0700 (PDT)
Date:   Tue, 11 Jun 2019 18:50:37 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
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
        Jason Gunthorpe <jgg@ziepe.ca>,
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
Subject: Re: [PATCH v16 16/16] selftests, arm64: add a selftest for passing
 tagged pointers to kernel
Message-ID: <20190611175037.pflr6q6ob67zjj25@mbp>
References: <cover.1559580831.git.andreyknvl@google.com>
 <9e1b5998a28f82b16076fc85ab4f88af5381cf74.1559580831.git.andreyknvl@google.com>
 <20190611150122.GB63588@arrakis.emea.arm.com>
 <CAAeHK+wZrVXxAnDXBjoUy8JK9iG553G2Bp8uPWQ0u1u5gts0vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+wZrVXxAnDXBjoUy8JK9iG553G2Bp8uPWQ0u1u5gts0vQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 11, 2019 at 07:18:04PM +0200, Andrey Konovalov wrote:
> On Tue, Jun 11, 2019 at 5:01 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > static void *tag_ptr(void *ptr)
> > {
> >         static int tagged_addr_err = 1;
> >         unsigned long tag = 0;
> >
> >         if (tagged_addr_err == 1)
> >                 tagged_addr_err = prctl(PR_SET_TAGGED_ADDR_CTRL,
> >                                         PR_TAGGED_ADDR_ENABLE, 0, 0, 0);
> 
> I think this requires atomics. malloc() can be called from multiple threads.

It's slightly racy but I assume in a real libc it can be initialised
earlier than the hook calls while still in single-threaded mode (I had
a quick attempt with __attribute__((constructor)) but didn't get far).

Even with the race, under normal circumstances calling the prctl() twice
is not a problem. I think the risk here is that someone disables the ABI
via sysctl and the ABI is enabled for some of the threads only.

-- 
Catalin
