Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BAC709F11
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 20:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjESSaf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 14:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjESSae (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 14:30:34 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::60e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911E4132;
        Fri, 19 May 2023 11:30:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZGOm+v1SlmsOWLZhgu+3g848L/Csc5cYAtAnNGEDl+6x4HcWwG/in7k0Vclggw7MOf+cgEuEI8QxISqqyK25I6XTvmNcoU3+rsyzLFA9Hjc68zbtLvPf9aUP9GpYMhpnJ4orO5bSybrYGeJ8p1BRqEOclqSjjbw3WRV9/Qg2eJCqIFKZu1UnjpebRaASv/xZJtVil+N8A3PD7uLeYhgZKEAcyKdxFl+GVvvkqc6hg282ZULlsigmw6n8a9ZiHprGilWC9DNZViqqSOxldSkYKNUq3jxW7yrYI3vjgnyN9i5shicWMmFwyPkWVoK2VZ2nTezojMLKcrt0129cQMt1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Hp5hbomG0ZEehiPXX1QujU9CzRbKKEEYl/JCOJOWbc=;
 b=dNy2CsoDhXqgUGPWr9Xlr1YYEl0Xw9KQBQ2T6JxC5eFsbaeqjkM4W81sZhXgieKOtVhJSJmec9h+90HalT8XM5IWdB2CGlqnE5SCd55D/bgJgYN3d18XGuvxvlnJoKthnzXPMzIPk9T1bXnYD7lZAW3Jpw/WPlSDlOnh5MN9l49OssNfu4zlbk7ApFhrkX1Yz1us5ITEdy2/9lynQNonhI7zq4uYt62HbfPysdIXPabn74kJ2Kp2xEMXxhsKZ2FF/BZC0xo59tbU6s3FyfxbxLlprODmOkvmF34qUxLWZ7ukvt5DmGO8XBzo0AWkSOHygo9+uNZAze+sWs+ECdhEag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Hp5hbomG0ZEehiPXX1QujU9CzRbKKEEYl/JCOJOWbc=;
 b=f09P0ERX7n2hvCpmsrWsSz60ThAGaf77qtVli1Nf5GK/W+bA7tjyD5MFNbmGGk4d2ZcrlY175AeYkG83cpf1XBuax9hTbuWJ5TcM+B5fi2UlAfaRc3xwa0L7iJx0snCGf93ZiC0aaR34mNGSs4W1yA5Rjo1rTZJMKG/fktspP7YhS92SJ2+50Yh7ZD7zM81v+ZqC0kSEcE9SUnGcp67dHveiDB8rI3/gBaJjX4yjJwuozPhHX0sJsXd30fRBviL/KJgn5eviXtn4joWi2O2eMaAGiFZn0W3zRCZfSY5lQ855F/5eW8g1dt+dpLu1avfDTdHl8zziEEeAJcK+XNMcbA==
Received: from MW4PR03CA0002.namprd03.prod.outlook.com (2603:10b6:303:8f::7)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 18:30:31 +0000
Received: from CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::ee) by MW4PR03CA0002.outlook.office365.com
 (2603:10b6:303:8f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21 via Frontend
 Transport; Fri, 19 May 2023 18:30:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT104.mail.protection.outlook.com (10.13.174.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 18:30:30 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 19 May 2023
 11:30:18 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 19 May
 2023 11:30:18 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 19 May 2023 11:30:17 -0700
Date:   Fri, 19 May 2023 11:30:15 -0700
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
Subject: Re: [PATCH v3 3/4] iommufd: Add IOMMU_DEVICE_GET_HW_INFO
Message-ID: <ZGfANz/aJp2WtXSp@Asurada-Nvidia>
References: <20230511143024.19542-1-yi.l.liu@intel.com>
 <20230511143024.19542-4-yi.l.liu@intel.com>
 <BL1PR11MB527103529CB229A58C2439FF8C7C9@BL1PR11MB5271.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BL1PR11MB527103529CB229A58C2439FF8C7C9@BL1PR11MB5271.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT104:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: da7d642d-efe3-4ffc-a1d8-08db58972056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /RC5ETfrSu6eMYT2HJhzAu6wJQFdoEoFpPh6STEvlahY8qtwwG4XoTuIvD62kKGPVyCPmXCHb6OuOaaaReVxt1/e2UL9p0+AUyQ8aB9Ynm595TmMKb6RgxKweke8S2h9QVuIm5Wy5TPQ++Djljuo3y10a7prsLNVu+7mzERL6O1oCyvd2SkAzrpJgvRkleMHzEntIKT+iL6pSvGDThy/D/AWoRnjxLrrBIP4HsXxJPmTfYxSk65QCZAPOwX8Yd7xb2cNaVyZqpx9SGuH1mFhtqP/YkNbUh/kq6WTzKfC/j+QdzfG+k1sQcbb7tktk1nxXeeqxtLqKMnYimr1ArEZLtqGR8/70XFrKoSc92Pth5uW7+4lUHEBdig5G3emXa8ddamw56sJ7LaxATl4fhLYOmA8GKMV0b09O63zZMmWpEk9DMNXs4lSxAhKpBDgfIOo+BghUAj0/uc7vh2BQJbo0hf9mYSggRx5Ofj0D2h61aXrDetuD0tkze/8SR2XyM26gK8eC8IT9GFyR5uTVkyE8ct8+Kof/7YbFGQXXkhL9yXT9My48IwNiXLtbc4Vjz/ElHKoaQjU/n1uyft/O8rgRk3QdgZ29tH+CA8Pl8ldXq1S090BMzU5UfHFHoMYAhnoOWtP/qbGc8JVdyA8hYIwcSnQxlJ+Z6Wsh9dJe+bLqY3NNM4ZVSAXqT5J0YiUzmlwotpttx2XXIlrlKqhAxmnTe9sUAcatpY7v06WUAWJHCkeG3rA3S6GwM16UOrzUh2Q
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(8936002)(316002)(2906002)(478600001)(4326008)(41300700001)(8676002)(6916009)(54906003)(7416002)(70206006)(70586007)(5660300002)(9686003)(26005)(40460700003)(82740400003)(33716001)(186003)(55016003)(356005)(7636003)(40480700001)(336012)(36860700001)(86362001)(82310400005)(47076005)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 18:30:30.7974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da7d642d-efe3-4ffc-a1d8-08db58972056
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Kevin,

On Fri, May 19, 2023 at 08:42:07AM +0000, Tian, Kevin wrote:

> > +};
> > +#define IOMMU_DEVICE_GET_HW_INFO _IO(IOMMUFD_TYPE,
> > IOMMUFD_CMD_DEVICE_GET_HW_INFO)
> >  #endif
> 
> Here we have a naming confusion.
> 
> 'IOMMU' is the prefix of iommufd ioctls.
> 
> 'DEVICE' is the subjective.
> 
> Then "GET_HW_INFO" implies getting hardware info related to
> this device. then it should not be restricted to the iommu info.
> 
> with that it's clearer to call it IOMMU_DEVICE_GET_IOMMU_INFO.

Though the entire ioctl is tied to the input "dev_id", I think
it isn't really about the device corresponding to the dev_id,
similar to the IOMMU_HWPT_ALLOC having a dev_id input too. So,
I think the "IOMMU_DEVICE" here should be interpreted simply
as "an iommu device". We could also highlight this somewhere
in the header.

With that being said, IOMMU_DEVICE_SET/UNSET_DATA should be
renamed to IOMMU_DEVICE_SET/UNSET_DEV_DATA -- "DEVICE" is the
iommu device while the "DEV_DATA" is a given device that's
behind the iommu.

> similarly for struct iommu_hw_info.
> 
> 'iommu' is the prefix for all iommufd ioctl structures.
> 
> then 'hw_info' is too broard.
> 
> iommu_device_iommu_info reads better? though having two
> iommu's in the name is a little bit annoying...

How about:
IOMMU_DEVICE_GET_FEATURES
struct iommu_device_features
?

Thanks
Nic
