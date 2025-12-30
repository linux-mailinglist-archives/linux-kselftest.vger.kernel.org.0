Return-Path: <linux-kselftest+bounces-48014-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E919ACE9C85
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 14:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19327301459D
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 13:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D47022F388;
	Tue, 30 Dec 2025 13:25:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEE91E5B95;
	Tue, 30 Dec 2025 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767101105; cv=none; b=CE7fZdmlaNVqZj5ss25Z0TuDTrviMa844NQ+TAc0MmjkKPLPxdXIq1UbEuIFByGDdG916JMGARl6kKAVixU1tRIXhnKT4Xl+bDf4M0Zsl+U+NfxcX7Td2tMN1g4EaPj+9s6uL4sTHpCAHGbKUJTIDWHlJQbmH70z4jKlzta/uWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767101105; c=relaxed/simple;
	bh=9rXcf/tMrp2AS71h6Y9QELSB2bEzY2RP0QI91OrkfqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ReSBaQ5ZAqlmR05lZCq/jaqlQX07m0RfnNDoQ3fMHrRfAJrqhlSXQjjMfQddIIIyExFx/KTf9Vr+jqiziIJ+iHWLPDtCGeXFNe4fOCAyYGFVYPtlujtbxu22/9rAaT/v+GKb4nOH2MPP9CmKNYk41ZvGaFAtfgezUurDGp1mfMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dgYhT6LhXzYQtsb;
	Tue, 30 Dec 2025 21:24:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A71B04056E;
	Tue, 30 Dec 2025 21:24:58 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgAniPim0lNpM+wYCA--.38240S2;
	Tue, 30 Dec 2025 21:24:56 +0800 (CST)
Message-ID: <31d3fdfa-799e-426b-bb64-42e06392f0b4@huaweicloud.com>
Date: Tue, 30 Dec 2025 21:24:53 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/3] Memory Controller eBPF support
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Hui Zhu <hui.zhu@linux.dev>, jiayuan.chen@linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
 Tejun Heo <tj@kernel.org>, Jeff Xu <jeffxu@chromium.org>,
 Jan Hendrik Farr <kernel@jfarr.cc>, Christian Brauner <brauner@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Brian Gerst <brgerst@gmail.com>,
 Masahiro Yamada <masahiroy@kernel.org>, davem@davemloft.net,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Hui Zhu <zhuhui@kylinos.cn>
References: <cover.1767012332.git.zhuhui@kylinos.cn>
 <enlefo5mmoha2htsrvv76tdmj6yum4jan6hgym76adtpxuhvrp@aug6qh3ocde5>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <enlefo5mmoha2htsrvv76tdmj6yum4jan6hgym76adtpxuhvrp@aug6qh3ocde5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAniPim0lNpM+wYCA--.38240S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr4kAFW7Zw4xJr18tryxXwb_yoW8tw17pF
	WkKFy8WFWkXw17tw4kZ39F9a1Iv395Gr43KFn3Jry7K3ZFqr12vr4Iyr4UuFZrZFnxtr10
	vryY9w4ku3Z0v3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8
	Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	j6a0PUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/30 17:49, Michal Koutný wrote:
> Hi Hui.
> 
> On Tue, Dec 30, 2025 at 11:01:58AM +0800, Hui Zhu <hui.zhu@linux.dev> wrote:
>> This allows administrators to suppress low-priority cgroups' memory
>> usage based on custom policies implemented in BPF programs.
> 
> BTW memory.low was conceived as a work-conserving mechanism for
> prioritization of different workloads. Have you tried that? No need to
> go directly to (high) limits. (<- Main question, below are some
> secondary implementation questions/remarks.)
> 
> ...
>> This series introduces a BPF hook that allows reporting
>> additional "pages over high" for specific cgroups, effectively
>> increasing memory pressure and throttling for lower-priority
>> workloads when higher-priority cgroups need resources.
> 
> Have you considered hooking into calculate_high_delay() instead? (That
> function has undergone some evolution so it'd seem like the candidate
> for BPFication.)
> 

+1

This issue[1] might be resolved by hooking into calculate_high_delay().

[1] https://lore.kernel.org/cgroups/4txrfjc5lqkmydmsesfq3l5drmzdio6pkmtfb64sk3ld6bwkhs@w4dkn76s4dbo/T/#t

> ...
>> 3. Cgroup hierarchy management (inheritance during online/offline)
> 
> I see you're copying the program upon memcg creation.
> Configuration copies aren't such a good way to properly handle
> hierarchical behavior.
> I wonder if this could follow the more generic pattern of how BPF progs
> are evaluated in hierarchies, see BPF_F_ALLOW_OVERRIDE and
> BPF_F_ALLOW_MULTI.
> 
> 
>> Example Results
> ...
>> Results show the low-priority cgroup (/sys/fs/cgroup/low) was
>> significantly throttled:
>> - High-priority cgroup: 21,033,377 bogo ops at 347,825 ops/s
>> - Low-priority cgroup: 11,568 bogo ops at 177 ops/s
>>
>> The stress-ng process in the low-priority cgroup experienced a
>> ~99.9% slowdown in memory operations compared to the
>> high-priority cgroup, demonstrating effective priority
>> enforcement through BPF-controlled memory pressure.
> 
> As a demonstrator, it'd be good to compare this with a baseline without
> any extra progs, e.g. show that high-prio performed better and low-prio
> wasn't throttled for nothing.
> 
> Thanks,
> Michal

-- 
Best regards,
Ridong


