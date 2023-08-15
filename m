Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEA877D040
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 18:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238545AbjHOQmx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 12:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238557AbjHOQmq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 12:42:46 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A751999;
        Tue, 15 Aug 2023 09:42:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLTykoHNE0bWRrIm0uaPAy+1ZQwSCWEMgmn40cP1WcgF5nh9TbjbH/DA04/ynqAzUuE+QKhA+p/WjzY1bTOEO2ai6aqP4G7mdls6RKumb+qXijmSmfNtTjKPWBjpvAqeb01wrKx/0ZQjUcL2VWTKtorj1bAYoe/o/0gwPwqbx139F+QjTM1ZjzMSAdX6SPS7+8j4Y+n8ylivoNE2JQDlLqLseb2R7j8HZtJLtMdUDnonuBooTA48JKGgDRR/p7Xqd2DMaPfdLzPPjbwyD1SkR6N4tB5cFVaDq9P4LmuIxhf5Vsq8WVoX/SJ4sYqg691E8DMOkGknuJGMcDnorVfetA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzHG/tWKB41iD8N9IwYFOFJMRfiBegUyl7L1yHrnXXs=;
 b=fHx+aBspLMquX+y9fdRHSE3wvWWdvA+SYCuc1UQkimK9wLX780zJzFcMzix7yCYVgItiLQdH6IKreX96s3lMquAPm/gpX+E/JJZXClLWP5qwNaD7f11+VO5r+NT2A4FOfHaXKzWAxoJVKT0QD8n/5J1+Gjjk+9JRCIcWlf2CwUlVbm52pQfrfQTIgI72jDtnW/uR0o+1HwHbwB4L2aIz4QhkzRwdE9YWeXzwl2vCpkUq8Q+L8EHL/O83L7DmbCMKh50x585Fr+iGq2Fek00W68Ajy3OMXBKMjswTE+cl2InT6D77j8s6DGF7fqqyQHHEBuzDtG1rrY7Xzu6jXTi2IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzHG/tWKB41iD8N9IwYFOFJMRfiBegUyl7L1yHrnXXs=;
 b=AydDp0WCVb9KVK22VCS3NROiXpdQ4pTevHSh9RuZp0fylGzbhSPyrtrqC+E9xzbkW+1Jch+l7Q8i9UU1B/jTFOhEbJdOzNDHppTSH4I4Mblxz64wolxeTpNcsXLn6pp/78LPg2JjsynJ4XAaDU+aES90LE4RrZK4GoOY3hSrwziqF47htsVzG3I6Cpthm8xgYGO72vRLfQucMoDvv+aXrwrNuYCNV8zseRVXWKke7otDoVB25rA2o3Y3dBJLItDbRAjWdoRU67cFwNq9eQMcejYsdc9pfLiyH37dFM5c9nsDhN1oUe2uyRj+dhK+FdsRCs+4lnXeRpKjkddg/Hg+gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV8PR12MB9182.namprd12.prod.outlook.com (2603:10b6:408:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 16:42:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 16:42:39 +0000
Date:   Tue, 15 Aug 2023 13:42:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
        mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com
Subject: Re: [PATCH v7 3/4] iommufd: Add IOMMU_GET_HW_INFO
Message-ID: <ZNuq+17Gv/d3lEin@nvidia.com>
References: <20230811071501.4126-1-yi.l.liu@intel.com>
 <20230811071501.4126-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811071501.4126-4-yi.l.liu@intel.com>
X-ClientProxiedBy: BYAPR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV8PR12MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: 940ce42b-0a61-450c-c144-08db9daea369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ClLUKAVexlyEETRRRTCoO+jhpdiWc3/gPIu7ZHe6ALMKWItzQMcbH7JfNdcNwVQQXMWsO3tfWDGNqcJC2HbXIujUbQmCz5o1I25b4IWgW/jENOux9mXJLYiY21Xn0TiV7l/uhd0dTS4oUGab77kvpetGMCVGnlrs5+JzjTYTXsOXxm0DWBa17nBnRMFz9L9Hejx8VtvZ/Sn71Rd0RCRMCyAfW7HvJe5h/Z1csOXZU2SX2UT9jb8FeDKXd0uU6Kwo+Osqj5MO0ov62CMqrnOWeLOBTBYIiEtECB0D2VO0hAJIO4aXmjMvc0qtNPNDzBM/UBxSmEcnB4JsYsFlHPmdKNwStPsMt7bICTnWV2Eh6Nb++PgVuUt1UU+UJkjDNS9zuuuu7hbD6G9mf00t2twIP+7RAK7wlhQiwEOOu1keelCHxwNvNo9bBQhqeKdj6W/BE0KDioTANV6/p+1z0qGtA61AtcEGAYopojiOv347kM0DVmhyF/LWrlR82AplyNIy1VxxEZR7dch5dimPPlNBAOjJq+lavPc7pH0Zi7m0SbrRpXVYTjSIOT2TAWrmTwTO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199024)(1800799009)(186009)(86362001)(4326008)(41300700001)(6916009)(2906002)(316002)(478600001)(5660300002)(2616005)(7416002)(38100700002)(66556008)(26005)(8936002)(6666004)(6506007)(8676002)(6512007)(6486002)(36756003)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RwRbiCVI3LQKp856hldqLjcvYZpXsw2sirK3i+qIZ1E2Qsmv+D7+J3vnxXWj?=
 =?us-ascii?Q?/thE4EJq2w2XEIFA9fwyBeXN7r29h3ovaJnijhSx4Tsa/Wp5Rs6nYmbrsgVy?=
 =?us-ascii?Q?bol/L8EWjUeoW7Ra5oIFU0LRy6XtNyI1xieh0zczgJiZ7tKZqWrAatFO0hUv?=
 =?us-ascii?Q?deRjpxDiGev68SdGM2UCbDihCfhV/LjUmSblJDgVbNi5rO64pntUwaL5vPTq?=
 =?us-ascii?Q?XsxZfXPQjCnOC9cw4z3LAHud5SJS6zk8h+gZw9MQMO6S2bNHtSpwViQqaXbK?=
 =?us-ascii?Q?AA7AcML+a+AbLHD3xfuHNKjMc1He4sHu7O9u+473jsYAvF+dekXPI18q/+FH?=
 =?us-ascii?Q?5BQ0XcXSj2/AkTEtSGdk2GwoAMz4ruvfZpODD+MqqJ/AD29ZOWIyxTd9IPJM?=
 =?us-ascii?Q?G/CocPFnBZSgyvjYYFpRVzx6l1W0voBi5J3UwCvZtCHHzkKXKzl4X1rAS09r?=
 =?us-ascii?Q?GFhKjIDsvYpu05/qwaBK+O6hSnUd5a9vn4myCWB+H2DLoAkOQgPgHG2KWius?=
 =?us-ascii?Q?45m8gZw+cHd+FTQgt5aGHx6QDUuIo7nb3LtlP4uf2wrcvvfsUlG7FpvnC2c/?=
 =?us-ascii?Q?YDeAoCuP4hFR1zx8kvo5ulPm2UmWQtR2dqKE1FKIJ+7FqbWnZz4Km2RMfljm?=
 =?us-ascii?Q?ijaieWjo1fkkHuRzpYGpquBuarXqigufoxViZw0PHX+fqi3ijBNYh/P2RFq6?=
 =?us-ascii?Q?lVadmprUNE51/xDscVjIHmlGmaf1pfvtYcUaBr1ZrNPOHro+JmaRjm7IA7xJ?=
 =?us-ascii?Q?KgRSyJblxfOQ2BfXj9KTlEgMVtbeZjNL7f1D8jCB61h3U/7aYYkTTmXlfMn1?=
 =?us-ascii?Q?z37kFhC+qbYJ0CWk6uRCGbkjZEJu9dfUL+86S0RvMF3dnpdG/X5dnlx0niCb?=
 =?us-ascii?Q?+Mn8DhWirlMl4V5JRQFK1dpbpHzVnnGtAanRoW8LJop2LS5nQH0SSN1PXnV4?=
 =?us-ascii?Q?zznhXo3dFIebF7fTBQ/i2Y9RTPNdnqJmGlkM4rd+6r5w3+UZu1Bv2d4jrmUo?=
 =?us-ascii?Q?WnXVq5FPm6FVrFvHE+DN/mVTPmHluKtqvU65JXKbIfK2yus5ZPJz+No0YJwI?=
 =?us-ascii?Q?5pFgVuVl5D8v/XKPzWWwUYFgYfNeQ6oS6OY6W/FYQEzBP2zdN46wFUHSQhHC?=
 =?us-ascii?Q?g/jsyS1D8FHd315ocFw+SES0rxe4IKH5dNeFWlj7ZtXNY+n1cuO5p9DGxjc7?=
 =?us-ascii?Q?hPvRW5I+mqPfhomM3MndAzyNi0vUf5igkKlc1GTT2u8Wqm/5NBgzKJd9d240?=
 =?us-ascii?Q?uFzb8JWxAi7CZQWL31SVl8xl6HMUgl0KLGgVoHfyDq8SCNivMc4iuIanQC0P?=
 =?us-ascii?Q?4F57QOo8WtO6dzOoART6kzbSVrWIaLpUod2wCVvlpHqvXpTHa980XU3/zMEW?=
 =?us-ascii?Q?HBnu4rsJTZi4aE1yPrEswDgepeSMdruJtBw0qteCA81tqE9KuG3khMrBY5FR?=
 =?us-ascii?Q?ds8TD7JcqZWgUeib8/dTXNhrRKoCsfXH3NreY4XvWBe3GrU9pdvW0CDb9eBz?=
 =?us-ascii?Q?d52MtBJDqBDm1mQTOcdpym4K/CSM/vRl8eYmdbX4pWY6doSyCDSZ97AmlkZI?=
 =?us-ascii?Q?7axKeGUB0X4ha0borvTta1WbaNqX5y0CpW5kzpDh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940ce42b-0a61-450c-c144-08db9daea369
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 16:42:39.6197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgfhcJdPrba+Kie0CWbGkHY6724d8fDp5n7KNDBXUE4idHFeJScYCT2jQusVisAK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9182
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 11, 2023 at 12:15:00AM -0700, Yi Liu wrote:
> Under nested IOMMU translation, userspace owns the stage-1 translation
> table (e.g. the stage-1 page table of Intel VT-d or the context table
> of ARM SMMUv3, and etc.). Stage-1 translation tables are vendor specific,
> and need to be compatible with the underlying IOMMU hardware. Hence,
> userspace should know the IOMMU hardware capability before creating and
> configuring the stage-1 translation table to kernel.
> 
> This adds IOMMU_GET_HW_INFO ioctl to query the IOMMU hardware information
> (a.k.a capability) for a given device. The returned data is vendor specific,
> userspace needs to decode it with the structure mapped by the @out_data_type
> field.
> 
> As only physical devices have IOMMU hardware, so this will return error
> if the given device is not a physical device.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/main.c | 85 ++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/iommufd.h | 36 +++++++++++++++
>  2 files changed, 121 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 94c498b8fdf6..d459811c5381 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -17,6 +17,7 @@

I was looking at this more and this code should be in device.c:
  
> +static int iommufd_fill_hw_info(struct device *dev, void __user *user_ptr,
> +				unsigned int *length, u32 *type)
> +{

Since it is working on devices

main.c is primarily for context related stuff

Jason
