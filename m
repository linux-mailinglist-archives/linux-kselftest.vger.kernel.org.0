Return-Path: <linux-kselftest+bounces-9327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933248BA60F
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 06:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39BC1C20349
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 04:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC693FC0C;
	Fri,  3 May 2024 04:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A2e9qaj4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C38CED9;
	Fri,  3 May 2024 04:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714710765; cv=fail; b=nsIIg6YzA8CC6jQGtOcFXw/Okp/kavfooJKb5zONsiTMXhjo07oB7u6UBtD8Um8zoRrQCpX2/4WHhS6qQvJ3P/sR01TTnw7Y2ETZtLQrBAbT6McIID+7KUaIAOz+4wHZbHP8k6BRxytoqLbVky7l1q8Sb5Xl9yrBEKkxDRiIkWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714710765; c=relaxed/simple;
	bh=5AVOJGVUIkJZdv5qEmcg1ups6cp3fZnQIeLA1DJKjag=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NgBYsEOfolvd22ycOv5K0zGbAcMa8Cp5XtxVylKAaRlqeiQJqzoKhSwn6I/n+HOIFkTNmG0b/6FCVk3kxuFHQ8/7ADo9Tcg1Q1GOsvAoyyt2CAcHVx1+VygKCVJ/281A77aSRgkYWf9OmZwxWCE3WhykZRo2GHMA7ENlEz8xdYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A2e9qaj4; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHkkM4UmLxlUHnGXoD0hV27NwOlBsUNaRQ5gRHtM1wOXYkgYKkaFkBfwUFTFXB+qiWhYmAsGL8wDmgaVhi6I0ex8tBNZ/ZEv+kq4PtX+2Lv0EQgMV2eei41kG2XVAw8cKe6GZW0XHzjTeAFfw7QLzImhAq2CNmv1c1fogXioZA3wb78pwa9uPfjnwWYWG+/iIH1WvBrgPuVs+Np08Y5c18hMVKL84xv8yGBZpDtEOI7KpWW60LnmXgzcJiOJOJb6QEu+wAotN3VIb8LC5PJyz5w1k3ExR/9x8pfULv1V7+rmi+2u4se6A0EkPpoFNHbH1aTcc/aN7nJwKev6U1eVgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DC2wnzQ/f2mJu4jlaSGosw848j4sbSY7P4kUBMFKJU=;
 b=GJYIPHPTKVNQ38gbBMxM8HvskFT9YCqK+0k3RW5KKALI5J0E4YYneUmZn6VhuD0r4Q74XcVU5BpDG+GvPqc0OHzUhHwcDdd3dfFVg7dY9CCVDhbrRjkIFuB8lwMJLa/D8PrL+N6NmXsVPZk9kRf+Iurv3XPrCdmk9mG0z7WcX0D/h5Z1jugsVU1cSXyllYunoyXBOH561j7ptlb4Czfr+f+4eMOczUylxdFYDHDPunDnY9UPiHLZnxUcsk7yVmQ8DVpsdmQXrpJFoUVeC6vbhjLEM3iXyPJOwonjars7KMhYcFzyOHe+o1lA2PYYAWfVIAP+VCy2RcvaK8jDU7isBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DC2wnzQ/f2mJu4jlaSGosw848j4sbSY7P4kUBMFKJU=;
 b=A2e9qaj412m5uzOYwHGIKZJQmonxlYyZW96XMdDlfip7XfUMifFxyqO0uISB92ke8q/gRwrqbKt84jteMe1DBXRJcCOH4/Wzlkxm/wDlKO1V+Ee0ZbLWB3bkKOu5BlayNJsZcbRwM9+CW7tZJoIH3Krn6+o5/iKCeq8/4rSDVwW+ojyI67NpJGLyA6i4xO3mC7Fy2DsMVNNG8Ci+yc2hiGHhLxLiGQVjHLoGLfnLAOXzmaKEvB7EjZ+ZF0AbpwcaDrL0/c621rBZ7npjutnZGzgaDYD9q36UU+eJK90GoLswX6TEN5kpmtb34uaP97ScYt7l2cwe0QO5wpxEUjhETg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 04:32:40 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Fri, 3 May 2024
 04:32:39 +0000
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
Subject: [PATCH] selftests/vDSO: fix clang build errors and warnings
Date: Thu,  2 May 2024 21:32:36 -0700
Message-ID: <20240503043236.101330-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0065.namprd17.prod.outlook.com
 (2603:10b6:a03:167::42) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|DS7PR12MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ee5438-327c-4fc9-f17e-08dc6b2a10b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fnBYm2ZMVVUA66gZCzN9TlXZ7ziCuubSGU6ymP8f+7gQRwA/HG3cKow2FI6Y?=
 =?us-ascii?Q?kvvRGPUJGQYc3orvShkiWH4NQLhN7mRa6WEOYR6qgbikkEDH1geFM0qwI1Kz?=
 =?us-ascii?Q?7KXQ2sRdUudLqEBMjRjMA4Mev8LOee/lXIreUA6FBGlM7mUhhAnHhEhxc+4l?=
 =?us-ascii?Q?FE5Ns81Qo7O92gaMrnPNn7tlRR0JOUTDZovNi4kyroQFYEQga8qgYv5X+cc4?=
 =?us-ascii?Q?of7WOWm47kGn2ookeCerlHr9pB3bdCIQiTT5c0axDs+33nCGk/zQwFCc6HnX?=
 =?us-ascii?Q?jpkeBibLBt3c5CkJ2qysjEPdbeY6lwB7GhNX/CoUPzVb+Pbx+RAG/26vbpgn?=
 =?us-ascii?Q?V84rPOSA9yc2ca4oorI6+CZDOTTj0ug1scp9a2useLV5fOwrMwsK86is4+7H?=
 =?us-ascii?Q?AR3Yor5icc4J7nvWmpvtoF5KJyODNPHNxWgKJaKCpQpoa9Rcg2sb0NtHhTot?=
 =?us-ascii?Q?f9Q8PaKN5mWLf9XFC+kD4RxUeb3gzNK6CHwrxJdSRSK916rmPR8mWaU8FEag?=
 =?us-ascii?Q?tTH2nYBQet9ZPtsISEFvQML7xONQgSXSO+/GHMOwmOndbgYiGc+fUosdqTW+?=
 =?us-ascii?Q?tV3R5q+fdRXxduSIV7feJp3GPO9EBwl0e/jtxUYEN+O0QJFXaWTFSSWFfyW7?=
 =?us-ascii?Q?kqiRNCOpIeKvd+XDzZdbLeIw/8Nsajbr8HYYkWD0iHTHgS4xKNc7Ryg8R9uA?=
 =?us-ascii?Q?vvFLAoI2do7i1NJGIdupLX0hk02c1bPNoybGzmZAiSKy/kudIn5007NNs2eB?=
 =?us-ascii?Q?T42Lnnp9bvwgAfUNsbCiPEFR4yotYeyNXaddXycBHzDkOcK75NFKzZEXkow7?=
 =?us-ascii?Q?Mk9ADQZFGwmpIBJl2VDZv9cNLZZJmBDW4auk6Pi3UJVsbI847gk2lEie9ijr?=
 =?us-ascii?Q?1JVY2KPzwrzMlzVnf2LwmJ982ycVAsabO2rhcg9B5IFUCQ/dDsW5XWKpaBA2?=
 =?us-ascii?Q?TcLRrnTwsCcrzTGW4vlye5HEbxpavuiWDG7x5EL0IvB/SF92tH3x6eLPjz69?=
 =?us-ascii?Q?ow/LiLYkWLclprbeeO6afx6LGsZZuq0kf0xh6Rk5LjxjeN8bDDXIwiLzzbip?=
 =?us-ascii?Q?yph1dj31M9vP9Mw8DAeRl/qTgJGrpwiXWdsy8OhckAG1TbfIyepYL5M0ppSZ?=
 =?us-ascii?Q?N3IO/tgnArhlmTY9ORs3KH8udw/jlSQRd6vFljL8T7J3jyp2vP5uGioS3Bqs?=
 =?us-ascii?Q?6HpQdx6l5GtF1Hv8JUggfj3SAVkShINHeOoUw5N0yI81M11XaxVyUlIG7RaU?=
 =?us-ascii?Q?zXecKWOjGWysh1hn3dY7ewby0kFeUF1YIONpbbSKBQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HcrHModZbeQ9SxKwwLmiOLBxxn7Zjua/Ed+UUxDmBlH6chf769YmC4WUyNn2?=
 =?us-ascii?Q?LE5gU9i6NqfLKCLcS5ulgdawLaMZExGNsHhC/8pxJGM3K9bHzGKhBLZFd/hB?=
 =?us-ascii?Q?aIUr3bZeM2fpoWUX3AP70pjYHjl1mEJd9oyRFx8nMnvx8ScRWolJ/C7ud733?=
 =?us-ascii?Q?NXoKfNkyjdahQChMohZCHo+Qe3co55bNx3rwpGb/M2MaIXRYp2sn4qxGcc+x?=
 =?us-ascii?Q?Rn4yhS6GZze9IJQA8ERgHi/84CwIcZs5JNBOvUi4/eZ4LnbaLP1zZ7Ab+Mng?=
 =?us-ascii?Q?Oh+30Og9M2lsAE37j+qIZjGDUG1+niXAKli2DiWivASOthSO+sOzUcjC5yaf?=
 =?us-ascii?Q?cRVuWywVlix0TnR1aOSJlc60jQxKUzD096wRsJHLQ8Qp91lF/4TsWEa95i1M?=
 =?us-ascii?Q?vfXuWzVBOVePbErlGHJHAW8WA6fA18YccBHlV8tzZJSxSjSgjZ09z27rLu0L?=
 =?us-ascii?Q?A/JuH0EEDprdBTov/Lr6imBYqDG6b2POzaCkwCpw8oU3JRI9Cv0Jyonbnmk/?=
 =?us-ascii?Q?uiCXKN5T9EIdfB1eUceXjhpRj/hvKsQNralnySEOC4Ky+SlZhkgWtRSWXWTG?=
 =?us-ascii?Q?g2OQljEjaYXrmvdXqDt80il+v/xnav0OpVDWw5o9p5BdbLd8vF8WC2yXmgzb?=
 =?us-ascii?Q?MwcinS76LaPJqBRtddMeglJwESAp29MSbK0m8ByoPYgmNzoTvygd2oULE3X/?=
 =?us-ascii?Q?BTRdtcnS9Pb4MzooWgAcj9FKaDAXl/qgVJqa4I6l322UrE9qZLpaDYOKsgtJ?=
 =?us-ascii?Q?4GbsB2aj8OOvdf32tG6JmbFth9dJaCr47jfI4LrkXMAHlWlCFOaum74D3Jj9?=
 =?us-ascii?Q?n/HOMGVPSPxYE44Us5+ucU8Kjw47aNEX4AwY/VV2KejQmT9FWwuHrNwi79ML?=
 =?us-ascii?Q?HmR0cjXTBTWi/rTPJ3P11ltL9UgL5zsn2uiv6NI0r7QGasFBwQW5P/SrJ1sD?=
 =?us-ascii?Q?LR/Vsnr/XaWqlOxWKPniczOaDdMADFTGV3W/Ge1/443Xmahp6ZQWM725XmQy?=
 =?us-ascii?Q?1Ovbft/LWovkqxT30wPapqapUQ72GpOYHEuaGR3SRwXmr9XbvNKdisDtqAAo?=
 =?us-ascii?Q?GjnX6Rx4W9pt2ZgIMuDgT084iHmbNez95Tutd/DOoiVeT+Id0/leJWsL9Ptw?=
 =?us-ascii?Q?3y92u533D9eQtO5go0m5Unuz4vpHAO/mnS1mLqoiqognX3Ra82eRh7245M5A?=
 =?us-ascii?Q?TKnv2j6tHagT4/Mdec8rCv/f7NFxMoSNUjdmK4aQCrlBxZE/qhycf6Hox7tA?=
 =?us-ascii?Q?BryIuc/kDq3l8lSpXc6jIB33uieBYVHgN8Fsdgi0DDaMquYNpI6xFhAFDIQz?=
 =?us-ascii?Q?ClTWTOYWFRJfWqdR8qyFFUIJ++igHnq9fsKemedbCXcpVuR9B519uRiCZ4Ka?=
 =?us-ascii?Q?j5Fmm4Pob1PC/W+DmL7j6m6BGDzoy5Yx0ecZTxCc3d3Pxbsxj+f8nEYY5eTQ?=
 =?us-ascii?Q?yiuZbul7ZO2UupB3nzkPffIYPmn1xf9P3Skr8+3uCNXLyeR0pT2W5gJE8zMx?=
 =?us-ascii?Q?/TTrh3Exis83gUF0Vy7BMKQOHU+wyA55/+XwOF0ttdhALH/0xGN5x4DO0FRk?=
 =?us-ascii?Q?ibFDsPNg+q+warzNisxCyOKz+BqRXbA15FyRjnoE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ee5438-327c-4fc9-f17e-08dc6b2a10b4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 04:32:39.3731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HAa+HXO8YDGFB3Z7X6qEEdLHzemHeB03w/GD3Hqp6BoPzza9NSd5VGLnNCibxDiKFRaXZsFgmaKWOBWVSwt3LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8321

First of all, in order to build with clang at all, one must first apply
Valentin Obst's build fix for LLVM [1]. Once that is done, then when
building with clang, via:

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

base-commit: f03359bca01bf4372cf2c118cd9a987a5951b1c8
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
-- 
2.45.0


