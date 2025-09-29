Return-Path: <linux-kselftest+bounces-42575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F76BA9623
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 15:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2741920AEB
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 13:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA6E3081B4;
	Mon, 29 Sep 2025 13:42:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8043081C2;
	Mon, 29 Sep 2025 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759153321; cv=none; b=FMdwO3/L3AgUPrPbFCdrZAxAH4Wq4yFLnxoZiBR/2lEXXRXpaoURKDcZ7ZbR1Uss+gH6cGqW0HJ0uB13HZLIniUlo2uUKaTG8UM9yqO2VNkXwpVrzGjuPJI6lirJZzev68MV5oo52bkVId//inqo1VLsbpBHTojHL00pJN/i0nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759153321; c=relaxed/simple;
	bh=2+odHfI52pbuGWOzo+NERol5eEsHV6EgYMvlSXYXO1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vr8t3ZqkRILGE0SKwYUTxOenEWLyy3YBXLZbj3RrB4kRE4VIg/cgJYiWZYsp6BPocJerLMsiaJ4rxbqV83TVwGE2gxsDl209Z9/jeyn2dI3W62VTtbNM7ZllpVCTrCHRdXsi29lxPg5/EAuoD94qfQ3lOZGFTT6N+NUzwN1JPKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cb2RC4kr1zKHMgQ;
	Mon, 29 Sep 2025 21:41:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id BA8391A0CEB;
	Mon, 29 Sep 2025 21:41:57 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgBHkhaLjNpod1DYBA--.60805S4;
	Mon, 29 Sep 2025 21:41:57 +0800 (CST)
Message-ID: <81a34994-1975-45bc-a9b4-e35cc9119d0e@huaweicloud.com>
Date: Mon, 29 Sep 2025 21:41:57 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf/benchs: Add producer and
 overwrite bench for ring buffer
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>, Song Liu <song@kernel.org>
References: <20250905150641.2078838-1-xukuohai@huaweicloud.com>
 <20250905150641.2078838-4-xukuohai@huaweicloud.com>
 <CAEf4Bzb65VnL5nESxkGGZCgW0Ow+apwTsqzpFv2s+rd3Y6YkAQ@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAEf4Bzb65VnL5nESxkGGZCgW0Ow+apwTsqzpFv2s+rd3Y6YkAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHkhaLjNpod1DYBA--.60805S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtr1UKr4kKFWxZFWkAr48Xrb_yoW3JrcEkF
	s5Wr18Z3W3Zr4j9w4fAF1kWF97Ja45trZ8GFy5trsFyr1UAryFvFna9a9IyFyFgFZrtr9I
	9wnI9FW3K340qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb98YFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r15M2
	8IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtV
	W8ZwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
	CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
	daVFxhVjvjDU0xZFpf9x07UCZXrUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 9/20/2025 6:15 AM, Andrii Nakryiko wrote:
> On Fri, Sep 5, 2025 at 8:13 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>

[...]

>>
>> -static struct ringbuf_bench *ringbuf_setup_skeleton(void)
>> +static struct ringbuf_bench *ringbuf_setup_skeleton(int bench_prod)
> 
> int because C doesn't support bool?...
>

No special reason, just wrote it like that. I’ll switch it to bool

> but really, do we need another benchmark just to set overwritable
> mode?... can't you adapt existing benchmarks to optionally set
> overwritable mode?
>

OK, I’ll adapt the existing benchmarks to support it.

> 
> (and please drop sdf@google.com from CC for the next revision, that
> email doesn't exist anymore)
>

OK

> [...]
> 


