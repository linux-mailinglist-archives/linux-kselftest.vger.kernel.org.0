Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33047D3F48
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Oct 2023 20:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjJWScO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 14:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjJWScO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 14:32:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBDA8F;
        Mon, 23 Oct 2023 11:32:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BFAC433C7;
        Mon, 23 Oct 2023 18:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698085932;
        bh=RkVLKUy3lHtj5/FCpvUPMs8FlzIKFTNNSX2d4ml47IA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LdVb81zr9XVrjxvflTOcny5spcq34UIGzdDpbhSxwMhsHxRwmgCbfvkmX5W2GU7mn
         4P8I6By5a/Jw55pxxsdVDyXLWY9TK6uBfL9P1kHBzyL079z5zXtAkEijvmqDDIRmpc
         oYIVCjF0RjIaKSlt2W5umCCJfD+/TG8gqBtGbfmDVINJmwpG9vX+ert0p7IAkP8XII
         Yd/RZ+7uZjXy1xR82SxepkfVcXn5BNTrECqpRpIW+qN+Rc0jHZV8FxOgORr2AKIUwY
         yZovQ1IegTdf93WoudXFiSPpcRS9kzRzlQe6cKJ6z8uTg1VVucTOaO8X73DotjutOG
         EpDjIvau+z7DA==
Date:   Mon, 23 Oct 2023 19:32:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jannh@google.com" <jannh@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "bsegall@google.com" <bsegall@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH RFC RFT 2/5] fork: Add shadow stack support to clone3()
Message-ID: <8b0c9332-ba56-4259-a71f-9789d28391f1@sirena.org.uk>
References: <20231023-clone3-shadow-stack-v1-0-d867d0b5d4d0@kernel.org>
 <20231023-clone3-shadow-stack-v1-2-d867d0b5d4d0@kernel.org>
 <dc9a3dd544bbf859142c5582011a924b1c1bf6ed.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b9wCzZ+OwVsSPv1f"
Content-Disposition: inline
In-Reply-To: <dc9a3dd544bbf859142c5582011a924b1c1bf6ed.camel@intel.com>
X-Cookie: Never reveal your best argument.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--b9wCzZ+OwVsSPv1f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 04:32:22PM +0000, Edgecombe, Rick P wrote:
> On Mon, 2023-10-23 at 14:20 +0100, Mark Brown wrote:

> +Some security folks

I *think* I captured everyone for future versions but I might've missed
some, it's a long Cc list.

> > Add parameters to clone3() specifying the address and size of a
> > shadow
> > stack for the newly created process, we validate that the range
> > specified
> > is accessible to userspace but do not validate that it has been
> > mapped
> > appropriately for use as a shadow stack (normally via
> > map_shadow_stack()).
> > If the shadow stack is specified in this way then the caller is
> > responsible
> > for freeing the memory as with the main stack. If no shadow stack is
> > specified then the existing implicit allocation and freeing behaviour
> > is
> > maintained.

> This will give userspace new powers, very close to a "set SSP" ability.
> They could start a new thread on an active shadow stack, corrupt it,
> etc.

That's true.

> One way to avoid this would be to have shstk_alloc_thread_stack()
> consume a token on the shadow stack passed in the clone args. But it's
> tricky because there is not a CMPXCHG, on x86 at least, that works with
> shadow stack accesses. So the kernel would probably have to GUP the
> page and do a normal CMPXCHG off of the direct map.

> That said, it's already possible to get two threads on the same shadow
> stack by unmapping one and mapping another shadow stack in the same
> place, while the target thread is not doing a call/ret. I don't know if
> there is anything we could do about that without serious compatibility
> restrictions. But this patch would make it a bit more trivial.

> I might lean towards the token solution, even if it becomes more heavy
> weight to use clone3 in this way. It depends on whether the above is
> worth defending.

Right.  We're already adding the cost of the extra map_shadow_stack() so
it doesn't seem that out of scope.  We could also allow clone3() to be
used for allocation, potentially removing the ability to specify the
address entirely and only specifying the size.  I did consider that
option but it felt awkward in the API, though equally the whole shadow
stack allocation thing is a bit that way.  That would avoid concerns
about placing and validating tokens entirely but gives less control to
userspace.

This also doesn't do anything to stop anyone trying to allocate sub page
shadow stacks if they're trying to save memory with all the lack of
overrun protection that implies, though that seems to me to be much more
of a deliberate decision that people might make, a token would prevent
that too unless write access to the shadow stack is enabled.

> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/*
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * This doesn't validate =
that the addresses are
> > mapped
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * VM_SHADOW_STACK, just =
that they're mapped at all.
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */

> It just checks the range, right?

Yes, same check as for the normal stack.

--b9wCzZ+OwVsSPv1f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU2vCEACgkQJNaLcl1U
h9C7yAf/Wex57X2ItbXMBkB/tlZtlPV/eWmSdzt3hcphR2yiBfwUuyAZB5ZmtuD1
Bu3oBJNAjDRGJX5a0GALddAvS2puaEFb2cI8mV+YZQMelL5zjPzb6tYBQY62E9hS
XQiE6V5Veu2stm8hHpqGtey6rivIqA+TZYMs/UZ9PxKJ1ReB5S0ea43L06dQTypv
mLrS/2LVWfLuhRAE0HTT9Fn02VBWdSCIEN5PI7JBOAABFDsRe3AvSd9/7YU+KkBF
aPWk8PO1JNzzMOlYq047rjzGNxn2ejLwLo3bGED+C1wcyM6xxxLWW1OmVi+coOF4
iIJ7+3buyT7fHcaklDu1vRNvE8xLJA==
=lZsS
-----END PGP SIGNATURE-----

--b9wCzZ+OwVsSPv1f--
