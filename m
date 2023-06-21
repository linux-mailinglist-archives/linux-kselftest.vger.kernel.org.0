Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C500E738329
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 14:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjFUMFI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 08:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjFUMEj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 08:04:39 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B811730;
        Wed, 21 Jun 2023 05:04:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2Dkpq254N/UI+tbVi0cOxgJFPb3d7poYQbZ0L1xWUBJmo+5aQos5eOX30RdueIg/dxArKVR7dVd7HW+TeZDHbHmJfVBo8m/VdcrWnfN8aYvYXeSJcu/KH8k1PDxjJmKiLeNwJW0IRchVCEl9VsRs9x7FkrsZa5oliOVCHQHyaq2fUw90hpMiksTWtGs6s1qV49C4K2tOlV+hscznEVwdecUlGj2pBbFP/otBbAUm+IY/apQT072IY17sQiKe2CmrgRRIy6KCREfBCBM1Ns6kWuNGEtlJMexW7jhpeSmW7sXI0aOo18i+mHrKIswOjXX0TZpGQv3THgvIwS6DnlZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FiCAa3RCfuih27zNwHpXb39RnWJlKbNt8C1h91O8PjI=;
 b=cKJ8cOG3VlZiL4gt35RY54ItCpmA4lW8XUM3Oc+kMQKVvAwdquY2qxwp8jpEa8J8HNxWm7L4GOOSQGOEBSuGsx6koBMRGXIMdLI+RN6GX68i2YGo/a9gxdxbvvJ1q5nMmcn9/CH+epoblD+w2VBrOG72nwy7sGNC638VlPdhTGdk4sLZTV8qu2eOqEpg/4fpIP/rrp1AkFkhPcivIOVO1LJy7pd5/SOsNGcKgBTAYXqEX4pZDtLrUKSK7Gmyv4ZTZRqqY6kJNvbH0L70+wCAy67SFnDucTYDWvjbJo1ARXD/rR3G5jAT1jFA4KORQLbOZ7x7ILhHVVh60N6VEZHDXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiCAa3RCfuih27zNwHpXb39RnWJlKbNt8C1h91O8PjI=;
 b=qwjp07qq9r5hQUojhz1uaPwxLmclxpJLXx4VPKVxDXyAcXwGl6gT+gmxW2KdGIZBiiM55Hub21GiD8JWSdVJVXA1/CuxHBwC+tix/OgT/mx0DIp5cQkF5q2q5p0gxBBcUBJTgCFlzCYgJ2OPukorv7Nucds9tt7fCMxZKs0ELihTOGQhAphIrmLlhunIjOS7OdBwJGS1JrW9bdcBjW1ddockm7RGOIFPa7UNNyqwednD08S73hNAB2XPybuAKoNXg3OzjmE8CgbetOlTnzJVM2Ma7S91+CIyQdzaOxQ1cvE7iJ9f+KIEBdDDSMf5U/LwcHvLKK33V6O6i6iXUW08eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 12:04:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6500.031; Wed, 21 Jun 2023
 12:04:33 +0000
Date:   Wed, 21 Jun 2023 09:04:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v2 00/11] iommufd: Add nesting infrastructure
Message-ID: <ZJLnTt/lCyTYBm7G@nvidia.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <BN9PR11MB5276DAF0A11809CF8433EE338C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZGdiS2m8jcd5OOt5@nvidia.com>
 <BN9PR11MB5276A74B2DA86C79908A420B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZH9AGWf1yRDu/86q@nvidia.com>
 <BN9PR11MB52763C7B838B04D3200322FD8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJBL8QLLBiwRsUSI@nvidia.com>
 <BN9PR11MB527663567ECB8AD52D3170818C5CA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZJGf3sgLKr9HLZuE@nvidia.com>
 <BN9PR11MB5276B852A32F53BE8EAA1A7D8C5DA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276B852A32F53BE8EAA1A7D8C5DA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR03CA0374.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: 341c4359-4173-4b92-9bd3-08db724facca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eVVIVGt3aJMMpBzc7BNVEW+TA6APm7oDS1rsClhosNyWBR9AUPLnGKpUpBkYO8w8vlNN2obA8jpAG1vvGQGPW8lecLuFZjin5qMyglmJM3Q31PXgYNLF9AYuStbwwhybL5wAwBrQ3COEIJ+hCY93ngWrcboVAa7kLUfUhtr5MBTcm3WnMeZBcFZHMR/iqff4kUDx7sk0OavztGryTCjEsfN7S9WpRvqMhmZ/oh2sgPIPPsBv+Fbe5RngXBlJSR2nCnnQ1INdpf8qfbU4vp3YOp83vAdGKusZohnoVUNi6kPtiZ6LRoMbecwzQXT/0zIHk9pcERxs73LEtcGOgMNIvlQGy8UNdUI+SC5UG4MgTUcQ4e2plHLlfw8iR4Y9mGnEDcMR53ftxmZz/2LquKhrrmiUUuP27wNw5JZpW5V8uD0yjwddOZO0MJyy+Z37FbkBW/hv2FijMbsa32oaKuNDN6ok6+S2ovS2WKxtKdhMvTPBu4V7gKjHTmKJUNZzyyP9EnzuehaXVUY+bYGRhzcbRcO1kO2qSDN5jJ/dQRDRGcUaFa3TP7dQk248LtBIx9QM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199021)(38100700002)(6506007)(6512007)(26005)(186003)(2616005)(6486002)(7416002)(5660300002)(8936002)(8676002)(41300700001)(2906002)(36756003)(478600001)(66556008)(66476007)(6916009)(66946007)(54906003)(316002)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?83r2FdpPXtiFFEECkMmoU3ZCUhcbjGRx2wJUlnKeVT6tBamjXQPnz/kN3XBt?=
 =?us-ascii?Q?TgJo8pdH1ksZ+SHrM6SsH6Fwo8WDUYgR9ToAYgYaBJVJ/JCHyRib7UALaMzt?=
 =?us-ascii?Q?rssJG5wBbgv6rofZoKkai1ziqN/DHWR3tA/2aus0pVzuxSnNQd4aYqNkxCse?=
 =?us-ascii?Q?8hcOUMm34uwV6qz9gEozOS9L/dsV+oNDKDUHxMs/D1AXs3viExz/jU92dv5F?=
 =?us-ascii?Q?U4G1o+XzQShHelJayeXdRMU3hyufglvpTwhyjugJgmhSoK/dZrtxjoX/HDh6?=
 =?us-ascii?Q?fNKZkyYaeJEyHDVDyEiW+t04vloRHyFXv/owCBD07oWmdDnK4P3oHpL7N8VD?=
 =?us-ascii?Q?MuP36BSO/a3vM9SiOXr4CfCNZ/0j0qvRY0zcWgHJFjO7bEBYMBJbgDtMnG+A?=
 =?us-ascii?Q?XlqW4wWMHfmbhfsWOBPmdimnOZ90ARaJ6muo979T2+7wpnG3xOjWmOpFhjWj?=
 =?us-ascii?Q?0R8JCXAd2vzIvJ9PNn00e6ETaCzRUB/GtwuhvzLMzLePbXntYNFC9eFjctQq?=
 =?us-ascii?Q?Ye6rk6P4SUT5zh1rDElUhGIiQiaSDJR43hvBj6UfcDjvxouKMvuNZQGESUpS?=
 =?us-ascii?Q?tBzVFuWTxW7Zuz0RfPgjJ+Ky2ydX14K8Rf7+Af9W2kC8ycOvmskXuRZqq2Oa?=
 =?us-ascii?Q?r0GnHEHo4VPZKiPdcCNY/Jcid9v+v8bbZ4dXEdYp6w5qe27SgFw+htFt1N4q?=
 =?us-ascii?Q?MmQAhh6CTq3Z6QQjivMqI1GgetbVnLCtFWW8oJUgGSIq0DyRHkgekjCuEX2A?=
 =?us-ascii?Q?Tu9Y+3DzeZTErJlpKyxX4ifs6f4kg1He1EO+hElcibDGYcXIla51ClCpkgja?=
 =?us-ascii?Q?s547BoO+kK3mV5Tsw9LtbwNWi5BO7fdC4rGfkjHcod5t4Ceq1VKfNU2K6qYZ?=
 =?us-ascii?Q?vEpD7nnacxYYSidwQcZSMG1XjilY2hgn7XmodEDL+FU3q0i6GKS31y2Ojod3?=
 =?us-ascii?Q?8n6dtzHU9fJ4nM07S/kckTA9J9zQRJdNNk2x3+O2CcHyfT2sA2p6ji2Ug+t3?=
 =?us-ascii?Q?i/ERcVvs9j7WFIMOkoiw3MUGwOPtVW0D8P19uBxW8maYrxV2V/eJLPnVo6Cc?=
 =?us-ascii?Q?la3HTGXooVfRVw0RNWyil1yehoq6fWRYtt+8VkLCQTgT6CWOF8TguOG6F6q+?=
 =?us-ascii?Q?rTELTi6cmQE55NxkpawHMwxyVj1VQzRMpTohzjo6XrcZpLUzcnaqtd0+d+65?=
 =?us-ascii?Q?xUd2B6V+jL2CyjURlrxu+G/yLiA6dJLUP4VzXfe2H12Hmd6COWHB7vLkt0GB?=
 =?us-ascii?Q?+bbaAaJZQqDShlNJVod1xX1E+albxXEAcmGUhacLcEGPZShR2sZh6ELhVnfb?=
 =?us-ascii?Q?/vu4ztPWdC6ZAzkzaAuqHPPSLfYT1O2eOFqXI3vWVuHFCoSExRZkFWaarnRZ?=
 =?us-ascii?Q?iuPEZpaReOR23HA1tRiYlf/SNuiCGDoHUAc4R1Y8apim2jMDmQ9VeBzxHyYW?=
 =?us-ascii?Q?W1BLvjrLDuTgxfZbgmLNCSvNM7S+ry9/go+hfyn5KnX9UmsJoJ2GSarUsrjv?=
 =?us-ascii?Q?Jl5X4vWVqpANcjRnw+x4DUhUZyfv/JznGXKu+ir0pvT49AqJEg+nhX7prLW4?=
 =?us-ascii?Q?ZUV6oOoDk7RBC4nS5um0aigayimjEzAiuEPYDbaU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341c4359-4173-4b92-9bd3-08db724facca
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 12:04:33.1944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6GBAZ+ctKD8q2ZhLhTnl/IECE8VBDfWHIZfIRezL4h47RaOz0apjUM0I2jRkVLQn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7171
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 21, 2023 at 06:02:21AM +0000, Tian, Kevin wrote:
> > > My understanding of ARM SMMU is that from host p.o.v. the CD is the
> > > S1 in the nested configuration. 'identity' is one configuration in the CD
> > > then it's in the business of nesting.
> > 
> > I think it is the same. A CD doesn't come into the picture until the
> > guest installs a CD pointing STE. Until that time the S2 is being used
> > as identity.
> > 
> > It sounds like the same basic flow.
> 
> After a CD table is installed in a STE I assume the SMMU still allows to
> configure an individual CD entry as identity? e.g. while vSVA is enabled
> on a device the guest can continue to keep CD#0 as identity when the
> default domain of the device is set as 'passthrough'. In this case the
> IOAS still needs to gain reserved regions even though S2 is not directly
> attached from host p.o.v.

In any nesting configuration the hypervisor cannot directly restrict
what IOVA the guest will use. The VM could make a normal nest and try
to use unusable IOVA. Identity is not really special.

The VMM should construct the guest memory map so that an identity
iommu_domain can meet the reserved requirements - it needs to do this
anyhow for the initial boot part. It shouuld try to forward the
reserved regions to the guest via ACPI/etc.

Being able to explicitly load reserved regions into an IOAS seems like
a useful way to help construct this.

Jason
