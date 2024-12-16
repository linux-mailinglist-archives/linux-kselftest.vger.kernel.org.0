Return-Path: <linux-kselftest+bounces-23399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8569D9F2CDD
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 10:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E731887025
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 09:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65CF202C4A;
	Mon, 16 Dec 2024 09:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b+X+o9Dk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19154200BBD;
	Mon, 16 Dec 2024 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734340938; cv=none; b=Wq2EgvIMw2Sqe06p9sNc9zYeWYw2gXGrjtKV0hkymlh/p1CAjPQ73gmL7fJvaMg5CENhHtntbPZ63uUO2jqfUGgHY1r2O8EPfTxi3OLE1eks8kZdmsPdRGVqxYE6pnRHohJU1psk2pdZ6sZnzj11xII7sbihooD17mqFmpgEQS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734340938; c=relaxed/simple;
	bh=6EfLlCPdQN+dTd2subfxyisFwKaGrX3I583/bK5A7fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIZglhQ7n9ypp8DzXcH7rMDFZWCWOsGMmlEmDixuSG3CekliCEcRsoApA46IxYpJhhRgamuGEmP5CUauPW7VlRRYuwpwS+qyMnTOz7jScAvr3EyuyDShDWKkCOScKOspKp0/swl3mY1kP+fUbsgO+hfqJHwAKqNvDhr7XqJIilI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b+X+o9Dk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG3qtnL020220;
	Mon, 16 Dec 2024 09:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+NodavmKFTUM6prHe
	atyonTh+dE3Y4X02W2UrRce8U8=; b=b+X+o9Dk2P0L8/HZAiuVZUR+8FNZjei7J
	Dkl50HowR3Phpd2zAKLXiSuH2ACzEuUQaG4mHL6TXrvW6eT/3/T3BBFSCcAPefNs
	++W/RIpH5/LWGFcOy2AUS3N8grLghj5k/SNlbFdnzzLjYDZgs8XbAr+3LxPrTot0
	KMr74SN1+cu097IU4sIi/dsN6zMML1KXs/sla9emz+s7WaA7SqfmwfC4vZQf37Jl
	Mgk8wLGjcc+ZQxeTqGj/meWLL4YmNRqRbFROBEVu7wj1K0G36+EUOQUGRC2rF4qU
	BIJoJdF8LTMBZ+UaycuQZkzZI7di3Um5Y+XZFyJ9SuD8E99V2MdzA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jcpgsakn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:22:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG70TAS014391;
	Mon, 16 Dec 2024 09:22:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hq21cv7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 09:22:06 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BG9M3VH55705864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 09:22:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48A9E20043;
	Mon, 16 Dec 2024 09:22:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A08A2004D;
	Mon, 16 Dec 2024 09:22:02 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.0.126])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Dec 2024 09:22:02 +0000 (GMT)
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
Subject: [PATCH v2 6/6] selftests: kvm: s390: Add has device attr check to uc_attr_mem_limit selftest
Date: Mon, 16 Dec 2024 10:21:40 +0100
Message-ID: <20241216092140.329196-7-schlameuss@linux.ibm.com>
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
X-Proofpoint-GUID: Lun59pA_LAadI8EXdv29cXPeB6FqrTa2
X-Proofpoint-ORIG-GUID: Lun59pA_LAadI8EXdv29cXPeB6FqrTa2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 mlxscore=0 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=806 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412160074

Fixup the uc_attr_mem_limit test case to also cover the
KVM_HAS_DEVICE_ATTR ioctl.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/ucontrol_test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index ef3e391811b3..087496fe264d 100644
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


