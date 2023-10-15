Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4EF7C983B
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Oct 2023 09:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjJOHOU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Oct 2023 03:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJOHOT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Oct 2023 03:14:19 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4FEDA;
        Sun, 15 Oct 2023 00:14:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdpSwgJRgHSZGwrlZ+NbVlZxgQ+ir846xMjotsgrU9HmYdXE1/K8tLdQCjtQbx83n8QkAM/tgKl52mWAL9aDJ+htgyd+silroZdzY6lg/k7bjvqa9c+P1TKN3syWjFtqImNPlVjyw5T2A78XIrSRf//ltC5HdinOBMggJB28YsZ+bKIXuvelJ/UUg4PoeZUhpJb9l+fBgbVkvRR/e+fmw2x0HbascfxG4LwOPIOhTnNdf/mqVPLVGcxrtz3ZFz4wHdffcUvGHtIYDijenTLx2hDUDTg/xUFyGV+OPYpiagmpZ9jJ2AWq2KUARHAmnS2d/cehu3dFAssEMAdWye6ejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTNoaD1HRrfW/MsTD0wCVJVvWQmO75+gygUQyfLXR6Q=;
 b=ckC7XE+7bSSy61mgmj9SGDh9bM9nVJJ2mup65aGsKaTz16QMKlAe+m2umMB7f07t83iDdTpMU5mIwhSZ8AuD4L20kCPiSRHZEBer/ed5t1YqmBJOmV0wUb9gp/Om6vKG0L3MP4bKKi01yk6BYhqajLGctGwnP/15KImJWGCB3EFs+VmBqPHk0qQl6qLrRJW7XpIaBIcm9C0+ffsZz/6/hQF3fU7D+8lhqku6fby+F3/EweE5vaEa0YDOtD4fwxPyRlW5cn35PMn/gXzxq4kiQ4z7/qyoPsARd9f2gEEzYAeDhO4yPuEwZQ+NsMCn58Vmd9FEQXRlHWStN6igOmcbzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTNoaD1HRrfW/MsTD0wCVJVvWQmO75+gygUQyfLXR6Q=;
 b=FmIhRu0Vd8AFBqzYpjs3sio8qAt+yYuO4v+2cuKeQyHl2L79cRr4kUlKpRka/LnoN1GdkdzzL+3CchHhNQeZBglBQ2KVuPnDGTB+X0J1lXYwkHkqd/sWu4ca7JZ0cCCDHB4folE+RB1rBKgKn3gtpFd+iz5nPht+vL5mbRBMmAlb1d6IVuifJkuEBGyrj2IIBSZrmGKfBTfpLw2WyQZPIHzhZs67wqAwpwPPX93RzHFAkLQoYwsbnJO3g6cvQSMbmWRoUA/UTy5Nj1Ryz17yruCRs2mO5vTb2Yqq3PCKKDIlz37Hw5kSbp87penDAnEsCOHIqsHzLJHmwppLXp8e9Q==
Received: from MW4PR03CA0319.namprd03.prod.outlook.com (2603:10b6:303:dd::24)
 by DM4PR12MB6398.namprd12.prod.outlook.com (2603:10b6:8:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Sun, 15 Oct
 2023 07:14:14 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:303:dd:cafe::ee) by MW4PR03CA0319.outlook.office365.com
 (2603:10b6:303:dd::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34 via Frontend
 Transport; Sun, 15 Oct 2023 07:14:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Sun, 15 Oct 2023 07:14:14 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 15 Oct
 2023 00:14:04 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 15 Oct
 2023 00:14:04 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Sun, 15 Oct 2023 00:14:03 -0700
Date:   Sun, 15 Oct 2023 00:14:01 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
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
        "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
        "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>
Subject: Re: [PATCH v2 1/6] iommu: Add new iommu op to create domains owned
 by userspace
Message-ID: <ZSuROTyaxePoVFA+@Asurada-Nvidia>
References: <20230928071528.26258-1-yi.l.liu@intel.com>
 <20230928071528.26258-2-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230928071528.26258-2-yi.l.liu@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|DM4PR12MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: fafc7f26-c3a3-4202-e0e1-08dbcd4e56a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: isCIWzJOt9LY/yQ+GJ2q9DEHgq9h/ldBVylPFKKMwvXbEZjwjQWe+JLIUIUwK69iOQoRDofYk5vws24BszI8yWk9pwPnoIXt3XndsgmZ1Vwc+C9nsd24iKGSLfMQwrqF3VYz0pyuYr+HHCFIUHsL44wKoJHzHfUV9io8w6v8XixUwxQfVsGF30dTr5CZNs6TedSTqgjo+g4ewXbu6XWgqeZgf+XECV2h3Coc7NnDV8LnTsbzbdUziEDixmcZ9IwjRP9Df0XsgQpHegmXysR4V1YcFaeO1BgNWJCF+q1oboT9NT5eq4jenUZP2j3/h2m6QUnmV6dVDu1n27DLqR1iTTTALSepTHiSE1vb97/IVJQ12zavT7ZqEgfpt3R5LVkho+JIN6SVRTto6CZIna1yo9ICLQL05fZ2wCZoMuPC3UIEg1IGGuMUDRWza6TDTRqnijhG41ZqT1uMkGZosQ7mimRl/4jPdz1aVfaHaBoUvZ4BPIiIwZfB7BRaLJjRsP8+JBt1wWVvYBSU/6rsOirub8RME0bt1kDK9FU6+MltnwvMTcE0h9XFMb9UPum9bHTRt9q2BsV7jydqTIHzRl2WbIth1/Ng6RP2ZEoU/ug5RjvPdZfug66Sq6X0l5KQ/G6m6IdP8oZDWOzTV6ZUWC3wPrdQdOg6kxZkHmuHMLqNDlIz7TfewnQ9hB4gI7FiQfPQ+eEEIw6pFjy4+2vNIjmybri7u47tkLFgY1MTO2xs04FamIJibmtaLMk0mivrp9C9
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(36860700001)(7416002)(478600001)(9686003)(26005)(5660300002)(4326008)(41300700001)(47076005)(83380400001)(8676002)(8936002)(4744005)(2906002)(70586007)(70206006)(54906003)(316002)(356005)(110136005)(336012)(426003)(82740400003)(7636003)(33716001)(86362001)(40460700003)(55016003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2023 07:14:14.6152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fafc7f26-c3a3-4202-e0e1-08dbcd4e56a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 28, 2023 at 12:15:23AM -0700, Yi Liu wrote:

> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index b4ba0c0cbab6..4a7c5c8fdbb4 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -347,10 +347,20 @@ struct iommu_vfio_ioas {
>  };
>  #define IOMMU_VFIO_IOAS _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VFIO_IOAS)
> 
> +/**
> + * enum iommufd_hwpt_alloc_flags - Flags for HWPT allocation
> + * @IOMMU_HWPT_ALLOC_NEST_PARENT: If set, allocate a domain which can serve
> + *                                as the parent domain in the nesting
> + *                                configuration.

I just noticed a nit here: we should probably align with other
parts of this file by using "HWPT" v.s. "domain"? I.e.

+ * @IOMMU_HWPT_ALLOC_NEST_PARENT: If set, allocate a HWPT which can serve
+ *                                as the parent HWPT in the nesting
+ *                                configuration.

Thanks
Nic
