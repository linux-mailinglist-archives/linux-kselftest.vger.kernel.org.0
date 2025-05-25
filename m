Return-Path: <linux-kselftest+bounces-33749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AB8AC35DE
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 May 2025 19:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFFC51890F91
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 May 2025 17:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CA4259CBE;
	Sun, 25 May 2025 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="SzUYT0uU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2050.outbound.protection.outlook.com [40.107.103.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF9A25A2AA;
	Sun, 25 May 2025 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748193575; cv=fail; b=MaOEYFpM9T3Gw5E1w4/FhUABYO3zKoZyEdbOonupRMQOEER8n2FsALIvE19kmmXF02gv/dOAHf+37Ao0DY/h2Db7GAeMmpxSMPks3YtrXKGwqhI+myFOsDT6IJSOiqzkVlXAh1+ObprkWBHlgn2ZtvcmoFN7z8uRVzg1qEZ6S1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748193575; c=relaxed/simple;
	bh=iREmfE8uFnGQ2VS4PdisNXVs4Em3dsKnTDEUFNZYlSc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pXibbVoqJplIbUHydN6hrcOdgWhcnhtMvxohFkNva4fuzLo99NQKU4fwRUU1wyB0t4a3Md5FNdsHzQ4hKneNuwLUdCllPxiaIzyP+4k/XEZlCSbtL63rB4xtHhL8wP019pJ+mCxqgdKKbSlmVbs5VVFb/wy+amtFdHWAIFUO6pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=SzUYT0uU; arc=fail smtp.client-ip=40.107.103.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSXc1VqpfDjQdaVRV3/hdpAIexUJgsues2KxnOE9nICZo59cH9n3smey04A7Ug9orW0SA2dW8pU+EGL9v20iWrHqOPhzagtKCh3sPYeVJQOgcSpgeqhik6HBE/1BvHswAJmhRjUyBdPu9frLtHRaUyzz3VL+s6A6r9daovTt4BwUPjRT+Fb1+t7WxX/HYMeKqss4TdDM6VfAHZdBpTQqAQxaLh8EULA2CyNBIiNkucxG1keQ1BLUSwyPiwgN05WquAo0YUUZ1TYKE4oeAG2SIS/UFnpb3tIeOtwgTWlHl6pnGDwVI2D3otUt1CSfyWDl/OEcar37Xj63gy7Wk2v72Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlJfVU3KB18bqlV7n5va4lz1OBRPnFkT0/4Aj5qq4YA=;
 b=pt7YASRsF8A6kpKLPVPTkIEfc/W4NB7nkGfay78hGg/aTInteImcS2DCcLDO0hO3CCTjc8RiE1+tjT7C5HT9BLrKwhM4AjfniGvoj9ncBFMaQbgSZNCbwJo8TaGtRCr3K6o1HOYuaxqEm/afK72deLztDCqyneE1bBbPwG9fJ1YL+gadPbzmrKLjirg65aASKti8gYdvsB3yqgZ5ipWL2HC2OHvWxOlorKgp3E8sBaPeZ+LvjVOfW76P2jvQp2z/2ocp4D/RzfZZJD9NzHqhPKGVyIyJgwESje/K8HGIaF+c8UyUJr6Cj2zhP4RtBSpkEGUsJF1zf4SRl542wrBOdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlJfVU3KB18bqlV7n5va4lz1OBRPnFkT0/4Aj5qq4YA=;
 b=SzUYT0uUT8Ay8W7AULm8WcKxX3Nc3XWo2M5Lf5T8hqLLVcwFTeX60LUIngdpioYiiYV5dy+tq/NiylswJSpfKYvgPDUW4FhfT58NRObGKdpdBkwhQ+7nDRPI/E8qpJMNyMZ+1tqtgCDQ6D7Cl+9HRV1m4a7jrLzhSlrX25lppWjj0YcDDuRCbau8rJNcKU/QU4o5hxncs8WpYacTU2vbrTNnU4BqrQ/bYbeSElRGMn1WzguhiNJsxqlwmsndhK/cffsBNliah7RkcB6K2qc6DAhNAvCrBRJPdrSynT1yZok0ZnYuUmYCwBZVLtFcOQpm7eTvbjgrF7XAsWOE/J849Q==
Received: from CWLP123CA0264.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1d5::8)
 by AM8PR07MB8041.eurprd07.prod.outlook.com (2603:10a6:20b:3d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Sun, 25 May
 2025 17:19:27 +0000
Received: from AM4PEPF00027A60.eurprd04.prod.outlook.com
 (2603:10a6:400:1d5:cafe::13) by CWLP123CA0264.outlook.office365.com
 (2603:10a6:400:1d5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.26 via Frontend Transport; Sun,
 25 May 2025 17:19:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM4PEPF00027A60.mail.protection.outlook.com (10.167.16.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18
 via Frontend Transport; Sun, 25 May 2025 17:19:27 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id D623620130;
	Sun, 25 May 2025 20:19:25 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org,
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
Subject: [PATCH v17 net-next 0/5] DUALPI2 patch
Date: Sun, 25 May 2025 19:19:19 +0200
Message-Id: <20250525171924.15603-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A60:EE_|AM8PR07MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dbd7918-fdad-4902-9437-08dd9bb04d87
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RTlyZ2ZENTFPY0w3K1g5WVRnME1TR2dudWVTS2RqYWdnMXV0KzF1cGlxOVRC?=
 =?utf-8?B?RG84OXZMMWFSUnd4SmxmbEhFSmZ3LzhzbHZBVHBCRWlRUmx2Zmt6N09yMGZB?=
 =?utf-8?B?U1dDRk1qc3ZkVW5NZUk1aUhBWWUzZ2lUZ2hranlTUWJ2aktPR3p5ck9SemxL?=
 =?utf-8?B?MXQrb0xYOVZ1Umwyc0Rzd2RlTm1vSmZqblcrSWZkV3BGNm43ZkZ3V0Vic3hF?=
 =?utf-8?B?WkE4bldVNnhVTXlpcTlwbDlhMTVjLzlUcDEvbmpNcmxBOG8xVVpZSVlLRnd1?=
 =?utf-8?B?Umt5NE9EaW4xTmd4eGYvbnVHRXYwZTJuVjd5R20vNDVpaXoxVDJ1MS96eUpn?=
 =?utf-8?B?dThmdHFQeEg5ZjU1ckNvRnpwUU5oUjhoTEw5T2NVV3VTK2M0RXZoU1Rablg1?=
 =?utf-8?B?c1A4ZWdrV0xBWk1PWE1tN09yRldFdlJrcGczNkFtZDFydkdnUEEwVGExa2sx?=
 =?utf-8?B?UWxTcTJyb2Nkc1BDdkVCd1YrTllQSjJRQ2NGY3RkUlk3dmljTVBIMUp4aUhm?=
 =?utf-8?B?a0xlOFVmeGFvOGd6aHJDakZxVUpTb1RlbmRMT3B5eHlLaDlRbUdCelIyYXds?=
 =?utf-8?B?VE5Kc3hTeU5ZZkZrSitKTmZKNFdNUzNMY05lMk14bHVRV2NKUklaU0h1VjdM?=
 =?utf-8?B?cmhXMXY5cFRRaHhiZjRRV3VBdDJFY2xBbkNzOGFzV2lZZmVOV3lZbDllUVNx?=
 =?utf-8?B?U3c5RkU5bm13cDk0TWFnZHpJS1RYMXZaQVNUUWhXV1pWZk45eDVPR3AwK0U5?=
 =?utf-8?B?RXBQeGs2M2ZVRGcyRFRiNk1DK3EwM2VrNVBXcWUvQXBmV0IzcUhBTUlZMS9a?=
 =?utf-8?B?MEcrekZHUGdzSFhGOVFyd2hxZnJzYm1VQVhtVUNmVlNSRkxKVVp2V09DSlpN?=
 =?utf-8?B?TkFrVnNyeUgxbmFLbWFuc0xtTTFIN0llWGVCZG1hM2xrWWJGWlZMbWtORE14?=
 =?utf-8?B?VG16dnlIMnZ0VWZ4amV5S2NEbUJTSlNFUXJXK2g5bG9xMGZUVkl3aGxsUVNa?=
 =?utf-8?B?WWJHOWh1WDZMd040OVV0ek1FY1I2cTVEZmRjbHAzTG1ibnlDODVQRitwQkhR?=
 =?utf-8?B?a0d0b0RzbkpDTUs3SU5CYkxpUFpXaHJ1V2ZPZmN1TGd3cUh2N29tSnZqZ2hX?=
 =?utf-8?B?cXVOOGdHL1JiVlZoaUlzZXoxb25HMU14Q1lDSU5TRGthem9LMCs4ZUlNb001?=
 =?utf-8?B?UWZzWEJ0OExWcXFaZElYMkZWTTJCNVJIOGkyQTJZTVJMNk5USUhBK2x6Vitn?=
 =?utf-8?B?VDlwQ1YvQXZoSVVwQ29ZREFrdU15WC9Lcy91aVN4YmZpQk42aTJtNTQ3VFVO?=
 =?utf-8?B?VWJUK096QzB1czAyWmJJaUhpUmd4K2hWU3pnU20xQ0hzZUFibm9xOE1CMFlF?=
 =?utf-8?B?U3k4c3VlUjRLZjAxYVZqVjJEVkxvaEk2eXlNWVBmeU4zblRtRFU5ZXhvRmtu?=
 =?utf-8?B?SzNHcW5GLzVBc0liTzFXTFJ6QjJCeFcwUG9lTXB0dTBSOFpxUEY0N0swQWtZ?=
 =?utf-8?B?blJzYkdhTFhIMjlVWE5Kd21CNlU1NVpNMVh3OXJZQ2FqMUtRVG1WdUFqcnk3?=
 =?utf-8?B?dVdTcVVLaWJvUGZXZnRud3VxSFBId3l5ZHZIRExhVVlvUE1FZm9qTFY2QmlH?=
 =?utf-8?B?cWdpRW9ScElybTUrRTI0SU1IWjZPMDUwKzJ1L3hmbmdnUXYwTzArTFZIUTJs?=
 =?utf-8?B?MlcyWXpNMnhnelZGcVIvcWRsb3dxa00zWk1QZGVJakFDMEIxbEkzZW1acmNC?=
 =?utf-8?B?d3JKbkxVUWk1NnVnS3UxLzNsWFY5S3orcHQ3aElNL01QZ2FlSG9YTG85Qjc5?=
 =?utf-8?B?OUFZNUp5aFJ2Y09hRFdTRFM1dnRKUTFmbmZNeXZDL1FjcFNpYVZlZllGc2tm?=
 =?utf-8?B?Y3VVbFZlSnd2SkcvbjJyK0JJeHA1TXpNV2xuN290d2RhcThPdjZCZzZyRVU4?=
 =?utf-8?B?eFpkcCtXbGJYVkU0V1hMQ0RwbnJiZ2pVaVQrakFuSE55NmRCZWdkT2NCYloy?=
 =?utf-8?B?RzVEUlR3RlY4R1A2N2ZoYkk0UGxxejN5R005dnk3TEFTUzBuWjU1cnJkWmxs?=
 =?utf-8?B?aElOYkdBTDFmUHVqZ2ttSHFVVzdRYmRIYW4vdz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 17:19:27.2298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbd7918-fdad-4902-9437-08dd9bb04d87
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A60.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8041

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find the DualPI2 patch v17.

  This patch serise adds DualPI Improved with a Square (DualPI2) with following features:
* Supports congestion controls that comply with the Prague requirements in RFC9331 (e.g. TCP-Prague)
* Coupled dual-queue that separates the L4S traffic in a low latency queue (L-queue), without harming remaining traffic that is scheduled in classic queue (C-queue) due to congestion-coupling using PI2 as defined in RFC9332
* Configurable overload strategies
* Use of sojourn time to reliably estimate queue delay
* Supports ECN L4S-identifier (IP.ECN==0b*1) to classify traffic into respective queues

For more details of DualPI2, please refer IETF RFC9332 (https://datatracker.ietf.org/doc/html/rfc9332).

Best regards,
Chia-Yu

---
v17 (25-May-2025)
- Replace 0xffffffff with U32_MAX (Paolo Abeni <pabeni@redhat.com>)
- Use helper function qdisc_dequeue_internal() and add new helper function skb_apply_step() (Paolo Abeni <pabeni@redhat.com>)
- Add s64 casting when calculating the delta of the PI controller (Paolo Abeni <pabeni@redhat.com>)
- Change the drop reason into SKB_DROP_REASON_QDISC_CONGESTED for drop_early (Paolo Abeni <pabeni@redhat.com>)
- Modify the condition to remove the original skb when enqueuing multiple GSO segments (Paolo Abeni <pabeni@redhat.com>)
- Add READ_ONCE() in dualpi2_dump_stat() (Paolo Abeni <pabeni@redhat.com>)
- Add comments, brackets, and brackets for readability (Paolo Abeni <pabeni@redhat.com>)

v16 (16-MAy-2025)
- Add qdisc_lock() to dualpi2_timer() in dualpi2_timer (Paolo Abeni <pabeni@redhat.com>)
- Introduce convert_ns_to_usec() to convert usec to nsec without overflow in #1 (Paolo Abeni <pabeni@redhat.com>)
- Update convert_us_tonsec() to convert nsec to usec without overflow in #2 (Paolo Abeni <pabeni@redhat.com>)
- Add more descriptions with respect to DualPI2 in the cover ltter and add changelog in each patch (Paolo Abeni <pabeni@redhat.com>)

v15 (09-May-2025)
- Add enum of TCA_DUALPI2_ECN_MASK_CLA_ECT to remove potential leakeage in #1 (Simon Horman <horms@kernel.org>)
- Fix one typo in comment of #2
- Update tc.yaml in #5 to aligh with the updated enum of pkt_sched.h

v14 (05-May-2025)
- Modify tc.yaml: (1) Replace flags with enum and remove enum-as-flags, (2) Remove credit-queue in xstats, and (3) Change attribute types (Donald Hunter <donald.hun
- Add enum and fix the ordering of variables in pkt_sched.h to align with the modified tc.yaml (Donald Hunter <donald.hunter@gmail.com>)
- Add validators for DROP_OVERLOAD, DROP_EARLY, ECN_MASK, and SPLIT_GSO in sch_dualpi2.c (Donald Hunter <donald.hunter@gmail.com>)
- Update dualpi2.json to align with the updated variable order in pkt_sched.h
- Reorder patches (Donald Hunter <donald.hunter@gmail.com>)

v13 (26-Apr-2025)
- Use dashes in member names to follow YNL conventions in tc.yaml (Donald Hunter <donald.hunter@gmail.com>)
- Define enumerations separately for flags of drop-early, drop-overload, ecn-mask, credit-queue in tc.yaml (Donald Hunter <donald.hunter@gmail.com>)
- Change the types of split-gso and step-packets into flag in tc.yaml (Donald Hunter <donald.hunter@gmail.com>)
- Revert to u32/u8 types for tc-dualpi2-xstats members in tc.yaml (Donald Hunter <donald.hunter@gmail.com>)
- Add new test cases in tc-tests/qdiscs/dualpi2.json to cover all dualpi2 parameters (Donald Hunter <donald.hunter@gmail.com>)
- Change the type of TCA_DUALPI2_STEP_PACKETS into NLA_FLAG (Donald Hunter <donald.hunter@gmail.com>)


v12 (22-Apr-2025)
- Remove anonymous struct in sch_dualpi2.c (Paolo Abeni <pabeni@redhat.com>)
- Replace u32/u8 with uint and s32 with int in tc spec document (Paolo Abeni <pabeni@redhat.com>)
- Introduce get_memory_limit function to handle potential overflow when multipling limit with MTU (Paolo Abeni <pabeni@redhat.com>)
- Double the packet length to further include packet overhead in memory_limit (Paolo Abeni <pabeni@redhat.com>)
- Remove the check of qdisc_qlen(sch) when calling qdisc_tree_reduce_backlog (Paolo Abeni <pabeni@redhat.com>)

v11 (15-Apr-2025)
- Replace hstimer_init with hstimer_setup in sch_dualpi2.c

v10 (25-Mar-2025)
- Remove leftover include in include/linux/netdevice.h and anonymous struct in sch_dualpi2.c (Paolo Abeni <pabeni@redhat.com>)
- Use kfree_skb_reason() and add SKB_DROP_REASON_DUALPI2_STEP_DROP drop reason (Paolo Abeni <pabeni@redhat.com>)
- Split sch_dualpi2.c into 3 patches (and overall 5 patches): Struct definition & parsing, Dump stats & configuration, Enqueue/Dequeue (Paolo Abeni <pabeni@redhat.com>)

v9 (16-Mar-2025)
- Fix mem_usage error in previous version
- Add min_qlen_step to the dualpi2 attribute as the minimum queue length in number of packets in the L-queue to start step threshold marking.
  In previous versions, this value was fixed to 2, so the step threshold was applied to mark packets in the L queue only when the queue length of the L queue was greater than or equal to 2 packets.
  This will cause larger queuing delays for L4S traffic at low rates (<20Mbps). So we parameterize it and change the default value to 0.
  Comparison of tcp_1down run 'HTB 20Mbit + DUALPI2 + 10ms base delay'
    Old versions:
                           avg       median          # data pts
 Ping (ms) ICMP :        11.55        11.70 ms              350
 TCP upload avg :        18.96          N/A Mbits/s         350
 TCP upload sum :        18.96          N/A Mbits/s         350

    New version (v9):
                           avg       median          # data pts
 Ping (ms) ICMP :        10.81        10.70 ms              350
 TCP upload avg :        18.91          N/A Mbits/s         350
 TCP upload sum :        18.91          N/A Mbits/s         350


  Comparison of tcp_1down run 'HTB 10Mbit + DUALPI2 + 10ms base delay'
    Old versions:
                           avg       median          # data pts
 Ping (ms) ICMP :        12.61        12.80 ms              350
 TCP upload avg :         9.48          N/A Mbits/s         350
 TCP upload sum :         9.48          N/A Mbits/s         350

    New version (v9):
                           avg       median          # data pts
 Ping (ms) ICMP :        11.06        10.80 ms              350
 TCP upload avg :         9.43          N/A Mbits/s         350
 TCP upload sum :         9.43          N/A Mbits/s         350


  Comparison of tcp_1down run 'HTB 10Mbit + DUALPI2 + 10ms base delay'
    Old versions:
                           avg       median          # data pts
 Ping (ms) ICMP :        40.86        37.45 ms              350
 TCP upload avg :         0.88          N/A Mbits/s         350
 TCP upload sum :         0.88          N/A Mbits/s         350
 TCP upload::1  :         0.88         0.97 Mbits/s         350

    New version (v9):
                           avg       median          # data pts
 Ping (ms) ICMP :        11.07        10.40 ms              350
 TCP upload avg :         0.55          N/A Mbits/s         350
 TCP upload sum :         0.55          N/A Mbits/s         350
 TCP upload::1  :         0.55         0.59 Mbits/s         350

v8 (11-Mar-2025)
- Fix warning messages in v7

v7 (07-Mar-2025)
- Separate into 3 patches to avoid mixing changes of documentation, selftest, and code. (Cong Wang <xiyou.wangcong@gmail.com>)

v6 (04-Mar-2025)
- Add modprobe for dulapi2 in tc-testing script tc-testing/tdc.sh (Jakub Kicinski <kuba@kernel.org>)
- Update test cases in dualpi2.json
- Update commit message

v5 (22-Feb-2025)
- A comparison was done between MQ + DUALPI2, MQ + FQ_PIE, MQ + FQ_CODEL:
  Unshaped 1gigE with 4 download streams test:
   - Summary of tcp_4down run 'MQ + FQ_CODEL':
                             avg       median       # data pts
      Ping (ms) ICMP :       1.19     1.34 ms          349
      TCP download avg :   235.42      N/A Mbits/s     349
      TCP download sum :   941.68      N/A Mbits/s     349
      TCP download::1  :   235.19   235.39 Mbits/s     349
      TCP download::2  :   235.03   235.35 Mbits/s     349
      TCP download::3  :   236.89   235.44 Mbits/s     349
      TCP download::4  :   234.57   235.19 Mbits/s     349

   - Summary of tcp_4down run 'MQ + FQ_PIE'
                             avg       median        # data pts
      Ping (ms) ICMP :       1.21     1.37 ms          350
      TCP download avg :   235.42      N/A Mbits/s     350
      TCP download sum :   941.61     N/A Mbits/s      350
      TCP download::1  :   232.54  233.13 Mbits/s      350
      TCP download::2  :   232.52  232.80 Mbits/s      350
      TCP download::3  :   233.14  233.78 Mbits/s      350
      TCP download::4  :   243.41  241.48 Mbits/s      350

   - Summary of tcp_4down run 'MQ + DUALPI2'
                             avg       median        # data pts
      Ping (ms) ICMP :       1.19     1.34 ms          349
      TCP download avg :   235.42      N/A Mbits/s     349
      TCP download sum :   941.68      N/A Mbits/s     349
      TCP download::1  :   235.19   235.39 Mbits/s     349
      TCP download::2  :   235.03   235.35 Mbits/s     349
      TCP download::3  :   236.89   235.44 Mbits/s     349
      TCP download::4  :   234.57   235.19 Mbits/s     349


  Unshaped 1gigE with 128 download streams test:
   - Summary of tcp_128down run 'MQ + FQ_CODEL':
                             avg       median       # data pts
      Ping (ms) ICMP   :     1.88     1.86 ms          350
      TCP download avg :     7.39      N/A Mbits/s     350
      TCP download sum :   946.47      N/A Mbits/s     350

   - Summary of tcp_128down run 'MQ + FQ_PIE':
                             avg       median       # data pts
      Ping (ms) ICMP   :     1.88     1.86 ms          350
      TCP download avg :     7.39      N/A Mbits/s     350
      TCP download sum :   946.47      N/A Mbits/s     350

   - Summary of tcp_128down run 'MQ + DUALPI2':
                             avg       median       # data pts
      Ping (ms) ICMP   :     1.88     1.86 ms          350
      TCP download avg :     7.39      N/A Mbits/s     350
      TCP download sum :   946.47      N/A Mbits/s     350


  Unshaped 10gigE with 4 download streams test:
   - Summary of tcp_4down run 'MQ + FQ_CODEL':
                             avg       median       # data pts
      Ping (ms) ICMP :       0.22     0.23 ms          350
      TCP download avg :  2354.08      N/A Mbits/s     350
      TCP download sum :  9416.31      N/A Mbits/s     350
      TCP download::1  :  2353.65  2352.81 Mbits/s     350
      TCP download::2  :  2354.54  2354.21 Mbits/s     350
      TCP download::3  :  2353.56  2353.78 Mbits/s     350
      TCP download::4  :  2354.56  2354.45 Mbits/s     350

  - Summary of tcp_4down run 'MQ + FQ_PIE':
                             avg       median      # data pts
      Ping (ms) ICMP :       0.20     0.19 ms          350
      TCP download avg :  2354.76      N/A Mbits/s     350
      TCP download sum :  9419.04      N/A Mbits/s     350
      TCP download::1  :  2354.77  2353.89 Mbits/s     350
      TCP download::2  :  2353.41  2354.29 Mbits/s     350
      TCP download::3  :  2356.18  2354.19 Mbits/s     350
      TCP download::4  :  2354.68  2353.15 Mbits/s     350

   - Summary of tcp_4down run 'MQ + DUALPI2':
                             avg       median      # data pts
      Ping (ms) ICMP :       0.24     0.24 ms          350
      TCP download avg :  2354.11      N/A Mbits/s     350
      TCP download sum :  9416.43      N/A Mbits/s     350
      TCP download::1  :  2354.75  2353.93 Mbits/s     350
      TCP download::2  :  2353.15  2353.75 Mbits/s     350
      TCP download::3  :  2353.49  2353.72 Mbits/s     350
      TCP download::4  :  2355.04  2353.73 Mbits/s     350


  Unshaped 10gigE with 128 download streams test:
   - Summary of tcp_128down run 'MQ + FQ_CODEL':
                             avg       median       # data pts
      Ping (ms) ICMP   :     7.57     8.69 ms          350
      TCP download avg :    73.97      N/A Mbits/s     350
      TCP download sum :  9467.82      N/A Mbits/s     350

   - Summary of tcp_128down run 'MQ + FQ_PIE':
                             avg       median       # data pts
      Ping (ms) ICMP   :     7.82     8.91 ms          350
      TCP download avg :    73.97      N/A Mbits/s     350
      TCP download sum :  9468.42      N/A Mbits/s     350

   - Summary of tcp_128down run 'MQ + DUALPI2':
                             avg       median       # data pts
      Ping (ms) ICMP   :     6.87     7.93 ms          350
      TCP download avg :    73.95      N/A Mbits/s     350
      TCP download sum :  9465.87      N/A Mbits/s     350

   From the results shown above, we see small differences between combinations.
- Update commit message to include results of no_split_gso and split_gso (Dave Taht <dave.taht@gmail.com> and Paolo Abeni <pabeni@redhat.com>)
- Add memlimit in the dualpi2 attribute, and add memory_used, max_memory_used, memory_limit in dualpi2 stats (Dave Taht <dave.taht@gmail.com>)
- Update note in sch_dualpi2.c related to BBRv3 status (Dave Taht <dave.taht@gmail.com>)
- Update license identifier (Dave Taht <dave.taht@gmail.com>)
- Add selftest in tools/testing/selftests/tc-testing (Cong Wang <xiyou.wangcong@gmail.com>)
- Use netlink policies for parameter checks (Jamal Hadi Salim <jhs@mojatatu.com>)
- Modify texts & fix typos in Documentation/netlink/specs/tc.yaml (Dave Taht <dave.taht@gmail.com>)
- Add descriptions of packet counter statistics and the reset function of sch_dualpi2.c
- Fix step_thresh in packets
- Update code comments in sch_dualpi2.c

v4 (22-Oct-2024)
- Update statement in Kconfig for DualPI2 (Stephen Hemminger <stephen@networkplumber.org>)
- Put a blank line after #define in sch_dualpi2.c (Stephen Hemminger <stephen@networkplumber.org>)
- Fix line length warning.

v3 (19-Oct-2024)
- Fix compilaiton error
- Update Documentation/netlink/specs/tc.yaml (Jakub Kicinski <kuba@kernel.org>)

v2 (18-Oct-2024)
- Add Documentation/netlink/specs/tc.yaml (Jakub Kicinski <kuba@kernel.org>)
- Use dualpi2 instead of skb prefix (Jamal Hadi Salim <jhs@mojatatu.com>)
- Replace nla_parse_nested_deprecated with nla_parse_nested (Jamal Hadi Salim <jhs@mojatatu.com>)
- Fix line length warning

---

Chia-Yu Chang (4):
  sched: Struct definition and parsing of dualpi2 qdisc
  sched: Dump configuration and statistics of dualpi2 qdisc
  selftests/tc-testing: Add selftests for qdisc DualPI2
  Documentation: netlink: specs: tc: Add DualPI2 specification

Koen De Schepper (1):
  sched: Add enqueue/dequeue of dualpi2 qdisc

 Documentation/netlink/specs/tc.yaml           |  156 +++
 include/net/dropreason-core.h                 |    6 +
 include/uapi/linux/pkt_sched.h                |   68 +
 net/sched/Kconfig                             |   12 +
 net/sched/Makefile                            |    1 +
 net/sched/sch_dualpi2.c                       | 1146 +++++++++++++++++
 tools/testing/selftests/tc-testing/config     |    1 +
 .../tc-testing/tc-tests/qdiscs/dualpi2.json   |  254 ++++
 tools/testing/selftests/tc-testing/tdc.sh     |    1 +
 9 files changed, 1645 insertions(+)
 create mode 100644 net/sched/sch_dualpi2.c
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json

-- 
2.34.1


