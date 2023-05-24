Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8401670ED33
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 07:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjEXFlF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 01:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjEXFlD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 01:41:03 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C81B3;
        Tue, 23 May 2023 22:41:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yd+Sb0dL5PVvw0Oj9R1Y9ZMDDLc+yOHW6RF0fBW2OF1Gbt3RrEkHVB8WIiAIKU24ckwCFbcbjY386ZWMA8NYYPDIlnirDUxkM60fc0DWm+T8kfTDq895oMwnkCKQ1vbZs0GqQJ2DNhZLm0KLhc8Gqg2SLc9BlOihh+qIIG8F56gWVz98Q9fOS2CzOnirrpPmm2QHmxUiqTni6NJiPTnwudrFBER1ClK+iZQxkll/jMUKkshBUo2HLvb+wjy5LKw1c9HbXQOuqCJj9DlE/x05mAkNTYfjGvYXqnvP2ej9yLXm1yuHULrPxNg+WWt2MRcjr0JHBgnAxBjkTBvXSklRcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPi1dEVFcU8HVIyIvWq83TAsjFOhg2qPq6Q0R0xw2qE=;
 b=QevItaZOtxZUZRcIRP2XixsdvDU81a186MS6QiMmBx/vBgEs/pTd7RlfNNXIAry4qIIr6OmJgofNGwllNaECOXD1iSGo4VvVuvdCgbFfKeKfMMjgu+zg1lcjBBUBZvXfOQdn2SeK+/ZEj+rvy14W+WNURQ7O53dlKl/K5oAtDHYHPPlbKK3P8xm3gS7wtYHoMKrRh2tZhihMTnojsD+TZrgleLRD0EewDW6p078VEhuZMFg/JnTV3KSUzy9PBNc4+xFSSQosg+ZuztrO6uysejG7LHmap5cvbJgx1guQjRhPk+6RAOO4JqEOyrxiUEMHtqb6nhVi1+P3tpwkG95ZMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPi1dEVFcU8HVIyIvWq83TAsjFOhg2qPq6Q0R0xw2qE=;
 b=UceqGKph/w9FIqtV+IZacm88WIZ4OVjTxxHcytP/dvpaGzjBIwxr/AXUVKdFxm3NjAUxItT8SxMWm6FitKSeMsRmM8z/raOWOnT2gZtH7FLo9LX/V8hxhlf8v8tg8KX9H5EKAuy3pv7h2XUIuW4t9M6VQpdMjzK6CfnKaT9sql9eCsjTK/2BRG2AERsris3hzZHrTSvywb7rO/PsYOxE6nkgFucmltTwQGK9TELfnLmFMygXiGX5fxbHFPaNmxjdDWzOoJwHFRJo3fLeaRRHQ6hUMvP1Hgq1zhr0W22zq0xr1bnzse1bEX3hPQEMwL5tIPyrRJBGcN7OrE5o2hs7mA==
Received: from BN8PR03CA0002.namprd03.prod.outlook.com (2603:10b6:408:94::15)
 by SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Wed, 24 May
 2023 05:41:00 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::15) by BN8PR03CA0002.outlook.office365.com
 (2603:10b6:408:94::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15 via Frontend
 Transport; Wed, 24 May 2023 05:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.30 via Frontend Transport; Wed, 24 May 2023 05:40:59 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 23 May 2023
 22:40:44 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 23 May
 2023 22:40:44 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 23 May 2023 22:40:42 -0700
Date:   Tue, 23 May 2023 22:40:41 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
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
Subject: Re: [PATCH v2 06/11] iommufd: IOMMU_HWPT_ALLOC allocation with user
 data
Message-ID: <ZG2jWQvl9tdpZ1Vv@Asurada-Nvidia>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-7-yi.l.liu@intel.com>
 <BN9PR11MB52767257B1AC401121F3B24F8C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZGfSjYMA06PmaI+Y@Asurada-Nvidia>
 <BN9PR11MB5276FCE1CAA5556E0CBE0B628C419@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276FCE1CAA5556E0CBE0B628C419@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|SA1PR12MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: 011f6aed-50a3-42d0-43db-08db5c19744d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HMgEOvXJMb16pvfbbeTm+hczhBREXZ4XvoVp01UNtmU2txps+FiSERNLFQGksbrclOomyIF41nuGsNusvBzz3v5V5e0kIPrPTAp/kfRfellzPwk8bgfgRxR8HmDmfzjz9oOdE3N1nXuiiZORJMDKLoQvTdwH/Wh2F0hHzu31UieADjxDohuOMr1canz4RzopZemvL899hs5Df3/GMVgUbp5QcSvyqNmZR7BH3GTT3haI3diIwXVv6WDJvCcsXBm4cvNqE5vobzZLbCJ7KpFrEniFvEGEINIPZsfblIQD0y7BfG1AT4Afhl17E+H909dJ1Xv3F2TIBm8GKTOWj0flRzphh/srKPbguVhJq9IF6pdlwXq82ibO9OWw/yYZXt2WSVFQ0tg1tBUUjFptOanftFUtWejc9Fzv9NAIJglLGFYUfzYzW76OU6QPd2S2VjM8JqCRKyeQK1MzcI+CpKCiF5UALTdawc05T3a3sZ3Xf+hncREIl2MfSUcapQGET/toqMgIgqR9CZQ4XoomekvUYXtgIJ1JzH3OuxDSkCMYDBQRxTesOP4niFsHzdq7Uf1XLXbTdo1Vcvpq3iZ24uCJjKt14biusS6de1W+z2jP5c7/z9fZq5kkoSK0lVCAFJYC/YFCz0SyAX5ANtenE6mn4Cgx0MCkdJnUjYyyd0UwuXde2TowRNeQ12/BNpV5i9p+pV85cYkTyRTurGevTG/FjO1Fih+ceWA4jDszeWY8j0s=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(54906003)(82310400005)(41300700001)(478600001)(316002)(4326008)(70586007)(6916009)(86362001)(70206006)(5660300002)(33716001)(8936002)(8676002)(2906002)(7636003)(26005)(356005)(40460700003)(82740400003)(186003)(9686003)(7416002)(426003)(336012)(55016003)(40480700001)(36860700001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 05:40:59.6028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 011f6aed-50a3-42d0-43db-08db5c19744d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 24, 2023 at 05:16:35AM +0000, Tian, Kevin wrote:
 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, May 20, 2023 3:48 AM
> >
> >
> > > >
> > > > +     switch (pt_obj->type) {
> > > > +     case IOMMUFD_OBJ_IOAS:
> > > > +             ioas = container_of(pt_obj, struct iommufd_ioas, obj);
> > > > +             break;
> > >
> > > this should fail if parent is specified.
> >
> > I don't think that's necessaray: the parent is NULL by default
> > and only specified (if IOMMUFD_OBJ_HW_PAGETABLE) by the exact
> > pt_id/pt_obj here.
> 
> I didn't get. The uAPI describes that only hwpt not ioas can be specified
> in the pt_id field as the parent.
>
> If we don't check here it means the user can specify an ioas id as the
> parent?

I meant that the parent pointer isn't specified at this line:
the declaration of the parent is simply NULL, and not touched
in this IOMMUFD_OBJ_IOAS case, as the parent pointer would be
only specified in the IOMMUFD_OBJ_HW_PAGETABLE case that is
behind this line.

We could add a sanity of the parent pointer, but that would
be just a NOP, right?

Thanks
Nic
