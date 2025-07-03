Return-Path: <linux-kselftest+bounces-36411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C39AF6DAC
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 10:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A6F481916
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 08:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1658629B795;
	Thu,  3 Jul 2025 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W8Ycyy8C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4502DE6E3;
	Thu,  3 Jul 2025 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751532720; cv=none; b=MkSV6+cRvAQqFRdDrwfHzOq4bB42389MLUQGkUGdFwiHZxPhjhjF4RXCQkUCOd64XkGLHiaVlC9OPeueWHsgYIDxHBhKGpL58UieuYUv/aYVBqfJCoJmbuQPuPip1E4ucC7lCxb9HIDR7h8Ar+5502kkeuIokGe6Ygn98iH9FIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751532720; c=relaxed/simple;
	bh=THsAr3zlwlWaWma2DhD3Eakrzn0/u2RkvZ8x4APY8WQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oROSzG1wLN2VqCMFxq8R4WWmi66+qDd17VL84+Q+YezzVbTqByFkQPksM4WfkjWvWQVDw0zrr4vxeo6fu2uRi8liFo2jtYCCXncue3+zV+FAD88h3URLs+1gltRBymhSdSXPw9ktmqimD1QO2+EeI2q/90Ky+Y4TE2ChiK9o+1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W8Ycyy8C; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562MlYEI024207;
	Thu, 3 Jul 2025 08:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/d2noo
	saDdXdconM+7uuqyYqydbAnZBC//lI6fIfcVU=; b=W8Ycyy8C5pbkqZkGZ+T89Q
	VgqAXjSHHT1AaSSEH0rV9qlmYZc07Ryj3z5XEi0MPipTkBonl+2MUZI2Tj3DnA7k
	JLagB8gYSpDeSTu0lIpeM+ICbtzOeMF7pws+aZNATynTulPC4M7HLkE0sPCV3ABZ
	NanVgLE64CzTCAbumm6mTmU1uHtnaLkA2nS/r4LpuvfBpjYZ/HEawoiVq7yhHKMk
	6fr/PizvF+7NsftV9mwfVzUj3wF8htlxfWSRXW0ZNG8kI7XL1NhLQZK355TwIvGe
	rbjG8KbJjBcwvqLQ/er4iZ/U4JXNVOoEwE5y7si+GZOQUQBgyDfDEoMC+N1POU8A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j6u226vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 08:51:35 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5638i4Y5003197;
	Thu, 3 Jul 2025 08:51:35 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j6u226v8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 08:51:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5636HAqx021106;
	Thu, 3 Jul 2025 08:51:34 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jtqum3qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 08:51:34 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5638pRoY20054692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Jul 2025 08:51:27 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EBBB58043;
	Thu,  3 Jul 2025 08:51:32 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB02258063;
	Thu,  3 Jul 2025 08:51:24 +0000 (GMT)
Received: from [9.109.245.113] (unknown [9.109.245.113])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Jul 2025 08:51:24 +0000 (GMT)
Message-ID: <7b78974b-6841-4280-89c1-01bd835d4f27@linux.ibm.com>
Date: Thu, 3 Jul 2025 14:21:22 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] selftests/mm: Fix child process exit codes in
 ksm_functional_tests
To: David Hildenbrand <david@redhat.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
        Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
        pfalcato@suse.de, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com
References: <20250703060656.54345-1-aboorvad@linux.ibm.com>
 <20250703060656.54345-6-aboorvad@linux.ibm.com>
 <9586f8ff-3b34-4613-853b-0c808fcbb9d2@redhat.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <9586f8ff-3b34-4613-853b-0c808fcbb9d2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aWULfUbizkVbgs-hwJzrcyYummicWdpm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDA3MSBTYWx0ZWRfX10b90fLzDQum H5vavubv3EkFWvXssp3EhUEd4tVsPs2pfbT5qWmg7SYZZDyqYoqbvg3U4XSHfEWEAILldoEgV3e uIPap7kI83M2ds6zkqMAfZq6s7yTyMdDURUNjBwvhRjc6AHXis+VdvZJ3t1qIUZc4EfQJ8CZEym
 P/ReoaBQCpXxiVMYb/9Nb0Cd39isLUYI+/0egdS6tMd+mgKK19o+7dcTdjRFIVP3FUIWXEuT9xX PLGujQy8170pvGSZQd1+1bGTAoMxrDY3GC1KnoMwp/dkiQj192bHn2quLT2DpXiBZ8v5fIU35qm 7QtMxVRcDwYtBTid1ouifYthkpcBek36Tfq8RwOa7JlHGDSfVhh/gle2+YTl1ssWiK+toV3+4i+
 l8MHAzcmpJgg5eD7tEX0nSfSIyXpLkuIqbQ4v3yIJTDyhSY7+3fgoMB65ej3NkDPoNfmyBZn
X-Proofpoint-GUID: Xz2n13aL_c-D2xPk4qXlU5WW64L6zz6d
X-Authority-Analysis: v=2.4 cv=GrRC+l1C c=1 sm=1 tr=0 ts=68664497 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=1mHyDwmyOsOsTL-LXCYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_02,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030071

Hi David

On 7/3/25 2:03 PM, David Hildenbrand wrote:
> On 03.07.25 08:06, Aboorva Devarajan wrote:
>> In ksm_functional_tests, test_child_ksm() returned negative values
>> to indicate errors. However, when passed to exit(), these were
>> interpreted as large unsigned values (e.g, -2 became 254), leading to
>> incorrect handling in the parent process. As a result, some tests
>> appeared to be skipped or silently failed.
>>
>> This patch changes test_child_ksm() to return positive error codes
>> (1, 2, 3) and updates test_child_ksm_err() to interpret them correctly.
>> This ensures the parent accurately detects and reports child process
>> failures.
>>
>> --------------
>> Before patch:
>> --------------
>> - [RUN] test_unmerge
>> ok 1 Pages were unmerged
>> ...
>> - [RUN] test_prctl_fork
>> - No pages got merged
>> - [RUN] test_prctl_fork_exec
>> ok 7 PR_SET_MEMORY_MERGE value is inherited
>> ...
>> Bail out! 1 out of 8 tests failed
>> - Planned tests != run tests (9 != 8)
>> - Totals: pass:7 fail:1 xfail:0 xpass:0 skip:0 error:0
>>
>> --------------
>> After patch:
>> --------------
>> - [RUN] test_unmerge
>> ok 1 Pages were unmerged
>> ...
>> - [RUN] test_prctl_fork
>> - No pages got merged
>> not ok 7 Merge in child failed
>> - [RUN] test_prctl_fork_exec
>> ok 8 PR_SET_MEMORY_MERGE value is inherited
>> ...
>> Bail out! 2 out of 9 tests failed
>> - Totals: pass:7 fail:2 xfail:0 xpass:0 skip:0 error:0
>>
>> Fixes: 6c47de3be3a0 ("selftest/mm: ksm_functional_tests: extend test 
>> case for ksm fork/exec")
>> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>
> BTW, when I run the test, I get this weird output
>
> TAP version 13
> 1..9
> # [RUN] test_unmerge
> ok 1 Pages were unmerged
> # [RUN] test_unmerge_zero_pages
> ok 2 KSM zero pages were unmerged
> # [RUN] test_unmerge_discarded
> ok 3 Pages were unmerged
> # [RUN] test_unmerge_uffd_wp
> ok 4 Pages were unmerged
> # [RUN] test_prot_none
> ok 5 Pages were unmerged
> # [RUN] test_prctl
> ok 6 Setting/clearing PR_SET_MEMORY_MERGE works
> # [RUN] test_prctl_fork
> ok 7 PR_SET_MEMORY_MERGE value is inherited
> # [RUN] test_prctl_fork_exec
>
> ^ where is the test?
>
> # [RUN] test_prctl_unmerge
> ok 8 Pages were unmerged
> # Planned tests != run tests (9 != 8)
> # Totals: pass:8 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> ^ what?
>
> ok 8 PR_SET_MEMORY_MERGE value is inherited
> # [RUN] test_prctl_unmerge
> ok 9 Pages were unmerged
> # Totals: pass:9 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> ^ huh, what now?
>

The problem with the exec test is that it uses its own binary to exec.

         } else if (child_pid == 0) {
                 char *prg_name = "./ksm_functional_tests";
                 char *argv_for_program[] = { prg_name, 
FORK_EXEC_CHILD_PRG_NAME, NULL };

                 execv(prg_name, argv_for_program);
                 return;
         }

So we should run it on the same directory where the binary present.



