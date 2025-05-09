Return-Path: <linux-kselftest+bounces-32790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CBBAB1EEA
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 23:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8021A00431
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 21:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C17262D14;
	Fri,  9 May 2025 21:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="o6wj5ef1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2081.outbound.protection.outlook.com [40.107.103.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0D3262FC5;
	Fri,  9 May 2025 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746825544; cv=fail; b=o5euyZbK2SBEBu+0E6Hli2SnrBSFDB78hZLL/uf/2Az2hixZKDLgey05Z2Eu6PCIkGJYv1B8cq6XDOfg9vD5LGofu6YWQHqEzCABpo8xtWz60fsdvWOXse5EMFZjNmy7kudxzxP3zI0dYG08bDuOiRlDrD3OOP7kQNO5kKxvmTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746825544; c=relaxed/simple;
	bh=YAtQ5zV0pdluDaNQq48Zarojk+Xw1ZIdQvNK689B7ZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXmDwZyzaLky1Z4MqjTSNUrr1LDxofaLJ2I7vDsbqdsXIBcczPD5XP7LQS4t5gFwG+K13QHl9dkv+/5MdFBAr/4oAcZxoOSrV4gPRWDUkg8klKrHvrtdqQdCDeCaSjLJht6A+SeGxqDM9pMWkWyD4yT3f6n5hgQs/0q/Pkfx8E4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=o6wj5ef1; arc=fail smtp.client-ip=40.107.103.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vP25961IAimHaj+0ITdvGE5YyxNBk0OmAUXZ3MbAmd6KtnXPyY8H/lLIGBCDYyD+WrZLSJlBM9wCS1gtdakrcpb2VSPgfx1sxHfLL1DbtWE3M2/pB1cijBCzsHsNtZX+ddw7eH+uKRR7BaWYvhYYYo3YDxv9YbswbTVZllVJoWJb+ebDB4hWCSVGX9dVbfX/lcxYT78d6UiX6aWE38hJVKWZzutIVcUJBns4z+jnVrTTVuuR/xHUCyCC1uZn9scfMBbBINZql3omo4fyGmZMjXVvBnlKNslT80Fvf4kxCNJejcVFPY4IJDJA0YDxBEeSY4/mZszp8P+r04s5owIqUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTAE5vupd3pWWpgpNKMaPyGEDr6ri8auzwYOqmDl8OY=;
 b=B3I9i6xp+rQ3+qMKeHTQxb5StpOH3/6fFFBpsuTamsr0f9o49l6E6ipn0HGicVaFQn/+azsN2YNIwpGbC55pLOJmJab4ItZFaAO1Vi/yrW4uJfDSqr/Dck4DSRNK0sz+clHwEvDJRn8QBJyk39VG1FQ+1mk8HENzb+8xTo2rp5Fj1ST2cpXAiDWZn6AOdAeRFoR28WFroJJKCu5ikg+M6ImTeCfYk+8eqD+df6ALMKrC6ZZTY0tI/hFKyToz3BpQKO1B9wsRtNuhuCfSzT9nlXeN+WGVToGZVfIKLl73xtzPkIVqfncQKfpXUZIEbqfJKSEygTATO8WBN68ANducvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTAE5vupd3pWWpgpNKMaPyGEDr6ri8auzwYOqmDl8OY=;
 b=o6wj5ef1HwgnKHuQNVoQsNmivi6MUQu2V7BpAY4r0DCo+rf2a8fPgmWsv358g9ujIS4vvEl5ZP+OwHEBUADMGbpWXGcA3d8O6UYtivBMVP4ILhzgCgQo9Z4rVJZG5K1YLV8fl4SEXdHJT6neSSe0mHWyCUhrhRJ82xUnqvrHy+CelO4G6Gk3o2BRlM/cN3yQclXyJN4B+OYb9H28cJ2QzZFYEz/HWIxi5cGPK8nrIvVhlpraYWOVU419S6fkVTf1wVi5dZnrdduuSYUgyozjDVdSVY1thHmnTDVVsGN6i7OONmg4gMaVQ6Xa0pmjDFSFfucTLBCDNCnbov74O+13Ww==
Received: from DB7PR05CA0071.eurprd05.prod.outlook.com (2603:10a6:10:2e::48)
 by AM8PR07MB7618.eurprd07.prod.outlook.com (2603:10a6:20b:241::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Fri, 9 May
 2025 21:18:57 +0000
Received: from DB1PEPF0003922E.eurprd03.prod.outlook.com
 (2603:10a6:10:2e:cafe::6b) by DB7PR05CA0071.outlook.office365.com
 (2603:10a6:10:2e::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.21 via Frontend Transport; Fri,
 9 May 2025 21:18:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB1PEPF0003922E.mail.protection.outlook.com (10.167.8.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Fri, 9 May 2025 21:18:57 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 93256200A3;
	Sat, 10 May 2025 00:18:55 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@amazon.com,
	bpf@vger.kernel.org,
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
Subject: [PATCH v6 net-next 11/15] tcp: accecn: AccECN option failure handling
Date: Fri,  9 May 2025 23:18:16 +0200
Message-Id: <20250509211820.36880-12-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509211820.36880-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250509211820.36880-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF0003922E:EE_|AM8PR07MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d78f18-bf3f-4425-c719-08dd8f3f1bf2
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YUI1TFZjeW1PczMzenlOeU9jcVBiU1NQN2pvOVB0cC8zNzRUeFk4aGxOSXha?=
 =?utf-8?B?NFQ0cEE0VDE5WndzZld3L25tUFl4MmEwWmJKbW1hMDQ5MEtpbWo5cGNKSXNs?=
 =?utf-8?B?RkdndlE2TVJxNWs4dFpwYWNOTWQwQWdLMW1aRDZpcnY0UXU2VWpOeWdFdHNx?=
 =?utf-8?B?N3lwNU1qUkcvdHNRZHA1TU4yMllrTFlOK1dPTGJ1TTZ4Q2o3RzB0SkorRFgw?=
 =?utf-8?B?OG5jNFFZWE9QdmZoMWpIUmlqNUlvUVd1UGQ4NTBUNmhJVU9CS1Y5NVk5TS94?=
 =?utf-8?B?cW9pNEZTWHViTSs1VXpsdkwrQjkyays4eGxMT3hwVUpUWkVNd0Rud3EwVm1s?=
 =?utf-8?B?M2hySTc5S1dyRDlxTUJzVmllZ0ZtNmxpVE1ybXd3T2NYSHdxMTRnTGcvOGdK?=
 =?utf-8?B?eW54c2p2ZERWc0tydWZMbG9MVkQ2bHJWNEh0cjNMa3MvQTFQekYvbm1UN1VK?=
 =?utf-8?B?VndHRy96azFpTDhMNTZnSmhQS3NGdmg5d3gzNVI1ZzlFenl3ankzZDFqWHhi?=
 =?utf-8?B?TkI0aDh3WTNPYjlMR01RZkwxMitQeCtEM29iamhVMHhrTHBRQ0tTNGxJWG5E?=
 =?utf-8?B?bk95aHIrQkJJbkVXNHlrYS9LYXFydUR3cmYvTlRYNi8vbGhVS25YU0ROYkJ1?=
 =?utf-8?B?aFZTTlZGaFZiYWZtL054QkhKT1g4ZFlQNHppMzRZZnRNZ09zL0h2Z0l0VkVt?=
 =?utf-8?B?OXFSUnhBd2pYd1BOakZ4QlJLc1A0Qm1zODlhN2Z1RXkwbnBkZzd5YXRYRnFz?=
 =?utf-8?B?T3FzRW1jaVhEdXRCSmJHdjh4Tk4rMThISFlqMXllN05zWkU4TTdLWXdwV2Ro?=
 =?utf-8?B?S2xUSVBGVHQxZFVCeXhNRHI4VFZ1VG5ic2tpa0VyV0FJUnNXMGhZM0lsZVFr?=
 =?utf-8?B?dmtOMUZOcHhzU3VXYXhqRmxENlFYS2JpbTU0N0s1Z1VEUHJ3aXMzT21UQXdt?=
 =?utf-8?B?V3J4SGdCeGYybzhwNmNRQUxYbjVXMjFNdjhiY3REOXNCd3VoMzFhdjZQckQr?=
 =?utf-8?B?VTlKTG01YVZ0VTBiYzdscTUxUHFhUTVCWWV5L1FUTEFyMnF6V2EzVVVBbzVC?=
 =?utf-8?B?TmMzOGc2Z1Yxcmh0d0JQQjBxQzNYM0hoSU1LclFkdjg1WG85ZXJEQjJpV1lr?=
 =?utf-8?B?QzJTZGU3bHZMQ1NIcXpnQm9odXNOYkU0YTZSdjZRWkcxK05DWm52bmY5R3N2?=
 =?utf-8?B?T2N5amdsS2dYckZCUGh1Q3Qveld1bXl3Z3UzS0owaHBIa3F5dFhKVlliVWVV?=
 =?utf-8?B?ZmhqdDg4SWtZdFNOSG5MaDROR1cvd1hqeGx4OGpwSzJtTzhxVWY1Y08rRit5?=
 =?utf-8?B?UzNJdTBWU3dGeTZOZVdZdUZsSTI2UEtmMUVLcUlGR0ZxSzNnV3lRNm9LbzRi?=
 =?utf-8?B?QlBmb3VxdWk3eGhhYjZWSHdGYXhCanZQZTc1WUpta1M5d0QycmNGd0owdVZr?=
 =?utf-8?B?VDZHTFJvckhaOGh4L1BtTitlVTJHaHN6Zm14dWJNMUwwZWtpNmJuMXpkZ2wr?=
 =?utf-8?B?NzIwRnBmQ2ROdk9XR1ZkUFNLOUJudTJ6U3UyNFFLcHRBcS9jMXlMenhmS3M0?=
 =?utf-8?B?VXE2VFF4Z05LSEMzd1JlT3QyOHNKNkhVMDlMdjlTb0pDMlZiYUUwT094WEJT?=
 =?utf-8?B?OUQ3bGJXeDQxTGRHSC9CeFhiWjZxOGxkWVBtT2RHMkxIc1pBSytwS0NHUCta?=
 =?utf-8?B?YldxU05JWG5pY2xNMUlJRVAwclIxeEx4ZFkraVhlaWxzbi9EakpnYUZtNkZp?=
 =?utf-8?B?ZzZTZWx2UXpTd3czbW93Vkk0Rm1oRHNXWCtod3lzaWUzT25sUFlxMWkyMWtv?=
 =?utf-8?B?dXpDWmhXbXFpa3VPbFVnSC9QRjE0eHJlRFlZcnBUSUl2cXo4UGFEUXc4ZE5t?=
 =?utf-8?B?c0FTMEphU3pZVFVUT0JYVGlya3BNUkpzaDJkZUVPOEM4Y0M2VnRtek5oTVFP?=
 =?utf-8?B?ODZ3WTZnWHJndnhvWFdGK3JIZWk4KzNidXJDa0Y2Sm5GVUQ2OWFUbTEvbEFB?=
 =?utf-8?B?dzhRVWI1QlR2cEtTVXNPbjdVT2ZtZWhlWnlMWDJvRjdUVnNhUUpuM2ZOZFNW?=
 =?utf-8?B?YzBiRFRnN3ZJU2UvK3dwNVBNbG9wN25RZGcydz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 21:18:57.0379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d78f18-bf3f-4425-c719-08dd8f3f1bf2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF0003922E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7618

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

AccECN option may fail in various way, handle these:
- Remove option from SYN/ACK rexmits to handle blackholes
- If no option arrives in SYN/ACK, assume Option is not usable
        - If an option arrives later, re-enabled
- If option is zeroed, disable AccECN option processing

This patch use existing padding bits in tcp_request_sock and
holes in tcp_sock without increasing the size.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h      |  4 ++-
 include/net/tcp.h        |  7 +++++
 net/ipv4/tcp.c           |  1 +
 net/ipv4/tcp_input.c     | 68 +++++++++++++++++++++++++++++++++++-----
 net/ipv4/tcp_minisocks.c | 38 ++++++++++++++++++++++
 net/ipv4/tcp_output.c    |  5 ++-
 6 files changed, 113 insertions(+), 10 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 0740efaaef28..b5066eef8782 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -173,6 +173,7 @@ struct tcp_request_sock {
 	u8				syn_ect_snt: 2,
 					syn_ect_rcv: 2,
 					accecn_fail_mode:4;
+	u8				saw_accecn_opt  :2;
 #ifdef CONFIG_TCP_AO
 	u8				ao_keyid;
 	u8				ao_rcv_next;
@@ -409,7 +410,8 @@ struct tcp_sock {
 		syn_fastopen_child:1; /* created TFO passive child socket */
 
 	u8	keepalive_probes; /* num of allowed keep alive probes	*/
-	u8	accecn_fail_mode:4;	/* AccECN failure handling */
+	u8	accecn_fail_mode:4,	/* AccECN failure handling */
+		saw_accecn_opt:2;	/* An AccECN option was seen */
 	u32	tcp_tx_delay;	/* delay (in usec) added to TX packets */
 
 /* RTT measurement */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3419618a7891..5e4593e39de4 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -279,6 +279,12 @@ static inline void tcp_accecn_fail_mode_set(struct tcp_sock *tp, u8 mode)
 	tp->accecn_fail_mode |= mode;
 }
 
+/* tp->saw_accecn_opt states */
+#define TCP_ACCECN_OPT_NOT_SEEN		0x0
+#define TCP_ACCECN_OPT_EMPTY_SEEN	0x1
+#define TCP_ACCECN_OPT_COUNTER_SEEN	0x2
+#define TCP_ACCECN_OPT_FAIL_SEEN	0x3
+
 /* Flags in tp->nonagle */
 #define TCP_NAGLE_OFF		1	/* Nagle's algo is disabled */
 #define TCP_NAGLE_CORK		2	/* Socket is corked	    */
@@ -480,6 +486,7 @@ static inline int tcp_accecn_extract_syn_ect(u8 ace)
 bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect);
 void tcp_accecn_third_ack(struct sock *sk, const struct sk_buff *skb,
 			  u8 syn_ect_snt);
+u8 tcp_accecn_option_init(const struct sk_buff *skb, u8 opt_offset);
 void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
 			       u32 payload_len);
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a1572a8adb35..8e7446346a65 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3367,6 +3367,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->delivered_ce = 0;
 	tp->wait_third_ack = 0;
 	tp->accecn_fail_mode = 0;
+	tp->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 10c37a41b9a5..c93e4bffb23e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -446,9 +446,8 @@ bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect)
 }
 
 /* See Table 2 of the AccECN draft */
-
-static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
-			       u8 ip_dsfield)
+static void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb,
+			       const struct tcphdr *th, u8 ip_dsfield)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	u8 ace = tcp_accecn_ace(th);
@@ -487,7 +486,19 @@ static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
 	default:
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
-		tp->accecn_opt_demand = 2;
+		if (tp->rx_opt.accecn &&
+		    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+			u8 saw_opt = tcp_accecn_option_init(skb,
+							    tp->rx_opt.accecn);
+
+			tp->saw_accecn_opt = saw_opt;
+			if (tp->saw_accecn_opt == TCP_ACCECN_OPT_FAIL_SEEN) {
+				u8 fail_mode = TCP_ACCECN_OPT_FAIL_RECV;
+
+				tcp_accecn_fail_mode_set(tp, fail_mode);
+			}
+			tp->accecn_opt_demand = 2;
+		}
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
@@ -603,7 +614,23 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
 	unsigned int i;
 	u8 *ptr;
 
+	if (tcp_accecn_opt_fail_recv(tp))
+		return false;
+
 	if (!(flag & FLAG_SLOWPATH) || !tp->rx_opt.accecn) {
+		if (!tp->saw_accecn_opt) {
+			/* Too late to enable after this point due to
+			 * potential counter wraps
+			 */
+			if (tp->bytes_sent >= (1 << 23) - 1) {
+				u8 fail_mode = TCP_ACCECN_OPT_FAIL_RECV;
+
+				tp->saw_accecn_opt = TCP_ACCECN_OPT_FAIL_SEEN;
+				tcp_accecn_fail_mode_set(tp, fail_mode);
+			}
+			return false;
+		}
+
 		if (estimate_ecnfield) {
 			u8 ecnfield = estimate_ecnfield - 1;
 
@@ -619,6 +646,13 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
 	order1 = (ptr[0] == TCPOPT_ACCECN1);
 	ptr += 2;
 
+	if (tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+		tp->saw_accecn_opt = tcp_accecn_option_init(skb,
+							    tp->rx_opt.accecn);
+		if (tp->saw_accecn_opt == TCP_ACCECN_OPT_FAIL_SEEN)
+			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_RECV);
+	}
+
 	res = !!estimate_ecnfield;
 	for (i = 0; i < 3; i++) {
 		if (optlen < TCPOLEN_ACCECN_PERFIELD)
@@ -6481,10 +6515,25 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	 */
 	if (th->syn) {
 		if (tcp_ecn_mode_accecn(tp)) {
-			u8 opt_demand = max_t(u8, 1, tp->accecn_opt_demand);
-
 			accecn_reflector = true;
-			tp->accecn_opt_demand = opt_demand;
+			if (tp->rx_opt.accecn &&
+			    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+				u8 offset = tp->rx_opt.accecn;
+				u8 opt_demand;
+				u8 saw_opt;
+
+				saw_opt = tcp_accecn_option_init(skb, offset);
+				tp->saw_accecn_opt = saw_opt;
+				if (tp->saw_accecn_opt ==
+				    TCP_ACCECN_OPT_FAIL_SEEN) {
+					u8 fail_mode = TCP_ACCECN_OPT_FAIL_RECV;
+
+					tcp_accecn_fail_mode_set(tp, fail_mode);
+				}
+				opt_demand = max_t(u8, 1,
+						   tp->accecn_opt_demand);
+				tp->accecn_opt_demand = opt_demand;
+			}
 		}
 		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
 		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
@@ -6974,7 +7023,8 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		 */
 
 		if (tcp_ecn_mode_any(tp))
-			tcp_ecn_rcv_synack(sk, th, TCP_SKB_CB(skb)->ip_dsfield);
+			tcp_ecn_rcv_synack(sk, skb, th,
+					   TCP_SKB_CB(skb)->ip_dsfield);
 
 		tcp_init_wl(tp, TCP_SKB_CB(skb)->seq);
 		tcp_try_undo_spurious_syn(sk);
@@ -7549,6 +7599,8 @@ static void tcp_openreq_init(struct request_sock *req,
 	tcp_rsk(req)->snt_tsval_first = 0;
 	tcp_rsk(req)->last_oow_ack_time = 0;
 	tcp_rsk(req)->accecn_ok = 0;
+	tcp_rsk(req)->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
+	tcp_rsk(req)->accecn_fail_mode = 0;
 	tcp_rsk(req)->syn_ect_rcv = 0;
 	tcp_rsk(req)->syn_ect_snt = 0;
 	req->mss = rx_opt->mss_clamp;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index e0f2bd2cee9e..87b03ee74676 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -501,6 +501,7 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
+		tp->saw_accecn_opt = treq->saw_accecn_opt;
 		tp->prev_ecnfield = treq->syn_ect_rcv;
 		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
@@ -555,6 +556,30 @@ static void smc_check_reset_syn_req(const struct tcp_sock *oldtp,
 #endif
 }
 
+u8 tcp_accecn_option_init(const struct sk_buff *skb, u8 opt_offset)
+{
+	u8 *ptr = skb_transport_header(skb) + opt_offset;
+	unsigned int optlen = ptr[1] - 2;
+
+	WARN_ON_ONCE(ptr[0] != TCPOPT_ACCECN0 && ptr[0] != TCPOPT_ACCECN1);
+	ptr += 2;
+
+	/* Detect option zeroing: an AccECN connection "MAY check that the
+	 * initial value of the EE0B field or the EE1B field is non-zero"
+	 */
+	if (optlen < TCPOLEN_ACCECN_PERFIELD)
+		return TCP_ACCECN_OPT_EMPTY_SEEN;
+	if (get_unaligned_be24(ptr) == 0)
+		return TCP_ACCECN_OPT_FAIL_SEEN;
+	if (optlen < TCPOLEN_ACCECN_PERFIELD * 3)
+		return TCP_ACCECN_OPT_COUNTER_SEEN;
+	ptr += TCPOLEN_ACCECN_PERFIELD * 2;
+	if (get_unaligned_be24(ptr) == 0)
+		return TCP_ACCECN_OPT_FAIL_SEEN;
+
+	return TCP_ACCECN_OPT_COUNTER_SEEN;
+}
+
 /* This is not only more efficient than what we used to do, it eliminates
  * a lot of code duplication between IPv4/IPv6 SYN recv processing. -DaveM
  *
@@ -716,6 +741,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	bool own_req;
 
 	tmp_opt.saw_tstamp = 0;
+	tmp_opt.accecn = 0;
 	if (th->doff > (sizeof(struct tcphdr)>>2)) {
 		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
 
@@ -893,6 +919,18 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	if (!(flg & TCP_FLAG_ACK))
 		return NULL;
 
+	if (tcp_rsk(req)->accecn_ok && tmp_opt.accecn &&
+	    tcp_rsk(req)->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+		u8 saw_opt = tcp_accecn_option_init(skb, tmp_opt.accecn);
+
+		tcp_rsk(req)->saw_accecn_opt = saw_opt;
+		if (tcp_rsk(req)->saw_accecn_opt == TCP_ACCECN_OPT_FAIL_SEEN) {
+			u8 fail_mode = TCP_ACCECN_OPT_FAIL_RECV;
+
+			tcp_rsk(req)->accecn_fail_mode |= fail_mode;
+		}
+	}
+
 	/* For Fast Open no more processing is needed (sk is the
 	 * child socket).
 	 */
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 0201089623e2..af619233a6f3 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1085,6 +1085,7 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 	/* Simultaneous open SYN/ACK needs AccECN option but not SYN */
 	if (unlikely((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK) &&
 		     tcp_ecn_mode_accecn(tp) &&
+		     inet_csk(sk)->icsk_retransmits < 2 &&
 		     sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
 		     remaining >= TCPOLEN_ACCECN_BASE)) {
 		u32 saving = tcp_synack_options_combine_saving(opts);
@@ -1174,7 +1175,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 	smc_set_option_cond(tcp_sk(sk), ireq, opts, &remaining);
 
 	if (treq->accecn_ok && sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
-	    remaining >= TCPOLEN_ACCECN_BASE) {
+	    req->num_timeout < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
 		u32 saving = tcp_synack_options_combine_saving(opts);
 
 		opts->ecn_bytes = synack_ecn_bytes;
@@ -1253,6 +1254,8 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 
 	if (tcp_ecn_mode_accecn(tp) &&
 	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
+	    tp->saw_accecn_opt &&
+	    !tcp_accecn_opt_fail_send(tp) &&
 	    (sock_net(sk)->ipv4.sysctl_tcp_ecn_option >= TCP_ECN_OPTION_FULL ||
 	     tp->accecn_opt_demand ||
 	     tcp_accecn_option_beacon_check(sk))) {
-- 
2.34.1


