Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BDF76DE44
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 04:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjHCCeT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 22:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbjHCCdK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 22:33:10 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDC64209;
        Wed,  2 Aug 2023 19:30:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJpzZE7P4EDBC8mkVs/6iZPNDYROWvrQ6El+6gGzG2CV3yq8jZA7J6E9ZfFTqvpZ04Cthyc+lSwhiK3kzfgP6BOnZNX3qGHOQMd29m4Jq02P2YblD0UH9IM/D3JufWB9Z2qqgfRrSo2M/rO/KsAhndLOxEDaxsTV0dxzgQHgh5SJdl20OeaPl4TkZj7kHWTk/AL0BE9nmsH5hR2CUsfXcSDgPPcC3s912h1yAZyhCAiympYWFvGvz1gboUPPLtphTKNR7jcEQvsEZE8wwXpRJL6Px+W8Ga3sIGyf0GkV9ekM1G8HrFxM/2ecJ5+cdMREptWhrHyvu9DE33sX3RGRIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMEWGyUCNMUxUoFxWKWxfwOKkPyVvEmg2eeHLDcz3sg=;
 b=U4g/gggt1jZhDJE2YV3y1Q90WYBJ39Ab2GdT7shmrsEPT9LXJH9gRv0ZMcKMciXMJb6zfnJWikyOz7hpckhSzHoMIiGNBtC8nWsa/rwERNXiwpvQy5i4CVmN8N3ApIt1yi33gYWvhlLhYIvMf8DC5KgQ5Upa+9vPX2SOYQdydx29TIt6ToBDrM5/ZjoSekaJDzBVWSnFAAtPEm6YLAPjSlr65i2tp/njc4tZQeb3/GfRrSx6xjCJYRs2BcU2DhYjnnq/ZJypTIK8EjBllmSnEl6KNWe+8FPs6ZG9cszzFLaZTLFolhAx194CHMyUC1RJHD0LILiAFRpJx/YLXiiccg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMEWGyUCNMUxUoFxWKWxfwOKkPyVvEmg2eeHLDcz3sg=;
 b=nL1UztreKFpM8m6p8s/jhw1EpPpDHhB5uHnWXi8zQbJXX+Plu1Q3kPR2UINeOB79cg6JvCUSJFMpjKxNg2nH+W7Oe49H7ap19CmaTM8SbIY/ntuAMGEQ52zHZvGLN5kJ9l4Bklf8baMAowg2HzGmVCfxPL1F1/bWtLrXTOJyMsa7eVZmSadhDT0LmvrDBMQ/7/UY2Y2lvwWSu72nJSR1U8aaTXLvlL5dgx6Ojj5wkKk55jTswhXrfGowcTCNq98YJsIeioRgkfkQg+BROnM+iKa5E0n4YNxiawFdVet/XpqmoJMJEScmpSBldHU9akKIoOs7X0f4m37rhG2ywW1gxA==
Received: from SA0PR13CA0022.namprd13.prod.outlook.com (2603:10b6:806:130::27)
 by SJ2PR12MB9087.namprd12.prod.outlook.com (2603:10b6:a03:562::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Thu, 3 Aug
 2023 02:28:23 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:130:cafe::73) by SA0PR13CA0022.outlook.office365.com
 (2603:10b6:806:130::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Thu, 3 Aug 2023 02:28:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.20 via Frontend Transport; Thu, 3 Aug 2023 02:28:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 19:28:13 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 2 Aug 2023
 19:28:13 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 2 Aug 2023 19:28:11 -0700
Date:   Wed, 2 Aug 2023 19:28:09 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
Subject: Re: [PATCH v3 01/17] iommu: Add new iommu op to create domains owned
 by userspace
Message-ID: <ZMsQuaBZfoRbNqjV@Asurada-Nvidia>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-2-yi.l.liu@intel.com>
 <BN9PR11MB52765C4F05F7632829B53BAC8C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMPzJd6iIFk/51Om@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZMPzJd6iIFk/51Om@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|SJ2PR12MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4f1e6e-81e2-4492-65b1-08db93c94f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tybEGX4LFH13YHjuPItnhZoeDGyPbbeQmJSYo9GJnCOY6zap+hYMIKHCzWWVSkj7nzuxvMLqZ2xTGdwUU37Ckg1PDpyyMNXZ3LeY4d9plb0CUyEqETHIKGFdSiprOxDnHsL74f8xlIX5AEeEnEwbDm5deGBQCQhFOGVjyrBXXGazp+bjGoGPHjmYlL+ylCXKngKOrPMlMNYF7eK2jmYHiYqDlSI9rZIKVRwfljCOSU1829hqnkjlOzgXxeORTItC5BII0dMFIqQcAkaWwLKdpY7K5BbKGGKaE7xNMlAydps5qM+ioelyQQH0fnHnPnio8oPzVjbuMftycadenVzlVJKmmIuyMrmZzp/+62/ptQLVG7tA2p5I3eVrAUJ9I0Evaq9aEtVhTd7oo1cF+YnggAfXlvu5xC8WiHlKzGQb5xwjvmG96br9g5ybmvnQ17CuE9K+aVbA1NJqiJO5rn5HLcmHiIWZc2jV1KEOPAQ34XOYSMqoafce8rPhZIZfeJz9om9t4/hxKYEK9bwjDM2fKxgOeA8I6zb9mWYrlwBZeulmQtpHYH1/rgCspAoTTdvrT0sqnPzOOBMtXKRV39nvRssW2/gRAyOfaI66lxlCO9X9I9HoIePO8rkIXEX4lrc5tSWT4jYjruW11OQNOWPOI/IgSLHaDbpRVWtgF+zZt9585JtdNAV9I+Gh+tccS46luL3/73eyJBsf8NKbKCyXFmtXzfD5yb69235LxKgEpu1czPUbxdyVK+ZxZQqKUWeU
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(4326008)(6636002)(40460700003)(426003)(70206006)(70586007)(186003)(356005)(7636003)(82740400003)(2906002)(336012)(26005)(7416002)(33716001)(83380400001)(36860700001)(47076005)(55016003)(54906003)(40480700001)(478600001)(86362001)(9686003)(41300700001)(8676002)(8936002)(6862004)(5660300002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 02:28:22.8209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4f1e6e-81e2-4492-65b1-08db93c94f39
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9087
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 28, 2023 at 01:56:05PM -0300, Jason Gunthorpe wrote:
> On Fri, Jul 28, 2023 at 09:37:21AM +0000, Tian, Kevin wrote:
> > > From: Yi Liu <yi.l.liu@intel.com>
> > > Sent: Monday, July 24, 2023 7:04 PM
> > >
> > > + * @domain_alloc_user: allocate a user iommu domain corresponding to
> > > the input
> > > + *                     @hwpt_type that is defined as enum iommu_hwpt_type in the
> > > + *                     include/uapi/linux/iommufd.h. A returning domain will be
> > > + *                     set to an IOMMU_DOMAIN_NESTED type, upon valid
> > > @user_data
> > > + *                     and @parent that is a kernel-managed domain. Otherwise,
> > > + *                     it will be set to an IOMMU_DOMAIN_UNMANAGED type.
> > > Return
> > > + *                     ERR_PTR on allocation failure.
> > 
> > "If @user_data is valid and @parent points to a kernel-managed domain,
> > the returning domain is set to IOMMU_DOMAIN_NESTED type. Otherwise
> > it is set to IOMMU_DOMAIN_UNMANAGED type."
> 
>  "If @user_data is valid and @parent points to a kernel-managed domain,
>  then the returned domain must be the IOMMU_DOMAIN_NESTED type. Otherwise
>  the returned domain is IOMMU_DOMAIN_UNMANAGED."
> 
> Notice the detail that this API expects the driver to set the type and
> fully initialize the domain, including the generic iommu_domain
> struct, which is different than alloc_domain.
> 
> When we implement this in drivers we should tidy this so all the alloc
> flows fully initialize the domain internally.

Changed to:

+ * @domain_alloc_user: allocate a user iommu domain corresponding to the input
+ *                     @hwpt_type that is defined as enum iommu_hwpt_type in the
+ *                     include/uapi/linux/iommufd.h. Different from domain_alloc
+ *                     it requires iommu driver to fully initialize a new domain
+ *                     including the generic iommu_domain struct. Upon success,
+ *                     if the @user_data is valid and the @parent points to a
+ *                     kernel-managed domain, the type of the new domain must be
+ *                     IOMMU_DOMAIN_NESTED, otherwise be IOMMU_DOMAIN_UNMANAGED.
+ *                     Upon failure, ERR_PTR must be returned.

Thanks
Nic
