Return-Path: <linux-kselftest+bounces-28702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B08A5BB0A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 09:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292AB170935
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 08:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30079225A59;
	Tue, 11 Mar 2025 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V5Xc0PCN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D05F22170A;
	Tue, 11 Mar 2025 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741682850; cv=none; b=YfIH+ZVi2dVhOoN3omfxev8B8W3MVb74zKjMLID2Vzxdi3KLGVJvHVCgI7lwLljpRD4WwbbWCqaUmSO+vL4EG+AoO2T2pxfUy2rQoxxFGAzgs/AY3Xgd0rFKuOiJxDnKDv18FkJDrMVyViWuYDLmsXM4s6ZXfHWUXPTw+Kc9PYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741682850; c=relaxed/simple;
	bh=ol1f7hay/Z679BK2/QRFOO0VTI1OSCSa3+Q2+6uk9yg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fmxGQkd4h1r+zzjMvZuJYA9r7g1z2i/oGWZLPcDCOelffwLYp+u8ZbWkdspfkG4VGOeQPbjU4Vd66Vq0AOrhtYHEJ7vUx34EjpVYa2UugHNskrRO34m/05gZL118WafcGOeAloAthLL5bFUVl0cp9b5zPWJGoaHq54CX9Ca3YSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V5Xc0PCN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AKFZHY028791;
	Tue, 11 Mar 2025 08:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=edl4hfarrhj8RCsBI17w+uCiwTK8phxXIqIjOaB8q
	wg=; b=V5Xc0PCN9W0iODXEodpYJpuNRihgplC4uBE3VEZ5VnAeyvnyfePNbWQtF
	aYSbX5y8/+JlPM/+x7sFXrpYq3QM/cdxwVJmqztdWdOAkk6BkWawjlOPBK6ubUrE
	1ax+qqSjbbRXkqUrfz4rI0xotNtIT2pi1ThXK9Ne7qPisRrDrlOkOcMhas7W5IDY
	5SLRcqjiQCBIMWTKbTCNcTSY2JdMFLQBAL+MATTzf28Dyxpt82Vv10dQ8NSib8HJ
	bjjh/PrOv81OOyIyImB5Dl4hhtZrpen1kqk7yUvl0rBanoSALGZSVKJOaTwEPWXh
	5RsYeVwN+ZamLu+TAe4mFN0QTbKiA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a042wcb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 08:46:58 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52B8LlTJ002936;
	Tue, 11 Mar 2025 08:46:57 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a042wcas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 08:46:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52B7bK5b014011;
	Tue, 11 Mar 2025 08:46:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4592x1ttma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 08:46:56 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52B8ksZP34538076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 08:46:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D42052004D;
	Tue, 11 Mar 2025 08:46:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1284320040;
	Tue, 11 Mar 2025 08:46:50 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.112.86])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Mar 2025 08:46:49 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: ast@kernel.org, hbathini@linux.ibm.com, andrii@kernel.org,
        daniel@iogearbox.net, mykolal@fb.com, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, shuah@kernel.org, miaxu@meta.com
Subject: [PATCH] selftests/bpf: Fix sockopt selftest failure on powerpc
Date: Tue, 11 Mar 2025 14:16:47 +0530
Message-ID: <20250311084647.3686544-1-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VPyMwzuXTjLqCJwbqKFCCgpkViq35HWO
X-Proofpoint-ORIG-GUID: _tsnpUPWeg2Nlj8o_gcPPYdfxINmsmdD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=902
 impostorscore=0 clxscore=1011 mlxscore=0 priorityscore=1501 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110057

The SO_RCVLOWAT option is defined as 18 in the selftest header,
which matches the generic definition. However, on powerpc,
SO_RCVLOWAT is defined as 16. This discrepancy causes
sol_socket_sockopt() to fail with the default switch case on powerpc.

This commit fixes by defining SO_RCVLOWAT as 16 for powerpc.

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/bpf_tracing_net.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index 59843b430f76..bcd44d5018bf 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -15,7 +15,11 @@
 #define SO_KEEPALIVE		9
 #define SO_PRIORITY		12
 #define SO_REUSEPORT		15
+#if defined(__TARGET_ARCH_powerpc)
+#define SO_RCVLOWAT		16
+#else
 #define SO_RCVLOWAT		18
+#endif
 #define SO_BINDTODEVICE		25
 #define SO_MARK			36
 #define SO_MAX_PACING_RATE	47
-- 
2.43.5


