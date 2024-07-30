Return-Path: <linux-kselftest+bounces-14450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8BB9409D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 09:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5CE1C22DE2
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 07:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C601922FB;
	Tue, 30 Jul 2024 07:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J7T49HBq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73A019007D;
	Tue, 30 Jul 2024 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722324280; cv=none; b=OGmSNV2r3tjcGZaAjpknu6OkQVwn+bhxn0xD9Jm1vUMrc+K+BYnaFyxz3l5fLME3Lq++nVkY/wMED0PNGvrOmfqdXR9+rdZjq1MGlMCWUQmqF2UgIMxyacLZDTcIta5f1r47MH2AiSsu2+wZrugQxxY2oCNcT7dn6glhl85OMXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722324280; c=relaxed/simple;
	bh=o1yV6y6UPAcZFmkWCd9MfIv6v8r+UKFWGvubA/++h1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G29tHeKaTVhIGYuYCEmghyhq5ssBDPifJ7HuvUkLyaghTFy0IsU83SAdKnGp8dFDTBMw6ARF/FtOFxYhApRltwR9UuaOZBmVQm15NMYF/T8P51K0mVRRku2RrKU+zz2K2+ndT9NI2lub4ECQXrYyvFdylqQd9YDyWrcDBLG3/m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J7T49HBq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46U6SemO026965;
	Tue, 30 Jul 2024 07:24:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=QVyQUH0NF7478
	Bf2SD3UC/TAcR5oReY6ypkTZUaGleU=; b=J7T49HBqgiwxHuFFERrJuCLd/CjSd
	W+m4kSHGSUuGQ1IOmX1vps3Nsr83oEUceCP6Ch47aHoPtfeR/0mXjSf8Xujc5Izm
	kA5840KPXJETBTVic1Sif7DS4kyWK3Rb+bIhj01MkEmwzFrjyh0/rC+K3BFAZMGx
	48st9kFKGuiq+JuvSlpbII5kI1Ecb42f7arOWYEBxLnweb/uEeiQcdaukVXXewzu
	YkbneO9fNDdVMq5rGixutjh3wt+ukSpY/d6obOeLu/MgLIBTfRaoYxJqFTrZ0+kp
	gGLZMJu8cfmoYv2IOgfmznlfZVLnB+6Jqb/pyre/kDAhoYJ2+gS+Ks2og==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ptxcr6m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 07:24:34 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46U7OX0C003459;
	Tue, 30 Jul 2024 07:24:33 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ptxcr6m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 07:24:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46U6iVmK007467;
	Tue, 30 Jul 2024 07:24:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40nb7u3nqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 07:24:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46U7ORqf45482368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 07:24:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 681862004F;
	Tue, 30 Jul 2024 07:24:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCC552004D;
	Tue, 30 Jul 2024 07:24:26 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.13.169])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jul 2024 07:24:26 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v3 10/10] s390: Enable KVM_S390_UCONTROL config in debug_defconfig
Date: Tue, 30 Jul 2024 09:24:13 +0200
Message-ID: <20240730072413.143556-11-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730072413.143556-1-schlameuss@linux.ibm.com>
References: <20240730072413.143556-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: J7dHo4vSVHvTlxYHnCzWVJgZar46HAXd
X-Proofpoint-ORIG-GUID: NV2Ur7q0D4UeEY0gycabKz3KuMCkzBAu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_07,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 mlxlogscore=898 clxscore=1015 impostorscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300054

To simplify testing enable UCONTROL KVM by default in debug kernels.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
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


