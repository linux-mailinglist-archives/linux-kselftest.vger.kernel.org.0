Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364456A7448
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Mar 2023 20:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjCATai (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 14:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCATah (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 14:30:37 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854D95FCC
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Mar 2023 11:30:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/O2dxrMTVJ3lrGgTLcBYZMCwunvefWPg6kvN+cQQ/p2Unwuv8ltl/dM135BFuVQYa821s6W+iFqkqFwmgM41EnwfH6Z3Neht+tthQE7zLUdpDXQ5CEBq4vUa6kEeghhUmbrfTGsBfdK6LHRkoL5x9zJe73W4QJicIYTtzkKzhkbyDonDp8ZWkSif+kHhf3DdWJhY6rCjzniHoVb/FyNzu4h3+rMppDupFAm5SnPMQAWNq6RbX5JubaAdhGfVNSwPaFBspW0ZRhSL7bxRsyoOGZ5xDYDWOya/NJGArdlGUqZUVrz/SKYWhZLzHs2sOWaQ51VvKu2X7mrts3oaqsPEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wn5X/PSKoS7df8S2eEJYAT732Xmw580UmfHwDMGBDM4=;
 b=BxheienQW0bb3/lRGd0NuN3BWlVNhH18v5s7WRY+57kjEYvERGVv2N4Ny7/z9Jea06KB4SsO1IBH61YGCWdIYXFAvrQ0uDxy6/CayLs+aBV5z1D4V29sTO27vSs+ORFplV3ZawgVNe8T+JDea4a9uZ5GxTY35BaoiRR+1SwwKkH2+uEry+ylFwgA1qiesl8eq9f2aEKW6xpsfnKggBElwGNqzF/ah3545IpvTCSuNOfQd/xCOPb5fRLU9PP4GtoTaFPYzouYxYLT0CxA2/8OGoUDbJtKUd9PFwGYFVwNYmqWmXOlFW305yEuS6eyD+LbcIMlFhtwO3CtBv2hZGZoqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wn5X/PSKoS7df8S2eEJYAT732Xmw580UmfHwDMGBDM4=;
 b=nK72OWahDcVPVvznqsniV5ovy2M0Vg6OPFteyRSp3QpWeOo9dtN104rzbQLq0UtgzA5XflanueRU5X/r05NkYbfzFutTjueKrUjzUlRvS8NyaF9+kNoJkDvB4tRPRS3zzYLiM96go3HuGCcJo+cmx0f+icUR6ONxn5CokUuRGHdL/WTCSvcHM90+hwocb/aKQHdkuUVhz9Eh4yh4NpncpeYJ9blboTTqor32oA76nR1BpPBYKLfpkMYCdSELvY11TbfbfZOo5QxyYj3GJN1GRx6TEyFlSoXY6Ztej2deN4PcaExlXYIHKag4/zfDKX+zr4vLHVtsgg1BJB6Qg6Zt0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 19:30:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.029; Wed, 1 Mar 2023
 19:30:33 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 09/12] iommufd/selftest: Rename domain_id to hwpt_id for FIXTURE iommufd_mock_domain
Date:   Wed,  1 Mar 2023 15:30:26 -0400
Message-Id: <9-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <0-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 50fc81a9-3d89-4b4e-71a6-08db1a8b6bb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IrfIKBBcki+o+bILCtSLZ0Fud7ww/uoPvIygk/8XApmcoI2FjASbbFMgeNsLxo/C3xWc3XAoCQvcx5wAqPKexPFesqg/jTfCxFU9vBXwyFvTRIMBjtpWXJzOsAj+1IsXZMGzqiM4zh+FsDOlHQJ+toqlGBxNX856Scmx4UH/5l/3U/JiwMOwXn6zCSuwvj2JBe98Ka8tG+YRqWB3Q6XGMdmI0+lvbFoeQhx3Q9r0dMeHZXoqUA3LFThbSG4ImbnIxJh/rRDpn61taX3cg/rc5ngo7Z5/kx8ZfyAkCh1Y9tjRec4qs0v5OrfcxD5wZVxKlbmcJ53Z08BTh1PahhN+tfIqkU194+JmzAjC6tX3TyZInSQr6OT0MNAI36FtPxcqh3q/TraVMkbQQVm579a+c5BOVmB/Wvd17hziU8F0HXj2mNvBW79Rt/4LWpb/8eVDRg7Lc8jh/rHIS6HdAcinZ9GIJhTqVYuW7pYAqAjcIjIm/ttdH+7z9UmQuxMS1np4PN/3ZiZ/nRr1JH/Sqb3telejoOG+IBh/i4kR496upKVRFIDvtEawChLxX1mdAA7TalEWluVKdO0xZUK1imlaV+iQplyrLueourzsKf5bq3Y9aT9GssFMT3JyLWiozVLHDhgqOXszrz0FDLXi9qt9qKG3aRJqcQTp2kXKGZjUKe9Y2Y9m3f3RcL7XNaopZwsx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199018)(186003)(2906002)(6512007)(5660300002)(38100700002)(26005)(6506007)(8936002)(4326008)(6486002)(41300700001)(86362001)(2616005)(8676002)(66946007)(66556008)(66476007)(6666004)(110136005)(36756003)(54906003)(83380400001)(316002)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i8hSSz109ul6DhgWPPXr+ak3tXy/+feCiIfJryYsNoS/BQU7sTvuKaPlxHpw?=
 =?us-ascii?Q?8Aaomuab3dmh30dGtFPlxfXD9n85qUfKuqM9RyQXCFg4g0pQB1kBLiQ8mpqc?=
 =?us-ascii?Q?pRTKphCCiTJ26AJqwNM2CVDoxV5QMXiLyAVBCV5GLiibVCmw3Gb1c71ITMLZ?=
 =?us-ascii?Q?nv5PzQyyRo/GhzuvKKqZXxuwV0+iseNLFRfVhxjICV+/uFPW+akWT4VgfISd?=
 =?us-ascii?Q?MjR8EgiG8ZtNo976+z8y9MRpV+r4A4hrl5zwX0J/HLiFGlpa5SXEjH2iBo2s?=
 =?us-ascii?Q?pRMn3qGHVw/MklLAbYhmzPvQJ9ZkjqCnUwnR4FqOR51xYdRUomwL1eV36p/J?=
 =?us-ascii?Q?1U+OK4yxEZJjvCQuOhjxobB9S0GAZLp0hqFVXqyRUjegap66xLJ0TQnyxb32?=
 =?us-ascii?Q?M8BTbcvDOnxbuR9SvWW1osgF7H/dcJEyzkWf2Ub2iCHbLvPQ6a3gaQSyEBx8?=
 =?us-ascii?Q?fAUsM0/WZt47IEAjJ5zPuxxLc3c21uKbquK2l+yZb/UF/1sM8geb6EXkuTVi?=
 =?us-ascii?Q?5KPl/P7+dNAuIF2dmvL+QKAvqf7xOlZ+oKBqhFwaGSF//YhhyLDd1Q2cUftr?=
 =?us-ascii?Q?EVwq73WKYnTiQNVBYHo8wcAPESnlC6r25Rw62wWgYCNfDsIr0TMaJAcggTK7?=
 =?us-ascii?Q?AvlLjy+vXV+RRbIHFQuZCuBj85Jt3wrw5vXtNk5oZrr4A5yYkRpzYgVMlShf?=
 =?us-ascii?Q?aUjxG2xadGc6lERqFyTkJl3ts66eZzP5+ftmau/FlPB9qvKpsUBJmSh27zw8?=
 =?us-ascii?Q?2TpXJeroeNl7mLTxd1/qGOjkwS8q/RBcGxwaeJjGvhMOflqng6PWIheWQHCk?=
 =?us-ascii?Q?OjgfWLRIbRq/YkAV9pKj9sGPnnVd+DIzEjnT1ZREauhfRXItzl0eOTU6Zfnk?=
 =?us-ascii?Q?R3WrLLTBLkp7EXmC706ooZTjpzLPiu4R3aS+SqOA1A7eMLfzcBzgYouF5k89?=
 =?us-ascii?Q?4SuPvpZj27BtemZvg26F27mTP+hCB39EPuHj18EMV3TgfywScUqysiT+Hr+M?=
 =?us-ascii?Q?iwSZo+khu2ZLxHBtvE+ZHj6k8EWwwf6/Cwm4oi8mfYuSX98mZCQn5zBrllTS?=
 =?us-ascii?Q?awmWuJXY65oMVmshlnXwrYJjgRVGRsybnwJnUpwmCmJeg2+JmYR06B1PLymL?=
 =?us-ascii?Q?SF+V4F7w13nr45laFyfuGIHkWQXz2Tt3j1oEfVwbKZ8BCpjeSdCAMxKztwZx?=
 =?us-ascii?Q?gRmEnhQPiOaqVUgBxDi5EwIYBdoJl5oGxbm5VcRciYIQTWSdRme0xge81gKP?=
 =?us-ascii?Q?6syORvwfXAlxFka6ICiAFjmcQCSlCB3Cp1J6hTMsbFY7mQDkQ9cABuqXsCXv?=
 =?us-ascii?Q?16y2htJHefzwYqxZ4Vsnw/Onn8Yc3IoLK+Abcq7mn4rvqzUH+8wqcw89uvVA?=
 =?us-ascii?Q?jrvzFHHRnwLQY8AsLBg7SI0/r0F9MR/neHk4hFEzn74lM8fLoG4rC+2H/m8g?=
 =?us-ascii?Q?9wxeGE0N2zX8BOqecnv2U8CGGAye0S/WMoDX+UQY8EK+bfUpPA1R+AcoUYlI?=
 =?us-ascii?Q?yCZ4iSQ9QHau3eDmkUY8EQk/jBu0y4MOlq3HJhoV3W9ExBdnRYSoNtp4zL40?=
 =?us-ascii?Q?K/Yfi9hVnqV2/r45YSZ2MYQyXFbN8DsFfBxN+IrA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50fc81a9-3d89-4b4e-71a6-08db1a8b6bb4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 19:30:31.4227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHSS4Yoq+a45mlpjUN4JbqQW+nRo35gkOKkvRviMd4ooxGHo5Lm1egho4d0WWx2s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In this case the domain_id was acting as the hwpt_id, so be clearer.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 000fadf8110833..6a61ec84243572 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -988,8 +988,8 @@ FIXTURE(iommufd_mock_domain)
 {
 	int fd;
 	uint32_t ioas_id;
-	uint32_t domain_id;
-	uint32_t domain_ids[2];
+	uint32_t hwpt_id;
+	uint32_t hwpt_ids[2];
 	int mmap_flags;
 	size_t mmap_buf_size;
 };
@@ -1008,11 +1008,11 @@ FIXTURE_SETUP(iommufd_mock_domain)
 	ASSERT_NE(-1, self->fd);
 	test_ioctl_ioas_alloc(&self->ioas_id);
 
-	ASSERT_GE(ARRAY_SIZE(self->domain_ids), variant->mock_domains);
+	ASSERT_GE(ARRAY_SIZE(self->hwpt_ids), variant->mock_domains);
 
 	for (i = 0; i != variant->mock_domains; i++)
-		test_cmd_mock_domain(self->ioas_id, NULL, &self->domain_ids[i]);
-	self->domain_id = self->domain_ids[0];
+		test_cmd_mock_domain(self->ioas_id, NULL, &self->hwpt_ids[i]);
+	self->hwpt_id = self->hwpt_ids[0];
 
 	self->mmap_flags = MAP_SHARED | MAP_ANONYMOUS;
 	self->mmap_buf_size = PAGE_SIZE * 8;
@@ -1061,7 +1061,7 @@ FIXTURE_VARIANT_ADD(iommufd_mock_domain, two_domains_hugepage)
 		struct iommu_test_cmd check_map_cmd = {                      \
 			.size = sizeof(check_map_cmd),                       \
 			.op = IOMMU_TEST_OP_MD_CHECK_MAP,                    \
-			.id = self->domain_id,                               \
+			.id = self->hwpt_id,                                 \
 			.check_map = { .iova = _iova,                        \
 				       .length = _length,                    \
 				       .uptr = (uintptr_t)(_ptr) },          \
@@ -1070,8 +1070,8 @@ FIXTURE_VARIANT_ADD(iommufd_mock_domain, two_domains_hugepage)
 			  ioctl(self->fd,                                    \
 				_IOMMU_TEST_CMD(IOMMU_TEST_OP_MD_CHECK_MAP), \
 				&check_map_cmd));                            \
-		if (self->domain_ids[1]) {                                   \
-			check_map_cmd.id = self->domain_ids[1];              \
+		if (self->hwpt_ids[1]) {                                     \
+			check_map_cmd.id = self->hwpt_ids[1];                \
 			ASSERT_EQ(0,                                         \
 				  ioctl(self->fd,                            \
 					_IOMMU_TEST_CMD(                     \
@@ -1203,9 +1203,9 @@ TEST_F(iommufd_mock_domain, all_aligns_copy)
 			test_ioctl_ioas_map(buf + start, length, &iova);
 
 			/* Add and destroy a domain while the area exists */
-			old_id = self->domain_ids[1];
+			old_id = self->hwpt_ids[1];
 			test_cmd_mock_domain(self->ioas_id, &mock_device_id,
-					     &self->domain_ids[1]);
+					     &self->hwpt_ids[1]);
 
 			check_mock_iova(buf + start, iova, length);
 			check_refs(buf + start / PAGE_SIZE * PAGE_SIZE,
@@ -1214,8 +1214,8 @@ TEST_F(iommufd_mock_domain, all_aligns_copy)
 				   1);
 
 			test_ioctl_destroy(mock_device_id);
-			test_ioctl_destroy(self->domain_ids[1]);
-			self->domain_ids[1] = old_id;
+			test_ioctl_destroy(self->hwpt_ids[1]);
+			self->hwpt_ids[1] = old_id;
 
 			test_ioctl_ioas_unmap(iova, length);
 		}
-- 
2.39.2

