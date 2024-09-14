Return-Path: <linux-kselftest+bounces-17980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AF1978F75
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 11:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04354283346
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 09:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73BD19D885;
	Sat, 14 Sep 2024 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLBvuI6w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A303A440C;
	Sat, 14 Sep 2024 09:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726305951; cv=none; b=V1RgSiPaLGL3V/tfRSpNQGMm7FwzkgHHmxDtwynmNdrsNpQjuq2Uop4ZPMZJRIh7m6RCaGRuQfSRmgHjglj6O2lTV9OtP9X8SXR0CRM67lF/UGeQgt+zEUeS2/3xlb3RDsfeBmAa4iED5DF2Qd9FDD0AFlTXwFtKAdzy2NftH4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726305951; c=relaxed/simple;
	bh=VfHrlgV7IZimZ56kwz6gkQcl8Qjv5fduKCR4vNPpZOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N76rYFhy1F/WxbNP3Gn9A81YST3+KlJ7CPa5JnDHqp5n0hXp1/uM7dCz+lhVIRc/RgJF4B4hs9RtXGKFdcOc/bXzPTQ+7sK0s5qUKyP+fcKDJ+eN0RphUENZml9DmLjOEPOiUHNB5gMdxtDbDYEOMLGvWdhboDk18MWnCmZ1pko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLBvuI6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D681C4CEC0;
	Sat, 14 Sep 2024 09:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726305950;
	bh=VfHrlgV7IZimZ56kwz6gkQcl8Qjv5fduKCR4vNPpZOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZLBvuI6w/tDERjYsF4sIHkwDHLawEOLjnbDtD1YpxvDEcp6bo9UlGOYJ9XksvAISW
	 CNC2Ez0pV97mPEDX2CgmhdEvI1BxcB4LXuiBBeCG66oUpX0OlZ1PSchh2He3EngnSy
	 Jda10jjZQSOtz3/jFSOBytcfgok4ygBz9SK5ncAPlg0H2vf2rRVL1zbQQoEO8a1vSW
	 WWoL3DhyfTQK9oTo8sQNWer+WAc2lvck+zgwkcYBjivlAXJHs2BzE0D/9ZT5YqBKhJ
	 Md4XVARyWMd6K1t7hW+jwgShSS6cvkiYwVs8EDZ57Mz/7lIz5kEJ3KuULz/Iwg/K/p
	 NIFNUtgcpsfyg==
Date: Sat, 14 Sep 2024 11:25:47 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexis =?iso-8859-1?Q?Lothor=E9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	ebpf@linuxfoundation.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] selftests/bpf: convert test_xdp_features.sh
 to test_progs
Message-ID: <ZuVWmxoqXFI3qvVI@lore-desk>
References: <20240910-convert_xdp_tests-v2-1-a46367c9d038@bootlin.com>
 <64df8d41-6cfb-45a9-8337-5cc04daedb60@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lrjavHNZyEh5dE4v"
Content-Disposition: inline
In-Reply-To: <64df8d41-6cfb-45a9-8337-5cc04daedb60@linux.dev>


--lrjavHNZyEh5dE4v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 13, Martin KaFai Lau wrote:
> On 9/10/24 11:10 AM, Alexis Lothor=E9 (eBPF Foundation) wrote:
> > test_xdp_features.sh is a shell script allowing to test that xdp featur=
es
> > advertised by an interface are indeed delivered. The test works by star=
ting
> > two instance of the same program, both attaching specific xdp programs =
to
> > each side of a veth link, and then make those programs manage packets a=
nd
> > collect stats to check whether tested XDP feature is indeed delivered or
> > not. However this test is not integrated in test_progs framework and so=
 can
> > not run automatically in CI.
> >=20
> > Rewrite test_xdp_features to integrate it in test_progs so it can run
> > automatically in CI. The main changes brought by the rewrite are the
> > following:
> > - instead of running to separated processes (each one managing either t=
he
> >    tester veth or the DUT vet), run a single process
> > - slightly change testing direction (v0 is the tester in local namespac=
e,
> >    v1 is the Device Under Test in remote namespace)
> > - group all tests previously managed by test_xdp_features as subtests (=
one
> >    per tested XDP feature). As a consequence, run only once some steps
> >    instead of once per subtest (eg: starting/stopping the udp server). =
On
> >    the contrary, make sure that each subtest properly cleans up its sta=
te
> >    (ie detach xdp programs, reset test stats, etc)
> > - since there is now a single process, get rid of the "control" tcp cha=
nnel
> >    used to configure DUT. Configuring the DUT now only consists in swit=
ching
> >    to DUT network namespace and run the relevant commands
> > - since there is no more control channel, get rid of TLVs, keep only the
> >    CMD_ECHO packet type, and set it as a magic
> > - simplify network setup: use only ipv6 instead of both ipv4 and ipv6,
> >    force static neighbours instead of waiting for autoconfiguration, do=
 not
> >    force gro (fetch xdp features only once xdp programs are loaded inst=
ead)
> >=20
> > The existing XDP programs are reused, with some minor changes:
> > - tester and dut stats maps are converted to global variables for easier
> >    usage
> > - programs do not use TLV struct anymore but the magic replacing the ec=
ho
> >    command
> > - avoid to accidentally make tests pass: drop packets instead of forwar=
ding
> >    them to userspace when they do not match the expected payload
> > - make sure to perform host <-> network endianness conversion on consta=
nts
> >    rather than packet parts
> >=20
> > Signed-off-by: Alexis Lothor=E9 (eBPF Foundation) <alexis.lothore@bootl=
in.com>
> > ---
> > Changes in v2:
> > - fix endianness management in userspace packet parsing (call htonl on
> >    constant rather than packet part)
> >=20
> > The xdp_features rewrite has been tested in a x86_64 qemu environment o=
n my
> > machine and in CI. In my environment, the test takes a bit less than 2s=
 to
> > execute.
> >=20
> >    # ./test_progs -a xdp_features
> >    #561/1   xdp_features/XDP_PASS:OK
> >    #561/2   xdp_features/XDP_DROP:OK
> >    #561/3   xdp_features/XDP_ABORTED:OK
> >    #561/4   xdp_features/XDP_TX:OK
> >    #561/5   xdp_features/XDP_REDIRECT:OK
> >    #561/6   xdp_features/XDP_NDO_XMIT:OK
> >    #561     xdp_features:OK
> >    Summary: 1/6 PASSED, 0 SKIPPED, 0 FAILED
> > ---
> >   tools/testing/selftests/bpf/.gitignore             |   1 -
> >   tools/testing/selftests/bpf/Makefile               |  10 +-
> >   .../selftests/bpf/prog_tests/xdp_features.c        | 446 +++++++++++++
> >   tools/testing/selftests/bpf/progs/xdp_features.c   |  49 +-
> >   tools/testing/selftests/bpf/test_xdp_features.sh   | 107 ---
> >   tools/testing/selftests/bpf/xdp_features.c         | 718 ------------=
---------

Hi Alexis.

sorry for the late reply.

>=20
> From the initial commit message of xdp_features.c, its primary usage is to
> test a physical network device that supports a certain XDP features.
>=20
> iiuc, test_xdp_features.sh only uses the veth and veth will also be the o=
nly
> device tested after moving to prog_tests/xdp_features.c? It is a reasonab=
le
> addition to test_progs for an end-to-end xdp test by using veth. However,
> test_progs will not be able to test the physical network device.
>=20
> Lorenzo, is the xdp_features.c still used for device testing?
>=20

correct, xdp_features.c is intended to test the real xdp features supported=
 by
the NIC under test (DUT), not just the advertised ones (iirc that was a
requisite to add xdp kernel feature support). For this reason we need two
separated processes running on the tester device and on the DUT (they are
usually two different devices). test_xdp_features.sh was just a simple test
script used to develop xdp_features.c.
What about extending xdp_features.c to integrate it in the CI?

Regards,
Lorenzo

--lrjavHNZyEh5dE4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZuVWmwAKCRA6cBh0uS2t
rBxhAQCLXMuPwqHagnF+4BNb6j5Gb3F5dygivRqlb51M0C2jUgEA2Nt5fMwbUPTb
OjTyGMkGQQ1xM77odNea/pO+2yekgQQ=
=Yjnh
-----END PGP SIGNATURE-----

--lrjavHNZyEh5dE4v--

