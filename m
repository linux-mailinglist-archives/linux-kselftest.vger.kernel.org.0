Return-Path: <linux-kselftest+bounces-11057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0065E8D6A79
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 22:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663271F24622
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 20:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A28917E463;
	Fri, 31 May 2024 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Btkd57T0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07EB17E454;
	Fri, 31 May 2024 20:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717186086; cv=fail; b=VHuulkJbszc5+1enZthw4zPdG6ocXJ+Mdz35R/TK4Vy6U6hJlZFHOnZdqLmEvkZvp61u8JLonG9qJ8AwQJttPKLxujp81wuL4O/avPwl/yycJjiuihOYQhOOw/vRkI0fjJoj7WdRQFlhACzBBwhvsygQc9M2MRsCGoexHvIQS+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717186086; c=relaxed/simple;
	bh=zBhQLTB8WkCdF8qUKVSvXWqLNz9Jx/yhF1CF0QcmCpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=opwex4G6nz9V9pi5iYhnLWCGAPd4NlcWfme2/AAr0sgHNkB+qYtkfAgJyswHmuEJye6VnrhTgJ/uAYyH/qfjFfaM9DI5STtBaf/uz2iubLOS1cu2IJud+S60RV2Q1W9WdlyU9du72UHSl2JBjvMPuNq/Luz/e0V3VXb24C81ij4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Btkd57T0; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpaEjkigaQyQeqZbGYXihmZpx4HE/RELE+lOpxtpybSMq/G8LdfQEr/dRs729bfmUFY4+3YpAJI9nmyHbwnugME3f58RQOiIiEctNN5nzpB+WaC6mDBsSKda3tYsOZxSkZUgGo4j7DRZsIJYB0aMerV6dV4Bjw4rJFEz6KPl7V70ex6iU4pQv3FquU12vAGE77Muu0XnwT0s/nGRtGaxea/2X25nrVs6LHzoIZXjWGjaH6GhJ47tGUS7rRhEEgQTH1FwqPHSIM2j09HHRaRkjHNpxUzWpVo9IwrONas5qOp5HZ+RWHcWIhr6Vn+pTpjZFDfvlkEylyWWmhV6kgKYFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01YYcT/4NfWh0YHun2p0ZqrMm4xnTY2SOjGXZCbnC8E=;
 b=bi+zX8j/+tnyHy0FAyvG3karJFDiyTzKqjXhket/Lc9LAxiDJmQyvBIbm9RLXB2LMy+NLdfxFONZ+g2VXMlsnuzvP/+cLQFLZ8A0VB0pUhK924qqovB/w7dJSdk7cBHqlHjspEDAlSQjlU603zJLoq2spoTtoATWZBl8/pMW5TeeK70ZZWaxWzAV2/xR+iNFski6hZFV4NxY2UUoirx0SrbLk+b3Mxa9RnVRqAEWZNVmGjv58bMJivyv5rhjC85VFkAfbNxil+nLC81HAWZRPQ5tJuvuZWN4X/d3bU6ABBbbTIl8mNmztW2XiVLHk/xemyUp5B1XYSBkc6TqkQZ74g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01YYcT/4NfWh0YHun2p0ZqrMm4xnTY2SOjGXZCbnC8E=;
 b=Btkd57T0Nns6md8EEdJ48isu/ZcaRPj6jud9wFw4+t91+snx69gwUSF2vBYlzqbwwyPvFi//T5suJI0QUchnWvYNxd8W/qGZp+aUl0NUt4Bp0nMDf3Neizrj4Z5Eyra4/OLhYjBwmi2rzGO+IfdqE6uWtfQtEMvZ8YTCogtRPrQ/O8a24VPPawXudw90iFmDOIpJ3ATvnD6fggbCdLCqyZahtYqoog/OANb48CbZW8ToQYeiew53JnbEjp2rDJ7HrvvlUUkZ6UhTfpEZZuD4GJyUHD+SDuBK5RZkaDYiDdYfDr0t49JGSqIZz9NZEsI4ZfZzkixPKi7JUca4tonXPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CH3PR12MB8880.namprd12.prod.outlook.com (2603:10b6:610:17b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 20:08:00 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 20:08:00 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Edward Liaw <edliaw@google.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	"Nysal Jan K . A" <nysal@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 1/3] selftests/futex: don't redefine .PHONY targets (all, clean)
Date: Fri, 31 May 2024 13:07:53 -0700
Message-ID: <20240531200755.128749-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531200755.128749-1-jhubbard@nvidia.com>
References: <20240531200755.128749-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::42) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CH3PR12MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac63a3e-1f52-4776-3bc3-08dc81ad5ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mlAD0H55Q7UYcXGPBnLpS8WkmMY323aYTrIxUJy3awEeOZ0QLyLkiMd7BT+P?=
 =?us-ascii?Q?m3CwT7IwsGvl7OHyCM0sKVI+oM7yhpMH5uOEKm+WaQ9zD9YTtOH+CHVHCa0/?=
 =?us-ascii?Q?pfTHbqKq+/ixFFP6Gc5v//5bqCWMdyBYrRY2WVECUD1/fjjQI8ZgrLcyBRbW?=
 =?us-ascii?Q?CIoKvby+M6kgQxOrzH5Zqnn6lXNM+WQ1a4eOZS9vvcF+BR9YcRy0ZVUFrLRr?=
 =?us-ascii?Q?ibU3Y6LzQeYakF8NyQI+P2SzuRrURmcK4fLIe8cPre88BrBNFWtkEB05+w3H?=
 =?us-ascii?Q?15PkPK4un6mydf+fOvjRlD7vlVwjyPDhlcLjp02dhvCkYeIppdnD+o6GVNmH?=
 =?us-ascii?Q?M7rR1LM3nmmGJGkprkf4JGCCGoWZP6EkBlwGQZt6pZtnj2C31ZPTqgjmvabV?=
 =?us-ascii?Q?rcpTuA+yb0B9n7VRVQNL06F1shRewbDWqxxIlZk+gzWTeYkYuh41jrRih+j1?=
 =?us-ascii?Q?ZixpruuRKL2EyTXXP8LWDeN8C0gKcJrAeJYwRezesi44TgbAX6O76g1MF8vE?=
 =?us-ascii?Q?qcSIebphZmz5xqtSjiR9+H2AHW7AkLF8NomC7S8L9ElocZoBKeHhIkT6W4Se?=
 =?us-ascii?Q?iPy7LuUgBOdeK6C0NvRacEp0EoCdihahVUIkcJnzc710vGPoYbf7/c2ljmDm?=
 =?us-ascii?Q?gEMYgCJtqwi6upVNAA3194Ep00sE3ekMq4Q33QyCO9hfpGJbRQ6Ap5K+HabW?=
 =?us-ascii?Q?nR8+7HrmI46Q0S8WaAu6DpJSjuTXBK3leZhCeUEPqRhAShd1mU3bwEJ3A8xm?=
 =?us-ascii?Q?eIDQGlNmSvLOrMC8TRfpAospuZtLgDpl/CMyGjQdHTUxOiMmOGGOoZJD51+s?=
 =?us-ascii?Q?PnMAALKA5oF5OoT5ur87C955fkMyzXvJ9xki76Q7d1Wll88Rg1TIhuTueWWc?=
 =?us-ascii?Q?c7f7NAPMT/U+l9/L+BtSVG9fjIdVWl0HljEOMGTIxYcgwYdnHTEkjCaf6WcV?=
 =?us-ascii?Q?iZVTDF1MS+r8Mem1oaG9GYbDtl0fgkfP4aWD5bsNBTBZnXURu7KqUBF87n3E?=
 =?us-ascii?Q?ptdsu5pK1yvOp4vM7C+jmSL/SQH3b4CAb+5eHXsgNnoWrbMja74Hh/Cj/Je6?=
 =?us-ascii?Q?w+Ys9I/pnxAm3z3aAjP1cbABvtB0sjxFD+R7T7oBIzG0eMFpk5mlQDuGOP1t?=
 =?us-ascii?Q?7aVcY7JjsjBlCk010DoJ7JXFrK4p5n5fsql64lbB9UwJmyseYJfgKmQaZEcC?=
 =?us-ascii?Q?9R2G1gR+Obzgx9rEH5wVRbErzILtI9OOG5FCl/m7nwA5cMrXVaUMwcLCPBoA?=
 =?us-ascii?Q?y1kqpzohodjEo1Qv8mraJnZKUOJWvdeTuYhax2uPVA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cuusBcxMl3AY+61aX+9c95fGqvayq3KDvVPwyqNQJFVvPcC8OZ4m69jIJxE5?=
 =?us-ascii?Q?c4iOlc3ePLLrmfFaM561y1n7K/y3XWoGPN996/QOgXdW/E8Ax/ebzQ+/ouS+?=
 =?us-ascii?Q?GEjl9dAvpUuw77E90Ku4qzy0Se8Gqy2KoLDKRlm6uBcoXPw2ZW6KmOdfVRXk?=
 =?us-ascii?Q?yz15rZXXGQ+VjtZzjOWoHqowrw3Ln3PtZex2nDStiF9v+inHJiWJH5b77Gvg?=
 =?us-ascii?Q?UpUBrlgiK6tBQ4goy2m9sdPgGRhaAMSio/3FId1pH0bp+SlDhjbiESbcP/0P?=
 =?us-ascii?Q?Rg3YK1wSEVe8rGlLQsXXQce3wg3RJY98ZdpsipM2T7uKxoTajIR/YNf/t6VQ?=
 =?us-ascii?Q?LUW2buEqx2fZZc5/XY2qC+7XEW8/H14141K6qrlZye5+JIrDFFRrC6mL7qqY?=
 =?us-ascii?Q?1yjDTxPs1YCTvUa/hEivuRm3hlND8oCwVcy9BqofAyV+w4E0q+jDj99oEXoh?=
 =?us-ascii?Q?DxIhP72fmB17gAWmCXGWZJyYcKlMPq/z9VjQECreVpqKEKt0r9jG9zrzxYtG?=
 =?us-ascii?Q?EJzHBK3N35t0xyDzlxq0IhTR8VawnIsl8U/vv7zVDbCSEg3QIixO0zb/gon9?=
 =?us-ascii?Q?t3TS3OWQcm4bWpXmhkR9RBvpx6af1WPQiSskgcpImhKnMOjCrbVaKia0QFtp?=
 =?us-ascii?Q?uF0AjhMRl47BCcjl4I/XVXTvkko/wl2NlvL2pmyB4idk3ka+ceIjpCxi5Ic1?=
 =?us-ascii?Q?3rty1gR7ruuRmjRL5Z242MTlo2897vdm14va/YQPPqkmC+6MZmPqE+ddG/5c?=
 =?us-ascii?Q?Rquod/4PLVl17h6KlzzlmCe9PIdvlydVurhgv5jqcFb/fmhM+9EzIFXUy8w8?=
 =?us-ascii?Q?5D5EF0nGNDb04EBBw1PsfJyd7LaaqcZUygxT6ItGJBFl0ABl1izb+4R2CQPq?=
 =?us-ascii?Q?9i7H+TEOAi832yFTVC/prpgcEMFJg+4fri15DSjCyDm/kEYph+P6SwT/NrZB?=
 =?us-ascii?Q?dTIIVhiBI7s3+96PmbFRco+5mVN1ckmwb+xQvBxoawlMEBeAEfFEzUbKPMTc?=
 =?us-ascii?Q?gjV7M+2ob3kax074ScaDq3ZzeFDaiwwy07im1mCsZJxQaNvUKwpUH11WFdlx?=
 =?us-ascii?Q?YlXoUJZGMxT5KDwPewZU35dSuj9Th1rAngo0oZqBRzAqPHlNFhUmR/gyz/ir?=
 =?us-ascii?Q?UxZ+Eupo+UdQUUKYdxjfuHfR2NeFUCs6e+bqldYmhBK6gT7r4TPFGDhV0tWa?=
 =?us-ascii?Q?hDCtkx/GvGp1RS5LcK6WVE4NwgL5xAaj0ie8ukAPYITooJN1fdM20xY15l2k?=
 =?us-ascii?Q?gs1NMi4CZ9iLnEHmKIg8c1muXvBMjcbwh2JV/VJl6MkxvvdM/2StDH6ayLaR?=
 =?us-ascii?Q?/t2l/fZHZGIHYs/if0xHn305HyZPaspLxVf2LtuHzpsErPvRLr4qGziXi+zC?=
 =?us-ascii?Q?R2RSJCMI3wzgb9ALWM5LdCXjONQeIFUSFsT20Icqi4hGENa252rRbCHhgHhI?=
 =?us-ascii?Q?b1wEN02+2xPqf3pfF4iXaUyTYspxlyZ5GBNNYDSZw8eGPNsYhlLHIunaOXNj?=
 =?us-ascii?Q?6Yaiu0HF2/mhimge6m8b3jwTy3T9vcJWcOy2qFezaasWCa0MH8eHmdlV7U5Q?=
 =?us-ascii?Q?qGCkCYSWbMz6GT7AVklHnSI+NEq8ckDdN/KAeGKh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac63a3e-1f52-4776-3bc3-08dc81ad5ecb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 20:08:00.0201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+yZVa+3YVCCDo1hdRtyp882JZJX8EyvZ8mzOCaJ8m9wnw4fXhAunoXhX8qbburY7ukcLnXq4Khvfme8tJPG0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8880

The .PHONY targets "all" and "clean"  are both already defined in the
file that is included in the very next line:

    ../lib.mk.

Remove this duplicate code.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/futex/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/futex/Makefile b/tools/testing/selftests/futex/Makefile
index 11e157d7533b..78ab2cd111f6 100644
--- a/tools/testing/selftests/futex/Makefile
+++ b/tools/testing/selftests/futex/Makefile
@@ -3,8 +3,6 @@ SUBDIRS := functional
 
 TEST_PROGS := run.sh
 
-.PHONY: all clean
-
 include ../lib.mk
 
 all:
-- 
2.45.1


