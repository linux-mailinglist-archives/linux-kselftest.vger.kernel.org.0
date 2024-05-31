Return-Path: <linux-kselftest+bounces-11054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A088D69E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 21:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A568B26562
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 19:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7901822D9;
	Fri, 31 May 2024 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S4AEGwnz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188C817FAB7;
	Fri, 31 May 2024 19:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184336; cv=fail; b=ZSpXdiZTo4Xf/vW5pB8zCETP/hoIM9X9V4yhEuy+kQX1dy3/0arH+TV9kVmkl2E5ZcaWVXUkuYxcd6kCcQOyukEJJE33GZbSOyY97pqcSySULxZI8O1OjTd9bP+/sN1Ajvyzm9gKz6H7Ofr04/UvEBDM/FrfcJsWv0sW+3WT9MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184336; c=relaxed/simple;
	bh=YCkpda0WNd/UD5RJUAuMeiLh0vddzkZNaNoxBNXrz5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k59NkQ5rpMnFyCW+4iXw7JzAMjCxe2Lpd25d7SclE1MQ3Ed5aaYpwHZYocMx72B+QwLx6+ydNx4nbEOcuT4mzsOCsr4BjOpxEsjgkF5cUBj7UUXFccyDQBiVEGM952y7GEk1X8XYY3Alg0eYjkIFeM0lE+2kvjpjdu1UvGekhz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S4AEGwnz; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cla7VV0fwKHJiL4C6dJ0MjXtioM1qCXHiFW4pMFsOLJmi+Jfdlhi3XHP9tPwC+hIcOH3zDLmvkqlleAuz9ECd5Hte+r1ZJhlx8CyPo4HQYUnhAvJwIcBJaZs7cyTzC66iiQUKY+IFDpRphrSfAG//kEBpjCYGSdQp8KW6VaM14JLwwkED6/VGMNPNAhF2K9NLYpWXmxRcZ34umw38QJZCg8ljmcpkUI/fTsgfU2q6NEyndvMzJ6sqB4q7YeM/wDUtvFwK9F6Nhni97IUS4Nirt6LLD7RH+kLQACT81l74TA/ai2ie314oZWS2DMrgIwck4grdyckjsY8FC/1bhNaZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eKIWT+CwljhaTJQqtFCfM9Y+IA41PKiy1KCN6DW9zE=;
 b=loOcZ2mDi82y+RI/uZ0oXh3uFfsp+pAqYKAst1BCZlWcSWLwmS0u+9UtSsan6WtaOOJ2A+NzTQ+OOYm6xQrO2cy6gHR4ggrfgR1M9T6TePCfP5hyIItvitHLL6SEdTuIUw8Y2j6ceyPKYYSdHMs3+NlGeA0XwqAyBEAqMu8WilOH+4i4qcPaAw95t88JXLid1S4A41E3pE33zUrqjZEqgHaCtkh7xtjZ1+UJ7E2Jaj4ttXJnTdOJY1MwiRhUoaXwzZwTRgqcqQbsPazO5LWHb6HmyoLU7Qr83tZ0tN6gesxugc8Gs5aMpu7rJYi8kPLFjg/Qjl1Qq1oM1ro+WYB+zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eKIWT+CwljhaTJQqtFCfM9Y+IA41PKiy1KCN6DW9zE=;
 b=S4AEGwnzvAoqzVfRGqCjoQilRsuyVPt7CvymW4ZVPf1vkb/Llqm3pdgcM2cRIvFQIqa+8R7IUUQHgjCy/rnho2StvGWTKAandlhSLXPf+5JpJ/GClSCUJyo8tA9Inl+MCWDe7O284XzrZwx4V/0vc0wXsgB9UhsG4v/z5yE2BgczA+h6INt+NroHz80K1pBCsFDVJwEx1KRy951uQzKtDKJvO5BoefzqreSk61o+FyHK8s0/O1KSpsohPsxVmYK3Q6A/i1SmGAYP1pYUOmRbaieGi38WOAem6MrckqhUuyaGI+I/dQxD3XE0M4fZtcrXlrqOtq/+jXe15kSzW+r7FQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Fri, 31 May
 2024 19:38:43 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 19:38:43 +0000
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
Subject: [PATCH v3 5/7] selftests/x86: avoid -no-pie warnings from clang during compilation
Date: Fri, 31 May 2024 12:38:36 -0700
Message-ID: <20240531193838.108454-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531193838.108454-1-jhubbard@nvidia.com>
References: <20240531193838.108454-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:332::8) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: eec6e666-5417-41a4-b468-08dc81a947c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FLsD/oQkrgzcFB7JQxiGO4e6HZlyVQQIya4AgbkygiRb2uUVjDaoANxhro8f?=
 =?us-ascii?Q?CRMG5ySeZaDdic3rbt9vlVqhakyAfLKZ4ZBfqLzWgel3wGP+/NSwptKnm430?=
 =?us-ascii?Q?94dHGt3Bsv334ofBPUVkpt1p29WJ4qB0o3CawedSSYL8cJC9RmcfklK99mfO?=
 =?us-ascii?Q?T2M52rrkcrRJpvsYussY7NJIdrNNpiJxyo7Kq0TVQ60PwnqUvWTClMpnVogy?=
 =?us-ascii?Q?ZbPT6B5LoEHktqeSlmLFooFy1/bpySGLjDlUqN6Jt53jouThKIS3IAcvevAx?=
 =?us-ascii?Q?oztutruTpqJ7tD8XTBktwwTi88WZzZN4QbO7Xbocn9cULA94i+RbzVPbzWa7?=
 =?us-ascii?Q?0brcS0Jj+qeco5thBi8KRoBkRlKvOALrKza+WkcrdXOgY6VWVXU7nFx7Fj5r?=
 =?us-ascii?Q?6S7ksDUE8CJzIcOCGKKAJbVT71IGqpMzeEI4c/+ET6z/PIKMvDMa1QmZG32L?=
 =?us-ascii?Q?R6OjNkRJJZtnZEPEWSRVUcEAHsT9ImoidB8Kax4ePznZ6dsKYAUwuxbfiIcL?=
 =?us-ascii?Q?MC16NOVDZMxZ8g1hwe3j+6cN4wlqbJTba9jHZNvYcEVChseFHIwWX9ivMbE7?=
 =?us-ascii?Q?h/kawY0hZmphFfxoC49jly4LfPp2S3yppH58imU06rBVeDrYKKxpIfMTFfzm?=
 =?us-ascii?Q?NcY2b3+eV99UxFCVcuEoeDjnEMT+KeIQvzaDn+xJt0hxlR0AGsEUafyjhO3i?=
 =?us-ascii?Q?xtzzF4XD28yK4LoXD7+nkRJg39shAptgLMcHb0BXZuA2NHfm+QEu0Oq6zcqy?=
 =?us-ascii?Q?Kor7o2y9EZOFja+f6cKnRM7SJ95JcNXSJXHvDAjMIQxZeN4ItvAHb8PdoOhO?=
 =?us-ascii?Q?KzfpbfpKA35Ddh5hMK80Snd8W7Oock1yOMRWBCYCDXXMlVOtVvq1WgG+WkuG?=
 =?us-ascii?Q?6ta6EcoDjBW3OUzrZp3P9oV2opZjWBapk07/d9LzwnKTOm885zx87yyrEkbe?=
 =?us-ascii?Q?6YOTJI3AGfejionFfDNpVs00PkJ235eaoFZTQCET/qQ1zr6/6gIzGew52XTV?=
 =?us-ascii?Q?bnWYmwhGwbhYtaoOgUTQLFNILYuql5d3KPL5X9tc7KH6Fpf/DWALcXDr0Yaz?=
 =?us-ascii?Q?7tPC6QjK69WnWg7/mwcr4nSHcEC6Tv8fRl0iT432PS/IBFkeFqBloq5VDO4t?=
 =?us-ascii?Q?3Dn1JyEbPya3LAEaSrHAyLF1FKdOkWYqdUKAqB/4PMSN61vg5sNLp9C/lhHM?=
 =?us-ascii?Q?B41I49lLCoS33T1gxYNjnBnhkg1LA6UBBXdNPWbaJ1DRg3Xt+TQv+Lv+37ID?=
 =?us-ascii?Q?0QBno1xa1AzjGiFsxhtz3DqHjN1X+hv39+YX5xRI2Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mc2rtMkJgW5TeWVAsItNHD2D81RUqU/L9N3k9l4Glh2AEoXWOsGe/eOzvMZi?=
 =?us-ascii?Q?hzjTq7opPdJfgkb6OKpkF6DZrGyMXgnrWSmjMtFDarVItna4bbDLc7Arhhky?=
 =?us-ascii?Q?gmIOvNJRuH7/4g81ahj03AeYSzI5IN+G+YqDdRlStHVfQRuCZTRMssaBLppI?=
 =?us-ascii?Q?gApUwF4oLRFmnwJOafvkA+EmNTCAG8JC2omFG1BBJdpzXQEqUYvwDZC6Wl49?=
 =?us-ascii?Q?nGUyRAkqnOJ1I7waUDbot0dU2h8YU+K7LKCpmyEwDCsC3R2SgSI16Yu5xAMq?=
 =?us-ascii?Q?SUDC9bgVoN3nyaiQ5afTSy4CMaV63Z7cq2wBTn9ZMZw3vzBdk0IL31txIOzt?=
 =?us-ascii?Q?VtXfkaNjFCLuryQpbj3m6+7u3MsiIPlUjtwaYMgo99fqoNRmhMhI4tOCqgBR?=
 =?us-ascii?Q?EfdDU+8W9B0M35MH4g3VIGV6sVH+feql9bi6NRBy6N23yrSfoxnNhOe5xDRe?=
 =?us-ascii?Q?/MGsKjvlo0Dn23nZSMD2e9dixXg8dvL9Paa9Mx06bu1oF3Skmv9ZvD3p6uWR?=
 =?us-ascii?Q?TFtd72EEpTiRhOHtFj9FHWzy7wn9TuJOqGjhnX8jPtqAPFFxxzc6PAoWCQ7G?=
 =?us-ascii?Q?xJWoYhY5bwlkwAtEvHnqr9kWDDbF3jsgsvKmsMEIFl4FkUK3iI/IyMJnsZYH?=
 =?us-ascii?Q?yXhrHgLiwb+ccKWsJFCIe6Mss0+1sje12094u+OTcJadcdsCuf5+AW/dz3Zq?=
 =?us-ascii?Q?jEU4qTKzR5xBqfa2YsU1ywWXbJkVGmM/d35k8/MBXwTLlOXkLbBaNvRPtABp?=
 =?us-ascii?Q?nP7xwL28f363BCpRn9GWPw6eiKgfBNUIY0TN7bKkZWZuJ7bjZFUrtu1q8h7z?=
 =?us-ascii?Q?zvOB59ZgiD+WuDsy9PcHrUtyhCI7eikN0k2dOkYCO3wQtBsVgVAHyRy74rod?=
 =?us-ascii?Q?MX1q5T3x6+kW4ioTZnC2JpB8OwEoMnTvFRGWeN9we86bLJAYmGGNAuDkbdXd?=
 =?us-ascii?Q?ffIlI64Je3goyawFNuanBgKvT3U2OPOJXM6kg26iMlHTXkNexAdOgFeNEHNk?=
 =?us-ascii?Q?7iFXnhsnJjNsyb+ne6nC1Ygnnzkf7utrfpQdOLz+aiipw55uhOtTY1F2yCe+?=
 =?us-ascii?Q?nXMhpI5vIqn16giySy5rou7De51GXfVwMHLzGXsWASOuglIK4Ld3EApK7/B1?=
 =?us-ascii?Q?Ii2dmR3KSEFx/12xmN0O6yRkn9Z5G/pnSL3vqQDbblBBAzGTB9OToDLccxBd?=
 =?us-ascii?Q?lcRSAemfp+6epdkXHGXLIFrKxpgGYFqWG+1/9n6elYX1GxocfBJQ4/dd5et0?=
 =?us-ascii?Q?4CRww0VrE1dDnt2BTJZNmt3BGOAsWKtK2QAhgIsyNSpsZU73gkOSTS7Gxndm?=
 =?us-ascii?Q?hrtrv4V6ZtzKBJIG4h0BJjLPaRKGA8XH2yhl99NxPAwor7jmlVg0BdRQUbG4?=
 =?us-ascii?Q?VgIskRqMEeJ2jU7WhN0MlcsZDhyPrmAAannhvnc1yxuzX4vbhFs8ZBo4m4vA?=
 =?us-ascii?Q?gLSEiN8MNra/llo+4JRtr6jUDo/UV1J17P3/++9TuA4G/Uph52KlniTd1991?=
 =?us-ascii?Q?LAXgX/eurLn6d0/N3FCRALm6gawN5iMkwFB50X61jf71SpqooNAJy7S+q/SK?=
 =?us-ascii?Q?axezWfnNaRIbfQ10dfmI0oX7AUnJ+oqMsRrBgRUF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec6e666-5417-41a4-b468-08dc81a947c1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 19:38:43.4227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5AteHk1wSi+uLUfoPFhsBH4TcKZG5teGnd6ho7hB/I0lgHNU2UNptjz/jd9ZH+A5izPaKhg6y97zueIMRHOQAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712

When building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...clang warns that -no-pie is "unused during compilation".

This occurs because clang only wants to see -no-pie during linking.
Here, we don't have a separate linking stage, so a compiler warning is
unavoidable without (wastefully) restructuring the Makefile.

Avoid the warning by simply disabling that warning, for clang builds.

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
2.45.1


