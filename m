Return-Path: <linux-kselftest+bounces-11039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C469E8D690D
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 20:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712022848DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 18:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC97217C223;
	Fri, 31 May 2024 18:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mSaUyunL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE8E7E575;
	Fri, 31 May 2024 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717180684; cv=fail; b=RsrmozFgF3ZsfU4ebaiCRzneY5PeDa3eORTxQDcPoUNjez5SdkKQodsBhCRN/CTeXtipMvqPglqNMJ8NO5MBeq9IK96jrc1dsucAydNQQW0pYFHwIqGtvvKZ/Ee7B5SoPAEyy48V/1Y9G7UxTH7wJd4E25Sx74oEDvjNNEbbKMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717180684; c=relaxed/simple;
	bh=HGxPKZc0Tg+zgTnJhV7dcR0VKSblOSlvzfJl3dU1ggA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tsX1NTu+mhsA/OvMpQZXm+aOVc+GRQ0BMIGOilLlMIFmHfCyU2iQozW6NUUHnYElY5x1YFD/c6SHejIFn3lOKhQb08bYW7AYIz7KNWvZI38j0uTxu1Sw0Y2S6KaK29gFnZRyQ+/Yvag5cRkCC+ZsmjgLa1X6uXaEvV3lqMYYpsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mSaUyunL; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4cagilTpL2tEEPAX/dwyTVlPprM1AgjsxD2PgE56DER7hs8xXBJZ9GzYRAVuyhbHMBjULlWH2eZnYs2t2DTIjEFcCznirDULu0DTlJ92rtz9wMa1G3GpWNknboa5o7NmqvR9NqPZEUhEKgbmUMS/di/1Olp+PFjEJIJWShUTXh7oLXOa0IU1783b7tVSgV9/SUDq0HtcRUfAyHVamCF4SZ+mb1Gt+gvKYoTpgkMTY6I/CQ4uycon001zwPCu5PG/PkRpzJyWl2OrfXtjOJPOxVKmAiMk7ROyymlS6mTEPM/JXmFf4Ziou0VS+5n5PWxhZ1g4lm/DkBl3s/KJOolCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiWQBaMWsgsNBBNOIIZ5jD0bN4oDf9RwnmnYQf0e6Uo=;
 b=Z8YNyYV25bVmX2M9RGSNyZFM3OyvJjuui+AnP+zQ/cOTxkdQVZCSfR9+kY90fdEbSO3PzkHjZ9rOO6KfY83k0Ydc12zJ4cs+D65E4d9Ctwh8R/YHGKvaVs30yxCoX1iJSVDaG5yEqKHdlI5HoqxdZZEI4paOkS+1ccspM8ub0R47bml0bL8OWOHGzwkOb4F5YL9k8ox4j3/xxvMUB0omkrid09cipLlnWTvuJz/pTaPCaFo0OWfEYJnMg6NuAZg1y2g+mw2GyShw0InNfe+1/5Q/D9sO8snsY0zN4Gv/zXVQBZlqHxdGEXS9IUaZMtERu54ZXV+47EdIArTegn7KTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiWQBaMWsgsNBBNOIIZ5jD0bN4oDf9RwnmnYQf0e6Uo=;
 b=mSaUyunLHlqt/MBtybPPRrEsOdQT6RhmqSZhmP+FK5sC0qD9KVJVJ55PcJA/LqP9iGuRUdQ26BHAGc9WC2oWh9wY3yBMAdgib8nuWqnojvA7tUh+OTKYwoAsRq/Fwzx6DhNrG2OUsgaHvK7uDRfN4YUtBlhz14TzF/ILx6C+M2C5bk0O9DLs19o+JGtCpuesulQrL3Gaf1Z0heKKIuUD0Hqxjydnt+bQAD3PeZLCh/i8QhxK7JlXbIx6h+dEYJ7QvoG0uGxIWcpUK7iljtaiEGPnOGm8J3Z4raoPeCHZ9g2WspAXCGHBilhdKpkO6EUb+VxJ6Ws4AJn+/QShdxoj2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 18:37:56 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 18:37:56 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Beau Belgrave <beaub@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Brown <broonie@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Bill Wendling <morbo@google.com>,
	sunliming <sunliming@kylinos.cn>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: [PATCH v2 1/2] selftests/lib.mk: handle both LLVM=1 and CC=clang builds
Date: Fri, 31 May 2024 11:37:50 -0700
Message-ID: <20240531183751.100541-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531183751.100541-1-jhubbard@nvidia.com>
References: <20240531183751.100541-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::27) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|MN2PR12MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: e3169be9-0ed1-4685-49f0-08dc81a0c9e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QxeqJuwKzaDISDJtHml3Uro16Y499sW3cyfCpqeWp+ZsCxl3Y2nY0rYqX6rL?=
 =?us-ascii?Q?YeU4EjlNYB8ONX9myqesmmImRZHLeZpW0G9TDG9H2JyuGfNGKTKVXLeVA0sJ?=
 =?us-ascii?Q?vCmePTgOJoKSn/BPQDgmmtjoyrbsndhIEpA+jI/D7qDdfrn7qd5NorSpi715?=
 =?us-ascii?Q?q1hJHNciYI8bVVah5L5R3BkekVjRVUJ1H1Ts3i/gf/xsYFaV/NiU4lFOTc9f?=
 =?us-ascii?Q?st/sbtPH+CJN0vW56wcv3LmfDoXvwkOF+BvUw+IGgNmVok5BLcyqkpeEArIv?=
 =?us-ascii?Q?h1NvS85Ga0+oEqVFjzw+Jqc/I0+ub01Q1EsXZB6e5o/jQxsOBbM/UeMCc1bz?=
 =?us-ascii?Q?TVpvZZV2PWGrTh+4h75jeqMSDczBVITOPQyahKY4nkLIpR6UJdNkvBAdg2iF?=
 =?us-ascii?Q?ZFOBSHGQZtbglMj1qILpxW4sJBIXqGGDxSp8hapy6Bt/ET0hz44zdCz/dyZd?=
 =?us-ascii?Q?oyF8ie/EC/flwjLcCk65E1505FA2kp+vG2HhPLGNmpdgE2GfHX4awadbQ5nD?=
 =?us-ascii?Q?GyOnar2X54LLm0ddsMXvqSXhfo/zXDM9WfWNEMFYO25fI4Tud916M/4r1NU5?=
 =?us-ascii?Q?uMlmnONunKpga+7Z3X7ZKOWSLwael8KhOzh1/diPgjkc2VZ45RrZ/qpM3azb?=
 =?us-ascii?Q?NXJOYI8qGuOZp/gT6GB0J6B5sHd0mWc1ImmfPVy+kQp+ZOQFPGRYXDfY59rW?=
 =?us-ascii?Q?xDJ6253pS3frfGoPDb2mZXB1m7ckYNy+rvZdIM+9MH0RLOE9TTZTEwE8ssaD?=
 =?us-ascii?Q?np9xH14J4NH386HMWVVPQGx0oadzoJF21OZD1xL5I94T8kaxpcknXf8n31s+?=
 =?us-ascii?Q?R7htCQDj4Jph3DEXiwcIRr7lsnIcIsVnBlkS3JcxUrh8oUw1IijxOXgXJj1O?=
 =?us-ascii?Q?VY5w94qc1yYcF/Q5MntaSA5NiO5tjgtptnzeDXKR45eKGI8FYFX1IHgeKnXS?=
 =?us-ascii?Q?mh52/jAsr7ndhoustRNjUvhWeKlwurDpg38Tv5diukJkz+sfIAaumUKcmmzC?=
 =?us-ascii?Q?gWhm3IzLQVEB5fQEKOeH0bGniLTUwwfWAzpWtrHEbqg35QGb8G4GFqo+kHU5?=
 =?us-ascii?Q?fVBtjLP/vvJYKdegOMSspwWFbkqcaScQ+dbytivWxUAXCIOmDS4CIkPaRihq?=
 =?us-ascii?Q?6igWrNXNW5aWuyHeFkANnFxg3vftTgbTxU2AGp5PtIs5HYe5Osto1RBTF7kl?=
 =?us-ascii?Q?E224L0cuUzjTG0iOUm5OvhHJSwszSK2uw1FBNN5ARj6iuZVW363J54mihBuu?=
 =?us-ascii?Q?6GTYtVX5s8hoo/hLinKwwheAJkD9ipVxXiCKHbhSnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BD6ZdViKna9Jqhu1ZXvFu29rLpWONyG+kAza/r9eGssqvJlCcZzepH+YCnHM?=
 =?us-ascii?Q?/M2TrFIyi0Ycdm7Uvd3hYiyuXkLt7xKZh1CObi8jEECaX2i+y6/Z7RxxrJjo?=
 =?us-ascii?Q?k/Y5j0Zr2CF7rHQqgb6ehGgybj75Ik5nqhgXQ6m042XdmyAn6hJ7mcKOuiGo?=
 =?us-ascii?Q?xJVanB5G9PJX61lhR4b9PI8gAkQpCc0PlII9fPsDo0dZCHSA4ID1036WBieW?=
 =?us-ascii?Q?iXzcRh82uxLhLKcXfaJLWHahLWfIehOkJYN+PrtgKkpEfDYJq0/16b1KW0C4?=
 =?us-ascii?Q?GlMGgaoPUEP2ZlrEib3a5lkrm8Kqgx5j1zHLe4Pw+xwObFHBoExtoqIUJnEv?=
 =?us-ascii?Q?NaaP+Tph4wAeEMbcGyMzhUz5u5hR15rWNTB7khjYHQb3fzxBR3wAQ/pgNGww?=
 =?us-ascii?Q?Sah0BBKvHzspYXs52tCAo9hsStJMgea7wRhtW/wQYJFwiv0ByonfzLE1MdUc?=
 =?us-ascii?Q?xrStLa8kcqATkq+evMhmud7NhNIKCfc0o6fQI9XiCwysXjJWAUyhipnePDps?=
 =?us-ascii?Q?zcRlzzJ874JEDObySq2WkPQdxde96jEHQe3E2IEI5apSUr9I4AjLttaNCuIe?=
 =?us-ascii?Q?OdpEzygn/N1kpCxXTVryesOD+Uv7fkCAmlstKdOQ4ptxwcpr4CCngaaC4A1g?=
 =?us-ascii?Q?mJg+LQbjGTfQ2qjs0dD0f8tH93w52f3WiKP5oVHyFDP1/c1am73e5d23Wtlt?=
 =?us-ascii?Q?iqpsmBnQf9PERqNtteCS2u9k+splXjLTYzAXbSmxSPJ6r9ndZtl9N7ec8Z/q?=
 =?us-ascii?Q?TEv97jG+xo1nvZILQWdQyXphDoU2+/efml//o9/zEDoixlXax4mPT7mY2h54?=
 =?us-ascii?Q?6kVW4YvQe1wycCSbDr2qYJteGwh/RqwZasPFE6DSShBWbXviZT5C79kHt3YH?=
 =?us-ascii?Q?o7Z55kzg05uHypH5QIkqkW9h7p1YMWGMpXrgBMMWk/me5Uj0x1rzgRWYYSLM?=
 =?us-ascii?Q?gSe7JSuPc9xJi3gPgJzOzaktom7c0GVTWbrcRN17zRKz2k0SqCda7Hz+cmvw?=
 =?us-ascii?Q?5QktV6g/aYDCcu3ln+nH7Txd8mkyhRw8fPzhMD8f1KtfmMb8PTRnrVrU71ps?=
 =?us-ascii?Q?SlEA8yrltBUNvWOBitkNALLSoqJ7OPFAQERst9RhHRLRBpGWn1HOy4h7jEtC?=
 =?us-ascii?Q?af6aEggYbaFhl7fUoXUYGFKxQBhr0fqc3K4/C+N8TMgyp0dRaxroIRbqr5bG?=
 =?us-ascii?Q?iuNrfGozLlhQ6BxgBWWmNSvTx+IYBhIlO0reLqQxChepSqKJw2+NdweYFprk?=
 =?us-ascii?Q?UiaS9Zee6e0B/rvRtyU+eipT/qg39PSqoZBDtlIoiuv5fK0YuJf8PZDRR0hQ?=
 =?us-ascii?Q?sYV3tR+xwqm11OHP5Y+LSf3itfq5y/A8w2U2pnXWE+hlx3QKxI0oZBTx0k3Z?=
 =?us-ascii?Q?1wpFTf43U9aZSLl5wr58B3CYMzVZP0evtMz8EgA/AwqmTCVRtuJ/QesloLxN?=
 =?us-ascii?Q?DIQNevjW8/Le3bE5MUikBAE74FJ1SB8Gek4uM/CUNZCu/+SSTgO/P4hLYqPo?=
 =?us-ascii?Q?GX/zxbUtDvwdGNHkvcKm/YBNjyM0Vx4TvWWx60GuiF8UhxAE0TAi+d8y0hZg?=
 =?us-ascii?Q?hOnpg6AOGo4PJu+N1qt1d4PBr+XHO/qq5KAy7pZ2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3169be9-0ed1-4685-49f0-08dc81a0c9e4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 18:37:56.2458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzxwAmJy6V8tu+GaZU/DLg5LdfIimLwr1nsNhB4ei307SZxD0puQ8ZHDqjtZ/NsmrKCAghlcbrX0TD1alw8etQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207

The kselftests may be built in a couple different ways:
    make LLVM=1
    make CC=clang

In order to handle both cases, set LLVM=1 if CC=clang. That way,the rest
of lib.mk, and any Makefiles that include lib.mk, can base decisions
solely on whether or not LLVM is set.

Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/lib.mk | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 429535816dbd..2902787b89b2 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -1,5 +1,17 @@
 # This mimics the top-level Makefile. We do it explicitly here so that this
 # Makefile can operate with or without the kbuild infrastructure.
+
+# The kselftests may be built in a couple different ways:
+#     make LLVM=1
+#     make CC=clang
+#
+# In order to handle both cases, set LLVM=1 if CC=clang. That way,the rest of
+# lib.mk, and any Makefiles that include lib.mk, can base decisions solely on
+# whether or not LLVM is set.
+ifeq ($(CC),clang)
+    LLVM := 1
+endif
+
 ifneq ($(LLVM),)
 ifneq ($(filter %/,$(LLVM)),)
 LLVM_PREFIX := $(LLVM)
-- 
2.45.1


