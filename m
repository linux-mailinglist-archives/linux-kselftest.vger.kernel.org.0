Return-Path: <linux-kselftest+bounces-25174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCE8A1C416
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 16:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C78164F96
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2025 15:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A701804A;
	Sat, 25 Jan 2025 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z8VyMaHq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D88E4A0C;
	Sat, 25 Jan 2025 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737820086; cv=none; b=EqWF3RPFf2BO9WqFlMiPs9r7Fb9ybQsUrlEQ4AV3uswYGT1C4wtRwO19gT6syPNWa9jphLu+Ix/TbimMQ6d80PSa3h3f28R6uaBPci9RE2RiEjEhSVmPe574bem09IetI8WFQoA/PZl36F84xb3Zdvd6gFQTc70UtFtJug4coFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737820086; c=relaxed/simple;
	bh=UeBzVhxUuj8aLRGmlwDM2T9MI/IwWwO5D4o18G5tY1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E3/V2dl/5klZoyy0dzvOkH0bW/B9R2t8OG8HxboiF7JEV26Et5cWB+YX4n5olKgsbxiOf630i4OWsnWcQHTaWa8G4hDr9cQIUHqoqUv2XYuTIFtSMctqUpafjf4prVJLiWWOgkmVgTKrmWPLS8WAJR1gO3S1D6AoIf6w6hMYDco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z8VyMaHq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50P7X3qC011420;
	Sat, 25 Jan 2025 15:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=W7veP8EVUZoD0ssaGNOn65G5QNNdh0BzLvEzZ7s2Z
	kk=; b=Z8VyMaHq68B1ikmMTT6V5MhCdApJFextlMjz0on3lxGLUSAG1yJ16GyDD
	mGr0gLU24Ddoixi+UI3XMYaH7tGrI2GK7v58CcMAAsu0E98/gZLgomh53Io/k+zK
	AKFI4XOY+Z2CYgn6OiRcp/U5svBs3YoVeq+EegEfH+/Jrgg8Br58Qx6QuBdcq80x
	/ib2vZhAK9ILKdtYCupQ+qhXwxeAuhjqzRhiPwcUj9VJRgKOAO4B3f9w1/4yH7y4
	5am/n6y384iK1FpjFFg9xetCz5VYKGSJ5BmkzdBo7JJ+bJ7s3QxmPWY6aUjFLrgH
	8SeN9edS/TG5XyFBNFWjsw/CERnIQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44cunn98ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jan 2025 15:47:41 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50PFleTO004121;
	Sat, 25 Jan 2025 15:47:40 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44cunn98aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jan 2025 15:47:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50PAmNtv032266;
	Sat, 25 Jan 2025 15:47:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 448ruk8gtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jan 2025 15:47:39 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50PFlcuf46006624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jan 2025 15:47:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 651952007B;
	Sat, 25 Jan 2025 15:25:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC6832007D;
	Sat, 25 Jan 2025 15:24:42 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.43.213])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jan 2025 15:24:42 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: ast@kernel.org, hbathini@linux.ibm.com, andrii@kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
        hawk@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org
Subject: [PATCH 1/2] selftests/bpf: Define SYS_PREFIX for powerpc
Date: Sat, 25 Jan 2025 20:54:32 +0530
Message-ID: <70fb07e980196ced9fc3e5e4dbeededce2e36fdc.1737816475.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8AxlWsM-c264b91E1YimFhHV4D5A490d
X-Proofpoint-GUID: Ls3Bxbnk_U66-BXn0QkGL7spkgbuPEkB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-25_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0 adultscore=0
 mlxlogscore=825 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501250113

Since commit 7e92e01b7245 ("powerpc: Provide syscall wrapper") 
landed in v6.1, syscall wrapper is enabled on powerpc. Commit 
94746890202c ("powerpc: Don't add __powerpc_ prefix to syscall 
entry points"), that drops the prefix to syscall entry points, 
also landed in the same release. So, add the missing empty 
SYS_PREFIX prefix definition for powerpc, to fix some fentry 
and kprobe selftests.

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index f45f4352f..02c9f7964 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -172,6 +172,9 @@
 #elif defined(__TARGET_ARCH_riscv)
 #define SYSCALL_WRAPPER 1
 #define SYS_PREFIX "__riscv_"
+#elif defined(__TARGET_ARCH_powerpc)
+#define SYSCALL_WRAPPER 1
+#define SYS_PREFIX ""
 #else
 #define SYSCALL_WRAPPER 0
 #define SYS_PREFIX "__se_"
-- 
2.43.5


