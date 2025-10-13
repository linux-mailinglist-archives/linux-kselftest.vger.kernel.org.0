Return-Path: <linux-kselftest+bounces-43008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A36ABD56F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 19:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E9B425482
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 17:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC9A2C032C;
	Mon, 13 Oct 2025 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="keh/8bRu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55A629A9C8;
	Mon, 13 Oct 2025 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375031; cv=fail; b=LHZPhPqopJP1cvcmebDr2nZqjVV3mzOvgldJgrGZYR1baW71zhFPC4dIcnnqlKoaeicE/vkYclZpLv+ZVxiaETOx+EHGcY1QFXnNglsKty72Iu3/homrc/TiZKzPWtJE6uBw53FoHcGNlENGaBZj/qFH60O0LlpZdN0GtH2pWTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375031; c=relaxed/simple;
	bh=xQm8MLa7p2JD9L5oGMf++tNq0TKkUk66QS899RE+6Ws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OtW3kAXdIPSM/FnervPDSzpBvpKgXNLwMwEiaFKi7K/SV6CRzzEKncl3G4h6axNMefK6g706DWWi0h8W97t6+kPhvKOU4bl13mhcWpLm+TUVAoAq0a20Cn54Kyg/RBj2xfTgyjGOY4KPX7/OUXmX2C5OZ+KPc/ZctxMWeq02qYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=keh/8bRu; arc=fail smtp.client-ip=52.101.65.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Riv84SCAR4MWxP+ncNU904z8DYJjKWG993wvjS3s6fpYjTQfHJBzGMKgxnIKXbt9xpbcSeQJw3JcR+0jtjn15gcYGxh3Xjq4aaZ5EVQSkNHWbgvpVRSrqg+/7MW+pxGRz1TM0wnVXENmzc1vIg1YCPafhAcUDBsSqwSvzAIWXW9UItuSI9ov9QLM1TJlglrmy1se2VWCd7djgS5ct/ZUETNd8FRcc8nCD92jLjtImlhqFIJ85jSsrj208YreIwSid3x6418if9KhhDTkKoQFRZoY96Zw8ap0eO220Oeh/X0XZs9MWgDVbrkZhgR4sOvM6lco1NSzbmF3oXz8cKf2rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiqTdhXOq2mMhAnl0NsYURfrTWV+EmIJRwG2vh4irIU=;
 b=QsNazJIUcFVF1lFoTFlUufCqgybgYVaIl/YbEclcE68VZ+p5L+ohqZ5BFGXdcJbqy6AkSeCnl80RPxjpUCaiIM2BpX6/yBjvflt4HAZ3T2F7c5wCzj0eR8/8NPOLxaBiwJ6PdmqTjZd8OagKGi4+PxL+BBuWQ6pD2aj78kaQNE7O4s7mlu4+E67uPu4qjSNkh/zchpDkmRVUwVQ8v7yWRyMTofsrw+da29qMqUHKsWRCTW/kXRfWnFH3egyY0nxz15k14OTP4ZJCpS7jV8ReM9kbxJZP2ftiwraFJ3P4G5ICIFD9PrBKWwM2Cnz8xYu1KPTsxse2/nd/pRMydq4iQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiqTdhXOq2mMhAnl0NsYURfrTWV+EmIJRwG2vh4irIU=;
 b=keh/8bRuZsLjpB9rC6bCExIYPg3QBRi2pe210lXRsu6qMgImG2GSP4Pjz9+RvOWPkUOmtvLCjoVIwPYnMnDk4GZdGlRtQ0HdG/ejCFgDt5A53gWZnwGhCp00MpyQELOc5uKw2sHLEQ6F3Lqftn4LsK49xBzWPOEZKHpP1ikY3Q2FUbNZoCFTG+5/3sTDnl4NFtluaVGFv82Y01BHx9bK+yNPHFvGqVfWh3K9RnUyNrrwvknOqU1XOoZeeGiq5tMa20FYCUy95kVf/t2DbgWvIMdEP0FJCRnhoaGHgO4w3wTzn+4NEeBPhetB8VLGMDiGzgNUCTTiDqcCwqFEL6oVzg==
Received: from DU2PR04CA0027.eurprd04.prod.outlook.com (2603:10a6:10:3b::32)
 by VI1PR0701MB6912.eurprd07.prod.outlook.com (2603:10a6:800:19b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 17:03:45 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:10:3b:cafe::d8) by DU2PR04CA0027.outlook.office365.com
 (2603:10a6:10:3b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.11 via Frontend Transport; Mon,
 13 Oct 2025 17:03:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7 via
 Frontend Transport; Mon, 13 Oct 2025 17:03:44 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id D1C5B1C003A;
	Mon, 13 Oct 2025 20:03:42 +0300 (EEST)
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
Subject: [PATCH v4 net-next 01/13] tcp: try to avoid safer when ACKs are thinned
Date: Mon, 13 Oct 2025 19:03:19 +0200
Message-Id: <20251013170331.63539-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DD:EE_|VI1PR0701MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b144542-c242-4e9a-ce5d-08de0a7a77c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2pnMzhtUk5pR2VZZFFxVmZoWU1SbWd1aSttNEpZdFNpSmVXQzhXQzRFbnRt?=
 =?utf-8?B?V1hmbWV6dkpQbE1NY1ZneWJnOWRXdUNqNVo0aGRQR2NUQllNU2V6b09WMGZa?=
 =?utf-8?B?L1p2R045eHZDeUNJWWlCQVVWK015NFIzWExTMFd6a203NmoyVmRjNlJiK29y?=
 =?utf-8?B?Ly9hTENGK0tVTHE0MWV1MWcrYU01a1pTMDAvQjkwZnMzV1ZTQW1ZTXdGajVP?=
 =?utf-8?B?Z0FwOHVjVU9JdWxmWEpCdlozL3BvTnhuSjYvQlpocDZMdUkwdzArN3dqSU1k?=
 =?utf-8?B?LzhySEpJUFZPVE9UZUU5ekNkZU4wNmRLRE5uWndxK1dmRVJjYmRmRU9hcDNC?=
 =?utf-8?B?TnJ6WUo4T3lsYXZJQUFsdWpTSVVKYVpLUk9nOHRVNHdsTWkveGtpQjcyZThD?=
 =?utf-8?B?N1lrbGNNU1NickFnSEV5VHpBNDczZUIxOUVvT0N6MTNBVGZYdkhKSms3RGRZ?=
 =?utf-8?B?ZXE1MGpJMG1TcmJGWmFpM05OUWJLenVLWkVHMi9FVFVqV2tjTlVHRWZNMTVs?=
 =?utf-8?B?blhqUVVXNXljMGtHVWJaMFU0VjBYQmx3cEpyY2VGVHY2eVZYTmR4dCtOMElu?=
 =?utf-8?B?R2FHWjAwekdWbWw2c1BvRkVpZndnbE5aYSt4NDNneVNwOVZ1UDk0cC9nZ2pH?=
 =?utf-8?B?WTUxSTgwUG1NcGJvSTlrT2dGKzV4cjF4VC93NXZnRmpZOXMrWW5vWVhBbnhF?=
 =?utf-8?B?a0VCTlNVVDViMmdmMU1RdDNaWVZNZHB2TmdWYnE0aURxYlFUL3lGakhzL1FB?=
 =?utf-8?B?MDd1VDArZVFGZXA3QjRvNE84aEN5djF6ZFpWM1ROREFiN2txdTh1YzlCVlFy?=
 =?utf-8?B?Nkgwdzk2NDBNQTZpWlIwaG5RdDBPUlNrY09DMlRNdjVrU0s4cUQ4MlJuanpF?=
 =?utf-8?B?bnUzQlZiWjBFeWlQenJOTUMzNVlNYkt4cnlUbkppMGd1ci9HWlUyNkNMSXYy?=
 =?utf-8?B?dUZmdHpMK21vNDZnazVLcjJPNmd3cVZxWjMxSkRlTDgyWWVZWDc2VGZtaHYr?=
 =?utf-8?B?VDJFd0pxYUJqV3MyUG1Ud3Z0VmVLblI0RzdQc2liUm9QWEFWUHB1eWdGSzY5?=
 =?utf-8?B?aURvWmN1Ujk1SEFYamUzUUlGV1VDQnJYZ0FWTzgxZ29SdUVTWXRpVnoxZU5q?=
 =?utf-8?B?SldPN0pMeWNSYlFjajNUV3BKUytMMkxpSzZ2TzBpNDlSeWt1YjZKMTJ6aHBv?=
 =?utf-8?B?TGRybmloK3BvZmU5V2k5c0g5SGlYVytIT2pjTDl2cHVVdkJNbFVKSi9lMnNJ?=
 =?utf-8?B?dmY5Vm8xNGV1TjJNVjU2SFZUN3BoNERvbmhZMUVQU2dXSVU5MmJDVkEzdDlR?=
 =?utf-8?B?QnExb0J6NUhJdnZCdzRWdldOY0p1WkI2UVNOWGVUTEtrRXArOGFMNEZJOCtJ?=
 =?utf-8?B?Zm5BcE9rUTE4N080emEvRFplSllsZGFGS0oyekYxTVhvYVZuaXlHazVwbGda?=
 =?utf-8?B?TmVrYUlPeVIwOURpUmIwcktHU3hmODZRYU9tdnVSZE5qK3M3ZE8wRlpBUlFh?=
 =?utf-8?B?aGpQTVY2YXpYdlBUWjkraWp3UTd0RUZ6c0RPQXYwT1c0VXZXVnFac1NEeEhw?=
 =?utf-8?B?czlHdk1BaHZmU0kxNk9wbnYvT1hVeDk0cDBsRkRNNW5za20wU1dCdkJYYjBF?=
 =?utf-8?B?andVZmp1TGZCMkp5RWpPM1hKUjRaR2JWdjRieG12TytUS3VGWkhQYzFEVXBl?=
 =?utf-8?B?K3p3MHNQenpWWG1kQlFQR0xKU3RUekN6ME1MeGpwZ2lVSklSaWdpeHk2VWw1?=
 =?utf-8?B?SjdnUmJpcGE3YWRrYlY2SUpMTHU2TG4vYjN6akdXMS9rUXcwbXA0ZXdlVmRi?=
 =?utf-8?B?cjVMU1NkMjNLS0kzMVB0VWY2bzZ0TGVCRUhGU2VvZEVpcmxDYXV2MkhXY1Bj?=
 =?utf-8?B?aFpWVnV1RCtkbjAvbjcrN3ovZXg3c2l5UXdjU3ZqNkxJYVFKWEl0WTdpaldR?=
 =?utf-8?B?eUJXT2FrZWk1VzJrVWFFSGlzbTNjUnBzdzNmN05rUWp3RkxraFRrdXEyV0U0?=
 =?utf-8?B?SUFjcnlGMkYydStmcXRHaXhnK0ZZMzNUdElpUFRha1FZd0lsYy9pd20rUmhi?=
 =?utf-8?B?Nmt2Ym5kUHdJRE1tQVhRaGk5SkxIOU11cWZaLzh2YXRiRENSMWpjWmpUNzhq?=
 =?utf-8?Q?mUjDJICgPAhObMaIxadeendKe?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:03:44.4211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b144542-c242-4e9a-ce5d-08de0a7a77c9
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6912

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
index 8a18aeca7ab0..f68d2ba619d9 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3419,6 +3419,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
+	tp->pkts_acked_ewma = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5180,6 +5181,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rate_interval_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_last_tsecr);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_ecn_bytes);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, pkts_acked_ewma);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, first_tx_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 31ea5af49f2d..8af527f4e2b5 100644
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


