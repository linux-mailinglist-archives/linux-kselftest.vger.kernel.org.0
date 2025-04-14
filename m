Return-Path: <linux-kselftest+bounces-30736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D5BA889C0
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 19:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42C77177F89
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 17:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2B8289372;
	Mon, 14 Apr 2025 17:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P1F05MRP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BFE2820BB;
	Mon, 14 Apr 2025 17:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744651574; cv=none; b=BE4cx5RTxa+lnF19yI5pvd3m1KEJHmBPEpxHS8SAH0spulwz2N4SMHvAny0JW+a5/19ee9Icn+Kd/9siJD1Qm2+DLA/k8Se3iftG9L2lNUDxiq5jyBqAAFzqS/d5X/Jxh3khfckJUnsOzx5cN4Z7IwtVV564Lvwi85F69sKBtyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744651574; c=relaxed/simple;
	bh=EeSg4KvHSg04gIwZQxiiFVckNJ2FMhnd9YsJP1J1wGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=acI4tVbYxQpdK5Ag4NTH69A1NfRHqN3FgI1ALyUaqzxErKKtmOW4G4/SjEe9F6z5ZM5rRAltlHLh96lzgnezwSFpROpkIxv8l2BmWbAdX3M1t1MHd91wnNfQWkYjGzOUeHPlVGwF3r8jzuCWIxPQg1pKpcAl1szWQXJVfRkJA3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P1F05MRP; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EH1TSA017287;
	Mon, 14 Apr 2025 17:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=9P/Dl1uLZQ/53PEsJCdRHUqG3DbG9
	iLKwAZXI0m98Ao=; b=P1F05MRPYdCbfV8BG4uHcOkWnWmJ6iU9RWxMER/psG9bU
	xAwYTHZL4UTjBpbi0Nx/JhsjtF6tXptNHPcQgkAPmLYQvz/tA/7VbqS+/w2rckAz
	+2KCL3fN/p/jssJ/JWr30Lx00VP1pKd80PlEuihhgsXIVv+CBu7W6hNn3IuvZgoS
	uHGyIrO+N0ziIByVUl5OvMOMiZA+xFlEGzbTLyAVjlpSnitMtGv8YnowU4a9zmH+
	s65f1khYumQHIeBKt8+FAVKr0clwPz+JSMprv2IiOykzbUL45K5HfEntAZwO8xsM
	V5vXdxBEzADwabhzXuS6Kn1E37FUgMkoQ2WJwTgAw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4615yag3j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 17:25:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53EFiGio008550;
	Mon, 14 Apr 2025 17:25:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460d2ntu62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 17:25:53 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53EHPqDa037123;
	Mon, 14 Apr 2025 17:25:52 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 460d2ntu5b-1;
	Mon, 14 Apr 2025 17:25:52 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        darren.kenny@oracle.com
Subject: [PATCH] selftests: rtnetlink: Fix bridge_parent_id failure on interface state
Date: Mon, 14 Apr 2025 10:25:33 -0700
Message-ID: <20250414172549.1691612-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504140126
X-Proofpoint-GUID: ns47UC514_Tfm-EFL6GI0fu1QXP0icEP
X-Proofpoint-ORIG-GUID: ns47UC514_Tfm-EFL6GI0fu1QXP0icEP

The selftest "kci_test_bridge_parent_id" fails with the error:
"Device can not be enslaved while up" when trying to attach interfaces
(`eni10np1`, `eni20np1`) to a bonding device (`test-bond0`) while the
interfaces are in the UP state.

Failure log:
COMMAND: ip link set dev eni10np1 master test-bond0
    Error: Device can not be enslaved while up.
COMMAND: ip link set dev eni20np1 master test-bond0
    Error: Device can not be enslaved while up.
FAIL: bridge_parent_id

This behavior aligns with bonding driver requirements, where a slave
interface must be in the DOWN state before being enslaved. This was
reinforced in upstream commit: 'ec4ffd100ffb ("Revert 'net: rtnetlink:
Enslave device before bringing it up'")'.

This patch updates the test to bring interfaces down explicitly before
adding them to the bonding device:

  ip link set dev <iface> master <bond> down

After applying this fix, the test passes successfully:

Success log:
COMMAND: ip link set dev eni10np1 master test-bond0 down
COMMAND: ip link set dev eni20np1 master test-bond0 down
PASS: bridge_parent_id

Fixes: 9c2a19f71515 ("kselftest: rtnetlink.sh: add verbose flag")
Note: This commit introduced 'run_cmd', which exposed this failure
in the bridge_parent_id test output.
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 2e8243a65b50..ddae704c8faa 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -1103,8 +1103,8 @@ kci_test_bridge_parent_id()
 	dev10=`ls ${sysfsnet}10/net/`
 	dev20=`ls ${sysfsnet}20/net/`
 	run_cmd ip link add name test-bond0 type bond mode 802.3ad
-	run_cmd ip link set dev $dev10 master test-bond0
-	run_cmd ip link set dev $dev20 master test-bond0
+	run_cmd ip link set dev $dev10 master test-bond0 down
+	run_cmd ip link set dev $dev20 master test-bond0 down
 	run_cmd ip link add name test-br0 type bridge
 	run_cmd ip link set dev test-bond0 master test-br0
 
-- 
2.47.1


