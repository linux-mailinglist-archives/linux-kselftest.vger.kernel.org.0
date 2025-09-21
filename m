Return-Path: <linux-kselftest+bounces-42033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB0FB8E406
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 21:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117F4189ADD6
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 19:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B734229B38;
	Sun, 21 Sep 2025 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dl+B59qB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0225D20E6;
	Sun, 21 Sep 2025 19:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482488; cv=none; b=ewKPAFHF4Edh+iRHGEVKCd0p4XxzmnkdQJWcxVdj8aiAj4bieRyfBeIKAeX0vyat3ahwPXml3Npu4R+HxChBf6+Va//J/fWoS2vQcdS/ZwgEQzVikdbhfLaoBjzmdt0NvWIMgziDZ8kOfbNQ+uEBxMM5LxmWAzz8VADfguZHk8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482488; c=relaxed/simple;
	bh=Xg1jliQYEaUH53KBwKBHmy3PLJfCReIPYK/DANUWEQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bMPfrn7JhPThWeqXHCsCG3PzT5fIAaR2T1sHc8kVVB5DjiWTJoZckxye139cAJCgEjJMNkGiqmhzncZMjYyl0Aa9p8Zt3ssNmCN0Ddlgv9S6wUcTniPx44Yt+gKTZfu9JtMLV1heusFcC0uD6zA0vSS47T0Kgm/g2jFBSC+pUCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dl+B59qB; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LImK70030300;
	Sun, 21 Sep 2025 19:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=lsO1CXeJnP7kQM2ZlLIqD0xF5EaaK
	vSHlbYBicl2Sn8=; b=dl+B59qBCVohsnIcKlofiOKbgs0JrNEmhQ8F7Izk7lZk9
	GG7L6e0sPzLr8XfoWxi+EJX4M9cdQifDbD5PVZYqiGmeLcc0jZwWLwJkYM9kuP2h
	MreOolSuZRjRH2UCGE61SGuTrmfGOjIp46JV8Dsg6ftYindXEi6h1u/U31qKnNtR
	XZkPbIy7ox8WpXk/FrOKMDP8EPsBJXA8AYt9fPYubelEYxrzA2uCg05tTC82Kq6M
	tn4gbqF/Iu+uPFvX5lkQXfFq05jUJA2bV5wIjGT1wLXdRwe4cPpK027K6SmKsuVc
	QXdtY+AVhXxUmUxNwvG/6+wdjJoy1FWIYg0OAv/Kw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499jv117d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Sep 2025 19:21:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58LJ4BNh034253;
	Sun, 21 Sep 2025 19:21:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49a6nggeuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Sep 2025 19:21:15 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58LJLFWO003840;
	Sun, 21 Sep 2025 19:21:15 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49a6ngget6-1;
	Sun, 21 Sep 2025 19:21:15 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH net-next] selftests: rtnetlink: correct error message in rtnetlink.sh fou test
Date: Sun, 21 Sep 2025 12:21:08 -0700
Message-ID: <20250921192111.1567498-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_04,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509210198
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMyBTYWx0ZWRfXzBFfsEnnUL44
 dy2FG3EX6DQyM4V9ICOT0z1ZpZRDoEnlj1qMKRchdKxDXdqqGsa35xtyigKTTq8nhf9ubMD9nyV
 kBuGrpX9342LxMx1w0q/HB4gh85rzB8j98klsxIuNyqfbkihD/LBPPcs8fud3EY8ueZUBR//1v9
 +rqYYrQZ01XA3cXwulwsoyzMXbQbXlnJ3l06LZaxfbaUsCEpjb7Hx/MG3oanSglopgZrNAJsvqF
 vnzjw7oE/WHdRhqJoyri4oFb6QjAp2ASwfrPuysHm1lpWoBQUuVJqd429vHVgPg+XhxgDyf2abU
 wSktG/GlkDtjNn9IxPpCb2nRhiC+Pxqor+i4zKcrbaPEp3CXpmZ4aOGSy44SF+e8rX2EAdBcc1X
 uulYP1vFpmxfR9/cygJ1exEm7JiSIw==
X-Proofpoint-GUID: SnX9wH9PwbvDZffEaUSQfQiqG2lK4SPR
X-Authority-Analysis: v=2.4 cv=YrMPR5YX c=1 sm=1 tr=0 ts=68d0502d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=-I1CY_1zln-DOjhblCEA:9 cc=ntf
 awl=host:13614
X-Proofpoint-ORIG-GUID: SnX9wH9PwbvDZffEaUSQfQiqG2lK4SPR

The rtnetlink FOU selftest prints an incorrect string:
"FAIL: fou"s. Change it to the intended "FAIL: fou" by
removing a stray character in the end_test string of the test.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index d6c00efeb664..24bba74c77ee 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -519,7 +519,7 @@ kci_test_encap_fou()
 	run_cmd_fail ip -netns "$testns" fou del port 9999
 	run_cmd ip -netns "$testns" fou del port 7777
 	if [ $ret -ne 0 ]; then
-		end_test "FAIL: fou"s
+		end_test "FAIL: fou"
 		return 1
 	fi
 
-- 
2.50.1


