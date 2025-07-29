Return-Path: <linux-kselftest+bounces-38046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF69FB147A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 07:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AB1E7AA748
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 05:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7551E239E81;
	Tue, 29 Jul 2025 05:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="La1wxWKb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA732245000;
	Tue, 29 Jul 2025 05:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753767316; cv=none; b=NHAd1/dD5Nffj24BWHMM7J3yDPJHfeyra+08T/zzwjqJqqRU8PkdUzYn7cDf7U/FbCjY/h/yv8R7fnT2S4UgsZQq97kgHB33XiMOcLdvIMh5W2yNuPJz/gbAN8+4zfwH1Q93sA8PcO9wK/2LHPSqAj+3KFfQOUEhdUA0cDWgVVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753767316; c=relaxed/simple;
	bh=L8yk0I8eEqtNR5+doknF2jsN0wuOs9YnrJPchV+zR4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzQYu1MRV+Xj6AQbZiMEOOPLGVtv8XmswCQ6xtu6oo1Sxxn4c2CcO7A5+cOGjPzIZsZ63dfOSCJb+1HEaGLFhC5mXs7NUf34a1yJWc0EfEhfzsgwD1y9ARcnESJRA70k9JlpeMqcyFVl+6xFDePEgDiaimYCCIkjeEEdwYbquuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=La1wxWKb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T4YwTZ015155;
	Tue, 29 Jul 2025 05:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=I3fCHcP374PKE/USG
	24onJKIBeFDzBfdCxFluw7C2aw=; b=La1wxWKbb6DEVxSeuACr0M4PINjLb9pB+
	gqLbg7u5WqM0nf6JfklDjs89pbmMO5G4BLFVKxrfhj0dXK/3xBkfbKvf4aYxIF2b
	IgliZ2Prf/nMOcWEUwzprfPXrm2jDXsNswJDRnRgfWqN+NRl2SQerQYSbPigevgq
	b+af85lcLUFoBEWjTJ/p+TAAjZV5wqEpEPwiKhSn1cr5pH0MCVz+0mY8AmoYKM+b
	eGZCFtkNzAEORJKGqtesnEg5Fz9gtWXosvnTJB1PDfte0MPXHKl9hHgM4aF5rrlJ
	EfXSPzbU87FOfdxIUGu4Er+gOV7a/+a/hOQQtRGMm8CAe7eyh4tZQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qfqmqcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 05:34:58 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56T5YwVL002054;
	Tue, 29 Jul 2025 05:34:58 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qfqmqcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 05:34:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56T3A7uR017969;
	Tue, 29 Jul 2025 05:34:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4859bth6dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Jul 2025 05:34:56 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56T5YrWu44826976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 05:34:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AEF12004B;
	Tue, 29 Jul 2025 05:34:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A397E20040;
	Tue, 29 Jul 2025 05:34:47 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.150.11.63])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Jul 2025 05:34:47 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Subject: [PATCH v3 7/7] selftests/mm: Skip hugepage-mremap test if userfaultfd unavailable
Date: Tue, 29 Jul 2025 11:04:03 +0530
Message-ID: <20250729053403.1071807-8-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729053403.1071807-1-aboorvad@linux.ibm.com>
References: <20250729053403.1071807-1-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDAzOCBTYWx0ZWRfX5HDTFZBViXsj
 sQriN2PAF/TEQNGcwLEZm7IqyrmlXzJcxAdOixgG6zO2r1Zi+L2F9o2WjlqttnWF++K4/O9JASx
 L5jGUOYYPbNjJ9kVgc9mX6FsdiRpoR2VtaddaptwyxzlMGuh3YbnhkEBHCTswdm5s8YdUIGU/Zt
 0lKVdKwQCaxtGxEdhyM/OasYMOPZ+GjakFJoHW9o21+/HQWuLqa1qiGu32dgzq5KiouD9aCYjy1
 6wJBCsfUTTCZBjgjAVeEsxOy8Ha9It4f7DHkwUCj5FmBkeIBOjTXJVp1fSW2GNacbm3RtFl+OBB
 PX50BRebn6jYFbkLK+SA/0Wkh8vTML0VoCeY1m8wUbIHGlqbecKXnsxkPY7jL5ldytqwQVpOfNK
 Q78woXIYbNWizMmBPvJuN2ZOeW0Vc4czGsUwO0WD0YfXd/H929d4WqHkTBh5bkt27zt3a+0y
X-Authority-Analysis: v=2.4 cv=Je28rVKV c=1 sm=1 tr=0 ts=68885d82 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Wb1JkmetP80A:10 a=20KFwNOVAAAA:8 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8
 a=6zTM3Imc7A7I5ri1M5IA:9
X-Proofpoint-GUID: PKKiQI5cwGNe6XvMWxlnWgNZrfba5Dml
X-Proofpoint-ORIG-GUID: -qUcTG5LhWDqQW1_-b_YoFOsW4noWCr9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_01,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 mlxscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290038

Gracefully skip test if userfaultfd is not supported (ENOSYS) or not
permitted (EPERM), instead of failing. This avoids misleading failures
with clear skip messages.
--------------
Before Patch
--------------
~ running ./hugepage-mremap
...
~ Bail out! userfaultfd: Function not implemented
~ Planned tests != run tests (1 != 0)
~ Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
~ [FAIL]
not ok 4 hugepage-mremap # exit=1

--------------
After Patch
--------------
~ running ./hugepage-mremap
...
~ ok 2 # SKIP userfaultfd is not supported/not enabled.
~ 1 skipped test(s) detected.
~ Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
~ [SKIP]
ok 4 hugepage-mremap # SKIP

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Co-developed-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 tools/testing/selftests/mm/hugepage-mremap.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testing/selftests/mm/hugepage-mremap.c
index c463d1c09c9b..2bd1dac75c3f 100644
--- a/tools/testing/selftests/mm/hugepage-mremap.c
+++ b/tools/testing/selftests/mm/hugepage-mremap.c
@@ -65,10 +65,20 @@ static void register_region_with_uffd(char *addr, size_t len)
 	struct uffdio_api uffdio_api;
 
 	/* Create and enable userfaultfd object. */
-
 	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
-	if (uffd == -1)
-		ksft_exit_fail_msg("userfaultfd: %s\n", strerror(errno));
+	if (uffd == -1) {
+		switch (errno) {
+		case EPERM:
+			ksft_exit_skip("Insufficient permissions, try running as root.\n");
+			break;
+		case ENOSYS:
+			ksft_exit_skip("userfaultfd is not supported/not enabled.\n");
+			break;
+		default:
+			ksft_exit_fail_msg("userfaultfd failed with %s\n", strerror(errno));
+			break;
+		}
+	}
 
 	uffdio_api.api = UFFD_API;
 	uffdio_api.features = 0;
-- 
2.47.1


