Return-Path: <linux-kselftest+bounces-37516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DD5B09727
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 01:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E12B67AF2A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 23:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF02224166E;
	Thu, 17 Jul 2025 23:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="XS83O6M5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010020.outbound.protection.outlook.com [52.101.84.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C9D2F850;
	Thu, 17 Jul 2025 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794647; cv=fail; b=QLnxfwXroULF/zCz+pd0Bm7L3d9Iw76cUFXFeApLJNSCJeooO6X4T+ku/2Wb+zlz8epkLnIOkAriiv71LiWGyM9mQbTxY8GkYYMt7DIXcyDNGIlYQiD9mcuPbvm9CjiDz/sAlcxYNi0+6uMK/UBYSSccNRYgOE28MTiIAY0YLTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794647; c=relaxed/simple;
	bh=Owbyar8jWuPxuheAcxnrn6fYqrC1v6BnMLKDln0LUxc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uRAwYAaYzkUDMiuedOlSmsSwt7n20WzAFtwoi8FZxiBVbvvSIUR1cEJn8aRnni0zo2yklF4cEXk1Oh9qKFsHg+OeGVowkGPK5QWsv4sZw6EgVzhKw5xXLG1T294yP5qF825biO5fu385qlZZO6H2uaMoNPXbUTNPi7zRLjVEvT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=XS83O6M5; arc=fail smtp.client-ip=52.101.84.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTQJ5DNa1u5eSnD39T8Ub0UwdW1NYxfZJ6BwnwuI4gWzLG7ozPMfcRKfcuRMYv6zeo+pSvmwLC8kSwBpIDVURMyJdyhkwCRZOafAFra/9wvPYiaNdRsh24gjVL4R+OWI5X/rYDSSGg7JBuY8JY834DhdDpQNkt4bjDxncgjlGIv7Cew6vnjGMuujED6N2Ac2hBvqe+IVPGnSoT+nwktc6Ed6C4NWtrUVKH6hxJtTwhX5eWzAqCUyEY8qK/+OM526HBc4IjjFe7HozozPfvo/5BC9AM69DKDRT5NAXfExzzNYFfG6rFm64O1W+Nuflvj6fdSIR5oyicIG8HjhARadvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1xjOikRh7AHYzsgJfHlChF5zmMbDE/33ebnY86L3XA=;
 b=L/I4JIyT+1bNYO2MoAa2FYtxdWf/zi5tz6RGdQ1148+2d/hZMv+jqkUOR+GyKOvkh1gkc/IAtV/9C0AaVI+XFT5DcWY3Duk8PmCNz3RrkSDHkNuNTQeLVY/mxEvkWy/nz3pVp+yu8FLs+JmlapCdVxtAbnNZ7b8s67Ufhf63Iki01FHH5Es5noSW9SkFPIQPz24L1OrHQS5qCY3IOIBx5uFNEQFFaQuFTWAXT/YFODs+bzQDTH6dK6Er96ElJvhFviBPuZ+zcV735yET1k7l0lySKwi4UX45fEOWeP266kQf+6dkU0wTQEXe6wvnJyneUGAhT4JpOZOF1s22kfKS+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.100) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1xjOikRh7AHYzsgJfHlChF5zmMbDE/33ebnY86L3XA=;
 b=XS83O6M53JF9ad/A4QmqrkKCK3h+adScVnTw6IJemmkEXpBuQaFwakX3A0C/RJTmk5YioJ0bQSTS8V/InrRlwyi2tVD0Qj3VP7g8UU6Ns5CuPViYEz/m8dLlKMj2IuI8y4YyK1YrduB93tKEFr51aG1Fo22Bz22ydBSsFgtNckrRLa1ec1QfL5ETNn1/9/fwEGU+YHKWvbnc2bp2WojKVRcf1JIxt7QpbjdufQd0xId4Au1Ht61dvcfX8gHa4Nl1XB+vh06JtitfcdHXgYVsT0fUFxiovX7bq+t1OaS26fe7QRrjyxxhc03ARqavp1uypZ2bt5FAzGDf+N01eamWww==
Received: from AM6PR04CA0056.eurprd04.prod.outlook.com (2603:10a6:20b:f0::33)
 by GV4PR07MB10549.eurprd07.prod.outlook.com (2603:10a6:150:29b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 23:24:02 +0000
Received: from AM2PEPF0001C715.eurprd05.prod.outlook.com
 (2603:10a6:20b:f0:cafe::d0) by AM6PR04CA0056.outlook.office365.com
 (2603:10a6:20b:f0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Thu,
 17 Jul 2025 23:24:01 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.100) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM2PEPF0001C715.mail.protection.outlook.com (10.167.16.185) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21
 via Frontend Transport; Thu, 17 Jul 2025 23:24:00 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 253E5680034;
	Fri, 18 Jul 2025 02:23:59 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: alok.a.tiwari@oracle.com,
	donald.hunter@gmail.com,
	xandfury@gmail.com,
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
	horms@kernel.org,
	andrew+netdev@lunn.ch,
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
Subject: [PATCH v11 iproute2-next 0/1] DUALPI2 iproute2 patch
Date: Fri, 18 Jul 2025 01:23:56 +0200
Message-Id: <20250717232357.69185-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C715:EE_|GV4PR07MB10549:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 12c23e22-59da-43bb-625f-08ddc58902f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qpqn3WbSLfil3Nq/ourgwHvHDkmXNM37ECXY3aEXmSWEwwm2MqxSD9UaGW08?=
 =?us-ascii?Q?Bh0m3g8n3qVYYeHFZThZ5nFjndTeVHCnXEO5n21jYGs+cU5ltd/7KiNjDfco?=
 =?us-ascii?Q?fS8+IhJGdnwrzZaJZE/46Aguqh5oJm75quxmXaf1PkdynTnSGwZRy/hjqnnl?=
 =?us-ascii?Q?DYb6ic620kx4xEWfT2mq0FRXjWszDlJpTpF6tnRqZtU2Dy+7bbq7dUt9f2oI?=
 =?us-ascii?Q?dc8AYQVPzQ6l5o2rVU3mgw83IELJz1nI6rk0QVl+3qMeNSu9RhM3mqFGcyQV?=
 =?us-ascii?Q?RC2IwDDPkWmSnlMaMn2li4yKAUZmH0oRoIOlp5k4zk4Fy/YH7uokkbcTxKtK?=
 =?us-ascii?Q?ihKyuUyFzGP2rv3KmJcTrFdLqbotwWFYlT+0sAkBCyTOmEfd51vZq2sqrH88?=
 =?us-ascii?Q?J0uPinm2QYsqA6+wcx5XhAK6lUsOzfDc6P20tjnSdPYS7165e4ux/0dA8HJv?=
 =?us-ascii?Q?leV+IRzn4eYiZwu/8EEc8WWo02tTChCuAFDzOads+AOEkh28s0IroO26cJtm?=
 =?us-ascii?Q?w+sTsSO1Nw4aqeGlfvDoNjpXrB1CL8DD4Z4heA+jkqaaz6jdgUIvAHJ+MUFU?=
 =?us-ascii?Q?TjTZ5GA06b/FEKig1/8Qd1h9lbciTJDZ4iTqTE9B/t7c4RK49FjMbydKylzf?=
 =?us-ascii?Q?5/p5erC40tg6loDdcQTBOU0VZBCOvyFUqYI9fp3akBsRnXpzQaB1zdRuDmnb?=
 =?us-ascii?Q?WD7CZXSjkX9K0zD4Thr6KOmDapUIMbZ8a5VGMp3NjagYrYImupvAlyRsAqm8?=
 =?us-ascii?Q?IOaMmY2XRbp9Y43U6Ku2gxbkWE/HAv02qtdIRf/h3mTDiUIVZouDILNAuhiy?=
 =?us-ascii?Q?OpxG5gu6jNlwDsz+zOtPeeV4phkzA9Fz/f1y4t2kLgYOPXBzBIoNFuopiHBX?=
 =?us-ascii?Q?QUlf02/AcU1SoUSEAmAR1hzVOagPdCn+5SepkabvWzb1iZEDP+bHppsZPrSn?=
 =?us-ascii?Q?5UXcdumfetRhsxJD28rLSc1eIn+JOQ6+kbqmVTsVTQxqsR1WxzS/zvomAcp6?=
 =?us-ascii?Q?k2zCe6E161uXUsm0O8HBMxs+JD6v1Nev5FYSXnNMUAKW9nl9K5iZ8SbPZlhO?=
 =?us-ascii?Q?/aVEOut+jqQ6lQGqRJxPoHxfUQdkDYjG38SfDbepYeu3IjFaxGEbqBv0mrVL?=
 =?us-ascii?Q?i6enYTIcELfHMoP92J4yPGJfaV18+phdoaJ1JgQFK1Uxqx1XnxRt4FMaGdsL?=
 =?us-ascii?Q?hizqUCPaCiLi30H85aKhgEYQCltaQ9cpJZ+YPDRzP8nQ4v2ZEU/zprcEw8qe?=
 =?us-ascii?Q?hrTDsTF/YO51GL7vbO93kMY90ztU+1RNEsZu4ami3lF8nOAZS4NDJp9lkydM?=
 =?us-ascii?Q?zMfi8buCUQvKR8DCj69IAuh+F6yVtz0qRNcc87GJFEMt+fOoSL356IlbDH/W?=
 =?us-ascii?Q?LSuZqCXDGSD/FmArcJReVWjQiL6Xz2skBlBgPhpElfyAybd1NbVbbRIofv+G?=
 =?us-ascii?Q?mTM3stxWN/IE4dW0tG7BttnKtYbmgKOM9HRjhudly5tV51zMi4AzjzrimVfS?=
 =?us-ascii?Q?dn22Xwu3E1LKdI0hVF1Glko8xHvXoFOgt/Jjq8sDp9sYkKW7Jsype4f8Xg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 23:24:00.6163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c23e22-59da-43bb-625f-08ddc58902f2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C715.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR07MB10549

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find DUALPI2 iproute2 patch v11.

For more details of DualPI2, please refer IETF RFC9332
(https://datatracker.ietf.org/doc/html/rfc9332).

Best Regards,
Chia-Yu

---
v11 (18-Jul-2025)
- Replace TCA_DUALPI2 prefix with TC_DUALPI2 prefix for enums (Jakub Kicinski <kuba@kernel.org>)

v10 (02-Jul-2025)
- Replace STEP_THRESH and STEP_PACKETS w/ STEP_THRESH_PKTS and STEP_THRESH_US of net-next patch (Jakub Kicinski <kuba@kernel.org>)

v9 (13-Jun-2025)
- Fix space issue and typos (ALOK TIWARI <alok.a.tiwari@oracle.com>)
- Change 'rtt_typical' to 'typical_rtt' in tc/q_dualpi2.c (ALOK TIWARI <alok.a.tiwari@oracle.com>)
- Add the num of enum used by DualPI2 in pkt_sched.h

v8 (09-May-2025)
- Update pkt_sched.h with the one in nex-next
- Correct a typo in the comment within pkt_sched.h (ALOK TIWARI <alok.a.tiwari@oracle.com>)
- Update manual content in man/man8/tc-dualpi2.8 (ALOK TIWARI <alok.a.tiwari@oracle.com>)
- Update tc/q_dualpi2.c to fix missing blank lines and add missing case (ALOK TIWARI <alok.a.tiwari@oracle.com>)

v7 (05-May-2025)
- Align pkt_sched.h with the v14 version of net-next due to spec modification in tc.yaml
- Reorganize dualpi2_print_opt() to match the order in tc.yaml
- Remove credit-queue in PRINT_JSON

v6 (26-Apr-2025)
- Update JSON file output due to spec modification in tc.yaml of net-next

v5 (25-Mar-2025)
- Use matches() to replace current strcmp() (Stephen Hemminger <stephen@networkplumber.org>)
- Use general parse_percent() for handling scaled percentage values (Stephen Hemminger <stephen@networkplumber.org>)
- Add print function for JSON of dualpi2 stats (Stephen Hemminger <stephen@networkplumber.org>)

v4 (16-Mar-2025)
- Add min_qlen_step to the dualpi2 attribute as the minimum queue length in number of packets in the L-queue to start step marking.

v3 (21-Feb-2025)
- Add memlimit to the dualpi2 attribute, and add memory_used, max_memory_used, and memory_limit in dualpi2 stats (Dave Taht <dave.taht@gmail.com>)
- Update the manual to align with the latest implementation and clarify the queue naming and default unit
- Use common "get_scaled_alpha_beta" and clean print_opt for Dualpi2

v2 (23-Oct-2024)
- Rename get_float in dualpi2 to get_float_min_max in utils.c
- Move get_float from iplink_can.c in utils.c (Stephen Hemminger <stephen@networkplumber.org>)
- Add print function for JSON of dualpi2 (Stephen Hemminger <stephen@networkplumber.org>)

---
Chia-Yu Chang (1):
  tc: add dualpi2 scheduler module

 bash-completion/tc             |  11 +-
 include/uapi/linux/pkt_sched.h |  68 +++++
 include/utils.h                |   2 +
 ip/iplink_can.c                |  14 -
 lib/utils.c                    |  30 ++
 man/man8/tc-dualpi2.8          | 249 ++++++++++++++++
 tc/Makefile                    |   1 +
 tc/q_dualpi2.c                 | 528 +++++++++++++++++++++++++++++++++
 8 files changed, 888 insertions(+), 15 deletions(-)
 create mode 100644 man/man8/tc-dualpi2.8
 create mode 100644 tc/q_dualpi2.c

-- 
2.34.1


