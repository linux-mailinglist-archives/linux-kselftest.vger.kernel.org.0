Return-Path: <linux-kselftest+bounces-46515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D15CC8A8BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 16:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B41E3A3D82
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 15:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2DA30E0EB;
	Wed, 26 Nov 2025 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klwzmebW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01D430C368;
	Wed, 26 Nov 2025 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764169899; cv=none; b=I4Jm0PilHA4UOLkUmhJdPSvpl7ll8qjHkxwNuH6ACygdAgU1Kylh0Ny3MxalvUVaCd3OwVmu5ql+QRUpLikvP4i1SyhcHB12cpvxZPMLr3ekL3uSxzeyJBdJoKqxeNdpgUdpwBrpxDVmSaFzA01I6rEXjvMoaWqH3WuaIHTwSxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764169899; c=relaxed/simple;
	bh=lhKyl86xtvsOfYKDgcEE8MT+kuSHuQsucm9ssM6ao4U=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CEmXWWc3tefN/CJlPuAh1EUWHWHX3k9hVrfjQE/xOImRdLfpN+Yy9lFiVS5JPtTSHwNOuMgApninIapzvRQAu+NV40lbLERda4ONzsPhVAOJSermWGxvkLeTRhY9e+fYFOhBRywFTeJ73B4N/9X9oHlwybw3qfe95TlQaTY4Rcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klwzmebW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D7DC4CEF7;
	Wed, 26 Nov 2025 15:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764169899;
	bh=lhKyl86xtvsOfYKDgcEE8MT+kuSHuQsucm9ssM6ao4U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=klwzmebWUh1vHqid4faCKWZYB9kXTHCrjIaMbpQ/F1WFSTP95CcvEnmYICo0u6ftf
	 qRNJCwj8sSnLrD1YdOA4vaLe8VvRvAU2GkoMBAYUvmGsoK3o9tpTpXWIJObpnYRWFS
	 CohIn20Vwb3pFQMZCVCmq+rkPTo9as+/t3oVSM5Twz7QLpKuAzyknE7/2ilI2x03wv
	 bRAxzCPlo7yXyzCQM9FJ4qv6YpqSMaj/iqAn6VpYYfvYk3V+zJzSbTe0ZaTkhayjIa
	 SAqhfB/SSOOvujirrgtOHXhpf5LCuq6mP3/ebMDyX9NMt7LyIneSYO8Biyh3H7gNRD
	 pklabnk6k66WA==
Content-Type: multipart/mixed; boundary="===============7714676400305535017=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <edd9991150f1456a7868025636825d7cf7595802e4a2fe405900c53fc1799ed8@mail.kernel.org>
In-Reply-To: <20251126145039.15715-6-leon.hwang@linux.dev>
References: <20251126145039.15715-6-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v12 5/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_cgroup_storage maps
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jolsa@kernel.org,yonghong.song@linux.dev,song@kernel.org,eddyz87@gmail.com,dxu@dxuuu.xyz,deso@posteo.net,martin.lau@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,shuah@kernel.org,kerneljasonxing@gmail.com,chen.dylane@linux.dev,willemb@google.com,paul.chaignon@gmail.com,a.s.protopopov@gmail.com,memxor@gmail.com,yatsenko@meta.com,tklauser@distanz.ch,leon.hwang@linux.dev,kernel-patches-bot@fb.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 26 Nov 2025 15:11:38 +0000 (UTC)

--===============7714676400305535017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index aedf573bd..013f4db99 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h

[ ... ]

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f79d2ae27..9e756db5e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> index 2ab4b60ff..1ccbf28b2 100644
> --- a/kernel/bpf/local_storage.c
> +++ b/kernel/bpf/local_storage.c
> @@ -180,7 +180,7 @@ static long cgroup_storage_update_elem(struct bpf_map *map, void *key,
>  }
>
>  int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *key,
> -				   void *value)
> +				   void *value, u64 map_flags)
>  {
>  	struct bpf_cgroup_storage_map *map = map_to_storage(_map);
>  	struct bpf_cgroup_storage *storage;
> @@ -198,11 +198,17 @@ int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *key,
>  	 * access 'value_size' of them, so copying rounded areas
>  	 * will not leak any kernel data
>  	 */
> +	if (map_flags & BPF_F_CPU) {
> +		cpu = map_flags >> 32;
> +		copy_map_value(_map, value, per_cpu_ptr(storage->percpu_buf, cpu));
> +		goto unlock;
> +	}

Should check_and_init_map_value() be called here after copy_map_value()?

The similar implementations in bpf_percpu_array_copy() and
bpf_percpu_hash_copy() both call check_and_init_map_value() after
copying a single CPU's value when BPF_F_CPU is set:

  bpf_percpu_array_copy():
    if (map_flags & BPF_F_CPU) {
        cpu = map_flags >> 32;
        copy_map_value(map, value, per_cpu_ptr(pptr, cpu));
        check_and_init_map_value(map, value);
        goto unlock;
    }

  bpf_percpu_hash_copy():
    if (map_flags & BPF_F_CPU) {
        cpu = map_flags >> 32;
        copy_map_value(map, value, per_cpu_ptr(pptr, cpu));
        check_and_init_map_value(map, value);
        goto out;
    }

The check_and_init_map_value() call initializes special BTF fields
(timers, kptrs, etc.) when copying map values to userspace. Without it,
these fields might not be properly initialized if percpu_cgroup_storage
map values contain such fields.

>  	size = round_up(_map->value_size, 8);
>  	for_each_possible_cpu(cpu) {
>  		copy_map_value_long(_map, value + off, per_cpu_ptr(storage->percpu_buf, cpu));
>  		off += size;
>  	}
> +unlock:
>  	rcu_read_unlock();
>  	return 0;
>  }

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19708012130

--===============7714676400305535017==--

