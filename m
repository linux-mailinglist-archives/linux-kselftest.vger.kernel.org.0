Return-Path: <linux-kselftest+bounces-12110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF3090C1C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 04:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229012835DF
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 02:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF781865C;
	Tue, 18 Jun 2024 02:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E43is4V6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBE58480;
	Tue, 18 Jun 2024 02:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718677473; cv=fail; b=iuwcNWi6ur7eaVzvLo+ppwhsnO+mJMme8pHP6qBNqQcDXUwSD7CkQAIN0TYs09fdcbJ/wj8xbkgVZR/mL4NfKC0PZlFjemdIyhB/QOJR3gTFqRYvS3lX1yxJBoOmVv36lyoGv2JH2oYguYm1uPQEuxLIRlq03s51T9MqqKnxw2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718677473; c=relaxed/simple;
	bh=3kKU3Iv2MQSLs9RBBYp5JmIGopyG1qeTf40HgZdb4Wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kLjQvOjj0uIQ/lk/q3El6D06/cedtfwieqn8QnH3rD8amZYSbf9xIMYXtBFYw8HMEPNHVGBYa23ftHlQIz4XhpWIpbpsGNizr+NvcGxk7/lqH4VBJXxdVrLKKXjIUzsp1dB4EfIrwiC8DGAYISSpr/2AOGFYap7zlczCdXMIBaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E43is4V6; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTaN8WEoWmx/e73Udx40q88mLJrC2XbtkY3drhV5281X3bam2JWlHOHA7oeExtB0kQBKhP0wLbqETLtCsJSCLWvAFyyRNPA3PPPkA7CpxkLgt/AWWwWCxNKeWYmEKgkN2jK22h5kGkTUYRZR0vYzyBMICImpACe0JDcEQwNMDFcnss0NkCFgU06PmPj9rQ09U7zMs7crYctq1ozSfF674Wi7nK/3BRfLjOxOTAxHkrYVrDKDBL1W8steQy2HstiNWf4pWW0zGXqXUQH0LdjUxLZnjL2RMtlyrQmkTpPEcWzn2BRWVG27eAPk/Vzx1h8JpZz6vjMJTdGDVJAK0LlrbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8HvqjHRkzHLq+KJUf8MEmS7IpTqRMglnhAc5buWyAE=;
 b=SP0XQWUiOQ0bF3QxDtwycZ1aKXTA9RTYWetwElW5opJ4nDk92tNU8X8WVk563HppjOZL2R5CNniCXWZtPNQiTqUOxLreDP3qn0dhlZubETKURuonAGalm0Xa9WZkgVv3cuAHrnrmJpamNDPjZRU1o6dW2DOPNLI69Y1ZHgBECjzvpxU8rGiQToJtljIgwCziZiAqVBEhjD+Y5sqgLycwkKLC2NmNN9fCcyV68p66d+eL9EmCb8m+XeWkioswnResOTvhzIK7E17dLkJcPNqGIpA7CG/k4T5TEI6BoBNtAoIVES2tvHdLFUq+FSMbGJ9y2+s1ZXuThSe6RJefdB+fOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8HvqjHRkzHLq+KJUf8MEmS7IpTqRMglnhAc5buWyAE=;
 b=E43is4V6/fxnwUDD172fzM6HD2rfXP0UyPYecifbxslEa9QhKa9pJQrOTUzTjGeR+C/lSin8tDLblGOcz9/3YqjUB9lB8rYLZSTtHnMJLAySxLrzIWV35xwpkl2+za3i+uBh4WloAMSq2eEPi8YouRJMXsPAFcFxx10aP717XHTgALQ5y8eKGfGWt9lUVZzgLuljgOhl9rudM8Gwqcx+IkdCZI5L31vAR5SOLS0ue3WozYOLUO/6LSGvj/HUIys2NZ203UClrxQYh4QC4Cqa5UdfMECjaD8lFXSg3CL7t24/1gHRQaSwBMTD2w6XJ5nPEfPZviYvx1TTnocunEzFDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SA3PR12MB8047.namprd12.prod.outlook.com (2603:10b6:806:31b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 02:24:25 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 02:24:25 +0000
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
Subject: [PATCH v3 1/6] selftests/mm: mseal, self_elf: fix missing __NR_mseal
Date: Mon, 17 Jun 2024 19:24:17 -0700
Message-ID: <20240618022422.804305-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618022422.804305-1-jhubbard@nvidia.com>
References: <20240618022422.804305-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0019.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::32) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SA3PR12MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a0e7556-e47c-4d52-283e-08dc8f3dc579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GAkBOa5I7P5d+Lb6nzdje4PjhN4b+ZnA8ohQzn7dUQUiTY16XPeZH3vjI9qU?=
 =?us-ascii?Q?fk7H5+nG5l588bKMXiqBbi/B7CaDShB3Td9D5SMLcOvvUF0bbGOQPzqn+Zmz?=
 =?us-ascii?Q?1Hx9CfP+NO/fM+o50IMTtQA7IBf9rvNzSQja0Bf2ntNeTAMMFtxr8477WQl7?=
 =?us-ascii?Q?2W5nEqoUnNQAfJUxyUHf5uC+Eu2pcXnLc2urF1ORsVQ+iBFfTc4p0058N09R?=
 =?us-ascii?Q?XMzIEZdBqznrIAjYSU8+ziPyTU4NQJfITonP8fWPreasJeYiHei7di4L6noV?=
 =?us-ascii?Q?JaQC/RP/V8EXfxneptycHAi5DalXAuNwGyA6u/PMq05ZAzZu+MIP0yfQXUMn?=
 =?us-ascii?Q?vJH0ZwDgzGmf9POONJj1FVBQaMk06KC9xOtcVWIXDTCenz5tFaLxoqq6wUjW?=
 =?us-ascii?Q?LxdPqeeo3H9ZoN4UJPkMZu0iGIHBfa+0QM63fX/xEXSRqsvXCb0UX/HvlQoe?=
 =?us-ascii?Q?d18Gk6IzFGHJCNoOIBKD3GmshoW4QwdZBRaVN1+HwBNZX6id/5JtRcNv5w1u?=
 =?us-ascii?Q?fm6auh32biGytHgRtPfZ/ME2mSStINIm21/P/gUG9MXxR+SebEnVQToOr2n0?=
 =?us-ascii?Q?WfrDGkxmq0YqkIW3u0/L2r6tkzblS1S9N4MnsdtIQF7TtosHEMMBY6p8V/Ag?=
 =?us-ascii?Q?Kq4QDs/QQYCd97ZVWdHHr8sE+L1J+25MdTZnOnF6Px4PNUTn4fSaP1DWmOCW?=
 =?us-ascii?Q?WqlB6ctKJyF9UP5i7RiPtmqk7OkyRa6K17whYmrFfNBk08ohHZ3duJ7x6mcf?=
 =?us-ascii?Q?7dszuAyJuyjju8YtdOM5li9nTAC6G/HbdU5O8hGXJyARIcBs7mhjHxKxzDQ9?=
 =?us-ascii?Q?D/wY2GW7AwbKcF3tIoA1Ncuw0aQKB3yL5JahfojKxCpqE/fl04BegqmIy8Nn?=
 =?us-ascii?Q?iLVD6ZIHxB43SIok1yBps9Lb1D9vTRMh1VDvAtVSPae3upBBVVF77KbuoJRV?=
 =?us-ascii?Q?VIPFEaEEIF7JFpHU/dq/eLWfu85DZd9Scu9rzwg4i0D+XxjF6TKDYcVfZig5?=
 =?us-ascii?Q?gXkOGPV5xT6vU58vjbiHvjqSDvoPFemngKxtw7tepenHcRA6lqXPy7TuXAQ0?=
 =?us-ascii?Q?9n0zulXC2pNYawKGdndC0yI7TjlTflyV/bPrZ3NdEYB2bM7uI+GWmpmCTYYH?=
 =?us-ascii?Q?XdEA6DScIEP8Uwyf6Rz0GViA0LJmebZOtBgPYYMPsZ1GNXtiWe+cgyTqbXvk?=
 =?us-ascii?Q?6Hw7Vrv1GqA4AX9QeFruyzCW1HPAdVwhWD7NMpPzTHh4fk9NTQNzOhnkd6Do?=
 =?us-ascii?Q?f/Oeu0mFc/UwNzu2CJFlYa3fEQPDU5BXZlovuGBlHiNlbsRTvQ/E4Ev5HxXX?=
 =?us-ascii?Q?P6PXM2fmhpyXJsIkoX/+rY7j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w5IkvCOckEC9NzwXJudFZwCYK0MovhTN7Z86fUGJL25SGv9BRNbs9EoepPC1?=
 =?us-ascii?Q?4Z3F4qvRAqLej/FOs/Q5ElmqZgMGX9jg7hHhJ9Jl7gCUhW6JfzRUXfO/9t+O?=
 =?us-ascii?Q?EsI3IWMtfRWyO/5oyfdheUiAycbfTjGkRhLOQ27/vBOorloVV/uJ8Cs4mDT5?=
 =?us-ascii?Q?DyAd55jyxKco71OvCd++vTUirCXMjI3G8gkVWwoE/dETIvje1XGRZBOviZmB?=
 =?us-ascii?Q?rmeJqgCP//eZlFX5eXHwZLfpnWwFR8KpYyrCuiSTT1gtl/pYZrmq+VU+OXOs?=
 =?us-ascii?Q?faG1SUFJ79dOosuWbwlc2aJ6dybn/LN2dphN6nG9hfu5PASicFyXmahfhJXA?=
 =?us-ascii?Q?8RYvbozNdXuNSeaVKbRXBiTHiVJtxpn28/CMAXq1JSJXx0jg0R6kpWpIQ3uN?=
 =?us-ascii?Q?r/bSL2j3oSNVWiDiY5SYrVIoyezvVCs4xovKNAbHpytffXz6Zl0vW9QT1plt?=
 =?us-ascii?Q?zN/ryLbO2tnU/JqJZMW5W5CKU2aNPE2ss2rW35eqDvLp0iBzwN86k5TiALRm?=
 =?us-ascii?Q?4kZCPLhEM8ib4VkNDQFFV8EdkPdNlr7bl9jV1nu/o6MsDms7gaUeFE2A3IRY?=
 =?us-ascii?Q?EXFPEApunf2y1SD8W0FGfiLX3IlurjUeTuvi9CSLuM6zk4F4jUFfvRzQHUeS?=
 =?us-ascii?Q?ROMr/Uf4CxaLJZUan0nKWuMg7RiLx7Dt2iwTPmBNHNXruUS/XnA3fjF1Xbvt?=
 =?us-ascii?Q?RaD1p8yoUWIreKFi8KA6WYfZosyYEQF2r5zaJhUB0patLSSHkMChaWVJ+JmJ?=
 =?us-ascii?Q?UiJMfxB2VbTOFDqHYffffFQnLRZyzAEzGOlPwmlr8ep/4SGIAJewDjfjmh3C?=
 =?us-ascii?Q?hgxDkyEklDk5FdOqjMKMhhGSuYMSPqhqU74koTcvA0p1mEzoZEFDHtFjDYaB?=
 =?us-ascii?Q?lEEt+VHF5e67jjbIIcRK5KSTnfxPvOrjCX0zgVJHR1zqceF4Wid4e0Ft1Zl5?=
 =?us-ascii?Q?srbfmMquwvuXD8EuFvNhCuD+f+bLIlLZWsOrynnyywX8lwl0zYddV0sTpNm+?=
 =?us-ascii?Q?I2EtUs7QYnONDmHPcTxmkZboi/imionhEh4q+mivgKZT4YeOOcFng/GokZ2a?=
 =?us-ascii?Q?huSsa/b1zD7iLP3GgndnD26xNn1UKQ8CK0uSkFuxFLf5l6p/qA+eUnWhlfcL?=
 =?us-ascii?Q?aqnCOWOFHnno0nKyFBXXVh86ruqA6oG5t2zKFJUbrW0T8eiMbvJitlOJmhRj?=
 =?us-ascii?Q?5k289uCwL4hv7JsMpC5kvQS2eZ82y3G/dWcfOjg7kDCVH6CvSce6ovRV7ZDm?=
 =?us-ascii?Q?bfUssIRwtDIplcJs54om2sySX4LrJkkL322bks4pkp3Iw/OjZzjEMPXNAZdM?=
 =?us-ascii?Q?HH1+Bo/c/pVnirLL5g5XVJrpc+9v8Ybf4LDizLqFYZkt3esa6y0bu30lGT+a?=
 =?us-ascii?Q?0fuRNZAARplPssiTFQbmi7xEAyI/POCGjapJK/f9SitJu7AhY2Y9QZJ9oV7P?=
 =?us-ascii?Q?VXSCSDczMuCyEuVI2vVCq1NToLtp8S4QAatK8//NJRYXs/wnwafdJ+kfZNY3?=
 =?us-ascii?Q?4W66NehEjgGpeMc9iza7mgpS6guZ8ixZgiF/jyokyzQctbHDcP33A8c4G5ba?=
 =?us-ascii?Q?G71yJWIKtLWhiLdaC0gxZpomOKfZpolit3/RVWPl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0e7556-e47c-4d52-283e-08dc8f3dc579
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 02:24:24.9774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFWfrOO+sRi4bMjpfbLz6mt5M+lj4d44gCdhBZ5T8ZjZvsjoAHdKCvjx/+glUc8evydDY/FExAsaZN29+YPL7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8047

The selftests/mm build isn't exactly "broken", according to the current
documentation, which still claims that one must run "make headers",
before building the kselftests. However, according to the new plan to
get rid of that requirement [1], they are future-broken: attempting to
build selftests/mm *without* first running "make headers" will fail due
to not finding __NR_mseal.

Therefore, include asm-generic/unistd.h, which has all of the system
call numbers that are needed, abstracted across the various CPU arches.

[1] commit e076eaca5906 ("selftests: break the dependency upon local
header files")

Fixes: 4926c7a52de7 ("selftest mm/mseal memory sealing")
Cc: Jeff Xu <jeffxu@chromium.org>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/mseal_test.c | 2 +-
 tools/testing/selftests/mm/seal_elf.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 41998cf1dcf5..58c888529f42 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -3,7 +3,7 @@
 #include <linux/mman.h>
 #include <sys/mman.h>
 #include <stdint.h>
-#include <unistd.h>
+#include <asm-generic/unistd.h>
 #include <string.h>
 #include <sys/time.h>
 #include <sys/resource.h>
diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selftests/mm/seal_elf.c
index f2babec79bb6..27bf2f84231d 100644
--- a/tools/testing/selftests/mm/seal_elf.c
+++ b/tools/testing/selftests/mm/seal_elf.c
@@ -2,7 +2,7 @@
 #define _GNU_SOURCE
 #include <sys/mman.h>
 #include <stdint.h>
-#include <unistd.h>
+#include <asm-generic/unistd.h>
 #include <string.h>
 #include <sys/time.h>
 #include <sys/resource.h>
-- 
2.45.2


