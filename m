Return-Path: <linux-kselftest+bounces-2080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF0A814C99
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 17:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C921F22E50
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E50E3BB27;
	Fri, 15 Dec 2023 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N62UDXB7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDD33A8FA;
	Fri, 15 Dec 2023 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFFKRBS022046;
	Fri, 15 Dec 2023 16:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=wmAUk/vTF+5Nn1KK9suFd2BGYlSFrE/EsVXvj0c5NBE=;
 b=N62UDXB7gU3t1z6zfhUskS5mDL0zXUYJ87ez/vQTGkUITGkZmYJWpinvO4DVnbQG3Kt2
 XkvqnfL1OPz5G9T/k0hRGudJTIn87UbbqgXe8wdLWCq2CRhn5K2bDAy2qpSg7Yh7+cSK
 3Ygw0uHBdQpPFqVQ5pkDUpmumGa1CGxh9gYr/z4LOyzZ5k+khKZMq1jn4gaq+zpKw2fI
 XX+81dKWc4dM7p9qA3Nj7tGYr9dn6k8TXJjtlCnwQog6omV9vWAcgq8gURHGRMyInA65
 nS90UVJWK4aJgGYdbWEH4deMOdZ4iEdj1SYrRJwaYuVjAXhihszHUGYW4RqSG3Wz0Q/B 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0reku5qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 16:11:32 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BFFlkiX010155;
	Fri, 15 Dec 2023 16:11:32 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0reku5qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 16:11:32 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFE9QRF012699;
	Fri, 15 Dec 2023 16:11:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw3jph59y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 16:11:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BFGBSIL42140308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 16:11:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2500020040;
	Fri, 15 Dec 2023 16:11:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D884520043;
	Fri, 15 Dec 2023 16:11:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Dec 2023 16:11:27 +0000 (GMT)
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: s390: selftest: memop: Fix undefined behavior
Date: Fri, 15 Dec 2023 17:11:25 +0100
Message-Id: <20231215161125.943551-1-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7IcDHKpNCswVDGbXMLYTUO2nGCw_s9Ta
X-Proofpoint-GUID: NSSmaOt_irSiAKvDhBsP_AhVSPfMJKHH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 adultscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312150111

If an integer's type has x bits, shifting the integer left by x or more
is undefined behavior.
This can happen in the rotate function when attempting to do a rotation
of the whole value by 0.

Fixes: 0dd714bfd200 ("KVM: s390: selftest: memop: Add cmpxchg tests")
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/memop.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index bb3ca9a5d731..2eba9575828e 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -485,11 +485,13 @@ static bool popcount_eq(__uint128_t a, __uint128_t b)
 
 static __uint128_t rotate(int size, __uint128_t val, int amount)
 {
-	unsigned int bits = size * 8;
+	unsigned int left, right, bits = size * 8;
 
-	amount = (amount + bits) % bits;
+	right = (amount + bits) % bits;
+	/* % 128 prevents left shift UB if size == 16 && right == 0 */
+	left = (bits - right) % 128;
 	val = cut_to_size(size, val);
-	return (val << (bits - amount)) | (val >> amount);
+	return (val << left) | (val >> right);
 }
 
 const unsigned int max_block = 16;

base-commit: 305230142ae0637213bf6e04f6d9f10bbcb74af8
-- 
2.40.1


