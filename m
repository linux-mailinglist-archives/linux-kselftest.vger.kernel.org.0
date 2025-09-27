Return-Path: <linux-kselftest+bounces-42520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9084BA5AE5
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 10:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6A0189FD86
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 08:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE06E2D5C95;
	Sat, 27 Sep 2025 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="aG5hCkPZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013043.outbound.protection.outlook.com [52.101.83.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E158B29A9C8;
	Sat, 27 Sep 2025 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758962897; cv=fail; b=SdQLTcRW/nJeZQBpNB+pnF9TXSxxTLz4CZUcYs/6scf89UEG53+urFHe80KCpVYX9wGWuXClFe20SKWPstcy6AUxran5EwlAedgCpdMmtVYPcQkH+kiWaeXBYt6J8sK7WQKMMVgS1Q41lqky7aBK4LsT/2to4ZyRPUYFlxLvWYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758962897; c=relaxed/simple;
	bh=URyf41vxHRFvXQLYT6pOvecFoPkUnLMw26dmWBEXCOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/ftLTpMGlf/RQVh4EOt0UQPGpxgDoj+qO43/aNEmSB9E3Nnf3hA3H+3THeRymIlpbxqN0DtNPBikf1wLxIKZRBJ96pMnLfBRlrTM5dbnYkS2ltorKm678g+gxaLeRJn6UQFcPxKlYhrTsXfanTuHCQpj+ZntvBGByo0lJozZhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=aG5hCkPZ; arc=fail smtp.client-ip=52.101.83.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L62xh8UuFrh9l89Ifu/p1f3FEtfBf5Wu3TvNZX2Akn/RJ1VYzr0xyCDMf7xZQ/rgrBMvJmd46y82Zf5IT9so839MwSoOCAO3KG+ia4VmdifVBC59XJ27v3amHrHYqa1uSDW8dyrrv7nrJVM31aVDo65PF6QXT49znSVNlCJiNmM6SqCSXjkcqUMsTCuGuPnSzvv/hCAynm1/FDAKdl70t3w1IU+FJ5F3VYe9QhoZlNUo6HoprsARnM9eJpOuVZRG4B05IOCUf4Az8muJ21VUTcPPjYPfOZZYpYfkqr+4Qlp/Cv5BPhdCQXCuo+4AIAzgx86hSexkKQMhSVU97AhaEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMXHfdRl4wARcD7p+kvUv4AXmzx5hpwOMrKl+WHgWZM=;
 b=P6S4s0QM1qziBdxw06XquLK4JBCCyLwn6GVyCafcoDLLI6nAYp6wITSYNYjwGyxyRzOUW90W3kha/lXbwL9iOmvoVxNj0KUL6uIylqMsHCVpXnnz1y7oox3qzRz27NyQYjM8yDASxEYAS9RRJ5Jw80HjqXbYKMpYYPVErFveRNsjQ+nPJwtJMIr39G5P2aklqYvNWuwqZF9rTXLz6RitJSJEzODQZR4ttJbVd/fBZAi9r+WzR9vryykfyR4a40OkbwfFz5WMr0+F9oC5qLvCUPUBW7Hl92C8i2JiZB4jfiLz8fUbTqU8hzrfVYbCb3nTLTuaHgrrM6fig/9kcqUoTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMXHfdRl4wARcD7p+kvUv4AXmzx5hpwOMrKl+WHgWZM=;
 b=aG5hCkPZWN4B77wxjVrV7nxFpm20/DGaP78uM8DCsVDEFf1434ujhfEPypugthQrcAZFKX2EgSRfgSko+9p4OQ7hQpIGH14YP51CmkpzaiTp47G5gtJ25HokjKp0Xu8CA5zPuWTug6EWM/S2uOoeiz7ZYSoFoSr96pxGI1VQk/aBsa3laKGNQjR7Sj9S/eBrv/7RfRTeLmrt6SbXo6czkv1/hX2mpKaVjUxl1gX9EiqoPRdZVPuGvDyHs81qzOtjNfhMbGNpLet2uZ2LHEDvcJsfhDrp0vQOE4MPt3qgCB61rkAuUVZEMwHt8qvB+IlDtdPwAxj2PEpzZZ5DMKQUIg==
Received: from PA7P264CA0204.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36d::7)
 by DB8PR07MB6316.eurprd07.prod.outlook.com (2603:10a6:10:13d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Sat, 27 Sep
 2025 08:48:11 +0000
Received: from AMS0EPF000001B1.eurprd05.prod.outlook.com
 (2603:10a6:102:36d:cafe::9a) by PA7P264CA0204.outlook.office365.com
 (2603:10a6:102:36d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.15 via Frontend Transport; Sat,
 27 Sep 2025 08:48:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF000001B1.mail.protection.outlook.com (10.167.16.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9
 via Frontend Transport; Sat, 27 Sep 2025 08:48:10 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 3AA7B200B2;
	Sat, 27 Sep 2025 11:48:09 +0300 (EEST)
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
Subject: [PATCH v3 net-next 02/12] gro: flushing when CWR is set negatively affects AccECN
Date: Sat, 27 Sep 2025 10:47:53 +0200
Message-Id: <20250927084803.17784-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250927084803.17784-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250927084803.17784-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B1:EE_|DB8PR07MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 7942a45a-a431-4493-893f-08ddfda29678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGJXRmhmanR6U0pXNW9QVGw1YWJKbVJxT2VZYWNnTlB0Rkg2ZHVONFIyd0FY?=
 =?utf-8?B?aElsRy9FbnEyeWk4ZkZPbXZnKzVrZEZCQWlGdlNRbnJuMGNrMmRHbjJKdTN5?=
 =?utf-8?B?KzBQM3A1UkxDMHZvK3pWWW9CZ1o1VmFLb0FlWlc0dkIyZEIrVi9QWnZlY0lJ?=
 =?utf-8?B?bkx0YktiRy9qTUdVN1VMcEt0Y0IyOFkzTkRKSWwvTkMxVC94djBGYnJhWCtI?=
 =?utf-8?B?bWU5aGR5UEdLNEY4N1RuWlZlRWU3NVJNaFErODlqQW5WSmlZdnlDbzZjcHBs?=
 =?utf-8?B?ZHZYTjAzL3gxV0N5UFBsZ0ZoQ1M2TkpkVE11YTJhUmZDQlZQdzRLRWFYREVJ?=
 =?utf-8?B?QUJTVk02Rk1EdTN1d2lxZFRJRnRRVCs2UWhkcG1MZzdBUCsySnNlYXI1ZWpu?=
 =?utf-8?B?c2tXZ2JKYmtkckdsR2Q5Rlc0TFpxMnFRNGlrUHk4OFMvZm1TeldrTFUyN1c1?=
 =?utf-8?B?SG05a1NGZzZPMkRHbXlhNU5WSU0xV0pPajJ2RlovRzduVm1oV0NzYjgyU2tO?=
 =?utf-8?B?QjV5VFdrWkF3U1AvTWJmSEFKK0VwK3ArM3BPWjRYdWNEN3JheDAzZVdIakVU?=
 =?utf-8?B?YjZ1SzRuajF0cktpdVpzLzgzanJtZU95eGI3cFNsQTZLQWZYM2JuNTA1SDlX?=
 =?utf-8?B?cjdmTGN3dUdpdWR0aVArNWJCOU42TmRiWDhJZ0FINUN1NWVhZEZTOWo1WDZT?=
 =?utf-8?B?bEVtV1hacFB3bUJmODBuTFJqMGRhVGxvVFE0OG9vWmkxbmpTZTJTT1dsRUc2?=
 =?utf-8?B?cVJGdlBDQnJZS2tUWTF5Um41bVZhdHZlam43ayt4KzlsVjJXS1BVQWZzUG5u?=
 =?utf-8?B?UDRIelRwM2ZlVTdBK0haTzY4R2dJdlhvNjNiUGJnKzNjSHlGT0RDVXJoNEZR?=
 =?utf-8?B?U3NDSFNXWU1wL0JZZTRFSEVYZlcwaGg2UFN3RkZDMzhja3VMVDBPQmRUZ1Q2?=
 =?utf-8?B?NmM1eVMrb0lxOVJCZ29qZ09CMmZUd1lBeWppaWJUeWUwSVlyVUhzM2hWV3VK?=
 =?utf-8?B?Znk5MGZnb2ZRU2pBc0hWU2FYTllETVJPelJRWDNKYzlKSHJHZHh1YTV3OENv?=
 =?utf-8?B?eTdLSmpoaXQ5WmJZVUx4ZkxDdWpaQlNud0RlNU14N0lUb3EvUmdua2lPakdE?=
 =?utf-8?B?M295enhHcWU5NVZhekNheFBOQ1ZqbHo4QUhtTlF1My9rZjU5RWxmcDJ1c09z?=
 =?utf-8?B?RS9BS05XNFYyT0VYaE9mYnAxbjVtbUZabCtQV0g3ekdDcUNQMmhNaDZwT0JK?=
 =?utf-8?B?RjFUWDJDZ1FDbmhlMk5udHp6NDgrTUJ3aC94UHZLcXErbks0VG95S2diNkFq?=
 =?utf-8?B?TWVLTzNvcU9yek15K3VjY1J3SnpTUEszYUw4bVlJSnhoYW1FVHM0dDEvWUR3?=
 =?utf-8?B?UENyc2ZXR1hGVFVpd0pMd2Z0ZW5CUTQ5UDdxb0RkZUVrSHQrYUJmMDNvbnZh?=
 =?utf-8?B?Y1dTWVh4RU9sVjJZZzZ3RVA0U3FQalVYSW9vOTZ0UlNRcEU5OHdUdkIxYWtL?=
 =?utf-8?B?YmF2YWNjcW5kbThwNE5rdEIzOW5jSmdUMEdUc1VqUFBZZDRIc3IyTVRNNVM4?=
 =?utf-8?B?RFIxdnJRMGRIcm8xUEg3MmRSckNIZG1OMFduOVhPQmF3a2N4TkMvMkNpWXhK?=
 =?utf-8?B?bUp5OEkrRUNhSTZsN1JTcXhMNVRjN3FNTFhJeFdDckU1RUZlYUhQSWtrQmR5?=
 =?utf-8?B?VWhWZkhqQkN6V094RDYvdnYwWjJNZ0pRZGw3OWJ5cXdESlBxSjFvNlRyUmZD?=
 =?utf-8?B?dHVVdTJkMTZ2OWxOOWhpRjlOT2gzVVlpYVVLVDJ5eXJYOXhERHpKeDJLL2VP?=
 =?utf-8?B?UjNWMGk0VHVZZE1IektraXBYVTArd2Q4Snc5amRGaGZzdjR3V2I3dU9jVHFO?=
 =?utf-8?B?SUhoSUZxcUZydFdNd1VXcWVGUUVxSk1XemNkZ1RzZHUxb2FLQUkweW01ZUg0?=
 =?utf-8?B?Y3JjRm5CZWJvMmJ0Yk9xMXY2cVM0NHp3OHZEOFNkZHZkWnZoRVlnaU5tbGIy?=
 =?utf-8?B?WkFXYWZ1eXF3dE5IVFh0WVVXbW9iSmU0Mk1NUU1HdWZ4a0pwVHFYN1BoeUc4?=
 =?utf-8?B?TEhxZWx6cHFZU212NEJiaEtRcFljWGhzN2tNRm03L3c4TXlRNzE4SE80aDFV?=
 =?utf-8?Q?bADIf46iD4zlamCbUOfmP6akK?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2025 08:48:10.6786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7942a45a-a431-4493-893f-08ddfda29678
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS0EPF000001B1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6316

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


