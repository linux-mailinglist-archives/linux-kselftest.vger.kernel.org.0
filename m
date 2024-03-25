Return-Path: <linux-kselftest+bounces-6540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B65D88AA5F
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 17:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410C6304A07
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 16:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB3257320;
	Mon, 25 Mar 2024 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTRqXiHs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D2B639;
	Mon, 25 Mar 2024 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380098; cv=none; b=itoydLeu+wZKED6v+Z43QPLl6CjKV0ujFKYZNRlfALfR93pL102AEjBhoFFqx5qO2uqoJ2zCciMdBGrSNtf8jCOjSU12X6SAK2Dedv7k2nMeXV/VFjLAmFF2jeGi35kagllobR4aUp/mvUgu8qYn8sOaNssVYKfm/ifyEYmkjdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380098; c=relaxed/simple;
	bh=nY4hVvGQMxHzOXNFl4eMqa6h4MlskuWR4OIWfrnWYEU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JAoX40QoSPC8cn5mL7u4RHoJVsE2mab6rgbMrS+Dy0+GQyvHwBLhjy1oHvCzFiVuA+xAhz58XlWWEMrw5JbkUgbqKDrW78+jmTFMK8XANKDxl1y1+45rc+/PMurpvNGna1ENirNwZ15DCkxt5JpTbuMNCzWMw6SgHP8F+6cYAOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTRqXiHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE0FC433C7;
	Mon, 25 Mar 2024 15:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711380098;
	bh=nY4hVvGQMxHzOXNFl4eMqa6h4MlskuWR4OIWfrnWYEU=;
	h=Date:From:To:Cc:Subject:From;
	b=aTRqXiHskEDq61B+LVZg0Ll5GNrR6B8Wgtl+Elf2b5TK/uIA4BN2b1v+akafXaOyA
	 ziU2C/aaYO19xwlpxBSxlmO/8AN6rXZ0IiBvcICn0M6zSNt3sgmHHB1alqSMBx5ae+
	 Vcy4O8ooGE3wtRoo/pIkg7LBinkgec/RAxSzFsOxo2t1iXXmWreq5w5oEN42imVyRM
	 izHgY2f8U3dvxMHkxKtbIBBwFb619PJgLGoGWIk0RLQQLALW3J1/7oreXzwoaAmASR
	 urn+4E6zGg+/KpiEAjktVYDzJoCdmbmx9tW6EAg4BQx/25D1DCdkDw/hvoQ8zUmY9y
	 2FlM9Q+1XKvtA==
Date: Mon, 25 Mar 2024 15:21:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Johannes Berg <johannes.berg@intel.com>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, x86@kernel.org
Subject: kunit alltests runs broken in mainline
Message-ID: <b743a5ec-3d07-4747-85e0-2fb2ef69db7c@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zIto0On63gACKm7s"
Content-Disposition: inline
X-Cookie: Evil isn't all bad.


--zIto0On63gACKm7s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Commit 28b3df1fe6ba2cb4 ("kunit: add wireless unit tests") which I can't
seem to find on lore breaks full kunit runs on non-UML builds and is now
present in mainline.  If I run:

   ./tools/testing/kunit/kunit.py run --alltests --cross_compile x86_64-linux-gnu- --arch x86_64

on a clean tree then I get:

   [15:09:20] Configuring KUnit Kernel ...
   Generating .config ...
   Populating config with:
   $ make ARCH=x86_64 O=.kunit olddefconfig CROSS_COMPILE=x86_64-linux-gnu-
   ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
   This is probably due to unsatisfied dependencies.
   Missing: CONFIG_IWLWIFI=y, CONFIG_WLAN_VENDOR_INTEL=y

UML works fine, but other real architectures (eg, arm64) seem similarly
broken.  I've not looked properly yet, I'm a bit confused given that
there's not even any dependencies for WLAN_VENDOR_INTEL and it's not
mentoned in the defconfig.

Thanks,
Mark

--zIto0On63gACKm7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYBln0ACgkQJNaLcl1U
h9DePAf/Z5uHCZ+iDZf1VGtBYitsHxt4Q8vx7Yuhke/QyIedqTs4MYw7fyG2dJfo
mAXOqpTCmGtKGAWMSx/AAz5wYq9gycemxm+B9Eg3Uznfh4vn9fFQJOaHU7ZvmAVY
8QAT3X7r/O/a6w6Ph4Kt4y1pvAhJblBEpZb3MGJpe3OmBP3pdBIwDp5oLupLqjRF
AJYmdQNstgBu9SBiH2W8X4mpxqwzZiGodXDAvcL2sYcu92fT2ly33TzQT2Fhrwh9
+J8n01UgWUAx4zmZmBj7sFppke3VYWUFMYkaI6dn7izzYZeA/+XB/s162tE/NH3Z
NFKKlH9c+8K9tGuroUbllBzQBc9n+g==
=CsSJ
-----END PGP SIGNATURE-----

--zIto0On63gACKm7s--

