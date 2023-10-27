Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB887D9C81
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 17:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346139AbjJ0PFi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 11:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjJ0PFh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 11:05:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C40FC4;
        Fri, 27 Oct 2023 08:05:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFB2C433C7;
        Fri, 27 Oct 2023 15:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698419135;
        bh=6DZb3YA47Tj4rWwCUYdaQTqFi0PaTzEpzyXKXZEANKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IldsEiFBj4G8bFlHXmKFlE+eUMVgVikT3NgQFmOcR8SacS3pqo7bvRekw039Esax4
         3FgDWRcqT/4xdsUDIjm7LOKo6qObo+FUmOq51f+MAJA1gKNTg1BnC5z36Wt/PKhy42
         /ppg7WET2RC5CucQufQLZr22UiIlTyhqFBqK+z7DIx4VLRa9H4xaQPEnmdt09GyX38
         tUazlq8ar5etBziJs7z0JrfekI/2+hI1TasBwBeZPlQTlmryXjGSAaehyY/TkZFFRn
         2HXCfwSOI3JMe+sUZEAhZMJGXenQ+N0DsEJFsciTf4envhDeTVMWpTkWI+5EJIquX/
         DlVueeyZDnC2A==
Date:   Fri, 27 Oct 2023 16:05:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>
Cc:     Deepak Gupta <debug@rivosinc.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
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
Message-ID: <ZTvRuK1uxbfjjWyr@finisterre.sirena.org.uk>
References: <20231023-clone3-shadow-stack-v1-0-d867d0b5d4d0@kernel.org>
 <20231023-clone3-shadow-stack-v1-2-d867d0b5d4d0@kernel.org>
 <dc9a3dd544bbf859142c5582011a924b1c1bf6ed.camel@intel.com>
 <8b0c9332-ba56-4259-a71f-9789d28391f1@sirena.org.uk>
 <2ec0be71ade109873445a95f3f3c107711bb0943.camel@intel.com>
 <807a8142-7a8e-4563-9859-8e928156d7e5@sirena.org.uk>
 <ZTrOw97NFjUpANMg@debug.ba.rivosinc.com>
 <ZTuj565SqIb9KjQr@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iYamXeVK/ZDq+CMx"
Content-Disposition: inline
In-Reply-To: <ZTuj565SqIb9KjQr@arm.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--iYamXeVK/ZDq+CMx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 27, 2023 at 12:49:59PM +0100, Szabolcs.Nagy@arm.com wrote:
> The 10/26/2023 13:40, Deepak Gupta wrote:

> > In general, I am assuming such placement requirements emanate because
> > regular stack holds data (local args, etc) as well and thus software may
> > make assumptions about how stack frame is prepared and may worry about
> > layout and such. In case of shadow stack, it can only hold return

> no. the lifetime is the issue: a stack in principle can outlive
> a thread and resumed even after the original thread exited.
> for that to work the shadow stack has to outlive the thread too.

> (or the other way around: a stack can be freed before the thread
> exits, if the thread pivots away from that stack.)

> posix threads etc. don't allow this, but the linux syscall abi
> (clone) does allow it.

> i think it is reasonable to tie the shadow stack lifetime to the
> thread lifetime, but this clearly introduces a limitation on how
> the clone api can be used. such constraint on the userspace
> programming model is normally a bad decision, but given that most
> software (including all posix conforming code) is not affected,
> i think it is acceptable for an opt-in feature like shadow stack.

I tend to agree - software that's doing a lot of stack pivoting could do
something like allocate a small stack with clone3() and then immediately
pivoting away from it so they never actually use the stack that's tied
to the thread.  It's a bit clunky and wasteful but should work.

Since everyone seems OK with dealing with the placement issues by
specifying size only I'm planning on sending a new version that does
that after the merge window, assuming nobody else raises concerns.

--iYamXeVK/ZDq+CMx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmU70bUACgkQJNaLcl1U
h9D6DQf8DwMUjt+7+yvXg6kbkMf4F05kvLRL/c3h4p7Kqy6K8wQ78rycdYFYqE/3
cKDlS5Y2Cu8antdFPldSlObYFxJo7VAgGC0IL1IkJay2J+uerz3BzNReTuvLU82J
NL04R/znP08P8RUxbclaEjGQ/cfkYqLj+aNO3vLQyxscA7a3VkeZsdagcsB18tH7
OfivqAaI2+umntU0jJ7ixfVv0Xt/WlgHYyEPD9bLY8lCA6wHPnZ0RQ6NYDW0jhpg
L/7Nx/pdtVtogt+ko1IfiPmBKVdipTArRVGuc1nj2Ru3u6p0hexzZC25PsbViBNv
r0s5BMFEAuzQzv2Gs0866iKwfAY+gA==
=6Vdn
-----END PGP SIGNATURE-----

--iYamXeVK/ZDq+CMx--
