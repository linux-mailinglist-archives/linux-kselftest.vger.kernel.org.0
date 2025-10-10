Return-Path: <linux-kselftest+bounces-42950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F743BCD184
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 15:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7576401E1C
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 13:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088282F39B3;
	Fri, 10 Oct 2025 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Ko8K8OIe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011023.outbound.protection.outlook.com [40.107.130.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC592F3605;
	Fri, 10 Oct 2025 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102260; cv=fail; b=gEvLRpB4QltHBLRE3BQ1RnQBsfbc2ZWNDghD85WrNKLgI20bJLYy217v7/RqHyDjgMtKfbTDjPjAKiSt89GqmbnPiOWbIDp3gtY68RvmOfSBbvabNHRJRmzD2KPyPfVAILhb5NiuZwzgkDWmqzfmqv5cZvebGBdSxLLnFcVC/cE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102260; c=relaxed/simple;
	bh=URyf41vxHRFvXQLYT6pOvecFoPkUnLMw26dmWBEXCOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2q51KByCqib0sC0LsKBpZmhrJcfx5N9Flz2FiUxdisEAs83N4zAc83T5LR6fDvG4ftA3jXjNLszZjFgwF61LgBqWvX1Degq1ZuuOUYFTIRIJ/Q1awakczvpioY9OayuIXdKjPN8ug/BNfiKdn/9/sherq5LyvRioSF8nw9xmqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Ko8K8OIe; arc=fail smtp.client-ip=40.107.130.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mk/HJEjCQcw9lsrj0V5gg2zyPaPi4o3uxfNzjXnbbtUcBekL72unciDLaC+4lnKhk3xruVHIog6/LuszKuyUICtryGHr+oWMmdgsytLF/OILXClXh2dfggmpOvJ17Hy5QjLn2l715YEu1SFv3P6rsE5TTAZbtLblpy8sgaUoRYIUxGgeMJEAlaIk9Vl5ar9F6hXOYmkVXfxDqXHDp+cQrQIA2wq/N9R7IsE63jLBpEHEyKj6zPjBfk49aIIAbEpsdyjJDHoA2mELrdt+GF/45P52FSIoeOHZ5hJ5XECZVlBpp6HtZd0ij6J1+j/WWTcqeoyUNk117SIsyxJGDFJaHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMXHfdRl4wARcD7p+kvUv4AXmzx5hpwOMrKl+WHgWZM=;
 b=iGrlmnruIco4mKM8oC/slvoyBaMwNuDA3UVSjNDhYmVXRcZtgV0tqe62mVmGLLJE96m8PDjHGmdXX1vUrHMkfhqfitvMVyGyfB4mj898t8cArhq7Qq5tsrSNTt2DshCp0Y9AAQJDAuie9Zp860p+/xgk3Uyu9TZ8eJF/tRBNjJgyas6SC/s9r6b+S12DetFFoqwZsx95QtBxTGrGG2VTEyLoGjNVkC/GJlJYOtECZKmh3O6p+/NN/Azj80ULnclPrJa4WJ5T/n5UoV8Z2JXIaPFe6hTe+oX2gGWZVs1PIe2hPRlFi6WH0PLbe+5TO5pk+13xLjGQ/DY0ZxhTfxN+MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMXHfdRl4wARcD7p+kvUv4AXmzx5hpwOMrKl+WHgWZM=;
 b=Ko8K8OIel8eHtSXiITW4eynAYgEY+6JNo9tV5Ei+lwcLnwZsOje6xJkLh4bVALlz7R75b9kzTOvCjOnSJzpPxbTAzBbqYPjFZ+D+x3+V3U03QtFtnoqf1t5RWjU3gdLBe1L48NP0bMK9pJgwicr7Rgk4slz1lC5ICqk2uIDPWw9DPfSN/X5qG01NS3Tl2e3nUlaGo3fd9bPYezyaDebqfJ+VG//ab/aKobX5IQq/qSsa4l24HXQuy8wHYOeJRtbsMkCJngxtTMOlBclQPJvSrJ3qSuvQh5dVZTl/SB7/TKBjdP1NagkuFr2AvVBRk1WQ3G5JWZ7xqPKxA4L7slNu4Q==
Received: from DBBPR09CA0045.eurprd09.prod.outlook.com (2603:10a6:10:d4::33)
 by VI2PR07MB10935.eurprd07.prod.outlook.com (2603:10a6:800:297::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Fri, 10 Oct
 2025 13:17:35 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:d4:cafe::fc) by DBBPR09CA0045.outlook.office365.com
 (2603:10a6:10:d4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 13:17:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9
 via Frontend Transport; Fri, 10 Oct 2025 13:17:35 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 695641C0050;
	Fri, 10 Oct 2025 16:17:33 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@amazon.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
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
Subject: [PATCH v4 net-next 02/13] gro: flushing when CWR is set negatively affects AccECN
Date: Fri, 10 Oct 2025 15:17:16 +0200
Message-Id: <20251010131727.55196-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0E:EE_|VI2PR07MB10935:EE_
X-MS-Office365-Filtering-Correlation-Id: 131a30db-c26a-4954-7146-08de07ff6091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2NZSEljSjh0TE9VeE9vT0lNenMwVDFWa28xUGMxNVJHNXVLMlNEaXZSOC9m?=
 =?utf-8?B?YTMvU3VMalNaTTcxaUZrWHBHeC9uYVFhTGJvNGg0RWZqYU1Tb1FnYXRUNjUy?=
 =?utf-8?B?UGkrUmI1T29HYmFVL1VoOXVXSGQxWXBRR1BCNWh6WDFKMDRQNDJJUDRrNFdS?=
 =?utf-8?B?Y09telFEQklocG9RbnhTaWI2YWxua2JJL0FzTlM3SU9XMzJPRktLUXNZa1lF?=
 =?utf-8?B?a0J2OUtiUi9FY1VzWi9WT20xdGp1b2xNTjkzY1psL3N0dndlSE00cTdXaHll?=
 =?utf-8?B?RWV1ekpndEExUGpxajNiRkxuNHRadDNmMkI2SlhDbjhwTVR6cnAzb2JmQTVQ?=
 =?utf-8?B?RkZ1QlY3N3lsZWMrVkFFNXZxOFRQaWtRenpiQ1dYUk84WHZET3VDVy9PdnB4?=
 =?utf-8?B?M0lzWHUyMWdoc1l0UnU0anFOVHVoMFBLS0QzbFBFNzZMRUh0VXlGOG1ZMXVK?=
 =?utf-8?B?VFpTRVVJTnNxMy90VHV5YldNdkFucHZJVUsxRjljTFVOMitTYkYybzRsM3Rq?=
 =?utf-8?B?RUFNSjlYNGR4Y0xDbmtUMG15N1grN1lzSEp2Y1BRbDRuZ3NZbDB1ZzNiMkx5?=
 =?utf-8?B?NkxPZkZEWTFPNjYzTTV5NGVWQktXamxobHFqWEVPZ3F5RE9XbWQ0U3FGaGVO?=
 =?utf-8?B?Qjd3SXZUUEJDd052UnRzQmVRNmp3TUxldmNwRzU1ODhJR29WYTRncGtKU241?=
 =?utf-8?B?Uit6cERweU9rM3lFbnhuc3ZtaWNEc1BEQnNPNDBmejlrbWpSR3pvMmExTjYr?=
 =?utf-8?B?bFAreWEwYjhxS3ZXNU9NV3NIZEV1dTA2L09tNGNySWdjamJpdjRmWFdwV3dM?=
 =?utf-8?B?MFZZeWQrQUs2bjN5em9UMlpqeTloUVQ2c3lHOTN0ZXVBY3pWL1A5V2M5SFZs?=
 =?utf-8?B?SE1hTW9wOWx0SEtrRWMxMGZhV1A5Z292dUx0Vmx2SEZaUHNDQklKVlo0eGI3?=
 =?utf-8?B?aEV4eVNVOVZrNWJFZWE0c01jTXhUMExpNUFPemxsK2trbU1UTktzV25Gem9h?=
 =?utf-8?B?cjRUZXJrOUkxMFRraU85bjVMVEgrRUdUYnRKWW85cjk2aEc5MWZDaGFDSkJF?=
 =?utf-8?B?eTU2SkQwRVZnK3RTR3pBTnRzZnJyTTBjMWFMWmJEUkFDN2h3eWozVmlXY3Mv?=
 =?utf-8?B?ZTdDbTZWUDRybjVRTGpyTFNncEppT2hGcVJSVEF1bmR2bXZvSWtGbDJMWU8y?=
 =?utf-8?B?QVVselZOTXp5WS9nUUVWbWJ1bmJTUlRVbmtOaTQrNDIwSGFod2FLdjJsRWhS?=
 =?utf-8?B?N0pUbnIvdkVmZVkwbjl2QVdLUXZPZ0lkVU56MU4ycXRrZmtJMjVCbEFCeTlD?=
 =?utf-8?B?UzUrZHpaRXlsbkduRmloYUN4ZzZnbGMyMm5qMUpBdDFDQ2xNNldZU09hWnVa?=
 =?utf-8?B?Wlg0VVRENzRCWi9zTTF1NVhhQXdxSzRuYW0zbVAwRGY2NVpkenpCeVJWS29M?=
 =?utf-8?B?Y2hWditsV0ZxcVNFSVg1elFTdXNFcE4zZWtQN2x2UEJ1L2RvZDhpSjBuWHMw?=
 =?utf-8?B?ZXdjYnJPYWRoREEyWHAyT1VvbkwrWXEybUUzYzg4ZW5ObTkyWFFETXVzblcy?=
 =?utf-8?B?V0dOUzFmZ21IaUpvWVF4MEtkc1J1aDRRd0E4bHNNcGM1ZWRjbTFaT1oyTTJI?=
 =?utf-8?B?ZGdvcm1FbEczWFNKS0ZPSlhOUXpQd2ZnbjIyZUlZTWdoZUhHdDl1OVB1WllX?=
 =?utf-8?B?cXh6b1J5TU5pRkUwR2xwUGM5NnM2VlFackU2MC9qL3VUZ2pyVm4yNnlNSmNo?=
 =?utf-8?B?R2h1MU9Rb0RQRVQyMkFGaG5CZUJDSVpJSVhubWdOc2h5UFpxb3Voc1ZvWTdS?=
 =?utf-8?B?Vm8yY0lPT3JVTm9JM0h1c1hndTFHdTZMZXlWbTNpQTNXSUJJdWNmajNEeXB5?=
 =?utf-8?B?TzExTHFkS215U0dBa0ROeGVQd0Z0UmV0WTJxWFUweDRYd1JlU2NLbmlVdXlT?=
 =?utf-8?B?K0ljTHpWak01SFdCekZpekRmamhWWWE2UVl3Y2tFN01ORlFUZTFrK1ZsTmI1?=
 =?utf-8?B?cm1ETEFTOFlVNFc0Q09CZng2RUZBaVZRWUU0eGsxUDF0SWk0VHNMMDY4eUJY?=
 =?utf-8?B?TDVham94QmtxWWQ4R0NpS0pJanBiNEhteVV0MlE5bHRkWGRVdmliL3Myamhh?=
 =?utf-8?Q?zkl+dakzyqx2VKIORszkz9aRU?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 13:17:35.0592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 131a30db-c26a-4954-7146-08de07ff6091
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR07MB10935

From: Ilpo Järvinen <ij@kernel.org>

As AccECN may keep CWR bit asserted due to different
interpretation of the bit, flushing with GRO because of
CWR may effectively disable GRO until AccECN counter
field changes such that CWR-bit becomes 0.

There is no harm done from not immediately forwarding the
CWR'ed segment with RFC3168 ECN.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_offload.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 2cb93da93abc..fcbf4148919c 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -330,8 +330,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 		goto out_check_final;
 
 	th2 = tcp_hdr(p);
-	flush = (__force int)(flags & TCP_FLAG_CWR);
-	flush |= (__force int)((flags ^ tcp_flag_word(th2)) &
+	flush = (__force int)((flags ^ tcp_flag_word(th2)) &
 		  ~(TCP_FLAG_FIN | TCP_FLAG_PSH));
 	flush |= (__force int)(th->ack_seq ^ th2->ack_seq);
 	for (i = sizeof(*th); i < thlen; i += 4)
-- 
2.34.1


