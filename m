Return-Path: <linux-kselftest+bounces-30474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4B8A8405C
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 12:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B79B9E2EAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 10:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8160F26B2A8;
	Thu, 10 Apr 2025 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="omPmcXAw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACE32673B7
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Apr 2025 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744279699; cv=none; b=ZI0vgwIN1L0zyEeMujvRy6DOtPHHIbVsHZEoIxonV42KgEE7audzf1SRaoZVRF02a7ZqxNFRdx3N82kdkP1ZP8NB5Fkkc1Qii/kKbsIKwV53UCWaodGd1nwg1/Z412ZUEteekM2ZFrLrKwpuuIHUfHDe/IY2JiUWj0aWBgj1/6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744279699; c=relaxed/simple;
	bh=ehCJL7O2VRwh6DBSRrwmosVFJbVgOyK3q6wvb8j9QFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GCRi3pEd5b2QGazFUiBtwi6Fj/IcGM09+2KAW+fxMu2vDJhfRkUhvELjIyVBO4m6uQnMyAssffCzlH0M8bWCcKWeDQNYgSl+G6ByrE4gBNCI+Mw2UxgE6o9ZKSR14hRda4Wrk/IFSBAaUDfF/yI7i4Ik6YeKIyzBCYoxA/3EtJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=omPmcXAw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A68Gpt022700;
	Thu, 10 Apr 2025 10:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=pk1XLmgBq5xVToKFE3tfnSHSmedA9cTbuIOl31OV7
	78=; b=omPmcXAwAfiinxNP46AHR+Fp4sR+ximIsxnQfx6n6+buFUHYF+0c4v9bF
	XB0IkiG9DgjDvrK1i9qi9QSUzCkaOQ3jeKJYs0POA+OVOMJEWTD4glbcuKZAIvfi
	gf0mN1zYgsg4iAd57as0Y5muorxoF4ItAt2kva+HDK1y05QhrrvLt43QPopPL4uh
	ZFXA9ca+O+87B3HEcwAiJZoORX0j0VF0xbJxkn5MBTdkbmcVY40CjK11cB1b+S3v
	6XbPuiWOKTiHxwlocHCvY5yWuuoRa6G7KRhf5yC9XcLzTLpXuaYPdsu8+choUKDi
	HejANgYofpGnXvLicfb63oG8LC+hg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45x02qbyv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 10:08:03 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53A9tCFQ009615;
	Thu, 10 Apr 2025 10:08:03 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45x02qbyv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 10:08:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53A8VZUM025518;
	Thu, 10 Apr 2025 10:08:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ugbm5f1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 10:08:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53AA808U60359016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 10:08:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8822A2006A;
	Thu, 10 Apr 2025 10:08:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 409C520067;
	Thu, 10 Apr 2025 10:07:59 +0000 (GMT)
Received: from ltcden14-lp2.aus.stglabs.ibm.com (unknown [9.53.174.194])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Apr 2025 10:07:59 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, longman@redhat.com,
        Li Wang <liwang@redhat.com>, Donet Tom <donettom@linux.ibm.com>
Subject: [PATCH] selftests/mm: Restore default nr_hugepages value during cleanup in hugetlb_reparenting_test.sh
Date: Thu, 10 Apr 2025 05:07:48 -0500
Message-ID: <20250410100748.2310-1-donettom@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jE3lAz9X2QBh8-c-E2MYiYz_Zv8i7byW
X-Proofpoint-ORIG-GUID: CYIl7eGH620ENht-QvGtXimSVd7UFAvw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_01,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=919 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504100074

During cleanup, the value of /proc/sys/vm/nr_hugepages is currently
being set to 0. At the end of the test, if all tests pass, the
original nr_hugepages value is restored. However, if any test fails,
it remains set to 0.

With this patch, we ensure that the original nr_hugepages value is
restored during cleanup, regardless of whether the test passes or fails.

Fixes: 29750f71a9b4 ("hugetlb_cgroup: add hugetlb_cgroup reservation tests")
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 tools/testing/selftests/mm/hugetlb_reparenting_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
index 11f9bbe7dc22..114875a2b018 100755
--- a/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
+++ b/tools/testing/selftests/mm/hugetlb_reparenting_test.sh
@@ -56,7 +56,7 @@ function cleanup() {
   rmdir "$CGROUP_ROOT"/a/b 2>/dev/null
   rmdir "$CGROUP_ROOT"/a 2>/dev/null
   rmdir "$CGROUP_ROOT"/test1 2>/dev/null
-  echo 0 >/proc/sys/vm/nr_hugepages
+  echo $nr_hugepgs >/proc/sys/vm/nr_hugepages
   set -e
 }
 
-- 
2.47.1


