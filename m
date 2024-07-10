Return-Path: <linux-kselftest+bounces-13447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE26292CCC0
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 10:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AC101C21303
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 08:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5A78526A;
	Wed, 10 Jul 2024 08:19:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B91042076;
	Wed, 10 Jul 2024 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599589; cv=none; b=pOdDvfIBOZtktMPKiS5cMUwDdK/58j2U9X5XqsB02idJjjNFeCWReoFbFsMYBotTrtEFHRcuXIhH6RWMM7GdPWn80Z2xhsKqGTJM2KvFBq/RHbQ4vc1rGxDtuQOGUlUAITJhCHK7AhvwrIZmLEhrpDmRZw2r4hMCXunMKOtEN6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599589; c=relaxed/simple;
	bh=7S+cpVKiFu9oUMBpcHU6sD8vxcZ1GPeBY2k3VRYEi/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iDbwjQNQphfHpGXNh+CTrN86IRj2cI4ljyDlJPFGffV9QXCORtStSYE3jGhH4B/XGLS5K5HM65+sA74s4mg14VCIgdXXogtAxImfNGgn8nb5IDqC0IvXdfW1BFsxkRGDpnOVSNYmWxkFSb0z9aUQNG4G76HKSP534YnWeC0hVu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WJrJz2SGxzQkjs;
	Wed, 10 Jul 2024 16:15:47 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AB59180088;
	Wed, 10 Jul 2024 16:19:43 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 10 Jul 2024 16:19:41 +0800
Message-ID: <2336576e-1ed4-cd5e-5535-2d9b88218dae@huawei.com>
Date: Wed, 10 Jul 2024 16:19:41 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] uprobes: Optimize the return_instance related
 routines
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@fomichev.me>, <haoluo@google.com>, <mykolal@fb.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20240709005142.4044530-1-liaochang1@huawei.com>
 <20240709005142.4044530-2-liaochang1@huawei.com>
 <CAEf4BzYDrVJXnAruko-h5-oXCGuZ92x4KnY-2cD=XXBp1U_kBg@mail.gmail.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <CAEf4BzYDrVJXnAruko-h5-oXCGuZ92x4KnY-2cD=XXBp1U_kBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/7/10 7:55, Andrii Nakryiko 写道:
> On Mon, Jul 8, 2024 at 6:00 PM Liao Chang <liaochang1@huawei.com> wrote:
>>
>> Reduce the runtime overhead for struct return_instance data managed by
>> uretprobe. This patch replaces the dynamic allocation with statically
>> allocated array, leverage two facts that are limited nesting depth of
>> uretprobe (max 64) and the function call style of return_instance usage
>> (create at entry, free at exit).
>>
>> This patch has been tested on Kunpeng916 (Hi1616), 4 NUMA nodes, 64
>> cores @ 2.4GHz. Redis benchmarks show a throughput gain by 2% for Redis
>> GET and SET commands:
>>
>> ------------------------------------------------------------------
>> Test case       | No uretprobes | uretprobes     | uretprobes
>>                 |               | (current)      | (optimized)
>> ==================================================================
>> Redis SET (RPS) | 47025         | 40619 (-13.6%) | 41529 (-11.6%)
>> ------------------------------------------------------------------
>> Redis GET (RPS) | 46715         | 41426 (-11.3%) | 42306 (-9.4%)
>> ------------------------------------------------------------------
>>
>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>> ---
>>  include/linux/uprobes.h |  10 ++-
>>  kernel/events/uprobes.c | 162 ++++++++++++++++++++++++----------------
>>  2 files changed, 105 insertions(+), 67 deletions(-)
>>
> 
> [...]
> 
>> +static void cleanup_return_instances(struct uprobe_task *utask, bool chained,
>> +                                    struct pt_regs *regs)
>> +{
>> +       struct return_frame *frame = &utask->frame;
>> +       struct return_instance *ri = frame->return_instance;
>> +       enum rp_check ctx = chained ? RP_CHECK_CHAIN_CALL : RP_CHECK_CALL;
>> +
>> +       while (ri && !arch_uretprobe_is_alive(ri, ctx, regs)) {
>> +               ri = next_ret_instance(frame, ri);
>> +               utask->depth--;
>> +       }
>> +       frame->return_instance = ri;
>> +}
>> +
>> +static struct return_instance *alloc_return_instance(struct uprobe_task *task)
>> +{
>> +       struct return_frame *frame = &task->frame;
>> +
>> +       if (!frame->vaddr) {
>> +               frame->vaddr = kcalloc(MAX_URETPROBE_DEPTH,
>> +                               sizeof(struct return_instance), GFP_KERNEL);
> 
> Are you just pre-allocating MAX_URETPROBE_DEPTH instances always?
> I.e., even if we need just one (because there is no recursion), you'd
> still waste memory for all 64 ones?

This is the truth. On my testing machines, each struct return_instance data
is 28 bytes, resulting in a total pre-allocated 1792 bytes when the first
instrumented function is hit.

> 
> That seems rather wasteful.
> 
> Have you considered using objpool for fast reuse across multiple CPUs?
> Check lib/objpool.c.

After studying how kretprobe uses objpool, I'm convinced it is a right solution for
managing return_instance in uretporbe. While I need some time to fully understand
the objpool code itself and run some benchmark to verify its performance.

Thanks for the suggestion.

> 
>> +               if (!frame->vaddr)
>> +                       return NULL;
>> +       }
>> +
>> +       if (!frame->return_instance) {
>> +               frame->return_instance = frame->vaddr;
>> +               return frame->return_instance;
>> +       }
>> +
>> +       return ++frame->return_instance;
>> +}
>> +
>> +static inline bool return_frame_empty(struct uprobe_task *task)
>> +{
>> +       return !task->frame.return_instance;
>>  }
>>
>>  /*
> 
> [...]

-- 
BR
Liao, Chang

