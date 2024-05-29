Return-Path: <linux-kselftest+bounces-10814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE80C8D2AD5
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 04:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9A1283AF0
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 02:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E3B15B132;
	Wed, 29 May 2024 02:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WG9N4rb1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE1515B119;
	Wed, 29 May 2024 02:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716949789; cv=fail; b=uqaipHC5emt8Wg3H/3JyfUxumz6UtJwo73gvUENkTiSHXtReTnxP/TEwwTvhfd/Dk8CeYyhbmkW15la4fgf4sSSD7HSxG/XW3nJb5tFA5VAsGGExoZG9n0f8Ni+cpddm2j/fYpCQhqNYw6xmYa3FCXLkMFiloO09OXyw/4dF5BQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716949789; c=relaxed/simple;
	bh=IOmFOs3Q/TWtGdDRg7zopJXsyVMuAE1Hfun83T2AoYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ElmOxe+TXa4YcVyTMB2lkZI8tfOAIK5pvtmjG6Hqf09lLqesxSUBQqmLf56EKsQHynIIJtcUtdoEUXfhZ/Oy76MsF1uB5urjVtcv/UOCN3FnDUdcPheGSSXDZFD71fqv6qtxBrUSyDrr65s2GgGSFSF7IxjJotlMWA4exLwtYs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WG9N4rb1; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jX4CQbKY6pUOtzkEzSvrU4sRU9RcYXdP097Qf/nyfUkIPKABKDVpiagrBObR1dg2ogkvM0TCdgWU0K27S8SINAuxiOE1zZiy5yR4MqDjtUpcClsG1NDCTR7t22PwNYWESwsRdNUSBm23Cm9Hhs0kS3x7BypqeBE84+EtqZJus3lTbpjzQ+QPx7gO2o7o2JPIShCjmm/Ks4KNeaSybDg1NmeRT9SCAh5KOk7wH3iag6xDohttb3mE16k7T4WLzIgJ2H9YmbwP1cp85LEmLWaMpue6yOg8tfWQz4jQvde7WaQFEIRCaLu8zHIc5II+Fc8YPlWDILLwpYrIlxojU91tYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zH3UrrCrKeDtw+7I3LIXA5isBN9ztJ/Zy1KugoebhSY=;
 b=HVx1m0NLyfccmhF66anX2f+/0lwgMz6JSEbN+atvUPog7Tj5HwSkE7v7TXm9SYLMZz72XCjOToJON4YgTGDzUEmN8mSTiS4J3UGueN90naY8lPsXSIbn5S+IyrDj/lm99MixSm8jgs+PTFYVm3J8X0mGeDPehuvNfu5dFSSQFQBFyQ3be49HVDosCqU/CPEThxaodipPe8n+nyc3l2z/u+98l1Gb7OWvxWS9dw6MJ5Bok+g5ytSTpiG24LdDCbMHlE4V+CHCsGeXsMjZ5bTXA074Nhc5KVFyummMDNbXOc8cMOuHIuOwVOAv5zZ3nZZbs2xaKOIpyKG3nKtNIG8Weg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zH3UrrCrKeDtw+7I3LIXA5isBN9ztJ/Zy1KugoebhSY=;
 b=WG9N4rb1Pf6H228kG06FQkWX7+scmZIPyfMHghVb15crUQJGva6yJkOXv5OS6FE+AMXOW1e9QU2VmewaFH3WOJiYiZ9I2aq8vLSv0vmB83FQXKtUvPmpmT4CaiynQoKgOY9zdeXkyDav3J7fH/ZCLhY2R+ckGUIw3GF2dbb5pV21xVAp03IE1C9SChCEKH+89KfJ1T4ifdvl2O73I4zVIz8d9xD2oDD7gUmcnyia+SPafwdMUoTHAPx3qRN3YQQTsXNqM44ketTOE9AocUVPZW9tU6IJ0826WjvIOp68F2A6d4ExPITxMCkpcb0SdK9Sxm6yU76XbsqMxT5I1CZmdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV2PR12MB5725.namprd12.prod.outlook.com (2603:10b6:408:14c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 02:29:42 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 02:29:42 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Edward Liaw <edliaw@google.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	"Nysal Jan K . A" <nysal@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 2/3] selftests/futex: don't pass a const char* to asprintf(3)
Date: Tue, 28 May 2024 19:29:37 -0700
Message-ID: <20240529022938.129624-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240529022938.129624-1-jhubbard@nvidia.com>
References: <20240529022938.129624-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0056.namprd08.prod.outlook.com
 (2603:10b6:a03:117::33) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|LV2PR12MB5725:EE_
X-MS-Office365-Filtering-Correlation-Id: b944a782-e164-4b61-ec15-08dc7f87321f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zf3WApSk0W0WWaLC3EhQhPho6w7Fip7NhqUunw34uIfmA1qUjn3oO+ACT/oW?=
 =?us-ascii?Q?WAMvrGEHh1gZ2oonJ9vRjJs1f5oLboJzq+iSF1nFE+6Eeh2xN6jZ0boKh5XK?=
 =?us-ascii?Q?tJ6i3quEFy5dnddCqVBeTCASc6xTaqMFkAdvq9oTIhfkknPq27Vqpxgu2+Q3?=
 =?us-ascii?Q?VvRpr7vLklgltMmdiZ4u7xQW/Ibf3xlFVDZBd7lxuwlCE3O1TOmBNXv65Mxg?=
 =?us-ascii?Q?P/+pIrKtsFUDyqytSFFKqg2R347seaRRtwdmiHaKkGWGblxYG5kjxnjvF5WV?=
 =?us-ascii?Q?/ABz3AuGlJEEtvXMOyb2smRVkHQt3lWwwJq/RDMcFXubJDB7hEpYHneHzdty?=
 =?us-ascii?Q?6OcRPVxfFc5eqCidNv5CYm0M4bu7EBlGgu2RTa0R31HqmocS1mvB5TKOZvA2?=
 =?us-ascii?Q?FwnsbmOCg59CIM2dKLaD4HYTR59j/YrqrP6vhte7rLbyy7iVnzxnNj6b7r4g?=
 =?us-ascii?Q?j/pBeAWpFr5ybPxfHwK2tvmvKxmiG2RmyiKR3iwT34mPpIsdNCUw/QxmceJ4?=
 =?us-ascii?Q?Qzwai+rOwCI9B5jd/KLMzDuHLxvV4DciJ6qRNHY40EY4V0v2/Z8u1IndtYO0?=
 =?us-ascii?Q?NayL3i7ciXafUussNUyrquAl+z0DjioSYOpN4ggeZw7MBbFvXLS1P7ZRthJs?=
 =?us-ascii?Q?w7s08/soPpcsxGO+yMPils1k2fhDUgL7lLjKkJUbdHWO2fM11XNStQoaZ8/c?=
 =?us-ascii?Q?gpMV/wvLDVpVC/uN4Yga6lcq0qLcJi7yD0JPfBxn109nB1sFLjiS4hF8WgcU?=
 =?us-ascii?Q?WtsPnje0Qpk0PbGR18ueZkDownawFo7FnivhvHRHa0deKEHPY0yIRjuCGuUC?=
 =?us-ascii?Q?zhUaDps6MRARlnva/ol3dUBDeQiyZIp4QX3lhib8gEmFinxNmJgsdjVTC6aL?=
 =?us-ascii?Q?p6cWz9Mh2LywRGKCbjAk9g7GVZ/ypEaLEGsx7pLijzEoyqve7Szcbv4iyPOh?=
 =?us-ascii?Q?/24qhk+p3dLwPoiXXZMsmBjta1q1RpnaicZ1gxERt11+KyknxloDrT4oyjdM?=
 =?us-ascii?Q?xit9l46c5BvU8p6LM0Z2/PdOj6Th2dU68Z4yhGTTLCyHTOWaHRITsvqYkKk9?=
 =?us-ascii?Q?7Ilnbn3ZujUTmlOWmqarm6MVvpY8NCNiuXz6SoKjPwDnmI2DmsqG3KHLJlFY?=
 =?us-ascii?Q?yccaZ5PtaLUeVvPOk1BovTh4hXthch4kyHWoppJw5l6znjsh+rYD5BaBITxS?=
 =?us-ascii?Q?fqGD+nkgikgmEI4jhTOGV6cf/zD4fTWsThEgSoWrIW9jRxcVrl7Pj4ubhGy2?=
 =?us-ascii?Q?3pT7nv83MA2DB+ppqCmD2eCqpCH5yU0SG1ro87qssA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2fUkZFOxUlnjaMA30u0uecdhPUJztk30+OGR1mObcOl5RZOEzkylXIWgO7tM?=
 =?us-ascii?Q?cIdXTQ6+MUlJIyo4VitIa5xh0W66qyHe9iPDGEY0EQ75/Nqjdew8ilqSJyDs?=
 =?us-ascii?Q?/fj65vqnACwj4fOZdSRWUuJbA/4JU0P5GVO0uyTYeqBc7bApDGWcowdnA3bR?=
 =?us-ascii?Q?s7b4ggr6VPJVXjrS6nLPnOUA0R1iwX+1rHRU/PPWaCyYw/T5N+KB2itKSq6Z?=
 =?us-ascii?Q?YZs2KfzOzoNW8r4gtw040GDJ2/aMDFM+lM4vKiQ0G8VELYx3pAI+DDLlrN0A?=
 =?us-ascii?Q?cwf0YPW+EPX5m6KNvIMvH6D8q7nK6XAaY07iTtfojJkpKmEr+HN3Ouhx+aun?=
 =?us-ascii?Q?B2NvJ3Hrz31VFOkYx1oFRjCA2KxlyFSwsV+prqkKLMXmYh17iJ3XYuS2ZK1d?=
 =?us-ascii?Q?R2TQ2HzXc48719Em6LIzvx6E8SGp4hJWVNyEtfe3LVZqSyf5ULEQA8I2q1Mk?=
 =?us-ascii?Q?OIUBOtBc6pTlnTUvwR4pY82DpQL809/vf7IEv9XLu8SMyomoZD9lhX6u8c4Z?=
 =?us-ascii?Q?Cjqztz7isBjjZjaqZ2sIqtaCavmwlMq0B7mAHq4TIpsvLTGhZungXJ87Vgry?=
 =?us-ascii?Q?cmQGhq7ccG0MDsFH4Hm+Ls1L8n2pljfyYIp/3mtJiYVDKBC/SB+hVoIfrYp6?=
 =?us-ascii?Q?1MJ1owpJ9/1tXMksC9shzYwfMlZlidk1p5BBbvXDmQrjwdVxWoOHyK1g7YuR?=
 =?us-ascii?Q?4EeyzCHMaApc27YmpyDcwUYdoh0RmS4/69QMh6RBLkC7oUkXsMIi1Z4SQmUU?=
 =?us-ascii?Q?yB3MJiFyoyEetBPZ/xxhvmU3h0OotiVKC/VyhlbKM13e/lgRDF/YyQQhwUhz?=
 =?us-ascii?Q?aQPMTOgnUGBOySgYrIcKtsg8OYvEdeoPm1tXU5ypmjFWrBQq6HD/PkLePwxk?=
 =?us-ascii?Q?YKeXkGY2dd9kqd58HWSYn/+grze65cbaOmlr50tw1PxMxSY/NnY+3gNLZ2DP?=
 =?us-ascii?Q?nM49Igv+qtrS07l0wsSgWc/S4K+qlSJcwtBl4wcPRO3NWpGehiDxKH7T38re?=
 =?us-ascii?Q?wnPcT2aBxUzr0TyhWmzm+j6NjHiqOHv7W0ME6Swg7pueGnCWJS4rl4oB4y1W?=
 =?us-ascii?Q?L0nZItWuZVM4loTTULzeCmKlRuFRkIs2irMGi0tTCEsQGz53hefr0hwJzJXS?=
 =?us-ascii?Q?ma9JAMu5vJ0teQJj67Ehsggpxrs/mQJkC/2G0OzGyq4+4rc/E7iki9tYLbIj?=
 =?us-ascii?Q?B07GY6NLxU2r19Oodi64o9Cn6LKVkYg7iUXjSL6LyqEf2VVqawwX0zTVGaQ6?=
 =?us-ascii?Q?2eecUOYGO08JqzUHVuVgCrFqHAEW3/HbsIri9hM+AzKhvOAnrrzLpSZMpxQi?=
 =?us-ascii?Q?6CnwYEs7ieUIxnz/MEDHnYUqBVGwMGWAAm7wP1G3BWkfKacyq4I/0Ky3IQXY?=
 =?us-ascii?Q?giBpkDfaPAgM/A82K7V6dSvqcXxScWobUHOuLSURRYxkpkTGXAT1WyA7qEkV?=
 =?us-ascii?Q?I8dQXJ4k+n31gMfvqUPlefp1vxO6qN3zUVZPLY9M7O8/efb4GMGCnkq6FHXK?=
 =?us-ascii?Q?A31xb2/gmyRN+Mh1GRVZy3XgRs6EG8w1Tg5vLy995Ius5BlnpHe1Wgxxl/V9?=
 =?us-ascii?Q?Fyj4rDAYe1/I3EmmSGexX6vYNHCLhvLAWez8B1La?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b944a782-e164-4b61-ec15-08dc7f87321f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 02:29:41.8758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UZHHdOoVf1hBjWStaNPUhbrfXbB49epCf1dq8wnfvGrBU8th1MDSxooKrINvRufkwRvFNpDlbRrKjcrWyUaFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5725

When building with clang, via:

    make LLVM=1 -C tools/testing/selftests

...clang issues a warning, because test_name is passed into asprintf(3),
which then changes it.

Fix this by simply removing the const qualifier. This is a local
automatic variable in a very short function, so there is not much need
to use the compiler to enforce const-ness at this scope.

[1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/

Fixes: f17d8a87ecb5 ("selftests: fuxex: Report a unique test name per run of futex_requeue_pi")
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/futex/functional/futex_requeue_pi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
index 7f3ca5c78df1..215c6cb539b4 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -360,7 +360,7 @@ int unit_test(int broadcast, long lock, int third_party_owner, long timeout_ns)
 
 int main(int argc, char *argv[])
 {
-	const char *test_name;
+	char *test_name;
 	int c, ret;
 
 	while ((c = getopt(argc, argv, "bchlot:v:")) != -1) {
-- 
2.45.1


