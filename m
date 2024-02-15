Return-Path: <linux-kselftest+bounces-4814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CABE856EE8
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 21:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42D92885D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 20:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6512213B2AB;
	Thu, 15 Feb 2024 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g/HRHtMr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0E313AA41;
	Thu, 15 Feb 2024 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708030437; cv=none; b=PL3KmKRDkpbgvGblobfhdlAIuqguF/6IujxhCYam95eb0xaOQN2hh6B8n0k9HhdqpxEaycYZHvjPsgoxWH+Nrc+bEblCnq3oRfoCrXSfXFDIctU7hb4TcG/g7vXdAi++Qaq5NMbR4Oa1UzTQbVJBtr14Di/G8lfdtW/PafGxCEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708030437; c=relaxed/simple;
	bh=wFHRWFNDjByZdkECXDT5AIayYLGLuLsqg4VpCTDXaxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mUAfjOmVLoF8aZnh5JNwl+9t9W+i58104Q8v6Lt0U+0tQbV9Qrlm+gpehSc2Um7sGtXILEAa1vBJpbdSp1cJ2npwPOJwQrP5zMuy0tTXRkS/2wjex93XT6yp3+nbiQiE5ztrRpB38e5jIjL5VIbLiMwUv0K2WBamigdDxxGipXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g/HRHtMr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FK0xwu022048;
	Thu, 15 Feb 2024 20:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=naSuFLOBCRRosC0sA+aZ1BhtQ2Dg+R11DdlDmvqw/e4=;
 b=g/HRHtMru8XRydjbuofVyRwLgOX5KtVrIsP8/xWU3kjO/0SdSSHQYIA1xpCdjuXEUFeP
 puwW6oY7STMSa2CnLvg7sb9fWJgr40eCfgJNtCN0MTyv73tLBOs7Sb2aZab08C20lKsP
 OueyiOQAvKhh+REuho8wZ9EadA7HyXbbflQ+YkkmE/wg/UEkJhBsxZi5kw0NTwCKcOcy
 eOrSM+wB/AqECsx/T8VVpY+byBZCngMFHVuqTAkKvJJYcMQ8U2D1rOYdHBc9bRpWKM4o
 MNCJAV1lg+iogyEXsCe++Z60plU2P9DHf9faNWCK1jXpTgrZI0AXZf+0BNK4eX0n7jNu YA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9ruqhk7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 20:53:53 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FKZFg3010104;
	Thu, 15 Feb 2024 20:53:52 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9ruqhk7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 20:53:52 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41FI95da009896;
	Thu, 15 Feb 2024 20:53:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npm6vwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 20:53:51 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41FKrkEb41288114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 20:53:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A96720043;
	Thu, 15 Feb 2024 20:53:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 192432004B;
	Thu, 15 Feb 2024 20:53:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 15 Feb 2024 20:53:46 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id D7FF0E15C0; Thu, 15 Feb 2024 21:53:45 +0100 (CET)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 2/2] KVM: s390: selftests: memop: add a simple AR test
Date: Thu, 15 Feb 2024 21:53:44 +0100
Message-Id: <20240215205344.2562020-3-farman@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240215205344.2562020-1-farman@linux.ibm.com>
References: <20240215205344.2562020-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q5HIoWVPQ2WFVNTxT_t0V7S6We9xQ13I
X-Proofpoint-GUID: B3wchCvCjPM5t6wfpYG63O3gsLTd_2bm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_19,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150167

There is a selftest that checks for an (expected) error when an
invalid AR is specified, but not one that exercises the AR path.

Add a simple test that mirrors the vanilla write/read test while
providing an AR. An AR that contains zero will direct the CPU to
use the primary address space normally used anyway. AR[1] is
selected for this test because the host AR[1] is usually non-zero,
and KVM needs to correctly swap those values.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/memop.c | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index bb3ca9a5d731..be20c26ee545 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -375,6 +375,29 @@ static void test_copy(void)
 	kvm_vm_free(t.kvm_vm);
 }
 
+static void test_copy_access_register(void)
+{
+	struct test_default t = test_default_init(guest_copy);
+
+	HOST_SYNC(t.vcpu, STAGE_INITED);
+
+	prepare_mem12();
+	t.run->psw_mask &= ~(3UL << (63 - 17));
+	t.run->psw_mask |= 1UL << (63 - 17);  /* Enable AR mode */
+
+	CHECK_N_DO(MOP, t.vcpu, LOGICAL, WRITE, mem1, t.size,
+		   GADDR_V(mem1), AR(1));
+	HOST_SYNC(t.vcpu, STAGE_COPIED);
+
+	CHECK_N_DO(MOP, t.vcpu, LOGICAL, READ, mem2, t.size,
+		   GADDR_V(mem2), AR(1));
+	ASSERT_MEM_EQ(mem1, mem2, t.size);
+
+	t.run->psw_mask &= ~(3UL << (63 - 17));   /* Disable AR mode */
+
+	kvm_vm_free(t.kvm_vm);
+}
+
 static void set_storage_key_range(void *addr, size_t len, uint8_t key)
 {
 	uintptr_t _addr, abs, i;
@@ -1101,6 +1124,11 @@ int main(int argc, char *argv[])
 			.test = test_copy_key_fetch_prot_override,
 			.requirements_met = extension_cap > 0,
 		},
+		{
+			.name = "copy with access register mode",
+			.test = test_copy_access_register,
+			.requirements_met = true,
+		},
 		{
 			.name = "error checks with key",
 			.test = test_errors_key,
-- 
2.40.1


