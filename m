Return-Path: <linux-kselftest+bounces-19217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8156999411B
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 10:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34A21C229AE
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 08:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6281B9845;
	Tue,  8 Oct 2024 07:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qHZ3T8JO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D091C9B6B;
	Tue,  8 Oct 2024 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373396; cv=none; b=gOwW4LOG9F3x2gNsXGXKDK2Gm4r2TdMxzrDVVP7aFGAl/QUTFQcoaiNUi4WgUvPIAYH0O2wHF7X4KLyY6U22uwxgGEmSNmdjQfxE7x5O6uFBED08LQvxAcxv+dVomKN9hKHgVlDxbD+lfVjwyXPdS92x/Fg4XKrrSWE0Pz8PZQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373396; c=relaxed/simple;
	bh=Ay7iCPV5oDwVSKXFn3TQ2zrchzSwH75EjcMWM62k2lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAcIJ5Gr+Wuk5xTeT39bT2LdfZiSurWwupxckHuwgaVQvQOWUupZsCAajFuuov6pynmu903Fn6+Ydmq54CKKIKmixOV7BgyYt0xqM5ysRQRyJUVtPlom6A/u07MXY3ij3KkRGeStw8dPcYN7Sol/yq3+99nUldZmpoeWQc7lYMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qHZ3T8JO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4987Nptf014873;
	Tue, 8 Oct 2024 07:43:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=k7ze8KrQcsxk7
	wVQdziS6wI/Tb5cszzeVEsi/zyrBww=; b=qHZ3T8JOG7dW3p1Cg1Q042TSZqHzC
	f6RJ5w8AvL07X/oSrCItPlu/R4u6qIAK6JEaKepS+f+kH4M8NNd6aOZdF82kLmmP
	NWrU/ZxS6Lx+pllYv7G6DX2j0iX/RRmDEZdvPRKdcVLnLDMXIEX/7EZ3HG9mib6F
	5E6P+waT2KVmZmBuOnSzXLDPaHAar4A93Fbn76EXKqE1Jrlwz7jbgLH2ZUKBAAnd
	oOM1cQO7c39uwuLkg8z7CWDrS3znwqqDZl+CMZhZfGY/d+wWUokNSfTc1HPFri7m
	ztCJzWLaijfwWNa9PDPbJUc89xQp03UKKZov8IAYkE8wQh2rU6N4NffnQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4250a1r2h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 07:43:11 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4987hBBv029395;
	Tue, 8 Oct 2024 07:43:11 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4250a1r2h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 07:43:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4986hES5022851;
	Tue, 8 Oct 2024 07:43:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423h9jts5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 07:43:10 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4987h6Hp54985154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Oct 2024 07:43:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C465A20043;
	Tue,  8 Oct 2024 07:43:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D61F20040;
	Tue,  8 Oct 2024 07:43:06 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.23.149])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Oct 2024 07:43:06 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, schlameuss@linux.ibm.com
Subject: [PATCH v5 4/4] selftests: kvm: s390: Fix whitespace confusion in ucontrol test
Date: Tue,  8 Oct 2024 09:42:53 +0200
Message-ID: <20241008074253.370481-5-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008074253.370481-1-schlameuss@linux.ibm.com>
References: <20241008074253.370481-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N6KwmsHj4wuBWh5L9iVpMrNWh0eSOQDl
X-Proofpoint-ORIG-GUID: 6d7BWzKctDhX97ytStH-eO2KFKI4KDH-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_05,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=923
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410080047

Checkpatch thinks that we're doing a multiplication but we're obviously
not. Fix 4 instances where we adhered to wrong checkpatch advice.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/ucontrol_test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index 5185620a21eb..8f071eca79ff 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -329,7 +329,7 @@ static void uc_handle_exit_ucontrol(FIXTURE_DATA(uc_kvm) *self)
  * * fail on codes not expected in the test cases
  * Returns if interception is handled / execution can be continued
  */
-static bool uc_handle_sieic(FIXTURE_DATA(uc_kvm) * self)
+static bool uc_handle_sieic(FIXTURE_DATA(uc_kvm) *self)
 {
 	struct kvm_s390_sie_block *sie_block = self->sie_block;
 	struct kvm_run *run = self->run;
@@ -358,7 +358,7 @@ static bool uc_handle_sieic(FIXTURE_DATA(uc_kvm) * self)
 }
 
 /* verify VM state on exit */
-static bool uc_handle_exit(FIXTURE_DATA(uc_kvm) * self)
+static bool uc_handle_exit(FIXTURE_DATA(uc_kvm) *self)
 {
 	struct kvm_run *run = self->run;
 
@@ -378,7 +378,7 @@ static bool uc_handle_exit(FIXTURE_DATA(uc_kvm) * self)
 }
 
 /* run the VM until interrupted */
-static int uc_run_once(FIXTURE_DATA(uc_kvm) * self)
+static int uc_run_once(FIXTURE_DATA(uc_kvm) *self)
 {
 	int rc;
 
@@ -389,7 +389,7 @@ static int uc_run_once(FIXTURE_DATA(uc_kvm) * self)
 	return rc;
 }
 
-static void uc_assert_diag44(FIXTURE_DATA(uc_kvm) * self)
+static void uc_assert_diag44(FIXTURE_DATA(uc_kvm) *self)
 {
 	struct kvm_s390_sie_block *sie_block = self->sie_block;
 
-- 
2.46.2


