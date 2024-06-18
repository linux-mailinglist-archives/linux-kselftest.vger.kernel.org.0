Return-Path: <linux-kselftest+bounces-12112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EEE90C1CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 04:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62721F2222A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 02:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF411CD29;
	Tue, 18 Jun 2024 02:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R9dQgSVt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BF41AACB;
	Tue, 18 Jun 2024 02:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718677475; cv=fail; b=ScYNMSri8/CWc5Zy4EgwVD0tqHFDBSszoTCX6ItwV9Nx8IdS168Wg8o0eX63DxF/130YgEqelnRBlc8oT1Iz52isQUy0yexY7hG4xfdtJGr1M5tJ+dMvb3mpKAZ37G8rOB0cEwu271CIbkvsjtBCWffd9yBk3kBoCXmcvZMCNMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718677475; c=relaxed/simple;
	bh=Q9yVaYxP8sXzx0RKf1BLOgepyfp91n2T58njt7eot+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s2gFm2O/5sTBa/aPJIBocSKclHUvL8kFVP4ZzT/eWuBE5kkhqnQ7ylk9BoLu1jFGlvQnEUWNV8cxQ9L8OHdbgkxI3QwoWkJ+7QmdUWlKQaMOsm5NpjTSLLKNovimDHJhhB3DbfEhjwO1NQ15Zq0JK5ZQx6f8Tax6oQkYGyhdiu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R9dQgSVt; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAh4RBpjOajOqryWUlJe0lQ571wKD2l9BV+/z9YG42/lwZdHC4hxG4+0ROVCSS6cPGBmh3HEB+BVaiSFqpXRuSiwT8cf9Kvgy7PvqV+Cn0uqtAvS3SkE2dKQ6Jnh1H/P9EUvukXbgSnCvci9LDVMwuHpRaAr2G9FTnrlziwjMD2ktPxbg/HXzTvNb8hoJTOOEY8JgsAkfXcDQ4uu938VPbS7Y6FP6VkREz4hDTNdJ6dmZJOu3H6abTzV3JAqu+vQfWWrUZv4XQPtVTZysy1bg3XmGo+r/yj4BnN4LHxOU1cyu5ePcT5vkPqXzPKNezzl0nR3qOKOYDnCcyTa6X6MJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lND8relr0oO4VJNIro7up2xxQynbvMNqIHPRAUyXI4A=;
 b=DgVuwnH2KY9QBm+a8kltOL89WMYCektTMrwyQ4Wvl8Qa/pLyWjdLPnzc+FQo1A5pgOPddbHxkwAzgBt7ssu6gSKohtnV/USzFBDtvCxrnaywqrDN62u2WQhRhDSt68Vs1TPsQaPwEgJue3y05lYSqZ3K76924LvpObkh9IucqgwrXatsPbGDj2zHDVvCbKv4OXDwOMf0qOgItpvzGy2mAZGu4Bo0UeNKfobhJZQgYtBsUcrPEsmrrEIzecmdBDR37ePLug/8QtifWo4IGLRWO1fP/zXNTU/uDvjN8goZ8+fJ+E/X5QrG9bcDYuannk4zo9XDWmYqmAKKqJYcx+CUDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lND8relr0oO4VJNIro7up2xxQynbvMNqIHPRAUyXI4A=;
 b=R9dQgSVtakbqUZJvgOFzVbj5nDb7vCpkXkyYnJGoRKdgnaQhY1Gk8LR5aUvzRU5ON1Cm8z1lm4YJwtzJ5pkGkJVDnxej0kwS13GTIApa6+h0LynIOqEgvpeYD9NUGw/s1RJ/D51RzVoMAyuyjKSKfGzH3nIaFYAbyU12dSTDjicf3u5dveQAo2A/2dlQHoKnGI0UvDVkYuGeDMWRF5hVdz+lI5EH9/LcyOg090RM5TRpJhm/T9qV3c9H3r22fb++yA1Y0m5yswkTasaHrzxXYDm8K2rvqaDE6O8AeMONG4YOAsblfKD0OD4JCGpwJBU2eXmvbNCT0SfIH0FbE/io/Q==
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
Subject: [PATCH v3 2/6] selftests/mm: mseal, self_elf: factor out test macros and other duplicated items
Date: Mon, 17 Jun 2024 19:24:18 -0700
Message-ID: <20240618022422.804305-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618022422.804305-1-jhubbard@nvidia.com>
References: <20240618022422.804305-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0065.namprd07.prod.outlook.com
 (2603:10b6:a03:60::42) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SA3PR12MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: c4fbb068-b541-45e3-185d-08dc8f3dc5ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rH5oz+bsGRghn1K6KkaFGKr+PSRDtkMlIsKctaViJq/3ZjyMTwgNqaifHn78?=
 =?us-ascii?Q?FLf9MgvqR82rc+C0KVosK3jwm2aWR8zNX9xibSOchPaJpw4/KmUFyJDlqaBf?=
 =?us-ascii?Q?ZEs2PcCck9a6Hex59ypfhZ5SnPR7g0vR06v/Oo7c8yjfBm2pIyNcxEBS8Fgg?=
 =?us-ascii?Q?wabrdexZJPjn9SlvrCuxWlb5UdL0ZiScr04A5FqAmJCH6fJnEzVB54bim7He?=
 =?us-ascii?Q?y5bkb/WYZ2fpNZhcZAb/+Ht7Tg0MJIMYcmM3bwG+Ufd3lJL8a4DINxzDZmG4?=
 =?us-ascii?Q?0HtjC7TcIb8QqAnVxg6x21XlrBWtqmZtqY7o13al9K0az4VBaEmEh+nnHcBl?=
 =?us-ascii?Q?efjIsndgO5Cz3m0R7+dZGTKEpX8019AO3nQwZ3glIHi10ESe4SZhJRv3aRHq?=
 =?us-ascii?Q?pHbleH3pkFecw8BNGG0M7WA54dCi3mW3nis+IMs3mKjKAUyEWtipVhw2XUkX?=
 =?us-ascii?Q?3BZvI+zRHz0nzBjerkaIKAyoaP9ccvwiVg+Z6yrFXlP4rZ74E1ZOg3ckYmBu?=
 =?us-ascii?Q?QJUPLLaEaeB88Hs43L1utxvsoMGc4oFfAmyeMm2e9rgeLpT118/WgFzqCzyD?=
 =?us-ascii?Q?LJQP9X8NCvTky1xdIIv74IwTYlcG12/WC+rNcSWVr3G8B/5sqbs6GSZqLXTQ?=
 =?us-ascii?Q?E7RvG5lFJOxCwmxlXKbLpIzu0ew89fv9D3rakdRKuKF+ngkvSI6ub1eCU0LC?=
 =?us-ascii?Q?seYyKsIYYIgXARqIKG+47bbkayjlj9lhr3ptQZKCctT9GQCBxA6wkPXHJG2C?=
 =?us-ascii?Q?4tbeBLYtCnZ1ymXU3hZqZOZ0nOvhtUHxtA1gn8lep5UY7xQJQzjCnPRTjwRe?=
 =?us-ascii?Q?Y36vY4z5TFuRiBE7V3LK/xVuJNz5srHgrVk7IFvg8742q95bcW/wtq/FEoZL?=
 =?us-ascii?Q?v6Wl7LAphiQ0oIREbMCDB5ItuyO6Q91zu0x4yWyjJc77SI2rv9lW92qIOGD1?=
 =?us-ascii?Q?w66peb/FMUoRSPoe2ziyL5UIJHtMykWqfYKj8vU4kr0dFS5q6WkG0ryj8o1N?=
 =?us-ascii?Q?Ut06wvdunwE7xO1x14khQ/DujkDGGouCsYCmE7bKL+rmLAK5+u0+kGLbzNQr?=
 =?us-ascii?Q?s4u1sbBXowuUnqy0q1S/uTQ7RhZKMGgpx+eLbum3xQ/0BhwgGGf17LsrOLuF?=
 =?us-ascii?Q?v9hHety01Dvh1QCquL8g8UNWxymQMC8BDWpePw4p08JlQbts5sMVxIwraKnI?=
 =?us-ascii?Q?ouGB8c53ss/qdKI6obi7M2m95K+XmWXfmv6pfSb7J20gDY2NipaC+Csc+s6o?=
 =?us-ascii?Q?SCZ8pEkh1ks5ZIr8V9lbiCBHefJY6QHEE+KCD4KHbEUOIkCuX8byqLz9WcFo?=
 =?us-ascii?Q?Q3JIYU+/L0wdEmAymcxTIHjB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HPiPbLStyQDMFAXkQXxwHFi8L6+PZ0bBu7vdN2IoOR3YeDSxDGpE2Xyf/7ub?=
 =?us-ascii?Q?ybBL+i6hkdWm8UI2jActJDdWnT6FkBM8WdJn4cXG1QO2h9iBeKitOM300Obz?=
 =?us-ascii?Q?lQr+XsdLNMM8NushrIpNjBqv81wi4gzJ92SsDGZ9pKSpB37F0ywx/dUKXN2n?=
 =?us-ascii?Q?Vc+ah3Rof4T2tMexVwVZbcRyXWVHYmFAB8b/sf8rXGXZS2V0/7orbTT5EnWx?=
 =?us-ascii?Q?kdYwImUG5m3MNC5yXji27IPFBV0P8LBsaSWXhD+newmOZlRUaDo9eVAbXIiO?=
 =?us-ascii?Q?mBsUfG/coIRrTip02VN0JV7qsCuiUnaTlAkShhWk4VR0Wjqgx3/ynK7TaJhE?=
 =?us-ascii?Q?M2MOsOagy0oHYbphVBplhKI+CnUgWuLGivurNxrTvt/h9E0Kfx9IXVv072z3?=
 =?us-ascii?Q?jwlxZfbhOYjq/aOo/jfUBwPU3df9tW3Y7H6MTW21icGXk3MI2K9NuyeuY96m?=
 =?us-ascii?Q?F0kpfJIHpXbErJwiPE/u0OBr2kCzFw2xNtN4NIUc7ZeFkv1q7d7a3/LueZ72?=
 =?us-ascii?Q?VypOb9zZ/nClGcImKt6O1hOxa5OLaltwVqveQotmaxL9LkU6tXjPBT1PhIKQ?=
 =?us-ascii?Q?9e9D5UK2680K+U+97aOwkGRdUSqGSAIVw4waFCjDi1AKtcNNC/KlIefnk/7j?=
 =?us-ascii?Q?eHFZH8iTMvyfz+ZwqsqAwh81JaDlUmtuVPUU5o4xQiHY1sNRDLjfhro8g9pf?=
 =?us-ascii?Q?dXyh7b4fsXcw+tjTVpNpSFB1Sb/DvDrivBtZlQ0su77PgJ1rtZvXvmYFw8Rw?=
 =?us-ascii?Q?KrHBoflrWy06JHocetLngCkJBI1lJEpdQXbLghNPhdCmI5Mm7GBnXZPEpVky?=
 =?us-ascii?Q?yo+GDTH6qmmPk8SVNLqDlT7wJsfW1+g2FSNuHhAvP/luNbc8MYxpgw09XBJy?=
 =?us-ascii?Q?dqhzjMli4YSuBbN4VsLD2OxlWTcRZHnvtJ3nlrdy2SNrLWavsSGy7cXgARxr?=
 =?us-ascii?Q?XCgr8hpq0E5/9fW/ffRNUXBpm3UfQGM9bpPBBuWiyqcbw9hrxywCYNQmOmm8?=
 =?us-ascii?Q?VHy3hq6zTYH1bHovwanlPyPLWwUthYGDMT57Ueie1Fi+h34RwGj451YiDAM7?=
 =?us-ascii?Q?b9vu+kVDu9AXrTmSLbhKGdpt0G5fPjv2xRw3zL4qQom9v6bATwhIhw/ylaJA?=
 =?us-ascii?Q?l9x66PJzZM7dK607m14poiGhk++Jc4ekbGvmnQaBUgtxr+9ki3xiqkcSm6IV?=
 =?us-ascii?Q?dEx7Lj0V35fVUsBHpEYXBnQRWHlwVCcEb3yPYUqWwVWbj1USrKcFwX/H3w1c?=
 =?us-ascii?Q?c2sg4/Iid4nnQFTwfa7dlE3yySqe4cQ4lGbBgId1fJFgmfk3kL6q4FgJl+A+?=
 =?us-ascii?Q?LGPlLOdltD+b875cR7TkuPKbrLaxJDBtsx1rImNkElcDLa+ezmjxyYu6lwMR?=
 =?us-ascii?Q?FXXYDy2wxY42dwKwdyafRJTMuG44FyuYn/Rlnpml91dcvySSi9y66lo8p7wy?=
 =?us-ascii?Q?FMo2UGHUy88ozQOQbeepUJi6MhpMDP0qRe/gPtBPM97K2HHuZaeNDE9rz12E?=
 =?us-ascii?Q?B51OdWL/3+nzvK4OrJQgCye2kD21A6uBau4n6hKxBI04Zn6TDzcFL24Y50Aq?=
 =?us-ascii?Q?BZ08++/orL6S6dKWgOrzZH6F0vOmJJC7pVDNt9ph?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4fbb068-b541-45e3-185d-08dc8f3dc5ee
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 02:24:25.6826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hpid2NyCGtmihWlbSOO23pTZsVkOMeeIavtt9jPRtUzZCYa6M42QnqcHL/z3FAxBMK5lxlXdJmqt6LONPOwcAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8047

Clean up and move some copy-pasted items into a new mseal_helpers.h.

1. The test macros can be made safer and simpler, by observing that they
are invariably called when about to return. This means that the macros
do not need an intrusive label to goto; they can simply return.

2. PKEY* items. We cannot, unfortunately use pkey-helpers.h. The best we
can do is to factor out these few items into mseal_helpers.h.

3. These tests still need their own definition of u64, so also move that
to the header file.

Cc: Jeff Xu <jeffxu@chromium.org>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/mseal_helpers.h | 41 ++++++++++++++++++
 tools/testing/selftests/mm/mseal_test.c    | 49 +---------------------
 tools/testing/selftests/mm/seal_elf.c      | 33 +--------------
 3 files changed, 43 insertions(+), 80 deletions(-)
 create mode 100644 tools/testing/selftests/mm/mseal_helpers.h

diff --git a/tools/testing/selftests/mm/mseal_helpers.h b/tools/testing/selftests/mm/mseal_helpers.h
new file mode 100644
index 000000000000..108d3fd0becb
--- /dev/null
+++ b/tools/testing/selftests/mm/mseal_helpers.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define FAIL_TEST_IF_FALSE(test_passed)					\
+	do {								\
+		if (!(test_passed)) {					\
+			ksft_test_result_fail("%s: line:%d\n",		\
+						__func__, __LINE__);	\
+			return;						\
+		}							\
+	} while (0)
+
+#define SKIP_TEST_IF_FALSE(test_passed)					\
+	do {								\
+		if (!(test_passed)) {					\
+			ksft_test_result_skip("%s: line:%d\n",		\
+						__func__, __LINE__);	\
+			return;						\
+		}							\
+	} while (0)
+
+#define TEST_END_CHECK() ksft_test_result_pass("%s\n", __func__)
+
+#ifndef PKEY_DISABLE_ACCESS
+#define PKEY_DISABLE_ACCESS	0x1
+#endif
+
+#ifndef PKEY_DISABLE_WRITE
+#define PKEY_DISABLE_WRITE	0x2
+#endif
+
+#ifndef PKEY_BITS_PER_PKEY
+#define PKEY_BITS_PER_PKEY	2
+#endif
+
+#ifndef PKEY_MASK
+#define PKEY_MASK	(PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE)
+#endif
+
+#ifndef u64
+#define u64 unsigned long long
+#endif
diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 58c888529f42..d4d6ae42f502 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -17,54 +17,7 @@
 #include <sys/ioctl.h>
 #include <sys/vfs.h>
 #include <sys/stat.h>
-
-/*
- * need those definition for manually build using gcc.
- * gcc -I ../../../../usr/include   -DDEBUG -O3  -DDEBUG -O3 mseal_test.c -o mseal_test
- */
-#ifndef PKEY_DISABLE_ACCESS
-# define PKEY_DISABLE_ACCESS    0x1
-#endif
-
-#ifndef PKEY_DISABLE_WRITE
-# define PKEY_DISABLE_WRITE     0x2
-#endif
-
-#ifndef PKEY_BITS_PER_PKEY
-#define PKEY_BITS_PER_PKEY      2
-#endif
-
-#ifndef PKEY_MASK
-#define PKEY_MASK       (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE)
-#endif
-
-#define FAIL_TEST_IF_FALSE(c) do {\
-		if (!(c)) {\
-			ksft_test_result_fail("%s, line:%d\n", __func__, __LINE__);\
-			goto test_end;\
-		} \
-	} \
-	while (0)
-
-#define SKIP_TEST_IF_FALSE(c) do {\
-		if (!(c)) {\
-			ksft_test_result_skip("%s, line:%d\n", __func__, __LINE__);\
-			goto test_end;\
-		} \
-	} \
-	while (0)
-
-
-#define TEST_END_CHECK() {\
-		ksft_test_result_pass("%s\n", __func__);\
-		return;\
-test_end:\
-		return;\
-}
-
-#ifndef u64
-#define u64 unsigned long long
-#endif
+#include "mseal_helpers.h"
 
 static unsigned long get_vma_size(void *addr, int *prot)
 {
diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selftests/mm/seal_elf.c
index 27bf2f84231d..45c73213775b 100644
--- a/tools/testing/selftests/mm/seal_elf.c
+++ b/tools/testing/selftests/mm/seal_elf.c
@@ -16,38 +16,7 @@
 #include <sys/ioctl.h>
 #include <sys/vfs.h>
 #include <sys/stat.h>
-
-/*
- * need those definition for manually build using gcc.
- * gcc -I ../../../../usr/include   -DDEBUG -O3  -DDEBUG -O3 seal_elf.c -o seal_elf
- */
-#define FAIL_TEST_IF_FALSE(c) do {\
-		if (!(c)) {\
-			ksft_test_result_fail("%s, line:%d\n", __func__, __LINE__);\
-			goto test_end;\
-		} \
-	} \
-	while (0)
-
-#define SKIP_TEST_IF_FALSE(c) do {\
-		if (!(c)) {\
-			ksft_test_result_skip("%s, line:%d\n", __func__, __LINE__);\
-			goto test_end;\
-		} \
-	} \
-	while (0)
-
-
-#define TEST_END_CHECK() {\
-		ksft_test_result_pass("%s\n", __func__);\
-		return;\
-test_end:\
-		return;\
-}
-
-#ifndef u64
-#define u64 unsigned long long
-#endif
+#include "mseal_helpers.h"
 
 /*
  * define sys_xyx to call syscall directly.
-- 
2.45.2


