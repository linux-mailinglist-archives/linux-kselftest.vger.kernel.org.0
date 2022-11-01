Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A35615353
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 21:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiKAUcm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 16:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiKAUcl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 16:32:41 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FDB1EC42;
        Tue,  1 Nov 2022 13:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuJ9v9OEGAzlUSnrklz0+OLYv+1JBGkpvoGmohQ7AOVKuTZ0a2LnUIHL+320v5JzqpX+nHwVy1p8DZRWUhjIVx4FmgtmUZan7dSRgOnqIJ46Au+fFuSjyHssTOsNvEaK62c5APWDMqcwyxnZam1+OAS2455uo8bpA8SzgjrMSqjw4VP43XzyhBnxhsgGWwm5FR+LyKiZKIdCn6P+648s+sRjhGtouEbFUxCX0+Rl/f6VldByHOkDGSYh0mLnUQV0o4lzcAEBVZz07wJBDHd6NcylSU+F/D1mWkjF0IGIL/22GFfZjm41yBKLbyRqr7DmrKtcMEsMVr+iXbt+lG4Mgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhrfeWVVzZJfNMwypps4ZFKS7siOUekN0581LcP+KMo=;
 b=Eu6g2pQnJrL6pEEzvi7GoVJiALSmYVZwjJEd3yCrVQf4KiKCwAPG5eHxNWUng3UM/oxlQjq1x03VW/cjJu9Z3ScxDlwdmJSdhIn0AiYbJH9KBruPvbHEFtud+v9HrPH0fvGgSciReUVbTWzM98Htf573Dmo6dvssA44ykeF9XD2/vLNNdeh4Jd5SyHWAyHv8A4CISBnVay76a9cnBPuc7/GJnEifbkLg/OFrcF8wcbRf+JB1bLFXxK/0YVGBtIi0JNi4b8uG0ou/jclTnSSo2D7AB6J67F6Kmtk7yKyi9FM+Yv9QOTQmNhuIUmZYWfPP/lnu6G4//YB7HNDH5caQ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhrfeWVVzZJfNMwypps4ZFKS7siOUekN0581LcP+KMo=;
 b=Z/VkaOoLSY/sEAyRL9C3lsdtaurVRc6C3VzW1TjeCV55JK+kFSsZL0D9HThE5/nAqAJxCvuSIA1YhaKLTBaA2S1AyYBqUjO5jjh3CyULah0Vsv43BXZiBWwHPmYiY6/ZdstjMVCOs0e+cqzVcDXIQtRlWPLFpM3c4WYP2i+RYrZQlsBmcbgp0TR7Si2eae8jkMKBN+6q3BF7JV1GhBU4igIpSROJ7a0uDFKOiv7i2qpiVIXfS8BMXSl/dR70CgAGEiIr4cx51/j9l89WAgB2D91jcR7ovRaOFli0NH5EFMdiLn+ZPTaqscQNuuMU46Emv6337/SOGrSSTAqmQBxHFw==
Received: from DS7PR03CA0187.namprd03.prod.outlook.com (2603:10b6:5:3b6::12)
 by MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 20:32:37 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::a8) by DS7PR03CA0187.outlook.office365.com
 (2603:10b6:5:3b6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Tue, 1 Nov 2022 20:32:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Tue, 1 Nov 2022 20:32:37 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 1 Nov 2022
 13:32:27 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 1 Nov 2022
 13:32:27 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Tue, 1 Nov 2022 13:32:25 -0700
Date:   Tue, 1 Nov 2022 13:32:23 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Lu Baolu <baolu.lu@linux.intel.com>, <bpf@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, <linux-doc@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <llvm@lists.linux.dev>,
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
        "Jason Wang" <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        <kvm@vger.kernel.org>, "Matthew Rosato" <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Keqian Zhu" <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 15/15] iommufd: Add a selftest
Message-ID: <Y2GCV97lxEGwAuo6@Asurada-Nvidia>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <15-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <15-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT050:EE_|MN0PR12MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: d969627f-c6ef-4dec-bdc7-08dabc483721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sFkmhEzKXLHfDSjsHaV65vS2fGRtZVIigBccLL70jYLYqL3dZawR8hZTgSUb+x+ffTjsCpmNnDbt4HDLSVjt9XYKu7S12FWUNyMr2jI3OVpI/1H7/Ij/uPtc1juj+2eZVRUhhdpFoVeoW8lT43CCrvJppPnkA92OXuLJFXgC5RD+BmPvTe4+OuGtws6FiV9vdLbLWYkxqurg/7W2jpMdTOoZauDauMbR9O9LI8bXRig5l4tcqvFoXwhvqci6NFikWbNlteSHC0+zlw3GnhPojnb1q61ffMejCb3W+5AFZptx2JwcFuwTx7Y3WhLHu75O1cHZzHfATrUStPQkq5cw7g9ACeLay851LUAahpG1G4EgPV6+8waOeCZkagHPUElsmA0nz3JPEEGorigy4V4UmTEX0xtp201hy27TuapgX0tZMRiL2N0zBTRA+pF+hwUaCQsnOOvN232Jtx8cDIgUDrJwcTpKFGs8VBQ5QhO30bWi1QkAta21Z3iHQ1qUczTAD87rWxyhC5238KRJVTgUtvmlaLhoiQDUHyNyN+rKt2Pth2Jm8ZbAYyHqM6rubyB7iTMuNrcTf3aH6h+Mhb9/RKLjMYmeOaJiYCbdGc4sWTupcitOpS8YmaDa5kWKWK5HTA749DRLqSRrWW2lTGRgbeBa8Aq81Vyz7dhgjfc5rWVACgZo+/+doKr4F3bPv1jfg+yhHlzeAbF6zzPVLWfJov1ta+HiV4FI2OgL5BnxlnXwffEsAQSGliSR4DuwiEqg8Y6WtnImh1xaviddA1p5eQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(316002)(47076005)(33716001)(9686003)(83380400001)(186003)(426003)(336012)(55016003)(86362001)(40480700001)(4326008)(8676002)(70586007)(70206006)(356005)(82310400005)(82740400003)(36860700001)(7636003)(26005)(8936002)(2906002)(6862004)(6636002)(7406005)(7416002)(5660300002)(40460700003)(41300700001)(54906003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 20:32:37.3409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d969627f-c6ef-4dec-bdc7-08dabc483721
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 25, 2022 at 03:12:24PM -0300, Jason Gunthorpe wrote:
 
> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c

> +static inline struct iommufd_hw_pagetable *
> +get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
> +		 struct mock_iommu_domain **mock)
> +{
> +	struct iommufd_hw_pagetable *hwpt;
> +	struct iommufd_object *obj;
> +
> +	obj = iommufd_get_object(ucmd->ictx, mockpt_id,
> +				 IOMMUFD_OBJ_HW_PAGETABLE);
> +	if (IS_ERR(obj))
> +		return ERR_CAST(obj);
> +	hwpt = container_of(obj, struct iommufd_hw_pagetable, obj);
> +	if (hwpt->domain->ops != mock_ops.default_domain_ops) {
> +		return ERR_PTR(-EINVAL);
> +		iommufd_put_object(&hwpt->obj);

Coverity reports that return is placed before iommufd_put_object.

> +static int iommufd_test_access_pages(struct iommufd_ucmd *ucmd,
> +				     unsigned int access_id, unsigned long iova,
> +				     size_t length, void __user *uptr,
> +				     u32 flags)
> +{
> +	struct iommu_test_cmd *cmd = ucmd->cmd;
> +	struct selftest_access_item *item;
> +	struct selftest_access *staccess;
> +	struct page **pages;
> +	size_t npages;
> +	int rc;
> +
> +	if (flags & ~MOCK_FLAGS_ACCESS_WRITE)
> +		return -EOPNOTSUPP;
> +
> +	staccess = iommufd_access_get(access_id);
> +	if (IS_ERR(staccess))
> +		return PTR_ERR(staccess);
> +
> +	npages = (ALIGN(iova + length, PAGE_SIZE) -
> +		  ALIGN_DOWN(iova, PAGE_SIZE)) /
> +		 PAGE_SIZE;
> +	pages = kvcalloc(npages, sizeof(*pages), GFP_KERNEL_ACCOUNT);
> +	if (!pages) {
> +		rc = -ENOMEM;
> +		goto out_put;
> +	}
> +
> +	rc = iommufd_access_pin_pages(staccess->access, iova, length, pages,
> +				      flags & MOCK_FLAGS_ACCESS_WRITE);
> +	if (rc)
> +		goto out_free_pages;
> +
> +	rc = iommufd_test_check_pages(
> +		uptr - (iova - ALIGN_DOWN(iova, PAGE_SIZE)), pages, npages);
> +	if (rc)
> +		goto out_unaccess;
> +
> +	item = kzalloc(sizeof(*item), GFP_KERNEL_ACCOUNT);
> +	if (!item) {
> +		rc = -ENOMEM;
> +		goto out_unaccess;
> +	}
> +
> +	item->iova = iova;
> +	item->length = length;
> +	spin_lock(&staccess->lock);
> +	item->id = staccess->next_id++;
> +	list_add_tail(&item->items_elm, &staccess->items);
> +	spin_unlock(&staccess->lock);
> +
> +	cmd->access_pages.out_access_item_id = item->id;
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +	if (rc)
> +		goto out_free_item;
> +	goto out_free_pages;
> +
> +out_free_item:
> +	spin_lock(&staccess->lock);
> +	list_del(&item->items_elm);
> +	spin_unlock(&staccess->lock);
> +	kfree(item);
> +out_unaccess:
> +	iommufd_access_unpin_pages(staccess->access, iova, length);
> +out_free_pages:
> +	kvfree(pages);

Coverity reports a double free here, call trace:

[jumped from] rc = iommufd_access_pin_pages(..., pages, ...);
	[in which] iopt_pages_add_access(..., out_pages, ...);
		[then] iopt_pages_fill_xarray(..., out_pages);
			[then] iopt_pages_fill_from_mm(..., out_pages);
				[then] user->upages = out_pages + ...;
				       pfn_reader_user_pin(user, ...);
					[then] kfree(user->upages);
					       return -EFAULT;

Should be the same potential issue in the other email.
