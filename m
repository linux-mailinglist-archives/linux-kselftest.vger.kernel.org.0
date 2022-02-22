Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302274BF7EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Feb 2022 13:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiBVMKL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Feb 2022 07:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiBVMKL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Feb 2022 07:10:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D06815A204
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Feb 2022 04:09:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7F5CB8198B
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Feb 2022 12:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39F0C340E8;
        Tue, 22 Feb 2022 12:09:40 +0000 (UTC)
Date:   Tue, 22 Feb 2022 12:09:37 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v11 10/40] arm64/sme: Basic enumeration support
Message-ID: <YhTSgWRfEcn7ZVg1@arm.com>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-11-broonie@kernel.org>
 <YhOihgeVRTztfDqv@arm.com>
 <YhOpL54V9RAthj24@sirena.org.uk>
 <YhPnCx+Rajjverjc@arm.com>
 <YhQb6r0mVSYDHowo@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhQb6r0mVSYDHowo@sirena.org.uk>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 21, 2022 at 11:10:34PM +0000, Mark Brown wrote:
> On Mon, Feb 21, 2022 at 07:24:59PM +0000, Catalin Marinas wrote:
> > On Mon, Feb 21, 2022 at 03:01:03PM +0000, Mark Brown wrote:
> > > We do run the kernel in streaming mode - entering the kernel through a
> > > syscall or preemption will not change the streaming mode state, and we
> > > need to be in streaming mode in order to save or restore the register
> > > state for streaming mode.  In particular we need FA64 enabled for EL1 in
> > > order to context switch FFR when in streaming mode, without it we'll
> > > generate an exception when we execute the rdffr or wrffr.  We don't do
> > > any real floating point work in streaming mode but we absolutely need to
> > > run in streaming mode and only exit streaming mode when restoring a
> > > context where it is disabled, when using floating point in the kernel or
> > > when idling the CPU.
> 
> > So, IIUC, for Linux it is mandatory that FEAT_SME_FA64 is supported,
> > otherwise we won't be able to enable SME. Does the architecture say
> 
> The feature is not mandatory and we do not require it for Linux.  It is
> expected that many implementations will choose to not support FA64.
> 
> The only impact it has on the kernel is that if it's present then we
> need to enable it for each EL and then context switch FFR in streaming
> mode, the code is there to do that conditionally already.

OK, I get it. So FFR is only present if FA64 is supported.

> This is actually a bit awkward for not disabling streaming mode when we
> do a syscall since the disabled instructions include the FPSMID mov
> vector, vector instruction which we currently use to zero the high bits
> of the Z registers.  That issue goes away if the optimisations I've got
> for relaxed flushing of the non-shared SVE state that we discussed in
> relation to syscall-abi get merged, though it'd still be there if we add
> a sysctl to force flushing.  This is a solvable problem though, even if
> we have to use a less efficient sequence to flush in streaming mode.

I guess the simplest is to just disable streaming mode on syscall. The C
library would mark the syscall wrappers as not streaming compatible, so
whoever is calling them might disable SM anyway.

So I think your original proposal in the ABI doc is fine (I just need
the libc people to confirm ;)).

-- 
Catalin
