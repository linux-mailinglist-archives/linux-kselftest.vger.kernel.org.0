Return-Path: <linux-kselftest+bounces-9321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E68A18BA5D2
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 05:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D399283D47
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 03:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5098383A9;
	Fri,  3 May 2024 03:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qBQ/QICL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7EC2C190;
	Fri,  3 May 2024 03:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714708276; cv=fail; b=Kob3eiYCn7y7xCyXyx4wJajx+XjqsRE8fYFqFjdPa9rWkbp7JyeGP1by0AWLxh0s4kdqMx57TE7+gdWriDoX/CkMnZRNDjEqTYtenq3Gop2rjhFWAdI8OymBQLja0bwD7neXxVreyEzP+oKgiABZ+gzi6i9NXctgQjFVXHVQe50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714708276; c=relaxed/simple;
	bh=7yhe1LCaPrHq7LU4lyvPlRHGEsFGtsVIA2JMq8j8BvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k9ehNbHi8FqFrYpz/qDjPjBVEIS9p//JhQtOIjizEiJGIneySM4gtcqpmuna8MmmcwMInTGA5EZbUJ0pfQASiZJ7ESMZLDP2Ona3omxTxYMX5loWZ1La8IYRrJ07XKy2ydW/hmWEzt4o+JeeucbLPRrG8AcZsIMw/YQoSfZFZXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qBQ/QICL; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fg6NslB4rVTXV++znvdpS9FQU84fXsx52d+5JTLM0juwtEh7NZUSH6gW0LQG4PQEhhT6J25H5HYmXLGgFWlJGgr3GvQOabnCux3sE/j9kYez9BczPA/3PFpmS16GxEtmnRX9r6WmZ3soCOPokN2URFz8pIcHHrP9McfbWN9b7YtyRkjB2SEnCWli3wdn6zdDentGmCUFd/r7mvy+cwD4avOziwQYe9ooKXz/JwA+ecZ+PaVLrwrB7jqUSUE/T/GfDLC61MB29WIB61Ea44rY5JCU8QgaVHFr7RzJwWOsqVk+goOzZc9OpQ6eG7ZcEHlw2DRXLpzy4wf/UaXroy091A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4BRcRLbmLAuVmb5goOiogq51kSab7J9azMKA4MN2ZE=;
 b=iGDVlFuT4SZTZ+CHGCuLDuv/Di2aPvrsJ+WvEqNxM+19tOqtYegwU9txLizlvVFmlr2wsQzP9eVyfrQMGldMI6iYt8sXEngUzvxqqa9CH6QS9/+LbqFX1FAD8KSZxj1QIXLgsQAedhoLsl3YWQVwA+7RrZjUVm88HVE4bqp+79cZzvASx5mPB9QoV3F55ttj4XfGhnQkA4e+zSySqZyMBavlas09jrva2T9pNqfoqEBOddTmWrPPI/ArNsMZ0/Cecn6hjxjU0cPWlm3NtUZeXErP02f+bEW4qWUtgY1TQrJ0JtlB3dV8+F5kZJ0Yrt94CXCqDL0ZMbsCgAk/77bHBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4BRcRLbmLAuVmb5goOiogq51kSab7J9azMKA4MN2ZE=;
 b=qBQ/QICLRz4v8WhEH20tpPo5avMLqydq7efBKM6yeJ0h03NB6nWHpDzBJqHB5X+fBJlZjgw4hlH8Qw/qsHMPCS5MoFFiW2DjJxErapO0LQbFn8jxBE6106RZWF7A/V5iGofSEN+xYsvD8d5WW+xhHnkkTAb/euxVDufh4CvZ7gBHmGMKjcWfGH4COWwaarQOae+EAIHaEtrDr3dpxlqWbXILs8V1abtblhdKc8kHfcpbU5jYFdPM6D/OXiivWFE8hSFzJW/iqz/gHyJluQXflb7TO1JvxyI4x2khQ4xZe8h8XF4kRew9DTWUZCcp6esl/fMKa4CRkPtHJ0VQT0IPLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV2PR12MB5941.namprd12.prod.outlook.com (2603:10b6:408:172::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Fri, 3 May
 2024 03:51:09 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Fri, 3 May 2024
 03:51:09 +0000
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
Subject: [PATCH 3/4] selftests/cgroup: cpu_hogger init: use {} instead of {NULL}
Date: Thu,  2 May 2024 20:51:04 -0700
Message-ID: <20240503035105.93280-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240503035105.93280-1-jhubbard@nvidia.com>
References: <20240503035105.93280-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0077.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::18) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|LV2PR12MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: adc75903-838d-4458-3b95-08dc6b2444cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bqLcYowkM8TO1Khj8s3wt8AQJbe7P9RkXIWvJZVit5vT0SB7L/aySBOj4jII?=
 =?us-ascii?Q?t017x9t6hoks+bJ0nm4INFDf29Nb4agHWWfSFfyY8BIR0hlw3gez5abnl+/b?=
 =?us-ascii?Q?W2xR8RbuNr7/33ZKeOgnUt34fiLDoKqqzu40mtjVQaN1lRXLTxOzb0W2h57W?=
 =?us-ascii?Q?gW2Mx0WqxsjHhJnoPbPhDTVR2q1AN3LNjULz06pXlzSFACp3uDOemfcTd9E/?=
 =?us-ascii?Q?5ZSasTOQhx8jWsALZc0mNWrshYWMDAsOS6JGZ7SzKn7N1I3Eg347pAXP2D3e?=
 =?us-ascii?Q?gx+jNVN7530lL4fsT2OlYU1ibLCbE2atLxsdPNR4JrEJ/HOaXZz44qT3Arzs?=
 =?us-ascii?Q?wnJSsJrdaU/9PRSyh8YT7f/8KHsY5yLALTrHngEUQFGTlas1oygU3l1ChBuy?=
 =?us-ascii?Q?sI6Ra/O77h5uGcaXOAFhkyvf4YM0sjDPdkbPugK1RGw2Q3UpeXsZ0pH6msAt?=
 =?us-ascii?Q?5VC5HTELd7a7vhUHugmnF8YlhP6iv8KuIMcc1HG0+GbfLSxkhvvzl1OklrVt?=
 =?us-ascii?Q?hdtLFyB2BqAF+5//ZpZFlHJr2Nsx6kXCymclPlFRDVjLgu+KfoI1xw9zOO7k?=
 =?us-ascii?Q?AfR5hzRoG3m8kBaNEx9SecOKZHzxwsJAcIT4tgmbWQD5so2r/XRE0Dx/zDQx?=
 =?us-ascii?Q?2phMMZLlvrTc5lsG7reEwskFP/eDfRtSaCvXgpMF/4NV1+RZvQewhqHdkYUt?=
 =?us-ascii?Q?JgAU5oI7sb3eLlGFRF55ZQEh6+w8q7rtUSSH/vTYiGgjpbRJczQxakgyr0gG?=
 =?us-ascii?Q?6aT5Y+Q48riA6HDZLTITSJMVu2xE0IgQV4ykKFxw5NQ3N8dGBdjbRbGfwZw1?=
 =?us-ascii?Q?l6JXOJAYubcvXUgejYqc01vCmSkHPadK8h9R0un2tF7Z9gJmheczVPPyNjuZ?=
 =?us-ascii?Q?oCCO61e0LxzaHTuTgnNegXyZsIZhLe+zE0MO0Z/PJQumV+R9mTW68nGNY1Q8?=
 =?us-ascii?Q?JChYz4caYfFeegSe4vCgd2D6HOFhkHHmZekfYz4QECbvae8JhrirJximdCI7?=
 =?us-ascii?Q?/IVUbbf476YxI/UARsq0ydrXnOhJvCXXWhtYc4SAZqy4UDbHfeeeGr9lbdCr?=
 =?us-ascii?Q?MF0y/KvdFxRUVGl+hQtJE4tqYQXV7/zx7ij4eayPQgoRK9G83WTYrQWTlXAn?=
 =?us-ascii?Q?USdLeHjuYs4d/y4+K0BGD9Xf5mxWDyzTKkHJEG3FSOkK0iwvzVNVDoMcJ//j?=
 =?us-ascii?Q?XYOHGGXiY+t7miaLozLEokIhfmeoqiF1dT6TqG75itE9UOo/bkk5QCKFu/Pt?=
 =?us-ascii?Q?AIkzn/XzPf/mgSXVjJ0/y3QpaSnekQEGWv7LU3NKqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HPVS13N4f+A1ZrICFCT4X4YIEMQApEhLDdT9i1uXiSPZnrAdrki/CmD4H0/f?=
 =?us-ascii?Q?jCiOM/iOiHJsz/mFG40wdCzu4j2GAPLFNhM6cYMsZ/R02ZIRcd6mejUEqsl3?=
 =?us-ascii?Q?4UxEafM1qGMQNN7dydS5Um72WttviN56dbbgAK7JGUYg3lsBLXsJZWyzTcn8?=
 =?us-ascii?Q?IUe8hFhFRVUaNx6C1p+Zo5w2x+e8fQnO8AsP7ox9QIALJCs3qEjS/kjwaEts?=
 =?us-ascii?Q?lthwQ2Qdw6v7mMfmz0fwOp8c5t7NZIG7Igts6ahnR8b7drNb1FjbS0whVwTr?=
 =?us-ascii?Q?oNlHSLqQ23x9a/2hWP/+jTK94HG+/DqB6I3Gk5UHVnvoErbVr+3WKBQuZmcm?=
 =?us-ascii?Q?qHMxLLyjCHbBYSjME9jiiITkAf8mj6LF/Cape08xsX69m6GSIsGMbwWgYQZW?=
 =?us-ascii?Q?5pu0P12fkGPeb2kSW99Wnsu6Uq3mS9QCK1Q9LS39tNmIs2Fsy74ddS/Ns7lJ?=
 =?us-ascii?Q?8iHoM6mP4uvxBhcor03dS0DKFzz+v6eHvjfCmJ1G0H9pa3qW99vOJEcIO/TW?=
 =?us-ascii?Q?pcDET1cMosMxViDg4bTp7vmxblFDgJjMfQltcyWUTxoMIBfjNuv4MPOQOmRO?=
 =?us-ascii?Q?k2zvbbGcr/1nrFe6Cm/+52u7GbcS9Yge7jtG/Fp3zBVVb2cxO4fCjajQCwNd?=
 =?us-ascii?Q?Zq0ZeM2PpFDqUgfS2ws17uw1kCo0f1ztubNIx3vp6/Tj0kn//pBYOiDST8Tl?=
 =?us-ascii?Q?EWtqXxGtF9/alYMI9fR+aYb4+s8TgIz6wo4ovJYXa3k+ed5DL4UM2KHSfKxG?=
 =?us-ascii?Q?CpFGNiyvt13r/5HYh6cn5j8NFH1H3pVZ72rL48hqQzEJnMW0wcGsbqlW7hfz?=
 =?us-ascii?Q?dbP7XiaERpyz5gCGJulOibkRsHnK6OArArgWe7l5zu9biWsEaePBVJd+bdDj?=
 =?us-ascii?Q?AD7ihX8xOaHG0mdv6KmYSk6rP9UkQ4tWFDBB73dlH0y/NDlWTshV3SW1Tbn0?=
 =?us-ascii?Q?K6I8R8axCGNlr5yMy17XCsH6PZFECGGteMInJL3QHPxRwLgYdNc/b69cqGcC?=
 =?us-ascii?Q?BqXLgY2BqTUVJMEQ5ihdaEhappG2vGKZbVVGcY1Ijne2n1FguBvHMg96/3HN?=
 =?us-ascii?Q?PUrrpKGw7u4PqaqQiHXTW8t+twwyJAUU6vSE4XmAnKOik2yhMn9wpqzj6ivc?=
 =?us-ascii?Q?kR0G69OPSavCLieNAX2gAu9D7LsP4rRxtyi5MPr7S1cCd9iQTFqfkrpPsEuK?=
 =?us-ascii?Q?5yqJPvzfxvDFCkhLDaq5BsZuIjR7114Di7E7J0n8RTzjlyroUo+2NhV90koE?=
 =?us-ascii?Q?odWyEsQhResn09t8thPv90byXYLdKoHlbtRbC8rK2MxJI322Amy6FsqZZHl+?=
 =?us-ascii?Q?94F/gyNO72aJK8cOzwF8EfrKiN1iuvD2+IIMYpzw8DuM3SPEYpBN5VYphBbc?=
 =?us-ascii?Q?ksakn8HuJNtyPaNAZcPU7qIJpYcijKG86Cl1yhfAK0MKpIONOe19ry1erkf1?=
 =?us-ascii?Q?W2iksdU+XmKV3cP0JzICwzSrUn/CJ1vfnn2NRv87qWK4ZFShBUGuLr5VRS+0?=
 =?us-ascii?Q?G2y+pZSyvSF0DcqS1Kn1KlPUGzE+xexpmijbTV+2igjzaGTJQV2a4ESDT75A?=
 =?us-ascii?Q?yMmXR6f5mIUqN5g9N3GwLfCP55LPdCx3TP9Xc5Ac?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc75903-838d-4458-3b95-08dc6b2444cc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 03:51:09.8077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JlYkCjR97NgTPkKqJ+DeRF/LoO/Mw3mO7lkVV2WF+HJFqK7tfrD5B1bQ9g6h47AqNCCDzFwP7kqTB505PocSNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941

First of all, in order to build with clang at all, one must first apply
Valentin Obst's build fix for LLVM [1]. Once that is done, then when
building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...clang generates warning here, because struct cpu_hogger has multiple
fields, and the code is initializing an array of these structs, and it
is incorrect to specify a single NULL value as the initializer.

Fix this by initializing with {}, so that the compiler knows to use
default initializer values for all fields in each array entry.

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/cgroup/test_cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
index 24020a2c68dc..e4266b60e5ac 100644
--- a/tools/testing/selftests/cgroup/test_cpu.c
+++ b/tools/testing/selftests/cgroup/test_cpu.c
@@ -237,7 +237,7 @@ run_cpucg_weight_test(
 {
 	int ret = KSFT_FAIL, i;
 	char *parent = NULL;
-	struct cpu_hogger children[3] = {NULL};
+	struct cpu_hogger children[3] = {};
 
 	parent = cg_name(root, "cpucg_test_0");
 	if (!parent)
@@ -408,7 +408,7 @@ run_cpucg_nested_weight_test(const char *root, bool overprovisioned)
 {
 	int ret = KSFT_FAIL, i;
 	char *parent = NULL, *child = NULL;
-	struct cpu_hogger leaf[3] = {NULL};
+	struct cpu_hogger leaf[3] = {};
 	long nested_leaf_usage, child_usage;
 	int nprocs = get_nprocs();
 
-- 
2.45.0


