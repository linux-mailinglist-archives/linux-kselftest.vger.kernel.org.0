Return-Path: <linux-kselftest+bounces-3312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A351836280
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 12:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B375291D02
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 11:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD413B790;
	Mon, 22 Jan 2024 11:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dVetWdx6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF4E3CF5E
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jan 2024 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923977; cv=none; b=E0Xz/kgXrL6aZ8KXMRKGPxVKEm/HohOWuZx4y9lCndCp3HAhFvGU3KCPOe2loOVm380qjs3S002fFMWO7URl0Znx5jgzn+euti/QBzKCwLwBceR6AvvUxlZVkHpEf4aXOqKagAMnbhWzGQgRSgmqfd+xbsTqxbkytGUgqiAJiY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923977; c=relaxed/simple;
	bh=ProXTEbb42WMrODS82z2i95OCR1gKnbNsh8jOLrnuI4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OMN3ejKwYHM32ttn+2eq/YQqf6UqSuVRYb/Kf7Vh6V2CX7giCrbPnPu+/X7f2wcQINLjDuBSkSYKOj2n33p3Agw9tM+/xW28o4wgxaz7xOJQDVqlpNdtVV3t68CzIH25OBdCcvbRh5pgYSLkKWX4ISNF0UsrQIbljB3n80yGOnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dVetWdx6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40MBQeat013649;
	Mon, 22 Jan 2024 11:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=yjp8mNUxahTgn7kvuM/IVGuQ/zwU7B9XzbCPNzk19Eg=;
 b=dVetWdx6AmSJ406orknqwhruHB8fEOr4i+8Eo36uFdtfrst5HF9RB/pBkxdCo91Wa/b/
 RjkCci79iyKK5Aaig7cBoLpgN38j0Sc3MnMIm6KABge29i9E6905P9C84fLrT7F1A2XA
 gxSgSSf8eLyvBlBoj1Ws+8agLE4wXHpWZh6e9n2tHfHkfrNW9S0HRVVDRhYVjk4I2h9/
 ZdVlcO2S5aDGCko840/CnzOnUMqT+sYbSXxKCUlEB0emPDV4/NnHMwF0wArk0W6ilkPV
 z+JfM23KZbGSPVBB3We383nzbSd17Qltmo6uANOIeS9w+700oU+caRZ12Dj3+QuomiSv kg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vsqg18ga6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 11:46:12 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40M8vsEs022438;
	Mon, 22 Jan 2024 11:46:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrt0kqxrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 11:46:11 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40MBk9fT42074868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 11:46:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12DE720040;
	Mon, 22 Jan 2024 11:46:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F1F02004B;
	Mon, 22 Jan 2024 11:46:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.81.3])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jan 2024 11:46:07 +0000 (GMT)
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
To: linux-kselftest@vger.kernel.org, shuah@kernel.org,
        skhan@linuxfoundation.org
Cc: rnsastry@linux.ibm.com
Subject: [PATCH] papr_vpd.c: calling devfd before get_system_loc_code
Date: Mon, 22 Jan 2024 17:15:55 +0530
Message-Id: <20240122114555.47513-1-rnsastry@linux.ibm.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1-pbW6YaZ4BzpQV7n0yPFfrP3I52q7A5
X-Proofpoint-ORIG-GUID: 1-pbW6YaZ4BzpQV7n0yPFfrP3I52q7A5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_02,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 impostorscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401220083

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


