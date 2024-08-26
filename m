Return-Path: <linux-kselftest+bounces-16327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E2695F7C4
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 19:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DAB21F2316E
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 17:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B406194C95;
	Mon, 26 Aug 2024 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kSnrARkd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEFF14AD0C;
	Mon, 26 Aug 2024 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692556; cv=fail; b=Y0UKjLyXH6lkyXo6Rc1jugpp5oBoYBNDYwx/UBBN2G92T/bqmrD8fwVj3WoHkWIWQR0mdruQVS8a7TvDPiXM/Wkq2aPgDsWLKd+xJ+KjnZvEzlM/fVnLoadimlOfnq56NsP5fN1og1slsXwdIZ330duyL3eTGN4hvq7j3O9pR8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692556; c=relaxed/simple;
	bh=tjhlqYwSwhtDOPwygyEQyVnZd3sExyphqupRZx7p/94=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KZPyxD+BACqSRsClOTL4UNeY1zlIySkYVnvaYuzxGOialKbG9Y+Ng+YlNNgEBSDjGP7y2FVZYLhVpRSk1dQDbNGGg+jre5Z6kIfnlCLCjvUwt8v29MEseT7qqJN1XNBDBn+PWM9zk5Hn1VV2EkZq19Zxu9RrvD4/MYmqjVWD54A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kSnrARkd; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMDShwmJkC2gzuSmskznRIFqGP428Efb6lKqV2doKXrbjFnLUrCgX0b58Isx5hX794FQRNYBkBUZVFHg9ciyylVz/nQ9iiR4tKBgdkM2gnkwBE7IlPOJW/u5AzcBc7X/Fv74e2AA7o0RWBctjMDCU8W4UivJk2Z6syboIjbzge2QpJQzB/5jkAu/Bqx2JLs6EX/MaNT8/qEpXsBWZr9SNYsYp50lus8Y44JAl4MhoSr3IZkG4Fslfq24Woa7kr1UB8JIML5FlecGCJ+dkgtxbP2pXjf/QD12v86QSdOeaUnGbeY1++999+RkRLT5EHZic4htr/1hv/CA1vaONRi9Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeMZpR580ZbfiPZNRvONIN63Rx5mGP9j1Bmq6Un4UHU=;
 b=kj7NkqcEwTYK/ds3hHxjQRtvuSVwlGmkfeGKKv2nFSfQ/Vegi2N+akQhNBTyGcLhQMs/gFT1xUvUE6J2qfNun0mvNwne5Aw9HmaPR4vUxGD77DBvFjmmfDsX+XUuYazkaQuCPGHXomi+DjJQpu6ULSxcohrJx+gTIt+VWYTAiuACKiPtUTusyWUxfhqHOr8TKI2DjIwf3vXa2prW2rf6reDPeAD+5uR3lvlEpngPA+tHowTzkFlKL/koZmQMhXMrMfJj5/zKP7AviLjh3tn9pfhzjBSFZsCoiHPR55aaYmRnOeDy5Gd/uQYltk9HsWSmApPBXRw8h6mhdHG9IOQkJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeMZpR580ZbfiPZNRvONIN63Rx5mGP9j1Bmq6Un4UHU=;
 b=kSnrARkdf2+y7uPYDO4CXlDUi02x4c9a5u+gb7Y51/XwoCmFgU8dYdkcZP+qGUBe8WHRo2jgKouOkfaV3FeFjNgynRkD6EjxLRUgqAdJ6ELyOAsPpxXrAT4nAMQA5YQDGARcP83qlJq0nBF0yWdUSafqasAewo5gnvUc0+SKOk3TI/gDHv3+OEshN0TO5XuD7ENBMGBEs0CpcTd3A+naey1woEEsOUs+SE9kfxLWaIL70D+xnYoCT1G7eDz58fAx919qa8Rq5X7aSUpOks97mOGCaEd98HAKNWs9RqkwQdovc6W+EpVdpl7/gO1Qp2D7nffBGJCQEutBkRzYNg/u8w==
Received: from CH2PR04CA0013.namprd04.prod.outlook.com (2603:10b6:610:52::23)
 by SJ0PR12MB8092.namprd12.prod.outlook.com (2603:10b6:a03:4ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 17:15:52 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:52:cafe::e0) by CH2PR04CA0013.outlook.office365.com
 (2603:10b6:610:52::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24 via Frontend
 Transport; Mon, 26 Aug 2024 17:15:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.2 via Frontend Transport; Mon, 26 Aug 2024 17:15:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 26 Aug
 2024 10:15:35 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 26 Aug
 2024 10:15:31 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Vladimir Oltean <vladimir.oltean@nxp.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Petr
 Machata" <petrm@nvidia.com>
Subject: [PATCH net-next] selftests: forwarding: local_termination: Down ports on cleanup
Date: Mon, 26 Aug 2024 19:15:11 +0200
Message-ID: <bf9b79f45de378f88344d44550f0a5052b386199.1724692132.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|SJ0PR12MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de09dfe-d974-416d-026f-08dcc5f2bba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TWIjXy+ypVQ7JYMP9xkVYZQy03LyIjkJT3Oq40zTF9YsE7DBhxw8329XDMQS?=
 =?us-ascii?Q?mIBYdRyb0aDPx4yW6XJFB9ZEgJteNN7B6ibuZt/++K6C3AUsvbH2PBLAglbj?=
 =?us-ascii?Q?Yg1RunVQwJM3QX/sNskVedEIDICixtBtLIRE66qLLCemvbM/e+Zd3h2kwtDD?=
 =?us-ascii?Q?ZUCcbTuSS34IXREjtXr8vNF53loH8EpZhKhBoULSfS3p0lgL+ppyMGJ6oyNF?=
 =?us-ascii?Q?tGZMkaGW/sDkviqTcpq+JovdO640ez7FJE2fnyBOd+da1RYUl8V5JOdHN7rF?=
 =?us-ascii?Q?HbHzLnzulwpTixiY6wJWYdZSRrdNmK75Xt3cdGRw78pYfU+vERrHQmWb866J?=
 =?us-ascii?Q?iQoI+xh+1ACR/OxGqX+xNGadyYapca1keVwSA8YDl9SY5iv9mNHJHVCb616U?=
 =?us-ascii?Q?2tPgBhfWhssqt958N6xc81B1+vMqbtYbEYgx3+oOUDXmjO+9CX0bVGU5UXVI?=
 =?us-ascii?Q?h8t9P/31G2hlsQ4IGndEHzPmG8wT27gC/Q+xF3FE1zfukk2hMhBipxb1BIFe?=
 =?us-ascii?Q?307cH7CRmR4kR/oHXpjdjD91YXmT1RoK8y9g83u30rVmujBIsJ+c2ZbQm74Y?=
 =?us-ascii?Q?O5AAVvJHxSGCnxY8QpLEWpAgJVJ+s4t7EN5ovj8BTuuQf0y60rQPWHZCE15X?=
 =?us-ascii?Q?9kT728J155R+W2EdLBUW5s5gYLTPkdO5wjcLRgxRRI3+pSFq/P/fUb1vqBTX?=
 =?us-ascii?Q?c5ITeJ98W6/7FCRmkx4e8H8AKTHznCMKJZblCT4xhaUOuMrzApXJBbOnYefA?=
 =?us-ascii?Q?GzCbCEWugIG5/LthbcSmQsqoNSJAmJIh+jJUmDEWuuftQKmRiVct4DidKG4v?=
 =?us-ascii?Q?O77+yIsAzydUTgGhhyyaUyK26Q3vz967jmcm7Aiuw6p5uIALUitl8BCMbWoF?=
 =?us-ascii?Q?33ruXcYQoolUBfEs9H7ldw0nu6h30aj3bqke2muyp01aUaGYqak6aHFcdqj9?=
 =?us-ascii?Q?DBg0Cie4qOcrChhlePip3P7QtXCYByUDNcoW0EhHFyixMbMUWgykoBGPkjis?=
 =?us-ascii?Q?RrcWquKWA8++5gFfJNvl7Jf9T3pqpJFE4fefXgub2gl8QYXs9pLoGPoNWZN+?=
 =?us-ascii?Q?dauW9eAuer/tm1udsBnq9c2+6k3VWPPohvL2uRwYwBiuGR/CYfDNEzwqhIWi?=
 =?us-ascii?Q?eV+jUcpFRr3hSJVNjbjdrH6dxZ1T+d53uGAJnTZpwmOwD3Wz1HyYN4tY7YUx?=
 =?us-ascii?Q?C/Vo/wcoIehm8tYp4Jawj2Pp0xGxQhEKigHB3KjPDC+AgzBNG+hWVJQiiDAt?=
 =?us-ascii?Q?0rMHURI9dXMz7fTAyoQMGx0TLeOYnP36i93Rp3tYrDxng5rDTseRiIljG4xK?=
 =?us-ascii?Q?Xo44NfBCbAp9iLnYixfwu7RVAs71eM4mEHNV2xdsCVkz1wezALWBII5ccmKm?=
 =?us-ascii?Q?F1eV/1Nx7y6f2H/dEz8oLpX18+4fTE1rsGkqwkPwZ7eRWFcTOcO6WlM4uYAf?=
 =?us-ascii?Q?o+xv7BRgz5LmIgXsx8ZfYYRbRu8rX/Kn?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 17:15:49.9116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de09dfe-d974-416d-026f-08dcc5f2bba5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8092

This test neglects to put ports down on cleanup. Fix it.

Fixes: 90b9566aa5cd ("selftests: forwarding: add a test for local_termination.sh")
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/local_termination.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/local_termination.sh b/tools/testing/selftests/net/forwarding/local_termination.sh
index c5b0cbc85b3e..9b5a63519b94 100755
--- a/tools/testing/selftests/net/forwarding/local_termination.sh
+++ b/tools/testing/selftests/net/forwarding/local_termination.sh
@@ -278,6 +278,10 @@ bridge()
 cleanup()
 {
 	pre_cleanup
+
+	ip link set $h2 down
+	ip link set $h1 down
+
 	vrf_cleanup
 }
 
-- 
2.45.0


