Return-Path: <linux-kselftest+bounces-38039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3031FB1479B
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 07:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A1B17268D
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 05:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF7F234964;
	Tue, 29 Jul 2025 05:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OI/gnrMH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B0586250;
	Tue, 29 Jul 2025 05:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753767275; cv=none; b=Tkn7lF2hNSFgjn/XE6kUY+b+GTg7onebi1CQFgz3x9MyVGOXT/+4KPzHtW0U9MCL6TfYzigMFL0vDGppjhvaBGHF1FauhS+ssVtrhSWFlOn7FsMS9EpaxohlY1qSpBR4CFpQdp+WvtzFWxx5NJIiFENoNX0p6G9Ibh0nkSYEclI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753767275; c=relaxed/simple;
	bh=E6bO+NN4m7iteU5PTu8cUKpjoqYLZ+L3iL28EY+wspA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mGSVlqR2GC55vCdue88LuXwH9XOmulRg9JVlcKuVkKz/Jt/5ZaoHB8Bj8bZwXeL87fXQVMtFc9dUiZy9bAM8RbNG+zCpeW+ZvQnkO/uuQcuK+i+2/gdHjjCseLG/AkAncggLL6/uXTtxzTS178Ds8QZQNffm7dCPLkAND8czeRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OI/gnrMH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T4ZPIk015929;
	Tue, 29 Jul 2025 05:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=BzKXBqbp/faCAopeARB3w/J9fSxnLWo9rSJqyHdAM
	3o=; b=OI/gnrMHKGpSl8VLpprhPuUyTh6AUHfZENXhFs8AwYabXqP90KbxrrI3E
	l7v/RuzDAaiOrHvONgIA6xqBQOBN3aZSjme44it9kYzaMPhlAGo3NoPWHw+pj9vO
	r3M/6k4nHXPn66k7tdDJOzzC/5jrYh6ghmWqrUeRKHgrQjpmxSo7dkV2/BiPWG6b
	TJ/5L1VhjEfKnWK0SlWr1tsb8d3W8k1Sy6inVjCCLCl0DgaR0NdHts87gyiFS8Kw
	XLDUync5KlOfjRhRtzV+EAMGEOJgdlVodiJKFN6JR0LiTm6ljJ9RD0C4p8cXubfh
	L6WHFDw/yPnEz1kR9fhn3Hl/+TWZQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qfqmq5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 05:34:16 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56T5YFFs000501;
	Tue, 29 Jul 2025 05:34:15 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qfqmq5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 05:34:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56T4JAqa015952;
	Tue, 29 Jul 2025 05:34:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 485aumgws4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 05:34:14 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56T5YABO48693738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 05:34:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1668720043;
	Tue, 29 Jul 2025 05:34:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED14F20040;
	Tue, 29 Jul 2025 05:34:04 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.150.11.63])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Jul 2025 05:34:04 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Subject: [PATCH v3 0/7] selftests/mm: Fix false positives and skip unsupported tests
Date: Tue, 29 Jul 2025 11:03:56 +0530
Message-ID: <20250729053403.1071807-1-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDAzOCBTYWx0ZWRfX8hAUANN1wq0Z
 xjxSK5pUzlUOHIJMn+FZmhiDfOiCRFV0Ms/uKu8pUVh2GQaUmxXR32fVKo3xutEG7BupHvFB9OM
 4SRVAOi9Yz2ZGZ3fSkY1Ofag02wV+E4PB9QLO15bUG2f6i69SHZEVN1cp8E/G/dQZWyj8MiQGKs
 aoNrEBRoj5wZCU1hbelEXyzXbX6FJyL7gvHYyHXoSrBNsALALPewKbIftu+2KZQobJVKYYaIPhX
 QnjbZRtjpc+Jzkk3DA7p4/uFKG23qzY9ZOe4wBq9QT8T3Cw9K+Tctct9mrBEer6O8CN5lU/nNdG
 wRTnFt1VlIcM2WtFUqFYb5s05I56EYQSo9dlDPuQu/n3AHGbfEyzTze/n2PnX9W7m1ze3AQgzBg
 aKvvnzt06OqMAaVljKi2yieAaV6HNoezxJ9X05nAuZ8WEfHtV2qJu1PhXHFq6PVtKhNIUfW8
X-Authority-Analysis: v=2.4 cv=Je28rVKV c=1 sm=1 tr=0 ts=68885d58 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=irm_vNLxJShBRlos8zwA:9
X-Proofpoint-GUID: pw61ZIEWy7RakHmY0YtrLFjMg38otVvq
X-Proofpoint-ORIG-GUID: fqFVTppS9lOwJEJZYn1nMtUcYHS1_3iu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_01,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 mlxscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290038

Hi all,

This patch series addresses false positives in the generic mm selftests
and skips tests that cannot run correctly due to missing features or system
limitations.


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
  selftests/mm: Fix child process exit codes in ksm_functional_tests
  selftests/mm: Skip thuge-gen test if system is not setup properly
  selftests/mm: Skip hugepage-mremap test if userfaultfd unavailable

Donet Tom (4):
  mm/selftests: Fix incorrect pointer being passed to mark_range()
  selftests/mm: Add support to test 4PB VA on PPC64
  selftest/mm: Fix ksm_funtional_test failures
  mm/selftests: Fix split_huge_page_test failure on systems with 64KB
    page size

 tools/testing/selftests/mm/hugepage-mremap.c  | 16 +++++++++--
 .../selftests/mm/ksm_functional_tests.c       | 28 +++++++++++++------
 .../selftests/mm/split_huge_page_test.c       | 23 +++++++++------
 tools/testing/selftests/mm/thuge-gen.c        | 11 +++++---
 .../selftests/mm/virtual_address_range.c      | 13 ++++++++-
 5 files changed, 67 insertions(+), 24 deletions(-)

-- 
2.47.1


