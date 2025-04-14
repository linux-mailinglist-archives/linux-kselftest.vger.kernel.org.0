Return-Path: <linux-kselftest+bounces-30817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC63DA891B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 03:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD1F17D17C
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 01:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A94E2036E8;
	Tue, 15 Apr 2025 01:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="atjrVMIu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974D3433B1;
	Tue, 15 Apr 2025 01:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744682288; cv=fail; b=WfM2y1ln9dkJ5pOsbxXwoIGURVyJiF8YbxL6M5Eq+vscScgzb/MsIPuPxKp8g3iGACWkS89aTun/QJfY0zdPJ3lXlVcpt+PrjFX+0+lqPiyCWQj9ExyRv1uuqH5b7Hj37e079FBAY3aN+PdVN02idi09HiQYC/+cFbknk19vWj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744682288; c=relaxed/simple;
	bh=IYDVG7Bsz4Dzau0WyEiLZTe6exBbiIkKys0xrrjlHYM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Uys9+0IfQ982aKJ6xIjJPcCN9hs8PtPy2EeI2vSkfz0JLXWXnDoJa3fi6UbELJrQ+UpJDn4+pGD66gxN6lQcuhp04RC9FTcRtzT/DKYxgdLrs01aGlD0Q5bhHZmMK+yKyHMUnk1mY1gRVe9wbpUqa3ilzHcTY4/hbEmNw+caoYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=atjrVMIu; arc=fail smtp.client-ip=40.107.21.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TF69vCqOXo5QuOIScLEpScpyoWOa3oHpV5DAt/4U/BYrq0X43psfXfwbZ/5UzpD1qfnGVW4w/GlfFBnX4677RNb67y+BByFb2R6rbW8sAhoXddYNQFbSYVn2AJG3rBnWllM5w5FBreOIDUpNMZ22jkJPrPg15nEuur/LECVf0JxNIxOR2decOA60fApkf91l1T/7KGrueZYGwYPIf39SwVoZn+97NTEL0N3UySfRr8C78AahWPlKH2D/5p8bF+UdNVwxX4nThvhbB+YDZEQYXj5JnNjrIyu8FYU0U9vEuRwRYDIwAhJlEy3qQt1BukjcHe3BgRQHDnhVQyYc8mUR5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVfNtaoj6l3ceB8QOIPPbdsRvQwI8Ihl6TR0rjSwNL4=;
 b=BQE4RBUbsQpbzRF0swlulbNy3rXnSGTKDQqWtIffOb6kynOzVOavWFavfNvhQvCJCTxgDxFSFzE55IEEMstaZ6P66b03E8a4cF1dZi/FAdr1nS4wEJfAQVMlik+2tUNrPQjD1CUvKSVoSPFjMq6g/XLiQDTeTICyKk9EGN1F6pfsOvEh2ckor6x/VHyZ//8O5kSB1B/sOkJrvc8OJnfjAXRFHUeqVyCtDy75bg3D+DlRfBZl8gkHOOe+mghbNqq3I+gv+N+9l+X+bvFfwPzOPsqmrcoIREcXHUXQBA7eMlRQAEK7mnlApNqXNW4jM2SMFvH9RHHp5sSna17aWUJaYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVfNtaoj6l3ceB8QOIPPbdsRvQwI8Ihl6TR0rjSwNL4=;
 b=atjrVMIuZgYKt2pTxgKWrvwEHxKcjNLCMbAAxwl0MdavbI2iuzzid5KM0Hzw5g3hnT2dgpXR1l581qicbmxetXNQUicRr70qek9+E5JhVD++UR4FhPlxgYA0IYVdcdO0oJl+0rLoqWLwZblu5ZuXiShtccuyb7XE4NY7uqGQf/u52YlOzl4Niws0odKPTDedS1+XdRhGqhEpiJRqL5LSy06dvYQgV0ZLh022CiO2jv3xt4gO9t7VafuNgZoyqivFTTHlfXci/G33cpphy1+06Ker9rMw+j9LTFjJz/mAsrCX3tO6hRer5522XkKe8zkWeDdsWyvrBkbU9SUJY+zTjw==
Received: from AS4P189CA0035.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::14)
 by GVXPR07MB10056.eurprd07.prod.outlook.com (2603:10a6:150:122::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 01:58:00 +0000
Received: from AMS1EPF00000045.eurprd04.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::87) by AS4P189CA0035.outlook.office365.com
 (2603:10a6:20b:5dd::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Tue,
 15 Apr 2025 01:58:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 AMS1EPF00000045.mail.protection.outlook.com (10.167.16.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.13
 via Frontend Transport; Tue, 15 Apr 2025 01:57:59 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 7EFD9463FB;
	Mon, 14 Apr 2025 16:00:05 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
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
Subject: [PATCH v3 net-next 00/15] AccECN protocol patch series
Date: Mon, 14 Apr 2025 14:59:29 +0200
Message-Id: <20250414125944.97350-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000045:EE_|GVXPR07MB10056:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c2c28a-6895-4c8c-4829-08dd7bc0f32b
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TFVGNU1kVzFrcjRNekYyN244NUtNL2dXNlo5aHVxNXNPV3owRTdLb3J5UHU4?=
 =?utf-8?B?SDU4SXdCTEVOZTNGNGNmeGx2SU0rVnRmRWlEbkJmZytBRmdUY3dGczRLOUFB?=
 =?utf-8?B?ZUo1YzJBWUVqd3U3aVhkZ1NTT2dXclpWTVVQbkhoVjFDMkJrTmVpaGc3aFlr?=
 =?utf-8?B?VXVUNW1vUEdPZHFzVTEzYk9LQWhxeHNrYjV6R2FlZnl4akd3TTcrb0NrZnlt?=
 =?utf-8?B?bUpZQVRyK1lJT0dtQXo2RGRMd2NZVWQzeDJ1ekw1K1lqVnQ0MUo1QUJjVDdl?=
 =?utf-8?B?am9oQU1aS0J2UTN4TGdNRldKOGZBcGhZUTF1QjUxSGZTUHp4aUlxNHVmYTl1?=
 =?utf-8?B?M2xzTk5CQjJMcW1pV1FTbnI2aGFJZ2MyVXE4V0tnMy83d1NjSkNBYjd4Q296?=
 =?utf-8?B?eGZPTEwybFpxUW5KdW5lRWE1NzBGVksySmM3QVdaU0x2dlcwbU9kS1BJRWZD?=
 =?utf-8?B?L3NRSlNhTlpNUy9oK0g0SE9RMkRueU1yR1RWWGJRU3B2enlLU1Fxa2RCbzhO?=
 =?utf-8?B?WU1KakQvNzRJOER5cXdKNCtOREtHa1Z1TXc2TmRQb0xXaEdHRFI4RU5kRVFP?=
 =?utf-8?B?TTJCdXFxY01iekZESjl2VU94SVI0d2NleWhPZjhVR3htelZvRHVuQjJHdzNZ?=
 =?utf-8?B?c1FaMURHd3hidTMxZGJEQnRQRDRFaXRERG5ONHQvNTdpRUl2REFCVnAxZUg1?=
 =?utf-8?B?cmdUVUNIZU5uZEp6cmhTcFRtd2JhRXRaZXRoUUZiQWw4VTlkVTBKaGU3ZUJp?=
 =?utf-8?B?UEFwR1YzTGRiS2NxV1J6aEp2QWlOeHp0ekNkaEdSZis5ZFZ3dUFydWttRmdG?=
 =?utf-8?B?MThjRnN4OTVzbnJTaGxabmtTZGVvN0Y5eC9jalZBRWhZZW1KZnYwdmxEN2FN?=
 =?utf-8?B?Ykk5ZUd4ZVlVVGpXTVRkRUxWdnJzaE5iUVQ4UVMzWmlUemxJQ29FSTM4T29G?=
 =?utf-8?B?T1ovRlRISDVFWE80SlQ2QXJaZGx6RElQMzFEeE1yS3JodUxFbThtYXVlK1RL?=
 =?utf-8?B?LzRIMHkrbUlHZE9JandyeEV6dGlnTVMrSmNMc3hEa1A5YVVudUN6ZldQb3Rt?=
 =?utf-8?B?NHkrcDkzZjV6QWZ4VkdYZmM2SWorNWIwdFhzSmZoVGdQcHF4eVB4c0tTdkVH?=
 =?utf-8?B?WFZ2NFQvd2ExNjJMZDBYOUQ1M29QVXNYaEZ5ZG1PKzhLR3NFZ1VMeWFCbDdk?=
 =?utf-8?B?MFc2RytrcXJOMy9BY0pUN240SDZ4cnFZaEFsQ0NLT2s2dS9ub3MxTUU5Q3VJ?=
 =?utf-8?B?eUxlZzhNeXNMVWJSQng3bytaT1VucGEwNWx2T01MZzZDSkpTbzVwWXNXcWxz?=
 =?utf-8?B?OStnWDI3aGk1b2JNMk1tbnF1cmNRN3JsNnNVQ3V1cmdYdWovcHY1eERtTUNh?=
 =?utf-8?B?MEFpZkhNaVBoUVdhdi9IWXRKdUxjdEx4R3docDhqRkVCb2lwRWcxeTlhRllO?=
 =?utf-8?B?dkJISHluTkNxaUxkN3hWUmUwYjVmdFptVUxTUEh5NWluNXVVTmYxYmZCb3Bq?=
 =?utf-8?B?RXJzUWtlbXhla3I3Y0ppNklLdjBPMm8xcGJaaUJWUTVxM21vbXNsem9nN2pC?=
 =?utf-8?B?SFYvTFJka20wQkd0cmZvRGJpbmN0TjErQW1vQUNPa0tSYTl3djVmNkJaZFJj?=
 =?utf-8?B?eGJpRVE5ajBHNXMyenZYdHhRVm1uNXBCUUZYNFA4TUkxdFcrMEh4RHhKUTRE?=
 =?utf-8?B?RFRrRUxLNkVMQ2Vnc3FQZFQ1WXUxR3Z1QlBkZndFYis2R2hLam9tZGFDN1Y4?=
 =?utf-8?B?UEU4UHArN1prNlpjZTJrTHMxQ3IxSk5oR0NqWFJHZS9GVHBla2JJck0ybThl?=
 =?utf-8?B?MG1Ndk9xNkdTZjdpNmVJZ1dkVm1vaGI3aGY0ZEo2TzU2YlhMdDZZTHlHUFFN?=
 =?utf-8?B?aCtYbzI5UlhBbENyVzJ6UTgyVHFnVXVXK25ING80Rk0zckYzdDUweHpOckNE?=
 =?utf-8?B?REdPYndaQnRFakZUN2xSazZEVnZPNEVLZjZxa21QRjR0am03c3VjZWdWNjdr?=
 =?utf-8?B?eE1mOFBGbFppTU0rRU1hNm9hajRodlJLcjJ3TkM4RnA1ZVQ4TVZoWTh3NWk0?=
 =?utf-8?B?dU5BdFVPVnQ2cWx5dmhSdlR3ZkJmVGtRbmV2QT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 01:57:59.9178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c2c28a-6895-4c8c-4829-08dd7bc0f32b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB10056

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Plese find the v3:

v3(14-Apr-2025)
- Fix patch apply issue in v2 (Jakub Kicinski <kuba@kernel.org>)

v2 (18-Mar-2025)
- Add one missing patch from previous AccECN protocol preparation patch series to this patch series

The full patch series can be found in
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

The Accurate ECN draft can be found in
https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28

Best regards,
Chia-Yu

Chia-Yu Chang (1):
  tcp: accecn: AccECN option failure handling

Ilpo Järvinen (14):
  tcp: reorganize SYN ECN code
  tcp: fast path functions later
  tcp: AccECN core
  tcp: accecn: AccECN negotiation
  tcp: accecn: add AccECN rx byte counters
  tcp: accecn: AccECN needs to know delivered bytes
  tcp: allow embedding leftover into option padding
  tcp: sack option handling improvements
  tcp: accecn: AccECN option
  tcp: accecn: AccECN option send control
  tcp: accecn: AccECN option ceb/cep heuristic
  tcp: accecn: AccECN ACE field multi-wrap heuristic
  tcp: accecn: try to fit AccECN option with SACK
  tcp: try to avoid safer when ACKs are thinned

 include/linux/tcp.h        |  27 +-
 include/net/netns/ipv4.h   |   2 +
 include/net/tcp.h          | 198 +++++++++++--
 include/uapi/linux/tcp.h   |   7 +
 net/ipv4/syncookies.c      |   3 +
 net/ipv4/sysctl_net_ipv4.c |  19 ++
 net/ipv4/tcp.c             |  26 +-
 net/ipv4/tcp_input.c       | 591 +++++++++++++++++++++++++++++++++++--
 net/ipv4/tcp_ipv4.c        |   5 +-
 net/ipv4/tcp_minisocks.c   |  92 +++++-
 net/ipv4/tcp_output.c      | 302 +++++++++++++++++--
 net/ipv6/syncookies.c      |   1 +
 net/ipv6/tcp_ipv6.c        |   1 +
 13 files changed, 1178 insertions(+), 96 deletions(-)

-- 
2.34.1


