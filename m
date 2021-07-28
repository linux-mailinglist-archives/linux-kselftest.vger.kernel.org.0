Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120E93D8F6D
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 15:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbhG1NrE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 09:47:04 -0400
Received: from foss.arm.com ([217.140.110.172]:56780 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236868AbhG1Npn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 09:45:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55FA831B;
        Wed, 28 Jul 2021 06:45:28 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C9FE3F70D;
        Wed, 28 Jul 2021 06:45:27 -0700 (PDT)
Date:   Wed, 28 Jul 2021 14:44:07 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 3/3] kselftest/arm64: Add tests for SVE vector
 configuration
Message-ID: <20210728134405.GF1724@arm.com>
References: <20210727180649.12943-1-broonie@kernel.org>
 <20210727180649.12943-4-broonie@kernel.org>
 <20210728094158.GC1724@arm.com>
 <20210728125918.GD4670@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728125918.GD4670@sirena.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 28, 2021 at 01:59:18PM +0100, Mark Brown wrote:
> On Wed, Jul 28, 2021 at 10:41:58AM +0100, Dave Martin wrote:
> > On Tue, Jul 27, 2021 at 07:06:49PM +0100, Mark Brown wrote:
> 
> > > We provide interfaces for configuring the SVE vector length seen by
> > > processes using prctl and also via /proc for configuring the default
> > > values. Provide tests that exercise all these interfaces and verify that
> > > they take effect as expected, though at present no test fully enumerates
> > > all the possible vector lengths.
> 
> > Does "at present" mean that this test doesn't do it either?
> 
> > (It doesn't seem to try every VL, unless I've missed something?  Is this
> > planned?)
> 
> Nothing currently does it, and nor does this patch.  Planned is a strong
> term but yes, ideally we should probe all the VLs.
> 
> > > +#include <stddef.h>
> > > +#include <stdio.h>
> > > +#include <stdlib.h>
> > 
> > Not used? ^
> 
> We call exit() which is declared in stdlib.h.

Ignore me, I confused exit() with _exit().

> > > +#define MIN_VL 16
> 
> > <asm/sigcontext.h> has SVE_MIN_VL.  Maybe we can use that everywhere
> > these days?
> 
> I partly wanted the vector type neutral name, and I'm considering
> modifying the sysfs ABI file to define 0 as a valid vector length for
> consistency with accepting -1 as the maximum since SME doesn't have any
> architected guarantees as to which particular vector lengths are defined.

I see what you mean, but it is more than mere coincidence that this is
the same value as SVE_MIN_VL.

You could view SVE as defining the base architecture which SME then
extends.

Perhaps

#define ARCH_MIN_VL SVE_MIN_VL	/* architectural minimim VL */

would be neutral enough.  Anyway, I won't lose sleep over it.

> > > +/* Verify that we can write a minimum value and have it take effect */
> > > +void proc_write_min(struct vec_data *data)
> 
> > Could be proc_write_check_min() (though the "check" is a bit more
> > redundant here; from "write" it's clear that this function actually
> > does something nontrivial).
> 
> TBH I'm not sure people will be excssively confused by the idea that a
> test would validate the values it was trying to read or write were
> accurate.

It's not 100% clear that this is a test until one has read all the way
to the end of the file.  But now that I understand the pattern here I
wouldn't be too concerned, and the comment accurately describes what the
function does.

> 
> > > +/* Can we read back a VL from prctl? */
> > 
> > It's certainly possible.
> 
> The comment is describing what the test is verifying.

Ignore that, I somehow read the comment as something like

	[TODO] Can we read back a VL via ptrace?

which is not what the comment says.

> > Since this would test different kernel paths from getting the child
> > itself to do RVDL / PR_SVE_GET_VL, it would be a different test though.
> > I think this diff is still good, but beefing up the ptrace tests to do
> > the appropriate checks would be good too (if we don't have that already).
> 
> Yes, the ptrace stuff could have a bit more coverage.
> 
> > > +	proc_write_min,
> > > +	proc_write_max,
> 
> > Can we also check what happens when writing unsupported values here?
> 
> We could.
> 
> > If this patch is more about establishing the framework, these could be
> > TODOs for now.
> 
> It definitely feels like something we can do incrementally.

Is it worth committing a TODO list somewhere?  There's always the
possibility that someone else gets interested and contributes some tests
for us; otherwise, at least it makes it harder to forget them.

> > Can we be a good citizen and restore sve_default_vector_length to its
> > original value?
> 
> We do that in the tests that fiddle with the default vector length, it
> seems useful to keep it at a value different from min and max as much as
> possible to increase the chance that we notice a failure to set things.

Ah right, I hadn't understood that proc_read_default() reads the default
and then the subsequent tests write it back.

This might be a bit clearer if the setup code was clearly separate from
the tests, but so long as the ordering requirements are clearly
documented that seems reasonably OK.

In:

> +test_type tests[] = {
> +	/*
> +	 * The default/min/max tests must be first to provide data for
> +	 * other tests.
> +	 */
> +	proc_read_default,
> +	proc_write_min,
> +	proc_write_max,

can you also comment that proc_read_default needs to come first among
these?

> +
> +	prctl_get,
> +	prctl_set,
> +	prctl_set_no_child,
> +	prctl_set_for_child,
> +	prctl_set_onexec,
> +};

[...]

Cheers
---Dave
