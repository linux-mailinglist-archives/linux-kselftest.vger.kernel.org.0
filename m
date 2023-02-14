Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8DF696D0D
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 19:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjBNShO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 13:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjBNShN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 13:37:13 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706201F924;
        Tue, 14 Feb 2023 10:37:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e76GOVDVrwck+QqfT+F91cwCLZAnhA+J1MiATbawaf7WRCa/ktLYeOZkF3zFoQwou0tjvhyFHtWLs9RPJe9XPTEuBU0Ftb2JzOvgeggSk+KqvrQPe75NPgI3p77uyAYyHYHG/kLLNHeTdjSNA8CqY/AFbt/ebdGr9d1Qzyaarvy0kGb+qZduxA/QUell8uiizlGViazg7ZHqHJue5UYhUy2GQd2cHBiyX4uBS5CNsyX6X8KM3VysRz0ZbCKGmQ2zbLj/QJ/r6xx4W6fDF3mu9LLCgoeDGEZWoU36Ov9TKBc65vuYxU4YzU343fKlWQMCS9k2DgOkxva6/h06CD9Pgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4S4OHTMP2JYEUWEmdmIsWjBZa01f3Ih5UlK/HIXNOkg=;
 b=UMhwxug3E7X4CWGcc6pmJcvwLZSNtXISTCa94dYbCSV34dHSvS3ocMhCLLuiL6lGfDeCmzXZJ8ueq/gq+2H4yMlskkHYP8DTJ2IjFHGUTqFpkUEkQsPUVwIoJWKuMyDjfmDn9CH3sO7InjV+hAb8+F8lE6sXMGY5nui0wNYvRhFHVQNBZGzPdjxVRDcuW+xWfrKkbOm40E2DYgozEpc0RWiakaELDD//n6ols9To0Zajg50Oo1kWNyjl3dVUamokv3LKn9nylORhP1p0wGq4H6qpolMyZ/uzlF+rO0tbFRt0ssclKn+23yx5Bl5iPT/eb4I3iwhp+0LtnCJx0vjhtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4S4OHTMP2JYEUWEmdmIsWjBZa01f3Ih5UlK/HIXNOkg=;
 b=EAPFaNJALH/Aa6dPmi5Go+gfNkTy/zHGz8/yhoJABIFX9Z5028g1VtVLMB9pgYnWDiryM+nKa5pxaeQdEMcFeFAav2MX+SyL+tCy5q/s5hFkkgdZBNZoY5+Az66yqcxbILqy+3zajXgYXHM6ldRcjNF8g3Oq3sAzn/6gQjhx+1dTtSePSSOUQpcihPyikLvP2xAQNTgL9U/5CZTAbPb0rPJ8jCUScWFICqpfKq1rnOsVQuh+zB9OSwf2Uc3C8bzC+8TE8rlsJcJRSw0Hy48Mbqre2XAkMOLYFKWjPovZ7wUMVsF7FEXlowysMsp/ct24sNp4ckEHbESi3USeT2as4Q==
Received: from BN9PR03CA0660.namprd03.prod.outlook.com (2603:10b6:408:13b::35)
 by BL1PR12MB5318.namprd12.prod.outlook.com (2603:10b6:208:31d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 18:37:10 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::ee) by BN9PR03CA0660.outlook.office365.com
 (2603:10b6:408:13b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Tue, 14 Feb 2023 18:37:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.10 via Frontend Transport; Tue, 14 Feb 2023 18:37:09 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 10:37:00 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 10:36:59 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 14 Feb 2023 10:36:59 -0800
Date:   Tue, 14 Feb 2023 10:36:57 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
CC:     <joro@8bytes.org>, <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <kevin.tian@intel.com>, <robin.murphy@arm.com>,
        <cohuck@redhat.com>, <eric.auger@redhat.com>,
        <kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
        <peterx@redhat.com>, <jasowang@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 14/17] iommufd/selftest: Add
 IOMMU_TEST_OP_MOCK_DOMAIN_REPLACE test op
Message-ID: <Y+vUycZDiddxfSO+@Asurada-Nvidia>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
 <20230209043153.14964-15-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230209043153.14964-15-yi.l.liu@intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT033:EE_|BL1PR12MB5318:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd6ea8d-13f0-43d3-9ffd-08db0eba7b7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hcGIiBPfXr7m84X7qT6O3yZ2hYycfeiohbz9z121t1DC8a92+qcIkiYskVhKNs74BGIz2xXOwkgsEHqWqFjqBYA6+SK4PRhA427ob9jDjSvw5FnmKvhfkAKatRbxPxzUzhOzkB+JLEQtUDzmFC43GpYdW84nRDQDJ1JwnvVDAuf81YX9Uz46kfE1qi10ptb31n1kZILtYGXccSeRdUERpsTTKNdg2kyvaUMC0iqBd30gXuG17zU3UPqvdAfoSp40WndBL6H6TPqbg1EvRSLd6z9yXcjnZDQTjEsFlj+1TKE03cKWtcBT3qxxov64ofEGxSEAA7vt/IAjPtatQ4JOLvTD8mDcFRgEwFIQRb73lKyEEmwBxmNYsDjYRQ0gdgTRX/E3hJDmRMglKGV8CAETbJTIF2XuMmeKfWWlsb/B0qX09F/MkyeAO0Ikre1Waj/rKTAqsYUWOKnbtldZmMDzMlCuhsWtKkorJGzkNm+l9EnjeSQl4LL6KeebH6i+e1KIJWLueth1M5TdtSuaUP0ErBBSWe+kqjYWiQD07yo32aK1VNTIEMyaeNpM163CdjGtutbIw5gkuBOeLUJ4fXAqImcbryDw7+r4g7nWJVj7mpjkZkTREGPW5mXYTQ90aqi49KHYowqqsdy2JCspBn/SzTwABhtc/ab9VqaOBrt75CEvoLg4/cfHGS/mShmbVuPykpB3TZiPk+E9Uv91emNmDsvQ4+Zsul+edia/y+0EFRifBXJVM4Qobc3hOD+dlv29
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(82310400005)(40460700003)(9686003)(478600001)(55016003)(26005)(40480700001)(41300700001)(7636003)(6916009)(70206006)(186003)(70586007)(8676002)(356005)(316002)(8936002)(4326008)(86362001)(82740400003)(47076005)(83380400001)(36860700001)(426003)(54906003)(33716001)(5660300002)(7416002)(2906002)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 18:37:09.9628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd6ea8d-13f0-43d3-9ffd-08db0eba7b7e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5318
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 08, 2023 at 08:31:50PM -0800, Yi Liu wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> This allows to detach/attach the mock_dev to a specified domain/hwpt.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/device.c       |  1 -
>  drivers/iommu/iommufd/iommufd_test.h |  5 +++
>  drivers/iommu/iommufd/selftest.c     | 54 ++++++++++++++++++++++++++++
>  3 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 826441c6005d..bf803975062c 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -964,7 +964,6 @@ EXPORT_SYMBOL_NS_GPL(iommufd_access_rw, IOMMUFD);
>   * Creating a real iommufd_device is too hard, bypass creating a iommufd_device
>   * and go directly to attaching a domain.
>   */
> -
>  int iommufd_device_selftest_attach(struct iommufd_ctx *ictx,
>                                    struct iommufd_hw_pagetable *hwpt)
>  {

Just found last night that I forgot to drop this line removal.

Let's fix it in v2 :)

Thanks
Nic
