Return-Path: <linux-kselftest+bounces-9319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE55F8BA5CC
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 05:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0521C22425
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 03:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F9421A0B;
	Fri,  3 May 2024 03:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kxhNz49+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3931CD24;
	Fri,  3 May 2024 03:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714708273; cv=fail; b=tu8MzHuZPhvQkhR7vgXmKN87XS9O/TTZwcNMlsuVkdgV4Vp2MiWXw2QbmgTPnDx2bmOwa7HkpzGW9j4BcCBapuOE1sii6TYzkJUCjlk350jxUWhNR8UED9de8khh98yPOYXTjre+xfjkdJkjKKCQpBxNYTrHkpYWwEsbibWQr7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714708273; c=relaxed/simple;
	bh=FZQPLZWghbhTFg2/pYgoJQGyJYWercFD6b12pURP0os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vAt3L/WiRVR8mOrFx80yD/bfrlhfMjk3Cmt8ImiVdK3o06vyCHl8bPN/923DkYzn8bEF1E348bX/CiY0ZfmUYXc3v+j3eIRufC3b9XNK5uzfSVFqRy8wMQ1oQOszvc1MLqbKQGK9+n8jdEkbZLPXx5Yo91R5AaUJTOW6j/7PHOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kxhNz49+; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7fyyNIFak7+4+Cmh7vdgPScUedLSSrzpbzFr3g2eMhZm0gzBU2we7b4I1SEkkD19hRqC4ko2Rb3fqQLLDU/ygSfC4bXLFRbZY7NEMd9wg0vP1wdJc5GH5bO6kPqX8nB4hE0vRCJimaZCdAjHxpryN8DA5Bx6QeuHCgAcDusK0Fob+wLMN45tk4PQDEVXvwQR7d6ihyPjoPqbRvdxrnNsd/qasCsUxYSnZJC7Iy5tu9+UW+vUyBu5A2qPkQe4owkzz4SUgMO0UJX5keE+q5+qvI/uV7qOj/7aUNjdwtxSyvEkzbK7d9W6dZX2X1dbYBhEmCJRMSByFC7mDT2i7ANMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEch4UNGf2xILDLML6oCjGM+UDhweOuYpthwBkU35mQ=;
 b=BBFHLePVVt7iHmsptB2kotddC4xk1au4KDTGEPuFKF5LEiTZFbunW97R82iMYkd9jqP975mFnjzMZmIfEHiZsQBmb5mfM2+scIJpmHXdEwvHjNv092gH7GAvljaFvY/U6ps1JfOVUzNJa9SYDo+wCfH5tHrxeAaEW2j96f53QDOYHLtsRgZVlOa7SEW2Og+nSoFXOBBwBImnAWAhY/zGsmIfKb7Lf7pKV5SFLk4dNBVgKdhD0DgX9Ue7hO1xdG4ah3hbvpqy/jK5e+eTsFySkX513+oW9qAWi4Y/ietgz9xTNvE0pQxDHklFC6WNmy2Tw3A0/rVrr44EKlFUYXT4RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEch4UNGf2xILDLML6oCjGM+UDhweOuYpthwBkU35mQ=;
 b=kxhNz49+DQ/ANRn3r9AB54GThyH4BHgRfrC4+28kJZiHEHwAOKgQTw6JrqiRHypF4W4s7ksiJvKJGOhkf4iQCq6IalPjWfM27ZE9tFA1BnTP15WShjdQJKkUUEt5UhyCNK1qidPdBF41V/uTM5m613zeFtJSGQaH75uhQtxbknttkmVoIfqfYcscUt7Z1Jsg0wjjHIQ5qXpjmM5WDWvGC+mBP2u8gZHpPNTz2IjWTma65e7bNllvEe1DQoMOs0O1UFg9KnY9zT/YrqDyl6dHJSX6JWhid3+CgQlD3ZtC77iDB14bEfrpCC0DwIbngGEiDd/rext0OXMduejbL2zy0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV2PR12MB5941.namprd12.prod.outlook.com (2603:10b6:408:172::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Fri, 3 May
 2024 03:51:08 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Fri, 3 May 2024
 03:51:08 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Waiman Long <longman@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/4] selftests/cgroup: fix clang build failures for abs() calls
Date: Thu,  2 May 2024 20:51:02 -0700
Message-ID: <20240503035105.93280-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240503035105.93280-1-jhubbard@nvidia.com>
References: <20240503035105.93280-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0093.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::34) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|LV2PR12MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: 98063537-2a31-410c-dec2-08dc6b2443f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z8MRn10j9YzQK/8/9/X4QnqiKspr2jmUQudqWjU8Tpo1+J1SizQZXZkXR46C?=
 =?us-ascii?Q?wZO3EdJ3TSTnhLVD48eTJCgo0R7fMQG2BB8FFItci7uyvv0xD9dCiRHrSVuG?=
 =?us-ascii?Q?cdqlN2EsgeXb6MXWCFbEHdOyeYxwv59EuAfMJjD3YuLXrP4UEwhv8ZIgfe7e?=
 =?us-ascii?Q?5gNBWVQP0swd/NzfcaQ18XzfOI5O5l4PJerKjb0UEg5ZM6Rh1aDY4nclr77i?=
 =?us-ascii?Q?YG9mDy4a1SPMY1nEVQgZ5u0nMrP12e4f+9oy8mzAhMbI0YtSbu87Fz08sHIE?=
 =?us-ascii?Q?UZdLCYdfXdGnwD/wp9XT+4xngrYkNyjfl6I0bquoYg23eydvdFi5MqcjpkCP?=
 =?us-ascii?Q?JS2ZSfZ4hqMPKgwtKO1NhMPj3R8RR8Mtw1K+EfwIXlsOGMdfEy9xssNBu1Cz?=
 =?us-ascii?Q?ny+AhaVZ8LRhnjSOX9VHqF8kZ/DiTXCrq3KdHTP9N86609Z+dMabfsOd8LK7?=
 =?us-ascii?Q?ATqUYZ2/HjOs/c35bYtHApLAr6ck0Jcr72RD+2YKKoFxD7ZjTPvMP1E78Aye?=
 =?us-ascii?Q?D+4QX+ih0M6M55pjFrUa27XHh8gbpLtRkiBSnvp7Bl8in6JvqQDU4LMCTUGs?=
 =?us-ascii?Q?Owe+57WYwF9MR5+MH3RwKJta6iVXJlHzwTkuzdPKiYoQPqC+aERcMgu6AUzW?=
 =?us-ascii?Q?PpcfDKdzVKK7OMcmRD5rd56CxJOCtKfDHwbsZc8U8+LswdLExkrTeTU88jqD?=
 =?us-ascii?Q?4Rg5B/Lz06x7met0lPqsr78Y9lNlLtG3cgyMpvWRy6Blcxg8SKZ+bZ4BV+Hj?=
 =?us-ascii?Q?n5gv8ezZgmeOG7QWT/4uFMa3gfwdISOVU8jQVMhG1UvUzuTPrZ9dfRNTQUms?=
 =?us-ascii?Q?EMl1tP3q/ypla/zvb6l5MPVbWWlxZU3/1AIVoX+mefKVxtMjXftZAewQQXnS?=
 =?us-ascii?Q?UstR9Np85QA2m9MUkIaPRceqZ4GaqpIWOsH0JJmfKkGEKhOkt3/pZJpBFGzZ?=
 =?us-ascii?Q?0R4ioFANeq9GpZQUOJekPSwgI8QW6JwppEFSIkAqGUqBiI2JCUTE9EUpLm6T?=
 =?us-ascii?Q?pXPMJdI2/bwrbegaBvaSQrH/XJsg8jeivF0VTUeq40cK6QqdjFDhC4CNs5Ge?=
 =?us-ascii?Q?HWZfACsDojsaC7dvJdbQkCLV6Iv0LUSN0TwMOvcACV5gv9TqBseMWXdww0m1?=
 =?us-ascii?Q?nJHVVmZh8yYschcjrhKD6cnJxplX2h7fSJFHn42yfkcs7C9/33DvvjklrYdk?=
 =?us-ascii?Q?lhDhR29mOv7vtcNSwdxFE3vv8vWEG7CyJM0QnrIF4rGXonhQhadgMbGWyJHQ?=
 =?us-ascii?Q?4YG6AmqobnDdaJLyo10SyIVYTpxcMV+p46/lrRXDmg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7ubpC2pyVaLTxM5vJ9f7dePekbuqg8ZF/BdVd35d4CtO6oT14fv5SznDTu6O?=
 =?us-ascii?Q?hH+U0YqHc0Deqyvldp+5JwrPG3z0eig5UsmPSMk/OtcLDUupDJvm7fGzqT9M?=
 =?us-ascii?Q?sprnsFVOAcXSoelQikPXrjliECIuMHt1RK4ecMGb1N+1l5ALWzMre/Cfh6Vq?=
 =?us-ascii?Q?E5q1Xp/rS8d33VuiovV0Qi5syR0fA9vI4ArqmWtJhua8e1lyLcWFU/MkzTsP?=
 =?us-ascii?Q?E5ivDUI/SQXOVjuwdw2Wql0Zt8m6mqdYnw0Vueye5PO4eTh5/50UAzVL/hpn?=
 =?us-ascii?Q?XTfdNOU/rjZ+Mfdh1N450gIAhihNyRuuTPNZIPydSnZURRni15bIzx28DWcb?=
 =?us-ascii?Q?4n+8+yt37p6IwtfPNtVbAw+bd790opMggvCh/ow18ZSVCXhQWujLKnAuuKT5?=
 =?us-ascii?Q?Wksa0dFQKXAh4k6WyM21Y+DFgLVnb+JJjfvt72VQfEghKw17yyWQfgJWI0sN?=
 =?us-ascii?Q?okkmazi6TgnvK2Ngq85lJlFp4VOx1UMO2g82uPlCWufBDfz9tfHg00E76sXn?=
 =?us-ascii?Q?LxmvOnaMoPf1GZ0uXiNx74XYcIxEsbX6P1So4zdi/ecNF6FXQ44E1zGuqGVx?=
 =?us-ascii?Q?qOSHFe22Kzraf8zBDTMUFbk8l/WPR5yLbEgitePTETW2QBYj9aiOakM+GyXD?=
 =?us-ascii?Q?CP7mFb0UunTqveTyNMY+ORBXdndXddSl+JFxxsCe+qHNm6L9LtvrzY+2WZEv?=
 =?us-ascii?Q?8+E/P0kKN50/LmAlKB3BrJ6pXsTsE6ZfrEu3DIwUP/jbR+I3wSltnmVdXZ1s?=
 =?us-ascii?Q?Z3eZWpCE/p+buVVnasI0r2aIfD15fS+kM2uBNFmRoNkjDAYItrzzYX6yN+yw?=
 =?us-ascii?Q?/jOcYcKTAsI1eXOWkNmeb3aXKvUxdcWD7Loma0exPZZuCquAV6jHRgtGAzDI?=
 =?us-ascii?Q?L3r421swAUYw8TYqk7fDc/aJ3ks3gduptN6HcXb/u9EUa6ilCcKwlQYhVyOz?=
 =?us-ascii?Q?ozjJWXpf2ib7q+OQIJixY9Y7gOroaU1WombQqlNyHbPlWRVtG3nM4qpVtM72?=
 =?us-ascii?Q?HNNtE2E2Ec1iz4YctgDLSO9HZZOenwFAjvixte9oXEkDWcAZRR5fgNRmTpzP?=
 =?us-ascii?Q?moCNP1UN1c3LukapzfVG4DZVuC/fb1ASI4L9ri9x0xnq8sxnxike9jewpZUj?=
 =?us-ascii?Q?L9NQjJ2MhUC/fEtupqJw7GS0M0BRaZndRTOraamwjbDxIC5Boy0Fj/whyE0j?=
 =?us-ascii?Q?UgPwvysWfVLL0XvMfReMYAjSBTVdlcUwp/0hJbvMNb4j9wMtlfKsAh704IFk?=
 =?us-ascii?Q?x8j1Hk2cwG8dhGyAuhbvZ4RSY8Vi+3I439i90mphlZUMcIj+530jQicpgj1N?=
 =?us-ascii?Q?vCirWvbMD7crcZmJ2Leo1RIWj2gHjY66qlkxN0lKqc7haxkScvZvmgJo1IOA?=
 =?us-ascii?Q?bnd4pt+jcmug+Ezt6ApvXctHR46yLhQYXvNw6zef7NuXTI+55g1zfou8cQgD?=
 =?us-ascii?Q?49qO6pACcAJ6hvRoCmaurGRkt8FOlyh0HLvdK6S0UZ8sk6OOpRc0c4mGME0H?=
 =?us-ascii?Q?cFP4bq9/T5TXTRFoA6EBj9/dtkyDnPfqTd7jCNm1FvBqD/tnKGH3PJzgr2HI?=
 =?us-ascii?Q?LiWhvaSJVHg5NX1k8Bf1TasjeIJlvNpMwWyGuWGq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98063537-2a31-410c-dec2-08dc6b2443f8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 03:51:08.4339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0nI1iNp9a37M8EirS5zBXkpxrc7wIQEOd7ZqeBqH/7Cr/Sqmmfx1wer1RlWsHURm35c5DBYe/Oto4ulvBU+u5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941

First of all, in order to build with clang at all, one must first apply
Valentin Obst's build fix for LLVM [1]. Once that is done, then when
building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...clang is pickier than gcc, about which version of abs(3) to call,
depending on the argument type:

   int abs(int j);
   long labs(long j);
   long long llabs(long long j);

...and this is causing both build failures and warnings, when running:

    make LLVM=1 -C tools/testing/selftests

Fix this by calling labs() in value_close(), because the arguments are
unambiguously "long" type.

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/cgroup/cgroup_util.h | 2 +-
 tools/testing/selftests/cgroup/test_kmem.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.h b/tools/testing/selftests/cgroup/cgroup_util.h
index 1df7f202214a..239633e936df 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/cgroup_util.h
@@ -18,7 +18,7 @@
  */
 static inline int values_close(long a, long b, int err)
 {
-	return abs(a - b) <= (a + b) / 100 * err;
+	return labs(a - b) <= (a + b) / 100 * err;
 }
 
 extern int cg_find_unified_root(char *root, size_t len);
diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index c82f974b85c9..d21d3d280ca2 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -192,7 +192,7 @@ static int test_kmem_memcg_deletion(const char *root)
 		goto cleanup;
 
 	sum = anon + file + kernel + sock;
-	if (abs(sum - current) < MAX_VMSTAT_ERROR) {
+	if (labs(sum - current) < MAX_VMSTAT_ERROR) {
 		ret = KSFT_PASS;
 	} else {
 		printf("memory.current = %ld\n", current);
@@ -380,7 +380,7 @@ static int test_percpu_basic(const char *root)
 	current = cg_read_long(parent, "memory.current");
 	percpu = cg_read_key_long(parent, "memory.stat", "percpu ");
 
-	if (current > 0 && percpu > 0 && abs(current - percpu) <
+	if (current > 0 && percpu > 0 && labs(current - percpu) <
 	    MAX_VMSTAT_ERROR)
 		ret = KSFT_PASS;
 	else
-- 
2.45.0


