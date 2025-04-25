Return-Path: <linux-kselftest+bounces-31630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A10C2A9C01A
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 09:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5803B437A
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 07:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB9E230BF8;
	Fri, 25 Apr 2025 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCbRrNTi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A941DED49;
	Fri, 25 Apr 2025 07:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745567403; cv=none; b=jq6d1AUGT0Ks3FPhT6V2DKc0ncg9fRQyyFrpzKUew32+aBS/3pV19dW5t3AY4l4NLqOiHTRcv9aaOMHh0k/M2ERbbkGNlNKTNkavuSEGMkotG9icmOvbIXuFYKDcOX1UAzPh6/Td732hS2lA2MLXHpxWSIq4RS6pzNfaIF3+eLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745567403; c=relaxed/simple;
	bh=QHkZ2w2krqWg8kpw96Vq3sOxWvbIiIYjOXmgILg98Bg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MK0Wl1zonAzrDsbbm8F5Asex4t+x6zHc5jeXrDVjTZVpEygOaeaFGZEtozGBKFoT7ZOpwz13OaRCxUp/elGkmm+5CjyqCH2mYjuN7KyB2fr9t8Ih0QszSY72E/EPXlit0TH4y2IvjEnyRDRul4W0oBht5xaRBOpNh16KsjFe5Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCbRrNTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C0BC4CEE4;
	Fri, 25 Apr 2025 07:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745567402;
	bh=QHkZ2w2krqWg8kpw96Vq3sOxWvbIiIYjOXmgILg98Bg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DCbRrNTihtuIYKfP2GPR2CxzfZPocrxdsrAV+3YYKmMmsPv7dU1D4wIrtbglsE8gp
	 yrMsQCYkeJyYlDvBcH9fBhfucUmh3DxAr7Ifz29YuYTBSLQEy/IcccKdwtEKgCI6Oh
	 1OuDTFcyg7emDLu3AeswxJ/aGGJwjbmWseyOO/YRDAy4YdAIPuAEd8RHn2uLcAhu16
	 gjhAH7Ro852nke1poQ7MMF987WecfIXg0cSRN6xWJVrUye8C2F8agOrpk/hTw/6Z9M
	 s4e2BwZ5Vp123iloCXrGvbhOw5YuKzpIWfQjYbJ3Y6gF2UXaOsRKqr059KixcHyFGH
	 EALlvzHYVvmIg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8E83D1A037D4; Fri, 25 Apr 2025 09:49:49 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: Allow XDP dev-bound programs to
 perform XDP_REDIRECT into maps
In-Reply-To: <aAqjTz7O4HpuVspL@lore-rh-laptop>
References: <20250423-xdp-prog-bound-fix-v2-1-51742a5dfbce@kernel.org>
 <87wmb97uyt.fsf@toke.dk> <aAqjTz7O4HpuVspL@lore-rh-laptop>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 25 Apr 2025 09:49:49 +0200
Message-ID: <87frhw7k9u.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Bianconi <lorenzo@kernel.org> writes:

>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> 
>> > In the current implementation if the program is dev-bound to a specific
>> > device, it will not be possible to perform XDP_REDIRECT into a DEVMAP
>> > or CPUMAP even if the program is running in the driver NAPI context and
>> > it is not attached to any map entry. This seems in contrast with the
>> > explanation available in bpf_prog_map_compatible routine.
>> > Fix the issue introducing __bpf_prog_map_compatible utility routine in
>> > order to avoid bpf_prog_is_dev_bound() check running bpf_check_tail_call()
>> > at program load time (bpf_prog_select_runtime()).
>> > Continue forbidding to attach a dev-bound program to XDP maps
>> > (BPF_MAP_TYPE_PROG_ARRAY, BPF_MAP_TYPE_DEVMAP and BPF_MAP_TYPE_CPUMAP).
>> >
>> > Fixes: 3d76a4d3d4e59 ("bpf: XDP metadata RX kfuncs")
>> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> > ---
>> > Changes in v2:
>> > - Introduce __bpf_prog_map_compatible() utility routine in order to skip
>> >   bpf_prog_is_dev_bound check in bpf_check_tail_call()
>> > - Extend xdp_metadata selftest
>> > - Link to v1: https://lore.kernel.org/r/20250422-xdp-prog-bound-fix-v1-1-0b581fa186fe@kernel.org
>> > ---
>> >  kernel/bpf/core.c                                  | 27 +++++++++++++---------
>> >  .../selftests/bpf/prog_tests/xdp_metadata.c        | 22 +++++++++++++++++-
>> >  tools/testing/selftests/bpf/progs/xdp_metadata.c   | 13 +++++++++++
>> >  3 files changed, 50 insertions(+), 12 deletions(-)
>> >
>> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> > index ba6b6118cf504041278d05417c4212d57be6fca0..a3e571688421196c3ceaed62b3b59b62a0258a8c 100644
>> > --- a/kernel/bpf/core.c
>> > +++ b/kernel/bpf/core.c
>> > @@ -2358,8 +2358,8 @@ static unsigned int __bpf_prog_ret0_warn(const void *ctx,
>> >  	return 0;
>> >  }
>> >  
>> > -bool bpf_prog_map_compatible(struct bpf_map *map,
>> > -			     const struct bpf_prog *fp)
>> > +static bool __bpf_prog_map_compatible(struct bpf_map *map,
>> > +				      const struct bpf_prog *fp)
>> >  {
>> >  	enum bpf_prog_type prog_type = resolve_prog_type(fp);
>> >  	bool ret;
>> > @@ -2368,14 +2368,6 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
>> >  	if (fp->kprobe_override)
>> >  		return false;
>> >  
>> > -	/* XDP programs inserted into maps are not guaranteed to run on
>> > -	 * a particular netdev (and can run outside driver context entirely
>> > -	 * in the case of devmap and cpumap). Until device checks
>> > -	 * are implemented, prohibit adding dev-bound programs to program maps.
>> > -	 */
>> > -	if (bpf_prog_is_dev_bound(aux))
>> > -		return false;
>> > -
>> >  	spin_lock(&map->owner.lock);
>> >  	if (!map->owner.type) {
>> >  		/* There's no owner yet where we could check for
>> > @@ -2409,6 +2401,19 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
>> >  	return ret;
>> >  }
>> >  
>> > +bool bpf_prog_map_compatible(struct bpf_map *map, const struct bpf_prog *fp)
>> > +{
>> > +	/* XDP programs inserted into maps are not guaranteed to run on
>> > +	 * a particular netdev (and can run outside driver context entirely
>> > +	 * in the case of devmap and cpumap). Until device checks
>> > +	 * are implemented, prohibit adding dev-bound programs to program maps.
>> > +	 */
>> > +	if (bpf_prog_is_dev_bound(fp->aux))
>> > +		return false;
>> > +
>> > +	return __bpf_prog_map_compatible(map, fp);
>> > +}
>> > +
>> >  static int bpf_check_tail_call(const struct bpf_prog *fp)
>> >  {
>> >  	struct bpf_prog_aux *aux = fp->aux;
>> > @@ -2421,7 +2426,7 @@ static int bpf_check_tail_call(const struct bpf_prog *fp)
>> >  		if (!map_type_contains_progs(map))
>> >  			continue;
>> >  
>> > -		if (!bpf_prog_map_compatible(map, fp)) {
>> > +		if (!__bpf_prog_map_compatible(map, fp)) {
>> 
>> Hmm, so this allows devbound programs in tail call maps, right? But
>> there's no guarantee that a tail call map will always be used for a
>> particular device, is there? For instance, it could be shared between
>> multiple XDP programs, bound to different devices, thus getting the
>> wrong kfunc.
>
> According to my understanding the following path will be executed just for
> dev-bound program that performs XDP_REDIRECT into a BPF_MAP_TYPE_PROG_ARRAY:
>
> bpf_prog_select_runtime() -> bpf_check_tail_call() -> __bpf_prog_map_compatible()
>
> while for XDP program inserted into BPF_MAP_TYPE_PROG_ARRAY we will continue
> running bpf_prog_map_compatible() so we will forbid inserting ev-bound programs.
> This is even tested into xdp_metadata selftest:
>
> https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c#L416
>
> It seems to me v2 is not more relaxed than v1. Am I missing something?

No, you're right; see my reply to Stanislav - I misremembered the logic :)

-Toke

