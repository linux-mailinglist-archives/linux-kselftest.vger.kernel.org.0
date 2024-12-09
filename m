Return-Path: <linux-kselftest+bounces-23022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF929E91B7
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 12:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3101282C71
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 11:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566A221E0BF;
	Mon,  9 Dec 2024 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fr5H2cr0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B825421D5A0;
	Mon,  9 Dec 2024 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742455; cv=none; b=Utt+MzEXoK7Q8/aLwmOuGqZGS4Y5AOZMVWEbaKxOFaC0NbSI+4WLUFxyNQ5mCuL5we9O7/yvZ4QcGDwdPEEFNGnE/DwycrBXxVYtztT8pjKIYrhFpfHUwTKbkaPc444sCHFwPebGsggpVHgg7CK6dN07S19WIwu55bk3A0ztgq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742455; c=relaxed/simple;
	bh=6Gb2frNMTdFtRnJsl2x5J3o2gU61aFGEFMpOe4dH5nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=II5TroGU/FsgRR8sqs/jZES3D2BK0tdeNBUvlFjVBNycuLSDCyXXlMwrW/U98g+85PhLTQTovJZ4/zjIO79L6N/iLn9faxxAZjIft1ma4RATWVHd0RBvOPITRRx5Zy1PN9jirV9pIal4VDJPOB4bfXeTkAtiyTPFBXTjHB4bkMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fr5H2cr0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8NPOc7015089;
	Mon, 9 Dec 2024 11:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XZLMVfk7zaeLh8YGb
	mG0xOTw17vUgJUXqAvNpSqpz2g=; b=Fr5H2cr0qQREVIoKJUwcW0ehjAhdvxoIZ
	l3TMs20ogsTKDaw7txvg4tKd1av1cuSgNRYKMTuG91fVswYmNl5JBDKBVVs2/6eS
	JCrB4XuM7S8ah5tCvLT5JKJtENZenzh3C3GgVda+1y2NeOCQndyaD80IbgGHNDwJ
	OQDPeTk/xR6BDFcRwW3AhhEDTi1VWoJ6jgxkZb9ocMYPywroT/FnNGrlH6IwXuG6
	zkQWbnfPGZpXwSn4ClZTI5SxGq1lrlgxM4Ox89Ce3xo2FOsd2feicMtgtLmAP0zz
	xROOCIrr/SdTmt7HcOOgTAaU9M4iGNGkFQJsAKjRPMvKUnExZ0uBA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce38gvhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 11:07:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B99WfMF032727;
	Mon, 9 Dec 2024 11:07:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0ps6gh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 11:07:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9B7PH516122338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 11:07:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 193E42004E;
	Mon,  9 Dec 2024 11:07:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97C9420040;
	Mon,  9 Dec 2024 11:07:24 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.10.206])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 11:07:24 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 4/6] selftests: kvm: s390: Add ucontrol gis routing test
Date: Mon,  9 Dec 2024 12:07:15 +0100
Message-ID: <20241209110717.77279-5-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209110717.77279-1-schlameuss@linux.ibm.com>
References: <20241209110717.77279-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Zz7L67ECQL1v-IB65n63QpK64grkAPdC
X-Proofpoint-ORIG-GUID: Zz7L67ECQL1v-IB65n63QpK64grkAPdC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=933
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090086

Add a selftests for the interrupt routing configuration when using
ucontrol VMs.

Calling the test may trigger a null pointer dereferences on kernels not
containing the fixes in this patch series.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 .../selftests/kvm/s390x/ucontrol_test.c       | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index 972fac1023b5..d3a5dbfabade 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -785,4 +785,23 @@ TEST_F(uc_kvm, uc_flic_attrs)
 	close(cd.fd);
 }
 
+TEST_F(uc_kvm, uc_set_gsi_routing)
+{
+	struct kvm_irq_routing *routing = kvm_gsi_routing_create();
+	struct kvm_irq_routing_entry ue = {
+		.type = KVM_IRQ_ROUTING_S390_ADAPTER,
+		.gsi = 1,
+		.u.adapter = (struct kvm_irq_routing_s390_adapter) {
+			.ind_addr = 0,
+		},
+	};
+	int rc;
+
+	routing->entries[0] = ue;
+	routing->nr = 1;
+	rc = ioctl(self->vm_fd, KVM_SET_GSI_ROUTING, routing);
+	ASSERT_EQ(-1, rc) TH_LOG("err %s (%i)", strerror(errno), errno);
+	ASSERT_EQ(EINVAL, errno) TH_LOG("err %s (%i)", strerror(errno), errno);
+}
+
 TEST_HARNESS_MAIN
-- 
2.47.1


