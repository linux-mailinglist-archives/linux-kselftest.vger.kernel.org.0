Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D467709F5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 20:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjESStm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 14:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjESStl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 14:49:41 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1ECE45;
        Fri, 19 May 2023 11:49:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGAfwlzJ4wCEe+RuWYCsEf23RQPN2SDqXz9D1g2L+21AEj83Pso3s8e7w9r0Vyk1ydPmT1ziHtYnCrXi+JMqbiMaPgL2UI41C95f4G74ScEiJ5JJIMHR3YGocUPWTYT7qmOXE0Ewx0DC1Cg5t6mGc9/IBCprtKrc/+RxQapuzlYNjnIsmwzr0y7H6h2nGxOaxN+Wis1Y7rabTJpm3p3jvljemCal13L3dgNUWP1vbbZLf15vXISQnJs7LWMCqIDbkbkhORgVvZoyGFisC74dFShaH4U+nxhPffxzQXqdiAC+wY7TrcoGbFMBdZ2LnaBlCpULE1H/mqbKSc8hgXJOeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0ml7zBR+fE0I9SJ61LwZRJk4o5McbaYZ8P+NPAtlWw=;
 b=ACwJPScxKarIODFByB4l20bwARRPsBFCB77f6bUuJQQebwrW70h/4h+iKuawtjUfcHbqiwMVl4Hbd+VMw8u6PpIG5B0n3MJWV47mdgPw8ILTIoBdmRjREaw4k535YXaEVI8udXFyZfE5MqUTp/VhrI1Ej3Uxr3SkElBjEnmN+oONKIDOLq8wywzoyBLrulbkBxT0zv+KjFvdiam6Phsst55DVljHUXL/xCNltfZKyjxcROJ/IH5dmJpaX7F8O2/Fd4Xva5wbPgP9rAv+5IonPP5GuTszBe8AKtrH1APm8Tl9ioEtceVkDsn1LaJrRXukCVO94LajaTR7e04Dq/OuMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0ml7zBR+fE0I9SJ61LwZRJk4o5McbaYZ8P+NPAtlWw=;
 b=LGyQBkuWpmA6E22osPZQnDpQzc0H8Hmnq3CCZp9hH4BAgmsCZEJEVfp9PwhpVHua34DGi4G/4if87ym8bgea3naJlrxIWy3dCeXiJBnG6YEDqQGedJXBXFo0iz/Wkdd6Q4Epzskhqit5ymLV+Zf54pv+2VR0+QAe1BjhGaPTzrHtvsSHBr5TdCZhUEIjvWQANkYL/oEEa71Fy/xWzW6sBEkANFRk7tuw3xFX2x19IOcWivOT/2qEj7EIxoS/cDKPHmK1hfFxVXpY8nt+wcvccrce8dhDiHURbvx5Mv1qQvwWYfvUrMZrPI5BfuQRJLdZ++QnGWdGRzYczmV3UeBsdQ==
Received: from MW4PR04CA0043.namprd04.prod.outlook.com (2603:10b6:303:6a::18)
 by PH7PR12MB7331.namprd12.prod.outlook.com (2603:10b6:510:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 18:49:27 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::48) by MW4PR04CA0043.outlook.office365.com
 (2603:10b6:303:6a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 18:49:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.23 via Frontend Transport; Fri, 19 May 2023 18:49:26 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 19 May 2023
 11:49:17 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 19 May 2023 11:49:17 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 19 May 2023 11:49:16 -0700
Date:   Fri, 19 May 2023 11:49:14 -0700
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
Subject: Re: [PATCH v2 02/11] iommu: Add nested domain support
Message-ID: <ZGfEqmD0mrE0NTDW@Asurada-Nvidia>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-3-yi.l.liu@intel.com>
 <BL1PR11MB52717388249F052433A7FBB08C7C9@BL1PR11MB5271.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BL1PR11MB52717388249F052433A7FBB08C7C9@BL1PR11MB5271.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|PH7PR12MB7331:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a68b89-5a00-499f-0409-08db5899c577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JPi27Un4iTQrem+6WQq6JOF10i9I/QGUMFC+fyIO9a+K7qLH/HGOwaDdzoofR8k+C6IEWtvXTNAtTt8ZGxp3bflszLEhc5l7QwXCrfhjVjGrtNZ46m1URO4e9z8D8CdpOxrSZyOjmxeqSPa8rxG9OJ8oZm3p4WaKyMWhq770a/FvmgEKjL70HsrfCP3kRyz4fFCURCA4gbvjrWc4Cfq/xElUuZeRNbMysPHZgW7OaQ1ACpLmBkidgXlszRGwGwmWeJxUbFHLAs1o93ZKYm8zpQ2NYYSl5EJHArAgmEVQlYJyMX8yVyrtT2+76SHZIsgGlWZmT+byavR0HDGBxrTkXyAcNTeV6uOicdpbhtikQ8WtbajAL1GtnBECq58yJr3aU1yqxzEJb4ILyK/1VS3NGyFzRn5FwCpkyesIVQtu1lZfUOPTTVmr2sdRh7Zv6HjLcodDIlj1EVwhfGktY3Js72R08L4Gyf/TMVxpuBwq3/IxjaHQUgS2u1TnjzIPhuuMSk50w7aQwutro5e3IztYWDyI1moSKGERfJMX9m9gdgeFGUIYZrkByjjyNB5MsC892g4jV5xI+gIt2wp2onCrTYurFiXKO2L+BA4UNwNrfQEHpGLqqP8Cg1bOQZEo6COQeZENwu8cO5xeHAgKshmvIFQtBLlyx+8t+gCsI7gWBvvMZbIP2UcESGO8Txzdk8YTrkDnk0dZ+t/jicPLfjE/TGFRvF3nMP5mZ1fie1JgzndG8GRUFOWPWHyb86BIZzMF
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(6916009)(70586007)(478600001)(70206006)(4326008)(54906003)(316002)(86362001)(47076005)(83380400001)(9686003)(26005)(186003)(336012)(426003)(36860700001)(41300700001)(5660300002)(8676002)(8936002)(7416002)(4744005)(2906002)(33716001)(82310400005)(55016003)(7636003)(82740400003)(356005)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 18:49:26.8271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a68b89-5a00-499f-0409-08db5899c577
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7331
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

On Fri, May 19, 2023 at 08:51:21AM +0000, Tian, Kevin wrote:
 
> > @@ -346,6 +350,10 @@ struct iommu_ops {
> >   * @iotlb_sync_map: Sync mappings created recently using @map to the
> > hardware
> >   * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty
> > flush
> >   *            queue
> > + * @cache_invalidate_user: Flush hardware TLBs caching user space IO
> > mappings
> > + * @cache_invalidate_user_data_len: Defined length of input user data for
> > the
> > + *                                  cache_invalidate_user op, being sizeof the
> > + *                                  structure in include/uapi/linux/iommufd.h
> 
> same as comment to last patch, can this be merged with @hw_info?

I think it's better to keep them separate, since this is added
in struct iommu_domain_ops, given it is domain/hwpt specific,
while the hw_info is in struct iommu_ops?

Thanks
Nic
