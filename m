Return-Path: <linux-kselftest+bounces-4159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FDF84A6CF
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 22:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C1EDB264CD
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 21:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BDE54F87;
	Mon,  5 Feb 2024 19:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nd5zm0nc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C008D55E6E;
	Mon,  5 Feb 2024 19:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160744; cv=none; b=PUpboPS6PN8NzhqjO2ea3n36OHcGC2hkYO3/6gX7Uv8P/bvZ3+iZyB3Q+rP4ahiza76UqL34IkuV9fkPXrtRkcLV3cTQ+OvF/bsdErngQSAqo5h+t6q0A0DIJgSLUOgAgR42Bg/A3Kie5Z4XptMrFofte4Z/BSBGgOl1atRCz9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160744; c=relaxed/simple;
	bh=rZHGOctIsEvjRWCOq7z4zGR9cZjW17vqL6xAeBZUzJU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Q3UyX6um92rmo8BfBFlQ4GH845BU/Jks/kPLydeL5twa1oUNF1kjCzCCDDm/tobpJ9A42d7T/gOAP2+AnLtko/99AypQs2ZPRHextpUQT8gIHY3bkfimHj7au7hHoIypVKnQ2f5tVSpXE6Y0+Q4VwM3DMc+bppl4ux6z96yx/Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nd5zm0nc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142AAC43394;
	Mon,  5 Feb 2024 19:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707160744;
	bh=rZHGOctIsEvjRWCOq7z4zGR9cZjW17vqL6xAeBZUzJU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=nd5zm0ncAhhGDHhu3rHoIDRrAqaTNw8VDmNRyF7/k2rLZw9pL2g1qLgkpjzHrbpuQ
	 4SUNIrj1K57a0eufKX4WDaOJYd2LqTN0drTYV7eX2+ZohOganiub6bAHoD/0Z/4rfO
	 NSxCZWMAqL+Jy4Ex8mh3c61U/hO+jFPZ6OEYrFIeh23wOvqhU82B8FrJDdBpk8Olsx
	 hujarPDCw/rDZp8FFWaHI222EDYGzFFC2kkFlyU9+awEUrMos5miE9hlMxBcZtlbBM
	 0TyUyQ+2l4P7bNKwrQF3wHuWDlJrPGsZtY5cfSAZRd3+TID5mWIq+GvelggU4mXlPr
	 nM9bn8GEhF6pw==
Message-ID: <89892ecd6b1b043db58258705c32b02b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABVgOS=A8BQ6HHpBKFqg-N10ckk2XYavaS-MPXvZ0wenrVm=1g@mail.gmail.com>
References: <20240202195909.3458162-1-sboyd@kernel.org> <20240202195909.3458162-8-sboyd@kernel.org> <CABVgOS=A8BQ6HHpBKFqg-N10ckk2XYavaS-MPXvZ0wenrVm=1g@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] of: Add KUnit test to confirm DTB is loaded
From: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Brendan Higgins <brendan.higgins@linux.dev>
To: David Gow <davidgow@google.com>
Date: Mon, 05 Feb 2024 11:19:01 -0800
User-Agent: alot/0.10

Quoting David Gow (2024-02-02 20:10:17)
> On Sat, 3 Feb 2024 at 03:59, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Add a KUnit test that confirms a DTB has been loaded, i.e. there is a
> > root node, and that the of_have_populated_dt() API works properly.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Cc: David Gow <davidgow@google.com>
> > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
>=20
> This looks pretty good to me test-wise, though it still fails on m68k.
> (Everything else I tried it on works, though I've definitely not tried
> _every_ architecture.)
>=20
> aarch64: PASSED
> i386: PASSED
> x86_64: PASSED
> x86_64 KASAN: PASSED
> powerpc64: PASSED
> UML: PASSED
> UML LLVM: PASSED
> m68k: FAILED
> > $ qemu-system-m68k -nodefaults -m 1024 -kernel .kunit-all-m68k/vmlinux =
-append 'kunit.enable=3D1 console=3Dhvc0 kunit_shutdown=3Dreboot' -no-reboo=
t -nographic -serial stdio -machine virt
> > [11:55:05] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D dtb (2 subtests) =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > [11:55:05] # dtb_root_node_found_by_path: EXPECTATION FAILED at drivers=
/of/of_test.c:18
> > [11:55:05] Expected np is not null, but is
> > [11:55:05] [FAILED] dtb_root_node_found_by_path
> > [11:55:05] # dtb_root_node_populates_of_root: EXPECTATION FAILED at dri=
vers/of/of_test.c:28
> > [11:55:05] Expected of_root is not null, but is
> > [11:55:05] [FAILED] dtb_root_node_populates_of_root
> > [11:55:05]     # module: of_test
> > [11:55:05] # dtb: pass:0 fail:2 skip:0 total:2
> > [11:55:05] # Totals: pass:0 fail:2 skip:0 total:2
> > [11:55:05] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D [FAILED] dtb =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Ah yeah I forgot to mention that. m68k fails because it doesn't call the
unflatten_(and_copy)?_device_tree() function, so we don't populate a
root node on that architecture. One solution would be to make CONFIG_OF
unavailable on m68k. Or we have to make sure DT works on any
architecture. Rob, what do you prefer here?

>=20
>=20
> My only other question is about the test names: the mix of 'of' and
> 'dtb' can be a bit confusing. As is, we have:
> kconfig name: OF_KUNIT_TEST
> module name: of_test
> suite name: dtb
> test names: all start with dtb_
>=20
> Given KUnit only really deals with the suite/test names directly, it's
> not trivial to see that 'dtb.dtb_*' is controlled by OF_KUNIT_TEST and
> in of_test if built as a module. (This is getting a bit easier now
> that we have the 'module' attribute in the output, but still.)
>=20
> Would 'of_dtb' work as a suite name if it's important to keep both
> 'of' and 'dtb'?

Sure, I can add of_ prefix to the tests.

>=20
> In general, though, this test looks good to me. Particularly if m68k
> can be fixed.
>=20
> Reviewed-by: David Gow <davidgow@google.com>
>=20

Thanks!

