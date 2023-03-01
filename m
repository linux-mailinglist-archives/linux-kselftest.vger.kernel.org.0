Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23B96A7444
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Mar 2023 20:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCATaf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 14:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCATae (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 14:30:34 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A5659F6
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Mar 2023 11:30:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxtrHg5yWY8fNO0LTuG+4F8ELfQsYhet/3iyj9k0chN2my9SibylW0ixBjZPa755cGMhOYLPVKj9lQ23YpWolBO3Ki7JbcLKPCkG2z7kR8OhjUs0FkrMdhtJ0//xxc2nMurSQ/DurEVavAkbDnkSmhHljFSd4GlIVdfNVHCRgW8+SdaqDGYLGKyes4XTWH967MVaVEckPnQ859nPWBvPxTeOk7cGGi/IWzMQ5KLngnZdPAVGvtx+C1c2hh4Wd52QfDNGejusvnf12WEyIHpnQduoWJbT6hoO0vkPtIxc+iO93txRi5VkKqdw4OBHBGXFYK7Eu5sABj0w40Yj8lnaTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gaGur/d3vIig+rSDq2d3qya2Ehj8K222XcjOQiNMrY=;
 b=IcFuazy/hkFZ7eoOQ8VgtTnGcVtxUvebJC+/PttH850heKmmTtC7JGWhmrBKyosOqzRXpG2WGFfokf2Xm0IditAHbD3b9CfOEYE8BRZyUTx9cIKSSHX7vZRrTSRvgM28tCpZjtOQ4tJ3JwdLt+jfImtv5Ee8fAa6P9tmwgbnYRZi70tfGbc5AfXsov3F2XqYi4agM745pKVi8KY6FHh5UnThHhw/O9NzHmdC5SUj2RYIMJGUpQuw0sDSRreM+sDKUCw3WE9EjzY8jHvW1oaIEaoqXtDS7bavfP3qVtJHHdI1RfSmx0GqFUy84qnUO/aU1xinWZ3lAGWI89IB4BSbtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gaGur/d3vIig+rSDq2d3qya2Ehj8K222XcjOQiNMrY=;
 b=Oqq7RqR4YSYz5ieyfZKu24DCkSTY0hjT9BGEf3e3LFdwtR4RjtXBBEiFcz5ijF6Ko29fR5OP7xNQ1DCXnc+8W55h6tXxFT+2CIevOefC2q0rVQKM3y4vYlzM1SN9lz6ffORVuIcNbhLcbk0vX+8vIRYidctoNV6tF6rhp3kBamhJ9NXzoVMqApuPIehBT3IapG2J7XqxgiOzjnwvVersOK3OsnEj1sIi6L3dyAvu+fre9WpsgGCI/wnBDF46y4HwaC7QHsYUQ3Z7pJLi28AYi33pw4xCNsrf1Abln+UIqwwD5Ye36Aa4eRrqzgFN1p653+fyCkpoguHCRYy6AILiwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 19:30:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.029; Wed, 1 Mar 2023
 19:30:31 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 05/12] iommufd: Move iommufd_device to iommufd_private.h
Date:   Wed,  1 Mar 2023 15:30:22 -0400
Message-Id: <5-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <0-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 92cba08f-b4d4-46f0-6915-08db1a8b6b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Shw7guy9tXP+rjoFltczK+KZXlQCERyDSIhlyJ28I6I1zf5lCMXUoMqGLuZe3Dtvwt/0RJaqkHtjpVhddX3j8UM84/ZAeAKyOAjWjRauaQOW7NTX0o0T9B0EG+B5Aqafk8UEtFAU8cpO3CGenUa0MlpuogTe6mmowpMgnyfxWE+Cvanme5H0wf/uf0skDdCoyphQft54WdczQzOUaXtNKePY2hj+NHYUWFHdHM4eD3ze5zLN9e9NQ/3yVAXSITJX4WcuoGexDdYlB02HCk9WpfARxYdGdlU3PysN3aYCzRpUJj32uG3Me3oGY7r70SJCURI68TalwcPJxJwxkio8+dsvQi1YSlh5QQat4WJQBpjuONM+ne9jwFm/It62XgwbmyATzufgEXjXEWNnjCGag8CWPPtP3p+HGJ7qoUN52b0WZONCzAKqJ+o2Zrf+hH01up6rVJvxwC/jsksSSx3khAAjzo1RchArNaXBFbHObDl5sLckcwl55l3TFa6tFRjAf5CsWpRb1B23ySo8jHvxHkTvjlAtFJM0/e/XU9cJ+i3VQs0H/dH6izbSC2gyC8gMhYgPDGgVFNx4jarAhM8AtCZKPHAIwASY3x91iQR1AT8P6RKblIM0GjE/Yc1paqS3J2Y5E8kBbtN5MLbfVzZmoFT1mkH8/I6rw2ljlpxKkZ3carK8r5vN305SGjGY4l7n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199018)(186003)(2906002)(6512007)(5660300002)(38100700002)(26005)(6506007)(8936002)(4326008)(6486002)(41300700001)(86362001)(2616005)(8676002)(66946007)(66556008)(66476007)(6666004)(110136005)(36756003)(54906003)(83380400001)(316002)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NP7CagyYfcpxfyOnCPl5zAVijEKDcM3IsgAYTAuTHsaTj5pPuQ0Gq0soTiW2?=
 =?us-ascii?Q?Nurv6uVivRTYW4c+yhxll+kddD4Kc4iwwzenyI+Ejxo9+jtJiC+RTXyN4QGs?=
 =?us-ascii?Q?OnWtOY6KRcQcE8hWscHYZMcT5m8t8ZGGNIH6bfF+9biIuZZOEQAdX+nokKO5?=
 =?us-ascii?Q?h5p1iyYsYVUKN86PDDVpAPxpFulWntqtlBqqA7ROgiwY7Tqbj7PT8qkmiHF3?=
 =?us-ascii?Q?HO4gq9pHLpadze/KnvvuQb2T6ijb6ZEOTiO1QWs/mD8d11Knwr0YtYmWbgvC?=
 =?us-ascii?Q?EcCDXq1NPG/M1rvlWn5UafbA8b5QIBMKg06BBnA42HaXaPztggDi50a7Cj3J?=
 =?us-ascii?Q?6/qhTXQlirXMVdpT5DtFFCAG3lc/IvvDgqnt9HCwvzRwzLDqJpbrlGnUmvmW?=
 =?us-ascii?Q?vrYFcAAWPgKVrLMp2CUxSHNhCr2AzYObzmhq4WOC7Oe994s/6kt61JQ86s0d?=
 =?us-ascii?Q?rtUD7cmmxHJLUFcat0dczjTWj8I0O07b8qk9IhvvHp6B6Loff2oFqzn+qr9s?=
 =?us-ascii?Q?TDNRjWhcS4DwFw5PHuFePiLnO0lbhlrym49j948pOcCvs6aHtk+fVgHnO++q?=
 =?us-ascii?Q?dmD7QchLaDh3pnm4iHNpNz/VwmKXQejG86EmKLS2ABin3oYNIMhcqrECwlO3?=
 =?us-ascii?Q?sdRpyO7wREfGTXBaKmO/NjydEjif8ic4w/GpGv2YzaZfuXUyYAL7x1X/K/l3?=
 =?us-ascii?Q?BaZYHFjY651cg7rJg9Md+pkn/6qjnPG9cUAoVvbgMkkyIsr6bP0IRRjC6MG2?=
 =?us-ascii?Q?6asYYkTRuYbCUMG3QQsd8ue37I9D6IyBf5LHcZpxcNKdgaZbGzldDQ3nLN2j?=
 =?us-ascii?Q?B7ACyd+JwcE/RuavKKxtdkQZVjZiv+8rjFmp0047ZM7yt6NmKeBqC3EytQ86?=
 =?us-ascii?Q?CQEz3kD6ebHzNAF1afawzhJ8q1rhg0egeJfzIqjjHR++PJJms6vOTnh7EvQn?=
 =?us-ascii?Q?tpomTQBrYNXn8tG5d+8Iut22bm8q/A7NjZ+SbJTVuHfsU/FJaEV/vYYr1Jqp?=
 =?us-ascii?Q?2oqaAd7OGbRlO8DvhRG5tUvXreXZsHUDYnL+A1UipxcqvtmnmRr32KtwMyyH?=
 =?us-ascii?Q?0xOL8Pspy1gItTHeHsH1DRFzepehkdey2jxZzl5IRULZ5A2TbTKpEg2jxNOc?=
 =?us-ascii?Q?8yqZXL63htVghb2CpdNV14vng1JBwJWOHdOvtcWQGEuqrNUoF4DMTgYwpkJ2?=
 =?us-ascii?Q?xMkxrSDMGHjyYfKBqNT82TENEoWc3e5NmtX6DFUWfL2KmADSNXIjogUdyF5a?=
 =?us-ascii?Q?DJ843I0LgW9/05ZvUc+7DW/ZBlgdjbq06UGVhpIVeOIOvFyz7k0qVzPnTBwk?=
 =?us-ascii?Q?01gxQs2G4C51BjG1YGxEwf/z3dTA5YeFItJ2Mk/UYa8/HwdtIeEIKjjHwysy?=
 =?us-ascii?Q?7VP80np5OaRyKjItn2q0Tf0b9nFwFG/JDIKusTROS9eZxnVit0uOJES6I2ek?=
 =?us-ascii?Q?U1IG43WTVM4gJdFnzdNZY+b0dI5iSh6D3hJ3zE0ATCz4cPUVv7zqy1kK+HYm?=
 =?us-ascii?Q?554NrRJmSHjlUNH1GaAU/v6G6ZI19FIcEK5kF6kmdneIDwgaX2wsSW17TU6u?=
 =?us-ascii?Q?vff2cdHEDbfBZ3lZuHYVpvQcyRittYlIZmDew48+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cba08f-b4d4-46f0-6915-08db1a8b6b55
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 19:30:30.7999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vapVsD7OJxACAMUfgPt0da2fChw/WjWQMSdlqxUpLOuM8z0IdJV8l54KWfUsQhK0
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

hw_pagetable.c will need this in the next patches.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 17 -----------------
 drivers/iommu/iommufd/iommufd_private.h | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 6787a0d8d6e9f0..4483c06e0ec38b 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -15,23 +15,6 @@ MODULE_PARM_DESC(
 	"Allow IOMMUFD to bind to devices even if the platform cannot isolate "
 	"the MSI interrupt window. Enabling this is a security weakness.");
 
-/*
- * A iommufd_device object represents the binding relationship between a
- * consuming driver and the iommufd. These objects are created/destroyed by
- * external drivers, not by userspace.
- */
-struct iommufd_device {
-	struct iommufd_object obj;
-	struct iommufd_ctx *ictx;
-	struct iommufd_hw_pagetable *hwpt;
-	/* Head at iommufd_hw_pagetable::devices */
-	struct list_head devices_item;
-	/* always the physical device */
-	struct device *dev;
-	struct iommu_group *group;
-	bool enforce_cache_coherency;
-};
-
 void iommufd_device_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_device *idev =
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 9d7f71510ca1bc..84fe19a195466b 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -12,6 +12,7 @@
 struct iommu_domain;
 struct iommu_group;
 struct iommu_option;
+struct iommufd_device;
 
 struct iommufd_ctx {
 	struct file *file;
@@ -257,6 +258,23 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			   struct device *dev);
 void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 
+/*
+ * A iommufd_device object represents the binding relationship between a
+ * consuming driver and the iommufd. These objects are created/destroyed by
+ * external drivers, not by userspace.
+ */
+struct iommufd_device {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct iommufd_hw_pagetable *hwpt;
+	/* Head at iommufd_hw_pagetable::devices */
+	struct list_head devices_item;
+	/* always the physical device */
+	struct device *dev;
+	struct iommu_group *group;
+	bool enforce_cache_coherency;
+};
+
 void iommufd_device_destroy(struct iommufd_object *obj);
 
 struct iommufd_access {
-- 
2.39.2

