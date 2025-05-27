Return-Path: <linux-kselftest+bounces-33836-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B64AC47B5
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 07:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED8F3B61BC
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 05:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BBD1C5F14;
	Tue, 27 May 2025 05:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V/FBWR68"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF213C13B;
	Tue, 27 May 2025 05:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748324552; cv=none; b=s8FmR91PysjRiP93JGskCUv6kqXm9HDnYVts1u5AcVQIpUU8lsT/pEgU+wd6csFdPSIkfUHDyDHJfcNKH03hYmBSAslmMxRz0ixTsZ9swvVX5FraszHnhGX0AQ57QBsptIPJUBGJwpxHp+DWwbk8NzP13qyc8gPMu563Ei01ykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748324552; c=relaxed/simple;
	bh=LSN+JZs62AFH8k+p7KoqWLl+5lo1kiXD5xF9uP2he0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O3x6+b9iT6UKCams5/SW1ClAqFfGj1IAA8tRtez71kQ9RxDxbGVnmzP1SnoYAoBbUQEIqgBC8CgjYtdh5dY40BsgStoqQo4vs7hvdocYK8E8DH++tCxCBccjrJc8+Sr7GE+g10k7pEcsu1JbLVLaewrKOBbReu2KL4hLso/MqIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V/FBWR68; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R5FfiB015958;
	Tue, 27 May 2025 05:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=GB88/zUggTdqQf1vImnha+8Sk12HP4jhUFUL0qn4Z
	vU=; b=V/FBWR68q7U5PJamO7/+CQq+tyxlawzMoIkWkG/nRZ9+uewlSxq8Q8Ztr
	m7A1OpVNv56X8JSogwuQgOSjj8j52Z5KfouU0jQr4AAiPcQWAq+ld62QBIFquQmS
	X0h07LxZzYsuPoyqeJ8QPJHB10r6vLKp+fw4U6nOkpsh5eHRFXlpTvTCk/iWEVeL
	PTB0g6Dn8cnZ6wRJgtK/2PGKIpXorIkexRxwijT5YpX3OFuHVO6u+O4jUVAtddwR
	oO97vUl3NdHSk6R18WIUM0g1nCeFK9rlIEsgGHoTqtCLBHEqyZAklPp46YZOggAH
	GMS9iN88u4s/CWHadl1fOc6+9xhsA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46v0p2g75u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 05:41:52 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54R5RbJ8032740;
	Tue, 27 May 2025 05:41:51 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46v0p2g75r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 05:41:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54R2pSY1009847;
	Tue, 27 May 2025 05:41:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46usxms7bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 05:41:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54R5fkgp47841684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 05:41:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C934A2004B;
	Tue, 27 May 2025 05:41:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F9C420040;
	Tue, 27 May 2025 05:41:41 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.24.30])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 May 2025 05:41:41 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        hbathini@linux.ibm.com, maddy@linux.ibm.com, venkat88@linux.ibm.com,
        sfr@canb.auug.org.au, alexei.starovoitov@gmail.com,
        daniel@iogearbox.net, mykolal@fb.com, yoong.siang.song@intel.com,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, shuah@kernel.org
Subject: [PATCH net-next] selftests/bpf: Fix bpf selftest build warning
Date: Tue, 27 May 2025 11:11:38 +0530
Message-ID: <20250527054138.1086006-1-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hniIQAKNbKaMz0m7uRoeVVGmN4blMz1r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA0MiBTYWx0ZWRfX2KH/YZ+IXrD+ xEwRJfReATiRs31NWV8AHzlO+alRQxKzjNz03su/4PdjDwFwCMnMclWmCbI8sOigQtx/uiisz94 wpKFdDXu5QFUsnQcjZ7a3KX3p4tuznFhguhpQHkI0B8CIMGy7LB2el/unBH+vCfMq9BFtj+PCLg
 v7pmMp9dqtjyTSSuXI+zw925ImeqPR171eKx5d+LLwLpMfqpLFrVG70b5mqx0DucYAEOixRxVu2 P+/v7k5Otum5E0CBJa7vVTDZXr6TObLh5Y/Tc22YICRzPfMINs9h1TnThZywBfTlY7JcJL3ZkZi X+yrPf32qcMZNXLmguE/5vJvplY+gaFnjDHhHZohduGQUJtLxVlRNWzrZ99+tkUnDxM45JLornJ
 aevHuUXaYlaHN6RkOy4ICEgssJHEzd+IbjKgqHtR3KnQJkTfKexMqq5gfk+JgKxQZE7GuPka
X-Authority-Analysis: v=2.4 cv=Q7TS452a c=1 sm=1 tr=0 ts=683550a0 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=rV7urDwo7b39epbSBP8A:9
X-Proofpoint-GUID: kUl06Ny2CnDbsd5iHLU-MPR7ppgJ17oC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_03,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxlogscore=695 phishscore=0 clxscore=1015
 malwarescore=0 adultscore=0 mlxscore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505270042

On linux-next, build for bpf selftest displays a warning:

Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h'
differs from latest version at 'include/uapi/linux/if_xdp.h'.

Commit 8066e388be48 ("net: add UAPI to the header guard in various network headers")
changed the header guard from _LINUX_IF_XDP_H to _UAPI_LINUX_IF_XDP_H
in include/uapi/linux/if_xdp.h.

To resolve the warning, update tools/include/uapi/linux/if_xdp.h
to align with the changes in include/uapi/linux/if_xdp.h

Fixes: 8066e388be48 ("net: add UAPI to the header guard in various network headers")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/c2bc466d-dff2-4d0d-a797-9af7f676c065@linux.ibm.com/
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 tools/include/uapi/linux/if_xdp.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 42869770776e..44f2bb93e7e6 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -7,8 +7,8 @@
  *	      Magnus Karlsson <magnus.karlsson@intel.com>
  */
 
-#ifndef _LINUX_IF_XDP_H
-#define _LINUX_IF_XDP_H
+#ifndef _UAPI_LINUX_IF_XDP_H
+#define _UAPI_LINUX_IF_XDP_H
 
 #include <linux/types.h>
 
@@ -180,4 +180,4 @@ struct xdp_desc {
 /* TX packet carries valid metadata. */
 #define XDP_TX_METADATA (1 << 1)
 
-#endif /* _LINUX_IF_XDP_H */
+#endif /* _UAPI_LINUX_IF_XDP_H */
-- 
2.43.5


