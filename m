Return-Path: <linux-kselftest+bounces-44940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 494AEC3A6BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 12:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3961A46B69
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 11:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4442F30C60A;
	Thu,  6 Nov 2025 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OOW+z1Um"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E33A24DCE2;
	Thu,  6 Nov 2025 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426826; cv=fail; b=Ylmh7pUmkXcxLmbRbyjvW0WdLn5KFgPo6mWg/3rrcwDaEPonDOBnHquc0cylCWwDjre4VHinmP8bgTiKx7MSC65y/fPu9U3X79WveAvjAJsRtDwpkwYwaIGT5twajsjl6xzVIw51t0SqQnPTXT5uF46gp87upiO0BBru6Bb7A8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426826; c=relaxed/simple;
	bh=aSyDOfukmIJiOxpSDYV5hdhal5zjgE2Bvp84QrqkqGE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PR1/HWqz8+LrIgi/TiJLJgCGspRbXHXA1Y1ftGyXJoptbSarjNKft6PuQSvZbEajmLTRwCFT9RuYLzRu+V/+L2Rb/mFcjL5oerH2uYhToQ5X6zEM6Az+AKg0RZKuGVVAIEGgqYMfGeE+pI0VP1ISJoT4xDL6X5+cw0+x2WopovI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OOW+z1Um; arc=fail smtp.client-ip=52.101.53.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1VcyBXFMdjRYV5eSFNgiqt9Yb71FuFifxnFao4C35NAQ9YQCbvAlPRTkNMwqYhr+kk2KUFEFzdXVimkfnNZXCD8oRv5M2W/iV0NJSRK9iAc/vv2cdwtyflnj8J0lsKK/Ic1Ftgez+AD0SMrgyBGZ/mzquWAM8pbtMT+0oFdCkPCn+hRO8dKhOGTr4+n0oadJFAFFqIAEn7+hz0og0glU8305fwm4KL1NkRzBZywg9ScPZJ0/uEwhD0em+xZsKKmefS+aiiJtZAOFaxGqETpoL4F50fDC2i8/ZKL4FzrXt55vENoY0L4jFHz7OtZULrwra3cPyYAimVLMoIbX2RKAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9Eokqn2RTYBD29mYf/RIjks6yRLgGNWx7qX5d+COGo=;
 b=UheNDivrxN4ArOZhre61qoRXk+k3O+Am+o5JKiSXf/Xl5Rd+iCPp4bFaZwYfZmjNRpmb9rTa2UB6CSkcIaz08joYgnIswcC4OEWj6ygeJ76m9lZgYuvDmNBo8OuXDe33QQRLf9TKB5dVQzbOKY+tIB8WaDPhxvDqnlf/Q0bUSnA/i6n8jMZEAL03+T2GLpxfxxtQHmR9QfLcSN6Jvw1xueFA77hBEyLI9Y7xIFqXwim0uhJCgIdlPXXrtMNT2oRJQSjslEaYFnv7JIf2gLVVNyXYS34kgR12xQP7BZP+TicjNw9YqrqkIoWFzFw69FKUp1XF1kRp3KZmASyQenD2xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9Eokqn2RTYBD29mYf/RIjks6yRLgGNWx7qX5d+COGo=;
 b=OOW+z1UmXPRmXF0UoQc9bSzYdp1ZihEuDURVuJN1ZOYbRg1Ltx/4uWXNg9pkXWlVYSkNkY6i10W8K4k63B4C4g6AQ162ZtBjyMCB3CXrT1pb+XCXRp7eLX4AojeCITiceDZJ1qpuVb0ed51NYYe5Kfy7mkJa5jO02BiI2eUmicEa4+MrYp6u/CbueuUOZuUNVKSjYLwRxBXvoFoJ4pH3GfMV9q/bMJw/8tKFD5CrqBO6RuIcOT7nifbU01B6y/xFp3wY+gsY3OMcxChJd+c35udOZUYTO2+VBoQyBdnJeUHoHf2/HWu7MiR7YzB9I1H4Wbp9CcAlVgLRYEzEMhc04Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) by
 PH8PR12MB6724.namprd12.prod.outlook.com (2603:10b6:510:1cf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 11:00:19 +0000
Received: from DS0PR12MB8294.namprd12.prod.outlook.com
 ([fe80::d6a9:5e83:27dc:a968]) by DS0PR12MB8294.namprd12.prod.outlook.com
 ([fe80::d6a9:5e83:27dc:a968%7]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 11:00:19 +0000
From: Colin Ian King <coking@nvidia.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	alexis.lothore@bootlin.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests/bpf: Fix spelling mistake "clien" -> "client"
Date: Thu,  6 Nov 2025 11:00:16 +0000
Message-ID: <20251106110016.15960-1-coking@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0099.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::14) To DS0PR12MB8294.namprd12.prod.outlook.com
 (2603:10b6:8:f4::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8294:EE_|PH8PR12MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: cebf959e-5f88-4f80-f3ca-08de1d23accd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ax1AWS2QbXXdMA182RG70ch8diQIPZBXErp6BgmuExYbzz4Z7A3H2/HARCUL?=
 =?us-ascii?Q?ydn5NK7SoGLMsn1kUmhqi8uayVM1qhYHKdErP1QqKJtxHkuGOkkMBUP1DeHq?=
 =?us-ascii?Q?mtsEFL0SjSXJl8S6ggG0VjzjLeOUbu/fve8ztYZL6UjnixSqfAzTl53wUtR/?=
 =?us-ascii?Q?yMxqM63P2CeUtnDZDIOt/Iscp/W9KTnZ84SsICSQK5UJV83Rrhr00Y9Ukixo?=
 =?us-ascii?Q?dQcDtgWL0zqhW2blhH6c0nSXWtTFrj30s2ODYtgwFyfk3B560oLodpvZ0FEc?=
 =?us-ascii?Q?8hlHPlHgWQMtpJiHMxczouQYp5FMJDI2BRKIdFFm98+1CbChK/UY3xHhqB09?=
 =?us-ascii?Q?Pxc8fMwy0MGNMgK3kEAVNAtlzKNGCAhYH1yeOmh9FuqB9Fozf9BOoXN+zuPG?=
 =?us-ascii?Q?486CcSr28old5pZnEFl7ILAGzcHlUZkn1TfXD0mgDpBDfHKIVa6/nIYQ9XtC?=
 =?us-ascii?Q?RJLC4mt35/BPFeJ4ORz/6UddBU3xEs7ahJdTPrM7lnrS848lHj027RAtZJtN?=
 =?us-ascii?Q?vfPCdbxxdXdAlG7r05PlVMEHt7zxHVnSArjtpPSd8MplK7MSXd0hclu4tQtu?=
 =?us-ascii?Q?DXIcIa8EiHCvnc4LVvFwwq9oskBXSmIXs3iPBp1GQwPAUrz2sWPB9pzW6JpX?=
 =?us-ascii?Q?g+dZOOiBSFK/BSNOtIBpomwQt+dAar30jYOj1azguyzmQO00AIBaJEg5TqxH?=
 =?us-ascii?Q?APV2dsnTh+c/KYD+LiBKVImr2Yh40iy1B8ntut2lGzSsaCnHTcOzOZunbZEp?=
 =?us-ascii?Q?tZ4a0Rh0xURboT1CjQWwXSQmwDNuWS/ECX8wylJVGYsYgcMDomDUH04JRm4u?=
 =?us-ascii?Q?DHBO60c1VbNadCwUxV/53GHXdA0lc5v8HlyXe/3UlW5dR/+5aioBAVU3MXAp?=
 =?us-ascii?Q?u9t8Zl4a1BkVq8IADeQECso+p14L32hpm1MmVdtU2zoRqClDZYrPaGeQLQgj?=
 =?us-ascii?Q?H7zF1XeHDsTKM4+G7I2+ZQOOSQ2aFbt3Bn60D9JiCptnIfi6qp42Lg2uCdVD?=
 =?us-ascii?Q?fZtdcUr+Dk9tknN2E0037BfJLBKDuKFVhDGDG6Jdd5vLf78FMT0lv8GioQb/?=
 =?us-ascii?Q?eutKzX8gK2um9fjx3jUamdbEMRStaZM+QHK09KzPPq7CbfUVh/yN4nff9A84?=
 =?us-ascii?Q?E0kFvpQVSH4vcER5lPklXfKjakfZ7FWjcAww0tv00KU8IZpyodQqfGYHk8ex?=
 =?us-ascii?Q?URvFQXwpH6l83sWcGW9xWk6XZhuYl2NusClQnDJKc2jaQCoC9FYZQ93JCBO1?=
 =?us-ascii?Q?HCrouUGSg1bPmfT6zvr4Wzn2ZMf7Y7U2MSe367XsVm/vi9trLN4jkzQCNabj?=
 =?us-ascii?Q?/jLsUNSF7EzU1RjLtXry4IjuQxeEpntMzWjKXg55LseuG3x1J8Jzr7+s//lQ?=
 =?us-ascii?Q?2defoVtZc2BJOvGhThFP4ZW2S5v/j+fP+GPYgcW7d3peTkcqVoqyBkEB0qsF?=
 =?us-ascii?Q?th5Y23eW3eZBs9g2v9HB0MfF1CrkMIoPY87C9Yd+TQyFbXsKZAWCB8vKvopN?=
 =?us-ascii?Q?HBHqD3RN5jHYXPk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8294.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O4dpLzBtDHq/lX1OAwF0girGz+KrDDPXvdGcbyP+vNQgE/PVXoydz7QM2SzC?=
 =?us-ascii?Q?jMiLevT1T75jKlw2gYXVveD4EG2DZd2uqVbo8FyFicETjz78bywSP5ApVHdl?=
 =?us-ascii?Q?9p8svihK2BUR44mR9U8+Ydqqjd8wrPKh7bP3rGn+93NCImClY5knW6nXb1UM?=
 =?us-ascii?Q?y6S1d9J8Q9HbDvO21d85GT6y/gbiYbXKS5+Q54qgwBW2xV/mUkd6RgvaNHnZ?=
 =?us-ascii?Q?l8gP2RcL7Vs+ZJJW/fTWQbKcTlWm6EIyxK/YH4jsB1XFABXOBXjSpYlP/JAF?=
 =?us-ascii?Q?aIs3i7Y3xDdXDkNPCBemevC4gaxXI78R8eCCYdXZkElvY9cwu3nqRVRIclfc?=
 =?us-ascii?Q?Ck9lPaUFTGtXY9LcdbyBWoUGRyMIzIx7yF5fLMVnawqK3RFUYOGVOPLQe+D/?=
 =?us-ascii?Q?N3CY6OYFR8caDBose7k6ON08exJF62shFACWojfpINuRtsYMR7/xid6MAeAL?=
 =?us-ascii?Q?Lky6IM+vt+gGSNJgzB1FDZBwW53CLNP5W98I4HjkDp1ZPItNA6rfoo8ec0MF?=
 =?us-ascii?Q?KZStu/4+WPkaX2HtpnwRep0VQvbS7hmW3ZGVhn8px+i8JDN6En4SVWe2mNP7?=
 =?us-ascii?Q?1AN9naMA9KxoLEkY1cMT6ldmqF+bG9VK4bSTckNYBmk9Qq+jdb9YxG8yFORm?=
 =?us-ascii?Q?xPzlEzBfdaf8NSYw/828Z9DxiFb7ZiVg+JRkYXoUkiISJ2AiBNL1ZB6lUgWv?=
 =?us-ascii?Q?4XGCi3fQKWGL0C9s0CPoGIFag2czAu8O8QczXZrwlH0CyUeYIFrIs/7Euy2G?=
 =?us-ascii?Q?YDIwIv1+LKSRkUBjNWnRmfFz5+3Kl8UV7cD/jTUTB529ygAu07ENqrVtjPnN?=
 =?us-ascii?Q?phdrpC8MRrfHAg6XV8xmx7OHHmOtOwN8y7bk2L+LHL9lt8pHLtVHROZMn+KP?=
 =?us-ascii?Q?AAk0RhXC2qA3h3Av0LkPnPT6DZR/gZq0YaDepZopeBO1D4KknhrIucv8IGq/?=
 =?us-ascii?Q?aAAB7OdzfS/YyUOkuol+Y2s85gPYyQTkr/ojKRd6DFc0oQLOLxpmyjyE7wZ8?=
 =?us-ascii?Q?XZ+jNxOHWeDMAqn7eY6CNukPJgDXEcv5FzFrBtCEIJHB086JIi3+HX7Xs9Nh?=
 =?us-ascii?Q?w2UVBRB9R4VOBxWRCX4v+3tH01VYUNTk5GazOMkEOKHV1vLtvktV7A9yoXnj?=
 =?us-ascii?Q?2Meebe5Fp6vtTgZtkAz7yWxlqy9aueI7qUD6x0YqtMDoFuULvPukhyMhjjY9?=
 =?us-ascii?Q?0ke5TIPo11MznSwR+wGj6GfxxiUzJdDOZ9btct1gLqH8OYs0siRZDgAaYgrR?=
 =?us-ascii?Q?nGWsLLsXWHryPR6YrepB9rRnbTZWuYM/+n26Rj0E27wbgr/0A/446nZOuZaU?=
 =?us-ascii?Q?Rz69lBDR0cda0qTgMKS0IMEVKYEmVAIADftY5CMEofyoq/u8SeJFYq5kuhXr?=
 =?us-ascii?Q?JoiNXNG/QZbyt6bT/qJejXlnG4o0Jnvs+nRiMrp3PUbJ94nJZTBF2VFT2jGW?=
 =?us-ascii?Q?J27d98fnakMZtpfA0GlJy0uukfrYwSbMOO6m8MP6kt6kQQ0BI4JMlhLtzQ/Y?=
 =?us-ascii?Q?JqFKyJmMSD6q14A3tKIcjLwvRnnBG66G11zl9TfJxNdMme0tYtCTCAeIpDUh?=
 =?us-ascii?Q?R+aGn6xvh0+PfidKwbvzMnk2NNfEPb5XrYpIAFTU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cebf959e-5f88-4f80-f3ca-08de1d23accd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8294.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 11:00:19.5096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZuW5q4vWrjfXuiiqvRuI3NNgWJcse2ZR3aJ6Gzj9INi4Vdr7u4oybS/5bkq6Cw+oyO9fW+o6jLumtPM4Zpu6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6724

There are spelling mistakes in ASSERT_OK_PTR messages. Fix them.

Signed-off-by: Colin Ian King <coking@nvidia.com>
---
 tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
index deea90aaefad..f74fb50e3f9f 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
@@ -516,13 +516,13 @@ static void subtest_cleanup(struct subtest_cfg *cfg)
 	struct nstoken *nstoken;
 
 	nstoken = open_netns(CLIENT_NS);
-	if (ASSERT_OK_PTR(nstoken, "open clien ns")) {
+	if (ASSERT_OK_PTR(nstoken, "open client ns")) {
 		SYS_NOFAIL("tc qdisc delete dev veth1 parent ffff:fff1");
 		SYS_NOFAIL("ip a flush veth1");
 		close_netns(nstoken);
 	}
 	nstoken = open_netns(SERVER_NS);
-	if (ASSERT_OK_PTR(nstoken, "open clien ns")) {
+	if (ASSERT_OK_PTR(nstoken, "open client ns")) {
 		SYS_NOFAIL("tc qdisc delete dev veth2 parent ffff:fff1");
 		SYS_NOFAIL("ip a flush veth2");
 		if (!cfg->expect_kern_decap_failure)
-- 
2.51.0


