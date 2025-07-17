Return-Path: <linux-kselftest+bounces-37518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B21B0972C
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 01:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C0E1C21DFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 23:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FA924469E;
	Thu, 17 Jul 2025 23:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="gRsNPbWh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013065.outbound.protection.outlook.com [40.107.159.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9D12417C8;
	Thu, 17 Jul 2025 23:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794676; cv=fail; b=lUUyho7A/9xOOb+M0OM8liFO8CRqfz7atDqv/QD1fB2fOMIhw7GXMHBIoSYF85MoXjNzUGGNoah9mRbv3zzXVJetnylvpQEXG6keVyJBGAesYCTvFSqIaxKMHTvifstK6tVhrfQTCMGLhwgEiyHKidosAg47IXkGCbmyIXSi2sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794676; c=relaxed/simple;
	bh=lmlfA8M0EKEj3no+h1keLDRsoqSm9VuAyIe+aGtp47I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Pip1bz0+HGCLRqcSlQof44eJOrGOm3Vi2WpgKLHl0luPcZF+EmKuwygVpM0Vs1Y5+2IpyDH+n+tp/fAjdgWu3OQtkSKc52NThoW6eUbfLl8zX+DBlggENXj0cpljY8yf0PjSewgBy5GIeeCVB/1jeM3z7gY2NmBIYO48fRId+UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=gRsNPbWh; arc=fail smtp.client-ip=40.107.159.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJVUnTyNs1rpK+lVVhcff0o7+MqiRKPv7pf0CXKURz/HJAkXVTsAe172T4R3ZEMGQxp+UceuNY0rhp4iPzsq7X+ohbxOYeTkCl66+hxgXu3FwLNyxVc6SDRd12k+BCwKwlCPkbYjSWUtguuKiL7Fd5N+Sf18/P1xBAWMT0gWhu+uFJPIkOnbu3yOC7ivGVKEWwPQ28GJ6V7doR/sX0U8VdS34hY9Mm1jGoI6dnJQXtcDK9Fpy1VUzvsExeOo7RwS+uSox6hF1qVDSDUof0Szi2BQbGT3n8zq0XRnI8zghnZI3z+jigDCx64VLNATWY1XjashL5zrggFRk9QXrBfHdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbh7qOFYujJ1H6FscfFl0sbAbdBkYDx1lke0LYO/FUU=;
 b=OV09EoSZW+tURnE2KSD/2w0+n0sht1EphZsaz5wxOI4I+Iv1ClM09teHFI8yyoto9iNw1T95/dvhI2GeAZm6i/4lXVtmh2Sxv0ydTs4i7ykPVDgbyI1PetvxzLCnGgtbABjvIZtmLKqFfOd9JoJHC1XQ8u16dIji8nQRxdyBRey5ydiIIXl/GKmHDedMSM5RiuOj+js47p6+e/5wZzU8y3KFe/4hCFN/ZGvIMI+xzAQY4VvVK5CYn0bg9VTRAFEZKLBGr7xmgSJ0v1zUySQfXVmCXZZzlmLYXXrS7m8EU6ZLokew80q/1/kX5TPeaOLcS5BEwfdhPLvxvqMmBO9I1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbh7qOFYujJ1H6FscfFl0sbAbdBkYDx1lke0LYO/FUU=;
 b=gRsNPbWhAlpsqQ9RVpWsTBTT0MA5jGyfiECIBpqDXrMbSB5I8gLk2Jk6tQ5PhCdqrAnKrWOKUfLy+KupBRRuOsL90jZIsPqBSRV8WYOmcnfgJ0kypLBy0U5ZsqCu+Kf4FtHhR8PBnXF9WPWlSN2h+nP5nQLvWAYbN9o9MJLKg3tFMDLYqk8wUNF4vZ5Q5JLsBY0lVBCMy5n0xfMhyWrhJWwfk1EDYDA1pkYZkDvhr3/P1rdI2sL38biaImQXfNtQAs9V/Uru8SEfjy5PGEacx3Bb+2bsR7A5GPEgN48SaIY25a+MESfFoYIjbiWCITawcJ6VMnsDhzJquKVRaGmp4A==
Received: from DB3PR06CA0013.eurprd06.prod.outlook.com (2603:10a6:8:1::26) by
 DB9PR07MB9858.eurprd07.prod.outlook.com (2603:10a6:10:4c9::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Thu, 17 Jul 2025 23:24:31 +0000
Received: from DU2PEPF00028D01.eurprd03.prod.outlook.com
 (2603:10a6:8:1:cafe::76) by DB3PR06CA0013.outlook.office365.com
 (2603:10a6:8:1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21 via Frontend Transport; Thu,
 17 Jul 2025 23:24:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DU2PEPF00028D01.mail.protection.outlook.com (10.167.242.185) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21
 via Frontend Transport; Thu, 17 Jul 2025 23:24:30 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 454F3680034;
	Fri, 18 Jul 2025 02:24:29 +0300 (EEST)
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
Subject: [PATCH v24 net-next 0/6] DUALPI2 patch
Date: Fri, 18 Jul 2025 01:24:21 +0200
Message-Id: <20250717232427.69216-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D01:EE_|DB9PR07MB9858:EE_
X-MS-Office365-Filtering-Correlation-Id: a3eaa5bb-ad05-44a7-8033-08ddc5891506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RCtsV05RUHIxWDNKaUdPaGJNNTR2aHlVTDdXM3VRK0ZNWjUvdlh0bGlOQnhM?=
 =?utf-8?B?MWNvOFpiMDZCcDFSUWRIOFVrSDFkZVhPdjdxTHFaTGZKbjluaWFpQVM1SnI0?=
 =?utf-8?B?ZGJHMVdYOEp6ckFVSGF2aHd6RDhwWWpTM2pMRGhWK0ozT1ZUNWJRajBscUVU?=
 =?utf-8?B?YTY2Mm54akdnU2dhbjlFMHBlRVNOTG1tMWg1dXgrQU9zNnNNR1dicHhlbkU5?=
 =?utf-8?B?OEF6bGNLekJmZU4vSWMySTluWFRhSFE1L1NDVlhsL2kyUGJuVklEbXhkSnRX?=
 =?utf-8?B?U2YwYmgwV094UUVkSXJnSDRtQlY2SnZoYnlSTGlnbGNybFhDbFZmNTBQZHlw?=
 =?utf-8?B?L25wdDJwbllyRDJ3dDVYN0x6dnhvZDNaZ3hhVXVIWU1pRjkvVWV1QWJJVGNs?=
 =?utf-8?B?cDIwY0JIczZ4STZDSnBmUE1NUnRkYmdlZlBVb21TUmt0QmlaenVwakY4N09C?=
 =?utf-8?B?STg0NDJDaGpYUEZkY3AxNEdDeEppMXVrQjZROWlOMXlCSTUrRGRScVlncHFX?=
 =?utf-8?B?V2FJYUUzMW9QaTdhUjVPVWhxZTBBaGR2bXlTOGk4QW5MMUZhNGpoenhIUFJo?=
 =?utf-8?B?dXdsSnh3SFQxd21qVy9YSDlSeS9tTkJ0M2ZpbEFrNHRIZityN21VQmF5c3BV?=
 =?utf-8?B?MG9nRDZybnVvZnVJdkFERHZVSW5OL212Nmx2V3pMNXBwNzNKVGZHcEQza2M1?=
 =?utf-8?B?cys4RzNGWjdQZk11SlhlVWxpVExjSmFzbEpCTUpjWkFTY2hRbHRIcWJ2Uk5j?=
 =?utf-8?B?NmhVQkY3Nko5dmV4MnYwQllZT2UxdmozZVZ0QXQ0RzFSTWNXYy9kNU9Hb25H?=
 =?utf-8?B?Y09kdTVPMEtic0pGelR3dlZrSUdScXd0TVVkMEo0U3RXbmhYOHdYRy93clUw?=
 =?utf-8?B?K3Z4ZEE2V2cvZDlLb2VzN01aTjJrQUxJZktCYkJudFNTd3UySUpCTWVrc2hG?=
 =?utf-8?B?dC9qVnprOXRIc2R0U1pxYlhaWkRsNksrdUpjWXYwSEpXeTd0L1lJcnVqMCs1?=
 =?utf-8?B?c1VUbTRFdGFyV2UxS3ZDc0x1YjZLNWVSODU4TG1UZlVwRjRDS0t4Qnhib01u?=
 =?utf-8?B?U2EyYzk3N21jbEtyaGVRQW5DMms2a1pvc3hUTGhacXNvNnVxZUVWamhFQ3lD?=
 =?utf-8?B?QnQycmg4a3VscmU5UG1xY0hKbWU1dkZFOWp6Z3NNbVIrNnB4WFFGNUhqd1pi?=
 =?utf-8?B?dFF5NWVZSVRydENEK1BmdW41dGxEdmRSM1RUYjAzMGsxd3NKQUUwOHZZNGV4?=
 =?utf-8?B?SDhLbmtvVzJyOVJjZkFablNCNE84VFFGYXl3c1RDWC9pMjJNZUxNWlJVSGUz?=
 =?utf-8?B?RklIWktUbU9XODBMVGJNMm9oUVRCZ0IrL1dVdnZJc2c4SzBNd1lWazNEZk5Y?=
 =?utf-8?B?TUd0eXcwVG1uR29BKzZwYkRyczdkRTF2WW4zakdBL3dDZG1pbytrTFNiQU9a?=
 =?utf-8?B?VlBpOGRqNXhuYzlHYVJBNWZ5eEdXZ1J1L09IWGlGbmlDYVpXSyswcS9RT3d0?=
 =?utf-8?B?bDJsUWpyT0YvQ3JEcVFsZFhMdS9xWHN0R3o1V01YZ2VRNWpBWUFwZzhmZVFu?=
 =?utf-8?B?WG95Qm5hTjR5aEZzeHdreXZYKzM0UWVYdlBjZGpKYnM0YnViblhpMnI5eFht?=
 =?utf-8?B?K01LRStZRFpWNVdrZk5kbjIvbDd5eGt2OE1Remd6TGVLUWxwMVpMcGVpaUFD?=
 =?utf-8?B?Q3hBM2UyZVhTbVhmQ09Qa1RVUVFMbFBtUStsajVwUWgzdzZBNCtHSEh1eWJw?=
 =?utf-8?B?RUcvSEpSWUlaaWlaRG9LdEJEeE9IY0tQZDlHUXpIemNaZEJUVzZsTzZSOEMz?=
 =?utf-8?B?ZkxuTmNpMFJkZkphTWt0OTRadU9EOEs2REs1TnlLR01CbjRYZVZ2aXdSRktl?=
 =?utf-8?B?YnJMcndQYXVSdVY2ZDFLd0ZUQVViN3dnZDRPTkxqTWRPU2xqeTRGUVRSVDk0?=
 =?utf-8?B?OWdRSzFyN08zM3dic1JqUDJNOWYyNlE1WDRJTHlhZUpBcW5FZVJ0KzJvaVNK?=
 =?utf-8?B?bUd6Skc4V1JaWkpGWUZVTVBpb1JuZm95cnFwdGczendWd0o3bFRWYWJLSWxp?=
 =?utf-8?B?UHdTQUxiTWdFbC9pbkhaQjhqK0xmb29PTUV4L3lRLy8wd3JrUEpVcFFPM2FX?=
 =?utf-8?Q?6ggg=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 23:24:30.9388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3eaa5bb-ad05-44a7-8033-08ddc5891506
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9858

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find the DualPI2 patch v24.

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
v24 (18-Jul-2025)
- Replace TCA_DUALPI2 prefix with TC_DUALPI2 for enums in pkt_sched.h (Jakub Kicinski <kuba@kernel.org>)
- Report error if both packet and time step thresholds are provided (Jakub Kicinski <kuba@kernel.org>)

v23 (13-Jul-2025) and v22 (11-Jul-2025)
- Fix issue when user would like to change DualPI2 but provides an empty TCA_OPTIONS with no nested attributes (Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>)

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
 net/sched/sch_dualpi2.c                       | 1174 +++++++++++++++++
 tools/testing/selftests/tc-testing/config     |    1 +
 .../tc-testing/tc-tests/qdiscs/dualpi2.json   |  254 ++++
 tools/testing/selftests/tc-testing/tdc.sh     |    6 +-
 9 files changed, 1668 insertions(+), 5 deletions(-)
 create mode 100644 net/sched/sch_dualpi2.c
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json

-- 
2.34.1


