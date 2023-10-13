Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFE07C8CA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 19:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjJMR5N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 13:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMR5L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 13:57:11 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C25783;
        Fri, 13 Oct 2023 10:57:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jg4oczWE+X5MQZMB9UtVYOQOzWNQvNnq+GM7CkRcScDIpLhkbCUqHSlbQ8qYxdfBku5AZrALuj8Gu+SL904AOlZ9S5U66MG5FdrvabSQ2zgNwH9AptSC0WDyx2FOzpXdTj9jx+R42tOP4j0qRWG6QCg5hb8uMS1/FqWC9gmvrh2VrDqx1FsLDqRIXSHBytyxAv9h2YMwZgqz0KRFIXDGBW/LjX3eP0wziMKebWSkOnC+5y3BFKUiF57/Fb5cnvjWM/ggAgJ6jwcfHTJ3HT+t9blfNpXYOAB4qL2XvlqwvPZ+fKNUB6nloToJusKMhOesvt1qfehnjuMkZilqeWSbDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IU7v3bKAag+fXwMeLevyenwh9wI3QSilzimF+wgn0oA=;
 b=ZHh8QPkW4dF1LpeQ2ViOb3kg8wqfsmTVR70VdwjC5JOzb3Q9pegJQ3Kw1BaQ7USbQPF+CD6LCSYAQvv9ddxQJ9bqgVjzWoRwnaCyC1pPG2OqdJublyfjjhPjq4RdBmrOAgAsYcaFkB4+VLqAVJsUN0uet+MZQTfV1/AMqVzI19O/KtCgJluBtIwecYkB6DH26NGzUYXyFF10e4tGSEIAnZHuvB+UhOnjF+jdgTw5FmJkuYnos1PJaH/yyKoagpCT1A9QoGaqrXWObuGcQcUAVwJWh64WkXxUKStlE4z50pmAfnY1jrsn3KmVSb5SsBQPEQxgJaUqPjaPWEF0VnoGjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IU7v3bKAag+fXwMeLevyenwh9wI3QSilzimF+wgn0oA=;
 b=kLDpSAtuVL6WO9B+oTSPT1342xJXgqJuM8MwJ9OHIEey9HG3T5hEO9oZMHDqlFwvoU9V86/hZciwImxYt82+xFJi0MBTKOYAFDTdHf9Y549EiozmkXKxZiuvNaHbRg4L5X9JBIlWtEiPCS3NcRniAI9RQWwjobtgmjbHTWFUlMzQFo4iZOwAUjCsusFGZjDZt9VWVMNzSSRlCE6UvGyNUEk7i+Rr+h0VMzYNv1O6ADp3jaqCpibP1HwlMCP0nJAk62IaZ54CoF1AndBAmsJJxX3Dpuy/uF68rTFN8mxMILvXpD/46GR+hz5PkMIZrELoay2FOUaqSaTijJNUb5TLBA==
Received: from DS7PR03CA0010.namprd03.prod.outlook.com (2603:10b6:5:3b8::15)
 by SA1PR12MB7150.namprd12.prod.outlook.com (2603:10b6:806:2b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 17:57:08 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::a4) by DS7PR03CA0010.outlook.office365.com
 (2603:10b6:5:3b8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 17:57:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 17:57:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 13 Oct
 2023 10:57:01 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 13 Oct 2023 10:57:01 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Fri, 13 Oct 2023 10:57:00 -0700
Date:   Fri, 13 Oct 2023 10:56:58 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Yi Liu <yi.l.liu@intel.com>, <joro@8bytes.org>,
        <alex.williamson@redhat.com>, <kevin.tian@intel.com>,
        <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
        <cohuck@redhat.com>, <eric.auger@redhat.com>,
        <kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
        <peterx@redhat.com>, <jasowang@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>
Subject: Re: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Message-ID: <ZSmE6unIukqJ3GKu@Asurada-Nvidia>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <20231010165844.GQ3952@nvidia.com>
 <03ba68e9-33ef-35c1-5720-8f559f94f8a1@intel.com>
 <20231012133917.GL3952@nvidia.com>
 <3659d9a7-d9e9-bb73-daf5-41c765e99c8c@intel.com>
 <20231013140456.GR3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231013140456.GR3952@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|SA1PR12MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: 386e13bd-37df-4f3f-19ce-08dbcc15d144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5B+cdDL5Xes3XYaArUtr2me7OKXjwxXEsEycebXJge/1cTEsE6c7+akRVxr299qrPlq1d7UAaW2shDxHOjx4y5rfWY/5HoAbjGD0uR+5qFt4U0eIVU05xmRhD8zEsaCzUUFYItN6Z/Lyztrg3Nco9XlHZtnZ+TC00PnNaTWo1CSdZhDz6pYi++z5b7BlGp5S+IfAK+bya4Hf0HA6m2QIlJcWuXdnCkEranVlFKSgMYYf60b8YXsQIVudfYaAGwt9LvIcHsOzcAkJP4H4Yn+0huJAS5UQnhlXp/kmTRPzEFf7t4GuPDmubRIzvsjsrGWKl0TgEW2C0YE4JeEBAyqsxSs7gllVUIRGJuIJi0ECrilfPgtVdR1416gNHX4oHw/M7HtMknTmSsP5n8mFUBTJr/5zO3fVA8b2X2QLm3Xy8xCDLRxnfTlWBVAT5coU3K5O6ni4oCkTmmFALdaszeUduFk9/NCNZ5meNFBfdPwe59y0cHRzhsJWssKuxMBMSMmFPxcPs1bRzcGxoyzVw8QfyI9Al27Zpm/+IGE3I3ChUNvBjBWvGywYvQVZDffDf3wXIH4+YuLvnJ+y2/cifEAU7IUaIlxmPJBGMVi9KNweGzdUvuYn0AXgxVC8ryWDKtnSDWOatLfBDwdVSEwQBW3VRH/UaqMQX2WnIU6+U2vSWLfFQyET8QO5XXc54a9AHqgQfF0bEMMXU6uBxBCOPlfEjxRuDL2B3WSEMspJZo1aQHvQrQN/XjN+MNr1Jt6SQD+f
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(451199024)(186009)(1800799009)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(55016003)(8676002)(8936002)(4326008)(6862004)(41300700001)(40460700003)(5660300002)(7416002)(2906002)(47076005)(86362001)(83380400001)(33716001)(356005)(7636003)(36860700001)(336012)(426003)(26005)(40480700001)(6636002)(82740400003)(316002)(478600001)(70206006)(70586007)(54906003)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 17:57:07.8931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 386e13bd-37df-4f3f-19ce-08dbcc15d144
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7150
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 13, 2023 at 11:04:56AM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 13, 2023 at 12:33:13PM +0800, Yi Liu wrote:
> 
> > not really. Below the users of the struct iommu_user_data in my current
> > iommufd_nesting branch. Only the domain_alloc_user op has type as there
> > can be multiple vendor specific alloc data types. Basically, I'm ok to
> > make the change you suggested, just not sure if it is good to add type
> > as it is only needed by one path.
> 
> I don't think we should ever have an opaque data blob without a type
> tag..

I can add those "missing" data types, and then a driver will be
responsible for sanitizing the type along with the data_len.

I notice that the enum iommu_hwpt_data_type in the posted patch
is confined to the alloc_user uAPI. Perhaps we should share it
with invalidate too:

/**
 * enum iommu_hwpt_data_type - IOMMU HWPT Data Type
 * @IOMMU_HWPT_DATA_NONE: no data
 * @IOMMU_HWPT_DATA_VTD_S1: Intel VT-d stage-1 page table
 * @IOMMU_HWPT_DATA_ARM_SMMUV3: ARM SMMUv3 Context Descriptor Table
 */
enum iommu_hwpt_data_type {
	IOMMU_HWPT_DATA_NONE,
	IOMMU_HWPT_DATA_VTD_S1,
	IOMMU_HWPT_DATA_ARM_SMMUV3,
};

Though inevitably we'd have to define a separate data group for
things like set_dev_data that is related to idev v.s. hwpt:

// IOMMU_DEV_DATA_TYPE sounds like an IOMMU device, other than a
// passthrough device, so renaming to "_IDEV_" here. And perhaps
// "set_dev_data" could be "set_idev_data" too? Any better name?

/**
 * enum iommu_idev_data_type - Data Type for a Device behind an IOMMU
 * @IOMMU_IDEV_DATA_NONE: no data
 * @IOMMU_IDEV_DATA_ARM_SMMUV3: ARM SMMUv3 specific device data
 */
enum iommu_idev_data_type {
	IOMMU_IDEV_DATA_NONE,
	IOMMU_IDEV_DATA_ARM_SMMUV3,
};

/**
 * struct iommu_idev_data_arm_smmuv3 - ARM SMMUv3 specific device data
 * @sid: The Stream ID that is assigned in the user space
 *
 * The SMMUv3 specific user space data for a device that is behind an SMMU HW.
 * The guest-level user data should be linked to the host-level kernel data,
 * which will be used by user space cache invalidation commands.
 */
struct iommu_idev_data_arm_smmuv3 {
	__u32 sid;
};

/**
 * struct iommu_set_idev_data - ioctl(IOMMU_SET_IDEV_DATA)
 * @size: sizeof(struct iommu_set_idev_data)
 * @dev_id: The device to set an iommu specific device data
 * @data_uptr: User pointer of the device user data
 * @data_len: Length of the device user data
 *
 * The device data must be unset using ioctl(IOMMU_UNSET_IDEV_DATA), before
 * another ioctl(IOMMU_SET_IDEV_DATA) call or before the device itself gets
 * unbind'd from the iommufd context.
 */
struct iommu_set_idev_data {
	__u32 size;
	__u32 dev_id;
	__aligned_u64 data_uptr;
	__u32 data_len;
};

Thanks
Nic
