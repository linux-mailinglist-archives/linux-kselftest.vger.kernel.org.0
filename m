Return-Path: <linux-kselftest+bounces-4816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF0D856EEC
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 21:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72461F26016
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 20:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DC313B7A7;
	Thu, 15 Feb 2024 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U5Vsw+Ey"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B2613AA42;
	Thu, 15 Feb 2024 20:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708030438; cv=none; b=EMRnxVZVUupvk816erem4KVV4SlOhM9IAyOVgrLyLVdt572nQTSEaI2TFJcKGxClwRpNNuqR64t/bNabycK4GmvzHgUeEex3lPh8ATvAOUaZblSYoFHTxKuXNG3l/9b9sJtX5qprsq733E2DvaL+b7QjovHEJdwea6m732r6Sko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708030438; c=relaxed/simple;
	bh=BGgCO7bO624n30v5TJ5s8FoIEfRZT2PlRQJKkpcibKc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q3itp/l8c9DWoP2dMWMfed+969pQZYAg/pJNKnaPLcWrfmtf0CevMkNQOpTfdTB8oFC9mL2IqbaVjUSG3yjJGEYMGez/y1g8a0hj5kVbw6nCN+SzBVC7CfHxRqpX3xgGTFalzG+5TnrRU1brD2CgcT6dz4r9maWBq7mSyCBTFuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U5Vsw+Ey; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FJl6tP029502;
	Thu, 15 Feb 2024 20:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=lkiUo3f3sEeZpd15clopN9yMDKzXq+pvRMoZ9L8t5hI=;
 b=U5Vsw+Ey5ecbGhIj5uEUxnXbpyJvsCufwmVnkdCnk4wrQLQzMqjyQfMPUWzTHvr1gflg
 u9WQHVBT5s5pN3iKvFgidCpMJsaWjGQqIF5sEIz/CTlXxK/+i6pHH6e9eua0/AaetTXZ
 Ye6npI/6Jr/oRHhY1bBH6+zzEmTe7KjaKJO4P3p/s/rtBpOo+16W48EH8w0dUMwsBDSp
 ZxFp5qpMWkTIxP0D/ezX9kzT2kJRTd2+fJWibf3nLWCAF6+qqI5+Co2G89dXMmbNYBCD
 dxlPM5I87uLGTWTxLWsBOAQPP6KSu3EMmiRcTVC7uRARtPgSIodH/4AnMPOPBP9hPI4r EA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9q0v4gpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 20:53:52 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41FJuADv027301;
	Thu, 15 Feb 2024 20:53:52 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9q0v4gpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 20:53:52 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41FIAT4W009728;
	Thu, 15 Feb 2024 20:53:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6p636srs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 20:53:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41FKrkpO44958274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 20:53:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DF2F20043;
	Thu, 15 Feb 2024 20:53:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D3F820040;
	Thu, 15 Feb 2024 20:53:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 15 Feb 2024 20:53:46 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id D3D2FE034A; Thu, 15 Feb 2024 21:53:45 +0100 (CET)
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
Subject: [PATCH v2 0/2] KVM: s390: Fix AR parameter in MEM_OP ioctl
Date: Thu, 15 Feb 2024 21:53:42 +0100
Message-Id: <20240215205344.2562020-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: u6JhSUsnJunqZDij1BXRo45GgPCInAxG
X-Proofpoint-GUID: 65SWgHkjGRFrE_4xejYXhZEGyh4wclx6
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
 definitions=2024-02-15_19,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=682 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150167

Hi Christian, Janosch, Heiko,

Here is a new version for the AR/MEM_OP issue I'm attempting to address,
with Heiko's feedback to v1.

Patch 1 performs the host/guest access register swap that Christian
suggested (instead of a full sync_reg/store_reg process).

Patch 2 provides a selftest patch that exercises this scenario.
Applying patch 2 without patch 1 fails in the following way:

[eric@host linux]# ./tools/testing/selftests/kvm/s390x/memop
TAP version 13
1..16
ok 1 simple copy
ok 2 generic error checks
ok 3 copy with storage keys
ok 4 cmpxchg with storage keys
ok 5 concurrently cmpxchg with storage keys
ok 6 copy with key storage protection override
ok 7 copy with key fetch protection
ok 8 copy with key fetch protection override
==== Test Assertion Failure ====
  s390x/memop.c:186: !r
  pid=5720 tid=5720 errno=4 - Interrupted system call
     1	0x00000000010042af: memop_ioctl at memop.c:186 (discriminator 3)
     2	0x0000000001006697: test_copy_access_register at memop.c:400 (discriminator 2)
     3	0x0000000001002aaf: main at memop.c:1181
     4	0x000003ffaec33a5b: ?? ??:0
     5	0x000003ffaec33b5d: ?? ??:0
     6	0x0000000001002ba9: _start at ??:?
  KVM_S390_MEM_OP failed, rc: 40 errno: 4 (Interrupted system call)

Thoughts on this approach?

Thanks,
Eric

Changes:
v2:
	[HC] Add a flag to indicate access registers have been loaded
v1: https://lore.kernel.org/r/20240209204539.4150550-1-farman@linux.ibm.com/
	[CB] Store access registers around memop ioctl
	[JF] Add a kernel selftest 
RFC: https://lore.kernel.org/r/20240131205832.2179029-1-farman@linux.ibm.com/

Eric Farman (2):
  KVM: s390: load guest access registers in MEM_OP ioctl
  KVM: s390: selftests: memop: add a simple AR test

 arch/s390/include/asm/kvm_host.h          |  1 +
 arch/s390/kvm/gaccess.c                   |  2 ++
 arch/s390/kvm/kvm-s390.c                  | 11 +++++++++
 tools/testing/selftests/kvm/s390x/memop.c | 28 +++++++++++++++++++++++
 4 files changed, 42 insertions(+)

-- 
2.40.1


