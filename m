Return-Path: <linux-kselftest+bounces-31529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62458A9A8FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 11:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B23F3BFB89
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 09:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A59F221FBC;
	Thu, 24 Apr 2025 09:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xz35h3k0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678C221CA13;
	Thu, 24 Apr 2025 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745488008; cv=none; b=OMOuUc4A43KP05TyaU4lfA/Zl7MSw3tcU+xgoZY2grWLgC3iBomIrScaRE/c8l2XTR1t2IgK+zXD73IPd5O50MhH6vogRcutM0cBz+czH4SWvWF8R2CesMvq7usyO7kofFT4M/qsdKGG/BwEJ5FME5g1JQA2nAENisDgMS6U+7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745488008; c=relaxed/simple;
	bh=kRBDJNaddAADD3tImUoxy3nO7YUIsqSB0eBE/RCv4Po=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mtx0Pz5nMlCI9g6nU2PRDflycgLN+Sgil6s4PG1m8+cYWrmVR+Ydrk0Q9qLKT2/l2Nte4kpecyyXxBhMepAmdiS0A95kIc3+B25caQYjSw19R5eVgUnlh3fb5JmEfxP97fcwiDxlneUSV3uzR8BvwRDdyRbPLNZX5WfOK3yyxBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xz35h3k0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BF1C4CEEB;
	Thu, 24 Apr 2025 09:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745488007;
	bh=kRBDJNaddAADD3tImUoxy3nO7YUIsqSB0eBE/RCv4Po=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Xz35h3k0OZenF+jkvafY9OKecKxjHE4gH5kcKefli0aPtTyZZ1R6jNtVgr0O/9NqW
	 Gm6bP9MuE+rEXMm5LDcyHiiyOdY/vcu2n/14F87FzklxD4ax518URFFHyNUPnUUfgN
	 SEd5kZDX/v/yLKUWt7ixFx1t+puGEN1+Dv6L7z6a4muSiKRlbVjbXAYLk8vv51BNf6
	 nUWPHp1btKcE9AJcsD0Oy5Pl22mGlOfIwpphTVJhcdGBQp4vAZbHaukCYpud3p7dGX
	 5ilI92woP0yGEEaqM8WRpaj2rL/jJEYDoc2cs8mRTZI4CU0pPdnBWkTIIhI/GHk+Js
	 P4SsoqoXjbgaw==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D13251A035DF; Thu, 24 Apr 2025 11:46:34 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH bpf-next v2] bpf: Allow XDP dev-bound programs to
 perform XDP_REDIRECT into maps
In-Reply-To: <20250423-xdp-prog-bound-fix-v2-1-51742a5dfbce@kernel.org>
References: <20250423-xdp-prog-bound-fix-v2-1-51742a5dfbce@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 24 Apr 2025 11:46:34 +0200
Message-ID: <87wmb97uyt.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> In the current implementation if the program is dev-bound to a specific
> device, it will not be possible to perform XDP_REDIRECT into a DEVMAP
> or CPUMAP even if the program is running in the driver NAPI context and
> it is not attached to any map entry. This seems in contrast with the
> explanation available in bpf_prog_map_compatible routine.
> Fix the issue introducing __bpf_prog_map_compatible utility routine in
> order to avoid bpf_prog_is_dev_bound() check running bpf_check_tail_call()
> at program load time (bpf_prog_select_runtime()).
> Continue forbidding to attach a dev-bound program to XDP maps
> (BPF_MAP_TYPE_PROG_ARRAY, BPF_MAP_TYPE_DEVMAP and BPF_MAP_TYPE_CPUMAP).
>
> Fixes: 3d76a4d3d4e59 ("bpf: XDP metadata RX kfuncs")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v2:
> - Introduce __bpf_prog_map_compatible() utility routine in order to skip
>   bpf_prog_is_dev_bound check in bpf_check_tail_call()
> - Extend xdp_metadata selftest
> - Link to v1: https://lore.kernel.org/r/20250422-xdp-prog-bound-fix-v1-1-0b581fa186fe@kernel.org
> ---
>  kernel/bpf/core.c                                  | 27 +++++++++++++---------
>  .../selftests/bpf/prog_tests/xdp_metadata.c        | 22 +++++++++++++++++-
>  tools/testing/selftests/bpf/progs/xdp_metadata.c   | 13 +++++++++++
>  3 files changed, 50 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ba6b6118cf504041278d05417c4212d57be6fca0..a3e571688421196c3ceaed62b3b59b62a0258a8c 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2358,8 +2358,8 @@ static unsigned int __bpf_prog_ret0_warn(const void *ctx,
>  	return 0;
>  }
>  
> -bool bpf_prog_map_compatible(struct bpf_map *map,
> -			     const struct bpf_prog *fp)
> +static bool __bpf_prog_map_compatible(struct bpf_map *map,
> +				      const struct bpf_prog *fp)
>  {
>  	enum bpf_prog_type prog_type = resolve_prog_type(fp);
>  	bool ret;
> @@ -2368,14 +2368,6 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
>  	if (fp->kprobe_override)
>  		return false;
>  
> -	/* XDP programs inserted into maps are not guaranteed to run on
> -	 * a particular netdev (and can run outside driver context entirely
> -	 * in the case of devmap and cpumap). Until device checks
> -	 * are implemented, prohibit adding dev-bound programs to program maps.
> -	 */
> -	if (bpf_prog_is_dev_bound(aux))
> -		return false;
> -
>  	spin_lock(&map->owner.lock);
>  	if (!map->owner.type) {
>  		/* There's no owner yet where we could check for
> @@ -2409,6 +2401,19 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
>  	return ret;
>  }
>  
> +bool bpf_prog_map_compatible(struct bpf_map *map, const struct bpf_prog *fp)
> +{
> +	/* XDP programs inserted into maps are not guaranteed to run on
> +	 * a particular netdev (and can run outside driver context entirely
> +	 * in the case of devmap and cpumap). Until device checks
> +	 * are implemented, prohibit adding dev-bound programs to program maps.
> +	 */
> +	if (bpf_prog_is_dev_bound(fp->aux))
> +		return false;
> +
> +	return __bpf_prog_map_compatible(map, fp);
> +}
> +
>  static int bpf_check_tail_call(const struct bpf_prog *fp)
>  {
>  	struct bpf_prog_aux *aux = fp->aux;
> @@ -2421,7 +2426,7 @@ static int bpf_check_tail_call(const struct bpf_prog *fp)
>  		if (!map_type_contains_progs(map))
>  			continue;
>  
> -		if (!bpf_prog_map_compatible(map, fp)) {
> +		if (!__bpf_prog_map_compatible(map, fp)) {

Hmm, so this allows devbound programs in tail call maps, right? But
there's no guarantee that a tail call map will always be used for a
particular device, is there? For instance, it could be shared between
multiple XDP programs, bound to different devices, thus getting the
wrong kfunc.

Or you could even have dev-bound programs tail-called from non-dev-bound
programs with this change AFAICT?

In other words, I think this is too relaxed, your change in v1 that only
relaxed cpumap and devmap checks here was better.

In fact, I don't really see why bpf_check_tail_call() needs to look at
devmap/cpumap at all, so maybe just changing the
map_type_contains_progs() call to only match tail call maps is better?

-Toke

