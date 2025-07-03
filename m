Return-Path: <linux-kselftest+bounces-36390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEFBAF6A0A
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 08:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFDA817E38C
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 06:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7E721B19D;
	Thu,  3 Jul 2025 06:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mJ8tID+X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9A42DE6FC;
	Thu,  3 Jul 2025 06:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751522848; cv=none; b=Vof/lxgk/NBOKTcY3RZjYYT024aQg6PCOPClKyhLDrggBbYayUomUh8qlUEc7nwLYegEleEvStwriB2cad1Uqt9rgHak4Yi8s1YRm6x8KhibFKSFaefGRrN3UK3zjBM1yam6ICdVGxLp+h3N5x1PILtviliiQM78+aS/8TOdvdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751522848; c=relaxed/simple;
	bh=XsgDTHcbSlmeQChwCzbs2AReVe7lCNdaxsr0q+t/2oU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f6w7de7JoiiIL2tAGYxNJTOAQtWRat6aMxceC5pAn9vdRSM9n6UwZ2iu9s2U+tywAwCcILrNEOFcETiRZrsq9oQ/UWmXOWedDrq7sufOrC58DW3CSDXXeV62qG/tsV/QI5v2LtKIzsGUFS6P+bTjcRhjfkWepomp3UAExgh7gUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mJ8tID+X; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5630THLw017214;
	Thu, 3 Jul 2025 06:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=/pMWTm8f8FZgAt9g8Eu/ILN53nm+DEE9jHHb93yqR
	d0=; b=mJ8tID+XZD4xa35IcnEejVwLnPg1HxSVBWunwBFYQWNn/WqPOMeBJ0iGt
	0k9YdPnoXsNNCjpYdMnedSM4gByhdLNr8OejiUGc9GvYFxOQT2ouFZX9c2pE2nbZ
	HG5vTRiW9k+G9jXsj6DJhvYfAq07aDbhQ/98QAdEcyD2MyH/i0jmCXe8UtVOh2lL
	Dqw8R/LwVf30G/gqpqwoD0+qU/n/2QC1wZZ+hJirm3JFBlFL8ZghcNUAJMcgqaRr
	NxKdiu0bHoy96RSfQk+e/oMu6dSvzz4q+6eNUQetMeSlQe1fdmz5oG06TeYqlyQ0
	SZxfPOCUiUxPuxkuWDddx8q5b5pGQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84dhte4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 06:07:11 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56366fsn025629;
	Thu, 3 Jul 2025 06:07:10 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84dhte1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 06:07:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56366HOh021934;
	Thu, 3 Jul 2025 06:07:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47juqpuam8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 06:07:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 563675Jo44106028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Jul 2025 06:07:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C1352004B;
	Thu,  3 Jul 2025 06:07:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 206A720040;
	Thu,  3 Jul 2025 06:06:59 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.39.26.205])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Jul 2025 06:06:58 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Subject: [PATCH v2 0/7] selftests/mm: Fix false positives and skip unsupported tests
Date: Thu,  3 Jul 2025 11:36:49 +0530
Message-ID: <20250703060656.54345-1-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8Hu9LyLRjwpLLDRkQebWrbLMsNEpGni9
X-Proofpoint-GUID: U3JNq0F97USW9t6aRqiOWSDzw5Mxr1-t
X-Authority-Analysis: v=2.4 cv=Ib6HWXqa c=1 sm=1 tr=0 ts=68661e0f cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=c5YA-QwSPcc6PC69QzEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDA0NCBTYWx0ZWRfX0dDupjziPlRO 7wV7gvl88Fm9Gn9o5WD2NqTGjU3+zXQileHjlI4Jg3R7iyrEV9Su+W2s2RyMlC6upNBjjeTcHqO 3/inT8WffvSV8lMeJjdOqosU+la1Pst20p4Z35zWWmVGjgoAqG61K6qsCl+DglgAe2LlXaz7pe9
 4JsrVbu6BnRaFwF7dTjtAd8glk0km7IJdioskTxvyVYS1Yik8RfE97br4twCUBxODfF2oIrvIIg NJnGGtE6ToJDDFiFvqMvFCvvzgayttmk5MdP/K7knX88sntszEKA8mTKeWveJFTy30VvtH8LwCZ VRnZRBhr0hzip5sd4cu8Nr+cTLXM8R/yZ6+XPINRPcfdkYOghK36KzN1Uq2iJWj8eYyg0o8L/Nq
 +nMEhUVTHVmS6FL1wXwd0tnrWm5yh8iTvKofPEETMWyYfqIajgI/kFNoRB4hD9VeE/NYskLY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_01,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030044

Hi all,

This patch series addresses false positives in the generic mm selftests
and skips tests that cannot run correctly due to missing features or system
limitations.

---

v1: https://lore.kernel.org/all/20250616160632.35250-1-aboorvad@linux.ibm.com/

Changes in v2:

   - Rebased onto the mm-new branch, top commit of the base is 3b4a8ad89f7e ("mm: add zblock allocator").
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
  selftests/mm: Fix child process exit codes in ksm_functional_tests
  selftests/mm: Skip thuge-gen if shmmax is too small or no 1G huge
    pages
  selftests/mm: Skip hugepage-mremap test if userfaultfd unavailable

Donet Tom (4):
  mm/selftests: Fix incorrect pointer being passed to mark_range()
  selftests/mm: Add support to test 4PB VA on PPC64
  selftest/mm: Fix ksm_funtional_test failures
  mm/selftests: Fix split_huge_page_test failure on systems with 64KB
    page size

 tools/testing/selftests/mm/hugepage-mremap.c  | 16 ++++++++++---
 .../selftests/mm/ksm_functional_tests.c       | 24 +++++++++++++------
 .../selftests/mm/split_huge_page_test.c       | 23 +++++++++++++-----
 tools/testing/selftests/mm/thuge-gen.c        | 11 +++++----
 .../selftests/mm/virtual_address_range.c      |  8 ++++++-
 5 files changed, 61 insertions(+), 21 deletions(-)

-- 
2.43.5


