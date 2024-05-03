Return-Path: <linux-kselftest+bounces-9386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F236F8BB1C8
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 19:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5172882E7
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 17:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C268157E78;
	Fri,  3 May 2024 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNa29oPu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DA0156C65;
	Fri,  3 May 2024 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714757225; cv=none; b=jSJpe6XtsWdJMybTkFLjIEkQXpkS/446wAWYqziovoRb7KZ9RH3HgpFnZSUauwWmtPwh2HZGEKP/D+jwLbDrrP1eX5jtmgEnc+jYuD5+EeePhJz+sx+taGCYqN75K92Vp/3CDc185W8GYHAK400c63UiqnQUcgQq52CWGJAxVjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714757225; c=relaxed/simple;
	bh=nGEZklClkgBR7BRosaj0yPV5zjkbbDrLHzYD/gw9AC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1tX5ecQLFd1vtWbhP/ExKOdE39oZ+exkq6luDdsKfNzAj2EaVZ9dPXSV/Ex1vMnzi01qrTCEvxdWUle3ShN/ruHjvv+Fjh4ZKe4VDwVF2gg1LuF1j2j1ucVrgrJitHguJ0y4mQCHbKdekfGVRhTr5MPxLKA5Y688A7PeS07rZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNa29oPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5F7C116B1;
	Fri,  3 May 2024 17:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714757224;
	bh=nGEZklClkgBR7BRosaj0yPV5zjkbbDrLHzYD/gw9AC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BNa29oPuBF1NYMCQTctSCetUcoanK9ZORjS4DtGu0fhqFLWJAwEw8Vjk0mDOqpURA
	 DaB6H54oNzJrRCkIkr9rNN8oP3M2LOfl+kyFet3PaSBwKduWXGpB93IpvvOv024h8f
	 K6KuKUJhb4QQGSInF1f2P66NQJiIVeqmFC2XsnsNian9lFI1n99N511rTqIxQgl+Ih
	 3VO2HveLvF2W6uugRvMfyyLkxGDwoMy4GGgVNxVr6PJE2hnHX+JRijSGmAWWh3c9cD
	 PyOvWKgyYVAVAszqkO8RJds3IqPY+5EkR8RAqB/JsXKZsesSy7yg8uwyoOAdrRuwFG
	 m6kI6fHJEa1tw==
Date: Fri, 3 May 2024 18:26:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 03/17] riscv: vector: Use vlenb from DT
Message-ID: <20240503-reviver-unify-b07f33cb6053@spud>
References: <20240502-dev-charlie-support_thead_vector_6_9-v5-0-d1b5c013a966@rivosinc.com>
 <20240502-dev-charlie-support_thead_vector_6_9-v5-3-d1b5c013a966@rivosinc.com>
 <20240503-zippy-skeletal-e5f63c9f17c1@spud>
 <ZjUbpKKobaLXhqPz@ghost>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/UUPLeA56FpcadHp"
Content-Disposition: inline
In-Reply-To: <ZjUbpKKobaLXhqPz@ghost>


--/UUPLeA56FpcadHp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 03, 2024 at 10:15:16AM -0700, Charlie Jenkins wrote:
> The DT is improperly
> formatted since it has heterogeneous vlenb entries and has V enabled,
> but since the user disabled V in the kernel skipping the warning is
> reasonable.

I wouldn't go as far as "improperly formatted", as if the harts really
do have differing vector lengths, it's correctly formatted. It's just
not something we support in Linux.

--/UUPLeA56FpcadHp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjUeYgAKCRB4tDGHoIJi
0k/kAQDEpgDHBn8tOwN0/14xdb9NcbMKBl4+/Ralt0/MHWhQMQEA5rEhU78uLQW6
Rb1OYeDRleOf59Xkg5uXzIq/CHsNzg0=
=xwgV
-----END PGP SIGNATURE-----

--/UUPLeA56FpcadHp--

