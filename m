Return-Path: <linux-kselftest+bounces-37649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35138B0B1D0
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 22:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098B5560C12
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 20:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29E922CBE9;
	Sat, 19 Jul 2025 20:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="X2AiSmpO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013006.outbound.protection.outlook.com [40.107.159.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F852264D7;
	Sat, 19 Jul 2025 20:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752957725; cv=fail; b=ESmxGusL+W9Xi/LwNp4pDuQfhWb9ZJnyHqxz1FlmxPIhFSefOiY5AarHjTkhab826HxwSUu98GdyEV+/KOIb4V3QZnGcaJdJYn8awowGDblhJtP2+iNZLF7RJd1gsGdf9p+LEhvxg0y2CfKZ9ODj30Uyg0LV6T5DCvGs0fUjHHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752957725; c=relaxed/simple;
	bh=2+X08KR2uZR3lBG7SMmOlA758TA2DBF61kuZhVSOjRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kVCXeixl1RxCI7qNOaeBe7cbtt2boP2YXvsceNmxiiUhBnGBf6B8p/Hk6H5+ntj3LE61DYRWVrriKNMK9g2n6sYBmLIrP6/4aX5KTV+XEjZa/qsmdJ64a62JBEq9X6R7vhJFgx6hgUoOf8UOzK8L2W11kw5Q2mg+Kf+HRK1wUMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=X2AiSmpO; arc=fail smtp.client-ip=40.107.159.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7SestSrzzAqUtKMd/qev4mNgvgWFNA+PYzEOZ/f94ui5+23sBMmsr3uKSUS8DgvYwIL7A7qPG2TDGtjbCSKwnGgEmKM+O8k6Hx/ltidtMK8Xcp85LWukfjeUEAT2S8baT/sa+ukFd0zN+AttIKUqHsGO8EyfXv+0OYy8d39Az+QFKXvHSwzSnQxeZ7gbQEBt+7378e/TyPt4jO0BHzLrqIEzWF2e5Yb7TFibTfJJU/zUqM9oc8Wr4t66Z4KFMdyajRmpMeJwK0NyxCaWpA+FV8FRcgc24j15Q2Qlj4qUpAywwhsqdbLvLPkeSmnC8vqhzLHlY111HdgelxZC0IxjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jd+mGTCy4kr9sumObomQ5ywvPw4LhoiRcEi2WA0yrlA=;
 b=kfcTE5GQs0YMi83QQB5Ahq+JlMlvmNDzFWhfm3hGkB38UWBd/8bT8K6i3o1sq3tgxRUzFY77DgCDVmRs9TXp8S7INDeyiglK5VHUC//IXQnuQiDsj0c8fIt0U1Ytb9brE3AtVi1eLRCl/gzyHzUH5nuelSjbWVvArUjdBP4Q8D1kr6z22nY2yW0Jjzj3EIUBWiT9X2OQqtQG8Jn/JdSRyLF/W2x4IuZQoajtBe5cSMminopuQ9nF/1WB4NxLP5qJqJsqvnuAYVb0lGzkAmZZ5hbK3twEZWskLsLdSqIEWjSuJu96IO9tv/JOlbX5k+hO0OBhMZ3K1zxBElohNLvhLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd+mGTCy4kr9sumObomQ5ywvPw4LhoiRcEi2WA0yrlA=;
 b=X2AiSmpOPLvr379OTAFmYmhcW7/hsk/tVUZwH6ppO1sY2ru6tKEnhuMuZfPvwpwU9xk9zy1a2mSHq0QMtLohwhMOFjELcvturWQqfpNLsuc8r2P9MYeyRA7hTHN+I8oWCRtKLKGzjlKoOXcTvnTRt1hnHec/nxdY3QEkvl1OZKkLX++s0Nx0ANRsidC3l79mNqqC+DZFqZpF/yfEeqA/faQyxwLd89MRQ/RkJKd3us/hUcb7TAUt0sarAudQT7AqO2m+64DBlkAwtLTQqMEU8ls+WMKzgknOKezOaPHuWA57D/lcNdmGUUy+4yeCwjJ/f4KqqMe4tRIuEkeep5J9/Q==
Received: from AS4PR09CA0016.eurprd09.prod.outlook.com (2603:10a6:20b:5d4::8)
 by VI1PR07MB6479.eurprd07.prod.outlook.com (2603:10a6:800:136::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Sat, 19 Jul
 2025 20:41:59 +0000
Received: from AMS0EPF0000019E.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d4:cafe::e9) by AS4PR09CA0016.outlook.office365.com
 (2603:10a6:20b:5d4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Sat,
 19 Jul 2025 20:41:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF0000019E.mail.protection.outlook.com (10.167.16.250) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Sat, 19 Jul 2025 20:41:59 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id DA64D1C0010;
	Sat, 19 Jul 2025 23:41:57 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: alok.a.tiwari@oracle.com,
	pctammela@mojatatu.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	xandfury@gmail.com,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v25 net-next 4/6] selftests/tc-testing: Fix warning and style check on tdc.sh
Date: Sat, 19 Jul 2025 22:41:27 +0200
Message-Id: <20250719204129.15737-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250719204129.15737-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250719204129.15737-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019E:EE_|VI1PR07MB6479:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4065e1e2-6efe-43b2-6e55-08ddc704b57e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QMoUOYHGjbMEcDLqh2B8RHWeBw4aRZR+qOTyk66de/ZhPuGJvZlfWPUYJnmv?=
 =?us-ascii?Q?dNWkqTEnJ8jf7C5Fo93oV7RDrBfY/YcEVPMbg7OQLHqEwORnFPhmTAn0ftp2?=
 =?us-ascii?Q?3u4g/Zvx4ojoJNkUT3eVYKOHMLeAG8ju/03WARZ8eEbpw+ef7llSjCvGv8/X?=
 =?us-ascii?Q?ioLwWR0YL88jlLpIFo8KhY8HaJbSYNiyP5Bhe0Qzmlb4d56HHPJIaPjXMm/J?=
 =?us-ascii?Q?tjN0acJDnigPtcTehVmC+tlWPhLtrzet3fGJYOc50WBUlXCyeN+UE4ROznoI?=
 =?us-ascii?Q?Gen2BwabfI5/sde+KhPyiV8H0wpIXOfg+6T+pi0SJdjXrEe+yegC8z8GeZUA?=
 =?us-ascii?Q?eP1l9Ohs2OlIhsyHuzeqKPnZCsxZkcJO3rT3k+r0v8d8XhCaGE63J64Ai1jb?=
 =?us-ascii?Q?u1aVjOWw1pDE+IIlxbIGXlHDpAeY+vFZmaxPs5pjAB+EMDQeWOTnSsPpua1U?=
 =?us-ascii?Q?Ai4s22iaAHY+wRcSF8IA/Kwft+/Cm5TwOh0VE3Rn1TG/IIXCaLEm6VCOrdop?=
 =?us-ascii?Q?8OKFuU4pvQaHZnF8K9iPXpDEOEOnTyx7CgkjT4ysCaimbPLX5b+v5L/saj2P?=
 =?us-ascii?Q?mR15B5IZwdrB7Jc4fZxPB+bpmh8ZpbEe7QTsB1B7qN0v2tWQLtxK3OUB83lW?=
 =?us-ascii?Q?uBzTk2wX7YBGRXMsxy8Iorbv3Jbl5cewXmDUoOy2tx9o2ByVDpZjJUYMqu7j?=
 =?us-ascii?Q?+r7McXNwVUdZ5zqyrZy2OHV9QLHq0HA7deB8zCmzKuLSlwMjhZvY+DLZirIJ?=
 =?us-ascii?Q?MkiEApxwYyi4dn/1p8ECNFBWUYXKUpq9ebU0Ze0UVtDrNwExR1cwNisIu91h?=
 =?us-ascii?Q?34acwhkVv2IC1pIMKbZh/Cc5b49se3EoueujnQmtULT9/Jr9T0IQPUPlTYyY?=
 =?us-ascii?Q?126NPZhvSzWiFzSXrst2AYQLUcwzkq/oNbVIJL5o3Akw3NUb79WjcYLhf8Kl?=
 =?us-ascii?Q?TFqdEjvHbuo+iZ9GhPA8KteBGOBp2BZdLd5dB6/luWVCkACgxVsZLaPDe1AZ?=
 =?us-ascii?Q?cUEMvKUZ7jLshgl4euPBj6GdCHZHUOCFCYvi47D3D7OIPegJn9QtQbpcMEq6?=
 =?us-ascii?Q?MuKgTDsDElXqf9x6areBSd2BfYdPFfKvBChygfyfokG7IwD9A4gq/RMUVdsF?=
 =?us-ascii?Q?Z3SIbCzF6Lu2siRzbZthrqr1kapuZc5IQVLxKo0qJygQIJOn4DGJJvQR5/Zq?=
 =?us-ascii?Q?IhuwIla14ANR5WXI5b6J5SXov4ATHbKdt1KG3dKcsgBaAZxw6C1DZ96QDCdR?=
 =?us-ascii?Q?6OMyevz4NzUKSKqCTN+dD7q4SfwePHr2NnUFqSZrrhhZ75ov9tlfDtYuv42b?=
 =?us-ascii?Q?1O3aszjkSpOM0eiKdLYijaOw56JDIs3CFqAmJ1F+VMrlLDF44q/t9jSGupQO?=
 =?us-ascii?Q?S+jZR8TLNJegkHXRV1QevBsPzy4tkAzz76byYVSHcU2j4Qr89XLSoiksK5l8?=
 =?us-ascii?Q?6AxGOeHw90r1VfejOMoWFMIhfQV+T5JKhwE+xR8lEM76BRcjLwnlt8xqeSIm?=
 =?us-ascii?Q?7cRsxkvaWRg8Vjv6NSClYpX4Qa3W+csrjevbAhI0X7swpijU2k1KatewbA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 20:41:59.4798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4065e1e2-6efe-43b2-6e55-08ddc704b57e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6479

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Replace exit code check with '! cmd' and add both quote and $(...)
around 'nproc' to prevent warning and issue reported by shellcheck.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 tools/testing/selftests/tc-testing/tdc.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tdc.sh b/tools/testing/selftests/tc-testing/tdc.sh
index 589b18ed758a..7a81088802d1 100755
--- a/tools/testing/selftests/tc-testing/tdc.sh
+++ b/tools/testing/selftests/tc-testing/tdc.sh
@@ -4,8 +4,7 @@
 # If a module is required and was not compiled
 # the test that requires it will fail anyways
 try_modprobe() {
-   modprobe -q -R "$1"
-   if [ $? -ne 0 ]; then
+   if ! modprobe -q -R "$1"; then
       echo "Module $1 not found... skipping."
    else
       modprobe "$1"
@@ -67,4 +66,4 @@ try_modprobe sch_hfsc
 try_modprobe sch_hhf
 try_modprobe sch_htb
 try_modprobe sch_teql
-./tdc.py -J`nproc`
+./tdc.py -J"$(nproc)"
-- 
2.34.1


