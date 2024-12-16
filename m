Return-Path: <linux-kselftest+bounces-23397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC3F9F2CD8
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 10:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C041883E93
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 09:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58725202C37;
	Mon, 16 Dec 2024 09:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RjVQ3dGc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42DB202C2D;
	Mon, 16 Dec 2024 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734340937; cv=none; b=C2DtG7I2yfvfJ9OQDAZQ5FPKbBHMyJ2UqBPGd5QOSnS/OcvtCmBP9N2lY9aHNMMkfjaF7u9U9YVDqedodbWBAzSAY6WrGgoWZNV4CCEM8FslltOuMkq9tIzqfxHpX4YpOSrIJ8FiZa1uujscXcf0bXmVp6VrERqCPBldPFBbZ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734340937; c=relaxed/simple;
	bh=7B54tR1iKt0w3fNUGvj2YAS4o0xv6aTFm+7Tn6SDW7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azCHAcNeAUFovac13QPtYdAisf+1khOYZrgmyXLnsRVH5yK4rxx0+LJ0IZ8iClGB/oblC+gKHoaR7trSO2XShs79GvWGcYTnV8HfxeqUjkaV5A3QvLpCmW6B4uOpmKLAJa6sYIHrjx2KDiSh4VzrzshbT8hFc7vSlITuTq1r8BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RjVQ3dGc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG3qT9o011994;
	Mon, 16 Dec 2024 09:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TPXhzVRC9InqJX36q
	MuFuhGo3TZReRYuagQV5gd2jc8=; b=RjVQ3dGcL4+IiKqs/LUaEDWtjbJQdFbU1
	idpAdRjePv2uHDNtcmnGUMfTyvivcMyBF8Qi/XBK6Z4gkfjb+/HMr3nv7RNJWidE
	MoR06Jk7rkNry1HHJz5Hgd9BHcZ+l8plcohgX95xPCKeLWZtFL2tL7D94aelAQxH
	Dv3QrQuVloPUjgGleTw2J/943o1XUCKB75HKTM1vamDOXhy73fLldKlpea0DBYmv
	p1/mxF3Ebn+VJBjDIPJTyhQZEVFQqJ4wekByctSQy4oHtogz76nwCZT4hzqN21Vq
	4h6BBe84XuN+cXwnZd1xv8HUnj1wDIgad1NrWPTt1yD99quiwnruA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jcpb1amt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:22:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG4kYcX005544;
	Mon, 16 Dec 2024 09:22:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnbmw81r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:22:05 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BG9M12u56820216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 09:22:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8920B2004B;
	Mon, 16 Dec 2024 09:22:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C30E920040;
	Mon, 16 Dec 2024 09:22:00 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.0.126])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Dec 2024 09:22:00 +0000 (GMT)
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
Subject: [PATCH v2 4/6] selftests: kvm: s390: Add ucontrol gis routing test
Date: Mon, 16 Dec 2024 10:21:38 +0100
Message-ID: <20241216092140.329196-5-schlameuss@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: lW5AWENBFJgIpDIAqvjperoXpvCmgbZ_
X-Proofpoint-GUID: lW5AWENBFJgIpDIAqvjperoXpvCmgbZ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=932 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412160074

Add a selftests for the interrupt routing configuration when using
ucontrol VMs.

Calling the test may trigger a null pointer dereferences on kernels not
containing the fixes in this patch series.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 .../selftests/kvm/s390x/ucontrol_test.c       | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index b003abda8495..8f306395696e 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -783,4 +783,23 @@ TEST_F(uc_kvm, uc_flic_attrs)
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


