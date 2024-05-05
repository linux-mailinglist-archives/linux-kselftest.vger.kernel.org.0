Return-Path: <linux-kselftest+bounces-9486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B058BC3F0
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 23:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F314FB2145B
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 21:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1361D762EF;
	Sun,  5 May 2024 21:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ezD+hsho"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DC77605E;
	Sun,  5 May 2024 21:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714944347; cv=fail; b=CLfaDHCmKY7dYGe+x6nvZl4Co9ClYz7EGHTROsE+AFc2CTz1GIFRBM/K0GphxabmKAt1EiON5P1CAA6YKIMdcjwqDDRHUZe2A8AJye2QzPPxWJFrjnLyjAUHtD/bX/mD3zd5kvPoOB/1cwHL/VPxRlgoYCfxbtyvisT2RsOgu7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714944347; c=relaxed/simple;
	bh=P7Mx4fmKWZJgd7+VPFLdpy4+4QVsdAI2ht94qlbLe2c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OJWJt88PnCY6tqMA260oYNmJamvObc1RBaseHrgTQ6L8IZFnGem4qdmrWRxVsrfdYrIwOt15ktZ5kFMzd59EPzdXJKmRoQlDkGdtOJSen6Ajvk4e7ekk7VSbbwYErbntopdJaRikFeExk6mesgenIDZ4VihAAXDYT7Q9PCxk5Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ezD+hsho; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNBmMg3emSJZwqZeHQtA05QiOuzCdFgiF3s7wYy6r7UWKsNnjpJfEOGA3NumY+wtV3Y+U7N78DDUyiiusDDL4gtl4UhWYrhVl5a96oh4gIgYybMEyA6E7hJb2fhdZCxRi5x+RRIpkjtSXRFMMStmb60sWzzzK3yGndrfclVLU+VaqQJPNqIGUIh53KaxCHh+VfmN0CppxixZ/LbaBmi+alKU2kdkkPKXwvh+T3BqjWlVcLZU9oQ2NYjQhuTZwiS9ny2hD4LQbEXG5trXPhBVpyx//6RnUGBv5V0/A0bsZPBfvrubGgpT+T87fq7TI2devBeT4Mq05EPS+nFiWD43JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxHX0i0FiIW3ENfG/2xbjfS5zY6MTIPugTqf0sOpbaQ=;
 b=EKfkhX3ywhDe3VEYiTQiejnoaFhL/2INrWRW12cuq6oQvURw6buOHYRKJQtrYqJ4IApeafsGdGei8KBltWvR53+JXDyXSNM44OZ+sPwsuN1MDlb217npuOWpbdmb8uzv6LiuSPf6YKEeJ94FQ6j4c+caoxEKZydVX26xKxSBgvTTU95YBCQAG6t0tD2Hy/baOzq23SdQOckIc7v7fUccxu7GDeV+EPx/vinrb7DsjWXhOQwASvSePZafMY6GnMCLB8JgCn+oy0neG2jqz1BNHzaUgeMDf56SM0zv+8XJanEhEWZZhYlgw+kAMInLEhrqxrWxSCXba/3yryRIcGhZSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxHX0i0FiIW3ENfG/2xbjfS5zY6MTIPugTqf0sOpbaQ=;
 b=ezD+hsho0nTmJGbsb0Sr+qAIr/8dWAFnoSHFEEDC6TMGh/xsiEgf2sY04PV/osyNXnFiXqvFe23HtfU5L9UoDyfXj33o7U2CIgtoWyMi0I6MUp4e5XOyudKzi8NEWYswCkJaRyVGL8IDjaCfNK2z/XB4+Jx2yi9vnfVtqcNA3TEwZisIeWxfMflfWUpDoOnwv/KLW8WDA13RfmTQUomCe0n3OH/pNjEyFT9v9V87TuwBYyK/JOCOYdnC31SNyodhwEsQFdDHhq+HKCSglBERj4qWTU8dFZSZPRFw4H3hABmdpeBjmfOh5BKzdSdJMqeyYCC+/a2HVUSfs6+4akq44Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CY5PR12MB6647.namprd12.prod.outlook.com (2603:10b6:930:40::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Sun, 5 May
 2024 21:25:42 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.041; Sun, 5 May 2024
 21:25:41 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] selftests/timers: remove unused irqcount variable
Date: Sun,  5 May 2024 14:25:10 -0700
Message-ID: <20240505212510.58590-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::34) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CY5PR12MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: 726d4de2-31e8-4bbd-5e4a-08dc6d49eaa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EFOqa4ugB64YcB0vG5+DrcqkGmhf6NyYEeT9HKD/dme6jojzIKe9tUxnxRzm?=
 =?us-ascii?Q?FwV4+p/o9ofvh16a0HANBNTlz3er85g1x0G8e9cjICNADcCZqdPfgwPPlP22?=
 =?us-ascii?Q?4GZxx/4BEEq/BNgPZzJr7S3QPbksFjkHjiWhwW88fnodrKWM4gGj/+txSwuk?=
 =?us-ascii?Q?wnWtOg+yi08t8hxdBZ7hpOkvos+GfBZi9hplbnzwbTPHktg90saoX9iLs9zG?=
 =?us-ascii?Q?zwUzR2Lj8aQhhpZUszaJjwfA3/HAzGrcBbvVGDrfbchdF2T84ZNCXwPPsGqa?=
 =?us-ascii?Q?PKxOmo9z6WsruLo3wO/Tl8eujkVMGb0/0Ezdd09Lrt0uVkWrl2dHolgWQa5V?=
 =?us-ascii?Q?8zfq4lX/srQHTXnhWppOLFLe3M2MgE9TIe37i0j6E/KsueNUarvem2WP0Gve?=
 =?us-ascii?Q?0UqJtq3aidWQj68nqdl6X7B3UZUijOKzdHwWYfMrBLA840czjN7DF4y8nfkc?=
 =?us-ascii?Q?63DPqdSbUflyQP8D0GayN4+mPlCOwbU/dZX+cMEp6k1LKXJIpzeduDnwXWZO?=
 =?us-ascii?Q?GT0lKQfaiEWdrgowVN+yBcaI/ZMgYHkcZED0mWFxapEpT8NCT4dG+tA5Jcxz?=
 =?us-ascii?Q?gHeUnmlDW80rUwy6H/EC099hezYan8i1u/YgEzfDFmTU1xis7xyd80WFiMGa?=
 =?us-ascii?Q?IIIEr39FKyZVera2tA7WQcB5Cg2sFB2pQsoYklgfS8YWX8BlkxDDsqodSW0W?=
 =?us-ascii?Q?htF8Yce8OaYtiQ083pYiANPfN9XDWfly2QEVXvCKZD2vNcIl/Qzn0EeEuz70?=
 =?us-ascii?Q?KNmbvpAm90c9dXQFOac5bBVkmjrfliVKbkx8swPxe2BLnzJPnrODecj3DPkm?=
 =?us-ascii?Q?6MK7P3wY5oqoNRjJUkOBv+TPaoApYUCbZCXXT2aNsZglbwWJkVE4av9tcFGD?=
 =?us-ascii?Q?wh5Bl1Nqw1qpqZES1H5pIQBNfcUV4K3Znpm80XEIQuL+4q5yAB8IQA7IpGGJ?=
 =?us-ascii?Q?3nh661XZLaw8j7CPgtUTyfsmaZ5UquZxkwD+dOQvsi/j343u/VDo2NXHqkH2?=
 =?us-ascii?Q?ZVlNL4EMJ0OQ2izvVnkHIGqHYliX3VHVkKODqDvzXzJTi8m7KdtkMvU4gsOB?=
 =?us-ascii?Q?hPymt6D3sJwYMFiF4omO6hGnH5CMhCRARv3A+nRNVDEnZWSZCIQ1Xv4h04xd?=
 =?us-ascii?Q?viLkMrHE3gYVz8rs2h+jLkOyJXA1hrUfj4TP+149T///LKU/jTpiT7GETW6T?=
 =?us-ascii?Q?T+BX8Oehxd+pfUy7y1EEHVeB3pKI2scCOR/cTCk3C5tSAa1rlGEjbpq9etie?=
 =?us-ascii?Q?utmTv1Cuj9c0qQAzgev90cp5x//0+3CZvUGXrkiVGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MKWUG41oTFGatS98BOk2u6+6LB33UTX1oio/I6diRBPGw66NhnCyHsmy361b?=
 =?us-ascii?Q?LQesvTAa8mZoXH9CqRqmZJno5pait0oPeWp8iBzCGAQB3qgTuEYVmkk4lF79?=
 =?us-ascii?Q?gX4/jKfZXAH9PfCj62awexakW3k3w7wUdWwJ+6AuVoZdx5NLIcX3gFip9dyc?=
 =?us-ascii?Q?ZoHTqeeQeNwGRwaBEV4veFkh+1r0JJUc6qKXWwR9/z8JCyqIRozPPZB45I/3?=
 =?us-ascii?Q?EA4dDwnTHpXl1QE/Xr/89p+WrhoTaLv2Woz4LqM5CUg12MHMOtQNczkAz8h7?=
 =?us-ascii?Q?wyx+ppy3Xe5GmYJsF5VWzyWojbvgXAf7gow+l93+AnOPMqP/c5OO2VTyUzSg?=
 =?us-ascii?Q?Sq92TLMaQIX6pE2idoFlKQW+5fR7M9rUB7O1Kv42izXRbjUbGH0qTo4Rbj/D?=
 =?us-ascii?Q?71x4xEmxDAY+ge7EkR/7xXhuZzY+TJ0uW4pLQ6EZZMnZqh+yo9Ctb1rkvT+J?=
 =?us-ascii?Q?w1R9vBGG0yTDiP/9HIn/HaNn2pnXaBVDYGbgOob2fXFZs9+Mn/aErXbTmdiL?=
 =?us-ascii?Q?c5uiMwH3MZFscAgXrle+to2QacEjOpBpG73P+aHb8GTfTWBHWGJ+ZncSfwb5?=
 =?us-ascii?Q?nmQ/lu0pAV/fQzCrcDO8CY//ZiiKcBNl6QXZL0MOyJETazFHQygRHYBIOS35?=
 =?us-ascii?Q?1f2UNCNZ9mR0kzi7jI4gkL1wHCuGbVjZD57OxzPwAsQ3AxI5TIAkUM+DefHj?=
 =?us-ascii?Q?RzPPOrFOgJnYsDFCMTN1QD0LBvvgYG4xt09rMdOXeZHg05uQMZPpdXc3xtk4?=
 =?us-ascii?Q?pgpKQDsrSGnFM618mPGzIhT08pBhvYMTk8IA/moS4WPF66qnlcTVGZMbr2m/?=
 =?us-ascii?Q?4AO44FbJ95v/FvhSDNUTCpB8QNaQHx9QsFpZliwTwFk6bHiM5Lf3acqbG7T8?=
 =?us-ascii?Q?3Z2cSLzOA/xpouUQnzt6XixWNr9J1qa83t5ybwClZaBX2bpbwqoXJn+a5zr0?=
 =?us-ascii?Q?BK0jfqF0nRIxCJHTl2p4TourLtRZsV0oG+/JswAL51pjJ/U0XzR0RCYvTcEa?=
 =?us-ascii?Q?nKN46R9zFAfJhmFfydjG8HGpuv3wjBlx6iojBsnzlAcm3fB1qnwge11RTNBQ?=
 =?us-ascii?Q?B1SGrFTsWDIqfTzlE05La7cuDuL9kHsWSlAwNydlo6GXWiqYlZI/mPJeCz3t?=
 =?us-ascii?Q?HsvkEKW1n/r4+jOazEleEpfhklsAoyy93uiTiEhnCBj3hU0DyTEEQXpZmgkA?=
 =?us-ascii?Q?5efwk7jmmHZhYw2Ediwg//3EsXvnTtB8K/soPA/eCuEKS0WwYvrNcMWManMd?=
 =?us-ascii?Q?OnW8lBIVA+IeAURB2qj7/d+Mgtap6G830hmeGIM1LZz9jeLMRFCtmPwgS3f+?=
 =?us-ascii?Q?vPQzvsSTwh5FvZhGzYrUhmSa/xgQP6ZProBLLyuOECdAlYarmS1dOJyQN91B?=
 =?us-ascii?Q?fPJZVXb2Pvaeh37nM1hkPH2QAuqgIA82zSt0Tt7hR01MAkyF6I8n/kqX02be?=
 =?us-ascii?Q?P9m8gaRHwlC5bWr7vSgpg8edC41gSj/uStwcuCXGueH2hsEXIUTNqllecQ3A?=
 =?us-ascii?Q?FwJ+Jq4Y/6wdtioZFPHBNT5UJ9X40k8YrRSPohTNdyM/RpPYgtO/koK0Zkwq?=
 =?us-ascii?Q?3dkLq4aYWssWxOpQX4/GPwB7IAq6UykZl3cnnZ3RjUVVCQMgCuyLwyOGbvLM?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 726d4de2-31e8-4bbd-5e4a-08dc6d49eaa8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 21:25:41.7775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywRb13N7WOhzC7TY5xrw9ENHDfnDIleg3nVvMaFFvV3cLZ1cC4wwDV1oZUiIejfmd1UnnWByOhsHQFbOBQ3U/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6647

When building with clang, via:

    make LLVM=1 -C tools/testing/selftest

...clang warns about an unused irqcount variable. clang is correct: the
variable is incremented and then ignored.

Fix this by deleting the irqcount variable.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/timers/rtcpie.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/timers/rtcpie.c b/tools/testing/selftests/timers/rtcpie.c
index 4ef2184f1558..7c07edd0d450 100644
--- a/tools/testing/selftests/timers/rtcpie.c
+++ b/tools/testing/selftests/timers/rtcpie.c
@@ -29,7 +29,7 @@ static const char default_rtc[] = "/dev/rtc0";
 
 int main(int argc, char **argv)
 {
-	int i, fd, retval, irqcount = 0;
+	int i, fd, retval;
 	unsigned long tmp, data, old_pie_rate;
 	const char *rtc = default_rtc;
 	struct timeval start, end, diff;
@@ -120,7 +120,6 @@ int main(int argc, char **argv)
 
 			fprintf(stderr, " %d",i);
 			fflush(stderr);
-			irqcount++;
 		}
 
 		/* Disable periodic interrupts */

base-commit: f462ae0edd3703edd6f22fe41d336369c38b884b
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
-- 
2.45.0


