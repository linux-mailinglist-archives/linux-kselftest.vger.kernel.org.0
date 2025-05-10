Return-Path: <linux-kselftest+bounces-32809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF90EAB20A7
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 May 2025 03:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755BA523E13
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 May 2025 01:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5DB25FA02;
	Sat, 10 May 2025 01:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pJP9HTEm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4FE134D4;
	Sat, 10 May 2025 01:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746839108; cv=none; b=k0nHebENBvqUAQ0JoPuBGBFXW6sspCaPKHVx1AGnDM+f0CBT/3CCyNCLdvPSNdZZ8gczfV5U0Wr99bzvORsz1FpbFSK311kW4aNCB3XzDTyTL17neGB7Z1xY1aSw0uHvAk6zsx2gxaPHX6+NPihRlbv/k1P4p2rsnQWSJW3LVH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746839108; c=relaxed/simple;
	bh=msKNnWRtmNES3mhPLoAXNUbWW5k32La15cy+3ceDkho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pdOBn/n5WyyMXAPCQDVTfUXu19FNGSPvkRV5QGwwkCwH1+izWNXYaElLYVuDU7nCumLvqySAXcc0pik7JB5F3ON4yAv5gpq9vWpVIPA4QvSWXiFOaY4i2M/JTIyuGq1XHPDx9B2tD2Mp7Q2dsYmJs8JrsCULcAzbw1HpWMo37s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=pJP9HTEm; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1746839099;
	bh=BcDMEWZprG7/4QiD24tVvS5LuwgJ/uimoKaiXsdNfwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pJP9HTEmz5FOEBM56qol0g5N6SUdMlFbFZpCq3ExXL/74Sz1avpmYzT0KTq2bdrGV
	 cIRC0a+W8UtU3SQ/QluU+rLoISJzQPmI9VMVwtINra9qUcOdXYugqnZIThnmzhrrzP
	 j0puo3324XuwgSFJzqa1RFOMTagCJ2Shmu1weWpmnAncqrB+H6i5LsA6twye3v70J2
	 PnkxpFIFN9X2jRIv7kIlXeRI82WD+yL3HwdFBzEc3Cakz1jTCyZ05jMEkc2TbQrP6p
	 vOxc0gRD2vPSwSnWshNnZ9ZRPCynyZbCMD2InxVh7NknZd/OFS5X38uSVFryvpxQz1
	 2mdNUYWOM6C6A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZvSMY6BwVz4x5k;
	Sat, 10 May 2025 11:04:57 +1000 (AEST)
Date: Sat, 10 May 2025 11:04:55 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf <bpf@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel
 <linux-arm-kernel@lists.infradead.org>,
 linux-stm32@st-md-mailman.stormreply.com, Linux-Next Mailing List
 <linux-next@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Hari
 Bathini <hbathini@linux.ibm.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Mykola Lysenko <mykolal@fb.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] selftests/bpf: Fix bpf selftest build error
Message-ID: <20250510110455.10c72257@canb.auug.org.au>
In-Reply-To: <CAADnVQKBQqur68RdwbDVpRuAZE=8Y=_JaTFo-36d_4vr2DNVyw@mail.gmail.com>
References: <20250509122348.649064-1-skb99@linux.ibm.com>
	<CAADnVQKBQqur68RdwbDVpRuAZE=8Y=_JaTFo-36d_4vr2DNVyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/993WEPoqNjDikEmM0EjdhpP";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/993WEPoqNjDikEmM0EjdhpP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Alexei,

On Fri, 9 May 2025 10:04:18 -0700 Alexei Starovoitov <alexei.starovoitov@gm=
ail.com> wrote:
>
> On Fri, May 9, 2025 at 5:24=E2=80=AFAM Saket Kumar Bhaskar <skb99@linux.i=
bm.com> wrote:
> >
> > On linux-next, build for bpf selftest displays an error due to
> > mismatch in the expected function signature of bpf_testmod_test_read
> > and bpf_testmod_test_write.
> >
> > Commit 97d06802d10a ("sysfs: constify bin_attribute argument of bin_att=
ribute::read/write()")
> > changed the required type for struct bin_attribute to const struct bin_=
attribute.
> >
> > To resolve the error, update corresponding signature for the callback.
> >
> > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > Closes: https://lore.kernel.org/all/e915da49-2b9a-4c4c-a34f-877f378129f=
6@linux.ibm.com/
> > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > ---
> >  tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/too=
ls/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > index 2e54b95ad898..194c442580ee 100644
> > --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > @@ -385,7 +385,7 @@ int bpf_testmod_fentry_ok;
> >
> >  noinline ssize_t
> >  bpf_testmod_test_read(struct file *file, struct kobject *kobj,
> > -                     struct bin_attribute *bin_attr,
> > +                     const struct bin_attribute *bin_attr,
> >                       char *buf, loff_t off, size_t len) =20
>=20
> You didn't even compile it :(
>=20
> Instead of fixing the build, it breaks the build.
>=20
> pw-bot: cr

This patch is only needed in linux-next.  It should be applied to the
driver-core tree - since that includes commit 97d06802d10a.  It should
also have a Fixes tag referencing commit 97d06802d10a.
--=20
Cheers,
Stephen Rothwell

--Sig_/993WEPoqNjDikEmM0EjdhpP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmgepjcACgkQAVBC80lX
0GxVWwf/ZkvwI39VdsR9Cc6eDfSrM4MHj5NBvGGV6tUNoYclSENR/DyT+68SZ798
AzGX3tpbarQ3OT/LAbWpSMAl62GzV22LVn3R5+6W/067tygXXF97X7tmEr6kPIfH
csvUrXewvX7QLH0BO1MTMRHHdjlgydBY86wPmMWi7HOuxDRJhzGCeit3hWfCEdA7
OyKyOwzemjv7PrRwe/ybaZXnq2tdLYF1YNiFqUVsVrGu2WMCfnkE6nBaCT5+cUbX
biLx1adyPWW5NMo4wf0gMwF24JvcS8IjcRZcL2e3UfWMhaGLGZ7EN4aOYX9bq0mL
EtYXBv74Qm7vWGhjtommtPMxlU2ILg==
=yAPB
-----END PGP SIGNATURE-----

--Sig_/993WEPoqNjDikEmM0EjdhpP--

