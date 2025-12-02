Return-Path: <linux-kselftest+bounces-46890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04382C9C0AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 16:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4B824E268C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 15:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470733242B8;
	Tue,  2 Dec 2025 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9eTeKRs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB0F1EB193;
	Tue,  2 Dec 2025 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764690984; cv=none; b=UqmBOhkcPw9ezx8wObWMNqpHn4YJTOeIAIAkFVQSURmVPqdk8olPpGjDMuNBqpw2kgCtHv6y7TRPeOrfgryGnBXMIYbk4Fcw4p3FulYAiHa7wPNYvWiJwcnSwxDborJOg9CeSVmV/GZR9VVvezsQ51K08/AkxqhOldCu20oBqfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764690984; c=relaxed/simple;
	bh=++2IOkQlw/nO4LizW1PkL4S0/6+JLMTRLO0OjXOGjA4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=oSwIE+etqxZ8gwWVeGbFM1HzbMbUx5CiADsAHeEKHmj/6nHA9yk7VPb2KoCV0TOiOm5guVWKPzQdV+uttXi3yhznGr61PaADIqzJNfERlT/d7q0Lv43a5ULxR5PBsSGBS4xhq+EumAzaxkjGQcfhYkTKJwa6cgGK2LmOQbxs6Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9eTeKRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D7AC4CEF1;
	Tue,  2 Dec 2025 15:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764690983;
	bh=++2IOkQlw/nO4LizW1PkL4S0/6+JLMTRLO0OjXOGjA4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=R9eTeKRsBh3T2ew9zzxp4zqnddPACfRfy2uOE/HiQhW4s56FTZOd4V0L0qYObawXF
	 ny1ELzArNmcguJoJo1RQ6vSD2jIkcCXlh8PmydskdAyl3MRm8NNgH6PLOEuNCRU6ds
	 CujuPyTbKAmckpB3MlYhd5SaquW9wG8yqqhnTNjFqbQyNlEYQ6SNRGXBZHeIYXbo7l
	 LxoRjQHmTZHJZvGtIFgum5B1KhmAwNXd4HyVOo+5J5OKbAQ3aGVW9vnGa3T9aSNWp0
	 fAqqowwwflBfM+uCS+kS/AcYnjyoOtdaE0UNQa3NckVuTjpunwe3o+RHi7EGRSClNx
	 6avJUgWKBHqLA==
Content-Type: multipart/mixed; boundary="===============3063947242897467359=="
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <09491a8e930081007a29db98e86fae762e662ff371db8267bdd94f8ba45aae39@mail.kernel.org>
In-Reply-To: <20251202153032.10118-4-leon.hwang@linux.dev>
References: <20251202153032.10118-4-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add tests to verify no unintended eviction when updating lru hash maps
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,leon.hwang@linux.dev,skb99@linux.ibm.com,davem@davemloft.net,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  2 Dec 2025 15:56:21 +0000 (UTC)

--===============3063947242897467359==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/htab_update.c b/tools/testing/selftests/bpf/prog_tests/htab_update.c
> index d0b405eb2..bd29a915b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/htab_update.c
> +++ b/tools/testing/selftests/bpf/prog_tests/htab_update.c

[ ... ]

> +static void test_lru_hash_map_update_elem(enum bpf_map_type map_type)
> +{
> +	int err, map_fd, i, key, nr_cpus, max_entries = 128;
> +	u64 *values, value = 0xDEADC0DE;
> +
> +	nr_cpus = libbpf_num_possible_cpus();
> +	if (!ASSERT_GT(nr_cpus, 0, "libbpf_num_possible_cpus"))
> +		return;
> +
> +	values = calloc(nr_cpus, sizeof(u64));

[ ... ]

> +	err = bpf_map_lookup_elem(map_fd, &key, values);
> +	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
> +		goto out;
> +	if (!ASSERT_EQ(*values, 0, "bpf_map_lookup_elem value"))
> +		goto out;
> +
> +	for (key = 1; key < max_entries; key++) {
> +		err = bpf_map_lookup_elem(map_fd, &key, values);
> +		if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
> +			goto out;
> +		if (!ASSERT_EQ(*values, value, "bpf_map_lookup_elem value"))
> +			goto out;
> +	}

When test_lru_hash_map_update_elem() is called with
BPF_MAP_TYPE_LRU_PERCPU_HASH via test_update_lru_percpu_hash_map(),
should all CPU values be checked rather than just *values?

For percpu maps, bpf_map_lookup_elem() returns an array with one value
per CPU. The test allocates space for nr_cpus values but only verifies
the first element. This means values for CPUs 1 through nr_cpus-1 are
not validated.

Looking at tools/testing/selftests/bpf/prog_tests/lookup_and_delete.c,
the pattern for percpu maps is to loop through all CPUs:

    for (i = 0; i < nr_cpus; i++) {
        val = value[i];
        /* check val */
    }

For BPF_MAP_TYPE_LRU_HASH this is correct, but for
BPF_MAP_TYPE_LRU_PERCPU_HASH the test may pass even if non-primary
CPUs have incorrect values.

> +
> +out:
> +	close(map_fd);
> +	free(values);
> +}
> +
> +static void test_update_lru_hash_map(void)
> +{
> +	test_lru_hash_map_update_elem(BPF_MAP_TYPE_LRU_HASH);
> +}
> +
> +static void test_update_lru_percpu_hash_map(void)
> +{
> +	test_lru_hash_map_update_elem(BPF_MAP_TYPE_LRU_PERCPU_HASH);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19864460617

--===============3063947242897467359==--

