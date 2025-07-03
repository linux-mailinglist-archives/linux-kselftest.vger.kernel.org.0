Return-Path: <linux-kselftest+bounces-36388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38F7AF69A6
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 07:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520A54A70EF
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 05:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A76929C328;
	Thu,  3 Jul 2025 05:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="q5ZGRkij"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012019.outbound.protection.outlook.com [52.101.66.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3661E29B21C;
	Thu,  3 Jul 2025 05:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751519951; cv=fail; b=HotbgpAEtYe/AnKStwyhBSYpOoAWq1yPGAixUHccJKqpk9YbAnFRnsWs0fJqUrRawF6fHOo6IUfxpzFMg8L7zIJLJXru+YLZC7gvAZgbHsW0vDANmVfFGdRY2ECQ9IkaC3x2g5GAVgXZt/bj3K8/uO7T4mj6byTR3Reuvgl7Wxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751519951; c=relaxed/simple;
	bh=J30iOy+Lh8VCKUCbCfAEnUqRWAu53dq8wPfwoVdNSMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CI55EStI1wWR4B0plZHAlyXnrt7GSg9nk3HK/A65cQepDJiijz9M1sz2VsymPPZaAORCbeZmaHKXlTf7oWVM6KzQmqeGzW2VDEqm7a+I5spSAbwWxse2VcZNO6mXpaMaYjoG0uXVYYMiHXHqAT2ZESc85xAwbWJMjVIzwitZQIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=q5ZGRkij; arc=fail smtp.client-ip=52.101.66.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVgw0o6sDv+kh26AmoX7eWqMzv1YTNEzw9xO6DMROVgYzen7gxxzohHJhg5KL3iS7fn+rnqTCD9+dKi0fOV8t5aLbshFrCE0Gz+vb2JYQVgR94mfRyxevCgy6nw1Xt6onVSUrQpbGv2EG9Y9Z7+fjVeJJlnvjxKzQBZSCcLlijz/MHyvT/lkKrsTgSbtbN9FEbDnExn9bWPTk1D+jBazAsQ9F+a/Da1nTyGUq3SWsrd4nh6JvVohucbzVyM9RkmGg0542DFmP8F7o/y7s0wXHzfG4G1kOUBPxKbQphfM1jo/n5t6Bq8Qb2O9l+NJYLAsACXq5TSqUClJUmAnDHvbjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6fjybJ/1YtQztmB+/QhyRQqFiK3FOO4hsPtLxSluOA=;
 b=aen62O9GAteiMns3t8AtfLROuE2EiwUrj+tys7pJDCHoJl4WV5Q01HRicXWNxlMOWXrcar1ivIa5KW+uw9irx+rEvBz+El+uj3lUD9ZBM19B+VgpAqQsLraU2QXSPlCnVdLA/L3ZfWAbKnUEjxw27XXtqeXzHl2BDlS5xibWN2L06X+i2SLrZbVGfliseLVycRyr9bPJkGv9snXmUnFoxkqUOVCqu0oPLvQfEDs1YwlG4WYZ33wEUrMG8M4C9L9spKeU4zp1hMJYampmQ9Bn/voms5ImwIkHwCFYE+lduNrFU0abFFQcm9a3LbU+8lKd4+uxAuVCo/Z2d/5/gj1VRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6fjybJ/1YtQztmB+/QhyRQqFiK3FOO4hsPtLxSluOA=;
 b=q5ZGRkij9ulG7hn+HZ38yn+cSdxCoz9+SvRnBlqfXm0JLmNdxfv19PVMfTfrAdT9ZwiU74dgBmNa3HOvJZJIYW+uVa0mcstV28wGjsbZvqHQ8vhJJzU4qteG0wCs66AX+Ukmtypw/bra8YnE4FTlLsb19NGPjv7BUh/ZLfrwTvbj6pzwzEmurhIoHxap+2KzRoUHHbQQz8Zvi2pO0CIRxr7R8udSGp4QUy5UWo7j1vmRl5bkucyRjEgHBnMrBM7tvym7XYoxBmiHwf20z0hyiJYFL3XHA7cLH5vJvY8cM/XNdAnzZJRuzl2A8RfPJyp0KkU/H3UNB8z7XD5w9cryAA==
Received: from DB8PR03CA0002.eurprd03.prod.outlook.com (2603:10a6:10:be::15)
 by AM0PR07MB6291.eurprd07.prod.outlook.com (2603:10a6:20b:156::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 05:19:06 +0000
Received: from DU6PEPF0000B61C.eurprd02.prod.outlook.com
 (2603:10a6:10:be:cafe::c5) by DB8PR03CA0002.outlook.office365.com
 (2603:10a6:10:be::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Thu,
 3 Jul 2025 05:19:06 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.240) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU6PEPF0000B61C.mail.protection.outlook.com (10.167.8.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Thu, 3 Jul 2025 05:19:05 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 140DD200CA;
	Thu,  3 Jul 2025 08:19:04 +0300 (EEST)
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
Subject: [PATCH v11 net-next 15/15] tcp: accecn: try to fit AccECN option with SACK
Date: Thu,  3 Jul 2025 07:17:28 +0200
Message-Id: <20250703051728.37431-16-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703051728.37431-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250703051728.37431-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61C:EE_|AM0PR07MB6291:EE_
X-MS-Office365-Filtering-Correlation-Id: 850297ed-d6fd-45b6-1b77-08ddb9f12184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVg4N3Qwc0t3aER5NlBFTC9uYnhpdm9PL1p3UHFkVXl1NWJ5YWN0NERHODg1?=
 =?utf-8?B?TTEzR1pNWmpxaHZ3T2VYNDFjelN5ZG1lRHMyUzRiV2tFR09IcVZDaHQ3STY5?=
 =?utf-8?B?UHZSNnFFVmhTZnJRTnphWHU0VjVtNUNHemZWWTA5SUhUYUlMQUt2L0FzVWt3?=
 =?utf-8?B?SVNhdmYybk5MM01laCt0WmlFZ1NxV3QrM1ZKMzBDNkV5UXV4Nm9XSlFsUmIr?=
 =?utf-8?B?NkJNYVBIZWM2TG1BeVAxN0hRT1BIK1FST2RyUFVtZmY1OEtKYXprMVFqNzVL?=
 =?utf-8?B?akhFRkFLVFhtRm9pcTcrUmZYREViT0p6cTNLdU5kanF4QVpWMXI5QVd0NFdC?=
 =?utf-8?B?ckpxYUNFclp6Zzl1L2ZDQ2JCcG80NjdwVDE3aE8rNllJamVLRjRRM3FBU0Jm?=
 =?utf-8?B?aXZ2eGUrblUyeldSQjd3YWhrb3JQbUhjMzV3RGJMdXZjMW5sazJ4RlFJaVJk?=
 =?utf-8?B?N3pOUnVNVkdWYm5ZbHRSRytaSWZLMjg1NFRSMWV1Q3k3czBRdk93L1NZbTBC?=
 =?utf-8?B?WDRwZHI4VnJiSzRGbFZ1ZXBtbEs4dWhJSldwTGUvOThMaCtYamtSYkVBUHE5?=
 =?utf-8?B?K01BQ1dRMU52RnA1cEFNS2Z5YVB2YmhzZDZXU1gyYTEvKzA2UHoveHBLc1F1?=
 =?utf-8?B?NEVocXpYcWVnbnpTaEUrM1NEZnloWkduQ0E0WjA2MmNtNFlIM1RvZGlqMi9y?=
 =?utf-8?B?Tk9WQlp4RHl5Mi9NMTRxbHZ2OVN1QUlISzFpNFRqTHNReitZaXA5anB1NFd1?=
 =?utf-8?B?djVlTXo2My9pSCtxbWxMQ2RvTG1lQUhmYlNVMXU4VktnSkhvdTlLYkh4T1pM?=
 =?utf-8?B?YXFEOFFPYS8wZ2U5MlJyYkp5SzYxOGp6b0t0NERyOGgram9tNkE4QnZWVEZB?=
 =?utf-8?B?WFpIczVhZmFwV2grS2dRWHBLZGJ5TEc4bk5jUlYwbnUwRXdWVkptb2JrVitI?=
 =?utf-8?B?NUdUN0tNd3hsZ3lGdm9ZajBDdTlZL0w1eDRmZTJwbENOSHFVZ0JHZWVvVTRn?=
 =?utf-8?B?MTc4YTdLbVh0REJpUU9YRFBaTjdaNmx4KzJobkR5bmlTRWs3REh1SnNRUWVZ?=
 =?utf-8?B?UXpUYm1DZUZxbFg0Z1AvMnlhM2FnZjBIRHZXY1VsbWtFZXdDTm1CeTQzZG0z?=
 =?utf-8?B?ZWE2djkzQ2s4UnVDd3NRcEpzS2piWEFxVG1lMnRjaEw5V2JTU0lHTHFYYUhM?=
 =?utf-8?B?VnNTVHM4bS9CSmxmTVA0N2xXN1lBTWVENlpqWHNkSDV3ZVFhK3o4ZXhKU0NQ?=
 =?utf-8?B?NWRRdVBkUlk2U0ZKRlhjZU1NTHdpVW1ESmxNWXViYnp2UWFaS2Z5M04wL3Bw?=
 =?utf-8?B?dnhwT1BVS0Z6UFI5eC9JTmIvRC85enBFNUxQZ3I5V2NKb0t6U09jYUs4WWN3?=
 =?utf-8?B?bEwrVlkyTGwwVjZSbEd2MTlYTVhxQ1FHVi9UaUtLZi8vOFo5Q0FpUmlER1o0?=
 =?utf-8?B?OGkyQ041akkySUMvbjVGS3M2cjRNY2ZxK2Vxc3JBMVFXdnBZRzNsdk9hL2Ro?=
 =?utf-8?B?Z21vV083SFU0aFl1bHg1ZGJqem02UHh1aXlqWWF5UFQyS3BrdUNkSm55UHJT?=
 =?utf-8?B?Um1SWkR3RGZNOHJoQzFmWmIwM0JJeWFRRE16cDFyQUVLMXRGSEZQY0FneFpr?=
 =?utf-8?B?QWdvS05FL0dVdXdTbEs4d21sS0s0dFdRV0NRMkZpOWRwcjlpakJWUHB2blR6?=
 =?utf-8?B?OG5pbkd6ZU1OVVJ5NmxEejV2SEw5SlJPeDVqSjh3V2EybjdvZE80VkRnR3lx?=
 =?utf-8?B?OFVTUmptTk1ZRmJZOWFlYWl2UGJkR2RsclJnVVlDbUMzaExmVmJla3UrVnZn?=
 =?utf-8?B?UUNObEd5NlVTQ2I2eVMrZVZMenZMWFhlTHlIUDF4dWlxRXJmckdvQk5ZdkVX?=
 =?utf-8?B?Z1d0cVBoTmhwSjJRdkNCZUNyOFNUWG9WbEt1aUxoYVFZL1ZFUVVsSWw5VW5q?=
 =?utf-8?B?aWd4SzBZT2FwLy9RcU92cHI5elk5YUhMN3Y5T0dZazRzNW56S0N3NFY4LzB3?=
 =?utf-8?B?VDN0MytqVzBjN3gyTjZCOGJueUhvcU5DUHRORG0rRWsrYkJOaFVzYXhNWXM2?=
 =?utf-8?B?aVBVdU9uM1FON0xhVzByNHJSV0I5dkc2eVdiUT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 05:19:05.6194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 850297ed-d6fd-45b6-1b77-08ddb9f12184
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6291

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

As SACK blocks tend to eat all option space when there are
many holes, it is useful to compromise on sending many SACK
blocks in every ACK and attempt to fit the AccECN option
there by reducing the number of SACK blocks. However, it will
never go below two SACK blocks because of the AccECN option.

As the AccECN option is often not put to every ACK, the space
hijack is usually only temporary. Depending on the reuqired
AccECN fields (can be either 3, 2, 1, or 0, cf. Table 5 in
AccECN spec) and the NOPs used for alignment of other
TCP options, up to two SACK blocks will be reduced. Please
find below tables for more details:

+====================+=========================================+
| Number of | Required | Remaining |  Number of  |    Final    |
|   SACK    |  AccECN  |  option   |  reduced    |  number of  |
|  blocks   |  fields  |  spaces   | SACK blocks | SACK blocks |
+===========+==========+===========+=============+=============+
|  x (<=2)  |  0 to 3  |    any    |      0      |      x      |
+-----------+----------+-----------+-------------+-------------+
|     3     |    0     |    any    |      0      |      3      |
|     3     |    1     |    <4     |      1      |      2      |
|     3     |    1     |    >=4    |      0      |      3      |
|     3     |    2     |    <8     |      1      |      2      |
|     3     |    2     |    >=8    |      0      |      3      |
|     3     |    3     |    <12    |      1      |      2      |
|     3     |    3     |    >=12   |      0      |      3      |
+-----------+----------+-----------+-------------+-------------+
|  y (>=4)  |    0     |    any    |      0      |      y      |
|  y (>=4)  |    1     |    <4     |      1      |     y-1     |
|  y (>=4)  |    1     |    >=4    |      0      |      y      |
|  y (>=4)  |    2     |    <8     |      1      |     y-1     |
|  y (>=4)  |    2     |    >=8    |      0      |      y      |
|  y (>=4)  |    3     |    <4     |      2      |     y-2     |
|  y (>=4)  |    3     |    <12    |      1      |     y-1     |
|  y (>=4)  |    3     |    >=12   |      0      |      y      |
+===========+==========+===========+=============+=============+

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Co-developed-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>

---
v8:
- Update tcp_options_fit_accecn() to avoid using recursion
---
 net/ipv4/tcp_output.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 560b0ca54bb8..cf1d40e9c0ed 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -876,7 +876,9 @@ static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
 				  int remaining)
 {
 	int size = TCP_ACCECN_MAXSIZE;
+	int sack_blocks_reduce = 0;
 	int max_combine_saving;
+	int rem = remaining;
 
 	if (opts->use_synack_ecn_bytes)
 		max_combine_saving = tcp_synack_options_combine_saving(opts);
@@ -889,14 +891,31 @@ static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
 		if (leftover_size > max_combine_saving)
 			leftover_size = -((4 - leftover_size) & 0x3);
 
-		if (remaining >= size - leftover_size) {
+		if (rem >= size - leftover_size) {
 			size -= leftover_size;
 			break;
+		} else if (opts->num_accecn_fields == required &&
+			   opts->num_sack_blocks > 2 &&
+			   required > 0) {
+			/* Try to fit the option by removing one SACK block */
+			opts->num_sack_blocks--;
+			sack_blocks_reduce++;
+			rem = rem + TCPOLEN_SACK_PERBLOCK;
+
+			opts->num_accecn_fields = TCP_ACCECN_NUMFIELDS;
+			size = TCP_ACCECN_MAXSIZE;
+			continue;
 		}
 
 		opts->num_accecn_fields--;
 		size -= TCPOLEN_ACCECN_PERFIELD;
 	}
+	if (sack_blocks_reduce > 0) {
+		if (opts->num_accecn_fields >= required)
+			size -= sack_blocks_reduce * TCPOLEN_SACK_PERBLOCK;
+		else
+			opts->num_sack_blocks += sack_blocks_reduce;
+	}
 	if (opts->num_accecn_fields < required)
 		return 0;
 
-- 
2.34.1


