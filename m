Return-Path: <linux-kselftest+bounces-48500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB1BD02CCD
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 13:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E443306529F
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 12:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB8044A70A;
	Thu,  8 Jan 2026 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gztWuRWW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2956B43E49A;
	Thu,  8 Jan 2026 11:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873283; cv=none; b=hFAhWc8njk0DP6j840r055cygyzdEWdZMYiSTaCyLjq2Lh2Z0hvfEchlLVyoTdY0gL9+RsTZtAF8VxW5kSYgVO9/EV7qpUUsf1DuS5HUpb879AQiDohhPquk3TQUIj+mTn+O5Zyr+jy9uICleCXExqbUrzxwJcLWOyAEujR2cro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873283; c=relaxed/simple;
	bh=2QEBB0tMTbcvjFiR3Bb1wbKlZRI1fz02/DZZV9eNhGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWzMXGwYvZqKkPdRrkCjmcoxO3qZQkf7WN4fDckejdioq7va7ShQmSPGaab5roMbbJWBNUi+HRF/9i/7Gd7/iHjkjAQCky8ZwtX1ydlSOzsCGSbJsGSNXdfKrWanrroyvQnApMgHWnhk43x3hedSGiQ9lr9vasR3Azx/frT0pSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gztWuRWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EECC116C6;
	Thu,  8 Jan 2026 11:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767873282;
	bh=2QEBB0tMTbcvjFiR3Bb1wbKlZRI1fz02/DZZV9eNhGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gztWuRWWWZMayVuI+eb83hb3O95TWjuvXHPnEaq9PU++6FKFEs9agoO8gkYWsLZoQ
	 AUiOfOAzMknl1KMV1WWRlutba9l6uoUNrHhvu0FBq2uFDn5jpUBzNuZfUQG+FaWQiy
	 TQrhqyCltaiDZV7MUi4zRKt5lBONbDFu79sjvv63PnDEqWgZx4+WeSFhIbcWa3ZLyd
	 ccZlJiz329makknk+Pp+h3XLmy4RCnWlzOneHdEprUjri/PYwlvjwZMRdmhPX44NwX
	 UD4KU7TcamImNx7mzmBzSxb5xMoKo//IO2Ns/eUIaBFOYPgElqwojBE81i/eviy23g
	 LZPpq0A0TAzqw==
Date: Thu, 8 Jan 2026 11:54:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Fuad Tabba <tabba@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Oliver Upton <oupton@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v9 02/30] arm64/fpsimd: Update FA64 and ZT0 enables when
 loading SME state
Message-ID: <3c8b4a5e-89f4-47e0-9a5d-24399407db0c@sirena.org.uk>
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
 <20251223-kvm-arm64-sme-v9-2-8be3867cb883@kernel.org>
 <CA+EHjTxdSnpFHkm6o85EtjQjAWemBfcv9Oq6omWyrrMdkOuuVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sEpEXEQvmS/iAzMe"
Content-Disposition: inline
In-Reply-To: <CA+EHjTxdSnpFHkm6o85EtjQjAWemBfcv9Oq6omWyrrMdkOuuVA@mail.gmail.com>
X-Cookie: If you suspect a man, don't employ him.


--sEpEXEQvmS/iAzMe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 07, 2026 at 07:25:04PM +0000, Fuad Tabba wrote:
> On Tue, 23 Dec 2025 at 01:21, Mark Brown <broonie@kernel.org> wrote:

> > +#define sme_cond_update_smcr(vl, fa64, zt0, reg)               \
> > +       do {                                                    \
> > +               u64 __old = read_sysreg_s((reg));               \
> > +               u64 __new = vl;                                 \
> > +               if (fa64)                       \
> > +                       __new |= SMCR_ELx_FA64;                 \
> > +               if (zt0)                                        \
> > +                       __new |= SMCR_ELx_EZT0;                 \
> > +               if (__old != __new)                             \
> > +                       write_sysreg_s(__new, (reg));           \
> > +       } while (0)
> > +

> Should we cap the VL based on SMCR_ELx_LEN_MASK (as we do in
> sve_cond_update_zcr_vq())?

Yes, although I fear if we've got to the point where we've ever got a
bigger value going in we're going to have bigger problems.

> Should we also preserve the remaining old bits from SMCR_EL1, i.e.,
> copy over the bits that aren't
> SMCR_ELx_LEN_MASK|SMCR_ELx_FA64|SMCR_ELx_EZT0? For now they are RES0,
> but that could change.

My thinking here is that any new bits are almost certainly going to need
explicit support (like with the addition of ZT0) and that copying them
forward without understanding is more likely to lead to a bug like
exposing state we didn't mean to than clearing them will.

--sEpEXEQvmS/iAzMe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlfmvYACgkQJNaLcl1U
h9C5wgf9G+XKmo011/eubfLKJPyBw+Fnrf+TV1a7La9Ua9nDLvYoLuH2+ogXAq0J
Y2jWf3r7uTwF23+nOLzN6uyqWmqu0RHeW9LSOk4wDgqJDNNnA4UwpNauRFdfFQgd
5ANBOv6nviVTd0TpmjfCD2OoFKvbx+VHFXoonEsPFCSneA9IHd/8N21I/0q6sSr4
+5BKfPAr6d0Gk9NS3w1CRfB3XkOcG4Jf/vbJ1fjszfznHkWG1xV0R081qLd+GcDE
fXUJjF6YAttCNEd57BrKpHNENZnNcNYwW5OvWhsUMG7N754fVb5utrd6b6Rd4xGf
XcUYMxOkTJpeO7vgmY5AHpVUzXiVfA==
=JsxG
-----END PGP SIGNATURE-----

--sEpEXEQvmS/iAzMe--

