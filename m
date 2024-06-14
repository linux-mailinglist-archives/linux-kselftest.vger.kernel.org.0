Return-Path: <linux-kselftest+bounces-11911-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5774A9081A3
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 04:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D260B28404C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 02:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6A91836DF;
	Fri, 14 Jun 2024 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qZUI1UpE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DDA183097;
	Fri, 14 Jun 2024 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718332223; cv=fail; b=AZbfkAsgZ/K9OmyZKhRfDEPoczBKLfLhOc8vNPvpYPlJfGR9B9iXrc6f2sv2zXCoj+DfJ1kdfmyvlBYV6Y9sZfzJiVbht/HuKH0XCotnKeV7U4gRiXQXaNKd26tEifX2bwUJZIBmI5dXB//XaIk16t+O/0D8zVmTT7nMNprZbHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718332223; c=relaxed/simple;
	bh=TjFYh8xk5i7tftgztRAw1br9ljng0w3MWEW+D2AcbGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fez3MfQCOqExX6eg05Ef29S5ghbfLeNfxYqGi1xgpusi35RznhLUGaxHE3Ap5R5Vx0MGXBQtsyCbku6z20AJsChykUqX3u8HjY1UB80JhVqku2avPk6mFbT26k1i0h0VVGSiEK2TxIjkBMUAP0wCyhFhklhs56Ab3SYxLfxZiwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qZUI1UpE; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CT2B5koETb/7WXPgqXWSetRWCSStayy6WOp81tjv6034kv4nGNMujkOkahQdcImJv/EXC/cEkFlub3RXQZW8Rlu0cn6HMymBFZvkXSgpNypSLS+nxhumD5IfdKNJG1MVihaXP4lZrawhjWf14TZMicWXPPXEid+Nzml1QAOZk2E8BfltHR9RG72vJzaY3HPUlatU0SGmDu3MHXGyEL+D1j6fSstuOBvT0GyYNi6/AhxoCApFiBTjTHTOS/nLdP5QIYjsvFvKJ3KjCoiwW5JX7ko1tyRBBZE0CcgP+Sg6EoNq7ZgtyCjYqtlZw3PFkSgstA0Hs0vdg2X/AbBMr4IWfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELhIipCA5a26Y55PWno65iZaFhnhGz7WGaf+5hkdpTo=;
 b=JzbeE7g5Cx1gus6nk6KSW3ml3I0SpV2bbc3D0K0nCH+8NFRH9z5e7FbhSyOYRzqj7q4jiwfc2/sl/uh/g0tI3NEGU8fqj52nPePB1J10y0lfbOau1UHeNROaVttxVkQYhFxSL6RU0HyByxxu7sSoZC+4QjT0V7n9EITf7NZHTh8yDfwZb+bw4YCfJmZS8/QYH92TnRcB5v8HTKNaCQ+A4J73KcCkJEVkBJdh1DBbXhuXA0qJUYaS1xQ189OAVW8m3XsViATvfosu7LZSpW4OOkutsbcxu7OcnXETUCSMUI39KGKj+mzuTLWupYrtpPLNw4nZgInEJXB/stJJp6iNrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELhIipCA5a26Y55PWno65iZaFhnhGz7WGaf+5hkdpTo=;
 b=qZUI1UpEV1O6Y5Tsq4rAOh2KvC7OfspeKVTmLthfQxiBY6QQvExLLBxqV9I4SAJUukevkDUoJ4ENkzXScrjATpWUfi+ghCsKepZOJMWKqYS69ffuIU72MMeG/2WVhG8TqY3tFu9zHzf5OuYIOLwgGS4qbdo80rFmorP/he/HiOT3qR6MEvAmcLbSnJhsBdq5NTKs94YVWeTVIZADtVO4QuJ3GiWZomsxNrPp4gkODJjfMQxvRbMPhPHZINLEU5z+SjRCB0lFJOFOdMywLlPmkck/6Ru/lKoxzfsZ5Rz6uNBeKYbdtiEzn01VzDwMH4UFnvwLDOwe0DLpmIXCJu4etw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Fri, 14 Jun
 2024 02:30:13 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.037; Fri, 14 Jun 2024
 02:30:13 +0000
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
Subject: [PATCH v2 3/6] selftests/mm: mseal, self_elf: rename TEST_END_CHECK to REPORT_TEST_PASS
Date: Thu, 13 Jun 2024 19:30:06 -0700
Message-ID: <20240614023009.221547-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240614023009.221547-1-jhubbard@nvidia.com>
References: <20240614023009.221547-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::9) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: af80fed2-942c-4623-3eed-08dc8c19eb4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dBl/ZrVhVT1l6i9DSDzH8DhH6vgINbBGWkVtZkP6qyaSPLjHsyn7vDHAi0f6?=
 =?us-ascii?Q?eHhdU32bhFmkJQOdkdEV7TznP2dDnTw7gL7yVA0fQBQFQ5riy5eJuKnkBQZN?=
 =?us-ascii?Q?L3K1d74Zw78g36m0t7E7873gg/hkfvyW6GNwkmOu5x/nSNa0JX0lg2kOfukp?=
 =?us-ascii?Q?oNIsPrGV06DkO/FYIplOZ6tX1qOtjwiWyH7OXgvjPMXqfFxTgC1000GAHsFL?=
 =?us-ascii?Q?oLgV2zBfyezz30QyttIhQaJT4Qtd0J4mIe/uIuXFpckMehT9LqOKnheiDg3R?=
 =?us-ascii?Q?RdUMmMpHU/OsE/QcKuBNEhVjr3RF93giKdMR31goBbTJ0K2VCr8JSU/Jtg+f?=
 =?us-ascii?Q?kZWA69VPg+PVEUrm8cEsPgiTbzaqwrlBy4It15muXOEuvlWiphkRznULMoli?=
 =?us-ascii?Q?u13w5bF63w93df/k/Mv5xdnz92ueWeiN4vm6baDIVjJH9fBv275/tJFDBi5h?=
 =?us-ascii?Q?15m1l9ZZxYJgbShIfHY2U31JJa0dhP1YC+rYZfSzU/ekjNcjgjqmhOmPfetk?=
 =?us-ascii?Q?TTBEEKUy5HQSWdmsPRIcB3hVlqo9PQ7GMEiZIoQFSauW8THMpAnaKi92i9dQ?=
 =?us-ascii?Q?VpKrhrPimW/+j2o/RSOBsA/k70FcJh52MyOej2I1PPngcAmNfuSldQVZxodk?=
 =?us-ascii?Q?gvBzbEs7B4PbpT0NPRcjKxffPZ8fzt4Zp3Yd87RQUUlIq6kKLTR+4DcC0LYA?=
 =?us-ascii?Q?e2nmCAZE/bcWul+0sWcoKNzwECN7UobDf9gOTjFs0IVUZAox5+api0yKxUEf?=
 =?us-ascii?Q?ixIas3Ozyp3Yf+eB7SxjsP+wojk6D4L3nsbEmgt/PfEhGzA6KdW13nfFsOx8?=
 =?us-ascii?Q?jnIwkYT4onOK6r3r3t2lggYyLNDVZclvILRotPxz8nKDXqj8IABPeDqJHYkw?=
 =?us-ascii?Q?EQhcPLfUxYzdHYqb/krrealVQxAfmfD4Hy7QhswOLWkfyrMrzQa+wznh2Yq8?=
 =?us-ascii?Q?WQwj2wVH5Nhbd9JGzOGEtoCTldGOoyO5rNhHiAlLi9tmXgXL8bbKYdTmAKur?=
 =?us-ascii?Q?xmpvHiI5Mn0k0Xg+1vjD/jY8LmKRrLsHH9OIiKCi1jQma8Y4dU/eC7MMaxX5?=
 =?us-ascii?Q?ef+tnJwZ/u5AbMEKVTqnlgxqUwhk+ZygpwHRkziwy7TnYQ9zD0fQR3TZu2PF?=
 =?us-ascii?Q?oX8Uuf5VXDOSIvjPj6R3q99DLBVSiqAl7FrtETgexELENghhUI2kK2X/6Kt/?=
 =?us-ascii?Q?OKCe9kWzb5HUzu8xFDcnhVm7VIR4NjVw8EbkiISnq3dfre9V+FTlpw7p3/8e?=
 =?us-ascii?Q?wTIOaEwCqBv5mrIL//6azGHPkGx9JpzDrnb3i6RDvqdV+zOQfJS3qNO2FZx6?=
 =?us-ascii?Q?bJGvqCjjmv2/bI7XpqfMHAFp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6AWFnYCNzg+L2XlXDOSX18vivnKz0xs58pqLhnkxmRpRs+PAtg4yr2HRSzoK?=
 =?us-ascii?Q?GjZtyrOk+ffvuRcaJa0JuwjSoGoXrNpdqroAGxErYnovexKvmEswHVJA9LOS?=
 =?us-ascii?Q?7naNPB/wnWsQs0jhaZoZ3Tjfvo4Y4/BmVo3wC9wvqBeoHulVDdWrb85iKf1L?=
 =?us-ascii?Q?/vigZAPbaIXJU9AWT6narvLYmIe5vdJOjEwsXjlwKGaC3iMd+xc38PRldXtT?=
 =?us-ascii?Q?LlsscUBznSTR6m9qYEHs8QsY14jr2o30NMTuvM/LGMnADbrmCx09ERWPH4g+?=
 =?us-ascii?Q?zy4DO7xC2xvXK+G8eMPfTz52/a5CMErohyge3hO9f2GZFzNI9fP7FEpFJ51V?=
 =?us-ascii?Q?cAaN51Az+ZiXVaXyCI/YP4m9a56gdtDJ4kxmNAqbyxkCaBZXYEIP2RjUzoIp?=
 =?us-ascii?Q?OAAqySUa2iAubzIexUR0ljK41lzwsDxKt9oJ+dCg79D/ORpRqKmyJLmY+yuV?=
 =?us-ascii?Q?OgEHIox1FRM5q/Dv95leKRm9Dp9BE+xHwm8IRABYdpHdXBdEjTrQaLbZI8v7?=
 =?us-ascii?Q?9xX+Cxr7FtxJFKaKR4kTh37EvoAY//nCfoQlnDWMSjF/2WLDUf7GBeL0oOiU?=
 =?us-ascii?Q?oKa0Vwx/8SpNrrYJTpesa7FI8cm3MUZ3iP2jEW3hjvNOts4SvMlkJ9jlWfIK?=
 =?us-ascii?Q?VdXSm4qzNlbNYR53hEUZ6dLBSMBVvGDehe1Abvg/OFdMwPL/1khULi2Re4J3?=
 =?us-ascii?Q?NNjVm3j3cMfQHTgQNqaaNVH1hQGEWsf2z27xV6zIx+BEdPkHqFGUk47CQcRg?=
 =?us-ascii?Q?4KFIiQC6SI079NPrRTFf5YOtC8SjBClvbwWoBeH0A5NgvYpRb62sdWZL4RNF?=
 =?us-ascii?Q?hGX2rcNWjS/DjJn/zmLHAQAVEItNtUnYN/Pp06CkmUdjJ18+LJb6dKjwxmf1?=
 =?us-ascii?Q?rxr6lUOti17bFMYF1kWjgf9gxBXE6+sedDWBPIlVRx5l8CWvtlobTm3mxVEY?=
 =?us-ascii?Q?Lm6w4dUAzCUSOncl1vUbpYcIRX/026h1FCzkq9X8qthW9bPnyOIAktbRTW64?=
 =?us-ascii?Q?mf6Me7qoAaNRWTil93jPK0vpkJX5k1eNK33xub1Xo4a/oWz8+eHax+5WACIN?=
 =?us-ascii?Q?T2DYMhQ0WQdfeP1I/dr/3u08g/Xzbas7zZEZIqhWo4E/EyTpwthg4trfTaf5?=
 =?us-ascii?Q?dC1xjv6NMzKp0KoNG3WpJsy4T0CO+DpxzuFEh8ITVi7bjxcIU3cRizjdu3j7?=
 =?us-ascii?Q?BXYk8D3b+NHm7lB1xSZCIQCn2IAoi6WX/ezaCiPyfxl2eQ9AkpZrRFkKv0rd?=
 =?us-ascii?Q?dMmAmNCNx1Rc/nzsPW7EP+UYQZrHTVfHupQQb8KGAJ3dmwEZf3+9p69gEV5u?=
 =?us-ascii?Q?HkaM4P9Jad6XXb3D99C9xJq2HstRJji+FMbKkPvnPFmwcy88I1A/RsKEFEtq?=
 =?us-ascii?Q?Qcpx6H9LXDR1fmREs/7tK5kXrkDho781B7yilgISmP4HeNNk+Qjy5BYYz86k?=
 =?us-ascii?Q?3wIrqVnDXd2mLalkHf1PZMdHtOD5i15JjtcRlIntf3YU+PCL4gg2+1QDc4oR?=
 =?us-ascii?Q?hjEL23X1rEFmp36RgEkyyZ/UsGlCQBgSbvLHHqVnaUzBIUGnMSyv6WG8J3nd?=
 =?us-ascii?Q?xhACm/vQJ/5of1VZ20e25jWxL6Fm0L6+yEZdDBrd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af80fed2-942c-4623-3eed-08dc8c19eb4c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 02:30:13.0775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: giV4Hpf7QEEvwidWUQQj4Y8mflKYyTW3ehMilVPpXstD97i/OkrSVWLZLWuX2Stmor/zyhR+8utfBwfj4n8O2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932

Now that the test macros are factored out into their final location, and
simplified, it's time to rename TEST_END_CHECK to something that
represents its new functionality: REPORT_TEST_PASS.

Cc: David Hildenbrand <david@redhat.com>
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
index a28912fbecab..a556b7e51caa 100644
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
index 7f6a95613dd6..619da94b9f33 100644
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


