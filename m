Return-Path: <linux-kselftest+bounces-30171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 639E0A7D1C3
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 03:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DDD87A3F5F
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 01:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A32211A27;
	Mon,  7 Apr 2025 01:37:02 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BD2AD5A;
	Mon,  7 Apr 2025 01:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743989822; cv=none; b=HgseKm6RQprhnyO7RzksWx2INLqBNNmW1z95ldeSsdX/oAzCuVQv9kYSMuWdolYr/I8S1Mx4BM4RDFOQ9IEAQpbQnI27Ff9Ha3bcQQsvP8ib2vADZH8yrimLzxvxGNGvbUbzWhFtshVOE0t0OqL8cFTqpZmh5E20rlw0q8ZAnuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743989822; c=relaxed/simple;
	bh=ldVB0KK32mq4d0ZbSVjizKohj70d5TD1hgVLnPcwBTA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=C5nZJezfldjbofcu+YkEBPZ9WlgT2OFggmkLHAuDKTs34SzsLMvtPOAB2ctc9sUTARDGQwAcz82CgHiVPhlsoHRsYym7MfAPdt35107Ou9wfG5BLaPFqIw0pkwOavkIB+1fR2W5w4ASlW1TrDARm22Bz6CTTc+6kbKYOr2ClAhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZWBdL44vCz4f3jtT;
	Mon,  7 Apr 2025 09:36:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 772DF1A1AB5;
	Mon,  7 Apr 2025 09:36:56 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP3 (Coremail) with SMTP id _Ch0CgAHWcM0LPNn901xIg--.62536S2;
	Mon, 07 Apr 2025 09:36:56 +0800 (CST)
Subject: Re: [PATCH] selftests/bpf: close the file descriptor to avoid
 resource leaks
To: malaya kumar rout <malayarout91@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Geliang Tang <geliang@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <malayarout91@gmail.com>
 <20250324064234.853591-1-malayarout91@gmail.com>
 <CAEf4BzagSxO-fNeeWfFPu2vpnbEUBnS7Y2P=ODGks_zVEg1mkg@mail.gmail.com>
 <CAE2+fR83Y8ZKk8fqM0WgZeK4Zm4PZjBzoPMyMptVHfk81eXEtw@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <e255897a-30d8-5745-b89b-eb801e0864a9@huaweicloud.com>
Date: Mon, 7 Apr 2025 09:36:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAE2+fR83Y8ZKk8fqM0WgZeK4Zm4PZjBzoPMyMptVHfk81eXEtw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:_Ch0CgAHWcM0LPNn901xIg--.62536S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFW5KFy8XFy5XFW7Wr13CFg_yoW5uryxpa
	48G3WjkFyIqr1Fyr17Cw4qqFWxZrn7X3W5Ars8tF1UZr18JrySqr12gFWFgrs8urWvyr4F
	vF1IgF9xZr48AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUIa0PDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 4/5/2025 1:59 PM, malaya kumar rout wrote:
> On Fri, Apr 4, 2025 at 9:22 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>> On Sun, Mar 23, 2025 at 11:43 PM Malaya Kumar Rout
>> <malayarout91@gmail.com> wrote:
>>> Static Analyis for bench_htab_mem.c with cppcheck:error
>>> tools/testing/selftests/bpf/benchs/bench_htab_mem.c:284:3:
>>> error: Resource leak: fd [resourceLeak]
>>> tools/testing/selftests/bpf/prog_tests/sk_assign.c:41:3:
>>> error: Resource leak: tc [resourceLeak]
>>>
>>> fix the issue  by closing the file descriptor (fd & tc) when
>>> read & fgets operation fails.
>>>
>>> Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
>>> ---
>>>  tools/testing/selftests/bpf/benchs/bench_htab_mem.c | 1 +
>>>  tools/testing/selftests/bpf/prog_tests/sk_assign.c  | 4 +++-
>>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
>>> index 926ee822143e..59746fd2c23a 100644
>>> --- a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
>>> +++ b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
>>> @@ -281,6 +281,7 @@ static void htab_mem_read_mem_cgrp_file(const char *name, unsigned long *value)
>>>         got = read(fd, buf, sizeof(buf) - 1);
>> It could be a bit cleaner to add close(fd) here and drop the one we
>> have at the end of the function.
>>
> Here, close(fd)  is now positioned within the error handling block,
> guaranteeing that
> the file descriptor will be closed prior to returning from the
> function in the event of a read error.
> Meanwhile, the final close(fd) at the end of the function is retained
> for successful execution,
> thereby avoiding any potential resource leaks.
> Hence, It is essential to add the close(fd) in both locations to
> prevent resource leakage.

I think Andrii was proposing the following solution:

{
        /* ...... */
        got = read(fd, buf, sizeof(buf) - 1);
        close(fd);
        if (got <= 0) {
                *value = 0;
                return;
        }
        buf[got] = 0;

        *value = strtoull(buf, NULL, 0);
}

It only invokes close(fd) once to handle both the failed case and the
successful case.
>
>> pw-bot: cr
>>
>>>         if (got <= 0) {
>>>                 *value = 0;
>>> +               close(fd);
>>>                 return;
>>>         }
>>>         buf[got] = 0;
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
>>> index 0b9bd1d6f7cc..10a0ab954b8a 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
>>> @@ -37,8 +37,10 @@ configure_stack(void)
>>>         tc = popen("tc -V", "r");
>>>         if (CHECK_FAIL(!tc))
>>>                 return false;
>>> -       if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc)))
>>> +       if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc))) {
>>> +               pclose(tc);
>> this one looks good
>>
>>>                 return false;
>>> +       }
>>>         if (strstr(tc_version, ", libbpf "))
>>>                 prog = "test_sk_assign_libbpf.bpf.o";
>>>         else
>>> --
>>> 2.43.0
>>>
> .


