Return-Path: <linux-kselftest+bounces-7493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607B189DFA3
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 17:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A121283327
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 15:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70FA13D2BA;
	Tue,  9 Apr 2024 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcO6XzOb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF0813BC15;
	Tue,  9 Apr 2024 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677750; cv=none; b=goO/yAekyvvzxosmxyDYWj+DT9o57vVHFklVvec5kvr+T73zZXCirJLEJQw+LhGMXWIibJVlJrKsffcHAjo5IAGTVD/XnIcU2g2Te7+GMnJbtwzMTRnvfeYGW62OaV9nh23tnW88esH5Jy/oYOxv6Jx1r7t31dNh4buJub+XVF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677750; c=relaxed/simple;
	bh=ggaHHuc2VG2fdrOMhbw4XnILVWpXV0g7RGQkl6nlwv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fg8KCiQOHu6XOC9CzZ/EOHhYBKwxVIChmoGUCC6nwagQ47Zt9KaMVf8dClCYFvZaYM3ombE2I9elTKFdOSiHAVDvpu5JaJ4txgZcNhnTV3r85ocofFmcfPmtx1JMh8CmsL29tyLLAIDH7FfxPcg7opYDHJQ4f9rM3+Opjtuu/+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcO6XzOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05969C43390;
	Tue,  9 Apr 2024 15:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712677749;
	bh=ggaHHuc2VG2fdrOMhbw4XnILVWpXV0g7RGQkl6nlwv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RcO6XzObc7wlgdxiDjy0f1wHeJ/xg90oJK1uvGdSoHGMh1uDr+/iRiQu11+OQMo4Q
	 sJVbfuMNUvyKdBlNhz0pFzDcPRsQRWgwCjoiC/5WC7ktrR5xGmTyH39axjMlKIWkBD
	 RoLLn6NtCxA4/EgdcW6ce1XZyV64uZgdpUFUW5KT4yIDRy/h0SnWdTjZN1/YZFglOO
	 ooFFV5hsQsFBynSxN5lYVTvFdQ1mYVB83rs42o/PTOwBdmwgjqH2N5lULzJiY8kv4y
	 PxoUnyv4L2D20qsLEHGbCn7fuFr44N1ZRwCjJc7e8WTO9o2xRMPJtm8/y77fjEyP7o
	 W4c1mQgm9bWnA==
Date: Tue, 9 Apr 2024 16:49:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Max Hsu <max.hsu@sifive.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 02/11] dt-bindings: riscv: Add Sdtrig optional CSRs
 existence on DT
Message-ID: <20240409-princess-hypnotic-7fd89aafa31d@spud>
References: <20240329-dev-maxh-lin-452-6-9-v1-0-1534f93b94a7@sifive.com>
 <20240329-dev-maxh-lin-452-6-9-v1-2-1534f93b94a7@sifive.com>
 <20240329-affidavit-anatomist-1118a12c3e60@wendy>
 <20240405-ebdb2943657ab08d2d563c03@orel>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S3RasL52JpCL7Ifu"
Content-Disposition: inline
In-Reply-To: <20240405-ebdb2943657ab08d2d563c03@orel>


--S3RasL52JpCL7Ifu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 05:59:41PM +0200, Andrew Jones wrote:
> On Fri, Mar 29, 2024 at 10:31:10AM +0000, Conor Dooley wrote:
> > On Fri, Mar 29, 2024 at 05:26:18PM +0800, Max Hsu wrote:
> > > The mcontext/hcontext/scontext CSRs are optional in the Sdtrig extens=
ion,
> > > to prevent RW operations to the missing CSRs, which will cause
> > > illegal instructions.
> > >=20
> > > As a solution, we have proposed the dt format for these CSRs.
> >=20
> > As I mentioned in your other patch, I amn't sure what the actual value
> > is in being told about "sdtrig" itself if so many of the CSRs are
> > optional. I think we should define pseudo extensions that represent
> > usable subsets that are allowed by riscv,isa-extensions, such as
> > those you describe here: sdtrig + mcontext, sdtrig + scontext and
> > sdtrig + hcontext. Probably also for strig + mscontext. What
> > additional value does having a debug child node give us that makes
> > it worth having over something like the above?
>=20
> Yeah, Sdtrig, which doesn't tell you what you get, isn't nice at all.
> I wonder if we can start with requiring Sdtrig to be accompanied by
> Ssstrict in order to enable the context CSRs, i.e.
>=20
>  Sdtrig          - support without optional CSRs
>  Sdtrig+Ssstrict - probe for optional CSRs, support what's found
>=20
> If there are platforms with Sdtrig and optional CSRs, but not Ssstrict,
> then maybe the optional CSRs can be detected in some vendor-specific way,
> where the decision as to whether or not that vendor-specific way is
> acceptable is handled case-by-case.

I think it's pretty reasonable to make sstrict a requirement for the
kernel's use of sdtrig. If we have some non-sstrict systems that do
implement these particular CSRs, then I guess we can add some psuedo
instructions then (and nothing would stop the sstrict systems also
specifying directly). If they're using some non-standard CSRs then
case-by-case I guess.

I'm just specifically not keen on adding extra dt properties that do
things we can already do with the ones we have!

--S3RasL52JpCL7Ifu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhVjbgAKCRB4tDGHoIJi
0uhaAQDa5o/BPeXShwDCWbzLtGoQJW9RQEEKp0v/Px0VcnBn/wEAtxi0+ePlahyg
iuqh+k0zlBfw0fgjAmUxXyvYlSonvAc=
=bIMw
-----END PGP SIGNATURE-----

--S3RasL52JpCL7Ifu--

