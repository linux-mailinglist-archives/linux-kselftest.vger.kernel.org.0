Return-Path: <linux-kselftest+bounces-4480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5634B84FDE0
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 21:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52EC1F22E54
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 20:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F8C6AA7;
	Fri,  9 Feb 2024 20:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i4wbRFqp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA20E63B8;
	Fri,  9 Feb 2024 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511568; cv=none; b=I9yQJwhRlC5Q838ht2K837Re5yclOg8QSftuOcxFHssnjJanaUm1N0VyoADOMfVTxORGSK3ks9+u9JFWL9A3a64VWhRNK55JF/y93rWoqKwl5goqMinu44vsxvhSFYG7lG8+QaBv/OjuAXvQYtEvc4ph6am6s6aZN2cuVZU4SxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511568; c=relaxed/simple;
	bh=wFHRWFNDjByZdkECXDT5AIayYLGLuLsqg4VpCTDXaxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p0US78eShSyBAJtArO2oHBcDEoxm7sG+E/9jhxyYZMHTyuCStOD5Kyur8d1vjP41TvPatIMkpFE0ZzTFM1BxE9uUoUmc5YTj/KG0JUHGO9f7bgVIAqMUBmiAQ+/cJ6xzhx1Zf0VICn62PAr56QqUrCnYCugYQpOQ66yWPMgrUn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i4wbRFqp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 419Jxj9V005672;
	Fri, 9 Feb 2024 20:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=naSuFLOBCRRosC0sA+aZ1BhtQ2Dg+R11DdlDmvqw/e4=;
 b=i4wbRFqpb9mJJhih4QDVygWtN6+9R/gmJGUXA8mj9V72qoCV9iCe/kmi10EQQYgFUyCp
 ntgLz5O79tDGYkUK3uUQJm7dwsdhynLzubVlNlDiTwma6Ot5KJTuuMrqIqRTs80loBaQ
 5zYvTPb9P7CF5CZDp4Lpjd1Cp9qbNX/yEA4blsHe9cUWpw9ywdyOhDRIenZU+ZKA3zMy
 0ZHcU+piV1WqhEuh2cqEJ+r7gGx9cE8bObLoaM/IcaZdySBi21SouDL+9LkfBU1l8ZWp
 pdvrWqmlHUHBr3lW3Buc53wzic5cI+NTTnZR3OsOPckziHUcngQrWjhlAiXgQ01D0dEc PA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w5t7fhjt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 20:46:04 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 419Kd7XX021131;
	Fri, 9 Feb 2024 20:46:03 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w5t7fhjnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 20:46:03 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 419J6oKt008770;
	Fri, 9 Feb 2024 20:45:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w20705hxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 20:45:49 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 419Kjhor21365490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Feb 2024 20:45:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD18220043;
	Fri,  9 Feb 2024 20:45:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C93A520040;
	Fri,  9 Feb 2024 20:45:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  9 Feb 2024 20:45:43 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 7963AE0361; Fri,  9 Feb 2024 21:45:43 +0100 (CET)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v1 2/2] KVM: s390: selftests: memop: add a simple AR test
Date: Fri,  9 Feb 2024 21:45:39 +0100
Message-Id: <20240209204539.4150550-3-farman@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240209204539.4150550-1-farman@linux.ibm.com>
References: <20240209204539.4150550-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cVxdslRelh9t2e1uXQ5zRsESvKHfZdYA
X-Proofpoint-ORIG-GUID: 6KAtnlhjlZ1tzGP8yysYJqalED_Rd8Nb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_18,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 mlxlogscore=972 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402090151

There is a selftest that checks for an (expected) error when an
invalid AR is specified, but not one that exercises the AR path.

Add a simple test that mirrors the vanilla write/read test while
providing an AR. An AR that contains zero will direct the CPU to
use the primary address space normally used anyway. AR[1] is
selected for this test because the host AR[1] is usually non-zero,
and KVM needs to correctly swap those values.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/memop.c | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index bb3ca9a5d731..be20c26ee545 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -375,6 +375,29 @@ static void test_copy(void)
 	kvm_vm_free(t.kvm_vm);
 }
 
+static void test_copy_access_register(void)
+{
+	struct test_default t = test_default_init(guest_copy);
+
+	HOST_SYNC(t.vcpu, STAGE_INITED);
+
+	prepare_mem12();
+	t.run->psw_mask &= ~(3UL << (63 - 17));
+	t.run->psw_mask |= 1UL << (63 - 17);  /* Enable AR mode */
+
+	CHECK_N_DO(MOP, t.vcpu, LOGICAL, WRITE, mem1, t.size,
+		   GADDR_V(mem1), AR(1));
+	HOST_SYNC(t.vcpu, STAGE_COPIED);
+
+	CHECK_N_DO(MOP, t.vcpu, LOGICAL, READ, mem2, t.size,
+		   GADDR_V(mem2), AR(1));
+	ASSERT_MEM_EQ(mem1, mem2, t.size);
+
+	t.run->psw_mask &= ~(3UL << (63 - 17));   /* Disable AR mode */
+
+	kvm_vm_free(t.kvm_vm);
+}
+
 static void set_storage_key_range(void *addr, size_t len, uint8_t key)
 {
 	uintptr_t _addr, abs, i;
@@ -1101,6 +1124,11 @@ int main(int argc, char *argv[])
 			.test = test_copy_key_fetch_prot_override,
 			.requirements_met = extension_cap > 0,
 		},
+		{
+			.name = "copy with access register mode",
+			.test = test_copy_access_register,
+			.requirements_met = true,
+		},
 		{
 			.name = "error checks with key",
 			.test = test_errors_key,
-- 
2.40.1


