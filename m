Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82606CAF57
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 22:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjC0UGC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 16:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjC0UGB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 16:06:01 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE5A1718;
        Mon, 27 Mar 2023 13:05:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPbZlOwViDFxSE0i/9Alb5exw69CSEj3WYMIfG5MrUgDEmObOpRxHOIus3kwL1iqqG96rFpSUTBcJActgAiIEjUu/68efUccQ/C82fRXeKpsFfHHhHEDflXBrkbtUlHtEuc2PLegwvCZACZOUW5sm+l4MZVhI381dvm5JwyP/se2+uuViREOlNsODkHSapde2l+S3eIwvySPYoQvovjmZWIrYaOWKrjVFmP4H6lqSxGg4fd2N2H/jCwK0RkAKR5YYvzSnfA2ffjD8Uk+KRs4vdPcSLMqFKIm40iJEuYefQPhnLmi5bRfkRt1p/vWVOu1zumPQCCzAHtuQhhmCip0+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkP+th3r/HpIBBj4CKhCpozn+AvXJWvTcnxdQyvi5BA=;
 b=ayz2lQuI5xrQ/qdp1TGqSIqKMlUiY1aUw1mn4at+SF/zxfdkiZSdQ0yPwzI9lKuNgjOqcr6ALO3SY4o3M+NfwV7yvrI0oEkCmabygTHNpz6qQ76t2/246heVfnqh6gfs4WZl1tQgoVcuyaA7guHh4LiQAzRQ3Mx0bmq7nsetLIPRk+7I6KegUaTKn90eQdhS08CJb7RtToLvHy9x6nH+Av5e6JlRL3aoskHhDsAb3+HE5j1XnTsloEWn9ZLAcsZh8AnaxT9eECEGAvm4cn60g55FRJfs5otwkHbVZ5i4dPMn2BK7t5bpJgXHiM00zlXUHdN7WrjiaJiBb1v6DvALHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkP+th3r/HpIBBj4CKhCpozn+AvXJWvTcnxdQyvi5BA=;
 b=EETFX3tpQGW/GM2y8nzH3bCUbDsDFgTTaQsPFWCPzyMi3sp1tNgpa+SZIH2Evcu/5RqCQrVmEMPCj+Rio2Ab7jxL/L9aw8ExzK1UAtO+jCZxMtwFDTUTyJFj0FD4qJBRdNqG5GwhwvZs7GTi2lM08reA42xleDBNELermIoxPTFrAMqzEoWLXTk8SyMn4+yhu3iS82LtJ6lXg5orn9pPFRRPIzUfy9zev27QSL8HfcSySV/S+VMmOPsqAUJeO5yI+mkJusFnTk23fkn8VfG4OuBsUR4+HEwKEGCTChOIqOsarS0MgDeRJEW44XVTlA6W2+Ynt4Xx06B/EXUjUFvHgA==
Received: from DM6PR02CA0130.namprd02.prod.outlook.com (2603:10b6:5:1b4::32)
 by IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 20:05:56 +0000
Received: from DS1PEPF0000E646.namprd02.prod.outlook.com
 (2603:10b6:5:1b4:cafe::38) by DM6PR02CA0130.outlook.office365.com
 (2603:10b6:5:1b4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Mon, 27 Mar 2023 20:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0000E646.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 20:05:56 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 27 Mar 2023
 13:05:41 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 27 Mar
 2023 13:05:40 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Mon, 27 Mar 2023 13:05:40 -0700
Date:   Mon, 27 Mar 2023 13:05:39 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <iommu@lists.linux.dev>, Kevin Tian <kevin.tian@intel.com>,
        <linux-kselftest@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, <kvm@vger.kernel.org>,
        Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 00/17] Add iommufd physical device operations for
 replace and alloc hwpt
Message-ID: <ZCH3E+VnJilogZfi@Asurada-Nvidia>
References: <0-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E646:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 32e61d64-3d02-4180-c9ab-08db2efead15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XGaIPjRmX3/o+ZMHwFWTxuAifaw/xMGMtI+e1o1NRNIvpZDgst5p/1tAlHKqPe6JJ9ox9eGi0XCnNGveqxeXC3X/vnRR6obssC/zAsoiquppt4XtuS09h8l9t/Nys3AcNrWCEjbSzG//mkdwaIEvYPXmyXsAlKoJI3aI+uXlBK9Kf2VRpSerqIpV0ftugdzOrPuheS3WQe+Q+8WMQMf/BWrzgpr3Mcf71oqnWHUC/Nm1cM4T5GB7Xc01pphHCE1XFBtEv9EV5vVI1EAirpoPpMqdsH6kZz9OTbS8jl4vm74UOXr1HCGzhZQgM0m2BK82zNawDTLCpsUhISvDmr9OyA7omCKgkez8xUbtKSFw/HP6XNMXG45Pcya6OZzvoNuoYujVDhGuVqMCr7CykuCPXj9jTLs9x1xeDvVNUofZdSy9aQF5OeKsK3Pf2Rdye+6iTccTTGzF/mzMP4hb14D+XKpgwvokVDR5bs5zCNDWl5YcszmaClZVUclKDiUOXu29vUMbLqj8IJbVYE1wf4GDNfD9FzB+BfKcWJK9fIpB3dsSgl/0o1d8CsqQ2UD4pvXc+sZ2OoBVdzfc0s09DJjtKKz3MYHkfMg0YryGmdQdeyghJVjrdosnb4jSpkH5fmcWTYFZNMuxBiC/WQJBoLmPDI7UpnChiVXvbhCp/KJxg06UiE7jbQ9Ai2n68yw44PAC2aSWj+WVJYHxamk738DY/mo/34wVFa4Rw/jq93bW+plTK4fI4dRbs9zpx6zXKrFzCqWNrJLDaBRQYrvy67CbkvKQP2b+xvMaWeIT8oU30dXz+LBxajFnJUlytEeWew0aPO/21aEZ4CzKV6gC97Un40heKY7aGA2CaQ5AxlbsIjg=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199021)(46966006)(36840700001)(40470700004)(33716001)(47076005)(426003)(86362001)(83380400001)(82310400005)(26005)(2906002)(9686003)(966005)(316002)(478600001)(54906003)(6636002)(55016003)(356005)(40480700001)(36860700001)(186003)(40460700003)(336012)(8676002)(4326008)(70206006)(5660300002)(7636003)(8936002)(70586007)(82740400003)(6862004)(41300700001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 20:05:56.2108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e61d64-3d02-4180-c9ab-08db2efead15
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E646.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 27, 2023 at 03:37:54PM -0300, Jason Gunthorpe wrote:
> This is the basic functionality for iommufd to support
> iommufd_device_replace() and IOMMU_HWPT_ALLOC for physical devices.
> 
> iommufd_device_replace() allows changing the HWPT associated with the
> device to a new IOAS or HWPT. Replace does this in way that failure leaves
> things unchanged, and utilizes the iommu iommu_group_replace_domain() API
> to allow the iommu driver to perform an optional non-disruptive change.
> 
> IOMMU_HWPT_ALLOC allows HWPTs to be explicitly allocated by the user and
> used by attach or replace. At this point it isn't very useful since the
> HWPT is the same as the automatically managed HWPT from the IOAS. However
> a following series will allow userspace to customize the created HWPT.
> 
> The implementation is complicated because we have to introduce some
> per-iommu_group memory in iommufd and redo how we think about multi-device
> groups to be more explicit. This solves all the locking problems in the
> prior attempts.
> 
> This series is infrastructure work for the following series which:
>  - Add replace for attach
>  - Expose replace through VFIO APIs
>  - Implement driver parameters for HWPT creation (nesting)
> 
> Once review of this is complete I will keep it on a side branch and
> accumulate the following series when they are ready so we can have a
> stable base and make more incremental progress. When we have all the parts
> together to get a full implementation it can go to Linus.
> 
> This is on github: https://github.com/jgunthorpe/linux/commits/iommufd_hwpt
> 
> v4:
>  - Refine comments and commit messages
>  - Move the group lock into iommufd_hw_pagetable_attach()
>  - Fix error unwind in iommufd_device_do_replace()

This runs well with iommufd selftest on x86 and QEMU sanity on
ARM64, applying nesting series on top of this and cdev series:
https://github.com/nicolinc/iommufd/commits/wip/iommufd_nesting-03272023

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
