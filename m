Return-Path: <linux-kselftest+bounces-46928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F204C9DA63
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 04:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8D1E3347558
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 03:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1460722FE0E;
	Wed,  3 Dec 2025 03:33:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF512AE99;
	Wed,  3 Dec 2025 03:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764732791; cv=none; b=t//SQU5tcqtqcmA1B71dqaYZeQYKWMvwfGA3Sf5vNwxKdPeIca/AQesYAOQfoGt8NZzhUJXWffxJzjM3hKKfEQA8aJvV5cHn3MDmwIXVc1J+90iqSTXQlosO5YAr+IWss6IGPYSBfAzuQjMQdnQAPKn+pS6IMV8HcISnn4hkV4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764732791; c=relaxed/simple;
	bh=WB558lfCQypsSto++jyDD7sWZpxQX6pfmqwIr4F0X6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cby4dYsswNvGLWm8ui+BK7oqvjMjS9UhiQCEpzUDQwWL34G2f0T8WXFerxzZjb4IqyohrL1R0K1AM0PSS6OUXR2nvfpguZP2gFS5dwEw99hGqP1+XRUL6A0SgP2wO4gdQJ94y3oMgl/pvzFlA1bPQUlhzIjZG5sBp2nbhZFfYtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c35bdddecff811f0a38c85956e01ac42-20251203
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:9a00bd03-6b51-4c8e-a6c4-06e0aa533551,IP:10,U
	RL:0,TC:0,Content:2,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:7
X-CID-INFO: VERSION:1.3.6,REQID:9a00bd03-6b51-4c8e-a6c4-06e0aa533551,IP:10,URL
	:0,TC:0,Content:2,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:7
X-CID-META: VersionHash:a9d874c,CLOUDID:29264af93e65bb32178012985f7e831d,BulkI
	D:2512030718596DCL6T2J,BulkQuantity:1,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|898,TC:nil,Content:4|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:
	nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
	,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c35bdddecff811f0a38c85956e01ac42-20251203
X-User: zhangguopeng@kylinos.cn
Received: from [192.168.24.105] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1777734155; Wed, 03 Dec 2025 11:32:58 +0800
Message-ID: <d38858d9-3a40-463b-a38a-acb1cbf6ca3a@kylinos.cn>
Date: Wed, 3 Dec 2025 11:32:55 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] selftests: cgroup: Replace sleep with
 cg_read_key_long_poll() for waiting on nr_dying_descendants
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: tj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
 roman.gushchin@linux.dev, mkoutny@suse.com, muchun.song@linux.dev,
 lance.yang@linux.dev, shuah@kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251124123816.486164-1-zhangguopeng@kylinos.cn>
 <20251124123816.486164-4-zhangguopeng@kylinos.cn>
 <3p7o2cxir6yz4baonmkrzumklg5zx3oddhi7mqlmxu26j7ze33@u2mrvj6pqad4>
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
In-Reply-To: <3p7o2cxir6yz4baonmkrzumklg5zx3oddhi7mqlmxu26j7ze33@u2mrvj6pqad4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/3/25 07:18, Shakeel Butt wrote:
> On Mon, Nov 24, 2025 at 08:38:16PM +0800, Guopeng Zhang wrote:
>> Replaced the manual sleep and retry logic in test_kmem_dead_cgroups() with the new
>> helper `cg_read_key_long_poll()`.  This change improves the robustness of the test by
>> polling the "nr_dying_descendants" counter in `cgroup.stat` until it reaches 0 or the timeout is exceeded.
>>
>> Additionally, increased the retry timeout to 8 seconds (from 5 seconds) based on testing results:
> 
> Why 8 seconds? What does it depend on? For memcg stats I see the 3
> seconds driven from the 2 sec periodic rstat flush. Mainly how can we
> make this more future proof?
> 
Hi Shakeel,

Thanks a lot for the review and for the guidance.

The 8s timeout was chosen based on stress testing of test_kmem_dead_cgroups()
on my setup: 5s was not always sufficient under load, while 8s consistently
covered the reclaim of dying descendants. It is intended as a generous upper
bound for the asynchronous reclaim and is not tied to any specific kernel
constant. If the reclaim behavior changes significantly in the future, this
timeout can be adjusted along with the test.
>>   - With 5-second timeout: 4/20 runs passed.
>>   - With 8-second timeout: 20/20 runs passed.
>>
>> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> 
> Anyways, just add a sentence in the commit message on the reasoning
> behind 8 seconds and a comment in code as well. With that, you can add:
> 
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
I’ll add a short sentence to the commit message and a comment next to
KMEM_DEAD_WAIT_RETRIES explaining this rationale, and will include your:

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

in the next version.

Thanks,
Guopeng


