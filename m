Return-Path: <linux-kselftest+bounces-36262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4603AF09D5
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 06:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5274A7747
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 04:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C90F1F791C;
	Wed,  2 Jul 2025 04:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="dEMzOpZE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010026.outbound.protection.outlook.com [52.101.84.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A67B1F4C8A;
	Wed,  2 Jul 2025 04:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751431060; cv=fail; b=VOIhkF+yQDgcb0EInmyk5XmreLgpjBjbkUPbQbsbH0ibcwASxAaPB5/pHP1xuCOghNItrRylGdqIIb5FZJc425REUVnDofvKkBVgv9NGqGV3cWhEt1IguQqSACbzDqe5SrZi0/myOhylzwJicd9ripcJE5h4a/CK+bdaPc6s4mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751431060; c=relaxed/simple;
	bh=O5udP8YpRvkF5Hj/okHkI4rccLHFOIFv4adj5Gykigw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6wFS4N+ErTkIWv+zuyR+PMg0XKav350t7euNY4OVwxokd5Cwf0A8AEpnm49fY/hM38DznuZv9FazhIPjUuYsSodoS3XymDvjuXOzRBCecnWKR3KW/nSSnmhf7IdioU3De3BFGfyCa4JbgL9UUMLZ9iiUA0NfNB3/HVKkxnZtEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=dEMzOpZE; arc=fail smtp.client-ip=52.101.84.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgYuxdWRzJmRPHcwzsWqnoDPiK4VcnN2d66fwVm48krrZWTiI/F8qdSmMN2BIrDa3Q8JkUKk5WBiNmbpO17iV1ZD5xc++d34KHbmJmnBEZmaHPqmOoRn8b/FZ59/r787CBHCGc27ZeTqwkdA0nBry7xHz/b67lz2vW5bMCqzEZn8H/4BVi2Rtlme0lHu/zYTO/2FaYoN/PzgrtYIfr1m6lLaJiXziwbxCnaXbmtsFdTwTM8KvD44WFl8WC4+czG7qMKx2O1ykyT58RU9yW4LxfvQtFaQJwNYQtIC3ZBStwTdPtLSBNjZ7GIpPNIF1t94I38HteqIJ/rHzd1glVYh5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jn8xF6UhNlgIyF3vQkXkNXRp6g71P3Eru9zsyWLoiPI=;
 b=zOG6dYP0ZHF6mdm+6pj0wdRSEZ62PVosZJqSYXb9dT/dkxCGYyZe2AY9q6r4X5t4DoyGEe/AtlYe4tm74Gj3q6ckyEi5cgz9u4ctaTQicVRBnFEd0k41cncSfkU8WuIhXIv8mwDIANcw9OGpN1VY0i8ajfE6Ph9CaYpXzjsUP4bul9+m/Nb/ns+qXB3oZtokadyioj8KAfujCarqoh0SMvMoxwJd9oIl71rI+0nfBHPbp8i3lz0L4m7zQcYUxVMENIDWLPRzkuw22rlJ7JFJlROv40ah47s0SzmMaobr+wmpVdUHoRQcq7RNP6HqtbVDmGnLOjLq0jWb3GbvcgewTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jn8xF6UhNlgIyF3vQkXkNXRp6g71P3Eru9zsyWLoiPI=;
 b=dEMzOpZEu6W8HCcpTnRBIjLH0sGpqrhUJPAcpLjq/EL5Ow0yEY3lUmtGkipdeMEhXbXTEH26tekcgRnAGeSweLAhT4OqrT8p3fnqhetcA1hPujNaVlIQ+dip00uLtW/BwsRiOg5qsqfB6sK3Y4ivUP6ZJdrjLHNAD2JmpKQe4iFjO9AvFFSn38vHjcwk4HietT774WHb1zCy+8dkA6L6s87lJX1M60MWxSGtKazixNHf5ir5XwpqHRE7WK+p755UsebvbnLRNTLkVKYIY+JCo0GgPrPrK03FaZTI73za++siwvHIg8hdM24H10R+M63txtEsN5CAQao0txkRNbj6/g==
Received: from AS4P192CA0054.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:658::14)
 by DBBPR07MB7657.eurprd07.prod.outlook.com (2603:10a6:10:1f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 04:37:32 +0000
Received: from AM3PEPF0000A79A.eurprd04.prod.outlook.com
 (2603:10a6:20b:658:cafe::ae) by AS4P192CA0054.outlook.office365.com
 (2603:10a6:20b:658::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Wed,
 2 Jul 2025 04:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM3PEPF0000A79A.mail.protection.outlook.com (10.167.16.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Wed, 2 Jul 2025 04:37:32 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 91DE61C003A;
	Wed,  2 Jul 2025 07:37:30 +0300 (EEST)
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
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v10 net-next 05/15] tcp: AccECN core
Date: Wed,  2 Jul 2025 06:37:09 +0200
Message-Id: <20250702043719.15130-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702043719.15130-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250702043719.15130-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79A:EE_|DBBPR07MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: f728beeb-affa-4ffd-bd55-08ddb92228eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|30052699003|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHRCWWhXQ1NUZFFER2JGWFJpbWFjeUpWaWZwUDlxaUlvbUk0WC9WdjhheWEy?=
 =?utf-8?B?aGtEb2dlUVcyNktZTUxRQUFyMFlDeFNtbDNDNFJkdmFTK1p0UkprWDFhYXVY?=
 =?utf-8?B?cENiTmxRbTVtVXlSakxhdjFEZ2lmc2V6cFhNbFNqZWpwTDlSODQvY2J5Lzgy?=
 =?utf-8?B?VXhZV05MOVd5OVQ0V0lzT2dLMFEvcE9FQk9DeEs1WjIzWjVvZjBYTFUzbzEr?=
 =?utf-8?B?ekRBeWtRY0ZHMFYzek1sN0V3NW5MMFJhczNSRWxBSE5DQ3czN2RHTTA0cndK?=
 =?utf-8?B?Zm9VS01mYjNMeHBnZG1sWjEzQUQybmhkRnRLRzkycDQ0UEFtU0RoMFl2ZVE4?=
 =?utf-8?B?aVRwZG9rYkxLR081Y3hiMmFMdURwaUE3L2hyOXljRlJGZ0JUVkluQnl6ejFu?=
 =?utf-8?B?NEl5Y210VFpvOVNSTXdUbUoyRFM1TFdKbWZORklTdStNVHM3VlVLcXluVjRi?=
 =?utf-8?B?TTFWVk5CWjQrclFNZkFWSE92d1dWWitzUG1HY3hRSHpjSEgrelBQbVVaNTZF?=
 =?utf-8?B?SDJiWC84Q2crWVpaWS94UHA3dnZkTzNyNEpaems2L3NTY01UR1BrNVBtQllo?=
 =?utf-8?B?WFNLaXhIcGhaMUNYclFPUkRzeTVrQTg2UmRGTXQrV1gySTJ1dFRsclRSL1k2?=
 =?utf-8?B?UjlQMnhPbkNKWU4vcE9wejg4SXJiamt0cGN3VUlBR1BFOUJpb2ZORE1DZDg4?=
 =?utf-8?B?TVBiUzVQa2FNWVhDdWhTN1ZPalBPNVlEVkFuSmdXUUJHTTZ2S2xoNzRjbndo?=
 =?utf-8?B?ZTJ0R2sxWXJpY1RKOTU5WDBKcU41c3BMazVWeEdhMnZYeXpNZFNyQ1VyVVcv?=
 =?utf-8?B?UDZ5Nk44SUl1cVJFMmRyWVIyTi9hRkRZR3NBbG54Vk1NZWxydGl3QXkwL1k2?=
 =?utf-8?B?NW1PdE1adGhZblBVNklGL2FHRGdiRkVFV09ZNllwejhYR2tWUVE1eGNLaUNB?=
 =?utf-8?B?am96NCttelZZZk04ZDhwMjhXMGFscGV6YnI4S2VsMVRaWDBsNXBhc1JMZm95?=
 =?utf-8?B?OVpBV2I3cSsyVjR1ek1XUnkrNmdCMGpKdUxvNjNZVng4bi8ybDM4ckp3bGtY?=
 =?utf-8?B?aGMvV3o3aXQzUVpndVhxSGl1WGpPbllTcm9XakxDam5mVlY0c2JpV1lrM2lM?=
 =?utf-8?B?bW9LK2hCQWFhRk85U05WRTAxZ2RjS3VMZXZ3ODNWQ2JmVGVaaVJ5bnpHWDdP?=
 =?utf-8?B?Sys2N1liT1JRM0h2RFp0TXZVeUl6Z3ZVc0tLSGNFWllwR2ZSRXNyNXdXZUpy?=
 =?utf-8?B?eVVKMDRFbzJNYzY2bTJkRURlVDVNQTVYdzZmekxWMzVNQTc2N2k1MGdCSEZX?=
 =?utf-8?B?UzdUTG1zNWNpc2NoWU9tcnlCRFA5RzlUOVBFSkJJL0k4WGd0bUtIR2xvYm1h?=
 =?utf-8?B?UkliWjNuaTczWFhPWGZjUG9RQVBiQzB5SXc5WjdGc3ZzSDhObzMxcFRZOU9q?=
 =?utf-8?B?K0ZVS3B4eVJWUllEckw4SXordnpiZWswZUd0OWlxQUc1eTQ0akRVOXVUcFlr?=
 =?utf-8?B?VjRFOGhmVzV2YW9mVDdaOHk2K0RzWmpabmpHaW5TbG55Vm1zTS9pcWJaQUFh?=
 =?utf-8?B?VlgzdWltaXBhc0Z6ZWtQVGVENDJ5ejZIdHVPd2I1bnB1ZnYrY3p1cEhYMHVM?=
 =?utf-8?B?QmFVMXR6V1pZTVp3QUZiUjY3WGR5cXBlM1lYM1ZXTHc4L0hwK3FGY3dBdUtv?=
 =?utf-8?B?UDJneERaWXhRaUZrY0xhR0N3dE52a21KNmZGY3FGRE5TMlRDbktCZzNsaUM0?=
 =?utf-8?B?ZVc1MVcrWGZWN2hCallBd2FrNUJKMk5lQVhMZEhDTDdyQ21LaXVXRGRvT1ll?=
 =?utf-8?B?cUUyTUFHR1Y4RURuVHpVTzZ1RlRrK05NZWJwN1FpWVI1UDNycEU0ckdSM1ZT?=
 =?utf-8?B?cFdJMmsvOVpMZE15MVZtUG03WEpaWVlmTEV1dUZqSElMVkVFeXhVZzFZbmVz?=
 =?utf-8?B?QUQxL3pFLzBlekdkeVZEdGtsbUZrUVg3TGg3djlITDJ2ZkUwd21NbzlCQXll?=
 =?utf-8?B?MFRXQWZSS3luY3Z0U3ozS05yS1NyYWI1T2RSSVV5YlV6NHBuV1hseDhKVEEy?=
 =?utf-8?B?bDB2U2RqL3YwalpCaGR1eDNsUXhvbUR5Q2o1Zz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(30052699003)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 04:37:32.2037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f728beeb-affa-4ffd-bd55-08ddb92228eb
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A79A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7657

From: Ilpo Järvinen <ij@kernel.org>

This change implements Accurate ECN without negotiation and
AccECN Option (that will be added by later changes). Based on
AccECN specifications:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

Accurate ECN allows feeding back the number of CE (congestion
experienced) marks accurately to the sender in contrast to
RFC3168 ECN that can only signal one marks-seen-yes/no per RTT.
Congestion control algorithms can take advantage of the accurate
ECN information to fine-tune their congestion response to avoid
drastic rate reduction when only mild congestion is encountered.

With Accurate ECN, tp->received_ce (r.cep in AccECN spec) keeps
track of how many segments have arrived with a CE mark. Accurate
ECN uses ACE field (ECE, CWR, AE) to communicate the value back
to the sender which updates tp->delivered_ce (s.cep) based on the
feedback. This signalling channel is lossy when ACE field overflow
occurs.

Conservative strategy is selected here to deal with the ACE
overflow, however, some strategies using the AccECN option later
in the overall patchset mitigate against false overflows detected.

The ACE field values on the wire are offset by
TCP_ACCECN_CEP_INIT_OFFSET. Delivered_ce/received_ce count the
real CE marks rather than forcing all downstream users to adapt
to the wire offset.

This patch uses the first 1-byte hole and the last 4-byte hole of
the tcp_sock_write_txrx for 'received_ce_pending' and 'received_ce'.
Also, the group size of tcp_sock_write_txrx is increased from
91 + 4 to 95 + 4 due to the new u32 received_ce member. Below are
the trimmed pahole outcomes before and after this patch.

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2585     0 */
    u8                         nonagle:4;            /*  2585: 0  1 */
    u8                         rate_app_limited:1;   /*  2585: 4  1 */
    /* XXX 3 bits hole, try to pack */
    /* XXX 2 bytes hole, try to pack */

    [...]
    u32                        delivered_ce;         /*  2640     4 */
    u32                        app_limited;          /*  2644     4 */
    u32                        rcv_wnd;              /*  2648     4 */
    struct tcp_options_received rx_opt;              /*  2652    24 */
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2676     0 */
    /* XXX 4 bytes hole, try to pack */

    [...]
    /* size: 3264, cachelines: 51, members: 163 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2585     0 */
    u8                         nonagle:4;            /*  2585: 0  1 */
    u8                         rate_app_limited:1;   /*  2585: 4  1 */
    /* XXX 3 bits hole, try to pack */

    /* Force alignment to the next boundary: */
    u8                         :0;
    u8                         received_ce_pending:4;/*  2586: 0  1 */
    u8                         unused2:4;            /*  2586: 4  1 */
    /* XXX 1 byte hole, try to pack */

    [...]
    u32                        delivered_ce;         /*  2640     4 */
    u32                        received_ce;          /*  2644     4 */
    u32                        app_limited;          /*  2648     4 */
    u32                        rcv_wnd;              /*  2652     4 */
    struct tcp_options_received rx_opt;              /*  2656    24 */
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2680     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 166 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v9:
- Use tcp_data_ecn_check() to set TCP_ECN_SEE flag only for RFC3168 ECN
- Add comments about setting TCP_ECN_SEEN flag for RFC3168 and Accruate ECN
---
 .../networking/net_cachelines/tcp_sock.rst    |   2 +
 include/linux/tcp.h                           |   3 +
 include/net/tcp.h                             |  15 +++
 include/net/tcp_ecn.h                         |  53 +++++++++-
 net/ipv4/tcp.c                                |   5 +-
 net/ipv4/tcp_input.c                          | 100 ++++++++++++++++--
 net/ipv4/tcp_output.c                         |   9 +-
 7 files changed, 175 insertions(+), 12 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 7bbda5944ee2..31313a9adccc 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -101,6 +101,8 @@ u32                           prr_delivered
 u32                           prr_out                 read_mostly         read_mostly         tcp_rate_skb_sent,tcp_newly_delivered(tx);tcp_ack,tcp_rate_gen,tcp_clean_rtx_queue(rx)
 u32                           delivered               read_mostly         read_write          tcp_rate_skb_sent, tcp_newly_delivered(tx);tcp_ack, tcp_rate_gen, tcp_clean_rtx_queue (rx)
 u32                           delivered_ce            read_mostly         read_write          tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
+u32                           received_ce             read_mostly         read_write
+u8:4                          received_ce_pending     read_mostly         read_write
 u32                           lost                                        read_mostly         tcp_ack
 u32                           app_limited             read_write          read_mostly         tcp_rate_check_app_limited,tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
 u64                           first_tx_mstamp         read_write                              tcp_rate_skb_sent
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index bd692764d039..874e0e45dfad 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -287,6 +287,8 @@ struct tcp_sock {
  */
 	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
 		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
+	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
+		unused2:4;
 	__be32	pred_flags;
 	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
 	u64	tcp_mstamp;	/* most recent packet received/sent */
@@ -299,6 +301,7 @@ struct tcp_sock {
 	u32	snd_up;		/* Urgent pointer		*/
 	u32	delivered;	/* Total data packets delivered incl. rexmits */
 	u32	delivered_ce;	/* Like the above but only ECE marked packets */
+	u32	received_ce;	/* Like the above but for rcvd CE marked pkts */
 	u32	app_limited;	/* limited until "delivered" reaches this val */
 	u32	rcv_wnd;	/* Current receiver window		*/
 /*
diff --git a/include/net/tcp.h b/include/net/tcp.h
index ed01ae4be7a9..f024126d5922 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -964,6 +964,14 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
 #define TCPHDR_ACE (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)
 #define TCPHDR_SYN_ECN	(TCPHDR_SYN | TCPHDR_ECE | TCPHDR_CWR)
 
+#define TCP_ACCECN_CEP_ACE_MASK 0x7
+#define TCP_ACCECN_ACE_MAX_DELTA 6
+
+/* To avoid/detect middlebox interference, not all counters start at 0.
+ * See draft-ietf-tcpm-accurate-ecn for the latest values.
+ */
+#define TCP_ACCECN_CEP_INIT_OFFSET 5
+
 /* State flags for sacked in struct tcp_skb_cb */
 enum tcp_skb_cb_sacked_flags {
 	TCPCB_SACKED_ACKED	= (1 << 0),	/* SKB ACK'd by a SACK block	*/
@@ -1773,11 +1781,18 @@ static inline bool tcp_paws_reject(const struct tcp_options_received *rx_opt,
 
 static inline void __tcp_fast_path_on(struct tcp_sock *tp, u32 snd_wnd)
 {
+	u32 ace;
+
 	/* mptcp hooks are only on the slow path */
 	if (sk_is_mptcp((struct sock *)tp))
 		return;
 
+	ace = tcp_ecn_mode_accecn(tp) ?
+	      ((tp->delivered_ce + TCP_ACCECN_CEP_INIT_OFFSET) &
+	       TCP_ACCECN_CEP_ACE_MASK) : 0;
+
 	tp->pred_flags = htonl((tp->tcp_header_len << 26) |
+			       (ace << 22) |
 			       ntohl(TCP_FLAG_ACK) |
 			       snd_wnd);
 }
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index b3430557676b..b0ed89dbad41 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -12,6 +12,7 @@
 
 static inline void tcp_ecn_queue_cwr(struct tcp_sock *tp)
 {
+	/* Do not set CWR if in AccECN mode! */
 	if (tcp_ecn_mode_rfc3168(tp))
 		tp->ecn_flags |= TCP_ECN_QUEUE_CWR;
 }
@@ -19,8 +20,10 @@ static inline void tcp_ecn_queue_cwr(struct tcp_sock *tp)
 static inline void tcp_ecn_accept_cwr(struct sock *sk,
 				      const struct sk_buff *skb)
 {
-	if (tcp_hdr(skb)->cwr) {
-		tcp_sk(sk)->ecn_flags &= ~TCP_ECN_DEMAND_CWR;
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (tcp_ecn_mode_rfc3168(tp) && tcp_hdr(skb)->cwr) {
+		tp->ecn_flags &= ~TCP_ECN_DEMAND_CWR;
 
 		/* If the sender is telling us it has entered CWR, then its
 		 * cwnd may be very low (even just 1 packet), so we should ACK
@@ -36,6 +39,52 @@ static inline void tcp_ecn_withdraw_cwr(struct tcp_sock *tp)
 	tp->ecn_flags &= ~TCP_ECN_QUEUE_CWR;
 }
 
+static inline u8 tcp_accecn_ace(const struct tcphdr *th)
+{
+	return (th->ae << 2) | (th->cwr << 1) | th->ece;
+}
+
+static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
+{
+	tp->received_ce = 0;
+	tp->received_ce_pending = 0;
+}
+
+/* Updates Accurate ECN received counters from the received IP ECN field */
+static inline void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb)
+{
+	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
+	u8 is_ce = INET_ECN_is_ce(ecnfield);
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (!INET_ECN_is_not_ect(ecnfield)) {
+		u32 pcount = is_ce * max_t(u16, 1, skb_shinfo(skb)->gso_segs);
+
+		/* As for accurate ECN, the TCP_ECN_SEEN flag is set by
+		 * tcp_ecn_received_counters() when the ECN codepoint of
+		 * received TCP data or ACK contains ECT(0), ECT(1), or CE.
+		 */
+		if (!tcp_ecn_mode_rfc3168(tp))
+			tp->ecn_flags |= TCP_ECN_SEEN;
+
+		/* ACE counter tracks *all* segments including pure ACKs */
+		tp->received_ce += pcount;
+		tp->received_ce_pending = min(tp->received_ce_pending + pcount,
+					      0xfU);
+	}
+}
+
+static inline void tcp_accecn_set_ace(struct tcphdr *th, struct tcp_sock *tp)
+{
+	u32 wire_ace;
+
+	wire_ace = tp->received_ce + TCP_ACCECN_CEP_INIT_OFFSET;
+	th->ece = !!(wire_ace & 0x1);
+	th->cwr = !!(wire_ace & 0x2);
+	th->ae = !!(wire_ace & 0x4);
+	tp->received_ce_pending = 0;
+}
+
 static inline void tcp_ecn_rcv_synack(struct tcp_sock *tp,
 				      const struct tcphdr *th)
 {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 18b6cb7dc02e..907232076b4a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -271,6 +271,7 @@
 #include <net/icmp.h>
 #include <net/inet_common.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <net/mptcp.h>
 #include <net/proto_memory.h>
 #include <net/xfrm.h>
@@ -3392,6 +3393,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->window_clamp = 0;
 	tp->delivered = 0;
 	tp->delivered_ce = 0;
+	tcp_accecn_init_counters(tp);
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5118,6 +5120,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, snd_up);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
@@ -5125,7 +5128,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 91 + 4);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 95 + 4);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index da4245718e63..56c8514ee139 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -360,16 +360,25 @@ static void tcp_data_ecn_check(struct sock *sk, const struct sk_buff *skb)
 		if (tcp_ca_needs_ecn(sk))
 			tcp_ca_event(sk, CA_EVENT_ECN_IS_CE);
 
-		if (!(tp->ecn_flags & TCP_ECN_DEMAND_CWR)) {
+		if (!(tp->ecn_flags & TCP_ECN_DEMAND_CWR) &&
+		    tcp_ecn_mode_rfc3168(tp)) {
 			/* Better not delay acks, sender can have a very low cwnd */
 			tcp_enter_quickack_mode(sk, 2);
 			tp->ecn_flags |= TCP_ECN_DEMAND_CWR;
 		}
+		/* As for RFC3168 ECN, the TCP_ECN_SEEN flag is set by
+		 * tcp_data_ecn_check() when the ECN codepoint of
+		 * received TCP data contains ECT(0), ECT(1), or CE.
+		 */
+		if (!tcp_ecn_mode_rfc3168(tp))
+			break;
 		tp->ecn_flags |= TCP_ECN_SEEN;
 		break;
 	default:
 		if (tcp_ca_needs_ecn(sk))
 			tcp_ca_event(sk, CA_EVENT_ECN_NO_CE);
+		if (!tcp_ecn_mode_rfc3168(tp))
+			break;
 		tp->ecn_flags |= TCP_ECN_SEEN;
 		break;
 	}
@@ -385,10 +394,64 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 				bool ece_ack)
 {
 	tp->delivered += delivered;
-	if (ece_ack)
+	if (tcp_ecn_mode_rfc3168(tp) && ece_ack)
 		tcp_count_delivered_ce(tp, delivered);
 }
 
+/* Returns the ECN CE delta */
+static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
+				u32 delivered_pkts, int flag)
+{
+	const struct tcphdr *th = tcp_hdr(skb);
+	struct tcp_sock *tp = tcp_sk(sk);
+	u32 delta, safe_delta;
+	u32 corrected_ace;
+
+	/* Reordered ACK or uncertain due to lack of data to send and ts */
+	if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
+		return 0;
+
+	if (!(flag & FLAG_SLOWPATH)) {
+		/* AccECN counter might overflow on large ACKs */
+		if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
+			return 0;
+	}
+
+	/* ACE field is not available during handshake */
+	if (flag & FLAG_SYN_ACKED)
+		return 0;
+
+	if (tp->received_ce_pending >= TCP_ACCECN_ACE_MAX_DELTA)
+		inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
+
+	corrected_ace = tcp_accecn_ace(th) - TCP_ACCECN_CEP_INIT_OFFSET;
+	delta = (corrected_ace - tp->delivered_ce) & TCP_ACCECN_CEP_ACE_MASK;
+	if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
+		return delta;
+
+	safe_delta = delivered_pkts -
+		     ((delivered_pkts - delta) & TCP_ACCECN_CEP_ACE_MASK);
+
+	return safe_delta;
+}
+
+static u32 tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
+			      u32 delivered_pkts, int *flag)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	u32 delta;
+
+	delta = __tcp_accecn_process(sk, skb, delivered_pkts, *flag);
+	if (delta > 0) {
+		tcp_count_delivered_ce(tp, delta);
+		*flag |= FLAG_ECE;
+		/* Recalculate header predictor */
+		if (tp->pred_flags)
+			tcp_fast_path_on(tp);
+	}
+	return delta;
+}
+
 /* Buffer size and advertised window tuning.
  *
  * 1. Tuning sk->sk_sndbuf, when connection enters established state.
@@ -3744,7 +3807,8 @@ static void tcp_xmit_recovery(struct sock *sk, int rexmit)
 }
 
 /* Returns the number of packets newly acked or sacked by the current ACK */
-static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered, int flag)
+static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered,
+			       u32 ecn_count, int flag)
 {
 	const struct net *net = sock_net(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -3752,8 +3816,12 @@ static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered, int flag)
 
 	delivered = tp->delivered - prior_delivered;
 	NET_ADD_STATS(net, LINUX_MIB_TCPDELIVERED, delivered);
-	if (flag & FLAG_ECE)
-		NET_ADD_STATS(net, LINUX_MIB_TCPDELIVEREDCE, delivered);
+
+	if (flag & FLAG_ECE) {
+		if (tcp_ecn_mode_rfc3168(tp))
+			ecn_count = delivered;
+		NET_ADD_STATS(net, LINUX_MIB_TCPDELIVEREDCE, ecn_count);
+	}
 
 	return delivered;
 }
@@ -3774,6 +3842,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	u32 delivered = tp->delivered;
 	u32 lost = tp->lost;
 	int rexmit = REXMIT_NONE; /* Flag to (re)transmit to recover losses */
+	u32 ecn_count = 0;	  /* Did we receive ECE/an AccECN ACE update? */
 	u32 prior_fack;
 
 	sack_state.first_sackt = 0;
@@ -3881,6 +3950,11 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 
 	tcp_rack_update_reo_wnd(sk, &rs);
 
+	if (tcp_ecn_mode_accecn(tp))
+		ecn_count = tcp_accecn_process(sk, skb,
+					       tp->delivered - delivered,
+					       &flag);
+
 	tcp_in_ack_event(sk, flag);
 
 	if (tp->tlp_high_seq)
@@ -3905,7 +3979,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	if ((flag & FLAG_FORWARD_PROGRESS) || !(flag & FLAG_NOT_DUP))
 		sk_dst_confirm(sk);
 
-	delivered = tcp_newly_delivered(sk, delivered, flag);
+	delivered = tcp_newly_delivered(sk, delivered, ecn_count, flag);
+
 	lost = tp->lost - lost;			/* freshly marked lost */
 	rs.is_ack_delayed = !!(flag & FLAG_ACK_MAYBE_DELAYED);
 	tcp_rate_gen(sk, delivered, lost, is_sack_reneg, sack_state.rate);
@@ -3914,12 +3989,16 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	return 1;
 
 no_queue:
+	if (tcp_ecn_mode_accecn(tp))
+		ecn_count = tcp_accecn_process(sk, skb,
+					       tp->delivered - delivered,
+					       &flag);
 	tcp_in_ack_event(sk, flag);
 	/* If data was DSACKed, see if we can undo a cwnd reduction. */
 	if (flag & FLAG_DSACKING_ACK) {
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
 				      &rexmit);
-		tcp_newly_delivered(sk, delivered, flag);
+		tcp_newly_delivered(sk, delivered, ecn_count, flag);
 	}
 	/* If this ack opens up a zero window, clear backoff.  It was
 	 * being used to time the probes, and is probably far higher than
@@ -3940,7 +4019,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 						&sack_state);
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
 				      &rexmit);
-		tcp_newly_delivered(sk, delivered, flag);
+		tcp_newly_delivered(sk, delivered, ecn_count, flag);
 		tcp_xmit_recovery(sk, rexmit);
 	}
 
@@ -6041,6 +6120,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 					flag |= __tcp_replace_ts_recent(tp,
 									delta);
 
+				tcp_ecn_received_counters(sk, skb);
+
 				/* We know that such packets are checksummed
 				 * on entry.
 				 */
@@ -6085,6 +6166,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			/* Bulk data transfer: receiver */
 			tcp_cleanup_skb(skb);
 			__skb_pull(skb, tcp_header_len);
+			tcp_ecn_received_counters(sk, skb);
 			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
 			tcp_event_data_recv(sk, skb);
@@ -6125,6 +6207,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 		return;
 
 step5:
+	tcp_ecn_received_counters(sk, skb);
+
 	reason = tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT);
 	if ((int)reason < 0) {
 		reason = -reason;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 2f1102616024..78018870a389 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -328,7 +328,14 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	if (tcp_ecn_mode_rfc3168(tp)) {
+	if (!tcp_ecn_mode_any(tp))
+		return;
+
+	if (tcp_ecn_mode_accecn(tp)) {
+		INET_ECN_xmit(sk);
+		tcp_accecn_set_ace(th, tp);
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
+	} else {
 		/* Not-retransmitted data segment: set ECT and inject CWR. */
 		if (skb->len != tcp_header_len &&
 		    !before(TCP_SKB_CB(skb)->seq, tp->snd_nxt)) {
-- 
2.34.1


