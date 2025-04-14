Return-Path: <linux-kselftest+bounces-30687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2FFA88156
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640991888539
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E86A2D1F62;
	Mon, 14 Apr 2025 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="jSiXWvMf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011064.outbound.protection.outlook.com [40.107.130.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A68146447;
	Mon, 14 Apr 2025 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636419; cv=fail; b=A0Zzk6XYFPyLiSRzDmyW8jxNTDK5mNsyFQYosmfZ6+ehxFT9nPsLe/AkromP057bL/MqmsOPGL7adsYnfH8qxLtk1CABoCIOH0JNrGlYcaT4OihQnIC6L6PiVV7yALfppefukY4VowIA4ePqN1A0XBLS1tXejNT10RmDnGsXN9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636419; c=relaxed/simple;
	bh=IYDVG7Bsz4Dzau0WyEiLZTe6exBbiIkKys0xrrjlHYM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Nej+I9GT99eRJGm9F6L1JrzMTOzcQ4jANHnSG+VRLt0vvjqLxXGY2i5Rpsh9hpMuZU6A6twrok+lvNkzxEwr9me0Uaa1h5aNnt4sxkWnDSqbpzQkVLOeyAHJ7ZjTvLYODgSjSEWYOrPnEnaSbL8LT8Dh183Liqg6cxKA3UjoxnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=jSiXWvMf; arc=fail smtp.client-ip=40.107.130.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPuAkpnZoi197XVOuMTb8JsKJxJLD5CYquWsBf7hM59T3daHfGiSSmnJCXjeAGJw0OXx6NZEKYSGYp3zK2KIRoF5jbdMWtTPxpbpcfGsgZqidr9T0C8YUwyW71jJN8jNEbpjois9IBjSB/nhJ4zgzY6p8/DeMQQnIoGzKvoYs7EuTaBkkj2H7ISQKweHBx4i7S11LjY2mhbA8wot8SFPMV/Bn6MmEmdsCkuJYIH+KtuX7YUYIL/a1hwgEqVxXiGAtkRuFq4ahjysmE9lR01tVX5WogLYcjP6IImb1+9WjlquQXzu6R7PslDypOCv5QpvY/yXxzGyYKeFWwQg4bUOAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVfNtaoj6l3ceB8QOIPPbdsRvQwI8Ihl6TR0rjSwNL4=;
 b=sHIvEMi/0s/KbUepg+QjVerqLlS8kYJp/ZcCRe9sOYzf+UhyLlYL4vwilcBk52KEI+QCQ+f0IIKhWRfDORtC3wjJ0eSsDUaNuAbPYnMNXBbajPVhwg1wIE9DYhHIdDqcdZMR4wrgRI0B4DGa4dLp586UkwxEnITtyJ2Bb8o1UmtZ2pTBNIsX40l6f7EbjvvQfN1vJHaYu9q9ublKH+nLxPzUkzCr89HE6WQIMX6rEshNa05h7hAsnHUsYgCCFSdFTm+fA1c0joLo8K4e4ZJMeKLoUo/vHbVbhssUmJKsu7QxAvo4g0IX1S6O2VJMObr1TJssxZH423FexD9o6EHEmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVfNtaoj6l3ceB8QOIPPbdsRvQwI8Ihl6TR0rjSwNL4=;
 b=jSiXWvMfn0T3qIMbh2LKQNkVBXPUWWotSb3K3Vptqvk9DfNke50AVK7+4/LyTI/MWq/pH5j5DibYX2L1eQ901hCHnWEr8AY9oEmrPFqxLYaNouV8EjutU2ON1q6UbalQyy9KSSvtZmzXGfKiynNXmHo/DK7jIBnLDwGPe84o+Ui6Jp9y7Q1cbTKl2X/G/F3hugQFBITNu7MKJH3aVvzLnORCaKc5ckMc+Y2paLbes59p2sw2/NiJui7a8VR8cBh4+Rp+n2Z2zGnFB77Wsf2Vfz5Q9z2gOMv+RjlnMBHh47FbHpzCvz9QlUneRmW5V+gd53xpb4bD7ep5wiclq0pfMg==
Received: from AS4P189CA0035.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5dd::14)
 by AS8PR07MB8373.eurprd07.prod.outlook.com (2603:10a6:20b:444::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 13:13:29 +0000
Received: from AM3PEPF0000A79A.eurprd04.prod.outlook.com
 (2603:10a6:20b:5dd:cafe::4) by AS4P189CA0035.outlook.office365.com
 (2603:10a6:20b:5dd::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Mon,
 14 Apr 2025 13:13:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM3PEPF0000A79A.mail.protection.outlook.com (10.167.16.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 13:13:28 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 53EDDQBB009623;
	Mon, 14 Apr 2025 13:13:26 GMT
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
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net-next 00/15] AccECN protocol patch series
Date: Mon, 14 Apr 2025 15:13:00 +0200
Message-Id: <20250414131315.97456-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79A:EE_|AS8PR07MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: deb00961-d236-4421-0d8c-08dd7b5625d4
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cmdLMkZSYUo3ZFpaenZqZzNNZUhseUdyT3Z2L2krUlh2dzlpTjZZVjM0NERG?=
 =?utf-8?B?ZmR1TWs5aTdFZnUwRUVwVUlLNFdMR1B6S0hGUDcyaFMvNTJ5NmJPUlVUemlJ?=
 =?utf-8?B?Q2J6UGZHT0FGa2xiM1BpUU9xRFdmMGg2dmtwNlRiL0QwS1JvY2NSdk8yd1ZB?=
 =?utf-8?B?Tk5lUFE0U2NrdDRrRFhxa25nMEtkVHRrWnpFS0tOZ2tETm0xMi84RzFqaENI?=
 =?utf-8?B?dDBHRHppOHV2TFY4bjAxMVBhY1ViNzE3K0xuMkYva0NpWWdpdjNqZW1UVVFQ?=
 =?utf-8?B?ME9BeWtJZjRwT1kydW5vYWJEUGtQaDZJSWpWeUhyOFMrQ0dBV21GN3RzQWFL?=
 =?utf-8?B?SU5JY1BZQXhKb003TnhiM1REVDJZbEdrbUtMMjQyRUVkOEwwWjB6TDF1Sk9m?=
 =?utf-8?B?U29vY1JUOTVoell1cVNFOW1TbSs3SmRGa2FxaW14SFVlZlhIRlhIaUlWZ0NT?=
 =?utf-8?B?MnV0YjJrclZiODhTcW9tUEIxNGVVSjdDZzRPWmMzRTV1SWF1ZWhiKzIzR0Ri?=
 =?utf-8?B?Q2R1bEtHVFVVcTlvVlg2cDR5NnMwWVhmbUd0YzQyZkVGNm9rVjRnK1NKMENl?=
 =?utf-8?B?MkJmRlI1eXVwNTI0Q0V0WWprbG5xbUNsdUtoWkFVTjJvT3FMMk5KVVM1NWw4?=
 =?utf-8?B?SjM1VExRZFBMMWhETnhUNmRyWnJZbWlER0lqcnZVczhIL3J1ejFNZ2k4bjJO?=
 =?utf-8?B?OUlpRGtRT2lqbE01cjB1alB0TC9kS3JIdEtESEVaeVR3OW5XYTd3R1V5dDc2?=
 =?utf-8?B?dmhNdnBwRC9tSU5vbzROZGIrUVNIeEhBWi9FN0hDaG1UMzkvN2I3ckhkZ0Nl?=
 =?utf-8?B?S2NrZWtkSmM1b290WC83NjYwYUtZdVBVdXU2UmpUczVCdFV5dW5qai92RSt1?=
 =?utf-8?B?UFg5N1lUTzZTdnY5VjBjb3RFenNzMkx6Y25WelNSYXBoY3BWUlZJbkJJcHdG?=
 =?utf-8?B?L2l6RFhzM1RVdUE1MzkyU0gyazJrUzVHbXhMU211RHA5U2ZubVJjS0FZeEFw?=
 =?utf-8?B?WG1YcEVUSFE2T2lYNXV2bHdsTTBTSTNLemFsZEhwYkNBNVQxNnd5emQxQjJs?=
 =?utf-8?B?dm1mRHVzSFlpK3psMHFzbnlLRG91ZFMzeGJGb1NuMFQ0a1k5TCtHb2sxbjBt?=
 =?utf-8?B?bXVIZ0lqMktxanFCUmxLU2dlbjk5K1pPVjlWYzg5bHBZV1pXZlkzOVRLMFpk?=
 =?utf-8?B?UVJqbjd1OTZHVlVWeGhCN05WSWFHNzF3djNiM1B6REgxT296NDNPMmE5WWhO?=
 =?utf-8?B?MWFkV2dOR1gzTnRsUUJHT3QvcVYyUzhwd2JtSXdHM3NIV0U2cTNLYjEvT3Yx?=
 =?utf-8?B?RDhQUXRkTmRJOWNRYlB6dW1TS0ZOd2RyUXhHYmhUdXcwdkwwUXpRL2ZKdk5P?=
 =?utf-8?B?bU5PaFowOTBEdDJva1lYd3Rrb056Y2dkVUI4SnpPNGVSWU5kbllINkVWRTFr?=
 =?utf-8?B?cEFuVFhkZ3B6dXZ4b0ozZmJCTytNL2RzRkZDc3ZzUzBmTG9hMUsyU3V2czcx?=
 =?utf-8?B?ejNrQ282Q0hPMXd0ZGRLc2NEcjdSREF6S1pMVGdRT0xianRwQVp2b1dXYTEy?=
 =?utf-8?B?Z3RuY215YVBnZ29NOVdjVmFDNjRHWFNhSXFDSjZLOHZGUGY4Y3VLS0MwS1ox?=
 =?utf-8?B?d2V0akljTGsxOGZDVzJTdEdXMXN4azJPTDB0L2RHTDJwVnpMSGl1eDgyV1gy?=
 =?utf-8?B?VEhaQWk0L0V6UHBna3lJbkVaczAvVmZMMUIyVUhjR1MxdmRub0NXRGxiRmxE?=
 =?utf-8?B?Ujk3TUQrdUludkVNVXJNYmNqRHJxUWY2RTdxVXpvZnEzQWs5V3FIcUlDT1Ay?=
 =?utf-8?B?Q2pvVGt1bzdXajE1YUdGa3orY081Z1lxOXFPbmVKZytQUlppVUJEWFdqSkww?=
 =?utf-8?B?RGt6ajZCWkNlN2VQT3ZkRE9xdStzTHZIM3lGdzFNNW1rWkxGK2U5T1M2c0x4?=
 =?utf-8?B?UkhZZmJnWGtMOGhKTE5uRzdZNnFSMHVocElWRDUzdVFzN1pOYUp6OURFMDdV?=
 =?utf-8?B?bFJ3L2dVaDBQL2J6cFdBemhEaWZlL1pNUldPRGV5bG56a3hqWTFMejE1Wkp4?=
 =?utf-8?B?Q1pPRzRJQmM1a3hDV3VqeFhwb056blloREJQUT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:13:28.7598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deb00961-d236-4421-0d8c-08dd7b5625d4
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8373

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


