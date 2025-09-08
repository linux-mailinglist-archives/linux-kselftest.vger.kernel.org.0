Return-Path: <linux-kselftest+bounces-40976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F6CB49726
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 19:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C171893132
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 17:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE10318136;
	Mon,  8 Sep 2025 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="QknoJPvJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013046.outbound.protection.outlook.com [40.107.159.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73D73176ED;
	Mon,  8 Sep 2025 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352880; cv=fail; b=mAZ9zhCRI0Be5PL5/v8goVMwyktNI8T/r/epJdZnQ/SYdFhNmnWoF7yFphhy6yd1tV5RCtkJWgjVxq2ZaoIL/4dAuaQ8S8KlFKAMllS0sGruqbjuqQh4bVU1OS202T4Woo832INnRgK0JzbzpqXF2Sp9phDLbqlvNLjhs2hTiv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352880; c=relaxed/simple;
	bh=nz28KqbbWh9uRNu7OUQ4y0asgaX3A/vM7oMEBsSUUd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZTKNeLdAF/5xJxNMMjuaTMV9j8jYHDGT83tmpXlJV1wbAR3eRv/qWCWiDj8tC1Q0n1I2al3EfekCvxs2xdotBWgXniV4op/mD4ilnW/Q72qQArGCtKtGIWhVACX4VlMWShkyzF+257nxtDmaJFXi1rY26pF1agBuKG5T6opLsZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=QknoJPvJ; arc=fail smtp.client-ip=40.107.159.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBOdShmyrs+zAF4VdBdi56fW0d4fPAr4hYWCANpmOzxhCP/KVyZpf+5Nxtn7fj7C9uuTPGeDsVmh9OHX1z28BNcaAFPN0iKnCfpJf4icVtABN4xgptU4A62GaSx131MWRNxKLGEKDBq7ONUvA9P2kMB3VsFNAs6RGcYeefUoSWNL2eJUe5MvBDSnEoi8MkB9iSd5YVqQSkIijTVCaVX0oT/AtxrHwhnjIlLHJfLFj3yRklwnm6YuP//nxl+xK+bh1bjAvHFRHQ54r3cRjM+zMV1+cPZxZC0FWGe1sCrz/2Dpph14l7/soJ+HBvN1A+ToYlq5jL1kzeYA6QKc81tp8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRb1EKzELm2V1v4XQ2fwngIBL176AuCB878SOqj3eok=;
 b=BpL0Q2NDkl/mLZ6lIC3PEqh3iCbW46gwM5+H7eF3IPt2UaHpTgr3VxnMlgpaFudR4XdBT/CpNRgIZnH1jSELin3p+YJH7NTTMum0+dcqHy712Zgh+9c3p78fwkooqczuoZbEOrYo4insmSk3Q8RZqkxdp1ma9Et5t/hXVzmoIyyN9bLvdkimS/q+UY1qg70ossLQ5S4D/jbh4nu5gj40ljGWeocj4jqjlNU17iphEknRSNPgbeokdxtU0iGXiV6jxqTnjMstmdT0SH9Y1tQ5TwvpopquLjydyodEm0sH56M7Ap/hRzDs70OhNcQR0tEFWNN0fx9oqGsdkHSAgj7pGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRb1EKzELm2V1v4XQ2fwngIBL176AuCB878SOqj3eok=;
 b=QknoJPvJ1xcG/SiS60/papHHyRyhFLlEoj7S/q0Z0IqTjUJULcJJKnVZatBAv63ce6whb9nkAdcVO+zUXHpmfHKzR0Zdxyxz8pxGH0hPw7KziIoCbLeVMZCr4DLRdSe/NAMZm2dDuJZ9CgDIvoWkiSlDpjouXoPwu5QXp82fxu0R72oyhngFZ1vf6tIq4GMiyHBINxpZ6LQn8iv7xLDoHUnkgWPHgOdPTYcY9/O/DTKaE2sdIGjhSWGssLg1s1tvuxh8RXxUACqR4jr1s6hE8AmQXptnRaJkW4HXU53fa/y7pZJMCoFO9jblIZr4KI2bztsiA3x2HpMabk0wcVallQ==
Received: from DU7P191CA0014.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::27)
 by DBAPR07MB6584.eurprd07.prod.outlook.com (2603:10a6:10:18a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 17:34:34 +0000
Received: from DB1PEPF00050A00.eurprd03.prod.outlook.com
 (2603:10a6:10:54e:cafe::12) by DU7P191CA0014.outlook.office365.com
 (2603:10a6:10:54e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 17:34:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF00050A00.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Mon, 8 Sep 2025 17:34:34 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 9E8861C0053;
	Mon,  8 Sep 2025 20:34:32 +0300 (EEST)
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
Subject: [PATCH v17 net-next 11/14] tcp: accecn: AccECN option send control
Date: Mon,  8 Sep 2025 19:34:05 +0200
Message-Id: <20250908173408.79715-12-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A00:EE_|DBAPR07MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da5eb24-c704-4625-959a-08ddeefdf9f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTdaQmZkTHUxNDdHR2c4UUJoMHdhcmxiYmQydGthTnpBcTdFdEVZUE5vVHpL?=
 =?utf-8?B?T09waDlPYXIzZ1grKzdIbFFWVWw5a29obXVSVnF1d0I4Nm5XU0xGb2JaRjNO?=
 =?utf-8?B?anhJRlRiNUIrODM5NzUvMjRZUzF6MEMrTExYaVJKR2xSeEFPSE1kOUFaN0xM?=
 =?utf-8?B?cUx6N0tUNGZlVHB4UENLMkFEYndqdkZNbG1DelVDTWxVNTJxaEhWcCtZTWNO?=
 =?utf-8?B?WmRFN3FJRmZzUkhYL1FSWkRqS1Z3VmFLaG1wRjhZVklacnNSVldHVUNUem9Z?=
 =?utf-8?B?MGdNZmsreDNEQXFpSGk5MUppY0JtNDE2d29Da28wamdDekVPcHVsT21Ncnla?=
 =?utf-8?B?cXRGbzN2OTMwdlNSZmVHVmNaZjkvK29UVGJWVTlINUtSVTBhd29JL09lOFlw?=
 =?utf-8?B?NTBUdVd4NndwY0J5UGJSeGZpZUR5M1E5ODFXakhhbm1zS3JGa1FKbXI3clFm?=
 =?utf-8?B?NHNWZzVBMUNtcWM0WG5hQThJcFUvVWxJeFJTeU81Ky85MmxWc1oyazNTK1o3?=
 =?utf-8?B?ckdGL2UzQldodno2RHcrbkVuRjhXOCttQ2RoSEgrRzIrcllsOFJKendvV1JQ?=
 =?utf-8?B?YXhvTmFRR096Tld3ODZKNS8rS1hoeGZmQmJnOE1QaHFhdmFkeVBqVGtIdEFJ?=
 =?utf-8?B?MEpZNnZpUEE1RHd2TkFtSEdLQ280YnNxdjRVZ2xZUllDbFRLbXpXdDMyeW9R?=
 =?utf-8?B?SFV1YkFJSncvdjU1OGJ6Z0VMaHVyUG82T3pub0JoeGk5d1lsSWpWam5tY1pB?=
 =?utf-8?B?V0poK0RCeHNGbzdVdXN0aVYxbjNjQnVvd3VXT1E3aHVpVzlNSnJaOHd5Ulo2?=
 =?utf-8?B?NzhEemp0cFNFY1orazZPSTBJQitXeXFUQ0RVNGRTNVEwWjNPTmNBK0krTlMx?=
 =?utf-8?B?Y1p0S2o5MEF3YjgzYWNLZmNjOWJrREtyeVlPWnVRKzZjUWF0T3VyMitHM0oy?=
 =?utf-8?B?b3RIcUhrVCs4anJENDRpU09aTm11a0lZdnhuVk5BWXdtcnZ5NzVNOURhWGtx?=
 =?utf-8?B?R3VGZnljVVFpWUh6VmJBTEpHeHFuSkhIazJ1dGxhc1UrbTRxbjluOVVGaGdH?=
 =?utf-8?B?UkNsQTFIbkRLTm5EVnFUK0VUWDY5Q1ZxTHBBRHBqanZGUElwckZ3WHYrVnZX?=
 =?utf-8?B?UVI4SEF1cFBPZ1lFTXFNRmVNbTBuV0thcWs1UmIzczZtZHB4VW1Hby9kSnJ4?=
 =?utf-8?B?Mk5VQlJZRit4akkydTg0T0tGek9PN0U4VXpqYVF4cm9XNWI3VnQ2RllzWGVp?=
 =?utf-8?B?bUUvV2V0S1E3Z3FzdER5NSt2OGhWZUprelcvZmMyZ1dXenpSSDg0WnN3aUFk?=
 =?utf-8?B?dW9TaCtXeTBvb3Q2aXdET0xMUk81UHJvWnlMZ1hxUXVrSFdVR1pxV0hXMzh5?=
 =?utf-8?B?Y3MyRU5tRlF6VWRBYVJTbEo4OU0wdDgrTkFBVkJJYXArMnZCcXBRWUxGczVK?=
 =?utf-8?B?RFVwOXZDK2pYVDdoM0VpM3Zkd1QyTC9JdFdrSVR1L0xueTBzcnNlby94OUk3?=
 =?utf-8?B?enU1REJyOGRhcDVyVTZobWovZFB5TllUalpEb2FWMnl3VUxlTlEyYjlOVHhG?=
 =?utf-8?B?eUtMWXNoK1VYSHZwb0hpeEZZUmdMTkhCSGc5REp3eG5ubUtlR0YxeHRLeXFT?=
 =?utf-8?B?TW4xRm5Xd0k5ODhaV2JITWdITi9IcERPMFJYWm9lZ3R6TG53TWZMb0FUNFVm?=
 =?utf-8?B?cXplbitESkhwcExQU0pnSHNXUEpzbldMMVJwWDVoblNqd2NUbEdKVDdkckww?=
 =?utf-8?B?VGNUcExMQkF0ZnNaWGVTR3VtUU9uTHpack1aVHV5ZjlCSGNmeGZzOTY1N3Y0?=
 =?utf-8?B?ZnBtV01PVzN0dnVaS1ZPalFyQTJmT1J0L040M2tMU2d0ZWRtckFnMmRuV0x2?=
 =?utf-8?B?VEI1VTcrWXZ2eGtDTzVlRm9iNWJzSE1tMnFjUGhZcUpxR0NCWFdLeXZCeXFm?=
 =?utf-8?B?Y3ZYalRCZWRyVVhHdHVBV0QrQzhzQ1BtaGtiYjVKNytLc21WM21GbGswRG9v?=
 =?utf-8?B?UWFpcnA5T0Iyd0R1SEdNU0ZTVlRlbis5YlNsaktUU3g1bjcxNWdIeGxRZllJ?=
 =?utf-8?B?WnBMckdDNldVanMzdHk4T0JQeWdTS1EwQk41UT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 17:34:34.2169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da5eb24-c704-4625-959a-08ddeefdf9f3
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF00050A00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6584

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
Reviewed-by: Eric Dumazet <edumazet@google.com>

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
index 1c206501b973..a06cb99d66dc 100644
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
index acbb7dd497e1..34eb3aecb3f2 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -149,6 +149,7 @@ struct netns_ipv4 {
 
 	u8 sysctl_tcp_ecn;
 	u8 sysctl_tcp_ecn_option;
+	u8 sysctl_tcp_ecn_option_beacon;
 	u8 sysctl_tcp_ecn_fallback;
 
 	u8 sysctl_ip_default_ttl;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 02f2895d57a8..dbb28c33ddc1 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -100,6 +100,9 @@ void tcp_time_wait(struct sock *sk, int state, int timeo);
 /* Maximal number of window scale according to RFC1323 */
 #define TCP_MAX_WSCALE		14U
 
+/* Default sending frequency of accurate ECN option per RTT */
+#define TCP_ACCECN_OPTION_BEACON	3
+
 /* urg_data states */
 #define TCP_URG_VALID	0x0100
 #define TCP_URG_NOTYET	0x0200
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 08c7f4757e4e..133fb6b79500 100644
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
@@ -542,4 +582,16 @@ tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
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
index 4a697acb4e85..24dbc603cc44 100644
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
index abf598c2b199..3216d5e2657f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3394,6 +3394,8 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->delivered_ce = 0;
 	tp->accecn_fail_mode = 0;
 	tcp_accecn_init_counters(tp);
+	tp->prev_ecnfield = 0;
+	tp->accecn_opt_tstamp = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5118,11 +5120,12 @@ static void __init tcp_struct_check(void)
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
index e898a76c485e..87154fd86167 100644
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
index c9f2c7bee00a..8eabff34017d 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3579,6 +3579,7 @@ static int __net_init tcp_sk_init(struct net *net)
 {
 	net->ipv4.sysctl_tcp_ecn = TCP_ECN_IN_ECN_OUT_NOECN;
 	net->ipv4.sysctl_tcp_ecn_option = TCP_ACCECN_OPTION_FULL;
+	net->ipv4.sysctl_tcp_ecn_option_beacon = TCP_ACCECN_OPTION_BEACON;
 	net->ipv4.sysctl_tcp_ecn_fallback = 1;
 
 	net->ipv4.sysctl_tcp_base_mss = TCP_BASE_MSS;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index f2f604a5a158..a5a814a655fd 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -472,6 +472,8 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
+		tp->prev_ecnfield = treq->syn_ect_rcv;
+		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters_payload(sk, skb);
 	} else {
 		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 34e5c83bbace..f897c2594954 100644
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


