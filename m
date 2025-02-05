Return-Path: <linux-kselftest+bounces-25815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0DEA2868E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 10:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63DB17A4109
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 09:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ECB22A4FE;
	Wed,  5 Feb 2025 09:30:27 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E27121A427;
	Wed,  5 Feb 2025 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738747827; cv=none; b=efoSLQ5djPRhM5PjfZTlCP1tCczyl82M8r/cHwIm5NNaOGq2e7oRH4eSgvvViUq8DfAMWmrgfYK3XS1KLFjoK/2J73xPEFavC3sNtRP4EfFYqjp6N0digamT5Fnd3GFmg/Hth0TOV83iro7g6nRst0Svq3BhQbf9/1VIfgHjNx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738747827; c=relaxed/simple;
	bh=KSvuNW4NaX9Wu27x971kTxNlQDfGsgCINQIRim9EfBw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=R98zf476FdNIHMXibHNU6ghcYrMD+4pL/pGiSFXx0gM+pTA1JGhifkbfgIeuDynkt9CJsATDB0Zl2iaULubiCPSY2JN9KqsPYnMb3Ds5KVb8UThMy688U5w+jMJ6RsRqJo1C1THD7UlmaP4YwjJ23+JJq8jjNzI83fJPYKuTsqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Ynw1f4WPKz4f3jYL;
	Wed,  5 Feb 2025 17:29:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B82CE1A11AF;
	Wed,  5 Feb 2025 17:30:19 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgC3c2anL6NnaHbUCw--.14822S2;
	Wed, 05 Feb 2025 17:30:19 +0800 (CST)
Subject: Re: [PATCH bpf-next v1 2/2] bpf: sockopt_sk: fix 'undeclared'
 definition error
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org
References: <20250204023946.16031-1-kerneljasonxing@gmail.com>
 <20250204023946.16031-3-kerneljasonxing@gmail.com>
 <99ccf971-cae5-9c45-5dff-2c8563a7879f@huaweicloud.com>
 <CAL+tcoAkyjDQd48wKuA8V_RE6j1OYTL2iGxT8HdVKpryD3SaUA@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <b13c3602-69b8-7452-f342-8204287cea4d@huaweicloud.com>
Date: Wed, 5 Feb 2025 17:30:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAL+tcoAkyjDQd48wKuA8V_RE6j1OYTL2iGxT8HdVKpryD3SaUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgC3c2anL6NnaHbUCw--.14822S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4kXr4xAw1xtrW7tr4rAFb_yoW5tF1kpa
	48A3WUKay8CFW5Zwn7Jr42vF1xKr48Jryj9rWvqry3ZF17WFyxGFW7KrWY9FnagrZIvr4F
	v347KF93ua1kZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
	1cAE67vIY487MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07jIksgUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 2/5/2025 11:27 AM, Jason Xing wrote:
> On Wed, Feb 5, 2025 at 10:57 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 2/4/2025 10:39 AM, Jason Xing wrote:
>>> Error messages:
>>> selftests/bpf/prog_tests/sockopt_sk.c: In function ‘getsetsockopt’:
>>> selftests/bpf/prog_tests/sockopt_sk.c:22:31: error: field ‘zc’ has incomplete type
>>>    struct tcp_zerocopy_receive zc;
>>>                                ^~
>>> selftests/bpf/prog_tests/sockopt_sk.c:169:32: error: ‘TCP_ZEROCOPY_RECEIVE’ undeclared (first use in this function)
>>>   err = getsockopt(fd, SOL_TCP, TCP_ZEROCOPY_RECEIVE, &buf, &optlen);
>>>                                 ^~~~~~~~~~~~~~~~~~~~
>>>
>>> Fix it by introducing the right header.
>>>
>>> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
>>> ---
>>>  tools/testing/selftests/bpf/prog_tests/sockopt_sk.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
>>> index ba6b3ec1156a..e0a9785ffcdc 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
>>> @@ -2,7 +2,7 @@
>>>  #include <test_progs.h>
>>>  #include "cgroup_helpers.h"
>>>
>>> -#include <netinet/tcp.h>
>>> +#include <uapi/linux/tcp.h>
>> Should it be <linux/tcp.h> instead ?
> I thought that too, but I altered my thoughts after reading this
> commit[1], totally without knowing why the tcp part should be changed.
> Should I change it back?

Thanks for pointing the commit to me. Under my local environment, it
seems both netinet/tcp.h and linux/tcp define tcp_zerocopy_receive and
tcphdr, and I think that is the reason why the commit changes tcp as
well. For the following build error:

selftests/bpf/prog_tests/sockopt_sk.c:22:31: error: field ‘zc’ has
incomplete type
   struct tcp_zerocopy_receive zc;

I think maybe your local environment is a bit out-of-date. I prefer to
keep it as-is.
>
>> Directly including uapi header file
>> in application seems weird.
> After greping the tools/testing/selftests/bpf, we see some similar
> usage like including a uapi header file.
>
> [1]
> commit a2f482c34a52176ae89d143979bbc9e7a72857c8
> Author: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> Date:   Wed Nov 20 08:43:21 2024 +0100
>
>     selftests/bpf: use the same udp and tcp headers in tests under test_progs
>
>     Trying to add udp-dedicated helpers in network_helpers involves
>     including some udp header, which makes multiple test_progs tests build
>     fail:
>
>     In file included from ./progs/test_cls_redirect.h:13,
>                      from [...]/prog_tests/cls_redirect.c:15:
>     [...]/usr/include/linux/udp.h:23:8: error: redefinition of ‘struct udphdr’
>        23 | struct udphdr {
>           |        ^~~~~~
>     In file included from ./network_helpers.h:17,
>                      from [...]/prog_tests/cls_redirect.c:13:
>     [...]/usr/include/netinet/udp.h:55:8: note: originally defined here
>        55 | struct udphdr
>           |        ^~~~~~
>
>     This error is due to struct udphdr being defined in both <linux/udp.h>
>     and <netinet/udp.h>.
>
>     Use only <netinet/udp.h> in every test. While at it, perform the same
>     for tcp.h. For some tests, the change needs to be done in the eBPF
>     program part as well, because of some headers sharing between both
>     sides.
>
> Thanks,
> Jason
>
> .


