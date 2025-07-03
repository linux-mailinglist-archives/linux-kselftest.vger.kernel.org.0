Return-Path: <linux-kselftest+bounces-36443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BF8AF778E
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 16:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0B3162A11
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57ABE2EBDF8;
	Thu,  3 Jul 2025 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="olvR6EZ1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4762EACFF;
	Thu,  3 Jul 2025 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553133; cv=none; b=bBZsR73a0rFJpIIa5VyXdLeNNUfFy8DfYxyAw5E/Ej2WmuWjG90A8arOu57FTfVE2IA1dsQ7hMP2y6nYJCePtFk8qd+Lt9HBJ3t9Plf2eR6+WqK/LC8LB7Ktkw8vXcmE+LaA76Yo+1Gz1fZ5Iln/NOjGAeqDkFc/+I0XxIOGiX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553133; c=relaxed/simple;
	bh=CcCcAs1S/wHwTfAHyx0ixW/Dl3hzosnHUjJLp3j1LlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ADHu/Hki6UEtbH9B+fNukbx3HbjPX3NqgKFLa/D22oP5aQrjwQ/vXl1NzER+Yv9g0oDQTBSzhfkCQQ5gidrg3v0UNDG3KMAZRyeJeCD7sFcNUJGvQgWXGh/ygjHHFSqj5tcd7HYyaucR/PJ5MV2P4BBIU6QKGxyqFkQ9Tf5yHbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=olvR6EZ1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 563BMWSQ028339;
	Thu, 3 Jul 2025 14:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eRsY50
	z3YQA/nIb5B7MZxVRcf3v888DImdHoogzEoUQ=; b=olvR6EZ1PllwopurFL2+/8
	dR6wYnsRvXeR85ieEdT4QRwMgXmQcY06rtq9noa2M59NrPqMUI2vlsOUDv8b5ANP
	dqmS9FAQRK2fR0cLI7kwDohOyY58cdhmZXOI0JRi4r2mpEs9qvAXAv8+Xl9NRoG3
	4lS/qr31alc4o7UAOU4yKPbuIz/f59Rki8OFA1VDzMKh4QKEaYueYzuuQC9lOwGi
	Sx5LD7HNOrmeklleMV5nC2pjSlq4TbcnYqa3EjhAUje64+cBb0q+9FhCLlaX4igq
	jDW3F7zs1eR5dUBMRlmEAaneMKTpFJQ64JQVUgWp4CplG9H7kqErYApWPrbxtODQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84dmf88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 14:31:54 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 563ELTeZ013840;
	Thu, 3 Jul 2025 14:31:53 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84dmf85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 14:31:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 563BZBHI021354;
	Thu, 3 Jul 2025 14:31:52 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jwe3n28u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 14:31:52 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 563EVqoC25952908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Jul 2025 14:31:52 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BC5358043;
	Thu,  3 Jul 2025 14:31:52 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBAE758059;
	Thu,  3 Jul 2025 14:31:46 +0000 (GMT)
Received: from [9.109.245.113] (unknown [9.109.245.113])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Jul 2025 14:31:46 +0000 (GMT)
Message-ID: <1b6e8526-59cb-4de0-bd82-8b0964cb6233@linux.ibm.com>
Date: Thu, 3 Jul 2025 20:01:45 +0530
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
 <7b78974b-6841-4280-89c1-01bd835d4f27@linux.ibm.com>
 <42c0135a-dbd9-47e1-9b9e-c36c147a2315@redhat.com>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <42c0135a-dbd9-47e1-9b9e-c36c147a2315@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mlj0ZM2IlX8Yno1D-kOeHnHdVJh9pEwN
X-Proofpoint-GUID: jKPDFIyjEgTEYq_-UPmCyt1NWA0zHq5I
X-Authority-Analysis: v=2.4 cv=Ib6HWXqa c=1 sm=1 tr=0 ts=6866945a cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=wdEVuivgXQAh7QcTvTEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDEyMCBTYWx0ZWRfX3u28tBnifZBA NgQcSJcGDE5fQh1ikDPw0BVHJVirVRARwJXc7caBlMeSOKmcQLYTXpFcEajWhW/eYGxViOl8tr5 tXyJh1Pv+M0MopBB8Qd0l7SF/mEkkXctLVFZ/SjLu6aFtpr/uZfm6fOsnCBeRHFRrRI5T8rs20n
 F0Vz1owkzLQWEcaK37zlDeHo8eHuxS7T5jc9G2LCwcynPbqgtN6HLRWSPzuNDHI36XBVP+LWvL9 X8pOB9Sp4m3HMvMZ3GO1hipcfoQaUPQ3i3uTLpw8iIPvKLW1Y4u3W1iyufk+XdZWGTEBBCnRxex 5o704DHbL5dIDV7kUpoBxAKKmQN49HiQQVdgwCUFoaqC0pF8SszqR/XqztC3reZWYkLpyPZEpik
 VXPPvI4zLl4QRee6TgisnNk6Dm+xeTJHT/xMcIVrql4kyh+exUeRvd5/4inOhvi0ljMT+oWY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030120


On 7/3/25 2:44 PM, David Hildenbrand wrote:
> On 03.07.25 10:51, Donet Tom wrote:
>> Hi David
>>
>> On 7/3/25 2:03 PM, David Hildenbrand wrote:
>>> On 03.07.25 08:06, Aboorva Devarajan wrote:
>>>> In ksm_functional_tests, test_child_ksm() returned negative values
>>>> to indicate errors. However, when passed to exit(), these were
>>>> interpreted as large unsigned values (e.g, -2 became 254), leading to
>>>> incorrect handling in the parent process. As a result, some tests
>>>> appeared to be skipped or silently failed.
>>>>
>>>> This patch changes test_child_ksm() to return positive error codes
>>>> (1, 2, 3) and updates test_child_ksm_err() to interpret them 
>>>> correctly.
>>>> This ensures the parent accurately detects and reports child process
>>>> failures.
>>>>
>>>> --------------
>>>> Before patch:
>>>> --------------
>>>> - [RUN] test_unmerge
>>>> ok 1 Pages were unmerged
>>>> ...
>>>> - [RUN] test_prctl_fork
>>>> - No pages got merged
>>>> - [RUN] test_prctl_fork_exec
>>>> ok 7 PR_SET_MEMORY_MERGE value is inherited
>>>> ...
>>>> Bail out! 1 out of 8 tests failed
>>>> - Planned tests != run tests (9 != 8)
>>>> - Totals: pass:7 fail:1 xfail:0 xpass:0 skip:0 error:0
>>>>
>>>> --------------
>>>> After patch:
>>>> --------------
>>>> - [RUN] test_unmerge
>>>> ok 1 Pages were unmerged
>>>> ...
>>>> - [RUN] test_prctl_fork
>>>> - No pages got merged
>>>> not ok 7 Merge in child failed
>>>> - [RUN] test_prctl_fork_exec
>>>> ok 8 PR_SET_MEMORY_MERGE value is inherited
>>>> ...
>>>> Bail out! 2 out of 9 tests failed
>>>> - Totals: pass:7 fail:2 xfail:0 xpass:0 skip:0 error:0
>>>>
>>>> Fixes: 6c47de3be3a0 ("selftest/mm: ksm_functional_tests: extend test
>>>> case for ksm fork/exec")
>>>> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
>>>
>>> BTW, when I run the test, I get this weird output
>>>
>>> TAP version 13
>>> 1..9
>>> # [RUN] test_unmerge
>>> ok 1 Pages were unmerged
>>> # [RUN] test_unmerge_zero_pages
>>> ok 2 KSM zero pages were unmerged
>>> # [RUN] test_unmerge_discarded
>>> ok 3 Pages were unmerged
>>> # [RUN] test_unmerge_uffd_wp
>>> ok 4 Pages were unmerged
>>> # [RUN] test_prot_none
>>> ok 5 Pages were unmerged
>>> # [RUN] test_prctl
>>> ok 6 Setting/clearing PR_SET_MEMORY_MERGE works
>>> # [RUN] test_prctl_fork
>>> ok 7 PR_SET_MEMORY_MERGE value is inherited
>>> # [RUN] test_prctl_fork_exec
>>>
>>> ^ where is the test?
>>>
>>> # [RUN] test_prctl_unmerge
>>> ok 8 Pages were unmerged
>>> # Planned tests != run tests (9 != 8)
>>> # Totals: pass:8 fail:0 xfail:0 xpass:0 skip:0 error:0
>>>
>>> ^ what?
>>>
>>> ok 8 PR_SET_MEMORY_MERGE value is inherited
>>> # [RUN] test_prctl_unmerge
>>> ok 9 Pages were unmerged
>>> # Totals: pass:9 fail:0 xfail:0 xpass:0 skip:0 error:0
>>>
>>> ^ huh, what now?
>>>
>>
>> The problem with the exec test is that it uses its own binary to exec.
>>
>>           } else if (child_pid == 0) {
>>                   char *prg_name = "./ksm_functional_tests";
>>                   char *argv_for_program[] = { prg_name,
>> FORK_EXEC_CHILD_PRG_NAME, NULL };
>>
>>                   execv(prg_name, argv_for_program);
>>                   return;
>>           }
> > > So we should run it on the same directory where the binary present.
>
> So, I assume the execv fails. We should handle that, and figure out 
> why it fails.
>
> diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c 
> b/tools/testing/selftests/mm/ksm_functional_tests.c
> index d8bd1911dfc0a..0ddbb390df33b 100644
> --- a/tools/testing/selftests/mm/ksm_functional_tests.c
> +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
> @@ -527,6 +527,8 @@ static void test_child_ksm_err(int status)
>                 ksft_test_result_fail("Merge in child failed\n");
>         else if (status == -3)
>                 ksft_test_result_skip("Merge in child skipped\n");
> +       else if (status == 4)
> +               ksft_test_result_fail("Binary not found\n");
>  }
>
>  /* Verify that prctl ksm flag is inherited. */
> @@ -598,7 +600,7 @@ static void test_prctl_fork_exec(void)
>                 char *argv_for_program[] = { prg_name, 
> FORK_EXEC_CHILD_PRG_NAME };
>
>                 execv(prg_name, argv_for_program);
> -               return;
> +               exit(4);
>         }
>
>         if (waitpid(child_pid, &status, 0) > 0) {
>
> results in
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
> not ok 8 Binary not found
> # [RUN] test_prctl_unmerge
> ok 9 Pages were unmerged
> Bail out! 1 out of 9 tests failed
> # Totals: pass:8 fail:1 xfail:0 xpass:0 skip:0 error:0


Thanks David.

We will add this in next version.


>
>

