Return-Path: <linux-kselftest+bounces-27156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCACA3F392
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 12:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59B717D2AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 11:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2977A20A5D2;
	Fri, 21 Feb 2025 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zrvx+0q/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC4B209F4C;
	Fri, 21 Feb 2025 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740139106; cv=none; b=VjXGe2X6xwLHIRZ2z+glusqdaDZxXRV6deSyIq9rQ8qdFUf/Vqs/Mc6NRtV5402MukZ9SwWkWSlrAeEPN3Pkdh+qCWsnjbmeak9QoxMO89IhP813EYIq/0qrRBLLhLl9/HCKB5ak6cBG/ODirsQkF6623bP36HE76W2duNcBZaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740139106; c=relaxed/simple;
	bh=gSp+iwas8q4fURy87r3vrpRkdO6BQ2hmPXt4cLfksSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIp3LYw53+7El5F6+P5GlSJkfpERA/8zt+4bmseFvf++rWEjlNGh768kiW0583BiIrKVqi9Jr0AD2qxSHxHH8BRM/BpRmUDXjXvJBZBUY1moWFJadENMTF8+bVDobvCBCzLNRRqi9dPJzAZLeXXwAyJq7owd/6SldbqLsONQdF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zrvx+0q/; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8fivA018674;
	Fri, 21 Feb 2025 11:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=EhxAP
	HTe66rLGXBARqiCtEmzc2aeftoE87GPqQGMK5w=; b=Zrvx+0q/8YDOz7Ktll3Xm
	qoofsSH6WuypCJ2C/eHZfAp2z2fjqZpVW5Q18liKxI2ybUM9wHKzpOTZNXoRnSmb
	hOV7I8PGCmUHV3P1hACVpkyUWzFxjFYlOuQ+kvyu39yEIJmbyEkPY0/NX3rCdItL
	XP0oc9e0ulX2ut/qvruu3nTRcUNQn017XefPDrjFd1KO88Km6C6emLAJgCx5pmv9
	VsETEYFdMalHmOFG3QurV7r2u+mSUGG04fRtfIjGy4eWe5J9tYOwduxX+0QulbTY
	f7F9xJq2514A4AVD9fU374skzyj9oi2xLflqxc+jyd5NmwPi7tqKTbN1r+jWFbYL
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00np6p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 11:58:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51LAMUEU025222;
	Fri, 21 Feb 2025 11:58:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w090fstd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 11:58:19 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51LBwE99029660;
	Fri, 21 Feb 2025 11:58:19 GMT
Received: from sishan-bugs.osdevelopmeniad.oraclevcn.com (sishan-bug36880967.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.109])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44w090fsnx-2;
	Fri, 21 Feb 2025 11:58:18 +0000
From: Sinadin Shan <sinadin.shan@oracle.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        chris.hyser@oracle.com, sshegde@linux.ibm.com,
        Sinadin Shan <sinadin.shan@oracle.com>
Subject: [PATCH v2 1/2] selftests: sched: add sched as a default selftest target
Date: Fri, 21 Feb 2025 11:57:49 +0000
Message-ID: <20250221115750.631990-2-sinadin.shan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250221115750.631990-1-sinadin.shan@oracle.com>
References: <20250221115750.631990-1-sinadin.shan@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502210088
X-Proofpoint-GUID: K7I4f80uXz8DWoCxAFh94NPoTzRIrcmF
X-Proofpoint-ORIG-GUID: K7I4f80uXz8DWoCxAFh94NPoTzRIrcmF

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


