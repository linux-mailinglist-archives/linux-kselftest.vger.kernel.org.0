Return-Path: <linux-kselftest+bounces-30404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B081BA82179
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 11:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE46B8A709D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 09:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422E825D52F;
	Wed,  9 Apr 2025 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ye2+qP4p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E5B25B67E;
	Wed,  9 Apr 2025 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744192641; cv=none; b=petsJ6bwwftdRR+vkaU8ktNR1mgidjosT/+E7O1Tv2jFCo9SZpuhTeMjq9h7eFkZ/jgQEv+IBHyM23ZT0GvT9qU5eXlv/45LyNyMA6XbcVbLfPEiv5tYWKA9gXbZPYrfDhKZ834EVXf5h3A/50QfBKNu7x2piPthf41IRffTI8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744192641; c=relaxed/simple;
	bh=C4LvSLwfHxGG+LmOO+Hpl1aLG1vB5gD8OXyfnJnLO1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ngvp2qLyvwkobLOu2leA/Nf7ycacqKg1Ody+ykzw8icI1nO5yGH3sHX5eRo9wCUm58/Q3NJIlNqXZKEl66dUG4DQCGk7KkexAW1Ki3ze4CdOZyxpfwAYt3H+JUQPGs/KfbjsKSmP7yjeRnHneBg5egaYBdg6LSJ/pkK9JkJ9k14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ye2+qP4p; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5393kBAE008172;
	Wed, 9 Apr 2025 09:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=4IR01w7c6IYyecb9RKBfcm9aMGadajgq/bwfVU/wi
	ao=; b=Ye2+qP4pv/lSf/aJtBdatJTpTYUpjm2AWThgYGvADEZ1BXydQ06s9mcZH
	zPHNoNxxGekMffFxzm0XkxcrxKQ+R3aI7VW8m84/VMeKD8NEzIXOp0T6X7QYKfZu
	EiH2ZPlMYW/vraGxmZzF8I7MUIzw1NZI8CClLlp6ac+7R7dBBMXlbZmdihZph0HF
	+hiMekLaXHIlwe6B7beIUWyCHyFmf0074EFOO4CX6jqDvetHIZ2q/APWnSJpnRaQ
	aykP5XxHho3zdEuIShIXbsP2pYyXo5yXO9tTssPaz0Od77pwU7jutPOuRqd7AWk2
	F1bxCwsM70KdKZYlyXZQQqkI61Pow==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wh99hhx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 09:56:54 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5399nf86007566;
	Wed, 9 Apr 2025 09:56:54 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wh99hhue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 09:56:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5398VO7d024610;
	Wed, 9 Apr 2025 09:56:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ueutfa3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 09:56:42 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5399ueB112517822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 09:56:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A52520071;
	Wed,  9 Apr 2025 09:56:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 244BC20073;
	Wed,  9 Apr 2025 09:56:36 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.46.171])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Apr 2025 09:56:35 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: ast@kernel.org, hbathini@linux.ibm.com, andrii@kernel.org,
        daniel@iogearbox.net, mykolal@fb.com, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, shuah@kernel.org
Subject: [PATCH] selftests/bpf: Fix bpf_nf selftest failure
Date: Wed,  9 Apr 2025 15:26:33 +0530
Message-ID: <20250409095633.33653-1-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _7bzi4MxnXVnTmd88qLeJOkXEz8b-KVA
X-Proofpoint-ORIG-GUID: PCihOu802yJC6FMZmplOTIec5oujlP-z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_03,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 phishscore=0 mlxlogscore=716 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090054

For systems with missing iptables-legacy tool, this selftest fails.

Add check to find if iptables-legacy tool is available and skip the
test if the tool is missing.

Fixes: de9c8d848d90 ("selftests/bpf: S/iptables/iptables-legacy/ in the bpf_nf and xdp_synproxy test")
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
index dbd13f8e42a7..dd6512fa652b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
@@ -63,6 +63,12 @@ static void test_bpf_nf_ct(int mode)
 		.repeat = 1,
 	);
 
+	if (SYS_NOFAIL("iptables-legacy --version")) {
+		fprintf(stdout, "Missing required iptables-legacy tool\n");
+		test__skip();
+		return;
+	}
+
 	skel = test_bpf_nf__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "test_bpf_nf__open_and_load"))
 		return;
-- 
2.43.5


