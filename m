Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E296285C1
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Nov 2022 17:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237895AbiKNQol (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 11:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237882AbiKNQok (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 11:44:40 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3F828E20;
        Mon, 14 Nov 2022 08:44:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cePhUxr+lSYdfyFXk/QvY8aEaZr8H/iGm5DfQesugcPCF/0ZJUvkMclI/tKkPknqaNvKGyVqGBP/gBvAOAfy3R79HxjwiJV/W3ibnQV8/b0XBxv1myytjWf1LT/PrF1zULcwXMN6n4pfuMQiniSf0L7lDRf3VPP0aUd5FB6T8yJ9O8KC5CGZFwnT+p19LmzKEQgAHb6bLpWqvAwU070BWiYc36OPOOG8GxaOkh3ob08Db814QokFNe81KDjbCjYaBpu3uTzrGr94wBUarGfvRUw0HVHUU5NeaZmYhoEgCQ2PYJ/7rzOjpLIH4RQ+9kAYNcd8RAHYdVjqNVU4tkfDvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjqoA8Ym8m7zyRvRE5gVdk91bgNJ/QfVOn04Ltf1MzY=;
 b=BNGfULWYVKemRB4vNM9I/0UVchey/5BnQtMfNP5RMdmkovvcrX3gfk/+8/BC6zgvdhZCQUz0ydrIC09FYe34We7zTI07TegL68GyJ50PEdmjmVuFOMpKQb+tP/TcMIFkyuhsIbhup4JuixDI1S80Q9qlPOPoJHZdmhUCz4hvRRGmdH22GpdfNvE3iXW/GAWvyrXIUNhuRyfcNFmgbt6E896CQkKYnPTzVNfGW5IQ2JPHUAY5GCdLRxDb0hMnrvguQvsCZ73mxzj303gsujeh11KTon+oI3mlAmpLTWHckOtwOAP5deFcCmc3BiPcwDRpMZHzEWNWxw0ookxbfyjS3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjqoA8Ym8m7zyRvRE5gVdk91bgNJ/QfVOn04Ltf1MzY=;
 b=Cv4oUEvlpnZKKTZR54TPa7LnpG4TMFGmyhWpCEUdAsgL2hkbxHxERSQZDoiP/ucj71dbpgUVfsvtHpFnW8ZoG2q3M3lqBLixYXxHh3Eiv6Ios9oj6iQxLbwkH/IT39stw8D60WyunWWiHC2ijIkYZjjMDxX5SsVZjxk9sAso74KHsB4vc09ohEDCIjyMzeew07CjedqHHKoPTt+9VZBRf4IXSqqpeMTYTE3df8FWHZy4d+F8zQQeoQ7PZMHaIqU9KbuM9VuQdFWmaXXTXZmge5b+Rg3FhcwrraTui6hZ9egOFg6/H178va6Ed7vO335ynMPI4+gF9kC+wOtkesQfkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5061.namprd12.prod.outlook.com (2603:10b6:208:310::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 16:44:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 16:44:37 +0000
Date:   Mon, 14 Nov 2022 12:44:36 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v4 02/17] iommu: Add device-centric DMA ownership
 interfaces
Message-ID: <Y3JwdIr/z2hkZmjf@nvidia.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <2-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <BN9PR11MB5276FBFDC7C96C9EFB87D4FF8C009@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276FBFDC7C96C9EFB87D4FF8C009@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0375.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5061:EE_
X-MS-Office365-Filtering-Correlation-Id: 9835c510-80cc-4822-a4b5-08dac65f846c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 238n85YqoW+8d3DjJ43lcBQzJtw2hFJnkp6D4PhronSnlFh+gFkIshMA11pHioR4CdBWI5fz7GovY/SdbezrPdZAhYzgK225N8tpJXABEOSWcrgrmZUVWrbvxlZvXBqb1gguWDTHADPvR2pPXw6zU/agLOsxO4eiMmd3MXFkVtIHlsSRiORRsPkmZgmqMSB575durdwu8wgfh4YOalmwnDBKkwWmmDFEuoONTvA4HFSO/d1aC1HCjlCgFvfjBIh8CaACdx5MryIIiTo6WzW4HiHVvnCfvJs/26/GyoF2gIPu0mdGEd1pPm/H9brwOHLD2yUO73BKta5jF4kHTcepQmLGIXbCkg+l2nNr5xXrzBrkTzNQKpkQz63TvyTLgqi6zjLoW/i4hm2nhAYOGmdsyAIRAuDmilFZBaUuST5AJ0+9Sv2kZRAgI/RTptpi7JLXOqorCnSXnNlsJSHuQjZ1fhSZ7YiT2lAg/uYURBpL3+v7PfnKsdThz0Sz6xMSTzivOKDne2ukA0N3qyGrN0u5aRPk/bKtAxHHDLwWNS9uEtL1VeBv8okR65ZXbMiHdgSJ7AuU+8Knz1p7jEPr1ktjLWVzvWoVPv0Q4Jx+YYhcvN9LX3cHaOuS9K8evT7iwzIEaRdwnz8s0U2DJ9rs8kLlR55AMfZXYlfmeqFdXkKltFxtCxEZ4duFxpXKfGjEW2Np6KqJ5W6K9LT9nzu+rGXTjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199015)(186003)(6512007)(83380400001)(26005)(2616005)(6506007)(38100700002)(5660300002)(2906002)(7416002)(7406005)(6486002)(478600001)(8676002)(66946007)(8936002)(66556008)(66476007)(4326008)(41300700001)(316002)(6916009)(54906003)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LLBaFnZGOGikadQNLan+1asP/tBCMh3tNZ7fbmBdvX4Z5XRRapomH/TOS8q/?=
 =?us-ascii?Q?410W0oYVLYPdXPyPII2U88Se31IVD6LUMFVF1Z0TQSUMxg4OYpSSZw+nRUPJ?=
 =?us-ascii?Q?1Dvr0DSYbHKt75AKDAOf4xqab1Tg3sdocTxtR4M/r9HW1WffwsaXNIiRFUI7?=
 =?us-ascii?Q?fp0D9wAImZnN2qD+jlIwVGg6TJJYgnD/hAeJIvg/9ClwNOcE51dsZMb+0p/N?=
 =?us-ascii?Q?29jTtCcWWsLAukB1Mm6ZdQOErgiShImonTzm3w2PnkfAuXYRoQXWnt9gtlGd?=
 =?us-ascii?Q?xTgjELlHU+SisWlpHSSGDdXjVlMcDMpDDxuVkZ8G+A5KLsU24J+sYHGMuTiA?=
 =?us-ascii?Q?WYFMSFdxDZgvibYV6OXOHz4Q5hHB+K8emTo7HvZwvbcYWtnqSYCfsOvcLceQ?=
 =?us-ascii?Q?+JW6pit/1ddGWHf6qCD4Su/CP1VFofA2Mq+mvD536GY3/JPHWeRG0f3Vqk1B?=
 =?us-ascii?Q?LwumZJAo2WHuMLKGD1aApo3BjxIe+VI7AW1SWF4au0rLW4EqF5d5joyK0cmK?=
 =?us-ascii?Q?b1TY96VN38mFyybitqixJQcrMUCd+gnDRl4LvTIfH7i8xydMj911tVqjdCjq?=
 =?us-ascii?Q?+xSdIdrWlXOjpfCFg4gPjlUT80hx4/gU9tX3crk0QykVaDbEJmEKIGDtEVC5?=
 =?us-ascii?Q?VQI0EVOkuJyA/r2B7PoQQnON1PzB9WJJSoU8cxtMx+L1by5ztEzd0x/OyT0W?=
 =?us-ascii?Q?rWAP3oh5mDhrf4UYUDcWI+s4wsMgy9ZkR7+C4qEDPtEivpKe6DuSLalUG07q?=
 =?us-ascii?Q?IPKiCFkjkHnhELGXRfoIYqTKcH/Rvu48IySfNGCCiuW2H5vZ9XtmoKBdcclr?=
 =?us-ascii?Q?XEnQXCEZt9OUHW1UOSyU6DGDVfLtwltHtiXvBjeMIUzTb1WwSggCYfsnHBlh?=
 =?us-ascii?Q?etzt9MjCYfk8agsSb4Lm0mbVoQ9xJ0Dwo4u9wUiy34opfrCRsFDUBCacbd6C?=
 =?us-ascii?Q?GZ8EJRqBLzrvzwoU1N9Cnt6bV7rNrB+/d0u7W0YyRtfpxlQLZyit1pGGdoJK?=
 =?us-ascii?Q?oZxdSgCbzNoIgCaPPrCGKgl5F7d4c9iaGBJFbfFufDa8xX3w/baArtiu1KTW?=
 =?us-ascii?Q?EZ45CAzhktX6KmZxSXF1LGyNty2MLSvqnhUv/fPJRii7Hv77r/K+90S7sfzO?=
 =?us-ascii?Q?U9hk0FcqOBS5yrcwTjBfODIm6k5xlkQjGuOOUsmehmBDkN7dNQY4ZY8NA3eC?=
 =?us-ascii?Q?QncRn4fRhEOO2+V9CWo5m5zZ2u9ICr7DwVqTh+Ik/RpY/085pTF7MWsXiKiP?=
 =?us-ascii?Q?wy6tN/YAe+aEcmSv4tzuLRWq1q8GdkxRuURpm9Ly+CPVpNEnj4+OPL7ogF35?=
 =?us-ascii?Q?OcWNmPayKUloukNwgX8KUJ4+naswxxHsq+JJPyDqkfCyMaRayDX2uMvuEFoC?=
 =?us-ascii?Q?JHwT43p3ZQYy9/qLEsFGhZiqjVXpkGWnhGM7B8er+Y+lP3JpwkhtRea2XJT8?=
 =?us-ascii?Q?rjw1cxRS8LrP+A0g9mnZEXP6HBM/Xdu9wBMbd6xg2kiYd6FNiva12cnRNaih?=
 =?us-ascii?Q?Bfl7CVlUenA6sbQ2dEE6En+NLE5dn1irGnNYJt9CPCY4fv81HIHAhHU9JDQt?=
 =?us-ascii?Q?+04P63tEhb7aeTUVgHg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9835c510-80cc-4822-a4b5-08dac65f846c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 16:44:37.5376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95URS/zpuxeWzznme6VRDhF9QpzFeTHz8h1waGljMkc0wdQNhiuHB0ymIOzidd0w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5061
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 11, 2022 at 05:37:36AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, November 8, 2022 8:49 AM
> > +static int __iommu_take_dma_ownership(struct iommu_group *group, void
> > *owner)
> > +{
> > +	int ret;
> > +
> > +	if (WARN_ON(!owner))
> > +		return -EINVAL;
> 
> move to iommu_device_claim_dma_owner(). just like how it's checked
> in the group version.

Ok, like this:

@@ -3112,9 +3112,6 @@ static int __iommu_take_dma_ownership(struct iommu_group *group, void *owner)
 {
 	int ret;
 
-	if (WARN_ON(!owner))
-		return -EINVAL;
-
 	if ((group->domain && group->domain != group->default_domain) ||
 	    !xa_empty(&group->pasid_array))
 		return -EBUSY;
@@ -3177,6 +3174,8 @@ int iommu_device_claim_dma_owner(struct device *dev, void *owner)
 
 	if (!group)
 		return -ENODEV;
+	if (WARN_ON(!owner))
+		return -EINVAL;
 
 	mutex_lock(&group->mutex);
 	if (group->owner_cnt) {

> > +	if ((group->domain && group->domain != group->default_domain) ||
> > +	    !xa_empty(&group->pasid_array))
> > +		return -EBUSY;
> 
> the check of pasid_array is a new addition in this version. it's probably
> worthy a comment here.

It is just the merge resolution with the SVA series, the entire if is
being copied from someplace else

Thanks,
Jason
