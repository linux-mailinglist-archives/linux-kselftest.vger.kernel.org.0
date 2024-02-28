Return-Path: <linux-kselftest+bounces-5557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BA386BA1B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 22:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5417A1C21B59
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 21:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEC670047;
	Wed, 28 Feb 2024 21:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEJfGmAr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111C170041;
	Wed, 28 Feb 2024 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709156321; cv=none; b=onMNo8W7bweuI253+zwOVZp/oUff2A5+Zh64fJr2Gy8BRps9X7bbvCpmuiNCx9FsB0tZ9fHSJvQnYXJ447W9/0Qmt5UVJ6Ct8wLTPtmHqMavSkK+5wGKfM/S141opJu2VRZWx2tBCroXmuMPyiLIroPGrxuoHax5GHoeAyZyjrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709156321; c=relaxed/simple;
	bh=U8ywN+/QncDricW1r5N+b+wUQnEUJQCcZiIU2QULtyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GorRGFjNC2ziK0crsC4CU00ZPadcd9iULO9VCQFaWo96EURzahdiIqkHmkFAA5BJT8FgRHd+iOXiwtfbbT7E7wroo69NWtSu4vLgxGkSXAUf7+rySVlMepAsizsPTf9IIPuwjLnMrM+tA0r2gCSC1SC+r/QPHpvz586TGP8MboY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEJfGmAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8B1C433C7;
	Wed, 28 Feb 2024 21:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709156320;
	bh=U8ywN+/QncDricW1r5N+b+wUQnEUJQCcZiIU2QULtyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZEJfGmArPh3XY8OOIjd+m5oualk77oyH+7LIpaLs+GExkgYdqCMIp3sz0dXvoKGaB
	 8M0Wn6kGjlo3vwq06rEEkqQFyVj9msUzEZmTJvjlD2EWpZEVam7up9Kz8G5yo4jLWq
	 QDl8FdnKBTFIfja0ZKFbkW3pCUplXar46+oHG0m1yL3pwqzEEOX/qzmk+C+zZOgTZy
	 YvzprWPMhDlTJe/YlQSLl6AUlaMRCfAJiYahgxI46wipIqjJEgafmIKnWoE7rnfQUm
	 o9eNDd0zyYS50OItAMHNgBwXW34CSDKfP5hcpyZpljTJpp1qkkEQI4HuwUmeMqAFPe
	 tT/1B4FNCNPkg==
Date: Wed, 28 Feb 2024 21:38:35 +0000
From: Mark Brown <broonie@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Aishwarya TCV <aishwarya.tcv@arm.com>
Subject: Re: [PATCH v3 3/8] KVM: selftests: Move setting a vCPU's entry point
 to a dedicated API
Message-ID: <f399a68a-ad9d-4734-b5da-25f5ce3b832e@sirena.org.uk>
References: <20240208204844.119326-1-thuth@redhat.com>
 <20240208204844.119326-4-thuth@redhat.com>
 <501ac94d-11ab-4765-a25d-75013c021be6@sirena.org.uk>
 <Zd-JjBNCpFG5iDul@google.com>
 <Zd-jdAtI_C_d_fp4@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SwDm9igrBxoRwCqa"
Content-Disposition: inline
In-Reply-To: <Zd-jdAtI_C_d_fp4@google.com>
X-Cookie: Function reject.


--SwDm9igrBxoRwCqa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 28, 2024 at 01:19:48PM -0800, Sean Christopherson wrote:

> I'll squash the above and force push.

Thanks, I'll give that a spin (likely tomorrow at this point).

> And another question: is there any reason to not force -Werror for selftests?

Enabling it by default can cause a bunch of fragility when people are
running different compilers, there's things like all the different clang
versions, and it's especially common to run into issues when you've got
a shiny new compiler on a modern distro but need to go look at older
kernels for some reason.  You then get issues bisecting things since you
get regions where the build was broken due to -Werror which may or may
not be pointing at the runtime issue you were looking for (particularly
likely to be hiding things if the build issue is in a different test).

--SwDm9igrBxoRwCqa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXfp9oACgkQJNaLcl1U
h9A9bwf/VnSj06MmEyM0O1ewUOdPy7uhrvuT68nO1/lvDe+rtaLIid4t9pEV/dCX
xVWT2JLrSU0tExy5RiX74TepZl9YIuWvZF1ErGoBOsd1zkJP6hmR/wDlqFoIxa6D
AA35wfE1FFJgvg7xLwFu2ViM05ZGfRIkpsI5Xfa0fgU2fyLNP5g4M3DJffVXC0Bs
ydCFydnLPiyCGEFBfU7i1IzxwmkU4yu8FvbqD4OXZ/zbDWcRlKys7TrnyrHTgHRm
oObROPpcc4yYdEDkSa5llyja1965xEqVqLCPF50Si181hnvcE4jTnj0kPZEJSJsj
k6gIX3jR9mFJyOarI1WbSPZFBOOIKg==
=MB1e
-----END PGP SIGNATURE-----

--SwDm9igrBxoRwCqa--

