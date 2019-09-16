Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99DFEB3998
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2019 13:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfIPLlw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Sep 2019 07:41:52 -0400
Received: from foss.arm.com ([217.140.110.172]:43846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfIPLlw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Sep 2019 07:41:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41E551000;
        Mon, 16 Sep 2019 04:41:52 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AE6A3F59C;
        Mon, 16 Sep 2019 04:41:51 -0700 (PDT)
Date:   Mon, 16 Sep 2019 12:41:49 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Amit Kachhap <Amit.Kachhap@arm.com>
Cc:     Cristian Marussi <Cristian.Marussi@arm.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "andreyknvl@google.com" <andreyknvl@google.com>
Subject: Re: [PATCH v5 01/11] kselftest: arm64: add skeleton Makefile
Message-ID: <20190916114148.GI27757@arm.com>
References: <20190902112932.36129-1-cristian.marussi@arm.com>
 <20190902112932.36129-2-cristian.marussi@arm.com>
 <cce97298-7a27-c470-6fc5-873b4447ecc9@arm.com>
 <e7b7b3fe-aba8-a4f2-400b-7cdeebd080e8@arm.com>
 <0a284da1-ff63-dfe9-e479-6ad68865aea1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a284da1-ff63-dfe9-e479-6ad68865aea1@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 09, 2019 at 12:42:06PM +0000, Amit Kachhap wrote:
> Hi,
> 
> On 9/5/19 11:27 PM, Cristian Marussi wrote:
> > Hi Amit
> >
> > On 03/09/2019 10:26, Amit Kachhap wrote:
> >>
> >> Hi Cristian,
> >>
> >> On 9/2/19 4:59 PM, Cristian Marussi wrote:
> >>> Add a new arm64-specific empty subsystem amongst TARGETS of KSFT build
> >>> framework; keep these new arm64 KSFT testcases separated into distinct
> >>> subdirs inside tools/testing/selftests/arm64/ depending on the specific
> >>> subsystem targeted.
> >>>
> >>> Add into toplevel arm64 KSFT Makefile a mechanism to guess the effective
> >>> location of Kernel headers as installed by KSFT framework.
> >>>
> >>> Merge with
> >>>
> >>> commit 9ce1263033cd ("selftests, arm64: add a selftest for passing
> >>>                  tagged pointers to kernel")
> >>>
> >>> while moving such KSFT tags tests inside their own subdirectory
> >>> (arm64/tags).
> >>>
> >>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> >>> ---
> >>> v4 --> v5
> >>> - rebased on arm64/for-next/core
> >>> - merged this patch with KSFT arm64 tags patch, while moving the latter
> >>>     into its own subdir
> >>> - moved kernel header includes search mechanism from KSFT arm64
> >>>     SIGNAL Makefile
> >> This approach breaks the compilation of individual test cases which need
> >> to export includes individually.
> >>
> >> make -C tools/testing/selftests/arm64/signal
> >>
> >> ../../lib.mk:25: ../../../../scripts/subarch.include: No such file or
> >> directory
> >> Makefile:25: warning: overriding recipe for target 'clean'
> >> ../../lib.mk:123: warning: ignoring old recipe for target 'clean'
> >> make: *** No rule to make target '../../../../scripts/subarch.include'.
> >> Stop.
> >>
> >> However tags test works well,
> >> make -C tools/testing/selftests/arm64/tags
> >>
> >> aarch64-none-linux-gnu-gcc     tags_test.c  -o
> >> /home/amikac01/work/MTE_WORK/linux-server/linux/tools/testing/selftests/arm64/tags/tags_test
> >>
> >>
> >> Thanks,
> >> Amit Daniel
> >>
> >
> > So at the end I think I'll opt for the following in V6 regarding the issue of being able to build specific
> > KSFT arm64 subsystems while properly searching kernel headers (and keeping compatible with the KSFT
> > framework completely):
> >
> > - only arm64 toplevel KSFT Makefile searches for the kernel headers location for all and propagates down the info
> >
> > - you can also now optionally specify which arm64 subsystem to build (to avoid have to build, say, all of signal/
> >    if you are not interested into....a sort of standalone mode without all the burden of the old standalone mode)
> ok.
> >
> > So you can issue:
> >
> > $ make TARGETS=arm64 kselftest
> >
> > or similarly:
> >
> > $ make -C tools/testing/selftests TARGETS=arm64 \
> >                  INSTALL_PATH=<your-installation-path> install
> >
> > or select subsystems:
> >
> > $ make -C tools/testing/selftests TARGETS=arm64 SUBTARGETS="tags signal" \
> >                  INSTALL_PATH=<your-installation-path> install
> This option will be useful as it is better to compile just one subtarget
> in development phase.

Agreed, this seems a reasonable approach.

[...]

Cheers
---Dave
