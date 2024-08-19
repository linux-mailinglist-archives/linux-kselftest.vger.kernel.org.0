Return-Path: <linux-kselftest+bounces-15642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDEB956C87
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 16:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B04284A33
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 14:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF5A16C863;
	Mon, 19 Aug 2024 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JV/xwsSe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA4115746F;
	Mon, 19 Aug 2024 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724076057; cv=none; b=gQf0Mxu3LxRVzDlhKbvnPdT2M9o6dGJcJAaNGzQPe9AVxQ9BXIhlDEanDh1PlGIyk7M+mcns+F29gAfBEDmTK1iM3N286SZOpQfcemWOiYhkUakZtMoZTZiqhrmO0/GDgEdZAqqzWdn9YtCbmlKuf18UhshetqTKxFLPTNyBkd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724076057; c=relaxed/simple;
	bh=QfzO9iO4+/4+sH16VK7B3e9zC7MZVFg9ysMXDB75Gs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F/L2hykUZ8wtIhedJ/WzsLVfuHda+VpJiBBuBAnhGQDqeJT3VHfHA42oUQZob1lgwMVp+XDFn/vNZ9b0KtEVc2y+d40iHrfMdoS6c6soFuSG+ngj5THVT7fQrz7ztUQzs0PgpQ8IFQmeECdodT6ZY3GUJP4hE2WDY7Ezx2o98Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JV/xwsSe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JAlX7X021086;
	Mon, 19 Aug 2024 14:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=NCtjfLHJsWFGuR3LMTQXRn3dMF
	c0BAZmTM/KV0UT+sg=; b=JV/xwsSegJvcvBENlE9fZOx70DM4CSKTAMOMNr9U8m
	m9vooPXLavNQNS9yhBp0fWIDulEyxuKPazL5G009NFuZ21l9a+4LpWaHze1V0z+p
	bFWrdv78zMVBj1pwT1cOVgzH5yZIyLk0F3X7p/UteRp5xku5fBBFMlKwLCBjebQj
	OIbtex7k55Hgn0TxmlBupiHEx4YFnZulhTDjrTv5amBpjQobTriyx1MVqv1VZk41
	WbWODU8ThJAnGT9y4zz0368GX3MLXcfR5jqbANyBY90LKdHtE9ds3VqU2OTGn9rx
	Rz1XRi5MosbudI8vnqvvfCFVwmAT6MPUhpR2rEouG0Uw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412ma013ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 14:00:50 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47JE0oux018909;
	Mon, 19 Aug 2024 14:00:50 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412ma013ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 14:00:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47JCrLj9019105;
	Mon, 19 Aug 2024 14:00:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41376ppcr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 14:00:48 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47JE0hZ443254200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 14:00:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 410CE2004B;
	Mon, 19 Aug 2024 14:00:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D43420040;
	Mon, 19 Aug 2024 14:00:43 +0000 (GMT)
Received: from a46lp38.lnxne.boe (unknown [9.152.108.100])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Aug 2024 14:00:43 +0000 (GMT)
From: Hariharan Mari <hari55@linux.ibm.com>
To: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, shuah@kernel.org,
        frankja@linux.ibm.com, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, david@redhat.com, pbonzini@redhat.com
Subject: [PATCH v1 0/5] KVM: s390: selftests: Add regression tests for CPU subfunctions
Date: Mon, 19 Aug 2024 15:54:21 +0200
Message-ID: <20240819140040.1087552-1-hari55@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3eXGGMohyrtYua53NFmjzwLGAZXa4eBc
X-Proofpoint-ORIG-GUID: lrHam5Wjz0--C66TLvkuvwy0vEYzVQZH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_11,2024-08-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=664 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408190090

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

 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/s390x/facility.h    |  50 +++
 .../kvm/s390x/cpumodel_subfuncs_test.c        | 343 ++++++++++++++++++
 3 files changed, 394 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/s390x/facility.h
 create mode 100644 tools/testing/selftests/kvm/s390x/cpumodel_subfuncs_test.c

-- 
2.45.2


