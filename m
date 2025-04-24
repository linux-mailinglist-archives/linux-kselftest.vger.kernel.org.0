Return-Path: <linux-kselftest+bounces-31543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BC3A9ACB1
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 14:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237A71B66EA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 12:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34D522D798;
	Thu, 24 Apr 2025 12:00:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B6822DFBB;
	Thu, 24 Apr 2025 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745496048; cv=none; b=pW2ilFm1kh8n7dX87rITtIDHDNrZThaKWWp1PZa2CI8q4eXs6M8ZzkskG/szd+YskyGFTDJaYFnaurEF8z4G98vYOCoTv2IoT2x7jDkm6Z6yrJ8eF7+6a5wf+gMk5iMWzk3VCXqTBsPmS3PK2Ss0CSOuWEMaIAHa45iJIjzP1t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745496048; c=relaxed/simple;
	bh=g6ZhCYqUsjw43UU7D94qUabJWGyv4hN727Jz1O4EMew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHnLBh/zNE/somawXAYL0EGWBRBArnYCz5yOSr3AGsTgqynY3cqA6aqbpxZzURvKiIgqSgpeKgj2rVxCXv7SxQM5e3k+yhVo5PcHhVEm8SGRR7TG9n2VtXGHbRxvR6LACgLa/20n32n5d7ObH64Wg/JBX1xskm7uJ9Q5h9CjqpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zjvg35YvJz4f3k5x;
	Thu, 24 Apr 2025 20:00:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6F12B1A18C2;
	Thu, 24 Apr 2025 20:00:34 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP4 (Coremail) with SMTP id gCh0CgCnVlveJwpoXVW4KQ--.17342S2;
	Thu, 24 Apr 2025 20:00:32 +0800 (CST)
Message-ID: <6b6472c3-0718-4e60-9972-c166d51962a3@huaweicloud.com>
Date: Thu, 24 Apr 2025 20:00:30 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next 1/4] bpf: add struct largest member size in
 func model
Content-Language: en-US
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Florent Revest <revest@chromium.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, ebpf@linuxfoundation.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20250411-many_args_arm64-v1-0-0a32fe72339e@bootlin.com>
 <20250411-many_args_arm64-v1-1-0a32fe72339e@bootlin.com>
 <CAEf4Bzbn6BdXTOb0dTcsQmOMZpp5=DzGS2hHHQ3+dwcja=gv+w@mail.gmail.com>
 <D98Q8BRNUVS9.11J60C67L1ALR@bootlin.com>
 <CAEf4BzZHMYyGDZ4c4eNXG7Fm=ecxCCbKhKbQTbCjvWmKtdwvBw@mail.gmail.com>
 <D9E9IQQ3QKXM.3UJ17G9CBS1FH@bootlin.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <D9E9IQQ3QKXM.3UJ17G9CBS1FH@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnVlveJwpoXVW4KQ--.17342S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4DtFy5WF18uFW8Wr4xXrb_yoW5CF4fpF
	WFgF95KF4kGr18Za1vv3W0qrWav34fKry5JrWrtr1rZryDK3Z7JryjgF4Y9FWfCrn7Gw1j
	vF42qayfur93ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	4xRDUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 4/24/2025 3:24 AM, Alexis Lothoré wrote:
> Hi Andrii,
> 
> On Wed Apr 23, 2025 at 7:15 PM CEST, Andrii Nakryiko wrote:
>> On Thu, Apr 17, 2025 at 12:14 AM Alexis Lothoré
>> <alexis.lothore@bootlin.com> wrote:
>>>
>>> Hi Andrii,
>>>
>>> On Wed Apr 16, 2025 at 11:24 PM CEST, Andrii Nakryiko wrote:
>>>> On Fri, Apr 11, 2025 at 1:32 PM Alexis Lothoré (eBPF Foundation)
>>>> <alexis.lothore@bootlin.com> wrote:
> 
> [...]
> 
>>> Indeed I initially checked whether I could return directly some alignment
>>> info from btf, but it then involves the alignment computation in the btf
>>> module. Since there could be minor differences between architectures about
>>> alignment requirements, I though it would be better to in fact keep alignment
>>> computation out of the btf module. For example, I see that 128 bits values
>>> are aligned on 16 bytes on ARM64, while being aligned on 8 bytes on S390.
>>>
>>> And since for ARM64, all needed alignments are somehow derived from size
>>> (it is either directly size for fundamental types, or alignment of the
>>> largest member for structs, which is then size of largest member),
>>> returning the size seems to be enough to allow the JIT side to compute
>>> alignments.
>>
>> If you mean the size of "primitive" field and/or array element
>> (applied recursively for all embedded structs/unions) then yes, that's
>> close enough. But saying just "largest struct member" is wrong,
>> because for
>>
>> struct blah {
>>      struct {
>>          int whatever[128];
>>      } heya;
>> };
>>
>>
>> blah.heya has a large size, but alignment is still just 4 bytes.
> 
> Indeed, that's another case making my proposal fail :)
> 
>> I'd suggest looking at btf__align_of() in libbpf (tools/lib/bpf/btf.c)
>> to see how we calculate alignment there. It seems to work decently
>> enough. It won't cover any arch-specific extra rules like double
>> needing 16-byte alignment (I vaguely remember something like that for
>> some architectures, but I might be misremembering), or anything
>> similar. It also won't detect (I don't think it's possible without
>> DWARF) artificially increased alignment with attribute((aligned(N))).
> 
> Thanks for the pointer, I'll take a look at it. The more we discuss this
> series, the less member size sounds relevant for what I'm trying to achieve
> here.
> 
> Following Xu's comments, I have been thinking about how I could detect the
> custom alignments and packing on structures, and I was wondering if I could
> somehow benefit from __attribute__ encoding in BTF info ([1]). But
> following your hint, I also see some btf_is_struct_packed() in
> tools/lib/bpf/btf_dump.c that could help. I'll dig this further and see if
> I can manage to make something work with all of this.
>

With DWARF info, we might not need to detect the structure alignment anymore,
since the DW_AT_location attribute tells us where the structure parameter is
located on the stack, and DW_AT_byte_size gives us the size of the structure.

> Thanks,
> 
> Alexis
> 
> [1] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@linux.dev/
> 


