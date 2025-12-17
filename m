Return-Path: <linux-kselftest+bounces-47666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA71CC88CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 16:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09D23318F812
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 15:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D43F36C59F;
	Wed, 17 Dec 2025 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j4yDUKSm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AD436C59D;
	Wed, 17 Dec 2025 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984694; cv=none; b=f1SKfmxpqHsZaNn53j5vFfcmNGOeYHOKsROxQkV9M/mkju+bPQKESgNDVIItOl5w4RD6PmC5sUM+3yJpM08AfhSRdPfidqdy8jq5q1AGdtb/DDI8lUGaloKjW1pfmqMnkxz8eFnWKck7Y8ZkQeDH5OBROXF2jJ8J/yViLfh03KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984694; c=relaxed/simple;
	bh=7igAGa1tiKnz7brDkA0WSEn4Ad3/hqkq63Fr/o7OGp8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NywHieC4gtXggaBTroVFvqnJEEbD9j00Hm57lw3YEGkRkxxSxbMcwxGlt1fo3CmXaeRE6GSTKBXoNWs4Kr901u7JzhZc/HE9gztCdpMo6sEzo4Y+XAF2l94fLTkKicmtdM4VqO2wghcdMIPg9DgnapqCAK+xqawuVMEEzIBcJKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j4yDUKSm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHDjAaf003416;
	Wed, 17 Dec 2025 15:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=Ruy4JEfcflMSGCDnLg6/LqOSGGM9Bf8oNAFy4r+v8Iw=; b=j4yDUKSm
	n03qtjAbwL2M/QljaiPaFW4MjoQYW40IHFX8J4iaTF3VmE+E5udCEhtWgp36RYDd
	2Iezumj6FBM6thyJFcaGP2uFnmvcGiWIfJYA4vaiJIMEWGZppdGzwNxNDoppxETA
	qKwgJf4Os43wd2NHMqn2iv6s9+V8jO6mdyBuNjyn9J2f4ZrGQs41Afv+NOKi9/TV
	N8ymePYjacGfc+GZL0+/S5SqElQEtjhb2IYwzvotdcf6naYYO22Q9ZsyXog3/RBU
	151HT7QrmysDoEXJJRzm7hsmQASvFyRwvP4mpNjgp0XxSm3FRzK33xnfCiiFPWQe
	4JfrxEujB8Pkrw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yt1mpyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 15:18:04 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BHF5xvS024790;
	Wed, 17 Dec 2025 15:18:03 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yt1mpyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 15:18:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHEA3m3002863;
	Wed, 17 Dec 2025 15:18:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1kfnawu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 15:18:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BHFI1pF52167032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 15:18:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E712120043;
	Wed, 17 Dec 2025 15:18:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AE7620040;
	Wed, 17 Dec 2025 15:17:59 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.20.161])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 17 Dec 2025 15:17:59 +0000 (GMT)
Date: Wed, 17 Dec 2025 20:47:57 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Issue in parsing of tests that use KUNIT_CASE_PARAM
Message-ID: <aULJpTvJDw9ctUDe@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iYNUA6JLpR3S6cF8hARwwCYw_LtPTrMn
X-Proofpoint-ORIG-GUID: sgE7OsxrWqiSMG5lo2X-Yf2in7whwbHT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX0nmSBlMiBS5E
 2m6iwcg45iDfL1DxMw5IJU/8+Sj82WHtFc5XvhQ6sOass29RHjmuzsELLgx+AFjiJk4j/NgVniq
 DLHoYzg81cTabvv5NTCx9hfm47zVhDkwqlaZS44t/gIGSyYrqy/KhubHkMsy29VfrDTOBfxXVRe
 eK6e+Lu2K4jNDx8nuN7GR5AmLymLcX9uZloaSUOcINDcZPbtK10WAAeE/Uc+rF68AQCV+655Dgq
 WoKbd55SZpFRYbm3DWvZ3iUxurJHP4zmvoJ1zOCOletoP8qqIuSy1SZYjKpQQ4xJayZDXSLpSTu
 Eyt9CllYgQEMI+zAvhEKCUAooIfsGduZ9xBM0jLRtXmMOpgmJz6pk7hVof9WD1P17NMNdhwPaZP
 MSNisEqX+SbW5pD0Wp+qa7ioOzMuJg==
X-Authority-Analysis: v=2.4 cv=L/MQguT8 c=1 sm=1 tr=0 ts=6942c9ac cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=AI-MSd0SjKFp4D8ZOU8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_02,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023

Hello,

While writing some Kunit tests for ext4 filesystem, I'm encountering an
issue in the way we display the diagnostic logs upon failures, when
using KUNIT_CASE_PARAM() to write the tests.

This can be observed by patching fs/ext4/mballoc-test.c to fail
and print one of the params:

--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -350,6 +350,8 @@ static int mbt_kunit_init(struct kunit *test)
        struct super_block *sb;
        int ret;

+       KUNIT_FAIL(test, "Failed: blocksize_bits=%d", layout->blocksize_bits);
+
        sb = mbt_ext4_alloc_super_block();
        if (sb == NULL)
                return -ENOMEM;

With the above change, we can observe the following output (snipped):

[18:50:25] ============== ext4_mballoc_test (7 subtests) ==============
[18:50:25] ================= test_new_blocks_simple  ==================
[18:50:25] [FAILED] block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
[18:50:25]     # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/mballoc-test.c:364
[18:50:25] Failed: blocksize_bits=12
[18:50:25] [FAILED] block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
[18:50:25]     # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/mballoc-test.c:364
[18:50:25] Failed: blocksize_bits=16
[18:50:25] [FAILED] block_bits=16 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
[18:50:25]     # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/mballoc-test.c:364
[18:50:25] Failed: blocksize_bits=10
[18:50:25]     # test_new_blocks_simple: pass:0 fail:3 skip:0 total:3
[18:50:25] ============= [FAILED] test_new_blocks_simple ==============
<snip>

Note that the diagnostic logs don't show up correctly. Ideally they
should be before test result but here the first [FAILED] test has no
logs printed above whereas the last "Failed: blocksize_bits=10" print
comes after the last subtest, when it actually corresponds to the first
subtest.

The KTAP file itself seems to have diagnostic logs in the right place:

KTAP version 1
1..2
    KTAP version 1
    # Subtest: ext4_mballoc_test
    # module: ext4
    1..7
        KTAP version 1
        # Subtest: test_new_blocks_simple
    # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/mballoc-test.c:364
Failed: blocksize_bits=10
        not ok 1 block_bits=10 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
    # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/mballoc-test.c:364
Failed: blocksize_bits=12
        not ok 2 block_bits=12 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
    # test_new_blocks_simple: EXPECTATION FAILED at fs/ext4/mballoc-test.c:364
Failed: blocksize_bits=16
        not ok 3 block_bits=16 cluster_bits=3 blocks_per_group=8192 group_count=4 desc_size=64
    # test_new_blocks_simple: pass:0 fail:3 skip:0 total:3
    not ok 1 test_new_blocks_simple
    <snip>

By tracing kunit_parser.py script, I could see the issue here is in the
parsing of the "Subtest: test_new_blocks_simple". We end up associating
everything below the subtest till "not ok 1 block_bits=10..." as
diagnostic logs of the subtest, while these lons actually belong to the
first of the 3 subtests under this test.

I tired to figure out a way to fix the parsing but fixing one thing
broke something else. Im starting to think that the issue is that there
are 3 subtests under test_new_block_simple (array of 3 params passed to
KUNIT_CASE_PARAM), but instead of creating 3 structured subtests, the
KTAP output dumps the results of all 3 directly under
subtest:test_new_blocks_simple. Which makes it tricky to determine where
the diagnostic log/attributes of test_new_blocks_simple ends and that of its
children begins.

I'm not very familiar with KUnit framework so I though I'd reach out
here for some pointers. I can dedicate some time fixing this but I'd
like to know if this is something we need to somehow fix in parsing or
during generation of the KTAP file itself? Any pointers would be
appreciated.

Thanks,
Ojaswin


