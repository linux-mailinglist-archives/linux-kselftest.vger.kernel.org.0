Return-Path: <linux-kselftest+bounces-42584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01553BA9D86
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 17:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70B227A4E74
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 15:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B126830ACF1;
	Mon, 29 Sep 2025 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxuNIqIS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86947301015;
	Mon, 29 Sep 2025 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759160863; cv=none; b=l+gcYueZSvSBQHTsySuXi0vU/IG4+d89jfb4Dndm/yy11lJy1vWz5YM42z3lvqn3FtVui5PHM7ZeAicXAS/q7QFy1SllexyqG81CCto48iEI8oCK/g+3UXgyzCT2Z65HVumrodAtx2xdTVImGLPTX+qlgcCfZfqxvZGv1O86EPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759160863; c=relaxed/simple;
	bh=URoRiJpvfzY/qJO4BWJD2PxiH4IP1gLR8iG4C2gTC4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGFtKqO6v89qkZQTj9nbEJMIrJ1gNflM4hqdRSolvHqxCqDos6r/SdlKQHQzD/tqQ1mtPMCOt/4DboX/YG8WJIPxtVf3BqYnGsN2fB16YYpct44LbuAPlB9JVWfEu80EHH5XNyxFN/p2bYDC0TSTOHuCFeic6qIw7Z5S19Awuys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxuNIqIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B373C4CEF4;
	Mon, 29 Sep 2025 15:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759160863;
	bh=URoRiJpvfzY/qJO4BWJD2PxiH4IP1gLR8iG4C2gTC4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PxuNIqIS/y7SFX7DqksrGpsfRi9OmW7w639bH4FW/ongQuHKKAzK/QBZSW+olYIz5
	 FTxX7MSXzTPgjY/QcTjdIqQCZ2ojwg/kzzik0fz+w31Z3NG6RMiXeOThNCLfR6b9pI
	 DlwUsmMHbnMoe78TDnk7tYxes59781XRKoMtE9QTJL6zMMAJJWr7Mt7jRdrT4x2sf8
	 XFlBEfm1l8KYAB3v6l2LDNC+jfrtjFMbLSC/qFAaG6aKtP1E1enccObKCzYHc9wSTn
	 v/4FlelTf8huZjN2kdlZIHn+2uz1YxOAIb+5KDpZ18q0YlnHjWO3XvHI3UdSgvz/M3
	 NqqegVZIdoG4w==
Date: Mon, 29 Sep 2025 16:47:36 +0100
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "adhemerval.zanella@linaro.org" <adhemerval.zanella@linaro.org>,
	"nsz@port70.net" <nsz@port70.net>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"dalias@libc.org" <dalias@libc.org>,
	"jeffxu@google.com" <jeffxu@google.com>,
	"will@kernel.org" <will@kernel.org>,
	"yury.khrustalev@arm.com" <yury.khrustalev@arm.com>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"codonell@redhat.com" <codonell@redhat.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: [PATCH RFC 0/3] arm64/gcs: Allow reuse of user managed shadow
 stacks
Message-ID: <edd79fba-c5e0-4020-aef3-57dc01c077d2@sirena.org.uk>
References: <20250921-arm64-gcs-exit-token-v1-0-45cf64e648d5@kernel.org>
 <760447dc3e5805bf5668e80a94bf32356e2eb2d3.camel@intel.com>
 <aNasTpkYm8n1AHZ7@arm.com>
 <04dc6271e11b453204255779fcd3c29573c9c296.camel@intel.com>
 <5c616340-2767-48f0-8727-326deebf718f@sirena.org.uk>
 <80f8389c5c136ce21d922be10e4978d1ae5f1139.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TB4gd7jcOJO5ieTv"
Content-Disposition: inline
In-Reply-To: <80f8389c5c136ce21d922be10e4978d1ae5f1139.camel@intel.com>
X-Cookie: Stay away from hurricanes for a while.


--TB4gd7jcOJO5ieTv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 07:17:16PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2025-09-26 at 17:03 +0100, Mark Brown wrote:
> > On Fri, Sep 26, 2025 at 03:39:46PM +0000, Edgecombe, Rick P wrote:

> > > > What do you mean by "a fuller solution from the glibc side"? A
> > > > solution
> > > > for re-using shadow stacks?=A0

> > > I mean some code or a fuller explained solution that uses this new
> > > kernel functionality. I think the scheme that Florian suggested in
> > > the
> > > thread linked above (longjmp() to the start of the stack) will have
> > > trouble if the thread pivots to a new shadow stack before exiting
> > > (e.g.
> > > ucontext).

> > Is that supported even without user managed stacks?

> IIUC longjmp() is sometimes used to implement user level thread
> switching. So for non-shadow stack my understanding is that longjmp()
> between user level threads is supported.

Yes, that was more a "does it actually work?" query than a "might
someone reasonably want to do this?".

> For shadow stack, I think user level threads are intended to be
> supported. So I don't see why a thread could never exit from another
> shadow stack? Is that what you are asking? Maybe we need to discuss
> this with the glibc folks.

There's a selection of them directly on this thread, and libc-alpha on
CC, so hopefully they'll chime in.  Unless I'm getting confused the code
does appear to be doing an unwind, there's a lot of layers there so I
might've got turned around though.

> Again, I'm just thinking that we should vet the solution a bit more
> before actually adding this to the kernel. If the combined shadow stack
> effort eventually throws its hands up in frustration and goes with
> WRSS/GCSSTR for apps that want to do more advanced threading patterns,
> then we are already done on the kernel side.

Some more input from the glibc side would indeed be useful, I've not
seen any thoughts on either this series or just turning on writability
both of which are kind of orthogonal to clone3() (which has been dropped
=66rom -next today).

--TB4gd7jcOJO5ieTv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjaqhgACgkQJNaLcl1U
h9CVxQf/eWHRRunA9pDbxljpsxxDZVq5oza9BFSJWETarOjElVwdpN0C1zOuNgV9
Of4pK7kfkOO7cGw5HNxZlCvk/ixi78Fw7K9EA2WPxKb6JsbbCB6C2ZeCNNl112Y2
yBSweBPKCMLVl/hjC8vE5RjPX0K5eNsifF1FT75fvouXnl0vrUE1dG160d0C1dps
3Cy5m1OS4AiqHJFWNmm3j6wXDSwpuWjcJXQWG7A7+5ZZvlbxv8u2ThZ1xs77NgGZ
ZRteYOMjf6cjg0E+yexveJn7Ld/IMo6iz2NAgJV7Fk4iNkQiKRaT52ultSgwvdsK
CY3CZYU96MfAGENjVVWWwjWuxTJaEw==
=J5MO
-----END PGP SIGNATURE-----

--TB4gd7jcOJO5ieTv--

