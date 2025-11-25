Return-Path: <linux-kselftest+bounces-46448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AB7C85C04
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 16:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007D93AF92C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 15:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F86D327C13;
	Tue, 25 Nov 2025 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiCMwtGY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13922239E7F;
	Tue, 25 Nov 2025 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764084261; cv=none; b=lBqdrICaj8+LlM/g1zhnzGTDsa27JwQNqeOhI0XVXWlIgnGQwsOdkug1hv6E9gcou4RD6aBNtICiQdCzzezi4sbuQ0XOPng01KWgFBGrirfwuCkYhHFu/HFyS4WUWLgDK17aKuZIQsXuzMN0oI9Nx/FWQ2FCDnig8yy6cZ9hDUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764084261; c=relaxed/simple;
	bh=skaRmpcARcoPMCvbTj8iSF7JhuIiZTFUq5qGHuG1qjQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=BhSfFAtKQT3wCU/Ht29GGVVW1OK8Fbjt/+kk/cs/+cgxjYcz/08/tUUCXgXoM6bgY87WQaN8UfvSZMuvAygxjr1b91wDCIX7qYQSsRA+v6fnD29wQXeM0hzWOs6/q6IssoOaaJo1PPAalTqO/cHqzFJM61+X5EahuIasl4Q32Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiCMwtGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12333C4CEF1;
	Tue, 25 Nov 2025 15:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764084260;
	bh=skaRmpcARcoPMCvbTj8iSF7JhuIiZTFUq5qGHuG1qjQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=CiCMwtGY/ldLvqFqhPjYtFCht8bHF3ehgMONQk7MScEOzROHenzRgkaqGldIs9QP9
	 LRisI0eZeBpF2McQH6CtxwK3z/CenfUIgIwWk5Uq6qp/vAt1A+psCE+nEcgrxabtWi
	 F3jgrnsdJfCqZUVEEmHIwVzQKWSzscRakyWyIBqH21KerXr+Es8YWfbFXT1PwbLKvg
	 DhBjkUzxZw2YsQI/ABES6kE8L4coJb0lXGcnmMgCsvw3ecDKr/DK6/nz5P8iPKMRYv
	 +eaQF8pC66sVfpuBH10Qj8djwURn1+VjQ72LT7+ZHGZM+50IwrOsYcX9SQ20p2s8xc
	 LWe4c5iPth6Wg==
Content-Type: multipart/mixed; boundary="===============2535521487941337947=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ceddf1642622347c5208e25b020429354c523327fc5fe9b031212a9d91d8bd26@mail.kernel.org>
In-Reply-To: <20251125145857.98134-4-leon.hwang@linux.dev>
References: <20251125145857.98134-4-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v11 3/8] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_array maps
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jolsa@kernel.org,yonghong.song@linux.dev,song@kernel.org,eddyz87@gmail.com,dxu@dxuuu.xyz,deso@posteo.net,martin.lau@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,shuah@kernel.org,kerneljasonxing@gmail.com,chen.dylane@linux.dev,willemb@google.com,paul.chaignon@gmail.com,a.s.protopopov@gmail.com,memxor@gmail.com,yatsenko@meta.com,tklauser@distanz.ch,leon.hwang@linux.dev,kernel-patches-bot@fb.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 25 Nov 2025 15:24:20 +0000 (UTC)

--===============2535521487941337947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 1eeb31c5b..241f11d4d 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c

[ ... ]

> @@ -398,18 +405,18 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
>  	struct bpf_array *array = container_of(map, struct bpf_array, map);
>  	u32 index = *(u32 *)key;
>  	void __percpu *pptr;
> -	int cpu, off = 0;
> +	void *ptr, *val;
>  	u32 size;
> +	int cpu;
>
> -	if (unlikely(map_flags > BPF_EXIST))
> -		/* unknown flags */
> +	if (unlikely(map_flags & BPF_F_LOCK))
>  		return -EINVAL;
>
>  	if (unlikely(index >= array->map.max_entries))
>  		/* all elements were pre-allocated, cannot insert a new one */
>  		return -E2BIG;
>
> -	if (unlikely(map_flags == BPF_NOEXIST))
> +	if (unlikely(map_flags & BPF_NOEXIST))
>  		/* all elements already exist */
>  		return -EEXIST;

This isn't a bug, but the change from equality check to bit test might
allow confusing flag combinations. The old code rejected map_flags > 2,
which prevented BPF_NOEXIST | BPF_EXIST (flags=3) entirely. With the new
bit test, userspace can pass both flags and BPF_NOEXIST takes precedence.

Should bpf_map_check_op_flags() validate mutual exclusivity of BPF_NOEXIST
and BPF_EXIST, similar to how it validates BPF_F_CPU and BPF_F_ALL_CPUS at
include/linux/bpf.h:3858?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19674301388

--===============2535521487941337947==--

