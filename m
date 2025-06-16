Return-Path: <linux-kselftest+bounces-35092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B39ADB62B
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F25C97A9EBC
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C969A286417;
	Mon, 16 Jun 2025 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S0PEOhi7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353FB216E26;
	Mon, 16 Jun 2025 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090031; cv=none; b=gWKkZKhphD+z4rjpkvaIVPrxAD75NglpH893NN6crAY5ws4bactBJoM+CnoR7KKT2WPP89sPFWyiQhZtr4lUqShwhkd5nlr8UabCQE44vmb90dKx4gZISKEI+F634onm2A9sRt951wIxWDK9jnFnA531lubWRD4SquZpONat/VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090031; c=relaxed/simple;
	bh=N3+w7YRiWNSYjXfkzMcJUCIjuAfRuZULI8CJX32v8Mg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kh915MbuSr9HKRqbZkadt5sKo5ZT8fSkl3BDGXXpR9sJl39TZ3uT+c39BSNVtgtwMovadtWzg6wfVxLymLmuuU9dJjc5URH/zAmMzFlMBk8j9DFn5IJsGbBWxdhq87z2Ae6RYrVyy+VQdXWCi9JVN1q4FcHP7PQJB68o2Tow1lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S0PEOhi7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GF04OW004256;
	Mon, 16 Jun 2025 16:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=I6tpdeq6gAbNR7xr7dzlEkuLfK7b1b6RfYKjOPqWj
	Hg=; b=S0PEOhi7NkolxOg84i7V2oNTwFW8Jd8FD2tbxqRH0OZ4bOKbGNCXdYrdS
	pziPD77tN343Febgnk4CPKlOLQsOhvCBj7cQSoc99r71DaCZMasUTNiene91k5j4
	dRctiUUUQCWBquIiHM/NLB/k4UsS8w7N19CbYaYwTM0T8LSKSevzb2F58xxgqU5z
	7wLgOS5mJzKGwfmjoBKjbCDM+q6bZSeIAZ5sVfNkZdnkDKcEuqQqad6rfUMgWq6h
	q5gwOieVOKdTZ8WUVydjD4syW+moUs0BBvwOF4FeSVMfdZ69zlPk04uzMp5YyZbk
	PV3is+96YUwTHXVVtaIXFFemnHUiA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygn2vrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 16:06:45 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55GG2J5w001796;
	Mon, 16 Jun 2025 16:06:45 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygn2vr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 16:06:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55GDL38C005492;
	Mon, 16 Jun 2025 16:06:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mwkxtg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 16:06:44 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55GG6e8p24707822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 16:06:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CF4920043;
	Mon, 16 Jun 2025 16:06:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AD9E20040;
	Mon, 16 Jun 2025 16:06:34 +0000 (GMT)
Received: from li-c18b6acc-24ee-11b2-a85c-81492619bda1.ibm.com.com (unknown [9.43.33.110])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Jun 2025 16:06:33 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Subject: [PATCH 0/6] selftests/mm: Fix false positives and skip unsupported tests
Date: Mon, 16 Jun 2025 21:36:26 +0530
Message-ID: <20250616160632.35250-1-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDEwMiBTYWx0ZWRfX4xEd6FrN0e/r /ltKQUB2w4Fczw3Gh78GdlaJpu7A8woR/RpRv4HZKY3+ZHi72LWxtFVAcZ3wsEgVQjplNeMkwjC p/Z7UhLu+z35vXrezRodLm25KLHklTQllFna5IeflKX+HAwTV33L/y9Onh/bHY4utuB/HLoe1bX
 JJr0YhphTVu9YeyNrtYxy8KPnyW3vnbVs6aW75f8VF08+IaaimEg9Nid+nl6RCeWcCvAwyWSQ7z npB+2+FuMolxGLlowv3y7J0XNavADL3yNTweXGSE/jOiWvCL6/pF7q5N7V4Lu/TiZjyYXOjCStM Gcwj2jPx/A28A4DssFLq/p9b2DOlKhemMZUFK9V5krHcnPZKD8IKVYOQqrolhfQfGcIeNaZDxdg
 llYBmgGyhhYMuP48GKKyeuzmfWr03NuXxApI5U8quZVzeRIr7lGTLgSNWE3C5wbQPyHTZ2Aj
X-Authority-Analysis: v=2.4 cv=fYSty1QF c=1 sm=1 tr=0 ts=68504115 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=6IFa9wvqVegA:10 a=SIVL7P9ECBs5F6Hl04QA:9
X-Proofpoint-ORIG-GUID: 92M_0BToZtZBcQFtkmzxgcKbc4vSdr56
X-Proofpoint-GUID: LKPpOlXkcsJ-F05eAvT-Ci6P3YCXw_80
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160102

This patch series fixes some of the false positives in generic
mm selftests and skips tests that cannot run correctly due to
missing features or system limitations.

Please let us know if you have any feedback.

Thanks,  
Aboorva

Aboorva Devarajan (2):
  selftests/mm: Fix child process exit codes in KSM tests
  selftests/mm: Mark thuge-gen as skipped if shmmax is too small or no
    1G pages

Donet Tom (4):
  mm/selftests: Fix virtual_address_range test issues.
  selftest/mm: Fix ksm_funtional_test failures
  selftests/mm : fix test_prctl_fork_exec failure
  mm/selftests: Fix split_huge_page_test failure on systems with 64KB
    page size

 .../selftests/mm/ksm_functional_tests.c       | 24 +++++++++++++------
 .../selftests/mm/split_huge_page_test.c       | 23 ++++++++++++++----
 tools/testing/selftests/mm/thuge-gen.c        | 11 +++++----
 .../selftests/mm/virtual_address_range.c      | 14 +++--------
 4 files changed, 45 insertions(+), 27 deletions(-)

-- 
2.43.5


