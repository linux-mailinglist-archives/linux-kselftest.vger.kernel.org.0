Return-Path: <linux-kselftest+bounces-13177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C54A4927080
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 09:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8B61F24F95
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 07:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE151A2FDF;
	Thu,  4 Jul 2024 07:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CZNb9M8Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37FF1A2FA3;
	Thu,  4 Jul 2024 07:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720077934; cv=fail; b=OMVSoG00uFuNoKoES/aEpCNqKqwu7hCFZkWNSHQJzPuM+H3KCIJ1I7fSMfv+z4Xa3rRaq49mhSVONF3iZB43SWAj+MbPX2yg7ubeQpmlxhL26TaTfUJpZsoy5LL/5MsJOPtH3jaNhOcwPsCxyI2RdrqF4gtKPuSJ01EYCYvXEBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720077934; c=relaxed/simple;
	bh=R2uFp7LxQhjHDxOETaUQduZRHgkPJuFGWO9Fm6/Vg94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aeJAjEE2Pf2rvdJoQZfhNr8l4X/Bpvq1nOOcvHZ3bGfTctN4mjKUtLaPxDufxToDI8lv9zcAx7FSLuSAq55mp6JoIG37g63sn+uWXh8bJQKNLsYVGqGFc2DTzE8dN50PxMsiFJtOwZI9eSqitKYry+9Si9yomfcGkvfjk9Z2rY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CZNb9M8Z; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2Q6GF8UiIGy9dKUmkodKLGcHtbR8LoDlhRcbIZ8FSPMf+r+IAHhptYwvIvRvPwnHpmMNz700ppeMUC7afLGgTtiejHH2iK0GwSbiRECsCCyv4HZOW7qA30dWxbAzbEojZx+l7aFb0+BfCR+EuVgH4UFyPURxxpdxqDqyN6Ow2gr+ZblXVx4uPDt6JDGI/tKsluZIhc1W5m6nO24wplglU//TOW23sYT7UK1leCaWNmjCueJpsdf5qwxxpiYY4gZHgw8WmFSD9kOfyHWybUsOPdIYx36wtXb5QqmNiWxaMFHP5AFpZnXoPPgq8V2mOkunX734lHbmulc+4MhLxp3Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dN/cxnEpgOPiCihYwocCeyUVpSZd/JqCjW3g+U/bO04=;
 b=VD1y92ReLvzuPmJSRGkSPglq5+jFZDEfXsvSBunbrz5DdukvWnpHrdLhbREVqL3nCfFwJR4fsbEdgdx2ugY+SGFC2TSTh1FnVEv97U3f8NN3rvpnUWImOy9cqKfYZOyrAiKCgdfdszPBWeXtF7O5IMGHXREDTChvd6mzLM8vuktjtZn58Uu+SsOPagwlaNNHqGItDoEAgWBvmGRFwIwpd91AEIr+njOor0CffA/uIPD1KQMm+YVcFiPCY64y2X6Iu7dk+h4jLP7vTOhuQe5NCsKhDEZB/At8SF27oQJtwAojWxVDSXgQRaN1oV905Z1773zzyFZcd/IQeIzCGHeWNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dN/cxnEpgOPiCihYwocCeyUVpSZd/JqCjW3g+U/bO04=;
 b=CZNb9M8ZBE9RFM6EfFXm+vslllYMvBfnwNsiaRvSIRPrIrf+YbsWnH68MSI33a+PZZUHykJ6k70MvobLWPtLhlOwcUvai/jvm6bXRpAruJBrt16vKJT4j0HZ7gUQPZRDWK4e8gEM2dKMs4zbKhDt9y758aRXeKexTNQo2S+kw3q81J6ipxXHDcZkOEWZeNXnRNDh4dZgziJTURxjw9IzQL/o2SnW86RBrBB8FCw9MTcd27pJcKFBAi7JVaolaMHgnBWQa4Q4gMJdkzi3sXb/qp41Pc2NPe/Wgd4GwUrExuCBCWic1UqVZ/r1r8ZOD75Y5ujVH7IqCx5W+AU6mCmFIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH7PR12MB6610.namprd12.prod.outlook.com (2603:10b6:510:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Thu, 4 Jul
 2024 07:25:23 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%6]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 07:25:23 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: angquan yu <angquan21@gmail.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Yu-cheng Yu <yu-cheng.yu@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	x86@kernel.org,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v4 5/7] selftests/x86: avoid -no-pie warnings from clang during compilation
Date: Thu,  4 Jul 2024 00:24:29 -0700
Message-ID: <20240704072431.111640-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704072431.111640-1-jhubbard@nvidia.com>
References: <20240704072431.111640-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0149.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::34) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH7PR12MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d21942-8c13-47e2-38e6-08dc9bfa77fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VwI0wrIs97+lWCYWRdWfCb0aSJY6Z9TfdtdC3prSFMzsVQbDXxQl69nzMCLd?=
 =?us-ascii?Q?UdgfaN5PTUggFVk0EYZuvKV43AYXCP52F7ZBr1MhFyWE4QXXxUvYg86TSqs8?=
 =?us-ascii?Q?uumJzfod2BjLyvek499tygYc9trcfAnNCo0Wx6CeT04/blRuLMTuPzz0JYez?=
 =?us-ascii?Q?vjDH48MG3gJ8UivV63fAx/eMIdoPjwL8kU6V91fvcOoTw+pBP44vTOwfEvM/?=
 =?us-ascii?Q?6T70J3ETQXiPXkE1L/2JLX1rIkXidq+wjzsWL5yEm1OQiScK6/yeE0eTbnpt?=
 =?us-ascii?Q?IGl49V8buPMLrgIqoxeAkDUxsG3jUVzbzcDir/rpDY2SpqRZqUPlBXMpilcH?=
 =?us-ascii?Q?KN2rJXVbfVtIMLculAg85WMtfZnv/y0KgS+wI+ApSvvAmnsW6U0wmlliA+ND?=
 =?us-ascii?Q?/wpk3lr/8twCsjEUNNhQv+TN6zFURM/Ko2wuctsHT3EmhFpYzqaQ6CNFjZ0f?=
 =?us-ascii?Q?7mNOe9EmAiO6Z7UAtjlyK+kp4aQ6+M8Fn29CH6rDMdOPCAykQCW6TU22b7NC?=
 =?us-ascii?Q?G8cVJXXK4AxtOMt7G+FFtgbEDkKKmSYMPU77VB35w1M/hDxYq20FN24hqx64?=
 =?us-ascii?Q?59lqBb3mjLZuLLX0Y1qcf+m/eMMBZNEky85+Pd44jYIXmNEvPwiN1/ETpxQB?=
 =?us-ascii?Q?WFT7yc0vo8CGktjOuEi/ANOoohuYGSiRzkrlPRHkYjE4OeEqzSQohzguvIGB?=
 =?us-ascii?Q?GpWtRHDIK0MVrCwkdQIx3xF88WHuNiKgdk9m25RibJkarCxrWWcvk+/CRfAz?=
 =?us-ascii?Q?iDuamwIgEEj8mRpnfiifKH277IrKEDfGRWJfIiVRTtzvscdNcQtWlZ7IN25+?=
 =?us-ascii?Q?W962FDZ3IP4ja7xzkgS2Z1qWNXdQH/FUz/YCM4crkx6iGcvfgTX1eX9pNugQ?=
 =?us-ascii?Q?T9GC1mfrY5M3wLk0Q3sSFfxkeItMtKEKoJ22F6A20jSg21ltaHeozt2S74k6?=
 =?us-ascii?Q?qPOIMPnK3t7n1uJTW1/SAi8wJtxiKD9uEI+xB5S6PlZbMkzqQVGjhAIBOJZO?=
 =?us-ascii?Q?CDjy7CLHp1jMQRPgUqNDP/0xeU26o2f8rQQQpeVmX0MbgKB4Ly3So430Vh/w?=
 =?us-ascii?Q?+y+m/rByz7TMMltqYBxB9vGcyjQ/DQV+Mqgcp5tJb96zlgZRBL1A7oRR4964?=
 =?us-ascii?Q?q4yl7nojbTitZpFsiBovY0p22087pIA2EnkBcvfVRaQIXs6AmZ0WizT5EKj+?=
 =?us-ascii?Q?oV5CcRjCnkGejS4ycLUZhRlRfMrST4DjPPMRzozOkLej+XQ2wQ0AfusSKyLk?=
 =?us-ascii?Q?78NLLKKiw4Ya/p+dPi8jtp5GHLOxATtIYSUPAFSByaO1YOf+snGSV4q4Skiy?=
 =?us-ascii?Q?SG2m+WYpbmzHmBqyyW/cL1MdDO+nyT4w666vrm+kOJvvhg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uSE9GgiK2LPyIniwlbZmfuf/Ay43kC1+DrkHyzI3Z7+PkOmh+pkSVC7NjpUN?=
 =?us-ascii?Q?CMbqa9yQ2PX/5TBbMO1ejAXaHWxiM5DyXwW6tqCAx3mYe3sFkRnwWDa1YsF4?=
 =?us-ascii?Q?UOnCp6wyi++NxqdE8crT73/9/wiLrpIwxAKBiQDOrIdB4mo2wegBd45FHNZW?=
 =?us-ascii?Q?W+qMEyxKtavIdhGFaiQSZ1r7zcx0hXjNxIfpdykhNvW2naqbWV3ZZvojisaz?=
 =?us-ascii?Q?MpOH5BVZNpKgLYLIFS3jkkt9ChIs9pW4emFRUdRVGD19PsT0JeWIDviEuGhR?=
 =?us-ascii?Q?w4TNsL7z5llwJl1KI49PS9iZQltOYdH1knvAZRSd/utYAN26DqCgAft9jHW7?=
 =?us-ascii?Q?1yHEowrHxsSRisKgx5wU3rzE3Rhv++u84Y0ptncW+hKZvyDh9TlQX14w9Poj?=
 =?us-ascii?Q?tsZ7qKIqp2xpPGftZHq3x8Q4ybcKgCrbXmHD49E76vYFf4gh6cAQ6H0x/rPQ?=
 =?us-ascii?Q?1+2kpPQhCEGEIoSCmQffj2uCZpvLe/opeXnhi9gDSYiOTQ9leKicQTjW5+pA?=
 =?us-ascii?Q?fjQXms4X/L2JxSKZCp9An9hb6QPWPpEnzlvy/dobKXJ5+KxZeLFZdLbUSu7n?=
 =?us-ascii?Q?BZXlgOitvPz8xxeeE/IJWqhMqkPWdtMZ7gW82/G8AoeDuM8pgJBaaKI3mpRa?=
 =?us-ascii?Q?vC0cl9OAyNx6z5NGbi6A3QZUVQWNKDoGBvOuKotTqMeBuUilxiqe8IHSSyJ0?=
 =?us-ascii?Q?g0Q7BTPuSAGn4mb9gKIjzeB8LN/kC7ztzSmO9UM/XS7/64SrQtam+E5UbBbs?=
 =?us-ascii?Q?omtG7S/y+rBH5bmdzdK4hZaa7gj0RY/D56TEx48IAkU+SsOdBC70uni5Hd6s?=
 =?us-ascii?Q?nuUc1DVBNNQ8FZ5RawVCFr6T4qQOAVLU1AUSAIZLqns+Eo7HniahUyB/cpcA?=
 =?us-ascii?Q?gAXukkYBi3ZXIKJ1z+gkKMzgsihYWA8KhCOx8q8DLVcRyseIJvAOlHwiJLFQ?=
 =?us-ascii?Q?0eyu/ZJukAa/uVi+UpaaD2qKfpd790UIRr2hEuAEzsjfnodUWY3dtWJZSqx+?=
 =?us-ascii?Q?CdSNNQKhE5cUXCXlkX1nM7NvhdgXsICirSs0nIPse8w5+FKvkELxTJv0pnJN?=
 =?us-ascii?Q?81qtJ6lltHiC5OdiPtqR2mxajaLvmuLb4LS2jbt45Ps10ZW7U3w4Jee7DrCK?=
 =?us-ascii?Q?dkms2l09uN/BLBbe2WalvvVsGldcTyTXI4Nym5O8n32Hqrium7j/Md6bn9r9?=
 =?us-ascii?Q?9omtdnMhpnmhw3f/5tO02JD94tDDDsOjNSjkNEeTDcLq41ae+qDYIMpoclgP?=
 =?us-ascii?Q?MsOxb3oOERSwwI8gH2Iowyz85IOZb11UJR6cTnCKZ8YTbGGiq7Hi+FXDA/cy?=
 =?us-ascii?Q?wiczY58D0ISly/euhSzYpGUrRvAQvIP4sHT0yXTJGrSCOA/060Y/Xp7BlRMo?=
 =?us-ascii?Q?JK73zVzdRp8aUWIQQ8ic510Gycc8TKN1EcX+zO73K/7R0E9owwJhUAui6d/7?=
 =?us-ascii?Q?TeNGVlEwL1MOe9xo7PzB3YmWiPuMTLVxWGOTrnFFyVIaCcRGnsj27kVS2ZSZ?=
 =?us-ascii?Q?q2h/x2YhyEP/MAAmxfzplHCBDVob8pgbntigly0Vkgdcs/fE3AttO61UPpRw?=
 =?us-ascii?Q?9T7oPInY3UwL0xahOc1oN8yv76mAbNf7NmVcrjiIx0RipZborkvp5KiHw+2n?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d21942-8c13-47e2-38e6-08dc9bfa77fc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 07:25:23.7462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tafXZ/F5tStBrTsJeva1d618NVpgkR2qKCgcY0icRmzD2gUBPxfbcVnoTuFe6wYhqa4dXypshVC442w8mHzuQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6610

When building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...clang warns that -no-pie is "unused during compilation".

This occurs because clang only wants to see -no-pie during linking.
Here, we don't have a separate linking stage, so a compiler warning is
unavoidable without (wastefully) restructuring the Makefile.

Avoid the warning by simply disabling that warning, for clang builds.

Acked-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/x86/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index d0bb32bd5538..5c8757a25998 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -40,6 +40,13 @@ CFLAGS := -O2 -g -std=gnu99 -pthread -Wall $(KHDR_INCLUDES)
 # call32_from_64 in thunks.S uses absolute addresses.
 ifeq ($(CAN_BUILD_WITH_NOPIE),1)
 CFLAGS += -no-pie
+
+ifneq ($(LLVM),)
+# clang only wants to see -no-pie during linking. Here, we don't have a separate
+# linking stage, so a compiler warning is unavoidable without (wastefully)
+# restructuring the Makefile. Avoid this by simply disabling that warning.
+CFLAGS += -Wno-unused-command-line-argument
+endif
 endif
 
 define gen-target-rule-32
-- 
2.45.2


