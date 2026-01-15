Return-Path: <linux-kselftest+bounces-49017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9813D2485E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 13:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 914FA3115345
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 12:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57935395DBD;
	Thu, 15 Jan 2026 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="btDM+Ef9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012066.outbound.protection.outlook.com [52.101.66.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088BE396B8B;
	Thu, 15 Jan 2026 12:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480152; cv=fail; b=h2y99dIdE//3Qk8jp0qHBlMXu6OCcJ8XreRdMRUJvnwJVTVNeo4ugavO/UPR6qT7ahCkvNhRdGiWIKI1pDICyfOq2tfIxlYkuZyUi5X0Aik6fkbMGq3f9Z4tgxBaPk+jsNXi7FA08S1Oe2uehhf/yGg1LOjLrHKsQ9S1q3ZWeoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480152; c=relaxed/simple;
	bh=sfaivtWgi8JvvhfVjCCFe/2X2sqfNciS3sai2mg6OS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MreX8GNpj5FKoq9/c2AWeaUOl9UYr0DlDu+AV9UiA4Rl+QtROZqv6urFlIMmWZ9dxVjiQGfKhdNdj032/FmWOWjg1x23aVivn+5iYuNZm/Vo/TUDAxH4/diWzGSYKD6NM6R4iFppMoZn9NTPZoiYjk3pcDPwZERpyVLsyhAG3Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=btDM+Ef9; arc=fail smtp.client-ip=52.101.66.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovDzvL4ijBY17cMeVeBQpi04T7Q0FuJPUqaLd5F3Nl4exphU2Bc3gMjKTc/cwUPWy40QHQHvZ4hppvY8iE5NsXVsbBK7M8PosNy0nrOSNxkteuO3s5beQg4wHQ9TKpEqXTMW9QosnVyGLTMOC3veZ89ehWo7K7PgHVIyDZ2iRj/bJggcDeNE0Cr6NtWGge3VQTxaRxKJlfT88ImA7tiVueG9pBpIu7swYSZ5keAvJGx3VVXm/Ywc7ikZRvoXW4NdrbucNMzDW+7t3g/i2bU0TUBZBBFv5Q4osBzXZZRUwr4bZKQAb86ZEcq9Wx0WE89Ix0vMmmt9GjwNzepNelH7Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0Vkd6ZAGJZiROzsViYZ3djaHdNTx7wxwvFgDOJe5+0=;
 b=tZIzNIp7U1m5BF2tOl6hnILaRKW5314/ZQbdBAPFXsXzsmBeMqYxz5WV75HzgcD7uEQ0nGfDLWs5PNF5WHyL/KoEazYcygPFWPx1+o7RS0XamKw50fCjA8OxNS6Q8jZuycr7ST175MOOQ9hFc4MXuRM9O+6Jnwlsmi58qrMtLkyJIYhsZMiaApHBD3UUTdr/icvLFfJHGZGJaHtGI53wYUfUHg6tbkbnMldD3+mg0H9xXbjj26uapd4mP1VphOUbi19avvFuDgR7cvx9H4d8wc2U4xdoXdI/dNfIJaZbw6qJ45VYvqFyBdlbAaxa4BMsddK0jjiC0R7EJPquO60oAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0Vkd6ZAGJZiROzsViYZ3djaHdNTx7wxwvFgDOJe5+0=;
 b=btDM+Ef9mdYnNnVxAj8MTwXVELnEj9XoGr3b/F/cZKL6mnXGaulTQR8R5n3x3FdSpJU45vEGvGUtk/BqJLTU3f44KkJVOVr4uKm6vkik7KXitR9Lko2zcCmP4gmpjv2+3N/+XyTtCGRysAVtvs5wRHRtxpX0FpInsQFZVRT1jB3AKAoJRmF/NOq57XiTNzh2OGrU9FpxYW6klcTarpQJ6Z9dy+I+EQ9OAukTlBCnvQwHsZt6YZXjIzyUZW/17IkeydzZIMRTO+AmCCKKicQBvUz9b2IlAiUWZqHwJ47Wvw+Jz8ppdkGw5SSOrKOwIBWfwmSGfN1Y4AbN7SUxrGVbSw==
Received: from AM8P190CA0006.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::11)
 by DBAPR07MB6903.eurprd07.prod.outlook.com (2603:10a6:10:197::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 12:29:03 +0000
Received: from AMS1EPF00000041.eurprd04.prod.outlook.com
 (2603:10a6:20b:219:cafe::ba) by AM8P190CA0006.outlook.office365.com
 (2603:10a6:20b:219::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 12:28:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AMS1EPF00000041.mail.protection.outlook.com (10.167.16.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Thu, 15 Jan 2026 12:29:03 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id C1DB62031D;
	Thu, 15 Jan 2026 14:29:01 +0200 (EET)
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
Subject: [PATCH v8 net-next 01/14] tcp: try to avoid safer when ACKs are thinned
Date: Thu, 15 Jan 2026 13:28:33 +0100
Message-Id: <20260115122846.114576-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115122846.114576-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260115122846.114576-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000041:EE_|DBAPR07MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: 686dc491-f917-4fd3-3772-08de5431ab14
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TkRQbkFPQm9sRGhEaUd0Z253ZE01OEFERjNKZVZleG1BTW5jbEhrdlZZLzZM?=
 =?utf-8?B?enhmMzdqZkx5QS92L3FuNkFqbEZZbkhhdmFmUnN4WVVmQlMwUzVGMFd6K21v?=
 =?utf-8?B?MEpTWFM2WlJwU2VvaThCeTlyQ0dCUUtPZmkwdC9KeHo0aDlsSENvaUIrQjRX?=
 =?utf-8?B?clNOb3BqSVd0a09ZbDRBM2xmSlB0dG91amovQWh4ZWNVMFZCSWk0YVJMdW9B?=
 =?utf-8?B?Qy9haVIrN1k0S0pmUU5MTVdtczZ5czdtL3dHQnJyMXhLaTBlRzJlZnQrL3NQ?=
 =?utf-8?B?ZUdtTDJTajFUeU82a1pmSUhXYkhKRkNtYi8xd0tQUjlpOG51ajlEZWhTc2Q4?=
 =?utf-8?B?MXliV2JnUWY5NkhPbXduR2k0UTEzK1JhZVBvU2JvYXAvZUlQbnZpK1N1NlFs?=
 =?utf-8?B?OE1GVW8vWjIvK3c0aitRQi9UMUVNOTB6TENQRUFzY2JoT3cvL1NxNlJsTFk0?=
 =?utf-8?B?UloyRmkzVkJYMEROdVhVYzZhdTdFazR2NzRyZTBxYjhPRmV6OWVtYW5SYlpP?=
 =?utf-8?B?cGpPN0VNa0lkWHdubzRkRXhERDQrNE8xK3lKY0M3UEZKQmd0UFUxNDVRQmVj?=
 =?utf-8?B?dklqUUQxeWFQaVZNWFk5cm1QRzRGZ2FXTS9rV2RrdWR6RWRhSXJvYlZhaFdJ?=
 =?utf-8?B?QTlTTlorOFFSTHRiODFwYStncHVBSWJhWndZTU9WTlgyUGw1SDNZNS9va3hv?=
 =?utf-8?B?MmZEOFJscDdleE9CSmpGOTdNZWc1cHpOZnhGWVhaenp1T3lqbmtuUXZiWWl6?=
 =?utf-8?B?VnU2anBONFRQZVY3dGF3dmExMDliMUx5Umh5NDNZMHNZNVdBNXdVQ0x2TExl?=
 =?utf-8?B?VlJKdWJkL09MMVNRQkJ6T2hCVmlsYWlWbng2R25ieEh5ZUthWFZiRDc1UjFF?=
 =?utf-8?B?VUpKenZnWlBacVY5VTB2OHFyaWFIUzdLZEFNQ3ZFVTdzZkJhRjNvbUEwNCti?=
 =?utf-8?B?bkltUzRIZVJFeXM1eFByYVJXWkwvUjhrS1NOTWsyVnZTdnc0ZjM5OHhqb3JX?=
 =?utf-8?B?c0xlbXZLWDZSZFNpMUVJSWc4T0Z5ZDBObUY2dGN6SEFPZXdMWUl1OGZQMnVH?=
 =?utf-8?B?OCtoOXU5eWo1MnpmM0IwUHdwVy9pbE80NEg1SDNQUkR5WEk0QVUyZVkrc3ZM?=
 =?utf-8?B?eVU4bWVIbUJVRHF0Z2xNYVpBTmgzZXYyUDhtQmlCb0pPTU5GaU03dGZMYWc0?=
 =?utf-8?B?c0YzQVFVTWxiNER1S0FkeHAzVklsZFVJMzBxaXdUbXR6eEppNXc4M3lGTldX?=
 =?utf-8?B?M1F0Y1FnTG9JV2t3UEdyOU9DY3dDL3QzVnhxamFXenJoYmhjQ1pJVzdmWk93?=
 =?utf-8?B?RnpFL0txTjBuc3NLYlA5d3pYV0doMjF3N0pXKzJaK0RoTjR0dVRXM0pvZTFR?=
 =?utf-8?B?R2lKMk5NZGdPWlVmZ2ZkZUs4UXA0UGJCZUFsbGFjM3dZUkh5YWZkN2VZR21O?=
 =?utf-8?B?VVVUSmdNZzZFK3dqM0lzYXhzb2M3a1lxbXpNUnJQV0ZIS2VrWmIrYkFXQmxn?=
 =?utf-8?B?U0haRnRXSHpVa01WTkpVWU5HUVJpeUU5WFdIVXhMbjhKY3IveHRIUVdoT3NU?=
 =?utf-8?B?MXJqbzlEVDNzUWc0SFhINngrRW1BOEIyYVJYNjdXQXNYVXZ6WGZFUmxUelpO?=
 =?utf-8?B?M0l0cHV4eTZTU2xzc1hWMkIySzVPdXM0Vk1BOXFjbTNlRzhwa1lWNndiam1X?=
 =?utf-8?B?ZnVqM3hPa0pFTENRVkYxbnpOeFFsWGQ2Q3hRek4wV2lJallSRDdjNkczMi9B?=
 =?utf-8?B?SHVhMmVpS1YvUDZ0ZlFIMjB1WndjdlM4UFhZcG9VRXVxR1IyN0ZiNnpHZnd5?=
 =?utf-8?B?REFteTM5aGRuT2NZMWhsQURUcVBuOWVDSi9yaVY4elBpMEhqUlhONm1oUktq?=
 =?utf-8?B?M3VwejY5K2RsTGtJd3RweDcyYStvOUJxc3g3dWF6Wkl1cnhlaGdBRkw1T0gv?=
 =?utf-8?B?WXJKVWhwNWJyWFNUZzNVZk1JTTFWZ1JnZEd6Tmc0aXdlWU8wRkc4SFh0MzdF?=
 =?utf-8?B?NEl1bnhySmtNa2VLWTZ3YXc1NC9IUkJBMlRHVGdkaDR6MnR3R012VE03WEJS?=
 =?utf-8?B?QzdiVW1KM3BnT0JnblBNdTVhOFhoSHlBc2lSVTY3T2VHbTBRdG1mNms5Wi9l?=
 =?utf-8?B?QjlLSnd5QmUweXNYTUNqTDV6Q1FSWVZtNVA2TFIvTm5pbXJ1VjJJeWlJbzg4?=
 =?utf-8?B?bHE2SjFuOTQ2aFB5NHk0bWdGTGhsMjdtc0xHWlppaEpsSEdoY1R1aFRURnZP?=
 =?utf-8?Q?zf1CUFaZxIgy5oJL2SiCoP3kixT6YkfhLVxMF0u0a0=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 12:29:03.2647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 686dc491-f917-4fd3-3772-08de5431ab14
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6903

From: Ilpo Järvinen <ij@kernel.org>

Add newly acked pkts EWMA. When ACK thinning occurs, select
between safer and unsafe cep delta in AccECN processing based
on it. If the packets ACKed per ACK tends to be large, don't
conservatively assume ACE field overflow.

This patch uses the existing 2-byte holes in the rx group for new
u16 variables withtout creating more holes. Below are the pahole
outcomes before and after this patch:

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ecn_bytes[3]; /*  2744    12 */
    /* XXX 4 bytes hole, try to pack */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];       /*  2816     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 177 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ecn_bytes[3]; /*  2744    12 */
    u16                        pkts_acked_ewma;        /*  2756     2 */
    /* XXX 2 bytes hole, try to pack */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];       /*  2816     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 178 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v3:
- Add additional min() check if pkts_acked_ewma is not initialized.
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  1 +
 net/ipv4/tcp.c                                |  2 ++
 net/ipv4/tcp_input.c                          | 20 ++++++++++++++++++-
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 26f32dbcf6ec..563daea10d6c 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -105,6 +105,7 @@ u32                           received_ce             read_mostly         read_w
 u32[3]                        received_ecn_bytes      read_mostly         read_write
 u8:4                          received_ce_pending     read_mostly         read_write
 u32[3]                        delivered_ecn_bytes                         read_write
+u16                           pkts_acked_ewma                             read_write
 u8:2                          syn_ect_snt             write_mostly        read_write
 u8:2                          syn_ect_rcv             read_mostly         read_write
 u8:2                          accecn_minlen           write_mostly        read_write
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 20b8c6e21fef..683f38362977 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -345,6 +345,7 @@ struct tcp_sock {
 	u32	rate_interval_us;  /* saved rate sample: time elapsed */
 	u32	rcv_rtt_last_tsecr;
 	u32	delivered_ecn_bytes[3];
+	u16	pkts_acked_ewma;/* Pkts acked EWMA for AccECN cep heuristic */
 	u64	first_tx_mstamp;  /* start of window send phase */
 	u64	delivered_mstamp; /* time we reached "delivered" */
 	u64	bytes_acked;	/* RFC4898 tcpEStatsAppHCThruOctetsAcked
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index d5319ebe2452..37a6e0aa9176 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3418,6 +3418,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
+	tp->pkts_acked_ewma = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5191,6 +5192,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rate_interval_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_last_tsecr);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_ecn_bytes);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, pkts_acked_ewma);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, first_tx_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 198f8a0d37be..8e95a4e302f4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -488,6 +488,10 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 		tcp_count_delivered_ce(tp, delivered);
 }
 
+#define PKTS_ACKED_WEIGHT	6
+#define PKTS_ACKED_PREC		6
+#define ACK_COMP_THRESH		4
+
 /* Returns the ECN CE delta */
 static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes,
@@ -499,6 +503,7 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	u32 delta, safe_delta, d_ceb;
 	bool opt_deltas_valid;
 	u32 corrected_ace;
+	u32 ewma;
 
 	/* Reordered ACK or uncertain due to lack of data to send and ts */
 	if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
@@ -507,6 +512,18 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	opt_deltas_valid = tcp_accecn_process_option(tp, skb,
 						     delivered_bytes, flag);
 
+	if (delivered_pkts) {
+		if (!tp->pkts_acked_ewma) {
+			ewma = delivered_pkts << PKTS_ACKED_PREC;
+		} else {
+			ewma = tp->pkts_acked_ewma;
+			ewma = (((ewma << PKTS_ACKED_WEIGHT) - ewma) +
+				(delivered_pkts << PKTS_ACKED_PREC)) >>
+				PKTS_ACKED_WEIGHT;
+		}
+		tp->pkts_acked_ewma = min_t(u32, ewma, 0xFFFFU);
+	}
+
 	if (!(flag & FLAG_SLOWPATH)) {
 		/* AccECN counter might overflow on large ACKs */
 		if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
@@ -555,7 +572,8 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 		if (d_ceb <
 		    safe_delta * tp->mss_cache >> TCP_ACCECN_SAFETY_SHIFT)
 			return delta;
-	}
+	} else if (tp->pkts_acked_ewma > (ACK_COMP_THRESH << PKTS_ACKED_PREC))
+		return delta;
 
 	return safe_delta;
 }
-- 
2.34.1


