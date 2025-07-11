Return-Path: <linux-kselftest+bounces-37120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D0CB01F26
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 16:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CFBD3B6642
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 14:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7662BAF4;
	Fri, 11 Jul 2025 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="IpGjRj4I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFA7FC0A;
	Fri, 11 Jul 2025 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244341; cv=fail; b=EhPD7rIaCM51B5Gxdlixgcp0lDy9QWo55SULkjXpQRf5UMq2Con7BGh83X/RKYsNSWNbkFugXg5D8r1eywrmy52QioLOmeOYI/tFrcKZ/koiBarS1QCE9tzGHgyK4KFAY4ROisYaBTb3tRugUlLqTvRMlz3vjappgtt6qrFtzls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244341; c=relaxed/simple;
	bh=Ufyh/8zjLCDaePrp1GcddPUV1gBwDzcOg4QJfaTtWlo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=i47gd3cgt032DE/yqVlSaXKxyGcwEQvTL5ssj2NbiKeqTR17JILKN7KlziIj5jasiTDmGBXSmwuGapjLXztcPmEXxTCvWRzP0etPELgjj9/sKKmNoPGekL4veBOhihhEd9FrsbvEnGJjARSNCl2BFokdgNYIU5Tx33n6V7HIx9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=IpGjRj4I; arc=fail smtp.client-ip=52.101.70.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLLbzLA12hJkTHgWNl5iyKPCTQJhirsYqgoIY1ou7YeA8Rst13WaFSL2UA7gvgQb2KXzZssD5GNrj6fepPTFNBMwBSe/SNzGlBvnx0x58DE/CDWGEt2AlrOWbhZNTcTIqvBpPs+QIBH+gDb8bROGFMQY7fA5MH6J/Iv/MtDrQ+GXeI9CerJ0ckH8MqH7F+F+nEvAAe2AI05QpCbLbOd4tvuxrlvXLGz6IOkUSVdfWAGl1r/QSp7i+/L0EaHXHci1qBrteFJfJHgQlUOsJeGvDZZPdLHww0cqBRoMuBZpgqxFEgnVxWkYHxuFOCZIsoaRrsbNkxb3v4xjsGJib++mxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqh/3xnC2I5iOV6GI3liykgUHCNMwGM8cMesMVfNvLw=;
 b=dZK6Aorv60xrxBEG9nzuE2JhzcxMU6FbLcG5bPnFmRua9+TmRB7M1bewzwNKu4qZEzu/t9GbPIP04890jqkj2DC7dwGNOYqmy9nCM4bIa0A5kOtndtdu3AgFgODkyL6zKCCPfiPJQ5uYVgFXCTQkmY+ZqDZNNmetwdH1vMMqVAKMthxQgutxioHQ/o4jAV4VjLDpLmOaignMgexIkhya8ylK1fKy4Ee8dnvaEbO5wmQ/WvKeJ0pqrLttOMHlsqnoWlh6bxmMc5jGWYt5iIinobWK/UBHrTOkwhlseJrIy941ZOtIoUVHHtn/CEX511ztVCiWQWejjWbft5pozXnjZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqh/3xnC2I5iOV6GI3liykgUHCNMwGM8cMesMVfNvLw=;
 b=IpGjRj4IbcPhsM+1s/b3ZfJ2MVxHxyubmzFRXNY56GM1OvAXSIhskqHuizjX8k9kg5pAA8OnThNk1KwJDiC1rBM6vcAvVhCvr8O/Rv8fLHrQBT+9ZbqiNCv5y/LpdUyVCo+wdJVvD/Z1eJBJ5GUVmrbmScoKxQivBQ9r7yK5zYVz7RyBM+qAyHkhTyWLzOOdOl/iarx6XvyrKb7Vmo1DKII4e8jojvekyKxtUzikmiGIUf0z1K5IQZ7iJ0VqtLNXw5RKbl1AmD1pjPA8djB91RtBuU/qD5aufZ4LidsWxH/n0+jryJDCPluK0Bqm270QlmiMS9rHk8tP696s3C8sXA==
Received: from AS9P250CA0009.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:532::18)
 by VI1PR07MB6656.eurprd07.prod.outlook.com (2603:10a6:800:187::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 14:32:16 +0000
Received: from AMS0EPF000001B5.eurprd05.prod.outlook.com
 (2603:10a6:20b:532:cafe::31) by AS9P250CA0009.outlook.office365.com
 (2603:10a6:20b:532::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.26 via Frontend Transport; Fri,
 11 Jul 2025 14:32:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AMS0EPF000001B5.mail.protection.outlook.com (10.167.16.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Fri, 11 Jul 2025 14:32:14 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 80D83680033;
	Fri, 11 Jul 2025 17:32:12 +0300 (EEST)
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
Subject: [PATCH v22 net-next 0/6] DUALPI2 patch
Date: Fri, 11 Jul 2025 16:32:02 +0200
Message-Id: <20250711143208.66722-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B5:EE_|VI1PR07MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: e02a0cbb-9330-4729-cad4-08ddc087baa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzhVV3FmeWNJZkZvQ0xySXd2cldDTXJ4dnFnMllZdzh2eWJtUEk4cjdtOUc3?=
 =?utf-8?B?SVpsVGV6RjVNUXBlWjNyVmFUUDZEZ0lrUVFJVVhuU2FqMHVtOXJOU1RtU0px?=
 =?utf-8?B?cFRHamFQK2NXdWpyd2djQ0RWeUd2dHR3VmZwVWJJZmVac1RpQmttZlYrZmJQ?=
 =?utf-8?B?ZUZXMVNKa3dhUG9ib09kbURXcko0SEF3U1RmV3UyOEpXaFdhM0h0OExxeGh0?=
 =?utf-8?B?cG1YUzJRUFRNVzZzWi9SWStMazRGOERwYjdjcmJWNkcvMFdXYzdLNGkzZDZ6?=
 =?utf-8?B?OXRQMmI2cnRMY0Y1d2ZoWlVDR3F4ejAvS2pSSUxJNGlhWW5TVVE4eTRWbkln?=
 =?utf-8?B?NUhyeVpWaERUZjVJN2FoYUIrMlduVVJGbnRubEo3Rkc0aVI3L0lXWHRtR1ZF?=
 =?utf-8?B?SWg1MEVYMnI0Q3FQdWF0bENjUHlQckRjL1RWZDRSd2FqSUlYSTA4dmF6QThy?=
 =?utf-8?B?TjF1VjdNMEtxUytLQkF6L05HQXRYYkdROVZtT3JXYkxvVTVFdW9jR3dQMlhu?=
 =?utf-8?B?TFQ5VUhlWWNacnMwcm1aV1dFa3Q1MDdmTklITG9JejJSWGxGRTVjTVZORjJx?=
 =?utf-8?B?aStqZ2dvaVp6blRFb0NSdXd6eXhlNGZqbTFmUUgvMmNRdWh4ZVo1UWl6cVhq?=
 =?utf-8?B?TTQ3d3pKWlU5eUVybTVPdUZhQkc3QndjZHVUYm1CU2xmYkZobTJnMmoyRFpH?=
 =?utf-8?B?OGJkR1NiQ3FRdkl4ZFdpVTAvbmpQNkZsYkxDdTU4ZVpYWXlQb3AwbVF6YTJ0?=
 =?utf-8?B?SEZlbkNBSllHLzg0U3FXd3Z5cDdhZ2JLUjJUZG85aGZ3NlhpY1E5RTJFeUxY?=
 =?utf-8?B?UW96ZDNvVW0ra3piUEhOVlFia2hOK0o4b1UwaFlqR1UyTDhXRTBwZnZaZXJJ?=
 =?utf-8?B?bmUySHJveUFLTExUT2sxY2dSZHF4VnYxMXF5WTltcjU3K29Hd0ZuWVZNVEpV?=
 =?utf-8?B?c2F5Zmo0RzB4Z00rWVVaVWJYNE5sVys0UWVNcmVXTElKckk5WDlQY0txZVNy?=
 =?utf-8?B?ZHNXVHA4cEZ3UTI3LzJtWmtBZmZvYWcyZDloL3cyaGIzQ1RFUVUwTFY4dG9s?=
 =?utf-8?B?UzdoT2VFcXNXQm45RzYzRFVncHRaZC9EWVoyVm1OQmxSYkN4WWhpNlhxYjRZ?=
 =?utf-8?B?cGx5OEVTZTFrV3dwRnl4UGZaeExrVDczakdPUDRuYXBydVoxSXdsZjJLNHNm?=
 =?utf-8?B?U2pzdi9HMGQxYmI5UTNFV1o5RFExNS9ROEkzN3VPWlNpVTNFUTJ2cEZoMEx3?=
 =?utf-8?B?cUt6NkdselhyOWl4ZzA1aFhsNWdhYlBlcXVmQlliRHlaOXdsdHFxdWxQYW9H?=
 =?utf-8?B?ODFYV08rMTNHKzJ5YTViZndyaW1mNUU5MUszZEhMeTN6WWNnTXV2SmhvWXNp?=
 =?utf-8?B?dlNrVzlURDhodms0MnZjVFluSmZWQ3RBMjRvaXFRUkYvV3FBcUpaMGt5b1or?=
 =?utf-8?B?ODk1NzVlOWhlMlNCWkx4cGtZMU5LMTdPL2FONkhJQzJiUWJwc2Q2a01FaEJY?=
 =?utf-8?B?c2E4RURkVnU2bFBUNDArRUJEVXpxcjJ4Vmw3VllBTjJkaW12am5TdjBvTVBl?=
 =?utf-8?B?ZENxR1BQSkExUWluODZHY0lmbWJuK0JIcDVOemFuejdHOFlZQWNZb3ZKQ0R5?=
 =?utf-8?B?clpmcFgya0d4YkdDa25pdjREejhtSHdXK2ZzVlhrU0lMOTZQTzR4b1lSRHVq?=
 =?utf-8?B?MVdQUjdLNnhENVJVWUp0eG43cTB1ajdMTjE4L3h1MjE2T0k4NTJIMHNXNi81?=
 =?utf-8?B?QUUyd083WTJhRWFyVFA1Q3VlZDRBVzJ4TWlHaUdDclZYd0VrNXg2b3RndVdt?=
 =?utf-8?B?WkVpMEd5NjVrMlBBaFdYYW5DK1h6cWtycEJsQkVvcGljVUpmRWNjMGZrdDJq?=
 =?utf-8?B?M29TVDJidkJyTHRzOWs5QWtGNkhzQVB2K3JLVVRBbWRoNk1QcExZWDUyZDJI?=
 =?utf-8?B?eG1Id29xbFQ1am5kdzcxQVY1dlJkRjN6SmxTQkYvL1dwU3Y3bzFHNkExN1dN?=
 =?utf-8?B?NWxCRXJ2TG9mNkxVQnFDd3ZkaGVIQVUvbmQrdTRxTU13WnY3RVQyc29pWVpx?=
 =?utf-8?B?ZmRnamhQcHJQU28yMDlDWEE2cjluZHd6WE1sT0pLUHdkVGRtTXNQcW1HZEYw?=
 =?utf-8?Q?lWhM=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 14:32:14.0197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e02a0cbb-9330-4729-cad4-08ddc087baa3
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6656

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find the DualPI2 patch v22.

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
v22 (11-Jul-2025)
- Fix the issue when user provides an empty TCA_OPTIONS with no nested attributes (Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>)

v21 (02-Jul-2025)
- Replace STEP_THRESH and STEP_PACKETS with STEP_THRESH_PKTS and STEP_THRESH_US (Jakub Kicinski <kuba@kernel.org>)
- Move READ_ONCE and WRITE_ONCE to later DualPI2 patches (Jakub Kicinski <kuba@kernel.org>)
- Replace NLA_POLICY_FULL_RANGE with NLA_POLICY_RANGE (Jakub Kicinski <kuba@kernel.org>)
- Set extra error message for dualpi2_change (Jakub Kicinski <kuba@kernel.org>)
- Drop redundant else for better readability (Paolo Abeni <pabeni@redhat.com>)
- Replace step-thresh and step-packets with step-thresh-pkts and step-thresh-us (Jakub Kicinski <kuba@kernel.org>)
- Remove redundant name-prefix and simplify entries of dualpi2 enums (Jakub Kicinski <kuba@kernel.org>)
- Fix some typos and format issues of dualpi2 attributes

v20 (21-Jun-2025)
- Add one more commit to fix warning and style check on tdc.sh reported by shellcheck
- Remove double-prefixed of "tc_tc_dualpi2_attrs" in tc-user.h (Donald Hunter <donald.hunter@gmail.com>)

v19 (14-Jun-2025)
- Fix one typo in the comment of #1 (ALOK TIWARI <alok.a.tiwari@oracle.com>)
- Update commit message of #4 (ALOK TIWARI <alok.a.tiwari@oracle.com>)
- Wrap long lines of Documentation/netlink/specs/tc.yaml to within 80 characters (Jakub Kicinski <kuba@kernel.org>)

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
Chia-Yu Chang (5):
  sched: Struct definition and parsing of dualpi2 qdisc
  sched: Dump configuration and statistics of dualpi2 qdisc
  selftests/tc-testing: Fix warning and style check on tdc.sh
  selftests/tc-testing: Add selftests for qdisc DualPI2
  Documentation: netlink: specs: tc: Add DualPI2 specification

Koen De Schepper (1):
  sched: Add enqueue/dequeue of dualpi2 qdisc

 Documentation/netlink/specs/tc.yaml           |  151 ++-
 include/net/dropreason-core.h                 |    6 +
 include/uapi/linux/pkt_sched.h                |   68 +
 net/sched/Kconfig                             |   12 +
 net/sched/Makefile                            |    1 +
 net/sched/sch_dualpi2.c                       | 1171 +++++++++++++++++
 tools/testing/selftests/tc-testing/config     |    1 +
 .../tc-testing/tc-tests/qdiscs/dualpi2.json   |  254 ++++
 tools/testing/selftests/tc-testing/tdc.sh     |    6 +-
 9 files changed, 1665 insertions(+), 5 deletions(-)
 create mode 100644 net/sched/sch_dualpi2.c
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json

-- 
2.34.1


