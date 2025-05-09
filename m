Return-Path: <linux-kselftest+bounces-32791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDDBAB1EF6
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 23:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C7D5412FA
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 21:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0858B2638A2;
	Fri,  9 May 2025 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="DuKmQsx3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013071.outbound.protection.outlook.com [52.101.72.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39C125F984;
	Fri,  9 May 2025 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746825544; cv=fail; b=cVxfbDRhHOfMf7ovRaASgpD+QwX5TtaGMTW7P40Q0dWIi+DYtm4TyZ7FhJPmiYZjl8O+/2xHio3quoAqKJL8q3jXWfXdnpNIr3T1Z6A02Hsmqsns6xq9/GUeRe/bPAHdDtPcmj037MplQzZ5Z3Nf5OjnwAbPa6GUqwCYBh3AfqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746825544; c=relaxed/simple;
	bh=2s4ErdkZwpfJwntEtQJ6GKHeuuuKynFcu3LsQQbskTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K2+cyanLfSIzM4rYLgH/sPumVeONVHV/h/h4oEswY2zH+hMQLvC6pcWfVc9ZERvFMIYt2NUC7TbDvVL6UGcsPo+LEgxMFwIBWQT7bnMmLh0wKJR6NE+mqIdNcmRz3cjXVX1ZZKySxFJuJAykJne1Z+a/eY3lyUvQsZdjXRafyGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=DuKmQsx3; arc=fail smtp.client-ip=52.101.72.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7cn5cK7+nHyZfG8XmoY3yGX4p4Th1TkX13PsPy1le37PtCy7NBfWAUlizpv6jdEO6nlbVfOydGyoxMLLvtoiLQkIGD9ty8d8RSi8E1Akf7ryavfa42Ne6vilqSN6yBH/HBjMovgg+qhZ+aiN9mdVKr/OvWZuMQTc380R046MTbdOCwoEah3heSyd4tARyClhiNw7f/ADELlFQwcihgP7ass5OGR2dffcQADXgh7g3UawZAO9FfhS4vkXSeclZ8inxF8OrzJX9YuTysNx4xQQhk3PJ2qEz2lOLOmRaZXYC8cmgEH7D1UycAQvOLJkAFZzWQY+H9ZexXm38tQZ8EVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heUVnTMH0Ymar78rzmcCUa8l+NYfp8GHVFR0eaHxqa8=;
 b=C2gsfU3nzjSgz4C/KrYTUlp1ovoq5rgYJhpSAleKw32ITcU7yRH6bRjPGMJnPZqiNTm1Xt/p4HA1cOgIIcepr4AJS5uVMALv+qcrIHLfTpaFEPRw1IppWf4KTsOfrRELtmwoXT49wqdzgofji8QVqpVi6kyr1YIUPBNJwaf7casxxIn89r+ZTmvMJrlJacCKJLpCMaST9IytHDanv3QRx1TDdV4NnnbDohBRRWCIB5xQVXtKUDXUKMtDmUgg6Upcma46BnSX7gJ1TAHEfR3mJF4lC0A04o8JOaMXG9ZTdDX+arM9NOhjDjpWf4+oai2OkQK4Wa9rrd1j2x4jhCNMXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heUVnTMH0Ymar78rzmcCUa8l+NYfp8GHVFR0eaHxqa8=;
 b=DuKmQsx3j7gvjoyBSCjAP70jembxWDbynAdT+cHJqNMmRRzcPuN2dg0w5TZXd2skt+2ETXRVNWRuzVj+LyQP7XwKh7+WsfGut29vgaJYPNzdJEDKrtfhGLqY3+OTlsiTGl26HB2C+hilNly2X0T0wI2yoCgU9rl5eCXciagWrZ80GAaTwpap9JbF/FriAg6i0PRuOcpD9HuAeYOzrEp9HxDV3ZhFtXwo9wpaT8BeaMjdvU/3rB/zAZeuAY9PnazG37w9hDFaDuUVVwQDBWjjeII1QF/Cn/nKGhBeedqcjELrOUaiO7cSLl67SpaYb2Vt0V1oYjoJifqIoCXTR+rvxA==
Received: from DU2P250CA0024.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::29)
 by AS4PR07MB8756.eurprd07.prod.outlook.com (2603:10a6:20b:4f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 21:18:56 +0000
Received: from DU6PEPF0000B61E.eurprd02.prod.outlook.com
 (2603:10a6:10:231:cafe::d6) by DU2P250CA0024.outlook.office365.com
 (2603:10a6:10:231::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Fri,
 9 May 2025 21:18:56 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.240) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU6PEPF0000B61E.mail.protection.outlook.com (10.167.8.133) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Fri, 9 May 2025 21:18:55 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id AB6542009C;
	Sat, 10 May 2025 00:18:53 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org,
	dsahern@kernel.org,
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
Subject: [PATCH v6 net-next 10/15] tcp: accecn: AccECN option send control
Date: Fri,  9 May 2025 23:18:15 +0200
Message-Id: <20250509211820.36880-11-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509211820.36880-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250509211820.36880-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61E:EE_|AS4PR07MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d62441-d955-49f3-6e6b-08dd8f3f1ad4
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|7416014|82310400026|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UnlOZEM5VGRLV0VQQUloMFl0Yit5dkVPWGt1cHVGengxdXFxU1JwUDh3cG9J?=
 =?utf-8?B?ek5ySWF4R2swc2ZveHlISmw4SmRvWVVSQXBJeU1CYWZCenVsc1JpNFlCWXhQ?=
 =?utf-8?B?d3orZW5icjZRSnJFYkh3NlNNVExOd3Z3anVEaUdRd3d1M2ozdUo1TmxxT0Vy?=
 =?utf-8?B?Vy9zMWtzdm8zMnQ3WWFxVzdFUndhcUNZT2U3U0pZbjhweGxHc2hWWktuQlJ5?=
 =?utf-8?B?TlpTQlU2YXpPb1dXMnAzQy9UTE5XMTRsM2lPWVJmclRKU0NXMWs1WkNhOWVE?=
 =?utf-8?B?NSttZlloNDE5NnM5ekpuTHhqK2lCRXBDdkNLekMrbnVBOWVWd1lndlJSVHg3?=
 =?utf-8?B?Sit5R2dDU2lwNkF1a1RLSWhNVnVLWEY0cm1HSmIvQjFvSnFkTndCNkZPVFBt?=
 =?utf-8?B?N1psbW9zV1RoVmdIT3VMeW5ENkllNXBYK0Nzdjc5NTZlbXZab2pJV2dnTUFL?=
 =?utf-8?B?K3Q2c0oyQmhoWnZ2Smo3ZE1TSWhmbWI1Lzh5SEV4YittS3p2RUxpOTNJMVA5?=
 =?utf-8?B?VkRoT0RMSDZET2VTSm43Z0YzK1E3STFsK0J3cUVSNEkwVHdxcUFhSy9Yd3dh?=
 =?utf-8?B?MmxTQ01QaGdidWNhMDhSMis4Nyt3aXVsZnBtRDdsSVZXTU02QU84clhtSElx?=
 =?utf-8?B?VHlVR2lQbVcxZ0lFUlFEa2NNS2h3d0UzVGs0ejFwV0YvWnRXN2FuTGxtQVEr?=
 =?utf-8?B?ZkVNNlNIRXMxTWE3RSsrQzBtcWNqdkNucmY5b1hQV3lLTmRjenZvN1M2ZGhl?=
 =?utf-8?B?ME1LZFZDSFlxei9ZMkhIakhvdXJpVXFRME02VGtBN3VKWUhUbHhmbWl0bHV0?=
 =?utf-8?B?VjBUdE8wZVlJejdxcnhZQkdxbzJPU2ZhdGVlTUV3TFovaTBCSG1FUjhGeVg0?=
 =?utf-8?B?YkI1aXlIc2ttMVlhKzJDN3BkSGZVMEJockdrUEZUUGtyNGQvdnN0dS96YVZZ?=
 =?utf-8?B?RWd6OUs3bGQ1R21PUjFCeEZKc0hXdGZqMDMwb2kwYW9LcisybGkwNHVNRS9x?=
 =?utf-8?B?VVhFQUFwdzBrbUpLQkEvSytzNW9ZZWVaQmFXUS9pL0xsWmY5d1A0SUlXNTJ6?=
 =?utf-8?B?NUltOG1QOEY0NE93MkVCVmJVMGU0S0k0ZnVpbk8zeVh1djVXU0ZkZHZOSm1L?=
 =?utf-8?B?bDVJR2RzVDdLS0l4dE1OMW9GSmc0OEVMU1NibHkvQWNmMWNIRk90UkJHWndU?=
 =?utf-8?B?TXZLTkFyTnZ2Tk5pU0RnRWF5UHNCZ0wrcmw2cld2aS95bHp0WW5Kd2lYcjFp?=
 =?utf-8?B?dTNrSUFjQ2QrZitCUUdJa3VaYkwzTHFhMTBFaEFKQTVxd1RFL3lnVlpodVZZ?=
 =?utf-8?B?T2JVV3MxNmhnT1MvUDVBQUVPaS9ydTZtUnFNYStmZGVBRlRTRG9BUmdIVWtj?=
 =?utf-8?B?cmVjdVFJV2RqbWU2NXJjTzJNaGNmQjRlcmNYakhNdnlkVHJCUm1hSmlIQWJS?=
 =?utf-8?B?azNpMElVVXBBbm5pbm9VL0JkRnFVeFU1MllkWEVCMnJDMFFFN0k1QkxVdCt0?=
 =?utf-8?B?eEJyaXYweWlaYlFrS2xnZ1k5ZmVyM2NVZ000NzJsOGVhbmU3VnJoUy9XcURQ?=
 =?utf-8?B?U2xnSlA5Z3E3UUZFaXh0R0ZPelVzYXRrVkJuT05vWDZEQXlTV1lxa080M1JC?=
 =?utf-8?B?eUJsWWRTZXhBS09QZ3pBSXZkUVVELzVBRmwrdklGNzJLWkRpRFR0aStzc1Yv?=
 =?utf-8?B?ajd2SGhJUndyWEpXV25QbVp2MVp1ZkF1dFcvMXpQRWJwbGRoVDNVVlNmQUl4?=
 =?utf-8?B?TDROR0EyNDAxcE55cjlqTlBseERTdVFzaXRXUHJtSDBNVTdCaVhjSVBPbTN0?=
 =?utf-8?B?RUcyU2pIVTZNaU5LalQ0elA0OEtHUUdRWE5xeEcxYzREL3FXR2xBaWpydDRw?=
 =?utf-8?B?UElqYU1vVEltby8ycm1vQkY3SlZiWGZhYlNJd2lVL0FlSjNwRklrRjQrdC9z?=
 =?utf-8?B?UnFia2tBYXFGbFdESGhGbkp6T0NIVExOY0VXSjE2ZHVuZ1R6V2kycEt5VUpp?=
 =?utf-8?B?SFZjM3RMSU9SRFBUQ3RuUFllaVFvYjRQTUllUEFqdFlwNzRNd3NqYXFCMUpY?=
 =?utf-8?B?MDFiY3JyZm1jY1RVRHB0QTJDRGFEek1pOTFRUT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 21:18:55.1556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d62441-d955-49f3-6e6b-08dd8f3f1ad4
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8756

From: Ilpo Järvinen <ij@kernel.org>

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

Here are the pahole outcomes before and after this patch:

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    struct list_head           tsorted_sent_queue;   /*  2560    16 */

    [...]
    __cacheline_group_end__tcp_sock_write_tx[0];     /*  2585     0 */
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2585     0 */
    u8                         nonagle:4;            /*  2585: 0  1 */
    u8                         rate_app_limited:1;   /*  2585: 4  1 */
    /* XXX 3 bits hole, try to pack */

    /* Force alignment to the next boundary: */
    u8                         :0;
    u8                         received_ce_pending:4;/*  2586: 0  1 */
    u8                         unused2:4;            /*  2586: 4  1 */
    u8                         accecn_minlen:2;      /*  2587: 0  1 */
    u8                         est_ecnfield:2;       /*  2587: 2  1 */
    u8                         unused3:4;            /*  2587: 4  1 */

    [...]
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2692     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 174 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    u64                        tcp_wstamp_ns;        /*  2552     8 */
    u64                        accecn_opt_tstamp;    /*  2560     8 */

    [...]
    __cacheline_group_end__tcp_sock_write_tx[0];     /*  2593     0 */
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2593     0 */
    u8                         nonagle:4;            /*  2593: 0  1 */
    u8                         rate_app_limited:1;   /*  2593: 4  1 */
    /* XXX 3 bits hole, try to pack */

    /* Force alignment to the next boundary: */
    u8                         :0;
    u8                         received_ce_pending:4;/*  2594: 0  1 */
    u8                         unused2:4;            /*  2594: 4  1 */
    u8                         accecn_minlen:2;      /*  2595: 0  1 */
    u8                         est_ecnfield:2;       /*  2595: 2  1 */
    u8                         accecn_opt_demand:2;  /*  2595: 4  1 */
    u8                         prev_ecnfield:2;      /*  2595: 6  1 */

    [...]
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2700     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 176 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 .../networking/net_cachelines/tcp_sock.rst    |  3 ++
 include/linux/tcp.h                           |  4 ++-
 include/net/netns/ipv4.h                      |  1 +
 include/net/tcp.h                             |  4 +++
 net/ipv4/sysctl_net_ipv4.c                    |  9 +++++
 net/ipv4/tcp.c                                |  5 ++-
 net/ipv4/tcp_input.c                          | 36 ++++++++++++++++++-
 net/ipv4/tcp_ipv4.c                           |  1 +
 net/ipv4/tcp_minisocks.c                      |  2 ++
 net/ipv4/tcp_output.c                         | 31 ++++++++++++++--
 10 files changed, 90 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index c74f939f32cc..af76d4f9b33a 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -110,6 +110,9 @@ u8:2                          syn_ect_rcv             read_mostly         read_w
 u8:1                          wait_third_ack                              read_write
 u8:2                          accecn_minlen           write_mostly        read_write
 u8:2                          est_ecnfield                                read_write
+u8:2                          accecn_opt_demand       read_mostly         read_write
+u8:2                          prev_ecnfield                               read_write
+u64                           accecn_opt_tstamp       read_write
 u8:4                          accecn_fail_mode
 u32                           lost                                        read_mostly         tcp_ack
 u32                           app_limited             read_write          read_mostly         tcp_rate_check_app_limited,tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index afb1a5ac65bf..0740efaaef28 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -276,6 +276,7 @@ struct tcp_sock {
 	u32	mdev_us;	/* medium deviation			*/
 	u32	rtt_seq;	/* sequence number to update rttvar	*/
 	u64	tcp_wstamp_ns;	/* departure time for next sent data packet */
+	u64	accecn_opt_tstamp;	/* Last AccECN option sent timestamp */
 	struct list_head tsorted_sent_queue; /* time-sorted sent but un-SACKed skbs */
 	struct sk_buff *highest_sack;   /* skb just after the highest
 					 * skb with SACKed bit set
@@ -297,7 +298,8 @@ struct tcp_sock {
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
index 50ad6e33d52d..3419618a7891 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -91,6 +91,9 @@ void tcp_time_wait(struct sock *sk, int state, int timeo);
 /* Maximal number of window scale according to RFC1323 */
 #define TCP_MAX_WSCALE		14U
 
+/* Default sending frequency of accurate ECN option per RTT */
+#define TCP_ECN_OPTION_BEACON	3
+
 /* urg_data states */
 #define TCP_URG_VALID	0x0100
 #define TCP_URG_NOTYET	0x0200
@@ -1088,6 +1091,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 	__tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
 	tp->accecn_minlen = 0;
+	tp->accecn_opt_demand = 0;
 	tp->est_ecnfield = 0;
 }
 
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
index c2c533403c87..a1572a8adb35 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3368,6 +3368,8 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->wait_third_ack = 0;
 	tp->accecn_fail_mode = 0;
 	tcp_accecn_init_counters(tp);
+	tp->prev_ecnfield = 0;
+	tp->accecn_opt_tstamp = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5087,11 +5089,12 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, lsndtime);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, mdev_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, tcp_wstamp_ns);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, accecn_opt_tstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, rtt_seq);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, tsorted_sent_queue);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, highest_sack);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, ecn_flags);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_tx, 89);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_tx, 98);
 
 	/* TXRX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, pred_flags);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 3de8cc56c5cd..10c37a41b9a5 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -487,6 +487,7 @@ static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
 	default:
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
+		tp->accecn_opt_demand = 2;
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
@@ -507,6 +508,7 @@ static void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
 		} else {
 			tp->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
 					  INET_ECN_MASK;
+			tp->prev_ecnfield = tp->syn_ect_rcv;
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		}
 	}
@@ -6302,6 +6304,7 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
 	struct tcp_sock *tp = tcp_sk(sk);
+	bool ecn_edge;
 
 	if (!INET_ECN_is_not_ect(ecnfield)) {
 		u32 pcount = is_ce * max_t(u16, 1, skb_shinfo(skb)->gso_segs);
@@ -6315,9 +6318,36 @@ void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
 
 		if (payload_len > 0) {
 			u8 minlen = tcp_ecnfield_to_accecn_optfield(ecnfield);
+			u32 oldbytes = tp->received_ecn_bytes[ecnfield - 1];
+
 			tp->received_ecn_bytes[ecnfield - 1] += payload_len;
 			tp->accecn_minlen = max_t(u8, tp->accecn_minlen,
 						  minlen);
+
+			/* Demand AccECN option at least every 2^22 bytes to
+			 * avoid overflowing the ECN byte counters.
+			 */
+			if ((tp->received_ecn_bytes[ecnfield - 1] ^ oldbytes) &
+			    ~((1 << 22) - 1)) {
+				u8 opt_demand = max_t(u8, 1,
+						      tp->accecn_opt_demand);
+
+				tp->accecn_opt_demand = opt_demand;
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
@@ -6450,8 +6480,12 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	 * RFC 5961 4.2 : Send a challenge ack
 	 */
 	if (th->syn) {
-		if (tcp_ecn_mode_accecn(tp))
+		if (tcp_ecn_mode_accecn(tp)) {
+			u8 opt_demand = max_t(u8, 1, tp->accecn_opt_demand);
+
 			accecn_reflector = true;
+			tp->accecn_opt_demand = opt_demand;
+		}
 		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
 		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
 		    TCP_SKB_CB(skb)->seq + 1 == tp->rcv_nxt &&
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index cc3049bb9d02..9e8eb0d639de 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3451,6 +3451,7 @@ static int __net_init tcp_sk_init(struct net *net)
 {
 	net->ipv4.sysctl_tcp_ecn = TCP_ECN_IN_ECN_OUT_NOECN;
 	net->ipv4.sysctl_tcp_ecn_option = TCP_ECN_OPTION_FULL;
+	net->ipv4.sysctl_tcp_ecn_option_beacon = TCP_ECN_OPTION_BEACON;
 	net->ipv4.sysctl_tcp_ecn_fallback = 1;
 
 	net->ipv4.sysctl_tcp_base_mss = TCP_BASE_MSS;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 3f8225bae49f..e0f2bd2cee9e 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -501,6 +501,8 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
+		tp->prev_ecnfield = treq->syn_ect_rcv;
+		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
 	} else {
 		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index a36de6c539da..0201089623e2 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -806,8 +806,12 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
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
@@ -984,6 +988,18 @@ static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
 	return size;
 }
 
+static bool tcp_accecn_option_beacon_check(const struct sock *sk)
+{
+	const struct tcp_sock *tp = tcp_sk(sk);
+
+	if (!sock_net(sk)->ipv4.sysctl_tcp_ecn_option_beacon)
+		return false;
+
+	return tcp_stamp_us_delta(tp->tcp_mstamp, tp->accecn_opt_tstamp) *
+	       sock_net(sk)->ipv4.sysctl_tcp_ecn_option_beacon >=
+	       (tp->srtt_us >> 3);
+}
+
 /* Compute TCP options for SYN packets. This is not the final
  * network wire format yet.
  */
@@ -1236,12 +1252,16 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	}
 
 	if (tcp_ecn_mode_accecn(tp) &&
-	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option) {
+	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
+	    (sock_net(sk)->ipv4.sysctl_tcp_ecn_option >= TCP_ECN_OPTION_FULL ||
+	     tp->accecn_opt_demand ||
+	     tcp_accecn_option_beacon_check(sk))) {
 		int saving = opts->num_sack_blocks > 0 ? 2 : 0;
 		int remaining = MAX_TCP_OPTION_SPACE - size;
 
 		opts->ecn_bytes = tp->received_ecn_bytes;
-		size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
+		size += tcp_options_fit_accecn(opts,
+					       tp->accecn_minlen,
 					       remaining,
 					       saving);
 	}
@@ -2959,6 +2979,11 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
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


