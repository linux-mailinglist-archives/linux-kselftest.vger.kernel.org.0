Return-Path: <linux-kselftest+bounces-42490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AAFBA48A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 18:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4787E623025
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 16:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF5D231A41;
	Fri, 26 Sep 2025 16:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaJZ20ii"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78B81C6FE5;
	Fri, 26 Sep 2025 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902630; cv=none; b=Y123guHQ3P2E1VBNFI6fVG0g9K6ZTBVIJa+aRRhGqKgEGzZMMbGZQy+XiVW0MAZ4WEmr9ofgIXGmL4Ry83wAJIRTrAlE/e74k8Oa7Yzxt7fsmv8zwKQnrZBCPW4LOcwc90LgaQ5whjIItHLHtK7JbunJCRmuehnzKJ8ZsQwwPxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902630; c=relaxed/simple;
	bh=ObmcF4C+T8N19cVMniegJQo4RItlifGeuvtddMkK6z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcnrnLyq5BsH7kVMlSIwWYft/1uO0jc8bunCy89GVjdoMXlLu2M3te2yiAwSJOoPMOgcqs2I3Lz+aJY9CkXxTr3AlP60Idl9Im4yf66z3h4If59B+juKhUHrt5gXu/Na/T5EIJ2YYy0p9MPN+NdhhK+VyBQCgNwI1sS4vEFlzg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaJZ20ii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B590C4CEF4;
	Fri, 26 Sep 2025 16:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758902629;
	bh=ObmcF4C+T8N19cVMniegJQo4RItlifGeuvtddMkK6z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IaJZ20iiY2mQIh0cB0OB4arkaX3zvJNT7Y12tsG/xT6145aJm+eeF0koiHmITnQYH
	 FD7jngGj9n+y7KWyKr++bv9GT3d98mhoY4pQM/SWH4bjUxjnH6wIDrmQh11lmz8vmo
	 4UKBGeFCaoTxOy+oRrtHetBWssY0oxM6q+V+5CWVgN+6QoNCXm8qvBDhSf81syayDw
	 IAqY4eqIRhe90amXwEXOM8WVlevEvWyMIC/G4yFZSmL7kOmo/M4yfKlYvYwv1t4fQG
	 TOR+fEt4eWFP5hph1Lc+w14dCVWmEgfEPsUGqrlyW+2pw3PiUpbZ9u3xp+bc89z4DI
	 jg3JjyVbAJR8Q==
Date: Fri, 26 Sep 2025 17:03:43 +0100
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "yury.khrustalev@arm.com" <yury.khrustalev@arm.com>,
	"adhemerval.zanella@linaro.org" <adhemerval.zanella@linaro.org>,
	"nsz@port70.net" <nsz@port70.net>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"dalias@libc.org" <dalias@libc.org>,
	"jeffxu@google.com" <jeffxu@google.com>,
	"will@kernel.org" <will@kernel.org>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"codonell@redhat.com" <codonell@redhat.com>,
	"libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: [PATCH RFC 0/3] arm64/gcs: Allow reuse of user managed shadow
 stacks
Message-ID: <5c616340-2767-48f0-8727-326deebf718f@sirena.org.uk>
References: <20250921-arm64-gcs-exit-token-v1-0-45cf64e648d5@kernel.org>
 <760447dc3e5805bf5668e80a94bf32356e2eb2d3.camel@intel.com>
 <aNasTpkYm8n1AHZ7@arm.com>
 <04dc6271e11b453204255779fcd3c29573c9c296.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HdsstHaENm3Rb3lO"
Content-Disposition: inline
In-Reply-To: <04dc6271e11b453204255779fcd3c29573c9c296.camel@intel.com>
X-Cookie: Your canceled check is your receipt.


--HdsstHaENm3Rb3lO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 03:39:46PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2025-09-26 at 16:07 +0100, Yury Khrustalev wrote:

> > What do you mean by "a fuller solution from the glibc side"? A
> > solution
> > for re-using shadow stacks?=A0

> I mean some code or a fuller explained solution that uses this new
> kernel functionality. I think the scheme that Florian suggested in the
> thread linked above (longjmp() to the start of the stack) will have
> trouble if the thread pivots to a new shadow stack before exiting (e.g.
> ucontext).

Is that supported even without user managed stacks?

--HdsstHaENm3Rb3lO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjWuV4ACgkQJNaLcl1U
h9CB9Af6Amiwsbjop9BcOnSoURnplsrcG/pyYCUpMiraJ4DWRZ6JhT0gasKnabgY
9yaQ33czhMyB49aKN8F4vOJ76gTMrjxrpmTtoVTJXLAB2ws10n51XOTv+N8VkVO8
js1oOnxIHNwFLhk1uuCZ/W73//IUkUJiJOCHnlWqqrZUC4hLEoUYMe1O5kYK1fjB
Ij3ESrwUp17z++3luTdL0NQgoNNRy84yKA4cIq2XKN3thX2pzXS1t9KVpq+a6Z4o
hRoRE55SVe+AStC4C53L8gB2kbIRFc+yQ+KytuLhNOkPAJm+8aXlN0MOLcvfZI4p
JpBidc9QZrzn8pab6F3q8YNyOQeI1w==
=mecK
-----END PGP SIGNATURE-----

--HdsstHaENm3Rb3lO--

