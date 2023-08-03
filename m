Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DBC76DDEC
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 04:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjHCCRh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 22:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjHCCRe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 22:17:34 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20615.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2370E1B4;
        Wed,  2 Aug 2023 19:17:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blVOGVKyMcAafAhk0IWPM8vH7HV2af7NTLpdXW3BLsQEvlL/NhC/yhrb1ZqRY6zv8Pvf/HYJfx/LAJzhPPg7D8KdEjTFCZ5bP1pYgqBTtWbXH7GVOBGSkEWFnSBQIXAhYVXEwLx7wSCDSBrYWaKlMmi5t6IEU3nQjfoZl3g9RS9ec+uIG1okrKn6QnMi1eSMqwAIcxIPxKdaRmCF1721NZvh7ylRd3CU4RJCLYmDueQvEUATYPLD+QPsRW/km065AlWqh+un5FB2EKRMPa+40h2l1+eDjtjbC7NyuDjWjZ7VLnEiiJm0QLJ7QR00cS5Kvr59zGLEkc8iSTFqVEX1vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xlj6/q3FuibmBvVUh7z5VTu0ad8S3QXqHOfHBcGzyX8=;
 b=oQwvSIM5G+hrvq61K5DM4nloQ/LHscazq1m5yHlsuCaWK5Vw1x2+I8OKs28m5h5uihW7EVydEaB1AONh3/P7MhyszCJ+1WgKfJ5T3zvez1ZyTPA3qjSYLcjoy+SU6kV+NEyuE6RNdnZbzZwTbRodPMLtISt8UXdCyXI4ES7Ptus40i5utlb2OCS+sn0mmwMDP8p3rhdBq5yuWZwC5AvDdxc6WvYWDqsGi/uRmr0JBLqkp5LdjlOK4djtMaD/YvGc6BwlvKeu/hAbonvqyvwxDCR5E6giNjZbEgSZIC+kQWrepX/9eslUs2OOsSddiPo9/9ivl9U1b8fsGTaatK9UKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xlj6/q3FuibmBvVUh7z5VTu0ad8S3QXqHOfHBcGzyX8=;
 b=PREASW/4yCcxX2Zz6DyZ0FLzkPC5ykSKI3kS/pFW/QIpHSgFZU4Oy8q/vw9lPg7z9x6lWlFkvcRvUsyjTLiNWb+sfawkGes6cACvm5i4JPe1ZYu3GNDO9weYpMqL+AOlgg7A3PJIaVQOBOFhh1BBzUbmWCj10+uCCz/cIB8wOH4FXsYHzw56X9VWNrWUYgNiN8kNf8IeY0zAg23aN1ZHXBJl9MsKb/fSsfLDzCJTAZDJUMNpDUt+RoULtZCw2QlO5kQv7U7fnbpnnWDcxlxfjTWo+PKTb/6+xhCd3hch5mEGXLr6tnUIhgjd9lzxw6kdEBCPXw6TY2/BN/0RF6s4tA==
Received: from DM6PR11CA0001.namprd11.prod.outlook.com (2603:10b6:5:190::14)
 by IA0PR12MB8894.namprd12.prod.outlook.com (2603:10b6:208:483::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Thu, 3 Aug
 2023 02:17:26 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:5:190:cafe::e8) by DM6PR11CA0001.outlook.office365.com
 (2603:10b6:5:190::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Thu, 3 Aug 2023 02:17:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 02:17:25 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 2 Aug 2023
 19:17:21 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 2 Aug 2023 19:17:20 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 2 Aug 2023 19:17:19 -0700
Date:   Wed, 2 Aug 2023 19:17:18 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
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
Subject: Re: [PATCH v3 07/17] iommufd: Add IOMMU_RESV_IOVA_RANGES
Message-ID: <ZMsOLumqmaakH5OY@Asurada-Nvidia>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-8-yi.l.liu@intel.com>
 <ZMP+lvbhAwEbhjx/@nvidia.com>
 <BN9PR11MB52764E058BDC007FCF2F240B8C05A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMe14r37YkdOKulU@nvidia.com>
 <BL1PR11MB52710D1257B38E4627BC61118C0AA@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZMlNcRgMYatv/YqO@nvidia.com>
 <BN9PR11MB52764C401206FE8D7A4731628C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZMsBi24W2+ubtmkh@Asurada-Nvidia>
 <BN9PR11MB527633F9EFD1EFB52772CD158C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527633F9EFD1EFB52772CD158C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|IA0PR12MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a549331-d285-424e-ab14-08db93c7c76f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X4pqzL28N7tHFqaekiaW6aR8zn4Il4VEWggP+UeLJLdzqnw7lsgKU6NRhvoA+xn+dQQqcBua2QZ96h86KMxCv4uZyLQiaBQx0+9TKKqcnkUj3V0ydLWDeQODnqMf9BWq/cIfLIIR8Oy6Po+SlKYpntriyGHUf/zByD67gtPcPlzW9P9reUEKekBMrMhZmCqG18ryH6V6M1LOiOWWccD1nj9xklRKwExgdQdYiJa+0mKFR7D65wirVtPL9P4hUVCE0x7Q+fLE+nEumap4T0D5X+XVyUgKLSX8psXUVTwRtzTOKTslbGMONXsNDc8OMtBOy+G/QbiHxFYWG88KOPpd8BiP5/gy9pMXiyFWIgspd30n/yIpaJrJHIWRoVAt9Qk8CM0OgYP3BTHjVWsaXOHug2+KEGy3hDDm71gNODtwGRL3WB58JOcJNwahjlDicoLxjpWwE3btE3oXBlMoLCzEYTRSQOP385vV9dGNHFgijYnllYqQ5RGawhvbJM5E8XH64zDLbuUCBOIcji2VQHHEyCgTfnTSCZu96Ey5SK8ajknffTXWWxWXxn130t0VZqBN2rCXyQvDCFaWq2ztEiEmZG1nHVQ56dwPqE2agNePD0Ewlwrg3qkGwwDAOx5WMURSPrkv63r8DCSIi/o/gDwvKBBZwsY1HrPZrgolAMv1+xZzaph68aeMi8VcX1MVPHOi6sbDQ9BjhRhERlnf/V/lXUOH5TbladiOTW4rDMiBXuI=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(4326008)(7636003)(55016003)(40480700001)(356005)(7416002)(5660300002)(426003)(47076005)(186003)(336012)(82740400003)(36860700001)(26005)(8936002)(8676002)(40460700003)(2906002)(558084003)(41300700001)(9686003)(70206006)(70586007)(6916009)(54906003)(478600001)(86362001)(316002)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 02:17:25.5722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a549331-d285-424e-ab14-08db93c7c76f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8894
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 03, 2023 at 01:25:37AM +0000, Tian, Kevin wrote:
> > > Preferably let's not making it a hard dependency for this series.
> >
> > Should we drop this and its selftest patch from this series?
> >
> 
> Yes. let's drop it.

Ack. Thanks!
