Return-Path: <linux-kselftest+bounces-13251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 344B3928DF7
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 21:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DE31F222AB
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 19:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5612176256;
	Fri,  5 Jul 2024 19:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YqoXSdAD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D418E16E863;
	Fri,  5 Jul 2024 19:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720209470; cv=fail; b=k5EFTwzD2Zmyg+bfa/iaY+0H+2luUHDtQUqBlUOnSoEuN3iu0cckUARfG/JzScWF4fewaNUdGQ4lIGuaKva6lN3ylIBXAukJXoKBwzpOm12X9ohLDvtiiXXf/PPTNRSHyl73lTFgQ4Xvw5aZRSxEXoeb9oaEd4yu1pVuouKy0Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720209470; c=relaxed/simple;
	bh=MgHmNWKEluy7o11yRU54f+76oQvqaqzKi+q0CMeRRs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YbCwJ0oXFWfc7Tm4FliF3Yd/C5c4rv9idPVBmsbnyzljlB8Kkcq6wm4i/r0snNlv//8OA0UZVpGqJ1U44pEc3Qi7zSXrtQaer/Snpamuj8NOWu4RQ+sbsw3n9WU0tQAvXUEfR+xL6MLeat77SKfHgSOsmlQvn3dqp7xR1ZMqcgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YqoXSdAD; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNEthakfs4v2hsuKFQJvtQCn80m7RxYrMQV+x9z6SDyZ8JTI+CFpRj6bc5p8moIOnJtNbt9cgH8X1aYb//OD6OtObq6kPWiiNeCMqffUvG57uNEJxI1+2+67jeUSCc84NJn7WAr9bsoNVKrzBuRvxr9yfBT+rN0MYr1UPoFf+7yT/gqT9Baj9EUBPi7tegnQVnUmwmfKSW7tR4ELlm4+PpzWtH3FrLCeBDDbfTKzRwYEtPFAMKMs6KvCyuspv662Pzd5is1hkZ5FOKhs79nj/Oos7JKuMgyV/javbMIawlFTgOHttyX+a8PFlgBvrZf3ernETG9tQrFD9vwgXyrxnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVye0FQABQG+xEBFmxIGedfhZGdtStZvWVFuBSLoVkw=;
 b=GQOJcBVcIOI+bgWulBClVFfTt94H/IWWY9tWk+FIVIuRixDcRpXx+Y5Lxjj46RySRmj6a8D/7c7axeGr2sHZqSVLsWfAx3gI/f9tXhJELNK87Q1kvw78wPzaV/Rq/ORzS51TrRM4GzBvo/Y7b484NGS6dTMDo4sJb0tlxDg0u4p3uCwQgopnApWxCzSAhJR2NMGm/DQuykfSvC9geq+ooe6LZT23iDsuhk3sfW/9grhJn09HA39BsaWig4qJ0KvdpZbv5OSGntZnZ/UEFotMoZHbYUb3XzeRja0hJmsWmOdMu82XjlWnmZgjeiCUy8MfkCWSEdedE9oFMu0oiqOGVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVye0FQABQG+xEBFmxIGedfhZGdtStZvWVFuBSLoVkw=;
 b=YqoXSdADwGL/9snSCMkUh5+eXP2bYcG0ycxjJ+H8NVIyseImJfQxbfbUbhT5HZD+FDHE6k1eJqKylk0Fv/zkg0OF+8CUworWDyHQniuKRA8/77NmwDPKCUs0ult4RDRnt+ka9JyThzAwzOev1CO/A0PrQ0YvJB+6+eIhO/FpErT63RuXgmVZrPbB4DWvPS39Dya/19bUg0k71NHQktIXdTOsShi+EtMSUwGbgB+lCxhx9P8G695nk3FhdL0OHoXVhRy5Q1DWFme7bdDTQNtLtOmC7+WJWUCRQuBrSX8Gw4v3oejDMbg6MHZC/goiyLIAwvH7xbxrfXX4PurxONdlaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SJ0PR12MB6877.namprd12.prod.outlook.com (2603:10b6:a03:47f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Fri, 5 Jul
 2024 19:57:46 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%6]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 19:57:46 +0000
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
Subject: [PATCH v5 1/3] selftests/vDSO: fix clang build errors and warnings
Date: Fri,  5 Jul 2024 09:57:34 -1000
Message-Id: <20240705195736.34039-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240705195736.34039-1-jhubbard@nvidia.com>
References: <20240705195736.34039-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::16) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SJ0PR12MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e42adbd-45f7-4a1d-429a-08dc9d2cbd59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZQeRkymZrz0tYeh8+6Y+82beno1ZL4YXLWAoFiq5r+/CyPdsQziHxKWGtEMu?=
 =?us-ascii?Q?/NpF1pZrAcqgTNYnskdtWcpV5/TRYgb5W880GMEAI6N30IySC0Z3RxSOW0ON?=
 =?us-ascii?Q?b0lCG4OL4H/QsnfJxd8xFLIA9/9Uo7sFef53GuRAmAsJ+qNz5bCd8vk3A/ro?=
 =?us-ascii?Q?GeZ7+OQvxkCci96C5qzdslk/ExvCNWdRCUXT1iY6QRL3nnDZBdSWL3YUqGTm?=
 =?us-ascii?Q?WFBGNsVRJLe094Ge/sgpAhzLaN191wF1OzFzz8R1aVIGPsXHjd4Hy8awffYs?=
 =?us-ascii?Q?RVH6YRLKVqb1vKAfGc+vf54J3zrBRYTkQUiYDY4cCtbXLHK31dZDHhcrjCWt?=
 =?us-ascii?Q?4GizQ8pNOI50Qmyn1t4DQeMoFHcNovOyUQwWmXE+u3foO9gzh/jGk1QkWTTs?=
 =?us-ascii?Q?40sFvi2IpUFY7CKVwUsxjBGfodDlXaSrG1bR2WTed4kIXln2TJwZE0xask1L?=
 =?us-ascii?Q?bBD78bwD3hdTpuxtG2xkcNmyBDh9kgEVY+WsOlOJEHUceqOkgBxg3x7LY8PJ?=
 =?us-ascii?Q?rTFX3TQkOMRzWJT0usfb/W5eOXYewEdT/fai3v2UqmFn1ig8JGMtydGDNRxZ?=
 =?us-ascii?Q?0Y9kALj3XlzpLsuHbJLlFjwZrDGNpyC67MFF7ALhua78gvi7+tnZl1WOjJMu?=
 =?us-ascii?Q?QTjXDsA8ukQ0jj0yWHmdZuJj7if4dLh3C6Uzd6lyVoFtu5TlI8EvExFTfMRV?=
 =?us-ascii?Q?BL/BFnPO8UiWlEvqWkwPZrmeu0Jgi2l5LptHdmkLT8T1FW/UROJA4ncEpTrm?=
 =?us-ascii?Q?csaJfQMboLvEfpm4/1Q7zFaPtqx66r/wOx+7TIFUSZxKvxcN2w7Q3sCDFEsa?=
 =?us-ascii?Q?dpYb3JufZW3FlHH4CaU97y0mCzZRlhiETd4YrtqE1yTzwnJuqz06Re/bTblU?=
 =?us-ascii?Q?w1PVmfoa3x7kTPfmDgbRqBO7GTEeCd6m6i8cQ4O9nKiijGRkBbFUrIww4EPS?=
 =?us-ascii?Q?nWyBGeIBN22/FiuI34c0WPrkSMaLrKkQO17lFf5Z5t2dxk9HNPmywBBki1oq?=
 =?us-ascii?Q?M+qxBtMSBxjqC05gawHAtqUX+l1mujRebFcPN6JbB0VxtSWNOFxbN5vV4G/B?=
 =?us-ascii?Q?WWYqrQMYRIKB5l+1UXFBON/sxSHhNnDUs/G9BxybHICMNe74PQPwknEOTHLl?=
 =?us-ascii?Q?Du7yaQnjOZuc/qmt/IEynDN+hyK5jCxva4r/dxPiZXrdE/sIaqCbRZMd+tX6?=
 =?us-ascii?Q?6cWU0EXFVjLLMeUWHgJ7718LN6b9n8VsdA5q4yUTdWyHVseUUtFMHMciObm4?=
 =?us-ascii?Q?ocKVWuoNaA/mvzpi6LHqvcS5SafN/f3EoF0RWQ58VkG6lP6CutPjPEXSu5vv?=
 =?us-ascii?Q?D0id0/49+YZQA+8qPDuk53JsW1fxLzYWICcC/UjTM08bAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LQCkuSjdrTKAwrkjgOMQCzvyMKHbaaUf7oAWWqd1nGhBenTHPvzsv0h93AVj?=
 =?us-ascii?Q?BBZmH7GkaKKsE3aqGNRk2Z9XseWzFuf27aSMe2IhsFbFkZJxYNbsbpdyueMI?=
 =?us-ascii?Q?jKIAg5W68cEmzLCL9rBXfWrBpkH9iEeYGEPpXMskbipwWxwaJrHN2JHQWQig?=
 =?us-ascii?Q?ARFr7wQwq3thYRcaFCMp6VJQg/ohUgugiv4RVxwd71uglLI//2m7krzf8q15?=
 =?us-ascii?Q?sjL5qYLX7CbkvN5F9LbNINJYKuxgO0jKHP7lO1IikTurvHGyvwShWUcH+mmL?=
 =?us-ascii?Q?Kd8QRllcKoeHwRnDRYMl/rpeHbPB8woKkYO3TVdaBIkTlFADkuW+65zIksot?=
 =?us-ascii?Q?E4cZqa3O3bHmsYvTm5YzNBwl1+to7m2bAl06D1RIemo39XmYSvtgwQ+u28Fg?=
 =?us-ascii?Q?H1lEqC+o+lf8mKLcRfkfBkX7u84+gu1OWBx0CKISYl8ExI7Y++AfDY4jSSPv?=
 =?us-ascii?Q?+lvMnNWbi1DcBi3PnzOyNisW/SzFkWCBYPgW+jm9MtR0yMHmPhfzP9TGYWmP?=
 =?us-ascii?Q?ndiPQK0OAW1/CIc3KflUwWDkknnkmdiNgjGNIkZpMvhWDlG90RTBjC75Pq7X?=
 =?us-ascii?Q?pn6qftc/3FQ1UtmowlimLaj7Dvmpe5V4lhagb9MCzs8W5gOY8Bhrcj82SNkW?=
 =?us-ascii?Q?zaTpG5lzgBSqeIWDcFphZxdOPw5zRdLfjbn7ohQfuloR2fXJMNUtKgd3aNrD?=
 =?us-ascii?Q?LBg3NNL95fbebPU10ZocqwUsIUiidjrzYd4o+lCLVXcBVfdBHsoBnIbFhenA?=
 =?us-ascii?Q?crSBEep3WO7UM5qBYyOLzvuAv4mvOSq/bKoA9OAo4+esCHB6cf9LTD4BTDUc?=
 =?us-ascii?Q?+gUlobGSCBAH+iwYVUK0jBVuu1k8HSMTz+t4lOJ9n0IyxC4jgEd5V9m8N2vN?=
 =?us-ascii?Q?wFCI/mVPNQptVlqXqud6D1hGURszC1XQC6AtpfV+2uxwCdWrkQ9GVVM60HD8?=
 =?us-ascii?Q?4ynOROd3Y+HeDY91P3iuUZR9+yOiUrEgti45TNFPBekJKEpIQMhqtP8Yktm6?=
 =?us-ascii?Q?mSy43D/c6ulo5UJ0n4jI4Z4kEQIW2VRuGjWeukt3Me93znK6sVDwzcu6qHOF?=
 =?us-ascii?Q?u6RTavY6OUmt5hEVmqrqyCT/EBXeAFrTtP9iL1zvWaMdK1aETiS9x9DCfWBW?=
 =?us-ascii?Q?stcIwmgNFPCxM7tUPIQ0alGxg0U4A32QhAIV9Evqp6o+aLmR6ZWXJqj5O6Kr?=
 =?us-ascii?Q?lHCw4tShrkzo83p+Qsu7SPmHp30UD6OXE5d2cX2G9Lv9kDAM0m1A6wThk/hQ?=
 =?us-ascii?Q?Ri+1m8ZG6skIL28i4MYhpDzAcNKGWndtuUMh3Y/LNlWJSTiNkYw3tJEyabrq?=
 =?us-ascii?Q?4fjaDKOgr29Md9K3zyRNALQ/OkHPkLI1OBruofEa0RUZ2LZ8nlWkZzl5NuWv?=
 =?us-ascii?Q?dKxA7usL8amobeRuzChksfs83e6XWiTTbFWzrRKdUUSe+9tK9zRQvppisJbc?=
 =?us-ascii?Q?I5K4gDbLaU+y/g9Bq8y0zPyI2LAVRhl8/F2kREHRMSINSvTqH5nU5aMX99t7?=
 =?us-ascii?Q?9k17u9mHe2ZIz6YRFptUfmmUc0JI4HroGFtaGIL2o5hc4hAMCH7rBD9QzaXN?=
 =?us-ascii?Q?1KYJWkrHQ834182zbGNHQDsAvH47kJ+u1pCMgIH3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e42adbd-45f7-4a1d-429a-08dc9d2cbd59
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 19:57:46.2672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44i+/lD/m9SNjx3i8Q6R9hL2O78ShnLtxLcP7w3S7mfC35U03e4yX/5UesaBQoey18DVuAoLYyt4GhT+rhWxDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6877

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
2.40.1


