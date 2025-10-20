Return-Path: <linux-kselftest+bounces-43570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D42D0BF2AF1
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 19:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 884394F75EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 17:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D0C32F75B;
	Mon, 20 Oct 2025 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2t9lGOf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED25B3EA8D;
	Mon, 20 Oct 2025 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980913; cv=none; b=Q9vuFL/XuNmAC88v3ZSxvgNKIp4vQMF/LAb7WG9AorFo/1BV1s/R6c9wnl/1z+TOBxfaBBprPLY5xSkOPaylPzTHXLX+Z/BiL3AyA20Bx4xFbY9ZoB2HnqMK+ZpmGKguqURvS4jHYJpbBrpuajKzblTAQ0CaYVstGVh8v/cyvs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980913; c=relaxed/simple;
	bh=C8eG7PMjUaKTBS6LaCf8Tbd0+/VSPq+6Aua09Qgzo+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4O8xfKkdyF8AC+jXe9KWdDqfsGDubZNHerPbAnhsCQyL2k0rbduxSbjX8HwPm5JXCQ9mZjLOJqkAf387UhEjHZGxUCKUPWcly/XeYevs4CtVXd/D+3OSYXunW3856hO9itTMbrcgE2ksSo1Y9k5w1Ob4HddBh8JhOr8fzeAohg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2t9lGOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F6AC4CEF9;
	Mon, 20 Oct 2025 17:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760980912;
	bh=C8eG7PMjUaKTBS6LaCf8Tbd0+/VSPq+6Aua09Qgzo+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U2t9lGOfNY6Lkx20w2fVB4DPLQ7RNQAT5k/Gy1bRzoMuCqKvcONn9R5Q8SaF6Mp0u
	 k5ouH3HNB9g4K8O+zH6Hok3sFRVzqmySNOvidRwN0G43JXPWbn08n/8sTz8wOFY0Od
	 cjmgS652cobnqMLIWBdx7bjZ9VFEwQX1vJW79Ew9BTcGy9P35lRWrtRMlCuW+fZx+U
	 /ARWcluXqvCoCLKKW805/Q/cvcm2UAjm6fgf8slnos9VTFSrAZ+Dy17ywAtwrJc4tQ
	 iBD9KrheD9J7RLnfsiuBJzsqz2En0BSGlcfaxC3mFJhPUDuC3z5PYgP5svbn7Fktoa
	 NNayKWfubeVcw==
Date: Mon, 20 Oct 2025 18:21:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: corbet@lwn.net, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, mark.rutland@arm.com,
	anup@brainfault.org, atish.patra@linux.dev, pbonzini@redhat.com,
	shuah@kernel.org, parri.andrea@gmail.com, ajones@ventanamicro.com,
	brs@rivosinc.com, guoren@kernel.org, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
	apw@canonical.com, joe@perches.com, lukas.bulwahn@gmail.com
Subject: Re: [PATCH v4 02/10] dt-bindings: riscv: Add Zalasr ISA extension
 description
Message-ID: <20251020-kelp-trustful-1c07c69cd534@spud>
References: <20251020042056.30283-1-luxu.kernel@bytedance.com>
 <20251020042056.30283-3-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BFPQpvVg8gUO11Ws"
Content-Disposition: inline
In-Reply-To: <20251020042056.30283-3-luxu.kernel@bytedance.com>


--BFPQpvVg8gUO11Ws
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--BFPQpvVg8gUO11Ws
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPZvqQAKCRB4tDGHoIJi
0hvXAP9MBxNLwQ6EaW26x/57UgbQ5Ohba3hlU7D3bJB9ReuoPwEA89307tQnz5Yg
euZ/obSdJwA33QQLg4HfL//+TgpQAwM=
=orfO
-----END PGP SIGNATURE-----

--BFPQpvVg8gUO11Ws--

