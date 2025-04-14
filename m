Return-Path: <linux-kselftest+bounces-30701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FA6A8817A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89D33B9247
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCF72E62AC;
	Mon, 14 Apr 2025 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="DLVH+yVj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2077.outbound.protection.outlook.com [40.107.105.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7231D2E339D;
	Mon, 14 Apr 2025 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636466; cv=fail; b=NB/H/OAvg54msyJfx7o0O6YViDiEV0femetAsBT3LIeUnQDNrX3H8aKeRGSK/NcRAgPcoHUZRdfjpQi36fwvtw4WWXKw0b2zYvX3P1vs5L4HwKgFrjUxCxWMQA05mI43j07DQ5hf3iwvZa+q5RsTBKDmADu5JNX6IfKYxV/fL8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636466; c=relaxed/simple;
	bh=w4JD0NL/AHwo1JfoAZFre+bdqHcUx1W0DN0F2Zs4Y58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GwZoisd+6UzogpGPhgY301BgvYxOXkuW9qFnMt9RYjgMcTMP5UzTfirjVmHWetSGeGh8lSwkjEuvFTevpDved1fYvqGsh7zHreeXd/84YEyu9yXk/LPsQ5GpNhF9CioSIyS62QJXRa9U+l0nu+jucMstI3g7UhoV5An66rwMyMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=DLVH+yVj; arc=fail smtp.client-ip=40.107.105.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRUMcIWQd0ZbZL53TJ92IhLg+bQ5w5e3+GA9jTX4S8ZsMxtpdLSxcpxCY5AvhgIvvmZs6wa/hwYnjjmWtVvpCd8QbduG7byZXydwh2Z+xxb9uDSB9PipcWwcAF131P8famB0U4dJp7dF0Ck3goeHjyejB1cd6ONYqOENDvSoudLYog1A67Cl5aHL+d1s4L+1EhAOwvmq+pbiWmGasR4rNcDm+sVzEx+VnnXb0pX2G+TDv594sGAP5VUBpuE44bkaQUzfFx99kdgD+kjKKxqe1Gs63nJ5t9wlqMkkJtiQK/oV+OkLe2RzUrZCkOtPYErw3kpC5iClzm08AfnXk7uccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMcrZYM463qpXcRhkrG0+mbXiFQzAPSySth9TyHjelo=;
 b=OXdMfxEC0M9PI692wd0zcK+4QEdmxlzxUmgQEKnei3npbLreGyCp+7qAnuZS5yZaWrWVqhX6c27M4xJ5NIoQglOH1yDHZcIHSFPpK/ekd4DplvGTZ0vhrqbvWYUodnRpyiXVmos6A84BYuGxVJBUXpLwyPkGsVIdt+M/wmheCE2sBYknRI4Q/feXD04XaTKrEkajtnh6DnmO/DW6B0LUMK51ba2oPI8ZHew/K/05xSutLjqdNWtHxdjfBJWXX7Tp9rKKMZlCrICely/w/GMLkjt3JvQVp7C9a4kjHCCX9n+KIscuKZmAu5TNBlgJq4xbKCLSCXoyw7iWTYLavgfqLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMcrZYM463qpXcRhkrG0+mbXiFQzAPSySth9TyHjelo=;
 b=DLVH+yVjvTWUuRbBnMHdRqDvxwaqueVcLAAvIKDntGD8nI5yyicb6bJgX5Q8lpW+fwZ68vDDhBwlhzD6DqA6TWGBbzU6soEdwgMl6sfCLbnSIp+lshXIU0ORJuQxYqcTHxX/rrwfh6QSwhBQw4wdknprf9J1KZ2r/fm4x+0TTPRYeXTOiVBjh/vEW96IaTu0SQvNhOEOpnBCAxK2P7wUz+916B/gOCOJlbXpsMmL9a6BzyHuOxpET9zABGrpXtgPYaR21lXBbtnn4AM230s8HobOsRHGBNQou8RhuIP+btCMrqcarncO/rPUg5gbEnvbG2edIGIsqmqoLpWrdBapsA==
Received: from DB8P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::29)
 by PAXPR07MB8698.eurprd07.prod.outlook.com (2603:10a6:102:244::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 13:14:20 +0000
Received: from DU2PEPF00028D00.eurprd03.prod.outlook.com
 (2603:10a6:10:130:cafe::83) by DB8P191CA0019.outlook.office365.com
 (2603:10a6:10:130::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Mon,
 14 Apr 2025 13:14:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D00.mail.protection.outlook.com (10.167.242.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 13:14:20 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 53EDDQBP009623;
	Mon, 14 Apr 2025 13:14:19 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
        donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net-next 14/15] tcp: accecn: try to fit AccECN option with SACK
Date: Mon, 14 Apr 2025 15:13:14 +0200
Message-Id: <20250414131315.97456-15-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414131315.97456-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250414131315.97456-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D00:EE_|PAXPR07MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: a69231e9-57d3-4ba6-91ea-08dd7b5644c5
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aGhMZTIvVmxKRWJHcFZKZk1zM25jbU04SlBEbUJrVU5iQ1FzQitZUVJLT3Ra?=
 =?utf-8?B?SlQrY1g4bzBvMVF0SHcrb2pyaXZ2YUNHNkV1S1ZBRVdlcUg1WWtDT1ovSi9U?=
 =?utf-8?B?eFpSQU5JRWtPcXBTclhlVVpjNGdIamEvQ0lmTk5oMkxpKzA1ZTBDV0orOHJ0?=
 =?utf-8?B?WFVoQmZyazNmL2EvNXp6amFRV3grbDdvM3dxQStDVDFvaENWQ2tWUmx3SzRH?=
 =?utf-8?B?eHh1ZHIyQXZFS0c4ZUl3K1NKVll3a0o5RFBVUG1qMlpDUEUvNys2cHR5MlB6?=
 =?utf-8?B?U3VVbVgveFl4dWR6SjlVVTZhTU1CRTdubW9SWDlUMDNyeFRoSFRnN2R0SHpP?=
 =?utf-8?B?dDBjN0JGM3pTTGVCeDlIYWE5Ymg2WU1XY2V0d3duQ0hHTjhhRWJBWU9DL0o5?=
 =?utf-8?B?amUxZVp1L0xtNnVNd040ajB2d1Q2VktzRGgxYjVDcXFxTFFMTFVpcXNWMXBP?=
 =?utf-8?B?Z1FwV1Vwd292dGFsTFNxc0NHbU5zWjdyWkRqTTZoYTBhN2NZSDVCcjFvazU1?=
 =?utf-8?B?SkhpVWh3UU9iVitjUmw3OFFlcEJrZzdkTlp3ZlkrRmVwV3BiQ3R6QmNiTXdY?=
 =?utf-8?B?TkN4d2YzT3RySXJ0VE84WS9DV0NSMkVEQXBDSUFVWCsvSUhXQURZYmMxNjdq?=
 =?utf-8?B?bDN2eXljZmNGOXJ2R3cyZFJablp0QVVoVGpJaFV3alozTFFHUE4zWU1RRU5R?=
 =?utf-8?B?c2ZySmd1b1lOanhtUkxNSVpIa3RMbllGM3NjQ2xoQm9PZnJrMzQrdmFldG5a?=
 =?utf-8?B?MjBWaWdza0lWV0NlUjFyS3lNVUNzQ0huRFkxT3pPVFhRYmIwQ2dRdUEwRVN3?=
 =?utf-8?B?bVFRZjR2WUdZbGFRdXdpeW5PM0IvWnRFT2Mrc0pmcktzQVBiVWlUbXFlNkVC?=
 =?utf-8?B?bHNuN1VnRTYxWWFnTnI4WkVMd3g5d1Z5UmRPTVhuU0FRSWRGZ1A2UXFZa2Vo?=
 =?utf-8?B?R0VmcnZ0dmk3cXZnSnFIbGJqNDV6Q3dyamI3akZBaU5YZHpOenQvTDBCSXRO?=
 =?utf-8?B?NExMOFhvdnRITEtkcEFGNjlRR3huUG8vVmQ4WTg0SE1wMXczY0F0SzBpc2Iy?=
 =?utf-8?B?WWQweGdMVVU1Skl1UVFhN1BqQy8zSUtrdzVHWEczZnNUdFQxSS9uNk40QXhv?=
 =?utf-8?B?eDlhZDFuenhwR1JnRnpGeGFObEFFdVNwVk5xLzZ0VENXNmFmaGhoQ2N3c1di?=
 =?utf-8?B?d1RSM2F6cm1xZ2pMN25veEM5ek9rQUpJMXQwU0VFNkJEQzZZN1ZrWDBXQzhj?=
 =?utf-8?B?SjFrQ3RuZFd3Vy9PL1ZqY2lkZ0ZTcXRVblBMelQ3U2FNQVJ1MFpOUmRUbXFI?=
 =?utf-8?B?NDhieWE2QTJUYXcyWmRsZmpNSFlSd2NBcVk2SFpzSXQrYWhlU2VtUzdJNkdo?=
 =?utf-8?B?RzFBSTFDQlB3LzVEMmloL0o1Y3NCYVZGUGdMOFN6ZTJWTTA3aS9nWS93cFFl?=
 =?utf-8?B?UklVQU1zSnM5bUVSTTNQSk5oakZmai9Jd3pkM3lVSDNGTWF2a3hqVkpGK090?=
 =?utf-8?B?WjBkL3FOL1VWSmVldDltaWV2MkwvR3ZCdFNxYTBvMkxRTm9GWW9EblhrVjlm?=
 =?utf-8?B?eWI3QzNMSm1neU16VGFwNnkxYWhkT1prMkp5Y0hFTE81NFdpbTBVODRNcmxG?=
 =?utf-8?B?SEZLbEVyQnFac2ZyVXFpUjZlQTZZWHlqSzhpczdPa205SVJnSVhtOWcwRS95?=
 =?utf-8?B?bUhkZXRnUy9peFNOS1EyeGd3dDIwQ0pMdGkwVWJhekZSTjRyODRYR21pWFFq?=
 =?utf-8?B?NzFCYkgrcUZITkNOUFFDSEVmcTk5clA5YnlFc0hkN1h5OTNMVFBlWGY2L1Er?=
 =?utf-8?B?QnBLM28yOTJQcytZdWd4bE9pUXNUWGdVTysxQ3RSQ2doVThFcXQ2dzZJUjhM?=
 =?utf-8?B?eWh1di9HNmg2Tm5PV3VyUXVmT1BLaXRsUkJ6MEpJUmRsQzA5U085aDNrM3d1?=
 =?utf-8?B?UDNZbWJCbGxjL0ZWUXpEOUczb0JKeFB3UmpJWTMwbjJzSFNDOG41SVlUckw1?=
 =?utf-8?B?a2Q5bHRLZDVNdnNxeVdyU3J5K0hTTS82MDY5dDRkVHA5L01NaDVGbWxBWmI5?=
 =?utf-8?B?S1BmUDB3REFPSlNXb2o2L09vc2diM2xzcXRDdz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:14:20.6743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a69231e9-57d3-4ba6-91ea-08dd7b5644c5
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8698

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


