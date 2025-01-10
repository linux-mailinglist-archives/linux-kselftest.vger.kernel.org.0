Return-Path: <linux-kselftest+bounces-24203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1234EA08E10
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 11:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D737A18814DE
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 10:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD63209F59;
	Fri, 10 Jan 2025 10:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Mk7Ik4Ut"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284451C3BE7;
	Fri, 10 Jan 2025 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736505116; cv=none; b=oxJfrU5/cPpjTOtSPvq2AajS26ylNeE/7SfFbS8GNbEK3ZDxMYxlKFQa0zHLukeJBB+y7uz6/Bx7ZlwnkWYpPjdauUdGHU+rH+R+DSfvy8iEu5QV90TX5X+F8rrQlEnwi0mkc8DNIPqhVUPruXwo6GbdE+GHsOcaMGqotARM3ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736505116; c=relaxed/simple;
	bh=CxWGiJGU9/Zn1bv0YzFeTKzMHG/t4Te4bbf/omnlS4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=So3Tj5FEQ+JQwUxXnmQr/WSLlvWXU+tbVgPyXQwtQyfLUM70zEHEllnxmnt0VdKHQlWSk288vJQ1a71tcsgrdKEE//9Ll8LViDd/dzmrExKGpYQPwMTAM87eX7o2cmXaAmeDtydQZ3dkq3ikjnt9L0EdCQES++aK3bKCCXvyBUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Mk7Ik4Ut; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509Nx5YP002168;
	Fri, 10 Jan 2025 10:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=OBsjov9ThPbAR7dxg/CNMbqXw91YLJjBbFEIZZiSs
	Ck=; b=Mk7Ik4Utq/qn4OFVVGB2q5UIBkFBAsJ0tkfFjwen4OxNGVnCfQcku2zmx
	ZWKsUCChbREbS1Gp/qWuQa342XoSeDt4htitHDc16FAhL5/TwWZitPNrX+XgfAJV
	C7T1KSwJIM6QtmH1Kx9DV6Hg3jvuLVYPkGtFBCfp72wIKv+g/ipZRQBJNyJ1/UjY
	6n3NK9Nyx3ix4GYl4P26Nwvo/XCb4w4szBDhWm17t1kx63GDeWY938ilyl4l6GeK
	Yl4yMFTL42X2iqixE8MzihlXfdNCrQkGwJqQCU8FUpO5JL6AGxckC7jl8QFiLj+H
	6sfDavPp4XUWdG+DNJkUYtVj/ja3g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442rkht3dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 10:31:31 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50AAUOBp003623;
	Fri, 10 Jan 2025 10:31:30 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442rkht3dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 10:31:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50AA2Ouf015903;
	Fri, 10 Jan 2025 10:31:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygtm9pad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 10:31:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50AAVRfG59638162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 10:31:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CFB020043;
	Fri, 10 Jan 2025 10:31:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FEB520040;
	Fri, 10 Jan 2025 10:31:17 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.104.43])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jan 2025 10:31:17 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: ast@kernel.org, hbathini@linux.ibm.com, andrii@kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
        hawk@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org
Subject: [PATCH] selftests/bpf: Fix test_xdp_adjust_tail_grow2 selftest on powerpc
Date: Fri, 10 Jan 2025 16:01:09 +0530
Message-ID: <20250110103109.3670793-1-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zDrGMnLUi_G3QeX4TcVDY0ShClZjLlHd
X-Proofpoint-GUID: OPNysoGTUs22IsG8wgIaOgAYPyJ4tFbs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100084

On powerpc cache line size is 128 bytes, so skb_shared_info must be
aligned accordingly.

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c      | 2 ++
 tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
index 53d6ad8c2257..b2b2d85dbb1b 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
@@ -82,6 +82,8 @@ static void test_xdp_adjust_tail_grow2(void)
 	/* SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) */
 #if defined(__s390x__)
 	int tailroom = 512;
+#elif defined(__powerpc__)
+	int tailroom = 384;
 #else
 	int tailroom = 320;
 #endif
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
index 81bb38d72ced..dc74d8cf9e3f 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
@@ -10,6 +10,8 @@ int _xdp_adjust_tail_grow(struct xdp_md *xdp)
 	/* SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) */
 #if defined(__TARGET_ARCH_s390)
 	int tailroom = 512;
+#elif defined(__TARGET_ARCH_powerpc)
+	int tailroom = 384;
 #else
 	int tailroom = 320;
 #endif
-- 
2.43.5


