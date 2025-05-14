Return-Path: <linux-kselftest+bounces-32944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6C5AB6DA6
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 15:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3DC1B62B3C
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 13:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7F527F72C;
	Wed, 14 May 2025 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="IzUfQCdT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012018.outbound.protection.outlook.com [52.101.71.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8630427BF79;
	Wed, 14 May 2025 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747231034; cv=fail; b=r9VNOUTu6b9c9zU3TE+FqbdnVpttonMjWWpyT8ICxBMg3KaeGWndid455yeLckZ25zEPBmkGqXACb5q3o1bPGU7yv4Q2iYeY3hwcCscFGe+bCaaOGRFIHPp0Fl6dOEoJK3/yi5Lw95YlNNFuJyRcSXCoW5kr1Jx7jVNjJYvYnHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747231034; c=relaxed/simple;
	bh=RiVzglCq3yirbO65bQLjxw3XyfyZZzwsxZVfuiPFOQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iehesyw/XHgWKoq7n++FoE6OQGEL4aJwYJpwWo+1tw0+ZqMD20v/1EsJweTKTiknZY8bMULS+ADVBx3GbPASRlwK9h2f6a5YLULGbdNBp3TCLnRS/inJ76prX3wFyle9DyMUusUcx5s8ownNoNdgp7QVwGccPxwDL2qA9BwLfT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=IzUfQCdT; arc=fail smtp.client-ip=52.101.71.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNTGwuEVLcPLtM5OB8HQeEdEvj+uI6KzZ/rcu5NyywYIlYIavvOt7ATY/04sIEdbH8Z4EyAOE0u0YjOVyHuhv9elxxY8tkwDEGXIg+o4b69kONQ8aBSvY5MKhNsZUoqHDgNnK8ptQdirXEYCTxdMFT7z+5xRRJbAKRo8hHDDQvOmx3uXt4n7Qv0NkK6LSrSCncLVkDAaGSMeqWJa5sWY+8nRYVwGRZJhqYzlRIkuG3wn6vAXh/8J0aJ3EoUdYu4amLP1z1v4nlc0rwnPpn4MHSxpsMeFuiKEv3qJJl1TEw85lfzMHIf9dWyMkMnNnDOPzKYt+thg1G/kKbKKdX5+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKFCP/C4aPcd8mhJtuI5amaTSYaKb5i9XzOlq59Ozrk=;
 b=X5+Z88W0IBqy/x7FldkyixWoq5x8LoHcfk2ajb7ZEI6ncriiPXQO8ig6mIamfPblUpRO2xdyOiQy6by0eANM/ob444KQoJmiWM/DNqNRNJqwcBkt/TMyvkqYO3L2fXUQj0bRnQJky/1pQ7YpaX71pE6vXy9PvzQmiS1PCdGXiP4GBk2knKGN0VGvife02dlBZgsMeEv7395AlObiLmhPnt27T9O3hScJQngWUnENVxm9r6tjpZNJFXsGYqos46v/oi4iyhGIL8sZnT3TXnl3iqZqOy21MEerXHywjDC9atpr21ZuLgVQsHgFxb56DYraywI5RS71Rnt4JZer7uVubw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKFCP/C4aPcd8mhJtuI5amaTSYaKb5i9XzOlq59Ozrk=;
 b=IzUfQCdTwc48gQo/UjkdNc4TQXpaEsboVJ8UwX9zdsSojiujZ7+N7WIkKX+0KlLTlPauqKJ/Am96WGWVuiwktPkA3cPd9ExZ/fkaD6r3JTOLjv4oZXFA2hlkMGPeNySGmEydtzdi7vqHsKcx1bZ4DGhGTUWjoH/E7PP3m+UHliE6blJR1I+/x1HITj/1Tnnb0ps9kjhiyCmZ3E/KwDtLRK1d6Gm34sl169gsYGX5zV2B9b74Z6B2RzanFrLzQzyo7ytX8dZzbZDp+XpPeJVcgEl8wv5PrD57ywMTqjCUNXnR3f4PnOgWIh75ObjMNG2o/aSsp+zdPBQieeKq8g799g==
Received: from DU7P195CA0017.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::27)
 by DB9PR07MB8449.eurprd07.prod.outlook.com (2603:10a6:10:36f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 13:57:09 +0000
Received: from DB1PEPF000509FA.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::ed) by DU7P195CA0017.outlook.office365.com
 (2603:10a6:10:54d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.17 via Frontend Transport; Wed,
 14 May 2025 13:57:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB1PEPF000509FA.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Wed, 14 May 2025 13:57:09 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 78E692009B;
	Wed, 14 May 2025 16:57:07 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
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
Subject: [PATCH v7 net-next 10/15] tcp: accecn: AccECN option send control
Date: Wed, 14 May 2025 15:56:37 +0200
Message-Id: <20250514135642.11203-11-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FA:EE_|DB9PR07MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 64011484-c427-453d-c668-08dd92ef3807
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Ky9WYlZYaUl2a1ppdmdqNXZ3enlCVUtVQjRjaHkybkgweTRHT2IrN3Q1a050?=
 =?utf-8?B?V0ZKb213VHg4YStiUFNhTURFM2xla3ZuRk8rSGROa0JkZnd3NW1ENnNMWE1G?=
 =?utf-8?B?aWJDU3ZVMTNkOWZMcGo3cDgvdEJUMGE2c0NzbXovck9BTjhZcTJLajV0NEpM?=
 =?utf-8?B?MmovcmtoUlp4cm5jUUs0VTE0bGhxbU12bVc0QkpBWWh3TnMrenJQWm1Zb1RR?=
 =?utf-8?B?TmpTMVl6dzlRVjBwcmJJaUhEOEtQVklZdDIva2oxdG9ya05mRTk1cHZCQkJQ?=
 =?utf-8?B?YXhIMDdyYXRsc29UaGhhL1ZpRjdSRWVaK1F3d3VyVkdvT0hKOTdtb2hwY3pE?=
 =?utf-8?B?ZXl3UzBCMjUwOEV0RlJ2UXF5MEpYRTR5QVdybi9iN3U5RnVrSE9kajM2WWxn?=
 =?utf-8?B?blppYVdCUFVYZFhUSGs5bnhneDQ4S21hUENsdFRmL1pJUi93YXh3SFVDaG4x?=
 =?utf-8?B?YmFyRmtBNlJoU1ZSRzd1Uldjb0NybUI2ZnZuemcwZWVGYmF1d2JIZy9tamQ2?=
 =?utf-8?B?a2psUjVSVCtlYUdMRnJBbWR3V3RRem12bFBqV1hkWXR2ck44TU1PVmNFM0xv?=
 =?utf-8?B?b0IzelNHSlAxMGhHQmpFQ3RIaDMzOU5wQmt5WDRycHNKZCthY1d0VmdZQTVC?=
 =?utf-8?B?dTRCRGJrRTUvVGx0c01VRW1qSzFtMU81dktRSlFTMjA1SUR3dG92OGYzRHVr?=
 =?utf-8?B?dWQvS1VQY21ZSHlOWWQzQ1Z2VUhiT3gvUlQzWUJiNTJVcThNS0pBM0VtK0hn?=
 =?utf-8?B?azhaVnhUTFdQeHV1UFU2ZndBUWVmNURISis3NGYxOW9GYlVyK2pYNm5OMXVz?=
 =?utf-8?B?QStma295ZEJ5UGMrQ050cDhOSmMzaVN3Q1Bvc0JRYzAzZHZUdDhncmxVbnZ6?=
 =?utf-8?B?ekR3Nk41TUFwMjFHQjB3M04vbGtzVVloUEpGT1BvUGRVWG15MWhRa1p3TFVq?=
 =?utf-8?B?amk2cVBqVEZEOXNBL0Q3UHRyRTY2bjM2L25YRUFkejNKRkhrTFJLTndDbFZK?=
 =?utf-8?B?bjA0Ly95U2N1VHJrRlBDWHF2OUxrQ2Y4T29KK09mNnV4KzVDaGd4WU8wcFFG?=
 =?utf-8?B?Ykhzd0FmRU5XVENxUlFNenhTMW1oSG5qQnpaUDBLOXhPSXNRN0k2TWhTcSs3?=
 =?utf-8?B?cEFIK0VqMSs4RDJ2elN3RUYxSll2aFBQbzVEbTE4MW5HaGdwRm00MGxidjZT?=
 =?utf-8?B?MUIvRzduaTMrVHZEL0RvUnNnekNjNE1wQzRoOWE0dkhmZVNMRkh3dXhJUUZy?=
 =?utf-8?B?YXVva2ZOTEhuaitwbEtsMmhRdEJkTk5yOFdDdW1LWmZWQ1N4eTRoaitRMU1V?=
 =?utf-8?B?bVBEQlZ5THdPVGlvNDdkM2wwa2dQL0xJSDFzQ1hVN3hTM2wxdGNBK3dhL3I3?=
 =?utf-8?B?V00xaFRPbDBUUkxCV1J2Sys2Qk1HY25BRmpQb2tsb0k0K2twbFZkTTUwZmJu?=
 =?utf-8?B?eHFoc1BsT1VLbjRmYTFWdXdEVUlZYi9WVDVscTNZYVowL1h5ZUdmbG90WUdv?=
 =?utf-8?B?QXlndWR0V1BFQnZ5VXlpUjNua041d0hIaEdac1ZYLzQxU2pBWTh6UTh1TzAr?=
 =?utf-8?B?WnBDM0JsTTVMUnY2YVFZeTFyNWNGUThKNTlXcWs5MUxoaWhwckhvZFd2V3VW?=
 =?utf-8?B?MWlkYkRYc2FTUm5LNzRHVVV0b2UrTHY1aGc1RXhTek5UNUJLU0V1QXlwZHB0?=
 =?utf-8?B?VmFBRzI3eVdMNXlxaGhzNHB6eDBHUXV4d254b25ma3R5SklxSzhnZmpLNmZZ?=
 =?utf-8?B?cGtOTC9BRytYa3M5enFZc3crSlppZU5rcDArUElSUEZCU1EyWkZJaHA1TERK?=
 =?utf-8?B?RHluWDc1VE5zZlNIZ01PeTJ1cUJOejloVVpHT0VKMmNiMzdLbFowaTdaR1k0?=
 =?utf-8?B?cGhEKzlDVVl2cG5velQvMU8wRThqWnNrUHN2NDJyWTVITkFteVI3dHdkajhH?=
 =?utf-8?B?ZHJ2d05vNG9Zd1orWkJBa3IvZlZiM25Vb2xVcXNSdENaRlhER3ZMTnlkZkJp?=
 =?utf-8?B?SmwvaVV5Zk1MdmFGTkhXY2FMeFVkNzk2cG95cm43NnRIVGp4QnhMSGRsT1hp?=
 =?utf-8?B?RUVxc1BYR09iQjVteXAyQUs5SENydlVPM1pkdz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:57:09.0258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64011484-c427-453d-c668-08dd92ef3807
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8449

From: Ilpo Järvinen <ij@kernel.org>

Instead of sending the option in every ACK, limit sending to
those ACKs where the option is necessary:
- Handshake
- "Change-triggered ACK" + the ACK following it. The
  2nd ACK is necessary to unambiguously indicate which
  of the ECN byte counters in increasing. The first
  ACK has two counters increasing due to the ecnfield
  edge.
- ACKs with CE to allow CEP delta validations to take
  advantage of the option.
- Force option to be sent every at least once per 2^22
  bytes. The check is done using the bit edges of the
  byte counters (avoids need for extra variables).
- AccECN option beacon to send a few times per RTT even if
  nothing in the ECN state requires that. The default is 3
  times per RTT, and its period can be set via
  sysctl_tcp_ecn_option_beacon.

Below are the pahole outcomes before and after this patch,
in which the group size of tcp_sock_write_tx is increased
from 89 to 97 due to the new u64 accecn_opt_tstamp member:

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    u64                        tcp_wstamp_ns;        /*  2552     8 */
    struct list_head           tsorted_sent_queue;   /*  2560    16 */

    [...]
    __cacheline_group_end__tcp_sock_write_tx[0];     /*  2585     0 */
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2585     0 */
    u8                         nonagle:4;            /*  2585: 0  1 */
    u8                         rate_app_limited:1;   /*  2585: 4  1 */
    /* XXX 3 bits hole, try to pack */

    /* Force alignment to the next boundary: */
    u8                         :0;
    u8                         received_ce_pending:4;/*  2586: 0  1 */
    u8                         unused2:4;            /*  2586: 4  1 */
    u8                         accecn_minlen:2;      /*  2587: 0  1 */
    u8                         est_ecnfield:2;       /*  2587: 2  1 */
    u8                         unused3:4;            /*  2587: 4  1 */

    [...]
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2692     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 174 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    u64                        tcp_wstamp_ns;        /*  2552     8 */
    u64                        accecn_opt_tstamp;    /*  2560     8 */
    struct list_head           tsorted_sent_queue;   /*  2568    16 */

    [...]
    __cacheline_group_end__tcp_sock_write_tx[0];     /*  2593     0 */
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2593     0 */
    u8                         nonagle:4;            /*  2593: 0  1 */
    u8                         rate_app_limited:1;   /*  2593: 4  1 */
    /* XXX 3 bits hole, try to pack */

    /* Force alignment to the next boundary: */
    u8                         :0;
    u8                         received_ce_pending:4;/*  2594: 0  1 */
    u8                         unused2:4;            /*  2594: 4  1 */
    u8                         accecn_minlen:2;      /*  2595: 0  1 */
    u8                         est_ecnfield:2;       /*  2595: 2  1 */
    u8                         accecn_opt_demand:2;  /*  2595: 4  1 */
    u8                         prev_ecnfield:2;      /*  2595: 6  1 */

    [...]
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2700     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 176 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 .../networking/net_cachelines/tcp_sock.rst    |  3 ++
 include/linux/tcp.h                           |  4 ++-
 include/net/netns/ipv4.h                      |  1 +
 include/net/tcp.h                             |  4 +++
 net/ipv4/sysctl_net_ipv4.c                    |  9 +++++
 net/ipv4/tcp.c                                |  5 ++-
 net/ipv4/tcp_input.c                          | 36 ++++++++++++++++++-
 net/ipv4/tcp_ipv4.c                           |  1 +
 net/ipv4/tcp_minisocks.c                      |  2 ++
 net/ipv4/tcp_output.c                         | 31 ++++++++++++++--
 10 files changed, 90 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index c74f939f32cc..af76d4f9b33a 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -110,6 +110,9 @@ u8:2                          syn_ect_rcv             read_mostly         read_w
 u8:1                          wait_third_ack                              read_write
 u8:2                          accecn_minlen           write_mostly        read_write
 u8:2                          est_ecnfield                                read_write
+u8:2                          accecn_opt_demand       read_mostly         read_write
+u8:2                          prev_ecnfield                               read_write
+u64                           accecn_opt_tstamp       read_write
 u8:4                          accecn_fail_mode
 u32                           lost                                        read_mostly         tcp_ack
 u32                           app_limited             read_write          read_mostly         tcp_rate_check_app_limited,tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index afb1a5ac65bf..0740efaaef28 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -276,6 +276,7 @@ struct tcp_sock {
 	u32	mdev_us;	/* medium deviation			*/
 	u32	rtt_seq;	/* sequence number to update rttvar	*/
 	u64	tcp_wstamp_ns;	/* departure time for next sent data packet */
+	u64	accecn_opt_tstamp;	/* Last AccECN option sent timestamp */
 	struct list_head tsorted_sent_queue; /* time-sorted sent but un-SACKed skbs */
 	struct sk_buff *highest_sack;   /* skb just after the highest
 					 * skb with SACKed bit set
@@ -297,7 +298,8 @@ struct tcp_sock {
 		unused2:4;
 	u8	accecn_minlen:2,/* Minimum length of AccECN option sent */
 		est_ecnfield:2,/* ECN field for AccECN delivered estimates */
-		unused3:4;
+		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
+		prev_ecnfield:2; /* ECN bits from the previous segment */
 	__be32	pred_flags;
 	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
 	u64	tcp_mstamp;	/* most recent packet received/sent */
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 4569a9ef4fb8..ff8b5b56ad00 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -149,6 +149,7 @@ struct netns_ipv4 {
 
 	u8 sysctl_tcp_ecn;
 	u8 sysctl_tcp_ecn_option;
+	u8 sysctl_tcp_ecn_option_beacon;
 	u8 sysctl_tcp_ecn_fallback;
 
 	u8 sysctl_ip_default_ttl;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 50ad6e33d52d..3419618a7891 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -91,6 +91,9 @@ void tcp_time_wait(struct sock *sk, int state, int timeo);
 /* Maximal number of window scale according to RFC1323 */
 #define TCP_MAX_WSCALE		14U
 
+/* Default sending frequency of accurate ECN option per RTT */
+#define TCP_ECN_OPTION_BEACON	3
+
 /* urg_data states */
 #define TCP_URG_VALID	0x0100
 #define TCP_URG_NOTYET	0x0200
@@ -1088,6 +1091,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 	__tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
 	tp->accecn_minlen = 0;
+	tp->accecn_opt_demand = 0;
 	tp->est_ecnfield = 0;
 }
 
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 1d7fd86ca7b9..169a393374b3 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -740,6 +740,15 @@ static struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
+	{
+		.procname	= "tcp_ecn_option_beacon",
+		.data		= &init_net.ipv4.sysctl_tcp_ecn_option_beacon,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_THREE,
+	},
 	{
 		.procname	= "tcp_ecn_fallback",
 		.data		= &init_net.ipv4.sysctl_tcp_ecn_fallback,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a71260838ccf..20a2e30e15f3 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3400,6 +3400,8 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->wait_third_ack = 0;
 	tp->accecn_fail_mode = 0;
 	tcp_accecn_init_counters(tp);
+	tp->prev_ecnfield = 0;
+	tp->accecn_opt_tstamp = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5119,11 +5121,12 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, lsndtime);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, mdev_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, tcp_wstamp_ns);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, accecn_opt_tstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, rtt_seq);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, tsorted_sent_queue);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, highest_sack);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, ecn_flags);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_tx, 89);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_tx, 97);
 
 	/* TXRX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, pred_flags);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 3de8cc56c5cd..10c37a41b9a5 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -487,6 +487,7 @@ static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
 	default:
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
+		tp->accecn_opt_demand = 2;
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
@@ -507,6 +508,7 @@ static void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
 		} else {
 			tp->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
 					  INET_ECN_MASK;
+			tp->prev_ecnfield = tp->syn_ect_rcv;
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		}
 	}
@@ -6302,6 +6304,7 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
 	struct tcp_sock *tp = tcp_sk(sk);
+	bool ecn_edge;
 
 	if (!INET_ECN_is_not_ect(ecnfield)) {
 		u32 pcount = is_ce * max_t(u16, 1, skb_shinfo(skb)->gso_segs);
@@ -6315,9 +6318,36 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
 
 		if (payload_len > 0) {
 			u8 minlen = tcp_ecnfield_to_accecn_optfield(ecnfield);
+			u32 oldbytes = tp->received_ecn_bytes[ecnfield - 1];
+
 			tp->received_ecn_bytes[ecnfield - 1] += payload_len;
 			tp->accecn_minlen = max_t(u8, tp->accecn_minlen,
 						  minlen);
+
+			/* Demand AccECN option at least every 2^22 bytes to
+			 * avoid overflowing the ECN byte counters.
+			 */
+			if ((tp->received_ecn_bytes[ecnfield - 1] ^ oldbytes) &
+			    ~((1 << 22) - 1)) {
+				u8 opt_demand = max_t(u8, 1,
+						      tp->accecn_opt_demand);
+
+				tp->accecn_opt_demand = opt_demand;
+			}
+		}
+	}
+
+	ecn_edge = tp->prev_ecnfield != ecnfield;
+	if (ecn_edge || is_ce) {
+		tp->prev_ecnfield = ecnfield;
+		/* Demand Accurate ECN change-triggered ACKs. Two ACK are
+		 * demanded to indicate unambiguously the ecnfield value
+		 * in the latter ACK.
+		 */
+		if (tcp_ecn_mode_accecn(tp)) {
+			if (ecn_edge)
+				inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
+			tp->accecn_opt_demand = 2;
 		}
 	}
 }
@@ -6450,8 +6480,12 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	 * RFC 5961 4.2 : Send a challenge ack
 	 */
 	if (th->syn) {
-		if (tcp_ecn_mode_accecn(tp))
+		if (tcp_ecn_mode_accecn(tp)) {
+			u8 opt_demand = max_t(u8, 1, tp->accecn_opt_demand);
+
 			accecn_reflector = true;
+			tp->accecn_opt_demand = opt_demand;
+		}
 		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
 		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
 		    TCP_SKB_CB(skb)->seq + 1 == tp->rcv_nxt &&
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index cc3049bb9d02..9e8eb0d639de 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3451,6 +3451,7 @@ static int __net_init tcp_sk_init(struct net *net)
 {
 	net->ipv4.sysctl_tcp_ecn = TCP_ECN_IN_ECN_OUT_NOECN;
 	net->ipv4.sysctl_tcp_ecn_option = TCP_ECN_OPTION_FULL;
+	net->ipv4.sysctl_tcp_ecn_option_beacon = TCP_ECN_OPTION_BEACON;
 	net->ipv4.sysctl_tcp_ecn_fallback = 1;
 
 	net->ipv4.sysctl_tcp_base_mss = TCP_BASE_MSS;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 3f8225bae49f..e0f2bd2cee9e 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -501,6 +501,8 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
+		tp->prev_ecnfield = treq->syn_ect_rcv;
+		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
 	} else {
 		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 0a4d9791b4a2..ea37a30ff71c 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -807,8 +807,12 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 			*ptr++ = htonl(((e0b & 0xffffff) << 8) |
 				       TCPOPT_NOP);
 		}
-		if (tp)
+		if (tp) {
 			tp->accecn_minlen = 0;
+			tp->accecn_opt_tstamp = tp->tcp_mstamp;
+			if (tp->accecn_opt_demand)
+				tp->accecn_opt_demand--;
+		}
 	}
 
 	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
@@ -985,6 +989,18 @@ static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
 	return size;
 }
 
+static bool tcp_accecn_option_beacon_check(const struct sock *sk)
+{
+	const struct tcp_sock *tp = tcp_sk(sk);
+
+	if (!sock_net(sk)->ipv4.sysctl_tcp_ecn_option_beacon)
+		return false;
+
+	return tcp_stamp_us_delta(tp->tcp_mstamp, tp->accecn_opt_tstamp) *
+	       sock_net(sk)->ipv4.sysctl_tcp_ecn_option_beacon >=
+	       (tp->srtt_us >> 3);
+}
+
 /* Compute TCP options for SYN packets. This is not the final
  * network wire format yet.
  */
@@ -1237,12 +1253,16 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	}
 
 	if (tcp_ecn_mode_accecn(tp) &&
-	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option) {
+	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
+	    (sock_net(sk)->ipv4.sysctl_tcp_ecn_option >= TCP_ECN_OPTION_FULL ||
+	     tp->accecn_opt_demand ||
+	     tcp_accecn_option_beacon_check(sk))) {
 		int saving = opts->num_sack_blocks > 0 ? 2 : 0;
 		int remaining = MAX_TCP_OPTION_SPACE - size;
 
 		opts->ecn_bytes = tp->received_ecn_bytes;
-		size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
+		size += tcp_options_fit_accecn(opts,
+					       tp->accecn_minlen,
 					       remaining,
 					       saving);
 	}
@@ -2960,6 +2980,11 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 	sent_pkts = 0;
 
 	tcp_mstamp_refresh(tp);
+
+	/* AccECN option beacon depends on mstamp, it may change mss */
+	if (tcp_ecn_mode_accecn(tp) && tcp_accecn_option_beacon_check(sk))
+		mss_now = tcp_current_mss(sk);
+
 	if (!push_one) {
 		/* Do MTU probing. */
 		result = tcp_mtu_probe(sk);
-- 
2.34.1


