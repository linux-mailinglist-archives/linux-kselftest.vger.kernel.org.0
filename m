Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A1F7D87D5
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 19:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjJZRxt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 13:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZRxs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 13:53:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E742A90;
        Thu, 26 Oct 2023 10:53:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE63CC433C8;
        Thu, 26 Oct 2023 17:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698342826;
        bh=SZ0M7biq3ctrIFy2BWuggF9UsMOeq6C1UVNJ4cOuuUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OGFdh8AURIfxMKoMX5B2YfL/20hAhEtWjX2wiIpH3DeD6X5z+BJkIuSGsBEkoXoDw
         hSpM7YlvMC1N/mQY2Ran98Bm9cp+OrvOnwS93xXhhwCJec299N3itFbocP0LIr02rz
         MQZDfvJk3VjKM9ORdXx+4GNckAZyURx3DnYagBKOdYfNoLUIVgxQqAP0zr68ivzube
         44DMSl38ad0QvL2sJgCaGATcQYf20Yi/8cuaP+I37HCvsY5dpMiMQWcMNBlzSk6wrI
         UkTzD5yGKKUdytgm+vKcsqYOVTjJEhgQ2+JiTd6ZXQtHFk8YW5nMCIWXFsQLIELMy/
         +r4b/tW5x+sqg==
Date:   Thu, 26 Oct 2023 18:53:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jannh@google.com" <jannh@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "bsegall@google.com" <bsegall@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH RFC RFT 2/5] fork: Add shadow stack support to clone3()
Message-ID: <807a8142-7a8e-4563-9859-8e928156d7e5@sirena.org.uk>
References: <20231023-clone3-shadow-stack-v1-0-d867d0b5d4d0@kernel.org>
 <20231023-clone3-shadow-stack-v1-2-d867d0b5d4d0@kernel.org>
 <dc9a3dd544bbf859142c5582011a924b1c1bf6ed.camel@intel.com>
 <8b0c9332-ba56-4259-a71f-9789d28391f1@sirena.org.uk>
 <2ec0be71ade109873445a95f3f3c107711bb0943.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q+DyIvg4AWqTL3GB"
Content-Disposition: inline
In-Reply-To: <2ec0be71ade109873445a95f3f3c107711bb0943.camel@intel.com>
X-Cookie: I'm also against BODY-SURFING!!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--q+DyIvg4AWqTL3GB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 05:10:47PM +0000, Edgecombe, Rick P wrote:
> On Mon, 2023-10-23 at 19:32 +0100, Mark Brown wrote:

> > Right.=A0 We're already adding the cost of the extra map_shadow_stack()
> > so
> > it doesn't seem that out of scope.=A0 We could also allow clone3() to
> > be
> > used for allocation, potentially removing the ability to specify the
> > address entirely and only specifying the size.=A0 I did consider that
> > option but it felt awkward in the API, though equally the whole
> > shadow
> > stack allocation thing is a bit that way.=A0 That would avoid concerns
> > about placing and validating tokens entirely but gives less control
> > to
> > userspace.

> There is also cost in the form of extra complexity. Not to throw FUD,
> but GUP has been the source of thorny problems. And here we would be
> doing it around security races. We're probably helped that shadow stack
> is only private/anonymous memory, so maybe it's enough of a normal case
> to not worry about it.

> Still, there is some extra complexity, and I'm not sure if we really
> need it. The justification seems to mostly be that it's not as flexible
> as normal stacks with clone3.

I definitely agree on the complexity, trying to valdiate a token is
going to be more code doing fiddly things and there's always the risk
that something will change around it and invalidate assumptions the code
makes.  Particularly given my inability to test x86 I'm certainly way
more happy pushing this series forward implementing size only than I am
doing token validation.

> I don't understand why doing size-only is awkward. Just because it
> doesn't match the regular stack clone3 semantics?

Basically, yes - we don't allocate userpace pages in clone3() for the
normal stack and we do offer userspace control over where to place
things.  There was some grumbling about this in the current ABI from the
arm64 side, though the limited control of the size is more of the issue
really.

I'm not sure placement control is essential but the other bit of it is
the freeing of the shadow stack, especially if userspace is doing stack
switches the current behaviour where we free the stack when the thread
is exiting doesn't feel great exactly.  It's mainly an issue for
programs that pivot stacks which isn't the common case but it is a
general sharp edge.

> > This also doesn't do anything to stop anyone trying to allocate sub
> > page
> > shadow stacks if they're trying to save memory with all the lack of
> > overrun protection that implies, though that seems to me to be much
> > more
> > of a deliberate decision that people might make, a token would
> > prevent
> > that too unless write access to the shadow stack is enabled.

> Sorry, I'm not following. Sub-page shadow stacks?

If someone decides to allocate a page of shadow stack then point thread
A at the first half of the page and thread B at the second half of the
page nothing would stop them.  There are obvious issues with this but I
can see someone trying to do it in a system that creates lots of
threads and has memory constraints.

> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/*
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * This doesn't valid=
ate that the addresses are
> > > > mapped
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * VM_SHADOW_STACK, j=
ust that they're mapped at
> > > > all.
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */

> > > It just checks the range, right?

> > Yes, same check as for the normal stack.

> What looked wrong is that the comment says that it checks if the
> addresses are mapped, but the code just does access_ok(). It's a minor
> thing in any case.

Oh, I see, yes.

--q+DyIvg4AWqTL3GB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU6p6AACgkQJNaLcl1U
h9A3Pwf8Cx/yHRC+zQt/rkwSj4HCvlwTPerplXmFQCQIJbiMf9oFaplULq2JmsMf
S7lCREV/wMKQp1Un90F2iD/bXWYS651zMAVyRlXbh634djAnhskeZTUvaY9b/mbw
XEUzmNy1dpC/iXuwaRs2tEklKHafXECgZtFl5pAh0E9QyeDRHOz34ufb4CLZmzq8
SuPL/3JX/DbzUGJAgArtSeNahcye2wD6nbokdyxa4R/ytUCFQET9eAqvOhx8v1eY
K2OuWJqVL+NA4s2d4PeYqsLQ025iH7trmG30AoDllM2WH9sVlRwqPzWWnRb9FZjC
NFKUl2laCh1gdAk1KF6MASZLdehqPQ==
=wVjo
-----END PGP SIGNATURE-----

--q+DyIvg4AWqTL3GB--
