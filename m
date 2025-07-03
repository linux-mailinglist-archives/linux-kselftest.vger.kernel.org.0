Return-Path: <linux-kselftest+bounces-36419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80505AF71F3
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 13:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1290E4A11C3
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 11:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D27729B789;
	Thu,  3 Jul 2025 11:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fe3QCXwD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EB4B676;
	Thu,  3 Jul 2025 11:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751541547; cv=none; b=F3OHijfE1m7Fx8ycY4XAmTJkmBgixZY4YpPiVSGD76ks6XwmNj7GMqUq7K2iUdyNMrWCFULxyWYJIQJNMYt0R4TIMz3OCtRObJR38FnDk1N/+aUQFnTDAt2owGNzHzowkXGu3vdp/ySJXSngQOzgYlnaXG5Yj2vOSDqpkR+iZ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751541547; c=relaxed/simple;
	bh=nyCHXu44AYG125jm9G4lxVXvhWsTPk95gOqRhQ+06NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqJFGoMRIn4dyjUHe+DJqM7V7zcmdMCCCainAoj0/MNVNnsVLTf2aSsvq4wce/gUpfG/rkEvSl4GmLRGwWZc5KUMLHYY47n6qh83KhfENL7f8UQxfqODB2l3qsEX4d9G1OzSQ6vXfsNYOUy8gZ7djiZSHxzwDyU+3iVNASHZxAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fe3QCXwD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35068C4CEE3;
	Thu,  3 Jul 2025 11:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751541546;
	bh=nyCHXu44AYG125jm9G4lxVXvhWsTPk95gOqRhQ+06NQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fe3QCXwDlnP9CTt7wsSz3leRINY1NfRDcuUqgjhzQjbVEX2TU5IlTrFXp8DoZrtk0
	 C70I6Hk7cBHS7fE/SvXIpvfMjRKAzsA/ildfa6+PCtSSHVkcgYiooXTGxZUzwvb94D
	 7p/c5slT+/29VUHj4OMrMa7FE5xU8x4XUvYS68LdRZpUDLcRm+Bd3jMrPhA14T59UO
	 At0u2pD4ESSRcZY4QNGxRxGUVaI81nSVO135BXF6tWXIJwVb1y9IMWt2qQHHIteDyy
	 JuWqneQo59bdxnqVlWCz/MqC/NvJyKojZ+6/Lgdp2EezsfcePI2N0XF1XqO+nMWlmc
	 XsMO8GZBY+ncw==
Date: Thu, 3 Jul 2025 12:19:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Christian Brauner <brauner@kernel.org>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/4] kselftest/arm64: Add a test for vfork() with GCS
Message-ID: <6aa6e38a-c874-45ac-b2bd-c876cdd9c8a9@sirena.org.uk>
References: <20250610-arm64-gcs-vfork-exit-v2-0-929443dfcf82@kernel.org>
 <20250610-arm64-gcs-vfork-exit-v2-3-929443dfcf82@kernel.org>
 <aGZd0vdu8PpLKfX1@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rGV4m2bsRAZx+JSb"
Content-Disposition: inline
In-Reply-To: <aGZd0vdu8PpLKfX1@arm.com>
X-Cookie: Uh-oh!!  I'm having TOO MUCH FUN!!


--rGV4m2bsRAZx+JSb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 03, 2025 at 11:39:14AM +0100, Catalin Marinas wrote:
> On Tue, Jun 10, 2025 at 01:29:46PM +0100, Mark Brown wrote:

> > +		exit(ret);

> Should this be _exit() instead? IIRC exit() does some clean-ups which
> are not safe in the vfork'ed child.

This test is written to nolibc so that we don't get any of that libc
level stuff, but yeah it would be a bit more correct.

--rGV4m2bsRAZx+JSb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhmZyQACgkQJNaLcl1U
h9C3sQf/Zjyv/4tU0gG1+behcSAImRmsr++fqj4ba2/X9B+mbKG26y3hkGkNQ6eT
HhNBykYnmsG5nkBA8IEQ4sq8dhZrQ5HOs6k/Ez+n/ibeHm0GK024XG6qmUTEZ1ST
5ibrqVltjCSb6x4wBVpLm/zdQAR06toxHvUdA2Dk7dvlUUNkP1A+fmXdPC/F7wTl
MvSrq0LFIBJj6Ig0MC4BJorezR5en/omZKFJflypCmelM3CVsw1e6yGWpr1lm9cb
QFPLB3b50mtHcnspolCOpcbqpY1Io3mopOGA/Lasjs9L9tJ30MAGgRKNlrLy4Yij
5e6452XWIEVfUcKmLt79G8xYOi6K2Q==
=nUf4
-----END PGP SIGNATURE-----

--rGV4m2bsRAZx+JSb--

