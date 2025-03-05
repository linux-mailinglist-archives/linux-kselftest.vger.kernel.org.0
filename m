Return-Path: <linux-kselftest+bounces-28324-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA342A50627
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 18:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1298E16F7AA
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 17:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5762E24EA91;
	Wed,  5 Mar 2025 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WZb9Gnmu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71EA24BC0D;
	Wed,  5 Mar 2025 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194878; cv=none; b=CMAiyln36wdCDz9a8O+s7NqgyCOU5yeGNHsZgi8SQVoPovt3gKjRZtgD85M+nqi9lAc5uzXtLeKOE52LRtiXXZCwNZVtFgZ3gCtJEA4sa8Rl3KdDU0hKXNKyT8NeNwPdewOlKd/IyzdYt2BC2nka8DBD4tQzoRKuHK0rYNXTOhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194878; c=relaxed/simple;
	bh=LcA+Azx1zvoyTAiIOM17FE/qhMZat3YvpeZ2eDY+wE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlpA74nrMfdTY2F4dk6gv2/mIAUVGsV5SMnBAE0GS6wJEC653CXuR7X+u8XToFM5kXhMcTBb1MgCVVq/A4AEjda3bDiQKtHYzCCm94pIsL7TaJ/zVZM6ZxhcK71E0YP69QImvC3NyvzZzkWr4vxy15eYET7zaQ++dOtJGcec1g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WZb9Gnmu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525Ee8mR016832;
	Wed, 5 Mar 2025 17:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PS68SYTKzMk+m8+1D
	IOu/nXCjBltKr9eZ8jthIu8bgY=; b=WZb9Gnmu8g5p8dARv4dq83vFli1EoaXG+
	arAYuDKBMxlJ/2spngx/Ow6JavTZNdoKLaC4GuPUGNW/kabHeiJ1Lq7XUVLVtUdT
	JvHpLEri9YebNBuFw04fkkE+pWq2mqZOdvTz3CvH9/aprXDHNzXMyvCEu4luSfTQ
	ieSYv2z5PQQJogAL9v6YaLrUGdL1Ao4cgHFtf98yPE2DP0iXRTSrr3iuYYjfLqy+
	a6xxoLYBgh6+YXvGXyPuVkT+XvG7P2XfDQqTG+1UGJGPZftmGS0JTNoBcO1p/R0T
	j1ZpMWK5Kj/xmsWJPfjAG16tuy+13UOYOjeKJ+zvSUFGca+K1eeXQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456f08upft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 17:14:12 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 525HBI1h000386;
	Wed, 5 Mar 2025 17:14:12 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 456f08upfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 17:14:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 525FQ6Cm013776;
	Wed, 5 Mar 2025 17:14:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2kutfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Mar 2025 17:14:10 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 525HE86034210330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Mar 2025 17:14:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1FA020043;
	Wed,  5 Mar 2025 17:14:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F6B820040;
	Wed,  5 Mar 2025 17:14:04 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.4.86])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Mar 2025 17:14:04 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ast@kernel.org, hbathini@linux.ibm.com, andrii@kernel.org,
        aleksander.lobakin@intel.com, daniel@iogearbox.net,
        davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org
Subject: [PATCH v2 1/2] bpf, test_run: Replace hardcoded page size with dynamic PAGE_SIZE in test_run
Date: Wed,  5 Mar 2025 22:43:55 +0530
Message-ID: <b6e7bbda97f45dcd0362ab99623d54db32742d9d.1741188826.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1741188826.git.skb99@linux.ibm.com>
References: <cover.1741188826.git.skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HXujsdBj-LqGa-ztEsDxMWAEmoEqGWFI
X-Proofpoint-GUID: nYyOjz_DiLN5SdR9hbKGI60IbV517AQJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_07,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 adultscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503050130

Replace fixed value 4096 with PAGE_SIZE for calculating the max_data_sz
in bpf_prog_test_run_xdp, which allows for a more accurate determination
of max_data_sz, considering different default page sizes across different 
architectures.

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 net/bpf/test_run.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 7cb192cbd65f..c0d5bbf20098 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1249,7 +1249,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 		headroom -= ctx->data;
 	}
 
-	max_data_sz = 4096 - headroom - tailroom;
+	max_data_sz = PAGE_SIZE - headroom - tailroom;
 	if (size > max_data_sz) {
 		/* disallow live data mode for jumbo frames */
 		if (do_live)
-- 
2.43.5


