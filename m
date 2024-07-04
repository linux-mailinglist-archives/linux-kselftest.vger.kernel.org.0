Return-Path: <linux-kselftest+bounces-13175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7A692707B
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 09:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09CBF1C232B7
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 07:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B121A2C18;
	Thu,  4 Jul 2024 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NzupmT2l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFA41A2570;
	Thu,  4 Jul 2024 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720077930; cv=fail; b=UzPniwrRUK5L7yx179LCYwxXzNQaie0u35vZK+d0j/VgHbDaWtygz9YOPQXeX9T4KWSGoAfBHn0j9/AlCIpSiqKbdPRt1hQoGTdpG59cDw1Ns4Gbe/NqGjSGPVZjq0AqT4C4WnOTY+r0c2Sc6zREfO02OtS2HdKWmLNxRWn+/js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720077930; c=relaxed/simple;
	bh=niEUSUr5jT39XwuYK9l7lc//lUEMKOU3BgbAMYzwjok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pMRbFVNQzV7wRYiY6xHum3xANw+mq5t9Vcrr0zpElJPU+b9drXtKR0JwhoZp+1EQJkTg/fKPVmF6eOmsQLTD4uT3AgEpjPbndR85XJHY+EINk9ER2BgZdyaZjjUKeIAupGvrEH3zJBm9DT1rc3raH8CDbU+krS2SgVil8vzRnI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NzupmT2l; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ofb3hLMIAYL0+kPIngZhPl1zkLB+6ihi8sMJhXD/JYYZDXCHw0rX835J1EAu14Of8LQTN/WsgNXRB0qyoFlfnEjAJCZUDBF2gjEg6mIZoJPw4Sunlfp2JHDjrcPYhsm7SATKWsAM6aNRjUhBbGtAAc9QrztoCw/yJwnRZ6l29D6VXvKg4fslNHYQcK6z5wGu13gMi82b+AA6OHHRjrk1FO57i/NkfMv2Rl8i6hhSCPnHPPR/jAkmBRsAvTR1shnWeslX92ooUuumWqopHLcyZY2EOfksH5/svu+9JPiuotl3JMm4ltXATVLlZrRhHLG9dTwxjaKgZMf4Oplc8lZa5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWPco6IexFMyI4ntqp4WT7USqkIwQMDjZt92k0D7mMA=;
 b=RVrXIujdHcYxJm+rvkvbtdT/yCj+LtevnwnCciwkMusbHhY+vbFQ0HDFOZcBZk7hG4YxS9eQnTGoNhVZb/jQLspk9J60+xm3SN8RTa2b2X5Bqo9IgpFELy0F7d6lNAsIEJAbEcTR0soa/HChAE+ghVu1FWUXPSstiKOpz0mi5VFAN573ez4XgrroWTixYQn8kqw0PyPC5vbpYhWJGhTBRxdXwMpzL8t5LJBim3viy1lZ6zjE2yYa/5Lg0S6LU2en/TVOSE6NX25kw3AvzLGt0z63G2KqBkPkHTyfLLq42dpoSf9DSYoCTRrYOVghh7SFnjvxWGYEGWyRN/xvrNDQ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWPco6IexFMyI4ntqp4WT7USqkIwQMDjZt92k0D7mMA=;
 b=NzupmT2lWZItoS1QHYBnw7Li8eyyyzbh3s9pb3MbIxkUByJrmvKiCqKAiI87fZcWYzupqqhCldhzdYB74p/aIVVA6sdUONSpfJwiA9DArfSxHxCRt0J71HK+vLzl3eD2S+32A7lL8sP7OZ73AbmHZVcydvIZ/IvyLk82/aEFkmYaTqaVq/wArl4wHW5IdynkTxhHYwrXuimErBSdAtNdURoGCj5ANdSbN+Y4NDQnWtm1Ip7ZKTb9l3JCEJgJ89Jd+qpFubsdlxaOUduA9qIcUE6+kbWahFPKzVpk4WiheknV3Adq3UcEgw6oe+UCPxrnvJYz28sXyrEIZZmQL8Vxnw==
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
Subject: [PATCH v4 4/7] selftests/x86: build sysret_rip.c with clang
Date: Thu,  4 Jul 2024 00:24:28 -0700
Message-ID: <20240704072431.111640-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704072431.111640-1-jhubbard@nvidia.com>
References: <20240704072431.111640-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0197.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::22) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH7PR12MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: b88e0389-09f9-4ef6-7135-08dc9bfa779d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZGRiHVZnXtT4tCcpi+q0fzZNKHrKkJiGaqtGCwZSYDDL5Weo9+eNS95LgSGC?=
 =?us-ascii?Q?RdBkDeAcHO24+9Or478rOydMweqaIGLVPa95K9wkrSnz9brnUpbA5d24vWHm?=
 =?us-ascii?Q?8i4tJ/aiK8Pxs39ObPnXJltAOtf8GPXBLpIOEbhaUtSRtH6a1Ua0exuzJrrO?=
 =?us-ascii?Q?o7EGssjlUXpVPg0F7sB24wsmzXQdeG5O32iEaHYJgZFGU2URJLEjcg4e3YMO?=
 =?us-ascii?Q?qH69Zf7TO/XTAyVU4XN39Jr9qe8pg/lN52RTB89sjGB/UuXYakX5VwX4Ee1e?=
 =?us-ascii?Q?hN1LfH6rL3ffvZnO/CiWojwooFvtClleKYYpkqXZtfvRo3Jtgw3GF7wTWsOg?=
 =?us-ascii?Q?U70D43YKBVjVn0VfxTBfPF0NeXM0h2NsEHLz41qW1mBg+plyLE/EzgorR8XD?=
 =?us-ascii?Q?cwzSMJ3b/3xM4xm+9unZ6BO07CIMe/TZR7V3n7VHTWbNpbnOfKYgmr+iYcF0?=
 =?us-ascii?Q?xrJfgeRoF5apR2lmYSLV0Ex6ZEi0WAnnEzFeKwquHJ2DF3Z2r2OB07Zn1JEs?=
 =?us-ascii?Q?jUGxgbAkWwcf1D+j63ywFtYs7urktqz0cAK+XEOeR/zzfkUE71TaeZJp2BNC?=
 =?us-ascii?Q?1XJjH/wGfb80ltn3nrMWuFmY3VkPpsRmEFBG8IYP+qJiNHXawIu76Bj+DBh9?=
 =?us-ascii?Q?Pgx7hzIVTVUdjUqk9TqFEmYJzUxyarssS2budq895ZkmBDjf+5c7S/vpm2pB?=
 =?us-ascii?Q?wJtvqvgxUhaTro1ZAbmh/IbF9ceUebpoz/54Pv9RScI30anBl0+JEcgXm5AM?=
 =?us-ascii?Q?OqNQ16/zMWFzCK/vRcA0w6hS2tIK35dl0uIKEthxXIXil9owO3C89VtZ2rn5?=
 =?us-ascii?Q?mV7y72bllL4tvfEBjCrEmTigNre4BxbRvkPBl3K3h/GkUe8hnL6ZrXigOWIM?=
 =?us-ascii?Q?NFIYUQVoEeC4o5PBq84PbXzNGEM0eqQ3v8gmTaKXKkmz83jBdVUe0UU/O0Bw?=
 =?us-ascii?Q?E7LlMFjXyYBlVIOWbqSqHCiw3aA/oFvGgaS6ZE+VpstFji+Bx5UpKbxKHhjH?=
 =?us-ascii?Q?wnZKx4Pwyf6R85Y1weELgz/yem+O+mbg/VeZUCLXM/ehnrPjJRJ4DcgTgxmU?=
 =?us-ascii?Q?Wt3y3FFjib6q3zTDyPgZp3+joWnxwvsg5YxXRvQMSYdfaSrdWtDOIhr4HQnU?=
 =?us-ascii?Q?fcztULMBJmqL2u3mdRcoKpXkkn4xrRgus6arkh2woab3HQG0brKZHGMZ7zdH?=
 =?us-ascii?Q?75ygDas7c55Lb3W6MP0MK+I0twkIbpJnp8ctWUM35JvMXCxQGwG+ve8gE4cf?=
 =?us-ascii?Q?koPyPq8fCMBm8HgacStiWeuZ36PcFMbHVQV6wnJO14pnHgrxQ2VHs/9Pue44?=
 =?us-ascii?Q?ZAMSvNFLDSEiCQX152JPEBkbXEDYq/9RfB9si7tAhCFenw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Oj8hmvi9P0PjiAxDBlQOJV8KdhWEJDxKfStao6yklZxnD4ZkoxC+YRBhLnU?=
 =?us-ascii?Q?ZpKSDZgFEvAoByJjcfrw+23mvBQ7hr8qvoUG8v0NZbE8kMN+g/Qi0B6rHyRk?=
 =?us-ascii?Q?giYzHpuGNJHulS3/Y/bfB0OqlYIrpQVwuObpHUGv8JxTJT0qts5OBWcFOrV7?=
 =?us-ascii?Q?aRO7DAh+CCJNjSFkg07q3fEaxOWs8zFeS0MSO/SMtCMjrIi6pJM0ZNhZZfE5?=
 =?us-ascii?Q?+7nSEegFlNKdCJN9eEvB2vCTpnYXfZtqMMjhayEr8GAgypGPIym2aECt207K?=
 =?us-ascii?Q?T3En65lbKykk12Kz09P/3bY1enbQkTNTqfE/h8oYSUUG8KvPRQiJF9Tg+ZRi?=
 =?us-ascii?Q?9FpGaPRYK+GFp9NaJiSR3BLsCCsuLwORAiIuaH3bMY14rPoXJqVzu5r8mCVD?=
 =?us-ascii?Q?c0A6X/o3LiZDddJG2hUTueVXZPn9u7JJr3c6fHsXg5t5cOtuEIDLmuVy5IjJ?=
 =?us-ascii?Q?VRT22unPYLsHJxU+7cSHH+w8O/EP5Ks1ADxCLW7BKxb0o/vsZKKRJYAbp/VJ?=
 =?us-ascii?Q?iWg01cNqZho7YHjtoCZebxiMGqIPdK4rDHv3l+6IfPg1/8VDW6G3W1mLVQV+?=
 =?us-ascii?Q?H/Wa6nYJhJLh6BLuhlZI/Mz7d+7p7Uf5oPScqET1gR1qEBDuqX+DXqyO7Z2P?=
 =?us-ascii?Q?fIyYZHvmVmSeDCKUX5riN1vR4PG0rMfAFOxfrEk18hgk/1gFYtP0Lw3cYLrE?=
 =?us-ascii?Q?p8pleUE/smSNCBoiNMx197fzA0+fbCZXdUP/ejZAgCVVUgatbg5y89h96RYc?=
 =?us-ascii?Q?sfs3tRcqMIPpfP557VdVr+ncCjLrJZd0WdCiSEB4UlBh3rZXjT9im6FTroY5?=
 =?us-ascii?Q?5arWR+V9fH9UBBcSHbIPU8zcqXrW00LrM6dtlHeUup3s5mD9633JQhEI4x1q?=
 =?us-ascii?Q?09MXPxfK8Ro8TiX/eU1CIGXiMhKNT1Y0SX1daiT0x8iPf8Exmyh7e2OPamTz?=
 =?us-ascii?Q?lx4s7hy0KO1FYsNSGFz4WOiKygqWgQDnZYot4Zik4vhuc0IE5fC8VZB5aS9s?=
 =?us-ascii?Q?PGXpGMNviQ4Tbnxi0gtKeODGqO8nJ1Wa8KnQrAI7SwkW4vBI2348PdYaB2XX?=
 =?us-ascii?Q?WrEVT67M4vzamRk4KTt4w+tsNPZhJZt6BEDnaNaaXMw8Bdph0rlw8OgHLUup?=
 =?us-ascii?Q?F0y1w+CP1p59g+gXaCgBgtLDKQwHp2fCPaMzcUR0JWNkXhkZRSXBftJygSS1?=
 =?us-ascii?Q?XfRm8gngt8VIktWFy3f8yTD78/r+0tvsA3eZ/F/fShXvTsQyGEAkBSFC8Hr6?=
 =?us-ascii?Q?pDn9gYO5X7NcLoeBmuXnPsJyfN9qmBeUM7yQ0jmxxR8Q3cXobwZ4bMf77eXJ?=
 =?us-ascii?Q?59xolOMUy8QSmGa5WQRZsGURsH44p09kSjpJgzGpOoWF5CYyOvTvOhkKlYFZ?=
 =?us-ascii?Q?XeWDdib5lGVQ7qDPCz/GbcC3SVvN4Km1BH9Khwsc8htZSlkFv3OXE4GBr8Q0?=
 =?us-ascii?Q?NMGzvTQ3bd7wABenE+2AbGMpyYiLYkHuDFmTitMb4b+8byYUVMBTeE1vG3Wa?=
 =?us-ascii?Q?62/38hzFkaAY2yeAHwDTejFg68CR5OQMySOUcBB4JsQQOG0gVQnLOypiueQa?=
 =?us-ascii?Q?7jfhvKJ78IoeIYQClYvM7mV227CtO7yBbeVjOG6namdK1jlRNBnHSwhYNQsH?=
 =?us-ascii?Q?GA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88e0389-09f9-4ef6-7135-08dc9bfa779d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 07:25:23.1406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QinwV4uBbGOhdiFfPyQ/dxde480YyKj2Otwqss3PSDecYldZOQyzbzPFKpGdlDv/vFOLeBbVKysS5H/8I7TpzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6610

When building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...the build fails because clang's inline asm doesn't support all of the
features that are used in the asm() snippet in sysret_rip.c.

Fix this by moving the asm code into the clang_helpers_64.S file, where
it can be built with the assembler's full set of features.

Acked-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/x86/Makefile          |  1 +
 .../testing/selftests/x86/clang_helpers_64.S  | 16 +++++++++++++++
 tools/testing/selftests/x86/sysret_rip.c      | 20 ++++++-------------
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 99bc2ef84f5a..d0bb32bd5538 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -115,6 +115,7 @@ $(eval $(call extra-files,ptrace_syscall_32,raw_syscall_helper_32.S))
 $(eval $(call extra-files,test_syscall_vdso_32,thunks_32.S))
 $(eval $(call extra-files,fsgsbase_restore_64,clang_helpers_64.S))
 $(eval $(call extra-files,fsgsbase_restore_32,clang_helpers_32.S))
+$(eval $(call extra-files,sysret_rip_64,clang_helpers_64.S))
 
 # check_initial_reg_state is special: it needs a custom entry, and it
 # needs to be static so that its interpreter doesn't destroy its initial
diff --git a/tools/testing/selftests/x86/clang_helpers_64.S b/tools/testing/selftests/x86/clang_helpers_64.S
index 0d81c71cad97..185a69dbf39c 100644
--- a/tools/testing/selftests/x86/clang_helpers_64.S
+++ b/tools/testing/selftests/x86/clang_helpers_64.S
@@ -9,4 +9,20 @@ dereference_seg_base:
 	mov %gs:(0), %rax
 	ret
 
+.global test_page
+.global test_syscall_insn
+
+.pushsection ".text", "ax"
+.balign 4096
+test_page: .globl test_page
+	.fill 4094,1,0xcc
+
+test_syscall_insn:
+	syscall
+
+.ifne . - test_page - 4096
+	.error "test page is not one page long"
+.endif
+.popsection
+
 .section .note.GNU-stack,"",%progbits
diff --git a/tools/testing/selftests/x86/sysret_rip.c b/tools/testing/selftests/x86/sysret_rip.c
index 84d74be1d902..b30de9aaa6d4 100644
--- a/tools/testing/selftests/x86/sysret_rip.c
+++ b/tools/testing/selftests/x86/sysret_rip.c
@@ -22,21 +22,13 @@
 #include <sys/mman.h>
 #include <assert.h>
 
-
-asm (
-	".pushsection \".text\", \"ax\"\n\t"
-	".balign 4096\n\t"
-	"test_page: .globl test_page\n\t"
-	".fill 4094,1,0xcc\n\t"
-	"test_syscall_insn:\n\t"
-	"syscall\n\t"
-	".ifne . - test_page - 4096\n\t"
-	".error \"test page is not one page long\"\n\t"
-	".endif\n\t"
-	".popsection"
-    );
-
+/*
+ * These items are in clang_helpers_64.S, in order to avoid clang inline asm
+ * limitations:
+ */
+void test_syscall_ins(void);
 extern const char test_page[];
+
 static void const *current_test_page_addr = test_page;
 
 static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
-- 
2.45.2


