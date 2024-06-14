Return-Path: <linux-kselftest+bounces-11909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1446190819F
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 04:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3A7284451
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 02:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2709183083;
	Fri, 14 Jun 2024 02:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RIFBUElG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB9B138495;
	Fri, 14 Jun 2024 02:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718332220; cv=fail; b=QRoxWFU3nAV6Bh/omfBh3o2oQVlIxOfT8JegfSuHG0mQjnriBMiCdZv0/DHJvJgvtFX0Dq2MCtx0Kem/EbkeHVA/XtrJib3E8JZVPzIDR/SOw4xllmonqX59Igtmsx6UqdXr8SgM6dQdMhori0ZG8A2UBnsumglILn4LNp/8Uz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718332220; c=relaxed/simple;
	bh=2TDW0nPDUC7dxg1i8N2caDS8VUqbVY1jqhl9ncG6rSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DEHMg9a5uwawJvOVWXZ4L7rkdBjQIcOeVY4zBQisY7Q6+3qvDVnnOaBe2yNnLmV/lJkeGMrU6dG9aUAvyhuzpDHaPz6qtXXeDcH909JijV5btJhYfghOrWSqcMTqpMpeiCklR9MDukwm3xQ0AM7QwkMsLJmG6va7fkJXSqTXcIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RIFBUElG; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahhm3SO59FFI0hWMFNbVVuzdzlcM+L8Ene8ZXq6ypw4VwEF15lwGMZiYgZ+V6e77FaviBvLF2mOMIQeJLlJZqYXvFi/kN4quG0eUPKCNhaLNj4MwWwpEJ+V0/vjeo2DGs+3T/Je7I+MiwYFbjtCiqLMsTxPD399t9lpRgEZ0RFhvXZIAhijWvBcOJuK60oUvmqKaYxxL14u34K/aLiRNDb3OE41452lB+u+aROqs+aeEDu154qJvl4ZJ8TCtLwoC3dfEjzdA+TDurS6rNKlI1gPTgs0aat3ut5nMe6b/WNymO6BUtDE/Vdo8W8BudKE7WBPJYrxy3RIOsp/QWC69Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Lt2eL/4RhlpXOKr7DkYkcD248gcAkhriafXFFjq05w=;
 b=P445YND6x3/fXFCgtTUyiPs5lVlw1EhDSalwEM8NLEsMfQ+v7DeN7+VtMWZGAqt+tR1RHuDGxYV5wSVN1bl6GUav8Q9dIxXQN556P19FllOT9n+lS8E6JKNzCEsACFjh920udHKxByomQMa5TKpruoOpClo5k/S5zqIMVUR/th1lYlLs9JZdDf8om4btOYg3cLQaAbk0wzYLp/8cvDcIZBy0HwyJs8lis27dejDZVPxmFSpE/QG3DSOVj9dPt1ouPiCyGmJi7Lq4V3XP2KrsrE5j6RjqD2b4S1dCGQEPc8rVPacQyZx5xy1CEF4Vxz/6dWQlczF7uzKxT7vI9Dgmcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Lt2eL/4RhlpXOKr7DkYkcD248gcAkhriafXFFjq05w=;
 b=RIFBUElGJ6Xii+oqIG/1vAvDgcMq8av4OPfBHNMuSWtBA5SEbUypGGAerH4f6hfqmruSNlnSXSRnGQdVTuRMI48bRFsEws7u9yVLojn5iB9+wYDHILVE25qJpdUvRvI282HU4TEtD+2XdjaSQMceFxWx7icn6M8FtN/tT0/vShZDntPsYtosrGRXQL1+/8HLglAZFhTgk+eyefA/zBjEEv4bIPh6eUTL5Nj2agnweUWeBU6EbrdNLCC3YL1PYWDGWfM5GFzhAtyKz9EO+H+2e+0/S678crqUwEsuV1Gho24rSykHRqNv3TyM5UTLyFCEkCh+zf5sA/l2OCRL7E3kVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Fri, 14 Jun
 2024 02:30:12 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.037; Fri, 14 Jun 2024
 02:30:12 +0000
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
Subject: [PATCH v2 2/6] selftests/mm: mseal, self_elf: factor out test macros and other duplicated items
Date: Thu, 13 Jun 2024 19:30:05 -0700
Message-ID: <20240614023009.221547-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240614023009.221547-1-jhubbard@nvidia.com>
References: <20240614023009.221547-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0161.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::16) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: fe1acee1-14f4-4c58-3847-08dc8c19eb0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OlQudQyAfA73L6cLVJs9FxKdgvH8/XgSmT+AKuQYLbbsNDgmxp3XUhvVfvuQ?=
 =?us-ascii?Q?uFuVgBp2vU0Lw/ywS4AGSNGHLOq6YQnLmtjTdaU5aPz+g1rF+MAwPKVhvaDx?=
 =?us-ascii?Q?jg2ne7Ql65ww3eJIeepL9EhFWwWIElKzgXbRhACBm+MhzUrIbdwXmMl3qJu5?=
 =?us-ascii?Q?oqYNshyryHFP8FSrmOzOkDUHQfo5sy9d+63Q03JQ8iygVNHVRSnPcUAyE5Lb?=
 =?us-ascii?Q?zHI6TaLKC9pg8ml8ZoVIVs3OCXGXXd8lsvJ04lChnRnaTrysnPMnz5XfEYQp?=
 =?us-ascii?Q?7vQA5ogv0rciJrCD7euZhH2GsZk741Tfx2/P/qJvvXrH8rJ8EpywGEajP3cq?=
 =?us-ascii?Q?QCCpNoZaVpVy1ASMrEZw6+pHQonctL/Wl0GeYpGYT2J37I7kavHaDpIMtDrx?=
 =?us-ascii?Q?S3ybuL6gAETr7Yjv46b4KhbrsiC+qG42Gcc69ZYHFmDTn+MMy4BwS3+HNKa0?=
 =?us-ascii?Q?IgWXy0hDs6AAUx0VakO4aSmPsEVLYUrolMTDZ8F0ar5+BEf4nIAeYkzpoZtR?=
 =?us-ascii?Q?g/i00eotErBkBmfp9z3kZeYKNWOJld1uSTUQ4SlY1UZAa26wJ/Cm4X8OVo63?=
 =?us-ascii?Q?XChG3PJN+aZAYam0SFfV3Kgrsp/LEkIZIwVTooeMx/WmkR4VKVv+e1RGLqHK?=
 =?us-ascii?Q?JfXZYqzKcjGcNcn11QrDU2/iMZqM438U4mHay4Me2aOUAiNdDck1rjBR0UFd?=
 =?us-ascii?Q?GtrUnDfdQzNs60DWsFTwOQ33n5dPUSI0Jn7dOqvektEAEYb01JPfAhQHz0m2?=
 =?us-ascii?Q?cNwU8IOpcDrm/DA/4qcd31r/nEbuaAVe2cA2rVVASApjGCiZpIhPsnlo3F14?=
 =?us-ascii?Q?pvyATnovZAzNs1NgGnSVFPCUiHHPeIzQssSV2DEPVw2VU9tW18dbR43MY5ZY?=
 =?us-ascii?Q?YFrTtpbEJsF3pN5El+KCXVJnFYDIos+wIAX/Ftbqvmeo5yJj/HZIp7id7bP2?=
 =?us-ascii?Q?SnuxlA84NO2iRiE6ahCQAfsE9PSmVS7Rc0/01bNddTszYR5dDnskeNvIeyjo?=
 =?us-ascii?Q?gAXo0psb/8DXRk83Ro38FvGV7IpWXG9RucTlENzbhfzAImAoZDfbHY19lI1W?=
 =?us-ascii?Q?/n/YmEbKZ//tozN93ruX2Urncj5Np4ymQ9m9qPS5wEpolWVWzjJ0KFeclX3a?=
 =?us-ascii?Q?7lcKT1DhZtVUVHxLHv54jP+95pGSyqzysH8bFUPTSCbbrk6MpRmNJeCYvuoj?=
 =?us-ascii?Q?uf9k/+IRFT0sGzYc8qs6/hkzcWuik+h66KKbosuzY89kDXMBILDlLLXS8KQP?=
 =?us-ascii?Q?oRzxBSSOLW+lHvhPzgjGGdmwwRKYFviF5QpU5zGlIIIFbgll/1eXv//46TzX?=
 =?us-ascii?Q?Ata4WFsHOadrYKAjoKftSsRs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l3ngnR539LgbgcQtgzKX4yn/g6GQ4ZvABl+NMsJoAWqbSVHUkTO9BfHWrCX6?=
 =?us-ascii?Q?a6fLVbhqCgtvJnuwdpzm5KDoJUlnAxPWakI3UsG/NQiz8/T78Qc6ncHq2zrt?=
 =?us-ascii?Q?/WvywOf/J+jbairIf4lSSuv6UB6qxbzArxoVsT2LMOpYYGoSzPPj5+vMbO8r?=
 =?us-ascii?Q?8R8cehOjBt9vTXnbIXzPf8Hp83lMvC0U9kSRITABcWS0OI11BwydLHY4WK6H?=
 =?us-ascii?Q?GTJpe04KhfEHkO3setCtfra6jEAVi6S0daPa5jDQF8czM9AcfN8+p0bfva7S?=
 =?us-ascii?Q?P1zyeoDTaZ7q56Llb3DTo9dl3L61TqIw4LAR9V4mNEOmHrkZaVNQ8k+etRrf?=
 =?us-ascii?Q?MrAdAADyc1Mfz9CcmiNAeFeCKOBkGjx6Zs2CB2NlZNVxx4gpTIQS8ElGY29P?=
 =?us-ascii?Q?iHQ/5X0VIQQBxNY5KY5+4YttnZE/gy2kA/Y/IZtrfkc/VxPi15jKOAjb1bjD?=
 =?us-ascii?Q?f7iKqGyOtW8AKhZoyDUgDaTrRxEFbfDRTCxfarOSLUZdu7Iaa3hZ3c/O8ZcX?=
 =?us-ascii?Q?raGLrWAYJ8UaDNrcV4HDrRQweNn2s74cht0Ab5R5m8H819HZj6Qk/VnmCjyp?=
 =?us-ascii?Q?UZQMA2XZ7yPsSEyV20yeHIoMyTbDptiP6RXoXmLTcJRrIvZslRYll6W/xNf+?=
 =?us-ascii?Q?p/4NLZRF+vjIB/v4pPTgheNDm2YrCKXCWjU6xXsfgAwB9pGHdBdUaO2EWbFJ?=
 =?us-ascii?Q?YdWUvdSXsEmPnf9HpMYMNLr6j9lA++56JmtqJt1rUZx5/d/liM0DFj1nX9R/?=
 =?us-ascii?Q?1kjYt/s8TFa/BCOh6+Gio2/0cQorLeV9jG5N8qZuDK6X1viG1AzbuUY2Am2S?=
 =?us-ascii?Q?AcppL9MPtsqP3aMgOukWPURIbSX1nIHR3CPGrDJqKFlu9qzzSapENA9TDAje?=
 =?us-ascii?Q?Xg/wDvuoG+j48whrdcM+ySAPZTjLWPPVJAi3wQnLUAAxjcNpq0xjT5dbYeZt?=
 =?us-ascii?Q?rj5KMJ9oWkYT+SNjGAn1mTgIApoxPr54Y7abvQrGNIhdtRtZb/6iEuT44829?=
 =?us-ascii?Q?3LfGjJnnxNupEEi8tH5sHoOqo9AomCx41RW8lkNA/zfnkSAspP8NPuZzIx6A?=
 =?us-ascii?Q?hsLlQjMt2h0q/3YoOvsbUl9ZABuGZvWpSk2ozwuYxKPKdmTF7bsBQBVF13X+?=
 =?us-ascii?Q?wg4gZbOkuGtMc7aI+t2ZRQzjTVDYWpClQdcSQl6TQRPmhOr1hystauRGktZX?=
 =?us-ascii?Q?4yAr4ZK9P8nJGShA1Y8U68tszqBQeTCWBN0aUOKZJmsHSFYxu5ZLSC1sDeBY?=
 =?us-ascii?Q?Y/1zQlWb8vBijrHxesMnaqSemoD4ayA2ECkHiSjL3Xyv0NgOr9NcRImN+vbO?=
 =?us-ascii?Q?Er/NRt2SdVB2Ucwt2Gknq9e6bELVxQz8xylol44fVHNvIVmnxDMcYylNueRD?=
 =?us-ascii?Q?YPXEGVsuA+EpO7cG+4PLsopenL/WHUuRFF47OxYPvDsk1EO+dEofvsb0+pPn?=
 =?us-ascii?Q?ESKcj8sjsCLvooHcopx9zn8RKneCe6nT3KfJdWvA7KQT6oK/01e5sxFXWlho?=
 =?us-ascii?Q?eabCruTAJ2TL4hZOKfWMk36xmQKl68WCFAoKDMopc25t0JdPVhRi2wQc1sJr?=
 =?us-ascii?Q?jkh9hD/2wnrOUCjlG6y+hm6um17NjjLII3MPHj5z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1acee1-14f4-4c58-3847-08dc8c19eb0f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 02:30:12.6029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4oLGoKrZxJrdHGIzDLrtezh7BvHUFep7LiCiyR9EpzWqPdksy0iQfR4JTnl1FtIDCnLRI0+w0oNbJJYxmQgHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932

Clean up and move some copy-pasted items into a new mseal_helpers.h.

1. The test macros can be made safer and simpler, by observing that they
are invariably called when about to return. This means that the macros
do not need an intrusive label to goto; they can simply return.

2. PKEY* items. We cannot, unfortunately use pkey-helpers.h. The best we
can do is to factor out these few items into mseal_helpers.h.

3. These tests still need their own definition of u64, so also move that
to the header file.

Cc: Jeff Xu <jeffxu@chromium.org>
Cc: David Hildenbrand <david@redhat.com>
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
index b65bc20c04fc..a28912fbecab 100644
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
index 6212434bd6e3..7f6a95613dd6 100644
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


