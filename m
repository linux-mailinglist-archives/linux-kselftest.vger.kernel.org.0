Return-Path: <linux-kselftest+bounces-5077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7891285C765
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 22:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88F31C20DD7
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 21:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53C8151CE5;
	Tue, 20 Feb 2024 21:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tDfL1I8D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D20C612D7;
	Tue, 20 Feb 2024 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708463545; cv=none; b=EXLjik/0KB/IN45LtERTpiYC5y35UNppNXPPk4m/pGGWQ7A2dzriNZ7kFcY4LmVtoif7P6jMfkicVTA+iTkvTWBKVQdLeNKj0W+k2ksrFRXarbdrdpt88dqq5jD+Sy8vvxBca76wTEXZk5UjlXOucCd63yHIP8W+USM0AUmKcTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708463545; c=relaxed/simple;
	bh=2b/TBXFc7Ngj4lYkWZR0AtquaqmyHgrue1RjZw5DqIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d7m2k6Tw8o9ManA+0f67ELhikzqvoF6wqHXsL/lUMZSt1rNVF7u1PGWGZ3msaWwYJiiS50Se1SmpAUYnzm9MpgojNoiXm/bE63a+uZ3C9oRPbrnkS0l1j1x5FXEIcGyt6ZRbMJV5yQucwhAmLYK3ZoNy5B86ECAws4GTHcTUxik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tDfL1I8D; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KL7iSj015515;
	Tue, 20 Feb 2024 21:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=T6ai+h3Ps3tOexGpnPubrh9NaPw+d5RswAkH6epS5z4=;
 b=tDfL1I8D3uDPd68YwOQOFxx9TaEZ6I4662pU30kWLIr+VskoX9EvzIaolD9fo7bjFNuo
 DnXSSwEPfkp6Pj8pSYIFSmJBun1ZEgZ2M333/eXaEXxqolwbKlYLxsJty2OsL3++DOE+
 kp9aGxdBK9KN33yRN14PA7zFiEu/ZRvBJADDIgy51Q1IJ597nkvTPeVADyxmzFRsW081
 pmy64j/pQr+Xkmj014rG8MpCOlFKirdi7Fv6Tl7NTthx94pSUZU5F8iqFQOfWzhCIZCT
 2j2YGUooNnMyEI1kxCcqia7tmmoboShv54BDUjIVH9R81yLUho8s56Nkj1k/GC6ti29i xw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcyst5w4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 21:12:20 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41KL8fvN020506;
	Tue, 20 Feb 2024 21:12:20 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcyst5w4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 21:12:20 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41KK5CjP009547;
	Tue, 20 Feb 2024 21:12:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84pauj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 21:12:19 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41KLCDLx18088514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 21:12:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BE2420043;
	Tue, 20 Feb 2024 21:12:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88BA320040;
	Tue, 20 Feb 2024 21:12:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 20 Feb 2024 21:12:13 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id 3879BE0172; Tue, 20 Feb 2024 22:12:13 +0100 (CET)
From: Eric Farman <farman@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v4 0/2] KVM: s390: Fix AR parameter in ioctl
Date: Tue, 20 Feb 2024 22:12:09 +0100
Message-Id: <20240220211211.3102609-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3YNrl-RDEMkXYgu0XoayVkjVacCpBjO9
X-Proofpoint-GUID: 4USiI4tudUtV9ab_p4FoITrfIGkq6cF0
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 bulkscore=0 mlxlogscore=839 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402200151

Hi Janosch,

Here is a new (final?) version for the AR/MEM_OP issue I'm attempting to
address. Hopefully they can be picked up to whatever tree makes sense.

Changes:
v4:
        [HC,CB,NSG] Add tags (thank you!)
        [NSG] Add commentary
v3: https://lore.kernel.org/r/20240216213616.3819805-1-farman@linux.ibm.com/
        [HC] Drop the AR swap in MEM_OP path
        [HC] Remove WARN and don't do save_access_regs on !bool
v2: https://lore.kernel.org/r/20240215205344.2562020-1-farman@linux.ibm.com/
        [HC] Add a flag to indicate access registers have been loaded
v1: https://lore.kernel.org/r/20240209204539.4150550-1-farman@linux.ibm.com/
        [CB] Store access registers around memop ioctl
        [JF] Add a kernel selftest
RFC: https://lore.kernel.org/r/20240131205832.2179029-1-farman@linux.ibm.com/

Eric Farman (2):
  KVM: s390: fix access register usage in ioctls
  KVM: s390: selftests: memop: add a simple AR test

 arch/s390/include/asm/kvm_host.h          |  2 ++
 arch/s390/kvm/gaccess.c                   |  3 ++-
 arch/s390/kvm/kvm-s390.c                  |  3 +++
 tools/testing/selftests/kvm/s390x/memop.c | 31 +++++++++++++++++++++++
 4 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.40.1


