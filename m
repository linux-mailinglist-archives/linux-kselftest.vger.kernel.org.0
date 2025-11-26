Return-Path: <linux-kselftest+bounces-46514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB36C8A8CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 16:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D6C44E23FF
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 15:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D2330B53A;
	Wed, 26 Nov 2025 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXptKun5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7FF30B511;
	Wed, 26 Nov 2025 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764169897; cv=none; b=KL93KHSn0PVifzrCq7FD1VxqLCjqDh0JuhSq9LO3gcc5TO4eFW5m3Q8R7eJm3jkM4k6RMYZ6JegDz+XxbORinkDCr3JkjIhwXXqhTHbeDor5u9hOSUoMygD+JqINcdTHr/8hAmTa/OteFm5EfG87BDiAwTkamnZpw/sO/foxfQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764169897; c=relaxed/simple;
	bh=UrzcQh3sg6kcWBdDCfvd5VPfbA+6VsJInFfrGlUinsI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iOgry0t3V4xZMms1+ka4Hk+ZY8zeB0VnkkZr1whg+UTaB+0GusB9+p4dsEc6VoCZwPN41co45IjB3t7nWatSlHTVRYc+FObn0QUtj8XBOobhqvBOSyi3jMzidLIabNh0W+i/7dRZhy+mdnBA02JVbxEg6nHH+BxCFMNx96IPlW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXptKun5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5D8C4CEF7;
	Wed, 26 Nov 2025 15:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764169897;
	bh=UrzcQh3sg6kcWBdDCfvd5VPfbA+6VsJInFfrGlUinsI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=UXptKun57dM6a0o0LRQB0kqL/6mSoQztVqD7epfkXrwdkxVxyN6S8zc/CsQBnGOI3
	 M7lCmRHRi5sjJs2iMd0gfZ8pyLHuMzs/W2DlV6/Av6GDSTZdmmh3GrDoxLaloF+qsG
	 HHmAXy8ydDtGReZzCam9XZCTPa/REjeDAJ9dst0i1v3iE+eb7LqlYRskWW1t6V1Kqf
	 Wk4a6iEyJDPzNyMQa5mv/xKC+pZJDXM2vP2OHuKX+hisFKq5INpw3tNieP52rqmDUF
	 tqGwWG/tg29CQr3hcLz7nN0fCxMTGpj3X+F9GYqFM1jC+OGLC9bSxZCb+ZNBq5CaS+
	 dDTPKnh+qNWsw==
Content-Type: multipart/mixed; boundary="===============5907589292713514585=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f33b87ffc7d3884dab5f73d90ba3f29afd4ee5975be512532702228363cde72e@mail.kernel.org>
In-Reply-To: <20251126145039.15715-4-leon.hwang@linux.dev>
References: <20251126145039.15715-4-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v12 3/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_hash and lru_percpu_hash maps
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jolsa@kernel.org,yonghong.song@linux.dev,song@kernel.org,eddyz87@gmail.com,dxu@dxuuu.xyz,deso@posteo.net,martin.lau@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,shuah@kernel.org,kerneljasonxing@gmail.com,chen.dylane@linux.dev,willemb@google.com,paul.chaignon@gmail.com,a.s.protopopov@gmail.com,memxor@gmail.com,yatsenko@meta.com,tklauser@distanz.ch,leon.hwang@linux.dev,kernel-patches-bot@fb.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 26 Nov 2025 15:11:36 +0000 (UTC)

--===============5907589292713514585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 01a99e3a3..f79d2ae27 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index c8a9b27f8..441ff5bc5 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -1249,6 +1258,15 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
>  	return ret;
>  }
>
> +static int htab_map_check_update_flags(bool onallcpus, u64 map_flags)
> +{
> +	if (unlikely(!onallcpus && map_flags > BPF_EXIST))
> +		return -EINVAL;
> +	if (unlikely(onallcpus && ((map_flags & BPF_F_LOCK) || (u32)map_flags > BPF_F_ALL_CPUS)))
> +		return -EINVAL;
> +	return 0;
> +}
> +

Can htab_map_check_update_flags() correctly validate the new flags?

When onallcpus=false (the common case for normal map_update_elem
operations via htab_percpu_map_update_elem()->
htab_map_update_elem_in_place()), the check at the first if statement
compares the full 64-bit map_flags value against BPF_EXIST (2).

When BPF_F_CPU (8) is set, or when the CPU number is embedded in the
upper 32 bits (e.g., 0x0000000100000008 for CPU 1), map_flags will be
greater than BPF_EXIST, causing this function to return -EINVAL.

This appears inconsistent with the equivalent check in
bpf_percpu_array_update() (commit 51f40f83b), which uses:

  if (unlikely((map_flags & BPF_F_LOCK) || (u32)map_flags > BPF_F_ALL_CPUS))

The percpu_array check casts to u32 to examine only the lower 32 bits,
allowing the CPU number in the upper 32 bits. The hash table check for
onallcpus=false doesn't perform this cast, so it will reject valid flag
combinations that include BPF_F_CPU.

Would this prevent the BPF_F_CPU functionality from working for normal
percpu_hash update operations?

> @@ -1262,9 +1280,9 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
>  	u32 key_size, hash;
>  	int ret;
>
> -	if (unlikely(map_flags > BPF_EXIST))
> -		/* unknown flags */
> -		return -EINVAL;
> +	ret = htab_map_check_update_flags(onallcpus, map_flags);
> +	if (unlikely(ret))
> +		return ret;
>
>  	WARN_ON_ONCE(!bpf_rcu_lock_held());
>

[ ... ]

> @@ -1324,9 +1342,9 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
>  	u32 key_size, hash;
>  	int ret;
>
> -	if (unlikely(map_flags > BPF_EXIST))
> -		/* unknown flags */
> -		return -EINVAL;
> +	ret = htab_map_check_update_flags(onallcpus, map_flags);
> +	if (unlikely(ret))
> +		return ret;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19708012130

--===============5907589292713514585==--

