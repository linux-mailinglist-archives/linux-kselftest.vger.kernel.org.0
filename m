Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471B2773DF3
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 18:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjHHQYn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 12:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjHHQW7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 12:22:59 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20607.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::607])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A85A278;
        Tue,  8 Aug 2023 08:49:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQfw5DAI2T/X2SY5ZsOHw63QLg5ZRg1TxleIVt2JQFa+KVK034NPcKhE+k8hzB4IHZE8H8Rsk2Dmkgpl0Pm7c4pzEba/9+wry3GwqON+5H+/22V1eaHoveliXe9vtwP3gjs6Rpu2vRNrgz0QJwoZl9eBsrRQXAHDksVcSbl4qurbQ5S+b5YUhXvuYyK16XrPv3GM1qMGgyUgTO1Mu9cpuzhp5moQRmICb92wkXza0gDIniicu/dF2RH3pqgHNV+u+WJDR5pSsEkvlUpmvjmJYJ8DQeceLGRyklCr470f/KPS3+0gFY0/uBFaUjtaCeTSNWPztbVtHRH5qgTXkMUjWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPF07RDdIl7+e43hfcBqnZcvbtLnBEfe3h1J+onKoD4=;
 b=nTDDSjF18cEx5u2yPbsSt1AwuWcvO79VEQtZABAExG1mZgwY7wBDLDmIw1Fhc1BJ7s0h14O/GBk6QBrJQyYixa9FAgAyEfZ+RCqH5VTUjfmiirxjUNJqf4D0anwFN/5KBfkuuvJLzrND6p6tl0/y+EHF/HCIKpV9qgyS3EFOSSOytmtrfUf9M6HThTB09cVqhuCZMFSqDv40y5iaDce6pq7WzLfRTNISeyVMwfkUO8xGhf30SozjlalHQyjfcHkD02tzAueMyaQfeeAQPSrAlCvBsy397+urhZzWDrJvhABzxUJt5Vsea+01tCFx6zGvDUQH1MNuB51QbbK+T5DCkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPF07RDdIl7+e43hfcBqnZcvbtLnBEfe3h1J+onKoD4=;
 b=CtGNCR/5rcUK5wJaDI+rZh2pzfrs6u/XBjc1nC5HrB4pAeNlZR+rXvLjNqaiM24H8niTq/lbHyZFvvQTK4hmW6Kt6lae9zGj5MJ/uZXoeMwrB2TQWCXHE2h5O48er7KAEzezZpXfOMDeTggHJFjugy1Wth2jitJ2tkqYg7B5NRuuYMGfihVXO8oqPfGnwvvMre0xX6tylPwFr5zZ3lLQLNVSUQZYklFHb07DxKLOcfVd/MkEohM6cDL+uN8pbXgbpOvrBgF6BjJCvpEqKkRj1bf6iX/TrkyG/SNNGyKNpFQQla+x9QTDzuosJR5Vav7y2M0jx0HzQMdWrczrLmsE1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4412.namprd12.prod.outlook.com (2603:10b6:303:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 12:34:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 12:34:04 +0000
Date:   Tue, 8 Aug 2023 09:34:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
Subject: Re: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Message-ID: <ZNI2O4Upyna5AWDA@nvidia.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-10-yi.l.liu@intel.com>
 <BN9PR11MB527690EBAA872A16AE8926F88C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529F4D4DABBE29E9B7BF5C9C30CA@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZNGypUee/U9d68TZ@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNGypUee/U9d68TZ@Asurada-Nvidia>
X-ClientProxiedBy: BL0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:208:2d::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: 872e303e-03ed-4cb4-8c60-08db980bc07b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KoR8g8/jbv8A/crS23X4SwJyprgXTrWqo1c6T6Sf7fIw7U60RS+da2RlgavpA4nIuOv8WGBnlaCMUb2wq5kxocFAYGTst07QDLwNNn8yBZutbN7+4KL9x/QTNJhsHdcHwYMMMQ6sy0PobEWIzORt7Wt4LvEuRXiegYTBv9/N8T1lbyM+vd224g/fzs5gtDon4a3y056FQ4y+L9BwXuDMVkGGcVwhhQUI8vsV/svErWMuPDMR2dSXqCZ9fh6Jwoo4DHNipZ0HBOWMBrqAjsbnHPlo04aTq/Hq+qOI5N0aLzs1RjQPjDhfIE3r7nTXE6iq8OTscLGFw6h4TBUfq7KcZE2yoUobLUJV6jrl1D2sK0gTZEE0odDSYqw8Eb3prUy4SperQlzDsigjQZRqUa2Mbnp6o3SuaZWHVHu1X/ZORynLa0hFzNmnRe5rCmW3V2Euhpp7gCEjBXPXQO3WFV1ViNEZIPFLPqplkhcorIVGlfYvIqI1nHPI6daT5Vy2tuZOKuq71bRIETPX9KMaD4vUG1mJk0Hvq3OzffXtmCsoVmftpixvap39aUAF9v+isY7F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199021)(1800799003)(186006)(316002)(83380400001)(2616005)(2906002)(36756003)(8936002)(8676002)(26005)(38100700002)(5660300002)(6486002)(7416002)(41300700001)(66476007)(66556008)(4326008)(66946007)(6862004)(6506007)(6636002)(478600001)(54906003)(86362001)(37006003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fajDz3R9EKu21VOipfbnYokBRjrp1y9MTiACSpBl5BNkRbbDfku4Z6TMDIv1?=
 =?us-ascii?Q?pHJXH6ZiIjBbwHNojNtHU4ihzRp9wjudLBdN5ZXWaP3Z1l56+hb+ZTpGc7i8?=
 =?us-ascii?Q?+8UrZe1UeJPp9/mfTXV6zirzDND69OMUQWiLH1nFdDhly5dwa11ORWsyO4Bz?=
 =?us-ascii?Q?dJSjEZ9gkCAPvo5v9AlI/rPzohaXMUzzOTGwATs8o9RQ0D/OAjNvw0TUPCnO?=
 =?us-ascii?Q?GV4LdbivcCMFbZZqXE9K/PcIkVDiE+yXByigdW/M5UqIWb/pR0MnjpNeMmc3?=
 =?us-ascii?Q?XqcolfuWhRxz530hAEAzs/I8b4TGwu2JUnD9o7KN3PnlnbsSmOtZdMi4LKlE?=
 =?us-ascii?Q?AqFDh7e4/Pwr7XWns8TY0hmzjTiQkhFrsMhgBsvcRCvfV95RtjiUUdoMJXSV?=
 =?us-ascii?Q?y3Kiv/onc4vZKy+p1ZdGT+kI9qTVYeed9RzFZyPf8AyJVsrsWp3XVS+9BNkU?=
 =?us-ascii?Q?PNzejRCjAYkHcU5yAbQGfUvWbv2BdQTKFqaJHd2gEfx8P1L56RXb/DK7nakL?=
 =?us-ascii?Q?HYBSo9TWCLHzGtuqmzTKie3JL65BgNsCVYg+CPy6sq7eR21+yfIyMaSqqH1n?=
 =?us-ascii?Q?X3N3L3P5R2E47l4kfEP7KX/E9KklIL7OKZVzHmSu9np7u75STO5G7b21M4Ya?=
 =?us-ascii?Q?NyhpaDPZfGCaqiSEC0itQ3h83enLa+1HamGZTpu9E7NO++y5/QSAbw5l7rJx?=
 =?us-ascii?Q?eXC5XP5zYqq05HEbTnTC8nzPoq9Cd/jXCEW3TIvnHgo444rYDqzByd4FARtc?=
 =?us-ascii?Q?pxB2Wx1pskAm4apMVWqZo2Nq2NU6fjo4a7lZPHtDjnIYBHcBR+oxITKgQ6XY?=
 =?us-ascii?Q?tCs1LxoZyg/ghH50u14FJqPfChoAeGcl74ae4NzWig2cvP3H+zjpDZ7iSYho?=
 =?us-ascii?Q?kOW0UyEPBDfnUq4+avoTuCcQuGsVgsyfQ5or1PZf2mxdt7cPTUPnWD7BtCqN?=
 =?us-ascii?Q?fnm4chzS+5657Ziq3krlIrZGNg2OtcSn9nXH8A24/AGgbxCUqdoQ39flkhtR?=
 =?us-ascii?Q?OdeB+PVrB4dN24VUB5aIyyXyakTIhQpgGFJxytK/YoBLCnVvUc3JTbsMUcWQ?=
 =?us-ascii?Q?X1s7+hDRSXf57Ji+laLoUAOKo/kjCRKGVZ7znTibNwysFn9bLECx/R4ZBHFj?=
 =?us-ascii?Q?hCfVS/2exchZbLBoG+OF35DYTChsDN7LBTz5Zvzq2dghQgiRYp+B5f5oUetN?=
 =?us-ascii?Q?bt6K5evdBwat6tHvVzRxCSBuPQloHyu6IumtP+dkR8gEaLvLnFhIg/TJfgiZ?=
 =?us-ascii?Q?b1xOxl2BxOneRziZeJYD5oAiuF+YrClUWDRfd5q11fC/6ZSxg+4tRaZPF7l6?=
 =?us-ascii?Q?qUEfzjhx3sAK8Y/CI0LmcENC6ojIrwTeBcHScDOlBpm2qULYErCC+bcOvd/h?=
 =?us-ascii?Q?liTz+51JOGMOq/KbygTE2Uu+QEGDEmT8XS3xLXxLFSEQ3mfL/XQvosPoTTv0?=
 =?us-ascii?Q?c7MUcKMqfmkZ5dgbfIx8jyu2hh2UQU4eebNAX8S/WRV56ERz24Jrl2O4xWls?=
 =?us-ascii?Q?/DBfe8epPPQqbJMWrFWkuSnLErx4yqJKyqvMkQiVYTsTWu3Zn+Ve7/l3+syT?=
 =?us-ascii?Q?+BZ7td3PPWwJzIuRvyN6YXn+7ArK2bZi1bZGbEos?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 872e303e-03ed-4cb4-8c60-08db980bc07b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 12:34:04.6406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FGBHXbFASyVrxvh/1UKxpArogDT0UBptPzg3aMxUotDJWVRbsLKlsh8MiNXmbzRK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4412
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 07, 2023 at 08:12:37PM -0700, Nicolin Chen wrote:
> On Mon, Aug 07, 2023 at 03:08:29PM +0000, Liu, Yi L wrote:
> > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > Sent: Monday, July 24, 2023 7:14 PM
> > > >
> > > > +static int intel_nested_cache_invalidate_user(struct iommu_domain
> > > > *domain,
> > > > +                                         void *user_data)
> > > > +{
> > > > +   struct iommu_hwpt_vtd_s1_invalidate_desc *req = user_data;
> > > > +   struct iommu_hwpt_vtd_s1_invalidate *inv_info = user_data;
> > > > +   struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> > > > +   unsigned int entry_size = inv_info->entry_size;
> > > > +   u64 uptr = inv_info->inv_data_uptr;
> > > > +   u64 nr_uptr = inv_info->entry_nr_uptr;
> > > > +   struct device_domain_info *info;
> > > > +   u32 entry_nr, index;
> > > > +   unsigned long flags;
> > > > +   int ret = 0;
> > > > +
> > > > +   if (get_user(entry_nr, (uint32_t __user *)u64_to_user_ptr(nr_uptr)))
> > > > +           return -EFAULT;
> > > > +
> > > > +   for (index = 0; index < entry_nr; index++) {
> > > > +           ret = copy_struct_from_user(req, sizeof(*req),
> > > > +                                       u64_to_user_ptr(uptr + index *
> > > > entry_size),
> > > > +                                       entry_size);
> > >
> > > If continuing this direction then the driver should also check minsz etc.
> > > for struct iommu_hwpt_vtd_s1_invalidate and iommu_hwpt_vtd_s1_invalidate_desc
> > > since they are uAPI and subject to change.
> > 
> > Then needs to define size in the uapi data structure, and copy size first and
> > check minsz before going forward. How about the structures for hwpt alloc
> > like struct iommu_hwpt_vtd_s1? Should check minsz for them as well?
> 
> Assuming that every uAPI data structure needs a min_size, we can
> either add a structure holding all min_sizes like iommufd main.c
> or have another xx_min_len in iommu_/domain_ops.

If driver is doing the copy it is OK that driver does the min_size
check too

Jason
