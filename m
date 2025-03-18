Return-Path: <linux-kselftest+bounces-29354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DBFA675D7
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 15:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202B54226DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 14:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2882320DD71;
	Tue, 18 Mar 2025 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arIkXsvl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22EF21364;
	Tue, 18 Mar 2025 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306513; cv=none; b=OVP1HssYiIQYltgpf426CaY9xnLkpUAzuvOVB3o1hm38XI6m+Vr3nLfmbUY5EijBQD4zOog01sx5DvgGCb4TKTWcvjB+5zModx7fm4I1rpMKHbvKRkLQj5vQsL9gIRPtrmT7+XPpkkF2dYuyq2dCnbLwoTQd675XGa4kG99Tt94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306513; c=relaxed/simple;
	bh=qrsfuSTdWgHF4sFYhwU6FgFYYBFj8TCjyhoY/gUNj18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCKkeRQbCFiM0U0uqe5G5XLEE/fFTOecvgrpB8ngtbDR942T8gp4acFh6w9a+z5zOJidqrmqTRl+T8K7RrrSgUvd29MFhjixoJ8mUWr1nBas5rBFT5Kdc+auWtIDOWzLWugMclaOUbTZbu3FVUwthdFsLSBzUImPOvnM7RMHjyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arIkXsvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6A6C4CEDD;
	Tue, 18 Mar 2025 14:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742306512;
	bh=qrsfuSTdWgHF4sFYhwU6FgFYYBFj8TCjyhoY/gUNj18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=arIkXsvlpBIOPpzsVbVKH7cxUl3LLAXPTdus0y4tsVLS0P6YxWFBe3qWClegb9nWT
	 TX4kFUrgGoJSKBeqqGGvkPg2W6Pewn2l2DKXOebBvJNv+fTBNCOpS2mRxxPMzZeoTH
	 7ia/nP3/1GXK88vRga9w4lukKONJvPmAewTVh89VNBHtwEvWPYnNEb8aaaJsvOgG2v
	 Ssx0TCmawTUUiP9fhPrEdfdwaI4IZIRf9vDhSfW4xY2boJHw9Qx1VWgRR5F8sFtF1v
	 p0r1vYeVt6Tzmk1j8/gisPG4R5mFqW9AQVSf2tQ8h6hYOwOLU480l+c/wv1OGwNmlN
	 hFyg4ZXKwcNDA==
Date: Tue, 18 Mar 2025 14:01:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, Aishwarya.TCV@arm.com,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH] rseq/selftests: ensure the rseq abi TLS is actually 1024
 bytes
Message-ID: <78518446-083c-4db1-8c96-61fd49eddd8e@sirena.org.uk>
References: <20250311192222.323453-1-mjeanson@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UttlkzIHsrVPa/RY"
Content-Disposition: inline
In-Reply-To: <20250311192222.323453-1-mjeanson@efficios.com>
X-Cookie: I disagree with unanimity.


--UttlkzIHsrVPa/RY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 11, 2025 at 03:21:45PM -0400, Michael Jeanson wrote:

> Adding the aligned(1024) attribute to the definition of __rseq_abi did
> not increase its size to 1024, for this attribute to impact the size of
> __rseq_abi it would need to be added to the declaration of 'struct
> rseq_abi'. We only want to increase the size of the TLS allocation to
> ensure registration will succeed with future extended ABI. Use a union
> with a dummy member to ensure we allocate 1024 bytes.

This is in today's -next and breaks the build of the KVM selftests:

In file included from rseq_test.c:24:
/home/broonie/git/bisect/usr/include/linux/rseq.h:62:1: error: use of 'rseq' with tag type that does not match previous declaration
   62 | struct rseq {
      | ^
./../rseq/rseq.c:78:7: note: previous use is here
   78 | union rseq {
      |       ^
In file included from rseq_test.c:24:
/home/broonie/git/bisect/usr/include/linux/rseq.h:62:8: error: redefinition of 'rseq'
   62 | struct rseq {
      |        ^
./../rseq/rseq.c:78:7: note: previous definition is here
   78 | union rseq {
      |       ^

since unlike the rseq tests the KVM rseq test includes the UAPI header
for rseq which the padded union conflicts with.

--UttlkzIHsrVPa/RY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfZfMoACgkQJNaLcl1U
h9CbtQf/cN/+lBzMtmEisgCTECB8NE+CDl5aPxK9d5lYQf7mIwn+MZCeLl6WHIcA
fBSjRXFwsPlUwhbOpYIv0KABI04QF778sWKbx206+YMawNT4tFMf1DCXztYunryQ
Q+WNwAQr8KuodDVY8WyW2vXgN3gNNA2YRgGRjsDwBRvUoVUEalMm07o3dvCJJtqX
5o8h5sdV1VwvYEfxjw2ULiMcQbCRDNDtmVzhX12BawGhMGwmVHjBFIF31pLuvRt3
ARUEiZhv5H8K7e/iha5OmJOnwo9xsr0TRg93xrskKgc92YMEqQrM6r/OMPclwN+I
sN/yG+PTblylmdSL2T86XxClXEYjZA==
=0ixX
-----END PGP SIGNATURE-----

--UttlkzIHsrVPa/RY--

