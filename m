Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043B2724D6D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 21:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbjFFTpc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 15:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239166AbjFFTpF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 15:45:05 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D900B2134;
        Tue,  6 Jun 2023 12:44:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8S2yfE1N66eB57k9hwfEMtzCakBEPy2xNyX+YcsLS+pWBCm6PvW6mpU3k62raZONFL/5XDo/5B2B7BXCoq+Fjdkizr/rDF3c6slf7Vt9JFIEAgxRNSnqxAbSrgR0Xdyowdr9JK2fPoBiblgwzDQRYnn9Wr60o3AYMv+zPJRzCb+6Vfaip6Su7iu6HV3d+kItVihKgrv8sMAbg5kFyF9rdIvysj+8p8xWgpEDE1kVbEGUYWs5YGom4TeBp7IC+rwCFSNH6Ot7gPOfUtmMRw5vATf3OpNBRPbeQNHY+rbgoe8ZAlxPx2pWjTEYRluD++0nc37xk5eTTyMOHy+9SbqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzwLM7tqhc9OKLlV9fUwWpLi98qt50iX+1TF65zsujg=;
 b=ZtbgeU2h2/2q4MIAgV5/j32H4ZDPLzGAeu5sDqEO55stGfDvp3LNZxx+dMg3aSaFsXYayCo+gfoBJzlkPQ/MAtJRi4hITvEJ1s9A2vSQrFL+xFlgSNm+DYIf8d+zJi49joaei5guFQ1VMQBx4JgWuMQRHENsrVDIE3AxUIHBC3tj/JfucbF7aUwlN/Epd3eDuvRhlSA2gvPqgA8A9MYnBaUN1IVPsFAb4Khkx1Ko50gYkibKvjs2xvIslqRiUyJYcotl7n2k83qyRlgIU5rCBURYuw0UiLF3ug6pkBhbAxm1LZK12a5zabNr12/Cap5daZukvmYRpwfltdRkQ4QdQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzwLM7tqhc9OKLlV9fUwWpLi98qt50iX+1TF65zsujg=;
 b=Z6WdesgTKAHbaURcYnsN1mzhXb4GBuyJwelEoOj3L7ZDRoV6ANcCGjAlBMmfO2oJamtt09ncdcK394cGx+13eGU8dc6V+l6xdQkcsFVetblZOw9EiV2VLNhBvPLtSYE85MeFYBA8P9+ONpfAzIGB3b+lfgjDuBAIBttUPomp3jm21ZDlPifQ1b+DdSVTeV8OYpknBIF4HL4bPVrlhc7QQgw6TIL487blQbfk3ornGg2BMQF8yudqiarzQpT+nnGISF5vYAX88JjPk0KiFmHDIR0dySYLXyvkTh6t+1MXYC//+XF/3boUGZQY9aRhd9S/0bQxKpFF59gYvmtno1oyHg==
Received: from BYAPR11CA0049.namprd11.prod.outlook.com (2603:10b6:a03:80::26)
 by DS0PR12MB7874.namprd12.prod.outlook.com (2603:10b6:8:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Tue, 6 Jun
 2023 19:44:04 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:80:cafe::17) by BYAPR11CA0049.outlook.office365.com
 (2603:10b6:a03:80::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36 via Frontend
 Transport; Tue, 6 Jun 2023 19:44:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 19:44:03 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 6 Jun 2023
 12:43:47 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 6 Jun 2023
 12:43:46 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 6 Jun 2023 12:43:45 -0700
Date:   Tue, 6 Jun 2023 12:43:44 -0700
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
Subject: Re: [PATCH v2 01/11] iommu: Add new iommu op to create domains owned
 by userspace
Message-ID: <ZH+McCPS14Wc25JL@Asurada-Nvidia>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-2-yi.l.liu@intel.com>
 <BL1PR11MB5271B553140BB729AF4389AB8C7C9@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZGfDrRDI50oGih2r@Asurada-Nvidia>
 <BN9PR11MB52766A760580E6FBB995A33F8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZG2fVj41GgosR1dk@Asurada-Nvidia>
 <BN9PR11MB5276F1410A11ED631CE6824F8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZG681VohNlw2vvLD@Asurada-Nvidia>
 <ZH897AGywGVbt51Z@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZH897AGywGVbt51Z@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT011:EE_|DS0PR12MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: de3576b0-930e-4642-5b42-08db66c661d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EBhlW+md1V6cTSKeaRdIj/WeTxh3jBMlTYGXtKGEKNqu5ab7zqXE1fJ+yu4DqDzugc2luV3qgsoJ8fraPJBb9Bamkro7RAz6phG0fLGGg3p1YWuOlIw52c0FwtB69J14uP1xlhAT4Cvue2vPF8QnNeOFFh1Qqljt1VG++JWa054g5nHdkiVi8Y/Bxhs7qKtLI2dGUjggJHGKOWf/sMkoBJnEVbYWE2Yyw89PUx6d47fsKST/sZR946dOwVzfkBVc54v90Kd3eSi6RrN1zdxJkU930sFjGx6MvFD4yl46Ks0dCN5JL+evfoii6sAGV0WmDXwrNamIduk4sGEHaNGFyKdQE5N65dxjZPR1/SnqZVGWme1YtGO1OaRt+XS7D7Z1JIpamROJdt486c79QolREqnq2Cw4iuKwozP5d6ZO6sF/fysTJhtbhJ/LQpKAN32EzFNvSVbjhXA8L3Oj3keXNAVLA+XQUSQaV3vTQswDw4Qx7O36MwjzO+XGOfL3ShfLDc9uFBgzQ6viokc13kmPOmhAmyZoHKkYquj1a01gOoDJlXqb9e0kcBM9ff9ORfSsN8DA1yJnQ8LrcxY4EOYbRdX+At9t/GsOH/XF4bH2g2xQtD3fVVgl2wYfjetZKJEQfZddveaJiWeiiLsAsxC2LWMwCf9iYKO+pfmnjC9lyim0jGcgCdFCchuXCIxE/rN25o8miVfeneqScG6lJe0K2XIi1sSLnqVFhtLHlVPyM/McFVRBrpcpqpGkG8P1kYos9Iafb22Fg5tyRb1Qfyrdmw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(7416002)(6862004)(5660300002)(8676002)(8936002)(4326008)(41300700001)(4744005)(2906002)(70206006)(6636002)(70586007)(316002)(54906003)(26005)(426003)(336012)(9686003)(186003)(66899021)(47076005)(36860700001)(356005)(33716001)(478600001)(7636003)(82740400003)(40460700003)(82310400005)(55016003)(40480700001)(86362001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 19:44:03.2646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de3576b0-930e-4642-5b42-08db66c661d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7874
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

On Tue, Jun 06, 2023 at 11:08:44AM -0300, Jason Gunthorpe wrote:
> On Wed, May 24, 2023 at 06:41:41PM -0700, Nicolin Chen wrote:
> 
> > Upon a quick check, I think we could. Though it'd be slightly
> > mismatched with the domain_alloc op, it should be fine since
> > iommufd is likely to be the only caller.
> 
> Ideally the main op would return ERR_PTR too

Yea. It just seems to be a bit painful to change it for that.

Worth a big series?

Thanks
Nic
