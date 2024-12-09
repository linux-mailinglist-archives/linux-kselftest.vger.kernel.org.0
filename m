Return-Path: <linux-kselftest+bounces-23021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7888F9E91B3
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 12:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 045C3280A1D
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 11:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E330121E0AA;
	Mon,  9 Dec 2024 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FEpgqsUW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259DD21D01F;
	Mon,  9 Dec 2024 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742454; cv=none; b=kgbaDllTdjZC1KvZ1FnytgpEwXlXV4Woln4/2syvIhdUU1S2w6gfRwkmA6KWElXPdo1LV/aTjNcpeLJ3gCjyGitJnCJd2IUamv8KZrDbEpRMXrT7NJMIMMWY5XB+NDpY4XjkYue7FfeYMyocOm3nQOcKfEaYSTsEMs4z+/iIyf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742454; c=relaxed/simple;
	bh=H41krADckwSSUM18EDLrvu8Lh4Z+GBPmhDjE0mRRl4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqzEXNTYznpRZtmP5x6GBfSZL2x8IdfzW6ROtHsWVLkLGEQ0nLqzZY4nuMsobVLrDXFixyi1k5Es51yD/pig921S1wK1vPNixEsgyGhU11B40swFO+JR4kSIfW7Ioo3Tgtd8e919+zhyGWsJfbGnABhpCIzmqOya4Cvup4XeKME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FEpgqsUW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B92ZRiE028575;
	Mon, 9 Dec 2024 11:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=u0bFFaioMTWO2bOyi
	BFfn1W5MGQdiyzGiVcKA7z137k=; b=FEpgqsUWIDp4m39fEzw8UW4s2J/fmLFkz
	LKrZnHQDtNfbhzPL5c++n2bNYTe1cQ58CvvY0OcQrp4f5o1tfjtrF3E8jDY3bKj7
	MRUEXusCGjhvlsfaJkB9YDggh4QHcnL70e/iu3uaFUdJGRS3hc8wzgJy5n9yRna/
	55Ud2eJaT48kI2RGuoi7URNqgm+a9gIHJI2TCvr8p1XiqQYuT857+me5i4bt6swD
	EoX3+OIEc1PjG3Le154H8THOeWcLlzGvwYOCgi8T54KvqcFkiULDz7bYVAer10ws
	9m0zV0W9Tq8TJ2odiDWcG0h36ITUo+qeqW2Rh39d7jtM3Sh83eRog==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsj84ea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 11:07:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9AJ7K0032555;
	Mon, 9 Dec 2024 11:07:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d1pmx9aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 11:07:27 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9B7OuF56426856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 11:07:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E789520043;
	Mon,  9 Dec 2024 11:07:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7268520040;
	Mon,  9 Dec 2024 11:07:23 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.10.206])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 11:07:23 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 2/6] selftests: kvm: s390: Add ucontrol flic attr selftests
Date: Mon,  9 Dec 2024 12:07:13 +0100
Message-ID: <20241209110717.77279-3-schlameuss@linux.ibm.com>
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
X-Proofpoint-GUID: 7OuncuPyZJiFx9b2RM7hFjgpjHyJaV6z
X-Proofpoint-ORIG-GUID: 7OuncuPyZJiFx9b2RM7hFjgpjHyJaV6z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=818
 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412090086

Add some superficial selftests for the floating interrupt controller
when using ucontrol VMs. These tests are intended to cover very basic
calls only.

Some of the calls may trigger null pointer dereferences on kernels not
containing the fixes in this patch series.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 .../selftests/kvm/s390x/ucontrol_test.c       | 150 ++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index 0c112319dab1..972fac1023b5 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -635,4 +635,154 @@ TEST_F(uc_kvm, uc_skey)
 	uc_assert_diag44(self);
 }
 
+static char uc_flic_b[PAGE_SIZE];
+static struct kvm_s390_io_adapter uc_flic_ioa = { .id = 0 };
+static struct kvm_s390_io_adapter_req uc_flic_ioam = { .id = 0 };
+static struct kvm_s390_ais_req uc_flic_asim = { .isc = 0 };
+static struct kvm_s390_ais_all uc_flic_asima = { .simm = 0 };
+static struct uc_flic_attr_test {
+	char *name;
+	struct kvm_device_attr a;
+	int hasrc;
+	u64 getrc;
+	int geterrno;
+	u64 setrc;
+	int seterrno;
+} uc_flic_attr_tests[] = {
+	{
+		.name = "KVM_DEV_FLIC_GET_ALL_IRQS",
+		.setrc = 1, .seterrno = EINVAL,
+		.a = {
+			.group = KVM_DEV_FLIC_GET_ALL_IRQS,
+			.addr = (u64)&uc_flic_b,
+			.attr = PAGE_SIZE,
+		},
+	},
+	{
+		.name = "KVM_DEV_FLIC_ENQUEUE",
+		.getrc = 1, .geterrno = EINVAL,
+		.a = { .group = KVM_DEV_FLIC_ENQUEUE, },
+	},
+	{
+		.name = "KVM_DEV_FLIC_CLEAR_IRQS",
+		.getrc = 1, .geterrno = EINVAL,
+		.a = { .group = KVM_DEV_FLIC_CLEAR_IRQS, },
+	},
+	{
+		.name = "KVM_DEV_FLIC_ADAPTER_REGISTER",
+		.getrc = 1, .geterrno = EINVAL,
+		.a = {
+			.group = KVM_DEV_FLIC_ADAPTER_REGISTER,
+			.addr = (u64)&uc_flic_ioa,
+		},
+	},
+	{
+		.name = "KVM_DEV_FLIC_ADAPTER_MODIFY",
+		.getrc = 1, .geterrno = EINVAL,
+		.setrc = 1, .seterrno = EINVAL,
+		.a = {
+			.group = KVM_DEV_FLIC_ADAPTER_MODIFY,
+			.addr = (u64)&uc_flic_ioam,
+			.attr = sizeof(uc_flic_ioam),
+		},
+	},
+	{
+		.name = "KVM_DEV_FLIC_CLEAR_IO_IRQ",
+		.getrc = 1, .geterrno = EINVAL,
+		.setrc = 1, .seterrno = EINVAL,
+		.a = {
+			.group = KVM_DEV_FLIC_CLEAR_IO_IRQ,
+			.attr = 32,
+		},
+	},
+	{
+		.name = "KVM_DEV_FLIC_AISM",
+		.getrc = 1, .geterrno = EINVAL,
+		.setrc = 1, .seterrno = ENOTSUP,
+		.a = {
+			.group = KVM_DEV_FLIC_AISM,
+			.addr = (u64)&uc_flic_asim,
+		},
+	},
+	{
+		.name = "KVM_DEV_FLIC_AIRQ_INJECT",
+		.getrc = 1, .geterrno = EINVAL,
+		.a = { .group = KVM_DEV_FLIC_AIRQ_INJECT, },
+	},
+	{
+		.name = "KVM_DEV_FLIC_AISM_ALL",
+		.getrc = 1, .geterrno = ENOTSUP,
+		.setrc = 1, .seterrno = ENOTSUP,
+		.a = {
+			.group = KVM_DEV_FLIC_AISM_ALL,
+			.addr = (u64)&uc_flic_asima,
+			.attr = sizeof(uc_flic_asima),
+		},
+	},
+	{
+		.name = "KVM_DEV_FLIC_APF_ENABLE",
+		.getrc = 1, .geterrno = EINVAL,
+		.setrc = 1, .seterrno = EINVAL,
+		.a = { .group = KVM_DEV_FLIC_APF_ENABLE, },
+	},
+	{
+		.name = "KVM_DEV_FLIC_APF_DISABLE_WAIT",
+		.getrc = 1, .geterrno = EINVAL,
+		.setrc = 1, .seterrno = EINVAL,
+		.a = { .group = KVM_DEV_FLIC_APF_DISABLE_WAIT, },
+	},
+};
+
+TEST_F(uc_kvm, uc_flic_attrs)
+{
+	struct kvm_create_device cd = { .type = KVM_DEV_TYPE_FLIC };
+	struct kvm_device_attr attr;
+	u64 value;
+	int rc, i;
+
+	rc = ioctl(self->vm_fd, KVM_CREATE_DEVICE, &cd);
+	ASSERT_EQ(0, rc) TH_LOG("create device failed with err %s (%i)",
+				strerror(errno), errno);
+
+	for (i = 0; i < ARRAY_SIZE(uc_flic_attr_tests); i++) {
+		TH_LOG("test %s", uc_flic_attr_tests[i].name);
+		attr = (struct kvm_device_attr) {
+			.group = uc_flic_attr_tests[i].a.group,
+			.attr = uc_flic_attr_tests[i].a.attr,
+			.addr = uc_flic_attr_tests[i].a.addr,
+		};
+		if (attr.addr == 0)
+			attr.addr = (u64)&value;
+
+		rc = ioctl(cd.fd, KVM_HAS_DEVICE_ATTR, &attr);
+		EXPECT_EQ(uc_flic_attr_tests[i].hasrc, !!rc)
+			TH_LOG("expected dev attr missing %s",
+			       uc_flic_attr_tests[i].name);
+
+		rc = ioctl(cd.fd, KVM_GET_DEVICE_ATTR, &attr);
+		EXPECT_EQ(uc_flic_attr_tests[i].getrc, !!rc)
+			TH_LOG("get dev attr rc not expected on %s %s (%i)",
+			       uc_flic_attr_tests[i].name,
+			       strerror(errno), errno);
+		if (uc_flic_attr_tests[i].geterrno)
+			EXPECT_EQ(uc_flic_attr_tests[i].geterrno, errno)
+				TH_LOG("get dev attr errno not expected on %s %s (%i)",
+				       uc_flic_attr_tests[i].name,
+				       strerror(errno), errno);
+
+		rc = ioctl(cd.fd, KVM_SET_DEVICE_ATTR, &attr);
+		EXPECT_EQ(uc_flic_attr_tests[i].setrc, !!rc)
+			TH_LOG("set sev attr rc not expected on %s %s (%i)",
+			       uc_flic_attr_tests[i].name,
+			       strerror(errno), errno);
+		if (uc_flic_attr_tests[i].seterrno)
+			EXPECT_EQ(uc_flic_attr_tests[i].seterrno, errno)
+				TH_LOG("set dev attr errno not expected on %s %s (%i)",
+				       uc_flic_attr_tests[i].name,
+				       strerror(errno), errno);
+	}
+
+	close(cd.fd);
+}
+
 TEST_HARNESS_MAIN
-- 
2.47.1


