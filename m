Return-Path: <linux-kselftest+bounces-9318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF788BA5CA
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 05:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D937CB20C17
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 03:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FC61CAB2;
	Fri,  3 May 2024 03:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VPj7qMKr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214E9D29E;
	Fri,  3 May 2024 03:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714708271; cv=fail; b=Tj4wXWOlNoWoN/l3vPFtsDReKlJniiI1dbqJNxTESJt9rTJfLGGtFynQa0v3TLt9/Enh0KlzHgq2lsXGOIsLEBRB7A/hWX4ILu/bwS9R42OHSZgT+UfWVJaYrNSQlSjbk18+0JmVuCCpLy/Q3AhCjCgZBfwGTLus6SGK0BDTODQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714708271; c=relaxed/simple;
	bh=mVShj9zctXUUC8C9yCT+Gcw+c685gJWMD1nlaQSf704=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SYzY1M/OnW2Cjux43dMGU08JoJJ0n2pVsKf0ubJsroV7dzmhN8Myt+hs76kEUB1dSJCb2ar+wS4oAgBMh6UupalqTDukdP2BFFWZhRueMk8G9oMdd9TJ+WMLobhvk7tXIb4k1oLGLYJb2M8z11ql0Xdfv6+JPFKtN9r49QQ86uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VPj7qMKr; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXbrS/PEnYoQNekmNwvWc5hlcaQDXWUcJ7txwDVt/5J/APMXLnDR43OpF/QoxWAYG+slmZf0bH6Z7ftTpHILM6UH9m3BqLoI5T/HhtHmKs97GWseNCxHc0mUzPSHRlxkVv0Jceu1vOlJ3cp/vs2oZdRHgG1pj8VgvzGyUXGWHAzwWliCzedXF2eEO007H4py5qtJr6Cm6AnBvUSYb5wmw+9LTNyB8FSva+f6i2Osj5bvbyYU2xqa80SoOl9+IdKX+GlXxzspzi/86KE8gNFkealOAq1RzOkCupmj9/ZAKkWZ7E+IkbxtY/4cdfE3ttF6UAUAGvCAccueo6iZfYt8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZB77OPNzCh15kJp+Y9rNy8rErkG8bGA7zmFOGE/sIQ=;
 b=ZH4qr8OBKyENiMhHLC5J74BaAgXsdLyUTAbLDGLa1k+688slcxM6X8uq6TrphGI1M/KwPaExI65wPDUQlQ8TOJXcZU8h4foIGtgBWJMFpGqtKuYBLpcymus1yc9XG50BgFZdoxaPTaY5qMJZvVlLyQke3bjWldeqJKFmEqBe7BALb8ksWhoJLzhA+tiPFOoZwXs/80nzJmhghaD62UgWOywhXJqgI+m2INldOIe1+vqNJrrnUbGA4dYWjsfLJ7wshP3pU3DouQFTgyTrAAOJiSVnRYpKZSvfyovTOR+1ZBBjBLMHe1EDHrWrddDicxBZ0Hew05UlZ/6TjVE4emnlaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZB77OPNzCh15kJp+Y9rNy8rErkG8bGA7zmFOGE/sIQ=;
 b=VPj7qMKre2rcsWiQz2gCIOQ3pwjGVuYQagFambpV1zUKP2sL0dbz84764O4qsBqampKVWjMGqVTk9b2uu6mUJBd6ONX+izIe87J8CnKk130jNlVlep6a5v3tKYD2y/XRPQaSA6Bo2W+6Wug4Fc3Xv6WL1G890x3xDWIY35eJabtTuG99F3TmB+19pKRnsuuMxQFxUR54SrbsfEWL6swAGbkm1TXMr98MdT2mLwtgyw0caEbFQgCqeTd8btZaZ0jywKemNUWXYthyjVj8JGOsFO+qXTKnb09bbZecIrjiyB8LT+ex+BdvFBfRYSbi9Yg4Ga3hOW9rU3RVoV8BBf9vJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV2PR12MB5941.namprd12.prod.outlook.com (2603:10b6:408:172::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Fri, 3 May
 2024 03:51:07 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Fri, 3 May 2024
 03:51:07 +0000
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
Subject: [PATCH 0/4] selftests/cgroups: fix clang build failures, warnings
Date: Thu,  2 May 2024 20:51:01 -0700
Message-ID: <20240503035105.93280-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0096.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::37) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|LV2PR12MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: e63b6ae9-1055-4033-7ca5-08dc6b24437e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zCTt9BguvNbdlw2FkTz83NY7e7F3sPihT7ObUfEX1KYW0XJzAPGMgZphQWY2?=
 =?us-ascii?Q?PINiUtca5WkOm0kGLdjoM8JD/pdaxNFfCZT2gOcoDABV1gTanDtAxZXZZJP6?=
 =?us-ascii?Q?ykCPBg0sQlkG/z5mp1XT/WLYyVRALSMmC8ZSY/02aFLeqWrrEsS7qLoWO3U+?=
 =?us-ascii?Q?F9Fvwdf75T/b8wHGa5n6fcfvZcnDP0J6J33SGFX/eY8BfLnC105VbEf9tE3/?=
 =?us-ascii?Q?aip/OD2Q3BpjV1dnmayeUDXCLF1MVBibTSSiu6of4kKP2lOlFPIQSAdr9qo9?=
 =?us-ascii?Q?GH4aDKeC16VahjHv77QEsEzCeJv+VLJ0dBtSXoU+a/wQ6E0jOdNX8cKo+s74?=
 =?us-ascii?Q?087u38ThQWynh5HPUeTjgdOF7xDlF3kVOOZgh54mhom0ysNjoc2fOVGIAD44?=
 =?us-ascii?Q?waVqrTapltv2tTuMogLe2IMF14BQfTUhg7N35adslabXxythgfTgqXk+/zGG?=
 =?us-ascii?Q?CHj5Gel6egkXIF+upFkZIK+7uCWlV1DPhbtaCU4y46fAIbUqTuskeMmlQc3c?=
 =?us-ascii?Q?3x2i4jrhgXjJsAqv2HfLFxf5S0ISdafqBoVh77ekkKkXlyUrBGdsoSt/gUT9?=
 =?us-ascii?Q?EOLWETeag105RiLakYSQ9qJv+zUzx1Db27i8gd+VAWNg1LcL3yr8YSnvWtoL?=
 =?us-ascii?Q?+gMfFurTOHWccB9tF1eTAucCBpy5vnM1odU0AUUIR9SAP64YZLukO7E1PEGZ?=
 =?us-ascii?Q?mUWE3vi+EOXTYx3bjD3STV7Lk0KhxNmq8FUJS93yHVcnqgIQJmwB0PVQiirE?=
 =?us-ascii?Q?eK4Rj3Eo62CKZ8w1w+UI6EcJFkYxVebC08INhsyiRMFh7d1mcjSakuOuoUQf?=
 =?us-ascii?Q?O4T1W7b647bcu8hUinUJ0d/tJf1NgdTkQa309s8tUelZ+mws3RBcFQ11j5Xx?=
 =?us-ascii?Q?VP971Ei3lI5/dg8FPv/w2hCMltAZ1ihIRGlu4OH8CvFTZyCWQYoDEbHlOEhj?=
 =?us-ascii?Q?YhAREQe+NgVWZSCZ0E0oVcieDZUUYh0jPlKP3tkItJbh/HI/vqnD/pJmm/5V?=
 =?us-ascii?Q?+UWPmFt0LbbpumXFoG2Hddmr69v+4cjh7k7Ehn/XAv0bXO+CrwYzW70Th+xR?=
 =?us-ascii?Q?UpTUXM5WCKKlHgKVu5Ore75VtBpz6YSTsckdW4ZOai0OZ+ra1bBtbNms642E?=
 =?us-ascii?Q?iPxdvJ//wNwb/FCAkoiJisE0J29hccyWagDoMn612own/kbxVk7vyewlg5RB?=
 =?us-ascii?Q?l/zFYKSG4UIp57K+q5786vOjxGCwjwKFVnRExLGFvke/W4v1LptCXD2byH7F?=
 =?us-ascii?Q?y/pX//DBpG5ZzK1zXE7MQPqhb9hnP2C3GEH4/C2hGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sGWfOUnz2UOA1/KK2LolVIj0CJYSJJddP7J+Sc6p5QxaPbhJqUu5F/OhjcFt?=
 =?us-ascii?Q?bSY2bnZCNF01s6wTcQknb4mV+CQFZDMcJ77E5lf2aLLrb5yB4BuNCK8YIJXY?=
 =?us-ascii?Q?LSArSnbFD4vfuNMXbQOHhjnHUP3EUhiLsiqy4TRQ03bdEsefvQ3uIzc9z7Sw?=
 =?us-ascii?Q?XCDLc8MMcFi8L6lJ0lU1bATzmbqF49sW79Dr2An/2LKLgnRXBpfjZ4lIb/ti?=
 =?us-ascii?Q?Fa5E/DWV1DfeApKWkwkm2YXRcmQNEdFgDChMvCh8pelIl4T+8dUKe75+JgZX?=
 =?us-ascii?Q?lsovtlzRxIo7QS9bZD7ocrnLerSYE+3vbw/qnzvKnBy0Pa+G1wLSHeNnWzKj?=
 =?us-ascii?Q?6f0JzKG0mNmRBF8G5zNW5BuVf9HOkQyryrwbu7g2b6bg22287F0l6Vai8ahZ?=
 =?us-ascii?Q?zbKRyPHLqgmIBc4fMAIcBNk3DdYIUdknnIdIhth2q1wYgsNkTKqnGu4drBMH?=
 =?us-ascii?Q?62tMCBeXmxiQ4ed9SHP6qIBMY2a99Hm8SsAzyCsT8svYElhLq9/mW4hH2BfC?=
 =?us-ascii?Q?xF+4w32OqodgBsDH7b3juZNMputnp0uLr76y69LyGyoJRGtpMRG8Q0gzaDMD?=
 =?us-ascii?Q?k31JZjDm0/XsNXcmX53ywsbxPPmLFqFHaUZsDQThWIKh3L46W2vKxy3Hqlgv?=
 =?us-ascii?Q?EctnwtC7ltaG0s+WqAVrufCnJp3kkszdj2LAuKLkXW3zaUJ1wrI1lSRRhehi?=
 =?us-ascii?Q?1q9dn9kjRkjo0DQyvyOmYqjv/bUzXQLs1eH59oped1/Fxo84BuGdWgrSErTZ?=
 =?us-ascii?Q?CA+eZAdFSDFSRZ9J9PSRrNdoZfAjf+EAJKtTEjOTCyeO7jasxm7M5ovWTBs5?=
 =?us-ascii?Q?RB9U4CfQp+LWOcN9VrKAdaCMMJZnQDbX+Fz6jZq0P3p8mT8WqnQa8JJPrTi/?=
 =?us-ascii?Q?CM2Xwd5SXxVqGA+Dkk0BfpuLi/MqgD+J0/oV4gMJkHXUGGWTla/qTO41eUKw?=
 =?us-ascii?Q?x/MxX4ao8SKCpnLcr9rWmqTN45DV7lj6gVe6xcZ7OnPsNk7KrrAJnNL0dkYR?=
 =?us-ascii?Q?aoAAEjNEGfbzdbQWFUE1c9+XLXYo6GY5N3zBNf2fGkwqXnxyDzpFKV1yRSGs?=
 =?us-ascii?Q?7m5pRIt8XIwIfVFF1OvEvwUu84Ym+8WXyZwZqrPezC4p2PaJsjQ9VxaibzNh?=
 =?us-ascii?Q?4XXsIqLUxiGX3zVYQ5hn6wKNDMIru+RohJqB+FsVBExuQ05iUA25DO3FaA6q?=
 =?us-ascii?Q?vbzva3uL262068Ib4vV8Kwqua66rTIFHh0ugX5P1sjlCsFxJK2/5Exomhd8z?=
 =?us-ascii?Q?q1g5NDqtM2u7rtHEnoUSK/2QSV/rj0DWOFjwlKHZmXrmqkCjLuf1pYMFPg9O?=
 =?us-ascii?Q?3c/yTVBFE61wBkX3fRJ84s8UUElMJm4xLfTlRp5KM7C21Rk64bzxaLc91VFe?=
 =?us-ascii?Q?assyt5+rvttiOkVlCBDjM7A4J0aZWMGUWp8KscE11DSN+kMYApU1th2on1vW?=
 =?us-ascii?Q?rDjsYYuGsN2HI1OltBr1wCJv1IFKSeFKfLSk3N4+GQMg/zkNIcNg/LS9gHl+?=
 =?us-ascii?Q?v+hGi3MAGkRnoMi0fmajPHgQYtO5pW7XOXFZW5PqO4gqzQFYQWNW8yOhvY1C?=
 =?us-ascii?Q?AHTiO8SWOhlFsurYflT4LzJ4mwdgpTqz6fQ9y8kP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63b6ae9-1055-4033-7ca5-08dc6b24437e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 03:51:07.6070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgKz3ptq2IQjSPIbXMA/IlUnJlq7ux9pYCdXniORCbtuWYaKyoYkTZ7ZW/ZkOvjjZzAT7WY+UmT2QL30jTIlOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941

Hi,

Just a bunch of fixes as part of my work to make selftests build cleanly
with clang.

Enjoy!

thanks,
John Hubbard


John Hubbard (4):
  selftests/cgroup: fix clang build failures for abs() calls
  selftests/cgroup: fix clang warnings: uninitialized fd variable
  selftests/cgroup: cpu_hogger init: use {} instead of {NULL}
  selftests/cgroup: fix uninitialized variables in test_zswap.c

 tools/testing/selftests/cgroup/cgroup_util.h     | 2 +-
 tools/testing/selftests/cgroup/test_cpu.c        | 4 ++--
 tools/testing/selftests/cgroup/test_kmem.c       | 4 ++--
 tools/testing/selftests/cgroup/test_memcontrol.c | 4 +++-
 tools/testing/selftests/cgroup/test_zswap.c      | 4 ++--
 5 files changed, 10 insertions(+), 8 deletions(-)


base-commit: f03359bca01bf4372cf2c118cd9a987a5951b1c8
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
-- 
2.45.0


