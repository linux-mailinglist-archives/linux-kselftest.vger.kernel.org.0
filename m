Return-Path: <linux-kselftest+bounces-18065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D096B97AB95
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 08:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539EE1F29B25
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 06:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DED1384BF;
	Tue, 17 Sep 2024 06:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YcGf/o6d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE8148FFC;
	Tue, 17 Sep 2024 06:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726555520; cv=none; b=i8XIjD6d/JgEwgkAMPapbK0pSwkKUtJ2qnxklRd63ARSNeWKItb9Vh9ZuPA2G3BkAodd5XVTvDmMZPaFcsIEVPAnMOXYPKA3jNYBawGdtM2zO75pAnlHKZ3aX9+SzMD/jhLJQ05CbMUqhkMmDZyHIB9McDhdC+jiFEZ6C1yBRYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726555520; c=relaxed/simple;
	bh=tFYyepEjwjKyfiG7IC9pzS8g80HaXgIrWSs5Nxzhf4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDnCf3w5DfvnMN/m1QemIYTSKl/lSVOv2coWEFignPl5xuSydadxBPZa42JmmIKUoRcpU+OEWx+6a7YjKKEM7/idI2D2NU+gA/ZQXwTAGDmT4PKQ0Kh1hKgOenKSrNlr/3YY8mB09MTXuVqbTjVixHjArushPambgJv/u5OClrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YcGf/o6d; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GIVTPl008074;
	Tue, 17 Sep 2024 06:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=jKACk4qIdExim
	ONCpIFkda9i+GjHzkMm4u1zXF6o2NM=; b=YcGf/o6deTPeptzqP8q618FvTlui1
	1IjQ8vXcn8OciAX7u0P0YbAK423XyN3KZBJ30WQ6PHaqgaCkyG2fKbGUoJxZ2SGd
	pepR7mPlSTY3ObOWIFb/aFNXu+iWtf7lfrpwhdnpi50257MqJKt0fJTZUq98Mizu
	wensHJaNYMY+3fkwyYamAz3txpZvweJP+sTL7KaAeqjHC1OhDR879wnd6L6kxAuB
	JL8QTadYJ2m9AbOpZaw8dply6ECt0k9cYI2fL0RUFPg5/ZyIFj2S3bwvufAHDAms
	//Jr16BgIThVxLm41fpBcff28YoaLmNEUmu0mdbfVKIu06ft8xBlCMTig==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vdebuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 06:45:13 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48H6gaoi011755;
	Tue, 17 Sep 2024 06:45:13 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vdebur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 06:45:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48H6RULB000762;
	Tue, 17 Sep 2024 06:45:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41nntq3g77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 06:45:12 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48H6j8nt55509388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 06:45:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50C122004E;
	Tue, 17 Sep 2024 06:45:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B88E320040;
	Tue, 17 Sep 2024 06:45:07 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.17.198])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Sep 2024 06:45:07 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>, schlameuss@linux.ibm.com
Subject: [PATCH v4 3/4] selftests: kvm: s390: Verify reject memory region operations for ucontrol VMs
Date: Tue, 17 Sep 2024 08:44:55 +0200
Message-ID: <20240917064456.210839-4-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917064456.210839-1-schlameuss@linux.ibm.com>
References: <20240917064456.210839-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 64CWbNe-2i0T8fXrlXgCMfVsVp4wH-xe
X-Proofpoint-GUID: vCVb9-sR2rbxHtQcL-8Fn-DWCe60_tAU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_02,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409170049

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
index c713aa03e920..1f1c58f5ec2f 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -401,6 +401,28 @@ static void uc_assert_diag44(FIXTURE_DATA(uc_kvm) * self)
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
2.46.0


