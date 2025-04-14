Return-Path: <linux-kselftest+bounces-30695-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B66EA88172
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09DB3B1AF7
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C302D3A81;
	Mon, 14 Apr 2025 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Azkwzj4F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011033.outbound.protection.outlook.com [40.107.130.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102842C374D;
	Mon, 14 Apr 2025 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636457; cv=fail; b=rcy1v7+GYzW5qfZ2LklQIyELFu+2MuszQNjsW7GiFCpscQUNowkjIy9U46WUhp4fUTvFuCVn2BucbsiGL1uQf7+32og+wYF8RwC5og240UEDsbm9MjHtOT3ZyL7S8U6o4QLh0Cz/njevxwcqBrUaadENtdViVp8O1klTRrHw60g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636457; c=relaxed/simple;
	bh=+ezEZy8hckPaea1lF4ilsBt0GsZjvoaMn1f9l0j0RCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hx14eiX2lkxHo0gHY2trmYnziHoW5Bma+1HP0sj65Q5J6Blm1HsG7H8QmrBarK72SY7UzR4XPOOQqp56FnhfqEO7FmNFolz8B7AYDhS1il2ar0Sv8P3sfcylGwiCBn5q+eAUf8BAO1IXdc+2wEVpXgJk2YlPy6aKivySIe2+OZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Azkwzj4F; arc=fail smtp.client-ip=40.107.130.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qriuHmEf1wvtnWkCJLMk5pA6/2D0lFxMYw2sHoeF5yZN3wgcHjqpPX5fP4jpjYniR4hNK7b9OCNBznH5xCcFPMV87xYDGTC2C50E2/j1V5LWErUxeXz5Je6xxpKtVJnATHHX3+ik6bVWnqPAT18jmAC5qs0oP5Eyx9kg8gAZ3wxTDeeCa6/o3f9UDy8rFTibtPMbt1whoXU9hy4GXJwtEzzIiOydZrub6LZ93/YPtOFax0QJepdf9Rp6fn9sPTamiFE9VLyVHSlOIvuDQPAND/gE1+CmHFYRQ68T73k3XSddRj9sKfSpfHfwZppP4CuIZeTx4OT3W1pIlcybbl3FXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ix+QtM7JJKtuEJJnzOOAErViBOEsmOlScq7uOdppACk=;
 b=wzCOkKgC0wxAVH/FRPhTv1c17r82uzis669Ya0mrH7Tl8nqvFlENvvS13Yox4kAfWbeVASCpKNQd2rzf/f9kdxl1znKThZPkPirNVolFtY/WOdJ0aMxX2m4xNd/lfPY9ZvTtTzBWT/EFLIqLM+ylIh+/MTXIyvFzg7NBhPB19nXCNEHCdKDBbQrRwcm23Jm9E+OJmh5B3BhVyobOOdrzJdEEsdSrwVVDVCAH2WMdnKfK57UtW7xYpb/JisJ3F5TRLY+FpsCz6lExR/YTZL616ZT8hCQc4n9AJSkC33x6qIMwg6TRde+EDt3E9G10MAI+31Kg/ipe/jqlbdxZ6raX5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ix+QtM7JJKtuEJJnzOOAErViBOEsmOlScq7uOdppACk=;
 b=Azkwzj4FtfmDyFLL1vQcH92Ffv9kS1+n31k8SZc5Brhnwm2HrhRF/vVXDYu8d4iZ+8BFPPRCIEtj20T9WcKnWOXou2KVW3iZNmD7lEZFNPvACB3Q3eaQIk5oKel5PhuPeQx1CCcvt02foDEDoyjmb6lkq1I7FQKZ8FNy5qS3hpv1LH9wQoOEPe0lPB6Eqgg5CaIwytkPKXWXDAred/jJwhlfbIwGxzmN1hIGLL8TYz21Uad8kCEiHvdo99llh5GyOK2D+VJsyMEirlEzkD9+B5rGK+OvOy3ZZTUlyMZU+Z/pFwg/mE05tr46NzOqwn3w7WBLHqI2OD2+hzVWrV5ixA==
Received: from AS9PR06CA0210.eurprd06.prod.outlook.com (2603:10a6:20b:45d::28)
 by AS4PR07MB8458.eurprd07.prod.outlook.com (2603:10a6:20b:4e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Mon, 14 Apr
 2025 13:14:09 +0000
Received: from AM3PEPF0000A794.eurprd04.prod.outlook.com
 (2603:10a6:20b:45d:cafe::ce) by AS9PR06CA0210.outlook.office365.com
 (2603:10a6:20b:45d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 13:14:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM3PEPF0000A794.mail.protection.outlook.com (10.167.16.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 13:14:09 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 53EDDQBJ009623;
	Mon, 14 Apr 2025 13:14:07 GMT
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
Subject: [PATCH v3 net-next 08/15] tcp: sack option handling improvements
Date: Mon, 14 Apr 2025 15:13:08 +0200
Message-Id: <20250414131315.97456-9-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A794:EE_|AS4PR07MB8458:EE_
X-MS-Office365-Filtering-Correlation-Id: 33bf6c0f-fc82-4d3b-d712-08dd7b563df6
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?a3JpNkxLS2tZZ2NFbnNWbzdnS201MW1jclVhc3NhQXdvK1VIMnVoN3ZleXBj?=
 =?utf-8?B?VmNnS3Z1S2ZMMW5hVDlPRTBzM05aakZrK2tqOEpzNmkvaUU5QkVEV2JOa2s2?=
 =?utf-8?B?TnE3S2tjZXJYK1hXcm1PV3VBNjV1Y0FqUlMweTE1dWl3UXpOOXdyalhqUXVx?=
 =?utf-8?B?UXBLLzlnSHUyMkdaZkR3SWx5eGlKRVpqa1BPbDV3bnJxaTZvTEZtNE9peXhI?=
 =?utf-8?B?V0pNd2l4aVBUSVI5cXBJcjNlcC9TMkR3YTJNT1I0ZTcrSGt3SzhWcEw1TFJj?=
 =?utf-8?B?WFdkcHBORm95b0l0cGs2Yzc1UlNUU2VvVVhPS2JTT3lLRU95VFd2UndQUkZ4?=
 =?utf-8?B?dkc2Vk5JNGRRWkpDZlhZMFlISzFKdm1tM0hmU1dKNlE2c0ZUTWcxNVgzZml1?=
 =?utf-8?B?WFNKRmR6WDhIa0pob2daQkxMSS9Xc2hNTEU4T2hYeVVndU5JWUN4OGo4WEV2?=
 =?utf-8?B?VUNaMytGWittay9HYmd0dVBRWEFqYWwvL01jLzF4bkZaMWVKRjlLRDdYT3FK?=
 =?utf-8?B?bEVFbERhdUNiUDR1dnNVNnk1d2hvVm5jNWpNRnd6R0IvaUF4Mnk1TERIMDhJ?=
 =?utf-8?B?UjhNbEtwTUtwVll1L2lhbUFGUmRJR0xpNFZsR3ZDK0o0NGM0SzduMkIyRWVN?=
 =?utf-8?B?MXBqRUhZMmpXcndKSjFBUGtOVDlFY0oxUGlZdkZPL2t2TFVmQzl2OHVGakc5?=
 =?utf-8?B?b01mZno1RldrbDlQZkFXUitHcjE2QkRTUEY4MUM3a1ZveHkvdzk3bnNaaG5O?=
 =?utf-8?B?RVNDTVhVbkl2UU9yaEd4YUVzZmZWK2lTZGRzaTVlcXVHTzRKeW1IVGJSeTE4?=
 =?utf-8?B?aHdBWGxIa200WkJlRC9hMTlqSmREeU95eGY4eEduRjlaV0pENlBqcXVUMmFo?=
 =?utf-8?B?SzJ4VUgxaDNucjJtZDZWTjd4aTJST0wxRWlrM2VyOFBkL01KSlJPWDljQ3Zs?=
 =?utf-8?B?VTFhNHdtNWFUOUVJbGx1cTF1cXhFd0RhV2ZGR1hpeEdFZW5acDJpSS9BV2sy?=
 =?utf-8?B?WXVIL0N1QWI5ODRxVVY3VE1STVJWeFdwZXVXREdveEVMcWFlMEhjbUdKRGQ3?=
 =?utf-8?B?R0ViczJISFRUWENEVU02SU5sc3Zpc2gydldzdk5WWUNvRzJqM0M0Ymk5Zjdl?=
 =?utf-8?B?SmhVVzVUaFg1bVYxMXZvMHFWd2dlZlBrOHJWUGs5LzlIYVN1bGN0eUFpQUZY?=
 =?utf-8?B?bUhzN3dnYTc0bHh1eGRiZk43Ulo1R1A5ajVDeGpqeEEvbnhKejRhUkROWWw0?=
 =?utf-8?B?bnlYQ2hyekd1QVZRQXIwMjQ4Y0ZwU3VhQ0pveVVzQkdHUnlSSkJJaUhlejNV?=
 =?utf-8?B?MW0wK0kxYWloTDRUK0d4MEN1b0dCMkQ2YUx5MnczZkFsWW04bGE0OCtqSU14?=
 =?utf-8?B?VVNSRkhmY2JDV3gzYnA4L0dJbWdOTDE3UVBhMmVZM1JMRjFJNzRFdVZjdWpq?=
 =?utf-8?B?eG8wUDFSTzZVOUJIRmZHOGhTcWtHYkJEWUgyNlNqNHRGaE1hZ2RjRy93VkQ4?=
 =?utf-8?B?SG5Rb2pTcUdKdCt6Q3NmQTl5MnpMSzVQb0ZKbmdReDVEYStsTkE4dzZuZmhV?=
 =?utf-8?B?L0Y5cnJjTnpvN2taWGdGQ3pzOEdsV3IwT0pvcFlDK3BFaGNEdFBnbWRxUXE3?=
 =?utf-8?B?c1FBeDF1NTZGWjl0Ym1MMEF6dC8vajMvb3BHRDQzajdIVFRZREVBR0xXY0Rv?=
 =?utf-8?B?OWZ1S0dXTXhScE1BbmM5QkE5OU0zMFZJQ2t3bjJQem15S1FRSnZEN3IzamZr?=
 =?utf-8?B?eG5KUGREekZYV2hYTExOaXdScjN5RFdyQjYwSnBxMExsa2wxVldUSS9BR2NC?=
 =?utf-8?B?Z0l6NG5NV2l0eDN0WnJ0dWFTOUF3Yi9LUjlVdzNBajlsZndEMHpwMGNRL2xQ?=
 =?utf-8?B?d1pFdy9oUURtQ010K0E3VCtmd1VScnQzNFdtdUVSdVZnUTc1cnBEbEdVRTBS?=
 =?utf-8?B?UnJBUS9tdmtuYUYwZXBLZGxXRkw5cEJVVGxOWmllRHlQNmtRZ0pEeHpTY3lt?=
 =?utf-8?B?d3NVSXYxeGRPQlpLclVQMVRRK2tva2owN2thc3dkNkMwbFA3YUVRb3FCbnov?=
 =?utf-8?B?MWJBRDdHNWl6YU5Dek1GNGh6Y1VYSGZ6RjNKUT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:14:09.2531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bf6c0f-fc82-4d3b-d712-08dd7b563df6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A794.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8458

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
index d63f505a30e2..ad97bb9951fd 100644
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


