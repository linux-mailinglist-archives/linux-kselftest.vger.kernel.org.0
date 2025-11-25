Return-Path: <linux-kselftest+bounces-46449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE73C85C19
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 16:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9E654EA8EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 15:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C151232860B;
	Tue, 25 Nov 2025 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIu6wgKp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94571239E7F;
	Tue, 25 Nov 2025 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764084264; cv=none; b=WQgeWXboe0H6p55WwRG8qRHgIY04jqZQZUvK3kuZCOB6k+QfwyonBxw0Zpaz/6NtosHmOaxclUaXhw3k8HLot4U0dbY6hjai7ufdTFQz3GGCPYorJWPNPPUhGB8UB/g1HZJusAg2cZH7zk38DUgh3jb1jizYg4l+H0zZI9bZIhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764084264; c=relaxed/simple;
	bh=tyJxwbMpZJ1gnCKxfaavtlEGlLXrwDrTIgAkujR99T8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hjHrIWSHIuI8rpWGq0uqQnP0dUuKhEYeJ4ieqFva2Dwps86lQ+cSZbelolnRHrZReFNaVRhfm7K4OI9K6h5e+U3HKSG1FZUBNnQin+LjZNgJgKgVfB8iRRwdZZlvMYsTEs/snmGj7H2ydHxwsfGbbyrAHov/6LwDQ9ZtACFLFPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIu6wgKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92136C4CEF1;
	Tue, 25 Nov 2025 15:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764084264;
	bh=tyJxwbMpZJ1gnCKxfaavtlEGlLXrwDrTIgAkujR99T8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=EIu6wgKpIJUm/DofIPClk0HIESpUjGzb2Med/zDoyKHtuHLhtyqBqt3pHRJy9MSVR
	 tzQFpnU9WwHR0NssFDHqhm8jNr6PHx6zdA0KtEuU9we0K/h5TV6BhhsIk1mduqyWNN
	 dkw7ezy2jbs2s7VHIzLOJuN+MOGnXBDTc4vmKmkhStzOwWcsHQ9jV7noy9gZBoB/8P
	 O6qnzt9rif8+EN48IPyNsWb1NDQVOnb5qJYQV2mzkliS/dEbbEnB+uPJU2Kh23IK42
	 PHHryQ2KzjopZgz3AwSpnGvhfygIkFmYJngJ+n7pcwtYAeZsJSe04PCHCdFtcewarP
	 WV/RLm+ON5RSQ==
Content-Type: multipart/mixed; boundary="===============1067285565325027886=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <93d46a7f17d77926f071bf654862d4967eadc1b2d9c020732991e5120519da07@mail.kernel.org>
In-Reply-To: <20251125145857.98134-6-leon.hwang@linux.dev>
References: <20251125145857.98134-6-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v11 5/8] bpf: Copy map value using copy_map_value_long for percpu_cgroup_storage maps
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jolsa@kernel.org,yonghong.song@linux.dev,song@kernel.org,eddyz87@gmail.com,dxu@dxuuu.xyz,deso@posteo.net,martin.lau@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,shuah@kernel.org,kerneljasonxing@gmail.com,chen.dylane@linux.dev,willemb@google.com,paul.chaignon@gmail.com,a.s.protopopov@gmail.com,memxor@gmail.com,yatsenko@meta.com,tklauser@distanz.ch,leon.hwang@linux.dev,kernel-patches-bot@fb.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 25 Nov 2025 15:24:23 +0000 (UTC)

--===============1067285565325027886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> index c93a756e0..2ab4b60ff 100644
> --- a/kernel/bpf/local_storage.c
> +++ b/kernel/bpf/local_storage.c
> @@ -200,8 +200,7 @@ int bpf_percpu_cgroup_storage_copy(struct bpf_map *_map, void *key,
>  	 */
>  	size = round_up(_map->value_size, 8);
>  	for_each_possible_cpu(cpu) {
> -		bpf_long_memcpy(value + off,
> -				per_cpu_ptr(storage->percpu_buf, cpu), size);
> +		copy_map_value_long(_map, value + off, per_cpu_ptr(storage->percpu_buf, cpu));
>  		off += size;
>  	}

Should this be calling check_and_init_map_value() after the copy,
similar to how it's done in other percpu maps? For example, in
bpf_percpu_array_copy():

    for_each_possible_cpu(cpu) {
        copy_map_value_long(map, value + off, per_cpu_ptr(pptr, cpu));
        check_and_init_map_value(map, value + off);
        off += size;
    }

And in percpu_hash lookup:

    for_each_possible_cpu(cpu) {
        copy_map_value_long(&htab->map, value + off, per_cpu_ptr(pptr, cpu));
        check_and_init_map_value(&htab->map, value + off);
        off += roundup_value_size;
    }

When copy_map_value_long() skips special fields like bpf_spin_lock or
bpf_timer (which happens when map->record is non-NULL), those fields
are left uninitialized in the destination buffer. The check_and_init_
map_value() call initializes these special fields via bpf_obj_init().

While BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE is deprecated and existing
users don't appear to use special fields, the inconsistency with other
percpu map implementations could be confusing. Also, the commit message
states "No functional change intended", but copy_map_value_long()
behaves differently from bpf_long_memcpy() when map->record is
non-NULL.

> @@ -234,8 +233,7 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *_map, void *key,
>  	 */
>  	size = round_up(_map->value_size, 8);
>  	for_each_possible_cpu(cpu) {
> -		bpf_long_memcpy(per_cpu_ptr(storage->percpu_buf, cpu),
> -				value + off, size);
> +		copy_map_value_long(_map, per_cpu_ptr(storage->percpu_buf, cpu), value + off);
>  		off += size;
>  	}

Same question here for the update path.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19674301388

--===============1067285565325027886==--

