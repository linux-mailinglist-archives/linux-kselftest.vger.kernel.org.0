Return-Path: <linux-kselftest+bounces-4883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0EB858816
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 22:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4047A1C217E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 21:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2C9146900;
	Fri, 16 Feb 2024 21:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s+mrOfV7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4C3145328;
	Fri, 16 Feb 2024 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708119390; cv=none; b=PL9BmWUfszvy5+dlXJfHpWoswySLECoVzzyn7KNXHz6NdlAgIL5ZmBVfCQPxnmrdLrZ1cLZO37Qaa3M8GQ8dw46w0rTofmSp+0m14zYA6tFkvD4xj2ibuffGqoBRDYeHe+AUFjzL+1865/CYaSd+tc5YmyjkF6k86I4BaYAxkJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708119390; c=relaxed/simple;
	bh=ABazzURm9YE0CBrLRExDVt/8/GoQ0YtBOKQly5ilylg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WcLYQMOodYFdfLYO/jkJB5sb8SRofb3t+W2kbkeFrFoe/vF3F2gNFG0ZPvEbsfMmwpVFgEl3180dLdp2gclVYXzjDeSrYh6JJF0mNaGQFeOHsbnorTHCVSZPavK9htwibyO2Xp9Uy/yM9X/k5Ysy3JpMIrLm0REd34QSK0uVGkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s+mrOfV7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GLKWGK026387;
	Fri, 16 Feb 2024 21:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=GMoZ8cVjbJyyRF6RsjzaoDYPrwdJ4WYC/25L17yBbNg=;
 b=s+mrOfV7lA2/dV1wMstEd0zpj83l2Ob9MS8G78Nll3E4V9jLLquLCgwgiD13Xy1e1Fvb
 O85p5WLAIMuro1UicmQhsCGon53c7rbbdfHYEj4nVTgmC+jbOssau6PCHBG2MLFShpqA
 sgfNmpvsVTYcGUUE8ml7mXECYVLTDKu9z3ndkvPoI8FNjyGWC7/e5eutLNIfrJYNkcJy
 SpYYDYfXoyO+7XFWvkw8qSJdFffVr+UnTINuxQXiUV+AmBNIknd9yWDYKt43Ck7MTSJJ
 p3LS0vNbIn11CkUfFJoj7GTWAaYeZwxjTNMim6ycD6deJfV1onlHnO259ELsQN/tobJ9 DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3waeyn0v24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 21:36:26 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41GLZRgH031405;
	Fri, 16 Feb 2024 21:36:25 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3waeyn0v1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 21:36:25 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41GLMOis024888;
	Fri, 16 Feb 2024 21:36:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfpwwsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 21:36:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41GLaIRY32244262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 21:36:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A3652004F;
	Fri, 16 Feb 2024 21:36:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4767F20040;
	Fri, 16 Feb 2024 21:36:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 16 Feb 2024 21:36:18 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id F3312E0045; Fri, 16 Feb 2024 22:36:17 +0100 (CET)
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
Subject: [PATCH v3 0/2] KVM: s390: Fix AR parameter in ioctl
Date: Fri, 16 Feb 2024 22:36:14 +0100
Message-Id: <20240216213616.3819805-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IamFYXRCpSTxxKQZanDVXnAGpV2K06C7
X-Proofpoint-ORIG-GUID: pK7Z57Xtrlc1PFVE9dz4sgYUc8-uYd_L
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
 definitions=2024-02-16_21,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxlogscore=710 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160170

Hi Christian, Janosch, Heiko,

Here is a new version for the AR/MEM_OP issue I'm attempting to address.
(Thank you, Heiko, for the offline chat!)

Changes:
v3:
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

 arch/s390/include/asm/kvm_host.h          |  1 +
 arch/s390/kvm/gaccess.c                   |  3 ++-
 arch/s390/kvm/kvm-s390.c                  |  3 +++
 tools/testing/selftests/kvm/s390x/memop.c | 28 +++++++++++++++++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.40.1


