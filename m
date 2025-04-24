Return-Path: <linux-kselftest+bounces-31604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E871A9B97D
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 23:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3731B82E91
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 21:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E690217647;
	Thu, 24 Apr 2025 21:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSz/QCNI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B7A84D34;
	Thu, 24 Apr 2025 21:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745528529; cv=none; b=XRYyCI+aAUUWVH1bkODqD5Kq4K6CBlSUNcuAwt0NvF8x40EzJd8i3JMoH6FaDBqLkJ8DtL3XmO3kSA8GKRepGLhndndRXlNh1bw/RPc4YDCrCIG8SU0QWd8EvXMTmnKmUBbKmtF+yahb8c1llXPViG+b7kpcrmc8k4Q8jUNbkvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745528529; c=relaxed/simple;
	bh=lcno/piv6G8U2O2pOdcBFZ4l31qu/0fwXvq8yYTYdiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8xXZt7exm58L6yo56W1l4VeRZACM7S3a5IPKMP0i7nrcCCTZTwQ4+srh7VhvLCpJ42HX2oQ+esaABGaUOgxfC6T72nHcQJr4dWA+kamgJ7VfPNe0YOFOMpEXblFwHtIH1JTeTTvpWydTBwBaDbeAcPEjuvEp8tt0XV33ktriGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSz/QCNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC9FC4CEE3;
	Thu, 24 Apr 2025 21:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745528528;
	bh=lcno/piv6G8U2O2pOdcBFZ4l31qu/0fwXvq8yYTYdiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WSz/QCNIAk2g8dWnMEVv8N2bQcFZA+Bgo3Zyhf7B5PqiRp7a2zsvs4u1ZBiyIZKMB
	 IcpnIx9gRVapaub07jlk1iYsGDng6AD2G0wYTqN47OTzo8IkS/D6YTYZaEVlAemiMn
	 dbMlAwGd97jsdZk7klFoINobhmiOswbKkrpsg9qmUovm0n7g8TMq1ojlAX0t+nZIq4
	 978awB41RfNJn+G8SlHZQAa+nGSeDhGuC25RWHZcEcLtM4Cf3rwOXEU67McRQ8q47o
	 +cQAt23+TFcCccWxwLYFwTfVNQ2/xh+ly9tUXtzDTClRbmRLV8qfMFa8W0Zk8gsBKk
	 2XY7KSw/8IP0Q==
Date: Thu, 24 Apr 2025 23:02:04 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
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
	Jakub Kicinski <kuba@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: Allow XDP dev-bound programs to perform
 XDP_REDIRECT into maps
Message-ID: <aAqmzAU1smXkRX84@lore-rh-laptop>
References: <20250423-xdp-prog-bound-fix-v2-1-51742a5dfbce@kernel.org>
 <783dacd8-6782-484a-8934-f4a5d20eeddb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WfJaJPPtTAURvLii"
Content-Disposition: inline
In-Reply-To: <783dacd8-6782-484a-8934-f4a5d20eeddb@kernel.org>


--WfJaJPPtTAURvLii
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 24, Jesper Dangaard Brouer wrote:
>=20
>=20
> On 23/04/2025 19.44, Lorenzo Bianconi wrote:
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
> >=20
> > Fixes: 3d76a4d3d4e59 ("bpf: XDP metadata RX kfuncs")
> > Signed-off-by: Lorenzo Bianconi<lorenzo@kernel.org>
> > ---
> > Changes in v2:
> > - Introduce __bpf_prog_map_compatible() utility routine in order to skip
> >    bpf_prog_is_dev_bound check in bpf_check_tail_call()
> > - Extend xdp_metadata selftest
> > - Link to v1:https://lore.kernel.org/r/20250422-xdp-prog-bound-fix-v1-1=
-0b581fa186fe@kernel.org
> > ---
> >   kernel/bpf/core.c                                  | 27 +++++++++++++=
---------
> >   .../selftests/bpf/prog_tests/xdp_metadata.c        | 22 +++++++++++++=
++++-
> >   tools/testing/selftests/bpf/progs/xdp_metadata.c   | 13 +++++++++++
> >   3 files changed, 50 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index ba6b6118cf504041278d05417c4212d57be6fca0..a3e571688421196c3ceaed6=
2b3b59b62a0258a8c 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -2358,8 +2358,8 @@ static unsigned int __bpf_prog_ret0_warn(const vo=
id *ctx,
> >   	return 0;
> >   }
> > -bool bpf_prog_map_compatible(struct bpf_map *map,
> > -			     const struct bpf_prog *fp)
> > +static bool __bpf_prog_map_compatible(struct bpf_map *map,
> > +				      const struct bpf_prog *fp)
> >   {
> >   	enum bpf_prog_type prog_type =3D resolve_prog_type(fp);
> >   	bool ret;
> > @@ -2368,14 +2368,6 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
> >   	if (fp->kprobe_override)
> >   		return false;
> > -	/* XDP programs inserted into maps are not guaranteed to run on
> > -	 * a particular netdev (and can run outside driver context entirely
> > -	 * in the case of devmap and cpumap). Until device checks
> > -	 * are implemented, prohibit adding dev-bound programs to program map=
s.
> > -	 */
> > -	if (bpf_prog_is_dev_bound(aux))
> > -		return false;
> > -
> >   	spin_lock(&map->owner.lock);
> >   	if (!map->owner.type) {
> >   		/* There's no owner yet where we could check for
> > @@ -2409,6 +2401,19 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
> >   	return ret;
> >   }
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
> >   static int bpf_check_tail_call(const struct bpf_prog *fp)
> >   {
> >   	struct bpf_prog_aux *aux =3D fp->aux;
> > @@ -2421,7 +2426,7 @@ static int bpf_check_tail_call(const struct bpf_p=
rog *fp)
> >   		if (!map_type_contains_progs(map))
> >   			continue;
> > -		if (!bpf_prog_map_compatible(map, fp)) {
> > +		if (!__bpf_prog_map_compatible(map, fp)) {
> >   			ret =3D -EINVAL;
> >   			goto out;
> >   		}
>=20
> Does this change allow us to have a dev_bound BPF-prog that have
> tail-call BPF-progs that are not dev_bound?
>=20
> The use-case is a dev_bound BPF-prog that reads e.g. HW vlan, store this =
in
> data_meta (or a per CPU array), and then tail-calls another BPF-prog that
> reads the data stored (from data_meta area). Maybe this is already suppor=
ted
> before?

I think this patch allows a dev-bound program to run hw-metadata kfuncs and
perform XDP_REDIRECT into a prog_array but you will not be able to read the=
se
info via hw-metadata kfuncs in a tail-call program since just dev-bound
programs are currently allowed to do that (and you can't insert a dev-bound
programs in BPF_MAP_TYPE_PROG_ARRAY).

Regards,
Lorenzo

>=20
> --Jesper

--WfJaJPPtTAURvLii
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaAqmyQAKCRA6cBh0uS2t
rHFCAP0bRx2lAXXUsfTA1ErKIHb9Yx4JXnBDFflWJ5EtduCmTwEAtQ+4ndu+sJdB
UfYAUvq4DS2vLeATYaX971YYUahcgAA=
=0+99
-----END PGP SIGNATURE-----

--WfJaJPPtTAURvLii--

