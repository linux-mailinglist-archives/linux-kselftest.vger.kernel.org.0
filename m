Return-Path: <linux-kselftest+bounces-16145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0FC95CD52
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 15:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA681C21C8E
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 13:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06338186E5A;
	Fri, 23 Aug 2024 13:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TcHSUsq3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BC51865F1;
	Fri, 23 Aug 2024 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418604; cv=none; b=EuIC5S4YtxBEyrMLSVLOEXKJx3dIyl+7cIbe66dzvgfZv+uK68QI2v75RSSHuoZOn8X03+HuEo3QOpUIcblrLLrqFTJcVoLo2aAvJIodNF84Z3FHtjZUksIo3QA3myaujDLNEa7+GH2S/MeeD1rFUZTjm/bo/9d1YVhGusvHwUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418604; c=relaxed/simple;
	bh=wb+VuNjiBFvQqo9wiUYegEmAHzTOE4dTmrmGfheD7iU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AXMwK22hiwB3vkgKV2HCl7JJmfKzAzX7hBDUsHeAhZcm9O98BQCchued07KaQoHOtdy6o+9GrV1WRS11NRI/3LOTElm5p2RsiXP65TTyaqXsLVcoHViyXKVo8KeFslE//tEL8PYIDIkEiCO9oeUOi0B/wLvE54NHUEdO7zcHDI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TcHSUsq3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NAHUJW005497;
	Fri, 23 Aug 2024 13:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=Vh5aCItZOd5/dSuzijCh6RX8nx
	+0QnG2r83rtM+0yUI=; b=TcHSUsq3a72B++lznZvxN03J8AHhdThkhadXDghAsd
	7no/pk/2DLHV9eI0nF0OQwEUmKoFdaVsBHnGWKd2lHNAZG/anEiHCX+HHBGaHCBD
	8sZOFRxA9xOxbIUFkOS8xMvTvwV0QJA7YCjLtPm1fFsVR8/yMDhsCDw55f4xplIV
	LrgbUwksMsQ3/EHBF9DA+kZj+3JSJRO29LkRcMNXrQxVqBvM+hiPCbWVadprK7jl
	h9tcll/og1+7G8b/KacMBY32jwxYHkMmPDVFP6dWjJ4FkN0XX9+WBN0YvirDymUd
	jWG0qvtra2ecZ52UtKrn4/aqpGRJzcHXcRfYTsmnUyOQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb650e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:09:58 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47ND8kWY013601;
	Fri, 23 Aug 2024 13:09:57 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb650dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:09:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47NBjbBw018968;
	Fri, 23 Aug 2024 13:09:56 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41376qa07q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Aug 2024 13:09:56 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47ND9o5j55968070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 13:09:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB7A12004D;
	Fri, 23 Aug 2024 13:09:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EB1620040;
	Fri, 23 Aug 2024 13:09:50 +0000 (GMT)
Received: from a46lp38.lnxne.boe (unknown [9.152.108.100])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Aug 2024 13:09:50 +0000 (GMT)
From: Hariharan Mari <hari55@linux.ibm.com>
To: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, shuah@kernel.org,
        frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, david@redhat.com, pbonzini@redhat.com,
        schlameuss@linux.ibm.com
Subject: [PATCH v3 0/5] KVM: s390: selftests: Add regression tests for CPU subfunctions
Date: Fri, 23 Aug 2024 15:05:03 +0200
Message-ID: <20240823130947.38323-1-hari55@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6qyFEgIB1D85gNWyVmgXaJ_yx2n15r4C
X-Proofpoint-GUID: liNONXtUo5vNrMQOm5dV8s7jpn3qkwV2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_10,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=737 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408230095

This patch series introduces a set of regression tests for various s390x
CPU subfunctions in KVM. The tests ensure that the KVM implementation accurately
reflects the behavior of actual CPU instructions for these subfunctions.

The series adds tests for a total of 15 instructions across five patches,
covering a range of operations including sorting, compression, and various
cryptographic functions. Each patch follows a consistent testing pattern:

1. Obtain the KVM_S390_VM_CPU_MACHINE_SUBFUNC attribute for the VM.
2. Execute the relevant asm instructions.
3. Compare KVM-reported results with direct instruction execution results.

Testing has been performed on s390x hardware with KVM support. All tests
pass successfully, verifying the correct implementation of these
subfunctions in KVM.

---
v2: 
* Fix facility_bit type from bool to int
v3:
* Global variable in the header is moved to facility.c file in selftests/kvm/lib/s390x/
* Fixed the line length 
* Fixed single line comments and multiline comments 
* Renamed the PLO macro
* Removed the unnecessary type cast where Implicit type promotion applies
---

Hariharan Mari (5):
  KVM: s390: selftests: Add regression tests for SORTL and DFLTCC CPU
    subfunctions
  KVM: s390: selftests: Add regression tests for PRNO, KDSA and KMA
    crypto subfunctions
  KVM: s390: selftests: Add regression tests for KMCTR, KMF, KMO and PCC
    crypto subfunctions
  KVM: s390: selftests: Add regression tests for KMAC, KMC, KM, KIMD and
    KLMD crypto subfunctions
  KVM: s390: selftests: Add regression tests for PLO subfunctions

 tools/testing/selftests/kvm/Makefile          |   2 +
 .../selftests/kvm/include/s390x/facility.h    |  50 +++
 .../selftests/kvm/lib/s390x/facility.c        |  14 +
 .../kvm/s390x/cpumodel_subfuncs_test.c        | 286 ++++++++++++++++++
 4 files changed, 352 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/s390x/facility.h
 create mode 100644 tools/testing/selftests/kvm/lib/s390x/facility.c
 create mode 100644 tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c

-- 
2.45.2


