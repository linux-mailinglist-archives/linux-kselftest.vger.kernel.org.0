Return-Path: <linux-kselftest+bounces-22098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135F99CE14E
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 15:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4762CB360A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 14:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9361CDA01;
	Fri, 15 Nov 2024 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZghoCDRQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFCA12F585;
	Fri, 15 Nov 2024 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679933; cv=none; b=Yin5QUpohg8ZZvN6WI/9jJr3f9YTSXtiZn1XKrLNo2FThZoX55dx19h9yhU3xXOi7SeiZN6Mq0qGdzfktE0MlFPsyDgZxwZU9SeNHqmWj1PerTdFvuyf0XOKdBhb/BerPaSebDtVCpIqpsinCM2jrdGJQCLSria2g9NT0vVliq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679933; c=relaxed/simple;
	bh=bstTsljYnstdf3sANTf0Aa+2NdTvKUtQsxEVw4E91Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d89tRm/zJpkwseJUjc1TARjWV1DsLctvBT8UHYSVqCIsC7lk1+h0HTf3fp310VoZ5QkMEQgkKFCCLRJmPrqbFjSXRUIO8koD5lQEL+hjVENzuKZYPf+B/tQTTQBXLYqoKIgPi7/A5+uB8Kiw4wq1UCD1sAanuhN1PdsycxyiHBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZghoCDRQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994C4C4CECF;
	Fri, 15 Nov 2024 14:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731679933;
	bh=bstTsljYnstdf3sANTf0Aa+2NdTvKUtQsxEVw4E91Ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZghoCDRQcnGXIYKpeBSNEjA17oMqYZNU9Wh23NVNn0M93Ced8F0LcgtT6l7Zo5bEj
	 QEWbbM/4ndFtYw2tt6XAVjoQZZ6Ih7+89QamhpkZLAZ4WzGHrOYGlu+MeYrW/p5Avw
	 pyNpK/eBTSsuy3Vm2NZlvasaMp+NR0CAYYs//ynlDH5DxTp8wJH23YsKi2Y2Wondcz
	 PnExgZtwn6YN88NctdUeXWTy57DTsjJDKlggUZNIgRbJuoWvJVpLCZHnqsPPt7qQ4c
	 nCG7Z7sTK08yZ7SGmxOpwbSmtf4fpH1vARsx0y6RQyCb4+MDRvT1yif/7NruFjmrfu
	 GN7+AV+R55Wrg==
Date: Fri, 15 Nov 2024 14:12:09 +0000
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
Message-ID: <ZzdWuUgyAET1babn@finisterre.sirena.org.uk>
References: <20241028115343.3405838-1-linyunsheng@huawei.com>
 <20241028115343.3405838-2-linyunsheng@huawei.com>
 <ZzYfBp0IO1WW6Cao@finisterre.sirena.org.uk>
 <a031f13e-a5ee-4db9-89a3-983b962c3c1b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zqSCGjScNLC9d3w2"
Content-Disposition: inline
In-Reply-To: <a031f13e-a5ee-4db9-89a3-983b962c3c1b@huawei.com>
X-Cookie: Editing is a rewording activity.


--zqSCGjScNLC9d3w2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 15, 2024 at 05:03:34PM +0800, Yunsheng Lin wrote:
> On 2024/11/15 0:02, Mark Brown wrote:
> > On Mon, Oct 28, 2024 at 07:53:36PM +0800, Yunsheng Lin wrote:

> > This is breaking the build in -next on at least arm64 and x86_64 since
> > it's trying to build an out of tree kernel module which is included in
> > the selftests directory, the kselftest build system just isn't set up to
> > do that in a sensible and robust fashion.  The module should probably be

> I tried the below kernel modules in the testing directory, they seemed to
> have the similar problem if the kernel is not compiled yet.

> make -C tools/testing/nvdimm

This is not included in the top level selftests Makefile.

> make -C tools/testing/selftests/bpf/bpf_testmod/

The BPF tests aren't built as standard due to a number of issues,
originally it was requiring very shiny toolchains though that's starting
to get under control.

> make -C tools/testing/selftests/livepatch/test_modules/

Ah, this one is actually using some framework support for building
modules - it's putting the modules in a separate directory and using
TEST_GEN_MODS_DIR.  Crucially, though, it has guards which ensure that
we don't try to build the modules if KDIR doesn't exist - you should
follow that pattern.

> > in the main kernel tree and enabled by the config file for the mm tests.

> As discussed in [1], this module is not really a vaild kernel module by
> returning '-EAGAIN', which is the main reason that it is setup in the
> selftests instead of the main kernel tree.

Sure, we have other test stuff in the main kernel.

> As above, I am not sure if there is some elegant way to avoid the above error
> in the selftest core, one possible way to avoid the above error is to skip
> compiling like below as tools/testing/selftests/mm/test_page_frag.sh already
> skip the testing for page_frag if the test module is not compiled:

Since the tests currently don't build the test systems are by and by
large not getting as far as trying to run anything, the entire mm suite
is just getting skipped.

--zqSCGjScNLC9d3w2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmc3VrkACgkQJNaLcl1U
h9D8/Af8DcxkwVhqkHIadV8p7T/GNw3ehWEjED7pMgzo4TfkjCCDPXzX2aZr0tVp
MyND/9CwU/jMwIBIqxVJT0PfLamo7Ve7AXwGhugK8xxD7CYjw87ctwbYWiELUaFo
GfTlyButNQTRtpCMDbXdMA2utKXMukkp/zKU9bbIeq+U+/Pb/HTrQlTqa6tnVmDU
un2Mv2RgkRzSWuoRPnb34C23wrDthY4ZKtBRLeRDVLS1KJtuG0vOY4qBZaL1t/Hx
1K6bHyVUk00qY8EAnug7DjDY8Ai63QZR7FFzILQ+7X+QRP0rrBPMNYPARGu938Pn
qSzkDtAEsZ6j79hWUAYPBklN5HQ9Qw==
=vsmZ
-----END PGP SIGNATURE-----

--zqSCGjScNLC9d3w2--

