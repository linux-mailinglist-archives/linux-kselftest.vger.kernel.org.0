Return-Path: <linux-kselftest+bounces-27531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221CFA44C13
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 21:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5698422F72
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 20:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76207211282;
	Tue, 25 Feb 2025 20:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O0IR2pws"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53CD19B5A3;
	Tue, 25 Feb 2025 20:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514179; cv=none; b=WyIzcdfFUUGL6P/Dkj8XC71loxoqBV58cI3ZF6djB2//xZ7hPRNKhEe9t9zfz68uDkg3f7TTyxdWVB7xmb7XCiAGD+bx+sqcsefVwUSj/WeCZ1JEQ/8kmYTxnlhQFNRjhG+J5mK04sWwsn6aV4YMb6gO0u/ytqAv0eM6MsBEvKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514179; c=relaxed/simple;
	bh=gSp+iwas8q4fURy87r3vrpRkdO6BQ2hmPXt4cLfksSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VnjEM6MjM5S2oNR9p4x+zbV3zM8BoNgJl5luR6ZbQA1IzZP5A4dC0i/tCBNpDoS0ANK7fPQ3FYKHLpiJ18s3hcXsMQMZ/qkDbawnjycw/wMuXrNHXmqppjSYWAL2nnj1TJCgZGIoo4dNIUhzy/igFZXcqBeAGhGXl7aRerfpX/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O0IR2pws; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PIXgRa007526;
	Tue, 25 Feb 2025 20:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=EhxAP
	HTe66rLGXBARqiCtEmzc2aeftoE87GPqQGMK5w=; b=O0IR2pwswYcsLUpsnh3ki
	xVtpiLC2TeWneVFiSiPoF7JbSV9zP5dDb5T5hfS5IriCtUSlgD8b3fA+iQydW60F
	khSlfUiJud/cpW2pgFGKd1x3/rZE2j539fTf4E/nabVKd+cQLpJe3DN3b2+MmlmU
	RvrFbCHEwMlQaV+LIEf/66GEd8mSHtnLmYuzng5+mjJnnss5sbBFnYG8UY4AJeZu
	tDorbKUmeWAWnphf/XxyZa0NtDK+HC/B6M9LbvORs4SeAGT9g2Tl5YW8dstXWbDz
	/RW52qKQH7v7CHeWjEqhpFAtinqB44U8vzR3fQ/PzstK72A2ZBT70fopfXVrevWt
	g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y6f9e4mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 20:09:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PJSTHK025470;
	Tue, 25 Feb 2025 20:09:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51g9yt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 20:09:28 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51PK9QpV011891;
	Tue, 25 Feb 2025 20:09:27 GMT
Received: from sishan-generic.osdevelopmeniad.oraclevcn.com (sishan-generic.appad1iad.osdevelopmeniad.oraclevcn.com [100.100.231.227])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44y51g9yrn-2;
	Tue, 25 Feb 2025 20:09:27 +0000
From: Sinadin Shan <sinadin.shan@oracle.com>
To: shuah@kernel.org, sshegde@linux.ibm.com, chris.hyser@oracle.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sinadin Shan <sinadin.shan@oracle.com>
Subject: [PATCH v3 1/2] selftests: sched: add sched as a default selftest target
Date: Tue, 25 Feb 2025 20:09:09 +0000
Message-ID: <20250225200910.260569-2-sinadin.shan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250225200910.260569-1-sinadin.shan@oracle.com>
References: <20250225200910.260569-1-sinadin.shan@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_06,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502250122
X-Proofpoint-GUID: iE34fYeTF-WS28dy0ys-Z5yFNVm4NDKw
X-Proofpoint-ORIG-GUID: iE34fYeTF-WS28dy0ys-Z5yFNVm4NDKw

The sched tests are missing a target entry and hence out-of-tree build
support.

For instance:
make -C tools/testing/selftests install INSTALL_PATH=/foo/bar

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


