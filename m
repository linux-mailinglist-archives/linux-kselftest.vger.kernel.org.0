Return-Path: <linux-kselftest+bounces-35012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A03AD9E3D
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 18:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8C53B7B4D
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 16:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D97C24A041;
	Sat, 14 Jun 2025 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="GWsYGSk1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013056.outbound.protection.outlook.com [40.107.159.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1BC1A0730;
	Sat, 14 Jun 2025 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749917359; cv=fail; b=KlO1NrtXdXMX5IkC4N2L6TaaQxfufLdOVadotmd6cdGTZu2MH675oNgQnWS0CXL5Zv6yp2C5M0NBxpotBtMDRS4Tk9u2aRV7lvbuanmWp0upnW8cp9f4QnMRUNZZo9kTHtBBhAmPuYK5MstPnyzW1Dj2kvYl5G2UOgaNjc7Qt3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749917359; c=relaxed/simple;
	bh=/5aqOxVdUy+qE+O3m9LglNZTFz3rTWppV7DZMS5qUR4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GxNRgHF27U9GCZ5ggzqmcbGXH2tGV3FEiw9Qti6OAITJc62ao4BsPUjymNJplIsmuhDaVUddGB8DPI5FC4Jy2rRwG3LfprpUNWJJ86woHm6pJLITZkUNA9c6egPMYWErl7SYiGTnsC2/BXJ13orvoolaRx86o6M0c1wFX3LoBbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=GWsYGSk1; arc=fail smtp.client-ip=40.107.159.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkEQTAfXfrxhSwvanMXsyZV48C4gNFlBjIuFvxlCGz/PCbBmGiqpxNK9h6XCtvVslrFk25Zs2zibSqpmjeoMP1hgVOnKAJCM3mQYi2t4LRNR6ixL9qmdJHMhWTW/5P190T2fd0SqJlNT04ImZqZ/3B82sPGj0e9XAMXZmO0saap3jDXR2FHo8td+oJQgpTTZ/x6BImKY4s8fDeBUPfJFVQiIgslPCmjxrKo7D6VG5jCmMYlqriDkN5IKLgM6UGmLYKN5bYj/hUguskL4FTNetQ9yhyNncrb1oxp4wi/RrhyTKfUPdnZ9QryJd3bOcJhfAXOQ4hZpMsR9TOmLdbrzHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFB3aB7c+83+0WvNhTq2ybOk3RRIzAxPyKhAlTPGATc=;
 b=vkGpdZTB6V41Jec8Y+hSRJvjdyJpJsKv7CXJ0hVcj329+eCBS4mDK2Ahn3IxbUI4niX0IMC6uwLu6uLFyR9IWr9bDzkZiVsiTdvbO32XIMLWZ/quCflrIiQpemtZXV0eJ2fH1dFo8+YXwCB+7xw+vj2UPTnynYDmyt1mAMHNJQsJp+EYxGIqfU0MS4jAkXCOfiTUg8hfxnoh217KM30vFSfxUnVPd660855puiLW6L5nISZnIYvs6DE2LtgiCuL67JuxlM+yZaTg5b2FPhQ9SNC5sBIyXZnEM18rqgOOQj6SrG7HkXd8GofkIoWO/OSjrOFqoaDDnA+YrE/wwpMXEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.241) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFB3aB7c+83+0WvNhTq2ybOk3RRIzAxPyKhAlTPGATc=;
 b=GWsYGSk1r08tswlZEMfl95TC+YHEDMa0XiH1cA1biLYvv1hHVUiO1FIklvvi56zq5HDQJaNhKqb6uFR7/sKk2fjNI+KEJaG7exIUUdVYmIuFW38mDG6Msm4pa5BNjLHnm/7Vvh//QDUhO/YlT7puF5A81eViwAfIm4Quc2FasQwKPzOJ49o/tSh1uyvCaCXXA5SegGdjiA/xHzvPUjqZw4heS0CFX/uH0zyhd8krIdQqy403Eat64kgkuXFQSHKJGoBHP/tyZqQZYxQLMFCKlTE6Qv0bXzfJVeZkmqQRvOwG4gCvbR6iFJa2nEAYBW9baMx5PuxRery+4YATLXgZDQ==
Received: from DU7PR01CA0047.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::24) by VI1PR07MB6350.eurprd07.prod.outlook.com
 (2603:10a6:800:138::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Sat, 14 Jun
 2025 16:09:08 +0000
Received: from DB5PEPF00014B95.eurprd02.prod.outlook.com
 (2603:10a6:10:50e:cafe::b6) by DU7PR01CA0047.outlook.office365.com
 (2603:10a6:10:50e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.28 via Frontend Transport; Sat,
 14 Jun 2025 16:09:08 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.241) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB5PEPF00014B95.mail.protection.outlook.com (10.167.8.233) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Sat, 14 Jun 2025 16:09:07 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id A64C320119;
	Sat, 14 Jun 2025 19:09:05 +0300 (EEST)
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
Subject: [PATCH v19 net-next 0/5] DUALPI2 patch
Date: Sat, 14 Jun 2025 18:08:45 +0200
Message-Id: <20250614160850.11087-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B95:EE_|VI1PR07MB6350:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1925f3-b272-433c-4032-08ddab5dca62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vkx1ZUM2NksyRVAra2wrKytudVJEREw0Vy9ua3pTTHFqK0ovazUxM21xVW1s?=
 =?utf-8?B?OHJVWkRwZ1NUaHlhTWlveWhhRmdGd2xaR2lIQmxscnVtTlk2K2JjWHdhN3dx?=
 =?utf-8?B?MEF4ZVhGOERUWFRBcWNGUVVMdTBHNitSRy95UCsyVG9CczlvNjlnQW5FTTNr?=
 =?utf-8?B?c1VtQ1o2K0syeE5zTzRpT014a2o4YVJZQms3ZWoxdDIya01kZEJad3JkdElN?=
 =?utf-8?B?VW56bnZldGViKzNkTlJCMnJoeXQ0aHZMVnZVS1BKVmVEeWVaNUJpVElONloz?=
 =?utf-8?B?VmxmcjZ3N24wM0piK1NaZTJFVGFsSjJRdHRxYVJEQmFVVFV2dkVPTUNCR3E3?=
 =?utf-8?B?c0FzdGpka0VQbmxFS1dvbXIvZWdTS1Q0N1V2WWlIeC9RRzllMy9Eem5iZmZV?=
 =?utf-8?B?TFc0U21jL2w2c1YwdUl5eEhDUzArWUdFazhUOEVUQUNBQnorTXV1Wjh1OGNq?=
 =?utf-8?B?NFRpYlRGTXpNbVJDR3R4TFFQT3lOSVd3U0NOUm9FdmRwN2k3bXhaS21HWXRa?=
 =?utf-8?B?OWlrcklHZzRlWUJzVzZuZkxmNXZtMkNva3hlSzBKcmFMYWdVQ0NkRGhrZVR0?=
 =?utf-8?B?RkxKbFIrdHFqZEt6RmlCc1BGZXdUMVRvK2N5UXdYVnVtMm1kc3M2Y1k0blNi?=
 =?utf-8?B?MUw3K3J2ZDVES25ZKzdPbzNNWTlCb0psTFcvTWlnV0ZSWklJUkdsZVRPc3ZN?=
 =?utf-8?B?UWxpMTVEQjlQWmN2ZEZQMnlBV0o5QzZ1bEFaQko4WU53MG5KVE83blRveVcw?=
 =?utf-8?B?VVQyaHkwM1B2NTdOL3c2K2ZmZ05WWDJoeHdxb0g2NDA0bzRZZ0pPYVo1VlNM?=
 =?utf-8?B?cERBdisvenZ2UVlwT1Y2SWl6dzFiVUVEMEJsOS91NitYRFVDUGg2K0tVYTFE?=
 =?utf-8?B?ZGVyUThRbnN4ZFpBUFo2a1dhUGVQeDFxd3BWVGY5Ly9YM2J4VnJlVFBtdDRK?=
 =?utf-8?B?Z0w3RVhMNjhCR2MxNG4wYjdOUVR1SllZVmt1Q3V0WXpJWHVxcmVZY2ZlYlVn?=
 =?utf-8?B?MVVGU0YzNzFyUFNHSHNneU5xUlZ4VUZuUFdRNXdhL0ptSDZoSTQrN0JwelBL?=
 =?utf-8?B?eXdFN3ExaXQxY1hlNmtGUXJFNmYrTU1oam9INlVwemxCMUU1eS9CdGtTWHBH?=
 =?utf-8?B?ZU1sMVV2V2dSMVR6VDRFSXZxdlA5VFRMME5vQ1pEMmUxRVNITWpwT3F2bTdq?=
 =?utf-8?B?WHlSanNyNDBvWHlRMWZNbEpoK2ZiY0l4UWVlOThxK0F1NDMvRWd5MUFoWXpt?=
 =?utf-8?B?Y29DeFl3THg5YlRJcTRtTmhDeG4xTUlMeXVGTTlDWThDaEZETm40OTFaWG96?=
 =?utf-8?B?NTVvUXBIY3R4cC9UUllRdnRLRHJUQzZzRHlvc1NNcERDS25ZNUVIWlI3UkxI?=
 =?utf-8?B?MlViMnVXdTl4SXkyNk5rbHBBcjh0Z0w5ZitqNmdwTzhaMEh2K1AwektTcWJt?=
 =?utf-8?B?RHp5WGJrcS93NFRwR0dWb0RCaUlZZ0Q5cXcraWlZMkp5dnp0SE54ZUZxWTNL?=
 =?utf-8?B?MUE1QjdhZGZTU1ZDc0V1SzBXQm1xL0ZyTE9hdlkvVkRDTTQxbXg2WUJTUExP?=
 =?utf-8?B?SHAzeDRyNUx5dnVRSGhUemIvUTFaeGFYMkg3M3VTVVQ0YjloS240ZjJUWm5q?=
 =?utf-8?B?SFExT1o4dUdPTkJ0K1p5NEUwajBkWGsvN1ljVVVXbFhCemdoNXcxQVNoRmlL?=
 =?utf-8?B?dXR1d1RDZnZOZ1MrWm5yc1NXR01nTGZwaGhZTXdob1BoZkRyVm9DQm5CYWVR?=
 =?utf-8?B?MTV0T0FJUUxrdTI4YXBWSGpGWnh3QTNXaHlZZy9oVVpybi93c2ZNOEhDV2lQ?=
 =?utf-8?B?TG90Q2VRWUU4bURBSXhUWVdSYWxjcVlubzhjZVBPeENrSFd6elJBMFlaakd6?=
 =?utf-8?B?azQ3bUN4NVdWRDlvOUFsblpaM0ltUG4xd2E5anNjSzkrNWdocHdSSzdSNzd6?=
 =?utf-8?B?bUlTWWtNNlFFUTZlZG9XYTNpTm5HNkoyVFRIbG5jR3EyMTdHWlI4Y1M5MUxX?=
 =?utf-8?B?OHlSWGV4b1MxWXpTV1luci9sR1kzbkZkRnl6N3hUdkdpQm9iUVdjUnA2aU4z?=
 =?utf-8?B?c0kvb0hLMlRmK0QwRzZESWk5N1liSVNjL2UwZz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2025 16:09:07.1412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1925f3-b272-433c-4032-08ddab5dca62
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B95.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6350

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
Chia-Yu Chang (4):
  sched: Struct definition and parsing of dualpi2 qdisc
  sched: Dump configuration and statistics of dualpi2 qdisc
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
 tools/testing/selftests/tc-testing/tdc.sh     |    1 +
 9 files changed, 1656 insertions(+), 1 deletion(-)
 create mode 100644 net/sched/sch_dualpi2.c
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json

-- 
2.34.1


