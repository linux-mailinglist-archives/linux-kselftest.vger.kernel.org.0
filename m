Return-Path: <linux-kselftest+bounces-16523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AE696256C
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 13:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DB84B23E86
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 11:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167271662FD;
	Wed, 28 Aug 2024 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdB7lBpH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B1415B143;
	Wed, 28 Aug 2024 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724842900; cv=none; b=Wobz2yg7vuJgID9ucQjhxzhBdILD4VREpr6/M3EODScvm6H1FB5vYs867AUEXlUOwq2+aQ2QW3YvhDpYAtPjXfJqczA1NNEgG7yqe8ibX/Q2is0AR+YZ+zmQ9I9jvT3si2F1zKloslFI/4cIDmOzP85ebpZYfuLDd5dUchpT0eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724842900; c=relaxed/simple;
	bh=aAq7Jo9rst7OO5Q0HmdUuzWR+q5darrY1K5g+/n4DdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBTzoxr926s72t1FNkikU27jVMVKccoTXL6GQdL5Ll0hvb9JTOgmqnZT0aXHzEkuMYurnceM0WId6baetztHNj+AE1UI5/mTfWYVCwgOZhd4/T6WnfGMIdU5b7oc/xFxzOOifJz0Pc8w2skMX5YiweAIJQcK2r41BzaVgJateZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdB7lBpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1E2C4FF19;
	Wed, 28 Aug 2024 11:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724842898;
	bh=aAq7Jo9rst7OO5Q0HmdUuzWR+q5darrY1K5g+/n4DdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WdB7lBpHb45VmASYdwe6j0fVic8XqRSblqFmqv7IUqCXXetJPtGQWF6ADoERbELCt
	 Hh7yJjv5iVfhGUcNsD7o5G2iFAuANs6o6cqJMxKw23Xgf9jNDn+BOHo0m1p3qcmOl6
	 vBKOrBaDTCqc/mN+yDeQR8GEcyzyhv/A6J6Dlq3jZgEuJFSIfXEBY7td9UTsk7Vvli
	 YHxeqHk0Y+H7F3+faHRUCrO4Pcm0ClJGSf1HflQs2dH7z729r6t9cGdirPCEU9nYUp
	 C4rWW/dyCBc/Vo666txvLJaZBam+7QM4jkcsj26VmSNDdsO//x7MpUPYMF+0friFCD
	 0hhyN0igHZXaw==
Date: Wed, 28 Aug 2024 12:01:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, Catalin.Marinas@arm.com,
	ryan.roberts@arm.com, Anshuman.Khandual@arm.com,
	aneesh.kumar@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/arm64: Fix build warnings for abi
Message-ID: <c808efdf-fc78-40c3-90bf-948f65a6d133@sirena.org.uk>
References: <20240827051851.3738533-1-dev.jain@arm.com>
 <20240827123347.GC4679@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Lm19OG8IMFqYLhy7"
Content-Disposition: inline
In-Reply-To: <20240827123347.GC4679@willie-the-truck>
X-Cookie: You are number 6!  Who is number one?


--Lm19OG8IMFqYLhy7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 27, 2024 at 01:33:47PM +0100, Will Deacon wrote:
> On Tue, Aug 27, 2024 at 10:48:51AM +0530, Dev Jain wrote:
> > A "%s" is missing in ksft_exit_fail_msg(); instead, use the newly
> > introduced ksft_exit_fail_perror(). Also, uint64_t corresponds to
> > unsigned 64-bit integer, so use %lx instead of %llx.

> What's wrong with using %llx for a uint64_t? I think that part of the
> code is fine as-is.

IIRC there's some printf format specifiers specific to uint64_t which
are probably a better choice here.

--Lm19OG8IMFqYLhy7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbPA4wACgkQJNaLcl1U
h9Bw6Af9HQqe7pO0pmCJrqDwJ7A8MW1GXX+wMbHBhZzSbN1h0j0DuCd/RrO7Ip05
g+PUYV/2DdLpfsGTB09apSgnHMle2/M08oVNuRIuRJgkshPTp29SXRXpY+mv4CQI
ul8fZa35XVIN6aGmmLrXgBZ+nKm8/AwkwkkOLfPDhD6aDB2/6ZtrWQuo7JU+dpwn
XbYDs/rhczGoKfW38/5E9wQ2VX+xZ7NkMQmox73ZRahU7enMuvKOayA2CLdyp12Q
+RYAJs0J0uDasIP57NCtKBtrw47M6Kk7Gqw7pbNKwRnOO3NoKjfr6tZlC3vg0G8I
t/iT+u2Rgny5zyzCnOFw+yJTQLiQkg==
=OoG3
-----END PGP SIGNATURE-----

--Lm19OG8IMFqYLhy7--

