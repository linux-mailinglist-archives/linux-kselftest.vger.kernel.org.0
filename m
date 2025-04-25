Return-Path: <linux-kselftest+bounces-31629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6822EA9C013
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 09:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FDAC1B8677E
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 07:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D3E230BE1;
	Fri, 25 Apr 2025 07:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRm0GR6j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD97D21638A;
	Fri, 25 Apr 2025 07:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745567329; cv=none; b=Y1PSpH0yPQtI9vzvSLEJ2QxvIrHgigPIIrGXwWdxu5oEfJ9e1FL6LfDH/5xIs8cONpP8Yi9Hh1fU36dRVYqcNljsKC0404sNN2zYK8eGRWZZSZ/YlXtpT1v+FYEVpBofL1gCkfw3EP8sAD/RSmmyGzQp/QA1akzeDL5W+/tJ+bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745567329; c=relaxed/simple;
	bh=RZpzcYa7jVWnvEQOwF6i3444TmzEb7CsmbvzQ6FmMYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lj+noQUbDFs8wVS1yhEJxVP9VvBvHkrMdn9L43lYhKXIRTw/nxSmyPx18wW+NjAKHEmRG2swO4yX7D2fouiuakxgcL8v6EysyJPIhjfLAOnEtSU/NnJLTWrfcjU+mDIxiSaeVEZdZPSilSRyrmDU9UNaRyddmfs3niTJcuYaP38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRm0GR6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB71C4CEE4;
	Fri, 25 Apr 2025 07:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745567328;
	bh=RZpzcYa7jVWnvEQOwF6i3444TmzEb7CsmbvzQ6FmMYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=tRm0GR6jtvq7jKYX6Dx2Bt7zDutbVSud9a08mU9bWkd8m0xeBzH5J0akmNuz9OgeQ
	 p70KjDFT+oCP5TY3rRGHjssEtfc1IhARFUYy+JKuaf3fxwT1e2euy+l0LkFFf1HEjY
	 gIAV22d7UJW+Fu4lhLnRgH1Xwk1aeiPrLn1x6krJG+ndOZuQlzcbNziUT8E+xxMWHT
	 IWqgFHZQHdKBHX+hWqu3G06r+VX3ujUgOAX5xVgM5+U8Y+hI+OC2Gq4WB0THm2SNaO
	 +6SaHlcaimeGoF4fID5SHimtzc/VkeXbOZiOb+WUeZkEKh8u7bnq423R0uELCtzR9V
	 kxGNCmm+f0Stw==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0F35A1A037D2; Fri, 25 Apr 2025 09:48:35 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: Allow XDP dev-bound programs to
 perform XDP_REDIRECT into maps
In-Reply-To: <aAphqn-Lm0nn4FH0@mini-arch>
References: <20250423-xdp-prog-bound-fix-v2-1-51742a5dfbce@kernel.org>
 <87wmb97uyt.fsf@toke.dk> <aAphqn-Lm0nn4FH0@mini-arch>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 25 Apr 2025 09:48:35 +0200
Message-ID: <87ikms7kbw.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stanislav Fomichev <stfomichev@gmail.com> writes:

> On 04/24, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>>=20
>> > In the current implementation if the program is dev-bound to a specific
>> > device, it will not be possible to perform XDP_REDIRECT into a DEVMAP
>> > or CPUMAP even if the program is running in the driver NAPI context and
>> > it is not attached to any map entry. This seems in contrast with the
>> > explanation available in bpf_prog_map_compatible routine.
>> > Fix the issue introducing __bpf_prog_map_compatible utility routine in
>> > order to avoid bpf_prog_is_dev_bound() check running bpf_check_tail_ca=
ll()
>> > at program load time (bpf_prog_select_runtime()).
>> > Continue forbidding to attach a dev-bound program to XDP maps
>> > (BPF_MAP_TYPE_PROG_ARRAY, BPF_MAP_TYPE_DEVMAP and BPF_MAP_TYPE_CPUMAP).
>> >
>> > Fixes: 3d76a4d3d4e59 ("bpf: XDP metadata RX kfuncs")
>> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> > ---
>> > Changes in v2:
>> > - Introduce __bpf_prog_map_compatible() utility routine in order to sk=
ip
>> >   bpf_prog_is_dev_bound check in bpf_check_tail_call()
>> > - Extend xdp_metadata selftest
>> > - Link to v1: https://lore.kernel.org/r/20250422-xdp-prog-bound-fix-v1=
-1-0b581fa186fe@kernel.org
>> > ---
>> >  kernel/bpf/core.c                                  | 27 +++++++++++++=
---------
>> >  .../selftests/bpf/prog_tests/xdp_metadata.c        | 22 +++++++++++++=
++++-
>> >  tools/testing/selftests/bpf/progs/xdp_metadata.c   | 13 +++++++++++
>> >  3 files changed, 50 insertions(+), 12 deletions(-)
>> >
>> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> > index ba6b6118cf504041278d05417c4212d57be6fca0..a3e571688421196c3ceaed=
62b3b59b62a0258a8c 100644
>> > --- a/kernel/bpf/core.c
>> > +++ b/kernel/bpf/core.c
>> > @@ -2358,8 +2358,8 @@ static unsigned int __bpf_prog_ret0_warn(const v=
oid *ctx,
>> >  	return 0;
>> >  }
>> >=20=20
>> > -bool bpf_prog_map_compatible(struct bpf_map *map,
>> > -			     const struct bpf_prog *fp)
>> > +static bool __bpf_prog_map_compatible(struct bpf_map *map,
>> > +				      const struct bpf_prog *fp)
>> >  {
>> >  	enum bpf_prog_type prog_type =3D resolve_prog_type(fp);
>> >  	bool ret;
>> > @@ -2368,14 +2368,6 @@ bool bpf_prog_map_compatible(struct bpf_map *ma=
p,
>> >  	if (fp->kprobe_override)
>> >  		return false;
>> >=20=20
>> > -	/* XDP programs inserted into maps are not guaranteed to run on
>> > -	 * a particular netdev (and can run outside driver context entirely
>> > -	 * in the case of devmap and cpumap). Until device checks
>> > -	 * are implemented, prohibit adding dev-bound programs to program ma=
ps.
>> > -	 */
>> > -	if (bpf_prog_is_dev_bound(aux))
>> > -		return false;
>> > -
>> >  	spin_lock(&map->owner.lock);
>> >  	if (!map->owner.type) {
>> >  		/* There's no owner yet where we could check for
>> > @@ -2409,6 +2401,19 @@ bool bpf_prog_map_compatible(struct bpf_map *ma=
p,
>> >  	return ret;
>> >  }
>> >=20=20
>> > +bool bpf_prog_map_compatible(struct bpf_map *map, const struct bpf_pr=
og *fp)
>> > +{
>> > +	/* XDP programs inserted into maps are not guaranteed to run on
>> > +	 * a particular netdev (and can run outside driver context entirely
>> > +	 * in the case of devmap and cpumap). Until device checks
>> > +	 * are implemented, prohibit adding dev-bound programs to program ma=
ps.
>> > +	 */
>> > +	if (bpf_prog_is_dev_bound(fp->aux))
>> > +		return false;
>> > +
>> > +	return __bpf_prog_map_compatible(map, fp);
>> > +}
>> > +
>> >  static int bpf_check_tail_call(const struct bpf_prog *fp)
>> >  {
>> >  	struct bpf_prog_aux *aux =3D fp->aux;
>> > @@ -2421,7 +2426,7 @@ static int bpf_check_tail_call(const struct bpf_=
prog *fp)
>> >  		if (!map_type_contains_progs(map))
>> >  			continue;
>> >=20=20
>> > -		if (!bpf_prog_map_compatible(map, fp)) {
>> > +		if (!__bpf_prog_map_compatible(map, fp)) {
>>=20
>> Hmm, so this allows devbound programs in tail call maps, right? But
>> there's no guarantee that a tail call map will always be used for a
>> particular device, is there? For instance, it could be shared between
>> multiple XDP programs, bound to different devices, thus getting the
>> wrong kfunc.
>
> Won't this (devbound progs in tail call maps) be still prohibited
> by a bpf_prog_map_compatible check in prog_fd_array_get_ptr?

Yeah, you're right, I misremembered the check and somehow convinced
myself that the check in bpf_check_tail_call() was the one that
prevented dev-bound programs from being loaded into tail call maps...

-Toke

