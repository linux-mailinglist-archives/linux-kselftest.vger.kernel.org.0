Return-Path: <linux-kselftest+bounces-31085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE8DA92D78
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 01:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8CD71B64D2E
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 23:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A713920E310;
	Thu, 17 Apr 2025 23:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="czTee03d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97F81E4B2;
	Thu, 17 Apr 2025 23:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930837; cv=fail; b=pPV/27gbGG1b0i+SKEKHKDV+YHXw3N12a64jg6UZtdK3tcvzxeVj+u8b8gXYjMEDOsVwd1soZUZksHZJPF+l4kK++nHW4PExw+MmhFokqdtLbQ4djaVVjA7V8jehNLjLWTydzYIeHPUrWGRadGeubSN1dXvQsMsFxTkW5br0MtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930837; c=relaxed/simple;
	bh=ObS5PwsrXjifBy/eUQYkt6igRyGlug5RrKLYxxrz3bM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GKy3D0+1vBDPdEq92cHt2VPaFLJ1jYBIo77+w6ullwXiFd38Axlv9kbE3AR0hmsyt2olblxJ9Wtl5p9Haf8Bi9U4PUX23P2RdFRN98c9NqkGozPSogNhbrIx+nCJZFmMJG+gWCyTohYBNYVp/0UIYqtmY6jkB2EtSyR4zxLhSQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=czTee03d; arc=fail smtp.client-ip=40.107.22.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UB4VcItSSQCRaWtNHq8q8Uz4s6c8Sr7YrvcYLW0aGM8KqvFaAJkZB1ry+dwcd1aEpShJvZb3NNt4q3caxjgqyZcGZv0HthLeRYkZ9gv4qJE7d7iC0dxLXJSRntR2c5K7rQxWIaDOflri6JcKuAUeFz+eWqIqpiTqYIT8u65skiWAmr66a28wI07M1QbaRL7IG33kfm1rBYI26DI2Go1xKsUeB58+/XHhwj9+YJiUU3Nk/Tp4MWcMifC65B9LoT/DO8EuoteIxEQRWTTBW70VYBIXcX3DR2JjPlnskWQRvUMoAN9T3Gl1sBDcOrJ45S4wl/zelneLsAfbrh+1Hann/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfvVBK0+/sSe6Lhpj+Ttxsc1SPtotJ2vQ4y0txU6q30=;
 b=IuKbO61czNiiCJBDl5z5XvsjbhmokHXaRGnqlAglm9mf6IfmfKh31MQW5UtaNC/pu1lrwMrtA5P6b93wh2AewEPIuFiV+J1KYgD9babRl06FmBAeU48sxVCG8bwErckWiNQR/WgiWtG5M+y6nnnlOfntxzlCOaH9hEdxShHVhX0PT7hAbZ6eM2VGkSQZSkocCYF9KAPyMZWmXWDFiKJAKyCLj5xgC791ff97mkkWPjb6Ng1iumPAoIMpUZKkesN3MSQctsFl69swjSQeOtE1e+73chzXSWcEXqUCUgW3Uh7iF8G+5P9FdjUJ0L8//TCJNevCkC7eLOZzuwdXXPyEsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfvVBK0+/sSe6Lhpj+Ttxsc1SPtotJ2vQ4y0txU6q30=;
 b=czTee03dslgokLJkRlhkU4XlGlVhNJwXFE+DGK7VwEdqSJ/PGyaM2DxoZ2owEax7F4K7k4NcWZx6NhUF/hXoe0DUUC/bV3m/kfgcilnzDFNddWSd5Bfzi2/avCGkkIMI+pGnBkVWOwdpF1cLt14xlZuRITjgE4H2Ho+p+UwlkteOHuTHb4d1NHmgyjIXL6TAdjhzf3NivMiST+n7jRQjD67kpenpZ7ItyGMgbBVUA5FkmAooadcLFn4k0VxaqVs1vSYHdo7pRVQvpXCRl593cEAuc2gCm4FbUVfLbr9oiVBmdgcvrB0qnHOT6gguwq7xwRdrWDlw6FeGSJI8qoVU5A==
Received: from DB6PR0301CA0102.eurprd03.prod.outlook.com (2603:10a6:6:30::49)
 by PA4PR07MB7520.eurprd07.prod.outlook.com (2603:10a6:102:c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 23:00:32 +0000
Received: from DU2PEPF00028D0D.eurprd03.prod.outlook.com
 (2603:10a6:6:30:cafe::e6) by DB6PR0301CA0102.outlook.office365.com
 (2603:10a6:6:30::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Thu,
 17 Apr 2025 23:00:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 DU2PEPF00028D0D.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Thu, 17 Apr 2025 23:00:32 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 9F45D20824;
	Fri, 18 Apr 2025 02:00:30 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: dsahern@kernel.org,
	kuniyu@amazon.com,
	bpf@vger.kernel.org,
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
Subject: [PATCH v4 net-next 00/15] AccECN protocol patch series
Date: Fri, 18 Apr 2025 01:00:14 +0200
Message-Id: <20250417230029.21905-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0D:EE_|PA4PR07MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: 621fba71-3a46-408f-0d29-08dd7e03a7c8
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dVY1WU5ldjc4TzI0YVVxR2Rxd0t3b2dPWlRVTHMybnkrY3FwNjNjY0ZLdTZL?=
 =?utf-8?B?R0U0d1dDblZYWG5LUE9rQWFxWVkzbEFOVVRaNmswRHl0dGwrOEQrOG01aGZE?=
 =?utf-8?B?SDZWWXpoeDZ4UE9icFJDejYvek5MKzcyVFVWdGRKM3hQRGR4WFhjbEdRS1pi?=
 =?utf-8?B?MHhydTd6eWxWTGFRUFlkMTVEV3BGWEdVOWtJNXlNRXRYbDhxYlVKazBvVm5k?=
 =?utf-8?B?RnZhb0tZSFhzaDVRaFZqWkQxc05JSUJ4eFliVFJ4UDdjVFI4Z3BPUXlqazZE?=
 =?utf-8?B?T2hlc2xVY3h2Q0FxWGQyV00wZ09hdXdKTEl4MTRIMGc0ZzhRK3BXbm9HQ215?=
 =?utf-8?B?N3dBUlI4cUFGaVNmNHdYM1R4UHJHLzNvNmQvUllXNC81SXhZK2tQam5aMW1l?=
 =?utf-8?B?a3RuS25xem9PSEdKOWUvUlB1akhTbVE1UkcyWjRIcVJUZ212SGFlSnYzK3pi?=
 =?utf-8?B?bWRUR0czdGxRZVl6eUMyTm9EUGpNajdRWXdyeGNReVNXclg3bktFckJaSUJu?=
 =?utf-8?B?VkNDMkZ5UmRhcjlNYXQweXRScHE4OFlpSHdvVVBCZlZmZ21ycUIwK0R6a3V6?=
 =?utf-8?B?MkE2UGpRdzFPWERsUE9KMnAyYmRGQ0pmSXhsck9qSWZTc1k2czB0VnhjM3Jk?=
 =?utf-8?B?Z29BMW1aSlI3T2QrWXlJdnVtVXBwMEczeTA0bTlKS1RSdDlJZyszMTZqTnNQ?=
 =?utf-8?B?NmMrQlBmUmdXdUxDRkQwSURaUkJaWjZTak5EZWVONXkySzZyR0cxeW1EQld1?=
 =?utf-8?B?STdWTmRtMjBkcmszaUFRYkxDN0FVdHFUU1RWTWRJcGQzaVJ1aDRsOEl3TG5R?=
 =?utf-8?B?eVErcHhKY0p1QzNHazNYaTF0TnBtUjdKRkdhMVFKK0hkUzlCRXYvWEs2bWVR?=
 =?utf-8?B?cFpHUEZSVnBCSERoK1ZnNWRncTh1SE5uR3ZMRldHSzhXUythY1laWmZ1M0h2?=
 =?utf-8?B?SzlJSlF3R0lCdTZVZ1lKeDJxSWF2dExnKzVaR2ZTcnFpRW52cFc1QTI2M2Yv?=
 =?utf-8?B?WTkzcERNYmtQaXdCNFBSVGh1bDJtdGlpMzg3akdqTFpvT0wrQW0yOGRFaURK?=
 =?utf-8?B?eVRzandGZ0NFd05TYVNMRzB3eXBTN2RPVkxianlPKzE3d3pkMmlKVEZrMUJ1?=
 =?utf-8?B?MXkybERPdnhxQnc2Q3FUVVlsMTA2RlVJSXNvcTdPWGg2cHZOYkQvVDJqWDFu?=
 =?utf-8?B?SnYxb0lveHY4TU9jZDlHdXpmOUtNQmtZM242NnBxQVVDOUhENjRCYUJwTmh6?=
 =?utf-8?B?N1FCeHJVa2s0bGtlNHpMbWM5dDRQNWNoQ3pBY2tYb2lyckdDRnowWEgvdGpm?=
 =?utf-8?B?Z3pMNHhTNmQwYUhoT0J3bkw2MkhWVGtaVTJhdDA0ZXB4M01xMUtQdkNmYzdo?=
 =?utf-8?B?UitJam55VGxRUXNYMHE1NEs3ZG04cEE1MGZxZ1FOSkVnZFdINVpRSnJZb1N3?=
 =?utf-8?B?VThxckRpTmdkVk1LM0gxRGVqRzdFZGIwZENxZFo2N040ZjlkNmpKUjRnczM0?=
 =?utf-8?B?azcvZ2RPaHd3K1JSR20xZHZUYWFRdW1ZTVIvSy9NM1JWYnFLVWpJL2Z3U1hD?=
 =?utf-8?B?QUxVbVpOOEF3eitOK1lycTlQa2NRWGZyMW0rQzNnRmZPa1dtT0xXbTY5ekd5?=
 =?utf-8?B?elN0Ukkyd0dZSmVueFgxMDBIVGJ3QTQwWXNmaWtsOVhlb05GdTJkTUxaNXI3?=
 =?utf-8?B?bXBVc084cXJLYVF0S3JRemNZR3ZFUkRUclBuYTV4a2gwM2ZPbzZRbEZsYy9Z?=
 =?utf-8?B?dEEzMForMGJZb0VkTks2QnoxOXhWVDBGZEh4bStXMVJUS05tckQ4cEJ3S0pC?=
 =?utf-8?B?TkVPcW15ek5XQU8ramNzcS8vZHU4T3ZySmhpa1Z3RDNtZXBtMFFvZUxra3BI?=
 =?utf-8?B?cTA4UW4vekdIUmhULzNQMlM4MkNKeURVRzdtYWdyeVN0R1N4VGk0OHFuYTlK?=
 =?utf-8?B?OXBpeFhuUGMvb3dNR085RnBDRzY0cEFmbFY4VlRGaHhweXR3eFZmQkhIOWJH?=
 =?utf-8?B?emNSbVMxYWhhOHkrTVhUUVZBVkdodWZLRWQwc2crWjczWUNzSjdWZW4wVFZn?=
 =?utf-8?B?VUg0VDdxcEtLY2FQSW9MakZaVzZydGZ1dWwydz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 23:00:32.0760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 621fba71-3a46-408f-0d29-08dd7e03a7c8
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7520

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Plese find the v4:

v4 (18-Apr-2025)
- Fix 32-bit ARM assertion for alignment reuirement (Simon Horman <horms@kernel.org>)

v3 (14-Apr-2025)
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


