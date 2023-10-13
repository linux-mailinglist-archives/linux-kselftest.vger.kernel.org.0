Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A725E7C9031
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Oct 2023 00:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjJMWWs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 18:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMWWr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 18:22:47 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1A4B7;
        Fri, 13 Oct 2023 15:22:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwuzLOQ+ciZXnB2mzWZhL+/iCcKZ+ywVVYFfAm45xHLwgCe9bO/q01jqWU40d43GfJBPW2+9i32RMH30ZKw1jDM1eyMDmTfT7f7UMQN8llu1+7O+VEPIz7NmVM8dP4T7vl2m0x6aaILdJtHozAp4K3oWMwy+R/uCxJbtHx0gb+WV1uHSyq2w33Aqz5TYOTa4jqp9f1+W2zc7D0RD9/cY7QxW9nBc76sn2EDd38QWGW416rqpp6kC0wNaoHFjUkdNLvHu8HYZzCLhCfkRWfjaMcEf1z/qM91smaEgkLvoWM3g6m9ami4kjPM2TnmzjVXh+C/7lz+LO2E5X5/vQjGJkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyn+TBoJwtb24Rv+zU6dnZ6QuuZg/Lukolnve67yK60=;
 b=m1Iq9PKvacqmsNE/gYFlynQjdQC59PQutwb66Ey21q7/8hv6y7POo5YChX2e0A3eDFYMKYmtXvtGCDlAcJ4e6TFy0JHIyEDwFL515OAspbJ94KnmdZK01YeiQKvzcOWUP1NnhrV1VDCxFmrvrbyQ3rDZO1jVHXCSqo02BuduMSlv++1Ycw5w/65caRUirttSXj6QNTDpFTjrSYHrxA0gKDtV08rBfm1vBsANcvdD0NEcsnAkS+fIdyGOP6iFqfXOJXTBXKJNlI5vIehypI86KAtPx/bHn+ZIUej90clSbKkoNdv6mwvel2XDlgtI4CUshS2OLACTfI+CQHlq4wiuUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyn+TBoJwtb24Rv+zU6dnZ6QuuZg/Lukolnve67yK60=;
 b=qHBD49/KLW9v/gpnLfuE9qe2/VTLCEav11PS0jzZcIL01qwGy80qBbLPc/426fVDY0lE3Cc3UxCgL+RLQTCWLrXTyefojudMc2NyxccOcruVBpLzGfbKTLj/alSLMDKoWa1O4mCcMahjkLSdIEmeSIA1Ayninl7iMJUY5qOEZeaRliUHIAQfbVcHWR6diyaaC7Hf3SLHcnITxVJ0chncCE8IzB7/54PIPdhbErGTEts/rwdoWGjxfRz99mGJj7oDBdz5bn3G/WFNFRj3pxF1YzH1Nsmh+YrMp6USM/DE1ThFo5EObRGibAnJ/yrP/rZjH83sFusW5Qf8xkUROjtbGg==
Received: from DS7PR03CA0123.namprd03.prod.outlook.com (2603:10b6:5:3b4::8) by
 CH2PR12MB4149.namprd12.prod.outlook.com (2603:10b6:610:7c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.37; Fri, 13 Oct 2023 22:22:43 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:3b4:cafe::76) by DS7PR03CA0123.outlook.office365.com
 (2603:10b6:5:3b4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 22:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 22:22:43 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 13 Oct
 2023 15:22:41 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 13 Oct 2023 15:22:41 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Fri, 13 Oct 2023 15:22:40 -0700
Date:   Fri, 13 Oct 2023 15:22:38 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: Re: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Message-ID: <ZSnDLoA90PC2DuNI@Asurada-Nvidia>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <BN9PR11MB52767E1B944C0B2F0667D5DE8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <43b3d605-fe3b-bcd6-a328-81d1448b7104@intel.com>
 <b2097fa9-e2da-04f1-fdc4-a77aeb4a15f8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b2097fa9-e2da-04f1-fdc4-a77aeb4a15f8@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|CH2PR12MB4149:EE_
X-MS-Office365-Filtering-Correlation-Id: 697fedde-4986-4f04-578d-08dbcc3aeb8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yRZOqvRsuRJYUtu7Ff9lIER9AwOr1+/voIqtKfE9YOmNo8236VKoUsqzueR8GMKg2/URP93LQIFZy1zrLlzIwvUQ6o+DWx/W3ozkkHGhyDZAG242uv+Mkpbf8DtASS5JTVTEnJWfyWKgPXsx2iXYAphcA0Rf63mSdbfHqqPVZMgOuX8+QOSGHuZ3uN+SVQu+swyPz2uMs89RbJdGnU9MOoudj6eyGwFyh5gtP9WOe0kzdq718ME6PpgYYdw1peWZ6rCZaVu0JacjEPZPvRVH0+IPOOzloNeoMKAkA+ZtvJDCeO/4wEsGIA9L2Uo63duEn4eSdJgYebOLoVrp2/wj56UvVrCcyfzcJsQ+5d9HokUU/nXKCMQ44c8Z+fvK2YnbflCLjuZzCKSCTZ+2a1M7SzMFqbWn7QAr86USvr94KGjuN4m9Jsg3wmres10R6/CyALd84IaZnzKtqp1g/CSP9sfK7O2AOwjfqElDZdxK9wbfFM1JuHsGMFTm6HbZ8tETtZoEfrTdv7KLl1SDTuYDlDwSvmoBNqSCBTmXYSmxn/afdr+3NLjo9Vcr3Mgx20J+3JBAMnIIxuCZbY1BIalVFBPvRFJs/c0Z/MIM81grF5l11HVEFZq9f2oHPOI2rH+kVPqNx/e6WK/fTvRH+ZihBP2wqy0HSfmNSEl3LfgU8uPhUNdOZ9pNOjE3ztuufFx7V7QpmFpw8r9rY+ABOLrR5d8P0W5DTPHRvlG2RDoLS1Kzd77ZgJkTAbGYElY7Bfk1wfDREQPXeyr+n6mbaUfbgPCLAGJHmp0ni2xw9YGqpUQ=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(82310400011)(186009)(36840700001)(46966006)(40470700004)(9686003)(53546011)(55016003)(82740400003)(40480700001)(40460700003)(86362001)(7636003)(36860700001)(356005)(316002)(47076005)(7416002)(336012)(478600001)(70586007)(426003)(41300700001)(2906002)(83380400001)(26005)(8936002)(966005)(5660300002)(4326008)(54906003)(70206006)(6916009)(33716001)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 22:22:43.3885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 697fedde-4986-4f04-578d-08dbcc3aeb8d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4149
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 13, 2023 at 07:42:50PM +0800, Yi Liu wrote:
> On 2023/10/12 17:12, Yi Liu wrote:
> > On 2023/9/26 14:56, Tian, Kevin wrote:
> > > > From: Yi Liu <yi.l.liu@intel.com>
> > > > Sent: Thursday, September 21, 2023 3:51 PM
> > > > +
> > > > +/**
> > > > + * iommu_copy_user_data - Copy iommu driver specific user space data
> > > > + * @dst_data: Pointer to an iommu driver specific user data that is
> > > > defined
> > > > in
> > > > + *            include/uapi/linux/iommufd.h
> > > > + * @src_data: Pointer to a struct iommu_user_data for user space data info
> > > > + * @data_len: Length of current user data structure, i.e. sizeof(struct
> > > > _dst)
> > > > + * @min_len: Initial length of user data structure for backward
> > > > compatibility.
> > > > + *           This should be offsetofend using the last member in the
> > > > user data
> > > > + *           struct that was initially added to
> > > > include/uapi/linux/iommufd.h
> > > > + */
> > > > +static inline int iommu_copy_user_data(void *dst_data,
> > > > +                       const struct iommu_user_data *src_data,
> > > > +                       size_t data_len, size_t min_len)
> > > 
> > > iommu_copy_struct_from_user()?
> > > 
> > > btw given the confusion raised on how this would be used is it clearer
> > > to move it to the patch together with the 1st user?
> > 
> > sure. How about your opinion? @Nic.
> > 
> 
> after a second thinking, the first user of this helper is the patch to
> extend mock iommu driver. Is it suitable to introduce a common API together
> with selftest code?
> 
> https://lore.kernel.org/linux-iommu/20230921075138.124099-14-yi.l.liu@intel.com/

I feel no...

But I could separate iommu_copy_struct_from_user and its array
drivitive into an additional patch placed before the selftest
changes, so at least it would be closer to the first callers.

Thanks
Nic
