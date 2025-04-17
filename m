Return-Path: <linux-kselftest+bounces-31099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEAEA92D9D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 01:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F100A3B44F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 23:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C33C22423F;
	Thu, 17 Apr 2025 23:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="lF+Wibzw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2054.outbound.protection.outlook.com [40.107.104.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF16D21D59A;
	Thu, 17 Apr 2025 23:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930890; cv=fail; b=PsZoU6+FKq7yMEv4lBC/aMUJB+4T2xezk2nAs86QnzUre9k0paD0hzFjwHjZeWzbJYfl89WLOQeXLt95/nRJSoE8/O1ld4V3nU8jXug93aKxyN83b2SYKT5w1KkFG/SgBVq/G9ENiwqke4hPHp8bWkwQMQwwtynzCx/9zFhu+Fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930890; c=relaxed/simple;
	bh=w4JD0NL/AHwo1JfoAZFre+bdqHcUx1W0DN0F2Zs4Y58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tukEO4gc/aLO+cEFPQMYLDZ1X+0jCK6psMV1jqCwSxF35SsV24PlSuc2PAypXpgKpjNhaxT6hOLloJ8eenwUV+iDZ3XIcQFup3wrJV50FVn9jWiHP++ps716RK8OBS4OTJCABBx0ZS3sCmKWI3OGJSqjzDudLzGaKQi+I5L3NVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=lF+Wibzw; arc=fail smtp.client-ip=40.107.104.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xndJriWRktS3zHXGAhUSqm1YqkTsGDIQPxw9oLkmuonZe4Suy1vorvUjn7MbWP0f/9HvqMizATWU0Cx4zpo3M83SLX50ZfrFfrwO+OEgunvKTythct7B4y4NkPjdpURn9uUZezMDvBoyrauUOvBvcW4YeoHg73ZsgEEEFJGwFFp8i2LmXumkxPBgLuc/WXEzzpt5G2o0h3cS8XdTdfmf1FhnzDTNap4xxfW14O2Hj5yzV8Bfzhi5AfO+i2QAierbMzf2h2wtEThtu5mIkVU9embOQVrUItepKM1dB0XmOcOwVJ6+M8SXJlZabBEaJFlyEVmPwVHKdQjFPM6pkIETUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMcrZYM463qpXcRhkrG0+mbXiFQzAPSySth9TyHjelo=;
 b=l3wQOJ7XSsh7zot1VFptTTGMNfRFtnqO0/mDpTWTdVRwt3dNCdTp8XFLzXOMlHcqFkGRIvVFowVBm4brmurqW1HvO0wDQfAdEa6hKyqy2psr8dbrEpSQUub3ao6jOKmD/HWNR+RdV+pY7lS4KxC3kohAkAJstn+ftgKzeeGLtDqRkh0wCCln/Kv8P83c5xLeoybqEI74TpgxZXO0FVb8NH+fRk92ImWi1fPUH6QXvejO+aAmxkThxkeMHJ/9Eklly6AT5Uunm+LO8flkp6VK0jshCRHHVyD3KwvYJnvBrsQzwWZd0xth87EWZHAPNovpaY5ngu2n4J+BvWSk7TpQcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMcrZYM463qpXcRhkrG0+mbXiFQzAPSySth9TyHjelo=;
 b=lF+WibzwQOQ1TrPSDSTru4JtuhhTQqj7lIs499/3g0+TYOvUTlomNeZ55XQtqq9wwhl3mEUbUJpdFrgw3f3193nmg1fNIbRFuSGNcQOWJGjv7UMBl8qkVNWMc/9yKmoUeyJI79SmSWpMAnfVgoWLaITDcA4g43LiG4Ow9p0eLCl8lYrhzNSuemcqT9ed0pv7TU0J6t8QW+YC3GGwhPEf56rPUB7PVYrOobNUDWZ5QRkytYkDdNETsRQV0OG696C02h2CkumNLMjhCwT7v2dtmYL011/+akTbJqkm/Ls4wfefDf8P1t7TztJ1NBojiUK+ptjj/It/IuxsRU2wr+wwwQ==
Received: from AS4PR09CA0001.eurprd09.prod.outlook.com (2603:10a6:20b:5e0::7)
 by DB9PR07MB9833.eurprd07.prod.outlook.com (2603:10a6:10:4ee::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Thu, 17 Apr
 2025 23:01:24 +0000
Received: from AM2PEPF0001C70B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e0:cafe::47) by AS4PR09CA0001.outlook.office365.com
 (2603:10a6:20b:5e0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.18 via Frontend Transport; Thu,
 17 Apr 2025 23:01:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 AM2PEPF0001C70B.mail.protection.outlook.com (10.167.16.199) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Thu, 17 Apr 2025 23:01:24 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 50D7120824;
	Fri, 18 Apr 2025 02:01:23 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: dsahern@kernel.org,
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
	horms@kernel.org,
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
Subject: [PATCH v4 net-next 14/15] tcp: accecn: try to fit AccECN option with SACK
Date: Fri, 18 Apr 2025 01:00:28 +0200
Message-Id: <20250417230029.21905-15-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417230029.21905-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250417230029.21905-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70B:EE_|DB9PR07MB9833:EE_
X-MS-Office365-Filtering-Correlation-Id: 867eab0a-ae57-460d-a11f-08dd7e03c71a
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?eWg4TktSMkdTOWFpM0VWejhqcWVEdmpnNVpsUWRRVVIvMjh0UUxYUVE0WW9l?=
 =?utf-8?B?NEJ1NTFTNWpCRDlIRmhjNEp3NXJ0MlpEd3g4eGFhN3NyZGxzdGg5c0JYbjhi?=
 =?utf-8?B?TXAyYS9JbmNwZld1TFhmTy9tY1hjSlhGT1Q0YzFwRno0SHY4a1IxL1dyZXNY?=
 =?utf-8?B?WmU4TlNjMEVWd3lqcTFiMjh1Ky93SG1IZHhBQTNTZm14bFJUci9MS2tKRERO?=
 =?utf-8?B?dXh2WVdyODBuK0o5dkVGeDc4WS9kN0FZMThvOGVXYmVlZ2JwT29YREE2UDFE?=
 =?utf-8?B?ZEsweCtoMEpjOWRidkxyQlFKbkRaUmNMM2EyZ0hZM01VZE42TEE0UzRkeWw0?=
 =?utf-8?B?VU5CblRZNEVudEh5U0RMOExvNjZ4WDdlL0Z0c0w1T25KWFJPcGhBQ01QaHdE?=
 =?utf-8?B?U20xUnM4ejV2Vm1WODRUaGpXaGZYYkIycks4UXA3WE15aHg5Q2I3eWw1MmpX?=
 =?utf-8?B?YWdZUHNnY3Y5QXIvL2RHbm50QzRULytQbTB4SUFnQ3JxSDBLMkxMSG5TSEdR?=
 =?utf-8?B?OStrSkpwMWlmd053OGhhcWVyR0hkZFdSMSszMjF3SitVYlRubjJ4bTIrNmVt?=
 =?utf-8?B?Vzg0Y1ZUQ2I5aFhYTUkreVFKbWtjUHk2ckxnY1RhS24zbE9YbTB1SnBBOXVu?=
 =?utf-8?B?T0hwREVOaFNhbHNsWWszNW93TU1RUDk1d0pwa1h2anJxZE10dTM4YlhkekhK?=
 =?utf-8?B?Tk1uNkpTVS8vNytjdEZGVTF4M2ZqVExHSE1UMlBBaXNjcFg5R29XV08yeS9T?=
 =?utf-8?B?RmtqYTRFekxCdEFQdUY3WmUyQS9CVmorYWk1c3QwUGpCdlRBRFhVeHRtaW12?=
 =?utf-8?B?OG5DN2FycXY0Rk5HTFlKQjRtdGEzQ0VXd0lVNXVxQXpiTStxc3IyTmRuMFhC?=
 =?utf-8?B?aE9qVVl6dmZSWm5vdEdvbnYreExOcmo4NHdwU0o0bGJ0bGVwVndFNnE1REQ1?=
 =?utf-8?B?S1FqdTI3WGdPeC9yckxvN0F4Q3p2bWlXVXpLUFU4RWNPY2sxRDNYdHJQekNl?=
 =?utf-8?B?YitMMWpKYWZGNWkyNCtMbzdPSTR2dkpuMFRzSG0xKzkxUEdpeTlyaFRHTVBM?=
 =?utf-8?B?L1J5d2FqQ3M4NXQrOWFtdVk0K0JIS3VlWGRPN3JWd3BjVlRwaVVOWG1QMUI1?=
 =?utf-8?B?L0dqQmZoa0lSRHd4TUg3aVlFRGdYL0hRM29ZWEtLNnNPclNTSDEzdDUvSFI1?=
 =?utf-8?B?eVNRU2RzTW03ekdLVEJzT2hTN0svdWhxaFBhWVp1VDJNbUZ1QlFEUGR0eVhj?=
 =?utf-8?B?OXZWbU5nejNQSk5RZ2FyWXRYTUFCMzhLc0FFZVBhOHE1ZFd1K3l1Ti9mbnV6?=
 =?utf-8?B?MlZvZVlxRTgzSURYczYwdGJ6R2RIazB3TkRCZFVxVWEwcU5EVy9YeHBCcWRP?=
 =?utf-8?B?QUR3dy9XUVpBWjhmZXQ5Yk9jOVlyM0FweGhJVmluZlFBbVhDeUpja0RCZ1Y4?=
 =?utf-8?B?MnlXeC9sL25yeWg3WjA4aHZRV1dRSXdRd2JXdmhzK09ybTFhMy9IalNVb3Nk?=
 =?utf-8?B?NXExRjFwOFVMaFgvS3I0WW5oL1V6OEd0L3plNm5tdmI2b3JvYWNCMURkNTdj?=
 =?utf-8?B?cUM0dmRnK2xmcE9mVTh0SW1sTytSd2hkOEZYeXJubHozays3bWM4ME4wZ0pp?=
 =?utf-8?B?NmlwVDdXVmVlT1Q1UmQ5WnNjNHFleWlHN3F1OGdOVVd3STA5Z2d1L3pPYjRr?=
 =?utf-8?B?dUw5Vm1wcDk5MGZidDF0cjFnSEdEQTV1UFBENVpEZXIyRGRvRG4zOVN3SjVK?=
 =?utf-8?B?aU91Slk5dWFiNkZqRFJ0cTJRbGFJa0UyTnFoZ1NrTno2eldiMHFiVHRwcXR2?=
 =?utf-8?B?VTU0MGZjVXJvSll1clJ6UWtldW1jSFlRVjNEYnovYUphSEV2QU9DMVJ2TDdk?=
 =?utf-8?B?WjRKMXpKYmJNVDJpeStHUW5VNExuelRHSTVSc0RNdTNNZWE2TDhTVThEa2lk?=
 =?utf-8?B?UFF2MDJnV2I2OWdEV2U3UGhsUVhUa3NVSGpwcnV3TmxsU2wwd2hQYWhUT1VE?=
 =?utf-8?B?OTVSZTh1TDVpM0U3bFhEYWplNFR6aHFSVzNhUmNhaDJQWUxTZS9lcXgzUEp4?=
 =?utf-8?B?ci9LaFVzNVAwSlJ6eHRFbmFSejk0WnkvWFNPdz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 23:01:24.6422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 867eab0a-ae57-460d-a11f-08dd7e03c71a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9833

From: Ilpo Järvinen <ij@kernel.org>

As SACK blocks tend to eat all option space when there are
many holes, it is useful to compromise on sending many SACK
blocks in every ACK and try to fit AccECN option there
by reduction the number of SACK blocks. But never go below
two SACK blocks because of AccECN option.

As AccECN option is often not put to every ACK, the space
hijack is usually only temporary.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_output.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 8e1535635aab..936ec8788c8e 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -981,8 +981,21 @@ static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
 		opts->num_accecn_fields--;
 		size -= TCPOLEN_ACCECN_PERFIELD;
 	}
-	if (opts->num_accecn_fields < required)
+	if (opts->num_accecn_fields < required) {
+		if (opts->num_sack_blocks > 2) {
+			/* Try to fit the option by removing one SACK block */
+			opts->num_sack_blocks--;
+			size = tcp_options_fit_accecn(opts, required,
+						      remaining +
+						      TCPOLEN_SACK_PERBLOCK,
+						      max_combine_saving);
+			if (opts->options & OPTION_ACCECN)
+				return size - TCPOLEN_SACK_PERBLOCK;
+
+			opts->num_sack_blocks++;
+		}
 		return 0;
+	}
 
 	opts->options |= OPTION_ACCECN;
 	return size;
-- 
2.34.1


