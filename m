Return-Path: <linux-kselftest+bounces-26935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEF7A3B1C1
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 07:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8676916638B
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 06:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9347D1AF0C0;
	Wed, 19 Feb 2025 06:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Eyq9PAKJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BEE16D9AF;
	Wed, 19 Feb 2025 06:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739947635; cv=none; b=K5+9lJevKGlDuDjzGvxaJ4cV7vEtBp9nEaI7T91TtvpPOFn91p+PEQJNQ0FkyE5+MvKbg8K78/UCx+8H3P0sv2iY5c1j+0HXOWMD4vqCIMvtOQc21+onb25f8daS0/+ApPzh15/Z2jfjI/q0ATiFFBabeExoiU2M7khzVh6qsOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739947635; c=relaxed/simple;
	bh=MYxLqKiBVCSV4EA6RHnM/JzZtNB2EIQInZuDvNCBosE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tc7b1I/QW+OC7PsLC8zxbBniUWwohq7TJsKLn3uIVFuvMuAdzkvy6kmFq0qmPNdm9lQYfW27OpktSHcSRQtUKWg4Bue40nSOK+Tc8/M70GzvMudWT1kw95kColPifM+49cqHN6fsKHOubLnKXsiDEuOf1l6UQFBiDtGyo49uUTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Eyq9PAKJ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J1ubbQ009405;
	Wed, 19 Feb 2025 06:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=FEuUaF/SEFjtrbP1K05Imcw37t8jk
	DE0hwRUENn2CnE=; b=Eyq9PAKJ4O8NqQvhtG2tpanbp4iCIj6KNDNPyd6qNw8qh
	ISckGpEP+FgPle8TxBvyHLDgAVMR31l53jj33+LVfbfRhNs7ogNTCXJxcb8tH+7a
	KdBjspdJBH7CByC74bMTMx7EszDAxOSdi2w1G4aBXvflyHxRQep8v830rTbwwGJC
	0g7zoynyrOgC+77d7/gLtY8mFyc73Ny3q+T7xo87Kn72huBSVTntETqkgVi56Ln7
	vU62DFIYCe8otWcwYStv0O5h5+5Y9LdabcLZgYXMGWJqzie/oiaJa36heGuYYAtz
	PiOJgPYF4p49vJsSENJdYrmT2l6T4VNgCRk79yStQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00kgytf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 06:47:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51J5EmRi012111;
	Wed, 19 Feb 2025 06:47:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w0b22s4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 06:47:08 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51J6l8LS007963;
	Wed, 19 Feb 2025 06:47:08 GMT
Received: from sishan-bugs.osdevelopmeniad.oraclevcn.com (sishan-bug36880967.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.109])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44w0b22s3n-1;
	Wed, 19 Feb 2025 06:47:08 +0000
From: Sinadin Shan <sinadin.shan@oracle.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        chris.hyser@oracle.com, Sinadin Shan <sinadin.shan@oracle.com>
Subject: [PATCH] selftests: sched: add sched as a default selftest target
Date: Wed, 19 Feb 2025 06:46:58 +0000
Message-ID: <20250219064658.449069-1-sinadin.shan@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_02,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502190051
X-Proofpoint-ORIG-GUID: PMe11uT95MgdSUQVfPVta_zzM2pE6qXT
X-Proofpoint-GUID: PMe11uT95MgdSUQVfPVta_zzM2pE6qXT

The sched tests are missing a target entry and hence out-of-tree build
support.

For instance:
make -C tools/testing/selftests install INSTALL_LOCATION=/foo/bar

is expected to build the sched tests and place them at /foo/bar.
But this is not observed since a TARGET entry is not present for sched.

This was suggested by Shuah in this conversation
Link: https://lore.kernel.org/linux-kselftest/60dd0240-8e45-4958-acf2-7eeee917785b@linuxfoundation.org/

Add support for sched selftests by adding sched as a default TARGET

Signed-off-by: Sinadin Shan <sinadin.shan@oracle.com>
---
 tools/testing/selftests/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 8daac70c2f9d2..e2d0d389ad912 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -91,6 +91,7 @@ TARGETS += rlimits
 TARGETS += rseq
 TARGETS += rtc
 TARGETS += rust
+TARGETS += sched
 TARGETS += sched_ext
 TARGETS += seccomp
 TARGETS += sgx
-- 
2.43.5


