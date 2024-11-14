Return-Path: <linux-kselftest+bounces-22043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A679C8F17
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 17:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A311F26115
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 16:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08427168C3F;
	Thu, 14 Nov 2024 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDl0yqS3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6220133987;
	Thu, 14 Nov 2024 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600137; cv=none; b=V0Vc0ZrEEc/TsFaRVtdiuV2FqVWYubn4NXKlPku7XYYMeGmTqiTcA/meFEIk5O7kc8QAtpK4toOmu7zqYbehDArPQTwvQ3QXfaA8L188uq5XmzTmqs2YJZH0Bf5fyaYIAj3piU9uyGDLScpcp7Mk84giV4iWGAaASchZ05XaKu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600137; c=relaxed/simple;
	bh=CLE+gdbwkUGWxgVL/DfhT8L9omEJZAlZq2aorhrIAow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCw92uAqMMxAeQjVl7ZwDSElJ4Y4L27dkhcxL2TT4msyHKnTUWDa5EXHLO7OZtQPRNeBGggQnl6Ju2msH0kl58DyWkH9LHzsXNVU0S6c9f+YjgQISgSd49GuQh+57f1ykdguk0OaIEDd37A4k/A9jjRteBpEAWSmGWZpE1Iop6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDl0yqS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFA7C4CECD;
	Thu, 14 Nov 2024 16:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731600137;
	bh=CLE+gdbwkUGWxgVL/DfhT8L9omEJZAlZq2aorhrIAow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VDl0yqS3yS2D3oGna4mh6TH6YC/T+22WILn0j6PiK4E7vghIzflz4uhXyAxYY5MdO
	 LepEXXmlDxd/tK5YiwY7HdF4AyACk96C4NUIejRVytBSvbjAgT5S3CQfiW0F8Kn53X
	 nhQyOFRN8pDPhsPLIGw+6GlBua7KrYfVpn2BvTc6NtLXBBzQWOxPrZXYik8pGYJ8PA
	 Phv6GsuBnRJ/37Z4T+oec6kp6EZnrOg0XfN1b1sMvPkgz3QYNKpAk9ygqJDqw4ioyB
	 DKOex+tJkIkeH0PENmcrUV6H20f3ukmgesA+H18Td0NpeTTV7LdkZ2qsksxiC6hi53
	 4jgMoE1+vSIlg==
Date: Thu, 14 Nov 2024 16:02:14 +0000
From: Mark Brown <broonie@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Linux-MM <linux-mm@kvack.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	Aishwarya.TCV@arm.com
Subject: Re: [PATCH net-next v23 1/7] mm: page_frag: add a test module for
 page_frag
Message-ID: <ZzYfBp0IO1WW6Cao@finisterre.sirena.org.uk>
References: <20241028115343.3405838-1-linyunsheng@huawei.com>
 <20241028115343.3405838-2-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0MyQI+clfZpBVvMG"
Content-Disposition: inline
In-Reply-To: <20241028115343.3405838-2-linyunsheng@huawei.com>
X-Cookie: System checkpoint complete.


--0MyQI+clfZpBVvMG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 28, 2024 at 07:53:36PM +0800, Yunsheng Lin wrote:
> The testing is done by ensuring that the fragment allocated
> from a frag_frag_cache instance is pushed into a ptr_ring
> instance in a kthread binded to a specified cpu, and a kthread
> binded to a specified cpu will pop the fragment from the
> ptr_ring and free the fragment.

This is breaking the build in -next on at least arm64 and x86_64 since
it's trying to build an out of tree kernel module which is included in
the selftests directory, the kselftest build system just isn't set up to
do that in a sensible and robust fashion.  The module should probably be
in the main kernel tree and enabled by the config file for the mm tests.

KernelCI sees:

***
*** Configuration file ".config" not found!
***
*** Please run some configurator (e.g. "make oldconfig" or
*** "make menuconfig" or "make xconfig").
***
Makefile:810: include/config/auto.conf.cmd: No such file or directory

(see https://storage.kernelci.org/next/master/next-20241114/x86_64/x86_64_defconfig%2Bkselftest/gcc-12/logs/kselftest.log)

and I've seen:

  ERROR: Kernel configuration is invalid.
         include/generated/autoconf.h or include/config/auto.conf are missing.
         Run 'make oldconfig && make prepare' on kernel src to fix it.

make[3]: *** [Makefile:788: include/config/auto.conf] Error 1

--0MyQI+clfZpBVvMG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmc2HwUACgkQJNaLcl1U
h9Db9gf8Cr2HGJXLOLGXW8Noo9DxYlVt3elXI60b8tNmifJUKessfHXguQp3P1N4
zOEibYMbPJb1psJo7B0xpb50i4BML30rUBm2vH4ZILQX8IMafE/y2L0vfJ4+kbhz
HMMaZtkYMlePGIK25hApP53VfsEPDwdqOkTBJTksOxf0xLG3ZIQcguwnlZldxrZu
5YfGkL85wLRoiOrNdqUR5lhl7hrV1YpLsrSeKfFs3fhAMgTrcmHLEpTYHtjo/caz
+V2b6+5SlF46vd0d0h8hz92i26LSTt/14K4ZXGQHGCVd2NmO7rmu6Bd6YbwGPVLA
e17YBlDrGC1jnnuLNiDpZtBtN6VdJA==
=MZrU
-----END PGP SIGNATURE-----

--0MyQI+clfZpBVvMG--

