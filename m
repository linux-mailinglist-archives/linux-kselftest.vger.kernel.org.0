Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B50A27709
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2019 09:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfEWHeg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 03:34:36 -0400
Received: from foss.arm.com ([217.140.101.70]:39058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbfEWHef (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 03:34:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF17480D;
        Thu, 23 May 2019 00:34:34 -0700 (PDT)
Received: from MBP.local (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89C463F575;
        Thu, 23 May 2019 00:34:28 -0700 (PDT)
Date:   Thu, 23 May 2019 08:34:25 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     enh <enh@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
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
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v15 00/17] arm64: untag user pointers passed to the kernel
Message-ID: <20190523073425.GA43379@MBP.local>
References: <20190517144931.GA56186@arrakis.emea.arm.com>
 <CAFKCwrj6JEtp4BzhqO178LFJepmepoMx=G+YdC8sqZ3bcBp3EQ@mail.gmail.com>
 <20190521182932.sm4vxweuwo5ermyd@mbp>
 <201905211633.6C0BF0C2@keescook>
 <20190522101110.m2stmpaj7seezveq@mbp>
 <CAJgzZoosKBwqXRyA6fb8QQSZXFqfHqe9qO9je5TogHhzuoGXJQ@mail.gmail.com>
 <20190522163527.rnnc6t4tll7tk5zw@mbp>
 <201905221316.865581CF@keescook>
 <CAFKCwrjOjdJAbcABp3qxwyYy+hgfyQirvmqGkDSJVJe5pSz0Uw@mail.gmail.com>
 <CAJgzZorUPzrXu0ysDdKwnqdvgWZJ9tqRjF-9_5CU_UV+c0bRCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJgzZorUPzrXu0ysDdKwnqdvgWZJ9tqRjF-9_5CU_UV+c0bRCA@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 22, 2019 at 04:09:31PM -0700, enh wrote:
> On Wed, May 22, 2019 at 4:03 PM Evgenii Stepanov <eugenis@google.com> wrote:
> > On Wed, May 22, 2019 at 1:47 PM Kees Cook <keescook@chromium.org> wrote:
> > > On Wed, May 22, 2019 at 05:35:27PM +0100, Catalin Marinas wrote:
> > > > I would also expect the C library or dynamic loader to check for the
> > > > presence of a HWCAP_MTE bit before starting to tag memory allocations,
> > > > otherwise it would get SIGILL on the first MTE instruction it tries to
> > > > execute.
> > >
> > > I've got the same question as Elliot: aren't MTE instructions just NOP
> > > to older CPUs? I.e. if the CPU (or kernel) don't support it, it just
> > > gets entirely ignored: checking is only needed to satisfy curiosity
> > > or behavioral expectations.
> >
> > MTE instructions are not NOP. Most of them have side effects (changing
> > register values, zeroing memory).
> 
> no, i meant "they're encoded in a space that was previously no-ops, so
> running on MTE code on old hardware doesn't cause SIGILL".

It does result in SIGILL, there wasn't enough encoding left in the NOP
space for old/current CPU implementations (in hindsight, we should have
reserved a bigger NOP space).

As Evgenii said, the libc needs to be careful when tagging the heap as
it would cause a SIGILL if the HWCAP_MTE is not set. The standard
application doesn't need to be recompiled as it would not issue MTE
colouring instructions, just standard LDR/STR.

Stack tagging is problematic if you want to colour each frame
individually, the function prologue would need the non-NOP MTE
instructions. The best we can do here is just having the (thread) stacks
of different colours.

-- 
Catalin
