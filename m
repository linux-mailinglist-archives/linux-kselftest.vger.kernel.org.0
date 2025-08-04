Return-Path: <linux-kselftest+bounces-38241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B51BB1A149
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 14:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ACB918906D0
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 12:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8332925A2C4;
	Mon,  4 Aug 2025 12:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="UVt/Vvu1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012032.outbound.protection.outlook.com [52.101.66.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C193E258CEF;
	Mon,  4 Aug 2025 12:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310053; cv=fail; b=qRrbji0eFnivBhT6AuDnNGh2wxee7meJT9x1Vl5kuuklaU6aUyzVHNPqF8hxlj4Ltznm8MnfKQNFMrpUZq7xEA1Fa8JBdCKZQsLVFe6w2pBjane4v295sSh3miwUelhbcZdzA778YNNwZWjEZE70LIJt+RD4wn72h6M+EiEH8BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310053; c=relaxed/simple;
	bh=+nIir1XcjdphIvHIlkOCtv9qk8BoNNFJVl0UWkNxki4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=naMejOzqOo+6YzZTflqWnBryNzBLUmTpytmPz2yrRyWtASPklOGunUztgewjJUroXMWFt2qFJYWrk9HVxzGU+NrYNafg1kVNDZLD62ysvW/bpRFhbvD18SoYqnOGpxTBOvC0ItNrWMu0B0BWScgZoG0GTqtXbtuyJN6DXfA9KCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=UVt/Vvu1; arc=fail smtp.client-ip=52.101.66.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6+E6gerwCQRJIIubgFCRXyznV5Ay+mffQqUFUzXKgwQ1BATiZ2JzQ3LS600c5/RLEMM6DE7iVd3IvzVl/JONJoIwJ+fgx09g2lM09K1aSbBhStx+IbmI8JNw9hIN1YkGzUKCf2kBqHVuqS247Kl7b+5fFLRFK2NWK7ED6hOPLeP7KfNaBTWVR0jykgT6b0JMft6RHIPB4162AYLyJse8QHMfNhwEb2bUa1Fg44ivppRlLqCgep8FOQ85SVEIyxn5zN25Q+YD2t4mDY8yX4tSRPnK+CliZaiBDIz7IzLce2kSNhU250d3p52vhGgOKK5HKXbYRHhfwICC3hX53UUwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BgUG084CoF/wlkDncV8myaBCjCAeBi9qiXHCQGcTpw=;
 b=EboSRJx+eHWPNpDKXM01gISOB7P/nYJ82rzTktOVcDv8zlmpXfWANUNMP8XKBzYn3++cNEiJJdmmA7ii9A4DaBo8ARLWV0O4R8wM+PpYMrnXZux5dvPUXhvTv+e7fLsMrGbn9AEbnutzm00wMiLPH/CgIbN+y601JQzzSoLEymaSppOoUgbkjqf/W0HH+TdVJafXJtc1k+hZqqrXkLTinZdsMKSF8c6PusKU3DTEWhe6dJz8o4M5DmyY0WPsaeai9O7Se583jDqxTPRehQQ7EHq8E+SWOvFEPq+5juRx3MUESa9LvtFmQwnUVMiNASDviUwbr20Yoz0EzKU/hxNvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BgUG084CoF/wlkDncV8myaBCjCAeBi9qiXHCQGcTpw=;
 b=UVt/Vvu1AI3lwm3aDBAWpSWmvmadXIEG2v3vBdR/JhgIE42TWzqOJU77+PhnRjFpeKgTk5+XFJSJZGve1nJNjgopVL/CRuhwvU8AhAU97WkM3GGACTaoVDFN60fiPqKzWRHrIFxa4hjRnOMt9HxffjElSiSRIuXEquL+D7+K+EXE3x/uqYsDvtiDzDcOfA42lm4tf/KMJ/cH44sROdxS/xa3BKQoGI83BSr+O1A3FTd6oDlHu0+GKw7prdI5XjMExyT2Mdl6M5cXJPD0xD3+E+9C633B/me5+RVjSq2K7rL/Oi2Zk39gRrngnZ243DG5rO8NmBnmRhdaLqLDGCTpGg==
Received: from DUZPR01CA0171.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::17) by AM7PR07MB6657.eurprd07.prod.outlook.com
 (2603:10a6:20b:1a5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 12:20:48 +0000
Received: from DB1PEPF000509FF.eurprd03.prod.outlook.com
 (2603:10a6:10:4b3:cafe::36) by DUZPR01CA0171.outlook.office365.com
 (2603:10a6:10:4b3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Mon,
 4 Aug 2025 12:21:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB1PEPF000509FF.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8
 via Frontend Transport; Mon, 4 Aug 2025 12:20:48 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 7AC7C68003C;
	Mon,  4 Aug 2025 15:20:46 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: dsahern@kernel.org,
	alok.a.tiwari@oracle.com,
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
	horms@kernel.org,
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
Subject: [PATCH v12 iproute2-next 2/3] Add get_float_min_max() in lib/utils.c
Date: Mon,  4 Aug 2025 14:20:18 +0200
Message-Id: <20250804122019.57829-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804122019.57829-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250804122019.57829-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FF:EE_|AM7PR07MB6657:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5b436198-2ada-42dc-c8ea-08ddd351581c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ONMNmvkRto5ZLi4PsITN+rfgwhismAAVamVnlsKzxSB6G6aHEvTYTmwkvQ4z?=
 =?us-ascii?Q?as3cVKaMMGsLK2cQOp4sC3WHERXOehxTh6ux6zx2AWDYWxrvR0nGrAx6jfOd?=
 =?us-ascii?Q?R974Q1g3XKMTfcq0BYHU8TV5xmT3CO0wXzlg8HSRy5UhgX/2sUCzFfueK8KV?=
 =?us-ascii?Q?5223M4hqpPt7S6fzHBgC0gL8ILH4aGoycW7y2k/GOGPQBdfPbUKl7lfC4UpB?=
 =?us-ascii?Q?PSsNHxAF/6Fm/c5cpA9ZmzvoJcCub6DU/Xm49APx6u/8fMiyt3502L8nyeVF?=
 =?us-ascii?Q?cHmiMkSTiSU7TdP3FAoBMAJx1SnoRO/x7MBEZAG6KRp+FAVokpsZByAanPsC?=
 =?us-ascii?Q?wYDQ+PWzOvflkWZaCroNa0RSdFL4RMTjfvVWnViLAeNEr5bS/6EBsxHxZm+Q?=
 =?us-ascii?Q?qpIwx87UVGgGUuYVsFxi//1ZagWXO3ydmhXeLW/6Mk4yqnwodKj3OJnWwWxo?=
 =?us-ascii?Q?5JjAbOUPCwLMK9x78J9IqxwTEnybGoTxfFcbLGAsEtNe1/iuzrXbix5yfYQ+?=
 =?us-ascii?Q?owp33ErtoKY1j9c/ziL9+WhYLwJL5Kv0inj5X33xXz6ilAXUe61is/Lg3i3J?=
 =?us-ascii?Q?tAvAYPS0GkSFRtdSwKpK+X2f8rtYGZ/kbwySfYS9ZX0Gg8hGlx1LCEbU0Jkj?=
 =?us-ascii?Q?mA8g+Y55m00TGhBgm3MxZTFbyjncp/iPDe3XGZvL10Z7ToO6bpFXj076W01l?=
 =?us-ascii?Q?gXwBHK3GaAteUBWcp8xZU0VPmDoZH0JytcvNNb71cNXw7RBvARB2vGfPaPKj?=
 =?us-ascii?Q?PzBBW5yFKMu1qsqM8oGOLKWduWkssHhyYZENHG7Jv57s6tefN5PqQWJgwQHv?=
 =?us-ascii?Q?U5Zei+U9vAOUu/q8SrLb4G7fwL0kJuj/VdzrVCuLwg3hHOBWInpzZAr4VyMy?=
 =?us-ascii?Q?nCJZ2/1W3krB5wATUx+KdTaJrgQiR/MHuqrqug/P2sA27rYyNC6aUVCvJCJ4?=
 =?us-ascii?Q?0pr3e1mYljTquLBvagXvtSKRknSv1DZ1U65c9fSPBSRL2w0iNf+EexXVOh+S?=
 =?us-ascii?Q?V54JKPB5ACeIEtnzIxjaJJZW/7Kc/NqvthNg2Da8efjiHgbvsNudBm4ca9Ra?=
 =?us-ascii?Q?ribVdmaoJwSygcjVU6CtiANp42l/4kP0gLZ12j2hU+VTWapsNi97MJ3akwvc?=
 =?us-ascii?Q?bR5Pza0xfH4k+SyiPai/JDIrPN0efGI12rTwNGO7f+AGEvWVmgV3WZv//AN0?=
 =?us-ascii?Q?0Z0D2d3fPUSkYrSi8IXz6C/ROxvAjVAERmMlIwZpw7vdZNwRgkVdX1svyUrg?=
 =?us-ascii?Q?UT077xZu1+/aLPpxnOJy7UYAng9uDNA0YykRxWL6whlQuqIYmCIRyIwP+df1?=
 =?us-ascii?Q?PXa89smId7AXNamtQOjSBYgOpLQqFTG3sx9WlCL/33ZySfMMnuNHdsbfAXcf?=
 =?us-ascii?Q?5rb3B9VYSe/U6YAjzt2RFzYcDLXEaZca6BZ7O+1tUeklfkDV+BoEub3SO6nt?=
 =?us-ascii?Q?etklvp/xZvwKic/btoDJPFSyT6MZHXk7GR9MqHdIngxG835WTpyZV5G3t7rD?=
 =?us-ascii?Q?OvQ1VND8iGUiWzyNd8nQpGQWoVg3CPNsMNZpY0UUeUCN4p4JiAO09yzzNA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 12:20:48.0032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b436198-2ada-42dc-c8ea-08ddd351581c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6657

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

get_float_min_max() is based on get_float() and does an additional
check within the range strictly between the minimum and maximum values.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/utils.h |  1 +
 lib/utils.c     | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/utils.h b/include/utils.h
index 9a8b8026..91e6e31f 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -147,6 +147,7 @@ int get_long(long *val, const char *arg, int base);
 int get_integer(int *val, const char *arg, int base);
 int get_unsigned(unsigned *val, const char *arg, int base);
 int get_float(float *val, const char *arg);
+int get_float_min_max(float *val, const char *arg, float min, float max);
 int get_time_rtt(unsigned *val, const char *arg, int *raw);
 #define get_byte get_u8
 #define get_ushort get_u16
diff --git a/lib/utils.c b/lib/utils.c
index 103e4875..dd242d4d 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -234,6 +234,22 @@ int get_float(float *val, const char *arg)
 	return 0;
 }
 
+int get_float_min_max(float *val, const char *arg, float min, float max)
+{
+	float res;
+	char *ptr;
+
+	if (!arg || !*arg)
+		return -1;
+	res = strtof(arg, &ptr);
+	if (!ptr || ptr == arg || *ptr)
+		return -1;
+	if (res < min || res > max)
+		return -1;
+	*val = res;
+	return 0;
+}
+
 /*
  * get_time_rtt is "translated" from a similar routine "get_time" in
  * tc_util.c.  We don't use the exact same routine because tc passes
-- 
2.34.1


