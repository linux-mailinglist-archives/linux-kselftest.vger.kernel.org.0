Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6B97697E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 15:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjGaNpu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 09:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGaNpt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 09:45:49 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8601708;
        Mon, 31 Jul 2023 06:45:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpuYT1bL5Qm2pgix6w+VdJwveRDCtWdr2fH9g7Zg4gF2cztsZ4x+ZZivip6pDHOQoRGgXcB/wMAPpLm4DxdMFYd0drZO9S0H08WpKStul7xKmhXoJRZFnkT9E6JZ5QRLISYe9dbCom3T1sJznwBGy3s3KZFyAthvRrd/hM6UASKCJwFW5KP8O4Vri6qJjiy53Ssq/8YRpiUuzPvqtHuxyxbw+PrXCL/c3Pd+IYVhHEFW66BSOhJTr2nnkqT9VjADw8RE4546Vzd26im+RVwEHdhX3ux0FxfAmcurWLh+RO2CirzXaEiQgtzcSX9vu0VTK3oMlUdIEPpCGHk3C4BH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypMOjGT02ipmvSQ23b2W/DRhdpWskRtwVBJmDklsyEU=;
 b=IAWh7KcKAkTHSFfPVslMno9WZ8r06qgO53nsJ6uK4UYJ0dMQgPb0rWjSb/QjtmWgw4oRbdymjlNwPvf6OJwh4qIC6coxhBBmoxZJiqmsMThGAF0hBwiHgNkmP6hTYY3AAR6QJ7gkDBNKz9N78H8S3M9xvbqvbTCYeJ3fhtLouFYBW8lQTp3A2ZaB7U0ClqwiEap+jxMyI5TuopbF2UJ04ZQp/uFcMl4Zgqtz0bXblXvsHggudizJ0kBYang74RCxlTucN+B5gvR7Nu7nHCworrCa34b0usHs1HVfsPk9TW+D16vGjoZawQ0a102WWCnqx4dbBiOuFETKhVPiz+UAWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypMOjGT02ipmvSQ23b2W/DRhdpWskRtwVBJmDklsyEU=;
 b=kDpolg44/+IAaZZFjjZSWsdqfGp5YqFzVdmUU7ic2kzJHRpz0bnbzVTN1J1BPtEEvR3eUib81cVTwwJMzwGje3RVAbZeQIpu2fpNJW5dOk/3gayEE2ha8ti/qSPGwKRiwp8OufOrlGbbSBzyD/RgQzFNI64gkc0RnEqXNeQAHpfSGOYZUAgvK2730OINXUnhV8GPU/PqC4Fpp1USJobKB4ojCQX0cbg3+y33FccxGeXVBZeL8Z2CDh/Suvj9ygl28+j9FUDKiFfJQqdW1b8NaC+2dHREw4ZlGVFpRT05i0f1Rqo42Qn3QIZYSc2SRN/QBGZabP6BCNxTWVGF4Im7UQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 13:45:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 13:45:45 +0000
Date:   Mon, 31 Jul 2023 10:45:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
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
Subject: Re: [PATCH v4 2/4] iommu: Add new iommu op to get iommu hardware
 information
Message-ID: <ZMe7B8s1tzLsZmIz@nvidia.com>
References: <20230724105936.107042-1-yi.l.liu@intel.com>
 <20230724105936.107042-3-yi.l.liu@intel.com>
 <BN9PR11MB527625066E23A1C4968905D68C01A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMKCd5S9VpNGf631@nvidia.com>
 <DS0PR11MB7529F6D703B42835B0F8A92FC305A@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB7529F6D703B42835B0F8A92FC305A@DS0PR11MB7529.namprd11.prod.outlook.com>
X-ClientProxiedBy: CH2PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:610:4e::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 02d07d1d-ba14-4147-cd23-08db91cc708a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sd3DAKKctcFeEvoyRx8QOpHfX7OF+WQj5zOJsqc0FGrkkUQHCj4AS0dcgrGLZBBlpmOOTIlOKkCY9T8lVKZ8XavEeqUTrY2A2wontejB51ZcQGuuE5yRxvYYrnxwaiVyfIGaEeXz0ymbo/WEjsXGln44sA5iGUAjmE+wwF7VdU6ZxgfEnccSV+xU9YPnIvqjxFZbceR4rL1r3tkDOhEbatIGLtITGPM6TJzcx27ERGt9nlW4A9HjmZ+k41Ena7y8AuT3LuyKZqDN3S/JhKeC16XRbo0LuSLTNd7MUZmNXZRP92cpr/oELzMRYKc6orZ6bTjuPrxkmM6NZknjXCcPpbaOy/wQjQo3/l3lcJ75vE/pFdx9Vh+kfWJlQWCKGMG1KERBPrq5LjMdSMIlwHmSv/qA4hPEBBGUvB2hvrUT9oH++UW93kaKjXaAzYCh1XoXF0DLa1gZtBCd8xg9vtJgQ1ZLPJr9znJ75JzlFbBP+LMeyOMlMmYNbQom5U2rAgtov2yfcqom2yKkPOLGWjEJjds0bptMw44464+epqZfYoOVWVTbcqBAonVZMhxbAnwQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199021)(66476007)(86362001)(8676002)(8936002)(316002)(6916009)(4326008)(5660300002)(7416002)(41300700001)(54906003)(66556008)(66946007)(478600001)(38100700002)(2906002)(36756003)(6512007)(6486002)(6506007)(26005)(83380400001)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iZBS+X1K5AMcNst0Z5nck1k48e32Sv6cRKaZHSL8CXIUWdXinxOkO2hXZA5o?=
 =?us-ascii?Q?cogGV1C13xX/bh0hCg809ZRQhlX3oWF2nHcZ8lcaYz6QPtxmw9kk3HGl9kfT?=
 =?us-ascii?Q?RTiIEFbyDzMf74qT/voiG2RxsbbVyoS9jkhX1wn79vTaOi68sScb2J+Peqm4?=
 =?us-ascii?Q?WomEH02YtH154Yt0+A2CiSx86kdqWcMrAyHm2uzpy0ODpjVhoSkFswsbmJuS?=
 =?us-ascii?Q?hMhPuTK4Yx80QvBFDs9OkzKTXUK58Q0FY0LGvYiavk2i4rwh5Da2ZUdLA4R7?=
 =?us-ascii?Q?dhe5JPjrL84RGiLInv+AqZbEaE8Wl7f2Q29fJGbXSU2SdonDPM/cXkGllizr?=
 =?us-ascii?Q?z47Mq9L7Rhlu+D/ZHeGgEr6IigSnoOWC8NZWWivo4B2cV0mzTm7YjDp1dU8n?=
 =?us-ascii?Q?AbOia725jwUjLVXiFUbU9w9tGb49z0oig0xFEK+5CiSj4Gz4TKMe2wzT0bsl?=
 =?us-ascii?Q?ZlNdLKNrz6qWxyfZuUi5R24u8LW42eWD2v8uBgJD3mwB21YLyAZcoxtgQ4Wt?=
 =?us-ascii?Q?Ap6KkP/APpn2j1v+ZnJ39dsY7Tzj49tyYzYth8KF/RzqJn+oqvQ7z929HtDg?=
 =?us-ascii?Q?dXkXRqFqaHIXE2pLjqj9InO7Jh8BPAopb2Crr0ml/F8sDdsgB+MnP+b/S8jq?=
 =?us-ascii?Q?u4C0sfcAB7LFWuM33U1+cIpkfUouCfPk3kBSmoOqycNKNE9TelrcVVpQYGWY?=
 =?us-ascii?Q?t0y4YwOmLr8AKES7L+A+9jAkQpH5612iUSo3uGPbIFC4rT4JqmG6YHtxu3Np?=
 =?us-ascii?Q?bAmEAdVRmpcoY76tB+WTEJoztOa5x0dEf/Wadx/3yGtzMZLBCuCT6qGRjHm1?=
 =?us-ascii?Q?h5qqI3265BdGXFI+de63VLTus90JE7F0HhrVVhX0qeEx8rgFzcz2JxnnC/ZP?=
 =?us-ascii?Q?grxwctX6iarjBSNYn8M9pHfM0ux5T9fM0IT42yO0oFEfq0xDqXq28XVUHONN?=
 =?us-ascii?Q?3UGRgG4LtGW2nIObqtndMUQZ6Si/Jft+vW2YqhG3jP3o+b4wBz+aliR02sGh?=
 =?us-ascii?Q?3eXmCF9iLSan7nni5dn9/mTjerDEwQDVJKz0HsQF0otcAA2cugP2HusZdVBg?=
 =?us-ascii?Q?8fS2ivpihnG388x52SWYCPBIeNvsDHBYjzAmAmYkHxuf8kNiyPwXB+dWnJ2+?=
 =?us-ascii?Q?wAwNz6rYRfV1Cl5L52BnDrdgV0OzhOu0b7mNhutCAJPp2VaLnDTxgaGRdYOq?=
 =?us-ascii?Q?FtL4A8cCUZeI2HfQua/gAFcs7lpFu1nQJOc+8Mdj/YD3C4858EfdVirIvVR/?=
 =?us-ascii?Q?aot8SlS69dO4s6MRgiLHEGPxgnUa5qcx4xFQbuSwjXC4He1FD+kdDMzHIaD2?=
 =?us-ascii?Q?xHXe2AxCw4yqLWrkflrUnOQIwlRydYKvNGxPX3UKo4/2onqb4rPa8msH6Yd1?=
 =?us-ascii?Q?2HWxOwGmLHup4H9P3JUUs5CALcmkqvJtRTxoWa9R2/HoxmTUNrKQ4u2kXQ6T?=
 =?us-ascii?Q?PjvamuGOpNTx9PCqpw1fiMTLNFu6KyaAj9O6yIPlcX7Hl4Y8953zhJNzpRy6?=
 =?us-ascii?Q?mBkMuJVqsdOq3wAi+Jd9nRIxSfdNwkySsa+x/w6WqsXSk+YmBGDugLtUCp1V?=
 =?us-ascii?Q?/KnVHVRjuzvayUOwgiPpQ7PwTgZf2TA33f81tbXW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d07d1d-ba14-4147-cd23-08db91cc708a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 13:45:45.4371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFEBNLYYab7F7Ar4NLFlhuaOSNNJrC7hZLJUxN593KmLlTK1lFnMPcdZfArCueUd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 31, 2023 at 08:33:55AM +0000, Liu, Yi L wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, July 27, 2023 10:43 PM
> > 
> > On Thu, Jul 27, 2023 at 07:57:57AM +0000, Tian, Kevin wrote:
> > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > Sent: Monday, July 24, 2023 7:00 PM
> > > >
> > > > @@ -252,11 +258,20 @@ struct iommu_iotlb_gather {
> > > >   * @remove_dev_pasid: Remove any translation configurations of a specific
> > > >   *                    pasid, so that any DMA transactions with this pasid
> > > >   *                    will be blocked by the hardware.
> > > > + * @hw_info_type: One of enum iommu_hw_info_type defined in
> > > > + *                include/uapi/linux/iommufd.h. It is used to tag the type
> > > > + *                of data returned by .hw_info callback. The drivers that
> > > > + *                support .hw_info callback should define a unique type
> > > > + *                in include/uapi/linux/iommufd.h. For the drivers that do
> > > > + *                not implement .hw_info callback, this field is
> > > > + *                IOMMU_HW_INFO_TYPE_NONE which is 0. Hence, such drivers
> > > > + *                do not need to care this field.
> > >
> > > every time looking at this field the same question came out why it is required
> > > (and looks I forgot your previous response).
> > >
> 
> The major reason is that not every driver implements the hw_info
> callback.
> 
> > > e.g. why cannot the type be returned in @hw_info():
> > >
> > > 	void *(*hw_info)(struct device *dev, u32 *length, int *type);
> > 
> > u32 *type
> > 
> > > NULL callback implies IOMMU_HW_INFO_TYPE_NONE.
> > 
> > If every one of these queries has its own type it makes sense
> > 
> > Though, is it not possible that we can have a type for the entire
> > driver?
> 
> Not quite sure if I got your point. Is it acceptable to define the
> callabck in the current version? or Kevin's suggestion makes
> more sense?

I'm trying to remember if there is a reason we need unique types for
the domain and the invalidation or if we can get bye with a single
type just for the whole iommu driver.

I suppose if we ever want to to "virtio-iommu invalidation" we'd want
to use a new type for it?

Jason
