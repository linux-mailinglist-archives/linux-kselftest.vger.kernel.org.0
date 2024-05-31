Return-Path: <linux-kselftest+bounces-11048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0080C8D69D9
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 21:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CE428A395
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 19:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13C717D8A5;
	Fri, 31 May 2024 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DcSWg5ps"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8A117D358;
	Fri, 31 May 2024 19:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184325; cv=fail; b=r6PkkKOYGOxbJGrqcIF4T0aViNuzft2ZW0Ye7iDBGXWdX/AGs7BpeZ0gV5PwwWo25ySQ7E+yUE4prKAJg96gQbSuLXfGaypbAmBt5FRQkKaKbzFu9RvdGrZi0X9JUCq4CNTElpodH+aGiB96nz7x4IGwH9pj9+0gqQqh5JnDxrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184325; c=relaxed/simple;
	bh=ie2OqclMHnylLphlJ/DT+yCw3LgxNA7ecDYXdCmGTVc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MHJiGLLNLU6O7W8tMwWjsjya8uPSMBHG76q1NiY99gLQ9ClnyS3757YSQ8nCPF15Xgo0UwKjOW0nY1IOwAl2cHsV3nSqWHRy7j5JFwZi5kdL8BK3qVqcbvFgK7mAeUiSUeRedZIU2Y8wLeJt/FdWlrzKHCez1fd+246Wc6JfbSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DcSWg5ps; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+W2i7kVKO0tYWtTSQsSvg5ql6OzFNVLUGp7lLShjhAWz/LwNeeGSeAdGYX0UZoYBWkTlQPCLDzSy8+wunDyPBjcz+ZO7qVkAntIWr9g7ylEZM4GomQXzOm1KsfjhRMg/4RejO2MnDL70b+JhqFPDpz95Y07TpPfXkMIf7lznxGstzYi/NpD9lD2IkbGFIOUsUQHftzjYML6UtO0VZoP1xM4idO2frL24L23Rmw7OSrzITjjBSzDZ1OYeULxapvXNiP2LIQJzGlqpQ9SRSJ4/uzMn8L1KtZGQo0H9e5Shrpu5fHslHTz4JRFKinvo2RY9+w/nC5z3dommKOM8pw+yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gbvJvlxgGSEfx8wcjWwvCw7mOfUZfqC8rRe73WXMqY=;
 b=BvpPBMat4+gJuIWTuf8HKovVvHoDD/r6AIL/y7hKb+Bd+G7S1VADsJXVr5MNLrx/YRXgYWfHseDPrPiBcmldZdUd+R2saskqsH/POZYv2P7437N94Ea8amUTIeUXgqh4wZc3BWIK+Tw+aElf5WmLjnTpenkiY9O463IHiX9mbYinQ+TsmRWk/o8MGAZPJKXebeTtbOwlQL3rcWWbBbDo2CYh2ETtc7Cou/40V9gpsqgTq/udxLRvFA1Nz47H7AUAqo89sv8dAZxSFjwWKf3+IFMOf8tIoKlS8Hou0V/Czvucpc+/HrHA476bavNQ94IT6cw+xVOimHV2vVKjRkRYpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gbvJvlxgGSEfx8wcjWwvCw7mOfUZfqC8rRe73WXMqY=;
 b=DcSWg5psnGjl9zoYon4osqlyKt4gVJijqpMwYmOw0Y+Bg8G1DUANIqDLgV0ulrcRPFDyBu4onu7RTpMG5JYuQ4t4qi18oOQNI9AEpkBSugBKL2RFRX77ClPlgWmuR5ogBhUtu9/FKiA/vlO27DEvNQZxbwSIsH4dGo2y6nV4sC1EYmJSe003QE8OJb0SSEGJI2YlWsJMb5PJ1QXmclLQY4k8lrMcKNd8Ez+VC1GvYv7BbFZAalV3iHF4UKdFRcKRhhToYpCEzgTL0SLhgBf3kOMWuLC3qXMY4Yx1qNixMUwuu/TabagcMD0jA1QfTGcxz4jLLn9ntWdRo5XlqBt1+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Fri, 31 May
 2024 19:38:40 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 19:38:40 +0000
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
Subject: [PATCH v3 0/7] selftests/x86: fix build errors and warnings found via clang
Date: Fri, 31 May 2024 12:38:31 -0700
Message-ID: <20240531193838.108454-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::23) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: a00d64c3-83aa-4367-5dd0-08dc81a945fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KK5tn7+mkpihbUgYxAwVy7y1Odd8685avYygAxtw89Ps2gkjMx13RfrBHcif?=
 =?us-ascii?Q?sKVPKy3h+LJIWuHjB4dcn3EEMuKAN3GCE78/UHJT0iJnVRVqWcrJMuJMZXKd?=
 =?us-ascii?Q?Z3+BlaFEc0dQvifEuNCwC4q4HqCXZ9Xxid3bwWePaBbBniyC5PWOSkMNRKPn?=
 =?us-ascii?Q?kTIg9H79Ezdi7TDdOLntBq6kdoUfr8vA4oc0OV1iHhBjPu4ETzsR3P1GvN4F?=
 =?us-ascii?Q?hgHfgTrJev7HSEOE2CG6MjCafuZhN0dHNZWDYCyS97Dv2SJIrOkmgEq63JbH?=
 =?us-ascii?Q?NcruqGP5QJGr4l+VX86IfzM1G/8CJWLYPYAY7U1WDitpjp8nGzTxeRoTUtrF?=
 =?us-ascii?Q?RGZkud9l4D5L8uIUCQjtN+Bh59oSU+MTchZ43ebsCjXo4Vl3LgfBpMipa6rg?=
 =?us-ascii?Q?SNq4Zk4veCDqk0f0f53dV/3ChYy485orkI7u6t2bgiXXCIWNNGbrB3vZMj/M?=
 =?us-ascii?Q?wDgne7aaoxOrVcL4q9MJ4fQ+s8eqwxxrjy5oQXXSmyhLBKE8zeJxfybvPhVM?=
 =?us-ascii?Q?a20pYa7isjt875CDtb0nVho5ctPbRDlcouD8Z8/AKOsiJA3vxXnaWT8yOEhH?=
 =?us-ascii?Q?Ns2KUv0SmzZtwWyf5AuJtp+VrvOGUMMQLuBiwE0lTQmXsLm66xW0MswZZp4x?=
 =?us-ascii?Q?m9dBrzviynpD0P4R2n6n8lprUnkR+XWk7s9Z7RQ/OGVmg5899+brCKpA/MBW?=
 =?us-ascii?Q?2vdw3/OYye71cNltDVakl/Ib/nj0ZpXa3yq9M21C3YmZjGa3XaQW6O1X82tA?=
 =?us-ascii?Q?9rQpENaxucVPx0sb3hHMCyXhxn7oJcfkUG5/XfCvY7ph248EE9NDMpdNKJb0?=
 =?us-ascii?Q?extT9I9AkiNBPEtl3HFugvboEEN9YM2wU5a52jkfG8gjJKMa+HGnAF4J00E5?=
 =?us-ascii?Q?TcZWU9JCdod/t8ayl0eVA6lirWRNH5COm8bdK+QjK1wT1Jp6ANYieYeV2JfW?=
 =?us-ascii?Q?3bjSw2khI8t+MUU5Hw4VnGLScTie5JNJG047/i3wn8pxMDVQv0LDX7+WKxN/?=
 =?us-ascii?Q?tJ5LrTZ0hbughOb5jH8ZyUJ5beG/LwUIT6to74DUA3t964ee9dgUHULTrhjI?=
 =?us-ascii?Q?q66M1riuu1TMyUU8dQzp09ijna49kAFy3EIsBXtOLdnSSK9VFk7SSLzLfNTq?=
 =?us-ascii?Q?o9LXiv1IOqa1Ts0q8m8Vjwgj1zdi0doPkFgevUYLB2ckNLbQso4fQltwhFN0?=
 =?us-ascii?Q?M0r2yON5C39Oo0MxJhP6iSDg5tJdRtbkBbJCJ/SqfgKGejdr1MqgCrn5oGdq?=
 =?us-ascii?Q?Ql7OtRXdaNrEFz6YRx7/n1DUneqdBAghq9egy5S6oA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bBeZDNtMgtmO97bdwAdcphg784Tj8bkR03KfF/06vjBCcUlAiVJghoPauZOd?=
 =?us-ascii?Q?VOE5UD/em2RXcWXvlAgJveUE3l0L6TwAIcnhWFaGvkADUupFxD3NJ3iY3RMH?=
 =?us-ascii?Q?SOYoEXxQDJZkZw1k5m1/wZwMmiU+uI6K9bl42o90jBeCd0v5531SGkKrpnTf?=
 =?us-ascii?Q?fZHLr3MjcmgbWr3ogdcyrIvB7meFCWyaePptyxsMLPNRSjc9Fr6fVtO6h+K6?=
 =?us-ascii?Q?UF3rVTO0U92D14JmQgC9ld5AmFW98wU67xsAcmIa4KGTHUshrR5GlzdLattV?=
 =?us-ascii?Q?z6mEfHI0px3lom9rpM7LRNPHwMNz4oJ/zcTJtJrqbAdSnzdmkU3pCXl7pJmT?=
 =?us-ascii?Q?gslnxX/rA8xGY+EgpxAwZPG0M8+bSa8kMe3HDCxKFklTUAY8OhC/eFkxB+3C?=
 =?us-ascii?Q?3RBF3YKl8AAgSBZbalxS7PMI+6s1RJfoP0rtj36vrLtKd/43ClgxVxbXMU24?=
 =?us-ascii?Q?ZW2dhlkAitEqGpdj8AgHa6hYkb0zW8IoX6DURwnlsRQnXUllTVh/HjMvlas9?=
 =?us-ascii?Q?dSldXD4ITEQhwl40/5hROPY1necBx3z3Krezreg4vUPLhYfud2HYR44rMk8P?=
 =?us-ascii?Q?TDA2FppMCv2jY1QZ5OPrmS6H6X9i2ooIfZJoqoXgNek8qbPNeJ6ItDfrz2Hr?=
 =?us-ascii?Q?xrOChkXHBP1jJy0RtQiRwLUhe2gr88qtxTHyPU2NUUpSnC6aDYRQxK5GKs8H?=
 =?us-ascii?Q?SKkDDUEh+cEYFTX/ecQyEXZjOW+cUoxYtB6jvC1hS4zjalkcfFEedrhoVgj4?=
 =?us-ascii?Q?etxw4uRmuJ+PXmbvRJnCYRHTXFjoZw7x0zotSduTFFNZTyLd5qeil9UUrj8r?=
 =?us-ascii?Q?8F+BeyOZ6Fvv9wxRL+RRemvAsGVM3/FKJVZM8i5reVuUK/V8ImohN27MKI2P?=
 =?us-ascii?Q?hSqy/K/CecdpynWVmfc+0c94vUwfOGts3KX2lHKJQ1AwuStxqwfC025Lb4Qr?=
 =?us-ascii?Q?OjZjsnInVYVO85Gh5ngZrg3h8mV8MwGaal5wR69C/Tz0GGJizqs9l4Xtjhd4?=
 =?us-ascii?Q?oDIAD3OuQGNWc3Nu2yuegRwiYDferMNRPazY6CK69YeFFJpbVk9AtMHUzdg9?=
 =?us-ascii?Q?RITOyTGbsohGXUEF9W0QQpGxzq2J34AWziGWxOjIWEeilwO6wvia6nerVkVK?=
 =?us-ascii?Q?rkViBg5IGyQsxddH5omjqAA3E7+X6RQhTm4KmfZI9d3V7XA2jTM8pCfJFiND?=
 =?us-ascii?Q?tGOq2Zx5Afgkby0F+yIsqk+xhb1mAlg/McrkifP6nyMp9J3tbxeqSdLKUjDS?=
 =?us-ascii?Q?tqvZxWjsTwBJ09ZfhmcLXlfFpPvIcKYoQZjejMtuivZGvFB5FR3POSAcPFhg?=
 =?us-ascii?Q?VEcs47u2OF61FXbt3GLGZBznlfmZbMEN2PlMBmC6XWIz3tNbE1mwC0B9HGf3?=
 =?us-ascii?Q?Vc0KK2i+e8ZYZl5rSoYbtoJSDXS7tYCYEFwH5QxKmnMBIO1yQJ8aO59E9yyR?=
 =?us-ascii?Q?PE8mNr14pK2rwX9HHzYnYB+HnJzXwjv652GeIwUewqbnnzvR8AEnrwzEQwQO?=
 =?us-ascii?Q?q8JK+sHV+PLA1iKukEr0+F+epR6e6g57hfsWEKSIQbC1ZddXziQFLh5yxy+N?=
 =?us-ascii?Q?pigoNU9d/hAn1az4m0pY2fEsBONa0CK5b8/dmqCu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00d64c3-83aa-4367-5dd0-08dc81a945fe
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 19:38:40.4416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLfGlM+6H6f+TbOiaRxx8ZcW0V9r/ENz6j6gBh99rGkPYLf4YMJ1ekhXZFuEFbjkpuC8UQLpA27fwsDjNlnG8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712

Hi,

Dave Hansen, Muhammad Usama Anjum, here is the combined series that we
discussed yesterday [1].

As I mentioned then, this is a bit intrusive--but no more than
necessary, IMHO. Specifically, it moves some clang-un-inlineable things
out to "pure" assembly code files.

I've tested this by building with clang, then running each binary on my
x86_64 test system with today's 6.10-rc1, and comparing the console and
dmesg output to a gcc-based build without these patches applied. Aside
from timestamps and virtual addresses, it looks identical.

Earlier cover letter:

Just a bunch of build and warnings fixes that show up when building with
clang. Some of these depend on each other, so I'm sending them as a
series.

Changes since v2:

1) Dropped my test_FISTTP.c patch, and picked up Muhammad's fix instead,
   seeing as how that was posted first.

2) Updated patch descriptions to reflect that Valentin Obst's build fix
   for LLVM [1] has already been merged into Linux main.

3) Minor wording and typo corrections in the commit logs throughout.

Changes since the first version:
1) Rebased onto Linux 6.10-rc1

Enjoy!

[1] https://lore.kernel.org/44428518-4d21-4de7-8587-04eceefb330d@nvidia.com

thanks,
John Hubbard

John Hubbard (6):
  selftests/x86: fix Makefile dependencies to work with clang
  selftests/x86: build fsgsbase_restore.c with clang
  selftests/x86: build sysret_rip.c with clang
  selftests/x86: avoid -no-pie warnings from clang during compilation
  selftests/x86: remove (or use) unused variables and functions
  selftests/x86: fix printk warnings reported by clang

Muhammad Usama Anjum (1):
  selftests: x86: test_FISTTP: use fisttps instead of ambiguous fisttp

 tools/testing/selftests/x86/Makefile          | 31 +++++++++++++++----
 tools/testing/selftests/x86/amx.c             | 16 ----------
 .../testing/selftests/x86/clang_helpers_32.S  | 11 +++++++
 .../testing/selftests/x86/clang_helpers_64.S  | 28 +++++++++++++++++
 tools/testing/selftests/x86/fsgsbase.c        |  6 ----
 .../testing/selftests/x86/fsgsbase_restore.c  | 11 +++----
 tools/testing/selftests/x86/sigreturn.c       |  2 +-
 .../testing/selftests/x86/syscall_arg_fault.c |  1 -
 tools/testing/selftests/x86/sysret_rip.c      | 20 ++++--------
 tools/testing/selftests/x86/test_FISTTP.c     |  8 ++---
 tools/testing/selftests/x86/test_vsyscall.c   | 15 +++------
 tools/testing/selftests/x86/vdso_restorer.c   |  2 ++
 12 files changed, 87 insertions(+), 64 deletions(-)
 create mode 100644 tools/testing/selftests/x86/clang_helpers_32.S
 create mode 100644 tools/testing/selftests/x86/clang_helpers_64.S


base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
-- 
2.45.1


