Return-Path: <linux-kselftest+bounces-19713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ED699E145
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 10:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304E5282405
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 08:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB661CF5EE;
	Tue, 15 Oct 2024 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bStxhZ+D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412011CC168;
	Tue, 15 Oct 2024 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981479; cv=none; b=V1keqHdMAGL12SdPCIlVz+6bvMNBz73VDgpojAKnC9h6PLDxzin08WP6FrP4G3x4S0SOzHIZ5rNiUZRnIly+wIIBPyEMcNkvWsVGw3xYYdV7QU/w+qffJDglsblHdwScNNGUQuZ6u4LJ74qDmYp2LNfOx0QhRFDAwOt5+/fuetA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981479; c=relaxed/simple;
	bh=5Q2GdaL6MtcHTUGiMw/42HdcOusoEc8koRg7nG3y+/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abyByBd6PzMA2YGM7FWlOixrZ44uNE3EgzTK1pxoHAXnpiZ/N6N9rxuGTFQFiQuBVcipOWkmMNfxwIUitVxZgmtragCQhDMEy+aBE53zEfPCt1RoJQzexuz6lH9l0vdCTicKD5qfl/ItzOX5olO77Bzyny4d5owfx57MafbyLWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bStxhZ+D; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F8PGQo023683;
	Tue, 15 Oct 2024 08:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KGN2m6haOJh3gMcXk
	VAFFzZbMXUorKeCd/nxut9hNmM=; b=bStxhZ+Dei8skAw4j9O+UmrDFNXyXUkl3
	PNK1jEGMNeSD3tMrTdy8uo5FMot33Ogb8k/c47C7h96PMovelvN2c/cAqZI04KZx
	RlI66xonr8JAr+Gc4R+Yf6NJ57eD79XcCMHnLWKBNW2C0utmfpr7TJAjUYpb+kwX
	AGyK5E/+/0UcqjZu3u8N1Vo7hqWHbtmxnIDneuQHkXHEaR+OvMizw1SM+UcWNBW3
	VPn/znm95H3N2TMW/67xHmpnu+97mCr/FoP3sdzSmfi/kHNlqy1GGMxTJbQrn1FA
	JiSr+9JhI5PELpvxb5c1qcK0oO1xoaar1ijXPtZWq54UTP6ks8NVg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429mv4r1wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 08:37:56 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49F8brcs019934;
	Tue, 15 Oct 2024 08:37:55 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429mv4r1wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 08:37:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49F8FLif007025;
	Tue, 15 Oct 2024 08:37:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284xk2nqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 08:37:54 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49F8bo1855640558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 08:37:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BED920040;
	Tue, 15 Oct 2024 08:37:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1AC220043;
	Tue, 15 Oct 2024 08:37:49 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.49.63])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Oct 2024 08:37:49 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, schlameuss@linux.ibm.com
Subject: [PATCH v6 4/5] selftests: kvm: s390: Fix whitespace confusion in ucontrol test
Date: Tue, 15 Oct 2024 10:37:43 +0200
Message-ID: <20241015083744.761838-5-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015083744.761838-1-schlameuss@linux.ibm.com>
References: <20241015083744.761838-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QvVLymaP34C6Bfw8ExjnASgdGjoQeO4C
X-Proofpoint-ORIG-GUID: ddxqYeMHzJMNWh-3UTACOTSu8Ro1TXj_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 mlxlogscore=922
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150056

Checkpatch thinks that we're doing a multiplication but we're obviously
not. Fix 4 instances where we adhered to wrong checkpatch advice.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/ucontrol_test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index ae077bf838c8..db8776269373 100644
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


