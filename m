Return-Path: <linux-kselftest+bounces-34562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E35AD37AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363E1163B7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 12:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77782BD009;
	Tue, 10 Jun 2025 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="bBQy0N3m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013050.outbound.protection.outlook.com [40.107.159.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95690299933;
	Tue, 10 Jun 2025 12:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560002; cv=fail; b=MuY3VpmH9Qs2xgu2v0JoQeiRx2QqF9Z056JI8KjutuuIyu8iEDtnmF3gUJ9di30SqLywhByZn0lfT6ee7pxk+F2NJQOzF0YGEkiSiKj2jcdfljrTHi4wBmkHwQzu60h+k2kuiV/d20rfhDv/xXI5m1s/enCxfjXlfdTDXmXD3hM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560002; c=relaxed/simple;
	bh=WPKvbTy0FFrfDqRthK5WQRF+GyWK6UWRRfudiBC353U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cbguRNkDvFzadYmCYUIKuO/8RejPFURS3KHO7oCJQK1NVAegv9mx165qmgJBLxg2J3M6bGyj2eK0t4C/mmIkLh7GZF6e4lLF0cDBmDehEhfh8arpm0HcKU0csVpz+z6dQBrVpqSZkGQ23rJlx50zFhmuyhCj0sCxNfzP0OYo2gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=bBQy0N3m; arc=fail smtp.client-ip=40.107.159.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJZpYTntt+Lk1XYU8SxLxGvQkDLZZO4vwSA0AoJo0Yg/cNMPsylU8/bnFvRiLT6AhamKjvLSbv1O5pCe8FgkNBiLMwsYH+0phnNcy7uOCJ7AV5Ldc0MPfgxDnp4BKiC+q7jM8RiLcOl7kE4OgsjFMcHCkJhFlUMPgO7QKetKsxBuqO7l9/J23zSws+sk2BzUE1/907Q7l2mkR0+2J02PPhDO9O2R1RSdEwOqbt11sHl8wVg6ZlBrlUIKmrmuDQNtr0rsHQuYJW7QjVTlD8rjLSGiCne6bbBqeVHRox12l49rS5VxPnGctnStqsLrY/OPn5/V38jdqx3T/s8SbuzLCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hq2bZy9tHtfOyGlz4Jr/PV7ViPkHgfOvujmUYLT+4Is=;
 b=pDzh9ZMEBSDLf8F9FlKpytrQCMcun5lP4DyubN8aDTNi2PUki8/keI8EOGrHQ8rFrrW9zDuDsqqBNe+57MJ2pCaE77PY+Cs4d1UP0HNh6vyGxPNnlhW59HlKDFnzjkpvrrbYVadcignSx5JhrRT4fW2rUvVsKCRL8cYKiHraVb/cCdh6vWLGVVOrAORYgYUBypgNwwvJSi7cP2xW9Uu9DD2yxk63+jpkOZdUWkOyJ61tcM34virShzxLkaxYhxte5TzzDMPUiMHuXdyVtLK2TetmqvRJXTcrmO+ZwnhZG3FxRCbfQ/d7xdC4d5aT5a4YnQAPI500bD0N3m2p1zRkwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hq2bZy9tHtfOyGlz4Jr/PV7ViPkHgfOvujmUYLT+4Is=;
 b=bBQy0N3m5lylrFdYhMRpmMaohNoEO1kfPADHh5rf5oQ+fYm6uQcQ+hlZJ4YcjxuY8ijFNzopUWLDVTcSrRB2TwtkGi6GdVmqBwpXwqoxoFGBX1lTQPQdUNMRdAwhkBmaMpZ1UapOLj4E2cwrM1pG4JNR2ARv2NiHfxyuL0SfmpZnBrKl51ZIvt/QWfNdx3WgCOVvDLoEX1lqWWMRsGPfIj0F0ARD5BXJBlA5jhtPkkz4VvVpgD4Ydj631kCi1RDnXmlNNZYzZ6SJUqePmg6W1u0yFB7q0SSuHQiKxiq8TiHz4rdLMyHUDd2T8GpAWh0g+ODE48xg2BfmXhim6WinyQ==
Received: from AS9PR04CA0073.eurprd04.prod.outlook.com (2603:10a6:20b:48b::27)
 by AS8PR07MB7143.eurprd07.prod.outlook.com (2603:10a6:20b:255::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Tue, 10 Jun
 2025 12:53:17 +0000
Received: from AMS1EPF00000045.eurprd04.prod.outlook.com
 (2603:10a6:20b:48b:cafe::61) by AS9PR04CA0073.outlook.office365.com
 (2603:10a6:20b:48b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.17 via Frontend Transport; Tue,
 10 Jun 2025 12:53:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS1EPF00000045.mail.protection.outlook.com (10.167.16.42) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Tue, 10 Jun 2025 12:53:17 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 8CE3B2004A;
	Tue, 10 Jun 2025 15:53:15 +0300 (EEST)
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
Subject: [PATCH v8 net-next 00/15] AccECN protocol patch series
Date: Tue, 10 Jun 2025 14:52:59 +0200
Message-Id: <20250610125314.18557-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000045:EE_|AS8PR07MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: 097eb386-e58d-468b-ea6d-08dda81dc51e
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aW1Mdk9jZG0wRXZwNjZaM05XSTFsYVNpY1QrbWJxY1hjdFQ5OEViWmV5UkJZ?=
 =?utf-8?B?MFNSbUdHaG9xdlBreUtYeHpIeTcrZFZBQVpoUGhIY3RkR0tOYysvRTRYTkg4?=
 =?utf-8?B?d3hQSnNKWWNGaVhiTkZxS2RyWGJNSEVlWC82QXMxVXJ2SU5jdWZtcThXVWFB?=
 =?utf-8?B?TExqcHE1Umd0dHlhQURmYlNSV0NxTzMxdzdvdC95a0lycGxCaHF0SXo3N2ow?=
 =?utf-8?B?TDRwUkI1RkRsZXRDMEVrY3NsSmZNdUU2UnoyQlJob1hDR0pzVXQzYjMzd0o4?=
 =?utf-8?B?amxKNHpnVGFUaC9Sb0YxYmFla1FybSt2Ti9yanAyTW9uYWhHaWJJamxxOFpU?=
 =?utf-8?B?RWlvL3JPblFVNXRTSzQyeUhoZlZCRkEvaGdlZVkrbjV6R25yUEQrS0RwZ0Mx?=
 =?utf-8?B?eDNVV1FKbnUvaWpEZTFLRjc0NDFxMGRkS2dZYXFreHQ2WlhLb0VxRDJCMkdy?=
 =?utf-8?B?SmJuODdpNnRoNDNZWUEweW5WLzFkZW9nYzhDaU53ZWxVdzhpMWxWWVhyNnUw?=
 =?utf-8?B?SnIzdHR6TWx1WTNaSHBSck5wcm8wMWREeTNXTncrb0s0ZWlTVGpBWTFVQm1H?=
 =?utf-8?B?UGJhREp4dEhkanFuTG54KzJQaWVYVmFOY01JTnUwUGJYYzBraWtjSktxM1Bh?=
 =?utf-8?B?ZEo2eVp4UXNwSFYwLzZtQUtZTmZVRzNjaWUzUjdPQmhYZXFYMFVwTXVqNzR0?=
 =?utf-8?B?Uy8rYVJTVnJML2Rma25NaEdtZlpEWVdKbHRxSTJZMStYcGljYUdwYlo0TkJ3?=
 =?utf-8?B?WWptS0hNY1J2OHA0QkF6WUZuY2ZYV3VVbnVXamhsSWFRYXh1d3QvVVpLTjNX?=
 =?utf-8?B?V2JINiszNVlLUzJVUzVsK3d4VlFOczl3U2pKWENjd0hVSmdGS0NZWWRyaUlm?=
 =?utf-8?B?THJwazMwblh5eFlRVUhaZkkvUE5VYmlETlJaL2pxSUJWM1lQeXU1VjJPcUo2?=
 =?utf-8?B?N2lxU093KzV1R2NxMmJHbDZxSnJDTHhSUXIwbmtUUUV1ZDk0ZThxV1NmdlE5?=
 =?utf-8?B?QjBiM0NZeURyZitIeHhsc093S1I2b0M0RE1NdzdaZzUrQnVMRjNQRUlsYWFL?=
 =?utf-8?B?dnlUUVIyUGpFZEtSVmtSM21mQ3FUWXM0cyt4WTU1M0t6U093NUZUZ3JpYmN6?=
 =?utf-8?B?VXVLdEZXd0JCMWlrYkl4cmdtTFJ6L1lwWDdKT2s3U3VXMFhsZmFtOUtyM28y?=
 =?utf-8?B?aXNzN0Q1NmJmRGJpYTZROHFsUGE2SkpvSTQzc1RweG44YWFETXVXK01RRVlG?=
 =?utf-8?B?ZUlhL1FPckZrVGs1S3VxRzZ3RitsRTlRTEdPdFFOWWNBV0dXQ0pLQUsxUHk0?=
 =?utf-8?B?c2Fja1V4M3dscGhxL2lGMG1nckF5NVR3YmMvYjJGNE1sL3J4d3gwRnZsZ3ZC?=
 =?utf-8?B?TWZCWkpxV3JWVWdaREx2SGEzcXJ0ZHBFMmpVNzExc2lQS3hwLzZUbWNJNXJE?=
 =?utf-8?B?M09nQWtNTUhTalVWYUE4bzB0K2UyK2NTbUprQmt0WU5ic2NvTVBSMFZlN2xJ?=
 =?utf-8?B?ZDEvbDl6d3Z2eFQzVldKK1ZXL1RZSWhOT2JRSiszZEgzMC9IZWdVdC9CRTZo?=
 =?utf-8?B?OHoxc3dlanRTUGZSRzdNL1dQSWNOWnhzV3VyTVliYU9mb2JnUEsvOERpYXl2?=
 =?utf-8?B?TFNMclk5SDI5VFNld1M2KzhUa29qdi83NTNKTjRBUWk3bFI4cFk1aElQNWt6?=
 =?utf-8?B?ZS81MndMVGhFWTJYV1I0OFhwSFpyYUlGZGJQeEZ0NkJGd0U3RTBFeStzVG03?=
 =?utf-8?B?aDk0NjV0NWl0cnJpMytSKzV3KzVoZ2ZEUDVXdThGci9CZVozWHEvbURndTFK?=
 =?utf-8?B?b1FSK2IxNFhQeS93QzJYU0FiOGx2NHh6dSttVUszRWVkakxnVXdHWDVrMHVw?=
 =?utf-8?B?S3pBMUhOem1UenV1c0pCRXNlbjlxaUo3S1NOaEZlc3RXenNwcEFpNnBvaFBY?=
 =?utf-8?B?UEYvQzlKYnd2UkVxN29ISEdiSEFGa0pMb3RhUithaU9LS0NUY1U1M0JGcWFR?=
 =?utf-8?B?aWxxMW1EVmx3MitNQnB1UXRCSkRCV2lHNnphUTdwc0tlNmRMWXpoQW42aG15?=
 =?utf-8?B?TEZOcWgzYlNBVFU5dTBxYm91ZlFKSXVqTXVwUT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 12:53:17.0419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 097eb386-e58d-468b-ea6d-08dda81dc51e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7143

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the v8 AccECN protocol patch series, which covers the core
functionality of Accurate ECN, AccECN negotiation, AccECN TCP options,
and AccECN failure handling. The Accurate ECN draft can be found in
https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28

This patch series is part of the full AccECN patch series, which is available at
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

v8 (10-Jun-2025)
- Add new helper function tcp_ecn_received_counters_payload() in #6 (Paolo Abeni <pabeni@redhat.com>)
- Set opts->num_sack_blocks=0 to avoid potential undefined value in #8 (Paolo Abeni <pabeni@redhat.com>)
- Reset leftover_size to 2 once leftover_bytes is used in #9 (Paolo Abeni <pabeni@redhat.com>)
- Add new helper function tcp_accecn_opt_demand_min() in #10 (Paolo Abeni <pabeni@redhat.com>)
- Add new helper function tcp_accecn_saw_opt_fail_recv() in #11 (Paolo Abeni <pabeni@redhat.com>)
- Update tcp_options_fit_accecn() to avoid using recursion in #14 (Paolo Abeni <pabeni@redhat.com>)

v7 (14-May-2025)
- Modify group sizes of tcp_sock_write_txrx and tcp_sock_write_rx in #3 based on pahole results (Paolo Abeni <pabeni@redhat.com>)
- Fix the issue in #4 and #5 where the RFC3168 ECN behavior in tcp_ecn_send() is changed (Paolo Abeni <pabeni@redhat.com>)
- Modify group size of tcp_sock_write_txrx in #4 and #6 based on pahole results (Paolo Abeni <pabeni@redhat.com>)
- Update commit message for #9 to explain the increase in tcp_sock_write_rx group size
- Modify group size of tcp_sock_write_tx in #10 based on pahole results

v6 (09-May-2025)
- Add #3 to utilize exisintg holes of tcp_sock_write_txrx group for later patches (#4, #9, #10) with new u8 members (Paolo Abeni <pabeni@redhat.com>)
- Add pahole outcomes before and after commit in #4, #5, #6, #9, #10, #15 (Paolo Abeni <pabeni@redhat.com>)
- Define new helper function tcp_send_ack_reflect_ect() for sending ACK with reflected ECT in #5 (Paolo Abeni <pabeni@redhat.com>)
- Add comments for function tcp_ecn_rcv_synack() in #5 (Paolo Abeni <pabeni@redhat.com>)
- Add enum/define to be used by sysctl_tcp_ecn in #5, sysctl_tcp_ecn_option in #9, and sysctl_tcp_ecn_option_beacon in #10 (Paolo Abeni <pabeni@redhat.com>)
- Move accecn_fail_mode and saw_accecn_opt in #5 and #11 to use exisintg holes of tcp_sock (Paolo Abeni <pabeni@redhat.com>)
- Change data type of new members of tcp_request_sock and move them to the end of struct in #5 and #11 (Paolo Abeni <pabeni@redhat.com>)
- Move new members of tcp_info to the end of struct in #6 (Paolo Abeni <pabeni@redhat.com>)
- Merge previous #7 into #9 (Paolo Abeni <pabeni@redhat.com>)
- Mask ecnfield with INET_ECN_MASK to remove WARN_ONCE in #9 (Paolo Abeni <pabeni@redhat.com>)
- Reduce the indentation levels for reabability in #9 and #10 (Paolo Abeni <pabeni@redhat.com>)
- Move delivered_ecn_bytes to the RX group in #9, accecn_opt_tstamp to the TX group in #10, pkts_acked_ewma to the RX group in #15 (Paolo Abeni <pabeni@redhat.com>)
- Add changes in Documentation/networking/net_cachelines/tcp_sock.rst for new tcp_sock members in #3, #5, #6, #9, #10, #15

v5 (22-Apr-2025)
- Further fix for 32-bit ARM alignment in tcp.c (Simon Horman <horms@kernel.org>)

v4 (18-Apr-2025)
- Fix 32-bit ARM assertion for alignment requirement (Simon Horman <horms@kernel.org>)

v3 (14-Apr-2025)
- Fix patch apply issue in v2 (Jakub Kicinski <kuba@kernel.org>)

v2 (18-Mar-2025)
- Add one missing patch from the previous AccECN protocol preparation patch series to this patch series.

Best regards,
Chia-Yu

Chia-Yu Chang (3):
  tcp: reorganize tcp_sock_write_txrx group for variables later
  tcp: accecn: AccECN option failure handling
  tcp: accecn: try to fit AccECN option with SACK

Ilpo Järvinen (12):
  tcp: reorganize SYN ECN code
  tcp: fast path functions later
  tcp: AccECN core
  tcp: accecn: AccECN negotiation
  tcp: accecn: add AccECN rx byte counters
  tcp: accecn: AccECN needs to know delivered bytes
  tcp: sack option handling improvements
  tcp: accecn: AccECN option
  tcp: accecn: AccECN option send control
  tcp: accecn: AccECN option ceb/cep heuristic
  tcp: accecn: AccECN ACE field multi-wrap heuristic
  tcp: try to avoid safer when ACKs are thinned

 .../networking/net_cachelines/tcp_sock.rst    |  14 +
 include/linux/tcp.h                           |  34 +-
 include/net/netns/ipv4.h                      |   2 +
 include/net/tcp.h                             | 225 ++++++-
 include/uapi/linux/tcp.h                      |   7 +
 net/ipv4/syncookies.c                         |   3 +
 net/ipv4/sysctl_net_ipv4.c                    |  19 +
 net/ipv4/tcp.c                                |  30 +-
 net/ipv4/tcp_input.c                          | 611 +++++++++++++++++-
 net/ipv4/tcp_ipv4.c                           |   7 +-
 net/ipv4/tcp_minisocks.c                      |  91 ++-
 net/ipv4/tcp_output.c                         | 303 ++++++++-
 net/ipv6/syncookies.c                         |   1 +
 net/ipv6/tcp_ipv6.c                           |   1 +
 14 files changed, 1250 insertions(+), 98 deletions(-)

-- 
2.34.1


