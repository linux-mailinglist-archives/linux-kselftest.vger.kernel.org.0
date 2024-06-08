Return-Path: <linux-kselftest+bounces-11462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16380900F36
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 04:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7F61F22196
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 02:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FF0179BD;
	Sat,  8 Jun 2024 02:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AUtP3iKo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C29C1078B;
	Sat,  8 Jun 2024 02:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717812638; cv=fail; b=oV6GhBL9UFdT3ftEmPfKEI+gYDEOzGfKliaCdNRy/KhZb5FA/csibEXWDb/akApk5sY+5kt/xNm4cIRfol2y5qZMxHDAtn+ekqdRdIA02HWivJ95P8SgM85xGDFlqsrN9GIwNCJFmUxazPg+fd8ip5wd/oubGNUOe0KnK0rmyK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717812638; c=relaxed/simple;
	bh=WJsPbWyU+TAIdxc7hDxCm4VLRWpjWLcKRF3TeupLkSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XTvutejyuj3SuiJXu4kKnUmav3zfd5VtqaxzUAPqTSGOzxckEA26w29Llpdt1ze/fBtSIMaoGOFS/ceEjAtHCiue/wbFOjAhA/2OEXWV7sFcj2rc1E8XtlwWcXmkbln05OC3XjwNAvtkqHjs+BbUacTk4MGikuqZh5C5tKOAcb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AUtP3iKo; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DT5z8Qd4j8TZoM+JRPNoY+lJwtS5jptW/e20j7SyYqQg0q9v8joK945rB9ZBfNfgoQ3oz2ZpAAW9kXNqlTmYT+eim91DJkClkXg8QzVrnBuxFpPqvrZ2LeU/IBBMANDEiQulu3w5ztxXvKF1cExbRwGIkXy0jGY4cog52vnZAlM1RGpqZ1wfJOTFZx//CrqfFH64mSWeOAJYQbvfCxF8A5ChxWALlVaMOrU7dr2YhFgGYOnqJmuDoGJuvEvpC+FWjRf4cCeJmNUm4T2mdIfa+a7UGlxwxjFDJxHprP+aGM0u25HDs/NXyv9ewfqLZvnoMkU5QV5ackn4LJcnvDSv9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oqGjv34FBcd1v87cGbIJRH+wqlBWpfcyFwWYrkFcN0=;
 b=MzAq0vGMalS7VCWQ1Drwf8+0RizrYAFr/bLiiDDJO8pNKh5oGNMtXAOJhbCrU8/p2dykw2u4qMmAvmvXZO3ygG/tdIxbdq4Jk9EeoD/iktGyN6mx2EjJIqIK0OMxg/Y2RXdBJQxfua8e8sg68vJoC/p7tmuiHHvwckRRFwYET+KF3rPOcnx4V7hDDZhzoMd4EXdrCs7edVr1XjS5ePdvsmrgjTgxT40yACT7BDZnlIVDE/gtkYcqU9djZL/75EkOrRAi8ZoFoCoXjXE7Zda97R8NQEi2gdSTxnEhoXCi80mUEgEJoMv6wHE6SrsZjEiSl0fsoMrR2CKJIbrV1joIoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oqGjv34FBcd1v87cGbIJRH+wqlBWpfcyFwWYrkFcN0=;
 b=AUtP3iKoEKUgXM2yfuVbwDQAazxsHN5jdmwgHeGlqblrXQgVW+KqH2oRkE/cMNPPsxB5V/s+ra0naeDkYPhHa+Oa6r6Y2VkIRpJGzT5mEym6l455GY6tzYf7DzG5qx3tb5vfyi1/u5l9yVo2OeoAj1RuFG71KNX47y+Albd6PPtveho87YGjpfwyRzM52TAqEsM58RI7BT/eHIcNf5rkjVxdBJ17XJeuYo6EUwl1CdSm3/kI1SubPV2zo6ptdO5/OviVbK3JCYKw/wo34Z5vS1GbiDt2jyG/6yPd5hSk0DxZivE/qzAtt7IsuOzRfDmzvO3NcUHtuoVWHj3f5O3q4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Sat, 8 Jun
 2024 02:10:28 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.036; Sat, 8 Jun 2024
 02:10:28 +0000
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
Subject: [PATCH 5/5] selftests/mm: mseal, self_elf: rename TEST_END_CHECK to REPORT_TEST_PASS
Date: Fri,  7 Jun 2024 19:10:23 -0700
Message-ID: <20240608021023.176027-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240608021023.176027-1-jhubbard@nvidia.com>
References: <20240608021023.176027-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::27) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8fa89a-600f-422e-44c7-08dc87602ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MC7ppyJdKvTeXYw4JfSKuJ2Vrm0SZGOlmr9m01GRrh/WJ8+FC7iEyZDZ8J5R?=
 =?us-ascii?Q?o56R/3/vRO5RyI/PtIJ33SSRW8c6u5thJfJrK35r3Hn3EBuRtpaLsM88Wvvj?=
 =?us-ascii?Q?LjLgcSZ6VnMcGVmsxW79P/rGHeIQo4qCrK8mKHIJAay6kEsh3DC14SnvTSZh?=
 =?us-ascii?Q?vBLSC9wDpdF1ruufdVDVg0Ja9i1mCYZKpaZJDvygi/Jpv+lDto7P7inNUpmj?=
 =?us-ascii?Q?zOqHWWgbLbh/StNxOK1smBYSzHtX/+8Hx2wMZIUbM5t7ANMnfc/qYEjeAs+N?=
 =?us-ascii?Q?UuOpmj5DnkphGr9RgwbRIRl6HmLN/hFz3tTiLljo7+CSKYjvFvjE10alAhw6?=
 =?us-ascii?Q?mspGC/cJnqa52pj5hXJecafIu99lmb0xL6gk4RaXKXARaN5CWYp9Nq6ktUFi?=
 =?us-ascii?Q?0ekkbaOXchAi4Q/RBO+coWWGbuFJ1ukwlmvsX88AjNlexijXIcvqdzWoWQ+o?=
 =?us-ascii?Q?FGwHv/lN6bLknndltugLbD/nnmGVVZSbg45Nib+OmdIne/XqG76dmqxMfldL?=
 =?us-ascii?Q?oqk50Oa47NF/1U29Hie0xowakU7FpiEMtVCJIUSQweEhbQYKdx9+7w55BNmK?=
 =?us-ascii?Q?2LPK8jJp8SJOo61REdBv4DkmXpswboHAnZUhmPWxiQczv+uxyitBnrftw/pq?=
 =?us-ascii?Q?qz9J7GptU74IMuvSKLNGCUZDcEWxfYPfQF6zkOlELVblKcuXiwptvWFMuziM?=
 =?us-ascii?Q?yXMvamBqNj+qVIw+BYlACeTrs4jiebGnauOHqXuvcYJnlTwMvSOgoeduRyzw?=
 =?us-ascii?Q?xdwzzmZ7wQ62pd0/QmsI6b5/WDFGEmRCxC0VlM6R1NC2ZBJzrXu3Y09AYIdz?=
 =?us-ascii?Q?NY0PHGn7DrunaFkJ9hMFO8QTKah9LtVCPzwkYZbMhWzPuY0bSzPzEDMAl85j?=
 =?us-ascii?Q?aBIdAT9lL9iObZl0dDo5wA175N4PxyOBJSF52w9G1HNw+75LdDAuS3WypO05?=
 =?us-ascii?Q?aw9Qlp6bmeHaNzqqO9kT9klbMAziJzGLM6Ea9fWO4eK1fv7E2H0UHfkZoHpN?=
 =?us-ascii?Q?GtIufosFOkaGoes6VxTd8CL6TpPYo/CL2afV5XCQvEqGPVp2/H4bEI0CZbA9?=
 =?us-ascii?Q?o1Kc0mVUszbzyOSQKL4NJOWnv/07Epf5i40XMiXj+bmFbYkRkzD57ONND+oP?=
 =?us-ascii?Q?NFcK0RZYD07XqmUJOs7yMxsZnpybAwdn2o6fv95eH+l4LLH7eVhI6SzlqomG?=
 =?us-ascii?Q?SuJ4eHP+OY3wYKRmx1sca40b14re5gw4W5CSZZjV1veCXSXDQ6FxBYjUgyY5?=
 =?us-ascii?Q?VDEpXTFUcHQIkFCgEQaH+JW1gO669coCv9FRwx8uBMOyKgIWtAks0wbDvor1?=
 =?us-ascii?Q?q9az3dsL2o/uhnqo8a/suiPN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e453cPrrKhKSNiGRea5I1YhfWIM5ZNVcLwV7SGRqkthpSRoNpCuhzppJjz+o?=
 =?us-ascii?Q?gfn4x8HpBpXHIg5Nxt+NoPAAu/0G44FUU+suRyLeY7E5glcxo2UtK/xpQtPW?=
 =?us-ascii?Q?vo1HXDVQlsOVCfM8mYir4KSyySBZcvvPiPnL+4SUNXrIlajQXwILZNU4YFWT?=
 =?us-ascii?Q?d6PU2WFZCdYXM39Uwho7lJqWipMrmdTMn3ZDWjIB/VnIPE5M3E3fna1Ad7qe?=
 =?us-ascii?Q?scCQoKqSYRkil+gZaezcvYNDUeV3WH1zbYxLcyKVyhETs7M5Pcv/UazcLh0m?=
 =?us-ascii?Q?1l2NLtHehw+XRfJevIsGXUdQoBAqAxYYXJVP0FkquZV6Risfr34xFvoX9bhR?=
 =?us-ascii?Q?6l0xcZSmEFp7RiiUQ87xFcm+Xw8T8CT2Eygirv2uFC+MwNoHSp/iBnZt9O8d?=
 =?us-ascii?Q?9KTzBoZGb8S9BUV5vPSQCVx23BeKNUbzsDl68Uf7k7lShSrEFT+GdUaPTpAc?=
 =?us-ascii?Q?rz9kJ5fKpkYBUaIsYa0V+opOSWVqwJnNND6cAygyyrqXZTzSFCMtxVYzkaYI?=
 =?us-ascii?Q?EnJS68xyqcbgHCuXk0c3C3XJjK0QnDLIUC4dRRSBa/IrXDJjm05oJemmAOwt?=
 =?us-ascii?Q?iRPIulWzkyQ/gPCZljxrIwukyasKN4Q9EV1L+OIYqLQAdciJacow08//jp7D?=
 =?us-ascii?Q?x2id0PLcDYrHWVUBWqwm3L9Z+2dXJQt/h6RbhStofYjh0ZnTBEtX9PMIOl4d?=
 =?us-ascii?Q?5hsky5DgzTYUgeU88hoL6wESpT1US1AZs89alNgLuH63xRn1WJjuF9vcPlxb?=
 =?us-ascii?Q?eth8OKfewYtIWricEYEqEjopW7NGBRsN0GEDuzmKokUflrZgP/QeeLBq6WJu?=
 =?us-ascii?Q?LCAJac6d0hbUgCUHzwDj6c+q+o4GoZiRLXG2ZPcZddDfBwYJUMoUhXHPHHDq?=
 =?us-ascii?Q?9TV5UeGHj+kG6rjmCyEfXApfuVKYj13/ai7QaQ9oiYwgZwOe1/qQ2slW4aWg?=
 =?us-ascii?Q?c0eZy+m9Ez5K6ual5hZNp4EanlqgdkNmzWL0CZT6tfBT40wzcyg784x6AR18?=
 =?us-ascii?Q?9Ehc4ztGBLJWpSouLMmQ339wrIG6S6Jq7oJe+Ui9H2iENT+TWMef6+95c2BB?=
 =?us-ascii?Q?msV4nggLpYGqvDORgvvJMgws3cFCLA0yC/METg8J1IjcmRib4K2nEmwB5XFZ?=
 =?us-ascii?Q?oLz/JV7Dmjc2gO9DfVO3Jh23JBgAO1ks4oMr7KTzQzfcPPZ3v3Z006+rcoAU?=
 =?us-ascii?Q?w7mTK1S/uCerfWyO36rjLOkhVZyWKbOEqVVCEdfNXmSKM+WncU7aFLJ3gxWj?=
 =?us-ascii?Q?KKlqhsc4WymjHawn2foEQGs+u+Ij/751divkcklxhHoGwAWvveQ4JU9IV7rf?=
 =?us-ascii?Q?7W/uo4oWk2PywxPxX7xJdN9dhRTfJeXrQLiPBRYNX1gw/2sr+s1fkJEFz8X6?=
 =?us-ascii?Q?rr9WCUc0BSK0+isQ/VUHB+UtsR0FcTQtcFtgvVzQQCBMUdapmngQTMbak60X?=
 =?us-ascii?Q?YaeOZUUA5rXy7KKB8f5zlg527gqPaGZWimU1fVaA3nzAnbySolCAZqv1Lekw?=
 =?us-ascii?Q?OqKXA91tx4r8bK94P1cQt6zCm9uXPqYZ28Gs7RG+U+Q8++LMQ6zAiAcByIWM?=
 =?us-ascii?Q?6su8ejnpEZQyNM3hU+8p3uuCa8wfrTXTa14qrYA6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8fa89a-600f-422e-44c7-08dc87602ade
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2024 02:10:28.6301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EYba7BqkhXAUvows5GGdYzqgEU7hfkq1W6FncefgCaX3KTXT47pnXBp6tMpbJUsCGMXNq+GW+sN5UsoIVzmjrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196

Now that the test macros are factored out into their final location, and
simplified, it's time to rename TEST_END_CHECK to something that
represents its new functionality: REPORT_TEST_PASS.

Cc: Jeff Xu <jeffxu@chromium.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/mseal_helpers.h |  2 +-
 tools/testing/selftests/mm/mseal_test.c    | 92 +++++++++++-----------
 tools/testing/selftests/mm/seal_elf.c      |  2 +-
 3 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/tools/testing/selftests/mm/mseal_helpers.h b/tools/testing/selftests/mm/mseal_helpers.h
index 8c3bf77dcf19..65ece62fdd0c 100644
--- a/tools/testing/selftests/mm/mseal_helpers.h
+++ b/tools/testing/selftests/mm/mseal_helpers.h
@@ -22,7 +22,7 @@
 		}							\
 	} while (0)
 
-#define TEST_END_CHECK() ksft_test_result_pass("%s\n", __func__)
+#define REPORT_TEST_PASS() ksft_test_result_pass("%s\n", __func__)
 
 #ifndef PKEY_DISABLE_ACCESS
 #define PKEY_DISABLE_ACCESS	0x1
diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index a29935d82027..f8e1c59f298e 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -240,7 +240,7 @@ static void test_seal_addseal(void)
 	ret = sys_mseal(ptr, size);
 	FAIL_TEST_IF_FALSE(!ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_unmapped_start(void)
@@ -268,7 +268,7 @@ static void test_seal_unmapped_start(void)
 	ret = sys_mseal(ptr + 2 * page_size, 2 * page_size);
 	FAIL_TEST_IF_FALSE(!ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_unmapped_middle(void)
@@ -300,7 +300,7 @@ static void test_seal_unmapped_middle(void)
 	ret = sys_mseal(ptr + 3 * page_size, page_size);
 	FAIL_TEST_IF_FALSE(!ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_unmapped_end(void)
@@ -329,7 +329,7 @@ static void test_seal_unmapped_end(void)
 	ret = sys_mseal(ptr, 2 * page_size);
 	FAIL_TEST_IF_FALSE(!ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_multiple_vmas(void)
@@ -360,7 +360,7 @@ static void test_seal_multiple_vmas(void)
 	ret = sys_mseal(ptr, size);
 	FAIL_TEST_IF_FALSE(!ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_split_start(void)
@@ -385,7 +385,7 @@ static void test_seal_split_start(void)
 	ret = sys_mseal(ptr + page_size, 3 * page_size);
 	FAIL_TEST_IF_FALSE(!ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_split_end(void)
@@ -410,7 +410,7 @@ static void test_seal_split_end(void)
 	ret = sys_mseal(ptr, 3 * page_size);
 	FAIL_TEST_IF_FALSE(!ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_invalid_input(void)
@@ -445,7 +445,7 @@ static void test_seal_invalid_input(void)
 	ret = sys_mseal(ptr - page_size, 5 * page_size);
 	FAIL_TEST_IF_FALSE(ret < 0);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_zero_length(void)
@@ -469,7 +469,7 @@ static void test_seal_zero_length(void)
 	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
 	FAIL_TEST_IF_FALSE(!ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_zero_address(void)
@@ -495,7 +495,7 @@ static void test_seal_zero_address(void)
 	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
 	FAIL_TEST_IF_FALSE(ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_twice(void)
@@ -515,7 +515,7 @@ static void test_seal_twice(void)
 	ret = sys_mseal(ptr, size);
 	FAIL_TEST_IF_FALSE(!ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_mprotect(bool seal)
@@ -539,7 +539,7 @@ static void test_seal_mprotect(bool seal)
 	else
 		FAIL_TEST_IF_FALSE(!ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_start_mprotect(bool seal)
@@ -569,7 +569,7 @@ static void test_seal_start_mprotect(bool seal)
 			PROT_READ | PROT_WRITE);
 	FAIL_TEST_IF_FALSE(!ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_end_mprotect(bool seal)
@@ -599,7 +599,7 @@ static void test_seal_end_mprotect(bool seal)
 	else
 		FAIL_TEST_IF_FALSE(!ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_mprotect_unalign_len(bool seal)
@@ -628,7 +628,7 @@ static void test_seal_mprotect_unalign_len(bool seal)
 			PROT_READ | PROT_WRITE);
 	FAIL_TEST_IF_FALSE(!ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_mprotect_unalign_len_variant_2(bool seal)
@@ -656,7 +656,7 @@ static void test_seal_mprotect_unalign_len_variant_2(bool seal)
 			PROT_READ | PROT_WRITE);
 	FAIL_TEST_IF_FALSE(!ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_mprotect_two_vma(bool seal)
@@ -691,7 +691,7 @@ static void test_seal_mprotect_two_vma(bool seal)
 	else
 		FAIL_TEST_IF_FALSE(!ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_mprotect_two_vma_with_split(bool seal)
@@ -738,7 +738,7 @@ static void test_seal_mprotect_two_vma_with_split(bool seal)
 			PROT_READ | PROT_WRITE);
 	FAIL_TEST_IF_FALSE(!ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_mprotect_partial_mprotect(bool seal)
@@ -764,7 +764,7 @@ static void test_seal_mprotect_partial_mprotect(bool seal)
 	else
 		FAIL_TEST_IF_FALSE(!ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_mprotect_two_vma_with_gap(bool seal)
@@ -807,7 +807,7 @@ static void test_seal_mprotect_two_vma_with_gap(bool seal)
 	ret = sys_mprotect(ptr + 3 * page_size, page_size, PROT_READ);
 	FAIL_TEST_IF_FALSE(ret == 0);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_mprotect_split(bool seal)
@@ -844,7 +844,7 @@ static void test_seal_mprotect_split(bool seal)
 	else
 		FAIL_TEST_IF_FALSE(!ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_mprotect_merge(bool seal)
@@ -878,7 +878,7 @@ static void test_seal_mprotect_merge(bool seal)
 	ret = sys_mprotect(ptr + 2 * page_size, 2 * page_size, PROT_READ);
 	FAIL_TEST_IF_FALSE(ret == 0);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_munmap(bool seal)
@@ -903,7 +903,7 @@ static void test_seal_munmap(bool seal)
 	else
 		FAIL_TEST_IF_FALSE(!ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 /*
@@ -943,7 +943,7 @@ static void test_seal_munmap_two_vma(bool seal)
 	else
 		FAIL_TEST_IF_FALSE(!ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 /*
@@ -981,7 +981,7 @@ static void test_seal_munmap_vma_with_gap(bool seal)
 	ret = sys_munmap(ptr, size);
 	FAIL_TEST_IF_FALSE(!ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_munmap_start_freed(bool seal)
@@ -1021,7 +1021,7 @@ static void test_munmap_start_freed(bool seal)
 		FAIL_TEST_IF_FALSE(size == 0);
 	}
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_munmap_end_freed(bool seal)
@@ -1051,7 +1051,7 @@ static void test_munmap_end_freed(bool seal)
 	else
 		FAIL_TEST_IF_FALSE(!ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_munmap_middle_freed(bool seal)
@@ -1095,7 +1095,7 @@ static void test_munmap_middle_freed(bool seal)
 		FAIL_TEST_IF_FALSE(size == 0);
 	}
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_mremap_shrink(bool seal)
@@ -1124,7 +1124,7 @@ static void test_seal_mremap_shrink(bool seal)
 
 	}
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_mremap_expand(bool seal)
@@ -1156,7 +1156,7 @@ static void test_seal_mremap_expand(bool seal)
 
 	}
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_mremap_move(bool seal)
@@ -1189,7 +1189,7 @@ static void test_seal_mremap_move(bool seal)
 
 	}
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_mmap_overwrite_prot(bool seal)
@@ -1217,7 +1217,7 @@ static void test_seal_mmap_overwrite_prot(bool seal)
 	} else
 		FAIL_TEST_IF_FALSE(ret2 == ptr);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_mmap_expand(bool seal)
@@ -1248,7 +1248,7 @@ static void test_seal_mmap_expand(bool seal)
 	} else
 		FAIL_TEST_IF_FALSE(ret2 == ptr);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_mmap_shrink(bool seal)
@@ -1276,7 +1276,7 @@ static void test_seal_mmap_shrink(bool seal)
 	} else
 		FAIL_TEST_IF_FALSE(ret2 == ptr);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_mremap_shrink_fixed(bool seal)
@@ -1307,7 +1307,7 @@ static void test_seal_mremap_shrink_fixed(bool seal)
 	} else
 		FAIL_TEST_IF_FALSE(ret2 == newAddr);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_mremap_expand_fixed(bool seal)
@@ -1338,7 +1338,7 @@ static void test_seal_mremap_expand_fixed(bool seal)
 	} else
 		FAIL_TEST_IF_FALSE(ret2 == newAddr);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_mremap_move_fixed(bool seal)
@@ -1368,7 +1368,7 @@ static void test_seal_mremap_move_fixed(bool seal)
 	} else
 		FAIL_TEST_IF_FALSE(ret2 == newAddr);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_mremap_move_fixed_zero(bool seal)
@@ -1400,7 +1400,7 @@ static void test_seal_mremap_move_fixed_zero(bool seal)
 
 	}
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_mremap_move_dontunmap(bool seal)
@@ -1429,7 +1429,7 @@ static void test_seal_mremap_move_dontunmap(bool seal)
 
 	}
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_mremap_move_dontunmap_anyaddr(bool seal)
@@ -1463,7 +1463,7 @@ static void test_seal_mremap_move_dontunmap_anyaddr(bool seal)
 
 	}
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 
@@ -1556,7 +1556,7 @@ static void test_seal_merge_and_split(void)
 	FAIL_TEST_IF_FALSE(size ==  22 * page_size);
 	FAIL_TEST_IF_FALSE(prot == 0x4);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_discard_ro_anon_on_rw(bool seal)
@@ -1585,7 +1585,7 @@ static void test_seal_discard_ro_anon_on_rw(bool seal)
 	else
 		FAIL_TEST_IF_FALSE(!ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_discard_ro_anon_on_pkey(bool seal)
@@ -1632,7 +1632,7 @@ static void test_seal_discard_ro_anon_on_pkey(bool seal)
 	else
 		FAIL_TEST_IF_FALSE(!ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_discard_ro_anon_on_filebacked(bool seal)
@@ -1669,7 +1669,7 @@ static void test_seal_discard_ro_anon_on_filebacked(bool seal)
 		FAIL_TEST_IF_FALSE(!ret);
 	close(fd);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_discard_ro_anon_on_shared(bool seal)
@@ -1698,7 +1698,7 @@ static void test_seal_discard_ro_anon_on_shared(bool seal)
 	else
 		FAIL_TEST_IF_FALSE(!ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 static void test_seal_discard_ro_anon(bool seal)
@@ -1728,7 +1728,7 @@ static void test_seal_discard_ro_anon(bool seal)
 	else
 		FAIL_TEST_IF_FALSE(!ret);
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 int main(int argc, char **argv)
diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selftests/mm/seal_elf.c
index 0fd129259647..131fc13cd422 100644
--- a/tools/testing/selftests/mm/seal_elf.c
+++ b/tools/testing/selftests/mm/seal_elf.c
@@ -127,7 +127,7 @@ static void test_seal_elf(void)
 	FAIL_TEST_IF_FALSE(ret < 0);
 	ksft_print_msg("somestr is sealed, mprotect is rejected\n");
 
-	TEST_END_CHECK();
+	REPORT_TEST_PASS();
 }
 
 int main(int argc, char **argv)
-- 
2.45.2


