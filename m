Return-Path: <linux-kselftest+bounces-4881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC7E858813
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 22:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16F71F24049
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 21:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DF0146003;
	Fri, 16 Feb 2024 21:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U+kp0rGC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751F9145FF8;
	Fri, 16 Feb 2024 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708119390; cv=none; b=E5VpTTXKLXPS2RhSG9/gdOX6FwR8rnceput7szflWnCtXQbqdCfHtnFKVlaRXVRtt1dWP+4Zs65WuTlBMBNjPsfX/hAnYnJEYZaM8Pkp6fD98uTKYJPuKog54Pvh7slKkfE83lS9w7W1GhAp2sbZEpWzCGRswpA7KIvYCHgFgV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708119390; c=relaxed/simple;
	bh=wFHRWFNDjByZdkECXDT5AIayYLGLuLsqg4VpCTDXaxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qd8+E7++WX6OQShV2/nWD4uV7TAOMu3t5gqgUqwZhDk8yCvwylqdXb2buoW7s9CiSzS+oh3HhFc1kcOCSwiHg6KzIwILh+73yezuT0EciRKaw1/dY/97e0K1x5wwpK7QhEUypDTwGTuvJvdAFA8oHoda34Lza+8QxBZG4E+4ojE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U+kp0rGC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GJw0QW026123;
	Fri, 16 Feb 2024 21:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=naSuFLOBCRRosC0sA+aZ1BhtQ2Dg+R11DdlDmvqw/e4=;
 b=U+kp0rGCuy2PTZ3j/J1afROGi761NyJwXb3kNkFQwsNITjyjgre++UwA2CX0VLMmYUa1
 8pDurd+zztGUfVaup8YXbK9Llt1+//iI/Hl4hQ2/AB+I0QgnqAjE+CXPUogiHPlpPpw0
 H1KY4ESrmVJi87vTq/P2MILSmTI7YxOYOuPhN4U2b4FGUiPs0idyzIz+5HjvjajNCt68
 URUITU59mKTRGHQSx4AAIcEyKwLL00azBlK4wGgb2CiiUbU74XdyS6cTWs/zRFy9n1D6
 +NtXHrnu4TXeo8ZiZ7nJ9g5v/JDlN9PVtSkYW+Adm3a/9BLT/Cgq+jmySvx6YM9nbeGV 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3waeau1nu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 21:36:24 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41GLX5A7013625;
	Fri, 16 Feb 2024 21:36:24 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3waeau1ntx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 21:36:24 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41GKPN1P009935;
	Fri, 16 Feb 2024 21:36:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6p63de7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 21:36:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41GLaI9h40305162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 21:36:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AD9320040;
	Fri, 16 Feb 2024 21:36:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 540102004E;
	Fri, 16 Feb 2024 21:36:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 16 Feb 2024 21:36:18 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 03F5BE008F; Fri, 16 Feb 2024 22:36:18 +0100 (CET)
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
Subject: [PATCH v3 2/2] KVM: s390: selftests: memop: add a simple AR test
Date: Fri, 16 Feb 2024 22:36:16 +0100
Message-Id: <20240216213616.3819805-3-farman@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240216213616.3819805-1-farman@linux.ibm.com>
References: <20240216213616.3819805-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FdhAZ1gjkpSwDYIrmbs8ZojpmQNHJ0-Z
X-Proofpoint-ORIG-GUID: W35zk3rRof34rMml9baE-PDwKWebts6F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_21,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402160169

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


