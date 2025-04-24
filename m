Return-Path: <linux-kselftest+bounces-31601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A6AA9B95F
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 22:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FECB4603F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 20:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6C91F5827;
	Thu, 24 Apr 2025 20:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfPkinW/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1C414E2E2;
	Thu, 24 Apr 2025 20:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745527639; cv=none; b=OP97G4ARxLbQDXUjZXRF8qL4pSxJIgl6Pj0EdZvcVE/FcpaHcKHJMBuxyh63wfVaKq7ZlWUvLLzUkGzTq7GoiuJIdEaHBy9V0iU/Zi7f0B06e4ekHi8WWTV7FlGEYl7xKigR/h9T9YYlJFBgTKFdaPlWdO1qvXhkIY9IdInYLXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745527639; c=relaxed/simple;
	bh=aRR9U42dKiAFdfeSisi+NbgIuTAkls5smAOfmnflsaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URvvOmFI/STcn9hPXM9ZA8Mt1S0WDRiGDav3F7yf/2yY6naZVctr5Ma5bzQzi1OuEOG01HjHkt0SksLEFo17MEC/obWIy3Pss+l2ebZ9WllAAWwdLI2w9/ZfIzqSVHjjtEzFK8TJFiQKa/iOsaVUAoHZhBOUozbDBIGJO1ps+Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfPkinW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F9AC4CEE3;
	Thu, 24 Apr 2025 20:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745527636;
	bh=aRR9U42dKiAFdfeSisi+NbgIuTAkls5smAOfmnflsaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AfPkinW/6MqeKFXAIw5YqEChgB2LX5EkjxeAvWGVHXpWJjXQKHoonSldphap6JNlY
	 sOfn3PptKh219lLorekxIdhc+lGBEqtr9hSd+nSZv/3igMc9rbsba1wAlqzF5ACjjG
	 kThJvK+QoMLHO1N6wN6VpZrD7o9LcXyBhKdrNx0CbF8h93zdnJZsyXWKNINXrI8D9S
	 Hr5xu6k4uF06r8oLp4bTkJurxQLqJe2QaePenx7dUzsW0aIU3iz6kq8LfFDckvJ8HL
	 1ILwntxb8QM56oZFYFsgQkbA53N6MgFxRra32pwFICBMTK1G2yuR96Tz26M028nsBX
	 ggVP9uatgmM1Q==
Date: Thu, 24 Apr 2025 22:47:11 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: Allow XDP dev-bound programs to perform
 XDP_REDIRECT into maps
Message-ID: <aAqjTz7O4HpuVspL@lore-rh-laptop>
References: <20250423-xdp-prog-bound-fix-v2-1-51742a5dfbce@kernel.org>
 <87wmb97uyt.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2v2QP9mMY9ArTXMu"
Content-Disposition: inline
In-Reply-To: <87wmb97uyt.fsf@toke.dk>


--2v2QP9mMY9ArTXMu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> > In the current implementation if the program is dev-bound to a specific
> > device, it will not be possible to perform XDP_REDIRECT into a DEVMAP
> > or CPUMAP even if the program is running in the driver NAPI context and
> > it is not attached to any map entry. This seems in contrast with the
> > explanation available in bpf_prog_map_compatible routine.
> > Fix the issue introducing __bpf_prog_map_compatible utility routine in
> > order to avoid bpf_prog_is_dev_bound() check running bpf_check_tail_cal=
l()
> > at program load time (bpf_prog_select_runtime()).
> > Continue forbidding to attach a dev-bound program to XDP maps
> > (BPF_MAP_TYPE_PROG_ARRAY, BPF_MAP_TYPE_DEVMAP and BPF_MAP_TYPE_CPUMAP).
> >
> > Fixes: 3d76a4d3d4e59 ("bpf: XDP metadata RX kfuncs")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> > Changes in v2:
> > - Introduce __bpf_prog_map_compatible() utility routine in order to skip
> >   bpf_prog_is_dev_bound check in bpf_check_tail_call()
> > - Extend xdp_metadata selftest
> > - Link to v1: https://lore.kernel.org/r/20250422-xdp-prog-bound-fix-v1-=
1-0b581fa186fe@kernel.org
> > ---
> >  kernel/bpf/core.c                                  | 27 +++++++++++++-=
--------
> >  .../selftests/bpf/prog_tests/xdp_metadata.c        | 22 ++++++++++++++=
+++-
> >  tools/testing/selftests/bpf/progs/xdp_metadata.c   | 13 +++++++++++
> >  3 files changed, 50 insertions(+), 12 deletions(-)
> >
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index ba6b6118cf504041278d05417c4212d57be6fca0..a3e571688421196c3ceaed6=
2b3b59b62a0258a8c 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -2358,8 +2358,8 @@ static unsigned int __bpf_prog_ret0_warn(const vo=
id *ctx,
> >  	return 0;
> >  }
> > =20
> > -bool bpf_prog_map_compatible(struct bpf_map *map,
> > -			     const struct bpf_prog *fp)
> > +static bool __bpf_prog_map_compatible(struct bpf_map *map,
> > +				      const struct bpf_prog *fp)
> >  {
> >  	enum bpf_prog_type prog_type =3D resolve_prog_type(fp);
> >  	bool ret;
> > @@ -2368,14 +2368,6 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
> >  	if (fp->kprobe_override)
> >  		return false;
> > =20
> > -	/* XDP programs inserted into maps are not guaranteed to run on
> > -	 * a particular netdev (and can run outside driver context entirely
> > -	 * in the case of devmap and cpumap). Until device checks
> > -	 * are implemented, prohibit adding dev-bound programs to program map=
s.
> > -	 */
> > -	if (bpf_prog_is_dev_bound(aux))
> > -		return false;
> > -
> >  	spin_lock(&map->owner.lock);
> >  	if (!map->owner.type) {
> >  		/* There's no owner yet where we could check for
> > @@ -2409,6 +2401,19 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
> >  	return ret;
> >  }
> > =20
> > +bool bpf_prog_map_compatible(struct bpf_map *map, const struct bpf_pro=
g *fp)
> > +{
> > +	/* XDP programs inserted into maps are not guaranteed to run on
> > +	 * a particular netdev (and can run outside driver context entirely
> > +	 * in the case of devmap and cpumap). Until device checks
> > +	 * are implemented, prohibit adding dev-bound programs to program map=
s.
> > +	 */
> > +	if (bpf_prog_is_dev_bound(fp->aux))
> > +		return false;
> > +
> > +	return __bpf_prog_map_compatible(map, fp);
> > +}
> > +
> >  static int bpf_check_tail_call(const struct bpf_prog *fp)
> >  {
> >  	struct bpf_prog_aux *aux =3D fp->aux;
> > @@ -2421,7 +2426,7 @@ static int bpf_check_tail_call(const struct bpf_p=
rog *fp)
> >  		if (!map_type_contains_progs(map))
> >  			continue;
> > =20
> > -		if (!bpf_prog_map_compatible(map, fp)) {
> > +		if (!__bpf_prog_map_compatible(map, fp)) {
>=20
> Hmm, so this allows devbound programs in tail call maps, right? But
> there's no guarantee that a tail call map will always be used for a
> particular device, is there? For instance, it could be shared between
> multiple XDP programs, bound to different devices, thus getting the
> wrong kfunc.

According to my understanding the following path will be executed just for
dev-bound program that performs XDP_REDIRECT into a BPF_MAP_TYPE_PROG_ARRAY:

bpf_prog_select_runtime() -> bpf_check_tail_call() -> __bpf_prog_map_compat=
ible()

while for XDP program inserted into BPF_MAP_TYPE_PROG_ARRAY we will continue
running bpf_prog_map_compatible() so we will forbid inserting ev-bound prog=
rams.
This is even tested into xdp_metadata selftest:

https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/p=
rog_tests/xdp_metadata.c#L416

It seems to me v2 is not more relaxed than v1. Am I missing something?

Regards,
Lorenzo

>=20
> Or you could even have dev-bound programs tail-called from non-dev-bound
> programs with this change AFAICT?
>=20
> In other words, I think this is too relaxed, your change in v1 that only
> relaxed cpumap and devmap checks here was better.
>=20
> In fact, I don't really see why bpf_check_tail_call() needs to look at
> devmap/cpumap at all, so maybe just changing the
> map_type_contains_progs() call to only match tail call maps is better?
>=20
> -Toke

--2v2QP9mMY9ArTXMu
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaAqjTAAKCRA6cBh0uS2t
rBSJAQCb5y1spcF6J0yANxRkAUZQAtSZVpd/X8FgWQ75OBWcOwEAlYBg0yHxDwhJ
qoZmCDGBeVGi3Fg1/EbKegw0UsZxNwA=
=ODrw
-----END PGP SIGNATURE-----

--2v2QP9mMY9ArTXMu--

