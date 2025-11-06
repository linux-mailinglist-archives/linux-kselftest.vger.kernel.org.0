Return-Path: <linux-kselftest+bounces-44872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93177C39280
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 06:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BDC23AF483
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 05:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8C12D5957;
	Thu,  6 Nov 2025 05:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WT0aHy8l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9A01DA0E1;
	Thu,  6 Nov 2025 05:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762406823; cv=none; b=i6fr8DPoGkqlZpO4c0UpmMWqHUkBBVHVrNVvq4++BgD6fD+tNgst5+c8+xGqW0wK4TgJGbjLZloQfwNIwGoYwhMkvXDgoQ7WU+O9ekygvvHrifhb1WkDr4/4vO5H5XyYvFzvU7br4gnsMdZh95dEppDbll7ZuvWHn1l6N5/ZcKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762406823; c=relaxed/simple;
	bh=mXTgreNXsFRhorKki4yN3xYOpEhF2wvMnPqdRfWqxek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BOIOj57jg6h2535QucO/ZO9Bq8cmijsbEoBPuOjeiyVfwg6NqUptyFNORi0Bcrp0VFAuQzB2qlH/Ew3miHKF0JeBx1FKevQpVCAJFjWmJUxkVMmFjHk/7LcKQ7vGTPnzv8i713dx1a++R5P5H6RmUOGossX+eph9ltgEvZaNuDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WT0aHy8l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A61tqru009215;
	Thu, 6 Nov 2025 05:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=noikY+uTrNQtmlKd5SNHQnCBWAXx
	+LlKyTQx4xBbeLo=; b=WT0aHy8lmLth0OyzkMhzzpoeNqfQDp2/0HU99JGd+wbj
	ngF7PUQrRuqqKnI1Z2hdwrCPvhUOYSoIE0yvu6+qJBUyvvlZpkWP43Q4BQv/2k3w
	6TXRcnlDV+Ssyk1nxGkztGwkquirWnoRl9HRVzrtNshvdku/h1KpeKrfteLok/kY
	hesM+v71TBYzyC1FGCTmoo/O9ENdKw3wDtHj2ZGOMAFjKRA809INlNK7FncYIwaF
	u0k76tDGJWCSLfMGOmMIXxr57gtsEDU8pTZnu8qQRYc4+u5mvym1NthebdLpwwtN
	kr8g9y4cgQ5lfZLdwYZxzabeI9vRiaCiXxZot0INaQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59q959ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 05:26:38 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A65Qb7E006803;
	Thu, 6 Nov 2025 05:26:37 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59q959vb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 05:26:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A62wISU018757;
	Thu, 6 Nov 2025 05:26:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5whnkue0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 05:26:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A65QW3f42008864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Nov 2025 05:26:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C0FF20043;
	Thu,  6 Nov 2025 05:26:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C57FE20040;
	Thu,  6 Nov 2025 05:26:28 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.in.ibm.com (unknown [9.109.219.153])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Nov 2025 05:26:28 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org
Subject: [PATCH bpf-next] selftests/bpf: Fix htab_update/reenter_update selftest failure
Date: Thu,  6 Nov 2025 10:56:28 +0530
Message-ID: <20251106052628.349117-1-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=StmdKfO0 c=1 sm=1 tr=0 ts=690c318e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=1NhHhBnQiQwb0G_R84kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: qW8AzHLwrsLqf_bLWMYosheoSwQ32XeB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAxOCBTYWx0ZWRfX9Dp6lBH/4Opa
 1OL/wznMklr0+/0tT/zj6iuEqjW+KsIpEptCEbU+hGDyf7w2zJLQ85PQgMPEsNEwD3Ng8zBsILb
 glklm1600THaSvhcHrLxQEIYISJT+IVz/ccW5+EN5qr2W8vjmnKE+kFfItUA4ML6FhfNnAUPYyb
 oAxdpVb393CRpfcQtt5iRZ76q5UUilrNMVDR0e/GYhEsFx3m+sYeqAqm0vmASQ/oSW2YW+An6CW
 yTENnJwoe9vXXWYfx+PlQAMIk/QhnMu4A4i5jJhlR75UPOjUTiAblh2qEZqLBI3uxOKLVYJWvRr
 pOK35LRWB8vn4bXOhPzvOqXbeJFrHEqHsg+8FUM4pOOV4afYPNcUTSYjm/Pc8E+kV/9eYrt9Fh2
 M4R4h3l1S496BLDJs3zdSod/fwewzg==
X-Proofpoint-GUID: tx1A5LVx1KBTqquDUM0sUtKoK4rhl76N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 clxscore=1011 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010018

Since commit 31158ad02ddb ("rqspinlock: Add deadlock detection and recovery")
the updated path on re-entrancy now reports deadlock via
-EDEADLK instead of the previous -EBUSY.

The selftest is updated to align with expected errno
with the kernel’s current behavior.

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 tools/testing/selftests/bpf/prog_tests/htab_update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/htab_update.c b/tools/testing/selftests/bpf/prog_tests/htab_update.c
index 2bc85f4814f4..98d52bb1446f 100644
--- a/tools/testing/selftests/bpf/prog_tests/htab_update.c
+++ b/tools/testing/selftests/bpf/prog_tests/htab_update.c
@@ -40,7 +40,7 @@ static void test_reenter_update(void)
 	if (!ASSERT_OK(err, "add element"))
 		goto out;
 
-	ASSERT_EQ(skel->bss->update_err, -EBUSY, "no reentrancy");
+	ASSERT_EQ(skel->bss->update_err, -EDEADLK, "no reentrancy");
 out:
 	htab_update__destroy(skel);
 }
-- 
2.51.0


