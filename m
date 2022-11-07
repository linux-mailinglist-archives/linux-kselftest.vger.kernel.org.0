Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F0861FC55
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 18:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbiKGR5V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 12:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbiKGR4m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 12:56:42 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C26264B8;
        Mon,  7 Nov 2022 09:54:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCrRkNTbzymS0r5KzHVwSdQmptuvMgf0Fbqj1cKSu1N3w1gt5IDhD2j9kHptmjzNS9mIAHTcio02lWG9DfVg1OOPQ6n2AwDAZwbRvT/gD4o0QHV1BOL1Ad2l87PFHZfTW1smEI2anoOBXfEA3d9f4H+A1vjn3VoaSAa8a0MdJ++5jKPU0+hRkevQlx17qlZT4+HaAlO/1Iw4u+RFkL5mv0+SoH24rZ3E/a7g+hWVCuqUi7xlH1w8jyFf7Ourw8457s35vtguqtImlDXa+6nSu5xXUppawGvpRfoeWfO3OAvM+aeTtGv8N5UF5hJGqhx0xEZH571AyvAmHP62vxkXKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oq+6drZntnxohH8iC15+bPSjD4OuSyR04N8EmKLEcTY=;
 b=NCkK2MeBMNrj5IByutUwBe9/+cdJEqerOoYSvjvVSC65nP4rbgdsz0oySOjJ4a06fD/3nmb9+HL4HXrzw5WA90+BJU5Fs8UAnQZ+E00mCZaivF616e6ox6Vx3VVRWgzXB0/u8AAUB10lWpx6ilOHjLUObP7vUVBZuSchHfzxwQgK9wbsS86PSSf8sSfKcuWNvhHL84xWt3n8yYg45TX0bqRNMQVwAtDh+rJUtSXX2sF6FTvKINsMkOQ1SqjfkW91oTt7oJMJ4v4yZ7WreaGF8SYmDsltymO9prG2iMD3UIF257noZbjEl+OS/cHDF+nKzqmdfHZn6HSBHvmocRaW8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oq+6drZntnxohH8iC15+bPSjD4OuSyR04N8EmKLEcTY=;
 b=jVewcCIiu54G232wkEETVmdDDdtefP66kLonayse38efzQ9+EbaRq8AB6SiDrFl1yUIUsowzDC9CjPBtMBdy06w7HieHda7WRvj2s/Hyz5SUy7am+mh72vHILiMlDRezBQ2khvjBASyd4h+RHWzy5HtMl1VZ5YBP1tar65CJCKxCoznJECfRL3LOG9cFexrI8xc1rOL1d9ayUp0Wg6Set+0j1w3QhYQ2LIFwSA1Yv7HTMKLL91j1T5aS+ypQLc5se9yXdsk6u2rWaNJPn63fPg87f63xkL+y89A+SGw5e3yB68R28dA6Lai4RzmMFoE/xaPyo4A6fcQETMXTd0Iznw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB6923.namprd12.prod.outlook.com (2603:10b6:303:208::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Mon, 7 Nov
 2022 17:54:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 17:54:43 +0000
Date:   Mon, 7 Nov 2022 13:54:42 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
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
Subject: Re: [PATCH v3 12/15] iommufd: Add kAPI toward external drivers for
 physical devices
Message-ID: <Y2lGYkO9X0neQTP5@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <12-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <BN9PR11MB527617D35DE59BD0EF10F7098C3A9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527617D35DE59BD0EF10F7098C3A9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR03CA0153.namprd03.prod.outlook.com
 (2603:10b6:208:32f::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: 1867a9c3-780c-40b1-08a0-08dac0e92623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OMqZ9LgNLGKNdRI+gyvBo1sbNIIZZd8QmLhLx5hLSho4YRsFiqyi0fQBz/3eW3ZfxB4hRipJdSwjXXASUBZSyf++Y00qb7cKUpWBjetBYYtiomOL89UIdpusw5G3zDiv3MIkDP6mb5K3LDazHjnbnk3NySAtq1H5MPrhbN2tb6gMighBCs0Vo3Q3O4Gy03FsSO3nFakBqeTAVRyiR0qTkotl+unP08iPRSN3zaEAY/QHYAKTqb9/W72x496fII+guyY4p6Aaj7NRRUfd/+DP1HSVcR0iuSI39x4hIhk926/uSL7waKqaBEGvoTVZK1zVjxvFL33Ap/SCT+iYUSwoZl+lXVzGhYahKu7120PRgVKFBtOUq/w+I9ozAXjjj6Ap6hBpeARbT+GVyAHld/qpZwuvoZ/Dm0cI8MYwby4D/9nFJvL4/YL/vLLgYX+YA0P12F4HHmzW/PqsAPiTp42Xeocr22/sigIGVwlfGRArEUfFqy2/vG+SdMdTq4rp+MAIEu3KTXj7nFFs4vkcvExbaeZwAHufbGMH/Fr5q0SWorJcHzqvDushn8BzBXFZ6uuOMpCnI5A6fV5E6zEQd6Nzw8x7kIwusjTJIAYjvAnR/HidgWMcPHuKQ1s7KDYrDts9Mx8GEjP3RKkU0pF7FHLANAIwHjy2e+xLRNyb+Zem3yBYBYMsWQAgeVmloiJKPKqoLyCdqoYaQYG1MQDPe6CnoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199015)(86362001)(38100700002)(6916009)(316002)(54906003)(6486002)(8936002)(66556008)(7406005)(5660300002)(2906002)(66946007)(4326008)(41300700001)(8676002)(7416002)(186003)(2616005)(83380400001)(66476007)(478600001)(6506007)(26005)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t0olbjfdmccZwvD+UAkmmvl3ebqALOLVGRlNIMUOGKOuyFN2+qJYQo1tdU1V?=
 =?us-ascii?Q?EZkoAtnren5vwfAY0qCK0t9w/2H3FkgJfYnsBFyBCTswtaAOa/N6qtzh+DZr?=
 =?us-ascii?Q?o/JzpesbvnjWxUgkJ/le6txVsA5np4H2X6iGtPuBIldVlkXOezcI4WsSDnrZ?=
 =?us-ascii?Q?J7vD+S/ui/Ph3tb43mYZxXpYyNW6FPULKOKahuLwij3YInhPG6hKTkbXlK1s?=
 =?us-ascii?Q?DrNH0rq0NmJhHRLI+GP6qm1qoE25wQvqo2cXFNEYPRvaLeUsrrGhay/BlTG7?=
 =?us-ascii?Q?6XJCJje9TsmzKpTcsE2QewQ9vcHWZrEa/pVW10UpQYUleERiIVVPIz+LTSOR?=
 =?us-ascii?Q?pSWZT1qcQtIjBVT6pqXK1hdQ9EaCdHYCGlrIDBt5S5445IOiehWD5i3l/cws?=
 =?us-ascii?Q?kVQJCoEKPjMkR74CUiXm5DbLwRx7d6LdxanClFuEvJxdwJccyOMgK4LR4kEE?=
 =?us-ascii?Q?NQPkCxBnAfVZlWlrOplLxPt304+2PELwtUddFipfF+60dhfXZ0+X/tB+PpQm?=
 =?us-ascii?Q?dO0gjSZwntcalElOwZwXbQvAZ6I9cwvwWm48qEcC0UCy4CIedqX0AGjmMMx0?=
 =?us-ascii?Q?+OFJibzmbwtzZMVAeSyK6vDzntKTNwFT0xnG0FuIMrIFQ/NP2GNg5NAqS6lT?=
 =?us-ascii?Q?4S6ezYIREzwYSYYdPU+tCuWGmEHzfs7do+eLas8BC0PeE5rD1IqxXGQscaa6?=
 =?us-ascii?Q?zkTTnYWrrxWrCuYXBFStVVTNXyVFcDb8m42SBYVGPD6c0RH6Ad3uU/RrTJZj?=
 =?us-ascii?Q?9Gl+jRE7r0N6huhNWTvHZBkGJeUNMfDoRvjj7+lwXNrazS238AcDUxZ6lX1e?=
 =?us-ascii?Q?2LOsWL0BCds4lg7G6A/IwFejtOcE62hJ/22e+tVYUR0+iQqsJ1e6Kd0nfur1?=
 =?us-ascii?Q?+0NKI2LqngDCdLlEVYH34OU+9iqIGKtfxOJaXku7x9p8ZvLQVjxdVFHwj4IT?=
 =?us-ascii?Q?AKbHRl8mgprnGkclzB6FSPCxSQM7kl4XvVGb6HEu+/6mIR6QV6OJ1PBrZDzW?=
 =?us-ascii?Q?hwjDItQou17SpkovHiVAPO4NGXsST7POhvcBlKw6RDrBP+gtQ2+H2Ofqc/MQ?=
 =?us-ascii?Q?PKqUDjGjCYnfZp1WLp9PGRjO7hD32giwsuwHkNjCKOvv3hZvUb81ZoI9pVld?=
 =?us-ascii?Q?+2uvSNz5j8t/GLVkHij4R02E/uYpssv5ryoVtDD7Ma/IqRhDheaXvTvn8nbu?=
 =?us-ascii?Q?ysQNP0ZG2l5vrGt9xNZtqUHBOIgtQKy7giQs7ffef/bxSsHSoZ9Nszjgmk3Z?=
 =?us-ascii?Q?34MsgsJqWMOJG0sGoABJggxEfxB0jhuidDQcsSD7o++DQ6hkZbOhN418rSO2?=
 =?us-ascii?Q?O3XlOga2HG0i2/40yG4Wt/T86T/nlCuE4uVFFg2wmzg6TFb9IcJ1MSv/3SXx?=
 =?us-ascii?Q?bEyxGt1nC5kaDmKJf8t6fU5SGi/jJxOvzA10KmQtbrClVhoO9bepvbCDMjDn?=
 =?us-ascii?Q?uNtQCGA8BGMsiHFZgUPr+ypres4LkOcfgA3PkD+dWteRZWPtlXryM4ZyHbkX?=
 =?us-ascii?Q?qAy5K/UVzntSnq7NZJk5JX2c9e2OdSU1/7ayRkwVQ5c1kiXIjiGkA+dp0xKF?=
 =?us-ascii?Q?5WJfbzF17RjzIJ/lw7w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1867a9c3-780c-40b1-08a0-08dac0e92623
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 17:54:42.8120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TgG0R6hc3kh46uJYvt/lvwGusDJbPLV6IqN+RNq1rkbhZpE1aP7m3EZLGM0b8E3g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6923
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Nov 05, 2022 at 07:17:38AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, October 26, 2022 2:12 AM
> >
> > +/**
> > + * iommufd_device_bind - Bind a physical device to an iommu fd
> > + * @ictx: iommufd file descriptor
> > + * @dev: Pointer to a physical PCI device struct
> > + * @id: Output ID number to return to userspace for this device
> > + *
> > + * A successful bind establishes an ownership over the device and returns
> > + * struct iommufd_device pointer, otherwise returns error pointer.
> > + *
> > + * A driver using this API must set driver_managed_dma and must not touch
> > + * the device until this routine succeeds and establishes ownership.
> > + *
> > + * Binding a PCI device places the entire RID under iommufd control.
> > + *
> 
> Then what about non-PCI device? clearer to say that calling this interface
> just places the entire physical device under iommufd control

We don't know what other bus types will do with this API. The above is
guidance specifically for PCI, other bus types should add their own
guidance as it evolves.

> > +	 * FIXME: This is conceptually broken for iommufd since we want to
> > allow
> > +	 * userspace to change the domains, eg switch from an identity IOAS
> > to a
> > +	 * DMA IOAs. There is currently no way to create a MSI window that
> 
> IOAs -> IOAS

Done

> 
> > +		rc = iommu_get_msi_cookie(hwpt->domain, sw_msi_start);
> > +		if (rc && rc != -ENODEV)
> > +			return rc;
> 
> I know this is copied from VFIO but a comment is appreciated why
> -ENODEV is considered sane to move forward.

Huh. I actually don't know. It looks like it is here to detect that
the static inline for !CONFIG_IOMMU_DMA returns it.

However, if we have !CONFIG_IOMMU_DMA then I think we also don't get
interrupts at all. Ie iommu_dma_prepare_msi() becomes a NOP and
nothing will map the ITS page into the iomm_domain.

So let's drop the ENODEV check, it looks wrong.

> > +	/*
> > +	 * Otherwise the platform has a MSI window that is not isolated. For
> > +	 * historical compat with VFIO allow a module parameter to ignore
> > the
> > +	 * insecurity.
> > +	 */
> > +	if (!(flags &
> > IOMMUFD_ATTACH_FLAGS_ALLOW_UNSAFE_INTERRUPT))
> > +		return -EPERM;
> 
> Throw out a warning similar to vfio.

Ah... That is kind of gross.. But OK, we can fix it later if someone
comes up with a driver that can safely use
IOMMUFD_ATTACH_FLAGS_ALLOW_UNSAFE_INTERRUPT.

@@ -167,6 +167,11 @@ static int iommufd_device_setup_msi(struct iommufd_device *idev,
         */
        if (!(flags & IOMMUFD_ATTACH_FLAGS_ALLOW_UNSAFE_INTERRUPT))
                return -EPERM;
+       else
+               dev_warn(
+                       idev->dev,
+                       "Device interrupts cannot be isolated by the IOMMU, this platform in insecure. Use an \"allow_unsafe_interrupts\" module >
+
        return 0;

> > +	rc = iopt_table_enforce_group_resv_regions(&hwpt->ioas->iopt,
> > idev->dev,
> > +						   idev->group,
> > &sw_msi_start);
> > +	if (rc)
> > +		goto out_iova;
> 
> goto out_unlock since the function internally already called
> __iopt_remove_reserved_iova() upon error.

OK

> > +	/*
> > +	 * There is no differentiation when domains are allocated, so any
> > domain
> > +	 * that is willing to attach to the device is interchangeable with any
> > +	 * other.
> > +	 */
> > +	mutex_lock(&ioas->mutex);
> > +	list_for_each_entry(hwpt, &ioas->hwpt_list, hwpt_item) {
> > +		if (!hwpt->auto_domain ||
> > +		    !refcount_inc_not_zero(&hwpt->obj.users))
> 
> users cannot be zero at this point.
> 
> a new hwpt is added to the list with users==1 in attach.
> 
> detach first removes the hwpt and then decrement users.
> 
> Both are conducted by holding ioas->mutex.
> > +			continue;
> > +
> > +		rc = iommufd_device_do_attach(idev, hwpt, flags);
> > +		refcount_dec(&hwpt->obj.users);
> 
> with above I also wonder whether refcount_inc/dec are just
> redundant here...

Yes, it seems so (in ealier versions this was not true, but it is now):

@@ -267,12 +272,11 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
         */
        mutex_lock(&ioas->mutex);
        list_for_each_entry(hwpt, &ioas->hwpt_list, hwpt_item) {
-               if (!hwpt->auto_domain ||
-                   !refcount_inc_not_zero(&hwpt->obj.users))
+               if (!hwpt->auto_domain)
                        continue;
 
                rc = iommufd_device_do_attach(idev, hwpt, flags);
-               refcount_dec(&hwpt->obj.users);
+
 
> > +int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id,
> > +			  unsigned int flags)
> > +{
> > +	struct iommufd_object *pt_obj;
> > +	int rc;
> > +
> > +	pt_obj = iommufd_get_object(idev->ictx, *pt_id,
> > IOMMUFD_OBJ_ANY);
> > +	if (IS_ERR(pt_obj))
> > +		return PTR_ERR(pt_obj);
> 
> Is there a reason why get_object() is not required for idev?

Caller has to hold a legal reference because caller is responsible for
the pointer.

> concurrent attach/unbind could lead to use-after-free here given users
> for idev is added only in the end of the function.

Caller bug. It is not allowed to continue to use idev while it is
destroying it by calling iommufd_device_unbind()

> > +	default:
> > +		rc = -EINVAL;
> > +		goto out_put_pt_obj;
> > +	}
> > +
> > +	refcount_inc(&idev->obj.users);
> > +	*pt_id = idev->hwpt->obj.id;
> 
> What is the value of returning hwpt id of auto domain to user?

It allows the userspace to potentially query the auto domain, if we
decide on some query later.

> IMHO this will add more complexity to the life cycle of auto domain.

Not really, the usespace still controls the lifecylce, the hwpt id is
returned and is valid until userspace commands the device it just
bound to become unbound.

> now if allowing user to populate auto domain similar to user-created
> hwpt then detach also need get_object() to wait for concurrent
> ioctls similar to iommufd_destroy() does and more trick on destroying
> the object.

"autodomain" means the hwpt is destroyed when its device list becomes
empty. This is all protected by the ioas->mutex, so we don't need
additional refcounting or locking.

> > +void iommufd_device_detach(struct iommufd_device *idev)
> > +{
> > +	struct iommufd_hw_pagetable *hwpt = idev->hwpt;
> > +
> > +	mutex_lock(&hwpt->ioas->mutex);
> > +	mutex_lock(&hwpt->devices_lock);
> > +	list_del(&idev->devices_item);
> > +	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
> > +		if (list_empty(&hwpt->devices)) {
> > +			iopt_table_remove_domain(&hwpt->ioas->iopt,
> > +						 hwpt->domain);
> > +			list_del(&hwpt->hwpt_item);
> > +		}
> > +		iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
> 
> this is always required. not just for last device in a group.

Yep, good catch

Thanks,
Jason 
