Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993607A82B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 15:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbjITNFh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 09:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbjITNFe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 09:05:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0314012B;
        Wed, 20 Sep 2023 06:05:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDLvr4wQMQ6cd7gb46DDdgwcY5b6Gm1QUond0ssJ3qwSOKhSLTIqi4xauRrBGAuv8XEKjbMi/f0fnsQNzeZW2FSwz2qvgJE9MJcxuroMC+xv42gmDMwbsAYLt8/9OZslWFNxfhwSp1BjxhyQsEj+JlUH34aC3tSZQCiZksMmU7NhDn18vB1/mAVCc8avTDVt8hx6fJw/XiO2yVUZPvnkCduvFAK2aVVtKNsiS1FyOAi6Wlu3Ru/C80Q3+cW0pZ/sT+N9gkL2cEZt7kwUhJHrF61sRSABEOgvyvFw+74hf3PJlSbTMU+Zp+NuHrqAeTDID0m6CX1D2OyZuF8X8WwwhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiuyUQXisBixtUZI5CFsFLcV85vxBRGBlK0+hOlAfrw=;
 b=jxU+Tb7Mlph+8SNoebI/geP2zSvhPGKxyZ8eYQA/p+YpAxg81iHrrtYl4kmt8te+g2oz2ARk63AbV7vhKYne+7PR5mtetb67o/4kqfpoNC41Gnu2tjTVvBEJN3o3liTQM6eOxVvqnk6VgL6oK/UB4bGb+N34G0c1mMdeDQFmjqXDGQ7HCciPhdd5c+FcJpCPJymA1g0isJMPGlOGwWw9QHUAoO9s8CoAFt2wD0pE1wuorfvBWrciFetGZFxtSLEVzAJ045hw/Vd9r2NN8nasHzKBO7Xf32YFDOORG7DXieop3POK7FeV0u3F5WSw/jNBfQU9lvm0xLyMUrwWNj3wiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiuyUQXisBixtUZI5CFsFLcV85vxBRGBlK0+hOlAfrw=;
 b=ag96WpgVBr5EUDyilqaTxpgJEuq3gvJMSM+C5f68ANNSsrY4b27YuECziFh5ZMJdxNVo/yNeJNtI5uKfan1C0ojapjvEdPsAAFd7IA3miR8tq3RNfkjKO8JUqcegmMQtZYZLJZYcfqolyuDg3nQ5SvGD+aEdjZghoEUCsDEj192bBB1AijZaYdjuEEsePRUUBDEOhREask7IOAMEOTTnKvZuAkgKbddg0lZ+xkiZPRtCwgom2w9HPjXsgPrRXURf4sG0hktnFOTSwwnHHhIc+Ciy2g8hIemWFMVl1tuEw9Q5RqQMJD66/gIq1tNAyriOIzrdWX6tnNqAbwa8gBttlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL0PR12MB5010.namprd12.prod.outlook.com (2603:10b6:208:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 13:05:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 13:05:25 +0000
Date:   Wed, 20 Sep 2023 10:05:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH 6/6] iommu/vt-d: Add domain_alloc_user op
Message-ID: <20230920130522.GV13733@nvidia.com>
References: <20230919092523.39286-1-yi.l.liu@intel.com>
 <20230919092523.39286-7-yi.l.liu@intel.com>
 <7aa8fd9e-e43d-db68-bdb6-fe4f891255ca@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aa8fd9e-e43d-db68-bdb6-fe4f891255ca@linux.intel.com>
X-ClientProxiedBy: BYAPR01CA0052.prod.exchangelabs.com (2603:10b6:a03:94::29)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL0PR12MB5010:EE_
X-MS-Office365-Filtering-Correlation-Id: f2cbe356-28ba-4b95-906d-08dbb9da4190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JOawAap5iuUeR1y1n5opSk5BeOiP4gq/D11Ru/Dc5XvX2G/nRWkh1uC/WHK5LerC0c1iwNuGzSU3ZuiUYxXWYbiz6OFL2WZJWTCGmWla6nNWnbi8mFgDQeaABzgnE5I1vBIDMf2EJkiWws9AiVW9QDY3i5m+p5MXee/t4u7NF9u2j2BrfyDvIlewKBdAOssAGAxXpipiNcCLlczv5N2QdZoDJ0zhO94PR4edP0tWh3k4Z+WfX+u7s5jj4mA4DKGsUXliqe8/7KKFSqrOuscTJc4s01FwGiUrRAozvUQZ4DME2BFaxytFuOUIVhtLmImiGff46N/oILsgl9hTj8NVmzqaXKhDX+FMXxDMZd5v1/JHCcSQ8tcumRekewY71TrMbdTLTCH6LbAaIfEnATzqTK2NMk3OQHR30lHb7U+azEjpOb8sbRTCaatHHB9goW9O8Oj4p5+FqN2zecwNz23Fpv4qAf7Xtj8KNnFfL0MYpl/CH7bSWO2yas1LRbWcGQ1CHJslJQ/Z6nJk4475TcL1ZZr/vZkuF9TCFERROU+s9YzLjUjv1Ng5DEefSCla33j+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199024)(186009)(1800799009)(6666004)(6512007)(6486002)(6506007)(86362001)(36756003)(38100700002)(33656002)(26005)(7416002)(2906002)(2616005)(1076003)(478600001)(5660300002)(8676002)(8936002)(4326008)(316002)(6916009)(66476007)(66556008)(41300700001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/GugV+2TVI4elzcSoxGjlIEaWpKsVntHIqHDXroFuIEQAWyLnIDjF9scoVNB?=
 =?us-ascii?Q?AwFS5nQHbjflObJFbrGOFexH8OU8fm6iF1t7nmXYI88PNedBN/89x9xMSAv2?=
 =?us-ascii?Q?w4Lc9XTRMi4Nhad0tTVoe+J3uybUeUxcc8sf7a7j+m4uM9lMZfkogURXF8Ns?=
 =?us-ascii?Q?z6Yd4V5GiGfv6jVnsj5xKu2UJpQCxGffh1wXLKhuwM6uYyL0kE82g7N2RuK0?=
 =?us-ascii?Q?J+lngLH12lDkNCE0dPghPqmR/YB01pZgAV6W1bPWCF7tdR7X/VgaPV3eeZiv?=
 =?us-ascii?Q?0QMTbusxxIaFUkKVdB7pNEJwgvSuj0GYeACIN9iyQGw97Rg5el0x1dR4ej8n?=
 =?us-ascii?Q?6WRAjXwqL8VQtjjOielI5UQJM9beMKNO3SIXqmGU0T/HANz0O3Jgr9FnWyb+?=
 =?us-ascii?Q?1pIy4OcRhmVQIb38gJnCXZ0M0LiHtbCHV429u/W8dWx0FJipvAFntIJqc1Tx?=
 =?us-ascii?Q?pYTcbXY7Th+b0Fyel5LBzJSISNFim8o6oNa9IRMm4ppvBRfYfN3HY564vSev?=
 =?us-ascii?Q?EerT3xZWNJ1N1fEEklzzXC1Y6qqINrSi99BJrMat1W1RvHf1hWHUGTqozmdu?=
 =?us-ascii?Q?FKTZQbcGN46qpwcE/sTT4+VYsUtejD/h22t5okHS2my7x0rpWaEdRkmJg0D3?=
 =?us-ascii?Q?hoPfy+F996vktTm5wYTbSMJoBfranczq/rWhDLk56r25N/nwuSVArq+s23HV?=
 =?us-ascii?Q?QkTQG7hW+yspP2peTdPNg7JOU0XKHTxbyTfVLjS8XKYMyDA7k8pUGzFTkHqs?=
 =?us-ascii?Q?aHJYsGF8nMkff0I8R6604SgGscM/A1rJfvdd5LQ9nWz3E9mG0fF0fThdib9E?=
 =?us-ascii?Q?Z1W/X+596hH2TjiqcYCWI8tcYhxW75anIJ0pWSvS8ZSpaTwHpPT9Dw3a5i5y?=
 =?us-ascii?Q?FG7nwOXOjzf2ktZS5YZl+OiizQJTPsXBsCQY09LRXiRbYSJzefle9m76LoVC?=
 =?us-ascii?Q?qoq3jvI6F5kN+3i+pJdYPgGXqWhmg9uEP0ceqPKwJHaRWQzB95fSi+x9PsfL?=
 =?us-ascii?Q?LWqQ3Aj9zgJ/jcn1/eAwGD95bA60sLjOt1yE5rKyJTTb8KCLgvn/8I99stor?=
 =?us-ascii?Q?Bvo+tooNFchlnnTUzAaISY5HvB6NZhYWK+aWOi6Y1BZfij8f/Bb0e1Op4khl?=
 =?us-ascii?Q?o30y33wuSAGXsisvCl4xT6r0cKHwA1LJFosIKOKR8wwM44d7f7dAxiF39Bip?=
 =?us-ascii?Q?jSmXTchmxTEwCIVDhPKwMA8YBLwfOkZxZ4p+Hg2Pgga8sTJycuV/Gmz88FCH?=
 =?us-ascii?Q?IZI7ZKvKjy65yX9O5WiNEG8my0RE8VTqZSfb1pb4lr7gh+i5KHmavNFfzDmX?=
 =?us-ascii?Q?/dnMw/i5B6baVIgND2buIUOanTMbuyoQA5C1vC+gLLqBcnHwYwQ7Dh6/Xzyq?=
 =?us-ascii?Q?F6mWpIK2V7C4wpzZNk/marJdsw8tJeYyCMrnpMQFovSGzXuCkk81RN5vdL7A?=
 =?us-ascii?Q?wdni8IRFOCzMm0LADepCkkwD44baag0joUzBoz3rtaLLyiw3ejfy5+yP6CbZ?=
 =?us-ascii?Q?XW1oz7rD/e9/x2bIhcGb5Ftn5TIogFDugU0iuzixMK1pUTv1OfefZieGJMFO?=
 =?us-ascii?Q?fV01ci7bsOeKSr5QU0PcTQs6tL6PJuSFzrsPkHVC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cbe356-28ba-4b95-906d-08dbb9da4190
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 13:05:25.8596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +dIQsx3/7XDtIdKb4+EEBIlS8QioLhakcE8HpdkasDIAU4WxNY0mQeaN/r4Cf8dn
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

On Wed, Sep 20, 2023 at 01:28:41PM +0800, Baolu Lu wrote:
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

There is a check missing for supported flags

 if (flags & (~IOMMU_HWPT_ALLOC_NEST_PARENT))
	return ERR_PTR(-EOPNOTSUPP);

> > +
> > +	domain = iommu_domain_alloc(dev->bus);
> 
> No need to bounce between core and driver. Just,
> 
> 	intel_iommu_domain_alloc(IOMMU_DOMAIN_UNMANAGED);
> 
> and fully initialize it before return.

If you are going to do that then intel_iommu_domain_alloc() should
fully initialize the domain, not here.

Jason
