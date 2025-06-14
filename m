Return-Path: <linux-kselftest+bounces-35005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0450BAD9E21
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 17:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F43017544B
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 15:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776591A7264;
	Sat, 14 Jun 2025 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="mdRVIpyo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012070.outbound.protection.outlook.com [52.101.71.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55B31FC8;
	Sat, 14 Jun 2025 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749915755; cv=fail; b=VUzXuj+6grrjhE/DCa0n2AybKQ+y4gnbz7MVGSpGIrkWbH9smOhEKvw/iE9t5JFBiUTF5jnGRuCXgNe0xuMYVNf7yjxwIMj/vZeJnBBWeHy0x4Tezh/tJx23e2yQ1s0ykHqGVxBD1L49Kc6lyJGzKlJf1DkW11BLJhOAhJFfqjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749915755; c=relaxed/simple;
	bh=JeWwi+blu4AMARk/sapqVCOlYAGTPs/43XLYygCn3t4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MjbRPvXlLZDWHschuIBnPtC/9b/lfYzirJL6vzccjYT2hWcC0/sUm2ZF6bbRW99Ex1YSlvXTN6Lgyf7g8eBD9bPM9Z38iDMtUiJdOhlJGGuJWX2KJhkZjWuVPRueUZKm/NZ0du/EP25S3bvCUqye8+NrVEM4bAIHn/lbX0pyCzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=mdRVIpyo; arc=fail smtp.client-ip=52.101.71.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrEbjqrIM13FAaeq1YeQxpZ8fJDxlgVUp5Vk7UEM60PRD4WmDNhcxgRjqomQUGh1M+tQHuZUL7xbLBgErNJSUwZRdW5H5A+83iXyfYMU/54KATp6Bs+yGRj1BkypRdFN9OyjUSMlcnXZ7Q0FATFcZjBAygb+vSAhi6UQskXx9FlquA+scmy9un2fqEQKy3/cSfRfxhKM6sddw6JeWPX2H4JDIuSvhRQJgiULRh6dnxi6fkPHr33FFQ225EAe6Ae8JYWQF3x8xCpuuz5ApAGKOnm9YfT/Ba3vkemw/3VSVuZX8EnP3ydYpLSgdVCsHfIIVziJXkTaorqaYvuBxV9tlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvUB8jWrxylLRXsJdpwTPxaL0MNHaPCOgep0kvJojXs=;
 b=UYpkIAQLDmSNYoF21UfErBwasiewPCEiF2QblPDGjJLVQQZNymA0AO49OlbY1oSWg8Whho+5/HiHZk6SLsXuwO3e/TPGRVKDXUFo4RdX79EhPX3ElQD3E7qzeviYjHLuOnb4EkNt1ovulH7Eq2FBbxf2Z4a8oyVQHNbiybr91QFH6JDkq+1CzpbbSRt2axVeDIHW0JzpEmaMM3L8MpsRD0+dxk4ayHwIx668XKBR5tiSrIYxV11/2VuIrW9qSBWZnaCd1yHpzyPBVdEE6blL6omNTG0Qi4fl0RehHp4Ly5y82N8zlAS/XH8TrJCyvzIaSgTPsXoIX8vzjIdwXcf8xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvUB8jWrxylLRXsJdpwTPxaL0MNHaPCOgep0kvJojXs=;
 b=mdRVIpyoiDH961REt7lSyv8MLTYtaney1PleuoieF7gfdh3d9V+eBp7Ih5TfPjPyVncG5hMS9sQmVY+7aAcJXhL2I6cgLwwyiokzoglCGQ9gU2LpF78l3jbnHjxL2EfZ6oYc8GxgXUHZ1qsNAm3axGAyx5V1ve+845UqsNUcsb5G1ujR5c1J7ZAf/QLSwlQn6OdKoAG60e2U5rUyUjboTZiiGIV9b2iaguQZ5qXLv0iI8fSCnApc1Nj5wAx8t7HseCJaDYw2DIXoJbE4+H9c09GufpKB5OUponFuMvm2RVFUhGK8DeN9uXJfnQZHKapBlR3u+sU7P6eyXfLvUfwvag==
Received: from CWLP123CA0247.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19e::9)
 by PAVPR07MB9287.eurprd07.prod.outlook.com (2603:10a6:102:313::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Sat, 14 Jun
 2025 15:42:27 +0000
Received: from AMS0EPF000001A2.eurprd05.prod.outlook.com
 (2603:10a6:400:19e:cafe::35) by CWLP123CA0247.outlook.office365.com
 (2603:10a6:400:19e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Sat,
 14 Jun 2025 15:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF000001A2.mail.protection.outlook.com (10.167.16.235) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Sat, 14 Jun 2025 15:42:27 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 977041C0033;
	Sat, 14 Jun 2025 18:42:25 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: alok.a.tiwari@oracle.com,
	pctammela@mojatatu.com,
	horms@kernel.org,
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
Subject: [PATCH v18 net-next 0/5] DUALPI2 patch
Date: Sat, 14 Jun 2025 17:42:18 +0200
Message-Id: <20250614154223.11026-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A2:EE_|PAVPR07MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a4d74cd-c16e-42b2-f800-08ddab5a10b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0JIaVdhMVJIcjI5dTlVNDN4VTZzQy9TVm9Ud0VoRFMxZ2lkQ2lmTm5GLy9h?=
 =?utf-8?B?c3lpNFFHcHZuTmowM2hCK1d5TU5OcXc3OUwyMUZlS2F2L056UWNwRG04ZWZP?=
 =?utf-8?B?ZlA5SnBxbDEyS2h6U080OWp1ZERhUmlWVUhFUEx6eHpFV0cvVFU3SmNlNWlT?=
 =?utf-8?B?S1dmcUptcy9nSVhUT1Yyd0ErTlRPcjdXNkwyMmVVU0xHeExwTEJoQURPTWhL?=
 =?utf-8?B?U3IyNll3R3JFL3lLNmhMU2NicmREQ0Z2UW1WUHRoQ2pJTU5JTm9PZzdUNkdW?=
 =?utf-8?B?eEVPWlVnZ1B6bHBTcWhRdzFsWXlRaXloRU41ekxKZ0N4TDd6NVJJV3VUQnRZ?=
 =?utf-8?B?OWZzUVMzdTF1Z3dTVCtUcEtZeVN2SjRMMnp2RjhRa0x6ZFpBOHp3UElOV28y?=
 =?utf-8?B?aWRSTERsMkhLR1VZR3ZtT2NCSjNBQm5paU5pNit2SXdOQjJ4UEhhMFNCU3Nr?=
 =?utf-8?B?Z0kvK2ljREhFNTl1ZWcwMXhzZTMxNGs3ZWJaZWRpZERraVY1TkpoREJXdG55?=
 =?utf-8?B?SWNHN3IxTzdWKzJnSGkwR2ZEN1BVTUcwS0VEZ09zRHRGU2s2UEdqaWM3UEZr?=
 =?utf-8?B?Tm10SXhhOXk4WWxQQXlsUU1vcEUwVyswYU1oWnpJckJvZm5IRGx0WHRUckdy?=
 =?utf-8?B?cW5CWS90czdGdWMzSnZtc0tTNDNpamZQL0dqOGxPa2pVbGpyNWhvZng4YjVJ?=
 =?utf-8?B?dDlLMU9lbnJEQ3pkVHdkNjBOUzNsQmZ3N2JhS2dMTll3aTZVRWg2TU9mZzJO?=
 =?utf-8?B?VkVGYjBkbFBkQ3poWnk3Z2tiSFMzWlc5ODdieUFsUGJBUU1sNldWbnRtQVpC?=
 =?utf-8?B?RWNaZTBIYnlYSlhCaEVucFZmTlVqMXJxTm5jTzY5MnI1c2ZaSzJ5Yk0wN1h2?=
 =?utf-8?B?VHlOTkNRU01WVFIvV1BmR0s2ZmFpY3pCck4wWHp0TmQyT2ZmQ3ZKSnVtblJL?=
 =?utf-8?B?M3I1UWtESFozdXVRVi9qV1JVcktxUUl2S1JRd1h2Q0lzTDQ4YTNKVDl3YTBl?=
 =?utf-8?B?SzlReHczK28zTS9lNVVqZktIMGpuZW9ORUlwVGJYRmVwNmZjRDFPNXFFaTFP?=
 =?utf-8?B?SlpSbDljVXJEYkhsdkMxLzI3UjVhNWg2UHNjNk1TcmNUVXV2VC92RU5MOHZ4?=
 =?utf-8?B?K01tZ29BUlFTb3ZEM2Z4VmNNbXdacjBoem9jSzVuWXFNa1gzQTZzUDFnNmsw?=
 =?utf-8?B?Y1U3azRVUVd5Vms3SysxL0xXbnNKNUpGMDZUKzdwV01MSzFJQ0liOG5vS1hK?=
 =?utf-8?B?a1ZjUDRPMW5qMStOM1FWNkpEWEdsQllMZDBTNEdENjdiOU1aMXVMa1NMR0xm?=
 =?utf-8?B?bTFLUEc5ZXFVc3hhbTUrQjAwMWdBYW1qdjVFLy9NNkdwNjUxS1U2L0lKUkZY?=
 =?utf-8?B?UW9zVWo1LzZ3UThtNnBTbnhQaC9iVmFqQVdTQ0pDMGxIcVRBU3A4RmhIT2p3?=
 =?utf-8?B?OGlqdTRuYzZiMmlXRll1QlVweXc4YkF5alQ0R2pmVDNUcit0SU5QWW1KL1BH?=
 =?utf-8?B?YXZ6UjMySEp0eGxGWjE4UHloc25vUjhBY29uR2hEQlRiUGV2OURCNDM2N0ds?=
 =?utf-8?B?QU1takthZGlneE5zRFFvQVgrdmdSTzhEeUc3YWRwSGEvK28ycENqTCtCSE54?=
 =?utf-8?B?NUV1VkJHbHYvb1lrSVFDSnhHQmgxZVh0ek5wNVR1SlptWHoyVStCem5oVmRu?=
 =?utf-8?B?dkxDa3Z3WXNlRzE3NW5VK2FXSU1lUGMwOVN2YUVjenkzd0dYcnpqdjkyeGwz?=
 =?utf-8?B?U2hwWXVybkdWQWhCVm0xcUo2TjZmSjlLSHFYbzJHUTlaRCs1VFMwN0ZIZTJY?=
 =?utf-8?B?YWgrRVdhalNocEZyYjRERFc1R3JkbEszNjRLTWZBemRBdnhpcG9GdkRWV3Ez?=
 =?utf-8?B?S2IxWVpQNHgrUlRmU2dNb212MGpjbXF1YUVXUlIvQWZ6ZjhLRkRIc2kzV2I5?=
 =?utf-8?B?NWZPcERmSUdUalRuQ2s5YXRmanZiWUNCTmp2aXc4MkptQkR6c3JrOWNlN1Zw?=
 =?utf-8?B?TThRVEIxRkJwc0FvQTFrWENuSXQ1aWtRRjc1TFZrSVlyMHZ0RVhDdjIyVUlp?=
 =?utf-8?B?bEh0WmJHckNpNFpzT2xENVdCYU11d2ozaTRyQT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 15:42:27.1297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4d74cd-c16e-42b2-f800-08ddab5a10b1
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR07MB9287

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find the DualPI2 patch v18.

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
v18 (13-Jun-2025)
- Add the num of enum used by DualPI2 and fix name and name-prefix of DualPI2 enum and attribute
- Replace from_timer() with timer_container_of() (Pedro Tammela <pctammela@mojatatu.com>)

v17 (25-May-2025, Resent at 11-Jun-2025)
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

 Documentation/netlink/specs/tc.yaml           |  161 +++
 include/net/dropreason-core.h                 |    6 +
 include/uapi/linux/pkt_sched.h                |   70 +-
 net/sched/Kconfig                             |   12 +
 net/sched/Makefile                            |    1 +
 net/sched/sch_dualpi2.c                       | 1146 +++++++++++++++++
 tools/testing/selftests/tc-testing/config     |    1 +
 .../tc-testing/tc-tests/qdiscs/dualpi2.json   |  254 ++++
 tools/testing/selftests/tc-testing/tdc.sh     |    1 +
 9 files changed, 1651 insertions(+), 1 deletion(-)
 create mode 100644 net/sched/sch_dualpi2.c
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json

-- 
2.34.1


