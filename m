Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8103C6AFB3E
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 01:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjCHAgU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 19:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCHAgL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 19:36:11 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DABA0F02;
        Tue,  7 Mar 2023 16:36:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+hGzXjGDXze51t999kA2jdVnUeEbGuYWDUMdZ+8+RtVK7pkYeBgj6xc6Cvo10WvUy7IUY8H/m0gfqByoTTlx2ZxBPGbzB5f/6BNuL3kFlOWqEGlyZ8KDI0S0SmC5HtMew/KHLLMOWvAjpxvR+s/fPvgbsyOFUXdGTv/PPM4amlzy25pE9Yvpn/3NDECYgDPiAbly61wg6JaFw9rr5tUU/H8lb/pTKL7hK45mZRqmGTlk7M6FFBZ099MyvH/pGXl4w5thGRi8oRL+N689WfZYr0K/qhFh8pQXbCF1BfBddgUmHbT6iD9znrt8i8wN3P0x6eMCbaX+udyygtjfbYceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7FhxAsju1x7JDRfFiXFpOtrJm/Kpj/Olha+nn/QV/I=;
 b=JzTjrb0dCA4yPP9sKq/Lk4V9Qi8bHiuU5YtkApl/vFgZ0IeTWShScn/NYZ6ICcH89mlOOtnx9yep1y/5mt7So/CsBWPeci2WYnp4neOWc3psHfsUf+JHSpK3IHoigyGszkF5n0r9ORm/uBlEKqdf1YOjyE4nyaevdmi9dwVptwvQI4rOPxndIJMZdKG82jrWo19HixEEUN/M0uRQjfo0bKMCYlPfG/V56mi12vBVPCy0DmmgjqzXj5DTlmlmCngVC4wvQLg46f/mrl/FSS1eqYYk6Rpzo+wRHzMNngtjXz4Sqv/1GpYl46SsFwpKWoNYDtVJG0n1rreYFSwrbhx3DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7FhxAsju1x7JDRfFiXFpOtrJm/Kpj/Olha+nn/QV/I=;
 b=etMUmp5Tn3qO1VwcF6PFCwdQ1v4oAdGPBa5p+M2c3Yj8xS4d1IvnDbZvfAiTcbWWSGS4oL4E1feelopFe5buBxtNwwS2KDvVJz4Ho1t9zbcwJ3dBd4kMcYjxJAf/C7orkvK4OsZtQPnW57n8WJMlbmMskaRahFlrLhMOYS7KfE0n0QifjjgJPM4KXlSq7AMUfvEH5k75UebApNzzxFkeHwk1iD0sVz9LFmbf4VdAJs/MEDzeXeNrrFQ2Nb9GN4Meltif1RukutiO/acUo9CLj6P1vXGRat7yHPYNr2EUUj5dgNtmVjetZMn9SoEJ+KPdvJcRacbm8cN8WAUxg9165g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 00:36:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 00:36:00 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 17/17] iommufd/selftest: Add a selftest for IOMMU_HWPT_ALLOC
Date:   Tue,  7 Mar 2023 20:35:56 -0400
Message-Id: <17-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1P288CA0005.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::18)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 6370f496-6178-44c5-6b0b-08db1f6d167e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xfMoEYuJAYCsiRwhtQnf4RKfupp1HYxTyFvlBV/4KoJUmxIshW3QyM5ZdqYJo7Q8tNP41Z2baQwbBZvTm9hnj8jZoOqBefJgYzvzJGATMsPSZBLnrCA/n/a3UJGxmetS4EZSu/JM0VY0VksK1Ps0HKO/tkfLGFwiCfpFacTOqDAOr7dkhrqBJN0p7ieiFz0vTDxrkNR3RUcPA82pnT3UZoCy4wV49y2KorCKGOAzNxWCoRU0tLai2cwmh39uxZ8Mgadrv9b7uYGxmwLnGQ76uwOxF7jE+jHVL06IVXpYrrtUKOuUTe+lh/A4SLfM+esG33zCGcnlfGqpyR2705nijZw72HzaTW5jtq9AzgyAdgV0c0z3+ZDLmEXPzRqVpFXveOqvF0K6IFUTcBf8C6p2G11z1vL6ZCClHcoV6tnGgESsd+dZL1PXYejyZ8ROdQRY3FW91iVjrYhyuPwPQHgt8S93TqS2MRjbI2r9VREA8XdO6uP/WC89eVpfuuABPs2uvPFT17cCNW5laHn0rdkWMS+HssHTk2M7eFbPCwlPdHuaSS680OkdaciqR1smGq3K9Ok3DQtHmZpF4+68C+5VGk/6HxJopnHGaeb+cdj+CdfOD4Mt1Tj7bQE1tBrhe5WLjh3woILzxVag0yat9zyk3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199018)(36756003)(41300700001)(66556008)(4326008)(8936002)(8676002)(2906002)(5660300002)(66946007)(86362001)(66476007)(38100700002)(6666004)(478600001)(54906003)(6486002)(316002)(6512007)(83380400001)(6506007)(2616005)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0nwDcAq6WTJvMvX/jwAT5QI7SgK0OiO4x6e+glP9Q33DJFJ56hmAUt4QlqmW?=
 =?us-ascii?Q?+HWnCrE08wc8GWGbY8eTC5RvISMcYPn06FcZMxE7IRf5e+vDo9mwtH13CKlq?=
 =?us-ascii?Q?1bsUZUcB9y5RNRDwmwlHr1CrvWw5W+JQE4hEiBzzhHOvutURXxJ0Z5EppetR?=
 =?us-ascii?Q?BRYlvOl16aDsPXv7jznjRrbsWoPjtH/LTqlzK0CGS4CZNn3sz0hCTRKrZj1Z?=
 =?us-ascii?Q?1xwBgmOKd/jFKFPAD2cYm/CrYDkeARVJTyxyNOrWtzldaaZDGzMsEgWYkUXK?=
 =?us-ascii?Q?F5Wlr95sw3+6A6mnCG03ajnX3jDjxORXi4f8azFVkfXuRzNMXwsiVTv+HU6Z?=
 =?us-ascii?Q?dS4x9H/NLZPgc2JCqZ5e13za1b9Dk3/kU1zB/b2PWoCKVT8okQC8+3dp059r?=
 =?us-ascii?Q?XNYE4barHQpBkwpDkdIzRbQGLRIef17LUwewDtS/F5INtXAME+NLaJIqSRjV?=
 =?us-ascii?Q?Sl0YCn2JsruK8ne1i3iCsc+8peIP94M6yVLTzukqpFJoGlSZWXpl3SG1YrLT?=
 =?us-ascii?Q?TX54wlQ4eSDqbImDUQ43kvILQteVXWaAaw+Sl7fRB/0c585X88mOjQIFEF5b?=
 =?us-ascii?Q?HRNjcfRM8m4nVACaX2pkAxghVfLYQdTUc09hJ9ffZ5OTGegiCz+cum+i+Ilx?=
 =?us-ascii?Q?YjFU9RCvvYCKLogpUSULtnf1FZeKzD6jgbsKjhCg2sbFbzQHCmgUeSI8T60i?=
 =?us-ascii?Q?IFfVH6QOw0euOMrb6dOqo3UF6nsGYYJ+VWNtmkIOVB0vomBqWA2p2Q3taSAX?=
 =?us-ascii?Q?BO/AVlH7njdwVkJUtW/bygu906PkdZOww7lm0ZXaOGkMjqylIwMLpk/9I/aL?=
 =?us-ascii?Q?ryvXtCjGh4NCDbN4oMQ0SdWUwsIZM9wntj+KG5XEKKlCT/vXBvgWgeHaXiZJ?=
 =?us-ascii?Q?USDUJBTScT2pP2UD2rJXCNV1HORH4a8+X2DugK07539cx0/FfSd/kkS8bAb+?=
 =?us-ascii?Q?D7GzNKCwm1P82tH/b996VArkUWq3Bxnwj2e162pgZB1POVuSQmqTeq71LI65?=
 =?us-ascii?Q?vPSFk15mTsdItp922dk4kr6m5M9Adj4N93ytUOgcOMikau+XXlhf1rXcJ8Xv?=
 =?us-ascii?Q?PY0pGMeG2AiAOSI4z9DdOWTDv7sTN1kafv1nNdcjBynynDXLaLm/L80xAEV8?=
 =?us-ascii?Q?PLVgp98eh6p+z1EacGeigvARI5vs/TzW02MNCkyiRUvEmjRZ1mtoXLTL5WIs?=
 =?us-ascii?Q?1GneEdtSl2lk6B36HTBNoyZp5e7W+uyRCmejFi9lAct+js9VxoDBCHqLcNAw?=
 =?us-ascii?Q?+hp4fxq10+LHVNuBL+Xj9B2E4LHQ9PaJtmb0Nr/UqzQgelCwxyhTfZwpaiGq?=
 =?us-ascii?Q?3sxGYPdJJVuy1UtTfqgpUz/YNHcBrLQHOb1MPC4XZ9xsB1/ejz/nlMN0+ySa?=
 =?us-ascii?Q?wucGSBVoysIHgBjI73hBdCkYNNsfD3kZPQD8i9Ur2zGFm25wOjRXgXIYPzn5?=
 =?us-ascii?Q?0jz0URChLTtB4cJxJbtp40nZJncmTw6eBBskJ2Vro8XJQ44dlWrY/w7mrfug?=
 =?us-ascii?Q?v5wDmg7kH9xXUcl0WxoetqA99eTAdI+ABWWCk6QlWsqd8tUlmsCLiYJ+ZCc8?=
 =?us-ascii?Q?8hFcQuj3lswvhFnGEng5gsFGFGSCExX/4Q2RiWU5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6370f496-6178-44c5-6b0b-08db1f6d167e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 00:35:59.3899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qzUFCT2sJtSpan6SVIXTGIwd8qo9NMoticpAHYOql+l78SoMY0cXzGq2ZZlZVxE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test the basic flow.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 15 +++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        | 11 +++++++++-
 tools/testing/selftests/iommu/iommufd_utils.h | 21 +++++++++++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 83c98a371f9e7a..c07252dbf62d72 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1307,6 +1307,21 @@ TEST_F(iommufd_mock_domain, replace)
 	test_ioctl_destroy(ioas_id);
 }
 
+TEST_F(iommufd_mock_domain, alloc_hwpt)
+{
+	int i;
+
+	for (i = 0; i != variant->mock_domains; i++) {
+		uint32_t stddev_id;
+		uint32_t hwpt_id;
+
+		test_cmd_hwpt_alloc(self->idev_ids[0], self->ioas_id, &hwpt_id);
+		test_cmd_mock_domain(hwpt_id, &stddev_id, NULL, NULL);
+		test_ioctl_destroy(stddev_id);
+		test_ioctl_destroy(hwpt_id);
+	}
+}
+
 /* VFIO compatibility IOCTLs */
 
 TEST_F(iommufd, simple_ioctls)
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 7a3d149019da92..7e1afb6ff9bd8d 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -577,6 +577,8 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	uint32_t ioas_id;
 	uint32_t ioas_id2;
 	uint32_t stdev_id;
+	uint32_t idev_id;
+	uint32_t hwpt_id;
 
 	self->fd = open("/dev/iommu", O_RDWR);
 	if (self->fd == -1)
@@ -590,11 +592,18 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, NULL, NULL))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, NULL,
+				  &idev_id))
+		return -1;
+
+	if (_test_cmd_hwpt_alloc(self->fd, idev_id, ioas_id, &hwpt_id))
 		return -1;
 
 	if (_test_cmd_mock_domain_replace(self->fd, stdev_id, ioas_id2, NULL))
 		return -1;
+
+	if (_test_cmd_mock_domain_replace(self->fd, stdev_id, hwpt_id, NULL))
+		return -1;
 	return 0;
 }
 
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index e67a929a5c87d3..9b6dcb921750b6 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -96,6 +96,27 @@ static int _test_cmd_mock_domain_replace(int fd, __u32 stdev_id, __u32 pt_id,
 	EXPECT_ERRNO(_errno, _test_cmd_mock_domain_replace(self->fd, stdev_id, \
 							   pt_id, NULL))
 
+static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
+					 __u32 *hwpt_id)
+{
+	struct iommu_hwpt_alloc cmd = {
+		.size = sizeof(cmd),
+		.dev_id = device_id,
+		.pt_id = pt_id,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_HWPT_ALLOC, &cmd);
+	if (ret)
+		return ret;
+	if (hwpt_id)
+		*hwpt_id = cmd.out_hwpt_id;
+	return 0;
+}
+
+#define test_cmd_hwpt_alloc(device_id, pt_id, hwpt_id) \
+	ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, hwpt_id))
+
 static int _test_cmd_create_access(int fd, unsigned int ioas_id,
 				   __u32 *access_id, unsigned int flags)
 {
-- 
2.39.2

