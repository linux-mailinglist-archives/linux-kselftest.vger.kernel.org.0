Return-Path: <linux-kselftest+bounces-37124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FA6B01F2E
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 16:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CBDF3BB91F
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 14:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C152D29B1;
	Fri, 11 Jul 2025 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="oZQvTLTc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011019.outbound.protection.outlook.com [40.107.130.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0708A1624C5;
	Fri, 11 Jul 2025 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244346; cv=fail; b=pH6UoIfpSpc0p2BouU695hvNwuxqDtVoNEwkt2jZ+U2+i3thUhdKdy3uF6bmltbHuo7anc99xToqjVecs+QQfxvZ8WgUbkEilS8QYhYyNJPomo2NQBaV4uXp0cxRMopO+D6bm15AGEbY044kp1LfR2NNHyGIW2/F2rBti+d3ii4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244346; c=relaxed/simple;
	bh=2+X08KR2uZR3lBG7SMmOlA758TA2DBF61kuZhVSOjRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iq8FnIbVsJ6S+m3AL9E56oO0glLqN+LPwk/W9lJeDHmqgHtxdJN6H5mYiaSahUl32Gmtl8HNkXnj5c8z7Hg2bpdOQglO5TIhX9F1pRJ8YhwXzX3bFTWaeR4aRkGhTctuA/xFDZc/4/dEef2tc56tv38jdyybGi5t1rLMBiOfDBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=oZQvTLTc; arc=fail smtp.client-ip=40.107.130.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfB18qM4lXGj9JRAMPp0nCh0fWMe9J91lCi0DstGxzRMJ+IVOsbn+5K+++M7Pq24iOXhNOKjmI6GY9flKNcW3lIDYkaprvKWKRp1630tSKdL+4DRaeolSXk2U9x61QZtNN328zI7NI+VacYP5NrrWAUihGPfgtOyv2fjJf9qjIaaKVwlF6vppYzsZiluw45KXTRcHrtKyjkUs9UnkAUKMr7Y2dyxgfNR/awaJBL/MvxraoPaZ1oY0uR3sNripZl7/hUBlhx9S/HL2IxSIeWHavBFAhtnVb6mX25BgpJ/6WA+js2rUPw49XWC2POpI9OaOa8dIUpV+bpiCL4Sb1RfnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jd+mGTCy4kr9sumObomQ5ywvPw4LhoiRcEi2WA0yrlA=;
 b=BtCnyT66DqPiAZDZL5ZwsK3w/s8lGafiMlvY7G84JRq8dAZ2tnanm1BuwoekmsJV79ayzlLi3OUNQQcnvhGYE+fhFta6S75cK/9YCqaEqWJShEbfWpW51jf+EjzOVc/oTOdsZyM2tVZXrs8PWxlGMUjV7OjU24TBhxpKTsnmw+0JZIT3c0swFRYDrtu3zOnPT7155bZRKu9Mvq3gCICVBdldVCEH3w5bQj2SiEtQpkuqF5LYoRLMzDtEYoj+/uuUhXjKIUe/SpVUtk0yQUKslaLyh9VR8mMpl5khWg4j4Ij3fmTcwdnV9ya9c7LNTVNFUtcwI/l5PIxAnCitOxP6Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd+mGTCy4kr9sumObomQ5ywvPw4LhoiRcEi2WA0yrlA=;
 b=oZQvTLTcmkKBPvXfFP9/3vy1MkQH6iqJ0uqJuXuOaiFgI8ECOR12UsftUJKrpQLH9jsdV6YMwkJwfyNQChQlCQHlJtLhiZxnfhMCQphnNuleHu61zFIX4UCJzQlGHnjmmUHWEuHTnQmwq3yXV8cohbyXrbsrI8zn2k2NVj1XlTl5lt3FwnTs0HdUGfQwKQVxBjKKz5LmV/LlM5fHd7Nugr/zlw6m/emb8h4cs17vmmYAQgcxynpNW8qFY6YzcZWFKhhpjn/BLxadv3yWuIIh0Zl+/I2DYRukUZhsJNwXuQlVapYQo/a46q0nYhY3+W03e5ckkIHRBR2/o40xbWucuw==
Received: from AS4P189CA0016.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5db::8)
 by VI1PR07MB6317.eurprd07.prod.outlook.com (2603:10a6:800:13f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 14:32:22 +0000
Received: from AM3PEPF00009B9B.eurprd04.prod.outlook.com
 (2603:10a6:20b:5db:cafe::f1) by AS4P189CA0016.outlook.office365.com
 (2603:10a6:20b:5db::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.26 via Frontend Transport; Fri,
 11 Jul 2025 14:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM3PEPF00009B9B.mail.protection.outlook.com (10.167.16.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Fri, 11 Jul 2025 14:32:21 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 229A368002E;
	Fri, 11 Jul 2025 17:32:20 +0300 (EEST)
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
Subject: [PATCH v22 net-next 4/6] selftests/tc-testing: Fix warning and style check on tdc.sh
Date: Fri, 11 Jul 2025 16:32:06 +0200
Message-Id: <20250711143208.66722-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711143208.66722-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250711143208.66722-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9B:EE_|VI1PR07MB6317:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 642f583b-8b4c-4492-e3bc-08ddc087bf2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mTQyVRIbAgyDrYPJ6vecNgmRnBagizK8Ve2lcTx+74vjT+qRbaI1Ky/1b5kt?=
 =?us-ascii?Q?L3C0ql1Zmhhb8IgW1pQDER76fIs1XW1qvHeNwJLeZ+2rQbo+tj0mVzJ6YYox?=
 =?us-ascii?Q?l4hHxsYYr5hNmUgiEnCFXglleO8PGmwGbpEPTQy/VTmaD8p77YRnscRBCxY6?=
 =?us-ascii?Q?i8tO63Jv1EwFKDd3LS7gqe0uLoupWJcNiriflsnkEk6V9gWcU877lWWUZq7k?=
 =?us-ascii?Q?4dzpccsjN+JOnIiSKlfNVSMZBYfSwX6ea7CI03cHSLqVZgiE5kMQhOauUg8T?=
 =?us-ascii?Q?XEZkFtVbfC71FnptyLr58PGN5ARUahGtcOoMDCxelpyZG1s5q7OIzc4I4k8R?=
 =?us-ascii?Q?D5mgdH8l0cX6kGNp8nqQkWt9oXgh/e4MCF0TAtjOm15AQNuzE5TGKem7Ht3q?=
 =?us-ascii?Q?4rxv7TVMLdMBLVHmp3BmI70lRqHi+FI9tandBQRofOK+k5jlKw93gxPtIctZ?=
 =?us-ascii?Q?dSz2TePbouAc2lNGkYQXRXbP5SKVPPxpYjB93Lmte1l8HndDXkjtU4zTAXjD?=
 =?us-ascii?Q?zC9EccXkXfQMejuG1fuDgXOfl0pJSrLXrYjhXijtIeWFAiwxxkw7uVfAbOoA?=
 =?us-ascii?Q?jPXeYsu63VM8tkIwMNUEN8OgqNnYhjop9WNkr28CEXXcJpZeEhgA9wmxol2M?=
 =?us-ascii?Q?LwmB+POimYckRVKLqIsT7RcLL6lesW/Mb6Vh2OfVlTIl8lmk9jKTJIj8iqHK?=
 =?us-ascii?Q?V+c54n+xp3YhtQ5N27FCeRBB9fq2QNRQWZRUwvtx4sMzh5d+D+4JvBTVF+HN?=
 =?us-ascii?Q?34mBcoSwWADo36WVPeuRvJEKMOmaUzDJU1cmwUdVHTDanoZzzURVlGIGtnJO?=
 =?us-ascii?Q?WwsS3/HvCuEYR2Oe9mIREBj1DHRjlW1lcgmhxdvQg9Okj0akN1A+YifuP0Uh?=
 =?us-ascii?Q?12wqiuuyCBX418BI02wHMq1OKPLPQTHpZIcCqhleFX9XAOWstiU85od2+ssC?=
 =?us-ascii?Q?8zrHF6Asm6cE2ZN5zv7tRAIA6vyjSr7Ccwi30jE4COPGku4wfA7AUWRa6DpU?=
 =?us-ascii?Q?joasVOogcwGSA3twB+efhdWAbV95eV/bO3uFCE/88mVlcYnwngn4tSg2r3l2?=
 =?us-ascii?Q?WSQxgZ1p4hE36a/LhKWnUZQJRMQ9MIBo58NXAlcTqH7eypgcb658YF/KF55J?=
 =?us-ascii?Q?pDQyCWaq/KLi4D5EkayP9HGSSSDVp+Pv3KHqjCjkNRsTgy9ICxMtdFwZv6W4?=
 =?us-ascii?Q?3nNL5M/hcpmE9fCo15nNkqaOlIBdqkuwxDNjEAWZGdOAD2LHnYIrsih46GQc?=
 =?us-ascii?Q?ZRWTdFk1q1NB4Ptt01g9bJE82XCNIh6up1henSWCOHaNokKJAVjZGW4w8wKk?=
 =?us-ascii?Q?UAC2kf80sUfh3ngjeUOb7jj0h/oSDSYhOmfDwhBSIC5NymATsScQLfnWBW7m?=
 =?us-ascii?Q?FdCe1IH0XqHrVUpUfjbPO6Y+trXXz99Hct7tFV0q9UCw9LzsjfqUj6TbUFLy?=
 =?us-ascii?Q?hLvbUll4XX6pNbwvlBaBpcAMG6rvgRq/WUusPTXXGCZkUkR3IBGKqwR2FviR?=
 =?us-ascii?Q?JbV9tJazoa4F2Dbw5Eloj8/IK29bYEUOGwSI9/my00/G4c4dLiOz+9PCew?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 14:32:21.6686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 642f583b-8b4c-4492-e3bc-08ddc087bf2e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6317

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


