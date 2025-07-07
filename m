Return-Path: <linux-kselftest+bounces-36671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EB8AFACE2
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 09:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEBE816C370
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 07:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419D027B4E8;
	Mon,  7 Jul 2025 07:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RTFu88jY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7970219DF48;
	Mon,  7 Jul 2025 07:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751872690; cv=none; b=USqPLtr5O+OAsUfEmLaWwlJIDXwnpy3M8nXGtqKmOXLNSbWDG9S3wCe2qkskqT6rldoROH53a6yMvNnpOAYgD1GtMnMZvYLJHsuwzn1rel/7RPWl8BUUOrNkD+yvaoVgq0UKK0mjR9Ts/2tP9n8XU23qqLpYHf2IhpEA0DFLpPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751872690; c=relaxed/simple;
	bh=QSGl4K4f2MNV/fdE1EOY0GdLB5rrl8evP70DAea8sTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fnxLD56no6tqobZQ7fjjTeYvuwDKv6RL1erYzBWcI3xIwz6/otJ+Z8jQDUsDS/+Op75cq0bUIMAQfmF9EDXbtTz6y3516UR/lndY+y9aT07aDlJ3tEgVfPlvMd/dScLTMEL2VDLykM/o1F0x/RU0S+P8PX1Hz6EoqFKKSlaQZk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RTFu88jY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 566FRg3p002175;
	Mon, 7 Jul 2025 07:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=jIepRk6DVAebh6PEsLNjSpb6du02Gr5YnB3tOZopq
	qc=; b=RTFu88jYvpX7Y8m8tnWsSHI6nhlzKlob6KT8YSmL+hbgLhzYVrEeTg1xf
	SO7jTcWOHL6VCB4DZ6UMCZ/BLxl4jsv17CH9Q/msCPAr3F7WaHTxLSG9dNpeyeV/
	h0VXQVmmOZwk/ViYpwcuEcgm2g1nN/hzcXZhnE/krEHMkTPQKcNi2S9MeToOpQ9m
	Im1VYzoKY56ekeSvmC0MyYTm2CDtAWET7znu2fxkKIv+ktbLdQRh/Jj9wObtpLiT
	bteAyeT+8nknQbxOp/TXchAI3m6j+ztgmF7U4Lq4AfMInNQcFVqbtTwklJ6F9iib
	dRz+tyLB/mXDGHtlFJLEDuRtUA+0w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptfyfsfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 07:17:45 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5677Hil5011374;
	Mon, 7 Jul 2025 07:17:44 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ptfyfsfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 07:17:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5675R9CG013582;
	Mon, 7 Jul 2025 07:17:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qgkkmr00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 07:17:43 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5677Hdd223200230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Jul 2025 07:17:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86D362004D;
	Mon,  7 Jul 2025 07:17:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C02C20043;
	Mon,  7 Jul 2025 07:17:36 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.in.ibm.com (unknown [9.109.219.153])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Jul 2025 07:17:36 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, andrii@kernel.org,
        eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org
Subject: [PATCH] selftests/bpf: Set CONFIG_PACKET=y for selftests
Date: Mon,  7 Jul 2025 12:47:35 +0530
Message-ID: <20250707071735.705137-1-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=crubk04i c=1 sm=1 tr=0 ts=686b7499 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=PmTHI85cWLbkpOWelngA:9
X-Proofpoint-ORIG-GUID: 2Mm_RrxbAbON0QE-fcdfu8EiPAjOOCEF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA0MSBTYWx0ZWRfX4hyEHs9Gu1VF 59dRfRfk8fRfKfE9LdlSr2I9457vYFDvj2Oe9Vks4yX2gM7LNSzkeoRfizaPGxCL6MhgdIjQibj cdSsZtgcteq/PvUT267uMxuEUybPaMfkeU45M5ZnixxMaG2th26NmzloY+YI3LWkjauwKMZTLDM
 Yns/bWBe54c79z+G0IiSNATXD+WCK/qU8vhosiNJSHLXU2iyWbtfFR9xDAsb3Kne5LdV6maGBWM btAP0j4/CmKGH4ER9vVNiYIRL/eYBJDfXxEGxDaCE3byntVZUJaNppodJfWtrR5lfWUrgM27IiI UfQZ+4zB4BWEBnIyo7qzfinMIyeHPQBXSOzF/StqcLp8KyuDXhu2bd5xaJyFpviAAKrgVLHIE9R
 DCcho4vruxNwPQwIZnzLeC3plaawsUmacYYjOE/7sqKG16WJhaft/HvoR9Mql7dUAy/AmbNN
X-Proofpoint-GUID: eEAtjYMO7P97frU--vvMkJu3f2-QJ8jF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_01,2025-07-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=948
 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507070041

BPF selftest fails to build with below error:

  CLNG-BPF [test_progs] lsm_cgroup.bpf.o
progs/lsm_cgroup.c:105:21: error: variable has incomplete type 'struct sockaddr_ll'
  105 |         struct sockaddr_ll sa = {};
      |                            ^
progs/lsm_cgroup.c:105:9: note: forward declaration of 'struct sockaddr_ll'
  105 |         struct sockaddr_ll sa = {};
      |                ^
1 error generated.

lsm_cgroup selftest requires sockaddr_ll structure which is not there
in vmlinux.h when the kernel is built with CONFIG_PACKET=m.

Enabling CONFIG_PACKET=y ensures that sockaddr_ll is available in vmlinux,
allowing it to be captured in the generated vmlinux.h for bpf selftests.

Reported-by: Sachin P Bappalige <sachinpb@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 tools/testing/selftests/bpf/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index f74e1ea0ad3b..7247833fe623 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -105,6 +105,7 @@ CONFIG_IP_NF_IPTABLES=y
 CONFIG_IP6_NF_IPTABLES=y
 CONFIG_IP6_NF_FILTER=y
 CONFIG_NF_NAT=y
+CONFIG_PACKET=y
 CONFIG_RC_CORE=y
 CONFIG_SECURITY=y
 CONFIG_SECURITYFS=y
-- 
2.43.5


