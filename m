Return-Path: <linux-kselftest+bounces-23024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA85B9E91BE
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 12:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6275B281862
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 11:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B828C221D8A;
	Mon,  9 Dec 2024 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NYneA0DJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CD7221448;
	Mon,  9 Dec 2024 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742457; cv=none; b=qzeX+rQx5vRIIos+BJtyPNIAREygg+5xe2TzflfpNWd3HZKC6i7eGOiG9mUAvR8y0+b0TJIIH1Nlm96/1LyBA1Zrb3oGdiizgBdTqDXEYrLPaAMEmkmm1YhIKWLv9OfM6AR9fUjZYPP6pgq9x5Wpxbm/aYeKFMgX+y+1TrCBaEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742457; c=relaxed/simple;
	bh=ZCImB94yC55O4DJzZe+v7xwlS7jAorIbdZMzeTMZpaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2wtmPmnbzDMeVIiQhvti8yBErCNWqmu7tCNScRoajE32Q2lRXZz7jGib2dMeOeNn1YsW1E/tI1cwMOsogXShDU+8FoSsRIJPDQPg3buyKwZNDwVYdbdTBYyJ6afJKpnzeh5kw+USrhQGTIK3OvaZ3Otoq513uZ37aoBXDaRIaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NYneA0DJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8MeN2f023036;
	Mon, 9 Dec 2024 11:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=z+mwhYRDkIb/n+oau
	tR5WD/kA6zuLj360NkhhyMl4RA=; b=NYneA0DJrQC7/19i4v/EGAd9PvoNGtoYV
	MNDkUwQHeZsZ+D4ITFh53jrZ87VcUjR7Uz+OMlfA20gzQXS3XNtcWSaRzSzBIDTb
	oLFac+RWfAs68IozWBy1I1SC3Q+E7t3o8IaciPtuEodwwKk4YU+zonyGbIgZNLUA
	icoW4tySR5jvvNi9xZxhWEmGGPN8UUiDff+V4HlIBFIUUXGT8n9TwZBFaNuPKOGb
	CWoaxmyKrGtG6a11BX4grzI/av/y3/5R80zY4lmDxuE7nYLX+ZngSpGXixGGF9z9
	vsvzIfdDO9UGVdNPP5Y7GARD2yIRgJPxdZWHpDvDmXcyaIJ3NdRGw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0x7y5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 11:07:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9AChb4032575;
	Mon, 9 Dec 2024 11:07:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d1pmx9aj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 11:07:29 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9B7Q8W58851682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 11:07:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4138520040;
	Mon,  9 Dec 2024 11:07:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B741E2004B;
	Mon,  9 Dec 2024 11:07:25 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.10.206])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 11:07:25 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 6/6] selftests: kvm: s390: Add has device attr check to uc_attr_mem_limit selftest
Date: Mon,  9 Dec 2024 12:07:17 +0100
Message-ID: <20241209110717.77279-7-schlameuss@linux.ibm.com>
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
X-Proofpoint-GUID: -etal_45Cf-QPHKfKu89NrMUrA47ry0X
X-Proofpoint-ORIG-GUID: -etal_45Cf-QPHKfKu89NrMUrA47ry0X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=806
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090086

Fixup the uc_attr_mem_limit test case to also cover the
KVM_HAS_DEVICE_ATTR ioctl.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/ucontrol_test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index 755cd31e6387..e4a24dc7c7a6 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -206,10 +206,13 @@ TEST_F(uc_kvm, uc_attr_mem_limit)
 	struct kvm_device_attr attr = {
 		.group = KVM_S390_VM_MEM_CTRL,
 		.attr = KVM_S390_VM_MEM_LIMIT_SIZE,
-		.addr = (unsigned long)&limit,
+		.addr = (u64)&limit,
 	};
 	int rc;
 
+	rc = ioctl(self->vm_fd, KVM_HAS_DEVICE_ATTR, &attr);
+	EXPECT_EQ(0, rc);
+
 	rc = ioctl(self->vm_fd, KVM_GET_DEVICE_ATTR, &attr);
 	EXPECT_EQ(0, rc);
 	EXPECT_EQ(~0UL, limit);
-- 
2.47.1


