Return-Path: <linux-kselftest+bounces-10747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FEE8D0EED
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 23:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B291B221A4
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 21:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C9E161305;
	Mon, 27 May 2024 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pGNnjoQF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDB8167D92;
	Mon, 27 May 2024 21:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716843680; cv=fail; b=q0t8sHKbLXxfxWcCHpnuCrn4no/a3cYKQmGSwDysjAKqnaXq4jKEdbov29np13F35Pc3fXgdbdYMSty23618ZULSw2m0RFwkM3nbtCM1o1OIHp/TmnFY32Grg2Mi7hhCsQZQa0zG7PwCeRuRF55kCP+QHUYFfbBdvDsEC+kHHqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716843680; c=relaxed/simple;
	bh=c6b8+bXannTU8QjH8p4Nb9a42/H/kQXRHJejx2iWK10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sQnRgC2n3Ka6qGrd989iJwD4SZm6nIineYJUy7OovFLx7JxECU6SyfHn0p38udwEJxnl53Az4o3uXMkHf6WzwN5TyccBjkZLCGA3o6l5F9y0p6+YxSrnx8gmJbQrbNklWpcIMBbsEd/Z/BONkfZMOwIICZDd1iSzItoYDfWfXd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pGNnjoQF; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnMn3h2v6X6bfAweRXWR4/HxaMh7EVR5lzhJbO8qnZQJPE3AikHNTzwgSsdRjmDxqSYL2VVLH/oSmNutU8upNMZ7jrMkdbK8n3HiI0rBq0g+vc/KvTr9sF74ogpZpFWfiUb8NIZ2L2N7nn2YuuLYSc3VObTGUxEah92CE1o8XRlXU7VXCeyEPmTmHhNdjy3RP2LUwLNYbgdUji/kvThBJW4CZ8o2XRvyfMuhZFnmLW/Rk3FPdu7bUEZ6mAkiDXrDOQthSVSlBMxIfoIf3w9679S2lS8EYRmi36rVU1pCo9P4P5i0YIrnVQZYUcCkH1F7sVemQGszr04fjBXxU2jKfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9AzN/Pj+pcez2zGR6CXChIoS6ZCr8a5Q6nbSa88LBc=;
 b=bgNJwLWw0pGlWxfk9C0HMAx5/XatIZbU7Ovl3ivTD5zEfgMnHrhbbDL0taWoCBPyn8AHgR9m0iQWMtYMx6j05xuuARUwpm5ruuzN21QDEfRPBWOOdJAKsg3AC3PReQsSydG0qvqMwKM+rIuLNMDh9BSrreM/94QC46KgHWbkxtZimynvLjd4NGB0vG9xCto6mNm5MQu21MkaGCDGx6htbu5tpfdO/e2BLTSS/CasAKZ7OJhuaA/SNdi2ZimW2a6ZVbLE2e6kkJCp1gSl+SAklcoBKszSlhh2/vq1TvASkBFSe9jLAYh3tD6EXpJcLZS33+ttD/dgAZ/xCm8oYyvrTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9AzN/Pj+pcez2zGR6CXChIoS6ZCr8a5Q6nbSa88LBc=;
 b=pGNnjoQFpkWkNhIzPQqc3Cm5R9VNFWv54ruTEeAGndVGiAUwPKkFX/N/Lqqdu2U+SKsAcMPm3KdZwzx06gu7deNCQbHYpG3aO7+fC8NseFk7EpQgIXwosmBhBP/IW8w9DPsyo/0h0SOBydCMJ+R6cXdhtWIlXtiGiEC6jUdx/zyQ3kVXQpsfg9yFUxu0l84ke+xF7nk3/TqZsi3o2hFsXwmOhuL9PDjfRwhFx3hQKXo+4HKG+UC6D7JJcc7y7ac1SXKu8r+jekLvAaBSkDVyXAuO+im6H1odQnRykMgnUGuO6sxhO8yljL5IM3i5CkZiZ9ECSXGZd58DUQtAlkSQMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BL3PR12MB6620.namprd12.prod.outlook.com (2603:10b6:208:38f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 21:01:09 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7611.030; Mon, 27 May 2024
 21:01:09 +0000
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
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	x86@kernel.org,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 5/6] selftests/x86: remove (or use) unused variables and functions
Date: Mon, 27 May 2024 14:00:41 -0700
Message-ID: <20240527210042.220315-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527210042.220315-1-jhubbard@nvidia.com>
References: <20240527210042.220315-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0097.namprd05.prod.outlook.com
 (2603:10b6:a03:334::12) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|BL3PR12MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: f90d0499-bb9c-4c1c-ce19-08dc7e9021f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZN80u9rkoAkd2aV5nSZ3cSWjdaJeu1muDAz/EpgoFmsD8vzeF02gRhDWAWYM?=
 =?us-ascii?Q?hMeevoFGKGa9BfkJYQdpq5iCkxXaPQM1ERW2gKNXLPS9/593F+XCardVA5OD?=
 =?us-ascii?Q?/Vy4W50qtcqnzb57W4Toz/3G/eB/hG4UfZQZTGXiSVbcTbvdDCLRZeJZcOUP?=
 =?us-ascii?Q?vsVBxZ+Co06aEqeAZ9ptzKC1w7yqnD5OHoE1eJGvRI6t52SW1kczPOMlzLdd?=
 =?us-ascii?Q?P0UQARU4BX23pLPfv0nDy5y/Lm99banLGQPZ3SbgSvx3WraIzFSmoBvPKSAo?=
 =?us-ascii?Q?ZgZFwwmodFGuMYd/x07k9cN4vug/jCYw0RipyfVb8q4cxjOokKpVFSOWh0C4?=
 =?us-ascii?Q?9Sf6gLOGMlJGzfuIFZAaT322KuSWX8iHKB7KXrJfAyiStU3gmET4zftYhsYQ?=
 =?us-ascii?Q?9tZdlvqmkmuJS/i3924eB3lm9VKgzojjo/5wIOBZVxjc6DeByZh3aEFEyL3M?=
 =?us-ascii?Q?W4/xqAGjXc78FNl8kCGVqohcnDr03HjhGWXDInBBcKy81iL5+HiaURCuJK+y?=
 =?us-ascii?Q?0VTg4Hi4P+Xzj3+WJt1xswOeSyJCYvFtQ3WTwHleOAI6KuDxYYTefEcymy4g?=
 =?us-ascii?Q?0Kowp9NM/JykaSKtlO9SfgYmTswHdEIkTdprweIE50nEltXIJJke8Nbt4hS7?=
 =?us-ascii?Q?f/uQM2WlQAP4OrBKB1p5rvg2IA0sxckIqoRslHkXRZrXrB/jlE+vuVkVBQyo?=
 =?us-ascii?Q?6dnjyNawRSzJYjb/W26SAFHw7HewcjyE+i+DAOMZZav69yU7X+tPluJ032Jb?=
 =?us-ascii?Q?7BiXziYi/GFOP7iPBrydZo8F7bZvB5N2V9umU7RpUCrmfVkdKGJLx5V+04jG?=
 =?us-ascii?Q?uMfiCfjWtnGiJZKs6arLHLsLyHhiDoEqTsDh2LEby/nBS2vCDOO2JF89PR95?=
 =?us-ascii?Q?T3VF9G+MvKNCg2AFYbRj2mvbrp783LN9OsgjediRarencquyJINbMbdCaUQj?=
 =?us-ascii?Q?T2aQQrgyf6sOd9rJG9TbFV7s/4Uy5G7STScXt+OVBNQKx/A0DJrB6Zu+Rktj?=
 =?us-ascii?Q?O6/EPFrnnf0txcsjl2eZ4r+IkAqrYVCTiaNDMjOKYi8gfZVrvwLdBGUqFm6Z?=
 =?us-ascii?Q?y+oM6K/yCSlpCjU+mHWsV4ut/W+Qx3LZoND8gOBJs5nIqPnRE+ZwSuTA0b4h?=
 =?us-ascii?Q?J9258mSm8LNTU289y+JVMWNGRj5cJRhwYgDeL63Yn3o1o1nfwXWsNt+RtXK/?=
 =?us-ascii?Q?2ykfumIwx5z4kze1eSMOhZ3WeuUt5RMNW64ctLm71fyBqVtFnQBICcRFwMcX?=
 =?us-ascii?Q?I+q6pxG3v8Z7I2xKKw1MSAyGBpke9A7CwQYkdpzZDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+PImgknLw1d6ek5R+z8djY+rgtw8fPmMdBs1IzCbHdJNfjwexY3/hymvFbLd?=
 =?us-ascii?Q?7tDET3ruQtnocC5JWourFJGeES+yRYGiyiUHHRe1jnFA18WnnK+40R2i1wb9?=
 =?us-ascii?Q?P3mPup4E68RZOv2XjRikpG35M4/OU37cKTfKMN79Y8leu+fWUWsj4dD4AUgD?=
 =?us-ascii?Q?AjBdLAbST8SNnzdIZ5NrFiw9UXwbsbRFkTMMJ+S/obPFPMoQ8qYNzkN79Not?=
 =?us-ascii?Q?breIn8J+xURy59stQM+l4RtXCP6+ttArplXbs/5G52fNTeoa0f/cQhDsfAa/?=
 =?us-ascii?Q?vpE3aYTNG8MqtZrxpq0Q4eHBF+vSkLThuRFuBfG7nxXl2v2J8Nt5TE+xQ7FF?=
 =?us-ascii?Q?6H56d0U5EUGaTyTg4fjVTGtleSoxHa0pC25rX7T9bL3irKA52CboBZSl2JUy?=
 =?us-ascii?Q?Gwo3ekE3Vfa2A4Kyuz+d3iwInyppj865Y36INHLvY5KoOqAZ1LaNufyi9xQW?=
 =?us-ascii?Q?XagTm8SEtZ1T+x7/72p6jMh880kTH/maQ6nZSjipRVsJYemhPIUQNyvczxTq?=
 =?us-ascii?Q?vBwrBo4A2Ag0kFGcBFQsOSdTq+5rWOoGL/UreWDyaw5KGyA3IyqjuCfd1xta?=
 =?us-ascii?Q?1+WJhJcAv5Uw5sHnPyW8TV0aCwNDQRtUL5BFRMAeWQo3xPOBkP98I/1drzQZ?=
 =?us-ascii?Q?AQZMfC2imx7of2e4m5U9vj/LCnOhiK5GVn6wXjd53Nmh08WfsQ0a2x8eNiJx?=
 =?us-ascii?Q?rQmRumxL7CNu/ONXywBrfffe9urUtzmhOVwNPNSNJbcyIWCj3lWnvCGORmU5?=
 =?us-ascii?Q?BOl5yZpM+Yi+/dQgM/3MdEu7bVxd7wqgCbMbukkVelgvuwU5ZXObX0la5t3M?=
 =?us-ascii?Q?W5O/rh5tLOLddWG3RibpgWa+dFwGrXxMK9Nm/1RIX/5lg5V6vEjaoxs8y4E1?=
 =?us-ascii?Q?uVI1pN/NcDGuBhNdLXieBhWltMjbZa4SNqgk2/ZEEFuFui7djh38ceDiQaXi?=
 =?us-ascii?Q?oPsL2kDYqAl6czYtnoCIwzky0dhq956tZU4r821eMoWprksxbmSUTWN5vqIm?=
 =?us-ascii?Q?Z4+vgWSrjCsTngTfHPPf+LVEyEKoKLyZGuzXt9NwEcHgPNsZbW8XwNUYKWXA?=
 =?us-ascii?Q?Uk6r4p9tjlp6o2Gtili5wubjsbdFGSpmjnWnwin22kjIAWJi4vUeka9ttP0T?=
 =?us-ascii?Q?kzFRBHO5DYf+UrE+eQ4zs/mOPbvj8wN+OvWpHKTUIYCqKjWbtK1CoUG8StIJ?=
 =?us-ascii?Q?T1dBQT5tyMkpjSLcWxp8l8vWnTHfR+WtN6wpqlqNPgo9cO7/ZMKtbt9I/7QV?=
 =?us-ascii?Q?EUelFLEnH+52EKokALJqsfcyDmoBILx5GkRu93tfZZsm9dZIuKNdq3NekpsW?=
 =?us-ascii?Q?XmbgVggiOoa/vQ0GaSKuaA3Kz9/DM15x4WewcE/u/q/ZXcA7UCB+XaAKWVNE?=
 =?us-ascii?Q?KM2RyIqsF739tA7nmewSA/WYEYxSq5+hGNM+YXVzAZZEfYYV8fP79S7dOOGH?=
 =?us-ascii?Q?1CPA3p6rzGrvcvGGGwKgnElfldBKkP7e2upRei9KVtj3kdzQ2cvY9vNaOl9s?=
 =?us-ascii?Q?mJAFbBZpPwW9MaPA7JCyZvf3udTTBLemBkxk6DUk/u9BdrtcoykyQTzdYEDw?=
 =?us-ascii?Q?P6Vu8Ci4oyPdJ4lmi55kObAGbtCRm55ZE0eQExt3sZiTYyjCY61PB69M2xhH?=
 =?us-ascii?Q?dw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f90d0499-bb9c-4c1c-ce19-08dc7e9021f8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 21:01:09.1122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvXZvQD46vWzUq2o72XG+1V9z1XKZQQJvbRUOI2E90cfBR/9d4FcKIuQJNBub8pYITL46qVQo0srRlv6oyedlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6620

First of all, in order to build with clang at all, one must first apply
Valentin Obst's build fix for LLVM [1]. Once that is done, then when
building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...quite a few functions are variables are generating "unused" warnings.
Fix the warnings by deleting the unused items.

One item, the "nerrs" variable in vsdo_restorer.c's main(), is unused
but probably wants to be returned from main(), as a non-zero result.
That result is also unused right now, so another option would be to
delete it entirely, but this way, main() also gets fixed. It was missing
a return value.

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/x86/amx.c               | 16 ----------------
 tools/testing/selftests/x86/fsgsbase.c          |  6 ------
 tools/testing/selftests/x86/syscall_arg_fault.c |  1 -
 tools/testing/selftests/x86/test_vsyscall.c     |  5 -----
 tools/testing/selftests/x86/vdso_restorer.c     |  2 ++
 5 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 95aad6d8849b..1fdf35a4d7f6 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -39,16 +39,6 @@ struct xsave_buffer {
 	};
 };
 
-static inline uint64_t xgetbv(uint32_t index)
-{
-	uint32_t eax, edx;
-
-	asm volatile("xgetbv;"
-		     : "=a" (eax), "=d" (edx)
-		     : "c" (index));
-	return eax + ((uint64_t)edx << 32);
-}
-
 static inline void xsave(struct xsave_buffer *xbuf, uint64_t rfbm)
 {
 	uint32_t rfbm_lo = rfbm;
@@ -164,12 +154,6 @@ static inline void clear_xstate_header(struct xsave_buffer *buffer)
 	memset(&buffer->header, 0, sizeof(buffer->header));
 }
 
-static inline uint64_t get_xstatebv(struct xsave_buffer *buffer)
-{
-	/* XSTATE_BV is at the beginning of the header: */
-	return *(uint64_t *)&buffer->header;
-}
-
 static inline void set_xstatebv(struct xsave_buffer *buffer, uint64_t bv)
 {
 	/* XSTATE_BV is at the beginning of the header: */
diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index 8c780cce941d..50cf32de6313 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -109,11 +109,6 @@ static inline void wrgsbase(unsigned long gsbase)
 	asm volatile("wrgsbase %0" :: "r" (gsbase) : "memory");
 }
 
-static inline void wrfsbase(unsigned long fsbase)
-{
-	asm volatile("wrfsbase %0" :: "r" (fsbase) : "memory");
-}
-
 enum which_base { FS, GS };
 
 static unsigned long read_base(enum which_base which)
@@ -212,7 +207,6 @@ static void mov_0_gs(unsigned long initial_base, bool schedule)
 }
 
 static volatile unsigned long remote_base;
-static volatile bool remote_hard_zero;
 static volatile unsigned int ftx;
 
 /*
diff --git a/tools/testing/selftests/x86/syscall_arg_fault.c b/tools/testing/selftests/x86/syscall_arg_fault.c
index 461fa41a4d02..48ab065a76f9 100644
--- a/tools/testing/selftests/x86/syscall_arg_fault.c
+++ b/tools/testing/selftests/x86/syscall_arg_fault.c
@@ -29,7 +29,6 @@ static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		err(1, "sigaction");
 }
 
-static volatile sig_atomic_t sig_traps;
 static sigjmp_buf jmpbuf;
 
 static volatile sig_atomic_t n_errs;
diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index d4c8e8d79d38..1c9895cfc660 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -97,11 +97,6 @@ static inline long sys_gtod(struct timeval *tv, struct timezone *tz)
 	return syscall(SYS_gettimeofday, tv, tz);
 }
 
-static inline int sys_clock_gettime(clockid_t id, struct timespec *ts)
-{
-	return syscall(SYS_clock_gettime, id, ts);
-}
-
 static inline long sys_time(time_t *t)
 {
 	return syscall(SYS_time, t);
diff --git a/tools/testing/selftests/x86/vdso_restorer.c b/tools/testing/selftests/x86/vdso_restorer.c
index fe99f2434155..ac8d8e1e9805 100644
--- a/tools/testing/selftests/x86/vdso_restorer.c
+++ b/tools/testing/selftests/x86/vdso_restorer.c
@@ -92,4 +92,6 @@ int main()
 		printf("[FAIL]\t!SA_SIGINFO handler was not called\n");
 		nerrs++;
 	}
+
+	return nerrs;
 }
-- 
2.45.1


