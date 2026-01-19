Return-Path: <linux-kselftest+bounces-49398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E90D3B678
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0423D309CAF6
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 18:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56C638FF16;
	Mon, 19 Jan 2026 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="X/eokrjR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013004.outbound.protection.outlook.com [40.107.162.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243BE38F927;
	Mon, 19 Jan 2026 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849154; cv=fail; b=oO1XxoVk5hAELoxIVuqSqSTBeK1d1tzGo0taSdeZUSGUeEL0kr0DNcJFw9JZ2xRd0lzXQkxZd25ImdypQELODwqHWEWIZCzCE/Id/3s/tbDlJ0RHETfHWzLVQdA+SPGtU5YW9nzU+CtK4y2OL6q9+sLpYk2sy6AYdF2tL1otRFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849154; c=relaxed/simple;
	bh=OHHkFeNl2UdpsrxjHJsWEqXL3NzzfIRytrxFJ0ro3Ds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PSGQUj7ivrKijKjf4diib549GuG/lT08yq5vzd2Nh1Tuopi8MCKFKb3IISas1Pq8oBF2jorylMuaBxQ2xgIkcRrHycXYXtwdNRqw+pvt/qKuz3Px15saaMPkOOQMIDMVBv469SmAzE78RnYtvlIYnooHIHih5j42I5RJX0qQ0QM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=X/eokrjR; arc=fail smtp.client-ip=40.107.162.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOHXAXKS/TRdXQ5Bq3vJbh5QhfDdvYO8mSLN+h3rZKaPoVjwkQpsTWk/DNjHpQ2SHQ/wVIRBiePjZvCN371xJqM3sZEhU3oK6x23XNFe7aKe+HZLrNEg4mnSM7KM5NdLEvEaMuKr3RmV/fTcVsdOkFTx3ySGeyFOcyxWLOgPnOtfmiBA+WgbAwtdcrhUYRtDv23Y0EtwpWPjgaoYGsyuhIfs5TBdasMyBiU6AbYtX8WfbJu2Kk360qNMUeFn9Aje9Kq3oiiDyin9/4XzFTaBc4Ni0qcnasaeRb8lclEkypJm52/tQteez+tAv/US75jZUBhUH1qx6JbaG94ms+1M3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SL7WHvBlae7awX9LYbV/+CaNFPmWSLfdygJadqV/MJU=;
 b=jmOa+5t94eUCGFJhvDpyMQe2hDbDuI0F6SD1NAjG93QUUjtrn/g9EdJlAsKaSluUwj9qp5x/UEE1Tr++Khv/b4aGTbCQ4CvJTLLDgEZthCFdbdSbKbVYp3NoWM/DSD3uBmQk502RmvdRipvWPXkPQoYOpg6HG/mBlNp1eJIEH/6h1ILqreucLBeq8TMDb11lS7iRmxRaTKXkDMA151g3kujU6i+bNMCyCVmxaDncykrSoyAKXfeFXzMM8lXv2tlWnBhu2R7Nk/zQo7kwQ3w+8mMWewWQlupPjtcVUDWHpjzJgIK3lyX7hLG8P+URMSAS/BKCuCU2zq2rAJmy3yEjLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SL7WHvBlae7awX9LYbV/+CaNFPmWSLfdygJadqV/MJU=;
 b=X/eokrjRDx13uuHOxPGbaPoZmT2N0oyPcX25IB1XS1Z+qo3/eOZalXAq7zVfqoiqHdZ0oHncKVKIf7ti4rlBG8JtsQo/qMZJ5u9oIucJ41VtUAlbxFxgtvyKGjmsLh+CzUuhmlJDlI60hIFeZRRiLEjR5W25PcbPG7g2zZ6FYi3ZhzEfl/yodSnVQxZwmJAyui/ZlHDY2UooWvn+Tf0yq2bSfdsF5qoQAXX8aNs9WF91FQMZA5T9SnwCV37J6ZzCZOrCDeoZtpNYj2StZEG8mHRc3G8DTS26dPPs9Kxy7JPwvHE9+7LnYXO5vC0gxbnPL0I/FA8wo79iOwq/hlimqg==
Received: from DU2PR04CA0233.eurprd04.prod.outlook.com (2603:10a6:10:2b1::28)
 by DU4PR07MB10323.eurprd07.prod.outlook.com (2603:10a6:10:5cd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 18:59:04 +0000
Received: from DU6PEPF00009527.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::4f) by DU2PR04CA0233.outlook.office365.com
 (2603:10a6:10:2b1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 18:58:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU6PEPF00009527.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4 via
 Frontend Transport; Mon, 19 Jan 2026 18:59:03 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 507C3200E6;
	Mon, 19 Jan 2026 20:59:02 +0200 (EET)
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
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Olivier Tilmans <olivier.tilmans@nokia.com>
Subject: [PATCH v9 net-next 04/15] tcp: ECT_1_NEGOTIATION and NEEDS_ACCECN identifiers
Date: Mon, 19 Jan 2026 19:58:41 +0100
Message-Id: <20260119185852.11168-5-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009527:EE_|DU4PR07MB10323:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc48587-f360-4bb8-3675-08de578cd099
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NTdOeGpUdFd2OHRORVJSZlgxQWFXQzN0Q1pIS1BNUzFpOG9SVWlXQTZwS296?=
 =?utf-8?B?QzVrMWdmWHJqRm1HNk8wQVVjbmJCWGgvbmx2cExYZHN2dFRwdE1TQmVidFFN?=
 =?utf-8?B?QzBzdTBmM2FpZFNPTFhYc0xGa2FqT2tvYlhsQ25VUnhENDl3VmY3c2xxOXJU?=
 =?utf-8?B?d0NSUzNpY3VqSXZHaEJ6c0d1OUJBbnhrRlJHL2lCVkl5YnlwaUtKZXF0Skpa?=
 =?utf-8?B?UGlLV1prWlpvd2N5U0lNQ3JhcEVxT3pTa2ZKS2cyVWVkU1FIanI1Y3d5U1BP?=
 =?utf-8?B?L0h0SS95S0tOVDI4YzVGb3Y0dnVSQ3BDM0ZFRmUvRlFtQ2ljd3FydXFUUk12?=
 =?utf-8?B?NklHdVpKekcyUUU4WEpuTVJxcVBiUE92dWxqamYrMTRSWndZMTZRa1p2cFcy?=
 =?utf-8?B?VnFaWXVrOXByK0JJbUxYOFJKY1pFazRwVHMvQ3VLbFl2d1J1aytUTFQ4R2tm?=
 =?utf-8?B?TVVQUnlDTGNOQmp6VkdXVTJiNXovK0J4M3N5cEo0QmNsYTNSYXA2RjF6ZTBN?=
 =?utf-8?B?RitQa216QzZ4RVBOWkJhNVJWNWlDYjZ2eDkyWHZSZVRia1dUOUMrdUh4TDhv?=
 =?utf-8?B?S3FtNmdLOEV3c1BOZ1J1SS8wTi9aWlduVHk5MHF6QnpFbnNPdTB5YjFKT2ox?=
 =?utf-8?B?WkFYekZpb1NSWGRZdFNQNTY0MUNVQmFJN0lvcVRLQUFqUVZhNlVnVEtMbDZJ?=
 =?utf-8?B?dGM2ZEFWZ0V1UzRZLzQ2d0Jsb2FZQXN6NU01TDdpWDFOc2VheC9BajlqZmt4?=
 =?utf-8?B?a3U0ZXpGSVB3VnZ1NjJrdzlRU1JOWlN6REdmZTBuRW9FVm9nbHlweTVmZjFV?=
 =?utf-8?B?aERBemt1eGRnaXZPcFZ0OUcvbVJuVXFvenJQdEZBNm9MS0U0akJsTUVJYmpz?=
 =?utf-8?B?UFZmNU13aWEzVVZ2d0xPV0NOcXlIZ2Mxd25yUk9XemMzVlRLc1RQelcyQWFR?=
 =?utf-8?B?TTluS3B6Qmt1aldiYVZvcDAwbTJiSEFOM29FWnQ2cDAzUWk0OUdqQk8zcWxY?=
 =?utf-8?B?blJTVFhidXNNQzEydXhqa2grdUhtYVZIdmsxOFp6aVlRaHEyaFJuRnowQ3ln?=
 =?utf-8?B?MElLUUtCcVZKT2ZUa2dXVy9uR0gxNDczdlNFM1VEU2pHRkRXZkd5VC9FdGhT?=
 =?utf-8?B?TEtlV3dtQ1lMVXdtanVtUFFESVFISDJzVFRDTHczNmdROWRBZGlCSmZXdWJP?=
 =?utf-8?B?bVI0NVNMdGpCVU4xSUFBMlp6dEduVXhjTDNmN1ZNTWJWc3F1bHp4RXNXaXBm?=
 =?utf-8?B?dUJTMGZZZzJRcFg3MDRIZzRDL0l5bmVLeXNTZC9QdHc2UkJUVXExcGxlaFA3?=
 =?utf-8?B?cG1JbkVvOEhHVkxoeFJOQ0xqUzBWVDRVL2VYVjI3OVFTaE1YVVFVZW1idE9J?=
 =?utf-8?B?dTNTRmlWMkpSaUJDL2NjTFFGT1ZTM1VOZ2FFZGw4bjZ4ZDhxQXIvSyt2TlRV?=
 =?utf-8?B?MEh4ZzFnLzFodGFjczg2Z01aT0tVNEpXNUp2OStoZW5MRkY0MmNYTXFLWEI1?=
 =?utf-8?B?Q1Q0L3RwdlFhRHNJQUpNSFkzZ1EvL0FtVFRsbWdDdlpZbHQvay9Pam5xcVMv?=
 =?utf-8?B?aUlzQVNnVHZUUXZDc0RyUktBWTVuVGxjQVFldW0wNWNwVW5XY1NJWkpyek1M?=
 =?utf-8?B?ZmlLUjRBYlEyZ1N3NUZvL00yTzEzOW80eStQdlVrSlN4dkZlWW9zRm4xcUFC?=
 =?utf-8?B?OFMwL0xFdUpRQkFNcDAxK3ZBOTJIQ29SdWRtOXNGQTd1eThuN0hqejFnd0hO?=
 =?utf-8?B?SnUxaTM4RWJLeXc5aHFOMmUzNHJ2TkwrYXZaNmw1d0h6MjFQWGs1R2FIMmto?=
 =?utf-8?B?Zmt2ampIRW9admF4OHZDSWJyckVEYjF4TytsaldiVjJ5K2RsaXZDN3QxQWFI?=
 =?utf-8?B?SFYvZXZuajR5VWw1dHFValBJNFR1MlUweUZiQlhVbVlqeFFWcTFCc0xNR2tZ?=
 =?utf-8?B?ek8xd3NuRWZMck9CUHF1a0UwODFiMGJESy9reUF6N2FWaXhtNkU2SHVLYk5s?=
 =?utf-8?B?V3hETWxQWkFBR2hsaUlzdlk4bVJsNm5abGhTVTQza0w0VVJOMUpTQm83UTM5?=
 =?utf-8?B?SWpkb25xMkRLaDJkSVZXdTEvb0txWkRLTU5QOGRST21mcGtZM3hBRWsvV3dm?=
 =?utf-8?B?cXJOa2pqbmF5WDB5RmY2a0tQbGpZeXZlSE0wYXhXUzZmVXdNczVPcnI1cnRY?=
 =?utf-8?B?ZHRDRHZnK1lQYlJwTkRQbURWUGlDQnlSbVpLc2lPNzEvOENOQWZtN3hFeWtK?=
 =?utf-8?Q?I2cJN0j32NH2XnDSYmBF1guG59DxQIBf3fU4OWM29o=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:59:03.8985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc48587-f360-4bb8-3675-08de578cd099
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF00009527.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB10323

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Two CA module flags are added in this patch related to AccECN negotiation.
First, a new CA module flag (TCP_CONG_NEEDS_ACCECN) defines that the CA
expects to negotiate AccECN functionality using the ECE, CWR and AE flags
in the TCP header.

Second, during ECN negotiation, ECT(0) in the IP header is used. This patch
enables CA to control whether ECT(0) or ECT(1) should be used on a per-segment
basis. A new flag (TCP_CONG_ECT_1_NEGOTIATION) defines the expected ECT value
in the IP header by the CA when not-yet initialized for the connection.

The detailed AccECN negotiaotn during the 3WHS can be found in the AccECN spec:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v6:
- Rename TCP_CONG_WANTS_ECT_1 to TCP_CONG_ECT_1_NEGOTIATION to distinguish
  it from TCP_CONG_ECT_1_ESTABLISH.
- Move TCP_CONG_ECT_1_ESTABLISH to latter TCP Prague patch series.

v3:
- Change TCP_CONG_WANTS_ECT_1 into individual flag.
- Add helper function INET_ECN_xmit_wants_ect_1().
---
 include/net/inet_ecn.h | 20 +++++++++++++++++---
 include/net/tcp.h      | 21 ++++++++++++++++++++-
 include/net/tcp_ecn.h  | 13 ++++++++++---
 net/ipv4/tcp_cong.c    |  5 +++--
 net/ipv4/tcp_input.c   |  3 ++-
 5 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/include/net/inet_ecn.h b/include/net/inet_ecn.h
index ea32393464a2..827b87a95dab 100644
--- a/include/net/inet_ecn.h
+++ b/include/net/inet_ecn.h
@@ -51,11 +51,25 @@ static inline __u8 INET_ECN_encapsulate(__u8 outer, __u8 inner)
 	return outer;
 }
 
+/* Apply either ECT(0) or ECT(1) */
+static inline void __INET_ECN_xmit(struct sock *sk, bool use_ect_1)
+{
+	__u8 ect = use_ect_1 ? INET_ECN_ECT_1 : INET_ECN_ECT_0;
+
+	/* Mask the complete byte in case the connection alternates between
+	 * ECT(0) and ECT(1).
+	 */
+	inet_sk(sk)->tos &= ~INET_ECN_MASK;
+	inet_sk(sk)->tos |= ect;
+	if (inet6_sk(sk)) {
+		inet6_sk(sk)->tclass &= ~INET_ECN_MASK;
+		inet6_sk(sk)->tclass |= ect;
+	}
+}
+
 static inline void INET_ECN_xmit(struct sock *sk)
 {
-	inet_sk(sk)->tos |= INET_ECN_ECT_0;
-	if (inet6_sk(sk) != NULL)
-		inet6_sk(sk)->tclass |= INET_ECN_ECT_0;
+	__INET_ECN_xmit(sk, false);
 }
 
 static inline void INET_ECN_dontxmit(struct sock *sk)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 15f9b20f851f..41c781b6fff7 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1203,7 +1203,12 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CONG_NON_RESTRICTED		BIT(0)
 /* Requires ECN/ECT set on all packets */
 #define TCP_CONG_NEEDS_ECN		BIT(1)
-#define TCP_CONG_MASK	(TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN)
+/* Require successfully negotiated AccECN capability */
+#define TCP_CONG_NEEDS_ACCECN		BIT(2)
+/* Use ECT(1) instead of ECT(0) while the CA is uninitialized */
+#define TCP_CONG_ECT_1_NEGOTIATION	BIT(3)
+#define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
+			TCP_CONG_NEEDS_ACCECN | TCP_CONG_ECT_1_NEGOTIATION)
 
 union tcp_cc_info;
 
@@ -1344,6 +1349,20 @@ static inline bool tcp_ca_needs_ecn(const struct sock *sk)
 	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
 }
 
+static inline bool tcp_ca_needs_accecn(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ACCECN;
+}
+
+static inline bool tcp_ca_ect_1_negotiation(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_ECT_1_NEGOTIATION;
+}
+
 static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index f13e5cd2b1ac..fdde1c342b35 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -31,6 +31,12 @@ enum tcp_accecn_option {
 	TCP_ACCECN_OPTION_FULL = 2,
 };
 
+/* Apply either ECT(0) or ECT(1) based on TCP_CONG_ECT_1_NEGOTIATION flag */
+static inline void INET_ECN_xmit_ect_1_negotiation(struct sock *sk)
+{
+	__INET_ECN_xmit(sk, tcp_ca_ect_1_negotiation(sk));
+}
+
 static inline void tcp_ecn_queue_cwr(struct tcp_sock *tp)
 {
 	/* Do not set CWR if in AccECN mode! */
@@ -561,7 +567,7 @@ static inline void tcp_ecn_send_synack(struct sock *sk, struct sk_buff *skb)
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ECE;
 	else if (tcp_ca_needs_ecn(sk) ||
 		 tcp_bpf_ca_needs_ecn(sk))
-		INET_ECN_xmit(sk);
+		INET_ECN_xmit_ect_1_negotiation(sk);
 
 	if (tp->ecn_flags & TCP_ECN_MODE_ACCECN) {
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ACE;
@@ -579,7 +585,8 @@ static inline void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 	bool use_ecn, use_accecn;
 	u8 tcp_ecn = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn);
 
-	use_accecn = tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ACCECN;
+	use_accecn = tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ACCECN ||
+		     tcp_ca_needs_accecn(sk);
 	use_ecn = tcp_ecn == TCP_ECN_IN_ECN_OUT_ECN ||
 		  tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ECN ||
 		  tcp_ca_needs_ecn(sk) || bpf_needs_ecn || use_accecn;
@@ -595,7 +602,7 @@ static inline void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 
 	if (use_ecn) {
 		if (tcp_ca_needs_ecn(sk) || bpf_needs_ecn)
-			INET_ECN_xmit(sk);
+			INET_ECN_xmit_ect_1_negotiation(sk);
 
 		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
 		if (use_accecn) {
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index df758adbb445..e9f6c77e0631 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -16,6 +16,7 @@
 #include <linux/gfp.h>
 #include <linux/jhash.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <trace/events/tcp.h>
 
 static DEFINE_SPINLOCK(tcp_cong_list_lock);
@@ -227,7 +228,7 @@ void tcp_assign_congestion_control(struct sock *sk)
 
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 	if (ca->flags & TCP_CONG_NEEDS_ECN)
-		INET_ECN_xmit(sk);
+		INET_ECN_xmit_ect_1_negotiation(sk);
 	else
 		INET_ECN_dontxmit(sk);
 }
@@ -257,7 +258,7 @@ static void tcp_reinit_congestion_control(struct sock *sk,
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 
 	if (ca->flags & TCP_CONG_NEEDS_ECN)
-		INET_ECN_xmit(sk);
+		INET_ECN_xmit_ect_1_negotiation(sk);
 	else
 		INET_ECN_dontxmit(sk);
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8e95a4e302f4..ccbab5569680 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7266,7 +7266,8 @@ static void tcp_ecn_create_request(struct request_sock *req,
 	u32 ecn_ok_dst;
 
 	if (tcp_accecn_syn_requested(th) &&
-	    READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3) {
+	    (READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3 ||
+	     tcp_ca_needs_accecn(listen_sk))) {
 		inet_rsk(req)->ecn_ok = 1;
 		tcp_rsk(req)->accecn_ok = 1;
 		tcp_rsk(req)->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
-- 
2.34.1


