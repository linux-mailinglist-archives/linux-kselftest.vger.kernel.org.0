Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BA46EA106
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 03:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjDUBgA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 21:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjDUBf7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 21:35:59 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3783C04;
        Thu, 20 Apr 2023 18:35:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iru6hbU9kr3im5USVvNm1rSESl1j7pRlmcqRXhjiGgMSz+bU/SIcWp/cwtgsaCjDzUUBY06X69fk0/vmC+Kyz7NZJ+lEfdbCKGOpdVBHgdcYjoZz3BQ8FNLHAqOYl21PovineaESo30z2qxrifCidEHFksLZVLpcXqbeIW6nqThImf7TCwLZne0aAp5wjYz90Dm6cVeTjUBSgXmi13GSGZTFQFN6hc13ZOkHTtJg2XnlaPg/xoDcXYHzNDZiEfRnfz/luYypET8wGPuj0psX7b5cH3r6w95LYFjCV9cJktx8gjtTXai9cARhRLjW3DToJQqsg1ZMGMfCZiTebMj3Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfZJqFWw9/uwiIdmsjLKa+wo5tVtrhATB3hUKHDYGTQ=;
 b=YtaYyZpF+uNfvzqvhwOVqXXzkmuvnNnMmuPGTgXOuuFjUvjwDSiyaR1a2Zb3xBHn6HUQ5LPBWeh5WXxc2m+G/xHsjHGDP4tV15WRN46uTJTdQ5ubLkOA6CP8XJ2e5oBee7g8X+bTFt1VHrRCISY6nSFD+R7q2QGvYVxC8e9eOrbJYapDu+EHVTwqAdHYSP0911KBIJAXvhDySFFKlcLpozYeh60hjLQRXDe9xbnZOKFdlXvsmvOg8nrzwuhETjCKdHtfbDlidclDq3vB7kwfhoCuS15a/2tdMkSZxm1rTQ8w+aHRn2qQse1JHqMuw1NWpYh47Cj8UfOpaA+P6KtCoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfZJqFWw9/uwiIdmsjLKa+wo5tVtrhATB3hUKHDYGTQ=;
 b=tq4oQQoYCf7BaCXZ8/Reze54x6RS3m3XtNWd+kwMc45pb0jDvKSq7T7n0ZaPxQ41Vw6MRAMGtjIPhwNPJR2LHxrlj1pRAQK9iVb60/q1LNn05etqYbroUAiavVWvAmH08AgQGj4FVS/TdtM07v21ll8TaDTd84Tp5wR42fRhbsTyWepgyvvoZ8nZ+QLAsbFpXs7Syb+Ib38H7rfx9ANLSdpsIv0t7K0MwFh0Uld0JzayY6uZVHFEyKLZW2n/PcdrPu7VTqqigr28JQyM55a6oDZyprWjUdS5l46LvqMHpakTwtomd40h6APRsMD7+L+h3EKqEpwd1vwNFRnHVD1itQ==
Received: from MW3PR06CA0025.namprd06.prod.outlook.com (2603:10b6:303:2a::30)
 by IA1PR12MB7615.namprd12.prod.outlook.com (2603:10b6:208:428::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 01:35:56 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::32) by MW3PR06CA0025.outlook.office365.com
 (2603:10b6:303:2a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Fri, 21 Apr 2023 01:35:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.51 via Frontend Transport; Fri, 21 Apr 2023 01:35:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 20 Apr 2023
 18:35:56 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 20 Apr 2023 18:35:55 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 20 Apr 2023 18:35:55 -0700
Date:   Thu, 20 Apr 2023 18:35:53 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <iommu@lists.linux.dev>, <linux-kselftest@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, <kvm@vger.kernel.org>,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 00/19] Add iommufd physical device operations for
 replace and alloc hwpt
Message-ID: <ZEHoeelUkDEWNtZk@Asurada-Nvidia>
References: <0-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|IA1PR12MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: b53a7aa9-dd8f-4a23-7147-08db4208c0da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gooza2JVe4lNI4175c4c4Obv0ZU0oci9oZY/IcDzLF8J3iHLsssyCnvuHtDBtqiaSPh7JD5G4JPodoKBNrZdJK+q2WiHC6OyVXy9eBpYtfDpaJXY1pws/2eEDn3uD0XMODM69Tzh/CitU2WiVTq7ISjMrtQgOJ2SVyCcY1ZtaIVcSRPprrLLbJniVTmUginORWwCvQbXQQmgIktKDqtz5FLszbouNxtlC7bjvbysCj6FxsuwmdR++s9fFTlWzfJtfXlkyDN4hyuLdmRbUExIXDBD21MDGbxA37GjdyPzqwIw0lQ196QDRzkKbB+VTt7Ljw9SE5s2VuAYx6aXze76k2iXcsD2iqkLibAWGpgiTrmXQ/5QrZcAc2OPWeHWGUDrfRiHOZ65UVRzdAO7Wp9iI1lOBSKkcU7ziW3Jy+VRpDqXeQHDKH+Vh5FOBVqODLUfYQrGGmEdqliCKDO44HpE2sGiX8gy7GqYD8sl/wzsbZwE6ukM8tVdyPXVM0WudnU12L8gdnht0XA4k5BxXQOoEkQhZ5RJ1JATIBUcKkrqpYu12R1QAxKmVzpu8ziJ05OV9iwcIbZ/ND6gLeYeg+r+dEWX5DtMGHpUTLHMuIX1fgeSDO4E5PJq97/2O8nrZGhbVX8mvBKvsbMcmpZLp+tHhK/csKY0N8bNMfAVL4ukOmplbErvr2klQM0/Yx1v9YoXL8cNXV4GAKHpmNQJ4bIwtgT4PfptI0LjWNuQZmOogfjIjPowfWLR6hg5LPrbrmEXxyxtmr0+0GPklm15Qyyb9+g2jB2DLBoya5QA+zABp++jwYuxTvTNMFidNiYBuYJs0TILlWXQnGMG/l714/+5o+WHnu5OXosiJPpfVrOcl2o=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(34020700004)(6636002)(54906003)(83380400001)(478600001)(36860700001)(47076005)(40480700001)(55016003)(26005)(9686003)(966005)(316002)(356005)(4326008)(186003)(336012)(426003)(70206006)(82740400003)(70586007)(5660300002)(8936002)(2906002)(6862004)(8676002)(40460700003)(7636003)(41300700001)(86362001)(33716001)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 01:35:56.4832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b53a7aa9-dd8f-4a23-7147-08db4208c0da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7615
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 20, 2023 at 03:51:15PM -0300, Jason Gunthorpe wrote:

> This is on github: https://github.com/jgunthorpe/linux/commits/iommufd_hwpt
> 
> v6:
>  - Go back to the v4 locking arragnment with now both the attach/detach
>    igroup->locks inside the functions, Kevin says he needs this for a
>    followup series. This still fixes the syzkaller bug
>  - Fix two more error unwind locking bugs where
>    iommufd_object_abort_and_destroy(hwpt) would deadlock or be mislocked.
>    Make sure fail_nth will catch these mistakes
>  - Add a patch allowing objects to have different abort than destroy
>    function, it allows hwpt abort to require the caller to continue
>    to hold the lock and enforces this with lockdep.

Tested this series + cdev v9 + replace series + nesting (SMMUv3):
https://github.com/nicolinc/iommufd/commits/wip/iommufd_nesting-04202023-nic

I only have one device per group, so can't cover the igroup part.
Yet, the sanity covers hwpt replacements of a kernel-manage hwpt
from/to an ioas (auto hwpt) and a user-managed hwpt.

Thanks
Nic
