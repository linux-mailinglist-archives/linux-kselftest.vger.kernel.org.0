Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50126BDFE6
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Mar 2023 05:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjCQECY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Mar 2023 00:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjCQECW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Mar 2023 00:02:22 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6A837B64;
        Thu, 16 Mar 2023 21:02:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIvWfsh+H+v5RAO4Q+p0uzarkImwch8b85g1b5CKli6tQqh68kUoy0ICW7Cx6OlD18rFMWPM6tQSDChRmjvR4hnYqwvf+AZ0C4OULcxfX6kpdHcy3jHJm5rleJOMSko+0+yJ4wg2eUCFyYeg0CJiY+wo1D+jjumy0rR5gsYgzwliId2Sit7kQ959ZDxfAjGAg7Yq1gnkVBt/bobqjfIAmFR58KluU6zLanguEWZrEG+6g6XPkx6P/5Ko47lyf+7AtJulHP8/xomIwLfUN7W83ne+l7dTqWCMbsQ3H67iINleUFH1i5aGYMFaVoQBHMsGTLpW98LtDdHFO2tprGvlSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKvx0kGn1ZCmtDU7tLF24u0S88w74lvM7wQ+loXc66I=;
 b=ZR88gsX85TdxXTVgqMxU+pGciQlo2n0FuBsOwSvajb2ToKAE6/DxzZYdDVppsZ5fop/QMwS9J8HAiajKMhX6drIaa4begaT8DdX53huumn2KEqPYqVWEYVg8xZhpH9efCqzy1n2f+VnaunpXm962SNv/DI1icqYc+sxlYenUGeArS4+NycAzMOASrSCI5wQUsKhcp6fVnEIFGvuPGeW58qG+rPshxk8lMYqNW5PbR4VmEEqu74ewDIFnkY9Fj1vSh7Vlju+Vn9KoOttYRImTL8w1ahuwHtNpb0wWD1bDblAV5UWBP+0ZQCsOD1MOGFcqqKZlv+Ar/FTSfsg+yb8atQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKvx0kGn1ZCmtDU7tLF24u0S88w74lvM7wQ+loXc66I=;
 b=Fh5LpEJqvqRk24qykiWKjOWf4MtacSIRgiQn/cNna9mu3mMEr5rcpC50rl0Dh/whzNAUNtoED1Jpz2HWOCQS1LAGpa0CCs8E/IdWBxNchLjjMAqDCf3Oa3iPJygz/bwNTefifeqHjrPkLTgHDQkkmlLPPxEVtO8WQfBRPpKaQPtXyblnHRCK1+zMgi8xe8KNuOR+ePlRCzauIDQED0xR3YLl4rTa3WXBr8EJ123Q680bpmwfoUOUZxbYMcpN8D87B3yIWDOMMrXcTO5PzQciq/q9sDe2Az9U3i2oKaMS9p9dxIK9s3dscJ2MmQCw4ybGgOp8T6QYelaUM0rYisrLCw==
Received: from BN9PR03CA0570.namprd03.prod.outlook.com (2603:10b6:408:138::35)
 by CY5PR12MB6155.namprd12.prod.outlook.com (2603:10b6:930:25::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Fri, 17 Mar
 2023 04:02:18 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::4c) by BN9PR03CA0570.outlook.office365.com
 (2603:10b6:408:138::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33 via Frontend
 Transport; Fri, 17 Mar 2023 04:02:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6199.18 via Frontend Transport; Fri, 17 Mar 2023 04:02:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 16 Mar 2023
 21:02:06 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 16 Mar 2023 21:02:06 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Thu, 16 Mar 2023 21:02:06 -0700
Date:   Thu, 16 Mar 2023 21:02:04 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 12/14] iommufd: Add IOMMU_HWPT_ALLOC
Message-ID: <ZBPmPODkv72aDQ4R@Asurada-Nvidia>
References: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <12-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB5276AD6D42FA8FEFE3B69C878CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276AD6D42FA8FEFE3B69C878CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|CY5PR12MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b3d45c9-7480-4d53-4011-08db269c6663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s+ewrtHVJC3vrHbdsVf/XNtrILaK2Jq37rZCaJereNP/eXSg3VslZez6wsXPda0jQfC5zfNx1+AdzL6xUqR1Kp2SPjlAoXFbE5pGAmhQDzgORWAZQ7luVH44VWKkKXY/L/wl5/4cHdXWpv0QAObtLeJuBF1igc5NXxd2cj5CEozJ+RvS5IYqPK19qx6fTZBxCLFP0YehfSs+M00dutKMF14RYBCr7gsXgkX4sj45xljvGlC8rTIf1qc5sNDfMdF9ENNap440llIJPnBtYtBw3p7ryDmtXd6pkQQmyyuNS+Tz6sa9t/6LENxDcdxK/vRjEK0CgVBZRM16XRNKCQFILinrj+JsrIGTY4PczUiFpr5PvmA98BNUwXUeuFacbeqygyZqu2spNPT7ymscC6kU0JI+P6Bfd24py3apIqN17yeVpW2mJ2LsQxTSlwIVphPUP0e/Qv+sr1N+AApZlNx1eXLgyfjb5wm+dPTwFO4braCQ4b0nRg7wU/eCGxhg2CeHInXPf0IwKlR8seZViP8yozUUNJU3IjpZt5kupndZ32YvIcN6+2LtJZY+NvHJHYMFkU1fh7gM3GU0u5GzEea0DSqnrn6veihWgRT2OVQC0mgxz5C3izSuinl4Liyugs1BL8I3V46J3Khqzsf/0TQL9G8vHnt89TLJihEjY+Gu4Y0tTf44KSfC3QWXolsbLt8tXBX3/QfjE0ne5OpIcez5hCLwXObqm0igNcl0tM9XUrK+eqm9lFCZnPWqVdnen0Q+
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(40460700003)(356005)(41300700001)(426003)(4326008)(8676002)(70206006)(47076005)(70586007)(8936002)(186003)(5660300002)(26005)(54906003)(110136005)(336012)(316002)(478600001)(40480700001)(55016003)(9686003)(33716001)(82740400003)(2906002)(36860700001)(7636003)(86362001)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 04:02:17.5560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3d45c9-7480-4d53-4011-08db269c6663
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6155
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 17, 2023 at 03:02:26AM +0000, Tian, Kevin wrote:

> > +/**
> > + * struct iommu_hwpt_alloc - ioctl(IOMMU_HWPT_ALLOC)
> > + * @size: sizeof(struct iommu_hwpt_alloc)
> > + * @flags: Must be 0
> > + * @dev_id: The device to allocate this HWPT for
> > + * @pt_id: The IOAS to connect this HWPT to
> > + * @out_hwpt_id: The ID of the new HWPT
> > + * @__reserved: Must be 0
> > + *
> > + * Explicitly allocate a hardware page table object. This is the same object
> > + * type that is returned by iommufd_device_attach() and represents the
> > + * underlying iommu driver's iommu_domain kernel object.
> > + *
> > + * A normal HWPT will be created with the mappings from the given IOAS.
> > + */
> 
> 'normal' is a confusing word in this context.

Yea, Eric was asking about a related question in another thread,
because he couldn't get this part. I think we could replace this
"normal" with just "kernel-managed", so eventually it would look
like the following narrative after adding user_data and nesting:

 * A kernel-managed HWPT will be created with the mappings from the given IOAS.
 * The @data_type for its allocation can be set to IOMMU_HWPT_TYPE_DEFAULT, or
 * another type (being listed below) to customize the allocation.
 *
 * A user-managed HWPT will be created from a given parent HWPT via @pt_id, in
 * which the parent HWPT must be allocated previously via the same ioctl from a
 * given IOAS. The @data_type must not be set to IOMMU_HWPT_TYPE_DEFAULT but a
 * pre-defined type corresponding to the underlying IOMMU hardware.

Thanks
Nic
