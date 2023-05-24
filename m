Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F19670ECFA
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 07:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbjEXFUN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 01:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjEXFUM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 01:20:12 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B1B18D;
        Tue, 23 May 2023 22:20:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HT/HYn/VPmDK8ELiMouIg4hx4pvV20IPwSPXFV0JcmT3Zl2sUMq3bvnYqcmybukrEbArOBVUduH0mCU5zFKP6dePPGM1ViGD1aWH662Y99daY3YpMfOede8ilRnvD8iH6DB4fZsnHSgj2kGsbA/F3NrBK12yFRiXYyuDsdz1YZkkQdrqA7sUYAASkx7eX3jcbQfityvx1t31fH01lu/PWSVmMvZBeUszKBfzQLkRVIILLEFVRhG7byrkneE+scxuXdKV53F82CCIsZsFRIBJl3tNB4yLjJNcOtyKKamDdHC7hDmzcmAp4lrn9XDf6s2lxD2MGyXh29WSSYH6clYK2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQEJ3NmxWDgRkJZAS0YLalwjPbiw5qyVgjuah3QLLhg=;
 b=im8RRuWiXdru0WRQSNtxaJzwGSBkGcxjAiCKmZJE24Yq+REdonTxlXsX5YnMIJGe0/ApsUcBXaqZIuiFbfUZ7lkLBRKl1PT0AR4/h0EWWqqI1iq2RVJBPNNUPqntcXl098NwlA8B8fjNc/uE+zDf8DlER0Qaj9CPzN0myDBapifwtWFbvrfO7PhrjgnuVPkOzy06GHiB7Xnlz9s9BAE5dZfojk0hhzhFnOjsIwq5bnUdQnkpJlOsoAhIG/liEcQbobPZA/WAM2qq0HinWeg6kOMdiDO6d7y/c5Pfvko66oF5NtKsxdOdW8ITjLRNbtVov3zjw1dcO1FJfi5dzOpUew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQEJ3NmxWDgRkJZAS0YLalwjPbiw5qyVgjuah3QLLhg=;
 b=W01QzkUdjRvuk8QcDguxTlXctR8JqENTLarRSMkDaNAl+cj7GwtK1aQebte6y+z8mzWaC8K93ClyBPva5tT9lZmhMxQ9f3HwnTVdIOFMRWmgTpRMHQ1qw5UvrTruRyBUDsJ5wo7FmTkCzvjenD+Pnn6zZBZkWnxALuXxjeQPnySHcbOozctbEavHKJMEs5sxPKF5XGJ6XztTIF3Vyv/++YKBS+CyJM8wYTApd4csspfyQmentCmv2m35Zld9lgXtYI+DdNrcC7tQKFjufU7JqTfOUefFG8HP4tmvJzzZ6jktL+f0/kuwDEBoQyRp1Z2aZt30vHkWrnqw60M/ROm7ew==
Received: from BYAPR08CA0011.namprd08.prod.outlook.com (2603:10b6:a03:100::24)
 by CH3PR12MB8709.namprd12.prod.outlook.com (2603:10b6:610:17c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 05:20:08 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:100:cafe::ae) by BYAPR08CA0011.outlook.office365.com
 (2603:10b6:a03:100::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14 via Frontend
 Transport; Wed, 24 May 2023 05:20:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.29 via Frontend Transport; Wed, 24 May 2023 05:20:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 23 May 2023
 22:19:52 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 23 May
 2023 22:19:51 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 23 May 2023 22:19:50 -0700
Date:   Tue, 23 May 2023 22:19:48 -0700
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
Message-ID: <ZG2edCPs7qPgABby@Asurada-Nvidia>
References: <20230511143024.19542-1-yi.l.liu@intel.com>
 <20230511143024.19542-4-yi.l.liu@intel.com>
 <BL1PR11MB527103529CB229A58C2439FF8C7C9@BL1PR11MB5271.namprd11.prod.outlook.com>
 <ZGfANz/aJp2WtXSp@Asurada-Nvidia>
 <BN9PR11MB527674C06FAF4DD211B342BB8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527674C06FAF4DD211B342BB8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT017:EE_|CH3PR12MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: d0d7df9d-599e-4e01-98a9-08db5c1689ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 11AUxtb5H+QwjGvO50JULR22Qjw5bYQAhFU2VXl6ZHvlkoasOkDEX3N/++MV+rI9irFZjSOWLdRWjVKJJsRVbMyJZECbgXFen89ugWFlqM1mhDmX6mXpTZ9d3HUwgYoA8RXJljHRoTqyg81q93FYCuFvbNe0pkxf3k8Hd2iyWDKgLOnmALNWrfLSCrwDc/iMCwXowEOs7Gplo7DRBAsMj9c9CfGP+ZmNjcL8CqyjNUpxYhr8CiMztlLcRmB6NfYfYLs7Hhqx04MTq3RcSxXXjRa7KrOIPpL7nSNlC02jmIr40ZOv2NUYIFhbmhCZ7TEieP2V7GssadE9a6HzxSFRgnxQ3/a08oR8Zd0ZrV1svqoQoUxBZYcZsdystrl2p1XOWw0pJGP8tvCXgaZs1g5HPJXR2hac1JQz2qhPR8fqeJEOybp81UBHMMz/Sld+I6OO5m0uye56qVhBg/d0mhTrjBmqWGgwKms+QpjNtMfGkeLIkLSi31w++pJvhwMbquGs7U3oO2wkIhYCux86wMp9qb/tUQOtQK9K1NfXNFsFkk2ATeVdvvZ4Pik6GANn+zZSUhhnUBfHlRVbZ7/Kj5Nkv+WSrbAY6nNu91y56UncvUGoZ6oFCJDcav5BUzcNTQ1gneqJanVQgBThMS2Hoxk28DcFA3Z3Aj0F6FAFqOt5GsTvXzc4bFLZNUFQ6WdnA2zmLizVPfIlZBv9blyUEPxdbPcfgNfyp8PJ6cOdpT/Le3xqd6eRbqnIdNl5GtEfjNBx
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(70206006)(4326008)(6916009)(70586007)(478600001)(33716001)(86362001)(54906003)(41300700001)(316002)(5660300002)(8936002)(8676002)(55016003)(26005)(40460700003)(186003)(7636003)(356005)(9686003)(82740400003)(7416002)(40480700001)(2906002)(426003)(36860700001)(336012)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 05:20:07.0254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d7df9d-599e-4e01-98a9-08db5c1689ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8709
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, May 24, 2023 at 05:00:40AM +0000, Tian, Kevin wrote:
> > > > +};
> > > > +#define IOMMU_DEVICE_GET_HW_INFO _IO(IOMMUFD_TYPE,
> > > > IOMMUFD_CMD_DEVICE_GET_HW_INFO)
> > > >  #endif
> > >
> > > Here we have a naming confusion.
> > >
> > > 'IOMMU' is the prefix of iommufd ioctls.
> > >
> > > 'DEVICE' is the subjective.
> > >
> > > Then "GET_HW_INFO" implies getting hardware info related to
> > > this device. then it should not be restricted to the iommu info.
> > >
> > > with that it's clearer to call it IOMMU_DEVICE_GET_IOMMU_INFO.
> >
> > Though the entire ioctl is tied to the input "dev_id", I think
> > it isn't really about the device corresponding to the dev_id,
> > similar to the IOMMU_HWPT_ALLOC having a dev_id input too. So,
> > I think the "IOMMU_DEVICE" here should be interpreted simply
> > as "an iommu device". We could also highlight this somewhere
> > in the header.
> 
> yes this is a good view of it. with that it's not necessary to have
> a 'DEVICE' notation in the name which looks confusing with dev_id.
> 
> Just IOMMU_GET_HW_INFO for the iommu behind the specified dev_id.
> 
> then keep the structure name as iommu_hw_info.

That'd be neat.

> > With that being said, IOMMU_DEVICE_SET/UNSET_DATA should be
> > renamed to IOMMU_DEVICE_SET/UNSET_DEV_DATA -- "DEVICE" is the
> > iommu device while the "DEV_DATA" is a given device that's
> > behind the iommu.
> 
> this then becomes IOMMU_SET/UNSET_DEV_DATA.

Ack.

Thanks
Nic
