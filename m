Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6734B59CB
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Feb 2022 19:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357411AbiBNSUX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Feb 2022 13:20:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357425AbiBNSUV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Feb 2022 13:20:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB356548B
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Feb 2022 10:20:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50D5EB815CC
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Feb 2022 18:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10DEC340E9;
        Mon, 14 Feb 2022 18:20:03 +0000 (UTC)
Date:   Mon, 14 Feb 2022 18:19:58 +0000
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
Subject: Re: [PATCH v11 06/40] arm64/sme: Provide ABI documentation for SME
Message-ID: <YgqdTv3Hq+H76Ml7@arm.com>
References: <20220207152109.197566-1-broonie@kernel.org>
 <20220207152109.197566-7-broonie@kernel.org>
 <YgVaTounTtunlGU6@arm.com>
 <YgVrbc4fFrA0Vjh2@sirena.org.uk>
 <YgaWmP+P7v9b2lLz@arm.com>
 <YganZni933HbRTmO@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YganZni933HbRTmO@sirena.org.uk>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 11, 2022 at 06:13:58PM +0000, Mark Brown wrote:
> On Fri, Feb 11, 2022 at 05:02:16PM +0000, Catalin Marinas wrote:
> > So in this case we consider the syscall interface as non-streaming (as
> > per the PCS terminology). Should we require that the PSTATE.SM is
> > cleared by the user as well? Alternatively, we could make it
> > streaming-compatible and just preserve it. Are there any drawbacks?
> > kernel_neon_begin() could clear SM if needed.
> 
> In fact kernel_neon_begin() already disables PSTATE.SM since we need to
> account for the case where userspace was preempted rather than issued a
> syscall.  We could require that PSTATE.SM is disabled by the user,
> though it's questionable what we could usefully and helpfully do about
> it if they forget other than disable it anyway or generate a signal.
> 
> We could preserve PSTATE.SM, though since all the other register state
> for streaming mode is shared with SVE I would expect that we should be
> applying the SVE discard rules to it and there is therefore no other
> state that should be retained.

So when clearing PSTATE.SM, the streaming SVE regs become unknown (well,
the wording is a bit more verbose). I think this fits well with the
proposal to drop the streaming SVE state entirely on syscalls.

The ZA state I think is not affected by the PSTATE.SM change (early
internal SME specs were listing this as unknown after SM clearing but I
can't find it in the latest spec). However, after the syscall, the user
won't be able to execute SME instruction until turning on PSTATE.SM
again.

Would the libc wrappers preserve PSTATE.SM? What I find a bit confusing
is that we only partially preserve some state while in streaming mode -
the ZA registers but not the SVE ones. Is the user more likely to turn
PSTATE.SM on for ZA processing or for SVE? If the former, we don't want
to unnecessarily save/restore some SVE state that the user doesn't care
about (can we even trap SVE instructions independently of SME while in
streaming mode?).

I'd find it clearer if we preserved PSTATE.SM and, w.r.t. the streaming
SVE state, we somewhat follow the PCS and not restore the regs (input
from the libc people welcomed).

> As things stand this would either result
> in more overhead or complicate the register save and restore a bit since
> if we're in streaming mode we currently assume that we should save and
> restore the full SVE register contents but normally in a syscall we only
> need to save and restore the FPSIMD subset.  The overhead might go away
> anyway as a result of general work on syscall optimisation for SVE,
> though that work isn't done yet and may not end up working out that way.
> 
> Having said that as with ZA userspace can just exit streaming mode to
> avoid any overhead having it enabled introduces and the common case is
> expected to be that it will have done so due to the PCS, it should be an
> extremely rare case - unlike keeping ZA active there doesn't seem to be
> any case where it would be sensible to want to do this and the PCS means
> you'd have to actively try to do so.

IIUC, the PCS introduced the notion of streaming-compatible functions
that preserve the SM bit. If they are non-streaming, SM should be 0 on
entry. It would be nice if we put the syscalls in one of these
categories, so either mandate SM == 0 on entry or preserve (the latter
being easier, I think, I haven't looked at what it takes to save/restore
the streaming SVE state; I may change my mind after reviewing at the
other patches).

> > If PSTATE.ZA is valid and the user does a fork() (well, implemented as
> > clone()), normally it expects a nearly identical state in the child.
> > With clone() if a new thread is created, we likely don't need the
> > additional ZA state. We got away with having to think about this for
> > SVE as the state is lost on syscall. Here we risk having a vaguely
> > defined ABI - fork() is disabled on arm64 for example but we do have
> > clone() and clone3().
> 
> > Still thinking about this but maybe we could do something like always
> > copy the ZA state unless CLONE_VM is passed for example. It is
> > marginally more precise.
> 
> We should definitely write this up a bit more explictly whatever we do,
> like I say I don't really have strong opinions here.
> 
> There's also the interaction with the lazy save state to consider -
> TPIDR2 is cleared if CLONE_SETTLS is specified which would interfere
> with any lazy state saving that had already happened, though hopefully
> userspace is taking care of that as part of setting up the new thread so
> I think it's fine.

TPIDR2_EL0 should indeed be cleared in the child, it doesn't make sense
to start a thread with this reg pointing to a buffer in another thread
(not sure whether it needs to be tied to SETTLS but that works as well).

In fork()+execve() cases, it doesn't make sense to preserve ZA in the
child but we can't tell at fork/clone3() time. OTOH, it probably doesn't
make much sense to call clone3() with PSTATE.ZA set either, so such copy
would rarely/never happen in the kernel. We'd just carry some code for
the classic fork() case.

(few hours later) I think instead of singling out fork() (clone3()
actually), we can just say that new tasks (process/thread) always start
with PSTATE.ZA == 0, PSTATE.SM == 0 (tbd for this) and TPIDR2_EL0 == 0
irrespective of any clone3() flags (even CLONE_SETTLS). The C library
will have to implement the lazy ZA saving in the parent before the
syscall and the child will automatically recover the state if it follows
the PCS.

-- 
Catalin
