Return-Path: <linux-kselftest+bounces-49397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24777D3B674
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E5B1308E2B8
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 18:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD6738F956;
	Mon, 19 Jan 2026 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="VaiqTPfO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013042.outbound.protection.outlook.com [40.107.159.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA8838B9AF;
	Mon, 19 Jan 2026 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849151; cv=fail; b=aRIUvY4vDNHIkB4sG0K2RgaAfDhjlCLXAyzv4XTlAMd2bA6qBw4iarubU68qrlZBm9Jfxrr7VQBnrmrwoSGQNJaugURbxWMM9ohyoviOBbcR9Lwe+cR3oFlkPRluqStxSske5dV09QN+escG2YuhLYz9R3SmrovQyOCRcsqO7gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849151; c=relaxed/simple;
	bh=BHcoRf4SopqHlfUJphbh1VbQNcn3e9Ra0vHqLXBoXKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IidEUCdai+i3b1sYfOUxg9+HVEDaKUIZVQYUPl6ql72Q4HlaHZpgfrQ9zBKj5S7xuZn45462owgBPlHUuYR2K5GxJPy5wKcYz4Jup6m6B/TE4fU04/mBq8xVAi7ZvracYvWPbm6nFQJbZ4drDLpdb7/JhIkV2ESEMCaLLePSLH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=VaiqTPfO; arc=fail smtp.client-ip=40.107.159.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/29CtzRZg4exumvmf+RvSor0m1B87ns+Zr1SeK6zSjVnKLGVO97Pk8fQcS+fNVgk6VZDW1tYlr/oqUEg6sNAudAUHOzBOIGAS3oOa2Ohfv5t+pySHMZQch/Tkdn9ww2rk8pWeIwyWq/lvsTfTu+W3IYrkBtzBCmhsyfm2x8bfY4mQe7dQYWAVk+MryFj7V3FJhy+HJ1A60s011n2AjrP57qovdlhktOWwe8eHiMvrQUsPO72KM7RvV/A0A9kKY1Rh5pejxFNdaYmKew5k1PQmaGt2P9oUMOGF3rTDt7GUHF5k31PzDe9IjnJqkQ7jRk2yrc17T0U2z8zgvYN92RpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQlN1SpWRdPyfZvWK6obt3UuvQoIlKfJ7ICKCvTfaT8=;
 b=q+kmy2nA9PJwtey3Q2+sir2lBiCan7r2fMJmJKRKKtYmK2LVctuJrUSOH5nqEkVGQDF8TrXDsJ/LMMWliNW3NPdYRvN75/D7BKTTuDPXuifeXz6SHGsD1RPKtgDHkp46Qi6jUss27VTqkXDA/4g18E5wRllpScJyW6KsHHF/pDq+MgYhvS6uKVmpZzlmH4nvVD2uEDZKYmkNjpkJlOM/yXMwONcgmYbXFC+xhFPtwgdr95eISdhfWOW/p6pryJvygLSqKx9jM8WX6CsKeSdNAtrTTEBbBZrpmIbJ/SmezW1YDgbHb3fI9dWPR1+HlfQKBIbx/MMsfS2gO4c56o8iAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQlN1SpWRdPyfZvWK6obt3UuvQoIlKfJ7ICKCvTfaT8=;
 b=VaiqTPfO9DoB3vOcXo+6hJeTWevTg4eYULIyG0+cmHE1SrLTHdqUNuEa+bAwitpQVtv/mn5PiiIRR/luL16JIyeF2/umc9CAGZpnN3Tvcv1YZxo21waswJNfOWUpesqRG+oQQ4W6gC9qdDSArRTiv9JeJeU3MhjXVHySzJNgTNehMlLZEw+AQJVI3x3pN20kGHFgV99jJSnNIedbPjrDiXYxiWiD+bDdXhfVaPQBLgKsZZc7S78tNthvK2ArncXTHzJXvE32VhndTFPJcEZqyAMa5q8T2jdv6cJhay7YypHlOQPo4DwDXo9exalpLXeRPKMKGkn5ctWgc3TusuxzMw==
Received: from AS4P190CA0021.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::6)
 by VI0PR07MB11723.eurprd07.prod.outlook.com (2603:10a6:800:312::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 18:59:02 +0000
Received: from AM4PEPF00027A63.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::37) by AS4P190CA0021.outlook.office365.com
 (2603:10a6:20b:5d0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Mon,
 19 Jan 2026 18:58:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM4PEPF00027A63.mail.protection.outlook.com (10.167.16.73) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Mon, 19 Jan 2026 18:59:01 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 38903201F3;
	Mon, 19 Jan 2026 20:59:00 +0200 (EET)
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
Subject: [PATCH v9 net-next 03/15] selftests/net: gro: add self-test for TCP CWR flag
Date: Mon, 19 Jan 2026 19:58:40 +0100
Message-Id: <20260119185852.11168-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A63:EE_|VI0PR07MB11723:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 78ffaef6-4ec7-4e87-9015-08de578ccf55
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?v8Xqz4syAEsv8Vjed84UF0ly1tKGdn7cpEV1EY0bWIa4IlMFzSf4zKOnKfM7?=
 =?us-ascii?Q?eEqxoe8/ldZ1icpnTS8vSzsCLUsOTbg0yMH9Cr0WjmV4bNULEPsJUaPJQQcp?=
 =?us-ascii?Q?2XzqLFaC19EgLRKWcaTj1s0X0f5uA/9F5xfj84vT15nvkaq2RiEVee5q657O?=
 =?us-ascii?Q?4GzwIgabRsOpjflp3p8Y5ZefUSxZF9UVAGEoFmPa+z/Js3z1BPTXwySmZkJB?=
 =?us-ascii?Q?XZPBNXxvfJ7bbxFqmODuuKsjAIXPDzw0s+PoywhtUPlthKU3mUmCUhyM7g/p?=
 =?us-ascii?Q?VF4IGcjFXwpWqTUhsXJZNiZQfsWKAvTVkqNpyYTtG9whYLXP+G9Dn69zDfTr?=
 =?us-ascii?Q?grRvOyet2f6QHfVUbBuo5v/655myAEikS81OB4S7VTUYygcUonR6pXmMgrf8?=
 =?us-ascii?Q?sb2gS8YYEzzzUjkZ5hz7p0mt+DUFjQrVMjVupjlCFhPPW+kYLtodZnn8i4ss?=
 =?us-ascii?Q?aXEMaGlw72XT5F6CitXzNUbx8nyrCuZT7c6eOwlHlsZ9HmcyK/jmvhWR44YA?=
 =?us-ascii?Q?B0rZWM01EsxbRpvI7M9GKYMBMC03O6Z+edjJhiFEex0eFjdZMuOM2DxCjyRY?=
 =?us-ascii?Q?diTHlig1MuiACeu6meHyKezPn2AitqeH8KXQHkctU1fqaLF7kKAfqw1CKBDd?=
 =?us-ascii?Q?MhFzjE9xVoGsp3lsKU4cRVPLAYG/2vD5kPnA311aPy7pS/KpAZeq6uIVC3uC?=
 =?us-ascii?Q?TutabjvyHkIVp5Cy7Kkap/i1z8MEDoq3oNru7pcEXF4SyDfJqK0/Na2cUPZP?=
 =?us-ascii?Q?HvbfRYUzEtnPKvHsar4ZLp+vgtw7y7VXCMlEG+P0qy6h+2CGiRZfw3TURzaz?=
 =?us-ascii?Q?h/LJcyGhNtVWQTuijbkFmXusIVwcyzz51UqPWUKatWa6KwNlpQpMB2IJdy9r?=
 =?us-ascii?Q?WZv1y9uG9QXTbgCXBp5hJgYDXQPp4+M10igkemuZyA+I61AQ4sc6+55Pyqac?=
 =?us-ascii?Q?I4wVMt0yZC0DXuLyjid9P9/WWG88tNP9iJZ/K1pQ1lLUYgEvl/s90hvxFU2a?=
 =?us-ascii?Q?DV5DY4OV3ovngk+mT3zCvjobjHbsQHWnRWSoWj+WPyqkQld4c/1shwbJmiFs?=
 =?us-ascii?Q?Cf5js8kNt4BhYX6Q88EDx7/nYK6AsZXzqYfAghFRD2jnzLNXYe2VD5y/b7g1?=
 =?us-ascii?Q?knT8sUKup8SaqsLmMzFPNMM92SoN3jrNYuoEOjSYHBuX1Hkg7HXSQOKrnScj?=
 =?us-ascii?Q?u+LV3//pGY2QKuK4TSweL4DSd/THQ3PMnajtQRve6wQtEwhkxfDn52va6XFG?=
 =?us-ascii?Q?elDgcO/hDbPFaFAj9wNbS5B6d1/bUSos05636nsK7Bu+YRuYkvqRHQzixYZq?=
 =?us-ascii?Q?mbJ8kh5Rq7UrfswtAF/A8SuRM0YikJ1NbMnb1oyxglv/og5A/SoMIZLw1dpu?=
 =?us-ascii?Q?gnIqO8pmMmY5SDuz0/2K468NQD/4xuDfG6d30MjD07dgaXWiEHQ+MpM1NbEJ?=
 =?us-ascii?Q?Ej05psbdKnY2Bxn9PClhRyuFkNqv4iwJb0Z42lEsjhN5i82CHJ0pum2oK/XC?=
 =?us-ascii?Q?DUUbfqqgRRXoNw+E+JXAczDN5RVDDbp5Or06MZYI2L2km5S48lXnr3ES5IkA?=
 =?us-ascii?Q?z2ieAb853q1PD5ojbzKwHPx2cf1mRFliDVFgTlu9TZ2J+kfpcGThMp1uOw7V?=
 =?us-ascii?Q?DhxojXzlPRuYblJnR9bhkofYorlOxUmbJ6KwEcVq5aiTsYoc59JfyC6Zk9ai?=
 =?us-ascii?Q?MEp7dnbNDUDJrYbed/gLDzl0ufc=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:59:01.8032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ffaef6-4ec7-4e87-9015-08de578ccf55
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00027A63.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB11723

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Currently, GRO does not flush packets when the CWR bit is set.
A corresponding self-test is being added, in which the CWR flag
is set for two consecutive packets, but the first packet with the
CWR flag set will not be flushed immediately.

+===================+==========+===============+===========+
|     Packet id     | CWR flag |    Payload    | Flushing? |
+===================+==========+===============+===========+
|         0         |     0    |  PAYLOAD_LEN  |     0     |
|        ...        |     0    |  PAYLOAD_LEN  |     1     |
+-------------------+----------+---------------+-----------+
| NUM_PACKETS/2 - 1 |     1    |  payload_len  |     0     |
|   NUM_PACKETS/2   |     1    |  payload_len  |     1     |
+-------------------+----------+---------------+-----------+
|        ...        |     0    |  PAYLOAD_LEN  |     0     |
|   NUM_PACKETS     |     0    |  PAYLOAD_LEN  |     1     |
+===================+==========+===============+===========+

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v9:
- Add missing comma

v8:
- Rebase to the latest tools/testing/selftests/drivers/net/gro.c

v7:
- Update comments
---
 tools/testing/selftests/drivers/net/gro.c  | 81 ++++++++++++++++------
 tools/testing/selftests/drivers/net/gro.py |  3 +-
 2 files changed, 60 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/gro.c b/tools/testing/selftests/drivers/net/gro.c
index e76c618704cf..3c0745b68bfa 100644
--- a/tools/testing/selftests/drivers/net/gro.c
+++ b/tools/testing/selftests/drivers/net/gro.c
@@ -17,8 +17,8 @@
  *  Pure ACK does not coalesce.
  *
  * flags_*:
- *  No packets with PSH, SYN, URG, RST set will be coalesced.
- *   - flags_psh, flags_syn, flags_rst, flags_urg
+ *  No packets with PSH, SYN, URG, RST, CWR set will be coalesced.
+ *   - flags_psh, flags_syn, flags_rst, flags_urg, flags_cwr
  *
  * tcp_*:
  *  Packets with incorrect checksum, non-consecutive seqno and
@@ -360,32 +360,58 @@ static void create_packet(void *buf, int seq_offset, int ack_offset,
 	fill_datalinklayer(buf);
 }
 
-/* send one extra flag, not first and not last pkt */
-static void send_flags(int fd, struct sockaddr_ll *daddr, int psh, int syn,
-		       int rst, int urg)
+#ifndef TH_CWR
+#define TH_CWR 0x80
+#endif
+static void set_flags(struct tcphdr *tcph, int payload_len, int psh, int syn,
+		      int rst, int urg, int cwr)
 {
-	static char flag_buf[MAX_HDR_LEN + PAYLOAD_LEN];
-	static char buf[MAX_HDR_LEN + PAYLOAD_LEN];
-	int payload_len, pkt_size, flag, i;
-	struct tcphdr *tcph;
-
-	payload_len = PAYLOAD_LEN * psh;
-	pkt_size = total_hdr_len + payload_len;
-	flag = NUM_PACKETS / 2;
-
-	create_packet(flag_buf, flag * payload_len, 0, payload_len, 0);
-
-	tcph = (struct tcphdr *)(flag_buf + tcp_offset);
 	tcph->psh = psh;
 	tcph->syn = syn;
 	tcph->rst = rst;
 	tcph->urg = urg;
+	if (cwr)
+		tcph->th_flags |= TH_CWR;
+	else
+		tcph->th_flags &= ~TH_CWR;
 	tcph->check = 0;
 	tcph->check = tcp_checksum(tcph, payload_len);
+}
+
+/* send extra flags of the (NUM_PACKETS / 2) and (NUM_PACKETS / 2 - 1)
+ * pkts, not first and not last pkt
+ */
+static void send_flags(int fd, struct sockaddr_ll *daddr, int psh, int syn,
+		       int rst, int urg, int cwr)
+{
+	static char flag_buf[2][MAX_HDR_LEN + PAYLOAD_LEN];
+	static char buf[MAX_HDR_LEN + PAYLOAD_LEN];
+	int payload_len, pkt_size, i;
+	struct tcphdr *tcph;
+	int flag[2];
+
+	payload_len = PAYLOAD_LEN * (psh || cwr);
+	pkt_size = total_hdr_len + payload_len;
+	flag[0] = NUM_PACKETS / 2;
+	flag[1] = NUM_PACKETS / 2 - 1;
+
+	/* Create and configure packets with flags
+	 */
+	for (i = 0; i < 2; i++) {
+		if (flag[i] > 0) {
+			create_packet(flag_buf[i], flag[i] * payload_len, 0,
+				      payload_len, 0);
+			tcph = (struct tcphdr *)(flag_buf[i] + tcp_offset);
+			set_flags(tcph, payload_len, psh, syn, rst, urg, cwr);
+		}
+	}
 
 	for (i = 0; i < NUM_PACKETS + 1; i++) {
-		if (i == flag) {
-			write_packet(fd, flag_buf, pkt_size, daddr);
+		if (i == flag[0]) {
+			write_packet(fd, flag_buf[0], pkt_size, daddr);
+			continue;
+		} else if (i == flag[1] && cwr) {
+			write_packet(fd, flag_buf[1], pkt_size, daddr);
 			continue;
 		}
 		create_packet(buf, i * PAYLOAD_LEN, 0, PAYLOAD_LEN, 0);
@@ -1068,16 +1094,19 @@ static void gro_sender(void)
 
 	/* flags sub-tests */
 	} else if (strcmp(testname, "flags_psh") == 0) {
-		send_flags(txfd, &daddr, 1, 0, 0, 0);
+		send_flags(txfd, &daddr, 1, 0, 0, 0, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "flags_syn") == 0) {
-		send_flags(txfd, &daddr, 0, 1, 0, 0);
+		send_flags(txfd, &daddr, 0, 1, 0, 0, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "flags_rst") == 0) {
-		send_flags(txfd, &daddr, 0, 0, 1, 0);
+		send_flags(txfd, &daddr, 0, 0, 1, 0, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "flags_urg") == 0) {
-		send_flags(txfd, &daddr, 0, 0, 0, 1);
+		send_flags(txfd, &daddr, 0, 0, 0, 1, 0);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+	} else if (strcmp(testname, "flags_cwr") == 0) {
+		send_flags(txfd, &daddr, 0, 0, 0, 0, 1);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 
 	/* tcp sub-tests */
@@ -1239,6 +1268,12 @@ static void gro_receiver(void)
 		correct_payload[2] = PAYLOAD_LEN * 2;
 		printf("urg flag ends coalescing: ");
 		check_recv_pkts(rxfd, correct_payload, 3);
+	} else if (strcmp(testname, "flags_cwr") == 0) {
+		correct_payload[0] = PAYLOAD_LEN;
+		correct_payload[1] = PAYLOAD_LEN * 2;
+		correct_payload[2] = PAYLOAD_LEN * 2;
+		printf("cwr flag ends coalescing: ");
+		check_recv_pkts(rxfd, correct_payload, 3);
 
 	/* tcp sub-tests */
 	} else if (strcmp(testname, "tcp_csum") == 0) {
diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
index 1bb8af571456..cbc1b19dbc91 100755
--- a/tools/testing/selftests/drivers/net/gro.py
+++ b/tools/testing/selftests/drivers/net/gro.py
@@ -17,6 +17,7 @@ Test cases:
   - flags_syn: Packets with SYN flag don't coalesce
   - flags_rst: Packets with RST flag don't coalesce
   - flags_urg: Packets with URG flag don't coalesce
+  - flags_cwr: Packets with CWR flag don't coalesce
   - tcp_csum: Packets with incorrect checksum don't coalesce
   - tcp_seq: Packets with non-consecutive seqno don't coalesce
   - tcp_ts: Packets with different timestamp options don't coalesce
@@ -191,7 +192,7 @@ def _gro_variants():
     common_tests = [
         "data_same", "data_lrg_sml", "data_sml_lrg",
         "ack",
-        "flags_psh", "flags_syn", "flags_rst", "flags_urg",
+        "flags_psh", "flags_syn", "flags_rst", "flags_urg", "flags_cwr",
         "tcp_csum", "tcp_seq", "tcp_ts", "tcp_opt",
         "ip_ecn", "ip_tos",
         "large_max", "large_rem",
-- 
2.34.1


