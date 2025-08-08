Return-Path: <linux-kselftest+bounces-38598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 647B8B1EC66
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 17:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE541886999
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 15:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4E62853E5;
	Fri,  8 Aug 2025 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIYeKXV4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBCF225A29;
	Fri,  8 Aug 2025 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668291; cv=none; b=INb3n4leueQ5L7CTdkwRYsc1qyA7cTnOw65KhiYzZFNtizAyA1zOM/ep/6DaquMlvbJHqwYYiz8n52uT8zhAXMB4O+YeoyxRJ1WV7NCOWJrGbkXWp/DSMawVuf3y12yXTuXhkqHlVxWqGiQbrXtCCBoTqnepZj9gQMNujbCKNHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668291; c=relaxed/simple;
	bh=9M9vj6O/7T0eVWhnTNWZUnrhO3VOhOj0y1nq7m5+/KE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mtw26uGjRKLMSh79p+/Dbv8ZGssce/JkNUo3CaJtVv73ntfbIBiLWdUWEPepW1I6ug5JeL2KmaNPkylJRmFClklHk5Qg9Wnx7Iu8Xglwfh8JtIoC5fVHvhxCgFB+HjtMO96k6/UufHjjKl0kE9dHjaUosSpCvCmuW2/625JYf5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIYeKXV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2BCC4CEED;
	Fri,  8 Aug 2025 15:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754668290;
	bh=9M9vj6O/7T0eVWhnTNWZUnrhO3VOhOj0y1nq7m5+/KE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RIYeKXV4q5z6kKHjTlMG66L4ft6xNwRXRWfVR048a8Np9uvX7sWmdyRaDON/yfP/m
	 g0YV6UoqFXXYmCbmEwDzuAbrXJXPZmpYuAT27k0f/gBIokFEtVOMAfFXnxn8K7wCiZ
	 58M+8+qi56hsrVR5Nd4QfXhVoHWdDiojV4KV0ebpRH/m6uBWZiuBtHR4jSm75ADUwv
	 Oau/agS+PvoN62brSbn3k7ONiFAzFZ5Ek+B2hb+9QJEOV1SE5gINQnXLtD8GVVoo0J
	 3boyH2aZpnco9cbOim8xX1c6NzgGQB2rkHI2j7dPqoVy/Nf30OjCw2sMdYXh6v5T5D
	 Ee02sCv1R0rXQ==
Message-ID: <94048354-2385-4f65-9c36-64424985613c@kernel.org>
Date: Fri, 8 Aug 2025 17:51:25 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Add LPM trie microbenchmarks
To: Matt Fleming <matt@readmodwrite.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, kernel-team@cloudflare.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, netdev@vger.kernel.org,
 Matt Fleming <mfleming@cloudflare.com>
References: <20250722150152.1158205-1-matt@readmodwrite.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250722150152.1158205-1-matt@readmodwrite.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 22/07/2025 17.01, Matt Fleming wrote:
> From: Matt Fleming<mfleming@cloudflare.com>
> 
> Add benchmarks for the standard set of operations: lookup, update,
> delete. Also, include a benchmark for trie_free() which is known to have
> terrible performance for maps with many entries.
> 
> Benchmarks operate on tries without gaps in the key range, i.e. each
> test begins with a trie with valid keys in the range [0, nr_entries).
> This is intended to cause maximum branching when traversing the trie.
> 
> All measurements are recorded inside the kernel to remove syscall
> overhead.
> 
> Most benchmarks run an XDP program to generate stats but free needs to
> collect latencies using fentry/fexit on map_free_deferred() because it's
> not possible to use fentry directly on lpm_trie.c since commit
> c83508da5620 ("bpf: Avoid deadlock caused by nested kprobe and fentry
> bpf programs") and there's no way to create/destroy a map from within an
> XDP program.
> 
> Here is example output from an AMD EPYC 9684X 96-Core machine for each
> of the benchmarks using a trie with 10K entries and a 32-bit prefix
> length, e.g.
> 
>    $ ./bench lpm-trie-$op \
>    	--prefix_len=32  \
> 	--producers=1     \
> 	--nr_entries=10000
> 
>    lookup: throughput    7.423 ± 0.023 M ops/s (  7.423M ops/prod), latency  134.710 ns/op
>    update: throughput    2.643 ± 0.015 M ops/s (  2.643M ops/prod), latency  378.310 ns/op
>    delete: throughput    0.712 ± 0.008 M ops/s (  0.712M ops/prod), latency 1405.152 ns/op
>      free: throughput    0.574 ± 0.003 K ops/s (  0.574K ops/prod), latency    1.743 ms/op
> 
> Tested-by: Jesper Dangaard Brouer<hawk@kernel.org>

I've run a lot more benchmarks.

I've used a slightly updated version[1] written by Matt, that improve
the "delete" operation accounting that Alexei complain about, but I
guess Matt isn't 100% happy with his approach (as I don't see a V4).
The below "delete" numbers have improved compared to above.

Results from[2] with default 10,000 entries:
  lookup	7.598 ± 0.004 M ops/s	131.608 ns/op
  update	3.247 ± 0.029 M ops/s	308.008 ns/op
  delete	1.747 ± 0.053 M ops/s	572.519 ns/op
  free	0.294 ± 0.055 K ops/s	3.521 ms/op

  [1] 
https://github.com/xdp-project/xdp-project/blob/main/areas/bench/patches/bench-lpm-trie-V3-adjusted.patch
  [2] 
https://github.com/xdp-project/xdp-project/blob/main/areas/bench/bench01_lpm-trie.org

I'm mostly interested in the fast-path lookup performance. Documented
here [3] and links to plots[4]. People seeing these per operations
costs, remember that this includes the get random number cost. That said
is very clear from my data, that LPM trie have problems with cache-line
trashing as number of entries increase.

  [3] 
https://github.com/xdp-project/xdp-project/blob/main/areas/bench/bench02_lpm-trie-lookup.org
  [4] 
https://github.com/xdp-project/xdp-project/blob/main/areas/bench/bench02_lpm-trie-lookup.org#plotting-results

I've also documented the "bench" harness a little[5].

  [5] 
https://github.com/xdp-project/xdp-project/blob/main/areas/bench/README.org

--Jesper


