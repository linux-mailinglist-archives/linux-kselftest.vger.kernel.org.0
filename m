Return-Path: <linux-kselftest+bounces-28323-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A89F2A50624
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 18:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7281888614
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 17:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4053C1AAE2E;
	Wed,  5 Mar 2025 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="av0yX+lz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B381A704B;
	Wed,  5 Mar 2025 17:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194875; cv=none; b=XiIjIbq1X7sdlhV+1+vf90Yvl5uW158yCC/ZUhDmlwzgWPbhMSMmO9Bfni4pxi2dDWkm2JVbvrVVGhNC5VHy9lDZz1noaLKM4saTj1WzbTAN/c3TyKvmqzy9PrvgnxjPHexZzk1WQrqcugkprkwbBc8Ub2f9RPb4v4PYKySsDK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194875; c=relaxed/simple;
	bh=ER5oulteCDl6wDTtHmCSPNKknH6p6kdvj7AyoPej/mY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZCphkVsl+ZJBQUFk/37+tOjGUBmXRNaQauFpBQl0oIRVa1GIlUdfcVkYV/CwXVOBMYBtFZz3Gv8Ehk3K4MLk4kDM2E6fkUstoSWk8VbM6OprpZ6t60pRDw/WKA+zS6spoSg8xTBea41LosaM6W3uLOwRN34ofWPuR7vJD2R8YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=av0yX+lz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5258sedl013361;
	Wed, 5 Mar 2025 17:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=NzbcOXyS8UccSas1swTtUVMBhrgYbM34S6IP2OcG1
	rY=; b=av0yX+lzK/CeFFjnC5tmbETH+aHVAS5BXUSp90uGop1c6PO3VgZojotMH
	FCmxt1vd5hmL6NKNnGQhuHEbfYjMs8DPqvYmVSzflWVjymCUzvtX600/x1/acDMI
	FqPwmzpvdOhsuDhr+HTsQkI7rfPFPF4RrUDGPGrdbFxcc/mrrOKxzmoa1X4fd++E
	1MDa/3fC0Mcldj1JX8laMkvdH034PDxYQP6A6sVFm+y8//Jy3KyULVe/Qx80mz9w
	n6rQ0WEnt5IKxETApYKAfbXL8VJjWg/LYJ1utvmbLpe+9GK7aWqNGqQhjcghnSeS
	in7ci+y+SP4Yz9XvOhHagMRKR63uA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4568r0mwp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 17:14:07 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 525Gu9Wr001625;
	Wed, 5 Mar 2025 17:14:06 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4568r0mwp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 17:14:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 525GRvpE020794;
	Wed, 5 Mar 2025 17:14:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 454esk3je9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 17:14:05 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 525HE4GI29033014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 17:14:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09D0620043;
	Wed,  5 Mar 2025 17:14:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C526620040;
	Wed,  5 Mar 2025 17:13:59 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.4.86])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Mar 2025 17:13:59 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ast@kernel.org, hbathini@linux.ibm.com, andrii@kernel.org,
        aleksander.lobakin@intel.com, daniel@iogearbox.net,
        davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org
Subject: [PATCH v2 0/2] Fix xdp_adjust_frags_tail_grow selftest on powerpc
Date: Wed,  5 Mar 2025 22:43:54 +0530
Message-ID: <cover.1741188826.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iXc6f4iUsoASucweQROor_1hkQicFAOK
X-Proofpoint-ORIG-GUID: R-X5-IYHLD7Lx-yb13QitYIRMLBdFPcp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_07,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503050130

For platforms on powerpc architecture with a default page size greater
than 4096, there was an inconsistency in fragment size calculation.
This caused the BPF selftest xdp_adjust_tail/xdp_adjust_frags_tail_grow
to fail on powerpc.

The issue occurred because the fragment buffer size in
bpf_prog_test_run_xdp() was set to 4096, while the actual data size in
the fragment within the shared skb was checked against PAGE_SIZE
(65536 on powerpc) in min_t, causing it to exceed 4096 and be set
accordingly. This discrepancy led to an overflow when
bpf_xdp_frags_increase_tail() checked for tailroom, as skb_frag_size(frag)
could be greater than rxq->frag_size (when PAGE_SIZE > 4096).

This change fixes:

1. test_run by getting the correct arch dependent PAGE_SIZE.
2. selftest by caculating tailroom and getting correct PAGE_SIZE.

Changes:
v1 -> v2:
   * Address comments from Alexander
      * Use dynamic page size, cacheline size and size of
        struct skb_shared_info to calculate parameters.
      * Fixed both test_run and selftest.

v1: https://lore.kernel.org/all/20250122183720.1411176-1-skb99@linux.ibm.com/

Saket Kumar Bhaskar (2):
  bpf, test_run: Replace hardcoded page size with dynamic PAGE_SIZE in
    test_run
  selftests/bpf: Refactor xdp_adjust_tail selftest with dynamic sizing

 .../bpf/prog_tests/xdp_adjust_tail.c          | 160 +++++++++++++-----
 .../bpf/progs/test_xdp_adjust_tail_grow.c     |  41 +++--
 2 files changed, 149 insertions(+), 52 deletions(-)

-- 
2.43.5


