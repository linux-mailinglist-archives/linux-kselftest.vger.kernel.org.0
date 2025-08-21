Return-Path: <linux-kselftest+bounces-39604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C086B3084D
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 23:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA921BC5A38
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 21:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD942C0279;
	Thu, 21 Aug 2025 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pD1PJctA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5B3393DFA;
	Thu, 21 Aug 2025 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755811556; cv=none; b=SmqGKCdGADQGxE32L6Z6AEjMkMI/mIWhfs+iU8kpFbtEK2n6gdkU+Z0DtJQC1P3nU/av+9Ang7HBlgj8l5xIvFo6nsf5JH9SH+GxY2NohiQkPwX3uDtStifiDl93Vvreosky7LeJm/feMReheR6T9xdHjoasUUXhfFnr9m1mcJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755811556; c=relaxed/simple;
	bh=+Q8r/IpJLSBFIgkrEyE128JdbLX+nx0vcUqeZBoKrNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/cP0c/JPOqQteImQPUTwiJAPnu8hDOUdgnGW56mL9kIkelSFDF6Js+qYNYVFy/FKPzPwVf4yWgVD8Oon97YJKw9fvaYpZB8mYN2s4BYPLlgHpEpXcqgwg4GaVRxmsOnWAe3W70uxgRcdqQUvTTptOpuQ0MHJ7lbHKSMgOhRg4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pD1PJctA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD5AC4CEEB;
	Thu, 21 Aug 2025 21:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755811555;
	bh=+Q8r/IpJLSBFIgkrEyE128JdbLX+nx0vcUqeZBoKrNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pD1PJctAFEJ69To4v41TtyclO/w7OOhbzdeShybQoY78IUYgi9InihindHlQPz1mS
	 RDWYt+k9zmChtVD2neeSodbbnaxjWfLFMJJRGOt0J1JJcPjyYAtY5eG1ZUoIj+wuJ4
	 6ldPPkw1V+FD1dSlPxZiGt+TI3XA/wB99EW0kfmMrtqh69XokRelVhjNpuTXxju5e6
	 ZtTgjgUYLYQe7TiGes/+yuss9HqB3fQsC6J7xRzfh+EKBAC1GzDXxo/1xAgQ8De1QF
	 KrSuFURxk0QIlT4gCka0fv/vjpfjp8nvDmKIrcPRizyBJ4BJhptt2MdCn9AikQaCqz
	 OySzkfFMZy/hA==
Date: Thu, 21 Aug 2025 22:25:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 3/6] KVM: arm64: Forward GCS exceptions to nested
 guests
Message-ID: <e1c3bee5-6521-4dbd-a207-4ec3e4ff19fe@sirena.org.uk>
References: <20250820-arm64-gcs-v15-0-5e334da18b84@kernel.org>
 <20250820-arm64-gcs-v15-3-5e334da18b84@kernel.org>
 <87ldndk5c2.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="llrqpkiErFSNNE6q"
Content-Disposition: inline
In-Reply-To: <87ldndk5c2.wl-maz@kernel.org>
X-Cookie: Warp 7 -- It's a law we can live with.


--llrqpkiErFSNNE6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 20, 2025 at 11:15:25PM +0100, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > GCS can generate exceptions with an EC of 0x2D (GCS Data Check
> > Exception) when data validation checks fail.  When running a nested
> > guest which has access to GCS such exceptions can be directed from EL0
> > to EL2 and therefore need to be forwarded to the guest hypervisor, add
> > handling for this.

> Why is it so? A GCS exception from EL0 should be routed to EL1, no
> matter what (either this is an L1 guest with EL1 pretending to be EL2,
> or this is an L2 guest that has its own EL1).

> Can you describe the case where we need to reinject the exception?

I think I'd got myself confused while looking at the HCR_EL2.TGE case
thinking we enabled that in some case.  I can't now see what I was
looking at there, pretty sure I'm just mistaken - thanks for spotting
that, unless I work out what I was thinking I'll drop this.

--llrqpkiErFSNNE6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAminjt0ACgkQJNaLcl1U
h9DhBgf/W05P5KDqWX/JqdJjThleyVH7QJ1ZUGO+5QIqs7ZnsqlHdGl/KPWFFIc7
jqQBGtJ4BPARkr60Wcq/G1DI3kuGD/61a0PktBxAAMZvtfabDeRgKftQVMrBfa/U
zf88E/l6oAFCZQClYX4xprBoUSrG71rk4QemvoJrEbwkHXFIBptOEkRXPdWBcaHP
rjKiN7sSW6HxLsTuLXlLVN66V7D3RI03Fyw2Sj17wofhOUEd+5P5bET5RLeXSxRN
hEYPQqaF9t745NIwsmvD8b60HGUqOdEfAG9ZO+cW3enju+765GAqlajE8vMLxbeb
kNvV7xm23iBrTHRFUXxDOwhXIb75+g==
=3kBM
-----END PGP SIGNATURE-----

--llrqpkiErFSNNE6q--

