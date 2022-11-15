Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13BC628EB6
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 01:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbiKOAwk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 19:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiKOAwj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 19:52:39 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A2E6157;
        Mon, 14 Nov 2022 16:52:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oB8Ua7bYMluq+dkYPCngpArJQYb2QbJDAXwshCxVS3eFPG5MUYulSuRPO/+2Liw4ZhhWunyzOD2Z7LcD0IPXyaU6L2kDRUcYzpBz2ynkKthExZtHW9ODm/fSAREl14xMxSycx4sNeybe0h6utWpXHgkdmwo11urv8r7xOgjjo2o5jfYQqqDGvIG0ssh0pJfzEB/WFEyTidrNh+mcZ53C9Le/CAT9LSZItxj4fso9V8ry0mpjKYbmpSYUPrOrJUmlpRc8jp4BHv/+SgVW8wdzYAvxL/7yv11wUrr6sRqArWy/xc+NDvXklB/LSPOg1wqtRKgRLji5XcG6lsd7RICgyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERcrVkbRNWcTDdJVbeiWeqx6yiKW4Oo81fybRK0s49k=;
 b=SwzsfBd9ERVImRIhgFFOumm/7LYvUJtNGmd1ihX4NT89V9XG2jeWHkrbHyRyLyvY2vrTvNJG3Jczianj4exJSxtBDvElk67wyF5olkVU9AqsVkHVYj5AF2/e4UuDZSrmqXIfynUIJcfxDABGxU6lnb6hs1SGqR2K/7GqeVIZ2TbCago37X8+3Z7S2uiK/pXDnClXLGQL90utvGXKRV1xuBKpGmwFOBm6MfBMjGFAPl+tzhrBzGk5jy4z9Fofd6kv2gH72vo0BRNe1Bu7KlJuYnlwXaoXjKlc+jtZWXQo/CnMESp7HnI/FV+eEwxopI4TipxQ8dwAksGRYpL7IyUYXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERcrVkbRNWcTDdJVbeiWeqx6yiKW4Oo81fybRK0s49k=;
 b=s8nznz4dQlQa2M1kz1vEwx5hp/rAQRWFYBN3E8lB2dgYmnxMuNUyFf5GJV9+0VAiYATWGdRR5+LttXn8i5eCoADcusjMnhnHYjN4lDhwkUI4PozVZttDk8DF2FC/Bqm/0L06VpbCVbtYO3M9TZqVSv+kxo0KGQ2PV1JVghja54h7VaoWDaasNnVMNllb1veIUAclH0tnj7gubTa3NPzfOPvf409v723tBDcJadV/MMOt1AX9K5kjduotCuaak/usb42j7AGqjNzux9yUXduyheYh9fLH4id+asMqsCadD0Y42LI26n0/FVfWuizVnlpg4JCRQcKLUAf5/5HAVojhbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4874.namprd12.prod.outlook.com (2603:10b6:610:64::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 00:52:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 00:52:36 +0000
Date:   Mon, 14 Nov 2022 20:52:34 -0400
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
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v4 04/17] iommufd: Document overview of iommufd
Message-ID: <Y3Li0kKC76gk/J6x@nvidia.com>
References: <4-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <eef35bbc-f977-3e0d-60ac-5b0a0a30894f@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eef35bbc-f977-3e0d-60ac-5b0a0a30894f@redhat.com>
X-ClientProxiedBy: MN2PR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:208:236::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4874:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fab4dfe-f4f4-4f64-a48e-08dac6a3afdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LW1ikPgAJVHJo3JvWQR/Y9cW6gX6OB4zBl2jJpnrDXkd4c6Zlgc+1WBuYXxaB+zGB7cVB6JEVxTlKhlvm+AiFOVBGYFjGixZS+BHsIlwFIgEOZwfXUcwIWxpt/H3tuEP8v0Jvr/Jv0xffxDJgS1SQtHQNec9E2re5s65BiDVz8PdvtzIH3GyXqKjJXbE6aTunAVOtVdhMtSsdg6uEoMbLLznS28A6pAMo3e8iKTiV6l8bP2M5V7f6vXp1jHFZN8TMvnKxY3j27yvo7hnstAyRDQXVkPM+6N+ZpJc17NQLnCi2D4dS2WEvmouuKmUsBimQOrkByw1lMBNNd49LMfDZoNFKPo5K8kZoqs2f10d+SW1Aar19sofcEVuf2Wr1De8ds7+N7YPC/OETY+ztM3UkLdCksgmcwucictAjVvk64U65xG4eHMacesAPkcAqGIcP9alVJ6aMUP99eB9VxnUE0yHF6DFKZDPi2SdijN00yFtJ2nd5Q4md1wtYwvPz8IeEDSISPr3ApcDq2bMZnX8vAnJkwgwHFGqwAOR/SV+M7RwFp3SoUcXV0WYI6Z3IkJD3Jsjoqts6KR73+GlUETAdtmXRIRZQhsOZGDcoVaxFF00YtvEJsRv+mBne+2R+krJgtSLgOCzXJh6iZ0H+JF2BLtbZb+3q7hmrwx7XSRmBrHXxmy7ClnSYr9v7tayn2/CTnYdHKd+wpLDnNeTEIkU8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199015)(86362001)(36756003)(2906002)(7416002)(7406005)(8936002)(83380400001)(2616005)(186003)(38100700002)(316002)(54906003)(6916009)(6486002)(478600001)(8676002)(66946007)(4326008)(41300700001)(66556008)(66476007)(6512007)(6506007)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZnOQzd+N/46o1UtXtBxmVrburJiOda+ZKHmrNxruY/JJWDLgbXJIQhQsYYhf?=
 =?us-ascii?Q?OUieDnVshDb23ehXOoZDa3f8WGdVGGLp6qYBn7kq4rwFddyMh0Gsj+yOhHSw?=
 =?us-ascii?Q?g2xv+NdM8Gg9jGZNLC7BtowjXMz8pqNPfcmLJrgFXizjcpos4lpmD6kcm9rz?=
 =?us-ascii?Q?/rtm22s/BoiRChsu61nrjsTG7bOdckeThpXmvj1CCPigDSxR9oxwvCV01bi0?=
 =?us-ascii?Q?KtRVKQBeATq5yy6jHxQ6ahzitiZuN7Voq5jNuX5LLDPObVzUkvxrOmX2/rJx?=
 =?us-ascii?Q?vAiAmE+JBJ92F7OzuatYWQM+AsigmuSsTmWBq872c5Nikt9TuSeTCkUeDRcj?=
 =?us-ascii?Q?BWSLJ1x8cwBd2e+R7pNGi2pLs26VS0lEO0ZY0Fojo/i7E43GFcpOkdRH3iBO?=
 =?us-ascii?Q?MjS3mUmM1LVSQyKrrNMvjZZddyhUZnmUBNUzs+spqOj3+BJxdxAIGoMIP/Rr?=
 =?us-ascii?Q?z9stAL0PQnIwetIY2zclXLPc2X3inffigJcwXDsxanxq+6FPygzdQSdSV/qu?=
 =?us-ascii?Q?QFPlk3t7Qg/zJhxXjgVa/rkALnr0svWM3ZH7uGDST+xvEzfNpU2yUx7SyerG?=
 =?us-ascii?Q?JeWqdvkNAxgN/wRNOWegFvVJYtDZuTcIZSD49u56aLNkk2BL1KHwHHpRFg4C?=
 =?us-ascii?Q?k4+/cO/uaEs/wHCVmywX0C8lQQTSkKztmH3aiA/A3/wpYd2Xr4j3CkeXQaHP?=
 =?us-ascii?Q?C3nuq9wmu023aNuthkTo6KPj2JeJIcyVvOVbp1039ZOhxgCtFvFHh9oDf92k?=
 =?us-ascii?Q?1peecT9OIK4Zs9A1koPiIWENjhpVVGjtBZ1SKcpXAb/AcDmTYE2rpflxHoU6?=
 =?us-ascii?Q?f5fRBWWWZ2ZJUzrJQjHDzYJohd5vFkQpYmUc8jfPnu3/bjeTmH50ZIA6xtsD?=
 =?us-ascii?Q?N6RgCLVRwEyMnNRSDIihov1CzXHkFPN4T6zZH856D5196/MM/OOvFztpH+iT?=
 =?us-ascii?Q?6/fRh2VyLXB3pYmocpBs5UXUI7BuSeOuoGq08sGy9dqkGfPNmFs7OU9e75mk?=
 =?us-ascii?Q?NrvjzBL527/cK45S9gEJkmQtyEQ8BuqFyrtZSKtO+y5WvJv7VDgTCXoyqRdN?=
 =?us-ascii?Q?KhBtpEHLAdOt24OmUxNcldueS9/hUsVpsJ+eSi8ArcBNOdRdbvuE1JBL6T8Y?=
 =?us-ascii?Q?rl8ez86kb5P25dNPB6DfxWBqF6mHwheQpkSC6LHuf+dt+/o8cR/mSOvaXusE?=
 =?us-ascii?Q?tKzAHntp5DmF88pxeZiIB8JdOUbYNfnOWXGHC8FFSZIsvyq/gikJacurCajY?=
 =?us-ascii?Q?P+AlZ+uwW8ioM7bh03EfRX9BQkE9C0JokBQ+rIS34mzDNQb6+QlbvrmUFSFN?=
 =?us-ascii?Q?NiTKnggBksrfLt02c0SRPmG6N9ISPCq9mBeZU1+Sj0G9E+0sk0frJ64s26Yr?=
 =?us-ascii?Q?MoZOEvTZHbpaoABFLRUQku21wwoGHT/M7QwpJVGSJYIA29S7bQFAzHAfD1vQ?=
 =?us-ascii?Q?EZ85se+3TCLZ4oC3s3qAbUnjMaUrePim5f6yQwM3QsVuH3N7bpxNSfYPe1R9?=
 =?us-ascii?Q?kDpflS2R4EqVvbgtXq8q3zug2eZKkcNTItK7NS0wWXG9CoBKXmp4sDvCGzuR?=
 =?us-ascii?Q?aXMIKXfebR/nJ0VRwsM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fab4dfe-f4f4-4f64-a48e-08dac6a3afdc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 00:52:36.1613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfZljzU2xcYto54E8UQWNSwe6QnRzAiZAb66cEsnoQtzkKgZskzn0XhuCcEuzRu+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4874
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 14, 2022 at 09:50:56PM +0100, Eric Auger wrote:

> > +IOMMUFD is the user API to control the IOMMU subsystem as it relates to managing
> > +IO page tables from userspace using file descriptors. It intends to be general
> > +and consumable by any driver that wants to expose DMA to userspace. These
> > +drivers are eventually expected to deprecate any internal IOMMU logic if exists
> they may already/historically implement (eg. vfio_iommu_type1.c)?

Done

> > +2. IOMMUFD_OBJ_DEVICE is created when an external driver calls the IOMMUFD kAPI
> > +   to bind a device to an iommufd. The driver is expected to implement proper a
> s/proper/properly?
> > +   set of ioctls to allow userspace to initiate the binding operation.
> > +   Successful completion of this operation establishes the desired DMA ownership
> > +   over the device. The driver must also set the driver_managed_dma flag and
> > +   must not touch the device until this operation succeeds.

I don't know what this was suppose to say, lets delete the word proper

> > +3. IOMMUFD_OBJ_HW_PAGETABLE is created when an external driver calls the IOMMUFD
> > +   kAPI to attach a bound device to an IOAS. Similarly the external driver uAPI
> > +   allows userspace to initiate the attaching operation. If a compatible
> > +   pagetable already exists then it is reused for the attachment. Otherwise a
> > +   new pagetable object and iommu_domain is created. Successful completion of
> > +   this operation sets up the linkages among IOAS, device and iommu_domain. Once
> > +   this completes the device could do DMA.
> > +
> > +   Every iommu_domain inside the IOAS is also represented to userspace as a
> > +   HW_PAGETABLE object.
> > +
> > +   .. note::
> > +
> > +      Future IOMMUFD updates will provide an API to create and manipulate the
> > +      HW_PAGETABLE directly.
> > +
> > +A device can only bind to an iommufd due to DMA ownership claim and attach to at
> > +most one IOAS object (no support of PASID yet).
> > +
> > +Currently only PCI device is allowed to use IOMMUFD.
> is it still true? device_bind() now takes a struct device *
> 
> In [PATCH v4 12/17] iommufd: Add kAPI toward external drivers for
> physical devices "PCI" is used at several places
> but shouldn't it be removed now?

Right, gone

> > +- struct io_pagetable holding the IOVA map
> > +- struct iopt_areas representing populated portions of IOVA
> > +- struct iopt_pages representing the storage of PFNs
> > +- struct iommu_domain representing the IO page table in the IOMMU
> > +- struct iopt_pages_access representing in-kernel users of PFNs
> > +- struct xarray pinned_pfns holding a list of pages pinned by in-kernel users
> > +
> > +Each iopt_pages represents a logical linear array of full PFNs. The PFNs are
> > +ultimately derived from userspave VAs via an mm_struct. Once they have been
> > +pinned the PFN is stored in IOPTEs of an iommu_domain or inside the pinned_pages
> s/is/are

Ah it should be "Once they have been pinned the PFNs are stored in
IOPTEs" as the whole thing is refering to plural PFNs

Thanks,
Jason
