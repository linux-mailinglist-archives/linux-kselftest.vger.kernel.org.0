Return-Path: <linux-kselftest+bounces-36385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 971C6AF6997
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 07:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2674A8492
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 05:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE8829A9CB;
	Thu,  3 Jul 2025 05:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Qj6dec3b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010031.outbound.protection.outlook.com [52.101.69.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE14928FA85;
	Thu,  3 Jul 2025 05:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751519947; cv=fail; b=hrq67eDSH2sbWmTagBfcjYmUY51N7So81oPI5j/wRgefj/jQZvsJiAbrhzgRUPVKUOgPY20UIss9+l/5MKwDfNPz9pZ7cu8+Np0BJZRfp9H1wjCle6/Ia8IuguEH4L80b8TkG2IngIV4PbvteitG92WMGwBLAYB7Igy6ZByWwlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751519947; c=relaxed/simple;
	bh=MjWTZBZrhczo8yYTMJrqcxUC/ID6JCPaQb83hjNuyCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ksMtsVTvzlGARkJkq0qWi7vfPYJK926vrbq6eL8GlafRIlRN7C4ccO8N1srwtJu1bMg8PB8ETPVUoF8xMzTZ32eNmds0Za2rwV5QKbwP4V+qZd7eebMMqXefvqSCY6QFbJHHOYgwkpLISGvxhJ5WTSWRH9RbzQV7ZZIGpLTrtOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Qj6dec3b; arc=fail smtp.client-ip=52.101.69.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tO72x6UtBVZHetSIYBMo5e272ixN72eRnwO/fALi7EZXEropY7+UJOs+g2PzsZlLDlWN4sDpNIzLIZ58cXfo0+eyI8LvGEJxzFjIPYx7RfSt+9DQUhcl3iT1/IRIyzEaFXVHIU1YnPliUwIZJMPh9H8YPtJ4ylaoab91wO1WJEmokupNDIS0iSZSXCDAnVUl7+prPxuIthmdFOoJi98hK6WmOKHx3Rgvpi0T5KAeo02goq7chH417AxN236JOcj2RXECzTyu+2cGDYL6splAxTpXMFRbmSO5c2C5GVP/OBoOdUHFl7ywu++i92MqkorynhQ0yEI6mPLBoYOzlTQmEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48CMAxXDDlhaxY828e9lm2QHHuUNIaPyAUCQfo+7f78=;
 b=Ujg+8RqXktHgRj97CmszHi0DtMlhXVhmXG/0MxUdxBaGTxaWRf+xVqWaKHRr9JLsUqqpa44AusfgBaE3sw3jP+iPrdx/F7rzviVT3F+agR7Xk2T3l5yhYIoFZIf7deYGfVNaJX5zD6fGk2b0m2JB3P/GtsXoEhez7Eeu20Eb1u3MeffGn4+z8GMMlIEi5PGQTrISTc+ypD9i0u+LpauQYcQWkiAPFNv8/AAM/O9U7Z2tFMNr9AFMimKROZmaoWIP4ubgZ4D8njUlO3Tp/W8eoBH72Lo0hNiGufqy99vuPu/jYv8iqIb34jtqb7GUSFPQVLIvjDPCx0VFktrMCC3M1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48CMAxXDDlhaxY828e9lm2QHHuUNIaPyAUCQfo+7f78=;
 b=Qj6dec3b4gT4dEJRnG8xcpFF9vQ8vfsKypn3sJSy/xaj9QzmJa1k7P1YWYcb/Viebgl1pQDGchTajkTdLLAY6QAJb73fcT9WDdVsiXxLCIxLjf3IezDTMelCqKjYCS8eIz56JZPqhSkmHJqRJGZQbel8q4LA/7BWHWL+6ipahzsnpcdQPyowSE62+7AwIaEzGL0d1u6inNpvA4oj5vZ15Nnz8dY0HqZSpRLDMppncYGBCkYe1Hq0EboQztvwV+tbmqquOenU0BEfn0Z33wFl5Nl/aFYncZyt38cQyQ8AnQmjKllYVMYhN8jV+WISoj13fAzKJcA0QtYRJpEuHrmxqQ==
Received: from AM0PR04CA0126.eurprd04.prod.outlook.com (2603:10a6:208:55::31)
 by AS5PR07MB10132.eurprd07.prod.outlook.com (2603:10a6:20b:676::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 05:19:00 +0000
Received: from AM2PEPF0001C70A.eurprd05.prod.outlook.com
 (2603:10a6:208:55:cafe::9b) by AM0PR04CA0126.outlook.office365.com
 (2603:10a6:208:55::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Thu,
 3 Jul 2025 05:19:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM2PEPF0001C70A.mail.protection.outlook.com (10.167.16.198) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Thu, 3 Jul 2025 05:19:00 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id A90F2200BF;
	Thu,  3 Jul 2025 08:18:58 +0300 (EEST)
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
Subject: [PATCH v11 net-next 12/15] tcp: accecn: AccECN option send control
Date: Thu,  3 Jul 2025 07:17:25 +0200
Message-Id: <20250703051728.37431-13-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703051728.37431-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250703051728.37431-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70A:EE_|AS5PR07MB10132:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cac2a8b-3c1c-40f3-e403-08ddb9f11e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NG4xRFVyNTB5bVFSNlAxQWFJeFB6TlhBQXZmMWRscVdjZTNGa3dKb2NkZTZh?=
 =?utf-8?B?NEl3QzVmUlZUUDYrYUFpYWFNQmtvWUo2R0tnVEplWjUvTng4SUUxZHVBQWdq?=
 =?utf-8?B?SzZvMmxPZGVMOTBGU1FnTUQ5ajF4QUt0emxTeWpQSzNWcjNjMWxrc2VoakZO?=
 =?utf-8?B?SktIa1lKYUI1dDF3eHpvUTQvY0h5L2FVVFJ2VmI5MG12OTNYbmZLcFViMGZi?=
 =?utf-8?B?dHNSK3owTytLZC9NVk5kTGI5dzV0QjdiM21IaGR0RHdaNWg5TmhGK0VRa1po?=
 =?utf-8?B?dGE3QzF6NTQxeXVPU241Y29kSDU0eWZiR09NcUFjT3VYb3ArcW5GZVRyTzZY?=
 =?utf-8?B?d3dKeTJRU1BKZGpsTWY1QUloeEdsNm1EbS9QSjZPMkVCQ2R5TWJZc0lwdnc1?=
 =?utf-8?B?dzgwRGMvby9Ia2k1VWlSclhSK1ZOOHR5bDl1R3cyZHFtSW1ZY3hXamlmUUFp?=
 =?utf-8?B?eXdDeHp3YXNMTzBNaHMwS3dMVEpJd2VteVhQQ3dSYXhjcEVRT1NRZ2RtU3d4?=
 =?utf-8?B?dnpDN1JpQUNaNW00dlBZcVJrZERRcVcvSVVRZDA3Q1FHckQzZU91djFQbVBT?=
 =?utf-8?B?b1NndkxrUXUyMkFwR3lqeFVQWjRRWDRFRXFJTHhFUzJiK0U2MGwzZ0Z5KzhS?=
 =?utf-8?B?RytvY3N2aGJPb01iT2gzSUsyK1BWcjYvYWNxNzB0a0hmUlE0Y1c1K1VkQlFj?=
 =?utf-8?B?ZnRjYjVwY016bVVzRThPMFVNZkFDR1FpT0RCSUxkNjlRbjlLRzQwT0tkNTBF?=
 =?utf-8?B?Uk9lenc1dTkvRnUrbitUYVZpRlQ5bXRIUjZEU25ZQjluYWRnTFZyMmZtU21l?=
 =?utf-8?B?NnIrQ1lOOUVHSktJRHJEZzJPMkVKUWZ4S0UzSnlkYUlDUEpqOEFCUFdlKy8y?=
 =?utf-8?B?ZlI4Tjk5MjlRb3dNQWUwbi9DTmRsTnlXYXROblA0Q2gvT0xnUFRwVk9XaXgw?=
 =?utf-8?B?UVBIaGFEZFZqeTA4VGpBNDBkK3Yzbmg0VTFKSUZ0UDd2RmovQkFSY291L3Ft?=
 =?utf-8?B?S2xKOGU1RjVpdkFLWDlXakdJQmlET2ZabnZFRWp5bEFSeS80M1M1SDJ5OTZm?=
 =?utf-8?B?eEhhNUZxUm90RC9UcG9LRVUrZytpTkRiMC9QcmM0YVdTVDFiK3lQazV2TVRP?=
 =?utf-8?B?TTJTZ3ZxT1pGQUsxQitpdytyS3BnSi94SC9xbWxjMFNLZEhMMVNRYlczV0Zt?=
 =?utf-8?B?QWt4TkxLdXJQMmg2cFBISnNiOHRNMWdLd1hYUFFIYVNpTlZuaEdjTEtlbFM0?=
 =?utf-8?B?M0ZVN1B4QzdiTkJKRUtucXc3cHhYdUwwUzBIVXFvSUVEend1U1ZmUlFyOTli?=
 =?utf-8?B?RGZ2ZWY3RUU4TkM3QzlCbkNzdDB4K3paRjRkWmxBMU8xWHBBREJwakxPZzRo?=
 =?utf-8?B?OWRqbjVrTllIcjRQUGNISzhBbGtReDY5d2M2QTJPS2xZTjJBVktIMUEyNzVB?=
 =?utf-8?B?VTB6OC9yOXFxUWtKdWg3Z1E2Y09TSzZjdHBWRlplSGEwRzJ2K3pqZ0xFSDhT?=
 =?utf-8?B?UzZjaU1hVEl5L1BPR0h1K05PNk9FS2VpU0pobEQ1V296T3g1MzRxaDEvWklk?=
 =?utf-8?B?RzNYWElZdzQxeWs1Q1liWnNMSVh5NWlTNENTZlJsa3ROQ0ZkOEFCc24xQVhJ?=
 =?utf-8?B?UFJTUWFDbjJoUUpwVlcrcnVkb1EyQnZVWVZYVUxQV1BCQXVETUFlMzRTVUNJ?=
 =?utf-8?B?YmtpU1lEM21PR0tDdjZBV1Q2cHBncUdQOXRSZEpDYmVidWZ3UE8zRmFWdjRJ?=
 =?utf-8?B?clE5WWtwa1VPUkpWeGZuZFUyV1BIYXMwdTArendCeE0vdEZkek5Ra3U1Vk4x?=
 =?utf-8?B?U3VIRDF4ZUdiUjRqSHJNYUZxZllkZ2RjZm9lamRjRjVkVU5IWC9nK0RVSUk1?=
 =?utf-8?B?YVI3VWhCZVVqbG4vekRtbHlrRjZ1TjBpS1YxOThqb1hVWCs2UnAwRnZxbjEv?=
 =?utf-8?B?TUlEQnpXZk5LMjlmRXNtVm5BelI1YTNRUk1lSVZZT2RnUHNIVVh5VlVIVlpR?=
 =?utf-8?B?eXd0cmhzWUkxZmMyVXoveHNsby9DNVMvMno3RG1iY0Z6bGVhY2FPbzYvQThN?=
 =?utf-8?B?SS8ySVZXMkQ1dkdOeGsrNHhEeGZUK1FXU3ljUT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 05:19:00.1276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cac2a8b-3c1c-40f3-e403-08ddb9f11e3f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB10132

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
    u64                        tcp_wstamp_ns;        /*  2552     8 */
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
    struct list_head           tsorted_sent_queue;   /*  2568    16 */

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

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Co-developed-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>

---
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
 include/net/tcp_ecn.h                         | 50 +++++++++++++++++++
 net/ipv4/sysctl_net_ipv4.c                    |  9 ++++
 net/ipv4/tcp.c                                |  5 +-
 net/ipv4/tcp_input.c                          |  4 +-
 net/ipv4/tcp_ipv4.c                           |  1 +
 net/ipv4/tcp_minisocks.c                      |  2 +
 net/ipv4/tcp_output.c                         | 16 +++++-
 12 files changed, 99 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 9b63466bcbf5..5698dab3a7b0 100644
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
index ed6af7d0110c..88c668f9c68b 100644
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
index 0008b8190ea0..2c0a2db6e6dd 100644
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
index 4e8d6a0a4171..4516b4910fae 100644
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
index 945daecff082..667f4df961b3 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -181,6 +181,16 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
 	}
 }
 
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
@@ -256,6 +266,7 @@ static inline void tcp_ecn_received_counters(struct sock *sk,
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
 	struct tcp_sock *tp = tcp_sk(sk);
+	bool ecn_edge;
 
 	if (!INET_ECN_is_not_ect(ecnfield)) {
 		u32 pcount = is_ce * max_t(u16, 1, skb_shinfo(skb)->gso_segs);
@@ -274,9 +285,33 @@ static inline void tcp_ecn_received_counters(struct sock *sk,
 
 		if (len > 0) {
 			u8 minlen = tcp_ecnfield_to_accecn_optfield(ecnfield);
+			u32 oldbytes = tp->received_ecn_bytes[ecnfield - 1];
+
 			tp->received_ecn_bytes[ecnfield - 1] += len;
 			tp->accecn_minlen = max_t(u8, tp->accecn_minlen,
 						  minlen);
+
+			/* Demand AccECN option at least every 2^22 bytes to
+			 * avoid overflowing the ECN byte counters.
+			 */
+			if ((tp->received_ecn_bytes[ecnfield - 1] ^ oldbytes) &
+			    ~((1 << 22) - 1)) {
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
@@ -351,6 +386,7 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
 	__tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
 	tp->accecn_minlen = 0;
+	tp->accecn_opt_demand = 0;
 	tp->est_ecnfield = 0;
 }
 
@@ -433,6 +469,7 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
 	default:
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
+		tp->accecn_opt_demand = 2;
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
@@ -453,6 +490,7 @@ static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
 		} else {
 			tp->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
 					  INET_ECN_MASK;
+			tp->prev_ecnfield = tp->syn_ect_rcv;
 			tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		}
 	}
@@ -551,4 +589,16 @@ tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
 		th->ece = 1;
 }
 
+static inline bool tcp_accecn_option_beacon_check(const struct sock *sk)
+{
+	const struct tcp_sock *tp = tcp_sk(sk);
+
+	if (!READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option_beacon))
+		return false;
+
+	return tcp_stamp_us_delta(tp->tcp_mstamp, tp->accecn_opt_tstamp) *
+	       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option_beacon) >=
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
index a2b83acf5b94..7bfe763da9f4 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3395,6 +3395,8 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->wait_third_ack = 0;
 	tp->accecn_fail_mode = 0;
 	tcp_accecn_init_counters(tp);
+	tp->prev_ecnfield = 0;
+	tp->accecn_opt_tstamp = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5113,11 +5115,12 @@ static void __init tcp_struct_check(void)
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
index 107c20ae0f5b..103260fc9130 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6090,8 +6090,10 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
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
index 1da7c5e4da32..c32a965e8cd6 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3452,6 +3452,7 @@ static int __net_init tcp_sk_init(struct net *net)
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
index 2169fd28594e..65ef1c3c97c2 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -708,8 +708,12 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
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
@@ -1151,7 +1155,10 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	}
 
 	if (tcp_ecn_mode_accecn(tp) &&
-	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option)) {
+	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
+	    (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) >= TCP_ACCECN_OPTION_FULL ||
+	     tp->accecn_opt_demand ||
+	     tcp_accecn_option_beacon_check(sk))) {
 		opts->use_synack_ecn_bytes = 0;
 		size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
 					       MAX_TCP_OPTION_SPACE - size);
@@ -2864,6 +2871,11 @@ static bool tcp_write_xmit(struct sock *sk, unsigned int mss_now, int nonagle,
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


