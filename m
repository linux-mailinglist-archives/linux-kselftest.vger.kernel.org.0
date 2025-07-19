Return-Path: <linux-kselftest+bounces-37645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D127B0B1C9
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 22:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C731AA1069
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 20:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472D22264D7;
	Sat, 19 Jul 2025 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="k+Sk0W42"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012056.outbound.protection.outlook.com [52.101.71.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEE02F84F;
	Sat, 19 Jul 2025 20:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752957715; cv=fail; b=Y6i+1tLCgfmDuyvMsa/wqG0r5e8F+d36EfKbi65ObtM07OAds8Jd0cwFr6Z5yblhNh/eOMXZfa/sQOIoWaf7kLJxwubl6agBACyY+M5ldKvpPKlzPK90ea4WgdFXMK0e8COWBKz8LIUdjhHhGGHvtL7asQsPGPBtHZNmwNObggY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752957715; c=relaxed/simple;
	bh=LYzQAiROIXdlrFIpzrPxWDx8oPPD+8QanVS0sybrNcY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GdIRgWKZS8SVoSzIFXPRRkD1e1n3oza2OusEjS1IDolnBDbsM1dFp8KNbXbX2HSnFtCHiJJ2TvxK+igMmDt2SxFPRwl6QX6qSEmqN6Vcyf3eS0mG3zQeUFPP7tkm2sU24Yet0fNRjl7tcK/n4hY3IRNU11bknO+oX3zVJoRb29U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=k+Sk0W42; arc=fail smtp.client-ip=52.101.71.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQNRj9mMQ+HZbjiAxn9HsqVwWeT0f/x2BCuHeTK8NMxggRJnEAQlbsKnbIj38s67+S+gFguGgzhzB6XsDGM+OlULBpBMYrKlEe32GRlNvCbFStTIls+YkkQQU+v0J78kJrUu5YYwMzWxKqq2VFJ9xQriyk/Dr1AtGoWicVuaIur/NltCJBvmW0ei1cFuZ2ZeYdN5WHrsy3syVd8wK2HAvxO/ZRSIt2izL62c347UmXKqhIEWpdsSXO4/4tIixA4IWGVvvybfSBy2xm0dPfa7WFOWuSS4nPOM/l0DSYTxxRWHL4atOK/7CNrR13S8lIm5pLriSu3rTL60A3AbB75IAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esxIvMNnKNLyVFKeO82mL75mPdhnp9Rct9T6Z+4ncgg=;
 b=SylCPgZN3xf5mzHng4BYWbwvBk9liN/kTttr088RxCD2MfYZs60Wxo39mCEGD477RtffQCOr97YP9djgSR3wDUXcD1ZBAQrFsFLYt632TtSzMUJWxBdfN2LOVrYgJ0nG+Ly7/Q3yV2IknCmiBbbawBaBm/cu1OAzEqifjqFT+kyepfrv9ELf53M5Y3yuyOWLJlI6QKE1daP99R4JLq03Ij55zXxb4PkJVCalOUnwvHdXXo8k1TKhzZHyBkbyVt4BvXTdAKi6BsYzkD9Ojib00gPJqU8v58I8u6DSWMiTXMfKJ79bNLMxlw7N8zKhxkenSpRdedYpt2LsMshRpuAEhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esxIvMNnKNLyVFKeO82mL75mPdhnp9Rct9T6Z+4ncgg=;
 b=k+Sk0W42g1T0grL2095n1mFzt/RhjzDJVMr+/tfXQcQ/k5NglteOvUfcJnIupQyISo+36YAb6gGrlQrFYT3RmhfpzXaa1p7W7WSH3wqbTWFVBamc8JFh5iAuulFVeP0Mr+1igVPX1naFyLRHXKuf3U4KPMs/iHJ2j3anz3WNME9zfkC/K01Pj8EENCKn9vwUO8RUKp8z/tNZDV8BPm+6p5odzmo/YiXy1USnZlgiLr12InbOzu6mYI/OQHJaxU2FEeO2P/wIICQ//E6RoMr+SgA/68ESa9BM6ZbJhqV3/mUnVmp2ZltmeQ+TqZhUqNIcMu2VicYeqWsEfKQB0xy8pg==
Received: from DUZPR01CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::9) by AM7PR07MB6914.eurprd07.prod.outlook.com
 (2603:10a6:20b:1c1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Sat, 19 Jul
 2025 20:41:47 +0000
Received: from DB5PEPF00014B8C.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::16) by DUZPR01CA0016.outlook.office365.com
 (2603:10a6:10:46b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Sat,
 19 Jul 2025 20:42:13 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB5PEPF00014B8C.mail.protection.outlook.com (10.167.8.200) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Sat, 19 Jul 2025 20:41:46 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 867911C002B;
	Sat, 19 Jul 2025 23:41:44 +0300 (EEST)
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
Subject: [PATCH v25 net-next 0/6] DUALPI2 patch
Date: Sat, 19 Jul 2025 22:41:23 +0200
Message-Id: <20250719204129.15737-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8C:EE_|AM7PR07MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: 595228e9-c4f8-494c-f0cf-08ddc704ad7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUV5YXF0NGpSUHBPaDlTOWRtWENXdXYzWjQ1OVRYeTQwNFBJaVF0Q3R4VUEy?=
 =?utf-8?B?elFYTkhTeXkySDV0dyt5MHl0SHNBbjVLYnhKNXdkbGdxNG11Y1JwVURpZEts?=
 =?utf-8?B?a3lGVUhJUitBZ1hGaW9OQlFNb1VhU3F1U0NDUWlHaWRGK3NwRXdBUnI0L3NT?=
 =?utf-8?B?c0YzRHl4UHdkd3l0N2syQVAyT0p5OEZKNWk2bUN5S1RQR3NtYlByVWVDdFQ5?=
 =?utf-8?B?VWVOSU8xODJ2WmxqeFcyeE1ESkVONGkwWmZGcWhnSzY5SXVOalZUVzdyTUdq?=
 =?utf-8?B?eTAzN1hScmlucXRCMWh2bi9NMmlVaHlGTHJDQVJ4VEFBWllyWlR1ZkFQeDM3?=
 =?utf-8?B?a24rQXN0MGVzNFgxelQwbmZVaUVnOThjNXhrYjBkN1VPTWFkeVlUUzg2eVVk?=
 =?utf-8?B?UWlFSmhGWjV4RFNidTZVc1lEc0o1anUwdDVCOFBKeXVIREJmVEZVQ0gvQkNx?=
 =?utf-8?B?WklrUVJiOGtKemUyT1l6OGkzTm5ReWNkV0M4QjhRMWJ4TGJtVWFSVUhaMk9s?=
 =?utf-8?B?RFpra2xEM2JjYWx1bW91cWptWmxobmlvZkFIa0dnL280dlcvZFcxbmdVL2h4?=
 =?utf-8?B?NXFMUHNpSUZSRythN1c3TVZRSWJEdXAzMjJ0RExaUlJ1WE5Xblc2d202alo0?=
 =?utf-8?B?c3ExY201L1BmaUh6czJ1OTdJVWlFb2JiV2FsVG5Od2Q1UUYrMkpKMXVWUTBX?=
 =?utf-8?B?dWNQR3pNK3p5ajR5Y3NQcVdvNW8xS1RtOEV0S2h5VjdlcUVDZ0Nubi9IcVVa?=
 =?utf-8?B?S0RDVHRqb2RLeHhCZUh1cnNCMnB5dFA0T1hsUHdKWnJ1S0w5L0xwZnVMc0cy?=
 =?utf-8?B?eldkTUNqd3g4VzZjVE0yUmVNUEpOZU1pTjJXcFIxOUV3eTljRVhtN1BINnNK?=
 =?utf-8?B?N1pCMFg0U3VZcDVybHVhaUNvSmhhT3JxSUc1NEJTOWxJNjdwUlkvSzJWdlFn?=
 =?utf-8?B?U1E3QUlXWnZtdmpNd0hJK0xpZHE0SFkwbE9jR3BLcXJieWtDMUpUcXFSeTIx?=
 =?utf-8?B?R3kyUWVTUnJnL2xXRjgxUXVGYUtxMDBnVGhxSGkwV09KSVRHakNTb0lYbU5G?=
 =?utf-8?B?UnIvTUNyUlRJWVVlVk5sNlQ4NGI5UFF6encyNnBxMkRhTktiNS9oSWJOeC9Z?=
 =?utf-8?B?TEpCQ2J1anJPZDhvdkdnczVoOHJleEZhNSsxMVhrTmZrbXgxQWFsWEtsWFZk?=
 =?utf-8?B?VTd4VTljQUIyd05TZjh0T1lZMnRJL2F6cVpUSTVnZFJ4UHQzd2NZc2RpVlc1?=
 =?utf-8?B?emhaY3BoNG9FVzEwdEs3NllBQ1dWVlY2Wi9NMUZ6Q2xGM2Q0aldHR1h6ZkdB?=
 =?utf-8?B?ZUxZMU1FM1RkRnoyOUllWmpSb0Q4dytCaG1LUEZNTkNueXovTWFwVEhQMjBm?=
 =?utf-8?B?RTRqc2tVTjJ6dFBUWVNobDRPejIxN2JFbXhSV0V2b0x2dW4zallzYUh6ZEd6?=
 =?utf-8?B?UkYwaGw1Ryt4UWNBQ2xBOXNENGF5TnNtQmdEM1Jnc2M2QnpHV1NaZ0tLdmRj?=
 =?utf-8?B?R3JDejFZY2c5Yk9Xc0JFdU54M3RiUnBOYzBld3cvZFlRVEhtcTJZVEpjUXgw?=
 =?utf-8?B?bmNQQWprWXFSMUI3VThZSS9VY1kwcDJPNXU3WVBlWDRrOVJ1OUFGVzcwY0l6?=
 =?utf-8?B?TlJRdlZrMzVhVGp4MGlTYm93UmFRelpRbGJ3aUNyWlZ4NVQ2c3pxMHpYSXhL?=
 =?utf-8?B?ek8vTFBaN0RQUGxqT3NFeTlDM3c0QnZEYm14Q25HYVkzekVkckl3V2l6Y21a?=
 =?utf-8?B?UFRHaEdBbDVwSTFLd1NGWjI1bld0Z1VqSUhQcjZjei9TYTJlNjdkUTJTUkJn?=
 =?utf-8?B?S3ordk52aWxpb0k1YmxQUUlmU25WYUtBaWNvQUJ5YWxNclVJQU15bzFxdmgv?=
 =?utf-8?B?QlJRTFExYXJmd0lBcGh3cEZ4bENjcUVFeXgrczV5SUNXNVZuSkFWeXhBUDUx?=
 =?utf-8?B?OHNCOTZIaEtTajJuL3ZCb2Y4dFM1OXYyQnYzaVVxMFRJYXNWTGk4djZZOE5W?=
 =?utf-8?B?VnlSajA0c2MyekM3Qjd4bWxUcHJNaVlibStIcnFTR1JRcG5GT3R4NWpYaW5N?=
 =?utf-8?B?b0dURDFHeHMzelBoODFUUENIU0tleEdTcUQvYmdOU1huR01MSlhVQ3JWRWZp?=
 =?utf-8?Q?p7B4=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 20:41:46.0329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 595228e9-c4f8-494c-f0cf-08ddc704ad7f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6914

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find the DualPI2 patch v25.

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
v25 (19-Jul-2025)
- Fix the missing sch_tree_unlock() in v24 (Jakub Kicinski <kuba@kernel.org>)

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
 net/sched/sch_dualpi2.c                       | 1177 +++++++++++++++++
 tools/testing/selftests/tc-testing/config     |    1 +
 .../tc-testing/tc-tests/qdiscs/dualpi2.json   |  254 ++++
 tools/testing/selftests/tc-testing/tdc.sh     |    6 +-
 9 files changed, 1671 insertions(+), 5 deletions(-)
 create mode 100644 net/sched/sch_dualpi2.c
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json

-- 
2.34.1


