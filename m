Return-Path: <linux-kselftest+bounces-32747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D16CAB1396
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 14:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CEDE1B635CB
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 12:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB95B28FAAF;
	Fri,  9 May 2025 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z7WWvaY4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100AD1482F5;
	Fri,  9 May 2025 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746794329; cv=none; b=fK2utmLAE2MyytF/h83lxAtjKRQSIxCdP5dj5xtG0OuMgFaJ8qXaUY8ZDWnHqgr9VuTtSYjoQpejBCA/O5kvVtxBD7XE5kenjP6uII/3xphXCBhR4gomdWGiV6F6DMKX/bzjLQ1UWnOyVvQitSImCGj/KiVuWuZB4ICqYx/er4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746794329; c=relaxed/simple;
	bh=qilA77jmGaVhK0ChWSp1KyvYj5Xbbeq7sn/IHxqa5zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ruAQm1PAEAVREHjDKh+1vJH0LA9woQQBnkg9s7YMWe8viGytIK0aV6zPuGfB0te15sf8IqskdtaxTtwJQh6pUJe05/0DKRaQKBQw+OqKfbbkw9xKdqHCbIrZbsbRFpbi36+S2qI5UocH9VKk0Eow9SpfbePVcXsRDAuLEQlx3dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z7WWvaY4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5494BvKT017144;
	Fri, 9 May 2025 12:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=1GxsOSHaEZ3WauZ1cTkJRldsvonqkn4VH/52jeaGU
	m4=; b=Z7WWvaY4g6eCXiYUiUlKyClENxdQjuQkp9700lVVUOkAkssBbj096LEru
	GjOG+tquLK40lDeyNh3vMAWmYfddtqfUhqj6yhS6rF/stF6URVRpIBeferkYor0y
	JiYuQwAvyf3xk5tSwvxjxkP9i2BAzvfjMV7lOP3VcCPlkXHnmnl7Nl5tvtnR8SCI
	QLzVOcLBlNtJeZu7jfyZEu4yZkWVeQGgiX+XaFyeRZEeh+qoJMQSTGuh0QxvJUMs
	2lCUqUNr4KgMoWza0dhiUloHAqh4/zj3api+8zV31DzvNqPbpXmVGuy3LUy/Pw8X
	NEYSnzligZH6q8pgIt/r8Nvbh6isw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h46kusy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 12:38:16 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 549CLItO014654;
	Fri, 9 May 2025 12:38:16 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h46kusy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 12:38:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 549C6iZa004650;
	Fri, 9 May 2025 12:38:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46fjb2fy1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 12:38:14 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 549CcAws39322032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 12:38:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88F75200E6;
	Fri,  9 May 2025 12:38:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EFA7200E4;
	Fri,  9 May 2025 12:38:05 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.107.211])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 May 2025 12:38:05 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-next@vger.kernel.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, venkat88@linux.ibm.com,
        daniel@iogearbox.net, mykolal@fb.com, yoong.siang.song@intel.com,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, shuah@kernel.org
Subject: [PATCH] selftests/bpf: Fix bpf selftest build warning
Date: Fri,  9 May 2025 18:08:02 +0530
Message-ID: <20250509123802.695574-1-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=LaM86ifi c=1 sm=1 tr=0 ts=681df738 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=rV7urDwo7b39epbSBP8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDEyMyBTYWx0ZWRfX98i5fCsNXz65 vEK61wvfV2yQXLF/PG5XhanzoMmpVJUPXj4/McsweqYJxpVwcEBk6gzFfPWdzMji1adaZ/yNs/i k9ah1V554nsBjL1dh429MK5eBC6qdvSWeN2zp6pe9JGdR4kFtkm/I13sjxjummNxKl4hzv4Hqcu
 9hmpNGk3wR5PZsE5K6Dp0TM8dkIxA/VTewFnzH9bdLG9qYP6JKYW6ZLbZ16BNZSWwahr4SEWP8j 71r+R6Kqm9j21WYIIKqmbV/UrP1HLhdiN/NWXb3OscsCeKEK5hYW2IQx5KOLTaICu5XvveBYRX1 XQfoFWIngz5yQD5diwQAlnBvwjcBwpRvS/4Nri9klJ+ix93TOM+cz+IJyngNyISISD6QAEiGf26
 RjPl6+OFBjjkz2303QBaxkyTH6iM6syy8GqREPTmUnxHYcJq+dw1ncLeNlawKqJ4AypLV0/C
X-Proofpoint-ORIG-GUID: cOPeE_N3CccJrHFznoIfflPq4YPJqSuH
X-Proofpoint-GUID: K-YC-2hFpvEpO7YRJnr9fxDNdKaIviEO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_05,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1011 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0
 mlxlogscore=703 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090123

On linux-next, build for bpf selftest displays a warning:

Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h'
differs from latest version at 'include/uapi/linux/if_xdp.h'.

Commit 8066e388be48 ("net: add UAPI to the header guard in various network headers")
changed the header guard from _LINUX_IF_XDP_H to _UAPI_LINUX_IF_XDP_H
in include/uapi/linux/if_xdp.h.

To resolve the warning, update tools/include/uapi/linux/if_xdp.h
to align with the changes in include/uapi/linux/if_xdp.h

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/c2bc466d-dff2-4d0d-a797-9af7f676c065@linux.ibm.com/
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


