Return-Path: <linux-kselftest+bounces-40885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EF9B47450
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 18:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5BAB5880BD
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 16:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3F32F3C1A;
	Sat,  6 Sep 2025 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ZCf8OaGV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013045.outbound.protection.outlook.com [40.107.162.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24963283683;
	Sat,  6 Sep 2025 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757176154; cv=fail; b=pWNDKeYoIY+60RyTzlnSqO9soanKZRyeelvfZp4qu5iaY+PbNR4npOaJC4QXhYkj1kqtaBxZPh+mB1WhNs8UN/pCqaClxVKQgleFpWQkYE1opiEdLeqnXvdWRoqMKCaecWf33k7KeoLlVDX2gp/yb0YvJuMkRYNamE3rxbzNhMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757176154; c=relaxed/simple;
	bh=vQqpwS7TwAx0pGEhr45JDuQZdOyD6Unr26mUzxzbDYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=piADQUe4X5kPoChJBuDKPGsiAjKlLsMFL1M8yq+PjC2kgQ85rtieWs3g7Ct3QeGR9xPhpiVaFSTo/bYqHB6+WXK+KzWOJv71dyu8AOHc/gGsllBl522vYJtHjM16I0sKjwEweAWKqKHDR4iXwNJlwGR7rlipWSjcbY+z48ZyZT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ZCf8OaGV; arc=fail smtp.client-ip=40.107.162.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFznmUwTk2tvEE46/jgQ40CBw8MIIHQYU1GI5B4gTQP7NnK5g8xDf4wz+NNqV1Py+oKuMD3oWBui7nSuXpmXOJKAl3hHxJTQVkffbFf5SvaYhlfkiEpXPvqo7fyTSnpCl8vnDiSxplo/2V3PH+5/z3HCqEy6DFz8arwe7f0QuuBBiBJrU52Cq/Jx4saE/AxubzKCgtUga7TmaLxWT+Geob3XFthyhx2ve9jokdAT48tjrlSOuzo7nRJQKlOBrUxONyyzdJ5qyx1qjhXeJWuDomlWxvYM2tWwlXvJvXWfdykLD8BCLUi9WF9RQSKgHlK8qcV7iO/l3KqY03lXJjOMNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLcOwbtxJ6QQO5279XgwpV6k3SII4E1JJgdxd8GjFwg=;
 b=ppV2dI0Htia48EqPPr1mwoMN9Hl2zZ8xcwT1JJRp+gZMzNS9GN+2KvR7xdht1wyOtwCm31TOlH/0ocxPGCeoya4kSz5OXzIU7njmBTrvL7GyNujBp35fi42d43f84jKNX1jg0FWRzhMPGO05C5nkXhf9n5/n8xRCYANsSC0RJCs23vmJ4e0pUyBbTBnSN9uhPifq/8UuKseEFJDiN8LGjKofLeM+nh2W2y7lUqtGwonVVjPy5wCh/of+AIaaO7f4XSfdXZ4ux7rVzqOJlAROjkBKrSjgUVD9KEDukokfPLk4Wu8Hj5/E3t26/sjM7zEKsEDua1M74gqFlsmsIn3Alg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLcOwbtxJ6QQO5279XgwpV6k3SII4E1JJgdxd8GjFwg=;
 b=ZCf8OaGVmfx0mZmL1lYZb0TnCpSHpGqog+PnuToUWGJbaScxfyj/Mo9ijn0RBKi6CPPBXh1XrkYk7EiI9F1vF2Cm3kEKna0w4vFe0Rl6txd/sif6bkLuY1apHhZ4aWVvwlLACnWUmVhG4jhy+mzb1Y0l5TNxIYz39xPyyRALIqBNw6CPYKSoU1ivi2Pv+Gw4nTQqvCSTFagh4NiolR4Zm0JPiMG2QLe2fdKElCAMcwAvuyloc07caqvEBUbBthAeeRdMMeq8TR0xRwNSTHMkomS8yyDMD1dfMsyKTz8hhkkKtZFdvTWmmU69wx8j+BwLTt79XhmhYdzCGjjxM57Pww==
Received: from DU6P191CA0022.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::13)
 by GV2PR07MB10529.eurprd07.prod.outlook.com (2603:10a6:150:2a4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Sat, 6 Sep
 2025 16:29:07 +0000
Received: from DB3PEPF0000885E.eurprd02.prod.outlook.com
 (2603:10a6:10:540:cafe::fd) by DU6P191CA0022.outlook.office365.com
 (2603:10a6:10:540::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Sat,
 6 Sep 2025 16:29:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB3PEPF0000885E.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14
 via Frontend Transport; Sat, 6 Sep 2025 16:29:07 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id B78721C003F;
	Sat,  6 Sep 2025 19:29:05 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@amazon.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
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
Subject: [PATCH v16 net-next 07/14] tcp: accecn: add AccECN rx byte counters
Date: Sat,  6 Sep 2025 18:28:43 +0200
Message-Id: <20250906162850.73598-8-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250906162850.73598-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250906162850.73598-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885E:EE_|GV2PR07MB10529:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a4f021e-05f5-4ecf-15d4-08dded62806e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWZtVGZQYm9DeWx3alRIQ1Nrc3BpYkhTbFJOczJtUWFVSE5sOFUxOVNNd09C?=
 =?utf-8?B?K3ZvQ0lFUVM3cFJOSW0rVVJVcXBqRml2QmM4Tm9mNzlucW9SSGM5Qm1HdnBr?=
 =?utf-8?B?YTJsNzU0QnRaSEN4a29rN2pEajdpWWJLakZsSlljelRka1lid2FUSjV1MVVQ?=
 =?utf-8?B?aGY1NlBHTWpoRzFjakUyRzArbmlQQk5yLytscmNYK043OSszQmVFZW8xNVlp?=
 =?utf-8?B?TmdwRWVYckZZVlJlRUdNZUZ0Um1qSGM1RHhqanFBM1ZoY2xjaFFwMndVc2xZ?=
 =?utf-8?B?UVh1NTVpYnRGM0MyL0pWL1AzcHNpaWxwb1FqK3VycXBxQUFGRzBPeDZ0YlBO?=
 =?utf-8?B?NkRqc1NvdkpreXl2SGEyajZ4VkN2cFh3aThLVnBnL05aNm50NklnVFovSHFt?=
 =?utf-8?B?ekN5NmhzQlVmaG5CYVlCWld1ZzdOVFRXU2t5OWhCSm1PQXlYMmY1RDZFZUM3?=
 =?utf-8?B?bTBDb0xmRTBHYnlUSXd0SVZ0MWRxMlJmTHJycnVyQ1czb2VUNGRmQ3dOK3Bz?=
 =?utf-8?B?M0pDLzFadVRuN2VJOXYxKzc2WUxPU1BHaVBVWHAwMmkyNjNadUQwWTN6OFBa?=
 =?utf-8?B?V0grdkJVbEJ1MUJwU0lPUm93T3ZXcUgxNHkvNDRNeVZ5TmVUNEJ5UjFQODd3?=
 =?utf-8?B?b3NKMytqTW0xOXJZUENvQ1ZSNFpGdmpRMU5vZFhsR0pURnMrOXh5ZGdISXpC?=
 =?utf-8?B?U3VVZlp4c21mVEk1Ty8xRDJScjQ3YTJ1WEhTZnBVUGs3ZE5DTitmVFhJdXZn?=
 =?utf-8?B?NDhaK0swZUVERWtnWE5nZndVUmZ1RzVYdHZxYm5udU5DRFNXbXVNTUMzczA3?=
 =?utf-8?B?dUdsWTFNU0tueHpQY2pEU0pFd29GaXVzUkZpZVBhN01lajBxLzR2YkJjYzR4?=
 =?utf-8?B?enRVWXlYWmQxWVFNMmxOTUd5ZTZYVkE3ZWUraG9PVnhNRndVb1F0SzNwajhv?=
 =?utf-8?B?YVNjTSt5R1pPRDlWYzNQOUlnYW1Qd1MxMWZqMkhXY0VuWllNNmFPbTQ2YlVp?=
 =?utf-8?B?cUR4Z1IwU0J0L21jVEhOSkg5S0RLUGhZdUZ4RXZ6ZFprK1dmVDk2UUxzZEF6?=
 =?utf-8?B?bXRtR0J6TlpBOU1rYWpLaXBIVlFkRFJzbXNwMkpyLzJlTEJzdG1iSlFiL0Zi?=
 =?utf-8?B?VFU3L2E2YVlYWFdQemNBSUVpNmV4eDRreFY4UU54c09jYUVXdFJVVUwweVFx?=
 =?utf-8?B?WGdIaDh0MVlkZ2xuTDIwMmVDUEpLUHFWR2x4WnBMZE5NdmpGWndJTjcvTkxG?=
 =?utf-8?B?dk9KWEp0d2xxUDlvQVlDWHZVMy9vRVdWZStjUWNleWM4TEU2cGtteW5ieWtm?=
 =?utf-8?B?M1RabHNXY2hLbjBSaDZHSndvZ2pmS0YyNEhnbVh5SURueVZJRHF4K0QvK3Bo?=
 =?utf-8?B?L3FLL25DMHE0YzlrRG05UFBvRXEvemJTUVYyY1hyVW1QMTl2MFVzdndwQzdn?=
 =?utf-8?B?bDBBSGZsUzFEMDBvS2gwcnRvRXdzSlZOZGFPZXFySW9iUEUvaEUxN1UxTlpk?=
 =?utf-8?B?QnRWZitEY0hldk9PSXc1azY1SGdJRSszbzdHM2ZyYlRVY3IyaHVKbk83OTdY?=
 =?utf-8?B?UFpHdVNLdnZyOE5PZ0hpRXl2bldGdG1mVElBME9XK1lud0J1WUNpd3NGVk5m?=
 =?utf-8?B?cUFmbTEwWGpEVE10YTJJbUtheXRSRmd0em9TQlJrRXp3ZENzSllaREpTZEdM?=
 =?utf-8?B?V1N6eG1mbVd3SmIraktXOWYzKzlMeXBEYVhRemNtZkNwNDVIY1hQWFlTNjVH?=
 =?utf-8?B?YnhSclhGTmp5QjZEWUdDeS9VemkrR2JvTlB6dituZTV2MWVmUkxPTFJTSktT?=
 =?utf-8?B?NzV4LzRXRXFaMWJSYktDU0E0ZzhvbjVFeFpERkgzajNOVU1oTWZuOHFKdVZq?=
 =?utf-8?B?WWtwa0JVcTF6YjJFanowZlJES2tpSEJNRFkxd3VEcUlMWm1VUlUzS3ZKZlFH?=
 =?utf-8?B?cTZ4bE5UWFVrbmRQN0dtSURVSURzYklwMDgwZG0yTnNmZ0dwV2JQUkJSOHZW?=
 =?utf-8?B?eWF2YW93WEczZjdRdVNhRXUxZ01ybXErWWIveGVYWGRpUStTWGpJanptSWtP?=
 =?utf-8?B?ekVOUlY1ekcxQWVHZmthS0JqVEtTNUhocDg4UT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2025 16:29:07.2899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4f021e-05f5-4ecf-15d4-08dded62806e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB10529

From: Ilpo Järvinen <ij@kernel.org>

These three byte counters track IP ECN field payload byte sums for
all arriving (acceptable) packets for ECT0, ECT1, and CE. The
AccECN option (added by a later patch in the series) echoes these
counters back to sender side; therefore, it is placed within the
group of tcp_sock_write_txrx.

Below are the pahole outcomes before and after this patch, in which
the group size of tcp_sock_write_txrx is increased from 95 + 4 to
107 + 4 and an extra 4-byte hole is created but will be exploited
in later patches:

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ce;         /*  2576     4 */
    u32                        received_ce;          /*  2580     4 */
    u32                        app_limited;          /*  2584     4 */
    u32                        rcv_wnd;              /*  2588     4 */
    struct tcp_options_received rx_opt;              /*  2592    24 */
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2616     0 */

    [...]
    /* size: 3200, cachelines: 50, members: 166 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ce;         /*  2576     4 */
    u32                        received_ce;          /*  2580     4 */
    u32                        received_ecn_bytes[3];/*  2584    12 */
    u32                        app_limited;          /*  2596     4 */
    u32                        rcv_wnd;              /*  2600     4 */
    struct tcp_options_received rx_opt;              /*  2604    24 */
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2628     0 */
    /* XXX 4 bytes hole, try to pack */

    [...]
    /* size: 3200, cachelines: 50, members: 167 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v13:
- Move TCP_ACCECN_E1B_INIT_OFFSET, TCP_ACCECN_E0B_INIT_OFFSET, and
  TCP_ACCECN_CEB_INIT_OFFSET to latter patch

v8:
- Add new helper function tcp_ecn_received_counters_payload()
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  4 +++
 include/net/tcp_ecn.h                         | 29 ++++++++++++++++++-
 net/ipv4/tcp.c                                |  3 +-
 net/ipv4/tcp_input.c                          |  7 +++--
 net/ipv4/tcp_minisocks.c                      |  2 +-
 6 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 4f71ece7c655..5a2b0af57364 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -102,6 +102,7 @@ u32                           prr_out                 read_mostly         read_m
 u32                           delivered               read_mostly         read_write          tcp_rate_skb_sent, tcp_newly_delivered(tx);tcp_ack, tcp_rate_gen, tcp_clean_rtx_queue (rx)
 u32                           delivered_ce            read_mostly         read_write          tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
 u32                           received_ce             read_mostly         read_write
+u32[3]                        received_ecn_bytes      read_mostly         read_write
 u8:4                          received_ce_pending     read_mostly         read_write
 u8:2                          syn_ect_snt             write_mostly        read_write
 u8:2                          syn_ect_rcv             read_mostly         read_write
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index b8432bed546d..012d01347b3c 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -306,6 +306,10 @@ struct tcp_sock {
 	u32	delivered;	/* Total data packets delivered incl. rexmits */
 	u32	delivered_ce;	/* Like the above but only ECE marked packets */
 	u32	received_ce;	/* Like the above but for rcvd CE marked pkts */
+	u32	received_ecn_bytes[3]; /* received byte counters for three ECN
+					* types: INET_ECN_ECT_1, INET_ECN_ECT_0,
+					* and INET_ECN_CE
+					*/
 	u32	app_limited;	/* limited until "delivered" reaches this val */
 	u32	rcv_wnd;	/* Current receiver window		*/
 /*
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index da0b355418bd..1a41a459aa07 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -171,7 +171,7 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
 
 /* Updates Accurate ECN received counters from the received IP ECN field */
 static inline void tcp_ecn_received_counters(struct sock *sk,
-					     const struct sk_buff *skb)
+					     const struct sk_buff *skb, u32 len)
 {
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
@@ -191,9 +191,24 @@ static inline void tcp_ecn_received_counters(struct sock *sk,
 		tp->received_ce += pcount;
 		tp->received_ce_pending = min(tp->received_ce_pending + pcount,
 					      0xfU);
+
+		if (len > 0)
+			tp->received_ecn_bytes[ecnfield - 1] += len;
 	}
 }
 
+/* AccECN specification, 2.2: [...] A Data Receiver maintains four counters
+ * initialized at the start of	the half-connection. [...] These byte counters
+ * reflect only the TCP payload length, excluding TCP header and TCP options.
+ */
+static inline void tcp_ecn_received_counters_payload(struct sock *sk,
+						     const struct sk_buff *skb)
+{
+	const struct tcphdr *th = (const struct tcphdr *)skb->data;
+
+	tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
+}
+
 /* AccECN specification, 5.1: [...] a server can determine that it
  * negotiated AccECN as [...] if the ACK contains an ACE field with
  * the value 0b010 to 0b111 (decimal 2 to 7).
@@ -232,10 +247,22 @@ static inline bool tcp_accecn_syn_requested(const struct tcphdr *th)
 	return ace && ace != 0x3;
 }
 
+static inline void __tcp_accecn_init_bytes_counters(int *counter_array)
+{
+	BUILD_BUG_ON(INET_ECN_ECT_1 != 0x1);
+	BUILD_BUG_ON(INET_ECN_ECT_0 != 0x2);
+	BUILD_BUG_ON(INET_ECN_CE != 0x3);
+
+	counter_array[INET_ECN_ECT_1 - 1] = 0;
+	counter_array[INET_ECN_ECT_0 - 1] = 0;
+	counter_array[INET_ECN_CE - 1] = 0;
+}
+
 static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 {
 	tp->received_ce = 0;
 	tp->received_ce_pending = 0;
+	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 }
 
 /* Used for make_synack to form the ACE flags */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a387c39c9ea2..e4b7d6768d59 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5126,6 +5126,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
@@ -5133,7 +5134,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 95 + 4);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 107 + 4);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8449a5a3e368..636a63383412 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6163,7 +6163,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 					flag |= __tcp_replace_ts_recent(tp,
 									delta);
 
-				tcp_ecn_received_counters(sk, skb);
+				tcp_ecn_received_counters(sk, skb, 0);
 
 				/* We know that such packets are checksummed
 				 * on entry.
@@ -6213,7 +6213,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			/* Bulk data transfer: receiver */
 			tcp_cleanup_skb(skb);
 			__skb_pull(skb, tcp_header_len);
-			tcp_ecn_received_counters(sk, skb);
+			tcp_ecn_received_counters(sk, skb,
+						  len - tcp_header_len);
 			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
 			tcp_event_data_recv(sk, skb);
@@ -6254,7 +6255,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 		return;
 
 step5:
-	tcp_ecn_received_counters(sk, skb);
+	tcp_ecn_received_counters_payload(sk, skb);
 
 	reason = tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT);
 	if ((int)reason < 0) {
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 9eeb33344762..f2f604a5a158 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -472,7 +472,7 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
-		tcp_ecn_received_counters(sk, skb);
+		tcp_ecn_received_counters_payload(sk, skb);
 	} else {
 		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
 				     TCP_ECN_MODE_RFC3168 :
-- 
2.34.1


