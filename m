Return-Path: <linux-kselftest+bounces-23584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAD49F799B
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 11:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A9D16E5B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 10:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43812222591;
	Thu, 19 Dec 2024 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sV4AGMNS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE16222567;
	Thu, 19 Dec 2024 10:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734604059; cv=none; b=cFUnFf3fVcOACnGe/Jqeu3qd4obY9cYFhc+Tfyao+DxGeLUerQ4JjaVa73oldNg7L+0BMj2nQhrMK5Q0+3zyIsXbu/KBOZ5rWatsB/kY+LvwR6utJ3pQz/NcBaP56e+MuE0RsGt4Y/F8yYSI0W0QrB0uOrkNrgzaRKjYBsXuLZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734604059; c=relaxed/simple;
	bh=HDa168BdxQX06ZtiTf8KKlIpYnakwdao496rIRT3w9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fiVRY5DAQS5svawIfbD9MiPVsSDFTXJja0fktaJZhA8dsHMzD6RCMcrXl+8Mzx08uYn33NtrVLbtMjK6ihmjdR745W+qa8yv7FhZM52axpkDaTSI8lAt77N4787olkgS3glyclViU+zGczI3WrX4i3YbgUshDb7SFx2HRMzez84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sV4AGMNS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ0w5RB009282;
	Thu, 19 Dec 2024 10:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=8BdCbc0aWpyGMPoKibD+Rzg4VO7AiW9QJCqyQkaUK
	JI=; b=sV4AGMNSISzEP4hGSkp+agy+gJOn0zA8y+4pXIDw/NZX3k1DgmJoZcTwF
	Oe/aDn5DiIePEx+rLbqKm/BBNekCnfMwOLDHE6f/LWzscSJ7zBZAf1oWz7QpMe1g
	p1joTZos7oAGHsgAjZUgWVxAsIZj/jQl9F32fq9fjeyF8WhAez3UO3kGMjq2Nwcb
	DyIjcwaRpfx+010v8uIICQkzsMiv1BZCzKsQHvCwhqPHDpDICmOB3JVgQmNRE1xJ
	I/BCKsQg3kMR0lqeiG1NtHXPOSWNpsdWOh2Ly1srvQzDTlKabL0p/WLxuMv3KrOR
	T7duYMLD33m2T4dwuVlPujuQ4QqyA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kyv4vvr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 10:27:26 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BJAMphA023538;
	Thu, 19 Dec 2024 10:27:25 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kyv4vvqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 10:27:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ732tv029728;
	Thu, 19 Dec 2024 10:27:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hmbsvwgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 10:27:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BJARNQH55902470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 10:27:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2582220067;
	Thu, 19 Dec 2024 10:27:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9796D20065;
	Thu, 19 Dec 2024 10:27:21 +0000 (GMT)
Received: from ltczz402-lp1.aus.stglabs.ibm.com (unknown [9.40.194.31])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Dec 2024 10:27:21 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        David Hildenbrand <david@redhat.com>, shuah Khan <shuah@kernel.org>,
        Dev Jain <dev.jain@arm.com>
Subject: [PATCH] selftests/mm: Added new test cases to the migration test
Date: Thu, 19 Dec 2024 04:27:20 -0600
Message-ID: <20241219102720.4487-1-donettom@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4VB2ASD33czmFKJnF1RMbaav34FvzEOH
X-Proofpoint-ORIG-GUID: XaV_nVvu-X8CjbA6panhQFhjzWYpS6qW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=827 mlxscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412190080

Added three new test cases to the migration tests:

1. Shared anon THP migration test
This test will mmap shared anon memory, madvise it to
MADV_HUGEPAGE, then do migration entry testing. One thread
will move pages back and forth between nodes whilst other
threads try and access them.

2. Private anon hugetlb migration test
This test will mmap private anon hugetlb memory and then
do the migration entry testing.

3. Shared anon hugetlb migration test
This test will mmap shared anon hugetlb memory and then
do the migration entry testing.

Test results
============
 # ./tools/testing/selftests/mm/migration
 TAP version 13
 1..6
 # Starting 6 tests from 1 test cases.
 #  RUN           migration.private_anon ...
 #            OK  migration.private_anon
 ok 1 migration.private_anon
 #  RUN           migration.shared_anon ...
 #            OK  migration.shared_anon
 ok 2 migration.shared_anon
 #  RUN           migration.private_anon_thp ...
 #            OK  migration.private_anon_thp
 ok 3 migration.private_anon_thp
 #  RUN           migration.shared_anon_thp ...
 #            OK  migration.shared_anon_thp
 ok 4 migration.shared_anon_thp
 #  RUN           migration.private_anon_htlb ...
 #            OK  migration.private_anon_htlb
 ok 5 migration.private_anon_htlb
 #  RUN           migration.shared_anon_htlb ...
 #            OK  migration.shared_anon_htlb
 ok 6 migration.shared_anon_htlb
 # PASSED: 6 / 6 tests passed.
 # Totals: pass:6 fail:0 xfail:0 xpass:0 skip:0 error:0
 #

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 tools/testing/selftests/mm/migration.c | 99 ++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/tools/testing/selftests/mm/migration.c b/tools/testing/selftests/mm/migration.c
index 64bcbb7151cf..1e3a595fbf01 100644
--- a/tools/testing/selftests/mm/migration.c
+++ b/tools/testing/selftests/mm/migration.c
@@ -204,4 +204,103 @@ TEST_F_TIMEOUT(migration, private_anon_thp, 2*RUNTIME)
 		ASSERT_EQ(pthread_cancel(self->threads[i]), 0);
 }
 
+/*
+ * migration test with shared anon THP page
+ */
+
+TEST_F_TIMEOUT(migration, shared_anon_thp, 2*RUNTIME)
+{
+	pid_t pid;
+	uint64_t *ptr;
+	int i;
+
+	if (self->nthreads < 2 || self->n1 < 0 || self->n2 < 0)
+		SKIP(return, "Not enough threads or NUMA nodes available");
+
+	ptr = mmap(NULL, 2 * TWOMEG, PROT_READ | PROT_WRITE,
+		MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	ptr = (uint64_t *) ALIGN((uintptr_t) ptr, TWOMEG);
+	ASSERT_EQ(madvise(ptr, TWOMEG, MADV_HUGEPAGE), 0);
+
+	memset(ptr, 0xde, TWOMEG);
+	for (i = 0; i < self->nthreads - 1; i++) {
+		pid = fork();
+		if (!pid) {
+			prctl(PR_SET_PDEATHSIG, SIGHUP);
+			/* Parent may have died before prctl so check now. */
+			if (getppid() == 1)
+				kill(getpid(), SIGHUP);
+			access_mem(ptr);
+		} else {
+			self->pids[i] = pid;
+		}
+	}
+
+	ASSERT_EQ(migrate(ptr, self->n1, self->n2), 0);
+	for (i = 0; i < self->nthreads - 1; i++)
+		ASSERT_EQ(kill(self->pids[i], SIGTERM), 0);
+}
+
+/*
+ * migration test with private anon hugetlb page
+ */
+TEST_F_TIMEOUT(migration, private_anon_htlb, 2*RUNTIME)
+{
+	uint64_t *ptr;
+	int i;
+
+	if (self->nthreads < 2 || self->n1 < 0 || self->n2 < 0)
+		SKIP(return, "Not enough threads or NUMA nodes available");
+
+	ptr = mmap(NULL, TWOMEG, PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	memset(ptr, 0xde, TWOMEG);
+	for (i = 0; i < self->nthreads - 1; i++)
+		if (pthread_create(&self->threads[i], NULL, access_mem, ptr))
+			perror("Couldn't create thread");
+
+	ASSERT_EQ(migrate(ptr, self->n1, self->n2), 0);
+	for (i = 0; i < self->nthreads - 1; i++)
+		ASSERT_EQ(pthread_cancel(self->threads[i]), 0);
+}
+
+/*
+ * migration test with shared anon hugetlb page
+ */
+TEST_F_TIMEOUT(migration, shared_anon_htlb, 2*RUNTIME)
+{
+	pid_t pid;
+	uint64_t *ptr;
+	int i;
+
+	if (self->nthreads < 2 || self->n1 < 0 || self->n2 < 0)
+		SKIP(return, "Not enough threads or NUMA nodes available");
+
+	ptr = mmap(NULL, TWOMEG, PROT_READ | PROT_WRITE,
+		MAP_SHARED | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	memset(ptr, 0xde, TWOMEG);
+	for (i = 0; i < self->nthreads - 1; i++) {
+		pid = fork();
+		if (!pid) {
+			prctl(PR_SET_PDEATHSIG, SIGHUP);
+			/* Parent may have died before prctl so check now. */
+			if (getppid() == 1)
+				kill(getpid(), SIGHUP);
+			access_mem(ptr);
+		} else {
+			self->pids[i] = pid;
+		}
+	}
+
+	ASSERT_EQ(migrate(ptr, self->n1, self->n2), 0);
+	for (i = 0; i < self->nthreads - 1; i++)
+		ASSERT_EQ(kill(self->pids[i], SIGTERM), 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.37.2


