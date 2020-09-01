Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5766258F0B
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Sep 2020 15:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgIANZy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Sep 2020 09:25:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbgIANWF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Sep 2020 09:22:05 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F19B20767;
        Tue,  1 Sep 2020 13:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598966524;
        bh=NyBYlco/JNLZMS+aKzmoMM9nULs46wwavVWBQ7eUyTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YurMTajYCVS45RPNj7kcIbxsJfXYwHmOvSWxrHoIh6to5KpmtCkyrPS+T1PuiGX2O
         1ZEeHPmqyhLrCHt2XHxBDfM8x4IbhT0OpvJBmXLfYasLi0MjjWUPsHRm6gxa+sFhPK
         ce6F+P4PWDF84iuE/PgG2f1K5OQhtyZhwonsW1VE=
Date:   Tue, 1 Sep 2020 14:21:59 +0100
From:   Will Deacon <will@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/6] selftests: arm64: Add floating point selftests
Message-ID: <20200901132159.GA3579@willie-the-truck>
References: <20200819114837.51466-1-broonie@kernel.org>
 <cd9979be-34a3-375d-0fa1-61937337ca14@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd9979be-34a3-375d-0fa1-61937337ca14@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 31, 2020 at 03:45:46PM -0600, Shuah Khan wrote:
> On 8/19/20 5:48 AM, Mark Brown wrote:
> > This series imports a series of tests for FPSIMD and SVE originally
> > written by Dave Martin to the tree. Since these extensions have some
> > overlap in terms of register usage and must sometimes be tested together
> > they're dropped into a single directory. I've adapted some of the tests
> > to run within the kselftest framework but there are also some stress
> > tests here that are intended to be run as soak tests so aren't suitable
> > for running by default and are mostly just integrated with the build
> > system. There doesn't seem to be a more suitable home for those stress
> > tests and they are very useful for work on these areas of the code so it
> > seems useful to have them somewhere in tree.
> > 
> > v2: Rebased onto v5.9-rc1
> > 
> > Mark Brown (6):
> >    selftests: arm64: Test case for enumeration of SVE vector lengths
> >    selftests: arm64: Add test for the SVE ptrace interface
> >    selftests: arm64: Add stress tests for FPSMID and SVE context
> >      switching
> >    selftests: arm64: Add utility to set SVE vector lengths
> >    selftests: arm64: Add wrapper scripts for stress tests
> >    selftests: arm64: Add build and documentation for FP tests
> 
> Patches look good to me from selftests perspective. My acked by
> for these patches to go through arm64.
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks, Shuah.

> If you would like me to take these through kselftest tree, give
> me your Acks. I can queue these up for 5.10-rc1

Given there are a few arm64 kselftests series pending at the moment, I'll
queue them in the arm64 tree, but on their own branch in case you end up
needing to pull it in as well. I'll drop you a note once I've done that
(I'm just starting to queue stuff this week).

Will
