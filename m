Return-Path: <linux-kselftest+bounces-10662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737768CE384
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 11:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1BBA1F23118
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 09:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02BF85264;
	Fri, 24 May 2024 09:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ljAPogY6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3DD282E2;
	Fri, 24 May 2024 09:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716543126; cv=none; b=r/vCsKW5TXYN/2YPCZiwqmnT0Y9JCAm3ow8IPUM0cUNSbFMuS+wa3kgfob0sR5T8uxUCtA8e6mStu6VAGLLG8umcdvhP2LxPeHsX2DCXbPGbtFzKfaMuNeMh/ADhG/enC+sXg0lH/nUZ26T0olrhrP1tmdgavQ0REdODET6FwKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716543126; c=relaxed/simple;
	bh=rwAvwKwHBuccXt1++ALJWxvGf7nO+9ofOmq3PGzn/tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1YzaqDxdJnPzn4JvHo79wS6iEdB7wcPhHzfyJy9Ku7Mn0Bu1i1O4bpSYJLqggifMzo/dg5+N/+b002bhgNFalI1HIQgxoSX2zbnNezIw43UISlK+enYdvZiUEAnTRCCxegFP4AxHpp5YViCbc4qcFMkr3v9q5cr505M+11P9W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ljAPogY6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44O9N43H017389;
	Fri, 24 May 2024 09:31:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7is4630m7gBGeEwPyBGyvuIIaidItnoMd2eDRou0Gic=;
 b=ljAPogY6Xc5nYw7h4kDhE4uqSOX6jpC5WdpCqrRYsXtEb0l56jt39g+pX0W65ptwV+sB
 TQD84y+a9emrOehy0gTPhaEydDP4Srfe3GVD7dOQHxz8669qKsVJ21JaKu29QwHn13M4
 CTireWxFK3WxQIDp4afIJtSQJMnab7MnOjBw88j116G+1zxmwJ+XnRmoJaxiAJfPrK84
 umEBaAtBETdzDbcYapQ/X190C7CletZ/f9skQowaLyAVFSJJLUNfJlkoGEYCzTXacTba
 DH6rpM8yqWK2sdicROA6Ds6n927riXOTJV69v2jsMlEpMFUPqo4xyNBmLADg3WGpb/qv fA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yar6u8105-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 09:31:33 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44O9S4sE025761;
	Fri, 24 May 2024 09:31:32 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yar6u8103-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 09:31:32 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44O8032S008123;
	Fri, 24 May 2024 09:31:31 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y78vmfby6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 May 2024 09:31:31 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44O9VTXE16515792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 09:31:31 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95FC65805F;
	Fri, 24 May 2024 09:31:27 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 021AB5805E;
	Fri, 24 May 2024 09:31:24 +0000 (GMT)
Received: from [9.109.245.191] (unknown [9.109.245.191])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 May 2024 09:31:23 +0000 (GMT)
Message-ID: <3c6e5e78-aa49-4002-941f-af8fd2b81d10@linux.ibm.com>
Date: Fri, 24 May 2024 15:01:18 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: mm: Test if hugepage does not get leaked during
 __bio_release_pages()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Tony Battersby <tonyb@cybernetics.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>
References: <20240523063905.3173-1-donettom@linux.ibm.com>
 <20240523121344.6a67a109e0af2ba70973b34b@linux-foundation.org>
 <d551d1cd-a02f-42aa-9de2-10ff7757224c@redhat.com>
 <20240523195734.bc03a8822a34b1a97880fb65@linux-foundation.org>
 <7792c8ba-39e6-47ee-9b43-108270325c15@redhat.com> <87o78vsoav.fsf@gmail.com>
 <c9ee47d3-77cd-4333-805a-d457e4a1bb80@redhat.com>
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <c9ee47d3-77cd-4333-805a-d457e4a1bb80@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9SVpRuQBL_ZxKd5AyejlGygJ40Dy6mHE
X-Proofpoint-ORIG-GUID: ORbpw0wF7gjoGqKtK3qPRFcZr2ETtb5A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_03,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405240066


On 5/24/24 12:31, David Hildenbrand wrote:
> On 24.05.24 08:43, Ritesh Harjani (IBM) wrote:
>> David Hildenbrand <david@redhat.com> writes:
>>
>> dropping stable@vger.kernel.org
>>
>>> On 24.05.24 04:57, Andrew Morton wrote:
>>>> On Thu, 23 May 2024 22:40:25 +0200 David Hildenbrand 
>>>> <david@redhat.com> wrote:
>>>>
>>>>>> You have stable@vger.kernel.org in the mail headers, so I assume 
>>>>>> you're
>>>>>> proposing this for backporting.  When doing this, please include
>>>>>>
>>>>>> Cc: <stable@vger.kernel.org>
>>>>>>
>>>>>> in the changelog footers and also include a Fixes: target.  I'm
>>>>>> assuming the suitable Fixes: target for this patch is 38b43539d64b?
>>>>>
>>>>> This adds a new selfest to make sure what was fixed (and 
>>>>> backported to
>>>>> stable) remains fixed.
>>>>
>>>> Sure.  But we should provide -stable maintainers guidance for "how far
>>>> back to go".  There isn't much point in backporting this into kernels
>>>> where it's known to fail!
>>>
>>> I'm probably missing something important.
>>>
>>> 1) It's a test that does not fall into the common stable kernels
>>> categories (see Documentation/process/stable-kernel-rules.rst).
>>>
>>> 2) If it fails in a kernel *it achieved its goal* of highlighting that
>>> something serious is broken.
>>>
>>>>
>>>> I'm still thinking that we want this in kernels which have 
>>>> 38b43539d64b?
>>>
>>> To hide that the other kernels are seriously broken and miss that fix?
>>>
>>> Really (1) this shouldn't be backported. I'm not even sure it should be
>>> a selftest (sounds more like a reproducer that we usually attach to
>>> commits, but that's too late). And if people care about backporting it,
>>> (2) you really want this test to succeed everywhere. Especially also to
>>> find kernels *without* 38b43539d64b
>>
>>
>> Sorry about the noise and cc'd to stable. I believe we don't need to
>> backport this test. The idea of adding a selftests was "also" to 
>> catch any
>> future bugs like this.
>
> Yes, for that purpose it's fine, but it has quite the "specific 
> reproducer taste". Having it as part of something that is prepared to 
> run against arbitrary kernels (which selftests frequently are not) to 
> detect known problems feels better.
>
> I have seen some hugetlbfs directio tests in LTP. If you think 
> selftest is not the correct place to add this test, we can drop this 
> test from selftests and add it to LTP.
>
> Thanks
> Donet
>
>>
>> I am unaware of any functional test suite where we could add such tests
>> like how filesystems have fstests. Hence the ideas was to add this in
>> selftests.
>
> LTP has quite some MM testcases in testcases/kernel/mem/. But it often 
> has a different focus (CVE or advanced feature/syscall tests). Now 
> that most things are CVEs ... it might not be a bad fit ... :)
>
>>
>> So this begs the question which I also asked few people at LSFMM,
>> Does mm has any mmfvt (mm functional verification tests)? Should we have
>> something like this? Was it tried in past?
>
> I think LTP is mostly the only "bigger" thing we have that is prepared 
> to run against arbitrary kernel versions.
>

