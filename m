Return-Path: <linux-kselftest+bounces-13179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21476927086
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 09:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 944281F2508D
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 07:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1933E1A38F2;
	Thu,  4 Jul 2024 07:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M89PoW+s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A50A1A38C2;
	Thu,  4 Jul 2024 07:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720077936; cv=fail; b=myK4RoUsWW+6yS7p0ISUD445iz8el4ZxWzNZ6fz5cF+62Riv9pndwX1JUg8SuktD6uQ+uQN4qH/4+1Seb1RsRpPRhwwlf0g0S/2NYCZr0GetqmHi/dkct0Emii46VpTYzh4wqj+sKMpy6iJpRcynQUzR5QBzXjnp3p+1zbRIQP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720077936; c=relaxed/simple;
	bh=SaE/0Pkfzvvk+suDwmTUuWvjvCY4+8vjETCePovQka4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uqRt3dkcvH+M5aeOw6Qnf6fpmmrWjlRFDVS1D6BAAB2mOuRgg8snloxqC8DfoyLsugn3/HuvFjTb/9+R4fs5UZkFyGbJbX7KfS6hN9vuNFmLbSqR2c3OFpmIH+sOTLLEp9Z0x8PP9xXvNPqujX103SKg0ozJFNyEp+AKI8FCRu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M89PoW+s; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTj2HEXJ2Pm/cZjiDrDg6Lx71UXPkb47WR4tpJNjfjy5E3WLbAnp+QC7Hwehfc77S0JbU0N/WByIVjMPc+5f1IKjr+W6M0p5G7XRHgRDJlwp13hYOt1uIhqyWlNoHfetdklX0d5eHufFMHmf7T+s72CIccYENOGlGitFQIBYCRcLrftDbt6MufApMAWcncRYr0+FyARuR7ZCsfFBNXrlQ5dggdWZYLsESJGMo8w7HAdQyrJbbKN9+NlGbg4qDLcSR7/jBPpN+0Vmm18RC1yyn3mfg8rL+1UTa2vuYaTWcMtHiCCc7ALnRpeCqbMg/T/Np8oEtTEOSRGTAAdJccVuXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zb5DkSrbT/a/sdIvEdu3XVmNC3ITCZ/3J3YC9+olM9k=;
 b=GEu9jXFr5AjLnLGTXF5VHkfQnDOVCh+Z9PNV8bkWS+UTiHT15jexGVaONxLUzWg+R66EaqL2L1XEYq72h8jda8V5zerEY3GY1H5FXjMS3o3wYQ8cXZcSblem0NQDauQcVD5Ltp99+I4EVZgq+oO9VaYBlywJeYUm8vtPCpQBbHzQ5yNooYgbJuyTbCBIF9NjwGzwj4OupmneQ+SJc+Bp+YhMEXOxeK189TPzoRfy2LgoDG8loL5Nx/Kgrk6gt3jFeZc0n/xTDRrS4+aF7oBgmDS6nRflrgR9umzgaWoenmIy8fBFUXT+HmpAFpQr8MeK3B33HR4+FaWXEDBUOdy5hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zb5DkSrbT/a/sdIvEdu3XVmNC3ITCZ/3J3YC9+olM9k=;
 b=M89PoW+siVqPjs4fzmdWHLM8RpWdUrB2+BDLkdLyxXHMJelAbNgryypzg/yKvXEj4PtSLMfi/+tO/bXiCVYfjc1JlZO/YtcqOGaP790psHPsX8mBnV/AtiJb3ZSH+ubWOO7Wy38Jmm7o6j1QNbBj/JpdDrzfBfKrAtqvKHpRnINH8ZfqPCtVTsf57o+EA8Wm1ltGyZww/jQoTXadefQ90tIO/bCOK3DRuKgm99w9Hdxl0jKn4utxhNPNuoNL1VBTFk9sxwwCSa4xbNI3FQGCtsR8mSnx3uwnQwu2EUvOs8bZsPKugZhhR3PxBIzbZhsJYK2ZQg2+nmjEJd5Le+8KBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH7PR12MB6610.namprd12.prod.outlook.com (2603:10b6:510:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Thu, 4 Jul
 2024 07:25:25 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%6]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 07:25:25 +0000
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
Subject: [PATCH v4 7/7] selftests/x86: fix printk warnings reported by clang
Date: Thu,  4 Jul 2024 00:24:31 -0700
Message-ID: <20240704072431.111640-8-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704072431.111640-1-jhubbard@nvidia.com>
References: <20240704072431.111640-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::27) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH7PR12MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: a684b971-c664-48b9-878f-08dc9bfa78bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CTCE91FeZLm4FyUt/Nv//bzDW1NwjXQ6txH6JtBJB3/pWWO6wcR0vLqpX3+o?=
 =?us-ascii?Q?K5/++Vg3Wupu1U2OQnv3lvYQ1ku1+4ZpNqq4oYdraOOb8dsdjvbJ4/4PWwlK?=
 =?us-ascii?Q?GZ4+8J7dmol/xNGXvOKi6vv25Kq2sjZplUtacNa02/ZWV6RLcQeINIciWSeb?=
 =?us-ascii?Q?AQI0wlNhSnL4sezFkdjI4Yy3ve1fKUrTlLdEK+B9sUt7oJvZ9H5mXG3UH+LM?=
 =?us-ascii?Q?DpnH2K/WnAmCan55ad4PtU5Y0L6Yw5q6OrVFO0LQN8cKVejImbsfU42ldZyl?=
 =?us-ascii?Q?dTfIHjraAPLRhT2V4f0lqNQ8ZqhHU8QFbdiP5ORJ/Eoyceo6bLMvt5doP7no?=
 =?us-ascii?Q?YgjF+58f0FL9yVHJ8q49f5/GGHsyvveSBgXFKp3aJKJMXOAhGftxRnIUvNv3?=
 =?us-ascii?Q?2yGB/XmVP0PscUavAh2ibe/cEQ1tPstSc1Zhpz9etuGVY6HAxoXHzVNYR1IU?=
 =?us-ascii?Q?pb9d3OTXdn9CN7rOVDBUaipKc+tA8b4WV1IK0YGrzfVpcM2N7o8Q8t8nupxN?=
 =?us-ascii?Q?V64pfUuKjtaxDwkbLYV3ST5fyI53WJUUB/KqSzGolOY0Lhcpgdk7uWAPFFDs?=
 =?us-ascii?Q?2iXTKfdhG+uk/VVUmLhrE6a7fxmsXMtNzlIKwcBSmgZ/5c5mqcZmrxfV8nc/?=
 =?us-ascii?Q?NGVUd2JVfV8geM/Ap7IGuz2sTIvHgCrCm3GwbPq0Udf3x3dZ23IkJix8WbSO?=
 =?us-ascii?Q?00pmMbD4bCW6giIvFEnMJ2hrhOz8odx+UoSLD0w3ayJ4e+60zwRTrSLDLWxE?=
 =?us-ascii?Q?B2NRwyl9jrm3p3o/sNg6NHgWVjrwGGIy4Ugs1DyUkTNv6YoWCKJfmBazp86/?=
 =?us-ascii?Q?h2abIS6GTwQIN8TZRIZRmh4ec/etD7JvA2/ly9Flg9UTPfCqzsx98XFECDLd?=
 =?us-ascii?Q?oOwrQw0EchGIZXmg1hlWcFvHRvIO2sdpZCmv8zL8VeSWy3A70TH53oZXO+ma?=
 =?us-ascii?Q?Lo6NssvWsltsQLXhV44w9BnXn6TXlNv3LYVpsaAnCkrOTLb2DacmCltLIMkN?=
 =?us-ascii?Q?aVGQgkQNzOXjElSsSP5UdWNQyU/4fTvCmHQcp03/OV3H/+kze0XvreNa2ElE?=
 =?us-ascii?Q?TgcI85pVpkLh6oIW6XEAPLosKOhfgOU/vWAslzKzdsjAM1+1/fluoQmuA/SB?=
 =?us-ascii?Q?aDt6phwyUqYVyoJV3AigD2QTAnlSA4AkHe/drMibVAnv7929TfhbMYrQLx3o?=
 =?us-ascii?Q?yVY5OpOOTuBoaSbWUQcAHb5yer4UFWHsPayO1G46NFidBAHkYhw2HnzjKm7X?=
 =?us-ascii?Q?J0qBbrggN0SoA7diFDHrYWGn+36HTtYm65pHTROCOjRIF3FP6FMeEoP9Sy09?=
 =?us-ascii?Q?jq62XyaXNYk3AjNjBk3W2RA+bq/T6vsLUAo28AQyfBO7fQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DNQwpyPKko7Ysth6UupJPzFh5m2558jx15EA+TAJKMj2xfAYlfwbp3rgpa4p?=
 =?us-ascii?Q?mehwsEypHZv3Ppo9FpiPBCmn4Spj9fsv73WzKfacuREhDm7fjg9qBqZa6czY?=
 =?us-ascii?Q?YD5+MTCAv5gXkAbioiekFw74B2POKXVWJQbv54vga+Ahq15fLt8D/lSVHsWz?=
 =?us-ascii?Q?HxhEzacvl9QFmi94pM23cs/1R1eYVsc7fW6k3Oa4YFonYqPL5ea/b2stQ8On?=
 =?us-ascii?Q?UB+5DxAg2fDYFPRkqxzsynCPotcKBo1vopnLggCrOhc8vWn0DOzdaBEYmGTO?=
 =?us-ascii?Q?jMff3Nnl4CtkmvK8Wdqo0+nhT8h1wxKe56adzwx7G0fayp/Z0DBul5uP0+gw?=
 =?us-ascii?Q?BQPcsX7GY6tceK7/hfSeiHvMUd5HGjC2EUeKZ0ONGqp1EtY9VnfyVLb5J/Xu?=
 =?us-ascii?Q?2Ws11ygOci7GJfujjeG1CDQsS/LwxyEepeh8S2JoKjfvFKmd/97hh5HB63F0?=
 =?us-ascii?Q?X+/YZqmZVsOBfMslMNpO/OFajgSQwMo1cxZ9PA0RzTvhzgtU8h67yCvHilNA?=
 =?us-ascii?Q?ukeiLX17ywDdiGvE03yXaUCC9t79N773Rl8aOYRf3ekgNgwiVwq44qJIayfK?=
 =?us-ascii?Q?kXOVZbc2e3x+kOJqEx7z1DNEhxfvRhA4ns8sFGQ6Yklg79sDtJCCcWWe6PaT?=
 =?us-ascii?Q?xjXn8f3WlKNFiOVSsMxg3HHL01z4dmcJEXdKqPF9SOBi6mrA193ywTS52pjS?=
 =?us-ascii?Q?2JDQkt3m9Jor1OTe+CQm94O6PrjyR+IR9UIS+NnLlR4uvK9khA6Q3md80oG6?=
 =?us-ascii?Q?x7rI6uBeaF0YxPT6zmuGra32z0NtWhuB6fvMusjgljjDGBInBy6hTc1VUVgN?=
 =?us-ascii?Q?Chqv9rRCs6RWuxzwMiDFg0F073NLZdhZaNxeT8T7qTwrNgz29ZYsQxlmUQyj?=
 =?us-ascii?Q?W/obrVG7zvimqOcNS8FDPHvuMFFh8npNWsb9htqxSScacECQIpugioFsBqpT?=
 =?us-ascii?Q?aRGX8HbRY+6h5UAw7w2OaChb2c+BxRlWn21SrRwzfG4BvUfLQuRUc6w0HrBk?=
 =?us-ascii?Q?W94AAwFMm5SJ+JF4DRmWyvW369JurNJ/CmyKFBua43arGPWOAgLzTtCIORIX?=
 =?us-ascii?Q?0RHz68tSeE8jgVSjHsMdgjAsXXx1ggW2ZoKA7V3E5gb677hOcc4TbrCYZ7ZB?=
 =?us-ascii?Q?D9cHG8tA2LIJVfCpZzphXKDib3emVuqx6FR4jccBOcgfpdc+fRQXcu5SX8um?=
 =?us-ascii?Q?I8sXCLKqoYvym/FG5J7tIRRtljSmqYqGfPqPX5ZMGotF3KnhMlEghM1DVoxw?=
 =?us-ascii?Q?MJnNyfSJBQEdmZbv8oOrCiFlVGXGOIKscM2L1+9AImlx7kzcZu/KMv6Qtujl?=
 =?us-ascii?Q?OOPeojj6AhUoa8r5jusCdy8WetdvE6EDx+IMF3vQ2/pXL7q7R8tcji170Fck?=
 =?us-ascii?Q?ch+4iQqjtj3YsId41K/zLFSVQYYzC6Ju7LKKUD8rWa2DayCG/6cPasjPTek6?=
 =?us-ascii?Q?T7jJ9FmteCmE+tzKFoxTd+71BlGsnjrre0Gy1R5atuHjJYw60QtS1zfurkmn?=
 =?us-ascii?Q?OT7i+5ECgBIqWFcCc1gF7Epq7uAz0mp2zE+qYQR2/hnxZZlBcW1UN7Zb11fs?=
 =?us-ascii?Q?NJyEt7Ro+3MhF+Z+srZQGmT+zNdcr2FY3jCsZXHjSfaqdmPuhS+blkzcl91E?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a684b971-c664-48b9-878f-08dc9bfa78bb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 07:25:25.0244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubxRCafRkXZy/+NRojQF0AbTrqbNaI6Q4YoBH4UyPEn+o36n7PNwJHegaB0S6JPbx22McgdtZg4VCd3XvELjKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6610

These warnings are all of the form, "the format specified a short
(signed or unsigned) int, but the value is a full length int".

Acked-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/x86/sigreturn.c     |  2 +-
 tools/testing/selftests/x86/test_vsyscall.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/x86/sigreturn.c b/tools/testing/selftests/x86/sigreturn.c
index 5d7961a5f7f6..0b75b29f794b 100644
--- a/tools/testing/selftests/x86/sigreturn.c
+++ b/tools/testing/selftests/x86/sigreturn.c
@@ -487,7 +487,7 @@ static void sigtrap(int sig, siginfo_t *info, void *ctx_void)
 	greg_t asm_ss = ctx->uc_mcontext.gregs[REG_CX];
 	if (asm_ss != sig_ss && sig == SIGTRAP) {
 		/* Sanity check failure. */
-		printf("[FAIL]\tSIGTRAP: ss = %hx, frame ss = %hx, ax = %llx\n",
+		printf("[FAIL]\tSIGTRAP: ss = %hx, frame ss = %x, ax = %llx\n",
 		       ss, *ssptr(ctx), (unsigned long long)asm_ss);
 		nerrs++;
 	}
diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index 1c9895cfc660..6de11b4df458 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -247,7 +247,7 @@ static void test_getcpu(int cpu)
 
 	if (ret_sys == 0) {
 		if (cpu_sys != cpu)
-			ksft_print_msg("syscall reported CPU %hu but should be %d\n",
+			ksft_print_msg("syscall reported CPU %u but should be %d\n",
 				       cpu_sys, cpu);
 
 		have_node = true;
@@ -265,10 +265,10 @@ static void test_getcpu(int cpu)
 
 			if (cpu_vdso != cpu || node_vdso != node) {
 				if (cpu_vdso != cpu)
-					ksft_print_msg("vDSO reported CPU %hu but should be %d\n",
+					ksft_print_msg("vDSO reported CPU %u but should be %d\n",
 						       cpu_vdso, cpu);
 				if (node_vdso != node)
-					ksft_print_msg("vDSO reported node %hu but should be %hu\n",
+					ksft_print_msg("vDSO reported node %u but should be %u\n",
 						       node_vdso, node);
 				ksft_test_result_fail("Wrong values\n");
 			} else {
@@ -290,10 +290,10 @@ static void test_getcpu(int cpu)
 
 			if (cpu_vsys != cpu || node_vsys != node) {
 				if (cpu_vsys != cpu)
-					ksft_print_msg("vsyscall reported CPU %hu but should be %d\n",
+					ksft_print_msg("vsyscall reported CPU %u but should be %d\n",
 						       cpu_vsys, cpu);
 				if (node_vsys != node)
-					ksft_print_msg("vsyscall reported node %hu but should be %hu\n",
+					ksft_print_msg("vsyscall reported node %u but should be %u\n",
 						       node_vsys, node);
 				ksft_test_result_fail("Wrong values\n");
 			} else {
-- 
2.45.2


