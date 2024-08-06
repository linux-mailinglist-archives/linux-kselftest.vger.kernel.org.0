Return-Path: <linux-kselftest+bounces-14875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB35A9496A6
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 19:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6F31F28793
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 17:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB6B537F8;
	Tue,  6 Aug 2024 17:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VMyPHlz0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35E553E24;
	Tue,  6 Aug 2024 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965108; cv=none; b=pJHRaYtQpT3+G8/CtWAulgVGa4jXu/ATV+Wjex8CIdvgfDhoayLZvx9/a+/cxmTTLcgnk4YjPNy7+G7n+tMcH8/TY1PomoLcaf6l1reAn4n7nWip3sFHYmiiZ0bJqjRybKHMK+/XhO1zVML4FyMgtkzQqsnYRnUqUWxIzCLYCco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965108; c=relaxed/simple;
	bh=gGGjE0PHrEmPhHIpSKjViIoJqg8euS0ZAKVjsJ3LHHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhOM3IgVXQibpeR21gtHoKxxmCBWngx3Ajps9vlgrnaOjI7KectsNvlInpSO6B8iFm+Su0DSiX190f7T2y39syIZHGA7mTjT5l7kpJ63jXzilV39PkSxLqDHvQ1fQkEXL5YEYNPjdsrToeX4RlEpLI1GUkZRj+UW1sTnYoyX2qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VMyPHlz0; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5FB5F60002;
	Tue,  6 Aug 2024 17:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722965097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZOlmdNZnS8lNcYvVSNgUOcBoZaCZDG1qGlOMFh5L7CU=;
	b=VMyPHlz0AU5fvrXnE3mTUlf5V2+hl5kN7RiANkrdEJh4LtpoVqn6pjXMzROpAjuBIjQmai
	5Pyl+5P72sfv36rRHvbBxkc6Ax87AxGe4vUA51kcgHxXXCpGi5C/GESplIKdH30pFCosd9
	Qcpw4waxLaS/6o3I0kiE97J7XPm7PGyHZVvhkm83m5uO4ewPQLWvPeObEybyxr53kl17cW
	sILLGrxqOl+d4/enOSsh0hEaaHr2lQD6WRfgv6tFDY20mQHZJoho41/XNGZN02aNvzGYPG
	rI4og4fClsf2rHbd49okl5LK2cXYPZ+KmdRVMyG0EY7T2MMoQGC/mU1BSpj0FA==
Message-ID: <5aab98d1-949d-4a20-a64c-3187439a7e81@bootlin.com>
Date: Tue, 6 Aug 2024 19:24:46 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: add proper section name to
 bpf prog and rename it
To: Alan Maguire <alan.maguire@oracle.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240731-convert_cgroup_tests-v1-0-14cbc51b6947@bootlin.com>
 <20240731-convert_cgroup_tests-v1-3-14cbc51b6947@bootlin.com>
 <e8b88d27-4e85-46f1-8ed4-df883abc8a51@oracle.com>
 <263cd78b-0392-45d4-a13c-b2b0463c4c8c@bootlin.com>
 <05d39d25-d132-4194-a2a1-fbae8917e70b@oracle.com>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <05d39d25-d132-4194-a2a1-fbae8917e70b@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 8/6/24 14:33, Alan Maguire wrote:
> On 01/08/2024 11:00, Alexis Lothoré wrote:
>> On 8/1/24 10:35, Alan Maguire wrote:
>>> On 31/07/2024 11:38, Alexis Lothoré (eBPF Foundation) wrote:
>>>> test_skb_cgroup_id_kern.c is currently involved in a manual test. In its
>>>> current form, it can not be used with the auto-generated skeleton APIs,
>>>> because the section name is not valid to allow libbpf to deduce the program
>>>> type.
>>>>
>>>> Update section name to allow skeleton APIs usage. Also rename the program
>>>> name to make it shorter and more straighforward regarding the API it is
>>>> testing. While doing so, make sure that test_skb_cgroup_id.sh passes to get
>>>> a working reference before converting it to test_progs
>>>> - update the obj name
>>>> - fix loading issue (verifier rejecting the program when loaded through tc,
>>>>   because of map not found), by preloading the whole obj with bpftool
>>>>
>>>> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
>>>
>>> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>>
>> [...]
>>
>>>>  	tc qdisc add dev ${TEST_IF} clsact
>>>> -	tc filter add dev ${TEST_IF} egress bpf obj ${BPF_PROG_OBJ} \
>>>> -		sec ${BPF_PROG_SECTION} da
>>>> +	mkdir -p /sys/fs/bpf/${BPF_PROG_PIN}
>>>> +	bpftool prog loadall ${BPF_PROG_OBJ} /sys/fs/bpf/${BPF_PROG_PIN} type tc
>>>> +	tc filter add dev ${TEST_IF} egress bpf da object-pinned \
>>>> +		/sys/fs/bpf/${BPF_PROG_PIN}/${BPF_PROG_NAME}
>>>>
>>>
>>> Just out of curiosity; did you find that the pin is needed? I would have
>>> thought tc attach would be enough to keep the program aroud.
>>
>> That's more because that's the only way I found to make the filter addition
>> work. With the current command, the tc command fails because of the verifier
>> rejecting the program:
>>
>> Verifier analysis:
>>
>> func#0 @0
>> 0: R1=ctx() R10=fp0
>> 0: (bf) r6 = r1                       ; R1=ctx() R6_w=ctx()
>> 1: (b4) w1 = 0                        ; R1_w=0
>> 2: (63) *(u32 *)(r10 -4) = r1
>> mark_precise: frame0: last_idx 2 first_idx 0 subseq_idx -1
>> mark_precise: frame0: regs=r1 stack= before 1: (b4) w1 = 0
>> 3: R1_w=0 R10=fp0 fp-8=0000????
>> 3: (bf) r1 = r6                       ; R1_w=ctx() R6_w=ctx()
>> 4: (b4) w2 = 0                        ; R2_w=0
>> 5: (85) call bpf_skb_ancestor_cgroup_id#83    ; R0_w=scalar()
>> 6: (7b) *(u64 *)(r10 -16) = r0        ; R0_w=scalar(id=1) R10=fp0
>> fp-16_w=scalar(id=1)
>> 7: (bf) r2 = r10                      ; R2_w=fp0 R10=fp0
>> 8: (07) r2 += -4                      ; R2_w=fp-4
>> 9: (bf) r3 = r10                      ; R3_w=fp0 R10=fp0
>> 10: (07) r3 += -16                    ; R3_w=fp-16
>> 11: (18) r1 = 0x0                     ; R1_w=0
>> 13: (b7) r4 = 0                       ; R4_w=0
>> 14: (85) call bpf_map_update_elem#2
>> R1 type=scalar expected=map_ptr
>> processed 14 insns (limit 1000000) max_states_per_insn 0 total_states 0
>> peak_states 0 mark_read 0
>>
>> (I also tried to remove the sec argument from the tc commandline, in case it
>> could allow tc to load everything, but the issue remains the same)
>>
>> IIUC the verifier output, there's an issue with the variable representing the map.
>> When stracing the tc filter add command, I indeed see the BPF_PROG_LOAD syscall
>> but no BPF_MAP_CREATE at all, so I assumed tc did not read/create the map
>> correctly. That's why I used bpftool to make sure everything is loaded, but as a
>> consequence I need to provide a pin path when using load/loadall. But maybe I am
>> missing something ?
>>
> 
> No I think you're absolutely right. It seems like there have been
> problems with BTF-defined maps in the past with tc filter loading [1],
> but more recent tc fixes this since it uses libbpf under the hood. I
> tried with the section name update only and the test passes, so it might
> just be a tc version issue. As in [1] I'd suggest compiling an
> up-to-date iproute2/tc and re-testing. Thanks!
> 
> [1] https://lore.kernel.org/bpf/87zgkx9l6y.fsf@toke.dk/

I have checked my tc binary and indeed it was not built with libbpf support. So
applying what is suggested in the thread you have attached, I rebuilt tc with
proper libbpf support, and now the original tc command works properly (bpf
program *and* map properly loaded through tc). So in the end, the issue was on
my testing setup.

I have already sent a v2 updating the other topics you have suggested, if it
raises new comments I will use the opportunity to put back the previous tc
filter command.

Thanks for the review and the helpful comments !

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


