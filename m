Return-Path: <linux-kselftest+bounces-29294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF719A663B5
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D423AF036
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 00:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC0B76026;
	Tue, 18 Mar 2025 00:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="SG1C8Wf+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2044.outbound.protection.outlook.com [40.107.249.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356C313B2A4;
	Tue, 18 Mar 2025 00:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257680; cv=fail; b=CYFEk0CZn5xacI2rfCaZsFpVKL4Wj4gpWeYkSveU757U8OduOhVlH3wC9nHP1wL/iLKRhT2QT5InyamGMronXcR6TdOZua9rJa4zLAnFkvEqflMjB0f3AReAbk0mI2WVcRfE5MNeWZz+iMbcyMHEkcTSvvsENliQfJshQjWomb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257680; c=relaxed/simple;
	bh=sWqYAXfDGe5jiofS64w54a1k3338zORsmWSgQdXHs4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DjKc7NSn3QHo2vow2ihhd30SEw3SZTYXQzLJIbe+CuALivmR/uQX9PcdDfuihzxn+663CP2H9GA++IZKxu/NmVMjfxhkRJRkWW/kr50NpMNJkbdtU5KNj6JW51W9dOw8mFmt4dZMJDg2hoPrhjQT7iXGhyM6239icj5kgGS8vhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=SG1C8Wf+; arc=fail smtp.client-ip=40.107.249.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaeK7k6Z1bZ50K6URAnLIauf//jiQsS6YVptoZT6YvteIfPmRIg9sq3gGmHCfwaEd/cMSGHyiqvK+/prFQhskaDHrCC84iXHB9SVmgGEJEwLBfkK8tIJ+ef4bRO/2XFqBAYTmLmQw72KSFQuf13lrKCddJ2nf/Ng3fvSrckl7ddne4zZcVITs0Hf5LAKlotOyCxsh/eNz0KxNwgj4+ewoDZqTt6xCIr0NwD8UNCIYGjCLuakM2Ta9ZVXQomty96mjRG/7D3sPykA2LsAkLRFeEtbsfhkhqntfa7pMioEqZytUM27Z5dtnJX4CdxOEe9bpS1Yz4wg2lg7b6i913yXkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsEuFaE4xxb9J5cMRIB94+9EU7jYsAI9Fz9C19CcU94=;
 b=g+5gJqsA+MLsWzFSzbLO1zFzgAN+fP56VYk54N/mcKy/9NsxBr4XnNsv0KlNylGLBgytAP1JdAnyjlZSaNdnndQuGY+VxKXKhDQCX15A+CHrWnKDQxsE3TmejW4T2Z2fG4TYmjjmok8a/991aA43Rp2u8BH7XgFQMMyhcaXKAh8DEGxwRbjEz7Ia4OB/zSvLTzDDKiyIvpkAbmW3dlmYoG6eU6lC3Q4dT0xD8eiF3UehkBAwPBzpb9RVX8O09RvsbnasVM9apFyu6S8IzY6snoMbk5BT1TgfeV2zIp9VrJM1Xh8t9Ci3lKUxpG0SN/l4Dql/TWNvx3VU+Y+eNpQr2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsEuFaE4xxb9J5cMRIB94+9EU7jYsAI9Fz9C19CcU94=;
 b=SG1C8Wf+1pTlTMUpGb+h4Mw8ZMg5pdgT3drP1tNHKyHtbrphhTqHSX5spR1ye7KztAEqO6BAKPQBGjNzzEDzRu9PVJBSuXHfrZ9OKSfjoJbj6fKNmTEAYdSpZstaI257XizSwFIvmJFGSnu7uq/nN4VSkxfpBsLsKs9D6DySGGbkCgZLOx3AZ/vBtB4v3DeBaZ6F4231Cx3P1/Y9zrx75uF/DvzdCMbtZGn+lL/XF5Wo5hbg3lkkS1D4BPo3w1ZUHmW6cxo9iJEcBaReOtEVa1eyVMFqSNVguA0LBir0sQX3lRNYUqThA4pFi3TqJlxsXvq7voS33mJBDWuGsLfujw==
Received: from PA7P264CA0260.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:375::15)
 by DU0PR07MB9292.eurprd07.prod.outlook.com (2603:10a6:10:44c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 00:27:54 +0000
Received: from AM1PEPF000252E0.eurprd07.prod.outlook.com
 (2603:10a6:102:375:cafe::f) by PA7P264CA0260.outlook.office365.com
 (2603:10a6:102:375::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 00:27:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM1PEPF000252E0.mail.protection.outlook.com (10.167.16.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 00:27:54 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 52I0RNBn024935;
	Tue, 18 Mar 2025 00:28:02 GMT
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
Subject: [PATCH v2 net-next 07/15] tcp: sack option handling improvements
Date: Tue, 18 Mar 2025 01:27:02 +0100
Message-Id: <20250318002710.29483-8-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318002710.29483-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250318002710.29483-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM1PEPF000252E0:EE_|DU0PR07MB9292:EE_
X-MS-Office365-Filtering-Correlation-Id: a97a4cd9-7a0c-43f7-6a8f-08dd65b3b9b0
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VTA4SEZ3WVA5b3NOWEhYcHcrZUY5VENqanVTenJPd3hIVHMvOHZZWVFxYlFV?=
 =?utf-8?B?bG94ZWxsVHNjeldYSnQ1Y3J6TWF3VXpDZW9uY0pGcTczMHU3ekRMQVo3aFg5?=
 =?utf-8?B?WDhFMU04R1U3SFg4REcvdG5BcXN0VlJ3Z05XdTNMWVkwR0pYS3Z6LzFmR0tk?=
 =?utf-8?B?VDRqYmZrTG5lOUxTRFg5RDl0VURBR0VqZEJ3SDZOc3pDSkJObU1ycFhqR0R2?=
 =?utf-8?B?c0U1NTgvWmZZVjhmNDZzaHdVb2NlY1lOdDcyV3A1c3U5NVFMSFhiMndDZm01?=
 =?utf-8?B?Q2huTnJTaDI5NXBDeWhBNFI0NnhCVDF1RmlrcHUrWnR4aFZNb1NkbWR3SzdV?=
 =?utf-8?B?TWNoNHJMV1pRZzJnOTh3UTlSRERUSU5PUEZ4RlBtQTkwaTJ2SVZnWEJ2VGc4?=
 =?utf-8?B?MlJaVm52aURCd0UvaGNiUHc5QmQrY3JLSHVyK3JqNDlNMEdVNXJrRnR0TGNU?=
 =?utf-8?B?eE1WWC9FV1pGWUFSenhzNEhpSC9LUEd0N0ExZU90NndpaWNPL0xoODY4YWV5?=
 =?utf-8?B?RUl0SUJSRUlLWkxyc21QVmc2dUZ1dm5peDg3VFJZK0RpeUhESE9VcEoycWUw?=
 =?utf-8?B?eE1ob1RFYklPT202QnRyaGIxY1hGbkxmQVN6ZFdNeHIxVUxETHFzZHBiM2Vn?=
 =?utf-8?B?ZEFsN1ZsV1pyaVc4cDEwZXdzUis2b1BTMGgvWFQzVFMyR2NKRU1saGtRNEdF?=
 =?utf-8?B?ZGVCVU1XWWlneUgvcEcrVmVxS2ZRSytnamZYT2t1RHpYdVpTejZ2bFhpQzd6?=
 =?utf-8?B?TjZjeStobFlESTlzVmpKVHJVSHhjZFFweUVQZHBNN3lkanVsMW83bWtFUHpk?=
 =?utf-8?B?WTZFcE4rb1BnUEFrNEw4TXpYOUY0ZGlMTllsU25KWmVZTDAzZGtiWlEwR0ts?=
 =?utf-8?B?WkJkQVFvVW13ejJhbTJ4Qjk2dC95Z0RYZVRyOWdXWC9OOTFBTWhFRmh0bkh1?=
 =?utf-8?B?Y0I0SFhDd2xyRFNqUmNpOXdoVGFyZWtDV2FFS1Z4cmxXMzM3UVlTRVAzWTRh?=
 =?utf-8?B?M2d1aDhVK1lzT1diSHJ3WktZOGFjRE5FQTRiTm82OVEzU1FNVTEwMXl4R3dR?=
 =?utf-8?B?UjlzSmtIMTZoRVRwNCtTcC9FOXRkRU9zcUlTT2NPSWg5Rm5DVkcrL2V0cG1y?=
 =?utf-8?B?UjhFeWRyUUVHOWVzNTMxYVIyRm1ZUkUwU3RyNHM2OGoyZjZjZ2xQMWgwUmd3?=
 =?utf-8?B?K0JiUFByeElSZnU3VWdvYUtYeDFxeXVMVExaSlZSK3YxaVM5bVhGNlViN0k1?=
 =?utf-8?B?c2kxOG1LVkJicUtXZjZ5VjZqK0JyTjlZU1QwTzBra0pIZW1OR2xNQ2Q1a2Fu?=
 =?utf-8?B?TU96YlZicU0rVlp5c0huYmlpZlpkVFZZdWcwNis5QmpaZG5Gb3VCT0Yya1pv?=
 =?utf-8?B?aEhkZkdqZVVpLzhsb0lWZnA4bUdPRnhTUG11WUorN1VoOE1vNXUrczB1ME9Q?=
 =?utf-8?B?Z05jWGRRWHpWcG1qeVNQK1FTTHZsbDJkTThUelV2eVpuMERobDY4R2MzQ0d6?=
 =?utf-8?B?dlRDclpYQmxXTnk4SWR6ZGNEYTZXSXJVY1M5Qm1BWW5mbnVETFc0VVczVFl2?=
 =?utf-8?B?T0JBdncxQi9rSFlLMWdLZm5zM2ZybHR0TFdGTlJNMWxESlVYbTJhMXBDN3do?=
 =?utf-8?B?cEUyZDQ3b2E1b08xWHNYN0N0QitZM3dUamRBbTRZWUdxeVp6WFF2NDg5Z2Rr?=
 =?utf-8?B?Um1lRmFFRXdOUGZmQ1VqbUY2VmhzZmlPWmRqWndyaW14MmpnaUc3djdJamFo?=
 =?utf-8?B?YWE5UE9KeDFibCt1Q3N3S0JqREtjdnk3V2ZZN25KRVUwL0xpYnNPcEZaNzJS?=
 =?utf-8?B?dmVDNm05bklpNERXNWVraVVEUzBiOEduS05ub3VUcmU3SHEvMWZTNHR5eW9j?=
 =?utf-8?B?ZnVicmNwOFBZak4xMFR3L0hOdDY1eGxOY3kxczU3QTcvZVM0WFBSYUcwcCsv?=
 =?utf-8?B?SHUyam1uN1UvN1ZIa252cFZyRlkwQWdPNUdaOFpkbExLRDhmMTc2N0I3NHhG?=
 =?utf-8?B?NGtyQ05KdDNVbW42L3dLMmlUR3Z0cVc3VGVha3lwWkI3Mk9RZTFIRTU2cVF5?=
 =?utf-8?Q?AM9YhY?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 00:27:54.3501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a97a4cd9-7a0c-43f7-6a8f-08dd65b3b9b0
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252E0.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9292

From: Ilpo Järvinen <ij@kernel.org>

1) Don't early return when sack doesn't fit. AccECN code will be
   placed after this fragment so no early returns please.

2) Make sure opts->num_sack_blocks is not left undefined. E.g.,
   tcp_current_mss() does not memset its opts struct to zero.
   AccECN code checks if SACK option is present and may even
   alter it to make room for AccECN option when many SACK blocks
   are present. Thus, num_sack_blocks needs to be always valid.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_output.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 87a2a20243c7..3638a865a430 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1103,17 +1103,18 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	eff_sacks = tp->rx_opt.num_sacks + tp->rx_opt.dsack;
 	if (unlikely(eff_sacks)) {
 		const unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
-		if (unlikely(remaining < TCPOLEN_SACK_BASE_ALIGNED +
-					 TCPOLEN_SACK_PERBLOCK))
-			return size;
-
-		opts->num_sack_blocks =
-			min_t(unsigned int, eff_sacks,
-			      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
-			      TCPOLEN_SACK_PERBLOCK);
-
-		size += TCPOLEN_SACK_BASE_ALIGNED +
-			opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
+		if (likely(remaining >= TCPOLEN_SACK_BASE_ALIGNED +
+					TCPOLEN_SACK_PERBLOCK)) {
+			opts->num_sack_blocks =
+				min_t(unsigned int, eff_sacks,
+				      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
+				      TCPOLEN_SACK_PERBLOCK);
+
+			size += TCPOLEN_SACK_BASE_ALIGNED +
+				opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
+		}
+	} else {
+		opts->num_sack_blocks = 0;
 	}
 
 	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
-- 
2.34.1


