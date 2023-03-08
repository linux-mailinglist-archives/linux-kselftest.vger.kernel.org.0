Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2246B0C15
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 16:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjCHPDQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 10:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjCHPDG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 10:03:06 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0CE59D6;
        Wed,  8 Mar 2023 07:03:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THm9SDT1ZHAqNuUnOh+QRlK69vlIKrwocmLBnwmA14OGVM0cWCo0wxiOWSNngjmWH8+55dx4VHO41ByT3Y6o+gRqDq/WxL+3s/0yWF0LcTnnbu5M2wZYkYS8RO0hVtP1oFMdzZy6DZJXaFkgUUUv9mrY9JAlUhl8ZY02/ikUwhy8KHxBN6PqQfSdyyShOs4gjXBPoGBoerEDenn8gfuLpPo/MwuXl5uk4D12UoXclj4/vLN+7KG/sNkD3XeRAekw1G0Z5McYaQObXJlp0rXcFX0aanlL/dt/Jqw/5qhyGwmlOQ+R3brWo3goWyoMfhvpa4EazdXr82eLuXtyPkaYcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7d4BxHWwUUgkaUq+wPB80ARtPQy3sdf0Vu5WfdJJv4=;
 b=Uaj3DZXDzOElZxX4/7o4xbIzUh7caXSwSPHKRUYuXMwhr3BCiytizVyb7NAhL78Mqaqr1x11sysuyGUOpYSqmIyow5ql4EZzSfNocDGUXO7SNDNVGKpvV1urtBxzm10G3zt3NyjyJmcv4l6nNlu0HhWwsLKVyDktE+VOrXFgTw2QbZhdj2DxpbK8BAToLFK51N83lMZArUwwqyvtGy1C6/sgLX4W5iuppxisNIgw2S4gRhbQrbxcANOCehQMjqvTXztP0G54KBEhu73PrHQKdD7EezkW/zDFKH9OqDBvhQp6X64/vZrB2l5uKZXKSTh5boLaAp8F4KeRYBLLzC9v6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7d4BxHWwUUgkaUq+wPB80ARtPQy3sdf0Vu5WfdJJv4=;
 b=sy+e87X52UG+2JnqlX0KKr0iFKceHuFbmD62LGYRDJ67f+NGCLR+Lf/hl7e6/ol5SKe2Qyj0pgRF+VXQKmQFoj0V+58JZlOtShVQodB2L2/2VOAHHdIctI7BQdlIhwCBlkFpdiXTU87pPG6uXpaRPznwermYhjna0PeKT7pgp1Fz9/nx5gT0IUMlbySZk3c9jciaVIq03gy8aGuDm2gBaCeFHHKNb0x0/5WWX84MkIp1oiZDEXSr6Wix9G4Koy3JnOOX9AB4CCMiT4Fi/FKnUbjfCG+uzyT3bmW1Gj6oZAD5nd4R78cEzUqsNMs1+BDC83v67wvBGIWS7u6e0jdm7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7842.namprd12.prod.outlook.com (2603:10b6:510:27a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Wed, 8 Mar
 2023 15:03:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 15:03:01 +0000
Date:   Wed, 8 Mar 2023 11:02:58 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 05/17] iommufd: Keep track of each device's reserved
 regions instead of groups
Message-ID: <ZAijolW3I1BOSjpn@nvidia.com>
References: <5-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
 <9a047c7f-924d-0c8a-7055-fcbe7c84429b@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a047c7f-924d-0c8a-7055-fcbe7c84429b@linux.intel.com>
X-ClientProxiedBy: BYAPR21CA0018.namprd21.prod.outlook.com
 (2603:10b6:a03:114::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: bdbe06ff-61a3-48db-04ed-08db1fe635e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /n+wGwz3G+hAgsCs87C8HCVoP3q4tPpehNZQiEb2AZ8tbKUkUD8clbpxVSWatB+7q7NIfAh0qFql0IV/7xEKgzi28cWhFw3UuxHppaZQkRlecg1yFfh8LZe89VQBSCtprcspZD9YEPJewkD1nnw+TiFlflh4rwYeCoKwlzjzp4hU+aSox0SJjEWSv4TdY4d5Id2gGnHIk7HRHFrxJ2XxcTzbndYENIUBGLA06yCwhhP+JN/wjqaCWppXQGbxQ4rL1jmS6LdXdZlNkZl2uIYQy++oqhx5BjZ7MtEOlJVr7eXlMr8D2TvfuuKKVytzRKZRzaKwvBrdKUJ9/V/jiXMzMhva18jxOdoYgEmNp5FsI76MgGsp3Dp8m0jWMpQY8AtdYGYPZgIPHYmALiT7WAACvzPllsLfUJoSHhYL5+TY0pIlJOORnvT9jbF9OXIikmsf6/15cAuIcp+oY0AwWotiSKt01BkkLfbdWIg0dRyCmVv7RQkHevmVo6qI++T+qDI+unTzz2N4ak0QgrCrZ5GDyu183wz/QGYT73iALlVMq3nL2pO2LGSIAhCXGkjWnSDFOFH+fhn7r0Y84Kr08jpgqHKZVstfTyJRxEX0f0ReZxXpaPBPM6jFQNLdGizqM95F9zZSNNX9WJ915RpYlSxmmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199018)(36756003)(6506007)(186003)(41300700001)(26005)(6512007)(2616005)(6666004)(6486002)(6916009)(66556008)(66476007)(66946007)(8936002)(8676002)(2906002)(4326008)(86362001)(5660300002)(38100700002)(316002)(478600001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YcaJ0Ez477xDADRHGOvxXdRWiOOlhyApcTRBz7uVibFzrpLasEJWm20J43mO?=
 =?us-ascii?Q?GuSZHFm7HEYmIm7P1F6xGGdjBzmg1dCpzOdVxWZgKuwiNmYEmU0FXWTR50+f?=
 =?us-ascii?Q?ytFWlI39UbrujogrVq7IVIHYEH3P8vf9f8f9lqA+a5eGmirxzkNMyL5ZjGht?=
 =?us-ascii?Q?uVXU75MK4KUX5cTUNCOjHZCqVh1AZQc0syyWS9A070oEabruSWrMY0/oVUCW?=
 =?us-ascii?Q?VeiMus2KmsSXKiD3Jk8CK70AqoKEJbYyCT5jqFogdxjHKS6GAeW52J3niK/F?=
 =?us-ascii?Q?dOYA4eT6kqfRJjlzB/DsMi+AeqLjDT5SHwZKbJdgVkcC/3gCepmxGEo2X2yE?=
 =?us-ascii?Q?9NIeEUsDgJy9IweFZ3HmsqPFBKYjdflTfLHztRozZrp1LOUaWYhNbpWoOFSF?=
 =?us-ascii?Q?yNuu2vX1BOsUMB94k80vkBMQVGgB6EYUwEop6e98sg32AYwVCuBy19EYAikX?=
 =?us-ascii?Q?QAD2fAAcyyfpO2mexv1coNS5Pa4JwTcbZO5sKA1cypYPUHZs0XMNy8B/PxzC?=
 =?us-ascii?Q?mqRyxiXnQ10Tj7n28yP/GeMrjiSSyULIlAIAgj0+USDNDTDZ25sJ5B9y0IGO?=
 =?us-ascii?Q?jr/Bf+51uo84aAxA9eR1Q1s/JfYTF4Ge5V+PzCE9CQVZJiAUR1Oszj+nnmmg?=
 =?us-ascii?Q?Shcd/foga020Oc4eauSyw8kH0BjQ2Ld7x7mlH6viZWmZS91n4j9xwX7US5Az?=
 =?us-ascii?Q?e46UzuxR2weTy7O90dFLynROgW4RtkjXMHrU5wSrsugLuQqkwHGgKkGGn7g0?=
 =?us-ascii?Q?5uet2Oh1silmmJG+BUKd7wWrIeCCwdmcZ2G/ancp3xxJcu7+LwIPRQEpjt1/?=
 =?us-ascii?Q?svkmFxXqyrHA6b16fgHcWjTiweF75Wh5h8KWi9sc6r0IdSd6WaRAEabOBJb0?=
 =?us-ascii?Q?zfP8ygEcOhEMZGjvAbiN98VHK9GXXgkZzOwmqKu/jTc09O+KngTYnreYGE94?=
 =?us-ascii?Q?ZiIt2oAO7KFbOlq8VAit9ywDhPiyEhvzLy3eWZuj8VhTBAgquTjzKSyS89jX?=
 =?us-ascii?Q?Gb6dL7ga9VTd9p8wpMQyTN4yxy1Y+sk9Y/wQMFyeMiHheUl0l1jbt1X6cFQw?=
 =?us-ascii?Q?yae6Jz0l4XNba6bb0/QIe3l/IBsBtT7zD1Fusvmvoy3Is8C2G0CGGY1ywC4c?=
 =?us-ascii?Q?TQ4ctfQbGkLiLItPv/RFHHVe57RL2KjecyniyFYa4TYK+6K5KXOy8YTLdcMc?=
 =?us-ascii?Q?BAIwMLAarBra6yeMApz7xUnA0x5h5Pd7Cxh5wTxgGuhAYx03pzcNzkgj0GFe?=
 =?us-ascii?Q?KFFb+F1h5RaV37Ye1CXleu6gbEwYsWlxIWq97XvhcuVFpjUpX/4ET/X9jA3/?=
 =?us-ascii?Q?4GxNeO7miyGoMffhex19u+9QbHdYXnH3mvtPoYc5fxEP37NDJSC/RNf6am6i?=
 =?us-ascii?Q?lE639mIhknIKKzDrhXpGTz/8TyiCmLTHfBaaYbm4Ztk3JSA+v3LKiro//l2t?=
 =?us-ascii?Q?sgbmli/m/xOey0VFvBItU0vsmx5omeCtAqT7jDjoRDp2IkG5Xg4ojWwhcck1?=
 =?us-ascii?Q?hKGUeHRMY6vPpO7X9CLxqEPJDPVN2y/1wF4AlDLgSaVUSTK/HSkNKQUCJxB0?=
 =?us-ascii?Q?aJRXqRiSbH44/SdPpVBYz1tmFCR4496w5h3Zbfv/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbe06ff-61a3-48db-04ed-08db1fe635e6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 15:03:01.1825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AC5UUchKSCuaA+hx76DaugU6NyvmpnYrcTes+TZb838pCDUTLwawo24wH0kreGnL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7842
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 08, 2023 at 08:32:03PM +0800, Baolu Lu wrote:
> > diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> > index 2ff192777f27d3..22863759c3bfb0 100644
> > --- a/drivers/iommu/iommufd/iommufd_private.h
> > +++ b/drivers/iommu/iommufd/iommufd_private.h
> > @@ -76,10 +76,9 @@ int iopt_table_add_domain(struct io_pagetable *iopt,
> >   			  struct iommu_domain *domain);
> >   void iopt_table_remove_domain(struct io_pagetable *iopt,
> >   			      struct iommu_domain *domain);
> > -int iopt_table_enforce_group_resv_regions(struct io_pagetable *iopt,
> > -					  struct device *device,
> > -					  struct iommu_group *group,
> > -					  phys_addr_t *sw_msi_start);
> > +int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
> > +					struct device *dev,
> > +					phys_addr_t *sw_msi_start);
> >   int iopt_set_allow_iova(struct io_pagetable *iopt,
> >   			struct rb_root_cached *allowed_iova);
> >   int iopt_reserve_iova(struct io_pagetable *iopt, unsigned long start,
> 
> Perhaps a silly question. The reserved regions are enforced in IOVA when
> a device is added to the igroup's device list. Should it be released
> after the device is removed from the list?

Yes, it is, iommufd_hw_pagetable_detach() does it right after the
list_del()

> This may not be appropriate because the devices may share some common
> reserved regions, such as the IOMMU_RESV_MSI.

Common reserved regions are duplicated for every device just as they
were duplicated for every group.

The duplicates are keyed with an owner that is equal to the 'struct
device *' so we only remove the IOVA specific to the struct device.

The interval tree effectively unions the duplicated and overlapping
IOVA regions during lookup.

It is done this way to avoid memory allocation on destruction
paths. We never have to chop up merged IOVA regions or something to
remove a device.

Jason
