Return-Path: <linux-kselftest+bounces-39081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490D5B27B81
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 10:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1949BAA1FD9
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 08:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4262E266D;
	Fri, 15 Aug 2025 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="W0N0C+zG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013001.outbound.protection.outlook.com [40.107.162.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5753F2D1907;
	Fri, 15 Aug 2025 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247210; cv=fail; b=XGxUowbOjvsfezrHtIzqF9P70cfRQzvpUch0U/Q7DctfRkOFhSWRkXaIjUX2HmaUU6NaACqegfPpjrVmsHxFAYIqb1l5o0dhH2AnjdTPGq0AIh1qgqS7fvrAFkex/sPf/5qNQjgqZ+i+jEVzvBUY7M+4GJZWhtVNqXAAwNSygoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247210; c=relaxed/simple;
	bh=acfHT/2BQurdPnAunmnlfyXiank+MwReYmaEqLHwziA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VfK8+c7S4Xe9tEP50uyFO/2v7xob58LV955ZCl/v4b730I4XhuR8zYiHeSvAbW0/lRFHTpv15TGfTUlNb8BKmpy1NCF+ayp4BSDb1GaLjhzYJWj3pa3pcoOgvDJKaNfQgLi12PYiuexGHjnTiEgoQ8AyQeSXugs4uo1aU0mvb3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=W0N0C+zG; arc=fail smtp.client-ip=40.107.162.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVfDjqVWxfjdePKJSUChllvu4WQi01i/v5vxPy440GNRBRHXo0b4xcpri6+AS7dXjrDbA0rKpOSojqtHPbkBpehxFCSKOqimMgk0q++E61mHlsZNra8tx4zn/cWCflun3fXAuxmgVUcZ/Xbevdhk86fS2YMrMK9Q7Uh8sl2trFH1SXNPZFIKQtzL7jL8eAPcv1Nq4HFRDE85lU+VwUM0emNbT2L/HFrzuFTsbTfkB9gkGeVCO40YSCxWGizzDZ291sWH1ykywsOy4OBm90XgF9aviYaJ+u7X6/v0E7CYrJNows6GvtZ8c+HrXGw4Y0yHrdcfta35GNNOZZM53Hk9jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PM6xIJvaAm4sNDYqGr9LqcyL5nyoWo/zU2cMMB3jkYo=;
 b=c1vqQF/5k6EKXf45Jt/M2W38Bs+A+qY+YMAgUS79yWNQYYBqiJmG3SPfcQ8sbpq4ChIV/oP9S5KaW8FUr1wRikGHnHaxVQdjbH/t+0NZ9xCPl115P4hVY84Q5ia0T4C7WDFErr7NomH6EJrhyS5qaMVAncyKkalvP9xImC5ORgfcP4fZvCo2KDd1jnpj5uwtqDOb8YTRhs1ax1SUoaIx+81Eadb5Uxr/VzTvQe5finyrVhlYmH0PPIM9l5GMYIDv3xlWSxBzhbKLzMquCxzheaqeZmox/AVUy/RoSI4c/Y3OY3VrTinabyTobvvT+fVDo82xFk98kfJf7vtRqr95kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PM6xIJvaAm4sNDYqGr9LqcyL5nyoWo/zU2cMMB3jkYo=;
 b=W0N0C+zGbCXMdTD0UFclW5Jrc4lznu9+PMdM/m8e5T2EjH5GvyPzoKa3+IFTbGMK4TJw7TeqUpPQ+io1BBli7jp9UMoBHv72d9O5sME+6SVB9+320PJPBf4Ds9i2N1S6yL+k0n2uq34dUKEpQFCSsvwCBlDWwlON/4pcc4IRqE9gKv3hxii+kXSmNIkt9r4a7F4SIcyN4pk7NJ/x0AbpEuCbXk1G/znJ9RzI4wtdGMgGFFb3Coay2c4p671tG7rZJwguzUBtuuR0OpPj2evTz2h5jmhCvnoGKD44F4AWKNS5L6oWhFmr6frBOk23zs0UzWlK8NtuhOtQSPQVmkh58Q==
Received: from AM0PR02CA0083.eurprd02.prod.outlook.com (2603:10a6:208:154::24)
 by PAXPR07MB7822.eurprd07.prod.outlook.com (2603:10a6:102:15e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 08:40:03 +0000
Received: from AM4PEPF00027A68.eurprd04.prod.outlook.com
 (2603:10a6:208:154:cafe::79) by AM0PR02CA0083.outlook.office365.com
 (2603:10a6:208:154::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 08:40:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM4PEPF00027A68.mail.protection.outlook.com (10.167.16.85) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.11
 via Frontend Transport; Fri, 15 Aug 2025 08:40:03 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 5BB781C003B;
	Fri, 15 Aug 2025 11:40:01 +0300 (EEST)
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
Subject: [PATCH v15 net-next 11/14] tcp: accecn: AccECN option send control
Date: Fri, 15 Aug 2025 10:39:27 +0200
Message-Id: <20250815083930.10547-12-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A68:EE_|PAXPR07MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b32c699-6f1c-44ce-db52-08dddbd75439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2dCZEZLRllieGNlVjlQeGx1N1o2L0hiSVhBcjJGdi9ZbHR1eDZaeVNydFNB?=
 =?utf-8?B?RWlJTWxTbXgrRUQ0OGFwbUp1c0k1WkM0Zlk4Q2xNL2x6d2RXZEVrYmJ2c1Fz?=
 =?utf-8?B?dkhvUXhCUmJIdVNSNTFPUEZ1NlI0RWhnczZVUUE4VjRRUGZHcy9WaTFyZkRW?=
 =?utf-8?B?djl4dlVpTVU2V3dZbXJ2alozV3BQbTFmVklZNExXNWd4VnhzajBMOVlKZDVL?=
 =?utf-8?B?cE92ZTBiMFFMRDVTdzg5TzNiVkdlZm1YWWJBY2ZrNWMvYkQ3TXNCd1FoeUhQ?=
 =?utf-8?B?TUNHUlFYRzY1Z3V3bmJwV2o1Mlp2RnU5QnZDSlVGS0JNVG5yQUVycSsveGxH?=
 =?utf-8?B?K05IQlNkQ3ZqQjc2MWtMdXMrUjh2WmhqS1Z2ZzdJOEE2V0wvZVdTbnBMSFNu?=
 =?utf-8?B?emZMQTEwY0JoZlRzRmlBQ3lrMlpWU3lGYnVJOTlia2gyN0dXSjRUQ1dZdVBJ?=
 =?utf-8?B?c21KdmhmVjJlYU00TzhrOFZNR2tkYTNkVE4ydWh2UTMzbkh2bXUzR3lFc21r?=
 =?utf-8?B?dkNoT1VyNUNWQnRhRFJiOUlZRnhlS21vZFFzU3JGcGZXS2xaSk9vbFBrK05C?=
 =?utf-8?B?dHVsYklWZGhsdlpOczdTMVhUVkVwMTd0ZnVoZFJXL2o1YmZIZlladHVCT3VG?=
 =?utf-8?B?STBtUWFUR3JwVE1Fc1RXa1RUZm5RQkQ1NE5FRU1ObHI4RmlHbU9vRDRmbU5I?=
 =?utf-8?B?aTNmeFhXMWpTTjNrZnVCdnV0U1dIZmVHZFJ6aVlNTkcvNEwydXN2ckQxejdN?=
 =?utf-8?B?Z3Y0VGw3RE9tYlhJRnFoeGpmckR2NWVUd0RnMlc5UFlEeU9HOG5qYVR4ZHVy?=
 =?utf-8?B?MEx6d3hHOUVCSm5sZE84Tzd1K3Bob1VkeW0xTDluZzZSMU9vdWUrZC91azQz?=
 =?utf-8?B?RFpIWmhvOUlBWWREQjBIT29nUGdwRE1xTGhLcStHVVRpYWo0YkFyaHdVaE11?=
 =?utf-8?B?VmN4NDlFcFRYb3F3eGczQU5wMnhBY3RKckRNbUhEakhDbENjb1ZiWWRUc2ty?=
 =?utf-8?B?bWxBMmJpRzQxTS81d0p6QjZ4bkdnQUhwa3V0RFFwNzRONXdyeUlDanFpb25T?=
 =?utf-8?B?MHRvVDVrdDFwblBCY2gxNTgrVVczazRTS21nclhmOTlVVmdsTXlDTTVnUmhs?=
 =?utf-8?B?S0tmSW8vRHhreFdTZ2NtcXJnVEFSQnJ0Mi9TRnJrZTdacUVoa2o0Y3NVeG9F?=
 =?utf-8?B?dmFhcUgwblJoZ3hPb0dQbTVVSE9WQkNROTE4amNqRlZEcWIwM2VjQW91dFdF?=
 =?utf-8?B?TkFqbFRtdDhwK0I2UndZcW9UMmxQazFRUGE2Q3JyK0pCcllWUSthdGFBd0JH?=
 =?utf-8?B?ZjRMZVg2anpnUDZmYUlWZCtwNnNyRHZCck56ZE5NZWJFcUg5UVRxZ2ZuWmlD?=
 =?utf-8?B?OSt6SXpoNm9lVDJEaTJsaUdNTXdVRGxhZ2tzVFpDTndPNlpIOHhaNHRXQ213?=
 =?utf-8?B?RUxtTlpkNVlONE1ZWFAva0JHWXhhSEVQbkY5ekZKcGJrTFpDQWZzR3lRZGs0?=
 =?utf-8?B?MXAzRWZITjhyZy9uaUxTMTdDUmkwVWhvbXlqSmozQzh6VjltVWY0UWMreUpM?=
 =?utf-8?B?eERDR3lEbmgxTDRIUlY3SHFSN3BzV01QZk1FU1g3akxTYW1jeFU3RHRUSGU1?=
 =?utf-8?B?U0RSYzZ6ckZaVXlqZnhOMmcwbEJPT2U0Q2h0WE05U093RGNsSVplM0x4N2ps?=
 =?utf-8?B?MW9ua2p5eG9WM2VsaVFPUzltYzNjR2J2NDEyT0NIOCtsYVFMWWs3bndYQUpZ?=
 =?utf-8?B?eUZucVQyVG9LbzdPSVRkVTNwdTZyWDdTSTNxNEY1K3VyQjd0dURJa0xOU0F0?=
 =?utf-8?B?S3hOTUVqTTBTZnFLY3ZEbjFjZzRJOC94VnBYRy8xWVh6aXM5MSsyQjYweEpE?=
 =?utf-8?B?dHNXQlU5cnZzSFllQnFGQnc5TVhveEkrTlNwSTR5djdyNFpDOVlFNGpLRDl5?=
 =?utf-8?B?dFpXaTc2bUE5STRNSkZsWWNIc2Vza3JiS2tTS2w5M2ViWGxPQXQ3Y0JYWkdr?=
 =?utf-8?B?b2c1Zjc3aE9Ucm5QMjJpZjZDNG1RODdocDRiSXlvZERBZlNTVE13cjZWV3Zp?=
 =?utf-8?B?RTdnVk9tZkRwODBTYXBUdFBBSWZiQnVqSGdPdz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 08:40:03.3221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b32c699-6f1c-44ce-db52-08dddbd75439
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A68.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7822

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Instead of sending the option in every ACK, limit sending to
those ACKs where the option is necessary:
- Handshake
- "Change-triggered ACK" + the ACK following it. The
  2nd ACK is necessary to unambiguously indicate which
  of the ECN byte counters in increasing. The first
  ACK has two counters increasing due to the ecnfield
  edge.
- ACKs with CE to allow CEP delta validations to take
  advantage of the option.
- Force option to be sent every at least once per 2^22
  bytes. The check is done using the bit edges of the
  byte counters (avoids need for extra variables).
- AccECN option beacon to send a few times per RTT even if
  nothing in the ECN state requires that. The default is 3
  times per RTT, and its period can be set via
  sysctl_tcp_ecn_option_beacon.

Below are the pahole outcomes before and after this patch,
in which the group size of tcp_sock_write_tx is increased
from 89 to 97 due to the new u64 accecn_opt_tstamp member:

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    u64                        tcp_wstamp_ns;        /*  2488     8 */
    struct list_head           tsorted_sent_queue;   /*  2496    16 */

    [...]
    __cacheline_group_end__tcp_sock_write_tx[0];     /*  2521     0 */
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2521     0 */
    u8                         nonagle:4;            /*  2521: 0  1 */
    u8                         rate_app_limited:1;   /*  2521: 4  1 */
    /* XXX 3 bits hole, try to pack */

    /* Force alignment to the next boundary: */
    u8                         :0;
    u8                         received_ce_pending:4;/*  2522: 0  1 */
    u8                         unused2:4;            /*  2522: 4  1 */
    u8                         accecn_minlen:2;      /*  2523: 0  1 */
    u8                         est_ecnfield:2;       /*  2523: 2  1 */
    u8                         unused3:4;            /*  2523: 4  1 */

    [...]
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2628     0 */

    [...]
    /* size: 3200, cachelines: 50, members: 171 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    u64                        tcp_wstamp_ns;        /*  2488     8 */
    u64                        accecn_opt_tstamp;    /*  2596     8 */
    struct list_head           tsorted_sent_queue;   /*  2504    16 */

    [...]
    __cacheline_group_end__tcp_sock_write_tx[0];     /*  2529     0 */
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2529     0 */
    u8                         nonagle:4;            /*  2529: 0  1 */
    u8                         rate_app_limited:1;   /*  2529: 4  1 */
    /* XXX 3 bits hole, try to pack */

    /* Force alignment to the next boundary: */
    u8                         :0;
    u8                         received_ce_pending:4;/*  2530: 0  1 */
    u8                         unused2:4;            /*  2530: 4  1 */
    u8                         accecn_minlen:2;      /*  2531: 0  1 */
    u8                         est_ecnfield:2;       /*  2531: 2  1 */
    u8                         accecn_opt_demand:2;  /*  2531: 4  1 */
    u8                         prev_ecnfield:2;      /*  2531: 6  1 */

    [...]
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2636     0 */

    [...]
    /* size: 3200, cachelines: 50, members: 173 */
}

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Co-developed-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>

---
v14
- Add missing const for struct tcp_sock of tcp_accecn_option_beacon_check()

v13
- Use GENMASK_U32() for bytes_mask of tcp_ecn_received_counters()
- Make tcp_accecn_option_beacon_check() consistent
- Use READ_ONCE() only once in tcp_established_options()

v10
- Add documentation of tcp_ecn_option_beacon in ip-sysctl.rst to this patch

v8:
- Add new helper function tcp_accecn_opt_demand_min()
- Remove white space only change
---
 Documentation/networking/ip-sysctl.rst        |  6 +++
 .../networking/net_cachelines/tcp_sock.rst    |  3 ++
 include/linux/tcp.h                           |  4 +-
 include/net/netns/ipv4.h                      |  1 +
 include/net/tcp.h                             |  3 ++
 include/net/tcp_ecn.h                         | 52 +++++++++++++++++++
 net/ipv4/sysctl_net_ipv4.c                    |  9 ++++
 net/ipv4/tcp.c                                |  5 +-
 net/ipv4/tcp_input.c                          |  4 +-
 net/ipv4/tcp_ipv4.c                           |  1 +
 net/ipv4/tcp_minisocks.c                      |  2 +
 net/ipv4/tcp_output.c                         | 26 +++++++---
 12 files changed, 107 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 70cc11ff6763..b4ca041025ce 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -487,6 +487,12 @@ tcp_ecn_option - INTEGER
 
 	Default: 2
 
+tcp_ecn_option_beacon - INTEGER
+	Control Accurate ECN (AccECN) option sending frequency per RTT and it
+	takes effect only when tcp_ecn_option is set to 2.
+
+	Default: 3 (AccECN will be send at least 3 times per RTT)
+
 tcp_ecn_fallback - BOOLEAN
 	If the kernel detects that ECN connection misbehaves, enable fall
 	back to non-ECN. Currently, this knob implements the fallback
diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index b941151f8c0a..d4dc01800945 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -109,6 +109,9 @@ u8:2                          syn_ect_snt             write_mostly        read_w
 u8:2                          syn_ect_rcv             read_mostly         read_write
 u8:2                          accecn_minlen           write_mostly        read_write
 u8:2                          est_ecnfield                                read_write
+u8:2                          accecn_opt_demand       read_mostly         read_write
+u8:2                          prev_ecnfield                               read_write
+u64                           accecn_opt_tstamp       read_write
 u8:4                          accecn_fail_mode
 u32                           lost                                        read_mostly         tcp_ack
 u32                           app_limited             read_write          read_mostly         tcp_rate_check_app_limited,tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 73557656cb2d..f637b659b35a 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -275,6 +275,7 @@ struct tcp_sock {
 	u32	mdev_us;	/* medium deviation			*/
 	u32	rtt_seq;	/* sequence number to update rttvar	*/
 	u64	tcp_wstamp_ns;	/* departure time for next sent data packet */
+	u64	accecn_opt_tstamp;	/* Last AccECN option sent timestamp */
 	struct list_head tsorted_sent_queue; /* time-sorted sent but un-SACKed skbs */
 	struct sk_buff *highest_sack;   /* skb just after the highest
 					 * skb with SACKed bit set
@@ -296,7 +297,8 @@ struct tcp_sock {
 		unused2:4;
 	u8	accecn_minlen:2,/* Minimum length of AccECN option sent */
 		est_ecnfield:2,/* ECN field for AccECN delivered estimates */
-		unused3:4;
+		accecn_opt_demand:2,/* Demand AccECN option for n next ACKs */
+		prev_ecnfield:2; /* ECN bits from the previous segment */
 	__be32	pred_flags;
 	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
 	u64	tcp_mstamp;	/* most recent packet received/sent */
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 4569a9ef4fb8..ff8b5b56ad00 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -149,6 +149,7 @@ struct netns_ipv4 {
 
 	u8 sysctl_tcp_ecn;
 	u8 sysctl_tcp_ecn_option;
+	u8 sysctl_tcp_ecn_option_beacon;
 	u8 sysctl_tcp_ecn_fallback;
 
 	u8 sysctl_ip_default_ttl;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 698969b7e792..81589dd0baf0 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -90,6 +90,9 @@ void tcp_time_wait(struct sock *sk, int state, int timeo);
 /* Maximal number of window scale according to RFC1323 */
 #define TCP_MAX_WSCALE		14U
 
+/* Default sending frequency of accurate ECN option per RTT */
+#define TCP_ACCECN_OPTION_BEACON	3
+
 /* urg_data states */
 #define TCP_URG_VALID	0x0100
 #define TCP_URG_NOTYET	0x0200
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 6bf5b3b7c648..89a01bc99233 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -176,6 +176,17 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
 	}
 }
 
+/* Demand the minimum # to send AccECN optnio */
+static inline void tcp_accecn_opt_demand_min(struct sock *sk,
+					     u8 opt_demand_min)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	u8 opt_demand;
+
+	opt_demand = max_t(u8, opt_demand_min, tp->accecn_opt_demand);
+	tp->accecn_opt_demand = opt_demand;
+}
+
 /* Maps IP ECN field ECT/CE code point to AccECN option field number, given
  * we are sending fields with Accurate ECN Order 1: ECT(1), CE, ECT(0).
  */
@@ -256,6 +267,7 @@ static inline void tcp_ecn_received_counters(struct sock *sk,
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
 	struct tcp_sock *tp = tcp_sk(sk);
+	bool ecn_edge;
 
 	if (!INET_ECN_is_not_ect(ecnfield)) {
 		u32 pcount = is_ce * max_t(u16, 1, skb_shinfo(skb)->gso_segs);
@@ -274,9 +286,34 @@ static inline void tcp_ecn_received_counters(struct sock *sk,
 
 		if (len > 0) {
 			u8 minlen = tcp_ecnfield_to_accecn_optfield(ecnfield);
+			u32 oldbytes = tp->received_ecn_bytes[ecnfield - 1];
+			u32 bytes_mask = GENMASK_U32(31, 22);
+
 			tp->received_ecn_bytes[ecnfield - 1] += len;
 			tp->accecn_minlen = max_t(u8, tp->accecn_minlen,
 						  minlen);
+
+			/* Send AccECN option at least once per 2^22-byte
+			 * increase in any ECN byte counter.
+			 */
+			if ((tp->received_ecn_bytes[ecnfield - 1] ^ oldbytes) &
+			    bytes_mask) {
+				tcp_accecn_opt_demand_min(sk, 1);
+			}
+		}
+	}
+
+	ecn_edge = tp->prev_ecnfield != ecnfield;
+	if (ecn_edge || is_ce) {
+		tp->prev_ecnfield = ecnfield;
+		/* Demand Accurate ECN change-triggered ACKs. Two ACK are
+		 * demanded to indicate unambiguously the ecnfield value
+		 * in the latter ACK.
+		 */
+		if (tcp_ecn_mode_accecn(tp)) {
+			if (ecn_edge)
+				inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
+			tp->accecn_opt_demand = 2;
 		}
 	}
 }
@@ -349,6 +386,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 	__tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
 	tp->accecn_minlen = 0;
+	tp->accecn_opt_demand = 0;
 	tp->est_ecnfield = 0;
 }
 
@@ -431,6 +469,7 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
 	default:
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
+		tp->accecn_opt_demand = 2;
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
@@ -451,6 +490,7 @@ static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
 		} else {
 			tp->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
 					  INET_ECN_MASK;
+			tp->prev_ecnfield = tp->syn_ect_rcv;
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		}
 	}
@@ -549,4 +589,16 @@ tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
 		th->ece = 1;
 }
 
+static inline bool tcp_accecn_option_beacon_check(const struct sock *sk)
+{
+	u32 ecn_beacon = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option_beacon);
+	const struct tcp_sock *tp = tcp_sk(sk);
+
+	if (!ecn_beacon)
+		return false;
+
+	return tcp_stamp_us_delta(tp->tcp_mstamp, tp->accecn_opt_tstamp) * ecn_beacon >=
+	       (tp->srtt_us >> 3);
+}
+
 #endif /* _LINUX_TCP_ECN_H */
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 1d7fd86ca7b9..169a393374b3 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -740,6 +740,15 @@ static struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
+	{
+		.procname	= "tcp_ecn_option_beacon",
+		.data		= &init_net.ipv4.sysctl_tcp_ecn_option_beacon,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_THREE,
+	},
 	{
 		.procname	= "tcp_ecn_fallback",
 		.data		= &init_net.ipv4.sysctl_tcp_ecn_fallback,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5cc5b9a906a1..7808666bafda 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3393,6 +3393,8 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->delivered_ce = 0;
 	tp->accecn_fail_mode = 0;
 	tcp_accecn_init_counters(tp);
+	tp->prev_ecnfield = 0;
+	tp->accecn_opt_tstamp = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5116,11 +5118,12 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, lsndtime);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, mdev_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, tcp_wstamp_ns);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, accecn_opt_tstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, rtt_seq);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, tsorted_sent_queue);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, highest_sack);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, ecn_flags);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_tx, 89);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_tx, 97);
 
 	/* TXRX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, pred_flags);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index f07a9cd33ab1..9db75de542a5 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6121,8 +6121,10 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	 * RFC 5961 4.2 : Send a challenge ack
 	 */
 	if (th->syn) {
-		if (tcp_ecn_mode_accecn(tp))
+		if (tcp_ecn_mode_accecn(tp)) {
 			accecn_reflector = true;
+			tcp_accecn_opt_demand_min(sk, 1);
+		}
 		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
 		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
 		    TCP_SKB_CB(skb)->seq + 1 == tp->rcv_nxt &&
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 1629698ff91c..f4d759af887a 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3587,6 +3587,7 @@ static int __net_init tcp_sk_init(struct net *net)
 {
 	net->ipv4.sysctl_tcp_ecn = TCP_ECN_IN_ECN_OUT_NOECN;
 	net->ipv4.sysctl_tcp_ecn_option = TCP_ACCECN_OPTION_FULL;
+	net->ipv4.sysctl_tcp_ecn_option_beacon = TCP_ACCECN_OPTION_BEACON;
 	net->ipv4.sysctl_tcp_ecn_fallback = 1;
 
 	net->ipv4.sysctl_tcp_base_mss = TCP_BASE_MSS;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 0a0ee33e38ad..848c756a37b8 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -473,6 +473,8 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
+		tp->prev_ecnfield = treq->syn_ect_rcv;
+		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters_payload(sk, skb);
 	} else {
 		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 3b68d7cc6239..376f858575d4 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -705,8 +705,12 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 			*ptr++ = htonl(((e0b & 0xffffff) << 8) |
 				       TCPOPT_NOP);
 		}
-		if (tp)
+		if (tp) {
 			tp->accecn_minlen = 0;
+			tp->accecn_opt_tstamp = tp->tcp_mstamp;
+			if (tp->accecn_opt_demand)
+				tp->accecn_opt_demand--;
+		}
 	}
 
 	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
@@ -1149,11 +1153,16 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 		opts->num_sack_blocks = 0;
 	}
 
-	if (tcp_ecn_mode_accecn(tp) &&
-	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option)) {
-		opts->use_synack_ecn_bytes = 0;
-		size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
-					       MAX_TCP_OPTION_SPACE - size);
+	if (tcp_ecn_mode_accecn(tp)) {
+		int ecn_opt = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option);
+
+		if (ecn_opt &&
+		    (ecn_opt >= TCP_ACCECN_OPTION_FULL || tp->accecn_opt_demand ||
+		     tcp_accecn_option_beacon_check(sk))) {
+			opts->use_synack_ecn_bytes = 0;
+			size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
+						       MAX_TCP_OPTION_SPACE - size);
+		}
 	}
 
 	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
@@ -2863,6 +2872,11 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
 	sent_pkts = 0;
 
 	tcp_mstamp_refresh(tp);
+
+	/* AccECN option beacon depends on mstamp, it may change mss */
+	if (tcp_ecn_mode_accecn(tp) && tcp_accecn_option_beacon_check(sk))
+		mss_now = tcp_current_mss(sk);
+
 	if (!push_one) {
 		/* Do MTU probing. */
 		result = tcp_mtu_probe(sk);
-- 
2.34.1


