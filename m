Return-Path: <linux-kselftest+bounces-17734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40720974D7F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 10:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00AE9288EBF
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 08:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8070716DC12;
	Wed, 11 Sep 2024 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rhsSsMhw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5BB153BE8;
	Wed, 11 Sep 2024 08:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044627; cv=none; b=C5JwVb7tcpwKvDIzQPIETJrw+TWJAbtqHmHUvh87iaDsH1onOJ9obyWq4T+x0o5fEgKcf75qM/drhib2i0aBhGWHFhaN+sflaFcgArOiZo/pUfzog3gHIv0dMnCFeiwBRbmjEhAlfG42ubHZr6ZIBkUoIHFWH99x0TPJCPpscuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044627; c=relaxed/simple;
	bh=me5e7I5tQPw8veUZJwu13VUQhEb78fKv3wggn7e87LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tm5mpfmIYHyt2/TvsQLKtnky9D/QLp4QL9Rhwu16ySFM0gLGyhwMuITiK685D1XcsBNIjItWEpItSV7yZlr0Mh4ErmDt1+X8ZPXpeBOnRtQ1KnRF2BInRcvXYjZHNmAISIsoGv5jEJt1MN5KK64vfEsnOP/QjL7bmZ4+315vc0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rhsSsMhw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AMIUOK004560;
	Wed, 11 Sep 2024 08:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=gAZkRRJoVvFwd
	vmSptJKmbdeOFyVBUaFLcjNIa6pCuE=; b=rhsSsMhwqVPEa8wx7qgQ1yvuoq+nK
	nPtAg8OeBtqf6PYVtAaYcZyTaq26nRqfaQXKhJimFzuJ6UmZdSeZ5C8x3y3KBoNa
	/hnhuis4xh8nygdEnicf1LQseflgb13t7DRHz5ZKkbC00gqO3GLyxXtLFAZcCG/1
	l/n+03AwFf/tOLWgi9KBGk6+QfH4RgQo3MA8ZTzmIsVpQhMvFbZm5iNNLs9n7YJx
	Ye9mrp7wFC3ftX3GROQrkk8jYmEQRRrcgu+IwQyaxvp8tuQM5KocpIDcOMzu89Sh
	BtZlqtDNvndX1vX3qUmPpsVEpB7Q4aJmQSccObufA2RzcJHjrKNby3Vag==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegwvhqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 08:50:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48B6QNbx003123;
	Wed, 11 Sep 2024 08:50:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h15u0fns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 08:50:20 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48B8oGeW55378188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 08:50:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D583D2004E;
	Wed, 11 Sep 2024 08:50:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90FC820043;
	Wed, 11 Sep 2024 08:50:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Sep 2024 08:50:16 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Shuah Khan <shuah@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 2/2] selftests: vDSO: fix vdso_config for s390
Date: Wed, 11 Sep 2024 10:50:15 +0200
Message-ID: <20240911085015.3581722-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911085015.3581722-1-hca@linux.ibm.com>
References: <20240911085015.3581722-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -8vW4LDJFun_ZYAYg8cmREy-UJNXcKz5
X-Proofpoint-ORIG-GUID: -8vW4LDJFun_ZYAYg8cmREy-UJNXcKz5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=606
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409110064

Running vdso_test_correctness on s390x (aka s390 64 bit) emits a warning:

Warning: failed to find clock_gettime64 in vDSO

This is caused by the "#elif defined (__s390__)" check in vdso_config.h
which the defines VDSO_32BIT.

If __s390x__ is defined also __s390__ is defined. Therefore the correct
check must make sure that only __s390__ is defined.

Therefore add the missing !defined(__s390x__). Also use common
__s390x__ define instead of __s390X__.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 tools/testing/selftests/vDSO/vdso_config.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_config.h b/tools/testing/selftests/vDSO/vdso_config.h
index 740ce8c98d2e..722260f97561 100644
--- a/tools/testing/selftests/vDSO/vdso_config.h
+++ b/tools/testing/selftests/vDSO/vdso_config.h
@@ -25,11 +25,11 @@
 #define VDSO_VERSION		1
 #define VDSO_NAMES		0
 #define VDSO_32BIT		1
-#elif defined (__s390__)
+#elif defined (__s390__) && !defined(__s390x__)
 #define VDSO_VERSION		2
 #define VDSO_NAMES		0
 #define VDSO_32BIT		1
-#elif defined (__s390X__)
+#elif defined (__s390x__)
 #define VDSO_VERSION		2
 #define VDSO_NAMES		0
 #elif defined(__mips__)
-- 
2.43.0


