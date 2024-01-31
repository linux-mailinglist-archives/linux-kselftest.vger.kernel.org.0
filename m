Return-Path: <linux-kselftest+bounces-3876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 188E9844860
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 21:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B9A1C238A0
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 20:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAADB3F8F9;
	Wed, 31 Jan 2024 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lrFX2Wii"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78C03F8C0;
	Wed, 31 Jan 2024 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706731451; cv=none; b=Yvt8OkYs9XXjhmPW9JQYppyROb4WHleEdw7lJm2IHMh/J2u1CCNmNwUcnIRJM4uRb7hy+ov/6v7bR8AjpccimPqymnnZ4xT8uKdMjsreOdTZ4lWfKZeqGb4EQQujGZty9WMeXrMCxufprpRf9ZCYxv3+/DXkFNxGzRSUTYne0HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706731451; c=relaxed/simple;
	bh=H3X8hBE9MpoUWzlBFFbwUiJxMKacKJ2HbGRILneORiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHdYdTosvuAVuO+KKscZlxXIfbR1cp02BWmFTQ587oQqPRHyR60sQL2vvyJbU8JlbUaogu6RRGFVDL2Le0rwWsDDruz/lwkB8LtLmITJRqhjBBAq+e3fdbV5DgcXUJsHVdiVqbpHdeQ1IP2hjPHlkHyUxfi2O6R4IGgYDu6LBxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lrFX2Wii; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bd3d594e-55e7-47c3-99f4-efc1a4688fb2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706731446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZwLfC8CGeTzzOoxYrLLyAKkP2cIJ8WWC+JNjubQjcm8=;
	b=lrFX2WiigN0GpqwMGX9SYK2DYC0HacFx3LT3/EtVCF72Pk/e6kOTwt5Wpb0V+tOOso8N7l
	oYhyBkeSE1AkfhJKV6/l43GoQ70SWfH0pcfqqdqT7G0E3yi7u+0YM7Bn1/vy7XTZBGKwiK
	+fizEjoqZg2cDtyLtwPm/Rwf8S6hLO8=
Date: Wed, 31 Jan 2024 12:04:00 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Separate bpf_local_storage_lookup() fast and slow
 paths
Content-Language: en-GB
To: Marco Elver <elver@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240131141858.1149719-1-elver@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240131141858.1149719-1-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/31/24 6:18 AM, Marco Elver wrote:
> To allow the compiler to inline the bpf_local_storage_lookup() fast-
> path, factor it out by making bpf_local_storage_lookup() a static inline
> function and move the slow-path to bpf_local_storage_lookup_slowpath().
>
> Base on results from './benchs/run_bench_local_storage.sh' this produces
> improvements in throughput and latency in the majority of cases:
>
> | Hashmap Control
> | ===============
> | num keys: 10
> |  hashmap (control) sequential get:
> |                              <before>                | <after>
> |   hits throughput:           13.895 ± 0.024 M ops/s  | 14.022 ± 0.095 M ops/s	(+0.9%)
> |   hits latency:              71.968 ns/op            | 71.318 ns/op		(-0.9%)
> |   important_hits throughput: 13.895 ± 0.024 M ops/s  | 14.022 ± 0.095 M ops/s	(+0.9%)
> |
> | num keys: 1000
> |  hashmap (control) sequential get:
> |                              <before>                | <after>
> |   hits throughput:           11.793 ± 0.018 M ops/s  | 11.645 ± 0.370 M ops/s	(-1.3%)
> |   hits latency:              84.794 ns/op            | 85.874 ns/op		(+1.3%)
> |   important_hits throughput: 11.793 ± 0.018 M ops/s  | 11.645 ± 0.370 M ops/s	(-1.3%)
> |
> | num keys: 10000
> |  hashmap (control) sequential get:
> |                              <before>                | <after>
> |   hits throughput:           7.113 ± 0.012 M ops/s   | 7.037 ± 0.051 M ops/s	(-1.1%)
> |   hits latency:              140.581 ns/op           | 142.113 ns/op		(+1.1%)
> |   important_hits throughput: 7.113 ± 0.012 M ops/s   | 7.037 ± 0.051 M ops/s	(-1.1%)
> |
> | num keys: 100000
> |  hashmap (control) sequential get:
> |                              <before>                | <after>
> |   hits throughput:           4.793 ± 0.034 M ops/s   | 4.990 ± 0.025 M ops/s	(+4.1%)
> |   hits latency:              208.623 ns/op           | 200.401 ns/op		(-3.9%)
> |   important_hits throughput: 4.793 ± 0.034 M ops/s   | 4.990 ± 0.025 M ops/s	(+4.1%)
> |
> | num keys: 4194304
> |  hashmap (control) sequential get:
> |                              <before>                | <after>
> |   hits throughput:           2.088 ± 0.008 M ops/s   | 2.962 ± 0.004 M ops/s	(+41.9%)
> |   hits latency:              478.851 ns/op           | 337.648 ns/op		(-29.5%)
> |   important_hits throughput: 2.088 ± 0.008 M ops/s   | 2.962 ± 0.004 M ops/s	(+41.9%)
> |
> | Local Storage
> | =============
> | num_maps: 1
> |  local_storage cache sequential  get:
> |                              <before>                | <after>
> |   hits throughput:           32.598 ± 0.008 M ops/s  | 38.480 ± 0.054 M ops/s	(+18.0%)
> |   hits latency:              30.676 ns/op            | 25.988 ns/op		(-15.3%)
> |   important_hits throughput: 32.598 ± 0.008 M ops/s  | 38.480 ± 0.054 M ops/s	(+18.0%)
> |  local_storage cache interleaved get:
> |                              <before>                | <after>
> |   hits throughput:           36.963 ± 0.045 M ops/s  | 43.847 ± 0.037 M ops/s	(+18.6%)
> |   hits latency:              27.054 ns/op            | 22.807 ns/op		(-15.7%)
> |   important_hits throughput: 36.963 ± 0.045 M ops/s  | 43.847 ± 0.037 M ops/s	(+18.6%)
> |
> | num_maps: 10
> |  local_storage cache sequential  get:
> |                              <before>                | <after>
> |   hits throughput:           32.078 ± 0.004 M ops/s  | 37.813 ± 0.020 M ops/s	(+17.9%)
> |   hits latency:              31.174 ns/op            | 26.446 ns/op		(-15.2%)
> |   important_hits throughput: 3.208 ± 0.000 M ops/s   | 3.781 ± 0.002 M ops/s	(+17.9%)
> |  local_storage cache interleaved get:
> |                              <before>                | <after>
> |   hits throughput:           34.564 ± 0.011 M ops/s  | 40.082 ± 0.037 M ops/s	(+16.0%)
> |   hits latency:              28.932 ns/op            | 24.949 ns/op		(-13.8%)
> |   important_hits throughput: 12.344 ± 0.004 M ops/s  | 14.315 ± 0.013 M ops/s	(+16.0%)
> |
> | num_maps: 16
> |  local_storage cache sequential  get:
> |                              <before>                | <after>
> |   hits throughput:           32.493 ± 0.023 M ops/s  | 38.147 ± 0.029 M ops/s	(+17.4%)
> |   hits latency:              30.776 ns/op            | 26.215 ns/op		(-14.8%)
> |   important_hits throughput: 2.031 ± 0.001 M ops/s   | 2.384 ± 0.002 M ops/s	(+17.4%)
> |  local_storage cache interleaved get:
> |                              <before>                | <after>
> |   hits throughput:           34.380 ± 0.521 M ops/s  | 41.605 ± 0.095 M ops/s	(+21.0%)
> |   hits latency:              29.087 ns/op            | 24.035 ns/op		(-17.4%)
> |   important_hits throughput: 10.939 ± 0.166 M ops/s  | 13.238 ± 0.030 M ops/s	(+21.0%)
> |
> | num_maps: 17
> |  local_storage cache sequential  get:
> |                              <before>                | <after>
> |   hits throughput:           28.748 ± 0.028 M ops/s  | 32.248 ± 0.080 M ops/s	(+12.2%)
> |   hits latency:              34.785 ns/op            | 31.009 ns/op		(-10.9%)
> |   important_hits throughput: 1.693 ± 0.002 M ops/s   | 1.899 ± 0.005 M ops/s	(+12.2%)
> |  local_storage cache interleaved get:
> |                              <before>                | <after>
> |   hits throughput:           31.313 ± 0.030 M ops/s  | 35.911 ± 0.020 M ops/s	(+14.7%)
> |   hits latency:              31.936 ns/op            | 27.847 ns/op		(-12.8%)
> |   important_hits throughput: 9.533 ± 0.009 M ops/s   | 10.933 ± 0.006 M ops/s	(+14.7%)
> |
> | num_maps: 24
> |  local_storage cache sequential  get:
> |                              <before>                | <after>
> |   hits throughput:           18.475 ± 0.027 M ops/s  | 19.000 ± 0.006 M ops/s	(+2.8%)
> |   hits latency:              54.127 ns/op            | 52.632 ns/op		(-2.8%)
> |   important_hits throughput: 0.770 ± 0.001 M ops/s   | 0.792 ± 0.000 M ops/s	(+2.9%)
> |  local_storage cache interleaved get:
> |                              <before>                | <after>
> |   hits throughput:           21.361 ± 0.028 M ops/s  | 22.388 ± 0.099 M ops/s	(+4.8%)
> |   hits latency:              46.814 ns/op            | 44.667 ns/op		(-4.6%)
> |   important_hits throughput: 6.009 ± 0.008 M ops/s   | 6.298 ± 0.028 M ops/s	(+4.8%)
> |
> | num_maps: 32
> |  local_storage cache sequential  get:
> |                              <before>                | <after>
> |   hits throughput:           14.220 ± 0.006 M ops/s  | 14.168 ± 0.020 M ops/s	(-0.4%)
> |   hits latency:              70.323 ns/op            | 70.580 ns/op		(+0.4%)
> |   important_hits throughput: 0.445 ± 0.000 M ops/s   | 0.443 ± 0.001 M ops/s	(-0.4%)
> |  local_storage cache interleaved get:
> |                              <before>                | <after>
> |   hits throughput:           17.250 ± 0.011 M ops/s  | 16.650 ± 0.021 M ops/s	(-3.5%)
> |   hits latency:              57.971 ns/op            | 60.061 ns/op		(+3.6%)
> |   important_hits throughput: 4.815 ± 0.003 M ops/s   | 4.647 ± 0.006 M ops/s	(-3.5%)
> |
> | num_maps: 100
> |  local_storage cache sequential  get:
> |                              <before>                | <after>
> |   hits throughput:           5.212 ± 0.012 M ops/s   | 5.878 ± 0.004 M ops/s	(+12.8%)
> |   hits latency:              191.877 ns/op           | 170.116 ns/op		(-11.3%)
> |   important_hits throughput: 0.052 ± 0.000 M ops/s   | 0.059 ± 0.000 M ops/s	(+13.5%)
> |  local_storage cache interleaved get:
> |                              <before>                | <after>
> |   hits throughput:           6.521 ± 0.053 M ops/s   | 7.086 ± 0.010 M ops/s	(+8.7%)
> |   hits latency:              153.343 ns/op           | 141.116 ns/op		(-8.0%)
> |   important_hits throughput: 1.703 ± 0.014 M ops/s   | 1.851 ± 0.003 M ops/s	(+8.7%)
> |
> | num_maps: 1000
> |  local_storage cache sequential  get:
> |                              <before>                | <after>
> |   hits throughput:           0.357 ± 0.005 M ops/s   | 0.325 ± 0.005 M ops/s	(-9.0%)
> |   hits latency:              2803.738 ns/op          | 3076.923 ns/op		(+9.7%)
> |   important_hits throughput: 0.000 ± 0.000 M ops/s   | 0.000 ± 0.000 M ops/s
> |  local_storage cache interleaved get:
> |                              <before>                | <after>
> |   hits throughput:           0.434 ± 0.007 M ops/s   | 0.447 ± 0.007 M ops/s	(+3.0%)
> |   hits latency:              2306.539 ns/op          | 2237.687 ns/op		(-3.0%)
> |   important_hits throughput: 0.109 ± 0.002 M ops/s   | 0.112 ± 0.002 M ops/s	(+2.8%)
>
> Signed-off-by: Marco Elver <elver@google.com>

Thanks for the patch. This indeed could improve performance with inlining.
In Meta, we started to use LTO kernel which already have
bpf_local_storage_lookup() cross-file inlined into
bpf_sk_storage_lookup(), so we won't be able to reap
this benefit.

In the subject, please use tag [PATCH bpf-next] so CI can
pick it up for testing properly.

[...]


