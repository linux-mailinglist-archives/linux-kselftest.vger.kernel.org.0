Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC5F639E67
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 01:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiK1AOV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Nov 2022 19:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiK1AOT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Nov 2022 19:14:19 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A298CDFFC;
        Sun, 27 Nov 2022 16:14:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8xf6Ef3vQLU1LovLg8lNUFvx24kx2i/WI576gy4c2BfACe09hnus2uM/Bs49j0UgA5pzk7KPc6F3q8p7C9r1c+u+J6M4kn7kNpl5TqAbm1Q5GgObJpJOYJGoB4EL4sOO+N9Uf7HzTFanpmKc5Qzi5laeu4nYYykRk9FVtd/0V0latgWAcEL8P/sebc60RzJmbE1WN3aGbQSGpuYEXIt+PUTWYS3sj/LE9NK16L7t9Yvge8PrNtyupFLasO/M4Vz+yNaKmdE8M/9Y2/2p/HV+jXCiz7tCINHYjs9ZGxl4FvW8+xj67UddiK8cUfXxrASMJE5anXC3nnGKsnBkV/gEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3g447EvWhn9xGj4dlUGZ121BarfYa+Mro4tycEWBXc=;
 b=AXZh3JnE7CsvNbHsrCS43W6bQMwLQhrYibC0/FlgPM6+8uxC3Rd091rrHnjtGz8vzpyg8bE7pYo0cxOe8vpMmoxZYnR3pXGPhtPXkZoADsTjq1KydYi6+u5PsEe6QI/NiVi+gao1Uzx9bw7a6uOnm9hu3dgz0bsICtzeVjyRPWNWYy0JOXx8f0xUEp2Ds66wxpMSUFRFzqIJRWfqdB9k0NOXIOkzSa9rlzWRypZIRHgxOa0TC7cXcpMDxdO6PJ8qG72OyabYNNlWkVZ+PKGuZT5UV5lQnaRmiQI4Z6wbu1G3McT/GNPJcbNfqC30vUim7MPWx8vqPuTXxn2+Hm7zZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3g447EvWhn9xGj4dlUGZ121BarfYa+Mro4tycEWBXc=;
 b=SnenUDtYxXVQcCTz03fUWXBXUwrXj8HryKzLkcrUxjtS/ZdZ/NzP0CNh9hk2eQr3sRUFbdosU2nVI7p9geGYBEoNdu/DDjJ/ZqbwK8ZqsRQhrK+7auahNTQ3CWg6Xt1q8qTEsK3VAdhtCODYqvVN3FCGz6Sr0bfp2+J7RkFBHuaNH10u/iKiJCrFG4whzt3q4cm4U1PRq+Llpi7XsuBHpXofV+RzEMydYFTPVDs/uxru3l/X0pchTLYnIVKceuNE7nJ83yq5cctLnKqH6kHdwcjRl0oN40u5UiVk6wmqcn2JkHrdZow8SbVTeAQrBmvD/n9xB7dtnZ7WWszQE6wjCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7628.namprd12.prod.outlook.com (2603:10b6:208:436::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22; Mon, 28 Nov
 2022 00:14:16 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 00:14:16 +0000
Date:   Sun, 27 Nov 2022 20:14:15 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v5 13/19] iommufd: Add kAPI toward external drivers for
 physical devices
Message-ID: <Y4P9VzpCv/DyHeaD@nvidia.com>
References: <13-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <4c429c36-146e-e2b2-0cb4-d256ca659280@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c429c36-146e-e2b2-0cb4-d256ca659280@redhat.com>
X-ClientProxiedBy: BL1PR13CA0248.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: b8ca9691-5aaa-40f9-9a39-08dad0d57c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nyul23qIEfTr+biFLh5vJbVW8C69D9Ww/D+WYzFrzFG1uMuK7tAwgBpKJn68BttYjD1Y865ysAPfGYCS3vwORsWla5IrrMptxWGaUxZYl53jyCJ4BUFhnemClOiFHXPuGdYYf9nqXybOafHpTeMwa+ccbMfysfJ44St3/Tcl+fWKiNLrpgPolAsIdO82uUwr1abFUkiZmKLlre8XQ28WGcjBeeN+NL7isLoQxu136yIN8MnC30PfwUcZfw46poeAkT0ps68PDSizg8WS0Rz3PXafG1Gxk7f0gogA7+o8gNP2mNKKREKXwBicH6R68qJGHvWgFaC+/3e9H/TZNPsvApryCLVVBFA3yHEfrmNChAGs2yq86V4G/ezIR7bEm5bOuWl4ipydI02gnwhlKsguMNLv4V0/wNSxbZE5NxDuD5zKSUD80rhMTGjCG4EjqFFM2iW5fkf/NLqCUMkEsWg7gTnSvCiwG/ITSa1lvoKThWZJ6LMKBNzIcYXE9uQxyeE0Fd5KUfsA44020BigpkB6Xo69oTMHWnvS1BwGOjADSgWy2wRvyFBafIE/GCLDRp32siU/natkEDsJ9mTlhI5sV+bfRnyjmZbUvuly9acQuuSc1lok1N2AtpVA3bFzVN4N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199015)(36756003)(86362001)(8936002)(5660300002)(7406005)(7416002)(2616005)(186003)(83380400001)(6486002)(6506007)(478600001)(6512007)(26005)(4326008)(66476007)(66556008)(66946007)(38100700002)(41300700001)(54906003)(6916009)(8676002)(316002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mr6wADUZIO9ZIHuBnkb8ucQK60FB++qKD+Lk/5r3CyFVOg0lDZ2hf9KQ2BIj?=
 =?us-ascii?Q?hn6K9DpkcScU9ulG/72sonGGwTSDJNyAjLHn3G3xZPcSHj3qXFUE5X3YrSrV?=
 =?us-ascii?Q?6TWNbExFCFkxiKqGO4xvXHQ4k5BEZvHvAW3Xx5V+hxew+1HKr5JR9t1+dFpc?=
 =?us-ascii?Q?ylBG3+jkAsdyOu7odYYg4/UEJ28h++mGecaWsAvbbiIwQPywnRSoPa34o+XY?=
 =?us-ascii?Q?G7Kgv91E4WOLKKRwBANMw60hktka/o5ralSjJPYJfjXTz+zAScQsfZjZqNSr?=
 =?us-ascii?Q?eqxQnd6Is+f3r0kFlyY7wO8Ce/xBEreNRK7UQ9jqm1W4uYgKQyPvukPo/Zpy?=
 =?us-ascii?Q?WMgKg4z4JSVWl5Q+BMZ6VJMHoR0fzDOnnpbH5OB14dBxVDBjgMsrljKzgkeA?=
 =?us-ascii?Q?Rf+u2FNubdsUDM29aSB/69ghkXCXm0sxxOHuYkQZGjouuOTkio5zKlUs5q57?=
 =?us-ascii?Q?vBxkDb8UuGGv8OqeXXDiqd4dV/mxF7dvOXYITAa1aC6uHNQsHVdwVNwnpdKE?=
 =?us-ascii?Q?ps44xttetNmUx8K8UioXVtdV0lTqm4wDMPUF5Ux9mxao05xnj4UjD76aZpdX?=
 =?us-ascii?Q?RYXm4u5u0MxnltNHrGNnfZyL35tmqWBtgwdTRNkRKLZAA9tFnE4XgpF5EzmU?=
 =?us-ascii?Q?ZOvuL3ezI12MqNWWGCyJ1yMMNsgGLQGe1R/XZqIrIch5UHfxn0KTkwxrVGsB?=
 =?us-ascii?Q?aWHS0uMa2XTeTK5cbK+VReYiR2on5Wu9uoFwkIIu9l33/6CGvqsinoOi7HTY?=
 =?us-ascii?Q?P60zy4aEvt72/xvCMVRzY6iDYRvaNVhiEztFdjQgJVDzyX8X9Z9fTO1l5m0G?=
 =?us-ascii?Q?76L9GgB/toUyXOV/RdsFq/qdLLOyGw2IBiDefWtSN9ASDM2su3zT0LAZjCHE?=
 =?us-ascii?Q?wWFQCQhURoSpZUpGxFjXZkzuDODXTizivl5/+fTRKy5oQnT5w8+2dT39/ijk?=
 =?us-ascii?Q?tN7fupiHrrxWfwjRHk1NO3qflgjfndD9QDzS+qXvk8juLbUXT7EniM2sbwcG?=
 =?us-ascii?Q?5gTSCOshVNmn1vMiyjkChMNxR3kXBoafK2FoDxlwBSk+yYHRPzIJSBlo4LEf?=
 =?us-ascii?Q?H5yhKOKxuj5OUMej9zg+C/alhYfIJ3mlnbmPK9eWf6y0lDreG067qWsiaft8?=
 =?us-ascii?Q?CZ29w6x209neHWqn/jabXZg0+AoH7aoVlhlHf3sNn7d+vbkycp596YfQ8e9t?=
 =?us-ascii?Q?/JNu4KPrGIAqrPSuD+kf+/quVpYvtQ/SVnjC1FRsCDkTs0oYGTAVUnAjD8UE?=
 =?us-ascii?Q?yk6usCwE06vSHQsFT9XGVJK9YPHhxos9Xqkj2D6E4TKpYpjALmJvqBVCmbVn?=
 =?us-ascii?Q?OVNEpp+CbLnmZ+6lt03813RQ7MuXOyHWz7TuxuLnZoWYGwtBruBm/mhuZgw6?=
 =?us-ascii?Q?TKmgOCitXzk9QtaJW0PDIO34oW+PFteuXZh2DKxlEXN37TSVMaXvEJUOFnn7?=
 =?us-ascii?Q?gbgL7qj3ARAItb1wZaJuA366UFvWoLxlNu0qtcfPuae7nsQDlFFk1mjGlKZ8?=
 =?us-ascii?Q?5erxn3/FTeObx54vhIwE2SuWTe3sbMwNjDHAIzW1dBBXZEEotxL5JaW0u5rP?=
 =?us-ascii?Q?lDpwrFokLe1es+uv2s8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ca9691-5aaa-40f9-9a39-08dad0d57c5a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 00:14:16.0900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R60hQ+SX77odyTlRNWLJO64zXHShq/Zz8rdS2Z0NwU+cOJqGMwZjoyX45MjE649M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7628
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Nov 27, 2022 at 10:13:55PM +0100, Eric Auger wrote:
> > +static int iommufd_device_setup_msi(struct iommufd_device *idev,
> > +				    struct iommufd_hw_pagetable *hwpt,
> > +				    phys_addr_t sw_msi_start,
> > +				    unsigned int flags)
> > +{
> > +	int rc;
> > +
> > +	/*
> > +	 * IOMMU_CAP_INTR_REMAP means that the platform is isolating MSI, and it
> rather means that the *IOMMU* implements IRQ remapping.

Not really. The name is a mess, but as it is implemented, it means the
platform is implementing MSI security. How exactly that is done is not
really defined, and it doesn't really belong as an iommu property.
However the security is being created is done in a way that is
transparent to the iommu_domain user.

MSI security means that the originating device (eg the RID for PCI) is
validated when the MSI is processed. RIDs can only use MSIs they are
authorized to use.

It doesn't matter how it is done, if it remapping HW, fancy
iommu_domain tricks, or built into the MSI controller. Set this flag
if the platform is secure and doesn't need the code triggered by
irq_domain_check_msi_remap().

> irq_domain_check_msi_remap() instead means the MSI controller
> implements that functionality (a given device id is able to trigger

Not quite, it means that MSI isolation is available, however it is not
transparent and the iommu_domain user must do the little dance that
follows.

It does not mean the MSI controller implements the security
functionality because it is not set on x86.

Logically on x86 we should consider the remapping logic as part of the
MSI controller even if x86 makes them separated for historical
reasons.

> MSI #n and this #n gets translated into actual MSI #m) So what you
> want is to prevent an assigned device from being able to DMA into an
> MSI doorbell that is not protected by either the IOMMU or the MSI
> controller. If this happens this means the DMA can generate any kind
> of MSI traffic that can jeopardize the host or other VMs

I don't know of any real systems that work like this. ARM standard GIC
uses a shared ITS page, the IOMMU does nothing to provide MSI
security. MSI security is built into the GIC because it validates the
device ID as part of processing the MSI. The IOMMU is only involved
to grant access to the shared ITS page.

Intel is similar, it provides security through the MSI controller's
remapping logic, the only difference is that on Intel the MSI window
is always present in every iommu_domain (becuase it occures before the
IOMMU), and in ARM you have to do the little dance.

Even if the iommu is to be involved it is all hidden from this layer.

> and afterwards resv_msi is checked to see if we need to create the
> so-called msi cookie.  This msi cookie tells the MSI writes are
> translated by the IOMMU and somebody must create a mapping for those
> transactions.

The cookie is always necessary if we are going to use the
non-transparent mode. That is what makes it the non transparent
mode. We have to supply the reserved IOVA range from one part of the
iommu driver to another part.

> > +	 * creates the MSI window by default in the iommu domain. Nothing
> > +	 * further to do.
> > +	 */
> > +	if (device_iommu_capable(idev->dev, IOMMU_CAP_INTR_REMAP))
> > +		return 0;
> > +
> > +	/*
> > +	 * On ARM systems that set the global IRQ_DOMAIN_FLAG_MSI_REMAP every
> > +	 * allocated iommu_domain will block interrupts by default and this
> It sounds there is a confusion between IRQ remapping and the fact MSI
> writes are not bypassed by the IOMMU.

I don't think I'm confused :)

> > +static int iommufd_device_do_attach(struct iommufd_device *idev,
> > +				    struct iommufd_hw_pagetable *hwpt,
> > +				    unsigned int flags)
> > +{
> > +	phys_addr_t sw_msi_start = 0;
> > +	int rc;
> > +
> > +	mutex_lock(&hwpt->devices_lock);
> > +
> > +	/*
> > +	 * Try to upgrade the domain we have, it is an iommu driver bug to
> > +	 * report IOMMU_CAP_ENFORCE_CACHE_COHERENCY but fail
> > +	 * enforce_cache_coherency when there are no devices attached to the
> > +	 * domain.
> > +	 */
> > +	if (idev->enforce_cache_coherency && !hwpt->enforce_cache_coherency) {
> > +		if (hwpt->domain->ops->enforce_cache_coherency)
> > +			hwpt->enforce_cache_coherency =
> > +				hwpt->domain->ops->enforce_cache_coherency(
> > +					hwpt->domain);
> > +		if (!hwpt->enforce_cache_coherency) {
> > +			WARN_ON(list_empty(&hwpt->devices));
> > +			rc = -EINVAL;
> > +			goto out_unlock;
> > +		}
> > +	}
> > +
> > +	rc = iopt_table_enforce_group_resv_regions(&hwpt->ioas->iopt, idev->dev,
> > +						   idev->group, &sw_msi_start);
> > +	if (rc)
> > +		goto out_unlock;
> > +
> so in the case of any IOMMU_RESV_MSI, iommufd_device_setup_msi() will be
> called with *sw_msi_start = 0 which will return -EPERM?
> I don't think this is what we want. In that case I think we want the
> RESV_MSI region to be taken into account as a RESV region but we don't
> need the MSI cookie.

This was sort of sloppy copied from VFIO - we should just delete
it. The is no driver that sets both, and once the platform asserts
irq_domain_check_msi_remap() it is going down the non-transparent path
anyhow and must set a cookie to work. [again the names doesn't make
any sense for the functionality]

Failing with EPERM is probably not so bad since the platform is using
an invalid configuration. I'm kind of inclined to leave this for right
now since it has all be tested and I don't want to make a
regression. But I can try to send a patch to tidy it a bit more, maybe
add an appropriate WARN_ON.

The whole thing is actually backwards. The IOMMU_CAP_INTR_REMAP should
have been some global irq_has_secure_msi() and everything with
interrupt remapping, and ARM should set it.

Then the domain should have had a domain cap
IOMUU_CAP_REQUIRE_MSI_WINDOW_SETUP to do the little dance ARM drivers
need.

And even better would have been to not have the little dance in the
first place, as we don't really need the iommu_domain user to convey
the fixed MSI window from one part of the iommu driver to another.

We may try to fix this up when we get to doing nesting on ARM, or
maybe just leave the confusing sort of working thing as-is. I don't
know.

Jason
