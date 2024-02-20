Return-Path: <linux-kselftest+bounces-5078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CB485C76A
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 22:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C2B4B20CFE
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 21:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D480151CF9;
	Tue, 20 Feb 2024 21:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aawLrD9c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAE5151CCC;
	Tue, 20 Feb 2024 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463546; cv=none; b=GrvwBAJW5KbN9pPViZjDA44bs2UieLCKP/YOIvjz1+nPj6Q7TKKETfESATj0rMLf2MA6cipS/TtwbT3gzYCm2aLimB8ufqoEKhytpokNyIfI6CQK90l8eNFurkHOgdxCkPZZNn8Le0jgCnWbpXga0M0J6ntKpY5mEs2+ajr1AYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463546; c=relaxed/simple;
	bh=LXYj0J0AFG/thvSRyTGZUqOv+JIVwAw2S89O6yugFpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XeStAaQy2XxV9VtG/tqgefZNJz/T+KXeK5SxF1eL8u/3bP5ZWQPoRzgEWyI1hmI7KDui2FsxJtaalSe1s292JqEgKWqUqsNe1Ff+tfqCiS3um3QHBoRCiJHPxeANGy1qT1R9Cs5DdxuXezAUQhaec3M4OgyAt/N/oYsojqyNeIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aawLrD9c; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KL05Uj021714;
	Tue, 20 Feb 2024 21:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MJti5ASp33c3Q7C41cU4AJuOGo4cc1MZ0nh6NBIOpF0=;
 b=aawLrD9cSMPz55x5uMAFjKfx3BXap64w1rpS5aikQSiLAnD9RqFghgY8pdlEP67D94uV
 H/bhO5tkWxbunMYryZG8+O/IJs5irnQnSGHnlkYmFfQtbA/oQ0cns8cWG+vjkvJ0e1e9
 wLGgb58/9CkIJh973t2BdUmMvAz2Pe07Q3v4AKSAyiaxR2nrV2Tdt3m1eispip5uVFQh
 unGdtsk3SkS9FH9+zME2Yu88Ia9Kmrln/BF6arqaeqgAhi6CvD4tcC3Hj1fGC2Aw4Y2i
 rMuhWTl56r2jl/14B//Gtmaxz7qEToeefV66XzLVgn4jysOYLlQmPnrFnfV+eKEoI8c3 Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wd0jjmj88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 21:12:21 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41KKqE18000348;
	Tue, 20 Feb 2024 21:12:20 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wd0jjmj7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 21:12:20 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41KInwIB003596;
	Tue, 20 Feb 2024 21:12:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74tk687-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 21:12:19 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41KLCDOw12845580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 21:12:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1D002005A;
	Tue, 20 Feb 2024 21:12:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BD592004E;
	Tue, 20 Feb 2024 21:12:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 20 Feb 2024 21:12:13 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 3DA82E030D; Tue, 20 Feb 2024 22:12:13 +0100 (CET)
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
        linux-kselftest@vger.kernel.org, Eric Farman <farman@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v4 2/2] KVM: s390: selftests: memop: add a simple AR test
Date: Tue, 20 Feb 2024 22:12:11 +0100
Message-Id: <20240220211211.3102609-3-farman@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240220211211.3102609-1-farman@linux.ibm.com>
References: <20240220211211.3102609-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qDBH5e9QIAEbi7qL7pdi-AVQE9x6AdL5
X-Proofpoint-ORIG-GUID: neSjePMvyE0hKALCj2NdCxMyrgUlW5ve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200151

There is a selftest that checks for an (expected) error when an
invalid AR is specified, but not one that exercises the AR path.

Add a simple test that mirrors the vanilla write/read test while
providing an AR. An AR that contains zero will direct the CPU to
use the primary address space normally used anyway. AR[1] is
selected for this test because the host AR[1] is usually non-zero,
and KVM needs to correctly swap those values.

Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/memop.c | 31 +++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index bb3ca9a5d731..b6da8f71ea19 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -375,6 +375,32 @@ static void test_copy(void)
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
+	/*
+	 * Primary address space gets used if an access register
+	 * contains zero. The host makes use of AR[1] so is a good
+	 * candidate to ensure the guest AR (of zero) is used.
+	 */
+	CHECK_N_DO(MOP, t.vcpu, LOGICAL, WRITE, mem1, t.size,
+		   GADDR_V(mem1), AR(1));
+	HOST_SYNC(t.vcpu, STAGE_COPIED);
+
+	CHECK_N_DO(MOP, t.vcpu, LOGICAL, READ, mem2, t.size,
+		   GADDR_V(mem2), AR(1));
+	ASSERT_MEM_EQ(mem1, mem2, t.size);
+
+	kvm_vm_free(t.kvm_vm);
+}
+
 static void set_storage_key_range(void *addr, size_t len, uint8_t key)
 {
 	uintptr_t _addr, abs, i;
@@ -1101,6 +1127,11 @@ int main(int argc, char *argv[])
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


