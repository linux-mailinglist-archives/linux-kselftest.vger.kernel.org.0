Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC872599F2
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Sep 2020 18:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbgIAP1Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Sep 2020 11:27:24 -0400
Received: from foss.arm.com ([217.140.110.172]:43580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730195AbgIAP1V (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Sep 2020 11:27:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 579D91045;
        Tue,  1 Sep 2020 08:27:20 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5733C3F71F;
        Tue,  1 Sep 2020 08:27:19 -0700 (PDT)
Date:   Tue, 1 Sep 2020 16:27:17 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/6] selftests: arm64: Add floating point selftests
Message-ID: <20200901152716.GZ6642@arm.com>
References: <20200819114837.51466-1-broonie@kernel.org>
 <cd9979be-34a3-375d-0fa1-61937337ca14@linuxfoundation.org>
 <20200901132159.GA3579@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901132159.GA3579@willie-the-truck>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 01, 2020 at 02:21:59PM +0100, Will Deacon wrote:
> On Mon, Aug 31, 2020 at 03:45:46PM -0600, Shuah Khan wrote:
> > On 8/19/20 5:48 AM, Mark Brown wrote:
> > > This series imports a series of tests for FPSIMD and SVE originally
> > > written by Dave Martin to the tree. Since these extensions have some
> > > overlap in terms of register usage and must sometimes be tested together
> > > they're dropped into a single directory. I've adapted some of the tests
> > > to run within the kselftest framework but there are also some stress
> > > tests here that are intended to be run as soak tests so aren't suitable
> > > for running by default and are mostly just integrated with the build
> > > system. There doesn't seem to be a more suitable home for those stress
> > > tests and they are very useful for work on these areas of the code so it
> > > seems useful to have them somewhere in tree.
> > > 
> > > v2: Rebased onto v5.9-rc1
> > > 
> > > Mark Brown (6):
> > >    selftests: arm64: Test case for enumeration of SVE vector lengths
> > >    selftests: arm64: Add test for the SVE ptrace interface
> > >    selftests: arm64: Add stress tests for FPSMID and SVE context
> > >      switching
> > >    selftests: arm64: Add utility to set SVE vector lengths
> > >    selftests: arm64: Add wrapper scripts for stress tests
> > >    selftests: arm64: Add build and documentation for FP tests
> > 
> > Patches look good to me from selftests perspective. My acked by
> > for these patches to go through arm64.
> > 
> > Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> Thanks, Shuah.
> 
> > If you would like me to take these through kselftest tree, give
> > me your Acks. I can queue these up for 5.10-rc1
> 
> Given there are a few arm64 kselftests series pending at the moment, I'll
> queue them in the arm64 tree, but on their own branch in case you end up
> needing to pull it in as well. I'll drop you a note once I've done that
> (I'm just starting to queue stuff this week).
> 
> Will

FWIW,

Acked-by: Dave Martin <Dave.Martin@arm.com>

I haven't gone through the integration in detail, but nothing leaps out
as disastrously wrong.


I'm not sure how useful these tests are to people in general, but
they've been valuable for maintaining the FP context switch code on
arm64.  I think it makes sense to keep them alongside the kernel so that
they don't get get lost.

Cheers
---Dave
