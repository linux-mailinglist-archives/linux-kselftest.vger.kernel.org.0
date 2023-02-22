Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB1669FD56
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Feb 2023 22:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBVVCt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Feb 2023 16:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBVVCs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Feb 2023 16:02:48 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571002A15A
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Feb 2023 13:02:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QI3C7tzAjvI9JciDAQC9B+xAgCF5SJfW13XkFJKyBmGsrYprz0IHCRvkrKuNeZGdrj6lIyKI6E1CTymTZ9JDUvrPADq9hDG3psJuBw5k4pvJYC3B/B3jvflbGEPaOi17UQQlkQ+D403yp6+nMl5e18UoRoxCS/IJEHa4kDSbe2TSTR5UGOM6N0qyoCszLePKwHZl/eMFKPNYLHr/4x7b8pyHf3+MTkc7kNX7LGh2ArWp4DKJ/GbtZglIQZLYzGGJyr6HFgvX6Qi3fAsq7zh6/JRIqDeuKtZANTdGgDoJFc6FklGOXP5gGajWHpspQnis/iPRBYtWrLOUf8jXlegsOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nu5yBrrs6yqv2fqZNLDU92PUUel9kRO9VoOiR8+0+DQ=;
 b=OXveeQdhSUaYmfL26945ozzBHubG9pdSwQqBg3ArirBVtZxPzlNrTluDADWJbpbVdEwsVCtVsbNDd6rYLNsd+PVI/MIWfVMcYoPmD+jni2l8N7FYOtlxacKFMco2Qv1pn2oF8rSrkN0VQE+dn2DFFeDg/BMVLYd/j1B7ow2g4EhSar2tr3vFcYhECWsTFQu7fI+TfT2rc1VWpMZDnnhvn/hore9m8klwSjQHJSNTZP0l+LOB70AHO58jVXFkEsHhkFUsPlfzk4O5U+kNh9RmSHZha8BYrr+OdGIju33rARvBAbom6p7zH9Cjvh39u/x0FVuxj42AcJhUXM4l45+Z4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nu5yBrrs6yqv2fqZNLDU92PUUel9kRO9VoOiR8+0+DQ=;
 b=SHlA4CAk9Svc52yYWsS88iwHwc43DgBBdPgenMyUvHQsHMN9sY8oZO14aD+Vr+m29f8NxgjQJ0SyVOwCRb7AyUxIj3jsRE/iPdCGwlocpuzeVUQQzabRZrKGCndFemmxfHwvzP0j8W1VLugrKQ7dIkDiRi1moHFWi5BOLZVr6vAYgT9MTUekV/wZmYj5098gFt8iXbQoFeGwdf9cAi72Y/vy0a/rVIHbVvb9TKcQTvaoamSZuA9izxP5AMsHRb3fB60HdljuxCZjGm/6X/FZaQOiphbnSXFcOOd3EvsXcNp0dA61A6Jo3ty+mNLSuh6TxmrUy9J8qu8JVY9xla/DPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 21:02:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 21:02:42 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 1/7] iommufd: Assert devices_lock for iommufd_hw_pagetable_has_group()
Date:   Wed, 22 Feb 2023 17:02:34 -0400
Message-Id: <1-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <0-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:208:120::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: 090735b9-ec44-47dd-0ffc-08db1518233b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K+/GeCYHxusnkdFqgxtQtF/BSnZcwyaAj8BCaoc353K4y6R+Fd237KhTT3rn6nWNq56ukga2ZBovXPB/FHSzRbViTNSoSceeLo4DOzQVID+lFke7/le+ld8+rV8tl/WGIjntYNqxZx87iL1m3BA/ZS4sQdYIaVO8CPPT5JvXv5mivzDdqWdXoQCa9FNbmHD0SkAIg6ftMAxNP26hcsyJyMqJBdBTBLdhXm+swdsc6kGSASI+T3kC1YxsG6sUG0JNUcJnlJl1U+mat24T2aGP/OSNlnbSmO6jpcvIWAmu020TYihnf5l5GgAuQrjEIY7jVMn0UxAYiV3PNogni9zGU/Z/DtqaDWeTNtrh4BwThRYxyA8aZ3MtZcUhkBOjt4e/iSUbDd9W4XvcgTfu5jFWdiWFTutCRUNqqkEN6UfCz1C0eZI+Kaj5zIDyP699dXJ/pK/TDNxpztdD8wUISLoQO5OBWFKmzvO+7z7qkn5O51DWI1SHy1wYzDCPu5u/dRxFvtKP9ps5bOEA6TG9197M4VaUaeo9E+VL0oj1hI7S63W+886HFkDRlMsEnRyxPjZqK5aTtZMRBv7nlo+vq4sk60IRxkvarXk9VBgbNW8eijyevA2dZTMzNYuXVZ+qek4/j7gdV8e7/79NxL63H8VXpqbTMjCnZxKLQcbNfnlUWwJWp6w4Ms3CUh/MIYoMGo4D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199018)(86362001)(316002)(5660300002)(36756003)(66556008)(8676002)(6512007)(66476007)(26005)(186003)(4326008)(8936002)(2616005)(41300700001)(54906003)(66946007)(478600001)(6666004)(6506007)(110136005)(38100700002)(4744005)(83380400001)(2906002)(6486002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XFbjRaZKiwwIeTRquObL6kBcJ8UW0VKMSHRhr8CipGIMeiZvUds1wvJ26g64?=
 =?us-ascii?Q?shEI7j3HEJfAj/91Y5QwsmQ4vMlOJr3DgXFzMgyNGBo2r+ElrsogzfjK45ve?=
 =?us-ascii?Q?yG6sqAB/OP2oR5g9G/Sv5Kcten8Wmuf73slNc4StWsJLdE15hHWhLJt0qKED?=
 =?us-ascii?Q?PS5AhDN4VLsx9p1pOKKxQu6nAk90sUX62IfJ7SYXwmXu6xgN4mpcIwCqBbIM?=
 =?us-ascii?Q?S2AXb2y7X99QWxwjPORBT0MZDuEIr9Msjg6vbHvoMrFowF8qArQPWR6fagip?=
 =?us-ascii?Q?ce6uNHoRzNKilIKlcbIYzdkmSh6AcEAirbJgcv2PMJhMinID+Wh7f+MTEpD3?=
 =?us-ascii?Q?7t+a2CQyO3rxADXVwAg9mOteCLp2IfTivYVw9b64wdjRZQZItVTPWfSK1xOY?=
 =?us-ascii?Q?DZIH+3pP7fVn1a+8u69EjcoOZ3FpTdTFv56aLERxK1b3+iz9yQPqqjFtGbQv?=
 =?us-ascii?Q?Ax+Bf8QR1WfXJfzXDSoZZkXP9cbv/EHKjJa5ohXkKzWOkT0p4AJ6aIkMy45x?=
 =?us-ascii?Q?uomrTuj/jAD3jod23DkCwV4D6hX2Zmuf4XTgLz+4SD7FT7yxJoUe1p0IL+D4?=
 =?us-ascii?Q?1bBB59PXQmrrAO7z4jQau8I2tYvbu7huO6aJGEgbvrhSSDc1nrRceZfw6Nod?=
 =?us-ascii?Q?pRVSdPhIkGaQ5uwEK/QJYm30/lfJStUGAhTunvPul4mIp03O8Gowqx7I3yF9?=
 =?us-ascii?Q?eEXYJSqX1/cU2/1i5MULNYANxpRm9Bt6HBu1cc5N9m1Z0OKcpY9PSsS9C9Ot?=
 =?us-ascii?Q?rJ7lzvRF8hF4rCZ4fg2r1lIp3ffDSLnmniJu3KD1lN1fXgq6m5fPfQT4GL4f?=
 =?us-ascii?Q?q+wdqtRPaRqPUP7Gto7BhI/EvhOqxOiyuG8T+woU8XGDjNnefmHPqbSR5mxe?=
 =?us-ascii?Q?8gMLNi4Cvts9gZE3lTomMtajfNHd3cuVekz3B8b4SP2v0WlKBKqtsl8GN4Wb?=
 =?us-ascii?Q?zc0RkyPbgi9qYALWrtNso2ZYTJKAHCHDgTyV8SnwDBMWwocaTEvwV8iROoJ/?=
 =?us-ascii?Q?MSaeF0Sin6h8/PFDXLeKNe0CHi1kNPOZ/rN09x9MiXqmpu3AXp54yLPSFjtJ?=
 =?us-ascii?Q?s/8u1S3wfmiBmdm42QAsvXZrYwGnqVFsW4FNWm5QgIMwLrYhqNhKlkzOfJ/t?=
 =?us-ascii?Q?GEtN9z3KlKF/vFzZkga65MDXj+PUCVwmnRUeizfPm2aRtqtU9LP2+1/9SB4t?=
 =?us-ascii?Q?TXMObpi8UZaZwmLWXP+clFMKYEJGuFYKSMjSXFwYjmN8Q535lhq2yq0cbK8R?=
 =?us-ascii?Q?U5UBGREFtkUCVSF1/fmspLr+JKo7DD2nZz8mOXgxNBBFKBzPhKI5isHiQN8l?=
 =?us-ascii?Q?+I7DtptNXLg/dAfkhIa2bhmjROkCsd7WLZis3nG1ZxaAsiFib2jJ/TLCjXNW?=
 =?us-ascii?Q?MUopQZUurzGI8ZWSTbhIheLN5ahnC7g7qkKblpfOckCsbJVQ4O5AJJIoRJpC?=
 =?us-ascii?Q?7Czk7oPjcCV7Fq+d/2/QHvnl4DDspjkng7uuT34WU5YGid9mqkgVDcBrCGRb?=
 =?us-ascii?Q?y+Fm2xmbHkJPwqrAwHN7clzCvx6BNbt8egL4JV4ewu7xrnQmxvR74dVrYdM/?=
 =?us-ascii?Q?9Do2QJfVWRaZvG5PTQBmzY3UmtIN8pY8x6eeZezz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090735b9-ec44-47dd-0ffc-08db1518233b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 21:02:41.9559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxU2lpBEavxk3yOQIy96a2eJAVy64h0n9XE5eFZ8ZcOYc9/aUGDwi18TtXGcR3jj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The hwpt->devices list is locked by this, make it clearer.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index a0c66f47a65ada..dcfaf6567420e0 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -186,6 +186,8 @@ static bool iommufd_hw_pagetable_has_group(struct iommufd_hw_pagetable *hwpt,
 {
 	struct iommufd_device *cur_dev;
 
+	lockdep_assert_held(&hwpt->devices_lock);
+
 	list_for_each_entry(cur_dev, &hwpt->devices, devices_item)
 		if (cur_dev->group == group)
 			return true;
-- 
2.39.1

