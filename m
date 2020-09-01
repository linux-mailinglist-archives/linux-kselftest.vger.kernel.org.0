Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F8D2596B4
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Sep 2020 18:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbgIAQGH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Sep 2020 12:06:07 -0400
Received: from foss.arm.com ([217.140.110.172]:44860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729211AbgIAQGD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Sep 2020 12:06:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18DE21045;
        Tue,  1 Sep 2020 09:06:03 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32FA13F71F;
        Tue,  1 Sep 2020 09:06:02 -0700 (PDT)
Date:   Tue, 1 Sep 2020 17:06:00 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 6/6] selftests: arm64: Add build and documentation for
 FP tests
Message-ID: <20200901160559.GC6642@arm.com>
References: <20200819114837.51466-1-broonie@kernel.org>
 <20200819114837.51466-7-broonie@kernel.org>
 <20200901153840.GA6642@arm.com>
 <20200901154702.GF6262@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901154702.GF6262@sirena.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 01, 2020 at 04:47:02PM +0100, Mark Brown wrote:
> On Tue, Sep 01, 2020 at 04:38:42PM +0100, Dave Martin wrote:
> 
> > I don't know whether this is worth following up with a TODO?
> 
> > Some things I was aware of:
> 
> Well volunteered :P
> 
> >  * The sve-test/fpsimd-test programs contain a lot of common
> >    boilerplate and could probably be merged together.
> 
> >  * A fair amount of the asm in sve-test/fpsimd-test could be converted
> >    to C, with -fgeneral-regs-only.  This would be helpful since the
> >    code is highly unmaintainable in its current form (I know, I've
> >    tried).  Calling library functions would still be a problem, but we
> >    might be able to lift a printf implementation and some basic syscall
> >    wrappers from elsewhere rather than reimplementing everything from
> >    scratch.
> 
> Or just keep the existing asm for the syscall/print wrappers.
> 
> >  * The sve-stress/fpsimd-stress scripts could likewise be merged.
> >    Also, doing the required process management from the shell seems a
> >    doomed enterprise and it never really worked 100% right.  Eventually
> >    it might be worth rewriting a common test driver for these in a real
> >    language.
> 
> >  * While the tests confirm that basic aspects of the SVE support don't
> >    explode, there is not a lot of checking that the kernel does the
> >    _correct_ thing -- so there's scope for improvement here if somebody
> >    gets around to it.
> 
> Yeah, more errors get trapped by the kernel's own internal checking than
> by the tests themselves.


OK, I can follow up with a patch so long as these points sounds
reasonable to you.  Either way, it's not urgent.

Cheers
---Dave
