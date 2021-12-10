Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BFB46FE9C
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 11:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239631AbhLJKW3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 05:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236599AbhLJKW3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 05:22:29 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3214C061746
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 02:18:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 33252CE29DE
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 10:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B60C00446;
        Fri, 10 Dec 2021 10:18:47 +0000 (UTC)
Date:   Fri, 10 Dec 2021 10:18:44 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v6 06/37] kselftest/arm64: Add a test program to exercise
 the syscall ABI
Message-ID: <YbMphO6wwXz54yjB@arm.com>
References: <20211115152835.3212149-1-broonie@kernel.org>
 <20211115152835.3212149-7-broonie@kernel.org>
 <YbI3ZfhOO+M5L/9V@arm.com>
 <YbJVPGqADH/cadaU@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbJVPGqADH/cadaU@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 09, 2021 at 07:13:00PM +0000, Mark Brown wrote:
> On Thu, Dec 09, 2021 at 05:05:41PM +0000, Catalin Marinas wrote:
> > On Mon, Nov 15, 2021 at 03:28:04PM +0000, Mark Brown wrote:
> 
> > > +// SPDX-License-Identifier: GPL-2.0-only
> 
> > Nitpick: I think GPL-2.0 is sufficient (i.e. no '-only' suffix), though
> > about a quarter seem to use the -only variant.
> 
> Yeah, it's that because it's the default for kernel stuff.  Easier to
> make it restrictive and then relax later?

My point was that IIUC GPL-2.0 is equivalent to GPL-2.0-only (not to be
confused with GPL-2.0+). Anyway, it's fine by me to keep the -only if
you want. It seems that we have nearly the same amount of both
throughout the kernel.

> > > +	/*
> > > +	 * After a syscall the low 128 bits of the Z registers should
> > > +	 * be preserved and the rest be zeroed.
> > > +	 */
> 
> > That's the current behaviour I think but the sve.rst doc states the
> > values after syscall are 'unspecified' (same for the P regs). Should we
> > tighten the doc as well?
> 
> I think so if this goes in as is.  There was some debate at the time
> that SVE was originally merged, with a strong desire from some people to
> make sure that this behaves consistently on every syscall.  I've copied
> in Mark Rutland and Marc Zyngier who I think have opinions here.
> 
> > A downside with forcing zero is that it may prevent us from some
> > optimisations in the future. Currently we do an sve_user_discard() on
> > the syscall entry path and disable SVE but we could instead do this only
> > on context switch or when the kernel used Neon.
> 
> Yes, this is limiting our options for performance work since we need to
> at least take the cost of zeroing the non-shared state on every syscall,
> though there's still options for choosing not to disable SVE all the
> time (I've got a patch already I need to do a bit more work on). 

Some people seem to be pretty sensitive to the syscall latency, so I'd
like to keep the option to optimise this path if it bites us.

> The
> currently documented behaviour is in line with AAPCS here so you do have
> to wonder how likely it is that someone will rely on the zeroing.  On
> the other hand anything like only zeroing the state on context switch
> would mean that it's more likely that userspace bugs with something
> forgetting that the state might be cleared will be intermittent and most
> likely hard to reproduce which will make people miserable.  There's a
> good chance that bugs will be wrong answers rather than something more
> immediate like a fault which really doesn't help there.

If we eventually optimise this path, we could add an option to
force-zero the SVE regs on syscall for debugging purposes. But even
without this, such software may run into problems. By AAPCS, if the
callee doesn't take any SVE arguments, it doesn't need to preserve any
of the registers, though it may choose to. Let's take a gettimeofday
libc call, it may or may not end up in the kernel. When it's handled by
the vDSO, all the SVE regs are preserved but not when doing the syscall.
Something like a futex call would be even less predictable.

In an optimised kernel, the context switch indeed adds to the entropy
but the user can already hit such problems with the current more
consistent behaviour.

-- 
Catalin
