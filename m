Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607BC7A82D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 15:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbjITNGl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 09:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbjITNGQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 09:06:16 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D4812C;
        Wed, 20 Sep 2023 06:06:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5IGsPCGHUpMkGLoKLzDuxxhqIYClxibxbfsgwljHwGoS4Sp3BQWBikohze4By6YaQeM9xGznBEQmpVBOTKQVciYzAAw7PVILnVID1oePAczlo1dYpsO7opv8cvbSp1xGHQ+BigLEwKb9uAt8tpNU7HSTKKdQC2jOo8daST+GWX7jPKy95BgEF8M0EZirGnq73bVC1pAobUCi5ZrzL5paKByETfQChwk9kCGabszL/vbCS5jxi2rnNMWre+hrfbuyJDKxexowRAM+jv1TCy/eoCMK6qjA/oBMzi+y3n4cKsaWfvPuRcGhRfBJcTEN4jwhh/JDRYyF2gQGYF8TZKVfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fe4+S66gf29+FXm2gzbSuqN876eR0BbQWbEoIA2/ilE=;
 b=YKtJfYfHibRZRJzW7k1WYXXvJfkLNqSNbrgKyqQFdyDbu1iY4YSEN5a9rx1mWjd6yV2K5D7r0waCSkHKArCYjGvDaEPuXPE19CrFfiDUXcY2jWH0yd664DcjvQeUEKt8yhvak5dhneFnGv9HIMS8DxvU52GIPi+M0p3VaKBXgOh/kj9JVTz13M5/yINU6ZNnwbJqtTdTjs9NidPZXnjWVBWxxq/k8/q0Qhe4LS3YtYvR+CcRaa3bB0TGFhfdhJfSvLeWRY3ThgvbFG+kAFUGTaoKLUNU5qbarzFaoE897+9uAXb5OVhv2sjzrJUr6TD5WCGenjKvgABCFseEknWTzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fe4+S66gf29+FXm2gzbSuqN876eR0BbQWbEoIA2/ilE=;
 b=eO9XGf9yvI9MqzhMnhij1HRU1meBlUPeZB5sW59tKXnMm8bzG+WK1eIYF7D4Pbr7aJbwbh1r/EFE4ilw5Pa+xJ0aTszMXUYRp+NRDTKfPcFzPENq+jnhzZ3IJiqlfu5kAWgeDTxF9vgj7RpZx2Um0BjRe5lGNVIQeiu+wlOD5IoVvaXjTSUP3sQIH5AeXZghjy1eR8Zo8Yb0PCcSpPJQDhkKeE7yCL+x9aJqUzOhFBro1PIRmnVqOpZwjoLp8MgZINw+jv3HDd9kiXBeZNQPuCtQXT4KFAEmxMuoZsCB7Inu1Fv8hov6YIw94aLXcxvQlt3SlCQJRWHKOuUIMC1A7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL0PR12MB5010.namprd12.prod.outlook.com (2603:10b6:208:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 13:06:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 13:06:08 +0000
Date:   Wed, 20 Sep 2023 10:06:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Yang, Weijiang" <weijiang.yang@intel.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: Re: [PATCH 6/6] iommu/vt-d: Add domain_alloc_user op
Message-ID: <20230920130606.GW13733@nvidia.com>
References: <20230919092523.39286-1-yi.l.liu@intel.com>
 <20230919092523.39286-7-yi.l.liu@intel.com>
 <74533792-7dcd-d745-dc07-671260bc9e22@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74533792-7dcd-d745-dc07-671260bc9e22@intel.com>
X-ClientProxiedBy: SJ0PR03CA0291.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL0PR12MB5010:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3eb000-d0b3-4bcd-9792-08dbb9da5b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MIp904ELSQl5zQTQr+dwa6YRTnAOcw6KHzTGOJm/WN3oLgYad+KFgaBuoRce1/RywskaPd7iw3Zs7pv41WcGtR0Qi42RNPo5Teci7VQJ1xgKT7VqFFABsCKjWIpR7NPlEk8SQVh/2vFcXvmBC4XxD/MQv13xtZIMiQ71H3VkRITyh7bQAIgZMRM6kIxiVg4J5evH0XjAKL7aygP6JLLjttfduyFj4ibP8QyWkdZ4W/J68uEE0p7QNQMNcCRkMzxLPdEBwW+HDOAu17iYBgGxvaDex2VRHxkmFnEANxrNX8msmINcay1A50WJEHT69o3m5Vg8jzZ+PrTq+jnMW2RZXyFR/MLygH2wCV/QZcd5L7yAqU5pQ8FPhubT10fvJeRdK6ha8Wia6dNL4xWNBzfX6rxTQ37bW7IH8NqPTOueIHc9YLMKud/rp8SxRjT3fiAHVbWMWkju3abL5jzR4DSdZ2HjT+yvI0MAw+tutfabDAg/kS74h0ZMBhF9Ezh1UnUE/OB++P86R3id0EXS984f7j+jSvE06GlEYyLRcc6qVMIV2zSgcjUdUwNWx9bOQM0W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199024)(186009)(1800799009)(53546011)(6512007)(6486002)(6506007)(86362001)(36756003)(38100700002)(33656002)(26005)(7416002)(2906002)(2616005)(1076003)(478600001)(83380400001)(5660300002)(8676002)(8936002)(4326008)(316002)(6916009)(66476007)(66556008)(41300700001)(66946007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D4rkl82Hu1n0TJ8QKH3YHotC3irnBUhDTcZIgpcdkSPhD0vfToA0tjyRyvIt?=
 =?us-ascii?Q?421qU+MsafAfGLR17uxzp7ciUWYwDglfljC5eWuvKNVoh/MHHSBLeMrrweK+?=
 =?us-ascii?Q?iq2kvkB7ER66PLWgEZiWb3AsY/ivZ9mg+Ro7CSAV0hU4t6NIOrzo07ey3m8A?=
 =?us-ascii?Q?OccjhzkvUoBJJq30BXPV9jkrEhFoBGcEd+806sqknVT88JtsiB5Iffh/j7TC?=
 =?us-ascii?Q?wugbJdeCtvVDynqe51Bmjnir4GcF8EikgIqEaDcDWLfh0LqOgHd2IxzUCiOu?=
 =?us-ascii?Q?GoFsHnywO5KeGBSaFqtsGkkw093KGuueaRPvX0J30MdpbxOubF/KtMaEHwHM?=
 =?us-ascii?Q?stvw9Io4VWJLnL8T3TIp5ub6Q7914oneh4L1zrb4J2MrE2Sk2lLk1Z+bWX/O?=
 =?us-ascii?Q?kzgofsZodySoem69aVSdz4AKA5eZcTL3Kr+dFSb+ENR/3FTWQ1ZtlTXnRVU+?=
 =?us-ascii?Q?1sVBw3uSvE1wSOjtLNJiYt9cdYL4RG5Ukbzl5Mr10f0EjrO7m5VyzNsNJYoy?=
 =?us-ascii?Q?veZvArUohrBiu1RRCbEnUNoEFVoM4IXiuzkCLesAbiWUTYykAsRAKhFRlZzF?=
 =?us-ascii?Q?pEhvYx5nteofua56kf3ISH6IYagVVXajD9MC793BbTHwtAJS+A0EBRHPmqwF?=
 =?us-ascii?Q?PcAviW1eS3oOQQrp/APP521ngDqHRj9IUHTNdwfHEvqCDSdr3b60GNctFIZ2?=
 =?us-ascii?Q?e5Znnyp1b64/wUSQ6f1DFK+70jObiC/1Ir5GSWCHv8fQYBfBncMpg+4rkAVO?=
 =?us-ascii?Q?N3bPzW/DTq4QF4Xe5424DDgvqBhf4rXlVSGXPeYGsP+e63LXnqX0KFlexvDC?=
 =?us-ascii?Q?Cuq9/WZk/FkGx2uzThgbfYUHCD4CeaqZw42jjhtZZ4aNpTCm4VSQQad/VslL?=
 =?us-ascii?Q?fO0NI+Vugzaq59aQnkHy/gkfP+bc9yeNViHIWGhku9WXdcvPcerVhQ58Uk4c?=
 =?us-ascii?Q?0bQvVP9yANkHlq8vE86u78BWfgmM80DLYUdv3JkhX9ScboRGqJmv6XlC+QGC?=
 =?us-ascii?Q?0WYceC2utQT+bYUIWjb36EwOCZt2wWk+5wC0lBY85yGR2FnJiSIrNFBBzonQ?=
 =?us-ascii?Q?KV0kg3T6jGEYBL570B/Pp7ZD00ZpEcSnb+M4P3khvu5Gwrhr93qqe1I+o6+U?=
 =?us-ascii?Q?sYKlbRqP8elcWly0OameeEwCuCZH570SF0guy9Ashh/3UAr1tH589mvFG0y/?=
 =?us-ascii?Q?eXUyuAFDAkYlk1CuqT600MdyJMAZtBK6Ko25hzxe2h8c/Plg4/hOvDCIsilS?=
 =?us-ascii?Q?mqcMFRy7LAb7W7/Hh8sJ9Rd2GkbVKGV0+ZoH/7bQflp4ISiTERR2Nfe5fN0F?=
 =?us-ascii?Q?zVbiKpXpeOXvEvvoq2UUKKNyLIjZVQMbS+JXqo86fpUExgscF/fQPuYulQMl?=
 =?us-ascii?Q?8spiKAtcSy0WNNOMCUYHD09z+SThoKiScjQksgNeFRzwmKEQeaMRDr7StsrE?=
 =?us-ascii?Q?Jol6GFv6l4iKXoQ145SgqGwpGGmdefbeKNsm6pKbCUMHdsZe8cT+grMC7hW9?=
 =?us-ascii?Q?qtL4kUM321x6Cw7VYVdpMuuUSA2iyLFb2DnxPOXR80Wbl5Pu7qgSLwqlPZA1?=
 =?us-ascii?Q?pkWUkNhN2pQYElTkKR/ZZptBJ4wZeW1Mip2FIE9B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3eb000-d0b3-4bcd-9792-08dbb9da5b30
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 13:06:08.8287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Et7aFklTYQwedAYLKouOwjZdI+u0WdWGgl8WmlMDqMEKY6P8aRnjxRJ7NxwVb/5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5010
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 20, 2023 at 01:41:07PM +0800, Yang, Weijiang wrote:
> On 9/19/2023 5:25 PM, Yi Liu wrote:
> > This adds the domain_alloc_user op implementation. It supports allocating
> > domains to be used as parent under nested translation.
> > 
> > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > ---
> >   drivers/iommu/intel/iommu.c | 20 ++++++++++++++++++++
> >   1 file changed, 20 insertions(+)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 5db283c17e0d..491bcde1ff96 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -4074,6 +4074,25 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
> >   	return NULL;
> >   }
> > +static struct iommu_domain *
> > +intel_iommu_domain_alloc_user(struct device *dev, u32 flags)
> > +{
> > +	struct iommu_domain *domain;
> > +	struct intel_iommu *iommu;
> > +
> > +	iommu = device_to_iommu(dev, NULL, NULL);
> > +	if (!iommu)
> > +		return ERR_PTR(-ENODEV);
> > +
> > +	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !ecap_nest(iommu->ecap))
> > +		return ERR_PTR(-EOPNOTSUPP);
> 
> The outer caller has checked (flags & IOMMU_HWPT_ALLOC_NEST_PARENT) before it comes here.
> If this callback is dedicated for nested domain allocation, then you may omit the condition here.

No, please don't.

The point of the flags is to be passed to the driver. The driver
should validate them, not the core code.

We will add more flags, I don't want to change every driver to do
this.

Jason
