Return-Path: <linux-kselftest+bounces-18067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5589997AB9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 08:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4AF7B294D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 06:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7F71531F0;
	Tue, 17 Sep 2024 06:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gMx448dR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADF014D2AC;
	Tue, 17 Sep 2024 06:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726555522; cv=none; b=XGREjEA+YMrsRrhR1jnM85McrQq08LDCe/EexHWowLAMGbLHbs42QdVC9gDOwSIWebBPGzQz0flq8NevqDb6aWy7/YE7vHuYfwHSd88c50Iipaz16dkZGb3dQXEtzAu6xANTO3YVkss2JceDlDTJh2ryS0aIfX8HFo4TlDvr/KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726555522; c=relaxed/simple;
	bh=Eab19z/TpNQrwMEK7VrIP5gGxGz9rkp8RvOn9laezVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6IzSqnGHPFG6F5h2IqVv8KPGxvwgD0kw2TC449WP7PT1JOeXsarhX6oZSZNo0HvGZOCnkrnNdNH7j2fFD0odEOlm9cHjSS94FzN/rvMFS3UBv23QR6ntAJ+9cvxRhII0p9lVj8j6wurjzEB2AF2M6oJJJtTgjM+xUidbNHR76o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gMx448dR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GIUxRe006129;
	Tue, 17 Sep 2024 06:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=eKug9P7/DihZm
	kaac97VF9PXuPLF7ofWaSK/7mkX3PE=; b=gMx448dRJ4wREQvL51JvUmXWCZiyr
	14TN1jtfSCjOhWHlMdTy8XyfRZ86oU7TefWz/5V4nTbqappnFWDowduwXqVBqMlL
	B8QswXFF/vfzgMnkeQ+S/Nc32daD8yWpAkww7PStGKbvMMz22QwduZqteqhM7kqy
	ZEJfQEeXAmG9h15jids5Q2thagbt2ojLeXAOiF/fGTFT96KOX/O37S/zw6B6XRMi
	jpKsZB34tQdvGv2EzE85kub2PBD7ZmCXh/0fYppTF93IUq3sABQhbWM14a/FbzWw
	5PP6n+YF9k0cx6wVaKsFdNlsiLA6DMFjlSb+GXcaIBafXw3R6Fq0JfGRQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n41adsb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 06:45:14 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48H6jEdk031738;
	Tue, 17 Sep 2024 06:45:14 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n41adsax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 06:45:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48H5RMTS000637;
	Tue, 17 Sep 2024 06:45:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41nn713pk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 06:45:13 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48H6j9pY56361382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 06:45:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9F1C20043;
	Tue, 17 Sep 2024 06:45:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EDFA20040;
	Tue, 17 Sep 2024 06:45:09 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.179.17.198])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Sep 2024 06:45:09 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>, schlameuss@linux.ibm.com
Subject: [PATCH v4 4/4] fixup! selftests: kvm: s390: Add VM run test case
Date: Tue, 17 Sep 2024 08:44:56 +0200
Message-ID: <20240917064456.210839-5-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917064456.210839-1-schlameuss@linux.ibm.com>
References: <20240917064456.210839-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y9v0DmzbHOuB7N3Iz-NCjcHqgHiGy0ME
X-Proofpoint-ORIG-GUID: 4-JElDKybZarhXAk6t3t6WYBqltWZQxr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_02,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 mlxlogscore=906 bulkscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409170049

Fix pointer function arguments whitespaces.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/ucontrol_test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index 1f1c58f5ec2f..83061db79c83 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -330,7 +330,7 @@ static void uc_handle_exit_ucontrol(FIXTURE_DATA(uc_kvm) *self)
  * * fail on codes not expected in the test cases
  * Returns if interception is handled / execution can be continued
  */
-static bool uc_handle_sieic(FIXTURE_DATA(uc_kvm) * self)
+static bool uc_handle_sieic(FIXTURE_DATA(uc_kvm) *self)
 {
 	struct kvm_s390_sie_block *sie_block = self->sie_block;
 	struct kvm_run *run = self->run;
@@ -359,7 +359,7 @@ static bool uc_handle_sieic(FIXTURE_DATA(uc_kvm) * self)
 }
 
 /* verify VM state on exit */
-static bool uc_handle_exit(FIXTURE_DATA(uc_kvm) * self)
+static bool uc_handle_exit(FIXTURE_DATA(uc_kvm) *self)
 {
 	struct kvm_run *run = self->run;
 
@@ -379,7 +379,7 @@ static bool uc_handle_exit(FIXTURE_DATA(uc_kvm) * self)
 }
 
 /* run the VM until interrupted */
-static int uc_run_once(FIXTURE_DATA(uc_kvm) * self)
+static int uc_run_once(FIXTURE_DATA(uc_kvm) *self)
 {
 	int rc;
 
@@ -390,7 +390,7 @@ static int uc_run_once(FIXTURE_DATA(uc_kvm) * self)
 	return rc;
 }
 
-static void uc_assert_diag44(FIXTURE_DATA(uc_kvm) * self)
+static void uc_assert_diag44(FIXTURE_DATA(uc_kvm) *self)
 {
 	struct kvm_s390_sie_block *sie_block = self->sie_block;
 
-- 
2.46.0


