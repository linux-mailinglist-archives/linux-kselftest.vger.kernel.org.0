Return-Path: <linux-kselftest+bounces-31600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBF1A9B923
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 22:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2689A4DBD
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 20:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CEF21CC62;
	Thu, 24 Apr 2025 20:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNHKOAl4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A02C1DF73D;
	Thu, 24 Apr 2025 20:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745526466; cv=none; b=ZuHZU6NjdRHu+iLqK13LRkenKgt7ecqNx2CSq5zHYczM+rkcGscoztAdCtRff3l+ybnnOIsVu35qVwRadhHRLv8sS79LlyXj44elbzHwHaRIkaZJe9xSaigyZsYIWt9SjisOkRj9Y4eqdKGIB3GOnEMQmrHxKN9B0yXR5s3HZCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745526466; c=relaxed/simple;
	bh=hcJFO4o4Fe1B326uDZtwdZvdabXVFxoD6rq1srTLmM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJIMBdoyDqUV/ssIm5XxpfEkNPAYyoi9jwJH0uJVBjm0TKpJr05HmjO+AcDJM+VjApeGQXutSnW5cvpb0tOu02fh9Yh3vY2483zFxSBlnXSuLSsP0dczJ6W8gUASo4ZwZojUcnq/1niWJOiZeVaWC+RQmjr4diQH056J1nn/TyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNHKOAl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCC4C4CEED;
	Thu, 24 Apr 2025 20:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745526465;
	bh=hcJFO4o4Fe1B326uDZtwdZvdabXVFxoD6rq1srTLmM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UNHKOAl4lsrXMgobeXmWA200LBID9H/OGis070L1AGiWXj3KjS/ZmATSMxGAiLwU/
	 ZjLZIwn+Xaj/tFZFFimaKShCSkMihnpZcRhf3qN/LHT+99KeZR9xlglUhtLs195Q4t
	 x+/zg+sIr7HWRsRMCq14mlQYkqTIJ8ncwozf4n6/BT0vOg2zxph5P66SLLAVrUxfKm
	 /57g5b2hHB5UNzZwYZ3lzMMUmYtjUtPGUiZpvv+a61visORbhhBEHoN/O7DTGEbpxF
	 tvK7yeZ4a1XZ8gs8QAie58PIFbnn4xfUNhwvoMU4NvFUZZS02j/8TJKzsZPaErqa65
	 O9ZjACxgdnmOQ==
Date: Thu, 24 Apr 2025 22:27:40 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
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
Message-ID: <aAqevLQfeOoL9ikV@lore-rh-laptop>
References: <20250423-xdp-prog-bound-fix-v2-1-51742a5dfbce@kernel.org>
 <c865305d-b10b-4f67-b466-cc05a57dccfe@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vRkdHxtqZ+EQnOhr"
Content-Disposition: inline
In-Reply-To: <c865305d-b10b-4f67-b466-cc05a57dccfe@linux.dev>


--vRkdHxtqZ+EQnOhr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 23, Martin KaFai Lau wrote:
> On 4/23/25 10:44 AM, Lorenzo Bianconi wrote:
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
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> > Changes in v2:
> > - Introduce __bpf_prog_map_compatible() utility routine in order to skip
> >    bpf_prog_is_dev_bound check in bpf_check_tail_call()
> > - Extend xdp_metadata selftest
> > - Link to v1: https://lore.kernel.org/r/20250422-xdp-prog-bound-fix-v1-=
1-0b581fa186fe@kernel.org
> > ---
> >   kernel/bpf/core.c                                  | 27 +++++++++++++=
---------
> >   .../selftests/bpf/prog_tests/xdp_metadata.c        | 22 +++++++++++++=
++++-
> >   tools/testing/selftests/bpf/progs/xdp_metadata.c   | 13 +++++++++++
>=20
> The change lgtm. Please separate the selftest changes to patch 2. Thanks.

ack, I will do in v3.

Regards,
Lorenzo

>=20
> pw-bot: cr
>=20

--vRkdHxtqZ+EQnOhr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaAqeuQAKCRA6cBh0uS2t
rPPaAP0VaDYfwKbKvFdc8mDB5r7ccFZPNlvMQQpBfZcdfdiYtwEA5FREyZuhhcUJ
kl6jLogur8AAWBbi+uVnfi/uCZgZTQE=
=o5FE
-----END PGP SIGNATURE-----

--vRkdHxtqZ+EQnOhr--

