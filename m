Return-Path: <linux-kselftest+bounces-21368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 703DB9BB0B1
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 11:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D392BB256A8
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 10:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46351B0F19;
	Mon,  4 Nov 2024 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RD4ZOE3N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4328B1AF0B8;
	Mon,  4 Nov 2024 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730715049; cv=none; b=oowXBUOhx0vPswBRpfH6C2hwrimwZvian3JdydJbm3Cls0eBRJtbTHaTvpwI0uS9pfma+KSNzDGT8h4FzEtSJl1wUSnzCt6eSfNhlPk+CRABkPZJ9TMNiqh4Gi1slr1552TKOcaGxSxgRPpTQD/JNhLd0InrTN3HHlfJUNiMAOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730715049; c=relaxed/simple;
	bh=4QRd0qWtQnwJJ8Bkm82m9iIKsYtaQ9CrKyfOCUxkpsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZZZLmomJvqoaYlElab6m6krWOjqe+DvVSp8E4P84rJVUQLkedkmVszcHyzFxKBMhi+hwcZPBt1LRd9XzDeH7yu7Q+TZJppRP/A8X7Nf/gq+Fy7VB1yIj0POBlAKYVXa1TBtfn+LZW3vOaVCmgaS8jNOCL3KokYAddejQxk6AhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RD4ZOE3N; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A49Adih021840;
	Mon, 4 Nov 2024 10:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cZ05+0
	Qf5f/HiTPT4Z6NAsUFK85+lPVBtShBayUZ6ZA=; b=RD4ZOE3Nqi8eZ0589cKqwy
	qJoZmKCnHHu0diJuYUGsSfmO0ADOxMycXn2oWuQAdDrklvhpSd9NxqOyPN483DFM
	rr47lE1/eNke0ephhmdBM5k+oPpu+UePRG5EmjL29dQZrQzyH+CUsoJONoRoS0H6
	k+Oau738r8R5usZOnKtBGRzviYVKJiNM4LiA4mMf4FWJyxGyNtycr7lyDgAyHSui
	zJO3125N5Z3oOElqCHdTzJ7bOOOlf+d+/kcUehBpfCzwM3B8ujuL/oNFBcgjZM2a
	L3LeJWlW4lEyBtoCfENy90igs/Jlmnq8QsSBnLx20qJXjuh5FZHvP8lHPr9A+CZQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42pud506xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 10:10:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A48sX5Z024200;
	Mon, 4 Nov 2024 10:10:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42nxds1ywg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 10:10:31 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A4AAU2556492302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Nov 2024 10:10:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2777D2005A;
	Mon,  4 Nov 2024 10:10:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B597920063;
	Mon,  4 Nov 2024 10:10:27 +0000 (GMT)
Received: from [9.203.115.143] (unknown [9.203.115.143])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Nov 2024 10:10:27 +0000 (GMT)
Message-ID: <245fed6f-5fb4-4925-ba0a-fb2f32e650d0@linux.ibm.com>
Date: Mon, 4 Nov 2024 15:40:26 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20241104094431.GY29862@gate.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YnhkNikMYV6n9npEtQCV4ImByZU4w1Fi
X-Proofpoint-GUID: YnhkNikMYV6n9npEtQCV4ImByZU4w1Fi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040089



On 04/11/24 3:14 pm, Segher Boessenkool wrote:
> Hi!
> 
> On Mon, Nov 04, 2024 at 02:51:57PM +0530, Hari Bathini wrote:
>> On 02/11/24 2:29 am, Segher Boessenkool wrote:
>>> On Sat, Nov 02, 2024 at 12:49:25AM +0530, Hari Bathini wrote:
>>>> For ppc64le, depending on the kernel configuration used, offset 16
>>> >from function start address can also be considered function entry.
>>>> Update the test case to accommodate such configurations.
>>>
>>> (This is true for all ELfv2, not just LE.  For the kernel that is about
>>> the same).
>>>
>>> The LEP and GEP can differ by zero, one, two, four, eight, or sixteen
>>> insns (where an insn is four bytes).  Four insns is common, yes, but
>>> maybe you can support all?  See the function symbol's st_other field
>>> to see what the offset is:
>>> 0, 1: zero insns, zero bytes
>>> N = 2..6: 1 << (N-2) insns, i.e. 1<<N bytes
>>> 7: reserved
>>>
>>> (This is the top 3 bits of st_other, the other bits have other meanings).
>>>
>>> Four insns is common, yes, but by no means the only possibility.
>>
>> Hi Segher,
>>
>> Querying for function arguments is supported on kprobes only at function
>> entry. This is a negative test case where the offset is intentionally
>> set beyond function entry while querying for function arguments.
>> I guess, simply setting the offset to 20 (vfs_read is anyway
>> going to be beyond 5 instructions) instead of 8 for powerpc would
>> make all platforms and ABI variants happy?
> 
> I have no idea.  What is this "offset" anyway?

offset (in bytes) from function start address..

> 
> This is just the ELFv2 ABI.  No platform can make up its own thing at
> all (well, none decided to be gratuitously incompatible, so far).  And
> there are no "ABI variants"!

The test case applies for ABIv1 & ABIv2. All ppc32 & ppc64 platforms..

> 
> You're just making assumptions here that are based on nothing else but
> observations of what is done most of the time.  That might work for a
> while -- maybe a long while even! -- but it can easily break down.

Hmmm.. I understand that you want the test case to read st_other field
but would you rather suggest an offset of 64?
Is a GEP of 8/16 instructions going to be true anytime soon or is it
true already for some cases? The reason I ask that is some kprobe/ftrace
code in the kernel might need a bit of re-look if that is the case.

Thanks
Hari

