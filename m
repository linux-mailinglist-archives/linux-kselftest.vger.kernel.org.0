Return-Path: <linux-kselftest+bounces-21613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60609C0896
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 15:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 322E5B22652
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 14:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EEC1E049C;
	Thu,  7 Nov 2024 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C8OtgBkg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA8928F1;
	Thu,  7 Nov 2024 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988813; cv=none; b=KYV1aRzjY9LydMRzBJcLv9XCe32j+FJOWEYFhdgO8Hu363RS1dZRr8R02VPaumcEmsKvoAfx9431BK5UkocmfJAbPQfxB4/A+XSX3kkXOispVYbkLa7L390RvtH30cQguBvlJuOGn2el30d8f9ka2KEMLcV920cOO97oFKpNWNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988813; c=relaxed/simple;
	bh=sJ935eMUUjHWOSYwNX6SnA/FJrgaus3gC1OXryikwFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTwPNtPGccFPMv5ohhFn1KtgyzdRF3yy/CI+mXujcQxVD+N2yd6o3daK7i27i5wZMOr41fnv+p/gTCO0LxyK6NVsbkM5m7IeM6l+LNnQjkUkBv0P2sqvHwSB+16n3p7lAcnVRqW1B5HVOZ4In4C7+ipoYZs4Yo49t1Y47WMEYYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C8OtgBkg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7E9v9V031401;
	Thu, 7 Nov 2024 14:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RarTLkoppdvcghdSF
	0/FsQRpTX7IClGqjn7xbgrGp1U=; b=C8OtgBkg0h6Nyzx8UUqID8repUkG8M1SS
	L19+/cFln4011u8W+wHLFXRwcsXyuzYHgGO8UrETYHoycKRkFjUKWANs0QkiFpnz
	BLSSsnKc605TzRlxO8EeZ05Dq9seMDy7xh3E4Uzheaz0Y9p90rNMWEr5R7YKpcIR
	bFHySkSU054TPt4+EXi2zsUOiqv58ILtOfIxhJaAqVQKcsxTdNi/aGReKatdCOkn
	pPEcXikJpmy1+jZ1VVNUTF0U0A5a+jPfWK4uCwI3NDW02pMN4eNBvpV7edr/UtGJ
	1N3Q3IGlcTHFWNqyfuMmTN93TJU5KgkInWKlABkPFQmTqnQ7t8WyA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rxmrr4kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 14:10:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7DqQrg012243;
	Thu, 7 Nov 2024 14:10:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p14108dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 14:10:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A7EAYkw57213188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 14:10:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCC1920040;
	Thu,  7 Nov 2024 14:10:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A18C2004B;
	Thu,  7 Nov 2024 14:10:34 +0000 (GMT)
Received: from darkmoore.boeblingen.de.ibm.com (unknown [9.152.222.253])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Nov 2024 14:10:34 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, schlameuss@linux.ibm.com
Subject: [PATCH v7 4/5] selftests: kvm: s390: Fix whitespace confusion in ucontrol test
Date: Thu,  7 Nov 2024 15:10:23 +0100
Message-ID: <20241107141024.238916-5-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107141024.238916-1-schlameuss@linux.ibm.com>
References: <20241107141024.238916-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZNmuBy7E-XX0djP_BbmUvuP_3j3reAuN
X-Proofpoint-GUID: ZNmuBy7E-XX0djP_BbmUvuP_3j3reAuN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=867 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070110

Checkpatch thinks that we're doing a multiplication but we're obviously
not. Fix 4 instances where we adhered to wrong checkpatch advice.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/ucontrol_test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index 68d17b1ab128..71e76337d9dc 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -369,7 +369,7 @@ static bool uc_handle_insn_ic(FIXTURE_DATA(uc_kvm) *self)
  * * fail on codes not expected in the test cases
  * Returns if interception is handled / execution can be continued
  */
-static bool uc_handle_sieic(FIXTURE_DATA(uc_kvm) * self)
+static bool uc_handle_sieic(FIXTURE_DATA(uc_kvm) *self)
 {
 	struct kvm_s390_sie_block *sie_block = self->sie_block;
 	struct kvm_run *run = self->run;
@@ -397,7 +397,7 @@ static bool uc_handle_sieic(FIXTURE_DATA(uc_kvm) * self)
 }
 
 /* verify VM state on exit */
-static bool uc_handle_exit(FIXTURE_DATA(uc_kvm) * self)
+static bool uc_handle_exit(FIXTURE_DATA(uc_kvm) *self)
 {
 	struct kvm_run *run = self->run;
 
@@ -417,7 +417,7 @@ static bool uc_handle_exit(FIXTURE_DATA(uc_kvm) * self)
 }
 
 /* run the VM until interrupted */
-static int uc_run_once(FIXTURE_DATA(uc_kvm) * self)
+static int uc_run_once(FIXTURE_DATA(uc_kvm) *self)
 {
 	int rc;
 
@@ -428,7 +428,7 @@ static int uc_run_once(FIXTURE_DATA(uc_kvm) * self)
 	return rc;
 }
 
-static void uc_assert_diag44(FIXTURE_DATA(uc_kvm) * self)
+static void uc_assert_diag44(FIXTURE_DATA(uc_kvm) *self)
 {
 	struct kvm_s390_sie_block *sie_block = self->sie_block;
 
-- 
2.47.0


