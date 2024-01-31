Return-Path: <linux-kselftest+bounces-3829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7D8844023
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 14:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF803297F76
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 13:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ECC7AE5C;
	Wed, 31 Jan 2024 13:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F4JoE4Mw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8357D3EE;
	Wed, 31 Jan 2024 13:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706569; cv=none; b=nwsknHDWBAd32YgIWjJwzO0IbPpszwXsFafeua4t1kTquPryoGMPMdWsu0X1bbpQKcIAzBIabxkSwirKx/Nm7tIgnthMeukpy6FM9lEJb7AFTQdJmK3M6ighmI91npGo3D+0iKVT81WvGwZyR4rsXDKl/SQDc7IUkLwIuQ/lx5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706569; c=relaxed/simple;
	bh=ProXTEbb42WMrODS82z2i95OCR1gKnbNsh8jOLrnuI4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E6Er3JgJTYSYDbinuMYT7P7YnBHmG15rWg9zubLXf9hmi1d8DxdHOKxSEd1TJwI9JuurP4XW515ZhQ2gx6guucjKvg0cpKQT8SQJ3oZDOLOWR+oo69dVFmkXc/h7uzbDJpuBvMvMBjAWMAJfyPZJwqEfKWuPp+aNIYvQwqnfOhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F4JoE4Mw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VBaYgi008037;
	Wed, 31 Jan 2024 13:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=yjp8mNUxahTgn7kvuM/IVGuQ/zwU7B9XzbCPNzk19Eg=;
 b=F4JoE4MwRCfUiFU3YlVQ97KGcnfQuzeuXkErfTrzFLHktQhbu7xnQZzC+iLG7xaCmBci
 4gZ0aJioZKFbWcJ28UNKCHzKJZFvdGnNt3QG+l6+MgGNlpHQ6uME9s07l/3/o6Q1aK8m
 tM9EMDkr6lA4P/wa8g1Dyu28ac2ikVqm4LffRpezFnOUiOWwxOOJtjpxYKaLp04JL727
 WIxg3Q7B+rVv0shQE2nW44Fyexiv7iUQtRcjEUHzUf5uvd3mdpMFiDuz5AF8hSOBb/bU
 NVRQ5HqGn4ewhqdeJKKLGXQFCljbMRWIwOPuXWkTwjMH0GQ4YhSQoc+Q3oZ1D2Vg2FgO YA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vymu839k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 13:09:09 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40VCU6k0023273;
	Wed, 31 Jan 2024 13:09:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vymu839jh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 13:09:08 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40VC5pqg008234;
	Wed, 31 Jan 2024 13:09:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwdnm5cpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 13:09:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40VD94An57147712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 13:09:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B51B82004E;
	Wed, 31 Jan 2024 13:09:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4FE020067;
	Wed, 31 Jan 2024 13:09:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.59.95])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 31 Jan 2024 13:09:02 +0000 (GMT)
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
To: linux-kselftest@vger.kernel.org, shuah@kernel.org,
        skhan@linuxfoundation.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, nathanl@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: rnsastry@linux.ibm.com
Subject: [PATCH] papr_vpd.c: calling devfd before get_system_loc_code
Date: Wed, 31 Jan 2024 18:38:59 +0530
Message-Id: <20240131130859.14968-1-rnsastry@linux.ibm.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: of0iIm6w8rYeDF7JcWbHIF16Z7Rixjyh
X-Proofpoint-ORIG-GUID: O83hNWb-4by3EyM9cdH9oufTUYtX3KgY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_06,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401310100

Calling get_system_loc_code before checking devfd and errno - fails the test
when the device is not available, expected a SKIP.
Change the order of 'SKIP_IF_MSG' correctly SKIP when the /dev/papr-vpd device
is not available.

with out patch: Test FAILED on line 271
with patch: [SKIP] Test skipped on line 266: /dev/papr-vpd not present

Signed-off-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
---
 tools/testing/selftests/powerpc/papr_vpd/papr_vpd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/powerpc/papr_vpd/papr_vpd.c b/tools/testing/selftests/powerpc/papr_vpd/papr_vpd.c
index 98cbb9109ee6..505294da1b9f 100644
--- a/tools/testing/selftests/powerpc/papr_vpd/papr_vpd.c
+++ b/tools/testing/selftests/powerpc/papr_vpd/papr_vpd.c
@@ -263,10 +263,10 @@ static int papr_vpd_system_loc_code(void)
 	off_t size;
 	int fd;
 
-	SKIP_IF_MSG(get_system_loc_code(&lc),
-		    "Cannot determine system location code");
 	SKIP_IF_MSG(devfd < 0 && errno == ENOENT,
 		    DEVPATH " not present");
+	SKIP_IF_MSG(get_system_loc_code(&lc),
+		    "Cannot determine system location code");
 
 	FAIL_IF(devfd < 0);
 
-- 
2.37.1 (Apple Git-137.1)


