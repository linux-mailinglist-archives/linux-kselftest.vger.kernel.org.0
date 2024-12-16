Return-Path: <linux-kselftest+bounces-23395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3AB9F2CD2
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 10:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DAEE188411E
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 09:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07EB201253;
	Mon, 16 Dec 2024 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fEZ7bNc7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F1C201033;
	Mon, 16 Dec 2024 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734340932; cv=none; b=BOikk+1euW472MtBGE+FwuJe0PuFO+8xbmC/tFwa+QQ8wcSlsqPKVFk29TCM19+ftdP7XlTbXpXhZYnKPmzcOA2s8VQESztwSTvIV+Mk3SoJUU3EPdHahsVvwNM6Nb/nrFULntZUJxu/k61NJcADi5ssEyVuQpKN9mxoDfaSiOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734340932; c=relaxed/simple;
	bh=0fa1S9zXQFt4mD0xsxBRxWNZVv0Eo0unbM5x7xHlmhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0+hs+NG4ttDlkK+x1Wo72Imdo/lEySxOzfId03xA1hDvbEfamGwus3C37eN4oBfHOPHPnZ5c8SxjlizOv+G9jT/KoW4jP1TT8opdzdBO3XbySmwfzKZ26M3+iutEAXb8m0F3N5cJ9ERGvAkZzJclxMuPPkYZyxQUQ23Vsm+qMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fEZ7bNc7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BFNaRSB020349;
	Mon, 16 Dec 2024 09:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=P5xOYXthLzmrp6QLv
	NmF1jlp5ZTGQ0nylSIiJEUY5UU=; b=fEZ7bNc7zO+gKXHEJ2+aUDUd95ScDI3f1
	guPm13T7cRDhDreKgAAz1W7rmSVd7RS3/UaXHClm5kVaMPc49RUxl7/f8Ez+1DSF
	5oOet4EI1PPZxW9ZJ7GsZ7YYrvIRgVm6iBYa9oco6o73vvfmSYbIWBiN0BBIeTOK
	BZMuX7n/SInYuBn2Mb6Ad8vin6cRzBZAf7aX0b+owqzCzF1YkaFz9pN4lFSODd5G
	+BBixsQgR3yCt1GotTCutZJtXvOQpok5NpOT+VMkGNUs/6xR4BcxMLYdA541d5Wv
	2qlAbu8kAU+uBsU1lAB5HW8aZbygq8IVCKlKMdH2f47AvRtHFo9ow==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43j8xahwa5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:22:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG5stXZ011256;
	Mon, 16 Dec 2024 09:22:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hpjjw0ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:22:03 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BG9Lxvp35914474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 09:21:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C91592004B;
	Mon, 16 Dec 2024 09:21:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FC9220040;
	Mon, 16 Dec 2024 09:21:59 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.0.126])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Dec 2024 09:21:58 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Ulrich Weigand <ulrich.weigand@de.ibm.com>,
        Dominik Dingel <dingel@linux.vnet.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2 2/6] selftests: kvm: s390: Add ucontrol flic attr selftests
Date: Mon, 16 Dec 2024 10:21:36 +0100
Message-ID: <20241216092140.329196-3-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216092140.329196-1-schlameuss@linux.ibm.com>
References: <20241216092140.329196-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fJncHOynr37-JPnSs6hasi8jH7cM99eH
X-Proofpoint-ORIG-GUID: fJncHOynr37-JPnSs6hasi8jH7cM99eH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxlogscore=811 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160074

Add some superficial selftests for the floating interrupt controller
when using ucontrol VMs. These tests are intended to cover very basic
calls only.

Some of the calls may trigger null pointer dereferences on kernels not
containing the fixes in this patch series.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 .../selftests/kvm/s390x/ucontrol_test.c       | 148 ++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index 0c112319dab1..b003abda8495 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -635,4 +635,152 @@ TEST_F(uc_kvm, uc_skey)
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
+	int geterrno;
+	int seterrno;
+} uc_flic_attr_tests[] = {
+	{
+		.name = "KVM_DEV_FLIC_GET_ALL_IRQS",
+		.seterrno = EINVAL,
+		.a = {
+			.group = KVM_DEV_FLIC_GET_ALL_IRQS,
+			.addr = (u64)&uc_flic_b,
+			.attr = PAGE_SIZE,
+		},
+	},
+	{
+		.name = "KVM_DEV_FLIC_ENQUEUE",
+		.geterrno = EINVAL,
+		.a = { .group = KVM_DEV_FLIC_ENQUEUE, },
+	},
+	{
+		.name = "KVM_DEV_FLIC_CLEAR_IRQS",
+		.geterrno = EINVAL,
+		.a = { .group = KVM_DEV_FLIC_CLEAR_IRQS, },
+	},
+	{
+		.name = "KVM_DEV_FLIC_ADAPTER_REGISTER",
+		.geterrno = EINVAL,
+		.a = {
+			.group = KVM_DEV_FLIC_ADAPTER_REGISTER,
+			.addr = (u64)&uc_flic_ioa,
+		},
+	},
+	{
+		.name = "KVM_DEV_FLIC_ADAPTER_MODIFY",
+		.geterrno = EINVAL,
+		.seterrno = EINVAL,
+		.a = {
+			.group = KVM_DEV_FLIC_ADAPTER_MODIFY,
+			.addr = (u64)&uc_flic_ioam,
+			.attr = sizeof(uc_flic_ioam),
+		},
+	},
+	{
+		.name = "KVM_DEV_FLIC_CLEAR_IO_IRQ",
+		.geterrno = EINVAL,
+		.seterrno = EINVAL,
+		.a = {
+			.group = KVM_DEV_FLIC_CLEAR_IO_IRQ,
+			.attr = 32,
+		},
+	},
+	{
+		.name = "KVM_DEV_FLIC_AISM",
+		.geterrno = EINVAL,
+		.seterrno = ENOTSUP,
+		.a = {
+			.group = KVM_DEV_FLIC_AISM,
+			.addr = (u64)&uc_flic_asim,
+		},
+	},
+	{
+		.name = "KVM_DEV_FLIC_AIRQ_INJECT",
+		.geterrno = EINVAL,
+		.a = { .group = KVM_DEV_FLIC_AIRQ_INJECT, },
+	},
+	{
+		.name = "KVM_DEV_FLIC_AISM_ALL",
+		.geterrno = ENOTSUP,
+		.seterrno = ENOTSUP,
+		.a = {
+			.group = KVM_DEV_FLIC_AISM_ALL,
+			.addr = (u64)&uc_flic_asima,
+			.attr = sizeof(uc_flic_asima),
+		},
+	},
+	{
+		.name = "KVM_DEV_FLIC_APF_ENABLE",
+		.geterrno = EINVAL,
+		.seterrno = EINVAL,
+		.a = { .group = KVM_DEV_FLIC_APF_ENABLE, },
+	},
+	{
+		.name = "KVM_DEV_FLIC_APF_DISABLE_WAIT",
+		.geterrno = EINVAL,
+		.seterrno = EINVAL,
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
+		EXPECT_EQ(!!uc_flic_attr_tests[i].geterrno, !!rc)
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
+		EXPECT_EQ(!!uc_flic_attr_tests[i].seterrno, !!rc)
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


