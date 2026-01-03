Return-Path: <linux-kselftest+bounces-48107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83488CEFFA5
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 14:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 415C23057122
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 13:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F7730BB8C;
	Sat,  3 Jan 2026 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="YZgbzcb4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73FC30B53D;
	Sat,  3 Jan 2026 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445845; cv=fail; b=ZHs1qf5jkSET+kQkTQ6+aDG365JW5qUhpNtfAg0xIueYKq58g2zH/bvaCOSIJfCccT5H3/DNmyXmZAeYbzN5wumQnhWbYMKYdM8MK/yVNpV9J1xaLfnC8iQNHedcKy2Ix42IWkf+UqvTXmKxR7pVRM8+mBro38ynkJOsQbFHbb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445845; c=relaxed/simple;
	bh=uEHCvdkfhq16lespNmYXWbeCjwQbLoRYr0Dj8gR5n2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qdnrtp6My/wgDPsJlOTJYRsXjiFqY4A3bHLO8eoAF0LHN9OxQIVxRfZBVvRBnlTlxhAI3kUblG3Vhi4V18ZiDSCndYr/VQ7t+zhqf4xfF6bdg2XXk1+bz8SwNuWhn+0ZqZfYpEqI26gHI32PHpWsVniw+UF1Qm6ddU8Vik2E9Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=YZgbzcb4; arc=fail smtp.client-ip=52.101.69.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdJByd9jc7X88ANR2Vc5Fe03jMGoigNBXi4RrWQkZsSfG3htfouslHDYJYiuPNqEjWlE+viUF9bVMmVPxcEyTNJEoYIYlqLcUMiWedI2tcPIt3GdwAdc/RTz70z/TKmooxjeK+bzVfuUK8q0JK4XXr5FI8jgEexkyB+ThTCMtbxZg4i7crspGAXLAbLMWWTrOtVWhUB2vbhYK71HGqEcnKBOt/lYmn1KLkowwJAjQSFoniWgo9/g3bszxGgoXZLvoKEycb49VCVeq30GlY/EU2a+pqMmT5NF0lzua9KXvBoe1bw7nWYU6VoVGtxtz2ZSTcFuehBDONnWxGI2w2NzhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKfZrpgQMEtgJ5+p7KXBasbop0Itv204n+5VU3kynWM=;
 b=XKH1QPX4umepkZ3TsZO9jn+csdtN7VSpq6OHpl2MLcGqz5jbVNGBEwi/lGxroVeDWneGR8S1YVlURqMOXCKNkilR1KtYJRGdypm/K4qEd+6QrdZqmP0J2R1965YiS0OYtmQftZRdNUZ6tAnK+dhsAO51YNqZ/K/554lfJstNfqd2rjoHT1TFPO/BiEF/5vX0FeMbEKL6EwxW3cRrqg5mvV5j9gZADzEOWDWoUyNMKMO5/biQUCWT2YWpmb8E6nIzTSLsUZGd24FbWR/6JzxGAsT+7kzvWRXhsIcEMoE5fqkVsh9Ut3tLzfUzGUiGqJ1CPbhx8aEUwU+WJHwnUnxc7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKfZrpgQMEtgJ5+p7KXBasbop0Itv204n+5VU3kynWM=;
 b=YZgbzcb48s0t0LcJ3pAkqnWgcTHWgfgvPvpdNJEAr0So9uKCeULcXGl1oWpqD/ikEfOc2Q2x3FJu8hvngqqN4CO73gATvTeocQNA66S24XkMShCrEneh489PewCzNNmcCMa7zvcrMjdcDCkizUs1xKsx4jNF7YiofWd52OJVxqSgH3WMhVoHdI5ENDycVrp1IBSgKNH010J1KEJLbrHqtiDyBG2lGeMqmf2ihDkPJzIvulyqQ5ZU9ozdj6di7UF/2yMLvZEOybNRfDUyGFKfFC2tvXAC5qwGQI6Gi8C/AUf/wclpVheoyXskFnHsBdHbCjpwE7JrWeUYc/NI8QURsQ==
Received: from AS4P190CA0069.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::15)
 by AM8PR07MB7409.eurprd07.prod.outlook.com (2603:10a6:20b:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 13:10:39 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:20b:656:cafe::42) by AS4P190CA0069.outlook.office365.com
 (2603:10a6:20b:656::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Sat, 3
 Jan 2026 13:10:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1
 via Frontend Transport; Sat, 3 Jan 2026 13:10:39 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 972011C002B;
	Sat,  3 Jan 2026 15:10:37 +0200 (EET)
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
Subject: [PATCH v7 net-next 03/13] selftests/net: gro: add self-test for TCP CWR flag
Date: Sat,  3 Jan 2026 14:10:18 +0100
Message-Id: <20260103131028.10708-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000046:EE_|AM8PR07MB7409:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1078d2a5-ed76-44c8-ebb3-08de4ac97dc5
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?W5QqsAAugtXWXgjAC8EbhXuNhKCYEPpiIZvcHJVYOC8v30WlUnGUM7SmzUDk?=
 =?us-ascii?Q?oJKKx8MozextFCpXwJN5Ft+sZSpU3M9ca0CqC+fJGxhxXhm40ttF+PVACMl6?=
 =?us-ascii?Q?8Y/KWzLXbCY5suYmt1fJBNiZWJaxXHe5vmzXnUVylIE/HQf2vtB+zb+qXUB8?=
 =?us-ascii?Q?E3AMyEdKVVeOvjaxMNeO5b2Ec0WkxBp8ATA00eNeIAccjTINbzBgGaXqJkD/?=
 =?us-ascii?Q?GPfuzJyqLlkrswxOO+M+D69guZ5vDZVI5WLDsHAwtIzOOa3dQyBtk+CE/oJv?=
 =?us-ascii?Q?47k4C3j1JSMHc1lcVGFomtsE/lQ0OeG4ehJITZTJ443Fk0BZehBHkCR3l0fz?=
 =?us-ascii?Q?RdOGkFz418t7r8cMcrSKNt4uLSfZ7LILaHfEdojj2BjiMXIHy5uh/ZGXxE60?=
 =?us-ascii?Q?W1ebbOfuquaqefSae6dUilgVls5Eqrq8iie1FyzNuohj+lIBNMZBRDj+ZSWF?=
 =?us-ascii?Q?HaA+XwBJa3tCZRZKNwpG0iFzDYBorxMZooPbyqhbKtajn67wDw2FAgIt36zO?=
 =?us-ascii?Q?Njd1U0FJS/SyC2lfslOMo7g1TxN/53tyFDX+UPYARJWu6+n1mQ+r3AChobeD?=
 =?us-ascii?Q?lfbNr++jPwPLT/GsNMkVaM6zf6B5FaXm6+Jlnxqigdmm66SAZlD4uwtkOK5L?=
 =?us-ascii?Q?zuw8D+T/vmfaF8xv6JfnvITU3D8NNt1WCgCE1rkQXskMZec9UZJ6hunIwEuY?=
 =?us-ascii?Q?mCdUs6xr+Sp6gvI7eoILyfLjSzvSU6EBvpkzJZY9Ohxzn8Ntc5wlr2OX56XB?=
 =?us-ascii?Q?lQq2ss5mud4rVCAIicjrqIGzwTW1fp6ZkE3Rhgl4GYYPFUESNp5d0nZswJxj?=
 =?us-ascii?Q?o/jfXOJHqyRWEL4II9LieMmukE2gh7Vv0ZzP6A3QN4T+rs8wFziOPWfdsyhh?=
 =?us-ascii?Q?TJR+/heaABVmK5xDUXVRnrlvaec9gYVCbpE5HOaPKGLzXv4Iu60pMuoCwB2A?=
 =?us-ascii?Q?I9TmDO2BGX3V7RP5n9RrCqCaXNwHEWB1hYIFEGx04xs4rfU+cCenbGTTfDpK?=
 =?us-ascii?Q?669mB7EnJQOeXVML6H2vIkTz6QVUhucTgM+I43zs7dIkpMQQw63axb8R6COU?=
 =?us-ascii?Q?2ybItO2Mun/8A4kn1W1VR/F2HkXt5NQ1K0TybRe6aOKVNXURr68J2Mk0z4f8?=
 =?us-ascii?Q?Tjp6Rsil24Fiv5Xbnyvv83iYlact0v0BrfSfGbSx11AHEoR4XzEfNbGysr7l?=
 =?us-ascii?Q?CcclYjJmNib5V4TRiSXhvksZqw3vPaLnAQRoNz093iO1GxX6ZHNKM24T/cX8?=
 =?us-ascii?Q?17B9IHBub03X4wt0lkuoiyibcVE0bfLeU7sLj/RfgocDV9/HgYqn6i6xMtfX?=
 =?us-ascii?Q?tfpvz5+qdFLRXuaeEZzIcMdzaBHw7jZtQTXfkYPJ6zo84lUlR6AgBaVdtHpI?=
 =?us-ascii?Q?h45B6gggmz7rGWeBRke5u87isQ84A7o/OuaOfJp/7FEyIpuOI5q3zuwnBu42?=
 =?us-ascii?Q?JZo0bkAWvQGuKwAXsUBKkPOQEGVJLlFe9RwVxyyNKHju6tqGxAyLpPu7qV2f?=
 =?us-ascii?Q?ompgIIexKZO8k9u2E5Vr17BACPZqEC1QiT8S88O88rujfWcRvxz+tCJfxVRX?=
 =?us-ascii?Q?lnq/qw7C6SrP2RUNxcxQeldJ1xIAGLuYipLV4zNS?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 13:10:39.1500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1078d2a5-ed76-44c8-ebb3-08de4ac97dc5
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7409

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
v7:
- Update comments
---
 tools/testing/selftests/drivers/net/gro.c | 81 ++++++++++++++++-------
 1 file changed, 58 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/gro.c b/tools/testing/selftests/drivers/net/gro.c
index e894037d2e3e..736da13f85a0 100644
--- a/tools/testing/selftests/drivers/net/gro.c
+++ b/tools/testing/selftests/drivers/net/gro.c
@@ -11,8 +11,8 @@
  * 2.ack
  *  Pure ACK does not coalesce.
  * 3.flags
- *  Specific test cases: no packets with PSH, SYN, URG, RST set will
- *  be coalesced.
+ *  Specific test cases: no packets with PSH, SYN, URG, RST, CWR set
+ *  will be coalesced.
  * 4.tcp
  *  Packets with incorrect checksum, non-consecutive seqno and
  *  different TCP header options shouldn't coalesce. Nit: given that
@@ -333,32 +333,58 @@ static void create_packet(void *buf, int seq_offset, int ack_offset,
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
@@ -1021,16 +1047,19 @@ static void gro_sender(void)
 		send_ack(txfd, &daddr);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "flags") == 0) {
-		send_flags(txfd, &daddr, 1, 0, 0, 0);
+		send_flags(txfd, &daddr, 1, 0, 0, 0, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 
-		send_flags(txfd, &daddr, 0, 1, 0, 0);
+		send_flags(txfd, &daddr, 0, 1, 0, 0, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 
-		send_flags(txfd, &daddr, 0, 0, 1, 0);
+		send_flags(txfd, &daddr, 0, 0, 1, 0, 0);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 
-		send_flags(txfd, &daddr, 0, 0, 0, 1);
+		send_flags(txfd, &daddr, 0, 0, 0, 1, 0);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
+
+		send_flags(txfd, &daddr, 0, 0, 0, 0, 1);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "tcp") == 0) {
 		send_changed_checksum(txfd, &daddr);
@@ -1166,6 +1195,12 @@ static void gro_receiver(void)
 
 		printf("urg flag ends coalescing: ");
 		check_recv_pkts(rxfd, correct_payload, 3);
+
+		correct_payload[0] = PAYLOAD_LEN;
+		correct_payload[1] = PAYLOAD_LEN * 2;
+		correct_payload[2] = PAYLOAD_LEN * 2;
+		printf("cwr flag ends coalescing: ");
+		check_recv_pkts(rxfd, correct_payload, 3);
 	} else if (strcmp(testname, "tcp") == 0) {
 		correct_payload[0] = PAYLOAD_LEN;
 		correct_payload[1] = PAYLOAD_LEN;
-- 
2.34.1


