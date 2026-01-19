Return-Path: <linux-kselftest+bounces-49395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A9DD3B667
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 19:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AEFB304DE33
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 18:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C054838F92A;
	Mon, 19 Jan 2026 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="lCwLc1HT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013010.outbound.protection.outlook.com [40.107.162.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442D4325711;
	Mon, 19 Jan 2026 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849146; cv=fail; b=RsLsSXn/dBz8ZPfdc8nkfR+X8WxX8eT7CUAUCHo4WP1pwVbJyXoTQtNnqzgYEWxaRfPSGyONDdoXeGD8JcBK5dF74xPXzMnPOlq35jQFPaxC0RafQ02o7rbwLxFiQx8Buj7xXg6OxHufsaDJgeCzXPvqPVVpx/9tqCMmljGEFhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849146; c=relaxed/simple;
	bh=Q49lg1ygR5li/7gImh7zFQzfI3h2ISG+4HsdDeihcTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lKb5sksnBbpJazQ2WPjAIBmhah/S0HUx48TQE2wOKR1cy0RcQSmb7cjAz+gI8LLOcMjle1lVGYmft5TQZQn/x6ChVox3CxJIqIb6+i/7G/l0AnSAz8SAQsxJdJp3vklYZ3M6n0tla01zm1M0sTuJC3KaXlHaA+VBJzzZFQtOE/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=lCwLc1HT; arc=fail smtp.client-ip=40.107.162.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDqRdjcRYuaJ21kpY7SmQGvXPLruukILJUEXql/BxVMCQ7Ae0p0FkBPXZxuLy6N/kxt2pML6R6fyqWhVtaU8Jk4Po+0pOKFYCDg9RiEZ4CiyXsNJuogFP1j0MPtg4aSAo+8cbt/WL7jj0WKzo7Zf62efsoBhvfBlO6wPU8qZhEM05UJaFgTAbe8i4CN0fXTAwGyMOjjCkNvCgCFOZSiSINAcsrVb21o+cY6RjFlczyUVI0YcTqIPcFyf4Jfd8wkqb1GpBhonQYoUwM8Q1ueUBVAriIr/Z5NvsEkPuJb+syL+h8BYnqEFSS04AsTOaM15eYok4eDERAEdW73lK4gmyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kuB7eRxeMGDNwXVB8pJvlHLKjUPv3X1qilnfBJ6Mdw=;
 b=r8vgPRlAnoQZ6O+rRbPeVouLM22PCIUx/7DTV2e4E+cFHjDel4iWJ31iqpoE/LtNlaIO9+14BKRXWOQQuQBHxAIOgRD/VtRGeGKN/5kQXMzBL+twFxldQKDV+HBHvvJ+h3lbBA9gvo/xZ0ms5NWVwQs/GZ0e3HC0JPd2ncXqSCT59h+72h5aKuqk0qpZiiznaeUgfmNh6ZY46W6NdffskhriPNKM7zS/YVkEG6COY02NwvLVT6PzS2Usyqij5UaAjks4AML6IN56ZLXtkl98xBkDGfVW/QpkLEPtyoQGuvHtVgNxgsVx7b+LlWbmhMZYBde4I/V4w9+Ezaurma6A/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kuB7eRxeMGDNwXVB8pJvlHLKjUPv3X1qilnfBJ6Mdw=;
 b=lCwLc1HTNt80P7HD2A3vmexTXBx5gAsbjBuUO1AM7aLlcHZKBVMx7uR+GEw7adm9yt5QcOFN+S+y4TN1JrFjuuK1tTarL/CL4GoPjBXouTmPLbAXzxF2c64FMpnsiI35h7VoIo+z1Lqi4dSyqDncYjHS8ndRzhMR5Zs2FCToMZyAzsJKd+7l4UsToRMtv5KMvPbtFgWzsKydQ62cSSq8OqcsM81Fcv+DJE0i+w1OsH9g8DeeZg7rfIYK3ouxELYpP4YDyPyTdFW4ui15Docmodl+rDe3b/7zTJqTbuET0v2AhHWuez4/Fukvr1ym1Z2A3BRojVtqSw/0jztqF0qCng==
Received: from AM6P193CA0123.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:85::28)
 by GVXPR07MB9944.eurprd07.prod.outlook.com (2603:10a6:150:122::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 18:59:00 +0000
Received: from AM3PEPF0000A79A.eurprd04.prod.outlook.com
 (2603:10a6:209:85:cafe::ec) by AM6P193CA0123.outlook.office365.com
 (2603:10a6:209:85::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Mon,
 19 Jan 2026 18:59:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM3PEPF0000A79A.mail.protection.outlook.com (10.167.16.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Mon, 19 Jan 2026 18:58:59 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 1BAB1200E6;
	Mon, 19 Jan 2026 20:58:58 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
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
Subject: [PATCH v9 net-next 02/15] gro: flushing when CWR is set negatively affects AccECN
Date: Mon, 19 Jan 2026 19:58:39 +0100
Message-Id: <20260119185852.11168-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79A:EE_|GVXPR07MB9944:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6a2c89-7255-45b4-d87a-08de578cce11
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MFkxWHRHNUJSL2NVdGFnZStNSnlBc0R5NWE4N3QzakFJdnhGQ3ZYSTVBVGE1?=
 =?utf-8?B?V1luSVltUzdFKzNmbE81dFdGSE15NER5cDAyRW1XWHJZK2tiajFZdUpNcEhN?=
 =?utf-8?B?bjNGU1lWVStLTXlhaEp4ZmRBT2hGYmZraEEyYmRjSUcrM04vWERqWUJscDZn?=
 =?utf-8?B?Z3RuMEtZb3Fyd2YxMmpsWFd0c01sODRTQXd1V3pGNzZNL1lodGM3TjZGZ3p2?=
 =?utf-8?B?NjV4Mkd1V0VVVGlndU1KQUs3V3JhUDhDUkhMYWJERzFacmliSVdDNnNBeWhs?=
 =?utf-8?B?U2hIb0wyeEUwVXhMS1pFL0d2aGhlUHloZHpXR3JjaW1RNGoxR3loMWtYZjEz?=
 =?utf-8?B?MFllVFcwM2hqdDBVeVB3T2ZBdlhablZsd0FRK3BOeWxoWmRZYjd1YjhDRFda?=
 =?utf-8?B?V2x6OFlkWnNLNUdGQnhrN0M2WVFhUGIwdmEyTGFCVmQvVWVPNVpoek51OHd6?=
 =?utf-8?B?TTZtbTFUN3paRFF6WFYya3ZjeXNQN1pkSm11SzUvaGJ2TFlJQUZtNEdGTTRW?=
 =?utf-8?B?akZnTnk4ZGtaN1lZMFh3TzBQeitzNUxzaGJrZkFwLzk1UkZmVXdCaTQ2STRW?=
 =?utf-8?B?RXBtN2hDN0RLSFNVTGNaMFI0bTM2S0dFL2xjckVncmltZjJSNGdsTzBwUGRZ?=
 =?utf-8?B?Z0JhWUpneXpyYmxkcERuUzkxV0JzZEdiM2pDR1loNDZSdENEVW9IS2xHTFBj?=
 =?utf-8?B?cmNRbWZBak5xS3F3M2Q3UGVKU3Zua2luZjBQV0VpQmgzK1l4UU4xRmZZdDU1?=
 =?utf-8?B?cWJPbEhzcEFxUm9KNURxTDlRa25SNG9IU0dtOW9kb1ZyK2VvNi93YmVwNDFS?=
 =?utf-8?B?U2NZbjNjd1ArS29EaWRPQ1RZdExEY0tubHVxQXBpOWZ3cExWZXRDbXYxZk5P?=
 =?utf-8?B?VmtxVkhiSVBlZ2QzUFdiR1ljUk41WjZuanMwYUlGeEF0WVpvWkR3eW9neUpi?=
 =?utf-8?B?eWh3b2pqSnFiY2twY2tML1NXcGREYitDaWlEWEtwekJoMVhVY1lXZXM2SEd0?=
 =?utf-8?B?T3F0amJPckFTZDJtSmhPM09iV3l4dHllaTBSWDlNRmRLY3hWcXVSekZjL29x?=
 =?utf-8?B?ck5jS01aSHd3SzF3MmVwUWJaOUJiY09VdHAvU3JKNHY3ZHg5MEhYcU5kOFFq?=
 =?utf-8?B?NGY3NGt6YVRBeThoZzFTTm9PYjZBR0hEU0RKT3pURlNHdWhHdDNmaVp5djds?=
 =?utf-8?B?TnorL2VrZFUyZ0N1NklKZENuZVJBNUMybGtQZ3FNei95UTBPMVJvcUdMY0RM?=
 =?utf-8?B?d0Q1M3hOQ0tKbmg1SDFXZFZmeXh2NWI5Z2lmazJZSm1waCtQdGZ4UXFQblZw?=
 =?utf-8?B?ZDNXbk9VK0NGSUd2UFhlWVdPTFlBemZBZ1VBWktxemlCQkd3SnRVYkV1b2tV?=
 =?utf-8?B?ckxPTjdyeUlpM3Vqd2lEaXBTbkRzQlhIYkZCazhwZEIrQmx0ekJWL2doak5Y?=
 =?utf-8?B?K0dQOXJLbG1Sc0k3S1Q3UmpHb1prNndQeGtWRWFsOHlUeGYzOGJ3UmxXd3JX?=
 =?utf-8?B?eHc3T2ZBa3pETXphbTJXQ2tIYmYxYkFyL1NqTnpuSDBqZ0NNeFR0dE5IZ2pj?=
 =?utf-8?B?WmI2N1Fnb1VVN3JRcDJlS0c0TFRWTzBXcnNzZzNLbGtTcTdrclBMWVBqNGZp?=
 =?utf-8?B?dTFuSlU4NXY1cXQ5NU16ZjdaWHFNUVN5V1NWY250amQwenZNQVdSWW1QUm5D?=
 =?utf-8?B?Z0ZkUXR0SEdiOUM4VDBOSDVkTnZRS1ZYTkcwQlVwUnRndTQyRjdaV3VqajBE?=
 =?utf-8?B?Y0tKYkg0Ry9LdnRURFp5M3MreW9PUWJRbUtteHUxL1RVYk96WThxc05QQWpH?=
 =?utf-8?B?a0dhbEJTUjRyV3g0bzVXbXJYOFlQZEVPRm5aMEY3dEdocnN1N2h4Qlh5bVQr?=
 =?utf-8?B?NkNiOE1BcWpwQldHUWFHK2RvU1pYb3p1d3psTlZYWEY0MCtNNEgzcHowTjB1?=
 =?utf-8?B?aFhjcHNJRkl4VjlEM1d0QWJRRTVlS0FqcE1IWkxqMEp2RlFlRno5NFBGL0Fv?=
 =?utf-8?B?bkx0L2pnb3RDRzUyeURXV1NqODNhNFZ6RUlHUlk4OTk2L3h0QjNhZ2JYUUR1?=
 =?utf-8?B?WkxFdmlEMUxCeVpHQ2ExZ0t0UDFkcDMvcHZCMnI0ZlNJamttcDhYVjNuRytt?=
 =?utf-8?B?eFNMMkxYaXZlYkV3WmhpL2tRMHlCakU4bFNYSzliNTZRUElrMzBHdkE2Ykgy?=
 =?utf-8?B?cUlOVkJNTHF4L2p1TThVaHEwZE1WUFo4eVo1UDFtNU5ld0UvNnV3S1d4NE9a?=
 =?utf-8?Q?WpWZeOyEcx/fHzhqbVYja+RRHrT+j7lnj0KTDwojSk=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:58:59.6740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6a2c89-7255-45b4-d87a-08de578cce11
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9944

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
index fdda18b1abda..9bd710c7bc95 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -303,8 +303,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
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


