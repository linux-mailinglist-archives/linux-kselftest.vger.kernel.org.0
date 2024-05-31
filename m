Return-Path: <linux-kselftest+bounces-11055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9CB8D69E5
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 21:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12101C252E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 19:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF4A1822E8;
	Fri, 31 May 2024 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YItq/87l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B243017CA09;
	Fri, 31 May 2024 19:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184336; cv=fail; b=a34RFKGnJAM0VsDawFqOojx9wpq2hFPMqdXQeSUOZmnVixi8BWQnzRhDJXTfi/dyXn8YApbRKcVWrFOhrcESwOIuJJul8DExf51aEUw7vhKUoOsMT8D7ViGa+wbN8/xatc2FOtRP1/JOnNuMZQ1m9qIt7dY3imkT5M8gE9Kc44Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184336; c=relaxed/simple;
	bh=lkHfXOkuMLyiPllYiOpX/2ad0kFdXhkI3Oj2E82h+kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QGE7uA6bMmSDnvoRH2GsCIcMP5MBW9pznfOUpwHJAs+wf7l7kPcT1OFanzuRlPF6P4H9Io4fPRlheuvh0oetrkfCRDnKw9l8xDXgZ6fjE3yGz8k4Kd9tbLs77vI2P/9RUx8BvL2S3JWVrOpBowbhhMkdPNQg7h/DmSN/6l9oW3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YItq/87l; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=budO4adXbMb3am40Q/q4exmtmHA30iE6At/M38f5QvunGiPkFy6zdfGMDi7YuoMcXel06iJM8kfbogoXd4QZz/8O6FlXpCyBf94hW0l3vdAkoailK6zssOwzoi/8a7yRGFlgcnJ5K1rNw9l9VY7gUXNcCJIyubKGRqCkTLEm8b2oZrWArWF3B+Bra1fUuS+lp3r0qL2ym/nRdqsD4PacNXlEIqc0QvxPmhot6oflplK3XuixbQaeM0gaknv4q6BmDJoXI0iPqDG3CNYP++EGCJKJ7Dw8uNr4waxRRFxGxc5URO3JmVHTLvvLoFfRahCrAtePf1n9Z6zexQPtk9oGLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lm9A87k1N76AjiGjL01RxZ+v8mTLpTcbZTy2c/TQ+PQ=;
 b=czISQ/kqWpLAUG8z7h5xF+/E7RG9VYrku1v+KA/g6D0blS64U/FZrj6eH4Eyj9z6kLosS6pYz9Y/7wBaG/3jdSq3litH1Sk2DOoe5rixcxAHF/S2k9iHnvoVo72VehU+jgwrdX7Cv1j4KIy7l+zHDN0mtR3ZfpgbYszn9jh264b0YK+pMU4t8yewD7kONf94CFA+n79SjPgysAVqb8rGEF1Uv6j/NmyhlJmJXUgDBq5CG9stNlOeZTCfuloWQted7d6mwHuv/9yidzV0c19fEj5OlflaSpyTZ0BOPkvjwaxXLHKaP+FMvKitJZbfa4zuZf7x1NKeSUdmex1IEzekKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lm9A87k1N76AjiGjL01RxZ+v8mTLpTcbZTy2c/TQ+PQ=;
 b=YItq/87ljbgtW2hMZ0niYKVKB5VnFuUqs53rDoxfEHbubWhyckmcjFwiEvkAfTEgf2xzDAdBN75MGN9GdWl6C1iair7LDt8B9KXdAfFZb3gxuck3xwDxQTiS6h+yjpW4sScjKrycJ6HJL6TfdwuD1VPKi0gp0F5gdVDvC6Cw+aIdn9MF8Kl7taqJUZwZfrBJ7v8jnJVPr2CpgVtFVDZaVYVa3nZas56yJ0jVguimyLQJb+N+jetE6ON3Dli9JJnEOvOZ/hNmXeIHvaSFQ62Kjf9FdOogyRAjEEdTnNpPZVgn03DRWsOdoyEg23tGYqggbhJs30iSMH7I1SUWFc+KOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 19:38:45 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 19:38:45 +0000
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
Subject: [PATCH v3 6/7] selftests/x86: remove (or use) unused variables and functions
Date: Fri, 31 May 2024 12:38:37 -0700
Message-ID: <20240531193838.108454-7-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531193838.108454-1-jhubbard@nvidia.com>
References: <20240531193838.108454-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::12) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: b4dadd16-7edd-4ddb-4c71-08dc81a9483d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UATSKJQ/05VgCWvjYa9X0qLABLSxmvBJ/a15BRlYXgeYo7EiWDwsWXiCIQ0r?=
 =?us-ascii?Q?nyBKnQqgDXrNWwRGHwqTw0NeiI7CdYywYIwNRHw3txwRFb2Ysg6Wh430P1iV?=
 =?us-ascii?Q?VDv4qXfkVPJz1S2P3/BPKYsx5N81t7jn0SsLVkrev5tcZcRo9KxrlHUntxLz?=
 =?us-ascii?Q?DLey/mEz3hPcSwuXBPWG+PDpnCtWLtsEO9w3f/c7FepfxKNANIb/iphMOWCb?=
 =?us-ascii?Q?V15z9PGXxqF2OZwYJy74hTgFeOY/BUvx85pOS0bjVFG9Hp0WcNYdZD6M7EjD?=
 =?us-ascii?Q?dQdKBZ+X95MRtoFiUzmDa1ut/uYCsaYr4yJpRbiiuGRHYO7zsNUi8mkguebx?=
 =?us-ascii?Q?ph+mubFtwN0V+XJsho773cWU5wXrInid2Kkk0nX2zqUdrbDgYnjpk8MytCTL?=
 =?us-ascii?Q?NxfM44hiCZSNizS/Rze3vMbXWUHF5ecnwaQebJaznngTWHpc/Ji+CTeS6Kwe?=
 =?us-ascii?Q?b7Efqm1WzAAQitK+o3w9gpF6JCRf46tBViKwdhEA9D7JVpKIFxcU9gaotesa?=
 =?us-ascii?Q?JxYL7YMvxpStMLjZt0TZFJCe1YMQXW05sb7qm5DfFwT2DnXnW45vbqWwqBAo?=
 =?us-ascii?Q?KUxgQePCv+4riFyqZ/cA1cKJfPRnrS+oxwJPEnpAvUJDMOfMY2WZSFyocH4g?=
 =?us-ascii?Q?Y4+4PnfW6tMVVE5W3PVGGzHwZDY91QUGRfBPTTR5cd4ikHE/dqsZMfVYlVUt?=
 =?us-ascii?Q?TE5QP3c5JZNPMF8Ws/cuXXO6iV0v0ui8HYSiJaBGYCpe39VuEAn5hNj8Kl9l?=
 =?us-ascii?Q?h0RnE9//WBEi15lP9ww5rYSNu16IfgadnxUbLbyTapJtLH1HN9fU0QXUs9kL?=
 =?us-ascii?Q?F93RsK7f0bIPv7gdWcczImrD0g3D86+i+Nvb1YMkJ40KpIqeeYUoTOSCyhIk?=
 =?us-ascii?Q?6OTxp5C/2npY6MiPz+qsn48Ag3ml1NitP8/MVMJZ2suf/Cz7AuOQuEhKk0V8?=
 =?us-ascii?Q?TwByS/97NJE/LvsMw1ni1uaYlyP8y5FWrJ7JWZj7UfpvD7PU+BQzYiDLHju+?=
 =?us-ascii?Q?lvvXflruW7pzVI9besaO7/OuwGAwl4Q3QmmKPDSt+4PlKbv4zO0y9AiHpZ/1?=
 =?us-ascii?Q?tr/i5SmgZAAMAWGgwNzxZKBvEADLVwkN2PIKj1gPqxOCJkkxQsVfp7OVtF6s?=
 =?us-ascii?Q?jj6Woja4QoKxqc940tJFBIPEZvtRwxHOTfubYMqPloWEcsUC7TKKh1FGJixh?=
 =?us-ascii?Q?8LA2W3SQUCewyDgAcJy2JT5bkhvjBUiGcxi27BPDaQ+iYj6w3G3Z4otSwu6U?=
 =?us-ascii?Q?eZPjJHe562aL+UQIA6qHzG/H1gJNEvdbbbRUPkoU4Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sX+CmANIn6QrDXWwE5IJ5m8xwQ4Zyy0ss+GI/q9qwCKJZf8Ux+hdP6CqwjzM?=
 =?us-ascii?Q?/kdyDQk8Kn5flE2FcFKaTFZkGA8wFDdNaJwja9tO9+c7myLxnd7QI8jSF0pW?=
 =?us-ascii?Q?WGtyX2s7+1Z7pIkXAP+NJ4LYxhocWD5RoMY8itNNybGuQYGiMNQfOwMkl8Wb?=
 =?us-ascii?Q?FH8vv8eYL3Zr4nfEZbEItKKtAhf6SDC4cddAFj0UCR4UssE/JtlJJKSnFU9z?=
 =?us-ascii?Q?+is7+GoBLXefLyvN9Vdogor/2g/Ug0nFNuK1B6RoI1CXq6hKnaJuraT+CLbq?=
 =?us-ascii?Q?A5mFZEWplffeZghZW4wKqBxYq9Jr3GyaehekjjC6voCsg3twfB4AxpYzjTEV?=
 =?us-ascii?Q?r6t7yJz0ps0tNuMAStNxPNT7DZ9F+0LJhrDL5M9iKnhcEwyE9FF7+VIqb72e?=
 =?us-ascii?Q?ScyouxNjozfSx5CS8rdvfv47q6R/4g8FmgNhwfSFHYdsvvayw/uYCB/Byfaa?=
 =?us-ascii?Q?V6FDpQKedHbq9rFh99UIxfVhD6bQ5L/VkaJda4nxjR3aqlZGbtX0pLQTMS7v?=
 =?us-ascii?Q?23nOglkG556RkZDNBtAlYN1ZU0grASsgjc10CUljHetKet1LVRmBgFuVqjC1?=
 =?us-ascii?Q?0k56HxCT4Yc7eyywma5hg0Xqhp8SMAfodQVnfIBzLrBPrp7BYulVH75bgqtO?=
 =?us-ascii?Q?pe1v2yDFhY+6GkamkvPjFEyvD0pgG9uGbW7YO6wTx2dm2BA3NZVm4oEMDMgN?=
 =?us-ascii?Q?yLUI5ZLjLL3ofnSbilQU1xk8bmWO64uGLfbte03lsAKqjCFrEiDxphatslQ5?=
 =?us-ascii?Q?n7LwkvMNK06LlzvgHMFMApswkr8m0MA+smZnM2dkcw95WABd0aT1Pev7lVpj?=
 =?us-ascii?Q?qNP4UKTz+IdvS/0AW5V3nMgwdiFYpePx2E13l4ZnXiDezPneX7/W6oKFYVF8?=
 =?us-ascii?Q?wkVkGsfWZTBNMESfbXMwuc/K4npjOUB+VN8GmHYUFBaADZJIVq0JhmiNqM6V?=
 =?us-ascii?Q?Q7uxFQqj4WPP29XPFYhQFXl+w/tz6LaKOhIfrCbHOn2HNbHGyrqPLHKAf1ek?=
 =?us-ascii?Q?u7yY2n0iPG9/DzQhxJuq9XA5ywR6EM/7OBmVV/wlYS+7lukgWoIn39Btp5qQ?=
 =?us-ascii?Q?4YjLW36XlsccB6rRhkc+5QIVdp0xL1AVLbQDzBamZB7Ew7auepiJ6Z/WprpF?=
 =?us-ascii?Q?cazegdFuZmCVaYJC5GX+sl2MvOgqizyZWixkluT8npOcmPoyBOD5GES+M0Yx?=
 =?us-ascii?Q?9POY1nwCxStGQ8MJeuU22hAf2orvdqFVzsWgYzFdvgvFcj66Gui8a0pRrnNa?=
 =?us-ascii?Q?wVFtIv6rkDeOwu0QZXKueiuoIjO334uDBWKpNJblYnHkm+oiXcI1r7GToOq4?=
 =?us-ascii?Q?Rxzzksphuh5iFkHXKw92LLWjxTR2Fe/FbVk7S2KC30e5v9mQ6+rFIwkYDnS9?=
 =?us-ascii?Q?0QU1e7WJWSFTLcvKSJfwG4dlBLffgn53eX15BK1KBzjUTwJTXykEPv6YzylC?=
 =?us-ascii?Q?Z+8CH4qzw1FP+zq2tIVxMhfQGDLOIlW3i81XDDnbUBS3Cu+i7Eg+/gl6z8zL?=
 =?us-ascii?Q?M5GCgGs1gHvcCANdE3i0oBsnPiY2rzd3evQXlSPQBB/D+pXaIMVKvSU370hu?=
 =?us-ascii?Q?lP4kNOb2Kso00vm/l4KZpJtxYI75FBnUA6j5YvLX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4dadd16-7edd-4ddb-4c71-08dc81a9483d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 19:38:44.1955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNEGRjnTAv/B4JHp5CB50V8Q/JUmmORUfIgqK/uEFjDon1wGedPoa2mSDZMFrKYsDDCCVqJT+DStueY5s6/nAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008

When building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...quite a few functions are variables are generating "unused" warnings.
Fix the warnings by deleting the unused items.

One item, the "nerrs" variable in vsdo_restorer.c's main(), is unused
but probably wants to be returned from main(), as a non-zero result.
That result is also unused right now, so another option would be to
delete it entirely, but this way, main() also gets fixed. It was missing
a return value.

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


