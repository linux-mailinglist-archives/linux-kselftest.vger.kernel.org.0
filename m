Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4623D8CD6
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 13:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbhG1LhF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 07:37:05 -0400
Received: from foss.arm.com ([217.140.110.172]:55398 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233394AbhG1LhF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 07:37:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A600131B;
        Wed, 28 Jul 2021 04:37:03 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE36F3F66F;
        Wed, 28 Jul 2021 04:37:02 -0700 (PDT)
Date:   Wed, 28 Jul 2021 12:35:42 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 2/3] kselftest/arm64: Validate vector lengths are set
 in sve-probe-vls
Message-ID: <20210728113542.GE1724@arm.com>
References: <20210727180649.12943-1-broonie@kernel.org>
 <20210727180649.12943-3-broonie@kernel.org>
 <20210728094151.GB1724@arm.com>
 <20210728110701.GC4670@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728110701.GC4670@sirena.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 28, 2021 at 12:07:01PM +0100, Mark Brown wrote:
> On Wed, Jul 28, 2021 at 10:41:51AM +0100, Dave Martin wrote:
> 
> > This test was originally a diagnostic tool, so the way VLs are probed
> > aims to be efficient, rather than being defensive against the kernel
> > doing weird stuff.
> 
> Yeah, the whole probing thing doesn't really fit into kselftest's idea
> of what a test is - I just put this in here since it seemed like a cheap
> extra validation that we could add in with little bother rather than
> because it's a complete and thorough validation of every possible thing
> that could go wrong.  I'd be just as happy to not modify this at all but
> since it does try the intermediate VLs it didn't seem like a terrible
> idea to throw in some validation while we're at it.
> 
> > If the kernel returns a vl > than the one we tried to set, we'll end
> > up in an infinite loop because of the way the loop deliberately uses the
> > kernel's return value to skip unsupported VLs.  So, it might be better
> > to probe every single architecturally possible VL and sanity check
> > everything instead.
> 
> Yup, that'd obviously be a complete rewrite though.  We'd not only need
> to probe every possible vector length, but also validate that any
> unsupported vector lengths report the expected vector length instead
> when we try them.

Fair enough, but is it worth dropping a comment in to clarify what this
does and doesn't test?  This could be an area for future improvement.

> > > +		if (rdvl_sve() != vl)
> > > +			ksft_exit_fail_msg("Set VL %d, RDVL %d\n",
> > > +					   vl, rdvl_sve());
> 
> > If this fails, the VL vl wasn't "Set" at all.  I found this a bit
> > confusing from just looking at this hunk.
> 
> > Can we write something like "PR_SVE_SET_VL reports VL %d, RDVL %d"?
> 
> Sure.
> 
> > I'm not sure of the correct option for forcing SVE off against the
> > compiler default -- check with the tools folks.  If there isn't a
> > proper way to do this, it's a toolchain defect so we should flag it up,
> > but -mgeneral-regs-only might work for us even though it's a bit of a
> > sledgehammer.
> 
> -march should do the trick (if it doesn't the base kernel already has
> issues).  This is a separate issue that affects all the arm64 selftests
> I think.

OK, if there's already precedent then I guess we can go with that.

Cheers
---Dave
