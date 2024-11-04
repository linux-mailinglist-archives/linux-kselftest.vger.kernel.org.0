Return-Path: <linux-kselftest+bounces-21392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D1F9BBCE0
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 19:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7861C21E62
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 18:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122001C9EB8;
	Mon,  4 Nov 2024 18:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vr2XwHJ5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B82224F0;
	Mon,  4 Nov 2024 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730743772; cv=none; b=sV8hcmy5E6QSXEuS+sx9/ah6m0OYTBvHI55xUpLi5b1DaMujpGD2x3tP7E4/ON12XEPcdj9PsNWfj8cDp1UNibXmRcdrY43n6Hp6upLs6eQRCZ6cgM1qdpGvqby1whdXBDIfFQVQ/hLTrH7evYsuNAY2AQxQB7Ch2PT8n1apVj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730743772; c=relaxed/simple;
	bh=s9H92zsAkMOcwJ+GffO4YFN2D7ey7rDZ6UDXCRDq4gc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=df2UuEapeqqfnrJp6tqJRJtIC5sZRE0JSbaNfEGa24I55/VdTW6syr6P1atdxA8m3c3bvEIdSvCtz3SDpRluiPZxszcl7BZBiuqa9NAdXFwqAmiYVmSHH6slpe0ekMdEXHGx967xTI2/M7ylgttu3ExX+h0EVixB6nlgmHF3Zzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vr2XwHJ5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4Hc53b028263;
	Mon, 4 Nov 2024 18:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=w468gW
	nUBKcn6hvtsmUCHLK0zLOaHwww1ug2caMPJVE=; b=Vr2XwHJ51SOgi3qkNLCQeM
	009uYlpkYpIMofj19L3JM4V8HLxyIGiMazvXDTRcP00ka4gH1ZmCevoeRJdYlCl2
	/CegRbEpKH1+AvPbsgB1LWwB0Olsct3do8s6GI/Hsuvwhv4JN59Uq/ih0Xf2080H
	7lVAO5OYyxpqzOiQvBu0AmP/hs1vPVrbebnqegVJb4tDa3ncMP3ScQbSW0xDWBiv
	WswWpsUHZwITk8HTAqV+Yp6c6IsE+ae3g4HI5t0FybhwpdcBpTiL6z8AWHtpkG9W
	kZt2qcXjC3OIofbKe8LLA1KU8QkpR1bIOlKVMtjwIbfl62sFfvCS091wYjeYabdA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42q2uer77v-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 18:08:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4GNdLB024235;
	Mon, 4 Nov 2024 17:36:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nxsxyhgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 17:36:29 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A4HaRgQ20775284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Nov 2024 17:36:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5920F20043;
	Mon,  4 Nov 2024 17:36:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCA9520040;
	Mon,  4 Nov 2024 17:36:24 +0000 (GMT)
Received: from [9.43.42.65] (unknown [9.43.42.65])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Nov 2024 17:36:24 +0000 (GMT)
Message-ID: <f7e8243a-a4c8-44ce-ad03-7d232df461ed@linux.ibm.com>
Date: Mon, 4 Nov 2024 23:06:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: update kprobe syntax error test for
 ppc64le
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Naveen N. Rao"
 <naveen@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20241101191925.1550493-1-hbathini@linux.ibm.com>
 <20241101205948.GW29862@gate.crashing.org>
 <1916cb5c-cb3d-427c-bcf0-2c1b905fd6d1@linux.ibm.com>
 <20241104094431.GY29862@gate.crashing.org>
 <245fed6f-5fb4-4925-ba0a-fb2f32e650d0@linux.ibm.com>
 <20241104103615.GZ29862@gate.crashing.org>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20241104103615.GZ29862@gate.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lq2A1vmdafXCqy7dc8Y1uUEaoTXCzInZ
X-Proofpoint-ORIG-GUID: lq2A1vmdafXCqy7dc8Y1uUEaoTXCzInZ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040149

Hi Segher,

On 04/11/24 4:06 pm, Segher Boessenkool wrote:
> Hi!
> 
> On Mon, Nov 04, 2024 at 03:40:26PM +0530, Hari Bathini wrote:
>> On 04/11/24 3:14 pm, Segher Boessenkool wrote:
>>> On Mon, Nov 04, 2024 at 02:51:57PM +0530, Hari Bathini wrote:
>>>> On 02/11/24 2:29 am, Segher Boessenkool wrote:
>>>>> On Sat, Nov 02, 2024 at 12:49:25AM +0530, Hari Bathini wrote:
>>>>>> For ppc64le, depending on the kernel configuration used, offset 16
>>>>> >from function start address can also be considered function entry.
>>>>>> Update the test case to accommodate such configurations.
>>>>>
>>>>> (This is true for all ELfv2, not just LE.  For the kernel that is about
>>>>> the same).
>>>>>
>>>>> The LEP and GEP can differ by zero, one, two, four, eight, or sixteen
>>>>> insns (where an insn is four bytes).  Four insns is common, yes, but
>>>>> maybe you can support all?  See the function symbol's st_other field
>>>>> to see what the offset is:
>>>>> 0, 1: zero insns, zero bytes
>>>>> N = 2..6: 1 << (N-2) insns, i.e. 1<<N bytes
>>>>> 7: reserved
>>>>>
>>>>> (This is the top 3 bits of st_other, the other bits have other meanings).
>>>>>
>>>>> Four insns is common, yes, but by no means the only possibility.
>>>>
>>>> Hi Segher,
>>>>
>>>> Querying for function arguments is supported on kprobes only at function
>>>> entry. This is a negative test case where the offset is intentionally
>>>> set beyond function entry while querying for function arguments.
>>>> I guess, simply setting the offset to 20 (vfs_read is anyway
>>>> going to be beyond 5 instructions) instead of 8 for powerpc would
>>>> make all platforms and ABI variants happy?
>>>
>>> I have no idea.  What is this "offset" anyway?
>>
>> offset (in bytes) from function start address..
> 
> But what is there?
> 
>>> This is just the ELFv2 ABI.  No platform can make up its own thing at
>>> all (well, none decided to be gratuitously incompatible, so far).  And
>>> there are no "ABI variants"!
>>
>> The test case applies for ABIv1 & ABIv2. All ppc32 & ppc64 platforms..
> 
> Hrm.  So you allow essentially random entry points on other ABIs to
> work?
> 
>>> You're just making assumptions here that are based on nothing else but
>>> observations of what is done most of the time.  That might work for a
>>> while -- maybe a long while even! -- but it can easily break down.
>>
>> Hmmm.. I understand that you want the test case to read st_other field
>> but would you rather suggest an offset of 64?
> 
> I have no idea what "offset" means here.
> 
>> Is a GEP of 8/16 instructions going to be true anytime soon or is it
>> true already for some cases? The reason I ask that is some kprobe/ftrace
>> code in the kernel might need a bit of re-look if that is the case.
> 
> An entry point has no instructions at all.  Oh, you mean the code at
> the GEP.
> 
> The LEP can already be all the allowed distances after the GEP.  And
> the .localentry GAS directive already supports all those distances
> always.  Not a lot of code written in assembler does use that, and
> certainly GCC does not use a lot of the freedom it has here, but it
> could (and so could assembler programmers).  Typically people will want
> to make the code here as short as possible, and there are restrictions
> on what is *allowed* to be done here anyway (ld, the link editor, can
> change this code after all!), so it is not too likely you will ever see
> big code at the GEP often, but times change, etc.

Seems like a bit of misunderstanding there. Function entry here intends
to mean the actual start of function code (function prologue) - after
GEP and function profiling sequence (mflr r0; bl mcount).

Function arguments can be accessed with kprobe only while setting a
probe at an address the kernel treats as function start address.
Note that the test case pass criteria here is setting probe to fail by
providing an address (sym+offset) beyond the function start address.

And in this specific test case (with "vfs_read+8", where vfs_read is
the symbol and '8' is the offset), the test case was failing on powerpc
because setting the probe at 'sym+8' was succeeding, as anywhere between
'sym' to 'sym+16' is treated as function start address on powerpc:

  
https://github.com/torvalds/linux/blob/master/arch/powerpc/kernel/kprobes.c#L108


So, the fix here essentially is to provide an address that is at least
an insn or two beyond function start address. As GEP is 8 bytes and
function profile sequence is 8 bytes, sym+20 is beyond function start
address on ppc64le. In fact, sym+20 should work for other platforms
too as sym+20 not treated as function start address on any platform
on powerpc as of today, and that is all the test case cares about...

Thanks
Hari

