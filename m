Return-Path: <linux-kselftest+bounces-14933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6256194AD50
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 17:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D2A28357C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 15:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733CE13C9C8;
	Wed,  7 Aug 2024 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QiDOEZXg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5277B137905;
	Wed,  7 Aug 2024 15:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723045557; cv=none; b=JX3AA7U8QClqlGW6M+fM3HonH5GoIogaoxhbBuGKnkITlcywMzSc0CZGpQ+9kTclxf0EXXGLwTEYIZ9Mx4qyKQUnWmcd9ajsg145hz6SFv18iF34JwqC46WZQxLiopC7ZzlqQdVTzoMRq0X2RpszyxqBcpw2ev2BMmr6Civ4W4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723045557; c=relaxed/simple;
	bh=UTJTTwakb0Y4F7S7LSoa6aFHpamUUlndwuz8rJPyuuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=io++AVFvUxx1QFMfyrIQLT1CApyDHuxLdwcyYjpTeb10k8yYnOijsx4dRbZIzTzgDFeUjLzO+VcWiZuiO1jrTZzPr0Xmsb6/TjnuOWfWRoQZY92K/hCF/lzAEkeOML9odVk6Jl74poFBv5gr9pNZBaUC0Wc61yNUUY/5LQwfWEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QiDOEZXg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4772P2J0014888;
	Wed, 7 Aug 2024 15:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=MQSuH22OjStRM
	MP7ECvV1lS5lhnW+ejlhB0cuzypbEs=; b=QiDOEZXgI+sTtma+y2Bg8J+8Rlr50
	k8BYG2eiY52Gft0M1STHjW3pO1L4aWqgKgxn6B/Rs0cZ4EUKtidawo0EXdHQELxW
	d6mY/fc21pljdPavB/t6vavYO31QXGv7j0xZBnZtjDjuHbprc6nZ3oj3/3iBIVWE
	hWlV8QueSgu/KdU/STnZNv4j22fW1s0bTM7cyiUS10aDwPX6iX6+yMq1bDU1kdwo
	Xwht4il1CeHXG3+uaqdJa1q3Ozy4VdnAo3+Zz61qb//u7XsYIj/O34AE/mJndF6K
	dGLNbEwCcSRz6n0pB3mJ9qcybVK6jfgB2I0HZv710+DC3BRPJMIFjbiJg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40unmk2xyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 15:45:46 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 477Fjj1s015156;
	Wed, 7 Aug 2024 15:45:45 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40unmk2xyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 15:45:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 477EiDnJ024311;
	Wed, 7 Aug 2024 15:45:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40sy90sugv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Aug 2024 15:45:44 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 477FjcXP52494730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Aug 2024 15:45:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A44AA20043;
	Wed,  7 Aug 2024 15:45:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58D3E2006A;
	Wed,  7 Aug 2024 15:45:38 +0000 (GMT)
Received: from darkmoore.boeblingen.de.ibm.com (unknown [9.155.210.150])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Aug 2024 15:45:38 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>, schlameuss@linux.ibm.com
Subject: [PATCH v5 10/10] s390: Enable KVM_S390_UCONTROL config in debug_defconfig
Date: Wed,  7 Aug 2024 17:45:12 +0200
Message-ID: <20240807154512.316936-11-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807154512.316936-1-schlameuss@linux.ibm.com>
References: <20240807154512.316936-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JVKTwZNFdsRintbIq4VALojYHZhFSHBi
X-Proofpoint-GUID: V5Nbv0JJfkKkxs7fKGxtLLR3ByV_fOYN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_11,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=932 impostorscore=0 spamscore=0 mlxscore=0
 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408070107

To simplify testing enable UCONTROL KVM by default in debug kernels.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/configs/debug_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index ea63a7342f5f..0c989caed19a 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -59,6 +59,7 @@ CONFIG_CMM=m
 CONFIG_APPLDATA_BASE=y
 CONFIG_S390_HYPFS_FS=y
 CONFIG_KVM=m
+CONFIG_KVM_S390_UCONTROL=y
 CONFIG_S390_UNWIND_SELFTEST=m
 CONFIG_S390_KPROBES_SANITY_TEST=m
 CONFIG_S390_MODULES_SANITY_TEST=m
-- 
2.45.2


