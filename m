Return-Path: <linux-kselftest+bounces-13379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A792892BA28
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 14:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9FA51C22501
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 12:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00B6161914;
	Tue,  9 Jul 2024 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dADNr5Lu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111C21607AF;
	Tue,  9 Jul 2024 12:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529853; cv=none; b=k7XkAaaT0c4rLJfcQ0563/8tDmn3+4eVNkjHcVN1J8+TzPjN8jPnSuRRk1N+/cQVrU8wQhQIHNJZwfDC0mewKnF6JQGCGWXS/CaroTzDFkAXvwJJ2aCxRfwOJXn+LfXRcNGrt6VcJWHmXSaSpvlpCQ0emhTrus7VhKl7HHdon70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529853; c=relaxed/simple;
	bh=ecXYzsRpPmbBa2GIF6YdXHMwedezlu3O8DBdjeaPAk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOrgsQ5rw57eOgU8vBjr33ICtEts3XuZmOvKvOZp5hiyaIG+dFXk/xZkLxmlvR27jDEjeHtWEL07MEjKYbMpZ5tBoDtuyUGBoJe3ocgfeTUJWKKnpDHYQMPiNdpcDsmffi078Xbn4FJLlH9qW0u0ZvMuiKdgeK2R7OlFfcL2FO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dADNr5Lu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4698wb0W009365;
	Tue, 9 Jul 2024 12:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=DVn+IcitdC+Eq
	pA5zhoitN9B48ayH6HI9w1jAtUAgNU=; b=dADNr5Lu6Uk/pxTrK8JuT6ha9MNEM
	ZSqG9toN7/mYY3vlbBeJ4Y6GGfuNj9V8aiycRusTA4EtHv09WFlpIL2N4kn+DFZK
	Cb01VE2PtErZoUQRKv+rsy/sQ9H+u21GoR647ivqekFSD7Y6XLA0uFGZxYfyIV4v
	fFCr20LJKY9fTzj+rEXy5UqNtgKZEStcJBzHR/DeZGRdfg2blzZx7pRUqMlcOV3G
	EWyDF4zZ1wl1OM+uL7xi1g6SBfZX7qjmmjOi+1W/n6JdtJegKcDfcuVbQssuBFWs
	8uoUDl8dc+ApovoLN2wKE3seJ6IQM7qlmchXoOnF4xcyG3SDIxvxZg6hg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40925q0jkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 12:57:28 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 469CvR1o014763;
	Tue, 9 Jul 2024 12:57:27 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40925q0jkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 12:57:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4699vHQ3013992;
	Tue, 9 Jul 2024 12:57:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 407jy345sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 12:57:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 469CvLE635586658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jul 2024 12:57:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAAD62004B;
	Tue,  9 Jul 2024 12:57:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CE5F20043;
	Tue,  9 Jul 2024 12:57:21 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.6.108])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jul 2024 12:57:21 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v1 9/9] selftests: kvm: s390: Verify reject memory region operations for ucontrol VMs
Date: Tue,  9 Jul 2024 14:57:04 +0200
Message-ID: <20240709125704.61312-10-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709125704.61312-1-schlameuss@linux.ibm.com>
References: <20240709125704.61312-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SLhLu1WPAMcNC9LnX5tXai3RGOxB3J9e
X-Proofpoint-GUID: nQ-ckdmmFSecuGFX05tijlTf4Zoqe6qY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxlogscore=799 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090082

Add a test case verifying KVM_SET_USER_MEMORY_REGION and
KVM_SET_USER_MEMORY_REGION2 cannot be executed on ucontrol VMs.

Executing this test case on not patched kernels will cause a null
pointer dereference in the host kernel.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 .../selftests/kvm/s390x/ucontrol_test.c       | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index 64ad31f667e3..a6f8a51519f8 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -587,4 +587,26 @@ TEST_F(uc_kvm, uc_gprs)
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
2.45.2


