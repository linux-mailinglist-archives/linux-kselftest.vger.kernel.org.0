Return-Path: <linux-kselftest+bounces-12113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920BA90C1CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 04:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BE5282B79
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 02:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102A81CFAF;
	Tue, 18 Jun 2024 02:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I3IM5Y5i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B9F1B94F;
	Tue, 18 Jun 2024 02:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718677476; cv=fail; b=jPoOhLqSVMv8BYFdTV9Aw0ZLmf4dIFb7WYioaIyCw2rodyKdiajao4SI2vkbUVQXwwMEnbLW3WetVkkRub9LRjJM3C5Pvpw3PbgdSloFD4/H+XTQb7FPLna9VBttlKMRfuhcyohra/SnasmNiRDWZxpiNYGXFIzT8Z3wwCjy6O0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718677476; c=relaxed/simple;
	bh=FZrf+gNZtLWOihnJW5hsoQWtglHIcoCDdxtWhY7bF3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ax0o3x7eNIqX9fekot4XLCBw3PI+jGSo6GPF63msuTZ1gOt/GPvYYRDhd1a4d5g4b5xRkkh0Do9h0bYW0zK1qlRa6c6KXe641WRn3oqXD9JoZxJga28Vu3Ly6PHtSiI9iHMk99hV1lmA3Mcx+Rzf+4xd7JJZTSKXQutnN/jOR9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I3IM5Y5i; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zlqm0xIOD2EYl0sRt/nU3s0B2YDUJhaSLSTUNGXqiBeAHzK8ddb00uuN9+4FBa6J9B1FgG5zs8zCmJhpgZz+jOLDffQkk/jBfwvdEDzJKFyfz9VGJV//9A+GBjjYWhUDH7eqMZPacAv+90NQBGygkroj1Lf68ZewSUSJmU8FJ0zYwUEpepxohjtRNiQM/X3XZdELoiTTstxoIHp7lJA9+CbSbjj0D/toHemlWIMUeQCLFcqpR9K61wmV+521N8g9YjJz6ydWbb26fzJXIbA3eg3XM4Gj54ZHJf0HPyOr1eyJ9GOwAnWPQOc98lSEBnQKjCMPfO+WGRwSHRUrfPDNRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHCQG7BggPiMHbTnE22zLbGUpD7QcsjBk3b5b+WODUM=;
 b=RbjhgOfOjIX3jvI9/d1N5pfy2/aU/klZfxeBeALbsGN6Q5O/USkws60yefx8j0lM0USMn2PXGjfmF5k9uLuBD5ckmf1SMJYYX2BlspENJ/n4LI3ewFjfP0aotNx6oImN87K29V2LNSNlZcqpTuktdW26oh9J8ixmZaQ138dXTogf/OzllBDDXGF0rWd35/durWXzFZ2gkaH/5SeSJ8W3H/TzuLd+S5QFwco5fAPen3DFDuJBrJfcL4V6VuRyRVgeRNHDc+CI27Ke8sSWprwSQkJaVF/XKT87c1lDaR1fVnEE1QOLwA5RmVzYYULW+zSjAcNsUuMqCEQ3xd1A4rKcCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHCQG7BggPiMHbTnE22zLbGUpD7QcsjBk3b5b+WODUM=;
 b=I3IM5Y5imljOvPsj0Hgha5jWWebsQfclfXF+sqVInZMdQoqcUdjgWMe8MgvyTnqPBEWlwen7kTMlLJWvG8t5iLSUAueIORnd8ER3tvMmZxD+S/T+dT/HP6KYupEp/LMcDc4IW6RjWYl3QgVhxA/7e5Ej1aDZrOC9COVyWlA+6WiZ6aMlQaKkv0SJ7CmIozHLfQfy7ysRI2y+vlQiYETAfDHODtF7hRRYFLap8YMwyavO8OY3H8ezo5vyClmLAWKnav2o8d0fcFBB0TIw8Cbe2q2GKRknlKWufglQ1cl6I02vFb8d+GsRhb8oLUo3oDkPvRhAtD3iXF0NmSMfio92LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SA3PR12MB8047.namprd12.prod.outlook.com (2603:10b6:806:31b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 02:24:26 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 02:24:26 +0000
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
Subject: [PATCH v3 3/6] selftests/mm: mseal, self_elf: rename TEST_END_CHECK to REPORT_TEST_PASS
Date: Mon, 17 Jun 2024 19:24:19 -0700
Message-ID: <20240618022422.804305-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618022422.804305-1-jhubbard@nvidia.com>
References: <20240618022422.804305-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0227.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::22) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SA3PR12MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 27699c89-858d-4ad2-e2d9-08dc8f3dc65d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7+LjVT+lIYYP5u8X3wfF0ZmDdqU5zdxzr/WCYaIq1PXlYzGNjnbJzhLYfelv?=
 =?us-ascii?Q?GXQYdpTqbr67WaCP7Uj1EOOPSW8CwIFW6vcvMvusBbSWME1scNXp2rW04To3?=
 =?us-ascii?Q?ghGX47I/4XiHo1P4KTp8V0ffy2fAqqK3hRmaR3urqERFAlRVD/pDvMTZMkX7?=
 =?us-ascii?Q?wrQamUf+39m8LtoEqyZQXFApSXtL6KtYbz9pBqRwcREs6b5YpoIlYGuO25tY?=
 =?us-ascii?Q?SxfoigrSDdcmM7c67pnR9Wc9Uaq/WnTjs17JixO6o9NzvUs5u2qdXASIXCMz?=
 =?us-ascii?Q?XLSvspn7qFat2JrD3nWusa9zml3yJBJgZ6KYR9z7fHHdvA0/QTyrJRoHDVsf?=
 =?us-ascii?Q?t2iaznr0s0y0vkPombHHGSrli6ec/105g0HzIyuSBEaAsWhlrqC3SHnnoC2T?=
 =?us-ascii?Q?dpiNm/XqN7jzIDpmEAI8xHBgOclTrgk0Dd71u42n3hRuzXoPO9G1g7tiPJbz?=
 =?us-ascii?Q?qUQiuUDu25x3koy239EGi/nMXMLkw8Du5q5/ffDhCZTsmaXUgLGh9f0lK87B?=
 =?us-ascii?Q?jFY1s9WNp/3IzcR7MmgU7LY9cmH5MRmGpd0G95bBmAk95yhorUJb8BCrE9Yx?=
 =?us-ascii?Q?BzzWaZHaABW0JOGf/rq2hvLv5VXC5SHbVD2Wkp4VvgwhaNb6cYK4gi4da0xo?=
 =?us-ascii?Q?hfvUIIP3QKxfNjHSM0XTfk23Vk+Ma+dfKh4UtgMPZlLuecum6rIOBnzpOfgW?=
 =?us-ascii?Q?3RldUn+Z81E1uMFAzXHbsnnwGUoY2c4Gwlqk+HIuDjZC/lsQkiIUSlfz4ILV?=
 =?us-ascii?Q?6PePe3tpzTx3Em+iq2KQrOYcAtFqYOvASII9BZ/ONby8PZqVx7bxqnUUOPU4?=
 =?us-ascii?Q?IB+elq4ubmp6feSzn2r0eNmGTPw2m/DRCIuAi1gcxLmGygz8Mir9yXbDHg6q?=
 =?us-ascii?Q?Q7UqeVhfl8ptECdftBnDBgfl9cEhYi5NSlwNrGog8krf1xBnm5Je8fktFlP0?=
 =?us-ascii?Q?Z8eRcKdfLtAdd/NUKvvX0Bfxeud3uvvRz7c7Ftv4C8fwe+hNxQ8I4aL1Eo2L?=
 =?us-ascii?Q?Tl0Ghh+LKn9n2WK3HyevX/sL8IZUCIv63xqrzSMIpiXPdjWbrRHnDfx/GLaq?=
 =?us-ascii?Q?kaISeRUAyx861MqU4EkJ471Y7pNxOkqaWhopyS2cQqUkAtRbvLJ19Ghlpxa/?=
 =?us-ascii?Q?FVGW46Gi29v5PWybS8ywIIVdWFeM6nLeZh52ndqBdXEClppQT9802XronDSW?=
 =?us-ascii?Q?HtitqckbwX2AWoJm1eUDMcEYhlV7DNARuATCnTn9g8qBXDqZ6RLzcgBfSdkX?=
 =?us-ascii?Q?mkQxpDcwkhhADg0WCyukrLDX25abUjon1dRD9hRxgYytKBhw10ok0w6+xAq+?=
 =?us-ascii?Q?ZwdsSK04Lq2KzHs16JFxn/Xk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Bi+m7dPlk+TTZxtOGngp9Dm0n0kQABKyzDxoFdFjH5RTRN+byTBDV76Wlpu?=
 =?us-ascii?Q?AH4nobKzQSDEsb4czcDZb5AqzeYhGrOtG5MFv8AOjYHrK32sFmkH1dM7Di4O?=
 =?us-ascii?Q?ruIZqyAE1WNCbgTVJ+Ef30pbItSjxG8apzFX4zYgKwKBs7sKFxX954z4rzO3?=
 =?us-ascii?Q?AJY38OsCzM25bQsVMB79M1Cu6/erjDt6EWa87pGzniskkEFuNQv5QFpDZQay?=
 =?us-ascii?Q?OP7rk+mbftOlusNpsa6FC1jdBiBZsgqnV1gkKjQ1Iv/QDjrzZUTu1h+Hd4kd?=
 =?us-ascii?Q?Fus/63PWg1gJPuU8aGPf3nkoeAPpzoD5K678wutkkUZ/oBCU32WmUhybBmQt?=
 =?us-ascii?Q?69sMlFIhbhgQIQOCh/2/Hin8Y1EMnPTmSX5sU7ZMKUWjqW8Q9BevfoTShZm6?=
 =?us-ascii?Q?mab1zt70uURso2oMOruAY55wBw02TR3o0tHuziOmeTv5i+XwlcZfBvP9UJl3?=
 =?us-ascii?Q?6RGvTuLTghcQ3b9oxHypuSFSfsQ/1aLjwXGwHSPlCYf9mHiJKZdNGQPQYFkt?=
 =?us-ascii?Q?NY8LzZTIyBRSVvuOFusr4Arxg0egXnL3GuahVH3vm9AuFABV3mf16i1HxPCn?=
 =?us-ascii?Q?P5nUY5geToUg1ZDwTVlhoQkdFHEDL89Q7z4Gbc+1oAGgHl/x+2P8G6oQMag8?=
 =?us-ascii?Q?Lz5yHqTWd8UBYklvSJUF5gyOCVcVz80dOOmDZMfCmUDl5sZQ9LGz6A7KMFGX?=
 =?us-ascii?Q?zoctu5RbqBNFlio4y+7UGhbbf0tRXmynvzVUdG1i/5hNnUKC46UaBg2GHRZv?=
 =?us-ascii?Q?zHu161daSe/GQ41+X/bVIWSRgVX5EfBnsedr9ytfZcRI1XaRNXT8AECsqZEy?=
 =?us-ascii?Q?JIs+YsakQ+G88t8OwssIWOTQgkEUKN0lg3cWAQdxbQe+2WeYdV2lgWQHO1r6?=
 =?us-ascii?Q?RXqvXkrd4m2ovKr+Y5Cf4Tuuh0qO15Ytd71lINK83px13iC2STnASx3JOgbD?=
 =?us-ascii?Q?oa7ww9L9gUYyVm9iAOjdbQlBEjCRse4JLCQ+5lJlikcqxug8yamaLO2bzGZ1?=
 =?us-ascii?Q?6xJYbY+71Ol9d27QqllGAuAS6Zp/vESzBDWJVwH1+U7cxvEnlLhrmKY0qjvM?=
 =?us-ascii?Q?29IdbkPLQn2rfGE9rYdfkDsQ46KrY8SCsgDnZhZHjwFgB/8T3AM3ZU0vXkji?=
 =?us-ascii?Q?2burDqg9xQ5poUhHSq1j2Moc9HDheDy7Ltjwvm5/I0ytmuQza1VUIWORrjog?=
 =?us-ascii?Q?TeLbrqR0l17Oi/KdOzhhlRYBlDS/A2IYw1v78lddfSEUdEfrHAiR164PVKsG?=
 =?us-ascii?Q?DYH51xd9ynuEm0GUAlmXmAi18swqP+X12I404C6f0AiCmamPAkaov0K4Ojgd?=
 =?us-ascii?Q?WMrY9nU/nqIHGRUJi9B4/3WL4WvlHd1ipe62zWQJzuMP3iAVHNxv1XkxCcyN?=
 =?us-ascii?Q?zHzFmwVQv9ccRSdYkBAF2t8XLTsj+8itQQabnIBoXP/mkdDvcIBo+/flaMme?=
 =?us-ascii?Q?DDPjq4GzOZVD6LQXAzmsO9FYaMikhNCFOOAwJ6W5cSgJeFdemso/oKj6JTxz?=
 =?us-ascii?Q?Fb5JOiTKUf/3AF9K5rcXrYD2NDiNCXia+jgvPa5B1JxmoV1ZL6gIglsXlUqr?=
 =?us-ascii?Q?k34f2AR/of4+7wuHUuZxSh7jidXH+95G0tiZlSvo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27699c89-858d-4ad2-e2d9-08dc8f3dc65d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 02:24:26.4244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCbjcwiVbr99K7SL1c2jNWoGanYTIU66nuiumfkAxGQEmmqUAc8bUnelHr9xKryUPveO5WX7xZWPAxmmlpeaLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8047

Now that the test macros are factored out into their final location, and
simplified, it's time to rename TEST_END_CHECK to something that
represents its new functionality: REPORT_TEST_PASS.

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jeff Xu <jeffxu@chromium.org>
Tested-by: Jeff Xu <jeffxu@chromium.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/mseal_helpers.h |  2 +-
 tools/testing/selftests/mm/mseal_test.c    | 92 +++++++++++-----------
 tools/testing/selftests/mm/seal_elf.c      |  2 +-
 3 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/tools/testing/selftests/mm/mseal_helpers.h b/tools/testing/selftests/mm/mseal_helpers.h
index 108d3fd0becb..0cfce31c76d2 100644
--- a/tools/testing/selftests/mm/mseal_helpers.h
+++ b/tools/testing/selftests/mm/mseal_helpers.h
@@ -18,7 +18,7 @@
 		}							\
 	} while (0)
 
-#define TEST_END_CHECK() ksft_test_result_pass("%s\n", __func__)
+#define REPORT_TEST_PASS() ksft_test_result_pass("%s\n", __func__)
 
 #ifndef PKEY_DISABLE_ACCESS
 #define PKEY_DISABLE_ACCESS	0x1
diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index d4d6ae42f502..a818f010de47 100644
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
index 45c73213775b..7aa1366063e4 100644
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


