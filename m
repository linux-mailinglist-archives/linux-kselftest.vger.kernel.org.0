Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97249709FC4
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 21:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjESTOV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 15:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjESTOU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 15:14:20 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AFA1716;
        Fri, 19 May 2023 12:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQbOSfgzkQqiV57VKrNMvbybCbVJ91jqM+Te3i/mBMfB7iz8ncvCZ7dAopBYs2yBivl8jjEa6MiGoQoaVTKODMkrR8mYeMCqt4XAV5eNZ2c0F1TnUE27E+1S2r/qNghkCQlkcY3CdJY8Xb31GiEaQx9HS6b1UKfO5rBP1nn3gguvPuD/UT/hNRCzAyGOs8NmYs3s6db6qhD5VJ7r9Pt4hVMX29hofYVsZVh9BTgjza1ORRv1KGu9L0rbmJzvh8aSVv+A4xJWm+uaaI2f/VKBGx3KGtfn8K6osMo6RATTpdmoR26IL2cBKFrNamrDwV3+IQX+OaqiutUKWqZrTW+IAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dl/WyyBfeeB1KEpB8Ws+VEh905olhnnkh/xk3KAS08=;
 b=YvE+1UuTiwCtRJwjBeK9HBehu4a6sWPuh9QRH2gWQ9gGYze3Vaf64dyheqP4HkB5EleBU1eEnpTRs9L6a0myVaM0FRLxPpcza5YBTCbjUE7jOdFjhHSh/m/7gLbYpq0kPnz3CwzqI1Sb3JSD0bLyIu7ITx8k/pZMQfn/OexJdKhVtrfCBjnOyZgG0RDidVqctkkgHkkNbyTv/nTRIf6TasKSM1YRZKPkngbTimHZjVpAZak8M++tzT/dHLJY3gA4EYTXKoFY/+vuK22gViddupzzmulqlEfXshc5B0trG8ruATvxBvl4aVXomnvwTc4ezTs+hSjbf1eMgoP9EpKMdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dl/WyyBfeeB1KEpB8Ws+VEh905olhnnkh/xk3KAS08=;
 b=fBi5XoMyrrzAW07Nn0LRHCwvpFzBcbr+e1DatiXWwz+9Yr5hmqhJCWDdQCy5f0dPfLGEkcIb267NK9722/bilKLDQLSqKKOD87cJO4+29e4JJF2lsdi5CDD+q8nbjcs9QqMG0/qBLV+iZo9MB6SwNkNgJQxSmR8DT8YRgO1n4M+izSWI3CfEwBiJCvyqn1RjWZUTMfPgABS50jbFjcWbybF6y26IsW3a4k8W8OrS7chz9jZ1FbaZEWeY0/X0Ae+9j2flzdCx7uptnqCMLIsSZ7wSaJmZVkr0MKu5+E/vi8gYz5KauHjPxpQooX/MHWOZXIIwBMHfkCkPBm75411w1Q==
Received: from DM6PR04CA0020.namprd04.prod.outlook.com (2603:10b6:5:334::25)
 by CH3PR12MB8727.namprd12.prod.outlook.com (2603:10b6:610:173::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 19:12:37 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::c6) by DM6PR04CA0020.outlook.office365.com
 (2603:10b6:5:334::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.20 via Frontend
 Transport; Fri, 19 May 2023 19:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 19:12:36 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 19 May 2023
 12:12:28 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 19 May
 2023 12:12:28 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 19 May 2023 12:12:26 -0700
Date:   Fri, 19 May 2023 12:12:25 -0700
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
Subject: Re: [PATCH v2 04/11] iommufd: Pass parent hwpt and user_data to
 iommufd_hw_pagetable_alloc()
Message-ID: <ZGfKGR7NfYzEbIxz@Asurada-Nvidia>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-5-yi.l.liu@intel.com>
 <BN9PR11MB52764DEA24B824F640FA0CD58C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52764DEA24B824F640FA0CD58C7C9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT089:EE_|CH3PR12MB8727:EE_
X-MS-Office365-Filtering-Correlation-Id: db462825-ba81-4feb-3c54-08db589d01b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hPYVcbVmIF9ZbQ/ZRPqLZnZR0jJeWaUJZIKd6LsHglWAiI4Fz5aHuPo/CZnGKKwrkZtMWQOWV9HQ6spWn39W+RDXAbZ+4J1oS4ETjLf7kPc9rYVV3q2xAeTjomdaNnNIlC+pdyHRMrXzb1Jb7NetMPaO0rTUFk7qP61rQO0R+cFIIFBpOIlc19rBMdCb43imHisqyFeAZ9FeHN3jaNh4LUcFcjDvkYbgucesKmYQe/5DQItPyMoMpoFo0FKqetmIGk9I1v806a6setPL26zUTQNZ4tvR35OvBO17gXF6yntdDLFZykfv3tb4Sp+Lt9MFxV1HfiVbnlh/ne5Q966rYPbn/HwVzApTqBeIH+VQGKMGZAs5jXhF01LtWs38EXM8OYZ7gxdJeJi398fIEa+9+aOdhQ0m2inWJvTaEnBqI0kzqgJyfIwJOXtbNhPZ1HG2n3o21caPAH45sCESjLjUacQe27NfeaSYpIDCXuleyzGftRMiovXgBBimp354fZEbGiYKqyBqeqegiLfVYeaklpOMUUctI4sAmUX7Q+k59WAi1OuYjLeMeZNo/W6yz4bZKmJjnxborg1nTs+wQr2V6yXMtXrTGpJ5p0xIuD5KVlTT4MKDLwVD8HdAaPsZsY6YY0p+KX0ZYUf18BkRxs79wwAMhYIkBv3DjzW10cVeMmkgnVWzvD328oOrtl4vyduu9tNMWyxaqVMuiJAKfziaiBVIZ+LAnMe5c97WOcZ06pI=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(316002)(86362001)(4326008)(41300700001)(8936002)(6916009)(8676002)(5660300002)(7416002)(356005)(82310400005)(54906003)(7636003)(33716001)(82740400003)(478600001)(4744005)(2906002)(70586007)(70206006)(336012)(426003)(40480700001)(36860700001)(26005)(47076005)(186003)(40460700003)(9686003)(55016003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 19:12:36.3677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db462825-ba81-4feb-3c54-08db589d01b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8727
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

On Fri, May 19, 2023 at 09:34:38AM +0000, Tian, Kevin wrote:

> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Thursday, May 11, 2023 10:39 PM
> > @@ -89,9 +101,15 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx
> > *ictx, struct iommufd_ioas *ioas,
> >       /* Pairs with iommufd_hw_pagetable_destroy() */
> >       refcount_inc(&ioas->obj.users);
> >       hwpt->ioas = ioas;
> 
> presumably a user hwpt doesn't need store ioas?

hwpt->ioas has the refcount and mutex that are used by a user
hwpt too throughout the hwpt functions.

Thanks
Nic
