Return-Path: <linux-kselftest+bounces-46516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA69C8A8D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 16:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8DE24E5C75
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 15:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0309430F523;
	Wed, 26 Nov 2025 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYGFYTGy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7152FF641;
	Wed, 26 Nov 2025 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764169901; cv=none; b=MVC96ZE36Ao1xPJsD3feDgkq6Cu34mPyuT7mDKCveP+L2xm9F4/V+2fHNkK1ll0IY1S8o+yNz4Me6w+WVmtlDzFn6plQoppfI45b+AUJ4JWmwTD0XyLNtbFKRooUhQQUEVI7vBV3shQ+RMUlaX5q3lw853SDBDYfMNa6XDNL+TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764169901; c=relaxed/simple;
	bh=d/QM0S/pSEIwi+HHUkT0P92IJNOak5frWoh3QkPeuUc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XAx39K5b5SlDaPpKFADjSKfqM7h+H+ZTe4KqlwmrvLTX3xvC+6d58JGuO1ha5PJUx9oWKVIHHVv7S8o/CVT+jv+5lJ7PrSn5LCdgJC8mvQNvLUVLtX8Qn5TjhqechO2DdQi+OerIOVZNQbBu1ryd6CfVE6ZT0Wh48UpIi8xxjcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYGFYTGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B18C4CEF7;
	Wed, 26 Nov 2025 15:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764169900;
	bh=d/QM0S/pSEIwi+HHUkT0P92IJNOak5frWoh3QkPeuUc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=NYGFYTGyOZWKLuzfOIHv2CMnZVNY50x/JmaKl5r9qmNGPC38rBrC5A4nKhbtVJn32
	 tFB17x5Cn3j48aF59AvSUtGASW9z2fvkiuGjx3W3ZHxSLwIawTVQji3QRP4wEqQ4Mg
	 Gjd6hpxfe4G/mFVh7E6MObldfP0hVnO2DPfBzdojEoRBifLeSEdbsfgkOf4b+0JbkG
	 pG3G8RBVmqLKEYh0tpnkui3Jmp8DLvVhE10NhzfC9Q3oauEgALrl1niszpzoxXcw98
	 fn+BQ+1mYlkTujHkD4vfZgZ1ABlKGD7Cy6YdpaPAgmhV6K+nnZ/Cbswc14SESKTp1j
	 V6K4fEVR1Gbsw==
Content-Type: multipart/mixed; boundary="===============3920617201380884988=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <07707b44fc9032398db551041498d6265ccf0a0313ecd8779bd1fa82a7d96409@mail.kernel.org>
In-Reply-To: <20251126145039.15715-3-leon.hwang@linux.dev>
References: <20251126145039.15715-3-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v12 2/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_array maps
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jolsa@kernel.org,yonghong.song@linux.dev,song@kernel.org,eddyz87@gmail.com,dxu@dxuuu.xyz,deso@posteo.net,martin.lau@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,shuah@kernel.org,kerneljasonxing@gmail.com,chen.dylane@linux.dev,willemb@google.com,paul.chaignon@gmail.com,a.s.protopopov@gmail.com,memxor@gmail.com,yatsenko@meta.com,tklauser@distanz.ch,leon.hwang@linux.dev,kernel-patches-bot@fb.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 26 Nov 2025 15:11:40 +0000 (UTC)

--===============3920617201380884988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index d84af3719..01a99e3a3 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 1eeb31c5b..67e9e811d 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c

[ ... ]

> @@ -398,10 +405,11 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
>  	struct bpf_array *array = container_of(map, struct bpf_array, map);
>  	u32 index = *(u32 *)key;
>  	void __percpu *pptr;
> -	int cpu, off = 0;
> +	void *ptr, *val;
>  	u32 size;
> +	int cpu;
>
> -	if (unlikely(map_flags > BPF_EXIST))
> +	if (unlikely((map_flags & BPF_F_LOCK) || (u32)map_flags > BPF_F_ALL_CPUS))
>  		/* unknown flags */
>  		return -EINVAL;
>
> @@ -409,7 +417,7 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
>  		/* all elements were pre-allocated, cannot insert a new one */
>  		return -E2BIG;
>
> -	if (unlikely(map_flags & BPF_NOEXIST))
> +	if (unlikely(map_flags == BPF_NOEXIST))
                              ^^

Does changing this from bitwise-AND to equality break flag combination
handling? The old code checked (map_flags & BPF_NOEXIST), which would
trigger for any flag combination including BPF_NOEXIST. The new code only
checks (map_flags == BPF_NOEXIST), so if userspace passes
(BPF_F_CPU | BPF_NOEXIST), the BPF_NOEXIST flag gets silently ignored
instead of returning -EEXIST as before.

While all elements in percpu_array maps are pre-allocated and BPF_NOEXIST
should always fail anyway, silently ignoring a flag the user explicitly set
seems inconsistent with the principle of rejecting invalid flag combinations
at validation time.

>  		/* all elements already exist */
>  		return -EEXIST;
>

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19708012130

--===============3920617201380884988==--

