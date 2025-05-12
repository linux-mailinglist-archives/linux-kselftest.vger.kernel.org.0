Return-Path: <linux-kselftest+bounces-32841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A174AAB32DB
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 11:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 256D117A078
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 09:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5087825A64B;
	Mon, 12 May 2025 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WrLk8Ue1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2E814AD3F;
	Mon, 12 May 2025 09:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041354; cv=none; b=ASYfdLSVF6gWb1kq5GkuyiZknaGYKi+nZov5PrsDTlt9Jyq9jpb+mS/CAZTWNlSl50bNl3wByioC47tp7xZdnSvdgUPCZeIUy6RQAkTDTB4P2HjaT8km8oCMy7QmKSeXfbza3mlA0sGpGoEXoVzeQiRw6RglCLrIZHF0+cv34dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041354; c=relaxed/simple;
	bh=s1SdU+enVUMgwXhMSQPUMoofHMLBjpH8AGzNpTBb3zc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ovfWLZRS+Sj1+DVbpxjF1YffoOS+QHaIKl4Z/DSkAO6zekSW0tOu654Ipm+TmCeFIJaxi0bMuJn3WVpxqdZc3tkKZC7ugHjV1Gy0+sfJdXMb839GCRCXJ5zOnUdEZG17UoIlTqkuQeaV0IaJ9diFb76ulEHINN0UqhmP242Tzws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WrLk8Ue1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54BM01QP027520;
	Mon, 12 May 2025 09:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Vw1BmvQRyJMoGE7KAHnrMxzfKsxMOp3+NcEdr10Ko
	4c=; b=WrLk8Ue1fqUFIr+LUgSpyBwCVUQY4OrlOMcLaoYZLp/Sfhh/FVt7LMXcu
	iOPTNpktxgSbugX/+6sYiJ3ESltGnRTKayWI0N5KHtPCvflWuwpRHgWyhFJc24H0
	EYBoByGyZl+rHq7ADWmgTzqFWg4bbBL8cz9xVDDu4oEI1iTMhLWIh7axm4PvDd2u
	u0LjSQAnEMRMcxbjpDR3YmkjPRuq9E07rC9tAhwVFBbON5IIhl2cFUeaezPefDMr
	1t5Q6p9LyBdTGtjAckdGZcumOkwnGFzMrIPuWqLZLaSzHEo0wbVT3h7/I4I/yAjB
	3Mym4OrtMDBom7/H1otB/thMJ2o5A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46k1k6jd8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 09:15:21 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54C9F4lA029758;
	Mon, 12 May 2025 09:15:20 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46k1k6jd8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 09:15:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54C93a03016981;
	Mon, 12 May 2025 09:15:19 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46jhgywbk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 09:15:19 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54C9FF6l29295150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 09:15:16 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D331720187;
	Mon, 12 May 2025 09:15:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F5F320184;
	Mon, 12 May 2025 09:15:12 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.in.ibm.com (unknown [9.109.219.153])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 May 2025 09:15:12 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: gregkh@linuxfoundation.org
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        hbathini@linux.ibm.com, maddy@linux.ibm.com, venkat88@linux.ibm.com,
        sfr@canb.auug.org.au, alexei.starovoitov@gmail.com,
        daniel@iogearbox.net, mykolal@fb.com, yoong.siang.song@intel.com,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, shuah@kernel.org
Subject: [RESEND PATCH] selftests/bpf: Fix bpf selftest build warning
Date: Mon, 12 May 2025 14:45:11 +0530
Message-ID: <20250512091511.2029269-1-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dNSmmPZb c=1 sm=1 tr=0 ts=6821bc29 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=rV7urDwo7b39epbSBP8A:9
X-Proofpoint-GUID: AEiKzS3arrETV22-ON0_DJ_-wFeZ4kvs
X-Proofpoint-ORIG-GUID: PDLZ1YpOCiHF0Ez_fx3pqkkJJgSDAOC5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDA5NSBTYWx0ZWRfX4MNw5rIJ8mXN VPoa+A6HDIz42KRQqrPfyNkpbrvCsgABqtTQiugkaABDhijXXup+5CNvWcqKdzpePOZz8N7yAFD ui+Hov2E/baHEY3qCxnASCE2oHw9MLWnZt5yI65UIQrBURHcDJ2rZMMVPZWHUNc5ENvTggK1mnQ
 5gAaniMh8ukDxSu47w7TTdKZ1JonojuP1KmyyYqWwAFrbG1UIprCku6rh9J8cnsNKphVOh5mguE XJEUxfhUH4pfbR2fjMBGb3If2FaEoFPWM93QJBXWlSSq2Ga+BNFTMrEjr+Q2B+YYA2MOVvOrnNF mj51V84lJVgMrxaBHPnjqv0LarbNg6UKmaxxmXhB4SJvA2cQvmgEYFdkhl2dscVxCGheXEMeaR5
 77D4cQMyb4glkdqwVk57mX9Gi2bKl6v2juoMVjCX+MiNG+k3PtMyh2DeBap9WAduOz8aAe9P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 mlxlogscore=667 malwarescore=0
 suspectscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120095

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

[RESEND]:
 - Added Fixes and Tested-by tag.
 - Added Greg as receipent for driver-core tree.

Original patch: https://lore.kernel.org/all/20250509123802.695574-1-skb99@linux.ibm.com/

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


