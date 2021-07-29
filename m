Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306113DA8BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 18:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhG2QSw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 12:18:52 -0400
Received: from foss.arm.com ([217.140.110.172]:52068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229739AbhG2QSv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 12:18:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9167DD6E;
        Thu, 29 Jul 2021 09:18:48 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABA043F881;
        Thu, 29 Jul 2021 09:18:47 -0700 (PDT)
Date:   Thu, 29 Jul 2021 17:17:26 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/4] kselftest/arm64: Provide a helper binary and
 "library" for SVE RDVL
Message-ID: <20210729161726.GQ1724@arm.com>
References: <20210728163318.51492-1-broonie@kernel.org>
 <20210728163318.51492-2-broonie@kernel.org>
 <20210729095222.GH1724@arm.com>
 <20210729112217.GK4670@sirena.org.uk>
 <20210729132701.GH20179@e103592.cambridge.arm.com>
 <20210729160334.GQ4670@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729160334.GQ4670@sirena.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 29, 2021 at 05:03:34PM +0100, Mark Brown wrote:
> On Thu, Jul 29, 2021 at 02:27:04PM +0100, Dave P Martin wrote:
> > On Thu, Jul 29, 2021 at 12:22:17PM +0100, Mark Brown wrote:
> 
> > > Yeah, it doesn't seem to be in the slightest bit idiomatic for the arm64
> > > asm code the kernel has.  I don't know if you think it's worth adding
> > > that to SYM_FUNC_START now we have it though?
> 
> > Actually, I think the core definition of SYM_FUNC_END() in
> > <linux/linkage.h> does this.
> 
> Ah, so it does.
> 
> > It would be good to pick up the common linkage macros; if we have to
> > sprinkle .type manually all over the tests people will likely make
> > mistakes, to that's probably not worth it.
> 
> > If picking up the macros isn't trivial to do, I guess it's not that
> > important at this stage.
> 
> They're not exported from the kernel at all at the minute so that'd be a
> whole new block of work that feels out of scope here, we already have a
> stack of asm code in selftests.

Agreed.  Feels like it might be a good idea at some point, but it's
orthogonal to this series, and for now nothing breaks.

> > > that those are outside the kernel either.  We will have to do something
> > > like that if anyone starts building userspace with BTI though (or I
> > > might just shove a BTI C in there unconditionally, I'm sure we'll cope
> > > with the overhead on older systems).
> 
> > I thought about that, but that .S file isn't annotated as supporting
> > BTI, so I guess there's no problem for now(?)
> 
> True, we'll generate linker warnings but it should otherwise sort itself
> out unless someone forced BTI mode.  The whole annotation thing really
> isn't fun to deal with for assembly code, hopefully there'll be some
> toolchain improvements in this area at some point.

Ack

Cheers
---Dave
