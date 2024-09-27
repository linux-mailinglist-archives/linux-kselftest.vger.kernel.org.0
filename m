Return-Path: <linux-kselftest+bounces-18443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B01D1987DC8
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 07:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2B71F22581
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 05:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B1714A4C0;
	Fri, 27 Sep 2024 05:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jnV5hrdi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0155B2F2E;
	Fri, 27 Sep 2024 05:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727413703; cv=none; b=ZTnBQqEGSHXf73DFIFSQCldQfVVv1CtFPRDnyFtcFu63qMhal47hiovkuwhe/7iNAYAinNY1THaqTCHZTM/qTum8w+pQdfz0uADZF+IsUrZlMHnE9A+57DTXbSEVSHeMWc856a/nK1A7ahkWMxA0ftE3Eni8kr9vFUhclXyM1ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727413703; c=relaxed/simple;
	bh=FpiLuwfpOyRVMVZloHBShMMbqSoFyooVGxqn5qfDJeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K8pE+V5XxMMempTux0ET3aKg7w7u+0wF48HS3iMfM0S8vl+GorstvHn8Fslzbd2VvWL6pTABR5WzIfRyw511LTp4yjeQ6U0EVV3t23z3eMbwuUXT/HAMtsBkWoHoQ41MdoSQppaMBM0GsRZGHl76V4ieWJ3booV9qb5CCwukLSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jnV5hrdi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R41dHC004377;
	Fri, 27 Sep 2024 05:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=9CApFunvT3sS6/YT43VCSzj7Jy
	IFMaSoyJEvAHbUpvM=; b=jnV5hrdi7DVHqUOjDvmrhKLHhLIbj6UDFH53B2wn9u
	Vr92oCiTp6VWyteBiVtr/FpT74/84MVbFWeDrB5YnPJDdWOp8yrPqa+1XFNCEUwo
	xGNQh3GlG8rBD6uVem40ozWiM4pXfPNatjFhNRpKUikIGhyJXehDiKEMwYOVQ1eh
	4hKNND4eoOrhAkKyPFjAPPPJxFroXeZ/8ApQ4NTf1jE/MjegXPYAC+7BEVYK71iY
	0DURNa8/39HescwAxlP7H+Oe0JuvRm62R/iNEWkfmmP31E7nCZLaObkR2ByLoR/Y
	2Bm+4lM01xFwDHl6PvfkYM6kn19QEErWs/goHYlLXqTA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snnatagj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 05:07:58 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48R57w9Q006674;
	Fri, 27 Sep 2024 05:07:58 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snnatagh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 05:07:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48R0WxJ6000636;
	Fri, 27 Sep 2024 05:07:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41t8fv35ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 05:07:56 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48R57tkc52822414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 05:07:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B0CD20043;
	Fri, 27 Sep 2024 05:07:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75C0D20040;
	Fri, 27 Sep 2024 05:07:53 +0000 (GMT)
Received: from ltczz402-lp1.aus.stglabs.ibm.com (unknown [9.40.194.31])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Sep 2024 05:07:53 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Kees Cook <keescook@chromium.org>, Mark Brown <broonie@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        usama.anjum@collabora.com
Subject: [PATCH] selftests/mm: Fixed incorrect buffer->mirror size in hmm2 double_map test
Date: Fri, 27 Sep 2024 00:07:52 -0500
Message-ID: <20240927050752.51066-1-donettom@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u3hJP0oEm6bBvR-I7cUGFJWASJe_0GDW
X-Proofpoint-ORIG-GUID: lbJ2JrcLKLuXquvqnZftyDtOSMpyQfrK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_02,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=775 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409270030

The hmm2 double_map test was failing due to an incorrect
buffer->mirror size. The buffer->mirror size was 6, while buffer->ptr
size was 6 * PAGE_SIZE. The test failed because the kernel's
copy_to_user function was attempting to copy a 6 * PAGE_SIZE buffer
to buffer->mirror. Since the size of buffer->mirror was incorrect,
copy_to_user failed.

This patch corrects the buffer->mirror size to 6 * PAGE_SIZE.

Test Result without this patch
==============================
 #  RUN           hmm2.hmm2_device_private.double_map ...
 # hmm-tests.c:1680:double_map:Expected ret (-14) == 0 (0)
 # double_map: Test terminated by assertion
 #          FAIL  hmm2.hmm2_device_private.double_map
 not ok 53 hmm2.hmm2_device_private.double_map

Test Result with this patch
===========================
 #  RUN           hmm2.hmm2_device_private.double_map ...
 #            OK  hmm2.hmm2_device_private.double_map
 ok 53 hmm2.hmm2_device_private.double_map

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 tools/testing/selftests/mm/hmm-tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
index d2cfc9b494a0..141bf63cbe05 100644
--- a/tools/testing/selftests/mm/hmm-tests.c
+++ b/tools/testing/selftests/mm/hmm-tests.c
@@ -1657,7 +1657,7 @@ TEST_F(hmm2, double_map)
 
 	buffer->fd = -1;
 	buffer->size = size;
-	buffer->mirror = malloc(npages);
+	buffer->mirror = malloc(size);
 	ASSERT_NE(buffer->mirror, NULL);
 
 	/* Reserve a range of addresses. */
-- 
2.43.5


