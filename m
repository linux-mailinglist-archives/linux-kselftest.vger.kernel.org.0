Return-Path: <linux-kselftest+bounces-48105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3E1CEFF84
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 14:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DE3C303B782
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 13:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B527230B52C;
	Sat,  3 Jan 2026 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="A8wf4iZN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011029.outbound.protection.outlook.com [52.101.70.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9756630BB81;
	Sat,  3 Jan 2026 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445842; cv=fail; b=dPnsBGtqnAVcOOcSyZPSLAdS3THjhiHpVsCpKBkg+Zd/3ORFk1aiMRTS86AWafm6kzcy1x3gEXfNJP2I8SUiguFEZ9PIJuBTMQQEy14G99Yw1AIWnfEK6itrTq4eDGGxFBF8p6BHlR7ZfLFHW/6R7T47twj40fn3JxRCwrCAers=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445842; c=relaxed/simple;
	bh=WAKU0kvy3ZF5Mj8iz45FyNQcw7gu4ZyVU4VeIRtHXJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6rbO0duCCz+jFfcvhjdttQdU6w2J6U0I0f+7koJSlWMa1p/v6Lb4CWMJexnOwu3llMwB0IKuLA01snez5HiYjEYNBVtUIJKohkhnybcBfNwlj1Q+4mp8+dtWw88xNTCB///uWvV+4ybsckq6LGJfM8ts5wVbpMaEIZ1d2+qoc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=A8wf4iZN; arc=fail smtp.client-ip=52.101.70.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMYfkh6j6fE5Anyjx9h2MIKrm8FxwkhFeJBrGlKuMFkBrG1vs8d3hE3kvrFLFdTAa8orA31LJNLpOjtlL0Oh8aJh/haeqzi8jKTMOM0oznsOokJ9/zhOXfUUAoWUODq8MWAobxM6eip5Ql9luVFOWtavP2PKfem7qyUD7ZforrB+m4WO26Dfo4YP0C/3KrAAbgjGwolki6DojE+E3EfjvAHINxdF1cMmx8JRpZ0NswgWNJHAx6gzVvxIRZQBoAWhjownd3xCqfaQ5OUxWuX5fxlaehLnjJnUK/qHtHWPRSxLvVXPsUIXUaSZuvDJd0wQgiB2jzXXKYk99LMCMdAumA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ne3qs/zGP6BVjX5gcf0zk2hQAjKSiY2XXy4NASEemw0=;
 b=MNkRwwOspooK36Va9E+qDX/mUym0ZBnZzi+9ZBUs7SN5kkHy8ghSEa0TJgidvz19KJYie+MiA8mhEzcYwbiOnUBkwJClYCBv5haDTzLjZV0DS1H87lc/SYBakTqnKdnfRZ7SFIG0UK5ypuPahbJ+mMqHgq7TCtuA8n326lCavyLZcsarCNr18LVBPM7ByLPj1HTPm4HUZIx3d73X3g2fEDiKeo5aFXEXobJqgzAfXrE4m9p72dizc+I7hslQ+ui/dnlDRflEGe+FYDF1zz6qHplUddtEj+Pm2sQc5XZaytRVypVSZoqeYryFHZasY2QQTgv7cug1FBcKgHbfkfJq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ne3qs/zGP6BVjX5gcf0zk2hQAjKSiY2XXy4NASEemw0=;
 b=A8wf4iZNmuew8wi+Wxk6COPsz5o7URYPKo4TR3NiWAiaAPqBZBpZEeZRRR10x2dyO3dCXDDL5urjLTYdh7lkzaJhFIAj5LtcE+xQjJTvid9jCr8OCeisiiP4ocwGRjd1XZL/YYo6knDsOLpM6ilX/F0JMs86Ysu4QM3LJB/Q4z9Vd+25ycWhHYiWXlbKyYjwYIGrb1nzDY7S7ogCMhM63+jjHb9NQWWhiydWQNnqhL9IMEaABnNZwGMoV+Q6f4Oaa4I1+4BsUlu0MiAxjWUE5jLhGQjs78pmCO+ux5QlB684N00tChaDKnmdtWA/F3jRM1DpXCqzxwHIlvhVCVWRuw==
Received: from DU7P190CA0027.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::13)
 by OSKPR07MB10327.eurprd07.prod.outlook.com (2603:10a6:e10:99::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 13:10:35 +0000
Received: from DB5PEPF00014B9D.eurprd02.prod.outlook.com
 (2603:10a6:10:550:cafe::76) by DU7P190CA0027.outlook.office365.com
 (2603:10a6:10:550::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Sat, 3
 Jan 2026 13:10:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB5PEPF00014B9D.mail.protection.outlook.com (10.167.8.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1
 via Frontend Transport; Sat, 3 Jan 2026 13:10:34 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id F3E3C1C002B;
	Sat,  3 Jan 2026 15:10:32 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
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
Subject: [PATCH v7 net-next 01/13] tcp: try to avoid safer when ACKs are thinned
Date: Sat,  3 Jan 2026 14:10:16 +0100
Message-Id: <20260103131028.10708-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9D:EE_|OSKPR07MB10327:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc30c8f-ccc3-470a-7288-08de4ac97b16
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RlZQcHN2Wk9iNmlweWY5Zk5NTTZGRVNybWFGdlR4SFRWTHBUSHZVOGlXOHZM?=
 =?utf-8?B?VXhRUE11c0llbURQby9QdnpHVk9nSmJvelFVMXV3SFFMUkF3VHVKSnVHNnJI?=
 =?utf-8?B?TEJ3YzlLMWtQa3dNdTF6dWpuVnFHNVd0TExBZktzK3R5Y3VBaXpLNWhJV2pm?=
 =?utf-8?B?TW9MWmo4a0V6TE9NclhMK2l3c1B0c1NIbGtNVWoxOUFya0RuU3VqSVloMmRZ?=
 =?utf-8?B?RUpnQjZYcTd0TDRablM0bEVjaFhZV0pTUWdUQk1wbVJWaURmdVo3NTlzT0Z3?=
 =?utf-8?B?MmZlZ1c5ajFTclVmb1Uzc2s2ZEQxQVVid3JwbExzbWxBT21GZ1NyT3NLdWNB?=
 =?utf-8?B?Wk42UW93QVhFOVV3SVlpWG8zV0hGY0JnaXdkNkhsVnZKejNmRTROZlhaZVR6?=
 =?utf-8?B?dUtaRVg4Q3FPVzdaQndjNExzOWhWVHlpMWVJOEtYTmRTZloxazlWeDBwNmtp?=
 =?utf-8?B?cCtPMDZNamNCcGh2VTRleDhBTjNsdnBQS2M5b3k4SE1MZGEyeDFsZVZXMWFp?=
 =?utf-8?B?eFd4WDdFVllYZ21NU2xidHlmQVU3QnNqYW1hL3gvNDlFbVQrNmNZS1RJKzZZ?=
 =?utf-8?B?MHErRWd3eU8xRGljVUZQTkF1bks5b01McVhpTnQ4eldhazVlZGFUZFMxK3Vk?=
 =?utf-8?B?d2NDR0lQMlphNEdsM0Z5cS9lcUVNYnN6MEh6eUlhZnJuRS9GVEFlazQvYzdn?=
 =?utf-8?B?NVlZcVNUbytzL1NMdWl6V09YckhkOGFFYU8vQ3VwQzB4akdMcDRsd1RxaHFI?=
 =?utf-8?B?Vk9Ea0lPaDRpL2w0M1NZQmdtWTJDb05PRUdtOXJ2b3VXQm9KblU2dVFkeUVT?=
 =?utf-8?B?dVllWDZRb2o5VE1aZ0RBZVJRdVNZQ3pVWnpUQlowOVVwd0ptTnBxdTZ6NWg4?=
 =?utf-8?B?bVB0M2ZHWE80KzlmZTlqZ3k4MG5JZnRYSVljbGFMblowZFZoR3A2cExlcmlx?=
 =?utf-8?B?cFRmb0xFTlllY0ViYmdZRnZYOTNJckUvUzdxWGl0Vkx1UUQwZUZJdXRSQWJp?=
 =?utf-8?B?SmhmR1JoOVZkUk52d1JXNzNiUFpYL01VZXRSTW9TaEw3MGVaUjdyVVpJK0I2?=
 =?utf-8?B?WncyRHp6WXRyN0MyYnRLZ3VYakFUaHFMMktBQ0ZuUHFDc0RBSWJaZVpFNWVn?=
 =?utf-8?B?ZU9IU3lpZ0dpVjY2c0FuTDZoTldlM0l5RS85R214cHlwNzExMS95VHZlTko1?=
 =?utf-8?B?aFZnZTBNb1kyRXN2bjN3ZUFKZVk4OXVvSzV0MjBkMXU3eEtIM29KMGJ2cU15?=
 =?utf-8?B?aHhmMmVWUE9HVVlQK3cwcEU2U1NxRVRZSXdPTXZKbXFsQjRYT0l6Q29PTEZw?=
 =?utf-8?B?Q2IyVlVoMjBCSE14c0FBbC9teDBrMjFXdm1hc3M5OEhlZ29EMmpXRmhLTE1C?=
 =?utf-8?B?THo3UDhwSXpTcWNtMWRSYXk0SVo1UG45M3RzcWVMa3cwM0UxaWd0QnE1U3Jh?=
 =?utf-8?B?SkI5MzRuaG0wampHOWdVVVdybU1TWGRPNllBSGtJVm1RL2hwdnJIdHQzS2NX?=
 =?utf-8?B?SUk0bVRDMmVvQU53K0cxM0hIWFRzRVFRNXd5UmRURDNFSXlFdmhHZWFSSTdL?=
 =?utf-8?B?eFIvRmVsWUJOdktOTkpSNHdiRyt2YkFDTEl2VDNkdE5ZRzl4ckNKQ3F5YVV3?=
 =?utf-8?B?VU1QekdNRkVVNzdUT3gvb0dST2V2RWVQY1pXeEszT0NnbDhxWDlFTU43UFRJ?=
 =?utf-8?B?bFFXTUlnR0lBM1I0QlpiSzlwdmRXNm04MVp0WWNZK0NOTi9DNWtjSldpTWk5?=
 =?utf-8?B?Zm5aNUoyc0QzbDdBVGJvN21DSGU0d0VSR3JHUXNTWWlqblN6bjlWTm0vOW9s?=
 =?utf-8?B?U0IzMnROcHFQTFJINFJqVzNTR0FOQUtkeHBjdXAzUHlRcDNOcEpoTzJsbUpu?=
 =?utf-8?B?T1FGYWNCTXBRSlRyeFl6ZG8xVXJ4bGUza2JwM2dtOG5mUStaZzF4OUkybFBw?=
 =?utf-8?B?Skp0RjI2YlFkQ3FXUXlDOVA0R252OGUvU2pCRXRQaWh1Q3FKUFNVK1d2aXJK?=
 =?utf-8?B?NEZzQ1l0L3NWVE15UzFGSHpXYnFLS0ExZXJKRU54RE1VQlgxMkZkb0NMeWtP?=
 =?utf-8?B?dXR2QkJLd1dQRDFqRXU5a2ZRWWZlZkFnRHpoWm5mVGE3UjZJbkFvZ0o1YVhn?=
 =?utf-8?Q?LPIt7oZbqNVLC0ADE3TDLCRnq?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 13:10:34.6325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc30c8f-ccc3-470a-7288-08de4ac97b16
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR07MB10327

From: Ilpo Järvinen <ij@kernel.org>

Add newly acked pkts EWMA. When ACK thinning occurs, select
between safer and unsafe cep delta in AccECN processing based
on it. If the packets ACKed per ACK tends to be large, don't
conservatively assume ACE field overflow.

This patch uses the existing 2-byte holes in the rx group for new
u16 variables withtout creating more holes. Below are the pahole
outcomes before and after this patch:

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ecn_bytes[3]; /*  2744    12 */
    /* XXX 4 bytes hole, try to pack */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];       /*  2816     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 177 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ecn_bytes[3]; /*  2744    12 */
    u16                        pkts_acked_ewma;        /*  2756     2 */
    /* XXX 2 bytes hole, try to pack */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];       /*  2816     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 178 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v3:
- Add additional min() check if pkts_acked_ewma is not initialized.
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  1 +
 net/ipv4/tcp.c                                |  2 ++
 net/ipv4/tcp_input.c                          | 20 ++++++++++++++++++-
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 26f32dbcf6ec..563daea10d6c 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -105,6 +105,7 @@ u32                           received_ce             read_mostly         read_w
 u32[3]                        received_ecn_bytes      read_mostly         read_write
 u8:4                          received_ce_pending     read_mostly         read_write
 u32[3]                        delivered_ecn_bytes                         read_write
+u16                           pkts_acked_ewma                             read_write
 u8:2                          syn_ect_snt             write_mostly        read_write
 u8:2                          syn_ect_rcv             read_mostly         read_write
 u8:2                          accecn_minlen           write_mostly        read_write
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 20b8c6e21fef..683f38362977 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -345,6 +345,7 @@ struct tcp_sock {
 	u32	rate_interval_us;  /* saved rate sample: time elapsed */
 	u32	rcv_rtt_last_tsecr;
 	u32	delivered_ecn_bytes[3];
+	u16	pkts_acked_ewma;/* Pkts acked EWMA for AccECN cep heuristic */
 	u64	first_tx_mstamp;  /* start of window send phase */
 	u64	delivered_mstamp; /* time we reached "delivered" */
 	u64	bytes_acked;	/* RFC4898 tcpEStatsAppHCThruOctetsAcked
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f035440c475a..cd25fb50e81b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3420,6 +3420,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
+	tp->pkts_acked_ewma = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5193,6 +5194,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rate_interval_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_last_tsecr);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_ecn_bytes);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, pkts_acked_ewma);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, first_tx_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 198f8a0d37be..8e95a4e302f4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -488,6 +488,10 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 		tcp_count_delivered_ce(tp, delivered);
 }
 
+#define PKTS_ACKED_WEIGHT	6
+#define PKTS_ACKED_PREC		6
+#define ACK_COMP_THRESH		4
+
 /* Returns the ECN CE delta */
 static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes,
@@ -499,6 +503,7 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	u32 delta, safe_delta, d_ceb;
 	bool opt_deltas_valid;
 	u32 corrected_ace;
+	u32 ewma;
 
 	/* Reordered ACK or uncertain due to lack of data to send and ts */
 	if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
@@ -507,6 +512,18 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	opt_deltas_valid = tcp_accecn_process_option(tp, skb,
 						     delivered_bytes, flag);
 
+	if (delivered_pkts) {
+		if (!tp->pkts_acked_ewma) {
+			ewma = delivered_pkts << PKTS_ACKED_PREC;
+		} else {
+			ewma = tp->pkts_acked_ewma;
+			ewma = (((ewma << PKTS_ACKED_WEIGHT) - ewma) +
+				(delivered_pkts << PKTS_ACKED_PREC)) >>
+				PKTS_ACKED_WEIGHT;
+		}
+		tp->pkts_acked_ewma = min_t(u32, ewma, 0xFFFFU);
+	}
+
 	if (!(flag & FLAG_SLOWPATH)) {
 		/* AccECN counter might overflow on large ACKs */
 		if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
@@ -555,7 +572,8 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 		if (d_ceb <
 		    safe_delta * tp->mss_cache >> TCP_ACCECN_SAFETY_SHIFT)
 			return delta;
-	}
+	} else if (tp->pkts_acked_ewma > (ACK_COMP_THRESH << PKTS_ACKED_PREC))
+		return delta;
 
 	return safe_delta;
 }
-- 
2.34.1


