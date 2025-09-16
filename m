Return-Path: <linux-kselftest+bounces-41586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50381B5908A
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 10:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0EE67B2775
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 08:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0AE2EC56F;
	Tue, 16 Sep 2025 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="a3O3QyLu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013006.outbound.protection.outlook.com [40.107.159.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87762264AA;
	Tue, 16 Sep 2025 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011133; cv=fail; b=ReMt7QnI/L/XLSuXz3I6EDrcVlPJz3rFsdbY2hd32u50t8bQnzEFxrQRDtFQu1kJfLg7GtUwwaaYqYwmSmusb16poPOrLtIdb/GCd03ssB2huYvJl0ZJ1tS39KhNsEDVJ6lnFENhkIoz13ldwPqDtDiOBd/F8d+a1NE6dF26uZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011133; c=relaxed/simple;
	bh=dGcZCMrmmzg76+4j4hxBIgrcl/I03TgHxAQEaYBPq5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRI8vVigRKGRFZIr1UiACttSEva3dguNt0ngba8/05lmzuxtuM/yc3tm3HxaRzcB72OYh79sr5OrOGu+ciypuVRpL2qsw+gA+Emc5m9D7er2TU2QZVw6AGT7rUQJVD9mehMo5ocQkTIhJiJKstVekuY6+XeelB/7KKDBUSrFGDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=a3O3QyLu; arc=fail smtp.client-ip=40.107.159.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNbMBeU/rfsV5Zvf6uBLZ9jrCYZ6NVnzfylcyuEViBYNrCW5e8qltBEO8OETdi8Nex4shd+1WG6dafTIB6N7sgixZgVMxlkFDNYLEAp4aANNzYzN2Nss+H7rpspD6VVkNiY15lX8EFUqsNDgg+MM5EVTgBKE7StcIGVgknwehsiGOByA9P8EtxiVIyFd6bEtFrKX+SczRk0fx5+W+8g6D4sYt5P8rwVc9ogV4cC6eXWuJc6m7gVX0YisqDLwwtHBkNMIslgFecxLmAfdA2VeCnxNV3qiKhCiwLZyrcvjmq4ydHYvPbYx+cJ8aV8E1JwTrKt1NwKdMWPnTCYC+ahEQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkO7887bSVY9g221EtIj9dMwSGT8IlVexhOldvWd3uk=;
 b=LIC4d8vi+lzdyyto4fsY14gWtis7CyvizS2CyaNbbUPpy+4tphzC9k8A6iMiirToZ/YI44E/DTJwjgXonSrSyCzcrv3rl8f9fMtd1guGj6ajTZo4R29xsJ11Ra5s94EKVtEAr3+cPcRQMgYX1x70odXgjo/sD70t2eoo0WKTvnEajLf4CY4wgpgpsbt3bsLwkHnGwtfGb2CMqgFti9Gj0gvaK9T29g5ssV5y4pyDFSr3MCQgWPnyJZc4tq85VvpNGl/mma5PJBGq8J2Ffv8VWSkmgYb3pii8Ssp855dnFciWLkPyZuLPDfxMcAfmTcRZ/7N4RVgStd8yKr/1B7H3hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkO7887bSVY9g221EtIj9dMwSGT8IlVexhOldvWd3uk=;
 b=a3O3QyLuHLS3MNGf8e5ioPMxkrdm1ngUVjBl+2/Hx/y+KcQXs+OnoIZGqX5EbcyDMh6P7y0Ik6tldt8U8S9Rh7xo9mx7nD2iib2OHPmyHoGm9em+IVoz6S3QxQ7lkL5JcW04jU3NYS1H2ZEfhReJl8W5jbwoW77OzP14b5UGi2WgryGaxj7p4DUE0N/GvicKgjvXhM/oxczjM8noMNDr1sRLIBu+wjkuMcwC/ZkPovW+aSOw1himyR8ZGeOzVmKxHWvc2CXA54+ZrsFUSKU9SgG/kk2pXwoOMRIhVIUn+gouq31z8rpNEm7WSmXKgUBomTjP1Aa3IaNcTDlnzke8cw==
Received: from AS4P190CA0069.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::15)
 by PR3PR07MB6585.eurprd07.prod.outlook.com (2603:10a6:102:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 08:25:23 +0000
Received: from AM4PEPF00027A65.eurprd04.prod.outlook.com
 (2603:10a6:20b:656:cafe::4) by AS4P190CA0069.outlook.office365.com
 (2603:10a6:20b:656::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 08:25:23 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.240) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM4PEPF00027A65.mail.protection.outlook.com (10.167.16.86) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Tue, 16 Sep 2025 08:25:22 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 237372080F;
	Tue, 16 Sep 2025 11:25:21 +0300 (EEST)
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
Subject: [PATCH v19 net-next 06/10] tcp: accecn: AccECN option
Date: Tue, 16 Sep 2025 10:24:30 +0200
Message-Id: <20250916082434.100722-7-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916082434.100722-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250916082434.100722-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A65:EE_|PR3PR07MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b17494-4578-40b2-3ac7-08ddf4fa9476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmFKU1c0dm84MS8rb24zMUZkUmdLUEtOUDZKS1A1TVRoODdVUEhZcDlQQVY1?=
 =?utf-8?B?U3QxVHppUUZlU0gxOHpNWms2Q29sdkc2VHRVNmNpVjcyODJvb0tCQzZ1OVdD?=
 =?utf-8?B?NGJHV0dMaHlsM09Qbmt5NFlseGFXQTEySkdRSURBc3BVV2hNZzVNbldhZTNk?=
 =?utf-8?B?VkdEd0dEdGJpaFlycW1IbXEyaFNuNFNqd1BrOEdJcm1FbW1FUWlMaStMU1ha?=
 =?utf-8?B?dUljNXN1NHlrSUFLdEIyU2N2VUE5Uzc2MStURVBCbURSN0cxVHFXSXEyNFdN?=
 =?utf-8?B?aWlaRUlnYzV4SHYwWmRSY3dUYkhaRmJ6Ny9hQ21Jcjc5VTNSRHFZeXAyMGRi?=
 =?utf-8?B?a0NVempqTlhQWFcrdTFOdmd4ZDBLTzFSRVVXQ0dZV09NQ0RLTU1nb1Rid1hS?=
 =?utf-8?B?azl6NitTZDUxcmtKZ2gvaDFZTFlpanZ1eE80dTg1aVpzdWl3L0lJYVdNVGwz?=
 =?utf-8?B?aVJLSXExaDAzL0puVThKWHp6VFhCQVoxcDNQemlYZjJodC9SaGZQSVhLeGlL?=
 =?utf-8?B?Y1c0WWRBNU5WTWFjQzhXN1lkaFFIZklzYi9Gam1DT1NsOW4vN3dGRmxlVXZv?=
 =?utf-8?B?bmZwQ01tNGd5eXFSMUcvdnlERFpvV09YTWRZODduZ29QMXRtQnFIUmRQZTNR?=
 =?utf-8?B?eTF0ekdjYUZ3SlhsWVdsQVo0ZEhxaUd4V0lKS1Z4enhSUDNRZ24vWDBwUUpp?=
 =?utf-8?B?WUdWS0JvQ1Z5bXdNMmFINXliRGJFMnFVWjBaSUtIbWIvempYRDFDS1V6Y1FJ?=
 =?utf-8?B?MmxnK0dwZ1FESTVjV0lzQ1BkajJiTEU2Z1pYVzNGdEhkSGMzYzNjT29Ea1BY?=
 =?utf-8?B?WUc0VitYRUpiMGYzdDJHaFhWK0lEWCthYm5uek94ckU4OTFEZzBaeGdEblVy?=
 =?utf-8?B?WlI1Qm8xclB1ZmhqTGdQVVF4ODJvODk1OXRDTDcwTVo4MVEwWkkxbGdCR2to?=
 =?utf-8?B?Q2pjMTRZZnNmQzFQYXBpTmFKZzBYbEcvQnl0bGk3MXRFTzYvQlY0K1UwVTZV?=
 =?utf-8?B?aEZJTXB3WjZkSzBFVUdUY1hqY0Q4b3F3MngwbGxsTWJXYm1OcmYxZGROVUJi?=
 =?utf-8?B?bjBsTVRDNXN1WUpQbkRBV0k1aHY3TlptbGNqNDR1Vm9BZkt5ZDNYZnlFb2tB?=
 =?utf-8?B?ZTE5dEJQakM1bktqYUxxbGJZZEVabEJwYVVHQ1JTdUNDbDFDV1JhWkM3Tm4x?=
 =?utf-8?B?UU5PZU1BSGZFVTZETWZqUENlQ29LaHd4L2lnQXlDc1dBOElkV01YQTFQVlh1?=
 =?utf-8?B?OVpjUU9vci91eUNSS250TXBpL3hscFpDdk5QalU4Mld5MnJ3MGZGaXBqMUJL?=
 =?utf-8?B?YlVzM2RYRnBGVVo0dVNLNWZ6emQ2UlBJeXcyRnNPSDlvd2xtS3Y5RFM0SHRv?=
 =?utf-8?B?ZXRKZEdqdG14TmZIU2VPanU3RVMxVExkKzNCQ1Zkbzg4VS9FZjBhaXdnOWdi?=
 =?utf-8?B?VVFkbUsveVpHOTZHMGovaHNvVVlUcXJaa3VucG9iUlFLVmZsQ2pqaUpVMC9X?=
 =?utf-8?B?SEgzekFtdWRDUUlCVmJRSkF3dVdEKzRoZmcwSUFrUjhXOFFocVFYbTVsK2xy?=
 =?utf-8?B?ZzdIZFk2Umd5MjBBK256dFdvaFo4d0RnWG5CdW5RSlBrUjVaTXVFaVIwcjRD?=
 =?utf-8?B?SDl2cG5RTkxReTFBQWxDdE1oQ2MzVzRpT05Gc1dEbEZrclFYWmxVcTQyeTZ2?=
 =?utf-8?B?MWJHc3o3MXNUeE5qbzJ6bFFkWkk5Nnc4UGVNeEU5T2xVUzU2Z0ZNR1FBYlFx?=
 =?utf-8?B?ZlR3WlQ0VzI0S1hVR1FidTZwOTl4clRzcVduUzhuMDhEUnAvcVFMMXNPN05q?=
 =?utf-8?B?QzFKZ01YdXlBQjdDMVBOZXp0NndSZU9OdTBRZVJCWUl6UnhSbHlFM2M4VHVY?=
 =?utf-8?B?NjJ5VklUUG9lczdUQ2VQaWdGSms1aTRuL1BpMnhpdTR2RDdQbUpteU5zRzRG?=
 =?utf-8?B?amd6UnBWRzVLNm52cy9mMEo3aW16ak5pUTg3M2N5cGtuTzdFT2Q5eEdUMzdu?=
 =?utf-8?B?UzN0RUQ5MVFIdTF0ZnJBYjBoNUl6aWNmVEQ1WE1ENU9RTWsyaGhaZmtqZEkv?=
 =?utf-8?B?N28zQjZRVkVYM3EzL3FmR0VFM1ZlM0h3aHZudz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 08:25:22.5330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b17494-4578-40b2-3ac7-08ddf4fa9476
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00027A65.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6585

From: Ilpo Järvinen <ij@kernel.org>

The Accurate ECN allows echoing back the sum of bytes for
each IP ECN field value in the received packets using
AccECN option. This change implements AccECN option tx & rx
side processing without option send control related features
that are added by a later change.

Based on specification:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
(Some features of the spec will be added in the later changes
rather than in this one).

A full-length AccECN option is always attempted but if it does
not fit, the minimum length is selected based on the counters
that have changed since the last update. The AccECN option
(with 24-bit fields) often ends in odd sizes so the option
write code tries to take advantage of some nop used to pad
the other TCP options.

The delivered_ecn_bytes pairs with received_ecn_bytes similar
to how delivered_ce pairs with received_ce. In contrast to
ACE field, however, the option is not always available to update
delivered_ecn_bytes. For ACK w/o AccECN option, the delivered
bytes calculated based on the cumulative ACK+SACK information
are assigned to one of the counters using an estimation
heuristic to select the most likely ECN byte counter. Any
estimation error is corrected when the next AccECN option
arrives. It may occur that the heuristic gets too confused
when there are enough different byte counter deltas between
ACKs with the AccECN option in which case the heuristic just
gives up on updating the counters for a while.

tcp_ecn_option sysctl can be used to select option sending
mode for AccECN: TCP_ECN_OPTION_DISABLED, TCP_ECN_OPTION_MINIMUM,
and TCP_ECN_OPTION_FULL.

This patch increases the size of tcp_info struct, as there is
no existing holes for new u32 variables. Below are the pahole
outcomes before and after this patch:

[BEFORE THIS PATCH]
struct tcp_info {
    [...]
     __u32                     tcpi_total_rto_time;  /*   244     4 */

    /* size: 248, cachelines: 4, members: 61 */
}

[AFTER THIS PATCH]
struct tcp_info {
    [...]
    __u32                      tcpi_total_rto_time;  /*   244     4 */
    __u32                      tcpi_received_ce;     /*   248     4 */
    __u32                      tcpi_delivered_e1_bytes; /*   252     4 */
    __u32                      tcpi_delivered_e0_bytes; /*   256     4 */
    __u32                      tcpi_delivered_ce_bytes; /*   260     4 */
    __u32                      tcpi_received_e1_bytes; /*   264     4 */
    __u32                      tcpi_received_e0_bytes; /*   268     4 */
    __u32                      tcpi_received_ce_bytes; /*   272     4 */

    /* size: 280, cachelines: 5, members: 68 */
}

This patch uses the existing 1-byte holes in the tcp_sock_write_txrx
group for new u8 members, but adds a 4-byte hole in tcp_sock_write_rx
group after the new u32 delivered_ecn_bytes[3] member. Therefore, the
group size of tcp_sock_write_rx is increased from 96 to 112. Below
are the pahole outcomes before and after this patch:

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    u8                         received_ce_pending:4; /*  2522: 0  1 */
    u8                         unused2:4;             /*  2522: 4  1 */
    /* XXX 1 byte hole, try to pack */

    [...]
    u32                        rcv_rtt_last_tsecr;    /*  2668     4 */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];      /*  2728     0 */

    [...]
    /* size: 3200, cachelines: 50, members: 167 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    u8                         received_ce_pending:4;/*  2522: 0  1 */
    u8                         unused2:4;            /*  2522: 4  1 */
    u8                         accecn_minlen:2;      /*  2523: 0  1 */
    u8                         est_ecnfield:2;       /*  2523: 2  1 */
    u8                         unused3:4;            /*  2523: 4  1 */

    [...]
    u32                        rcv_rtt_last_tsecr;   /*  2668     4 */
    u32                        delivered_ecn_bytes[3];/*  2672    12 */
    /* XXX 4 bytes hole, try to pack */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];     /*  2744     0 */

    [...]
    /* size: 3200, cachelines: 50, members: 171 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v13
- Move TCP_ACCECN_E1B_INIT_OFFSET, TCP_ACCECN_E0B_INIT_OFFSET, and
  TCP_ACCECN_CEB_INIT_OFFSET to this patch
- Use static array lookup in tcp_accecn_optfield_to_ecnfield()
- Return false when WARN_ON_ONCE() is true in tcp_accecn_process_option()
- Make synack_ecn_bytes as static const array and use const u32 pointer
  in tcp_options_write()
- Use ALIGN() and ALIGN_DOWN() in tcp_options_fit_accecn() to pad TCP AccECN
  option to dword

v10
- Add documentation of tcp_ecn_option in ip-sysctl.rst to this patch
- Remove the global variable u32 synack_ecn_bytes[3]
- Add READ_ONCE() over every reads of sysctl

v9:
- Restruct the code in the for loop of tcp_accecn_process_option()
- Remove ecn_bytes and add use_synack_ecn_bytes flag in tcp_out_options
  struct to identify whether syn_ack_bytes or received_ecn_bytes is used
- Replace leftover_bytes and leftover_size with leftover_highbyte and
  leftover_lowbyte and add comments in tcp_options_write()

v8:
- Reset leftover_size to 2 once leftover_bytes is used
---
 Documentation/networking/ip-sysctl.rst        |  19 ++
 .../networking/net_cachelines/tcp_sock.rst    |   3 +
 include/linux/tcp.h                           |   9 +-
 include/net/netns/ipv4.h                      |   1 +
 include/net/tcp.h                             |  13 ++
 include/net/tcp_ecn.h                         |  89 +++++++++-
 include/uapi/linux/tcp.h                      |   7 +
 net/ipv4/sysctl_net_ipv4.c                    |   9 +
 net/ipv4/tcp.c                                |  15 +-
 net/ipv4/tcp_input.c                          |  94 +++++++++-
 net/ipv4/tcp_ipv4.c                           |   1 +
 net/ipv4/tcp_output.c                         | 165 +++++++++++++++++-
 12 files changed, 412 insertions(+), 13 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 3d8eb54b84f9..1c206501b973 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -468,6 +468,25 @@ tcp_ecn - INTEGER
 
 	Default: 2
 
+tcp_ecn_option - INTEGER
+	Control Accurate ECN (AccECN) option sending when AccECN has been
+	successfully negotiated during handshake. Send logic inhibits
+	sending AccECN options regarless of this setting when no AccECN
+	option has been seen for the reverse direction.
+
+	Possible values are:
+
+	= ============================================================
+	0 Never send AccECN option. This also disables sending AccECN
+	  option in SYN/ACK during handshake.
+	1 Send AccECN option sparingly according to the minimum option
+	  rules outlined in draft-ietf-tcpm-accurate-ecn.
+	2 Send AccECN option on every packet whenever it fits into TCP
+	  option space.
+	= ============================================================
+
+	Default: 2
+
 tcp_ecn_fallback - BOOLEAN
 	If the kernel detects that ECN connection misbehaves, enable fall
 	back to non-ECN. Currently, this knob implements the fallback
diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 5a2b0af57364..b941151f8c0a 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -104,8 +104,11 @@ u32                           delivered_ce            read_mostly         read_w
 u32                           received_ce             read_mostly         read_write
 u32[3]                        received_ecn_bytes      read_mostly         read_write
 u8:4                          received_ce_pending     read_mostly         read_write
+u32[3]                        delivered_ecn_bytes                         read_write
 u8:2                          syn_ect_snt             write_mostly        read_write
 u8:2                          syn_ect_rcv             read_mostly         read_write
+u8:2                          accecn_minlen           write_mostly        read_write
+u8:2                          est_ecnfield                                read_write
 u8:4                          accecn_fail_mode
 u32                           lost                                        read_mostly         tcp_ack
 u32                           app_limited             read_write          read_mostly         tcp_rate_check_app_limited,tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 012d01347b3c..73557656cb2d 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -122,8 +122,9 @@ struct tcp_options_received {
 		smc_ok : 1,	/* SMC seen on SYN packet		*/
 		snd_wscale : 4,	/* Window scaling received from sender	*/
 		rcv_wscale : 4;	/* Window scaling to send to receiver	*/
-	u8	saw_unknown:1,	/* Received unknown option		*/
-		unused:7;
+	u8	accecn:6,	/* AccECN index in header, 0=no options	*/
+		saw_unknown:1,	/* Received unknown option		*/
+		unused:1;
 	u8	num_sacks;	/* Number of SACK blocks		*/
 	u16	user_mss;	/* mss requested by user in ioctl	*/
 	u16	mss_clamp;	/* Maximal mss, negotiated at connection setup */
@@ -293,6 +294,9 @@ struct tcp_sock {
 		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
 	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
 		unused2:4;
+	u8	accecn_minlen:2,/* Minimum length of AccECN option sent */
+		est_ecnfield:2,/* ECN field for AccECN delivered estimates */
+		unused3:4;
 	__be32	pred_flags;
 	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
 	u64	tcp_mstamp;	/* most recent packet received/sent */
@@ -337,6 +341,7 @@ struct tcp_sock {
 	u32	rate_delivered;    /* saved rate sample: packets delivered */
 	u32	rate_interval_us;  /* saved rate sample: time elapsed */
 	u32	rcv_rtt_last_tsecr;
+	u32	delivered_ecn_bytes[3];
 	u64	first_tx_mstamp;  /* start of window send phase */
 	u64	delivered_mstamp; /* time we reached "delivered" */
 	u64	bytes_acked;	/* RFC4898 tcpEStatsAppHCThruOctetsAcked
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 54a7d187f62a..acbb7dd497e1 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -148,6 +148,7 @@ struct netns_ipv4 {
 	struct local_ports ip_local_ports;
 
 	u8 sysctl_tcp_ecn;
+	u8 sysctl_tcp_ecn_option;
 	u8 sysctl_tcp_ecn_fallback;
 
 	u8 sysctl_ip_default_ttl;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index da8c6640ead3..6be29129465e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -213,6 +213,8 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCPOPT_AO		29	/* Authentication Option (RFC5925) */
 #define TCPOPT_MPTCP		30	/* Multipath TCP (RFC6824) */
 #define TCPOPT_FASTOPEN		34	/* Fast open (RFC7413) */
+#define TCPOPT_ACCECN0		172	/* 0xAC: Accurate ECN Order 0 */
+#define TCPOPT_ACCECN1		174	/* 0xAE: Accurate ECN Order 1 */
 #define TCPOPT_EXP		254	/* Experimental */
 /* Magic number to be after the option value for sharing TCP
  * experimental options. See draft-ietf-tcpm-experimental-options-00.txt
@@ -230,6 +232,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCPOLEN_TIMESTAMP      10
 #define TCPOLEN_MD5SIG         18
 #define TCPOLEN_FASTOPEN_BASE  2
+#define TCPOLEN_ACCECN_BASE    2
 #define TCPOLEN_EXP_FASTOPEN_BASE  4
 #define TCPOLEN_EXP_SMC_BASE   6
 
@@ -243,6 +246,13 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCPOLEN_MD5SIG_ALIGNED		20
 #define TCPOLEN_MSS_ALIGNED		4
 #define TCPOLEN_EXP_SMC_BASE_ALIGNED	8
+#define TCPOLEN_ACCECN_PERFIELD		3
+
+/* Maximum number of byte counters in AccECN option + size */
+#define TCP_ACCECN_NUMFIELDS		3
+#define TCP_ACCECN_MAXSIZE		(TCPOLEN_ACCECN_BASE + \
+					 TCPOLEN_ACCECN_PERFIELD * \
+					 TCP_ACCECN_NUMFIELDS)
 
 /* Flags in tp->nonagle */
 #define TCP_NAGLE_OFF		1	/* Nagle's algo is disabled */
@@ -981,6 +991,9 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
  * See draft-ietf-tcpm-accurate-ecn for the latest values.
  */
 #define TCP_ACCECN_CEP_INIT_OFFSET 5
+#define TCP_ACCECN_E1B_INIT_OFFSET 1
+#define TCP_ACCECN_E0B_INIT_OFFSET 1
+#define TCP_ACCECN_CEB_INIT_OFFSET 0
 
 /* State flags for sacked in struct tcp_skb_cb */
 enum tcp_skb_cb_sacked_flags {
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 1a41a459aa07..08c7f4757e4e 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -24,6 +24,13 @@ enum tcp_ecn_mode {
 	TCP_ECN_IN_ACCECN_OUT_NOECN = 5,
 };
 
+/* AccECN option sending when AccECN has been successfully negotiated */
+enum tcp_accecn_option {
+	TCP_ACCECN_OPTION_DISABLED = 0,
+	TCP_ACCECN_OPTION_MINIMUM = 1,
+	TCP_ACCECN_OPTION_FULL = 2,
+};
+
 static inline void tcp_ecn_queue_cwr(struct tcp_sock *tp)
 {
 	/* Do not set CWR if in AccECN mode! */
@@ -169,6 +176,79 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
 	}
 }
 
+/* Maps IP ECN field ECT/CE code point to AccECN option field number, given
+ * we are sending fields with Accurate ECN Order 1: ECT(1), CE, ECT(0).
+ */
+static inline u8 tcp_ecnfield_to_accecn_optfield(u8 ecnfield)
+{
+	switch (ecnfield & INET_ECN_MASK) {
+	case INET_ECN_NOT_ECT:
+		return 0;	/* AccECN does not send counts of NOT_ECT */
+	case INET_ECN_ECT_1:
+		return 1;
+	case INET_ECN_CE:
+		return 2;
+	case INET_ECN_ECT_0:
+		return 3;
+	}
+	return 0;
+}
+
+/* Maps IP ECN field ECT/CE code point to AccECN option field value offset.
+ * Some fields do not start from zero, to detect zeroing by middleboxes.
+ */
+static inline u32 tcp_accecn_field_init_offset(u8 ecnfield)
+{
+	switch (ecnfield & INET_ECN_MASK) {
+	case INET_ECN_NOT_ECT:
+		return 0;	/* AccECN does not send counts of NOT_ECT */
+	case INET_ECN_ECT_1:
+		return TCP_ACCECN_E1B_INIT_OFFSET;
+	case INET_ECN_CE:
+		return TCP_ACCECN_CEB_INIT_OFFSET;
+	case INET_ECN_ECT_0:
+		return TCP_ACCECN_E0B_INIT_OFFSET;
+	}
+	return 0;
+}
+
+/* Maps AccECN option field #nr to IP ECN field ECT/CE bits */
+static inline unsigned int tcp_accecn_optfield_to_ecnfield(unsigned int option,
+							   bool order)
+{
+	/* Based on Table 5 of the AccECN spec to map (option, order) to
+	 * the corresponding ECN conuters (ECT-1, ECT-0, or CE).
+	 */
+	static const u8 optfield_lookup[2][3] = {
+		/* order = 0: 1st field ECT-0, 2nd field CE, 3rd field ECT-1 */
+		{ INET_ECN_ECT_0, INET_ECN_CE, INET_ECN_ECT_1 },
+		/* order = 1: 1st field ECT-1, 2nd field CE, 3rd field ECT-0 */
+		{ INET_ECN_ECT_1, INET_ECN_CE, INET_ECN_ECT_0 }
+	};
+
+	return optfield_lookup[order][option % 3];
+}
+
+/* Handles AccECN option ECT and CE 24-bit byte counters update into
+ * the u32 value in tcp_sock. As we're processing TCP options, it is
+ * safe to access from - 1.
+ */
+static inline s32 tcp_update_ecn_bytes(u32 *cnt, const char *from,
+				       u32 init_offset)
+{
+	u32 truncated = (get_unaligned_be32(from - 1) - init_offset) &
+			0xFFFFFFU;
+	u32 delta = (truncated - *cnt) & 0xFFFFFFU;
+
+	/* If delta has the highest bit set (24th bit) indicating
+	 * negative, sign extend to correct an estimation using
+	 * sign_extend32(delta, 24 - 1)
+	 */
+	delta = sign_extend32(delta, 23);
+	*cnt += delta;
+	return (s32)delta;
+}
+
 /* Updates Accurate ECN received counters from the received IP ECN field */
 static inline void tcp_ecn_received_counters(struct sock *sk,
 					     const struct sk_buff *skb, u32 len)
@@ -192,8 +272,12 @@ static inline void tcp_ecn_received_counters(struct sock *sk,
 		tp->received_ce_pending = min(tp->received_ce_pending + pcount,
 					      0xfU);
 
-		if (len > 0)
+		if (len > 0) {
+			u8 minlen = tcp_ecnfield_to_accecn_optfield(ecnfield);
 			tp->received_ecn_bytes[ecnfield - 1] += len;
+			tp->accecn_minlen = max_t(u8, tp->accecn_minlen,
+						  minlen);
+		}
 	}
 }
 
@@ -263,6 +347,9 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 	tp->received_ce = 0;
 	tp->received_ce_pending = 0;
 	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
+	__tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
+	tp->accecn_minlen = 0;
+	tp->est_ecnfield = 0;
 }
 
 /* Used for make_synack to form the ACE flags */
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index bdac8c42fa82..53e0e85b52be 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -316,6 +316,13 @@ struct tcp_info {
 					 * in milliseconds, including any
 					 * unfinished recovery.
 					 */
+	__u32	tcpi_received_ce;    /* # of CE marks received */
+	__u32	tcpi_delivered_e1_bytes;  /* Accurate ECN byte counters */
+	__u32	tcpi_delivered_e0_bytes;
+	__u32	tcpi_delivered_ce_bytes;
+	__u32	tcpi_received_e1_bytes;
+	__u32	tcpi_received_e0_bytes;
+	__u32	tcpi_received_ce_bytes;
 };
 
 /* netlink attributes types for SCM_TIMESTAMPING_OPT_STATS */
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 268f8b86e8a7..4a697acb4e85 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -731,6 +731,15 @@ static struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &tcp_ecn_mode_max,
 	},
+	{
+		.procname	= "tcp_ecn_option",
+		.data		= &init_net.ipv4.sysctl_tcp_ecn_option,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_TWO,
+	},
 	{
 		.procname	= "tcp_ecn_fallback",
 		.data		= &init_net.ipv4.sysctl_tcp_ecn_fallback,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a45a4184b603..8c4a4b8666fc 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -270,6 +270,7 @@
 
 #include <net/icmp.h>
 #include <net/inet_common.h>
+#include <net/inet_ecn.h>
 #include <net/tcp.h>
 #include <net/tcp_ecn.h>
 #include <net/mptcp.h>
@@ -4155,6 +4156,9 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 {
 	const struct tcp_sock *tp = tcp_sk(sk); /* iff sk_type == SOCK_STREAM */
 	const struct inet_connection_sock *icsk = inet_csk(sk);
+	const u8 ect1_idx = INET_ECN_ECT_1 - 1;
+	const u8 ect0_idx = INET_ECN_ECT_0 - 1;
+	const u8 ce_idx = INET_ECN_CE - 1;
 	unsigned long rate;
 	u32 now;
 	u64 rate64;
@@ -4281,6 +4285,14 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 	if (tp->rto_stamp)
 		info->tcpi_total_rto_time += tcp_clock_ms() - tp->rto_stamp;
 
+	info->tcpi_received_ce = tp->received_ce;
+	info->tcpi_delivered_e1_bytes = tp->delivered_ecn_bytes[ect1_idx];
+	info->tcpi_delivered_e0_bytes = tp->delivered_ecn_bytes[ect0_idx];
+	info->tcpi_delivered_ce_bytes = tp->delivered_ecn_bytes[ce_idx];
+	info->tcpi_received_e1_bytes = tp->received_ecn_bytes[ect1_idx];
+	info->tcpi_received_e0_bytes = tp->received_ecn_bytes[ect0_idx];
+	info->tcpi_received_ce_bytes = tp->received_ecn_bytes[ce_idx];
+
 	unlock_sock_fast(sk, slow);
 }
 EXPORT_SYMBOL_GPL(tcp_get_info);
@@ -5162,12 +5174,13 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rate_delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rate_interval_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_last_tsecr);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, first_tx_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_est);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcvq_space);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_rx, 96);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_rx, 112);
 }
 
 void __init tcp_init(void)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8b48a3c00945..e898a76c485e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -70,6 +70,7 @@
 #include <linux/sysctl.h>
 #include <linux/kernel.h>
 #include <linux/prefetch.h>
+#include <linux/bitops.h>
 #include <net/dst.h>
 #include <net/tcp.h>
 #include <net/tcp_ecn.h>
@@ -384,6 +385,73 @@ static void tcp_data_ecn_check(struct sock *sk, const struct sk_buff *skb)
 	}
 }
 
+/* Returns true if the byte counters can be used */
+static bool tcp_accecn_process_option(struct tcp_sock *tp,
+				      const struct sk_buff *skb,
+				      u32 delivered_bytes, int flag)
+{
+	u8 estimate_ecnfield = tp->est_ecnfield;
+	bool ambiguous_ecn_bytes_incr = false;
+	bool first_changed = false;
+	unsigned int optlen;
+	bool order1, res;
+	unsigned int i;
+	u8 *ptr;
+
+	if (!(flag & FLAG_SLOWPATH) || !tp->rx_opt.accecn) {
+		if (estimate_ecnfield) {
+			u8 ecnfield = estimate_ecnfield - 1;
+
+			tp->delivered_ecn_bytes[ecnfield] += delivered_bytes;
+			return true;
+		}
+		return false;
+	}
+
+	ptr = skb_transport_header(skb) + tp->rx_opt.accecn;
+	optlen = ptr[1] - 2;
+	if (WARN_ON_ONCE(ptr[0] != TCPOPT_ACCECN0 && ptr[0] != TCPOPT_ACCECN1))
+		return false;
+	order1 = (ptr[0] == TCPOPT_ACCECN1);
+	ptr += 2;
+
+	res = !!estimate_ecnfield;
+	for (i = 0; i < 3; i++) {
+		u32 init_offset;
+		u8 ecnfield;
+		s32 delta;
+		u32 *cnt;
+
+		if (optlen < TCPOLEN_ACCECN_PERFIELD)
+			break;
+
+		ecnfield = tcp_accecn_optfield_to_ecnfield(i, order1);
+		init_offset = tcp_accecn_field_init_offset(ecnfield);
+		cnt = &tp->delivered_ecn_bytes[ecnfield - 1];
+		delta = tcp_update_ecn_bytes(cnt, ptr, init_offset);
+		if (delta && delta < 0) {
+			res = false;
+			ambiguous_ecn_bytes_incr = true;
+		}
+		if (delta && ecnfield != estimate_ecnfield) {
+			if (!first_changed) {
+				tp->est_ecnfield = ecnfield;
+				first_changed = true;
+			} else {
+				res = false;
+				ambiguous_ecn_bytes_incr = true;
+			}
+		}
+
+		optlen -= TCPOLEN_ACCECN_PERFIELD;
+		ptr += TCPOLEN_ACCECN_PERFIELD;
+	}
+	if (ambiguous_ecn_bytes_incr)
+		tp->est_ecnfield = 0;
+
+	return res;
+}
+
 static void tcp_count_delivered_ce(struct tcp_sock *tp, u32 ecn_count)
 {
 	tp->delivered_ce += ecn_count;
@@ -400,7 +468,8 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 
 /* Returns the ECN CE delta */
 static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
-				u32 delivered_pkts, int flag)
+				u32 delivered_pkts, u32 delivered_bytes,
+				int flag)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -411,6 +480,8 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
 		return 0;
 
+	tcp_accecn_process_option(tp, skb, delivered_bytes, flag);
+
 	if (!(flag & FLAG_SLOWPATH)) {
 		/* AccECN counter might overflow on large ACKs */
 		if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
@@ -436,12 +507,14 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 }
 
 static u32 tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
-			      u32 delivered_pkts, int *flag)
+			      u32 delivered_pkts, u32 delivered_bytes,
+			      int *flag)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	u32 delta;
 
-	delta = __tcp_accecn_process(sk, skb, delivered_pkts, *flag);
+	delta = __tcp_accecn_process(sk, skb, delivered_pkts,
+				     delivered_bytes, *flag);
 	if (delta > 0) {
 		tcp_count_delivered_ce(tp, delta);
 		*flag |= FLAG_ECE;
@@ -3973,6 +4046,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	if (tcp_ecn_mode_accecn(tp))
 		ecn_count = tcp_accecn_process(sk, skb,
 					       tp->delivered - delivered,
+					       sack_state.delivered_bytes,
 					       &flag);
 
 	tcp_in_ack_event(sk, flag);
@@ -4012,6 +4086,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	if (tcp_ecn_mode_accecn(tp))
 		ecn_count = tcp_accecn_process(sk, skb,
 					       tp->delivered - delivered,
+					       sack_state.delivered_bytes,
 					       &flag);
 	tcp_in_ack_event(sk, flag);
 	/* If data was DSACKed, see if we can undo a cwnd reduction. */
@@ -4139,6 +4214,7 @@ void tcp_parse_options(const struct net *net,
 
 	ptr = (const unsigned char *)(th + 1);
 	opt_rx->saw_tstamp = 0;
+	opt_rx->accecn = 0;
 	opt_rx->saw_unknown = 0;
 
 	while (length > 0) {
@@ -4230,6 +4306,12 @@ void tcp_parse_options(const struct net *net,
 					ptr, th->syn, foc, false);
 				break;
 
+			case TCPOPT_ACCECN0:
+			case TCPOPT_ACCECN1:
+				/* Save offset of AccECN option in TCP header */
+				opt_rx->accecn = (ptr - 2) - (__u8 *)th;
+				break;
+
 			case TCPOPT_EXP:
 				/* Fast Open option shares code 254 using a
 				 * 16 bits magic number.
@@ -4290,11 +4372,14 @@ static bool tcp_fast_parse_options(const struct net *net,
 	 */
 	if (th->doff == (sizeof(*th) / 4)) {
 		tp->rx_opt.saw_tstamp = 0;
+		tp->rx_opt.accecn = 0;
 		return false;
 	} else if (tp->rx_opt.tstamp_ok &&
 		   th->doff == ((sizeof(*th) + TCPOLEN_TSTAMP_ALIGNED) / 4)) {
-		if (tcp_parse_aligned_timestamp(tp, th))
+		if (tcp_parse_aligned_timestamp(tp, th)) {
+			tp->rx_opt.accecn = 0;
 			return true;
+		}
 	}
 
 	tcp_parse_options(net, skb, &tp->rx_opt, 1, NULL);
@@ -6119,6 +6204,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 	 */
 
 	tp->rx_opt.saw_tstamp = 0;
+	tp->rx_opt.accecn = 0;
 
 	/*	pred_flags is 0xS?10 << 16 + snd_wnd
 	 *	if header_prediction is to be made
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 6162f8dbe9d2..aa8dbfe20924 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3561,6 +3561,7 @@ static void __net_init tcp_set_hashinfo(struct net *net)
 static int __net_init tcp_sk_init(struct net *net)
 {
 	net->ipv4.sysctl_tcp_ecn = TCP_ECN_IN_ECN_OUT_NOECN;
+	net->ipv4.sysctl_tcp_ecn_option = TCP_ACCECN_OPTION_FULL;
 	net->ipv4.sysctl_tcp_ecn_fallback = 1;
 
 	net->ipv4.sysctl_tcp_base_mss = TCP_BASE_MSS;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 5be2b3eb73d3..34e5c83bbace 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -385,6 +385,7 @@ static inline bool tcp_urg_mode(const struct tcp_sock *tp)
 #define OPTION_SMC		BIT(9)
 #define OPTION_MPTCP		BIT(10)
 #define OPTION_AO		BIT(11)
+#define OPTION_ACCECN		BIT(12)
 
 static void smc_options_write(__be32 *ptr, u16 *options)
 {
@@ -406,6 +407,8 @@ struct tcp_out_options {
 	u16 mss;		/* 0 to disable */
 	u8 ws;			/* window scale, 0 to disable */
 	u8 num_sack_blocks;	/* number of SACK blocks to include */
+	u8 num_accecn_fields:7,	/* number of AccECN fields needed */
+	   use_synack_ecn_bytes:1; /* Use synack_ecn_bytes or not */
 	u8 hash_size;		/* bytes in hash_location */
 	u8 bpf_opt_len;		/* length of BPF hdr option */
 	__u8 *hash_location;	/* temporary pointer, overloaded */
@@ -603,6 +606,11 @@ static __be32 *process_tcp_ao_options(struct tcp_sock *tp,
 	return ptr;
 }
 
+/* Initial values for AccECN option, ordered is based on ECN field bits
+ * similar to received_ecn_bytes. Used for SYN/ACK AccECN option.
+ */
+static const u32 synack_ecn_bytes[3] = { 0, 0, 0 };
+
 /* Write previously computed TCP options to the packet.
  *
  * Beware: Something in the Internet is very sensitive to the ordering of
@@ -621,6 +629,8 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 			      struct tcp_out_options *opts,
 			      struct tcp_key *key)
 {
+	u8 leftover_highbyte = TCPOPT_NOP; /* replace 1st NOP if avail */
+	u8 leftover_lowbyte = TCPOPT_NOP;  /* replace 2nd NOP in succession */
 	__be32 *ptr = (__be32 *)(th + 1);
 	u16 options = opts->options;	/* mungable copy */
 
@@ -656,15 +666,71 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 		*ptr++ = htonl(opts->tsecr);
 	}
 
+	if (OPTION_ACCECN & options) {
+		const u32 *ecn_bytes = opts->use_synack_ecn_bytes ?
+				       synack_ecn_bytes :
+				       tp->received_ecn_bytes;
+		const u8 ect0_idx = INET_ECN_ECT_0 - 1;
+		const u8 ect1_idx = INET_ECN_ECT_1 - 1;
+		const u8 ce_idx = INET_ECN_CE - 1;
+		u32 e0b;
+		u32 e1b;
+		u32 ceb;
+		u8 len;
+
+		e0b = ecn_bytes[ect0_idx] + TCP_ACCECN_E0B_INIT_OFFSET;
+		e1b = ecn_bytes[ect1_idx] + TCP_ACCECN_E1B_INIT_OFFSET;
+		ceb = ecn_bytes[ce_idx] + TCP_ACCECN_CEB_INIT_OFFSET;
+		len = TCPOLEN_ACCECN_BASE +
+		      opts->num_accecn_fields * TCPOLEN_ACCECN_PERFIELD;
+
+		if (opts->num_accecn_fields == 2) {
+			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
+				       ((e1b >> 8) & 0xffff));
+			*ptr++ = htonl(((e1b & 0xff) << 24) |
+				       (ceb & 0xffffff));
+		} else if (opts->num_accecn_fields == 1) {
+			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
+				       ((e1b >> 8) & 0xffff));
+			leftover_highbyte = e1b & 0xff;
+			leftover_lowbyte = TCPOPT_NOP;
+		} else if (opts->num_accecn_fields == 0) {
+			leftover_highbyte = TCPOPT_ACCECN1;
+			leftover_lowbyte = len;
+		} else if (opts->num_accecn_fields == 3) {
+			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
+				       ((e1b >> 8) & 0xffff));
+			*ptr++ = htonl(((e1b & 0xff) << 24) |
+				       (ceb & 0xffffff));
+			*ptr++ = htonl(((e0b & 0xffffff) << 8) |
+				       TCPOPT_NOP);
+		}
+		if (tp)
+			tp->accecn_minlen = 0;
+	}
+
 	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
-		*ptr++ = htonl((TCPOPT_NOP << 24) |
-			       (TCPOPT_NOP << 16) |
+		*ptr++ = htonl((leftover_highbyte << 24) |
+			       (leftover_lowbyte << 16) |
 			       (TCPOPT_SACK_PERM << 8) |
 			       TCPOLEN_SACK_PERM);
+		leftover_highbyte = TCPOPT_NOP;
+		leftover_lowbyte = TCPOPT_NOP;
 	}
 
 	if (unlikely(OPTION_WSCALE & options)) {
-		*ptr++ = htonl((TCPOPT_NOP << 24) |
+		u8 highbyte = TCPOPT_NOP;
+
+		/* Do not split the leftover 2-byte to fit into a single
+		 * NOP, i.e., replace this NOP only when 1 byte is leftover
+		 * within leftover_highbyte.
+		 */
+		if (unlikely(leftover_highbyte != TCPOPT_NOP &&
+			     leftover_lowbyte == TCPOPT_NOP)) {
+			highbyte = leftover_highbyte;
+			leftover_highbyte = TCPOPT_NOP;
+		}
+		*ptr++ = htonl((highbyte << 24) |
 			       (TCPOPT_WINDOW << 16) |
 			       (TCPOLEN_WINDOW << 8) |
 			       opts->ws);
@@ -675,11 +741,13 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 			tp->duplicate_sack : tp->selective_acks;
 		int this_sack;
 
-		*ptr++ = htonl((TCPOPT_NOP  << 24) |
-			       (TCPOPT_NOP  << 16) |
+		*ptr++ = htonl((leftover_highbyte << 24) |
+			       (leftover_lowbyte << 16) |
 			       (TCPOPT_SACK <<  8) |
 			       (TCPOLEN_SACK_BASE + (opts->num_sack_blocks *
 						     TCPOLEN_SACK_PERBLOCK)));
+		leftover_highbyte = TCPOPT_NOP;
+		leftover_lowbyte = TCPOPT_NOP;
 
 		for (this_sack = 0; this_sack < opts->num_sack_blocks;
 		     ++this_sack) {
@@ -688,6 +756,14 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 		}
 
 		tp->rx_opt.dsack = 0;
+	} else if (unlikely(leftover_highbyte != TCPOPT_NOP ||
+			    leftover_lowbyte != TCPOPT_NOP)) {
+		*ptr++ = htonl((leftover_highbyte << 24) |
+			       (leftover_lowbyte << 16) |
+			       (TCPOPT_NOP << 8) |
+			       TCPOPT_NOP);
+		leftover_highbyte = TCPOPT_NOP;
+		leftover_lowbyte = TCPOPT_NOP;
 	}
 
 	if (unlikely(OPTION_FAST_OPEN_COOKIE & options)) {
@@ -768,6 +844,61 @@ static void mptcp_set_option_cond(const struct request_sock *req,
 	}
 }
 
+static u32 tcp_synack_options_combine_saving(struct tcp_out_options *opts)
+{
+	/* How much there's room for combining with the alignment padding? */
+	if ((opts->options & (OPTION_SACK_ADVERTISE | OPTION_TS)) ==
+	    OPTION_SACK_ADVERTISE)
+		return 2;
+	else if (opts->options & OPTION_WSCALE)
+		return 1;
+	return 0;
+}
+
+/* Calculates how long AccECN option will fit to @remaining option space.
+ *
+ * AccECN option can sometimes replace NOPs used for alignment of other
+ * TCP options (up to @max_combine_saving available).
+ *
+ * Only solutions with at least @required AccECN fields are accepted.
+ *
+ * Returns: The size of the AccECN option excluding space repurposed from
+ * the alignment of the other options.
+ */
+static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
+				  int remaining)
+{
+	int size = TCP_ACCECN_MAXSIZE;
+	int max_combine_saving;
+	int align_size;
+
+	if (opts->use_synack_ecn_bytes)
+		max_combine_saving = tcp_synack_options_combine_saving(opts);
+	else
+		max_combine_saving = opts->num_sack_blocks > 0 ? 2 : 0;
+	opts->num_accecn_fields = TCP_ACCECN_NUMFIELDS;
+	while (opts->num_accecn_fields >= required) {
+		/* Pad to dword if cannot combine */
+		if ((size & 0x3) > max_combine_saving)
+			align_size = ALIGN(size, 4);
+		else
+			align_size = ALIGN_DOWN(size, 4);
+
+		if (remaining >= align_size) {
+			size = align_size;
+			break;
+		}
+
+		opts->num_accecn_fields--;
+		size -= TCPOLEN_ACCECN_PERFIELD;
+	}
+	if (opts->num_accecn_fields < required)
+		return 0;
+
+	opts->options |= OPTION_ACCECN;
+	return size;
+}
+
 /* Compute TCP options for SYN packets. This is not the final
  * network wire format yet.
  */
@@ -850,6 +981,15 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 		}
 	}
 
+	/* Simultaneous open SYN/ACK needs AccECN option but not SYN */
+	if (unlikely((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK) &&
+		     tcp_ecn_mode_accecn(tp) &&
+		     READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
+		     remaining >= TCPOLEN_ACCECN_BASE)) {
+		opts->use_synack_ecn_bytes = 1;
+		remaining -= tcp_options_fit_accecn(opts, 0, remaining);
+	}
+
 	bpf_skops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts, &remaining);
 
 	return MAX_TCP_OPTION_SPACE - remaining;
@@ -867,6 +1007,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 {
 	struct inet_request_sock *ireq = inet_rsk(req);
 	unsigned int remaining = MAX_TCP_OPTION_SPACE;
+	struct tcp_request_sock *treq = tcp_rsk(req);
 
 	if (tcp_key_is_md5(key)) {
 		opts->options |= OPTION_MD5;
@@ -929,6 +1070,13 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 
 	smc_set_option_cond(tcp_sk(sk), ireq, opts, &remaining);
 
+	if (treq->accecn_ok &&
+	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
+	    remaining >= TCPOLEN_ACCECN_BASE) {
+		opts->use_synack_ecn_bytes = 1;
+		remaining -= tcp_options_fit_accecn(opts, 0, remaining);
+	}
+
 	bpf_skops_hdr_opt_len((struct sock *)sk, skb, req, syn_skb,
 			      synack_type, opts, &remaining);
 
@@ -1001,6 +1149,13 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 		opts->num_sack_blocks = 0;
 	}
 
+	if (tcp_ecn_mode_accecn(tp) &&
+	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option)) {
+		opts->use_synack_ecn_bytes = 0;
+		size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
+					       MAX_TCP_OPTION_SPACE - size);
+	}
+
 	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
 					    BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG))) {
 		unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
-- 
2.34.1


