Return-Path: <linux-kselftest+bounces-19714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 283FD99E14A
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 10:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4815F1C219C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 08:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8BF1C877E;
	Tue, 15 Oct 2024 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lQ4JOxeM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF151CC891;
	Tue, 15 Oct 2024 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981480; cv=none; b=Y++ZhglwqfIwx/XiQesNa0IpDGMt385Cz0OPuzEWgnZHYUnTS7oAyrS0UrXZClRNsOhZnvhhBpntgzLF7UV4nQQVm0bcFATaZtNxdrK4RzbRAz7MJrfE9KQbfLdhRvyIy7Nw35R1qIzAblQhQAUNppIRKqEZfn5wKbgL5piVcyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981480; c=relaxed/simple;
	bh=DN/i/j37X1MwTckI2DOuaabrtjp+epUJsybf9fq843Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ow/kbNSqAuZQD43Hvy4g14FHPOW5S568qVsKxso9uaQBBPiWDm/R0E9ZV2jcRszlwe7+OFbpzLC3uvG5PJ3+KsUFMpcGdwxZMLYYVVE3f/z6gtsTq3e8fypu0GXGGGmMFiK7e0OMCjMLCEm9+Rb5dNDA6Qy97ON8HYB3kIGgh5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lQ4JOxeM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F7KMd3031011;
	Tue, 15 Oct 2024 08:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kGv+gbKb0xPN6mBlh
	SmbCHZzKlKLNv1iwMAtHYMds+Y=; b=lQ4JOxeM3U8Fzg0VLTofN15yKbgxulPxB
	lJcIhOQWUgk4IQZKNe22QLOWky6ktDrenpL7qOxKFW1e8LF6UO7ArBI82nikbysD
	xaS6ifWO+FO4oT1F5EZdyAEeYzdizuv6o8oD2NqwI+l30rcnghAQZuQOgSYsyvAI
	fqJ0fP9HsBM/DdDVA9HHbNygFzJdn0riaDQlCNRSaqCdklNczsPbvNm7O3xOji1u
	aeLvNo+cuDT9UB8EuP+M7CHKnNqgj885SQ2rTCbQO091h5D9lmf536LbRAkqXKhf
	TnF3+ZdSURBk4vOZZIX8Q/4TBTLzuJaR87jcFIGLMXHooqpmALXPg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429kwvrbrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 08:37:54 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49F8bs0V015670;
	Tue, 15 Oct 2024 08:37:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429kwvrbrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 08:37:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49F7RciD027499;
	Tue, 15 Oct 2024 08:37:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4283txjurk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 08:37:53 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49F8bnJM32834130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 08:37:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB66520040;
	Tue, 15 Oct 2024 08:37:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 595B220043;
	Tue, 15 Oct 2024 08:37:49 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.49.63])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Oct 2024 08:37:49 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, schlameuss@linux.ibm.com
Subject: [PATCH v6 3/5] selftests: kvm: s390: Verify reject memory region operations for ucontrol VMs
Date: Tue, 15 Oct 2024 10:37:42 +0200
Message-ID: <20241015083744.761838-4-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015083744.761838-1-schlameuss@linux.ibm.com>
References: <20241015083744.761838-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C0k-nChuhbD5Kss8CtPfYXxF-c0ogXPG
X-Proofpoint-ORIG-GUID: mdt50YgT69LIfcH6M89udgNq_rTYNn2H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150056

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
index 9568a4e03e4b..ae077bf838c8 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -439,6 +439,28 @@ static void uc_assert_diag44(FIXTURE_DATA(uc_kvm) * self)
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
2.47.0


