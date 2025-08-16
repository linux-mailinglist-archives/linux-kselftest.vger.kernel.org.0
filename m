Return-Path: <linux-kselftest+bounces-39134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35637B28A6C
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 06:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C3657A4DA9
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 04:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E94192D68;
	Sat, 16 Aug 2025 04:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UQVUx/s0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E6DFC1D;
	Sat, 16 Aug 2025 04:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755316913; cv=none; b=qQK9ljYpW3mJfhcW6C9WI+jSZUrR15yBxkfTxs8g73M8ERLnOJbKp1dYU9nMDsAUQl766Av71iiKhS2kgOMb4m2ILgHAQfi0Tagg/vtKl5y+O8N+auL3G4SMkD/wcEZc/0lFp7hpjIamN8Tt+3i16E53SgrZzK0nB9Ur4qQafwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755316913; c=relaxed/simple;
	bh=7proIHxW3nLs+X78jXMGNhl7+FH3COcyALFahB8jXEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nlID5WuoEnln57jNSBbn19VfcbsxhZIdttOY2lFJOq3USNkH62BXO/2xkP7iP5Zn+y+dfd3riCcwfwvDvwar8YX2Hf2my7yY8hOT6pd7jfusZdNOlVLGrfHcSec8u0twrA/HH272UWtBqQIh0+aNaYeI+ZHco1Z+034N/IXryfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UQVUx/s0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57G2AAYe029541;
	Sat, 16 Aug 2025 04:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ULVaA8RtCg8Rt4wkESRC4hkPhJHPXvkbBRl57XWyX
	UE=; b=UQVUx/s0XiQArYv2KMH9K9knc1OTAUvR8LUMRMKEPO/VFYps2emw2p7KP
	A84Ulp/8enIDgq7lGxk2PbwTVVhuiSNUt30dmmChsOW4ohVsDTqOcBkV+FQgHy2L
	pc4it5h8hxtk7LJJ0/8S8KdsWktCYLvkNoGi8KcfMJga9kSC/H7KUGzUqS68mDaW
	VHRExzxp0lU6k8wLyTGWGjlKYIklabwjBif1Esw2mEhLn5Quwi8niJBfeo9x0BdE
	Une/VdsQ/NdUjQG66mggZF0tBz+kDJyn63lzBghPxt85WkvPrrUBkyDTvxryfjPZ
	0QSear+zLhIdN8teUN5IvZUOBufFA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jfdrgf6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Aug 2025 04:01:33 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57G41WNL030378;
	Sat, 16 Aug 2025 04:01:32 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jfdrgf6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Aug 2025 04:01:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57G0YZFW026377;
	Sat, 16 Aug 2025 04:01:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48eh21kxnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Aug 2025 04:01:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57G41Srn49283338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Aug 2025 04:01:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AABC2004B;
	Sat, 16 Aug 2025 04:01:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E28620043;
	Sat, 16 Aug 2025 04:01:17 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.36.5.210])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 16 Aug 2025 04:01:16 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org, richard.weiyang@gmail.com
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Subject: [PATCH v4 0/7] selftests/mm: Fix false positives and skip unsupported tests
Date: Sat, 16 Aug 2025 09:31:06 +0530
Message-ID: <20250816040113.760010-1-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8F7Mu2elyPnZERHNYc6ja-6KH8o6w7mi
X-Proofpoint-GUID: 9CNViZUNZ1h3TVDrxEyzmuhfdYVLujRA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAwMSBTYWx0ZWRfXyvAhJj9SVkK6
 32AHfiikHsGKlOwl5GOTOwZMMQOTFDEW458aqYUc84U1y0YtAGgk3E4SQZupG0PMNmMCNND8EXt
 IPo0i34sTp5w2kCq++c0Kp0GO9ity9rNh3DHc10OMPPzL+9TSqOQSnGqfUj3ISGQpOGFFa1iSvX
 JrFlXo6bwvAPU5lD6Gu6AEInJmRnvkYnpgM5JgG8NjmDpjSacH8tDZFyo0/8DOUw2he3wjQiXEJ
 +M58UZRBR4VIcX1ZwRZp2MhCXccn5LHpqfMCMxvkwTGntqHx6ZV7i3wF3uDe/aSV/xR3cd2J7B0
 y7+d8tqsJfEuaegLu497MZVXkgLtpQ5O3FbhpB+w1p5GeMPkOtQ5lNsISE8mdMCJgNQzKLeB9QB
 CgPPwxVr
X-Authority-Analysis: v=2.4 cv=GotC+l1C c=1 sm=1 tr=0 ts=68a0029d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=lqfGnVuM_wKh1zUdGBEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160001

Hi all,

This patch series addresses false positives in the generic mm selftests
and skips tests that cannot run correctly due to missing features or system
limitations.


v3: https://lore.kernel.org/all/20250729053403.1071807-1-aboorvad@linux.ibm.com/

Changes in v4:

  - Rebased onto the latest mm-new branch, top commit of the base is commit 916e1f041670 ("drivers/base: move memory_block_add_nid() into the caller"). Dropped the v3 patches that had already been merged and re-applied them to the mm-new branch.
  - Only Patch 4 is updated to address review comments, all other patches remain unchanged from v3.

--- 

v2: https://lore.kernel.org/all/20250703060656.54345-1-aboorvad@linux.ibm.com/

Changes in v3:

  - Rebased onto the latest mm-new branch, top commit of the base is commit 0709ddf8951f ("mm: add zblock allocator").
  - Minor refactor based on the review comments.
  - Included the tags from the previous version.

---

v1: https://lore.kernel.org/all/20250616160632.35250-1-aboorvad@linux.ibm.com/

Changes in v2:

   - Rebased onto the mm-new branch, top commit of the base is commit 3b4a8ad89f7e ("mm: add zblock allocator").
   - Split some patches for clarity.
   - Updated virtual_address_range test to support testing 4PB VA on PPC64.
   - Added proper Fixes: tags.
   - Included a patch to skip a failing userfaultfd test when unsupported,
     instead of reporting a failure.

---

Please let us know if you have any further comments.

Thanks,
Aboorva

Aboorva Devarajan (3):
  selftests/mm: fix child process exit codes in ksm_functional_tests
  selftests/mm: skip thuge-gen test if system is not setup properly
  selftests/mm: skip hugepage-mremap test if userfaultfd unavailable

Donet Tom (4):
  mm/selftests: Fix incorrect pointer being passed to mark_range()
  selftests/mm: Add support to test 4PB VA on PPC64
  selftest/mm: Fix ksm_funtional_test failures
  mm/selftests: Fix split_huge_page_test failure on systems with 64KB
    page size

 tools/testing/selftests/mm/cow.c              |  5 ----
 tools/testing/selftests/mm/hugepage-mremap.c  | 16 +++++++++--
 .../selftests/mm/ksm_functional_tests.c       | 28 +++++++++++++------
 .../selftests/mm/split_huge_page_test.c       | 22 +++++++++------
 tools/testing/selftests/mm/thuge-gen.c        | 11 +++++---
 tools/testing/selftests/mm/uffd-wp-mremap.c   |  5 ----
 .../selftests/mm/virtual_address_range.c      | 13 ++++++++-
 tools/testing/selftests/mm/vm_util.h          |  5 ++++
 8 files changed, 71 insertions(+), 34 deletions(-)

-- 
2.47.1


