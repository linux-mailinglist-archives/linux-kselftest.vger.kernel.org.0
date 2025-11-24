Return-Path: <linux-kselftest+bounces-46389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C157FC80FC0
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 15:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886A93A80FA
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 14:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BF23043BD;
	Mon, 24 Nov 2025 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BWoOOJLX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8B92A1C7
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763994263; cv=none; b=OMg8HSGnsNwfXJZ/olLVLiAq+hcOJ63nByKRkycg700hN6sbFE8AvoZ4gCMD9f2xMF+TiBtPh9bma88ThwynxIUwsz9AWp2UGe56N3MXkAFkDnKrbRr7NFB/0kKbVrEptVsPEktLmtBh1lYbnqipxrimftsDC681CdJclwRMSNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763994263; c=relaxed/simple;
	bh=HopjOyG0yLSJ8H+vj0g0gPLWne0fYbdJ7c/qNICipdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBhw8dcSvEIq+GI7SoAkcrvMcjB024XZ1SHlAKXZmPWEi0vy7ORrRQlN7DSTzytiPIqWA2Ac/Ku7VRU0jNFNpwSJ9hbkGaTJ/fQz4I98nM31CVuqB40ZXn30Ww4qqpiLwF3gqwH2KCvMtpEGnb8esntlof4+qKQAmVKNFk92zqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BWoOOJLX; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5a633862-ae0e-43ba-8da6-0f03efd01bde@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763994258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qeiYgrXnmUsYEngedEc4LRUzDKY1yGdvKClr67ha3/A=;
	b=BWoOOJLXEfTp9oNy8Vs/hkx+lOu7wJ/edsodeHAB4HPCtx+Tlp/6gzTEPZr3RgvhB2bPff
	Yw2mfFUh6/wlqgoLbeBLMePKs+UiRWKlj2mWWBB1k7X7QcvfjMQHtsfDFZU1kCrcVRLoL5
	MYsccu9PgW7SX5X7I36qJYwDi/TXQVg=
Date: Mon, 24 Nov 2025 22:23:53 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v10 8/8] selftests/bpf: Add cases to test
 BPF_F_CPU and BPF_F_ALL_CPUS flags
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>,
 Daniel Xu <dxu@dxuuu.xyz>, =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Shuah Khan <shuah@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>,
 Tao Chen <chen.dylane@linux.dev>, Willem de Bruijn <willemb@google.com>,
 Paul Chaignon <paul.chaignon@gmail.com>,
 Anton Protopopov <a.s.protopopov@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>, Tobias Klauser <tklauser@distanz.ch>,
 kernel-patches-bot@fb.com, LKML <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <20251117162033.6296-1-leon.hwang@linux.dev>
 <20251117162033.6296-9-leon.hwang@linux.dev>
 <CAADnVQLARr69Qv9EfwWkpudXLZNb21zYd86aPux_Fv3UAsrLGw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQLARr69Qv9EfwWkpudXLZNb21zYd86aPux_Fv3UAsrLGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/11/22 10:34, Alexei Starovoitov wrote:
> On Mon, Nov 17, 2025 at 8:22 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>

[...]

>> +
>> +                       /* lookup then check value on CPUs */
>> +                       for (j = 0; j < nr_cpus; j++) {
>> +                               flags = (u64)j << 32 | BPF_F_CPU;
>> +                               err = bpf_map__lookup_elem(map, keys + i * key_sz, key_sz, values,
>> +                                                          value_sz, flags);
>> +                               if (!ASSERT_OK(err, "bpf_map__lookup_elem specified cpu"))
>> +                                       goto out;
>> +                               if (!ASSERT_EQ(values[0], j != cpu ? 0 : value,
>> +                                              "bpf_map__lookup_elem value on specified cpu"))
>> +                                       goto out;
> 
> I was about to apply it, but noticed that the test is unstable.
> It fails 1 out of 10 for me in the above line.
> test_percpu_map_op_cpu_flag:PASS:bpf_map_lookup_batch value on
> specified cpu 0 nsec
> test_percpu_map_op_cpu_flag:FAIL:bpf_map_lookup_batch value on
> specified cpu unexpected bpf_map_lookup_batch value on specified cpu:
> actual 0 != expected 3735929054
> #261/15  percpu_alloc/cpu_flag_lru_percpu_hash:FAIL
> #261     percpu_alloc:FAIL
> 
> Please investigate what is going on.
> 

I was able to reproduce the failure on a 16-core VM.

It appears to be caused by LRU eviction. When I increased max_entries of
the lru_percpu_hash map to libbpf_num_possible_cpus(), the issue no
longer reproduced.

I'll need to spend more time investigating the exact eviction behavior
and why it shows up intermittently in this test.

Thanks,
Leon

