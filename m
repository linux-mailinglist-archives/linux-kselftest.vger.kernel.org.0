Return-Path: <linux-kselftest+bounces-39404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA22B2E7F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 00:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319781C8858F
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 22:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287DA26F47D;
	Wed, 20 Aug 2025 22:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSwEfGU/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27B86FBF;
	Wed, 20 Aug 2025 22:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755728038; cv=none; b=UIJQPIPJsY0FqYMvzpAw7rS9f4xyA2Ktmvd/1NaVk7VMVososmlWVB1SSmFb3sbbTHhhnQNbjP5Ec0zVIH755rWNGD6DXrIk2jKLMjjTHFJMss4ZqKAxWoeH9gDsgqPDuk7SX2BKaQ2UP9wRJo64wlJsVJKxUYSkLvYhq7xX7+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755728038; c=relaxed/simple;
	bh=723mCQUWr4vd81W677iTRLHJxWJWtzlIUtHlOa32V2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7ovZxgKynayNwOM6ZxKxU3ZJEsJlc3FQ14WNGvJHlAnGqH0Fd758h1LFNx3FBkFGYkheVLWOy53X8lfF8DFe1Ih0uHU00cHTaAwdaVqLhKcL5ggjyyBtdlSfQ/5ZjL0L1I8AZjSswK8WLL/V3Zln7TJcieN6uBqQ0Ijy32NqNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSwEfGU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093ECC4CEE7;
	Wed, 20 Aug 2025 22:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755728037;
	bh=723mCQUWr4vd81W677iTRLHJxWJWtzlIUtHlOa32V2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NSwEfGU/YJrPF3PALBhfdolw0CHUjRu08AInSQfl2oOFBo69/fuTXpzGZwvjoaJdB
	 rQYI4nMpqDfU9sxX15xmXjazClgIP2wxPYwwNa6I0VCbVYMGpWY/PEqRV0l5UXVrs9
	 U+Nci3ttrnIrMHvMkF/mWu3GjYDDzWJ94MN16eC6x3t+P6XGjoBLVQMsA9yU3e5Sm7
	 kPZHWAGTE1vGTiscwRLtNeTW/7xBYsZValPSquuhueO9073mlb5tWJW20d9g/AmkO5
	 bWu3H1/p9uEmQiEOvmob4rT6gGAGpSJ6Is7CdXGrvAwEHi/pp/xZCSHYBKLXZP8piE
	 NO7XFUVIJnmTg==
Date: Wed, 20 Aug 2025 23:13:52 +0100
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
Subject: Re: [PATCH v15 2/6] KVM: arm64: Manage GCS access and registers for
 guests
Message-ID: <6ea4127b-813d-49b0-9922-b5f298ca5f0e@sirena.org.uk>
References: <20250820-arm64-gcs-v15-0-5e334da18b84@kernel.org>
 <20250820-arm64-gcs-v15-2-5e334da18b84@kernel.org>
 <87o6s9k8ie.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JKL6PMQq5ZwIKYYm"
Content-Disposition: inline
In-Reply-To: <87o6s9k8ie.wl-maz@kernel.org>
X-Cookie: Whoever dies with the most toys wins.


--JKL6PMQq5ZwIKYYm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 20, 2025 at 10:06:49PM +0100, Marc Zyngier wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > In order to allow userspace to control availability of the feature to
> > guests we enable writability for only ID_AA64PFR1_EL1.GCS, this is a
> > deliberately conservative choice to avoid errors due to oversights.
> > Further fields should be made writable in future.

> I'm not sure what you mean by that. Making the feature field writable
> is only allowable if we have some level of support (and otherwise we
> should prevent both the feature being exposed, and the field being
> writable).

> So future fields being writable will only happen when the features are
> fully supported, and only then.

> Please clarify, or drop this altogether.

That's bitrot from earlier versions where we needed to enable
ID_AA64PFR1_EL1, the other versions were similar.  I'll remove these
stale references.

--JKL6PMQq5ZwIKYYm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmimSJ8ACgkQJNaLcl1U
h9ArWQf/eQm5fVrMcWS54gUdtfiVe/qKLMrda9FKLpovpB8GsKqKDBef8b7Mo0GZ
wv/jvtET+UErD1lSyfeYcMoKrjKryCkuA9/vbNs+pB3j/wo9/DS11IgYXyj+fy/h
EpFn4aJieXOnKMBAngpXM3ZcSpio/ZPVASw28Ux17L8gfmYcLmAgNC1XaxD6bj7x
+IsTvk7ekqeUGzFYeZVZetm76oozpkKRKV3N8X4d5YfPukP83y8HrDKJZp0yIklF
+tLpcqGjMgmEb8XMWdGNY5PwHzPeQou/Dx4Tn0+lilEJV8vOZDyJKSHeQDvjeZnV
EVWu21kCgBmxXm8RxEmGCalLJpYV3A==
=2ze9
-----END PGP SIGNATURE-----

--JKL6PMQq5ZwIKYYm--

