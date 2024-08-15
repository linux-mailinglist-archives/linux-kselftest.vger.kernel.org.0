Return-Path: <linux-kselftest+bounces-15421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC82595378C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 17:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA7C289082
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 15:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109431B3747;
	Thu, 15 Aug 2024 15:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pPsM8hnZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDBD1AB521;
	Thu, 15 Aug 2024 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736753; cv=none; b=Ds/g1bulviHcStgzi105zrv1HheSMUJ9imMq5XSBE2FpvZQBmfupB8dEyX7PeC2LQCrdZWiaglPsPwQx11RayWWj9iC29XZgHCgbx8lTFp3TrIYFccEdOY+3dQ4cx4IIcjYbAeD5JM2fLdTcaR5mNb36UEdU4ihCRhbGCDLA6uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736753; c=relaxed/simple;
	bh=dAIPFx2WdpyalAsDEAwWHpZo3XDZjZCJBBRlPCt19lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVI/QmishPScb15hObhQkLHXH7gCt7b9N6ulNZw8vB6CqM8wkI6FQPsS/HYJC4q1rXY4vcBikr7Zu7Ua/IeeZ0tGZi0ed3JvY/t2mEgqucluMYXSDCs20vgWWXXmO9YwZZfAecXTH/6Quq23fMaBXu57ysye6DAnmncramPUbRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pPsM8hnZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47F9fvYe025244;
	Thu, 15 Aug 2024 15:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=6INXSd5BYAqFy
	ztK7qdJuDOSwKKR1vJiDDw0rXuCj8M=; b=pPsM8hnZkIlpy88sAH6P8EoBtMRtj
	1FwU6Twb1eL0AJeRo3nScgM+n+Thksm3a8CTD9hn8DhO9C/vk1YXI4A0JJsCRqqq
	sy2xSmIcxFARxt0QAg5YjXAEiRWqLvWWOngs/DNnfHMo1EJ6XvYFQTNGvLD+oEN4
	TCAhXPSkGpXck+KjC8sV9ksHk/JdlCIH1QYEWZqBgP4kSt6EVLngF3DIGvqI3GR/
	lXeY3mfqD8hcbxIL+2fkCIFYPNW6pwwYPFITU6IrZQ14fDySVBJGsfFntFdou4Q7
	4WDF22W9lgYbAxGQg6sbrdjlniPI12l+1YWjYt2zRnAH1Lgv7PpOsKwyQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111d6ccsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 15:45:42 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47FFhW6u003580;
	Thu, 15 Aug 2024 15:45:41 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111d6ccs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 15:45:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47FFGNOd020987;
	Thu, 15 Aug 2024 15:45:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xn83f06k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 15:45:40 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47FFjZKN52167018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 15:45:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B7212004E;
	Thu, 15 Aug 2024 15:45:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFA3C20040;
	Thu, 15 Aug 2024 15:45:34 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.32.201])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Aug 2024 15:45:34 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>, schlameuss@linux.ibm.com
Subject: [PATCH 3/3] selftests: kvm: s390: Verify reject memory region operations for ucontrol VMs
Date: Thu, 15 Aug 2024 17:45:29 +0200
Message-ID: <20240815154529.628087-4-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815154529.628087-1-schlameuss@linux.ibm.com>
References: <20240815154529.628087-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eqbtWjpqyIKhw3tRQteerulT8MMorvBL
X-Proofpoint-GUID: cjiajcL1nh53fqVEpsaxY8vI5Fdc6_aF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_07,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=945 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408150109

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
index 5f8815a80544..ed3c441522c8 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -524,4 +524,26 @@ TEST_F(uc_kvm, uc_gprs)
 	ASSERT_EQ(1, sync_regs->gprs[0]);
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
 TEST_HARNESS_MAIN
-- 
2.46.0


