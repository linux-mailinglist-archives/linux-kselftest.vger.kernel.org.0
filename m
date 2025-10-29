Return-Path: <linux-kselftest+bounces-44257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10951C18F68
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 09:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863661C88215
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 08:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEC731DDBC;
	Wed, 29 Oct 2025 08:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="NYSKJO9r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26E731B82C;
	Wed, 29 Oct 2025 08:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725181; cv=fail; b=JKi5Qic7NXqIJWphrbzv2ouL73NoD9+vIg0IDiC5rTb/9qEZpLN6da++6cX4F9obDCO7zUpqqFogH6PhPErLRgX/VfeluwfE4pVxcG5BwkwHwc833Z5HrtqiiVpFXPHIw0icJyR5a37FNdevcNFl14RuQgpVkUd3iMwhdRvIYnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725181; c=relaxed/simple;
	bh=URyf41vxHRFvXQLYT6pOvecFoPkUnLMw26dmWBEXCOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hEJY5Zv8zaSu3Z+Wz34Z9xfjiOG9ksu4puO6c81bVAlBsNZHgUUx7Si9iYb4uKmOtvVcNgD2DsomWWZVVj5BYXqvMNRLsEejjqnOac2cMwQaD0p+xE3h3MMsk6lcVxX1+uG/MHwmLxt8ySRTMrazZ8gYxe3/FvqfuPLgjYRIPo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=NYSKJO9r; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p07dl/fqvlPbjk2AK6E/35EvcW1jJMQTap1vYzqsNhxhm6lBB73MNXaqa8gVHZT433nA2PUqlbFXt27XR2xahKL9znNFcR5OPljqGVJOkMZ58zf1rOt4jxZ8fjfALrCLnmq27oH0BAGReGr3xSHR2buwxaCqzbZFOEeFoaZjz+HoK5Yup28NtbYmCfe1EKzLix4ux91ePWfozLKy+anE2M7t4/h7oaJ1oc+B5jn8vtWQiXWpv+8XBnGpB3FQ4QTizqnnKFlEBjm14yacrZoxG1u0BgP+ASsiprIHZVOMoXI/inN63PvL8mwrmSJOcUJ+xzhOStHpHifgkaXhy86Bvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMXHfdRl4wARcD7p+kvUv4AXmzx5hpwOMrKl+WHgWZM=;
 b=NrcK2/4Wy7RaNVGTvMDNtvVQtyeWnJoNj6wPnAx8YRswxPLZ6Ad35PaO0KKbLQyJYGOYyfCqeaHeQdh6c1NGG4XoXdhHQgiZk5JjjNjH0Li3bmiKVGBX7UNBCDjhIFk2aXw8RJDKeYmMY5LVy+hteo85Y2r/DY7bzXcoE0OXCP05916orYee2zfQl+Mt4dQVHhzCjZrowzFt/oNCYbhnfTjbURduNeNTYiZH+5oaJMaeCmXLUscbkMbDGPhUpJOaOwmKELweI5ZPB+BEZFkct4vloszQqlVDjwDMBCH0RUeQ4X1/MhB+30CTfMgQnJU1vOMWtWyMNb+Mak/3+tv3yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMXHfdRl4wARcD7p+kvUv4AXmzx5hpwOMrKl+WHgWZM=;
 b=NYSKJO9rmPrFdjlfauzNMeT1bjkFIuzAwv9Flc6JiyUqUDcGLE5bQOLFTMgFPC0Frbxo/vxMYftp92M1UGM1zSA2dFOr+VEa/y+sfc5rPiXKL/MwiTkvG02upfXVRGHJfaYbdMC/tVwsosNj3UnMKnL8gMksguRrLCoxrrE++4reYJVnBl3pO+2LSrVsGoUzSlPl1OeXZFNLfGmcsYE7a84mTV2KsBDexjfsVeDpUuwjMa+4rdjQCIuWncfOktfOhYCHz8qTD5S+eOJQiJ8O3kmiveVoY9UuMj3UI00ZjyCmIoPM39z5WCywB5uCHzzHqxt5lSLf+DAPmUnfeA4/hw==
Received: from DU2PR04CA0270.eurprd04.prod.outlook.com (2603:10a6:10:28e::35)
 by VI1PR0701MB6815.eurprd07.prod.outlook.com (2603:10a6:800:199::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 08:06:16 +0000
Received: from DU6PEPF0000A7DE.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::2) by DU2PR04CA0270.outlook.office365.com
 (2603:10a6:10:28e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 08:06:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU6PEPF0000A7DE.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10 via
 Frontend Transport; Wed, 29 Oct 2025 08:06:15 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 4F2DC20308;
	Wed, 29 Oct 2025 10:06:14 +0200 (EET)
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
Subject: [PATCH v5 net-next 02/14] gro: flushing when CWR is set negatively affects AccECN
Date: Wed, 29 Oct 2025 09:05:56 +0100
Message-Id: <20251029080608.92428-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029080608.92428-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251029080608.92428-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DE:EE_|VI1PR0701MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: 3970f381-4fe9-47b8-1de9-08de16c208c6
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?LzlpeDhVMHhheWMxN3NKWVhoQmwzOCtkQ05yazdKV0hYSjk0MTk4L2JoT3A2?=
 =?utf-8?B?ZUR4OVNSYzg0SThrL0ovRGNVWVJkMVpDdFJZdmRkNVFjUGJIQmd1MENzQ1RQ?=
 =?utf-8?B?WFpwWDlNMStLUnJqYVlCUmlnMy9OY09UcFZySmtTYWt3YWhYSWViM0l3Y3Q4?=
 =?utf-8?B?V282T0R3SysyWll0U2ZCbEY3dytQVjJnY21jemI5WjBSd21NK3NkTXBMdHJh?=
 =?utf-8?B?V1pIUGxOaXBOcSthUWprUy95cExsNzZTc0V5ajI3aTJHTjFKRXdsdFFFZ3JO?=
 =?utf-8?B?NG9MdXdVdHFkQ0c5SjJBb3hLSERpOUxVRXFQa2NYOG0waDVNVU01UlIzNHRa?=
 =?utf-8?B?SWZvdTBNaEpoK3dBZWU3MVJqYngzd2d0L0xadEhiNkduZTByYmMzSGxrb0ZB?=
 =?utf-8?B?U1h1UzhabWpDOHFML3F5Q0s3SmpTWEIraUJlbmEyNnlidDF2WXlFVXN4dDZS?=
 =?utf-8?B?UGF5UFRXNWZrRTJJZTYzcCsySGN6Nk1DalU2OCtVZ0NFMlQ4VkJFM25qMTcz?=
 =?utf-8?B?SktJV3NWdldEWW90QnJ0MnF1VWNianhGdHdUWGJ1MHJyVzJURlR1VllRQ1Va?=
 =?utf-8?B?TVpPaFpRZVBLM3FMR05zdEdiL1lEVG53RHhEYVppM0ZtZXlGY3pDcSs3MTMv?=
 =?utf-8?B?VTN6R0ZpbW5rdmNqTjc0UjdPTzBqbmlxSzVMeGFlK1JFb1RQejZXRERtNFdR?=
 =?utf-8?B?VVVFYTloZkVkL0dyU3BWeTgzZERNUHpGczZhTUplbWNYZWdZbjc0bW5lM2xD?=
 =?utf-8?B?bklLbzk4VDFsZ2l4QTJ2aGxZYnFFYmJQdGJ0Z3JXdlVoNkZzRmM3WXRxU0Qv?=
 =?utf-8?B?Qm91RHBITlR5V1FFY2UxUTZaUDhaS0lJNWJ3NGk4YmJicEFwbzZUNjRkazZF?=
 =?utf-8?B?VW5ucHVleGlnYmk4SWN0TC93Rk4vT3JKRTJzRHJkNDliN0pqZjEzSENuaEZY?=
 =?utf-8?B?TDNqeFhGc0xxWnRhN2xwemhYRlMraVZ6WXd0N2UyZ0pDa3JTVmlVYUxMUkhR?=
 =?utf-8?B?cE1JQlh6a1hkRjZLakdKTVVsdnkxZG5tVEs4Uks3Sy9LQ09NcXZCZFIyY05N?=
 =?utf-8?B?Q0ZaSU1NbzZJSVFuc09lYk1tdWRVRDdwVXBSMzNCTlBwT21HTERQUCtIV3lF?=
 =?utf-8?B?dnhwdWl4K1ZOWGxWMmZoSmxtbUcwSThHblF2WGFPZDIvVnh1OVlUYVo4MlBw?=
 =?utf-8?B?N3ovNjFGVzZnbTJEYlNHTVRoa3pxVW1BVzIyRWZSSUdINk0rdEFtcG9aUVlM?=
 =?utf-8?B?SHU1WFZ4dDg4TVBSU3F6MFptRm1od0RMWEx5VThzNm8xSThxN28yYjJMMlJF?=
 =?utf-8?B?cG1mSlZwaHU0eVFRVFprbWl5Z1F4Z3B3N0dnQi9XeXhSYjNvTXRHR3FvOU4x?=
 =?utf-8?B?S3h2dCtCaEFiZEozQVBwNk93a2hMaThjeWFQeGs3TkNMMXVpSkg4dG9WVkhQ?=
 =?utf-8?B?UmN5VHVNMS9WNzFzMlBlZVRxa1dUME0ydDZlRmM5R01pZ2NSMEN2anhZaFZi?=
 =?utf-8?B?TkV3VmtzYk5FWUtvTU9DWXNNRmwvSmQ4clZHN1ZSVlNQZFBaR09ONFpib3dU?=
 =?utf-8?B?dkMvcFZOUVNJbDdPcmNlb2pqV3dLc1FYb2c2M3docW9RMUZyNjlFK2JxQkZk?=
 =?utf-8?B?aFZpQXV1WlVjRkNZOFh4RmlHa0QzcUxiWVh4Zzg3dDNFbUxkcldHUTVlZDdT?=
 =?utf-8?B?dTBpQzZ3QTVrZ1FJaFVBYjU2aDlSU2NydGF6c2c5cEljcXB4bUlyajM3WkhT?=
 =?utf-8?B?NHpONHpEd2o4THR2UThZbTFJbDgrcXVCTXpRb0luOGRqNklzbVhCQ2VZQzhH?=
 =?utf-8?B?eVRTcytjU2dZUXZrcHhFRXIwbnkzSXhjUWppVkRNdWhSYTRBNm5DdVZob2Q5?=
 =?utf-8?B?dmkvbWR2blYzVFRJL2twdTBWbWdaZWV1R1BybGZxaWpsMGV2TVJ6Z3liL0R5?=
 =?utf-8?B?NkdzUGNzT1RmZEl1WWhWdVJuZEFWMXk5dG9FR3NNbWJkM1VzQ2lSMXJ3ZXVD?=
 =?utf-8?B?d0JUN2xCS3FXM0xJUmdYeEFocUJ2OG5FZnJ1bWtqa2I1SkpNK3c2OHRPM2RD?=
 =?utf-8?B?eXF0dFhxUlJESFRLNFlpY2plSW45TnRaQ21wSDVwY2tLYkZCVWdwbCtLM1dP?=
 =?utf-8?Q?pKsAO4PhrimNS06PnE13mKDY+?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:06:15.9038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3970f381-4fe9-47b8-1de9-08de16c208c6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF0000A7DE.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6815

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


