Return-Path: <linux-kselftest+bounces-29159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B728A63643
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 16:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E92F188EDF1
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 15:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401611C8614;
	Sun, 16 Mar 2025 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="AuwjDKBp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013044.outbound.protection.outlook.com [40.107.159.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41A31C84B4;
	Sun, 16 Mar 2025 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742138940; cv=fail; b=YtCSe3hDSIoCbdayGq3PTsh3QnCDMxJnGaICjTAlezXBaae3+D9xkDemVWJV7Y4iwfyHzjAevJTu2Cr6v05JYU26uGTmM+XUOUAbpgWMPkqcbqHOKVNKG5Wo4sJarPmQujEfd7KbFY62/Fr5GfNBa6piEoBJqW99P2q9AdGda7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742138940; c=relaxed/simple;
	bh=nGIud9z97Qu2Th/gqh9fc8yKSv6tJ6IPg8mnB3IEzrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQgOALADQh1SwtwYZ6OUiBB4NovqvPnJGzUfdtcgkDB6MW8tZSsoJFSISjmCQ+pksiGBXJfstRCQTuHcdVkjAaDWM70ppsNdJ8UUbCXIv8VA1LomWrGEomtxZewhBXxy0cDlZvLU+xgZqkOXQgK6dtgoKUlhadY0gT1xokzP+6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=AuwjDKBp; arc=fail smtp.client-ip=40.107.159.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2T4Q8+Ht3yVVOrl3F9Ubaf4+ogmkMey3pK1yPFHnOMy3vnE/n+D67v5LH2VvejpvoCDl+8fi5/Tsp1bU4e3peF5CXhfdbZ8LaEBfx12yrpuwEiQoEc+89ysSqPPjhlOznaGyTfM6lg9+aaMfTTFuLX87bpYxMezFYsaBhMlvOEwIMWEvdaWAiJVLj+mTFY68sCmvAm7n0owjUxJfPGUgIzpf9vzB/9rKxRBYQNut8e7GnQLBCj4g5A+XBHwYmFssp4HyDKXiGav9bL8FxkZSQcvhgaq8/vATKrk+urrc/+J7Qn8cMKeD0gVtn0xZiuw2UQgbMQOJr3e6vc9gKu4gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuVy8mv/5yMcbvosUGcJm+m9vXEd9vNF2Olw8FJXDL0=;
 b=YTpzPk+dZVeLY31wNbNiHEQbuxxTfFoHXctc2BwsDeVwrBaxccaUfQPYfCPE2EWbgtcd6WtNjH/m8gXKhH0EhHX54Ic/v/5zQcAUuCqJwAYplV3E76ucL5ltYFOnqzOgNR9F9EYwjlfXR7B+opwhUDgBQWZPs3+fbtfXVNpfXrYOyiijRtyIcBxAkNE8B6COqktRtuI3g/5tvntIBYG7hEVJe8Dl+LkoAbBMv9j64GnASFCPIWZjh49cPN1u4rGkg3v3/q01LlmEX5cvjQdDTN+X7cAhCby3O2zVsNu/l3fN/u6fehviYFgo2xyq+o3NKr/oqAim49YikSaUgtWZpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuVy8mv/5yMcbvosUGcJm+m9vXEd9vNF2Olw8FJXDL0=;
 b=AuwjDKBpU1SbplbNwBhRh5xdwx776oZnyrQ/3PhTvMp/hhOSYGKyWZ3uwnNDbnew6dHMlXwwvYotjnpmRgscqdN5SODFSKwEk8jbyXuRDK2VOh/s3Oa9Qsc/1xGa+zRG0W110BrVIxG1kwFECxA6yD10R4QqqJae0NuS+/qAWFG8itSSRmQfMd33g8mo/zWJuO+guJK7G3DzDMPG5HSX+FM3IPnk8DFOV0InGFyLECnByiTUbBAG5ZNvtGO1Wl1N0vmUpy5YOyU/n8say1wEXT6cyNF4739r/4xgjbsqYQX2U3CsT71YPo3Dwg4Yuv9JYXoL71Nmkc1x6wfhpaHDew==
Received: from DU7PR01CA0032.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::8) by AS8PR07MB9282.eurprd07.prod.outlook.com
 (2603:10a6:20b:61e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Sun, 16 Mar
 2025 15:28:50 +0000
Received: from DB5PEPF00014B95.eurprd02.prod.outlook.com
 (2603:10a6:10:50e:cafe::14) by DU7PR01CA0032.outlook.office365.com
 (2603:10a6:10:50e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Sun,
 16 Mar 2025 15:28:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB5PEPF00014B95.mail.protection.outlook.com (10.167.8.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Sun, 16 Mar 2025 15:28:50 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 52GFRT2v000613;
	Sun, 16 Mar 2025 15:28:55 GMT
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
Cc: Olga Albisser <olga@albisser.org>,
        Olivier Tilmans <olivier.tilmans@nokia.com>,
        Henrik Steen <henrist@henrist.net>,
        Bob Briscoe <research@bobbriscoe.net>,
        Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v9 net-next 3/3] sched: Add dualpi2 qdisc
Date: Sun, 16 Mar 2025 16:27:17 +0100
Message-Id: <20250316152717.20848-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250316152717.20848-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250316152717.20848-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B95:EE_|AS8PR07MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: 52fe31eb-8137-4b9e-241c-08dd649f40a6
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aXZOUmRDOTRRbkM2ejJTSWdVVTk0K3RoY2xDTXRCc0RBMDE1M0tBWGt3dStO?=
 =?utf-8?B?bFMvZTlhUGhDeVRtRkRGRkdDcllRWi8wTzRTVGc5UlIwa1RONEtsZ0ZZa0FU?=
 =?utf-8?B?Z2h0cG9GZDNwNUxwRXhnd1c4NzlETkR1cy9vZ2dqSjdMTjJwMUJNbXhEWVdm?=
 =?utf-8?B?WEZEc21WQTZMTmxqK0lsRm9paWptUVVVS0kyT211M3VlSWRCRWhBMWp0bmw3?=
 =?utf-8?B?ZFBRajR6b1Y2b2QrdElQVWdkODd3d2k5NHVtS3B2NU1IeEpSYVdXaVY2YUZF?=
 =?utf-8?B?UlVZMWlzZFZtMW5CUDFQWUY2MGpyemJPakgveHEzSTc4K0dSd3BSNXZGMG1P?=
 =?utf-8?B?NHlCT3NVeWx5OVhKeVZFM254cWNqSDJTK0tEdW91U0tqNHpuUlljWUtWc0RU?=
 =?utf-8?B?RXpvRS9UaS94MGVWOTBjTURnVDlPRGgzZ3NjZ1B5WjhCZGl1aWZNbm1xd2M5?=
 =?utf-8?B?R2ZsS2xDUDJJVDE0UU53UmR6amVFMVBoNWplOG5CV3NMbkxNeUl0NUJnNWFk?=
 =?utf-8?B?TGRTNzhIZHBNVXVKSWpEUnBGZDFxWC95TFdudjc1LzdlaUN2NWN3ZjBmYitJ?=
 =?utf-8?B?Um8yQXQ0ZWlHQjBEREdmYTh5STFOcnJjNmY5VVoyRWI2SEtsSStHcUt6ZTdi?=
 =?utf-8?B?YkNNR21SUjBacTc4OXdjM1VFSzdJUlQwY3M5ejVFZi8vQWN4ZEo4d1hpVFVQ?=
 =?utf-8?B?VE5Lc2NKbnBHemJ5eldBVW54cFhaWkZRc25nMXI3V0lHU0VKNzY5V1RhOEt4?=
 =?utf-8?B?U0k5NFVJVW95MnorUllwMkhrSXFSM09zQzhtQ09oYTQ5ZEg5aXZhNWU4MTYw?=
 =?utf-8?B?bDB4OHRDVFRrOTVpcGhMaDl3Q3F0a3FVL3l6c2dpUi9kRnp4UE5TYjAwZ2p1?=
 =?utf-8?B?WHY3eFJqUUo1cEJ5aFZpVGlTREdSM2FzVW5LRU94VUprczVHdUlNNXpOYnIx?=
 =?utf-8?B?eFBMU0hiaitHQ2lvMVRJREhJV1NSQ25nUGNvUFk3dXpVZS9DUGw5SDBZTEFR?=
 =?utf-8?B?L2hRV1Z6Rno2NFhjUFVCYmtBcHIxTHJFQ3liMHY1TzZEVkpmS2FZeEFrWXBG?=
 =?utf-8?B?SWc3MTh3a0JXbTF5SFE5WUJGWnJkM0hDUXNkNkxPQVJkNFpaS0tldWxTYUtk?=
 =?utf-8?B?aXgrakNNTVpuUzVENFgyblJSSTV2eVNqajhDREJGbUd5djBEUCtZNGE1MXV2?=
 =?utf-8?B?ektXWU5ybG90Tno0WjNqQytaTnBrd0ZSSDZObWlUMFVwRlNFdXpxNFFIN1R2?=
 =?utf-8?B?RkJqRTEvNlJXSlVGaW1QQ3BnTG1JaUt5V1Vkc1JwVkVEa0RvSzBSMXV6NS9W?=
 =?utf-8?B?UzNCbFZjN3AydmlacjkweGVKZFJtS3lUK2NvajVUYmlRQlVVUjV5S1RRdGQ3?=
 =?utf-8?B?aDJ0TlhRR0RkeU1QZnZHUWdQNXBPMVJKckZNOW5JQ09KUmd0QU1SZ2VZa3Rm?=
 =?utf-8?B?Njc2VGdZOFRWelNVZjNwdEdnc3JlYlo3aDZPL1ZLMklpZzhuTGUrTXN2dmNv?=
 =?utf-8?B?dmszQm9Jcno2WVN0VFVmalVJYkpnMkpNM2d3WStJSWpNMlhVQktmTktLYjM1?=
 =?utf-8?B?dUw3YnMyakVFdDhlN21FcHpub3FUK3pZS0JOMDE5UnJmb0RVcmZUbWk3RlNZ?=
 =?utf-8?B?Z0R2YzREMFdvUnlWWG5ubGZyZGRXaTdCZFFPTHF0T0h0MXlDZlN5d3UvbGtt?=
 =?utf-8?B?M1dLRzN4YzNleXZnMG5VakZXVkxHSGNxa2FLSWt4NVBBL0RKNWx2ZlNKL28z?=
 =?utf-8?B?eEtpYVZSSk1WZEMxbCtiUlRGRWhqUHh2RWJQZkpVbDQ0YXhReEZmNi8zeHFJ?=
 =?utf-8?B?NmhwS2RDazNnU0x0V0IzTktld2JIamRkWnY0ZHlYTlUrVjgrazZuc1lWNDZu?=
 =?utf-8?B?dmlFZWlWSkhVQVhRaG1HbGNQYUR1ZTBXVkQ0aFIvQlBlbHpabzZwaStDZW1o?=
 =?utf-8?B?eHZxTERPYmxVU3EyUlRSL1l6czBjdGYvWU1Ed2pkK0NnQXVBNGtUYU9YY0dp?=
 =?utf-8?B?ZkhSZTFXamk3WW13dm4rVEhzSFpHem9HMVc4bXFqcW0wTmpZOXN6VU12QUcx?=
 =?utf-8?Q?JYQjwu?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 15:28:50.2436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52fe31eb-8137-4b9e-241c-08dd649f40a6
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B95.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9282

From: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>

DualPI2 provides L4S-type low latency & loss to traffic that uses a
scalable congestion controller (e.g. TCP-Prague, DCTCP) without
degrading the performance of 'classic' traffic (e.g. Reno,
Cubic etc.). It is to be the reference implementation of IETF RFC9332
DualQ Coupled AQM (https://datatracker.ietf.org/doc/html/rfc9332).

Note that creating two independent queues cannot meet the goal of
DualPI2 mentioned in RFC9332: "...to preserve fairness between
ECN-capable and non-ECN-capable traffic." Further, it could even
lead to starvation of Classic traffic, which is also inconsistent
with the requirements in RFC9332: "...although priority MUST be
bounded in order not to starve Classic traffic." DualPI2 is
designed to maintain approximate per-flow fairness on L-queue and
C-queue by forming a single qdisc using the coupling factor and
scheduler between two queues.

The qdisc provides two queues called low latency and classic. It
classifies packets based on the ECN field in the IP headers. By
default it directs non-ECN and ECT(0) into the classic queue and
ECT(1) and CE into the low latency queue, as per the IETF spec.

Each queue runs its own AQM:
* The classic AQM is called PI2, which is similar to the PIE AQM but
  more responsive and simpler. Classic traffic requires a decent
  target queue (default 15ms for Internet deployment) to fully
  utilize the link and to avoid high drop rates.
* The low latency AQM is, by default, a very shallow ECN marking
  threshold (1ms) similar to that used for DCTCP.

The DualQ isolates the low queuing delay of the Low Latency queue
from the larger delay of the 'Classic' queue. However, from a
bandwidth perspective, flows in either queue will share out the link
capacity as if there was just a single queue. This bandwidth pooling
effect is achieved by coupling together the drop and ECN-marking
probabilities of the two AQMs.

The PI2 AQM has two main parameters in addition to its target delay.
The integral gain factor alpha is used to slowly correct any persistent
standing queue error from the target delay, while the proportional gain
factor beta is used to quickly compensate for queue changes (growth or
shrinkage). Either alpha and beta are given as a parameter, or they can
be calculated by tc from alternative typical and maximum RTT parameters.

Internally, the output of a linear Proportional Integral (PI)
controller is used for both queues. This output is squared to
calculate the drop or ECN-marking probability of the classic queue.
This counterbalances the square-root rate equation of Reno/Cubic,
which is the trick that balances flow rates across the queues. For
the ECN-marking probability of the low latency queue, the output of
the base AQM is multiplied by a coupling factor. This determines the
balance between the flow rates in each queue. The default setting
makes the flow rates roughly equal, which should be generally
applicable.

If DUALPI2 AQM has detected overload (due to excessive non-responsive
traffic in either queue), it will switch to signaling congestion
solely using drop, irrespective of the ECN field. Alternatively, it
can be configured to limit the drop probability and let the queue
grow and eventually overflow (like tail-drop).

GSO splitting in DUALPI2 is configurable from userspace while the
default behavior is to split gso. When running DUALPI2 at unshaped
10gigE with 4 download streams test, splitting gso apart results in
halving the latency with no loss in throughput:

Summary of tcp_4down run 'no_split_gso':
                         avg         median      # data pts
 Ping (ms) ICMP   :       0.53      0.30 ms         350
 TCP download avg :    2326.86       N/A Mbits/s    350
 TCP download sum :    9307.42       N/A Mbits/s    350
 TCP download::1  :    2672.99   2568.73 Mbits/s    350
 TCP download::2  :    2586.96   2570.51 Mbits/s    350
 TCP download::3  :    1786.26   1798.82 Mbits/s    350
 TCP download::4  :    2261.21   2309.49 Mbits/s    350

Summart of tcp_4down run 'split_gso':
                         avg          median      # data pts
 Ping (ms) ICMP   :       0.22      0.23 ms         350
 TCP download avg :    2335.02       N/A Mbits/s    350
 TCP download sum :    9340.09       N/A Mbits/s    350
 TCP download::1  :    2335.30   2334.22 Mbits/s    350
 TCP download::2  :    2334.72   2334.20 Mbits/s    350
 TCP download::3  :    2335.28   2334.58 Mbits/s    350
 TCP download::4  :    2334.79   2334.39 Mbits/s    350

A similar result is observed when running DUALPI2 at unshaped 1gigE
with 1 download stream test:

Summary of tcp_1down run 'no_split_gso':
                         avg         median      # data pts
 Ping (ms) ICMP :         1.13      1.25 ms         350
 TCP download   :       941.41    941.46 Mbits/s    350

Summart of tcp_1down run 'split_gso':
                         avg         median      # data pts
 Ping (ms) ICMP :         0.51      0.55 ms         350
 TCP download   :       941.41    941.45 Mbits/s    350

Additional details can be found in the draft:
  https://datatracker.ietf.org/doc/html/rfc9332

Signed-off-by: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
Co-developed-by: Olga Albisser <olga@albisser.org>
Signed-off-by: Olga Albisser <olga@albisser.org>
Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Co-developed-by: Henrik Steen <henrist@henrist.net>
Signed-off-by: Henrik Steen <henrist@henrist.net>
Signed-off-by: Bob Briscoe <research@bobbriscoe.net>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Dave Taht <dave.taht@gmail.com>
---
 include/linux/netdevice.h      |    1 +
 include/uapi/linux/pkt_sched.h |   39 ++
 net/sched/Kconfig              |   12 +
 net/sched/Makefile             |    1 +
 net/sched/sch_dualpi2.c        | 1090 ++++++++++++++++++++++++++++++++
 5 files changed, 1143 insertions(+)
 create mode 100644 net/sched/sch_dualpi2.c

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0dbfe069a6e3..987686e91919 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -30,6 +30,7 @@
 #include <asm/byteorder.h>
 #include <asm/local.h>
 
+#include <linux/netdev_features.h>
 #include <linux/percpu.h>
 #include <linux/rculist.h>
 #include <linux/workqueue.h>
diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 25a9a47001cd..62fec34c1005 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -1210,4 +1210,43 @@ enum {
 
 #define TCA_ETS_MAX (__TCA_ETS_MAX - 1)
 
+/* DUALPI2 */
+enum {
+	TCA_DUALPI2_UNSPEC,
+	TCA_DUALPI2_LIMIT,		/* Packets */
+	TCA_DUALPI2_MEMORY_LIMIT,	/* Bytes */
+	TCA_DUALPI2_TARGET,		/* us */
+	TCA_DUALPI2_TUPDATE,		/* us */
+	TCA_DUALPI2_ALPHA,		/* Hz scaled up by 256 */
+	TCA_DUALPI2_BETA,		/* HZ scaled up by 256 */
+	TCA_DUALPI2_STEP_THRESH,	/* Packets or us */
+	TCA_DUALPI2_STEP_PACKETS,	/* Whether STEP_THRESH is in packets */
+	TCA_DUALPI2_MIN_QLEN_STEP,	/* Minimum qlen to apply STEP_THRESH */
+	TCA_DUALPI2_COUPLING,		/* Coupling factor between queues */
+	TCA_DUALPI2_DROP_OVERLOAD,	/* Whether to drop on overload */
+	TCA_DUALPI2_DROP_EARLY,		/* Whether to drop on enqueue */
+	TCA_DUALPI2_C_PROTECTION,	/* Percentage */
+	TCA_DUALPI2_ECN_MASK,		/* L4S queue classification mask */
+	TCA_DUALPI2_SPLIT_GSO,		/* Split GSO packets at enqueue */
+	TCA_DUALPI2_PAD,
+	__TCA_DUALPI2_MAX
+};
+
+#define TCA_DUALPI2_MAX   (__TCA_DUALPI2_MAX - 1)
+
+struct tc_dualpi2_xstats {
+	__u32 prob;		/* current probability */
+	__u32 delay_c;		/* current delay in C queue */
+	__u32 delay_l;		/* current delay in L queue */
+	__s32 credit;		/* current c_protection credit */
+	__u32 packets_in_c;	/* number of packets enqueued in C queue */
+	__u32 packets_in_l;	/* number of packets enqueued in L queue */
+	__u32 maxq;		/* maximum queue size */
+	__u32 ecn_mark;		/* packets marked with ecn*/
+	__u32 step_marks;	/* ECN marks due to the step AQM */
+	__u32 memory_used;	/* Meory used of both queues */
+	__u32 max_memory_used;	/* Maximum used memory */
+	__u32 memory_limit;	/* Memory limit of both queues */
+};
+
 #endif
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index 8180d0c12fce..f00b5ad92ce2 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -403,6 +403,18 @@ config NET_SCH_ETS
 
 	  If unsure, say N.
 
+config NET_SCH_DUALPI2
+	tristate "Dual Queue PI Square (DUALPI2) scheduler"
+	help
+	  Say Y here if you want to use the Dual Queue Proportional Integral
+	  Controller Improved with a Square scheduling algorithm.
+	  For more information, please see https://tools.ietf.org/html/rfc9332
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called sch_dualpi2.
+
+	  If unsure, say N.
+
 menuconfig NET_SCH_DEFAULT
 	bool "Allow override default queue discipline"
 	help
diff --git a/net/sched/Makefile b/net/sched/Makefile
index 82c3f78ca486..1abb06554057 100644
--- a/net/sched/Makefile
+++ b/net/sched/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_NET_SCH_FQ_PIE)	+= sch_fq_pie.o
 obj-$(CONFIG_NET_SCH_CBS)	+= sch_cbs.o
 obj-$(CONFIG_NET_SCH_ETF)	+= sch_etf.o
 obj-$(CONFIG_NET_SCH_TAPRIO)	+= sch_taprio.o
+obj-$(CONFIG_NET_SCH_DUALPI2)	+= sch_dualpi2.o
 
 obj-$(CONFIG_NET_CLS_U32)	+= cls_u32.o
 obj-$(CONFIG_NET_CLS_ROUTE4)	+= cls_route.o
diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
new file mode 100644
index 000000000000..73d0e65829a0
--- /dev/null
+++ b/net/sched/sch_dualpi2.c
@@ -0,0 +1,1090 @@
+// SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+/* Copyright (C) 2024 Nokia
+ *
+ * Author: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
+ * Author: Olga Albisser <olga@albisser.org>
+ * Author: Henrik Steen <henrist@henrist.net>
+ * Author: Olivier Tilmans <olivier.tilmans@nokia.com>
+ * Author: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
+ *
+ * DualPI Improved with a Square (dualpi2):
+ * - Supports congestion controls that comply with the Prague requirements
+ *   in RFC9331 (e.g. TCP-Prague)
+ * - Supports coupled dual-queue with PI2 as defined in RFC9332
+ * - Supports ECN L4S-identifier (IP.ECN==0b*1)
+ *
+ * note: Although DCTCP and BBRv3 can use shallow-threshold ECN marks,
+ *   they do not meet the 'Prague L4S Requirements' listed in RFC 9331
+ *   Section 4, so they can only be used with DualPI2 in a datacenter
+ *   context.
+ *
+ * References:
+ * - RFC9332: https://datatracker.ietf.org/doc/html/rfc9332
+ * - De Schepper, Koen, et al. "PI 2: A linearized AQM for both classic and
+ *   scalable TCP."  in proc. ACM CoNEXT'16, 2016.
+ */
+
+#include <linux/errno.h>
+#include <linux/hrtimer.h>
+#include <linux/if_vlan.h>
+#include <linux/kernel.h>
+#include <linux/limits.h>
+#include <linux/module.h>
+#include <linux/skbuff.h>
+#include <linux/types.h>
+
+#include <net/gso.h>
+#include <net/inet_ecn.h>
+#include <net/pkt_cls.h>
+#include <net/pkt_sched.h>
+
+/* 32b enable to support flows with windows up to ~8.6 * 1e9 packets
+ * i.e., twice the maximal snd_cwnd.
+ * MAX_PROB must be consistent with the RNG in dualpi2_roll().
+ */
+#define MAX_PROB U32_MAX
+
+/* alpha/beta values exchanged over netlink are in units of 256ns */
+#define ALPHA_BETA_SHIFT 8
+
+/* Scaled values of alpha/beta must fit in 32b to avoid overflow in later
+ * computations. Consequently (see and dualpi2_scale_alpha_beta()), their
+ * netlink-provided values can use at most 31b, i.e. be at most (2^23)-1
+ * (~4MHz) as those are given in 1/256th. This enable to tune alpha/beta to
+ * control flows whose maximal RTTs can be in usec up to few secs.
+ */
+#define ALPHA_BETA_MAX ((1U << 31) - 1)
+
+/* Internal alpha/beta are in units of 64ns.
+ * This enables to use all alpha/beta values in the allowed range without loss
+ * of precision due to rounding when scaling them internally, e.g.,
+ * scale_alpha_beta(1) will not round down to 0.
+ */
+#define ALPHA_BETA_GRANULARITY 6
+
+#define ALPHA_BETA_SCALING (ALPHA_BETA_SHIFT - ALPHA_BETA_GRANULARITY)
+
+/* We express the weights (wc, wl) in %, i.e., wc + wl = 100 */
+#define MAX_WC 100
+
+struct dualpi2_sched_data {
+	struct Qdisc *l_queue;	/* The L4S Low latency queue (L-queue) */
+	struct Qdisc *sch;	/* The Classic queue (C-queue) */
+
+	/* Registered tc filters */
+	struct {
+		struct tcf_proto __rcu *filters;
+		struct tcf_block *block;
+	} tcf;
+
+	struct { /* PI2 parameters */
+		u64	target;	/* Target delay in nanoseconds */
+		u32	tupdate;/* Timer frequency in nanoseconds */
+		u32	prob;	/* Base PI probability */
+		u32	alpha;	/* Gain factor for the integral rate response */
+		u32	beta;	/* Gain factor for the proportional response */
+		struct hrtimer timer; /* prob update timer */
+	} pi2;
+
+	struct { /* Step AQM (L-queue only) parameters */
+		u32 thresh;	/* Step threshold */
+		bool in_packets;/* Whether the step is in packets or time */
+	} step;
+
+	struct { /* C-queue starvation protection */
+		s32	credit; /* Credit (sign indicates which queue) */
+		s32	init;	/* Reset value of the credit */
+		u8	wc;	/* C-queue weight (between 0 and MAX_WC) */
+		u8	wl;	/* L-queue weight (MAX_WC - wc) */
+	} c_protection;
+
+	/* General dualQ parameters */
+	u32	memory_limit;	/* Memory limit of both queues */
+	u8	coupling_factor;/* Coupling factor (k) between both queues */
+	u8	ecn_mask;	/* Mask to match packets into L-queue */
+	u32	min_qlen_step;	/* Minimum queue length to apply step thresh */
+	bool	drop_early;	/* Drop at enqueue instead of dequeue if true */
+	bool	drop_overload;	/* Drop (1) on overload, or overflow (0) */
+	bool	split_gso;	/* Split aggregated skb (1) or leave as is */
+
+	/* Statistics */
+	u64	c_head_ts;	/* Enqueue timestamp of the C-queue head */
+	u64	l_head_ts;	/* Enqueue timestamp of the L-queue head */
+	u64	last_qdelay;	/* Q delay val at the last probability update */
+	u32	packets_in_c;	/* Enqueue packet counter of the C-queue */
+	u32	packets_in_l;	/* Enqueue packet counter of the L-queue */
+	u32	maxq;		/* Maximum queue size of the C-queue */
+	u32	ecn_mark;	/* ECN mark pkt counter due to PI probability */
+	u32	step_marks;	/* ECN mark pkt counter due to step AQM */
+	u32	memory_used;	/* Memory used of both queues */
+	u32	max_memory_used;/* Maximum used memory */
+
+	struct { /* Deferred drop statistics */
+		u32 cnt;	/* Packets dropped */
+		u32 len;	/* Bytes dropped */
+	} deferred_drops;
+};
+
+struct dualpi2_skb_cb {
+	u64 ts;			/* Timestamp at enqueue */
+	u8 apply_step:1,	/* Can we apply the step threshold */
+	   classified:2,	/* Packet classification results */
+	   ect:2;		/* Packet ECT codepoint */
+};
+
+enum dualpi2_classification_results {
+	DUALPI2_C_CLASSIC	= 0,	/* C-queue */
+	DUALPI2_C_L4S		= 1,	/* L-queue (scale mark/classic drop) */
+	DUALPI2_C_LLLL		= 2,	/* L-queue (no drops/marks) */
+	__DUALPI2_C_MAX			/* Keep last*/
+};
+
+static struct dualpi2_skb_cb *dualpi2_skb_cb(struct sk_buff *skb)
+{
+	qdisc_cb_private_validate(skb, sizeof(struct dualpi2_skb_cb));
+	return (struct dualpi2_skb_cb *)qdisc_skb_cb(skb)->data;
+}
+
+static u64 dualpi2_sojourn_time(struct sk_buff *skb, u64 reference)
+{
+	return reference - dualpi2_skb_cb(skb)->ts;
+}
+
+static u64 head_enqueue_time(struct Qdisc *q)
+{
+	struct sk_buff *skb = qdisc_peek_head(q);
+
+	return skb ? dualpi2_skb_cb(skb)->ts : 0;
+}
+
+static u32 dualpi2_scale_alpha_beta(u32 param)
+{
+	u64 tmp = ((u64)param * MAX_PROB >> ALPHA_BETA_SCALING);
+
+	do_div(tmp, NSEC_PER_SEC);
+	return tmp;
+}
+
+static u32 dualpi2_unscale_alpha_beta(u32 param)
+{
+	u64 tmp = ((u64)param * NSEC_PER_SEC << ALPHA_BETA_SCALING);
+
+	do_div(tmp, MAX_PROB);
+	return tmp;
+}
+
+static ktime_t next_pi2_timeout(struct dualpi2_sched_data *q)
+{
+	return ktime_add_ns(ktime_get_ns(), q->pi2.tupdate);
+}
+
+static bool skb_is_l4s(struct sk_buff *skb)
+{
+	return dualpi2_skb_cb(skb)->classified == DUALPI2_C_L4S;
+}
+
+static bool skb_in_l_queue(struct sk_buff *skb)
+{
+	return dualpi2_skb_cb(skb)->classified != DUALPI2_C_CLASSIC;
+}
+
+static bool dualpi2_mark(struct dualpi2_sched_data *q, struct sk_buff *skb)
+{
+	if (INET_ECN_set_ce(skb)) {
+		q->ecn_mark++;
+		return true;
+	}
+	return false;
+}
+
+static void dualpi2_reset_c_protection(struct dualpi2_sched_data *q)
+{
+	q->c_protection.credit = q->c_protection.init;
+}
+
+/* This computes the initial credit value and WRR weight for the L queue (wl)
+ * from the weight of the C queue (wc).
+ * If wl > wc, the scheduler will start with the L queue when reset.
+ */
+static void dualpi2_calculate_c_protection(struct Qdisc *sch,
+					   struct dualpi2_sched_data *q, u32 wc)
+{
+	q->c_protection.wc = wc;
+	q->c_protection.wl = MAX_WC - wc;
+	q->c_protection.init = (s32)psched_mtu(qdisc_dev(sch)) *
+		((int)q->c_protection.wc - (int)q->c_protection.wl);
+	dualpi2_reset_c_protection(q);
+}
+
+static bool dualpi2_roll(u32 prob)
+{
+	return get_random_u32() <= prob;
+}
+
+/* Packets in the C-queue are subject to a marking probability pC, which is the
+ * square of the internal PI probability (i.e., have an overall lower mark/drop
+ * probability). If the qdisc is overloaded, ignore ECT values and only drop.
+ *
+ * Note that this marking scheme is also applied to L4S packets during overload.
+ * Return true if packet dropping is required in C queue
+ */
+static bool dualpi2_classic_marking(struct dualpi2_sched_data *q,
+				    struct sk_buff *skb, u32 prob,
+				    bool overload)
+{
+	if (dualpi2_roll(prob) && dualpi2_roll(prob)) {
+		if (overload || dualpi2_skb_cb(skb)->ect == INET_ECN_NOT_ECT)
+			return true;
+		dualpi2_mark(q, skb);
+	}
+	return false;
+}
+
+/* Packets in the L-queue are subject to a marking probability pL given by the
+ * internal PI probability scaled by the coupling factor.
+ *
+ * On overload (i.e., @local_l_prob is >= 100%):
+ * - if the qdisc is configured to trade losses to preserve latency (i.e.,
+ *   @q->drop_overload), apply classic drops first before marking.
+ * - otherwise, preserve the "no loss" property of ECN at the cost of queueing
+ *   delay, eventually resulting in taildrop behavior once sch->limit is
+ *   reached.
+ * Return true if packet dropping is required in L queue
+ */
+static bool dualpi2_scalable_marking(struct dualpi2_sched_data *q,
+				     struct sk_buff *skb,
+				     u64 local_l_prob, u32 prob,
+				     bool overload)
+{
+	if (overload) {
+		/* Apply classic drop */
+		if (!q->drop_overload ||
+		    !(dualpi2_roll(prob) && dualpi2_roll(prob)))
+			goto mark;
+		return true;
+	}
+
+	/* We can safely cut the upper 32b as overload==false */
+	if (dualpi2_roll(local_l_prob)) {
+		/* Non-ECT packets could have classified as L4S by filters. */
+		if (dualpi2_skb_cb(skb)->ect == INET_ECN_NOT_ECT)
+			return true;
+mark:
+		dualpi2_mark(q, skb);
+	}
+	return false;
+}
+
+/* Decide whether a given packet must be dropped (or marked if ECT), according
+ * to the PI2 probability.
+ *
+ * Never mark/drop if we have a standing queue of less than 2 MTUs.
+ */
+static bool must_drop(struct Qdisc *sch, struct dualpi2_sched_data *q,
+		      struct sk_buff *skb)
+{
+	u64 local_l_prob;
+	u32 prob;
+	bool overload;
+
+	if (sch->qstats.backlog < 2 * psched_mtu(qdisc_dev(sch)))
+		return false;
+
+	prob = READ_ONCE(q->pi2.prob);
+	local_l_prob = (u64)prob * q->coupling_factor;
+	overload = local_l_prob > MAX_PROB;
+
+	switch (dualpi2_skb_cb(skb)->classified) {
+	case DUALPI2_C_CLASSIC:
+		return dualpi2_classic_marking(q, skb, prob, overload);
+	case DUALPI2_C_L4S:
+		return dualpi2_scalable_marking(q, skb, local_l_prob, prob,
+						overload);
+	default: /* DUALPI2_C_LLLL */
+		return false;
+	}
+}
+
+static void dualpi2_read_ect(struct sk_buff *skb)
+{
+	struct dualpi2_skb_cb *cb = dualpi2_skb_cb(skb);
+	int wlen = skb_network_offset(skb);
+
+	switch (skb_protocol(skb, true)) {
+	case htons(ETH_P_IP):
+		wlen += sizeof(struct iphdr);
+		if (!pskb_may_pull(skb, wlen) ||
+		    skb_try_make_writable(skb, wlen))
+			goto not_ecn;
+
+		cb->ect = ipv4_get_dsfield(ip_hdr(skb)) & INET_ECN_MASK;
+		break;
+	case htons(ETH_P_IPV6):
+		wlen += sizeof(struct ipv6hdr);
+		if (!pskb_may_pull(skb, wlen) ||
+		    skb_try_make_writable(skb, wlen))
+			goto not_ecn;
+
+		cb->ect = ipv6_get_dsfield(ipv6_hdr(skb)) & INET_ECN_MASK;
+		break;
+	default:
+		goto not_ecn;
+	}
+	return;
+
+not_ecn:
+	/* Non pullable/writable packets can only be dropped hence are
+	 * classified as not ECT.
+	 */
+	cb->ect = INET_ECN_NOT_ECT;
+}
+
+static int dualpi2_skb_classify(struct dualpi2_sched_data *q,
+				struct sk_buff *skb)
+{
+	struct dualpi2_skb_cb *cb = dualpi2_skb_cb(skb);
+	struct tcf_result res;
+	struct tcf_proto *fl;
+	int result;
+
+	dualpi2_read_ect(skb);
+	if (cb->ect & q->ecn_mask) {
+		cb->classified = DUALPI2_C_L4S;
+		return NET_XMIT_SUCCESS;
+	}
+
+	if (TC_H_MAJ(skb->priority) == q->sch->handle &&
+	    TC_H_MIN(skb->priority) < __DUALPI2_C_MAX) {
+		cb->classified = TC_H_MIN(skb->priority);
+		return NET_XMIT_SUCCESS;
+	}
+
+	fl = rcu_dereference_bh(q->tcf.filters);
+	if (!fl) {
+		cb->classified = DUALPI2_C_CLASSIC;
+		return NET_XMIT_SUCCESS;
+	}
+
+	result = tcf_classify(skb, NULL, fl, &res, false);
+	if (result >= 0) {
+#ifdef CONFIG_NET_CLS_ACT
+		switch (result) {
+		case TC_ACT_STOLEN:
+		case TC_ACT_QUEUED:
+		case TC_ACT_TRAP:
+			return NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
+		case TC_ACT_SHOT:
+			return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
+		}
+#endif
+		cb->classified = TC_H_MIN(res.classid) < __DUALPI2_C_MAX ?
+			TC_H_MIN(res.classid) : DUALPI2_C_CLASSIC;
+	}
+	return NET_XMIT_SUCCESS;
+}
+
+static int dualpi2_enqueue_skb(struct sk_buff *skb, struct Qdisc *sch,
+			       struct sk_buff **to_free)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	struct dualpi2_skb_cb *cb;
+
+	if (unlikely(qdisc_qlen(sch) >= sch->limit) ||
+	    unlikely((u64)q->memory_used + skb->truesize > q->memory_limit)) {
+		qdisc_qstats_overlimit(sch);
+		if (skb_in_l_queue(skb))
+			qdisc_qstats_overlimit(q->l_queue);
+		return qdisc_drop(skb, sch, to_free);
+	}
+
+	if (q->drop_early && must_drop(sch, q, skb)) {
+		qdisc_drop(skb, sch, to_free);
+		return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
+	}
+
+	cb = dualpi2_skb_cb(skb);
+	cb->ts = ktime_get_ns();
+	q->memory_used += skb->truesize;
+	if (q->memory_used > q->max_memory_used)
+		q->max_memory_used = q->memory_used;
+
+	if (qdisc_qlen(sch) > q->maxq)
+		q->maxq = qdisc_qlen(sch);
+
+	if (skb_in_l_queue(skb)) {
+		/* Only apply the step if a queue is building up */
+		dualpi2_skb_cb(skb)->apply_step = skb_is_l4s(skb) &&
+			qdisc_qlen(q->l_queue) >= q->min_qlen_step;
+		/* Keep the overall qdisc stats consistent */
+		++sch->q.qlen;
+		qdisc_qstats_backlog_inc(sch, skb);
+		++q->packets_in_l;
+		if (!q->l_head_ts)
+			q->l_head_ts = cb->ts;
+		return qdisc_enqueue_tail(skb, q->l_queue);
+	}
+	++q->packets_in_c;
+	if (!q->c_head_ts)
+		q->c_head_ts = cb->ts;
+	return qdisc_enqueue_tail(skb, sch);
+}
+
+/* By default, dualpi2 will split GSO skbs into independent skbs and enqueue
+ * each of those individually. This yields the following benefits, at the
+ * expense of CPU usage:
+ * - Finer-grained AQM actions as the sub-packets of a burst no longer share the
+ *   same fate (e.g., the random mark/drop probability is applied individually)
+ * - Improved precision of the starvation protection/WRR scheduler at dequeue,
+ *   as the size of the dequeued packets will be smaller.
+ */
+static int dualpi2_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
+				 struct sk_buff **to_free)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	int err;
+
+	err = dualpi2_skb_classify(q, skb);
+	if (err != NET_XMIT_SUCCESS) {
+		if (err & __NET_XMIT_BYPASS)
+			qdisc_qstats_drop(sch);
+		__qdisc_drop(skb, to_free);
+		return err;
+	}
+
+	if (q->split_gso && skb_is_gso(skb)) {
+		netdev_features_t features;
+		struct sk_buff *nskb, *next;
+		int cnt, byte_len, orig_len;
+		int err;
+
+		features = netif_skb_features(skb);
+		nskb = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
+		if (IS_ERR_OR_NULL(nskb))
+			return qdisc_drop(skb, sch, to_free);
+
+		cnt = 1;
+		byte_len = 0;
+		orig_len = qdisc_pkt_len(skb);
+		skb_list_walk_safe(nskb, nskb, next) {
+			skb_mark_not_on_list(nskb);
+			qdisc_skb_cb(nskb)->pkt_len = nskb->len;
+			dualpi2_skb_cb(nskb)->classified =
+				dualpi2_skb_cb(skb)->classified;
+			dualpi2_skb_cb(nskb)->ect = dualpi2_skb_cb(skb)->ect;
+			err = dualpi2_enqueue_skb(nskb, sch, to_free);
+			if (err == NET_XMIT_SUCCESS) {
+				/* Compute the backlog adjustment that needs
+				 * to be propagated in the qdisc tree to reflect
+				 * all new skbs successfully enqueued.
+				 */
+				++cnt;
+				byte_len += nskb->len;
+			}
+		}
+		if (err == NET_XMIT_SUCCESS) {
+			/* The caller will add the original skb stats to its
+			 * backlog, compensate this.
+			 */
+			--cnt;
+			byte_len -= orig_len;
+		}
+		qdisc_tree_reduce_backlog(sch, -cnt, -byte_len);
+		consume_skb(skb);
+		return err;
+	}
+	return dualpi2_enqueue_skb(skb, sch, to_free);
+}
+
+/* Select the queue from which the next packet can be dequeued, ensuring that
+ * neither queue can starve the other with a WRR scheduler.
+ *
+ * The sign of the WRR credit determines the next queue, while the size of
+ * the dequeued packet determines the magnitude of the WRR credit change. If
+ * either queue is empty, the WRR credit is kept unchanged.
+ *
+ * As the dequeued packet can be dropped later, the caller has to perform the
+ * qdisc_bstats_update() calls.
+ */
+static struct sk_buff *dequeue_packet(struct Qdisc *sch,
+				      struct dualpi2_sched_data *q,
+				      int *credit_change,
+				      u64 now)
+{
+	struct sk_buff *skb = NULL;
+	int c_len;
+
+	*credit_change = 0;
+	c_len = qdisc_qlen(sch) - qdisc_qlen(q->l_queue);
+	if (qdisc_qlen(q->l_queue) && (!c_len || q->c_protection.credit <= 0)) {
+		skb = __qdisc_dequeue_head(&q->l_queue->q);
+		WRITE_ONCE(q->l_head_ts, head_enqueue_time(q->l_queue));
+		if (c_len)
+			*credit_change = q->c_protection.wc;
+		qdisc_qstats_backlog_dec(q->l_queue, skb);
+		/* Keep the global queue size consistent */
+		--sch->q.qlen;
+		q->memory_used -= skb->truesize;
+	} else if (c_len) {
+		skb = __qdisc_dequeue_head(&sch->q);
+		WRITE_ONCE(q->c_head_ts, head_enqueue_time(sch));
+		if (qdisc_qlen(q->l_queue))
+			*credit_change = ~((s32)q->c_protection.wl) + 1;
+		q->memory_used -= skb->truesize;
+	} else {
+		dualpi2_reset_c_protection(q);
+		return NULL;
+	}
+	*credit_change *= qdisc_pkt_len(skb);
+	qdisc_qstats_backlog_dec(sch, skb);
+	return skb;
+}
+
+static int do_step_aqm(struct dualpi2_sched_data *q, struct sk_buff *skb,
+		       u64 now)
+{
+	u64 qdelay = 0;
+
+	if (q->step.in_packets)
+		qdelay = qdisc_qlen(q->l_queue);
+	else
+		qdelay = dualpi2_sojourn_time(skb, now);
+
+	if (dualpi2_skb_cb(skb)->apply_step && qdelay > q->step.thresh) {
+		if (!dualpi2_skb_cb(skb)->ect)
+			/* Drop this non-ECT packet */
+			return 1;
+		if (dualpi2_mark(q, skb))
+			++q->step_marks;
+	}
+	qdisc_bstats_update(q->l_queue, skb);
+	return 0;
+}
+
+static void drop_and_retry(struct dualpi2_sched_data *q, struct sk_buff *skb,
+			   struct Qdisc *sch)
+{
+	++q->deferred_drops.cnt;
+	q->deferred_drops.len += qdisc_pkt_len(skb);
+	consume_skb(skb);
+	qdisc_qstats_drop(sch);
+}
+
+static struct sk_buff *dualpi2_qdisc_dequeue(struct Qdisc *sch)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	struct sk_buff *skb;
+	int credit_change;
+	u64 now;
+
+	now = ktime_get_ns();
+
+	while ((skb = dequeue_packet(sch, q, &credit_change, now))) {
+		if (!q->drop_early && must_drop(sch, q, skb)) {
+			drop_and_retry(q, skb, sch);
+			continue;
+		}
+
+		if (skb_in_l_queue(skb) && do_step_aqm(q, skb, now)) {
+			qdisc_qstats_drop(q->l_queue);
+			drop_and_retry(q, skb, sch);
+			continue;
+		}
+
+		q->c_protection.credit += credit_change;
+		qdisc_bstats_update(sch, skb);
+		break;
+	}
+
+	/* We cannot call qdisc_tree_reduce_backlog() if our qlen is 0,
+	 * or HTB crashes.
+	 */
+	if (q->deferred_drops.cnt && qdisc_qlen(sch)) {
+		qdisc_tree_reduce_backlog(sch, q->deferred_drops.cnt,
+					  q->deferred_drops.len);
+		q->deferred_drops.cnt = 0;
+		q->deferred_drops.len = 0;
+	}
+	return skb;
+}
+
+static s64 __scale_delta(u64 diff)
+{
+	do_div(diff, 1 << ALPHA_BETA_GRANULARITY);
+	return diff;
+}
+
+static void get_queue_delays(struct dualpi2_sched_data *q, u64 *qdelay_c,
+			     u64 *qdelay_l)
+{
+	u64 now, qc, ql;
+
+	now = ktime_get_ns();
+	qc = READ_ONCE(q->c_head_ts);
+	ql = READ_ONCE(q->l_head_ts);
+
+	*qdelay_c = qc ? now - qc : 0;
+	*qdelay_l = ql ? now - ql : 0;
+}
+
+static u32 calculate_probability(struct Qdisc *sch)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	u32 new_prob;
+	u64 qdelay_c;
+	u64 qdelay_l;
+	u64 qdelay;
+	s64 delta;
+
+	get_queue_delays(q, &qdelay_c, &qdelay_l);
+	qdelay = max(qdelay_l, qdelay_c);
+	/* Alpha and beta take at most 32b, i.e, the delay difference would
+	 * overflow for queuing delay differences > ~4.2sec.
+	 */
+	delta = ((s64)qdelay - q->pi2.target) * q->pi2.alpha;
+	delta += ((s64)qdelay - q->last_qdelay) * q->pi2.beta;
+	if (delta > 0) {
+		new_prob = __scale_delta(delta) + q->pi2.prob;
+		if (new_prob < q->pi2.prob)
+			new_prob = MAX_PROB;
+	} else {
+		new_prob = q->pi2.prob - __scale_delta(~delta + 1);
+		if (new_prob > q->pi2.prob)
+			new_prob = 0;
+	}
+	q->last_qdelay = qdelay;
+	/* If we do not drop on overload, ensure we cap the L4S probability to
+	 * 100% to keep window fairness when overflowing.
+	 */
+	if (!q->drop_overload)
+		return min_t(u32, new_prob, MAX_PROB / q->coupling_factor);
+	return new_prob;
+}
+
+static enum hrtimer_restart dualpi2_timer(struct hrtimer *timer)
+{
+	struct dualpi2_sched_data *q = from_timer(q, timer, pi2.timer);
+
+	WRITE_ONCE(q->pi2.prob, calculate_probability(q->sch));
+
+	hrtimer_set_expires(&q->pi2.timer, next_pi2_timeout(q));
+	return HRTIMER_RESTART;
+}
+
+static struct netlink_range_validation dualpi2_alpha_beta_range = {
+	.min = 1,
+	.max = ALPHA_BETA_MAX,
+};
+
+static struct netlink_range_validation dualpi2_wc_range = {
+	.min = 0,
+	.max = MAX_WC,
+};
+
+static const struct nla_policy dualpi2_policy[TCA_DUALPI2_MAX + 1] = {
+	[TCA_DUALPI2_LIMIT]		= NLA_POLICY_MIN(NLA_U32, 1),
+	[TCA_DUALPI2_MEMORY_LIMIT]	= NLA_POLICY_MIN(NLA_U32, 1),
+	[TCA_DUALPI2_TARGET]		= {.type = NLA_U32},
+	[TCA_DUALPI2_TUPDATE]		= NLA_POLICY_MIN(NLA_U32, 1),
+	[TCA_DUALPI2_ALPHA]		=
+		NLA_POLICY_FULL_RANGE(NLA_U32, &dualpi2_alpha_beta_range),
+	[TCA_DUALPI2_BETA]		=
+		NLA_POLICY_FULL_RANGE(NLA_U32, &dualpi2_alpha_beta_range),
+	[TCA_DUALPI2_STEP_THRESH]	= {.type = NLA_U32},
+	[TCA_DUALPI2_STEP_PACKETS]	= {.type = NLA_U8},
+	[TCA_DUALPI2_MIN_QLEN_STEP]	= {.type = NLA_U32},
+	[TCA_DUALPI2_COUPLING]		= NLA_POLICY_MIN(NLA_U8, 1),
+	[TCA_DUALPI2_DROP_OVERLOAD]	= {.type = NLA_U8},
+	[TCA_DUALPI2_DROP_EARLY]	= {.type = NLA_U8},
+	[TCA_DUALPI2_C_PROTECTION]	=
+		NLA_POLICY_FULL_RANGE(NLA_U8, &dualpi2_wc_range),
+	[TCA_DUALPI2_ECN_MASK]		= {.type = NLA_U8},
+	[TCA_DUALPI2_SPLIT_GSO]		= {.type = NLA_U8},
+};
+
+static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
+			  struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[TCA_DUALPI2_MAX + 1];
+	struct dualpi2_sched_data *q;
+	int old_backlog;
+	int old_qlen;
+	int err;
+
+	if (!opt)
+		return -EINVAL;
+	err = nla_parse_nested(tb, TCA_DUALPI2_MAX, opt, dualpi2_policy,
+			       extack);
+	if (err < 0)
+		return err;
+
+	q = qdisc_priv(sch);
+	sch_tree_lock(sch);
+
+	if (tb[TCA_DUALPI2_LIMIT]) {
+		u32 limit = nla_get_u32(tb[TCA_DUALPI2_LIMIT]);
+
+		WRITE_ONCE(sch->limit, limit);
+		WRITE_ONCE(q->memory_limit, limit * psched_mtu(qdisc_dev(sch)));
+	}
+
+	if (tb[TCA_DUALPI2_MEMORY_LIMIT])
+		WRITE_ONCE(q->memory_limit,
+			   nla_get_u32(tb[TCA_DUALPI2_MEMORY_LIMIT]));
+
+	if (tb[TCA_DUALPI2_TARGET]) {
+		u64 target = nla_get_u32(tb[TCA_DUALPI2_TARGET]);
+
+		WRITE_ONCE(q->pi2.target, target * NSEC_PER_USEC);
+	}
+
+	if (tb[TCA_DUALPI2_TUPDATE]) {
+		u64 tupdate = nla_get_u32(tb[TCA_DUALPI2_TUPDATE]);
+
+		WRITE_ONCE(q->pi2.tupdate, tupdate * NSEC_PER_USEC);
+	}
+
+	if (tb[TCA_DUALPI2_ALPHA]) {
+		u32 alpha = nla_get_u32(tb[TCA_DUALPI2_ALPHA]);
+
+		WRITE_ONCE(q->pi2.alpha, dualpi2_scale_alpha_beta(alpha));
+	}
+
+	if (tb[TCA_DUALPI2_BETA]) {
+		u32 beta = nla_get_u32(tb[TCA_DUALPI2_BETA]);
+
+		WRITE_ONCE(q->pi2.beta, dualpi2_scale_alpha_beta(beta));
+	}
+
+	if (tb[TCA_DUALPI2_STEP_PACKETS]) {
+		bool step_pkt = !!nla_get_u8(tb[TCA_DUALPI2_STEP_PACKETS]);
+		u32 step_th = READ_ONCE(q->step.thresh);
+
+		WRITE_ONCE(q->step.in_packets, step_pkt);
+		WRITE_ONCE(q->step.thresh,
+			   step_pkt ? step_th : (step_th * NSEC_PER_USEC));
+	}
+
+	if (tb[TCA_DUALPI2_STEP_THRESH]) {
+		u32 step_th = nla_get_u32(tb[TCA_DUALPI2_STEP_THRESH]);
+		bool step_pkt = READ_ONCE(q->step.in_packets);
+
+		WRITE_ONCE(q->step.thresh,
+			   step_pkt ? step_th : (step_th * NSEC_PER_USEC));
+	}
+
+	if (tb[TCA_DUALPI2_MIN_QLEN_STEP])
+		WRITE_ONCE(q->min_qlen_step,
+			   nla_get_u32(tb[TCA_DUALPI2_MIN_QLEN_STEP]));
+
+	if (tb[TCA_DUALPI2_COUPLING]) {
+		u8 coupling = nla_get_u8(tb[TCA_DUALPI2_COUPLING]);
+
+		WRITE_ONCE(q->coupling_factor, coupling);
+	}
+
+	if (tb[TCA_DUALPI2_DROP_OVERLOAD])
+		WRITE_ONCE(q->drop_overload,
+			   !!nla_get_u8(tb[TCA_DUALPI2_DROP_OVERLOAD]));
+
+	if (tb[TCA_DUALPI2_DROP_EARLY])
+		WRITE_ONCE(q->drop_early,
+			   !!nla_get_u8(tb[TCA_DUALPI2_DROP_EARLY]));
+
+	if (tb[TCA_DUALPI2_C_PROTECTION]) {
+		u8 wc = nla_get_u8(tb[TCA_DUALPI2_C_PROTECTION]);
+
+		dualpi2_calculate_c_protection(sch, q, wc);
+	}
+
+	if (tb[TCA_DUALPI2_ECN_MASK])
+		WRITE_ONCE(q->ecn_mask,
+			   nla_get_u8(tb[TCA_DUALPI2_ECN_MASK]));
+
+	if (tb[TCA_DUALPI2_SPLIT_GSO])
+		WRITE_ONCE(q->split_gso,
+			   !!nla_get_u8(tb[TCA_DUALPI2_SPLIT_GSO]));
+
+	old_qlen = qdisc_qlen(sch);
+	old_backlog = sch->qstats.backlog;
+	while (qdisc_qlen(sch) > sch->limit ||
+	       q->memory_used > q->memory_limit) {
+		struct sk_buff *skb = __qdisc_dequeue_head(&sch->q);
+
+		q->memory_used -= skb->truesize;
+		qdisc_qstats_backlog_dec(sch, skb);
+		rtnl_qdisc_drop(skb, sch);
+	}
+	qdisc_tree_reduce_backlog(sch, old_qlen - qdisc_qlen(sch),
+				  old_backlog - sch->qstats.backlog);
+
+	sch_tree_unlock(sch);
+	return 0;
+}
+
+/* Default alpha/beta values give a 10dB stability margin with max_rtt=100ms. */
+static void dualpi2_reset_default(struct Qdisc *sch)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+
+	q->sch->limit = 10000;				/* Max 125ms at 1Gbps */
+	q->memory_limit = q->sch->limit * psched_mtu(qdisc_dev(sch));
+
+	q->pi2.target = 15 * NSEC_PER_MSEC;
+	q->pi2.tupdate = 16 * NSEC_PER_MSEC;
+	q->pi2.alpha = dualpi2_scale_alpha_beta(41);	/* ~0.16 Hz * 256 */
+	q->pi2.beta = dualpi2_scale_alpha_beta(819);	/* ~3.20 Hz * 256 */
+
+	q->step.thresh = 1 * NSEC_PER_MSEC;
+	q->step.in_packets = false;
+
+	dualpi2_calculate_c_protection(q->sch, q, 10);	/* wc=10%, wl=90% */
+
+	q->ecn_mask = INET_ECN_ECT_1;
+	q->min_qlen_step = 0;
+	q->coupling_factor = 2;		/* window fairness for equal RTTs */
+	q->drop_overload = true;	/* Preserve latency by dropping */
+	q->drop_early = false;		/* PI2 drops on dequeue */
+	q->split_gso = true;
+}
+
+static int dualpi2_init(struct Qdisc *sch, struct nlattr *opt,
+			struct netlink_ext_ack *extack)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	int err;
+
+	q->l_queue = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
+				       TC_H_MAKE(sch->handle, 1), extack);
+	if (!q->l_queue)
+		return -ENOMEM;
+
+	err = tcf_block_get(&q->tcf.block, &q->tcf.filters, sch, extack);
+	if (err)
+		return err;
+
+	q->sch = sch;
+	dualpi2_reset_default(sch);
+	hrtimer_init(&q->pi2.timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
+	q->pi2.timer.function = dualpi2_timer;
+
+	if (opt) {
+		err = dualpi2_change(sch, opt, extack);
+
+		if (err)
+			return err;
+	}
+
+	hrtimer_start(&q->pi2.timer, next_pi2_timeout(q),
+		      HRTIMER_MODE_ABS_PINNED);
+	return 0;
+}
+
+static u32 convert_ns_to_usec(u64 ns)
+{
+	do_div(ns, NSEC_PER_USEC);
+	return ns;
+}
+
+static int dualpi2_dump(struct Qdisc *sch, struct sk_buff *skb)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	struct nlattr *opts;
+
+	opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
+	if (!opts)
+		goto nla_put_failure;
+
+	if (nla_put_u32(skb, TCA_DUALPI2_LIMIT, READ_ONCE(sch->limit)) ||
+	    nla_put_u32(skb, TCA_DUALPI2_MEMORY_LIMIT,
+			READ_ONCE(q->memory_limit)) ||
+	    nla_put_u32(skb, TCA_DUALPI2_TARGET,
+			convert_ns_to_usec(READ_ONCE(q->pi2.target))) ||
+	    nla_put_u32(skb, TCA_DUALPI2_TUPDATE,
+			convert_ns_to_usec(READ_ONCE(q->pi2.tupdate))) ||
+	    nla_put_u32(skb, TCA_DUALPI2_ALPHA,
+			dualpi2_unscale_alpha_beta(READ_ONCE(q->pi2.alpha))) ||
+	    nla_put_u32(skb, TCA_DUALPI2_BETA,
+			dualpi2_unscale_alpha_beta(READ_ONCE(q->pi2.beta))) ||
+	    nla_put_u32(skb, TCA_DUALPI2_STEP_THRESH,
+			READ_ONCE(q->step.in_packets) ?
+			READ_ONCE(q->step.thresh) :
+			convert_ns_to_usec(READ_ONCE(q->step.thresh))) ||
+	    nla_put_u32(skb, TCA_DUALPI2_MIN_QLEN_STEP,
+			READ_ONCE(q->min_qlen_step)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_COUPLING,
+		       READ_ONCE(q->coupling_factor)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_DROP_OVERLOAD,
+		       READ_ONCE(q->drop_overload)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_STEP_PACKETS,
+		       READ_ONCE(q->step.in_packets)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_DROP_EARLY,
+		       READ_ONCE(q->drop_early)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_C_PROTECTION,
+		       READ_ONCE(q->c_protection.wc)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_ECN_MASK, READ_ONCE(q->ecn_mask)) ||
+	    nla_put_u8(skb, TCA_DUALPI2_SPLIT_GSO, READ_ONCE(q->split_gso)))
+		goto nla_put_failure;
+
+	return nla_nest_end(skb, opts);
+
+nla_put_failure:
+	nla_nest_cancel(skb, opts);
+	return -1;
+}
+
+static int dualpi2_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+	struct tc_dualpi2_xstats st = {
+		.prob			= READ_ONCE(q->pi2.prob),
+		.packets_in_c		= q->packets_in_c,
+		.packets_in_l		= q->packets_in_l,
+		.maxq			= q->maxq,
+		.ecn_mark		= q->ecn_mark,
+		.credit			= q->c_protection.credit,
+		.step_marks		= q->step_marks,
+		.memory_used		= q->memory_used,
+		.max_memory_used	= q->max_memory_used,
+		.memory_limit		= q->memory_limit,
+	};
+	u64 qc, ql;
+
+	get_queue_delays(q, &qc, &ql);
+	st.delay_l = convert_ns_to_usec(ql);
+	st.delay_c = convert_ns_to_usec(qc);
+	return gnet_stats_copy_app(d, &st, sizeof(st));
+}
+
+/* Reset both L-queue and C-queue, internal packet counters, PI probability,
+ * C-queue protection credit, and timestamps, while preserving current
+ * configuration of DUALPI2.
+ */
+static void dualpi2_reset(struct Qdisc *sch)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+
+	qdisc_reset_queue(sch);
+	qdisc_reset_queue(q->l_queue);
+	q->c_head_ts = 0;
+	q->l_head_ts = 0;
+	q->pi2.prob = 0;
+	q->packets_in_c = 0;
+	q->packets_in_l = 0;
+	q->maxq = 0;
+	q->ecn_mark = 0;
+	q->step_marks = 0;
+	q->memory_used = 0;
+	q->max_memory_used = 0;
+	dualpi2_reset_c_protection(q);
+}
+
+static void dualpi2_destroy(struct Qdisc *sch)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+
+	q->pi2.tupdate = 0;
+	hrtimer_cancel(&q->pi2.timer);
+	if (q->l_queue)
+		qdisc_put(q->l_queue);
+	tcf_block_put(q->tcf.block);
+}
+
+static struct Qdisc *dualpi2_leaf(struct Qdisc *sch, unsigned long arg)
+{
+	return NULL;
+}
+
+static unsigned long dualpi2_find(struct Qdisc *sch, u32 classid)
+{
+	return 0;
+}
+
+static unsigned long dualpi2_bind(struct Qdisc *sch, unsigned long parent,
+				  u32 classid)
+{
+	return 0;
+}
+
+static void dualpi2_unbind(struct Qdisc *q, unsigned long cl)
+{
+}
+
+static struct tcf_block *dualpi2_tcf_block(struct Qdisc *sch, unsigned long cl,
+					   struct netlink_ext_ack *extack)
+{
+	struct dualpi2_sched_data *q = qdisc_priv(sch);
+
+	if (cl)
+		return NULL;
+	return q->tcf.block;
+}
+
+static void dualpi2_walk(struct Qdisc *sch, struct qdisc_walker *arg)
+{
+	unsigned int i;
+
+	if (arg->stop)
+		return;
+
+	/* We statically define only 2 queues */
+	for (i = 0; i < 2; i++) {
+		if (arg->count < arg->skip) {
+			arg->count++;
+			continue;
+		}
+		if (arg->fn(sch, i + 1, arg) < 0) {
+			arg->stop = 1;
+			break;
+		}
+		arg->count++;
+	}
+}
+
+/* Minimal class support to handler tc filters */
+static const struct Qdisc_class_ops dualpi2_class_ops = {
+	.leaf		= dualpi2_leaf,
+	.find		= dualpi2_find,
+	.tcf_block	= dualpi2_tcf_block,
+	.bind_tcf	= dualpi2_bind,
+	.unbind_tcf	= dualpi2_unbind,
+	.walk		= dualpi2_walk,
+};
+
+static struct Qdisc_ops dualpi2_qdisc_ops __read_mostly = {
+	.id		= "dualpi2",
+	.cl_ops		= &dualpi2_class_ops,
+	.priv_size	= sizeof(struct dualpi2_sched_data),
+	.enqueue	= dualpi2_qdisc_enqueue,
+	.dequeue	= dualpi2_qdisc_dequeue,
+	.peek		= qdisc_peek_dequeued,
+	.init		= dualpi2_init,
+	.destroy	= dualpi2_destroy,
+	.reset		= dualpi2_reset,
+	.change		= dualpi2_change,
+	.dump		= dualpi2_dump,
+	.dump_stats	= dualpi2_dump_stats,
+	.owner		= THIS_MODULE,
+};
+
+static int __init dualpi2_module_init(void)
+{
+	return register_qdisc(&dualpi2_qdisc_ops);
+}
+
+static void __exit dualpi2_module_exit(void)
+{
+	unregister_qdisc(&dualpi2_qdisc_ops);
+}
+
+module_init(dualpi2_module_init);
+module_exit(dualpi2_module_exit);
+
+MODULE_DESCRIPTION("Dual Queue with Proportional Integral controller Improved with a Square (dualpi2) scheduler");
+MODULE_AUTHOR("Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>");
+MODULE_AUTHOR("Olga Albisser <olga@albisser.org>");
+MODULE_AUTHOR("Henrik Steen <henrist@henrist.net>");
+MODULE_AUTHOR("Olivier Tilmans <olivier.tilmans@nokia.com>");
+MODULE_AUTHOR("Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>");
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_VERSION("1.0");
-- 
2.34.1


