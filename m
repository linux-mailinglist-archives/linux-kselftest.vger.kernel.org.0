Return-Path: <linux-kselftest+bounces-11984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E329094C4
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 01:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6179F1F21BB2
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 23:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F34C1487D1;
	Fri, 14 Jun 2024 23:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sZTnMhak"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66CA19D8AF;
	Fri, 14 Jun 2024 23:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718407873; cv=fail; b=V4TYLTN0dBhXudEvMI6+yiHXJ9wrkG8CJmZaA+aDZMKzPCfY8wbtzi2quxfYAd1IPnlypTjOHqSkZbU/OlKuZUM2T2s5ziWV8DH/Jk5VA1MC13UgCLMwFpznkxoh0eVLZagYDwkVdDhSS/2Ifs+C2IptwSVFm4Hf/1PpGZaAois=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718407873; c=relaxed/simple;
	bh=lK58vpBfcZSQv3JcPh24mTbHXlmDL5Zm8gqKEelHQvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I0x0gWTcPCE8cd11eZmfGPEDuJQDupsTrZelqdZ6ad9oWg7OTwiB6n2JPVH+oV9IxqD8NIuwgZmVqbv8oGAZjM1TYncDSaD4wLxLaZPMIAlAIuv051z44pPXS28S1SnGb8CACWf4AcBrhtFHJR9gxxDuDK6ieIHmHpuJmAPTYWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sZTnMhak; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L78ZkqmYhGGODzGdKgcbCvWMfA0TESxz7QuXNW+lSM9JbOpIr7Kq7U8deybtRXiQ4fFupXnPtyRKnZFXyb4MH7PK+MAdG9542pXyK7GlRForPtP5b902D7/BEh1zFTznEMqLTCAI//GBJ0LZqHhTiWZCpttQGSP3ILza0m47WfMGr+4Ry8S4Y0WcI3DU8Ar5wyS1zeDXX/xN3qwrnYjOAd29g77BDY+PdYF2B4Q8UNXkswebHQpGp+cY5tES1LCN9a7nJl9KHqNx2PxFuDiQHC7w1JshaK5rblJ6iCLnDAnRzqF5+7zuxh4FGvyaRWxNxpq9IZjG25LxF4n6d8xBGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xmOt1V+qeM2fjYdwMfL4nhE84hrotY5xIDTqf3ElEA=;
 b=kIxdThfPF0AVP9+r16J+Ye/XNERPDvM5xjC9RQBQA+NTbziNui8MvhhtooiyIQj7cxGb/nOsWzLn22kykqYj6X2e31eCpVmVQ56KhsC0QjL2UTZnct8vh5ccWOvq1UbcSyuEjYG1ugRxeeb1IHDwjyYt38OHzuUQ/ogg8wHQZ9hgBfPDhvH7bbqUA9+8RviBT0Tw47Zh47g0vRMDCl6ZAI3D8ewph7fMZ7GTJjsxahhDpgHY58tyidOrZgMSpCRhcCl1mX4UK4pkoRHfpGwWSiBtiJypkWv6gdi+GQRxfIYAH/8x4pxedZ8/DTrMWjdfc6F++t+QYHTrZeLEzNIwGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xmOt1V+qeM2fjYdwMfL4nhE84hrotY5xIDTqf3ElEA=;
 b=sZTnMhakgjGBftFF8/0p54Eocp7ysi9kwP2VPAjS2NaiX8WS3kZvln8965cLEw4xvlPlL5MNcGEpVyeQqxN2k54aTTFzqtyx98LhinIVylSZ1F/JOMAbuBSBsNwPFrnzh5nPEChH4LWMlmSv9w1bSmapQVSVRpdpIZqX/dFP80ch2KxHBpaXQrrKMsg1rVVLAzg7Cdztn/SrppsmhG7H66cy2WPPX/l2aSJxNaYty32w4w5eHF4YzL8e475P8sxSHiwC/MDTLAsazhMsyDJDnNLsgIXa6dUBoj75sKuuLQ4aaIumN/8xUvEwZpVP9hHpvqVeGVIh3Kl206wzkzQ4Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH7PR12MB6953.namprd12.prod.outlook.com (2603:10b6:510:1ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 23:31:08 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 23:31:08 +0000
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
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 3/3] selftests/vDSO: remove duplicate compiler invocations from Makefile
Date: Fri, 14 Jun 2024 16:31:05 -0700
Message-ID: <20240614233105.265009-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240614233105.265009-1-jhubbard@nvidia.com>
References: <20240614233105.265009-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:40::18) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH7PR12MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: aac556d2-4411-442f-84c0-08dc8cca113c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|7416011|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yI8Mbe7fditXJKPrE4YkzPUtTLfPqxydVZu1nwz2e1czeiBed1yTRDUlviXu?=
 =?us-ascii?Q?tf4FNra5wv7LClFWSaT/prV4V93omwtw3iYWHoaCVtavTYUPBH114GWwHqT7?=
 =?us-ascii?Q?3655uRfhvXr20+SAD6M6mxL+h2Gc2rUKbgSWpdwQ/mqDD0n844YKYA2F2crS?=
 =?us-ascii?Q?msSh5kyVnHTDKFefLAfKjhhED3MG0JmP2Aw2Fo+48k14LxJ4fq4R8xGaksAF?=
 =?us-ascii?Q?s5kLtEXVESjDJQGPTKO6RDtSuLJ7XD83PNlyn6ZZpY5kfFa/uNCrUcOWrkOp?=
 =?us-ascii?Q?8QEZuzrhhIGOHKIWQnKxHag4hFA2frwzzxycglxafYlu07gqP0zMpHL79xGZ?=
 =?us-ascii?Q?2g2ro7GroyBwjpXOCyhtpRVkxxHqqKMAG35S0ti2GEMyQX6dPDt1EUWRQ8IJ?=
 =?us-ascii?Q?L3WLL2oEpB1AwKPOSy9ekC9012XK09bpQEtw5lsWq6Muw9hgAwlBjrLNekhY?=
 =?us-ascii?Q?0LhfcH8flmMp8sdGySzf28LuaPjqLpcKIkqIHEmre18Dc+h6e7skriABruKd?=
 =?us-ascii?Q?GyCcbGyzCQzC46v1YVGshuYsGhU/XxeJb0LYSm/C5tdziuWDj9XwoDYhItSO?=
 =?us-ascii?Q?srHDA2/LovDnxeVxz+zwDLjTPo5NF8wrq2hUnLQhbO2pIM2pofyPs2wg+x93?=
 =?us-ascii?Q?6zpT/qtZ3oKQXL+9d7dtSFIS6QQymSmMtqECqULEW1POwmyc9LnunIUu3YId?=
 =?us-ascii?Q?539YHNxpq40LTj7WYIDGheSpk1YnqnacK6GuBWLtzWThnBmPCRRkTURFT+Dd?=
 =?us-ascii?Q?7Clx6j5hWbie66oKv3blXhn4vGnk/WQ45//cG0NjDx7eZvB12AaH5rgUiMCY?=
 =?us-ascii?Q?syi5NctIRh37eDaYhkgeppQ+uUgsD6CnxCo86bKKcOXd0tTvKY6JDXYZrRDl?=
 =?us-ascii?Q?cErUjI9JI0e40L4ePo+YglkwYG/gJ3ALtBEBnxGUwHBUGJTPmfzSQngtvxha?=
 =?us-ascii?Q?Nsq6DaS7q1tE/Zb4Y8bnmRUyVWKK9zV8c2FK0l/QsRNcLFDnk9V1WswCPfRm?=
 =?us-ascii?Q?LiJpPArtAk4HOC+viE8q4Uut6uoL7ADSCkWq4XUdbgG30wQa2RnHQoUHDqKw?=
 =?us-ascii?Q?Ut5CCpbbuT9MwfSsmKYRWNMObC3o9zX4igv66TT7wNpSk3Owfa+Jkp+I9S3f?=
 =?us-ascii?Q?HlR8SmP9OgeDZ4lCfqarVbaHhXRZQdCTHsmpWbFZFFaFuZKOK8yhOZKQ6YLV?=
 =?us-ascii?Q?eMnhri5+0R5P20i9Eisan4ycNYdrNbG3p4nQ8Pnx7JoYHRVIOTKQw8Kemx+U?=
 =?us-ascii?Q?izZZ3Dur4DdWG3FIntLEmcnFQ+YzWlp7Oa6whmJOAFLe6cQNhM2/E5JaxIpV?=
 =?us-ascii?Q?TsUWtceYTqHFnL7/+1X5waXX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(7416011)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Lx6prSk/fXx71xnxpzV2zXr+f8xAmm1bJRUOswVVAZUawdlfNW2CfNphMy2?=
 =?us-ascii?Q?gYQCxuVFu9clVZnQbRadpb5bnhiGgRMfJ2LC6ucffU0fpQYx2cUabMAWcho3?=
 =?us-ascii?Q?GSIoA12wWMD9BzGJfpqibFjnhCNAS9wKvqfVykyCYl8RbiLuw9Vn0AXPTvPj?=
 =?us-ascii?Q?dFgUPxUy3qWZaBtA/Qh+f24onrzqwwmqkg48sSBHrlr2R/ziow/J5wHheWxF?=
 =?us-ascii?Q?wQxjNjChha2DCPzKt4HT0QywnU9Tg9JYOwwAP3+twAaBEvFon4HghjEhabVg?=
 =?us-ascii?Q?pklsY/I3bKy/124mYX6r127uuFd0txZns6HXm4Lr3RzV8PVxr08lTNBX+oYT?=
 =?us-ascii?Q?ivpAIJnCO/IZgO2YS4TTC9RBgGHpFS5ou1wtWgp885CJXcOQUg8hwRF5rgbg?=
 =?us-ascii?Q?Wt+HVCXceZd3+GifbrKOJ9kQXidP9029aWL7gC9ThMzlU2WYMXOeUQI6MqDW?=
 =?us-ascii?Q?PwjIMV2Bgv1/qe435YJxhgrVIAWRcoVnU9VAUCaoAxEnLhxgP5JkfVI8jE2Y?=
 =?us-ascii?Q?5Q5jR+ITAn3kSYNiEFnUsPjuBi0rtEsqco6sfNMivqu2QxvjUWUGDBqf3k7z?=
 =?us-ascii?Q?28TYBztloBnh3vkkSe4Fq9UYdz/F4dudGT7Qt11yJYddePT8EzSx7ldbemh6?=
 =?us-ascii?Q?4bhgl4ilaZknAI1arSi7n0ZJs2u9vO5TcEC9GBNRoENFLlyHdSrA92Ce5jSt?=
 =?us-ascii?Q?Rssrhx+H7hDLEWShJoS4PvSxF8aT6SDnCSrpborqYhIWyrKLOnqgeM0f0bvs?=
 =?us-ascii?Q?8VUgMeJk82xEQQ1eh2JPbjh8an5PU5VxF+OUfhLGfUJKKvau7lptHy8LoMSc?=
 =?us-ascii?Q?Hg40QypUzWFQMaeYVR9AuGwUQOLaxDi+gbpzsOMP3IQEszBHgEYQ3G86/vkW?=
 =?us-ascii?Q?F6krJRZfRdXja13SWVLkDCPfHxB+81sDbH2WNrT5ZVxgvSzVyz3E1iN/jlxW?=
 =?us-ascii?Q?74QccFNJkRiOYTc+v/q4fncKz/Z/JupXcndNrIxVZEise48QShsrGVGzJD2P?=
 =?us-ascii?Q?7mynFagqbdfGs3Y50ckhcIuRd7EGZlKKRqLEus5nr4MbMr/HJXCuoLOTc3am?=
 =?us-ascii?Q?72zWMZ0k3bxkJIjuivhthtevTHnSClABwiT/7o4kP3+IZb9e7UWMxo5R3yvG?=
 =?us-ascii?Q?qsHbiRaMeAlJ+k6Oz+SK+frX1P647DKhzybEQNNSSTbfKm5fpIuZsjuO5vIq?=
 =?us-ascii?Q?SiT17Z4GvNpy7twyF90Z0ZeYfZIOOW7f60Jrdhdp3lyNCZoApaweN9/mBsTr?=
 =?us-ascii?Q?lisTAQt66INHsiXvZPCgGrmCVrhOh6Voccm7AdGMRSyUNbVOcE1iKNQGjwm8?=
 =?us-ascii?Q?feZ2/ozgTLqkbhTkmHHFaqEXtnjFxK5rb+guQiYsFarm0Clk/+3Zjn4IpBpm?=
 =?us-ascii?Q?Z05+/DO3Ws8TZpkYCVoCLlVzeB0dVSKqzka/Zf+wHAGWP4m8b0Nl0+oXBqt0?=
 =?us-ascii?Q?+ph2L4TDqGvwDFBhsCmAjW0YnlYkClit8sSfmBcZgDzFVRf3bLYa6XE3pQVI?=
 =?us-ascii?Q?4psxHWEZQYRcmTd3gIO8NCfc5lWZfz8dEVlLABbE2yNFzcJJoqo8NFqKt6js?=
 =?us-ascii?Q?bcuiSVKjGUzeyhVsMRdE4KWeMjh8hayHgI9xrVrf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac556d2-4411-442f-84c0-08dc8cca113c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 23:31:08.0859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gjBL79TXJx4EFgeG6hy8B07oilDh6gJvI0NVg12AkmKjqA/34Oy8zxEqFWWg7rNY4qMEJE/ry1KhpGtJNC/R5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6953

The Makefile open-codes compiler invocations that ../lib.mk already
provides.

Avoid this by using a Make feature that allows setting per-target
variables, which in this case are: CFLAGS and LDFLAGS. This approach
generates the exact same compiler invocations as before, but removes all
of the code duplication, along with the quirky mangled variable names.
So now the Makefile is smaller, less unusual, and easier to read.

The new dependencies are listed after including lib.mk, in order to
let lib.mk provide the first target ("all:"), and are grouped together
with their respective source file dependencies, for visual clarity.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/vDSO/Makefile | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 209ede5de208..98d8ba2afa00 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -12,8 +12,7 @@ endif
 TEST_GEN_PROGS += vdso_test_correctness
 
 CFLAGS := -std=gnu99
-CFLAGS_vdso_standalone_test_x86 := -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
-LDFLAGS_vdso_test_correctness := -ldl
+
 ifeq ($(CONFIG_X86_32),y)
 LDLIBS += -lgcc_s
 endif
@@ -23,12 +22,9 @@ $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
 $(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
 $(OUTPUT)/vdso_test_abi: parse_vdso.c vdso_test_abi.c
 $(OUTPUT)/vdso_test_clock_getres: vdso_test_clock_getres.c
+
 $(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
-	$(CC) $(CFLAGS) $(CFLAGS_vdso_standalone_test_x86) \
-		vdso_standalone_test_x86.c parse_vdso.c \
-		-o $@
+$(OUTPUT)/vdso_standalone_test_x86: CFLAGS +=-nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
+
 $(OUTPUT)/vdso_test_correctness: vdso_test_correctness.c
-	$(CC) $(CFLAGS) \
-		vdso_test_correctness.c \
-		-o $@ \
-		$(LDFLAGS_vdso_test_correctness)
+$(OUTPUT)/vdso_test_correctness: LDFLAGS += -ldl
-- 
2.45.2


