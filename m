Return-Path: <linux-kselftest+bounces-35545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26785AE2B7E
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 21:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86158172E43
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 19:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8A726FA5B;
	Sat, 21 Jun 2025 19:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="mxog6Z7C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013068.outbound.protection.outlook.com [40.107.159.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5B930E841;
	Sat, 21 Jun 2025 19:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750534427; cv=fail; b=sq+xtI3TIeCD3bf+ST215KP6GKF07b5ErMU8yykzNinToSyJLWcB9+EqViT7v9XbJcj7a498pScmxR7NfBvTy6MY3veTbiJ8RqVmBR8cfIP9w/vab2BXEMxCzDLlmXnzBHFGuq+K7+sAztEdGBJ+RD0KvAxAQ/nJh2lNjrvCRjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750534427; c=relaxed/simple;
	bh=Ym8RbWXjUiikEFgjfAp+Dbeq4CBlWIPTVocEfhQJfBc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=E0ni2iYJxyD+q4ZNoYRRn1g80bZNpTvIiaWk+oi+jTFogUmtIUa/X1/Cj8+H8PxH8hOdSmVtJ8Ah1U22ZoL4MUAXm87Pa2uC/pkWIx1D4Dc4nyv45IL/+sChwNeK+YiK7AqYWT/syUWRsfV5yZ8ld1XGGJ/ZfXpQTFyXLYknsuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=mxog6Z7C; arc=fail smtp.client-ip=40.107.159.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIOU2gk4CIQ+6iub+A7hUJcTQwb0mjr1moNIzKRQTOugPgyuQokVvzslgXLIVzj3hLsQfnF1QOGQ7FeEIA1XFFje/R+idzwDnJ+PNXxxTOJFOewCd6W4Yz/cT98t6tOrt+6t54q34mQ9PL7o3Ef88rb8qSWqYQW+M4UR8ho5jX30miBiOY6pCcYo21xULgVD252QNcZ+zF0a6u7bsHjFHfPj7xv1Klz4KWjKYDkyFQ4pnRjNkq4AaCMxEtBi+tJ76gf7YMB7RBbJkLa2EdNxpNRmRzQQSwhasd7JdGy7ghqkH9yyQxDqJk6xIEKsCzsr6Li5AS1JpzbpsSeN42vGeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JIU9Zqe66C8o5h0vDeD3wjUZnX8D9m394s0xnFXKXg=;
 b=D5S122ADu3dlASQu/GL+tht2JsMPLh5MrFiDpThk9YqAXqljw4J870SWwks1pw9prB+C68tBn6PZNnZB4o/YtyEX+MddS7BMlfoN32K958GT9qNvOiPADILFepzDIL7kSDBPUpmCzmYbTkkFMx4FPLa3e4V8RuD4NogvTuFEXgZkDoaZuIZIZoytkNm5GLfq5Kz7Jm7Yrp2zPWQ8KMKQhMPgopFJI/6F3Iz2PHbPg6ndKvKxvZ336PkReykL1UDRQ1kbn+rkKGeI9VZn1X1FgnLAt91ndpJl5uHnCKtd1C19vKPyKQQmP55g/kNqIDmCv/w+yToTwvCxeOAXaiCbbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JIU9Zqe66C8o5h0vDeD3wjUZnX8D9m394s0xnFXKXg=;
 b=mxog6Z7C3qOUT1nyRt88hr/ap9hf9UsHgEfOshVsq96rMgJSq+8zppCSoTsnsAaUSqvnrF9SCr12b2kbaj2mMJP3GbvHwJV3z2pmSKMAVjy7oPA+4iDNU21aKkzvnX9SmdiTZH/9/DIsnwV/oZZ7WQu1RLFVZn1jFjt1i9eb7a79tjQQpFKxINsx0IrrGSYgk+RRwUtdLhFwT5CIoS/pvg280blFzaWDDeT+V06zhJqE1w3ZoPvpNeIK8B4kvGa3uL3+DDcmu+NzkAORgEOC9vF9TUFBk/PUTJ5nbqrY/0YWlxIwtC/SRfADuAHqUDK+8Amkfirhwb4aQeolrSP9NA==
Received: from AS9PR06CA0348.eurprd06.prod.outlook.com (2603:10a6:20b:466::8)
 by DB9PR07MB7292.eurprd07.prod.outlook.com (2603:10a6:10:217::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Sat, 21 Jun
 2025 19:33:35 +0000
Received: from AM2PEPF0001C70B.eurprd05.prod.outlook.com
 (2603:10a6:20b:466:cafe::c) by AS9PR06CA0348.outlook.office365.com
 (2603:10a6:20b:466::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.27 via Frontend Transport; Sat,
 21 Jun 2025 19:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM2PEPF0001C70B.mail.protection.outlook.com (10.167.16.199) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.14
 via Frontend Transport; Sat, 21 Jun 2025 19:33:34 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 68ED1680030;
	Sat, 21 Jun 2025 22:33:33 +0300 (EEST)
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
Subject: [PATCH v20 net-next 0/6] DUALPI2 patch
Date: Sat, 21 Jun 2025 21:33:25 +0200
Message-Id: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70B:EE_|DB9PR07MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9f7649-d515-49cb-38ae-08ddb0fa8372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SElZUGNMcjF1V0dmajhEb3R6T1U2YzNvM1hyMFdKUGU0bm9odFF4SWl2VjVG?=
 =?utf-8?B?Y29kMDJXa0pNb3VJa2ozNzluVE1lRzZvQlc2ZWJMVVk2R3RFTlI5THVEWUx2?=
 =?utf-8?B?b0dWNGdvTjRJeURtZDkrOHg2WTJnYk81NE81am9KdnNHeEcwLzJXMytjUTRv?=
 =?utf-8?B?RDNoa0JWbjhLWW16NnVzM2hUNEcrNjdVUDZTUTBQb2YzdFErM0N6a0VnNXlG?=
 =?utf-8?B?eFF5NWFBcklLTTFvb2lkUXBLQVg2QTZZczlSYnNmcXpkWVE4S2FCeWx6dUpT?=
 =?utf-8?B?cjBScFl0UTk2VHdTalhoY3h1b0dMdkNmbDI0ZXpZdFpJdXFRU1FzcUtCbU5W?=
 =?utf-8?B?Ym1vVnQ3TDRaT3FIdjkwUVNjcEZ1RCttSHNyS0d3YzUzeE1kVzhhMkNEVWNK?=
 =?utf-8?B?WTIrVlp5Vy9xSk0rdVJ3TFd6MjQvNFNZQVN4MFpyQ1ordWdlcmprVzVDM1Mx?=
 =?utf-8?B?UHdhR1ZjMlExTStoZUh2TEV1dloxbWdIR1JUL2hZdDJQc3hnLzkzY2hCQWYz?=
 =?utf-8?B?RHJBREdVeXFjdVppVHBZUmFEdWNQZm5oTE1LWUdmOTNoWTRhWS82MndHNUlZ?=
 =?utf-8?B?UkpDVnpHK3Q2ZUdtbEIvVCtERVJHbWhjRTVKOU9odlp3c1N3Ynp6QW5aTDI4?=
 =?utf-8?B?YkwrVHdxUCtZRXRpcVFsVEVBZElIQ0dETlpmVnduK3pWa0ZWQjA5RWVUSG9O?=
 =?utf-8?B?U21Jd0FyTDFvSkp0OEZUVkd1Z3hMaXlRQ1BJZWo4QzRGVDEyem5ZL2F1TExK?=
 =?utf-8?B?ZlQ4OGxJZ05jOXFBa1JRVTZhREwrM0JqV2EwMnZFSGZPa3dzcnVLV1JiTGVy?=
 =?utf-8?B?aUlnaXJ0b1FNQTZqRDd5b1FYalduRExTZ3h1dU10SkhINzlZS0hGTlZ5enEy?=
 =?utf-8?B?S3pwVG9RR01yc1N5cGNjK3pMUzBtc1lmdHVBNGpTdGdTMEJnODlXZHVJOUsr?=
 =?utf-8?B?d2ZJeUIvb0VBN0xBeDhzc05lWUNLWWJybGYwYTB3MGl4RlppcW1vZ0l2SHVJ?=
 =?utf-8?B?NUhJUmJCNFNCWmdkRTRDTE8xUmc4bVRKV0hzdWdXb2NHNW9oU3dhNS9TREhZ?=
 =?utf-8?B?WVZIRlEwV0tSMEV4YTJvMWp6enpTeDVEWk4weTBzMDE0WldnYUt6WW9jUW5p?=
 =?utf-8?B?aWtQSktLNjhyMVZRRlQ3c0IwQTFUZ1UrdG4rbUVrZFdlSnZMeFFIbnRQVU1V?=
 =?utf-8?B?cTUwMDUxa2h0L2o5SW52SDdFb0pWOWh4bzNEQnpVdEEzUDZod3p3d0RkYjNY?=
 =?utf-8?B?MHNnckhReUwrRDE3T1h1VFFYTy9pZDhmKzkzSERkV3dlOGpoOGhEYnJrZ1B0?=
 =?utf-8?B?T3dHM1U0VStoMitIais2bEFjcXlFNm5ZemdISlh5S01nQXZTb2NLY1A2YnNV?=
 =?utf-8?B?U0RlaTF1bGtuMUxJRjVYelRoYngvRnVSMG02UnlFRGQ4Y1NCV2NzN0hERmpD?=
 =?utf-8?B?TE12VHJ0Z0VySm9CZ2c0bE5qbFR6Q2hTblVwbUlTejdaVXBpLzcrOVRsM1hC?=
 =?utf-8?B?eXgxV1ZBMWhRdGxkcHJhNStsNzZlNmFaYzNIeTJRSXJiQkFKQ2tUem9mNXF2?=
 =?utf-8?B?NjRkM1N6cFVUMEhHdjduNklQRXF1VkYyZ2lPOHNxc0RFWXpkWHZCOWpWaVR0?=
 =?utf-8?B?U2d2c2FyTkd1VnZiUERDVUtubzRJV1MrYkhQNlVWNFRRV2tvZ1cxV3FlRllo?=
 =?utf-8?B?VUNzMDJtWTlOaTc1WlhJYlNpQndrdnZLb0lUNzBqQ3hQcU5jZmJzWXdmZmt2?=
 =?utf-8?B?R3ZpblZVKzJUWXU0SkhmRTU4RUYwOWUzYmVFQ0swWkJiVXNHU1FZb1NDMXVq?=
 =?utf-8?B?bG9hdU5PRktkakd1NHFxb3NFdGF3MEtUTEpabWtPaUZLYmJJeEJtSVJSd2xY?=
 =?utf-8?B?V05iczh0ZDUxc2k4UHVWZ3NGcmxqdjlsekYzZzhhRGRRdXhkWGF4WkJ2Sklm?=
 =?utf-8?B?Z2pjd0VUTzROa1NJUStrRkVqSjlQUGw1U3dRQkNza044bndEenJxVU80Yi9C?=
 =?utf-8?B?bU4rWngxY2x6NTBmYUVzNHcyT1NYRzQvazRYcHh5ODVmMzBPMjBvMTJsNmVO?=
 =?utf-8?B?eXJEN0dnRDg0NzY0dWxPTG9raFREZnZvRks4UT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 19:33:34.9422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9f7649-d515-49cb-38ae-08ddb0fa8372
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7292

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

  Please find the DualPI2 patch v20.

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

 Documentation/netlink/specs/tc.yaml           |  166 +++
 include/net/dropreason-core.h                 |    6 +
 include/uapi/linux/pkt_sched.h                |   70 +-
 net/sched/Kconfig                             |   12 +
 net/sched/Makefile                            |    1 +
 net/sched/sch_dualpi2.c                       | 1146 +++++++++++++++++
 tools/testing/selftests/tc-testing/config     |    1 +
 .../tc-testing/tc-tests/qdiscs/dualpi2.json   |  254 ++++
 tools/testing/selftests/tc-testing/tdc.sh     |    6 +-
 9 files changed, 1658 insertions(+), 4 deletions(-)
 create mode 100644 net/sched/sch_dualpi2.c
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json

-- 
2.34.1


