Return-Path: <linux-kselftest+bounces-23652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7779F8F16
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 10:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF21F7A2585
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 09:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390F91AAA3D;
	Fri, 20 Dec 2024 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k5DpVzoJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011044.outbound.protection.outlook.com [52.101.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FBA1A840F;
	Fri, 20 Dec 2024 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734687376; cv=fail; b=LeppvXmJxJv+Sk+0WiCzV600O7iRq8Fwdj8Yn0xu4AwNgCTbF4VKGl11uxMziLdK00y8IihSuDMIsEjU1mEndNvHqnBBJlr0fIM8IRJw3HrGVuZAb8eluO4V1ll4bGU6HOYbck+CTdUUH6VBn1DRVewIqqKkkCgud3jTfjAgw40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734687376; c=relaxed/simple;
	bh=t95/TClJPZIvWeuRdlrksawbmrXagTjQXpsb9SUvOTY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PEHkl6LVtSpMdRQXAX+qp6+CISiQp9Dak6YVEwn+lxSZPYRCCvX96P/H6WoXMdkYVhDCRwu468mCbz7FMtpHoBcaU4dPEkkXH0b/3tRqE8BbCHoXzf0f5wNLq/y8LIhN6QpsVAjvK71gMUxX8/0Bsn4IXrkD93zzzwp3dB3TXpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k5DpVzoJ; arc=fail smtp.client-ip=52.101.70.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SiglDt5N7Sk56V3xBD5xN+ct4uLF5pX5fz5r2/iKn6FBAvjT+zR1gfJAvc+VZ5xbXVWDir2zV6Ox1NXfQla7IKeQZvM3vTkUyum6jwyYVItq5wao4DVrNAi1llyxzjgL1qXZwT++vTRPZu1Jnzjb+qNoEoKluR2DmuNnk7KFCAw2bQwfvObjbsWftm1Bkc7t8pXRt8XXnp7Fy1WIL8QxvWFxa2QSVQnS4O4fEmAwcruLgKEZemlrnNmZFZSsw/R7L2LZdvuP2yjQaAjxzDDmKt2IAFJNH9sDJaaWLQi4J/yUWpeAaf6SwgVHSZ3MxNv1QHVsXNsqC0XcBTP8ySR4Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/FlyTJUC3wJeeKxFbl/Bj4pj/DLPbPYuLp0tQ+Jd4A=;
 b=T+vfkOLgkpRf71dP8M1v75fCV6CMfcv2H10+b49XMNK0DbldfyYiVGNf8bGdkRLK+2oXj4OUMVZDosDwcd3b/DBrIqjDaArpryrhw4y1PpNJ4RZhRc+b7Q8TAG74x23dmOinR4SqyG9LZ65t9gWHNbmoaaQtUntjY34jfCq7/MUVN/UozkyVjX6cHXi4LHFkJvBBrV9mu10HQSjoOeId3XF4fxqtpMXos9i+fDy/TTrBWoStB/d6MxBwqbyzcdJe7wufyFoJ4prrT5dQ7CxNWRnctPX0Wb5L8/SJf4OjPHpShFByf9qgTA0BH2tKyiXMYOSevnflLfVLENe/p8EiUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/FlyTJUC3wJeeKxFbl/Bj4pj/DLPbPYuLp0tQ+Jd4A=;
 b=k5DpVzoJkMOp34Ui2dBj50sTohp/iWQlo0+JXNFH+ey6/Zk6R8JWn9r4oKgJAlc+G+BHKwjWBtFnvCaAwl4uX8MYb82Yt3DqZ6c9fwsReNHPNhHz6b+aTY+KhFtysNOdfOaUNAFDYZx4N9r9OWE3ko2Mw/Vg0l1MA7AtncmcNGaNo8tZuMeY8M2UblpdkDBOGg+I45pt6OSF8Mv40E6nysj4Z3FnwG5GOrtFUo4y1Hc6BN/eGmfY5xIisLoWGA56WpLFmcpjIJ1Ljp6okM7gh7hoRjQiRZ76g1znlOBROFxx3yQAaE+spsG+wY36A666RQwy6C+qt5IamB9vN4lQew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB10292.eurprd04.prod.outlook.com (2603:10a6:800:243::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 09:36:11 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 09:36:11 +0000
From: Wei Fang <wei.fang@nxp.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH bpf] selftests/bpf: add XDP_UMEM_TX_METADATA_LEN flag to umem_config
Date: Fri, 20 Dec 2024 17:18:06 +0800
Message-Id: <20241220091806.1856223-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0113.apcprd03.prod.outlook.com
 (2603:1096:4:91::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI0PR04MB10292:EE_
X-MS-Office365-Filtering-Correlation-Id: d58fb74a-144d-40c1-ebf5-08dd20d9bd4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nA9mJ7xpVyCgymRuDZhIZwl0EjZKFeSYdjtgPML7RwkM5v4OcPMneDaavVd/?=
 =?us-ascii?Q?V21mGHFze386xV2dbhp3+Cs/NJ+L8m2tHen4vu3bRAH93lv19No4a5A50QPr?=
 =?us-ascii?Q?r3D/goO0g7Q8Lf3YVLUDyvt4ZlvaktuZN9gYPSWjVTyRgHTUQkkjP3DY1g7n?=
 =?us-ascii?Q?NocsdMkbpW7Z6yoXvz49rrCsT7rusaSTQHqeApWjg9Bh5eUpJW/YWsteIpXu?=
 =?us-ascii?Q?yThpCPB8ruwLmQQzW8rQmZ+RMAfzfg0VLRJ6zKM2ZbCeL6A3aYjdnTNjutEt?=
 =?us-ascii?Q?p3OXWwNBmUZkY1mhxrFbtlFfOp4EOq1BYCK9UR3pqNf6SXCxa8AVOpsduA2Z?=
 =?us-ascii?Q?I7DD3IFLwh6FAA2yhQfjJZclNRYDyTMDoXjJRv1aKaK5pYzwyWCOMqi0uGP5?=
 =?us-ascii?Q?gbEXyu853UpsUNSqEiYWyE58thhRhGe4/CWz2ZSI9Qivx1EF7QI7/SOifHe7?=
 =?us-ascii?Q?eH7XfbpsShbDYsCNDGlL16gdS2CcH+IpLECyGVvMb/eieffqZVnZigsniOOu?=
 =?us-ascii?Q?tJ5tNZINAvSrvCNIfqxTEfqbnBH1z92cWuky/W0WfLZfXFp8p0MSpEQMJt0H?=
 =?us-ascii?Q?pGaSvGkhjM1HlUSJTr8O3mtkBWMTNKNarc8fGqoOy2uJrEIUXBa8PGIcyg/Q?=
 =?us-ascii?Q?ChBEG8BsylASmNvXErb4kAmepwpTX+BTHSzU5SkubpjvplQ5X49OsaU/QlRc?=
 =?us-ascii?Q?jzKUQdRswYad3YnUJWqj4ZPIFdoEaEvD9TNogR7nDkQouQy5beZH4udPBOer?=
 =?us-ascii?Q?hiKfrTCd5w2GGOn/SKjsZp4H6tUaWAQLkfM4TTFb3d9pw/xqmXboTTPMUCml?=
 =?us-ascii?Q?JEupkUNU13AnTi1MPuZqmlKkR4ELGJafGEcuH/0+BHemGbOj+XvmNFCMbV6i?=
 =?us-ascii?Q?zRQtSr1x9F0yMHrBa5hybeW5bxoJztcF4Gp22IuxXfrza2yK0rwfC8vz8/NV?=
 =?us-ascii?Q?X9aGkJdXceCZx3cJIPoz7wqxdFGpXdOVomfIbW/R1nSRumfH0myhglTapmWr?=
 =?us-ascii?Q?+/UdRZQaBxXSr1cHLN9sbCSTltowgKRS34+xgi1DOU351LZQDTMP7j5APcQ9?=
 =?us-ascii?Q?0Ju0zBCGuFUlksQW/NOpQMkCP1VxTQ32RPPuvwUFnfgQ7AqdbMaX6mmd/xfV?=
 =?us-ascii?Q?I6dVrSa8letnxGE+rNvptZy3wwwv3l3odp7HGZ497J6kzC52tAxubh1zjU4O?=
 =?us-ascii?Q?4MteZUNKK4PTxvCPqGjX8Mf/NjgPDu2fMD9AgsywsRWAIQIuNlt1lYVqZMRy?=
 =?us-ascii?Q?R0bW9iB508474Kkf4xkJH5m3KBXOH1vl5j+J5b/X9y+bWCPTcM7CI1OgxN4k?=
 =?us-ascii?Q?tUU1b1eT2pedU+4WrQpItgTAZmcnMzRkHP1lWjhsK0USqTpAIshZXZzPtx1j?=
 =?us-ascii?Q?8YnO1C+j1iVegRNnr9EHpZKdUeQZBgauCjzn13kd8ZTzAV/Md/3IU+RrSfAi?=
 =?us-ascii?Q?HMVf/j+KMMSPRBI7GWKyzLmlePM//BEX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iWWTXCWj+Y50cTeTPYfTUhskwuIBx2MTrNH5lgrs/aKhBhEwaVOUD5lWxv5o?=
 =?us-ascii?Q?X7jj+fDrhB1cyML6fs11lP43tSx5AQTUEnW9r848hIAyt21CdIx7vsp97arS?=
 =?us-ascii?Q?5CJSg9yXeL7U6Bl5yPOAH93l8NVKB57zU+TjpY4O5SlX7RVIoXXKFGszf18z?=
 =?us-ascii?Q?n5FuvDLZHd21aUhIo0k0NyZNzXZJh0PEdr8m4tuU6SllZlm8+u7gUq7VboJc?=
 =?us-ascii?Q?wRjlV9Snlmch9NJNOvNb48XideNoxCvmXqevu5+gWbzuSpGUQr7L+E6i6O2b?=
 =?us-ascii?Q?YLuaYl1DmmCEyZVeaTrgnLCV636lgE9PwAAWHlm3vyKAO588Rv7n30kI4Qat?=
 =?us-ascii?Q?plsLVx4eY4e0ut6g5gNvhmgZgKGHrYrXbKD8qyKn7tgp6euTWqK25bnf0onm?=
 =?us-ascii?Q?LwH4GKAOnFExSeMwOZVDICVdAIHNXIZ4mOD3llxAND2hDLj9Nnzwg0X6l46Z?=
 =?us-ascii?Q?PqF6QUuYPZ+mCMBQLbOQCQE5yMU661sE42r8H5A3+WsYsWxWH7d4TTcIjjCG?=
 =?us-ascii?Q?getjKtBv6oG19WieCEf74jh0o9uYxW5Dp4mH9TqlAaBYvguldpSC1ThZFfMc?=
 =?us-ascii?Q?SMuf5DgbhEFh9cLWZWLyxZLcoT+wpM6SZHtyxTqyG8cdoyOzK5srZo0bfTh+?=
 =?us-ascii?Q?ubbZlroVhQLggMDwCjQWGz/Wqka1jKvY9a6WIdohXDlvNR+yel6E1uFOXuYd?=
 =?us-ascii?Q?nQDwysX2sV7oEQiGfLw0pvI9wgXdNo7QEapxESVU+4ovqVvguZEvP0YBZq0O?=
 =?us-ascii?Q?rSL3VMzqaEtxF0HzPQNKtH3x1YTvXuYkRcFsAxsEkh4rbYvMBr1pHChofAqY?=
 =?us-ascii?Q?GhlmPr6yk6DnRwfA3cnvvoxyysrUPa79CTp2eNJ8o8V81kEBDEp2nIVd8Sos?=
 =?us-ascii?Q?spulC0rhZQ4iCz5UePXdNLbV+gqyYRU5xZnZaIS4xSMBhxJzkrYeZ7JJCKzL?=
 =?us-ascii?Q?hBPzU6v/PJXVpNQRzJzXLC7VHGHTZT/qVqElDJYi3uJ2eg9IXH2PBSlKkEjm?=
 =?us-ascii?Q?GvdknGu3Gs3jyA8nTtmMU7Tn44RGZe2fbUtDgO5kIO80gqdEyjjvfYHIOROJ?=
 =?us-ascii?Q?OBAWGb+ehUX5S6daVmMli1mCfOyE4mQVdCzybG2Zy9bOqpn+sOXoza9e0yqT?=
 =?us-ascii?Q?BY/WdK4VrKnrjW2Q5q/NzT1e5SWdCoN+oeFWFDLRIPnuoqPgjRWwZq2tSpPj?=
 =?us-ascii?Q?O+O4bzuqmmW2b/hRv4ex2HM0t0Jt98SxrXu14qeK2OfK5v82paqogsM1Uq8O?=
 =?us-ascii?Q?TwKHCE6Gwx5MHNG5ALYDfs0MUG+ysA5ref7Avj/QYXlmmXRA2yLaK6uDKT88?=
 =?us-ascii?Q?PoL137sXcP5g7RcwzqUwRI8xsl7n/6cgJ4A69zY0ett3mtz446RiIqmsaLZo?=
 =?us-ascii?Q?k4NDizoTN1kmIiQArJi9zVFpc8zYsLzdIbJdSNLZtqH1Dh8wujXbHN4xH1ek?=
 =?us-ascii?Q?CzLBZ7lPNofeUTeww/0ZbAUlqnuZYYqsZNrhpGwICQnhbt075S3/+dA0oM6z?=
 =?us-ascii?Q?9VgTRPDc8dcWJiD+UO6pfL+XL8JkQJ2Cb/LUJnJ4lpkfyQ7OpX0rKSUw1D66?=
 =?us-ascii?Q?2dnCyPalwFoguAubxg3UOfGAQGcGHZ+SCh468jsk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58fb74a-144d-40c1-ebf5-08dd20d9bd4f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 09:36:11.5684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5HK5MCV6LPb6JGc/wpCRHgZK/aMLzxyPPghGqm19pZSC5Vxz1k45qzQpVzGZDIU6kUnpvf85E9NVGvgKhccwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10292

The Tx metadata test has been broken since the commit d5e726d9143c ("xsk:
Require XDP_UMEM_TX_METADATA_LEN to actuate tx_metadata_len"). Because
this change requires XDP_UMEM_TX_METADATA_LEN flag to be set, otherwise
xsk_buff_pool::tx_metadata_len will be initialized to 0, which means that
the driver cannot get Tx metadata and cannot execute AF_XDP Tx metadata
hooks.

Fixes: d5e726d9143c ("xsk: Require XDP_UMEM_TX_METADATA_LEN to actuate tx_metadata_len")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 6f9956eed797..ad6c08dfd6c8 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -79,7 +79,7 @@ static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id)
 		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
 		.comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
 		.frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE,
-		.flags = XSK_UMEM__DEFAULT_FLAGS,
+		.flags = XDP_UMEM_TX_METADATA_LEN,
 		.tx_metadata_len = sizeof(struct xsk_tx_metadata),
 	};
 	__u32 idx = 0;
-- 
2.34.1


