Return-Path: <linux-kselftest+bounces-35095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56F1ADB638
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED02F3B7F34
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33D128689D;
	Mon, 16 Jun 2025 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iNRk/s67"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4A82857FA;
	Mon, 16 Jun 2025 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090055; cv=none; b=hDW5TmzMBepgGpLHbnlwlUccLQcSINK4OpAIC7kMfqRrnbPDzqCP2luHpoGe07HXPPPY47KRN8sVRD+iR+4JEiCGteaOmO0Hy74/CeVFYdfVGOry6LgVTkzfPqcZLVJdmWcB4Ax5As7//2mxvclcQJWxK2kuK8lPkA2Kz5OGi0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090055; c=relaxed/simple;
	bh=x/x4aLow37aTk+L+jDqgnakkPvatvVHAPIBtyvRRXAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7aDkUBADrpssTcm56oazUlYHfFiZ4q8uacKFhElYxaDwaJQ1+guWI1vu9yhj1GaXqkAmUxZUSzC39KG6EzyHMo4k4zBuCnwTvP3aKtEDqajQrCmHrCehbxXGtIsWoStsOsqJAxp7WkpVwNddvhzeqpvq83DQlwgIvwNDaPEcdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iNRk/s67; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G991AY013046;
	Mon, 16 Jun 2025 16:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=iet6fkxV/bIEsJnYo
	huK8U1oRhWcyLPD+7ECreKi1GA=; b=iNRk/s677hvWl5SJmNWQ8g1hN5SKTaEv2
	ynuDdNofhDqCaOdGWQgpR45skFbKx/cg2nClGzGUhuzz1ZOI30UVmEti2/RPynXD
	V7VGUqbGRLP2PZ23/032YZBBPaRgt2jGxqDdGCdBHXf9ptqCBxFLvOGn6e6za/J3
	I3cl/LP3NQ+hVBWd2LkBg/lU/oF5RZnMSp9G/PlDNwFoFfvHjcZS8Ejwo2Nz7nG/
	CH8JSZvJA6w9U6sAWzvnxsmlR63oGvYFNVruYMwKe5rMEpt9aTs9qy0V0unBLsg2
	rSpk+8wdXG+NJLYp3I5fzbvm0AOww+5/HYQTJ0AXPRYdR2O7+osTw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790s4axkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 16:07:05 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55GG65t6024407;
	Mon, 16 Jun 2025 16:07:04 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4790s4axkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 16:07:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55GEWnwi014115;
	Mon, 16 Jun 2025 16:07:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 479p426hf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 16:07:02 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55GG6xcH38535528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 16:06:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5413E20043;
	Mon, 16 Jun 2025 16:06:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78E0A20040;
	Mon, 16 Jun 2025 16:06:53 +0000 (GMT)
Received: from li-c18b6acc-24ee-11b2-a85c-81492619bda1.ibm.com.com (unknown [9.43.33.110])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Jun 2025 16:06:53 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Subject: [PATCH 3/6] selftests/mm : fix test_prctl_fork_exec failure
Date: Mon, 16 Jun 2025 21:36:29 +0530
Message-ID: <20250616160632.35250-4-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616160632.35250-1-aboorvad@linux.ibm.com>
References: <20250616160632.35250-1-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDEwMiBTYWx0ZWRfXwFJenYL91mJJ T+LXr+EzBm8zMdK61YwKeGS8+bR1mBgafkb+sU8R7WpxbY0wsFkfhP73YzxE0htoiaIK35Ey47K lSQg3x/ziTOrh52vWdotjOY//hhSRSJsuD3tKPfq7+v46z1Fl/nqNZ2PN8Ta+JcDgjeYuz4Iu9K
 Rpgs02Y8pxz3vGAhhgItO56BMC9wFJ3un7lpU9/Ja4xPihJe2xfbjmIEeoWeoViwjuiT2+mcIQB vUJdRqiNQ+my4m9z6dp2P8ma55qYx4glwk3DVBYcBSJKfU42l8ca1oofyOo3IpVh/Zb8ztSlZ1P pA6yOR8FbZg43HHP3eHm6nPNOxphA0uXPH9sWbprNVhcu960pV3p1liE1mFk49wECG8rEg/Lmqt
 r4plqFjY6cDMUAk1jdovaUuG2BxS4ncaxwEJOINYsDoOAglZjupvxIZI4oQMhbTDGIt82auH
X-Proofpoint-ORIG-GUID: xAycF3Go-Ax1MCywO7bjkEKluqpDCkzb
X-Authority-Analysis: v=2.4 cv=Qc9mvtbv c=1 sm=1 tr=0 ts=68504129 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=tTGku2e1hV2iMNi-bh4A:9
X-Proofpoint-GUID: zvUXO0GDhe6OEV-Y4q392kIY97Ih_us-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 mlxlogscore=956
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160102

From: Donet Tom <donettom@linux.ibm.com>

execv argument is an array of pointers to null-terminated strings.
In this patch we added NULL in the execv argument to fix the test
failure.

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 tools/testing/selftests/mm/ksm_functional_tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index d7d3c22c077a..6ea50272a0ba 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -579,7 +579,7 @@ static void test_prctl_fork_exec(void)
 		return;
 	} else if (child_pid == 0) {
 		char *prg_name = "./ksm_functional_tests";
-		char *argv_for_program[] = { prg_name, FORK_EXEC_CHILD_PRG_NAME };
+		char *argv_for_program[] = { prg_name, FORK_EXEC_CHILD_PRG_NAME, NULL };
 
 		execv(prg_name, argv_for_program);
 		return;
-- 
2.43.5


