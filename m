Return-Path: <linux-kselftest+bounces-32840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FACAB32CC
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 11:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575E817B19B
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 09:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB38725A33D;
	Mon, 12 May 2025 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ifONiE2I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2968E24C083;
	Mon, 12 May 2025 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041110; cv=none; b=c0fRu9JKTxpnfXXJEN7ODRpZ+AGNqlBfAwVd6DmfDpcoiK0aJ7SWzsF9OcGPAhKMeAUqTiRrd4yxUcu92AxVGEJHqP2ioi9GhGHyBvfnCquIUYwmvjcm3Sqr0eN90fzW4bwNg9XsV23+S/P71eMqSes7LkcqzP6Eqdc99rFFJZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041110; c=relaxed/simple;
	bh=W46spw9rLIkWRcAuZ9b5EhRVf0rvSNjCOOC9DrpFxnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nk5bnIxV+WLL+GmeHB5TSdTkomA25PVdLBVsqzNYtzc05OV6/HPzSzD3grIf+m4W0d9MQ/92Fw+HvP0monOUgapqxKhuyrWYfePhv1lcV4JmMYRzKW12J1c/nQxXo4UgKTDbGUodeMuAzZXRj2H8++FeTeofJ8hU1w9KzrKiyXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ifONiE2I; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C5uGsO002574;
	Mon, 12 May 2025 09:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=gygIZhYGtbWQoFQ9niyXbiOPG1NLlAASp9EPz500z
	ec=; b=ifONiE2IgIxxo6gEjYWQXt0rpUdaOLzX/dDy+PSjp/V5PkJHLe7pYv032
	o6qRgtJeWDEPc0162u4cUD63aIehZWBDM5Jw3UxNLAmlltQ5kjx8dRLKRVhr8nlq
	/qGl7B9It7xps82nr9cCvSmwwZ/yWqot4oC9QIWBEmXcJZHudRwEuPrUjatwTxiG
	DVSzSMOHXNLEGWNfPlTrX8Tk2A64XTKD9L5asaPg+MmAe6d11qR5Om4P9jGIuvS6
	9b4xQM04rz9Tx85aC/78fETWEvy/csw3P4+hVlXshpjRZ1WcgINOVYmCWtCNVCBO
	U0KSomUQvtAoDXXfxdvmVgKpy3xXw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46jue6b81x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 09:11:17 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54C97wF3000615;
	Mon, 12 May 2025 09:11:17 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46jue6b81s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 09:11:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54C6iipa011552;
	Mon, 12 May 2025 09:11:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46jku24vnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 09:11:16 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54C9BChu31261430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 09:11:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F40920082;
	Mon, 12 May 2025 09:11:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0B3F20083;
	Mon, 12 May 2025 09:11:08 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.in.ibm.com (unknown [9.109.219.153])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 May 2025 09:11:08 +0000 (GMT)
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
Subject: [RESEND PATCH] selftests/bpf: Fix bpf selftest build error
Date: Mon, 12 May 2025 14:41:07 +0530
Message-ID: <20250512091108.2015615-1-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4bV_IKwmpq44jGri-7mCGdrmOMdB5Ij-
X-Authority-Analysis: v=2.4 cv=TbmWtQQh c=1 sm=1 tr=0 ts=6821bb35 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=_H8_jCqrJ5XklwPHSncA:9
X-Proofpoint-GUID: -c5vRGLYrBw1Zs22wB0noNegpfLUV2nE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDA5NSBTYWx0ZWRfXwDxps1gLTnat M56O8HwreV4kftWVcPr0w2Hz2ThfQMyD4u0yD6DJvTLD0hfdNNK8KO97AyJloLhACF30AncRT79 kao8Mvupq4q48SYs6/WZkGbNPJDY06LUkefkETnsurSZcGby8e6KoePC2ydY4HngeJ2dPNg2mpH
 4K6B12U+S8r0mKVsI2PKjpgYlZOWdeypWm894kslpILASZnsGloEMRCJZEDDP3zBOU3+swxfKSS d0wKA8hgcIg1HSWrSx2QJ6OH0JM0lWmuKILlqoa2WYl3yZ9/AXqjB8eP60738ewicvopluHRQHU v4gnYlOADlKiL11xGfaUt3ZvsKiNJCUZ3A7UuzgifAuOcnTYVGTH0EJlyHGASuVGh+0ZguTwWDn
 8nC2wva5DVp6UKr2pbCGRqcIvAexEEgE95O2fqUkKRW2htJ2mab34Ht8gx/pcM3H5pU3PCnb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 spamscore=0 mlxlogscore=904 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505120095

On linux-next, build for bpf selftest displays an error due to
mismatch in the expected function signature of bpf_testmod_test_read
and bpf_testmod_test_write.

Commit 97d06802d10a ("sysfs: constify bin_attribute argument of bin_attribute::read/write()")
changed the required type for struct bin_attribute to const struct bin_attribute.

To resolve the error, update corresponding signature for the callback.

Fixes: 97d06802d10a ("sysfs: constify bin_attribute argument of bin_attribute::read/write()")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/e915da49-2b9a-4c4c-a34f-877f378129f6@linux.ibm.com/
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---

[RESEND]:
 - Added Fixes and Tested-by tag.
 - Added Greg as receipent for driver-core tree.

Original patch: https://lore.kernel.org/all/20250509122348.649064-1-skb99@linux.ibm.com/

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


