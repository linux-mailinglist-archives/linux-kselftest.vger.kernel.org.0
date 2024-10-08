Return-Path: <linux-kselftest+bounces-19219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D58994121
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 10:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4851C23882
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 08:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2E31DF972;
	Tue,  8 Oct 2024 07:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GU/z9URR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A191DF964;
	Tue,  8 Oct 2024 07:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373400; cv=none; b=hjxMl7MxmN57TxzTNv/G9Gq98oPhQ6iQ3z2roQMBLO1ly1pva0qUmwrCZ7lCebfYjuHg8GCoxAGQIRuX/+Gx1nDsDolWJSVNyIK90vfxSo8fGuw2jMu8peSldQwyzO67O9gS9YQRX/EFn/49sU9KbRRFro31EHXAO8eHW2XXJ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373400; c=relaxed/simple;
	bh=aCgS7xcBNSl28qbG/kUNf7LQsOyi4Bb65R+RliPqmK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTiY1/fM95TjI0aQTKoBwW9zFrTsAhNPKnq3pdiTGiyrYyQCSlsuLSFG5H6yJeztTpm214bstVlV3sWsROOw2FLHI+5alZmCOu0FljLHihWAEHlsXMgCHBaEAOycQa79z4ffvw/l2xtUW2RFt49x9vSZKOsy+pOEl7jCOysbEH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GU/z9URR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4987NhXW014613;
	Tue, 8 Oct 2024 07:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=II9xPt/4qV4DY
	MBtJH8PRN7/lT+nHhAqoNmvEpWSb4Q=; b=GU/z9URRqMMIiVupS2UnCKNDiLQZa
	NKVKFRk9O32O5mRZn7tDdnmoJUxQk153B76bHH+FloGLyvejNfjQBJAz65jdtQzw
	T3OBsEqMqHlRmRpMnlL838PELdCwqJODeu50NXrJ0bgt8A83DJgH55wGPfQbFC/C
	BNxADTUnUEzPK6EVsfFtKGnK/5ngm/mzntwa94xMxBVOU0HGKE96vO/W/T4sFzOq
	vIac6tSKAnDRtnMIK2G6AwTtDqlPNpqFLWqj2eya32nK5yUXdeWOjWDXCTdMC86U
	xVUuNCmIDf+dTi4UXOabJ4NhAnij3vb+CAyps5P73b83U3QjzPQTyJosQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4250a1r2gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 07:43:09 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4987h9We029296;
	Tue, 8 Oct 2024 07:43:09 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4250a1r2gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 07:43:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4985cDqa013857;
	Tue, 8 Oct 2024 07:43:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 423fss31mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 07:43:08 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4987h5DY21561916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Oct 2024 07:43:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E36DA20043;
	Tue,  8 Oct 2024 07:43:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E50F20040;
	Tue,  8 Oct 2024 07:43:04 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.23.149])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Oct 2024 07:43:04 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, schlameuss@linux.ibm.com
Subject: [PATCH v5 3/4] selftests: kvm: s390: Verify reject memory region operations for ucontrol VMs
Date: Tue,  8 Oct 2024 09:42:52 +0200
Message-ID: <20241008074253.370481-4-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008074253.370481-1-schlameuss@linux.ibm.com>
References: <20241008074253.370481-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u9Eeusu0_kTq0iEImFf66cuFq7hMDGUj
X-Proofpoint-ORIG-GUID: R22yy0mvipaK8ldWcc8dx9UUier0a8S6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_05,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410080047

Add a test case verifying KVM_SET_USER_MEMORY_REGION and
KVM_SET_USER_MEMORY_REGION2 cannot be executed on ucontrol VMs.

Executing this test case on not patched kernels will cause a null
pointer dereference in the host kernel.
This is fixed with commit:
commit 7816e58967d0 ("kvm: s390: Reject memory region operations for ucontrol VMs")

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 .../selftests/kvm/s390x/ucontrol_test.c       | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index f022322a00d4..5185620a21eb 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -400,6 +400,28 @@ static void uc_assert_diag44(FIXTURE_DATA(uc_kvm) * self)
 	TEST_ASSERT_EQ(0x440000, sie_block->ipb);
 }
 
+TEST_F(uc_kvm, uc_no_user_region)
+{
+	struct kvm_userspace_memory_region region = {
+		.slot = 1,
+		.guest_phys_addr = self->code_gpa,
+		.memory_size = VM_MEM_EXT_SIZE,
+		.userspace_addr = (uintptr_t)self->code_hva,
+	};
+	struct kvm_userspace_memory_region2 region2 = {
+		.slot = 1,
+		.guest_phys_addr = self->code_gpa,
+		.memory_size = VM_MEM_EXT_SIZE,
+		.userspace_addr = (uintptr_t)self->code_hva,
+	};
+
+	ASSERT_EQ(-1, ioctl(self->vm_fd, KVM_SET_USER_MEMORY_REGION, &region));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1, ioctl(self->vm_fd, KVM_SET_USER_MEMORY_REGION2, &region2));
+	ASSERT_EQ(EINVAL, errno);
+}
+
 TEST_F(uc_kvm, uc_map_unmap)
 {
 	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
-- 
2.46.2


