Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C9D6CBDF2
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 13:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjC1Lil (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 07:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjC1Lik (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 07:38:40 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596AB40EA;
        Tue, 28 Mar 2023 04:38:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEt+U+DTOtOWkhDOEATOJ3y6pN26RCMU9PZTTnQya0Cu1c0hEUmMoqF3hDfRfawOgNk4jqFjfs/vJS3S+5GqTEOxCUK10I5bIjXDBmtsavSkZPKZnuCZXCqB+BJCVwENTvh1mdtjEOILct27uNEp+Sd+E8NB/se1IIP8E5ViLNgMWcMZ6mj7PaenlkFKeJr0jnc5Vd2os1MHP5mGXvlz0ck6i7Hq6EDTea6DJMjjvN9JcXHO+k9adqPn3JgjAcAiQYHjLuADUCTX1NyE96R1aG9DRjg8fM2L9GN5OCWh+tGrag+rhHgmwARqCmxNeYVkQLMzVgTZPoLogVEiVFwtTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8q4ieXqh5HRdC2PlygbNilLrLYubZOI/bFrow4V1TUY=;
 b=Y9PhQkzne4noRG0HH2SEtK5wPuoYG1xsfennSfZSB9rRebR1G1iilJf9cpPQLoE3L0yQdO+Y2Qjobukf8d/RdBeBWja7Dosv++WkotT4zlT3RudgwEWou3/DVguPnSjq0qgmvdoH4xeEoOmcJB7JF1jklQC09UdVk3CizRsn42LljelngyQbFRaD7yRslU3S9e/OCVwukWSIgmvpEnsZkuO3goF9b4nTs+BZEEpc57SFszJFPcl4/RzSIGQRWGOMshjPLJ+7ZU8u9K4FAdguT1YvnlKq/4dsrgbi3LHje7bkgtqrc53KBTdc7bI06VHSTG/iyHyjX1nsAW/CG2xtFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8q4ieXqh5HRdC2PlygbNilLrLYubZOI/bFrow4V1TUY=;
 b=FxWhMFvba6kZ98I/fnsfgFe6lpof9ZJoJmZgsb/Onz1FTYKy76Hu2f5HL1yBKJXPt3LFKfShEjlMcP/pBZ+eVGECuFuzaEUIgP5OLeICuYIG+pgItmBnFcDu/z+CVnHpmU0OgKg8zaPwoUnozNuLYX541/0OLjAulLJz2te0HlsuEMGaxDQad0QLnZ3S+ArG9/k7ovO3GN/oqGaATe+6V37sOZ6kUufbgRxdwJQGmwTLBOQ1AYPtVJ3SI4J+QN2L8KsIYj6dNq5vAdofEAnsCYSorH7WIv+8xgRXmzexxYmbg72P2nLcRugibiqKcA3u0AkVjTBcMpq4/QZsBbFgjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 11:38:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 28 Mar 2023
 11:38:37 +0000
Date:   Tue, 28 Mar 2023 08:38:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v3 03/17] iommufd: Replace the hwpt->devices list with
 iommufd_group
Message-ID: <ZCLRu2NiVWNcdMk9@nvidia.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <3-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB5276E42B629C3E5AF019B6748C879@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBxg9cRIpsozB15G@nvidia.com>
 <BN9PR11MB52767DA03C240F040929A2398C849@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZB27ke/vQxsCngtC@nvidia.com>
 <BN9PR11MB52768F348A2814083BC5F5328C889@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52768F348A2814083BC5F5328C889@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: MN2PR02CA0035.namprd02.prod.outlook.com
 (2603:10b6:208:fc::48) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5144:EE_
X-MS-Office365-Filtering-Correlation-Id: fd84878c-0989-4716-2182-08db2f80f838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ikM7BIpv3wI6xjCPWS5haB+Zr94fMdjlfBobcqmEccL0cpuhCX4HhUqrTyI0+1xJnjubMFnkZofyOQivAWFRSs6cp0d5kXAsZKFbPFBxIj/uAz+DvsazHfCQG3XA+jMND+/tQD44sqg7z3NBdh5B85baBKe6dYMBucEOB+aLes9nvicNY2wAIS8IdEc+6DEvwujOq2hfflc9TBSTBZ7s7OmR+u9thJi81qsttBGCLAnG1DjlxxD1b0+nL5bAuw2FuGNmfutX4pcJpeoW/ZerRfBbNiYQsyyxoEmi5KB2w1hIGkhJc9msm/6S3n6nfgFYva9dW9NqVb/Gogu2W/gNpWbGh5uLEm67lUOOuC9EOBYyaoMWst5z2cV6v2DIzUDVGW0r/xC/JHM5YlfWJn1NrDLEpxvaARdEl9aR3L1Xcjt+zGSKN8QBNYsJTV1PYKv5VgSrLwIG1yBghMpXCjwDdeFuqpNmv0mlqi9exxEHr5lgGOgHCuvWdKx7wbtr87c1ZoxUQtY1jdMT6rFBaRnpMHf5l9ZkWVzmFhZ8yFqMWx9qn1ImV8hVM+yn2NdJIl3i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199021)(6486002)(54906003)(478600001)(8936002)(2616005)(316002)(6506007)(26005)(6512007)(66946007)(8676002)(6916009)(66476007)(186003)(4326008)(66556008)(41300700001)(5660300002)(2906002)(36756003)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5PtofYXsO5xLQA/G8BHdRmcDYp+Y4MOdmGoOzdfTyEFTAivAqEvU5kc8AaxE?=
 =?us-ascii?Q?171vdPN6y4GJ+8BDZBbTK5n7YpaHugy3+iwXuwcaVHZMhgZ0BB21W7IWAD78?=
 =?us-ascii?Q?rCCjCj7OMdToEKf9A7SEVzVgvmwEnHiqs6hfWvW8oQ3fAmmmCV8S35Y7QlzY?=
 =?us-ascii?Q?tuK4LhvIzIw9IpGmkUO1+m8WTg8cdu2T2WFbh9IGStVo6OCNIev3De0HnMOO?=
 =?us-ascii?Q?ZkFKCQiVsQ0jjBMOoPpyG+FWQBM90hgG742gCrXQtpKXl8ZuLS9Iu9Fy/BzB?=
 =?us-ascii?Q?gaGiulF74iDygs4JUOcKPDEtJbl1Vy4o/Qsrz17BfUKmOnJfBrtkqOQ+1SRn?=
 =?us-ascii?Q?yGN1+ECRI5c8Y3yvzOiDN8SmB/xH3Dr/1Tr6T+2/tND+VMW+q30UOrCNZrvK?=
 =?us-ascii?Q?GfHL7jwSBQLenLmq73hGe7ol6qe61QCh7/UNNrYeGqTstCGVr+CD6/EPHDlm?=
 =?us-ascii?Q?zPvGqnMarL5zMBCJnorLhnHBzBMUO4P8xQOtHbH7Bk4TVVVFNG5twMdorbkT?=
 =?us-ascii?Q?KCqvMJmlUa/aEExpWIWpUaydtsVc1sm8AHIvZjbuSOUQiYkhsvkW3Go9taXq?=
 =?us-ascii?Q?N6g3aiTU+Jt/bUBo+Ug1/ld6KMEsc6uceDlnWV4Arnu0mKk31KodJJoVGi4Q?=
 =?us-ascii?Q?nwopcelsVDaiLBbcrnCsoaFUHeEMhT07UERmcdw5vbxMCqEMxrIjKzUHukfk?=
 =?us-ascii?Q?3hxYk8shs3dEPgeYQ7Dmp4kVlCGXtqL3aGCVWvuGn4EpPVGXxz7WL8OXsFDF?=
 =?us-ascii?Q?nET/cW+lw/z4ASGjS98RkHHlZIOIXdw2U72PwewNdl8nmNaxkhAHUxrQD8wU?=
 =?us-ascii?Q?r0kmpV3Wp/JzfESuMBGTcO89YOY+YSgr70LcqgSldKnr5tBEVSgSB+1XwkdM?=
 =?us-ascii?Q?rKreqzk8CyaO+WLz/gVEUXaCbJcmwgDsu7xjmHl9rp8o1VbE2Cgs2Ha0aPe8?=
 =?us-ascii?Q?GBNMcjGgWIfbrI9bjYZnlquDH4gZAwFAeFIUSpNeQomQzvv/iedp/Uh856vI?=
 =?us-ascii?Q?kuQuAE8EaqHk0FIkJBY+HuW5v3/HK7DEyMhW6QPYvGU8MYjPXitmbD3r0UWe?=
 =?us-ascii?Q?yBldnBSscK/OIbYHw9uGJfi7zZRJmrbIpbaYUCEib7IehQngyU/1+BoAHzoL?=
 =?us-ascii?Q?O6pi3/D06cSoOYhpYrLUkPIafSwHpU9j390TNhuJk2aGYnSKwYcdti5Izxjn?=
 =?us-ascii?Q?cIh49JpE2aQ7FYmZj5WRNtfrCDPSj03UUDTSipQ0qqGkEw68EJi5ZbgUJK1U?=
 =?us-ascii?Q?sLObqd33HJ7LF23w9yU2LRjxs//O847Ah6H8Y/ufNfo2VLVNkC6MRSixyVOw?=
 =?us-ascii?Q?lKnjIPXwDj8Jae+m8zgdp84Vm7M/Vz30+bf/pM7WVCbKgGdJY/zlWieeqvA+?=
 =?us-ascii?Q?nT8ZAbllsUg5cJi6lGmCb63dkNcnBR7OqBDn9/RpxklOomykFbA72Ro14Y/c?=
 =?us-ascii?Q?FDcyLW/cThZAdyp3SLr08Xw1PdJBYxbNb/PcRzUsyxm0GTlwwfXps6MkUgvG?=
 =?us-ascii?Q?hIYotX3XquJfJv9ewZxiM5Se8RoaI8w8zeT2GJ9jTLA3ppvrh0aI03q9uaJ+?=
 =?us-ascii?Q?AK7Z+pzQZ90fP36ElZMa7ARq07yJYSM6h9N1YbBV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd84878c-0989-4716-2182-08db2f80f838
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 11:38:37.1679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4Gh0pIBDIWbWhEe7EpB5/y9yeIUbxvXmiCjwrI14n+WOjLncwjJ26zXdJyuIUOV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5144
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 28, 2023 at 02:32:22AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, March 24, 2023 11:03 PM
> > 
> > On Fri, Mar 24, 2023 at 01:37:51AM +0000, Tian, Kevin wrote:
> > 
> > > If vfio races attach/detach then lots of things are messed.
> > >
> > > e.g. iommufd_device_detach() directly calls list_del(&idev->group_item)
> > > w/o checking whether the device has been attached.
> > 
> > Yeah, you obviously can't race attach/detach or detach/replace
> > 
> > > And with that race UAF could occur if we narrow down the lock scope
> > > to iommufd_hw_pagetable_attach():
> > >
> > >               cpu0                                cpu1
> > > vfio_iommufd_attach()
> > >   iommufd_device_attach()
> > >     iommufd_device_auto_get_domain()
> > >       mutex_lock(&ioas->mutex);
> > >       iommufd_hw_pagetable_alloc()
> > >         hwpt = iommufd_object_alloc() //hwpt.users=1
> > >         hwpt->domain = iommu_domain_alloc(idev->dev->bus);
> > >         iommufd_hw_pagetable_attach() //hwpt.users=2
> > >                                           vfio_iommufd_detach()
> > >                                             iommufd_device_detach()
> > >                                               mutex_lock(&idev->igroup->lock);
> > >                                               hwpt = iommufd_hw_pagetable_detach()
> > >                                               mutex_unlock(&idev->igroup->lock);
> > >                                               iommufd_hw_pagetable_put(hwpt)
> > >                                                 iommufd_object_destroy_user(hwpt)
> > //hwpt.users=0
> > >                                                   iommufd_hw_pagetable_destroy(hwpt)
> > >                                                     iommu_domain_free(hwpt->domain);
> > >         iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain); //UAF
> > 
> > You didn't balance the refcounts properly, the cpu1 put will get to
> > hwpt.users=1
> > 
> 
> iommufd_object_destroy_user() decrements the count twice if the value
> is two:
> 
> 	refcount_dec(&obj->users);
> 	if (!refcount_dec_if_one(&obj->users)) {

Ohh, it isn't allowed to call iommufd_object_destroy_user() until
finalize has passed..

Jason
