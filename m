Return-Path: <linux-kselftest+bounces-3850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995AF844171
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 15:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506762856AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 14:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2320E81ACF;
	Wed, 31 Jan 2024 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h0ihTKgY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2F38288C;
	Wed, 31 Jan 2024 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710214; cv=fail; b=uXnRb9yjEg0s4ryOKXs2s63odvK6fHGic+Fx7SArHDafEnnkQ8oia3Py1TwcexOQPIv5PzjNeajpuQqFzdyEHVCYSyj6UT1WuP1W3tdF/Jf34TnCEDRObK3EZpSQE8XEzJsGO+uujcLZZnCe4C1lD25sf6acz6RXplHfpDxvlg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710214; c=relaxed/simple;
	bh=Bs5Liy3b6dj8f7tWhbOC1DD80bvxyu8KM8Ir7QZ1Zjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rN4r3aaaYy4P3zSOdrcHVhEo1B/AuKupBYDVnkacFwC8+T5g933bnrORsDTAEZpXefrvC5+xmhvD0V03NGebHLu9iLHXUwdYEu6BZp2ilbpV6RDynVvhUsCEbwOzLwG+i62rOaiV9D0nKOLCbKXrvNljiAhLqCO01kFPCxG015A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h0ihTKgY; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTup+O12ByHv6ZuzZwGsuI1JMKPR1cMeO/ZUVOPbPoW5gycqtJVQ6EFsx7ZCKCXB6RaKPqQggJp5PxDrEpINezq+iFmBZa3fvNv4zK7lfnZc13kuetgkfSlmdWQ2sf0gM0VVURIVJbmlQ0baW9uUPy1qwjFJRvGxaBMv17WIz3QaR6vjzdzeTQjcDu1Ydmpr/+9mMp0R6Hl4COmF4xvwUT1pxsKvpgxw1/zcnO7m+cAKTNqfpuGAankuJMW3y6PIY8EnhOPHXRaI2zYwX6C0EKyWKnF+w5gnJ5XYII1/UHmfXxy2YSxrRNQN/35ppCvkhnJc86cH4/Ua7azufAUVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkZnFm3Zt+QYaGFdRYCMGf3p1Az4yWlmdpVj7w23GbQ=;
 b=gac25rAe1DJS1tzHnt+RZAOnuslpN4YEMsGn6p4NVdvC44PWVpgpSDzRiyqgbUhry5/XAFLZgYGsGr5cflt5+TYAgTGgzHeoEfYRW1uC9wfpmcaO84Xw+1ej/Cxq72sKkwDc2I3JQAZPjvJSLVLSoQH/ymruZd/j3e+WYBIUyVnuUuVreGMbME4TR3nzrV5zsFXDhRiURB3g4pKD2iRewjr5lmLJEA+qB9a5XBko5IW5+CkxYSLugaiQwJOIv3AjyAKYkolsTiB8x0DTDh5Q/ov3yLdAhqH/ppFkQnkX5w9PM7KmLPXG6wLPCnnZJZi1coDEaH1VjVSf0FJuQQiV2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkZnFm3Zt+QYaGFdRYCMGf3p1Az4yWlmdpVj7w23GbQ=;
 b=h0ihTKgYvhXtHVlE+NLTL2sIRCEKac3ZJiizfOjXtH5jKw8Xqw4VndAgkaimJP0xzOXlGJ/juUKAG/dJKILejka2ZywJ1GLX+lJQsEtzYz9XEhGdajXUeqKYMucUVtemx8Q7D05ruWFefLGetZoqE2Yj1QHjKEPIZh1dPh5UldCOpPOD8oHZEqKfIuWxz9QmsMKVlol3XJ5Q4IgP8b71jo5iV1maFPWYGxWohBjHOQogC6tiumtVRCXefEayaiZbjGqdiCmsP+oiJ+igbfF3gFPCbJFj2mI6su+ENyIMpwPUBr8wS2yT6OpY3q+wgqsrHT6DQENypKpiYZ8Wo60LGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.35; Wed, 31 Jan
 2024 14:10:03 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::8a95:4c4b:5bd1:3a2c]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::8a95:4c4b:5bd1:3a2c%5]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 14:10:03 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Johannes Nixdorf <jnixdorf-oss@avm.de>,
	Davide Caratti <dcaratti@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Coco Li <lixiaoyan@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Lucas Karpinski <lkarpins@redhat.com>,
	Anders Roxell <anders.roxell@linaro.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 5/5] selftests: forwarding: List helper scripts in TEST_FILES Makefile variable
Date: Wed, 31 Jan 2024 09:08:48 -0500
Message-ID: <20240131140848.360618-6-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131140848.360618-1-bpoirier@nvidia.com>
References: <20240131140848.360618-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBP288CA0001.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::14) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|MW4PR12MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 8180d47c-fda9-4e88-ffe7-08dc226651be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Riw0RRyJtgFiSY4rIdfLE6eqqwNtOyVPCAmPRKRVZoFUyGOhTzfocxG944DxmcIW+DMwCNe7/y59eMdrzC01kYgR41wZo/L78XsZ3S1wP6StzTH0EBlBkbY26un4EMyqoJbQzrdcGpHbFjIj3hw8xKKRT60oJ8CP6MRMyNaHFY3VKY80LhyJFdgmJvEvNernxnzBWtbUNYNER2Bnr5mtqGH9rGV1gEIv8GCCFFr1rJZr59YbfKDjnQj9z7SwRT+WpaI/0VxTeIJHbwQVt0s8nLCIjWIUtxH/W1w7GwqYKxJVaZBR0rvHZ+n0dUwm5cc2JNoL98gXWFRmN3YWMW3gGqlMB0BSiC1MfS6U3eSzYsCtK6x75lhSa2vYRtWgLXOOi4Bfajms6+0BxU9d+SLyNl7xeCcAWaF7RKa+gzzyEoK7VlH9buSn35p6sCmfqNlwar8aBUAk43wpga2OvRRpEnaJpIoX2px8P8RSBx/mOLt2Bk5DUG+tmGdRzFnZSvIoGDDhCJBjZsRkhKDoZissFbBSghj46X+O+HP5/zYlf+AaV90b8qbAP+57ky3HjHQN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(136003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(66556008)(66476007)(2906002)(7416002)(5660300002)(316002)(8936002)(66946007)(6916009)(54906003)(8676002)(4326008)(36756003)(478600001)(38100700002)(86362001)(6486002)(26005)(6512007)(6666004)(41300700001)(2616005)(1076003)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QqU3pS7vxGZi2fnuedvRUFGEaryZPRs6WDCG9gD6/OYLp01Z3JbAYmCasOs+?=
 =?us-ascii?Q?DxaVhSGe8VY7PyUxn0jsgbQi/bxPo208Wo9bdZUJq2Sq1fNNQytoFpHTsiKt?=
 =?us-ascii?Q?Suth6OxTIR7PnsIehnSUKt+Bh39hzSDfAGGfY6TjsFPBUsdOFXXvwaLpdlK6?=
 =?us-ascii?Q?h+wEl17eDHQuKnBkJsecevTaCub+2Mw3Fq+Bgmc133MaGEZcTxvS3SMPk293?=
 =?us-ascii?Q?MoKXoYupjfM8MbjZFbWZMfaSlpjxTwfLu0ZHCp41D1vOjZ0uxuRe2dkmx+a0?=
 =?us-ascii?Q?DcOLKGA808L6s0yA2bMlCdUMSS09dhj0r2TnSfGRmFI/Mt6JcIFjNxAVVirI?=
 =?us-ascii?Q?uBoqp55oJCA7qpCDcCxOcTpSHqSpYIaErjSajvWYZ5wM/Cft54aoxEL8IkmO?=
 =?us-ascii?Q?7mdvGhQvoq74pJiEZ4SgHkZs4Y8tdEeFfOqcFBdGbO1fQrPeVirhfOuOMA2I?=
 =?us-ascii?Q?DxZF+4da+rdljGxWaS8pBE+y51UAomKkJfJylkif9oEks+kKFVo5xnKzRLQK?=
 =?us-ascii?Q?XYD0ILTGyk5twY0BibD89ergIwNdvXnQ8x5pbYUtUI//jZr151MuyL8AtYpz?=
 =?us-ascii?Q?QPLeSqyugafq2oaHy2Y/x2/To3k4rMG6EY/5Agwa7Jc/W/x8xvM9mE1meB4b?=
 =?us-ascii?Q?MGJVSaujWbGSteu6IrhEAnNH3PjMuTrdCJpFXxJVGivzyHQSBqptmHr2nVdN?=
 =?us-ascii?Q?kFm+jvg4GL6HRMAnar7/ic7toZeZLuF4D+OeSEmtXF+O6IB6lCZgHI5cM9Jy?=
 =?us-ascii?Q?nJ/f+aSism/xmamOKQhcnzJAaReYcs9/4YE+bwF5B8noOojVoLM5+UTDg+71?=
 =?us-ascii?Q?Al/b5vtBnPGdaI8sK95KA2Zi4hIIicOUEJlwF+lYDfYWy6SGsfA8VdFijM4q?=
 =?us-ascii?Q?ykTQKG8mm/nqi8/T902P0LqS3wXSuAK8nzHH6mSX5UY/g91KqenN+xuse8/s?=
 =?us-ascii?Q?dClZhhrcQpDv4PudLpjQl+qNNKaHEpw9Y8SKyhxChjDLaN3SpwOiwNEb9NNu?=
 =?us-ascii?Q?OnDMys172BbIv18Sn4AGAkBWh7RsR0hx4am8bIS1IkGZwZiwaauGBxKGNo8h?=
 =?us-ascii?Q?cYOaSE6y7ovvOZPXZGkE9YWjUnjVDU4M/4SmhffgC3q/8S4Kcd+qJB0NwaPw?=
 =?us-ascii?Q?n4/Hm4RL4le3MQuJ2TuCzebj4khnGKYQ9EUQPqFcGdNpco+xqZC0CiOnPvzQ?=
 =?us-ascii?Q?NmDtXDMUkxp857NzdkFbT9bZXzG4flq2xUJtfaYXX32Fy14afZ98mc0XVndh?=
 =?us-ascii?Q?5punSRPHXQN39200yGJX3lre6UIhERPCB8WpFXpifeTVGAEeHIp3aUtEHhDk?=
 =?us-ascii?Q?BoDFVKFPjo1ZpuTXcrfIAAiTtkedg2Fl/nwHHYvcC152bPdh92CdHtY8qGsA?=
 =?us-ascii?Q?pkmI7bEt6pwKepY6XFBXIbsAfGENflBH+9S+6+MSxdfm3fVTFUrRCB3JS5yl?=
 =?us-ascii?Q?2d4COj0mC0T3jofDNCykBlYze5Kuj/E7w7bUz0NuL0BrM3YqFaievY0PAF6+?=
 =?us-ascii?Q?CO8wcHceS4n9iVfuMRSe2LKc3/1d75UG0nMZtiyWsFZk8EQHNZnM7i6AEjoh?=
 =?us-ascii?Q?+bJYFOFFo31AO0iT0ROUlNi+8S+vuJdXlLr+OIJZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8180d47c-fda9-4e88-ffe7-08dc226651be
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 14:10:03.4511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3j0JjmV99S/G39sPJESBuVDMRdFZ5TR81tQHhZXBjf4xgb8PSLw+tx/su18Uc+BrfZXB/Y2+JUQ/vq/8v9vKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730

Some scripts are not tests themselves; they contain utility functions used
by other tests. According to Documentation/dev-tools/kselftest.rst, such
files should be listed in TEST_FILES. Currently they are incorrectly listed
in TEST_PROGS_EXTENDED so rename the variable.

Fixes: c085dbfb1cfc ("selftests/net/forwarding: define libs as TEST_PROGS_EXTENDED")
Suggested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 tools/testing/selftests/net/forwarding/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index 452693514be4..4de92632f483 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -112,7 +112,7 @@ TEST_PROGS = bridge_fdb_learning_limit.sh \
 	vxlan_symmetric_ipv6.sh \
 	vxlan_symmetric.sh
 
-TEST_PROGS_EXTENDED := devlink_lib.sh \
+TEST_FILES := devlink_lib.sh \
 	ethtool_lib.sh \
 	fib_offload_lib.sh \
 	forwarding.config.sample \
-- 
2.43.0


