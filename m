Return-Path: <linux-kselftest+bounces-26425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD65A31583
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 20:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84AD3A63BF
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 19:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D67B26E632;
	Tue, 11 Feb 2025 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VkZFzhb5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01CF26E621;
	Tue, 11 Feb 2025 19:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302870; cv=none; b=fltXNECbRGxZ36OR6/0ttYOsinpZtuftGVVeBkeYs6ocqY+cBqna30AiNOqr68loJ+r2vGr57VpsVeaYv6tbCefz89XnFSe8pDfy4tt7IVBzTVnB62qUsC8aVcOQRyeXtlb2Iv8kxM+2qLnsLlS0ISGqs1Fp4Dd6E5mO5qmN4JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302870; c=relaxed/simple;
	bh=ZFzoSlR2ABVZdSZFbH32Uk1CGJgXQvrURkJH7rAhfmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxUR9uNq3iK9gXU/mFTqEI3Wmj+jqGo9Kdn7a5O0tTutL1vEL0Z2L3aKWh0Uvk2DG4uHST0Jyw37lZgKQswQwjhGTyDv34Cwv8Z6JinqqP72ojWIcs6zglL82dn5KQK88Uy+J9FhC0XtuVCH8La7nhp+S2bAmvoCArYajHmzxnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VkZFzhb5; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8c9b4179-cacc-42b6-ae6a-4b786bef8b60@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739302865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qHvAoOMhYrBIe1CrjgBIQvJn/BEujyMWnlTDgZxlFPs=;
	b=VkZFzhb5aJu+bal9LTOem1IRLNqvsRirXU0bdIziXLS34oFGO2Jh+83DH7uAEUwdER+n7H
	qlavdmbDpYrnz66lv7fltmJg53/dJmpP7uFXCPqLzJcYdes2xVHVOaJR1hS70nIYHCddII
	MO88Vx9rDdmaOCpU+86m7Jn/mTtjcnM=
Date: Tue, 11 Feb 2025 11:40:58 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 2/2] bpf: sockopt_sk: fix 'undeclared'
 definition error
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, Hou Tao <houtao@huaweicloud.com>,
 linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org
References: <20250204023946.16031-1-kerneljasonxing@gmail.com>
 <20250204023946.16031-3-kerneljasonxing@gmail.com>
 <99ccf971-cae5-9c45-5dff-2c8563a7879f@huaweicloud.com>
 <CAL+tcoAkyjDQd48wKuA8V_RE6j1OYTL2iGxT8HdVKpryD3SaUA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoAkyjDQd48wKuA8V_RE6j1OYTL2iGxT8HdVKpryD3SaUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/4/25 7:27 PM, Jason Xing wrote:
> On Wed, Feb 5, 2025 at 10:57 AM Hou Tao <houtao@huaweicloud.com> wrote:
>>
>> Hi,
>>
>> On 2/4/2025 10:39 AM, Jason Xing wrote:
>>> Error messages:
>>> selftests/bpf/prog_tests/sockopt_sk.c: In function ‘getsetsockopt’:
>>> selftests/bpf/prog_tests/sockopt_sk.c:22:31: error: field ‘zc’ has incomplete type
>>>     struct tcp_zerocopy_receive zc;
>>>                                 ^~
>>> selftests/bpf/prog_tests/sockopt_sk.c:169:32: error: ‘TCP_ZEROCOPY_RECEIVE’ undeclared (first use in this function)
>>>    err = getsockopt(fd, SOL_TCP, TCP_ZEROCOPY_RECEIVE, &buf, &optlen);
>>>                                  ^~~~~~~~~~~~~~~~~~~~
>>>
>>> Fix it by introducing the right header.
>>>
>>> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
>>> ---
>>>   tools/testing/selftests/bpf/prog_tests/sockopt_sk.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
>>> index ba6b3ec1156a..e0a9785ffcdc 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
>>> @@ -2,7 +2,7 @@
>>>   #include <test_progs.h>
>>>   #include "cgroup_helpers.h"
>>>
>>> -#include <netinet/tcp.h>
>>> +#include <uapi/linux/tcp.h>
>>
>> Should it be <linux/tcp.h> instead ?
> 
> I thought that too, but I altered my thoughts after reading this
> commit[1], totally without knowing why the tcp part should be changed.
> Should I change it back?

afaik, uapi/ or not does not make a difference.

> 
>> Directly including uapi header file
>> in application seems weird.
> 
> After greping the tools/testing/selftests/bpf, we see some similar
> usage like including a uapi header file.
> 
> [1]
> commit a2f482c34a52176ae89d143979bbc9e7a72857c8
> Author: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> Date:   Wed Nov 20 08:43:21 2024 +0100
> 
>      selftests/bpf: use the same udp and tcp headers in tests under test_progs
> 
>      Trying to add udp-dedicated helpers in network_helpers involves
>      including some udp header, which makes multiple test_progs tests build
>      fail:
> 
>      In file included from ./progs/test_cls_redirect.h:13,
>                       from [...]/prog_tests/cls_redirect.c:15:
>      [...]/usr/include/linux/udp.h:23:8: error: redefinition of ‘struct udphdr’
>         23 | struct udphdr {
>            |        ^~~~~~
>      In file included from ./network_helpers.h:17,
>                       from [...]/prog_tests/cls_redirect.c:13:
>      [...]/usr/include/netinet/udp.h:55:8: note: originally defined here
>         55 | struct udphdr
>            |        ^~~~~~

e.g. this will happen to the tcphdr also when sockopt_sk.c starts including 
network_helpers.h.

> 
>      This error is due to struct udphdr being defined in both <linux/udp.h>
>      and <netinet/udp.h>.
> 
>      Use only <netinet/udp.h> in every test. While at it, perform the same
>      for tcp.h. For some tests, the change needs to be done in the eBPF

This patch just undo exactly what this commit a2f482c34a52 tries to solve for 
tcp.h also, no?

pw-bot: cr

>      program part as well, because of some headers sharing between both
>      sides.
> 
> Thanks,
> Jason


