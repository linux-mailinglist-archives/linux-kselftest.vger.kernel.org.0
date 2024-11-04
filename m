Return-Path: <linux-kselftest+bounces-21354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8175E9BABEB
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 06:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F3CEB20BCC
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 05:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D723F171E43;
	Mon,  4 Nov 2024 05:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NaG4qkYH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470D210F1;
	Mon,  4 Nov 2024 05:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730696454; cv=none; b=Uzg3KHrEpmi1zstNp/u/wLzQ4qczqNaK0O+jkgP6wqkyvi4DrvM5lzwzmksHWShIfRCakOSVzSsQU1lEjt4dTq/zrY/4u2VXchI7/sM6WaUv8o75+zf/HiBWtPTZRJzku6RaY5XAfl4mTrb1ENhX3QTikBoh6IB7UIB981ZNmlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730696454; c=relaxed/simple;
	bh=CzVFGR76ZnEFJJ5F6De3fSn0Rm8fdyuj0+EUqUV98q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZA++2vcC003G/P5Jdby1PZeSx+p/zVsnjBbwPOLcLCNubN592PPwHxgSteEPEiIkstCIykKGiG1MIGl7fIcbLcM+e6JNxB3IkpbtXveumQdD8ZviXN4loVcEOuFTFqsjgt1ViVeyb+xZCE0wqN6k0jYRF8T6ppgf9VJh9AMgjIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NaG4qkYH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3Nmdt3004224;
	Mon, 4 Nov 2024 05:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=KVsG5jdT2TVfScrCtzqE67N5ilrZ81Eb2E0epBNfE
	Ck=; b=NaG4qkYHzqqJkDmfcNLXA4nPJKQV+oisAe9NNUYYi7I2Xk1todfQPokYK
	PZmf2rkOUZAn4ekwIfRtSLODTwm93CY5QowUgbbM5OJ2e/7ApDfBco+MeOqlU3e/
	L3a9eqlhNi8nkolF0AY5QJuDX7CW+oxMNaUgLIAsFFS1eKZ+ahSPlYGuNyU7GbBC
	ToFfDwAK2k9kPhWbExXilW463u5N8uouPPggzwp/ZEJ6CDqC5eNL2vgSRW9ImqrL
	4XtgneSk87C//MKoBd9UB/dV7Tmb8jLyh5/Zj0u0BJ9C/cuDgC+X1kSjNbqMhLT8
	SoNNjgo2O+oHcaFYAL+BqssUEXO7A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42pjku8mx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 05:00:26 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A450QZs005963;
	Mon, 4 Nov 2024 05:00:26 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42pjku8mx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 05:00:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3GclKM024786;
	Mon, 4 Nov 2024 05:00:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42nxds1j2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 05:00:25 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A450NqZ44892514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Nov 2024 05:00:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 803622004D;
	Mon,  4 Nov 2024 05:00:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9547E20040;
	Mon,  4 Nov 2024 05:00:14 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.56.204])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Nov 2024 05:00:14 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: ast@kernel.org, hbathini@linux.ibm.com, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, shuah@kernel.org, mykolal@fb.com
Subject: [PATCH 0/3] Fix test_bpf_syscall_macro selftest on powerpc 
Date: Mon,  4 Nov 2024 10:30:04 +0530
Message-ID: <20241104050007.13812-1-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ob2DC6ybdJJj9owxvDKmlHlZC_1b8ke6
X-Proofpoint-ORIG-GUID: id6ZlegPCYOjhNdxl0PJlEBu-BTTgeEH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 mlxlogscore=928
 mlxscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040039

Since, syscall wrapper is supported on powerpc with syscall
entry symbols as sys_*, changes done to fix selftests like 
test_bpf_syscall_macro, attach_probe/auto, etc.

Saket Kumar Bhaskar (3):
  libbpf: Fix accessing the syscall argument on powerpc
  libbpf: Remove powerpc prefix from syscall function names
  selftests/bpf: Define SYS_PREFIX for powerpc

 tools/lib/bpf/bpf_tracing.h                  |  9 +++++++--
 tools/lib/bpf/libbpf.c                       | 10 ++++++++--
 tools/testing/selftests/bpf/progs/bpf_misc.h |  3 +++
 3 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.43.5


