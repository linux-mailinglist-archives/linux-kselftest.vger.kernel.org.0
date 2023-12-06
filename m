Return-Path: <linux-kselftest+bounces-1309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FECB807786
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 19:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5141C20A90
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 18:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB7841847;
	Wed,  6 Dec 2023 18:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/YlAtrR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B701C41840;
	Wed,  6 Dec 2023 18:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF45C433C8;
	Wed,  6 Dec 2023 18:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701887076;
	bh=4ociTYjLoBrdbSLdAVJ6LzCaO53NQDE26UM1o9IZWZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s/YlAtrRmhrOz+dFkqxppDDn4K8as+geagP17kHHEvfOK0G7t80W7bf6IQ+OPfpsf
	 lZGBvYzkhbsLel8sAoRPlHGaNyIdiu9QLUsiWWyq1bHqrJOql8doifcUt3iDn5xeXt
	 nEWqo4cuOFsBmoLzBvCXmtJWmpBzThD6CjI9GO8feB+bn/blEyhK3N8qi+XFw6eAYF
	 LTtwk1Cj0pIJTy5OJTWCjlq9u4XKeOoR1O4oF66Ciz9hCs6paeWX7BIC4DrXC7FnD3
	 +McORAGD0rvebh34P2oPjP6a9ufDbCaSyKMZ3ttn7cA3NQ0YcQNa/ORu5/Wlr46tO0
	 Hab1jL6pQKfDA==
Date: Wed, 6 Dec 2023 18:24:27 +0000
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
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
Subject: Re: [PATCH RFT v4 2/5] fork: Add shadow stack support to clone3()
Message-ID: <e3019fc3-3b52-4067-973a-83a2b0e5ae2f@sirena.org.uk>
References: <20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org>
 <20231128-clone3-shadow-stack-v4-2-8b28ffe4f676@kernel.org>
 <61f80d032c6a630dd641c9b598b37c2eb40d51e8.camel@intel.com>
 <ed665d6f-66b0-4eeb-8cf8-db852e017d6a@sirena.org.uk>
 <47bb581c20010552615125fce63e3c5c49d1c690.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MP7fcSpsVuqtyKiU"
Content-Disposition: inline
In-Reply-To: <47bb581c20010552615125fce63e3c5c49d1c690.camel@intel.com>
X-Cookie: From concentrate.


--MP7fcSpsVuqtyKiU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 10:23:08PM +0000, Edgecombe, Rick P wrote:
> On Tue, 2023-12-05 at 15:51 +0000, Mark Brown wrote:

> > Hrm, right.=A0 And we then can't use do_mmap() either.=A0 I'd be somewh=
at
> > tempted to disallow that specific case for now rather than deal with
> > it
> > though that's not really in the spirit of just always following what
> > the
> > user asked for.

> Oh, yea. What a pain. It doesn't seem like we could easily even add a
> do_mmap() variant that takes an mm either.

> I did a quick logging test on a Fedora userspace. systemd (I think)
> appears to do a clone(!CLONE_VM) with a stack passed. So maybe the
> combo might actually get used with a shadow_stack_size if it used
> clone3 some day. At the same time, fixing clone to mmap() in the child
> doesn't seem straight forward at all. Checking with some of our MM
> folks, the suggestion was to look at doing the child's shadow stack
> mapping in dup_mm() to avoid tripping over complications that happen
> when a remote MM becomes more "live".

Yeah, I can't see anything that looks particularly tasteful.

> If we just punt on this combination for now, then the documented rules
> for args->shadow_stack_size would be something like:
> clone3 will use the parents shadow stack when CLONE_VM is not present.
> If CLONE_VFORK is set then it will use the parents shadow stack only
> when args->shadow_stack_size is non-zero. In the cases when the parents
> shadow stack is not used, args->shadow_stack_size is used for the size
> whenever non-zero.

> I guess it doesn't seem too overly complicated. But I'm not thinking
> any of the options seem great. I'd unhappily lean towards not

Indeed, it's all really hard to get enthusiastic about.

> supporting shadow_stack_size!=3D0 && !CLONE_VM for now. But it seems like
> there may be a user for the unsupported case, so this would be just
> improving things a little and kicking the can down the road. I also
> wonder if this is a sign to reconsider the earlier token consuming
> design.

In the case where we have !CLONE_VM it should actually possible to reuse
the token (since the user is in at least some sense the child process
rather than the parent) so it's less pure overhead, providing you don't
mind the children of a given parent all using the same addresses for
their initial shadow stack.

I'll have a poke at the various options and come up with something,
hopefully this month but it's getting a bit busy so might be early=20
next year instead.

--MP7fcSpsVuqtyKiU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVwvFoACgkQJNaLcl1U
h9BjkQf+IKy3MFuF8lImmAni+DxdD+Kaebr+6cdjuI4Q8xYb1rhMSU/IXfh6GAfk
9J2Fh673QpD3E871HljnXRD2XdevWJxeJjIz2y7vjYVelcrHS71vjvH/mxIJN4We
gS9enoXEJNwqWyssqMBIUnwGD+kWNs7wvz4cKhRSc1hNd6q7IWCJVGYwOjsoI9/c
8gaf+t7lMSgrVaWOgkAHafhXfo3yfWfzpDhYBJ9B29gfVpUlQOyvwASElNWyPnUR
Mgkw1SbfuSxCloqVgZBMq5/kuSg5wCAeyTKtPNkXh3Lxq8/7wIDzb3ioe/Vt0lnr
m5vMJhWEJhg2/P2arPbdNwZHuwxP4A==
=WH48
-----END PGP SIGNATURE-----

--MP7fcSpsVuqtyKiU--

