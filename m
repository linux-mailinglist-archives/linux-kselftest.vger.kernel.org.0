Return-Path: <linux-kselftest+bounces-33142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2997AB92F1
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 02:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF4697B6DF8
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 00:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299E1A31;
	Fri, 16 May 2025 00:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="X5DqXhS9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891EF17548;
	Fri, 16 May 2025 00:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747353740; cv=fail; b=GSiNqPsA3us0udyF4DK0fJPuxnthLpnU44AdVxitR4RZ2jhvVssCUt2NASEx2/4KDXgxav+RxcVuHpxjxvvyIYVjway7W3uzV0Rz624l9va4R7lXEOQRTHwZfLmApP/xJKscnlhxQVvyFL57pgsNpRVGbVeH3hA4F20kXTxUUwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747353740; c=relaxed/simple;
	bh=Swqy7Bi7zWE/M8HjXjv84s1CMcZM0mC8do1qR1Qru2E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pA5b/wFY6r6c8MhKB0pym9ILSUSvz5dOcHIsvBAuke70m0pYBGC9fhVr+gUOYBwChJaaragtepeBEqyy9DLzAvqtNaG1W8QLqsL5lR8QCKz/GkvMBLEougb3yaJ1SwVXLUthwotBWGqD0mGsQ9iWtDWayaGCavhtSE6BtzanY3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=X5DqXhS9; arc=fail smtp.client-ip=40.107.21.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEPSXZ1a6E4L3cM+rhOfgqv40UoIqU3uOjfzmxeUitCaMBz4LlhLL0ZAOHn2/s8m7VzhQpXAydcxbjNonYfssO8pJshQj+nJFff90zWET4d4z0d6DfKBOXjXE4DOqMmXKd/R8ROMlNwCpU7mzSjybnU7vdFVVXJi+YYKe5uaXmc5SlO5celNX5OYYiiAzJAnRRPU7Wo79tegtSWBvCe+n6/IxnV1KEj1cRlbN5XxwcA+5YTVgCqlpuZracotNk/AThRjNZ59QGjc9+NKLPKFHVnECbXxW1sZUPAJXatK+zigd+Y/XMTvd/SY+ihHHkdiC0f/TPTsrUUT7SjqnTsDPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCqjx/iyu2BGmlskyliOrRKrx+gVFCV6a6GRu18B/eM=;
 b=uS7tLtdch/2FA5imVZR49M3IyRstVtxejUvHoZvGHv/5xYTKiH8ALJHxHFIJ4CWyMoPLp/qz4Xt+3/v3Ul4YuW2IfUiWEjFu+hd2edtQTPff7TEQmYCXIm5a9dN/g5i2inhfBhxW3hjEQIStY5njmndydiPHV+Qpvm8Uq/G/RXK7UBDgJDUJoLlyyH07ZfQWfz0t1aaB3GP3fy0a6SYOwmOIjMhEyHZQSZOfAXzCmDTXhtSQTQ6rSfWXBBqch2M+kj540lRhRf4/TdFaxukPcizp2+HBbo4n3W1OvXUdghEy1bxzz3BKxKaZ/pIezVmFK/ymfZzY4tkHTBdmw4jwOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCqjx/iyu2BGmlskyliOrRKrx+gVFCV6a6GRu18B/eM=;
 b=X5DqXhS9Z2zDPihA9Ff0EjRcHh6hAfwD8x49X1o0Vd1Glp/HG67XQJ7u1/lQ4Esx220E9GkNwH5Er4tq4cuEcEmEbGKruOWj9bYZ39jyEytKYrjHKDBrsbEB9gHILl5/2dROEA1QDTMwTorgtd+QyB3d9MiYDVlI6UC024Ti6CpXKIgx87BS++vtjYFgXOMdzYaok0woNUnWtzTYcm1aP3nJDQHi//x5VY62+shTQ67osXP+1FvnX4MUqzKmkobsrShnrUazD4jQjI4mcI7B27MUIXnX4uQ74h4fRfW2nv8RNq8fNh918l+kWlgTdvq/NK+U62ILQJTc98JhdC1fmw==
Received: from DB7PR02CA0003.eurprd02.prod.outlook.com (2603:10a6:10:52::16)
 by AM8PR07MB7347.eurprd07.prod.outlook.com (2603:10a6:20b:235::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 00:02:10 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:52:cafe::11) by DB7PR02CA0003.outlook.office365.com
 (2603:10a6:10:52::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.17 via Frontend Transport; Fri,
 16 May 2025 00:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Fri, 16 May 2025 00:02:10 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id C2B72200D2;
	Fri, 16 May 2025 03:02:08 +0300 (EEST)
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
Subject: [PATCH v16 net-next 0/5] DUALPI2 patch
Date: Fri, 16 May 2025 02:01:56 +0200
Message-Id: <20250516000201.18008-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|AM8PR07MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 711bff58-abf7-4434-8e7e-08dd940ce7b0
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WHpheEZDdE5xMDA0MG81Z2VWWHNSaDAyMVZ3aHZKcG40MDBpZHVBQUdvYWtE?=
 =?utf-8?B?VUtoZnVFZ2VzbEFkUml1czJPYmx1OVN5Q3VLclVpYVZLc0llcWc2cjNFUW5G?=
 =?utf-8?B?Zy9aUWtaOVJZMkZ6TEI5T0d2YnlWblNlN0laVlNmRlFjQW5JYzNLSjBnRU1k?=
 =?utf-8?B?RHNuTEJsSFdwRVBtQ1ZMK0lnQmo3dnd6NTN2WnhkQXJwMVBsallqOUJOMzh1?=
 =?utf-8?B?cVhMZEg3eEZuWnlHaVhjNzcyNG9sU2tTS3ZVRE1GWjNkUy9jVXQyaXQ5MENL?=
 =?utf-8?B?cWdmN25EQk1XaEg1aFJSdGI4ZG0yQkFDTWtROGtQTHZjcTAyVVMxYXlRV2VH?=
 =?utf-8?B?KzIrU0lzVTZqRlE0MDkvSUFsc1lHaXU5N0diUHQ2eUdEcVE3c0NIQTZUZ0hG?=
 =?utf-8?B?MGpyaFY4emJ4eVBXaUhlNmxVZXRkeDdvVWN3RDhFbXpRcE85OGszTzhUWHFp?=
 =?utf-8?B?bzJvVU1GbFJZQUVuTkZhUVBJZFdpQmhNaXFWSEdXMHBCZ3M2c003ODQveU9x?=
 =?utf-8?B?OFUxeldSY1Z2YU1ETkVrcnVTTHpjanNtTFZkanlRSHlTcHBTdG1jWFZxNjJ6?=
 =?utf-8?B?ZWtPelB4SHE3ay94czZDa0JsaS9FUld1WERyUlBSdklpNnZWbjlXVWVTdDJL?=
 =?utf-8?B?RVd6WER6ZEJIQTZGNVBmcDVVeU1OeUVJcVFmZ25Fc0gzRGExWDlwVXJZd090?=
 =?utf-8?B?blRzQ0JhMVYzTG94c1hCUldORUplQnloWGJYZHlNODdGdmxiU0NRYWxOTy8x?=
 =?utf-8?B?NlU3SlNVTmp0L1dnRy9sc1NqSyt4T0hnVEZtTi9kL2t4a2ZnNkpiQ3NWdm5C?=
 =?utf-8?B?U2tvNElIOC92YUl2Ky8waCt0YmJXTU1OTGtzdXhGaVRHMlVNL3J3WjBPaGcz?=
 =?utf-8?B?NmltNGIxRVVQY1hsT01VOWhEb3lSOWRRcExMMmZMYzFNZ0duOXl4d1o5bVNt?=
 =?utf-8?B?VnpLeEJrUXc2cEN2ckRwVXZyKzMzUXFQNWdlcTQxR2R2NkRBL3JJZnZCbDQ1?=
 =?utf-8?B?aTZNRC9MY2wyeTc3MGRveDJiYmJLU3kzRnl6aDkyM09xT1N0MVNOMXVUdi9F?=
 =?utf-8?B?d1grc09XRDZUWDl3VGs3UDgyV3JIdFQzc1NBanpKSkEzZFZQcXZUckZzNXRm?=
 =?utf-8?B?NmFqTmdnditXRENZWDRmUEpsb1Y5a2lxMS84MnBBSVFabjVxYVBCZVF3SU9M?=
 =?utf-8?B?bGNZWUI4SlZ5UHNoNW9ZcG5mL2dXQ0l0dVRJalpXcmVrQktxWmZjV0YzK01a?=
 =?utf-8?B?ZTlVU0pRNy9jdk5YRkNyYzVuK1F0VEwwYlNQZUZyMjlwQWpjY211YjgwNnNF?=
 =?utf-8?B?L0xmUUVjbGxSRUZ4R3RMbkZ6TmRjaWJhYUs5bVRjNER0UEJZT2lGNU1nUXIr?=
 =?utf-8?B?OWpjcTBucUY5SGRoS1ZlZ1FMa2JncTdXSllIRHRuY1paYVdoQmVZZnJvV1Vh?=
 =?utf-8?B?Z0p0RnQydytNOXNGbGxvbDFZaW9CTU9ab3pic0J4Z3RodDI2KytaaFRsMUJJ?=
 =?utf-8?B?VTNFT1QzL1BiNUFPUUgwL0VmYWN0aDhzd2F6S3JLeEpibGg5dUdhN1k0UkIx?=
 =?utf-8?B?TGYrc1JrUUFlMGplb0VkMmpWQ29wbzdPQUFJenJKSDI5azF2MHJQM0VNUGhV?=
 =?utf-8?B?R2xpSHpSZzZadW5GZFNFcjk4dEZxYUlSTG15SkMrRmEyOWs2cTlrdHVPaVFK?=
 =?utf-8?B?T3UvRWZtUjZIQ2ViUXJWTkc3bG5DU2VCR2h0WmM5NDV4dlhlQnR0djNObFN3?=
 =?utf-8?B?SmNyWVhUektIU2xINnNNWTlZeXYrQXkwRDE3TllvUWQ1VGo2aklLVENXaGpN?=
 =?utf-8?B?UzFnMjRtYkdDVjFSRU9MMW4xaURSS1NmN3JRblZwdmVCb3B3YS96VjEydmU5?=
 =?utf-8?B?eERsby9Bb29jNWZUVDF3VkFEYnB4NXR5UWx2aDFNMFEvdlBkQy9nVXNPTDli?=
 =?utf-8?B?elJxUlVISE1oL2JLeWVqUkl3RXB0N2oxMjVucndEWTZBZFQ1clVKbk5LWGtw?=
 =?utf-8?B?dDVyeWR4NGdFTUwvTURCWEpINE9BS1JIRnFhYUVzd05lZVVtbjhMaVVmVUZO?=
 =?utf-8?B?SXB6YXhrYjRCejlOdEt1VVhHY3VROVE3dVZXdz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 00:02:10.1640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 711bff58-abf7-4434-8e7e-08dd940ce7b0
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7347

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find the DualPI2 patch v16.

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

This patch serise adds DualPI Improved with a Square (DualPI2) with following features:
* Supports congestion controls that comply with the Prague requirements in RFC9331 (e.g. TCP-Prague)
* Coupled dual-queue that separates the L4S traffic in a low latency queue (L-queue), without harming remaining traffic that is scheduled in classic queue (C-queue) due to congestion-coupling using PI2 as defined in RFC9332
* Configurable overload strategies
* Use of sojourn time to reliably estimate queue delay
* Supports ECN L4S-identifier (IP.ECN==0b*1) to classify traffic into respective queues

For more details of DualPI2, please refer IETF RFC9332 (https://datatracker.ietf.org/doc/html/rfc9332).

Best regards,
Chia-Yu

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
 net/sched/sch_dualpi2.c                       | 1127 +++++++++++++++++
 tools/testing/selftests/tc-testing/config     |    1 +
 .../tc-testing/tc-tests/qdiscs/dualpi2.json   |  254 ++++
 tools/testing/selftests/tc-testing/tdc.sh     |    1 +
 9 files changed, 1626 insertions(+)
 create mode 100644 net/sched/sch_dualpi2.c
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json

-- 
2.34.1


