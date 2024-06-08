Return-Path: <linux-kselftest+bounces-11459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288C4900F2F
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 04:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65EB283479
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 02:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898C0D51D;
	Sat,  8 Jun 2024 02:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cDBEEQxo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3BBBA2B;
	Sat,  8 Jun 2024 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717812634; cv=fail; b=nAqbO5yoRLmrkygnzDTZcYYcnQmZB1pxUD/ckz2FxvDN1zkNuhYuR4bF6IZRQr5RuNDGUiMYL3tYo5ssW7OwiPjSfBvLGN0a7NaPeyeOyJYab3q6GphZ3fL+db8y7yWyViiJhfYrcQjXU82n7PScnXMppgQh7DX9RnxQVVK2qKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717812634; c=relaxed/simple;
	bh=QvtB1loVAGwsFskc0nC5hPabySSxVEKKh4Q2qWovAKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YWEO4Q29QCP+epXOJsdZ1JOjED3Rl0//eHd6f7HjhZuifqz8akr7mpXixdyzoWQwqvydUxcHpc5/iWKG5kDdthnSuc6XfBL2+QRmLa9wb0BcXVLmzqgBT1mc9zNjJguDFojew4PhtzrrDyuM5lTpiOig2PxsHkTqek8SzDuZCm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cDBEEQxo; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrYZM7KYHtVcNtbQQdKshQeFGJE0HIGpKNaf2ksOiJoNQSlZ86z7Sh57IT+Q00icST7tFjK+fGam5cFMeQZ1AimayltTjPeTjottsgGYR0HkXwIr36jk5N67wVNaaTbuaZZLISTSDx2DtRrHzZfOTAGBfwUCtT2l5DZcX7kgZbbKY+CLzFc+fL5mL8iBL8NM06DIGsF0/CVtIOG7GBCgo0w6yqiOZHHsg+CQmmFJU/+AbP6dQ3sYZsnHYnin1fbNll0h6BagRdVdz8+WghcV7D2iIKGrujeEDIbE+10hyBe+vWqxVEe1A2Bb6Tb+ErvLHGxli9Fx1P7srJTPrRKGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXZfY0TcuwHIFCWojdHQyPgCzHtD2jyu75gGuiYghe8=;
 b=BXCNmMoZvNcF7bPYHxMjTEYrpVH2bsHnAhxa4LoTA7oMx5lCdVJ0JoiLAuSZdg7tJ8dqH4mF7eoWK3mW+ED6VLwu2zJ0cRs4mtvyXv8CN4tJtDSe+dzKkoOLklLlZ1ke3hrBvJBewsPI1Jwmru67pNYYvSFweUvNm0otZiUEKvO5EHwHzEkSe3kgOsWAxfylFCbew9aoOHU3wH1P4QqyeFp6+OQLUZOhQg1r57KoREGTdEnpF+VtEZJ8C5bb17h3jvgXsmuljX2Dga6UoZTKr/BNQZvhUitb4ghpFaM7Efp01erg/4Z0Z8TQe2HLM45qgoJfFL0k2tykBfxyF1J0xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXZfY0TcuwHIFCWojdHQyPgCzHtD2jyu75gGuiYghe8=;
 b=cDBEEQxoqCMLJ/hHyOcwCI+VE/DD+/wG4jTGa5tw5jf/0OKBy37hVMe0Xq3TBdi5a+DTCdu0PdVZdaXnGa/geWdaEWxnViN9PVYpWPL2MuMDTN1UDKhea1x6lzzerDaWy2ksTwArMKaEH8yNO/dqARjStl16vBkXQ2VkJExk0HJJi3ReQLpPr3+KhWc7TeDDs0mdz229N75Jj+3ostUITi9wBsVtpZPrku8zgzZeNXUqS4ZOEewESWH00Gvqgd3l4p82sQIA01Y2t+WT1iJQ833uEAvVTKAAkNNKRGfTB9WXJQZC3W1lkA7bSoWnRNNh0AFRtF0pFS+/g3XfF95rdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Sat, 8 Jun
 2024 02:10:26 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.036; Sat, 8 Jun 2024
 02:10:26 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jeff Xu <jeffxu@chromium.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Andrei Vagin <avagin@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Peter Xu <peterx@redhat.com>,
	Rich Felker <dalias@libc.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/5] selftests/mm: mseal, self_elf: fix missing __NR_mseal
Date: Fri,  7 Jun 2024 19:10:19 -0700
Message-ID: <20240608021023.176027-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240608021023.176027-1-jhubbard@nvidia.com>
References: <20240608021023.176027-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0123.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::8) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d6ebbf-5e89-41a3-922a-08dc8760295a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?22cqeRmmXd78Vy82N8Ruj8Gu3Vn0KZun/ZH2R/qTL+afJeulh5F2VybYVpc6?=
 =?us-ascii?Q?Ku0J0ywyn9E3hIlQ2Qsm7NFsZ0aGqPM7YkhtOvSCgUJqa13Jf8X/Ph3tXMUA?=
 =?us-ascii?Q?cadYegabpM3DVn8F14D5RhWDG357d8vPvWu0EOVR1sKgeLFxXd+LkNIO574R?=
 =?us-ascii?Q?NPZSyu9f1t+XYVZ5e6PE1EtJZAFa8eXUFrdQzGX4cx2cwqNK71hQrG6kQgLD?=
 =?us-ascii?Q?gur0+eH6zHuWXIKcI7rEFR8Ne+nTkyZ3V2Nw/DeJeTqaWfYysyY6ZtRwaFy7?=
 =?us-ascii?Q?ScPwIY/hNstg4dsx4mDc4lLNvgsLQJEZ9A4QaLxurD/p9VZnzJZ/RFn39eYu?=
 =?us-ascii?Q?7nbfuNBWyWDWm/S2uXxyTOTP59dNJ+7+S3Yz3S4afmVZNyCuT85A0Ceg9ID6?=
 =?us-ascii?Q?al0RvPOUHv7D8CTnoLYc1JcBcHM8lY/mkf15fg73fgb5RwuPNMpjxvdYL5t1?=
 =?us-ascii?Q?mKzc5OP30tR+Ky0g9Q97fch65oInNb/dqS4cZejTihPyxGJZL/4uJgFfeoBN?=
 =?us-ascii?Q?qVlGA4PXVRv+ghd2T+NEG0mlqfHfbdDWze9UBIiaVQ2JhtHOJLwHZQ//6L3c?=
 =?us-ascii?Q?NlIca3oMpKNaOyy4nG9+9sXlw0NlCudh02LK/BQONX1ASTbHLWTt8Lp+ndHz?=
 =?us-ascii?Q?AVJEwf7COF+NtlfIReDrNsYNGWTNlqHkrbZOv3PPK1xx6f69+MRBBwrc9SzP?=
 =?us-ascii?Q?MI79zTXG3vDXctSdTcSzrLet1kPo0cEF+VHF6VEY8owNXDE/fRpIgSERWQW0?=
 =?us-ascii?Q?7HVOBrrVJVBwsIYRGzBxjEnCpu7eGB/DvQc9LIXPeXAH5d7hAeXaSi3d4S+t?=
 =?us-ascii?Q?WCNYsszaYr2MFb3ZN9+H2gaxdjMoz2j6PhpEuXnPadfVyOHS5zAoXDTsgbbt?=
 =?us-ascii?Q?TKaDWmsrIn4xC24bzUIocGULYHulJGVAWS88PvpG8ccVJt6B9w0FH33NgHfX?=
 =?us-ascii?Q?fR2tQDTQ1osC+387i22VTtjTOGx223HeIn0KSD7YqhFDlO5WrgiPYhh+GUKw?=
 =?us-ascii?Q?TdH1aWOd1akC7ngKsauOz7cNTfqWHi/QbLsDsaHmCpj+qKKMI6QUm3hCr/71?=
 =?us-ascii?Q?YdOiuB+t9PfGs+XxlstD3MZd1e9C5lwn4nF029S28mWpad9mmbxGTOFxRFAM?=
 =?us-ascii?Q?4pG6S+V5DtdEgvLYu1QBVIJExcmWwlkssMVb9iwRrCuh83Jec1Sg2RYMeydc?=
 =?us-ascii?Q?dXywN/i9cO5DeNXqvOr2Qag/t9SHG0rSxd5MqOoVMDfhsItFVgWb51/oklBJ?=
 =?us-ascii?Q?QTN6pJvy3L3bO471PyYPwdZrrhSI5lyL8ejZNSEy++R25QJWA9wZNv6Rg/Dq?=
 =?us-ascii?Q?Qr+UQZJCk+OR5WnPptzL62+L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w8r5ksIOt68PyACMRIly7tQfNn4/x73dlkcGJXw0yoUiKB3r/nVLcRQlfzmR?=
 =?us-ascii?Q?sIgzVhM6k2M/6mB7rXzJLqdw7QBmd3KCGFsOJpP0jbre6zbMvENwPJNEy0tm?=
 =?us-ascii?Q?vi3IAAEV6Ak8nFtShPYDYFQfcrZ13yvG5wUEW+Gu6S2FT08evEz60lEHl87h?=
 =?us-ascii?Q?qkgDB+cvLBryqxGFHq075rA/Jk8oU5CC+kZiSgxHS6mQMXT/J9zFXJNs6HQn?=
 =?us-ascii?Q?7kekeHX7ylpGUDFMfbcqqfamsfg7e+Xz3Ba2Rpkbv/WpJ+kWf0n87jZMeAJU?=
 =?us-ascii?Q?5eBe1/wSPzguzzQ696O8EMYNbckWUkD7NDoOX978MnINkSFhT3RUBLkpiLRz?=
 =?us-ascii?Q?gLIa1TogjYpUlqMhKgW282nLkgt/uWqOD+AO/dB/9PNY2oHb1pmSDyJsRDT2?=
 =?us-ascii?Q?8RFhVU8Rl/ENVloYCBvz9GEa/V430zmQD7x6ZbCVuoPwOyAzdWDn+bZuT1Cy?=
 =?us-ascii?Q?WHFgvmZCoEyqX8pd7QAI+ZMv2mam8FNah5h0QAF4B13Ovvota38d7QRRRB3/?=
 =?us-ascii?Q?tSApP+5AuLUF5UeAn35wBihI0FvtnSEtlLMc9Db1uBTet22+ZcnyKsMRZ+I+?=
 =?us-ascii?Q?9ah3XdOWRBDP9vXIMx/XVfZQpq4/RpFl5/XSlBiGlzHRWu97h/9ej6kLRtQ8?=
 =?us-ascii?Q?hiI01ePLt8VYI7QfNcGK1LsKxw4MyrFvNoY0Q0eptvgyX582/6Jn25Uz+KD6?=
 =?us-ascii?Q?WFE+7WvzWG7DVtnJsGSAfiM+viO1uzUFq8iPhsNn43bqlLw6XJ8aceNcx1XU?=
 =?us-ascii?Q?zk5kKJUOJVbtKlzIifi/nsZjLEbgn0544maxTXwFo5mRfS9K51GjMEN+JDkh?=
 =?us-ascii?Q?9+v2o0+XzUKmCFaRqmpgzq0tWmzRdli6+d9X298KHzgOVAkG2wNyxCCoXNhQ?=
 =?us-ascii?Q?vmJCJxEjXJc9KDCNg+oiYUp9iXuVlZSHQndCuXtqATF3y7sg3gvjeL/0rTki?=
 =?us-ascii?Q?HJgfTkqyHj8gRjQ4oXcEUOZA5iYRS0clR3O9pMyOaCn10JB6XNhI53CRWwtg?=
 =?us-ascii?Q?2wm0CHShrR0i1XwuzfU2rSUUEPIpTdbEc7NZ7pgwrKSizlILRJVgXd5gkK4N?=
 =?us-ascii?Q?FraYxo7AQi4FN0HQepRfxOpRzMRCWVpzxDr2+culnoPLXwvu4kRS2WVFj+KK?=
 =?us-ascii?Q?sOMfIRA+HCWT91SsgSKKl8YFIRNxgGIXfD8oDr9gTQ7lLvmx6i2oBf8voQuo?=
 =?us-ascii?Q?LwWK5JQaAmVvg6TREFfPfglTv7VBA/QGrJkzcGxB4Okl4k9mN3G54hCELU/T?=
 =?us-ascii?Q?MNRr2L/s8seevUU2W4OrH6ym99G2a0BqNaTuC+81Ta09wF5Pk3AIoPPlqV1G?=
 =?us-ascii?Q?uhcZHaoRwngBdszDILBDKWr/zwiQJp6+HZH/gix0QEy353uEovOgwmuLwBM3?=
 =?us-ascii?Q?0Zv43sZ2XmgXamS76AtDqO3Bv2d8gEPXXp8lOf/WTo+dVMpNBtxBEU0CQg5M?=
 =?us-ascii?Q?aBnEF5abeagoFCTZnVWRDte/7LUOEKBKa5g5i6aZns0IDZz8JMeAiJWqhO5c?=
 =?us-ascii?Q?Qf5LiLxkX5p7C0rUEG6ErqCFicGO42DH++iRPZRqZxBXHkUKUyNlD/Xi5Jz5?=
 =?us-ascii?Q?xxn3he3swuxMIaZ7WXz/ponKeRmHXk8PQKc2l3fL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d6ebbf-5e89-41a3-922a-08dc8760295a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2024 02:10:26.1187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xTGPuunX/zFm+DL46ptsb/QWBaIIUcu6VW7z2wqwyIUETkEy0DUD+lZ2BP8HmaGLvQvDQDfkCbMaRMYRDcwUAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196

The selftests/mm build isn't exactly "broken", according to the current
documentation, which still claims that one must run "make headers",
before building the kselftests. However, according to the new plan to
get rid of that requirement [1], they are future-broken: attempting to
build selftests/mm *without* first running "make headers" will fail due
to not finding __NR_mseal.

Therefore, add __NR_mseal, to a new mseal_helpers.h file. That file is
small right now, but subsequent patches will add a lot more content to
it.

[1] commit e076eaca5906 ("selftests: break the dependency upon local
header files")

Fixes: 4926c7a52de7 ("selftest mm/mseal memory sealing")
Cc: Jeff Xu <jeffxu@chromium.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/mseal_helpers.h | 5 +++++
 tools/testing/selftests/mm/mseal_test.c    | 1 +
 tools/testing/selftests/mm/seal_elf.c      | 1 +
 3 files changed, 7 insertions(+)
 create mode 100644 tools/testing/selftests/mm/mseal_helpers.h

diff --git a/tools/testing/selftests/mm/mseal_helpers.h b/tools/testing/selftests/mm/mseal_helpers.h
new file mode 100644
index 000000000000..b922d453a014
--- /dev/null
+++ b/tools/testing/selftests/mm/mseal_helpers.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __NR_mseal
+#define __NR_mseal 462
+#endif
diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 41998cf1dcf5..20949617a036 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -17,6 +17,7 @@
 #include <sys/ioctl.h>
 #include <sys/vfs.h>
 #include <sys/stat.h>
+#include "mseal_helpers.h"
 
 /*
  * need those definition for manually build using gcc.
diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selftests/mm/seal_elf.c
index f2babec79bb6..4053951a535c 100644
--- a/tools/testing/selftests/mm/seal_elf.c
+++ b/tools/testing/selftests/mm/seal_elf.c
@@ -16,6 +16,7 @@
 #include <sys/ioctl.h>
 #include <sys/vfs.h>
 #include <sys/stat.h>
+#include "mseal_helpers.h"
 
 /*
  * need those definition for manually build using gcc.
-- 
2.45.2


