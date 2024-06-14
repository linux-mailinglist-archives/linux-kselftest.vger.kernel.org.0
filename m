Return-Path: <linux-kselftest+bounces-11987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2D39094CA
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 01:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6BBC1F2226E
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 23:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAB6188CDE;
	Fri, 14 Jun 2024 23:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ew/2LI59"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB0518757B;
	Fri, 14 Jun 2024 23:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718407878; cv=fail; b=omAACZnC/sUb3kwfVmTa/xf0I+9IIGua1bPRFlkl9yi7ousrge47eoBTnlN930VOmmrsvZUupOVsd5j10wZAY6oQyhbArmYH5aOmJqJsoBCdaipi8JE2m7l8qGk4DXG0vleulUG4QpTp0KqcIqm/XeKEC+Dps+mYUrYgOPNwuTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718407878; c=relaxed/simple;
	bh=fS0h2uo0gjsvRvhFJVYjz4AkAkxlJjbzDCaNBlB9SjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tuhHLmIQGSldsTuD9vBAQfaprF+z0et2afvlVzFM/HZNxCJtx7O5RDcMVrBWDx+OSGqosc1rByyXzG66jX5Etxdfo6oCNOOM3UL8/3MoaSME7QOcPrc2qYhidaTMhXzFFPvaL7jKKBDfup7wNC+p3ABSy4DfxG2NNyxALrQycb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ew/2LI59; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3vDPfQ6eC+SDiFXNnPXS++O7++wjMiYD4B6xias1u92vjQ5wm7Ar6+vewZfek5T8dIDajFkbtyzCte7IKT+Zfj7uNhfU6tl0EkHYhrIc/U4zSydKY+s5lvr3uhksZVbucCvYZTsLO1cmiFMqJZrI4gk9PDTr+Gw/7FufDzsm2UDG4iyKD70YzJkARk1FrZnNHzHDWH1FnkUEtkjFl2/7zCOVjck8NzrnwSn8TgDC5izYz7tJA2vbIhQOLV+M8+vJ6BdL1qWUIEIMdC4b8LD9ojnAXTsqJQP7YhY4+mjZUzy8ak38sEWy5g7Z72wouWUsKd+JtxyhjrW4hqk6lErDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcsnsD1pNMQuFrOynC4BFElE2hN2iFDFASMwNJ9NSK4=;
 b=kT4LmnLLWHU6jjNjkLQ+RC9Io2TeAk9WxM3l9aLc4sCOtQeSIk/W271P/p98txOxVr00OfeHQIW/L5tNmbSTFJmcJg+urznklO3WyEkaeOV80WcXptaOrWmCRk8g6hB2hX0P2LrlNpyGeyw3FcuNQeHCz2Wz4zmp+T7nUFh/wGV1LeVbhGqhNKLR5Kghv31+pVsvPS19zqRlAn15XffQmyW1IL8q8/wwiounWIcu4LmTdq2rzHE5ECbYlDRAwt4ZXADtEfAVxzq1+0//PHvAVeolp2nRw/UIOEyzvB1FMgWg+89cKFOT+9NC8nwNeV/4ZMsNrXpt//GRVXXD8XJUvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcsnsD1pNMQuFrOynC4BFElE2hN2iFDFASMwNJ9NSK4=;
 b=ew/2LI59jL6QMX8cnwkk2wTwInISBmS/t2aVRPbNpWSkV25MtfrVjgSlOJCzeRt/f7DVpiq0vhiOQ0LAyOLDAs8VzbnLMIaAZGLqq7MD7/67Krrds1a++R0Z8FPkYBkbL/LrbLiZ3e1ROozqhMFJ9+r/pUXToA//p4FYx+csRQbLFX3KOMPNUKmlrOw09+OvoUfjfuE1kHxNA8xh4tdqae+PGu9SMrbf01EAbhY+XGBh/BdGQjOGFsOw9bi8fwNO5k8M58LT4VmvlJ7M9iXkrOt640cfzNvm8SsSrx5erodzokVKjC4Y4ImkIkyEaYddyiXbdfdAsnHzxV797ch92A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH7PR12MB6953.namprd12.prod.outlook.com (2603:10b6:510:1ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 23:31:07 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 23:31:07 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
	Andy Lutomirski <luto@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>,
	Carlos Llamas <cmllamas@google.com>,
	Edward Liaw <edliaw@google.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH v3 1/3] selftests/vDSO: fix clang build errors and warnings
Date: Fri, 14 Jun 2024 16:31:03 -0700
Message-ID: <20240614233105.265009-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240614233105.265009-1-jhubbard@nvidia.com>
References: <20240614233105.265009-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0027.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::40) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH7PR12MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 398c940d-ef75-4b33-cd45-08dc8cca10ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|7416011|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LsggZN2oP82g04UXiC7EjT2jf49wjUfDEc8Jl5uI73BseraAZEC0qF4kcJPo?=
 =?us-ascii?Q?FkmTl8yz1/I6QGGalefJVUPOut5/fMsiulGiaqdzp2HFXXGWWSzSK29KPqBl?=
 =?us-ascii?Q?OmPGFxpCn3u+0gnLt1SBDr/bSc5cWgpQcFqIdXtgFbH53WZCgkL9L8+tJwGP?=
 =?us-ascii?Q?t5/F74t+qDIFCWBKbn7eBBF0NVx8MPnnXe/qZlARTMl7iChFRD+vD2mQVdft?=
 =?us-ascii?Q?UwJKA4JKLGb5AGSop9e65LwSp/59nG6mg15z5QXYXmrKsw2K+tCvoNVAIFkw?=
 =?us-ascii?Q?9MzeYeYu67xhX9fv1qIOFKjAGT212gtU5fWsdKTTvhS+5odV1N0gAMa80amM?=
 =?us-ascii?Q?QGKIiYxUy/XWBwij7tkc2kp3ZhlhmkZW4U6mhFIBOy98aYmeiZv1N4L4xRWv?=
 =?us-ascii?Q?ta1Fu6N3KyRT0FrAHOlf5Z4myAX1g2+X/unuKrP5NXBvE/M0Z2suqcXfJ809?=
 =?us-ascii?Q?2puu7BiPZUquJdBsD+Jlchf/AdmifQ1sOqt6AbIdWNvX73xG0imCfEvqY5xz?=
 =?us-ascii?Q?DL3Kss2PzItzjGdAGcjrC7rHasAkMxD6IGxtwz22sGslv5tvLAquelLSUZgC?=
 =?us-ascii?Q?iyag2h92caJuFt6CYX2XAFtdX6x20giTMPCEIrdkWnEm4ryANuviaqkeeX7Q?=
 =?us-ascii?Q?33lEs2nGWjF7jVqiAYPkKGqmZmJywDEPUXuyBdk9cNpMBPeWMJR6g4Da3twn?=
 =?us-ascii?Q?B5ElkREZewatptdLV/AFGN1rWAUM8GVOArOKmvWm0EG7ug3Ll2x7evqst6X9?=
 =?us-ascii?Q?8y1OTd9nD1XUY3TyrQIUUyVz14xdKOsgouSuGaiBusgXj7Hll+NdqHm/438L?=
 =?us-ascii?Q?oVBtxENGXA5qdO0XjEGl+Y671ZAS+w58UWDMSyFbUdL/ifFuf/90zOHakrjN?=
 =?us-ascii?Q?kRQSjct1HLMv5OK6fuKLl+a7eEJg/viCmbg1AeyJrVvwy5v1eZVQA6/lSfCE?=
 =?us-ascii?Q?L4QQT4gbWyHnIc7xjgykrKLrFhqtqNnbnntjBPnd8hLes+Iu4k/nONj3lUdO?=
 =?us-ascii?Q?6XSnUzYMn1AbrEvL3KDuyIcZ1H/qZ2OIPSwAgnInh9rT0aov1a/ucGbAdFZO?=
 =?us-ascii?Q?95Yv7v531N1RPdQB3bGhJqpX+ccTBmk+xNrtn4aiMsHiBfvMLZEWM8uU+cPB?=
 =?us-ascii?Q?FA8r5d1srITL1LKG1SrRwcKOV+fbM3vFFxhopX1KNt0yXWJye9KrPmyZ+/U5?=
 =?us-ascii?Q?E9uY9TGi63FbnwhOEukii9eG5Rqjz4AFAsde/BWVZ6VHiGhiqaLc3acx7DuV?=
 =?us-ascii?Q?EcX+ttH275FC16GMbyaxEZlG41fxuvV/LvFAwb/jHRSbRrdahDiWJC9CY2pq?=
 =?us-ascii?Q?JUkplOkmHCwrreCnvgWUQ0Qv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(7416011)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/DOx9Gvr8LINLeIe4A9aWFC85ftulWeh9CJLwZf+G+e0RXnbllzURZZC2bax?=
 =?us-ascii?Q?2NmbM+MWcM5s/Pi5/pa2TsLq5EJL1ZZG2GL5n2xk2YGf4Z+B9LbQM0p6U+Th?=
 =?us-ascii?Q?tGBqdhzelffH4saBJj9DDgyNpFS6P5/D1SraDyX5VpEbK39mfGtlMmVqWglT?=
 =?us-ascii?Q?TXDjg0YLrrlqSqai6WIFdCUGPCbqiQvryMVTZwINceHMP6x2NH4QGQ7f4w3L?=
 =?us-ascii?Q?3v01HeXS2MdpTC37Qy/rKYPMh+uLrmJi4Gzfd3vTqTJ0FEA6gEFhBlPYUiR8?=
 =?us-ascii?Q?q9u5uSe0C8MrT82kF3+j57o1hnsk3GLlo89SKN4vuB1c3m/MxWMe6mQ3S2ZQ?=
 =?us-ascii?Q?avoxHFPyAan+/gqD0uFcWllUMHP/BM39LvfC/L+5ownZYp1qY1T8Mv99uBDa?=
 =?us-ascii?Q?So8rQa5vsTBPEz+kkn7Jr/FFaCI79XGAfpwdb6dx2HVIYIaBSSHLv24EOjCc?=
 =?us-ascii?Q?6ktxOWneT/b49lljCldPzYi/q4WEvZkRAZzP8kIvCmKVr3ct9ECLfOz/9Qbe?=
 =?us-ascii?Q?+fmlzrs7ASOqA3iSripA4lMhtb5kv0AodOpbA91iXEUxCtqAwIvNbkfRMqTc?=
 =?us-ascii?Q?4TnLXCYqmqLz9Hl16xf6eTW/8YN2BKvPVWxt0htFC0lzdxJaE/ZdrBIB8y5R?=
 =?us-ascii?Q?NI/Cxsv0f+0F6gnrOFLKGQQF5QCRlQjDB/9MFU7XSY7RHmEmZVnLGNv4y+9U?=
 =?us-ascii?Q?aHsiZjNMjdxVBmEPKN3VmjLBwLF/XPRNf42A1G3Q7Pe2UzPt0aLa4bO5j7kx?=
 =?us-ascii?Q?2ofbPBtLD/Ks08/0h4l39uzOjCjgBmDujxgA8AdD/cO4+2zte+YxhL/Q9TMr?=
 =?us-ascii?Q?Q9FUnir0hl4zWopNOIFHs3waavWVCx3FPW+pk3FVRYxWvDSdITL+c8B/3Olh?=
 =?us-ascii?Q?a8fXPtqSnffkmw2pzjK23cgcjc6/Go8uUy8jgvlBa6rojalIL0jVvOJ7/3+K?=
 =?us-ascii?Q?smygG9RlT2p0/aRlfZlAtgvrj4haygw9wjdn3XykAehs09W6YsPHSfVsxcBT?=
 =?us-ascii?Q?fXs7s4/kUfyWdfhnzPmicpJ06MGIEJ9iRn3XfRwXVLvHH3swJnWaKQ/uDOCx?=
 =?us-ascii?Q?TgmDh+qrRj0QDjJye9nnQMoWLZAV9zS3t00tagI5Q/fS5Vvpwsgypar81Ssc?=
 =?us-ascii?Q?/b438yY50DASrlHvKArAmR/pa1PLlbsdW8u3avWb0up75vm7/x5HbQhVHcwT?=
 =?us-ascii?Q?YzmQaTf4YANqcF8QBS+rx9YVYkulYSYmrZO0kEerY0kNiE0q2G4kwuv2DcZ0?=
 =?us-ascii?Q?ljIm13tGaXADIMsfqMZlwhHrZLa0D9gO8wesRF5lwBV0Va8Zi0KUExwDx3k3?=
 =?us-ascii?Q?1s/yln35N8hSJeWceJkpvMHf2lAC/BjpCF7YRwZM8cPBMGPXhxa81rVD5cfV?=
 =?us-ascii?Q?qArsD3LJTSmrezFdwJ/Ngi32tMjJ6PiudxTIskvoe6V/mfIoYrlOMzV64Y3g?=
 =?us-ascii?Q?jVgB2aPan7UrPy7CYO01Sy756K3ZnuS0wBcYk/FUL9DvGiCohEfVFqBNohT+?=
 =?us-ascii?Q?/72Kk7nPaaKPbt2RceBwTbzzpaGV/4cokqjQ4b7gZE4F62cCDcX5mm7iwD6u?=
 =?us-ascii?Q?wRpT4FjLu7kb86inb1zI52K1F4BvjAyMi5LhEOcm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398c940d-ef75-4b33-cd45-08dc8cca10ab
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 23:31:07.1430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWggBYASYUaaqwmMF6nlJeEEh+Cc5EwFNhbOy/aQgfDsSmEWFtziRCGQKNeYKoUHOFCWdDainNEZpF7Vo3rHNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6953

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

Reviewed-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Edward Liaw <edliaw@google.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
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
-- 
2.45.2


