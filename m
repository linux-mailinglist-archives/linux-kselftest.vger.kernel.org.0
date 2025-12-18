Return-Path: <linux-kselftest+bounces-47681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEAECCAA99
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 08:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5083C3022182
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 07:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A30330651;
	Thu, 18 Dec 2025 07:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XUg9jNOS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9530333064B;
	Thu, 18 Dec 2025 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766042429; cv=none; b=cOxxvfgew0P6semKv9YGY8zc8EAaKxNBBtc38T+fv6qudLhh3Yn5K/0lGp0qcVIYF8PMTsIQIfVViYnheJkFa+/y7fHAoFqv6RMXtdLzXxvjIqs3ufRqpHGNvg8k8ScYtMfWLRMs6zvJmOTN/OTmgpnqWSu7g6/4ZlhPAYBi+7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766042429; c=relaxed/simple;
	bh=n/4hzjJ+5DiQQZLxNqiFaBQ2BoW86ezVZJzRJDbCCJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=norLP/5Mg5KPKURajnpPYWf/OqY8Xhq1hspYFdN/2b+2yBYW1QE5sBi8fFc1RG0Td9sWpXFzKwe8BNy6F5s5kdNNGdn1q4w1gtxymZRQoCm1XvrT6uwcXcp+gqq2jVW5K/+7pqXEzI4f6JBeXghFzRYN0DKIvFhH3OxD4B77jxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XUg9jNOS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BI67fJo009648;
	Thu, 18 Dec 2025 07:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=TLWi3nrcsGDB818pqoBYohfAmJ3T7j
	IB7ZTB+6E2JUU=; b=XUg9jNOShKsCXJlNwaU5ewV5FcxSeioy1KVnCmNlgjb3FH
	/Z9C1JHKDOz1AMS7w9nVzeVY0dMU0t7jGjbQyIR+JNpYp2NwGQ/3Uh0ILUgiAIM5
	NoWQZgOmj4RU3wRdC6DQp2S1LYXA4rlB+HznI3hz5qx3j+NAFFoMQNnCv0Sq5QK7
	g6SrndgpPZwkgFFiU89OAU7E0+AYsgGXG9/WlkH87WuehXJEt4ktNMP9jyqR8h3K
	nZtKknuhklqyFClvBNe3EA1BhuuPbWHMtqwmxcjvx7QGXXAdywWhUJyFoXwwxXou
	WzzcgCRmDSwI4vEd4L2KZ9JeAA10S53+kMwN0s6A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yn8sc1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 07:20:07 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BI7K6Fc019392;
	Thu, 18 Dec 2025 07:20:07 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yn8sc19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 07:20:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BI5qOvJ012835;
	Thu, 18 Dec 2025 07:20:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1juyf6ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 07:20:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BI7K3d060686598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Dec 2025 07:20:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4B4320043;
	Thu, 18 Dec 2025 07:20:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC8AE20040;
	Thu, 18 Dec 2025 07:20:01 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.210.77])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Dec 2025 07:20:01 +0000 (GMT)
Date: Thu, 18 Dec 2025 12:49:59 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Issue in parsing of tests that use KUNIT_CASE_PARAM
Message-ID: <aUOrH1iapKnOaZEj@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <aULJpTvJDw9ctUDe@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aULJpTvJDw9ctUDe@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAxOCBTYWx0ZWRfX1ET7jvOYM1cS
 5YBd9661+Xw/0t1y17XPN/br5khxidZHrzs7d8OrFGqEZUXU9b1oY8DU6nQcfsYOX8otI6amw36
 /QR+is69w26euZYYTxxGmkMhvY5vkWcmCMhrjiCUiyq8CBoU/HocBENc9bbLfFr/P0/Y33T3sv1
 g77ckHkQ1fCd/ZNzYg1PXTOQVzUBRkyYkkfh8bDDTrcCPdRxgdxTk/N8LXjEv0yJxxeraC1oqP2
 3MaaGMBmLYU/ZKjn/sMm4teLXpm8eL3KIiZcfj49hcdTS8JX+heRQ5d1SS+VSSSUAMaTktKQiCs
 CoT70SXJGMN+3mfCjnTgXr0W9hQAtUdNCghKeQ2KvoY0dH5ZQRKGxwHd4KrU/BM6IKC3g5HGn+S
 DpkpO+YevjuVNJdgkBuYHZteFuc0Cw==
X-Proofpoint-GUID: g1z2H3Xot4sBDR1x_I0liZtfkVmUEbMm
X-Proofpoint-ORIG-GUID: SGRQkEJWG2CGRzFh_kv1QS1SnQq8zfqQ
X-Authority-Analysis: v=2.4 cv=LbYxKzfi c=1 sm=1 tr=0 ts=6943ab27 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=fBP9zgGPufsLqfDVMpYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2512130018

On Wed, Dec 17, 2025 at 08:47:57PM +0530, Ojaswin Mujoo wrote:
> Hello,
> 
> While writing some Kunit tests for ext4 filesystem, I'm encountering an
> issue in the way we display the diagnostic logs upon failures, when
> using KUNIT_CASE_PARAM() to write the tests.
> 
> This can be observed by patching fs/ext4/mballoc-test.c to fail
> and print one of the params:
> 
> --- a/fs/ext4/mballoc-test.c
> +++ b/fs/ext4/mballoc-test.c
> @@ -350,6 +350,8 @@ static int mbt_kunit_init(struct kunit *test)
>         struct super_block *sb;
>         int ret;
> 
> +       KUNIT_FAIL(test, "Failed: blocksize_bits=%d", layout->blocksize_bits);
> +
>         sb = mbt_ext4_alloc_super_block();
>         if (sb == NULL)
>                 return -ENOMEM;
> 
> With the above change, we can observe the following output (snipped):
> 
> [18:50:25] ============== ext4_mballoc_test (7 subtests) ==============
> [18:50:25] ================= test_new_blocks_simple  ==================
> [18:50:25] [FAILED] block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
> [18:50:25]     # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/mballoc-test.c:364
> [18:50:25] Failed: blocksize_bits=12
> [18:50:25] [FAILED] block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
> [18:50:25]     # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/mballoc-test.c:364
> [18:50:25] Failed: blocksize_bits=16
> [18:50:25] [FAILED] block_bits=16 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
> [18:50:25]     # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/mballoc-test.c:364
> [18:50:25] Failed: blocksize_bits=10
> [18:50:25]     # test_new_blocks_simple: pass:0 fail:3 skip:0 total:3
> [18:50:25] ============= [FAILED] test_new_blocks_simple ==============
> <snip>
> 
> Note that the diagnostic logs don't show up correctly. Ideally they
> should be before test result but here the first [FAILED] test has no
> logs printed above whereas the last "Failed: blocksize_bits=10" print
> comes after the last subtest, when it actually corresponds to the first
> subtest.
> 
> The KTAP file itself seems to have diagnostic logs in the right place:
> 
> KTAP version 1
> 1..2
>     KTAP version 1
>     # Subtest: ext4_mballoc_test
>     # module: ext4
>     1..7
>         KTAP version 1
>         # Subtest: test_new_blocks_simple

So looking into this a bit more and comparing the parameterized output
with non parameterized output, I'm seeing that the difference is that
output via KUNIT_CASE_PARAM is not printing the test plan line right
here. This plan sort of serves as divider between the parent and the 3
children's logs and without it our parsing logic gets confused. When I
manually added a "1..3" test plan I could see the parsing work correctly
without any changes to kunit_parser.py.

Regards,
ojaswin

>     # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/mballoc-test.c:364
> Failed: blocksize_bits=10
>         not ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
>     # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/mballoc-test.c:364
> Failed: blocksize_bits=12
>         not ok 2 block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
>     # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/mballoc-test.c:364
> Failed: blocksize_bits=16
>         not ok 3 block_bits=16 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
>     # test_new_blocks_simple: pass:0 fail:3 skip:0 total:3
>     not ok 1 test_new_blocks_simple
>     <snip>
> 
> By tracing kunit_parser.py script, I could see the issue here is in the
> parsing of the "Subtest: test_new_blocks_simple". We end up associating
> everything below the subtest till "not ok 1 block_bits=10..." as
> diagnostic logs of the subtest, while these lons actually belong to the
> first of the 3 subtests under this test.
> 

