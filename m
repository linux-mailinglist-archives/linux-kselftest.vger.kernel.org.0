Return-Path: <linux-kselftest+bounces-10749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90188D0F46
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 23:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00D1BB20BFD
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 21:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48943481C4;
	Mon, 27 May 2024 21:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zag8FdRG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EC7DDC1;
	Mon, 27 May 2024 21:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716844612; cv=fail; b=rlSkkvwjlUMZUNhyC/fCP9nhR1P0oMzZJQm8wOzsNRYOgfmovhDyMk1h0H+0ec99Au/6FdLIo4gHBZJuvI8n0GavBZPvM7L8HP3+esTBKx/nmCHO1G6CWk4USgNVAN130k/bmVc9b68wvL5RlVlXhe/dM19LsufIdex3IVKb/fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716844612; c=relaxed/simple;
	bh=5pksoOG09hDgo7rxeccmSrs+8KVMX/TW4s/IMkqnvr0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=E3ruO+5zUhV19qmsslThPMGR7kEtkxAu1cZDGlOSwJG0QCdN8kp5+Nm65SzFnBoEBGIIXvJHv+HDLTYtWJVwFpI//WbpF8MpfwOb3gyzJPZifDZqkJCeD+3LCRk19E8Qm8kQ2onEMdKV1kqHxkAgzZzbUOU9VHTl9A5I6fzkDvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Zag8FdRG; arc=fail smtp.client-ip=40.107.101.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brB6XPm+r43sXGEuM6Alb7La7DWASgnub5oSjZ2bGfrwAXat04Yi8P/6DnECx3BDlXOikfWGfdn46gu2Y1Gp6qS3QVDwzpUCC9OUYl6N1Pf03/Zp3FckOWoa12mPmtUAw5+gGf68S0ZuDOm35XsD54V6nzrS/x8dCvXhkaiPtdaBR+Gwhu5mTeGOuu79O0Ia5bcBBH4j8QXKJj1gZa93gCzcbqTXf8/5ImyhY1p2729AjFiTQhW8L12cecrUmWd8vpuoGg0WGGR8ESfJsqslrlCISZsxgfHLnnyGnkSnBCAiO56nvLvNtH1EUF+mTTtqFJAqJo5Ar+y18lcKnQrdXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28qpJeU5/KOChtq/m7spbUDPhoJrz89c74dQA+hjBVE=;
 b=jTc8k7cGoMJuDt+lTG+U0XdfusqdKf20DZpdLuUqn5I63odVlWSQFZAPKRZ5BIqFBY796voF0AXl1yRga4Il0QfyMf1+X20lpcAAOSgnGr7Qsd1X8UGa7XLELOW75bIcpy5ikdLkGDovMAWsUuk5ed/FrQOlG5lBtBZDYX21vj/k7ONZzeKlC5xPqlfw2DHV5gIuDxajdMB3UmUJDDVmMScK4HNde+kjYGw3XYmimGpiU7o4uGGGpOkNXmzUp2F3q6HENH3ARYGkOdSuwIrK2WZK8OylWQS4Qsj+wXnolL5YxipRwbTQ5bnWpkso/XMmr0KbnwTmCocoMbqFhrDHUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28qpJeU5/KOChtq/m7spbUDPhoJrz89c74dQA+hjBVE=;
 b=Zag8FdRG3cCeuUtyCDtYCQ9j3PEMSdEIiJgpvTmQFWfLpKzeOy/wZEzgsPQu6KI1fzuH1xJnO9UcLA2I589j/NR0GI4nDWQ1opxInmohrdYfOjiZHIeWUL1lPmWbUY3H9JsjRMmeXuJa7sp+zJLZqkYCM4WulrlIoecs8VZ+ox88aqi7IVgDhATCMR27ejbQb9HxnBJzR2LCquqlsEIReWgAa+uva63wkqVhmkltRLtPZMdzslVTyIMarzGzz1MkMZOjDvK/eg9wXRCtCa1uBPg5+o2881b7vLwpk5W6LSVtDpodoczk/ZvvS2NCcgM0KfTeSUHrTmOgUdLm1cHsPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 21:16:46 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7611.030; Mon, 27 May 2024
 21:16:45 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2] selftests/vDSO: fix clang build errors and warnings
Date: Mon, 27 May 2024 14:16:22 -0700
Message-ID: <20240527211622.290635-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::7) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CY8PR12MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: 906ed397-548d-498d-6fc9-08dc7e925048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FxoCFIaACYQ/anvkNYwWoi+YMRpwGBYw2XR5ugk0yCz4/3sB+wANgD7zorBH?=
 =?us-ascii?Q?ck9y6Cz4mMbP6MeeMB/k0F15WlLnAxKXeTxfp9mA+UWLFluFAOQ7m/+RkKiq?=
 =?us-ascii?Q?pGRlTZh4DiyS5EoebiDmVCu44Zl88hIGtz7xnRvKdtXcAVb+bm0CEKOMxETS?=
 =?us-ascii?Q?UCoadhVe7LCI98PXbFnTaQ61INS8/57g1hoAaTiW0T0gIlYQvt20FTILvasC?=
 =?us-ascii?Q?ZmrUJ489xfgBKFofZ+kGYxu7kq3sRUCtqBuAvWNtnhmsE8tH5i5PXzyP+9tU?=
 =?us-ascii?Q?kb/3d0OIh8ujLokoiQF8QhrtsJ5auNlHgGo6sRKXEN+trzOTtm2W468URk3s?=
 =?us-ascii?Q?w2o1Tl3tqt3+Qs6YIQWMrRPVF1FwQ1XSnS6O/d93uEtlmli7coanK7h+maMC?=
 =?us-ascii?Q?LZO5zoRdd6ugdO17l9hD3OU3Ns3+Hd0IQEaPoOyJEWSUvTUYIxriaCtkHabN?=
 =?us-ascii?Q?uDJ9Y0FrYLAbF7XicDdY11Ac205KzBml3iLA7MXfSeVE7ZAG/X09ys8/6RjM?=
 =?us-ascii?Q?E5EfqqZf0e11D+5OvKB9ZxekZcCg0vilKnC8TPkG0xN8uzbYFuwFxpgjOQLv?=
 =?us-ascii?Q?pb4obY2qJcVBn82BMiHBgG6izxizk95vtUXWewbhURZTjPdc5fuT5W2Bwqq7?=
 =?us-ascii?Q?fzUwyYn1vstOFi7AxAaHd2bBfLvWDFaJwVVHldEGC/+rsgKz3M0ObJDIl14J?=
 =?us-ascii?Q?j5W/Vcig8jZO4pJVGtDlRzrWhFlc71dcVZAmmiRNtvks1u/iuDrDv0iWRqnZ?=
 =?us-ascii?Q?6rJo8+z3nm27QPgLMz0WNwnjtCn2CkGYFyzeIjZcbZQLp1fzma/jACptNmlF?=
 =?us-ascii?Q?pWFM3Q52yy4mq+hLwAeXJLG3Gw1dm7iYiV0FU/YGsHoBAlfQqX2masbCS/ql?=
 =?us-ascii?Q?i4iozUpD8ZhG9B4/03kDufaIGQ9QYwDWwfuJGBpqbpqN0oVEAO7/2WvcLi86?=
 =?us-ascii?Q?7EQsJ5j6rWOcpbUQE+GhIwFSOYhpGT2NzR11pM9Yjg0J7k9l2XJsH70x2jiV?=
 =?us-ascii?Q?Y0flGzAnp4KUPpCaF8/M6h50bea4xw8Rg2qLbupQouBnSkQ6KbYijRkSZqYY?=
 =?us-ascii?Q?E3vRQgpNkrLjnBc4Oext/YZrE2qSWkdvuUavb+5z9eU4OzQMh4tootzQ0UTN?=
 =?us-ascii?Q?DWDhKGT2B0Esc1QRUwyP028/kjOkXD9x70Q48rZgWhPjfDL2ip3ShlzcYwx9?=
 =?us-ascii?Q?zrkiEyCkIRO+0xbk7a0iUO7DoyolZW3T3DLoFMUyAbULBEdm+QGCu7vB9Dds?=
 =?us-ascii?Q?ZbqF+eay4Xg2W/UEPKoy3Kf5b9wn07T1VZamQ9tb6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wwU7ZyXADQoBghcV+SZowXa3MCklCLN9H/PhBEZXkuzwR0BCL6BJK36xTczo?=
 =?us-ascii?Q?kxUaR1SW3+YoAhzLbo4OYvml0kNpr4DtFb5OpP9Yd6v7H2ilULgp75xGY+NO?=
 =?us-ascii?Q?rm3o5Y2hP6LtwTIhrN9BdHeJQDsPBL132PjlVlg35r1ZjvDhFRB/60aUWUo3?=
 =?us-ascii?Q?JWvO8HXmQCMwyfHzwpSe4BIt2mTdNpCDfe0ed/F5ygGIdcatzGyWkxkIYh08?=
 =?us-ascii?Q?FfiZ/5msT3SDJFsQQAdX7c0WNJ+5sR14rnDOE/4/OYT76tYHiwcb1RWxVWvk?=
 =?us-ascii?Q?wObb2N6Cf9q5EqFuvd7r1c6yQ+E/CzkVEDM771OvGvayJPC/XKehwh2p+d7V?=
 =?us-ascii?Q?Lakcg+ZkPpR2JK1Y1XDC9DWm/1Qiu2nKaKujl88XYAyIbDsCASB4biRGgogi?=
 =?us-ascii?Q?eZZDB0HHw0VGkHp0ff8KAYrQIPbUEk4+picpL8GVk32bUDusVDSlfQHGkqKA?=
 =?us-ascii?Q?nhk4/mtQRGYtQTnOhbP7j12gQgYR0wjFqO+Vtsx4ntPOarj7k7gjbx97FLaz?=
 =?us-ascii?Q?Ricn6poVgDd/bexRr1VxXbt9wcnTJqbadM6lx4gxWK1h2Y2PK2szuWwNiMOU?=
 =?us-ascii?Q?cOPP4kPwN6P6tI3qizyjrfigK6y+mjKUA31rlvVXFPnVVPnf4Tdk83GXzjE2?=
 =?us-ascii?Q?4OTr9oJwvHtRY54ZeH2FntvmyIjootf6FHoXeDHFd/x0lZ57VNjJMfZXIvQ9?=
 =?us-ascii?Q?qrEA7hlq/c0vOdAVoHkSkrUl4e2GYi3vPVRhT1NHEZtGK/A8qvIgKDAOZyqC?=
 =?us-ascii?Q?dBLmj6IJrIDcHE8qnlMrECd0NGs1ncMJb+n75aWxPvJPFiNqAOZ8zpF1w6Q+?=
 =?us-ascii?Q?toELprU2M8kAKETElLTbPoptut9U4uWmgO+7DjAGzGaCVreOQsW1kypgIDey?=
 =?us-ascii?Q?ao93svpgAwlVz/Oo2M92+8nJAb14mxI6SL6akpRUCGByQEiiiXKv7JecoPlW?=
 =?us-ascii?Q?qQEHYD4MtjXnD6TfZObG6pWf8+anU3kziOwe9PPfbNuiZF5RIDKDYXDvQ83F?=
 =?us-ascii?Q?3nCPKgdfoLTpoIiI1reZg6yrUUR2xKt5okiNoD1lJ1P/kltrd/Chad4Zdqzs?=
 =?us-ascii?Q?Ou86T67p1ko4YLhFj/2aMBfFFaeFRAP/DgNF6e+RdcfMYTkCclz9wsRman+2?=
 =?us-ascii?Q?lHmtXmpF903+vPfzBzDYBZruwq80h4kUvF6rZBrPtZDb2c7W7ELkcQHVdYi8?=
 =?us-ascii?Q?d23v7aGWikspw79jNM4OLl9xbMot33ELJ4TqBbwf6dh0cxWGAjYlXDoaHUMd?=
 =?us-ascii?Q?oXMPlz79RrZYt6IMWPk5SyUh/G+E++UBa7L9XyYxD2VSP9531j5gmlFHpztz?=
 =?us-ascii?Q?TfnrM01n5qC61nViEzlJTR4uzY5S9dI6K+z4PMnvXjKr05ncHsjl4p/z3DSG?=
 =?us-ascii?Q?7cIaCEYrDn6XCRQ7JnZW1EUF6Oph6LYzwT1eXE3YA9vr06OaU0cmCnplTwZM?=
 =?us-ascii?Q?qGbZ2OyeIJhtns0AaIac6jpgTt1zmMfQWF3HlWZkaVpnZ+pDipjGiR5OYe8u?=
 =?us-ascii?Q?acuOOpekRWi7q553U1HNFJrxHcEwW4fAoiFJYXbSm+k9a0AoKKtA1q7wnjMe?=
 =?us-ascii?Q?ipqGZxPHOv5FRCh/hHQwmeRIXgfdYM65i6Rr0OxRQHpnC6J56c6X9GWV3gOE?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906ed397-548d-498d-6fc9-08dc7e925048
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 21:16:45.7707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwsukZfIFyT5UyBHeGORuzT5OgSCMoTSLbuZ8RREgsmCAxVPeKHWVnsGdF91t+iXh0aLemJSHBz0Dh8PrI8buw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8193

When building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...there are several warnings, and an error. This fixes all of those and
allows these tests to run and pass.

1. Fix linker error (undefined reference to memcpy) by providing a local
   version of memcpy.

2. clang complains about using this form:

    if (g = h & 0xf0000000)

...so factor out the assignment into a separate step.

3. The code is passing a signed const char* to elf_hash(), which expects
   a const unsigned char *. There are several callers, so fix this at
   the source by allowing the function to accept a signed argument, and
   then converting to unsigned operations, once inside the function.

4. clang doesn't have __attribute__((externally_visible)) and generates
   a warning to that effect. Fortunately, gcc 12 and gcc 13 do not seem
   to require that attribute in order to build, run and pass tests here,
   so remove it.

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Changes since the first version:

1) Rebased onto Linux 6.10-rc1

thanks,
John Hubbard

 tools/testing/selftests/vDSO/parse_vdso.c      | 16 +++++++++++-----
 .../selftests/vDSO/vdso_standalone_test_x86.c  | 18 ++++++++++++++++--
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 413f75620a35..4ae417372e9e 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -55,14 +55,20 @@ static struct vdso_info
 	ELF(Verdef) *verdef;
 } vdso_info;
 
-/* Straight from the ELF specification. */
-static unsigned long elf_hash(const unsigned char *name)
+/*
+ * Straight from the ELF specification...and then tweaked slightly, in order to
+ * avoid a few clang warnings.
+ */
+static unsigned long elf_hash(const char *name)
 {
 	unsigned long h = 0, g;
-	while (*name)
+	const unsigned char *uch_name = (const unsigned char *)name;
+
+	while (*uch_name)
 	{
-		h = (h << 4) + *name++;
-		if (g = h & 0xf0000000)
+		h = (h << 4) + *uch_name++;
+		g = h & 0xf0000000;
+		if (g)
 			h ^= g >> 24;
 		h &= ~g;
 	}
diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
index 8a44ff973ee1..27f6fdf11969 100644
--- a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
+++ b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
@@ -18,7 +18,7 @@
 
 #include "parse_vdso.h"
 
-/* We need a libc functions... */
+/* We need some libc functions... */
 int strcmp(const char *a, const char *b)
 {
 	/* This implementation is buggy: it never returns -1. */
@@ -34,6 +34,20 @@ int strcmp(const char *a, const char *b)
 	return 0;
 }
 
+/*
+ * The clang build needs this, although gcc does not.
+ * Stolen from lib/string.c.
+ */
+void *memcpy(void *dest, const void *src, size_t count)
+{
+	char *tmp = dest;
+	const char *s = src;
+
+	while (count--)
+		*tmp++ = *s++;
+	return dest;
+}
+
 /* ...and two syscalls.  This is x86-specific. */
 static inline long x86_syscall3(long nr, long a0, long a1, long a2)
 {
@@ -70,7 +84,7 @@ void to_base10(char *lastdig, time_t n)
 	}
 }
 
-__attribute__((externally_visible)) void c_main(void **stack)
+void c_main(void **stack)
 {
 	/* Parse the stack */
 	long argc = (long)*stack;

base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
-- 
2.45.1


