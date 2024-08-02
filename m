Return-Path: <linux-kselftest+bounces-14722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA1594613A
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 18:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69EEB1F21A6A
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Aug 2024 16:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E52166F0E;
	Fri,  2 Aug 2024 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NG27yxeh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97C81A34C7;
	Fri,  2 Aug 2024 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614398; cv=none; b=KHITXteT5ISUGE2rUJu+OzISwYJnuSUZ6vL+CPycjz4SbZwbEmb98i1mKPlgjM3YWpwNexxK+yNEFysyjCpZdk+Fv34w2rmBluhAqByV/Dn3nv86sgZjOtQYcIIVyyoB1w8pDlwSqru7S0E5fZ8kDM5yHHvcqHm95d6d5IzRL7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614398; c=relaxed/simple;
	bh=UTJTTwakb0Y4F7S7LSoa6aFHpamUUlndwuz8rJPyuuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNzfApD7rvF1AXkpXCSAUh6tYAGK48h32YNFle3wOrldIsUTTpugQ2INgw211HaXA6QJxOsz6OgLpajn76IGXg+LkjwPCXmflqcOJ/1ab3/gH//u2vovZkG3vXRvgUICN9TZ0WHiCjPb1K0iyeGemJsWgEXuIGPqwgAYPQDn0Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NG27yxeh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472Fwlus002142;
	Fri, 2 Aug 2024 15:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=MQSuH22OjStRM
	MP7ECvV1lS5lhnW+ejlhB0cuzypbEs=; b=NG27yxehgKfqDazbxzrMS98m5DRQp
	Cq0HVV7cSUCUzP7TwNCtG97bSWLQOE3MBzPzshIP8YMfFdMqvEh1bdpWwvkAQ942
	9sRFbEXVP+z6RQqs2nbFeqzP50vncYwuiY1O9l7z6XBf0TGXoz+dMQoRhR/glJV1
	tSQrhb4hxvG1rjg1PlupPEnREIW47BREHdL4/2TmRimQjS8NRVEOjhoF6Y1udX8c
	Cyxp7TG7B/yEqUZYP2+ozaMYh36KjFEgLaQg+F434UXAYoJMeVLswCPqFgbuTJgV
	mVgQxF2MCtCpp+yqJsn9lBXBb9jvJzt6DQM0GTy3bqPWC068RLAcr7jfw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40s2jm002f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 15:59:53 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 472FxqV3003413;
	Fri, 2 Aug 2024 15:59:52 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40s2jm002d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 15:59:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 472EYJRK011129;
	Fri, 2 Aug 2024 15:59:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40ncqn7wcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 15:59:51 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 472Fxk5f48824778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 15:59:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 261332004D;
	Fri,  2 Aug 2024 15:59:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82F2F20040;
	Fri,  2 Aug 2024 15:59:45 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.84.102])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Aug 2024 15:59:45 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v4 10/10] s390: Enable KVM_S390_UCONTROL config in debug_defconfig
Date: Fri,  2 Aug 2024 17:59:13 +0200
Message-ID: <20240802155913.261891-11-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802155913.261891-1-schlameuss@linux.ibm.com>
References: <20240802155913.261891-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1ugd__24DPps2eXDGMihnzCTpXqQq49x
X-Proofpoint-GUID: lb4NYBnHjSQNZm4NGGi4yCUKSndCQyta
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_11,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=933 spamscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020110

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


