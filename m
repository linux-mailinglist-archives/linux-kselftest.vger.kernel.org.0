Return-Path: <linux-kselftest+bounces-21364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3669BAF88
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 10:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4CA61F21FD3
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 09:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120401AC885;
	Mon,  4 Nov 2024 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sFRV2jaX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FB2BA34;
	Mon,  4 Nov 2024 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730712170; cv=none; b=XtZOqklR/m2RhdS2hP4406zC0hwODYrd/ol3O8Hm1ppMNwYki4uQxbYdoQgsNJcLF982P9VtZIBFcYB7gyPWAKaA0EYzYDRV2RMLxhQ/ygp6yD1BoYlY4VhhVFqMQPjwNbH9kK+ckDUj3jl5mGKINIlerBQTZUPlhFMrW4uRxQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730712170; c=relaxed/simple;
	bh=tHjJ2iRlxincQ6ybuhGA93RH1ppVQ/RZT1X70YwkjtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIeo19WMddHbzV59v7Qv0bhBbMEpK65ht8VoYLetIWLR9MPW8eTZXaSeoXdsQKep0zviwL5wSV/9eUA/UD5rhLw9HGs6yoq2EVzUqe9eobJCe6OQxvCvKckf4dbxq4qeEqu0t5QKYstoHtJLuXGPq6d8+tSCVi+cahm2Pk3bvYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sFRV2jaX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A489oSP003826;
	Mon, 4 Nov 2024 09:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BgtOlU
	YcexH28p6ZLGkQs9farVzwCdQjbGABQPsJEZA=; b=sFRV2jaXiqRF9vwmAJSZjR
	J+/ruI5vjVq2OxrsONgqH9P3XR4mPpYZ4kqi/PpzJC/RkMRx0cBSNlpVvHcqqcUJ
	kYeG01cOSREN367acc3bzfVmLNALXmm6OPLy/zT1xbv+Y1LVz4SVAlxAJXdT3BXY
	7RTqSJ33l20fe6ASiyoXRDEgYFsUvluPRHYTr/2KlJia1PrP4CBVv1P9naPMF1MY
	ZmMRpYiejm3C1jufQWwbmlyMUz0TrRHrHCqyt+jVtJ/IAmGxIYQjxsfq2BTNVdvJ
	PA1G+ICOMilXo02uQOzWiqGIu3DZJfsTmFAEoBad9oYDjMQBlg+tmNUBt0q+IvdA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ptgyg9gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 09:22:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A498xnA032050;
	Mon, 4 Nov 2024 09:22:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nydmhurk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 09:22:03 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A49M1aS54788574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Nov 2024 09:22:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FBDE2004B;
	Mon,  4 Nov 2024 09:22:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E51E20043;
	Mon,  4 Nov 2024 09:21:59 +0000 (GMT)
Received: from [9.203.115.143] (unknown [9.203.115.143])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Nov 2024 09:21:59 +0000 (GMT)
Message-ID: <1916cb5c-cb3d-427c-bcf0-2c1b905fd6d1@linux.ibm.com>
Date: Mon, 4 Nov 2024 14:51:57 +0530
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
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20241101205948.GW29862@gate.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8GtkEmTnIot0mf1svQRW34AKbisKBiaf
X-Proofpoint-ORIG-GUID: 8GtkEmTnIot0mf1svQRW34AKbisKBiaf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1011 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411040081



On 02/11/24 2:29 am, Segher Boessenkool wrote:
> Hi!
> 
> On Sat, Nov 02, 2024 at 12:49:25AM +0530, Hari Bathini wrote:
>> For ppc64le, depending on the kernel configuration used, offset 16
>> from function start address can also be considered function entry.
>> Update the test case to accommodate such configurations.
> 
> (This is true for all ELfv2, not just LE.  For the kernel that is about
> the same).
> 
> The LEP and GEP can differ by zero, one, two, four, eight, or sixteen
> insns (where an insn is four bytes).  Four insns is common, yes, but
> maybe you can support all?  See the function symbol's st_other field
> to see what the offset is:
> 0, 1: zero insns, zero bytes
> N = 2..6: 1 << (N-2) insns, i.e. 1<<N bytes
> 7: reserved
> 
> (This is the top 3 bits of st_other, the other bits have other meanings).
> 
> Four insns is common, yes, but by no means the only possibility.

Hi Segher,

Querying for function arguments is supported on kprobes only at function
entry. This is a negative test case where the offset is intentionally
set beyond function entry while querying for function arguments.
I guess, simply setting the offset to 20 (vfs_read is anyway
going to be beyond 5 instructions) instead of 8 for powerpc would
make all platforms and ABI variants happy?

Thanks
Hari

