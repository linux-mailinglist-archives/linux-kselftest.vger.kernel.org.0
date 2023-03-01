Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949AD6A744E
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Mar 2023 20:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjCATam (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 14:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjCATak (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 14:30:40 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD6B392A9
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Mar 2023 11:30:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLs++cBeUCHOL1Gx5GLPJR6r+F56B5tbsoG2xP2nMI5O36So3l1EJqADAgaAaFf4xUMiKJrO6zeJCeRL/vybrMYELcfwWNMUwdOvLd3YvLiTAPu+q03Y0uNnm3bKooUByiI8Qv0OkJyxEhjVWUGuIbn/ddwt/WO7ZbGs+Qit8J/4SbZcMDS26HNNBglqPn8+I1/j0fXtLNNhK/gHdJBNQ3QXjM01gfNhMadbF6xDJlZbJ6ttsu81GPAfN4p+EEa4Q1Q6WI5d9nwEsE2iMLu6/fzkgCBArDx0wuIL8Y+0vRmUI3GuwM0fQbZUviLEg5nW3abGz5daXls6+nYaJHj52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1jfip3kaiixxARPeTAyk/c8f+gtmtxu46u/o2DHSVo=;
 b=C70ESpW3uxGwLxrKonb3ASDzwFSSo4qRMCOGesK+qE24zqbjJwt9vgxDCRNDq9siLZzxCTkig9VXMpR8jTkF4JmzwLLYdNGg8/D+MfuKSLabrTyy0r7xUa8nxXT2F7LdwaWlQFuzfLc956/ZgzUVY/Bdi7gV584jFvV2Hbx5p0xLcC1oMxcE88dewF6cpdpgTssDuhb5yQh2CkL3c3NMlm0JXfVxeb1a+AfrbchJiTPe3TNd99tNcFk+L6OUs7gmkS3uwhzWU68OT3M9C43iVb9dt333fFcZnjoUzxr0rj389phH3kf7qwLaI3hSbCA4BnkcbpuMdmFq8L9bQx+Yvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1jfip3kaiixxARPeTAyk/c8f+gtmtxu46u/o2DHSVo=;
 b=p71XntdbS1uuHvUjxndkQiUTLbMYgDHyK0qx+SEKa5VEIMoEIWcPaL1uzjSm/jWnYKI4Z9EM5Aq9wAGfn0ycvklFKfga4Aqd+TTZoNJX9TnDvZaB54BvEQfMSrtVYpKFN4XZFIbSZuwwTLZVIVwaD8w9JKciCRFrGXAUqYbhtQR1KG4587FzNwdMgIn1IwI0I2WEjepk4laJ4lkU0tZzrwCZby9ttdQcdnfJ0krCcWI7nlhlCr6lm1/uTce6Zn29kVLGkZxP3X+FX4RaOQOZlgmpVG/IQUmDplBRdyUDfqa+j6H+h+JXpBOZSLcnVq6QlKGtNAz1xSMb3t7A4mi4Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 19:30:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.029; Wed, 1 Mar 2023
 19:30:34 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 07/12] iommufd/selftest: Rename the sefltest 'device_id' to 'stdev_id'
Date:   Wed,  1 Mar 2023 15:30:24 -0400
Message-Id: <7-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <0-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 1363db98-8652-4505-c2c8-08db1a8b6c6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iyVY6uCF77WBh1Utl7jbygFIZ+UiXj5L0MhRB5gKbKe2qmEo9yAOatiqdkOqQj+XBNhZru9vpiMr/prBAaanuOS371l4K8PdJndAK3+xn4sP6GNQ5Ey8EAlPpdfW8OZQRf4tP46tHCurDuRdmXK0JL5alKADnyiAqj1XAusjt8IZxi7ksAewAj1G7QtE2iO5OTtQRWWBCTVWIsCch2t7oxJnQ52zkoGu6zGktnowU+o+oE66KxgxH3f4lfl5hvA3f2GZTztF8MrFjtc2hXYBe3anTGYarSffdt/C5u9NPSZJrV/GKRy7f1dLGmL48CqKVMDvVNw/hMbAw5d/KfVw7iAQT+UIxu5YScxlY1PehCRc8GMBUqZ2qq9a4u++xr3uEmWgwUGsw0uC3QZR/O9EL7OSa2uppo3+9X0CjBoRo3zTOnCL47PGpZdLLpjgA/P86JpX0sRCCD+r2qtnhaN8OyZsuOJi2Xqf8Jg6qDG5H2tGl+RfeyvIPmy6xYDqYfQExEGMqB3+y1MsAtPOudP9sn2fpqrUfL23FZMc60z/8QD/n6kSrJyIKfFMM3lvkw+eyBVkFfWrm1P1VDZtFXKFI52fpmUR+c34nuhOAbmPB8Ayyz5ymypolb7IBZaSndQqOCHgL7cTfu3syeNhmHtVwUlCDAqEClO+LwkynLR+DnbNLI0uwl1ZCxXsgku3oFSv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199018)(186003)(2906002)(6512007)(5660300002)(38100700002)(26005)(6506007)(8936002)(4326008)(6486002)(41300700001)(86362001)(2616005)(8676002)(66946007)(66556008)(66476007)(6666004)(110136005)(36756003)(54906003)(83380400001)(316002)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U6NV4aa73ISNaCAz74HT8/BcWLUC9vWt3JflYhMIynk+cAkM3XRNFxa2gMtR?=
 =?us-ascii?Q?3CXsD6D1ICv/Whc37yAfpXLxySiJ04v7Ni8vdBXRfpvIa+i7l3xdXa0bq9eA?=
 =?us-ascii?Q?XiHG57ic6FIGwZLPBaGWgQHbG3rgjmtqdCsrf7L0piDSJ6ET9OSc1IUxQgvI?=
 =?us-ascii?Q?HyuemiptrKxcJ44wif2zzYksJBciECzx4jQzXP8IvT3sbrgz3Ekb+LJGerhb?=
 =?us-ascii?Q?41uUuTjuQWklB+abT4E+QlbXADzz8Rr+QVzUP4rAT0AEJZvJPBEM46raPwkq?=
 =?us-ascii?Q?poa1nupm8P817d7Rf4WmFUmLlcPrOSEhHDfO7sYWQsoGNn9/Y5j40pZsEhcp?=
 =?us-ascii?Q?3JnO04blInpXPniqyk5zzhVoAXQHyCyqZQInsjvqbv5kh3HGT6M8i+WM1Uhf?=
 =?us-ascii?Q?rSLrHOmMg+z3cAIY1J7MnlZNtUNi/SqPQMsEROHS9c78tnlmp6KXGk4HgjL/?=
 =?us-ascii?Q?pVWQLiU9UKxPc56oXW/q3h00219fyHpZDdhDAZ7n9wiSrM1XoR6vkpIBOFMG?=
 =?us-ascii?Q?xgDjVScuCD396jljF8TyoVpUns65L8t0jOiSlj2Fl2Nwt7fJGrdu21CEVnDv?=
 =?us-ascii?Q?UTC6qMRL1dH4VawOHI0ruzqHVMM69/LxQ82OiyL6U6P+kQWTbLDe7KTARCZy?=
 =?us-ascii?Q?SDruF/HcaKgZwQFCcCO2s4QoxURiwXpzIHspj93Q6fLoHpjpYPgXPV8s/75i?=
 =?us-ascii?Q?RPYWrEmbqHqybYW1io29/6DxYdjT3TMKCLOJUZQV9c5dZ796or+fG/bbw//o?=
 =?us-ascii?Q?VcN+iyFsq6u28i1Tyc9jynr3FROqKzGiYuMELPCGbqYHtVSErb4bZRPFQJbO?=
 =?us-ascii?Q?4ZIKDPWFzjq4esonOYy+v+lm4nA+NolX2DWsdL7nV6MjC0OZSd5+JJQ9B8on?=
 =?us-ascii?Q?LU6InAFXQNsTfX+4yfFFo8z7KOYe4yk2AZe6u1Qw0eKjph9lCmTTNrJASTJS?=
 =?us-ascii?Q?BItG0/LmwDOL8oeER5DdnAG/ErTmU5JGr09aBcpItVvN4fDsyUYbm4oinctL?=
 =?us-ascii?Q?Zs6FrF/+WQasNIZwrGQb4ncaVeS/nTBqhUStLsQDZXTOGv1IQt87nnjtgn7W?=
 =?us-ascii?Q?E3Q/cusbZMNiUYSPUU0twOBvZsl7hthmclHt2N7OoExVYLruPrLhhliICzce?=
 =?us-ascii?Q?+fncBqk4Fgyex9vtLwg2psChorkrnApXJCMk7RKVb/tF2Y1IyRWXHkYe92Qp?=
 =?us-ascii?Q?jLwk6AdoeLTmo+nJ1jvNRPzBhDLYkB9E5gLP5zLl0l+JbGESDYvidGCBYiaF?=
 =?us-ascii?Q?ABgfJzwTfiVEkTf+3P8dASVG8T0Y01U1rXcl/VMnxceTsQiVGbmpf4Kj+KfK?=
 =?us-ascii?Q?XxSpfOPH+Sd7PK+RzswPU8XFxaa4dx3biuDbWUZfkCQdlG0vopLJNPNdhwhj?=
 =?us-ascii?Q?sgB61YnvI6k55Fs3kX/XJBtNOpEyL83prvPIIjUbtvACdA5xp8jl4PLvA+mL?=
 =?us-ascii?Q?ibBc/Um6UHRO/CPOfouAqDTyWSQmwgUglNi4a7q5hY+ioBICMPyo7lwJZK7+?=
 =?us-ascii?Q?dpXb6wcyUyN6aPT/1D6MO08HTXOT2Eq2gjIYIZzpZxMgYl82vYLqGA9Yqs6G?=
 =?us-ascii?Q?De71yjh3h2NclLPDqaoD6+m77NBi/b0bVsl2UtJV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1363db98-8652-4505-c2c8-08db1a8b6c6e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 19:30:32.6125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4AZjioGOHbWmYxOqSpXMCvZFjbjcK4UiAiqSIsXtyPDoSnGoq7jHjitusmGa2Ij
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

It is too confusing now that we have the 'dev_id' as part of the main
interface. Make it clear this is the special selftest device object. This
object is analogous to the VFIO device FD.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  2 +-
 drivers/iommu/iommufd/selftest.c              |  2 +-
 tools/testing/selftests/iommu/iommufd_utils.h | 16 ++++++++--------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 1d96a8f466fd29..b3d69cca77295c 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -49,7 +49,7 @@ struct iommu_test_cmd {
 			__aligned_u64 length;
 		} add_reserved;
 		struct {
-			__u32 out_device_id;
+			__u32 out_stdev_id;
 			__u32 out_hwpt_id;
 		} mock_domain;
 		struct {
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index cfb5fe9a5e0ee8..e05b41059630a7 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -302,7 +302,7 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 
 	/* Userspace must destroy both of these IDs to destroy the object */
 	cmd->mock_domain.out_hwpt_id = hwpt->obj.id;
-	cmd->mock_domain.out_device_id = sobj->obj.id;
+	cmd->mock_domain.out_stdev_id = sobj->obj.id;
 	iommufd_object_finalize(ucmd->ictx, &sobj->obj);
 	iommufd_put_object(&ioas->obj);
 	return iommufd_ucmd_respond(ucmd, sizeof(*cmd));
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 0d1f46369c2a30..85d6662ef8e867 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -38,7 +38,7 @@ static unsigned long BUFFER_SIZE;
 				&test_cmd));                                  \
 	})
 
-static int _test_cmd_mock_domain(int fd, unsigned int ioas_id, __u32 *device_id,
+static int _test_cmd_mock_domain(int fd, unsigned int ioas_id, __u32 *stdev_id,
 				 __u32 *hwpt_id)
 {
 	struct iommu_test_cmd cmd = {
@@ -52,19 +52,19 @@ static int _test_cmd_mock_domain(int fd, unsigned int ioas_id, __u32 *device_id,
 	ret = ioctl(fd, IOMMU_TEST_CMD, &cmd);
 	if (ret)
 		return ret;
-	if (device_id)
-		*device_id = cmd.mock_domain.out_device_id;
+	if (stdev_id)
+		*stdev_id = cmd.mock_domain.out_stdev_id;
 	assert(cmd.id != 0);
 	if (hwpt_id)
 		*hwpt_id = cmd.mock_domain.out_hwpt_id;
 	return 0;
 }
-#define test_cmd_mock_domain(ioas_id, device_id, hwpt_id)                \
-	ASSERT_EQ(0, _test_cmd_mock_domain(self->fd, ioas_id, device_id, \
-					   hwpt_id))
-#define test_err_mock_domain(_errno, ioas_id, device_id, hwpt_id)     \
+#define test_cmd_mock_domain(ioas_id, stdev_id, hwpt_id) \
+	ASSERT_EQ(0,                                     \
+		  _test_cmd_mock_domain(self->fd, ioas_id, stdev_id, hwpt_id))
+#define test_err_mock_domain(_errno, ioas_id, stdev_id, hwpt_id)      \
 	EXPECT_ERRNO(_errno, _test_cmd_mock_domain(self->fd, ioas_id, \
-						   device_id, hwpt_id))
+						   stdev_id, hwpt_id))
 
 static int _test_cmd_create_access(int fd, unsigned int ioas_id,
 				   __u32 *access_id, unsigned int flags)
-- 
2.39.2

