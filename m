Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED90D7CCCBB
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 21:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjJQT7E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 15:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQT7D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 15:59:03 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E409E9E;
        Tue, 17 Oct 2023 12:59:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDeBKYdBzeMHu0jPaS/x0Lir2t001JbPsVt2OvhBKEmbVLHaw/q2xoxycJXkxPYlKn5cqHO8/B2k9a6CX+5mIaLdR3ypCsiW9PnAEFM/CkQR9wIkkAe+Co8qYuM1iHZhowTl2yztvfKr3Vb2LOTDmG9iKQRmR4vKDzzTw/njh++7ntvdpNg0fYbuOB8vDvRodPQS6eW+mMxHZNkl2UJFoIA84uh3BL64dXMZTMh3Ods1BxE1HtFMfqO1tSjBKvy649o/HC83u6Y/mAg2qPAid+fywvUjKNxT1RCnqxKR2+XaYTFan61gClwktpXLPVRCeb3HfAKjDBjlHFHKSMk9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLhtWUNZpABRlJlSTGkRx28jNBwH89C2DwwILX5awGk=;
 b=bxEo4wSoYnyteHXbURvyvJIDgwmOhRRMM/ulcGYP84VETNYrWg/IhcE+DoCQfxWOueTqDQd0aVh/FVUpzyjLb2ClFb1C4wXDg60VT5WB8lcWikwqHVNNpOzje1ZzKE+KaVN5jknqAJiuHEIyVCmipUYNxD9pr2bOaB8m/hoOOJpBWat70GZtAz+mBGrrbwcR9ruTKt45zi3Gj9vG5Y1MeA1tKAuy0QE132Ze33ix2tiP7COH4NCUDuZ4T5mekrdg707tDrCnAEWxBTwSDxUcQfoX2dHXg09UEYTLWAP2mZ/aZwF99CmHboD0e3/DS3PtRAa7RyBOMuNNMy2EOufHHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLhtWUNZpABRlJlSTGkRx28jNBwH89C2DwwILX5awGk=;
 b=tAyfPyVLEdBi0nql6VMsAvmLTkdZnzYktgX/XHbeqyZhV/LUAVzssjbfs+jcs3zJovNcNBu9Mq4ZYvIMHnjcqu70OvbnDHtDz5HMyEYISalxCtyv0tcM5RfJiIjjpwPozfWXUO4Tb18cpRVMq9EvkjVgToodX5uxV0bSIeiDkm1wQEb9p8+mQvEEwbyeun57nuuyWeQsVHIP1PWIkjmjOvVTOYuaQQwgAlNylkiS20WJeI20zANFeKzQB1Rm4FBK4ZI4+tbtfQETJCtzXDUFmG9RfRgmxnMc9NbzpRH6Yg2dh1CtEcALkwiQUD/5IjfkMODe44CPPUvmNG0He6X5oA==
Received: from PH0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::29)
 by CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 19:58:59 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::d3) by PH0P220CA0024.outlook.office365.com
 (2603:10b6:510:d3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Tue, 17 Oct 2023 19:58:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 19:58:59 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 17 Oct
 2023 12:58:41 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 17 Oct 2023 12:58:41 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 17 Oct 2023 12:58:40 -0700
Date:   Tue, 17 Oct 2023 12:58:39 -0700
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: Re: [PATCH v4 08/17] iommufd: Always setup MSI and anforce cc on
 kernel-managed domains
Message-ID: <ZS7nb+mKanGFXhZY@Asurada-Nvidia>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-9-yi.l.liu@intel.com>
 <BN9PR11MB527658EAF017FF3576667EEA8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZSnkiKoCspmG1+/j@Asurada-Nvidia>
 <BN9PR11MB52763227866603ED7795AA068CD7A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231016115736.GP3952@nvidia.com>
 <BN9PR11MB5276FDC375685CE04A7AD93B8CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231017155301.GH3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231017155301.GH3952@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|CY5PR12MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: bc9418bb-8bef-4100-e812-08dbcf4b80ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nz911d+VfQQ5TxYx9eXMNXhJm+nY7UZeqS30D4BBj6MF+SxBfWZozZ4vflaAVmONxT8OxtWvqoNVznPSlmbeb8nqXMKlvWKPRuwmGJjw4SFEM6JJSwqxaFqQbbt4r5SGV2kfy10R9vKnAp6zCtPFJ8jR1T9EQETcI/7aWx9to+jPcxVE8NEDNeUS4IE6PF3OiRBUvMyEOyB4aKfxfQbXbrb5Dwg9SqAz5SFkBSPNPESgzUau7oXzmLwNoktTiughasIkdXME+4tTFj/BYskx86p8DVUblmi1m0J7oit8sRCpzIukpJiFx0vQ7SxgP9PZD51vxE+dFFp97C5AQZRvUkcKgsF4bxW8sfy5kvNLl6anE53xWyw8kx7UKjuf4quWSQ5+DzuuHI+eJQUfJUNT7W2R0xxU93tpoHA40lbYL+lQBF3Jkq4MRf1kGuXz0DQHOUTHhxXXLfx9DhL5k/s9VabTvCvxRkIX9NOCHuT1TxZ/1KHlDIFtRWp6WbJrG2rf/D881/iHx6N73CnlKfqSpztfY5oKvR5WhD164YDugR7y3fc8qYWRCGtCEQpsc+JX2leNbUfuSGbeLs1RPepVx5kYtbhy6477nYhqqtF77usuT+D9JehQGO468WT42A7T+3OxfuP5Ejt2PGMAN+tetcc6pV5i9hES6U4faxM0EoMuigY2BksUZD9LcHWXFsqb8gZo2htldWhON6lDhkA0Vzm+IoHRds/CrUTesifvuD+zX/VwncmPONlVUVulwvdWURBILqivtTBFPnr8vFW3jvpTe7UH1xIwaj/gNxN5oR8=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(451199024)(82310400011)(186009)(1800799009)(64100799003)(46966006)(36840700001)(40470700004)(55016003)(47076005)(54906003)(40480700001)(6636002)(316002)(70586007)(2906002)(86362001)(70206006)(40460700003)(5660300002)(41300700001)(4326008)(8936002)(6862004)(8676002)(7416002)(33716001)(9686003)(83380400001)(966005)(478600001)(426003)(336012)(82740400003)(356005)(26005)(7636003)(36860700001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:58:59.0879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9418bb-8bef-4100-e812-08dbcf4b80ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6034
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 17, 2023 at 12:53:01PM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 17, 2023 at 08:52:49AM +0000, Tian, Kevin wrote:
> > I prefer to removing enforce_cc in attach fn completely then no parent
> > trick in this patch. Just keep it in hwpt_alloc and leave to iommu driver to
> > figure out the attaching compatibility:
> 
> You are basically saying to set the cc mode during creation because we
> know the idev at that moment and can tell if it should be on/off?
> 
> It seems reasonable, but I can't remember why it is in the attach path
> at the moment.

This was the commit adding it in the alloc path:
https://lore.kernel.org/linux-iommu/8e897628-61fa-b3fb-b609-44eeda11b45e@arm.com/

The older code was doing a hwpt "upgrade" from !cc to cc:
-       /*
-        * Try to upgrade the domain we have, it is an iommu driver bug to
-        * report IOMMU_CAP_ENFORCE_CACHE_COHERENCY but fail
-        * enforce_cache_coherency when there are no devices attached to the
-        * domain.
-        */
-       if (idev->enforce_cache_coherency && !hwpt->enforce_cache_coherency) {
-               if (hwpt->domain->ops->enforce_cache_coherency)
-                       hwpt->enforce_cache_coherency =
-                               hwpt->domain->ops->enforce_cache_coherency(
-                                       hwpt->domain);

If we remove the enforce_cc call in the attach path and let the
driver decide whether to enforce or reject in attach_dev calls,
there seems to be no point in tracking an enforce_cache_coherency
flag in the IOMMUFD pathway but only for the VFIO_DMA_CC_IOMMU
extension check in the vfio-compat pathway?

Thanks
Nic
