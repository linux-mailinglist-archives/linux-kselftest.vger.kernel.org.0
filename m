Return-Path: <linux-kselftest+bounces-13178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85C1927081
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 09:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1741D1C23317
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 07:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4811A38CB;
	Thu,  4 Jul 2024 07:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aapGBSrL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC5A1A2FBB;
	Thu,  4 Jul 2024 07:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720077934; cv=fail; b=qJNuAz+5V05ADhjDV6ZtWvX6nxidKIGFKBE6qxsu3QWupmWX1vYRjyuDUtAfW64xxpqVa9nAozkObzsOoXdDthJ3X1bCEp4EQetRzVRMZTPfrSfiLdgCInodCDSQV3wXx0M/wYcR7RCVut4dgksmoByiECJHPDA6Pb6PLCPRLOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720077934; c=relaxed/simple;
	bh=PJkb7pOjet9akjxtdL3weN9511lk7kYO5jQcO/1Il9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XIT/rxidVAMlSWsLGgyuE9HztAuq/WuzLuHMEqK+mbhq831R4sIYj351auHS4clwg/vSMlwVgkENQd/8aXCz9V4hpL3CkHwE/s5LX/gyplcx9JISTXIit2WQj9P8tnJfvTWH+IHIOZljyh2meNVmUZ1NUa0yZ5T51OS5r9Lr30Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aapGBSrL; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFdbHvDZvgc8MsLa5WE2t144fqwtYq91xIiYMsRl6Hk8voyB7x3+6KfRSjvfjgqfZpVyCLP8IMDhwOS1Sjw1TVgx9giHVT3/w8i48crLIgtnm5pmNqt7DGwQ2MafkTHfdTXlD4MhV/w9EI0O5fFbXzw4a0CUfhbS71O4+dbJAAAWd3Y0ahayOTsTgwGC8TwCaJ4oLcoZC+oc4QAJQkLux6iR/iboVBj1bw48vg+pQHvEvONs0tMuOMuYhp20v30fa4hbIVou289+COiMZnqmzeGa63GC5FMzQbZOvS20cIpq69edazVZYK2Y9qT/YaFTCR2fXopNvx/gidNgVTSygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AEZVE3Uiw5qEDEQbGcpW//gGLlgERAuhbrwbTfJ1E0=;
 b=fT8zReR31fyercTkuPgdMVRA0ktAkcX3jcZQgJ3uvsa9KPovKtkVfmZ4lnMe7Q/rx5MPhIMm2HltW9FYdAt76+8a9MJpnGxDxjhpVhb8m/Hk9zCCy01wwJYCqhEXmobZuYqBFQwb4ul/JE0jmkyPxjgoyQ9sQ2Qksje3lZh7/ERSnnBJdghW6Go3reh3sYlVx6PEKksmNfxXMBSYc3Pw1ozA2uP2Gnk/EmY4xVBv1JkoMTErKuoR23u4VXRrN9qRXbRZZV3235j1E/TGo7Q3PH5lpYAugWtN5/JEmOK4HZobBJaOF049jXScEbFAGgwORh5x6piTP39+5f7BhczVZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AEZVE3Uiw5qEDEQbGcpW//gGLlgERAuhbrwbTfJ1E0=;
 b=aapGBSrL6BdcgfmMMzvaX8uZY9+IQabbHfYk84cXiIPf/9AYxUGZAVJoI+zPQmPWAqVTp/46zvcES67z0ugfrZwHdGWVjS0UvgekimbQNaLrTLu+8zeOzMp5ffcv2o/KiYXH+OV91L3sec+OSY+q+Cztk0MAf3jB3VTmFVOAnRDVQj1JN2NpxoWkG+sOaMrZtGYlMKKWhgXgZHvqNeFJwQOXwZpBexMLeq1oFztDuTZrvxbBkXhC1VN+ES2ixHMYUNOY2+r/wJFB9hVl/Pm5wGFeEqfVl3MbVQEPP/Y8n39GTIryl2oCRr++DQPqJL0/v6/ElmStXexitI7X7iIMSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH7PR12MB6610.namprd12.prod.outlook.com (2603:10b6:510:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Thu, 4 Jul
 2024 07:25:24 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%6]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 07:25:24 +0000
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
Subject: [PATCH v4 6/7] selftests/x86: remove (or use) unused variables and functions
Date: Thu,  4 Jul 2024 00:24:30 -0700
Message-ID: <20240704072431.111640-7-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704072431.111640-1-jhubbard@nvidia.com>
References: <20240704072431.111640-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::24) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH7PR12MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: 033eebbf-4b25-432e-e040-08dc9bfa784b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eI/GL3y7CkqtIxWYe6yo66H9OtQWlSYn+r4IPEpn8p5ir+BmNKqV4IiJmHLo?=
 =?us-ascii?Q?Ucupnqm4rIE7CVK69ofyN+mtcKxlNsvuIl/9XPvWyp0QsO9DOartiDiO2yeq?=
 =?us-ascii?Q?CefEPLbyOxOb/BznwBaW+pgabpRuLCzcVL9h9Nez8U83/nMr2cDD5U607S3O?=
 =?us-ascii?Q?YIVTkx+eAcAZR3vARx9esMTqRTXWSuYZkqpUqplC6Qq+0dPlKaDOLKfRisHe?=
 =?us-ascii?Q?gdKHi9aoT6hZSOQCZhmPBXNphZeOz5GD0l7Gg7xAiUzrmRxic/gBtoGnEMNQ?=
 =?us-ascii?Q?rYSriste+srD5yYswVRQ2MwCmwYenWtycVn7td9cfndORJ/hCH5eLQH5RZD8?=
 =?us-ascii?Q?crBGo0J/rmX6/PR1im85umwBFxmaCCN6JO5jbi8Wnpd/5MmqtbundEB+zcga?=
 =?us-ascii?Q?jWYnScjnegYjIafLqmLOji6phmoETQ9K/CNc7xCXH9qBREVHsRjHzg96TGN+?=
 =?us-ascii?Q?GDc97yL0AxlVh5U2XSUQyTycJF67hJhfedHtq6xorNSjJVK57mF3M34XqGvw?=
 =?us-ascii?Q?KtSnk5Y9gIkoCc27AkwX4PD7AfirYUsFAFgXqYCFHJ2Ub9s2Ajm0K2Ix/dTL?=
 =?us-ascii?Q?ogysxxPuRHPoxHn6HIAVgotEJxviJYMmgT1jD+kz583zB2eYkDpvGBYk65dC?=
 =?us-ascii?Q?Mnn3iBssExgiarUmMMDNp4RtrTolepDyyA+1TEfBY59bsDt3fAkOvCLYyDCy?=
 =?us-ascii?Q?sKEmgwoPYgbExbL1xzdX3ADEmZhOBw2a4Bj0DO5VF4lpg7rPprFd+QV0iU1O?=
 =?us-ascii?Q?HxIPpKrZx/lnbVw7gDfhxYvDuBhEwrflE0Y1WJJh4o9e6R2dKi2QpgcDzfcU?=
 =?us-ascii?Q?PFL2dFFC6Tksx/mLQ2hq5q1pzgKgeES6OVpLp6+k8oObhrFKvUPNyT1in7Ew?=
 =?us-ascii?Q?bd71+YYe/evCsK/Ob7N3OWt+vI60bPzrbIgDSE5mmOEJKYn50lhlWB4xk3kA?=
 =?us-ascii?Q?5x8UhbXX7dVguuYsMrj6l9JlQDNKky/Lm7n4aUoSSDzXIkmtO5OJz18N0Ecd?=
 =?us-ascii?Q?9PQAlOeepep1dT+f+DFWTXCXNz+gISwsZmFHApKtCWm0FQx6bmCnxy+VQ0PL?=
 =?us-ascii?Q?wQo9LMnA9MmlM7YqIw+2ly2XBHscTRU+ZxzbQ8JaoCBKeNm3EnNnOZ70lt/V?=
 =?us-ascii?Q?U0Z9ZSulYM8pVNGTTqnGI1IH12yZA54ZIYmdnHiYrYR5OQ1Q6aVGT//Vc3ws?=
 =?us-ascii?Q?aFcd2TaxwxeHihkTTwAqZ8m2rDT1IrMHjGXb4a+k9WDv9sbgI5mr5m+etCn4?=
 =?us-ascii?Q?NMENr+7ncCnDsZYrqNgHJuoOSADB5RKqw9o38Vjx/fnmChVqxETBYNQ7RCJv?=
 =?us-ascii?Q?vI+CWkSJzPWW8fpg/CbOMLmgv5Eup0mhLESjo7d81xoMyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2dmKaVBcIJHoUtD4zod9EClKAhT/QbNbJVZr2p0TIOxEfHHODmDatl6sT4p2?=
 =?us-ascii?Q?prEjvk1kWJsQAxEDfHHvl5zhHThC9y7inD39e5Ku8hyPP6OAoal/OrKrSErx?=
 =?us-ascii?Q?Xxq+C5KpKvhdvFlcjoU2Xr9Gs5VAZSEzfymGqmMkUfQSU2zqI/JJl48S+Cjw?=
 =?us-ascii?Q?L3c6R4jx7opS9F1dL6e9IrBzQ0zBHtJ/wuWCKX3L1Tgw6kxA1MyenpP8o0iE?=
 =?us-ascii?Q?Nw7HZ5JdKPSqRpgibjbOtx4adQgHGcyB8dMo0IiPQyJgIkf+LArn3Ku/qBQ4?=
 =?us-ascii?Q?MSxrzCFwtAXBF98/yigVztXFv+lUr1dbhj5F1ofmvyfbsiXWZ623mlPe/xpV?=
 =?us-ascii?Q?LK9x04qs4MIpb+iWHTVoUw360zOEiPTkPL7NWry/4xRPD/YK3cuY1U63k0Un?=
 =?us-ascii?Q?xnJYLG8ArqQU6IvO3Chd6v+GvYmI+NZdgebk+b4bL5ls6hU2DR7iGNAxNcQJ?=
 =?us-ascii?Q?VRuYqNKzFH8H5VaS9E4pdfKuAASG28TqFk+rWLTQ3txaxqJNpugrowm+44nY?=
 =?us-ascii?Q?ifsXEGTCTHu+R8AkuNKAPalOsi3Yhh13CxkPNFIdTTHDqQcjJ4rX9n0YP9sl?=
 =?us-ascii?Q?rj0DGRiTwelgMzIglZMjOng/LEvtGcGQ3PxY8gfnisMhgDDgzYwt8KxTLP3B?=
 =?us-ascii?Q?zJ/j2FuE6+8JpyioLfRZtB0iUekx3irjbesIw+mXJOdWmjOavFl2O2Ac6OPQ?=
 =?us-ascii?Q?Q9KoEsTKWqmn4Tz7k3ygXV475D0pLDhb1zKfxMKVY8RvS7+hl5nJ8Tf0L8Qj?=
 =?us-ascii?Q?STI6lsYiqnqMYd+Z6JCngrVwI1SufFs6/Ix2YnPmU6dVTxUwSN/aZd/Mdr9b?=
 =?us-ascii?Q?P8SJzWhCzU89MyV2oo07d6gmiklRsnaSPWXO4j2JVAy728DL4KOILW5qfeck?=
 =?us-ascii?Q?cxKCZS6vfu9BpFu8cBiJLhD27n422dsIUuTLDAwhJ9YD1Tvb0RQ2TxsRMVkM?=
 =?us-ascii?Q?sACgfoj6vFCm3CPlcNlnt1vLFjaQjVK4LPf/zUGr2TVcyZtd2QYtbX455xL1?=
 =?us-ascii?Q?N+yDYHiinchSFT9Yr3BzPVk4uLAtflcyQrot6NIkmlLUhZPDeW+bpA7sekXV?=
 =?us-ascii?Q?EFyhsxhaTioW939ZmesxKzkHvs4V3/v7z92KUhmRKLfun3IEFUl6NSXi2+9N?=
 =?us-ascii?Q?60e3Nvfs41Kg2rlxd2f/92yVG/tKD3xKeMyIu3iM46r2RR2g0qLGcN2D+szE?=
 =?us-ascii?Q?lGJgQ5rNY4xevF5+PYzlPYvSzZDSctD7j6MxOUn1yCAdl/TFjgCARnxGSh3c?=
 =?us-ascii?Q?dEPwxQsMOHhzm0ln92Uut/vNsXIwXw3XpqQsfC5spEdBnsFHr7EG8yD1mx6B?=
 =?us-ascii?Q?OIFR/siplKokL3NhhsWjoFbrNu8X3WGKTu0yP8GQeMBYLvtNnS8+K7HOROqK?=
 =?us-ascii?Q?7SJ0cRrqAvV1appGy3ocrTQ8VDeY2KgLwNznErlouIcJZ3/rSPuZ1Z79LhKO?=
 =?us-ascii?Q?yLsmCpBEXmYiW4rnOm0KHLbheNKuiiv3pU8HI51kBZgC0hF0MQYQq/N1I9UO?=
 =?us-ascii?Q?ILog1FDLKMpXGlkORLwK/krUjhhCXH4S4eo0Iaiq/6ZIeE0xKko9Y+W0X7og?=
 =?us-ascii?Q?h6HH0EVRV/0L2SgNKw7FLZ5kPjUSZESezGyDDKWBYArKHzfh9qKGu+9fk71h?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033eebbf-4b25-432e-e040-08dc9bfa784b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 07:25:24.2872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8A1f4ex4hpOJu1tTz5rGfGyDImTvUVLpG4T99bH8nT5xYepw6Oj5IO9iPloR0o7CDOXN0av1UJZMV0RHDVxiOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6610

When building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...quite a few functions are variables are generating "unused" warnings.
Fix the warnings by deleting the unused items.

One item, the "nerrs" variable in vsdo_restorer.c's main(), is unused
but probably wants to be returned from main(), as a non-zero result.
That result is also unused right now, so another option would be to
delete it entirely, but this way, main() also gets fixed. It was missing
a return value.

Acked-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
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
2.45.2


