Return-Path: <linux-kselftest+bounces-32746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A76AB1342
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 14:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF67B525750
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 12:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B612900B6;
	Fri,  9 May 2025 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="amXmW6E4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B767228FFD8;
	Fri,  9 May 2025 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746793479; cv=none; b=YRkTuA9t+ghcbQ9383WSudYTDZubFwoRo2+qVl1ytiCdXS9WbC/H+Kyg8ZVNWdurDB+OzBe5guuR0HMnIIPGU0ss+45O0AIxxKA1ulC6VkwqT2jdohtoQn/NOubhpfQvXISe6oJ3Sjki/HOObj9jRdepehDTnoThpHlV9/P8vi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746793479; c=relaxed/simple;
	bh=m+uUAXXGE4Lr9Okw8z3WDklkWM6X4LF6ceFNaNvBI+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tgFlOy+5OgTmWl4r0rFIWz9Ut86nhahDPce7bmTC3l+heql56V0xxYuc5UfO+3rYCSnlW6+U1oU+k91yg1nAB3acBZmV30E2KimhE6SzugLQBOEdYOMPua/Ukdug0KZaWIASNEfybEFY9JioLwl9f9uSXv39imdtEITRzDEPXGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=amXmW6E4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5494Bwcx029454;
	Fri, 9 May 2025 12:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=BIWzfxgWixiWNzTzbbOf2zuEQuUDcbIqjDgQNNpK+
	VQ=; b=amXmW6E4eMCuwJxWMOUI7XURM4xDKTx0o4nd6jfRW+UKXHEZh+noqZBB0
	v6uzBXx9sqpaKwhdKlHpoAQVRzN+bqOMCjJVQJnhHQXprwC2IzpUHXaUmEY31MLZ
	Ekts88oAoiwvtajHQKXJSQiigbmn+EuhywZjmohiiq3Hfkc/d8K479cmhKtEWib+
	g9sG0b69LYNLdsr6H85g7hUpWa0o8cc43F2huk3HQNM5IVBXNNQ1iXbKkMrLYCnp
	Z1kHJLjK4BE9iw7juJKE+X9DB30UYemRWZIHYB6H46ILDhZaAlLl/XqRQ8YE0hGw
	XzxvF398V7yEgnD2B+4SsxFL/wIPQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h6k0k745-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 12:24:02 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 549CO2h0027104;
	Fri, 9 May 2025 12:24:02 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h6k0k743-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 12:24:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 549AFS7L013861;
	Fri, 9 May 2025 12:24:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46e062tx06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 12:24:01 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 549CNvgx33555104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 12:23:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E09A2009B;
	Fri,  9 May 2025 12:23:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA26120099;
	Fri,  9 May 2025 12:23:51 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.107.211])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 May 2025 12:23:51 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-next@vger.kernel.org
Cc: ast@kernel.org, hbathini@linux.ibm.com, maddy@linux.ibm.com,
        andrii@kernel.org, daniel@iogearbox.net, mykolal@fb.com,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, shuah@kernel.org
Subject: [PATCH] selftests/bpf: Fix bpf selftest build error
Date: Fri,  9 May 2025 17:53:48 +0530
Message-ID: <20250509122348.649064-1-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i5SEaNzYtik8Y7JXup7kYmp9eCCzylWM
X-Proofpoint-ORIG-GUID: b_ML1_eoJUq3_Toq-K4bzpjQu5N0dnqS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDExOCBTYWx0ZWRfX0ffVYNaLjUR4 ELARAE7ViwMsTSdlETP+ZMrMWO1v8K/aJT4JUhLJwWe4ja7fSeu2C48q+t2X+vu7ZnademuQrAo UXRh/Ma8UthKWI+ZeWa365a7a73o3D1xVUVRl2yW9775b1oJ/gc64UQkEm6CQgfs3bj492CUgcO
 OWisNVxz+gKsG/v7AJ2phqIAR7UZS6JqRXaPay7vJchxmgBfv3juhbjx/nUazgZBdMJGOpUe4L9 E95zqFGoyYkcKZKD8WVtkgSErf+n6GS4mYyT7AOcviw+k6jqHFDkDTarbVdNs5aH+I4aVhNXl34 9ju68rjmvWOz/cRxYignETqHB+p0Q+5nsFEXDFkBcGbb6ef3G1CjnuCu4mW+QK2pGfT5sYoi1uH
 ZvsZr/4jIj0n16ckWGlu1iJXfGlFiaFT69yuS4VcTDicFXYx68NLf9MrMi3IhEYAQ+6w/z54
X-Authority-Analysis: v=2.4 cv=OcCYDgTY c=1 sm=1 tr=0 ts=681df3e2 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=jh_1Je4BJys6wSEZv6QA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 mlxscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=800 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090118

On linux-next, build for bpf selftest displays an error due to
mismatch in the expected function signature of bpf_testmod_test_read
and bpf_testmod_test_write.

Commit 97d06802d10a ("sysfs: constify bin_attribute argument of bin_attribute::read/write()")
changed the required type for struct bin_attribute to const struct bin_attribute.

To resolve the error, update corresponding signature for the callback.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/e915da49-2b9a-4c4c-a34f-877f378129f6@linux.ibm.com/
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 2e54b95ad898..194c442580ee 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -385,7 +385,7 @@ int bpf_testmod_fentry_ok;
 
 noinline ssize_t
 bpf_testmod_test_read(struct file *file, struct kobject *kobj,
-		      struct bin_attribute *bin_attr,
+		      const struct bin_attribute *bin_attr,
 		      char *buf, loff_t off, size_t len)
 {
 	struct bpf_testmod_test_read_ctx ctx = {
@@ -465,7 +465,7 @@ ALLOW_ERROR_INJECTION(bpf_testmod_test_read, ERRNO);
 
 noinline ssize_t
 bpf_testmod_test_write(struct file *file, struct kobject *kobj,
-		      struct bin_attribute *bin_attr,
+		      const struct bin_attribute *bin_attr,
 		      char *buf, loff_t off, size_t len)
 {
 	struct bpf_testmod_test_write_ctx ctx = {
-- 
2.43.5


