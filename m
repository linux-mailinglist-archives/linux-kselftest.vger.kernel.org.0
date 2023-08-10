Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2ADB776E8E
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 05:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjHJDdk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 23:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjHJDdj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 23:33:39 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BB21FF7;
        Wed,  9 Aug 2023 20:33:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgrGfmYWF0o0Zov71ZDojZM7X70LKxlSstx2JGVzJjK3yNOZW01BBXUc8LwZoNcf6gs1Y8kUlLu4l8XTkWzW2MGLnqO7Vzwkuckm0fK7PDXGP1gC3mJxCOVa79adMzfWpwDKkv4jMty3XzCVdNvo92gAGDcnjzBPo/nCNs5u0QziHG3jdUl/s83yuXJBnV5xw1mHjcDP3c09uUSfAuFFL/vklECCpYfbiHiI1t5Ic+6eqbnZmW7jto8SR8nHUuJ/JGaM03Yy2r47wTsNlofE7POYsN0O6YpZchEUeJNHrHLbC/q+VHjd7EZF3lmJfnIpUMPO33o9AMSefK2jqiiTcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9VX8hWCBXkdr2C3RbERUMPDpbxM2XVL1TYY8fXsoeE=;
 b=Fjpyc8ZsY2MAOzyqM35QgeMWdT6X9cusawH3tdOIo4ydqeQ28zFN1lilcPZJjVSJQUazjTOv1MH1j78vMasxOdRSRNWWN266c6QXupCqS4JY/6ZsNwBXaJ7ZGqzFdJ6B71Hpgd3mjIGN+k4X4kaoD0LL5TQ36qUDyKWVLRVcfwJGMGgABat5Q1ZoEnytsxKW1tvbTJYqOOFFXOSKRkMEjVd4EmbLFj7Pe+D0TW9p0FVystR759UhExBcmlN76fqWsOdpwseEsnbsVd5sI/a7pnmHGTJoTfvCkLzO2rSLrn9qAPvyZ/9oEYhUvx4WNBf0lDO3oz/B/h0vzHZ1cYo5+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9VX8hWCBXkdr2C3RbERUMPDpbxM2XVL1TYY8fXsoeE=;
 b=K+vXK7FpKxzfY40AndecOPVCJ7ixODTumEk7BwITvQWtad3dfprsDiz69MNyfnc+xkre+/FiE0S7D2Ygqgp/NvWBqtN3haUmQqugufYonAKSKnbu9P/gyhjt/gD4oWEF5FFs6UVUQy1xl2tPagl3SPZH5cn6SZpcrFBa82GqJz92yoNZ6yKKfu/R+72C1CurPe3cNhWx7+HdIqJVJ59+A2TMet0rXktqcc2mLw3OFBKVkdg0McNijy/aK7Xw/LkidfufnROcZ9oi/UZB82Js/1VDInYrfNKHlw+ZgF8ZP1c7o68rPoqJ/4qGOWNXMuXYRqrjkqceNZGWMQnKqjjfog==
Received: from CH0PR03CA0099.namprd03.prod.outlook.com (2603:10b6:610:cd::14)
 by MW3PR12MB4588.namprd12.prod.outlook.com (2603:10b6:303:2e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 03:33:36 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:610:cd:cafe::62) by CH0PR03CA0099.outlook.office365.com
 (2603:10b6:610:cd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Thu, 10 Aug 2023 03:33:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Thu, 10 Aug 2023 03:33:35 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 9 Aug 2023
 20:33:25 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 9 Aug 2023 20:33:24 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 9 Aug 2023 20:33:23 -0700
Date:   Wed, 9 Aug 2023 20:33:22 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
Subject: Re: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Message-ID: <ZNRaUZIiGV+v2l+d@Asurada-Nvidia>
References: <ZNJ+Uv/WJwngosjJ@Asurada-Nvidia>
 <BN9PR11MB5276BFFEC7E12EEBD4503BF08C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529C3646E38542457D7B75DC312A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <BN9PR11MB5276912120F662498910A1D48C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529C310FAEA61B6E7988629C312A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZNO92PIx2IQ70+DY@nvidia.com>
 <ZNPlGd4/72dahSs4@Asurada-Nvidia>
 <ZNPmpW3/zDnjqxyU@nvidia.com>
 <ZNP0UKGU6id5wfc6@Asurada-Nvidia>
 <DS0PR11MB7529819E78B7F04D99069701C313A@DS0PR11MB7529.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS0PR11MB7529819E78B7F04D99069701C313A@DS0PR11MB7529.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|MW3PR12MB4588:EE_
X-MS-Office365-Filtering-Correlation-Id: c2bcaef4-6c8e-4847-19d2-08db99529463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gF/T4pjN0G9oQTu/NJHzpsh4C9ksTGM9W5fmOvb/cJwf1Gx6G74eLBlNIRqrB0tKHkeu3p0SnIAw6/XaQy7ku37hsWN+zpAMcILLdI8uVKTzMLFTL8gSt00YAyE5H0DW2Kej9OKMkIi8jNg57sddDKBXUJVQc3vgCi7fPT7kujpRtJudCVHSljaSOrk/0G+n2GZLne+FZVcEiz3pVw49K1RwefN9N/zJMU+pU6E+rFzY7dIGZKeexrbLKdyC8U57Cf4vkAihhrkdLbX01yfXrRZOncrGCHGgDoYHmzg8v/CdpW1vFYVC62m1Sp/CKolUaPMTYXQaJELUGhoWaugWfboBskUZFgiDqc8jzYmaZwnZsHSu+lSONXWXF0yrRdaD70o59ARt4zUEeBI/o+XgfU4Z75eOWHoRkMuLwuMPFBCY80lKg6uwrUpYsIolX/9VP6DFXmIwuLVsIsTDADwio0x1v4+5bPLEkgxWCgkEq96AhfbBmLm0RHrDrvszui9CPUiLs5KXUnQMQ6uFrpVVB00Wt+9Ta+CFomHLn6rL/FM6EBm5GqsMrtIKnIztQ+El6eVi0Z5pv7QmnfRvl0Bo4eb2aDANlXQdNpMLLdDV40a/qYqadD3IuxH8tpUdFVWUyoZRs/HMoGPU3Xn2vTxho1G3s7EAAmrchvpwVhKx829+mTNbq0pkLVTJo2+EByfM2mn5C+3VmmtOYH5YKV+LZZnHR8mZlmnXKwBrT+whL1OHltlvvKAoYG444T/0wusi7TYZRRJIyT+IEZSfENxBgA==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(186006)(1800799006)(82310400008)(40470700004)(46966006)(36840700001)(33716001)(55016003)(5660300002)(41300700001)(7416002)(8676002)(8936002)(40460700003)(86362001)(4744005)(2906002)(7636003)(356005)(40480700001)(82740400003)(36860700001)(54906003)(478600001)(83380400001)(966005)(9686003)(336012)(47076005)(26005)(426003)(70586007)(70206006)(316002)(6916009)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 03:33:35.8166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2bcaef4-6c8e-4847-19d2-08db99529463
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4588
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 10, 2023 at 03:28:10AM +0000, Liu, Yi L wrote:

> > @Yi,
> > This seems to be a bigger rework than the top level struct. Along
> > with Jason's request for fail_nth below, we'd need to bisect the
> > workload between us, or can just continue each other's daily work.
> > Let me know which one you prefer.
> > https://lore.kernel.org/linux-iommu/ZNPCtPTcHvITt6fk@nvidia.com/
> 
> Let me address the fail_nth request first. You may rework the
> iommufd_get_user_data(). If I can finish the fail_nth soon,
> then may help to lift the array to the top level. If not, you
> may make it as well. 😊 I guess I need some study on nth
> as well.

Ack. Am working on the iommufd_get_user_data() already. Will
continue the ring buffer thing.

Nic
