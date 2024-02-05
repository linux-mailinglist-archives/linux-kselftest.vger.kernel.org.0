Return-Path: <linux-kselftest+bounces-4168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2B984AA78
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Feb 2024 00:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59BDB28D884
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 23:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF763487B2;
	Mon,  5 Feb 2024 23:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JxEzh6tp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47B24BA8F
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Feb 2024 23:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707175497; cv=none; b=t5UFsY7gsjgUd5d1R6RsOiQCCnNwEGCeCLkx8fik0tu2NdPbYQ/jTV2dSt1bVW1aL6XbV+NTcUuxp15fVtlAewKVlwIN/NVPpMutIjUtk34YNauKguRUmLcSzx35jM/sl4KaDBhos9c3kd7+EESwD2kVR78/C5a8l3gJP1wLo2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707175497; c=relaxed/simple;
	bh=y3Ra/aPyXFejjmK6Gi4QOmq1Gn2dv0Xmng3txeAbyng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6lg6nIit4bS4yeZZRZeGCjCOd/6VaQI97qSkUCk1BENzyQw7rwZXUeczL3yeTOegB2kXU8L/R70YfuQgDmLJyQeUm2DdgE5ZwdLA1fI8DhxI2cJn/ZIp+2bKGXeC3frYAtmF3bhEGCjLtjLYy57dWPHZkeaXyaIsRLcNHm8M/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JxEzh6tp; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5a08032b-ed4d-4429-b0a9-2736689d8c33@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707175493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3W4biwjTNLI62PNfsqhj18Fa+p++jpbdxldJj1IjrJQ=;
	b=JxEzh6tpnpG+Wmmxm3eutJ7ZLIMRxeUtZKBc+mwSXTZiRstt6qXrSpIIbQIVzYdiF/YnL7
	Z4yBFsoe1OKLa4WFhr7zQPD4kWanQfawljUFMNAwoxvvErE3I/Y3oL2nOhyPJSmxUlTjA2
	2vmhaoi5RPEdN9EiEC1V/WdYUTsOAiQ=
Date: Mon, 5 Feb 2024 15:24:43 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Separate bpf_local_storage_lookup() fast and slow
 paths
Content-Language: en-US
To: Marco Elver <elver@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240131141858.1149719-1-elver@google.com>
 <b500bb70-aa3f-41d3-b058-2b634471ffef@linux.dev>
 <CANpmjNPKACDwXMnZRw9=CAgWNaMWAyFZ2W7KY2s4ck0s_ue1ag@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CANpmjNPKACDwXMnZRw9=CAgWNaMWAyFZ2W7KY2s4ck0s_ue1ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/5/24 7:00 AM, Marco Elver wrote:
> On Wed, 31 Jan 2024 at 20:52, Martin KaFai Lau <martin.lau@linux.dev> wrote:
> [...]
>>> | num_maps: 1000
>>> |  local_storage cache sequential  get:
>>> |                              <before>                | <after>
>>> |   hits throughput:           0.357 ± 0.005 M ops/s   | 0.325 ± 0.005 M ops/s        (-9.0%)
>>> |   hits latency:              2803.738 ns/op          | 3076.923 ns/op               (+9.7%)
>>
>> Is it understood why the slow down here? The same goes for the "num_maps: 32"
>> case above but not as bad as here.
> 
> It turned out that there's a real slowdown due to the outlined
> slowpath. If I inline everything except for inserting the entry into
> the cache (cacheit_lockit codepath is still outlined), the results
> look much better even for the case where it always misses the cache.
> 
> [...]
>>> diff --git a/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c b/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
>>> index a043d8fefdac..9895087a9235 100644
>>> --- a/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
>>> +++ b/tools/testing/selftests/bpf/progs/cgrp_ls_recursion.c
>>> @@ -21,7 +21,7 @@ struct {
>>>        __type(value, long);
>>>    } map_b SEC(".maps");
>>>
>>> -SEC("fentry/bpf_local_storage_lookup")
>>> +SEC("fentry/bpf_local_storage_lookup_slowpath")
>>
>> The selftest is trying to catch recursion. The change here cannot test the same
>> thing because the slowpath will never be hit in the test_progs.  I don't have a
>> better idea for now also.
> 
> Trying to prepare a v2, and for the test, the only option I see is to
> introduce a tracepoint ("bpf_local_storage_lookup"). If unused, should
> be a no-op due to static branch.
> 
> Or can you suggest different functions to hook to for the recursion test?

I don't prefer to add another tracepoint for the selftest.

The test in "SEC("fentry/bpf_local_storage_lookup")" is testing that the initial 
bpf_local_storage_lookup() should work and the immediate recurred 
bpf_task_storage_delete() will fail.

Depends on how the new slow path function will look like in v2. The test can 
probably be made to go through the slow path, e.g. by creating a lot of task 
storage maps before triggering the lookup.

