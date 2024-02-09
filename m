Return-Path: <linux-kselftest+bounces-4478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A183B84FDDB
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 21:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B4A1C246C7
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 20:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68B56AB7;
	Fri,  9 Feb 2024 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NQHu5dly"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063B9FC19;
	Fri,  9 Feb 2024 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511553; cv=none; b=e7RlVTTq0OhiTTmkICaij3TAWE9N1FTiZ0Dmt0P1raKNHtMnCrDNYWMmHasRl18FmgWQT4TlawmeSbro2k55u+EznY38n1Kzv0mViIH0sZTWtbDbpWkWHowPr/b6bo8lKH61k92A97S6IKluUozGiL/65+ce6oNTvYLtnmBWYwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511553; c=relaxed/simple;
	bh=RNpzy0rP2PpG/n+yojMX3buqynBn/GPYVyepeEu7qmI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fcjqmJGrzTrl2LJmJ62wqNwcX2SZmfCNF/jB8gwJkZdzg0yK1Lxbu8flqGfkE2m6AEmVr5OndNK56P4IIO895duEofRK9ohmwdM2ErYHL7B9ke+2v9Qw7Ct4CrCxNYXCrwVwU12oXN37fVfGHqTUx+bn8Gq7rXxa+8DeDqs3h8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NQHu5dly; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 419JQbnr019017;
	Fri, 9 Feb 2024 20:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=powVHdDg11H3JJupYIeDcBgLhFeMGat20WQXjIGHCT8=;
 b=NQHu5dlyScGtSyWO0X87KoYNcz8n8bOjeh4SWSKXwi2u6XNb/MOBV84b+eHHPxX4oYVB
 h4ZjbybERtlyMAMmQimQ8BDZyeQ/05l2VN9fC2ZH77kegpSN3yXqNfaayO2NUzFBbJWI
 Guo2NQCNNID7NbZLGNR6J6s8SRBgcyjGQ/HZO1gucviHWbcNz99iS3RGDhwz3Bu4WXVR
 8oGaViyXGrrH0/4sOoDh2LiKEJNbY6E2rtl5GVt6Z0rlaqhe+N9GlsSu9bGOi0So7bHX
 3sogVnV0u/7sFvhWzGKiuQ1SeiC+rZP2jF0g1h5UHRi7PQOa5Hxy0GFoP0y7Lhtg8QyU qA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w5rjmkrdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 20:45:47 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 419KVrnO001745;
	Fri, 9 Feb 2024 20:45:47 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w5rjmkrd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 20:45:47 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 419I7XmP016215;
	Fri, 9 Feb 2024 20:45:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w22h2myct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 20:45:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 419Kjfti59441482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Feb 2024 20:45:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3271B2004B;
	Fri,  9 Feb 2024 20:45:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 203CB20043;
	Fri,  9 Feb 2024 20:45:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  9 Feb 2024 20:45:41 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
	id DB1FFE0361; Fri,  9 Feb 2024 21:45:40 +0100 (CET)
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
Subject: [PATCH v1 0/2] KVM: s390: Fix AR parameter in MEM_OP ioctl
Date: Fri,  9 Feb 2024 21:45:37 +0100
Message-Id: <20240209204539.4150550-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1KPxcPoJ3mayhDxkSjsr3OCSRrAFkKdt
X-Proofpoint-GUID: Lxt1ZgaqeoOIEOiqTN-c0NzVubLqpXbo
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
 definitions=2024-02-09_18,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1011 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 mlxlogscore=545 mlxscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402090150

Hi Christian, Janosch, Heiko,

Here is a pair of patches to replace the RFC I recently sent [1].

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

[1] https://lore.kernel.org/r/20240131205832.2179029-1-farman@linux.ibm.com/

Eric Farman (2):
  KVM: s390: load guest access registers in MEM_OP ioctl
  KVM: s390: selftests: memop: add a simple AR test

 arch/s390/kvm/kvm-s390.c                  |  6 +++++
 tools/testing/selftests/kvm/s390x/memop.c | 28 +++++++++++++++++++++++
 2 files changed, 34 insertions(+)

-- 
2.40.1


