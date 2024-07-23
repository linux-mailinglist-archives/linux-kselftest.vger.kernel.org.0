Return-Path: <linux-kselftest+bounces-14074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 143D4939DFA
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 11:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E2A1C21B25
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 09:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD0714F9D6;
	Tue, 23 Jul 2024 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GrXtki8r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552C114EC4A;
	Tue, 23 Jul 2024 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721727134; cv=none; b=c6sNnoVr38XYI9QyTkleXslA0uXuGUQSs3oGmLO0rSlMraH40YPT6QrarKIRaeUZASaFDQZ8yDCSGaFvRj+pIkL2bK57e+AuwJwTDJjHjR02E5JE0/lCYv9l+h2fhhqWkVgbVkb+v8evXbG7lshVl/33pLWFeM6enBxwkgez4DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721727134; c=relaxed/simple;
	bh=s1fUKLDRQ/uLhu6dNjIqrQREiEFxn7PUyv9db1yRMoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZRyKnvD4+7PqNl9RoUkAs7+IZINfNLLwPGqzsy8rDPMXBAFOPxtRoMnG1QbrmtUQk88QdNDzKj7tSERuyLBgJUWwwECDeZ8i72lhIGpwH9Di6l08ag4UXdO+27QFFOJzaj8v/aTpsp5RAgn/w6wisS2HnwcbDVYPicfiJ51FFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GrXtki8r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N8utjr007012;
	Tue, 23 Jul 2024 09:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=l244AP4em60bD
	g8/YP4QDj1GR0JC94JWs3TcfyUsPxA=; b=GrXtki8rOWr6r/X3kImnM6Z1c0G2K
	i6s3pXPD8O/UQaSRGui+ODdVT/zCSgALBuxhXnxtRE9iUgs/vQtKtI81dBDuH4Uq
	++SdDIm33O8/VWCV2H8CXubLnBH4M/N57iop+q/g+R6mVNwJOXQ2g+T4NF/UNGT+
	D3WEFdjScDEoE5tYAFpWR93KEKOeNYjJH+Qobe7iwsUof4lZa/5G9O7R/0gY4IwN
	dBXQxEZHI9KyQ5KaVSJjbnlJMztb9wvZWa3xChrCxYb7ExITH1x4jr9EWndc/rsB
	f8QNt89RO+6rLsPXYXZE/mPWwKZ5pmVJ9jTmo65ItLKlOC31V8icY0SDQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j3rv0s3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:32:11 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46N9WAdt028669;
	Tue, 23 Jul 2024 09:32:10 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j3rv0s3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:32:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46N5WuC9005773;
	Tue, 23 Jul 2024 09:32:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gy2p9nud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:32:09 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46N9W3Pi11469122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 09:32:05 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CC122006A;
	Tue, 23 Jul 2024 09:32:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0203E20040;
	Tue, 23 Jul 2024 09:32:03 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.28.84])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jul 2024 09:32:02 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v2 10/10] s390: Enable KVM_S390_UCONTROL config in debug_defconfig
Date: Tue, 23 Jul 2024 11:31:26 +0200
Message-ID: <20240723093126.285319-11-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723093126.285319-1-schlameuss@linux.ibm.com>
References: <20240723093126.285319-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YtGWH6HaBU4BcyNc7oNATo6l3V-GX6J3
X-Proofpoint-GUID: 8NTgXoY4LankCkk-6fmJ07HIiOblmOna
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=747 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230069

To simplify testing enable UCONTROL KVM by default in debug kernels.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/Kconfig.debug | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/Kconfig.debug b/arch/s390/Kconfig.debug
index c4300ea4abf8..4798dded6d76 100644
--- a/arch/s390/Kconfig.debug
+++ b/arch/s390/Kconfig.debug
@@ -20,3 +20,6 @@ config CIO_INJECT
 	  This option provides a debugging facility to inject certain artificial events
 	  and instruction responses to the CIO layer of Linux kernel. The newly created
 	  debugfs user-interfaces will be at /sys/kernel/debug/s390/cio/*
+
+config KVM_S390_UCONTROL
+	def_bool y
-- 
2.45.2


