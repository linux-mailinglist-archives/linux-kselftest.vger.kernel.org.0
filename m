Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EEE776844
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 21:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjHITNk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 15:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjHITNA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 15:13:00 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B9F26B7;
        Wed,  9 Aug 2023 12:12:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyDpVutWEe+vx+tr3m9AeZz4xiBX4U5Q30g4zV9yvivsvRdaPPDTOA1CaisdQDeS/pKfeS0QBO5T4Tuska7N6Ir55IHX8ruLA3fQ+nE1mg6pDMjU8vAKJEr+ca5rOsoIshRYHAdqFoebMtFsc/LBVWR5vjpAyAJA+vUYJNTGmOjv9437kRVLK6qYt2p1TUoWQoJo+DkzgsYh64g1/8ws6I1AabztWFiTkC0+r6/D3VH7WKTSGXsvijyHVYe8/szDuS6auUZElw472W0osK1/rvOWe2RnnnECRzC7kixLqIdYez7X+on0H0sI9sSY75ueU1rCmoR/Zv3UGHNR6m2iPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZJta2sP2LC85zJ0Wps8ju/FkO2mf7+jTz9wTDdQsQc=;
 b=XdVr3ocH+4Njklh/T4VZmUWrfGmH+7vProq0Le8duJ8kMeOMOdzKOaSocsb5AcSojvPnxEo51z/2szQdmmd/x9RRLSDpKNpVAVBuy+JktOrytdW/7FX9jhEp/Qy4vT64UVP1n1+NUbhXQAC+jmnZ9+Wg5mu3Ai4xLNbVgSRSaD4c82f/VJPlwQ1il7Cian75JYkVJGP6r4Gz1drfs+N8zyKsg77YA3TWvD3BAJJG2M6IOmgvmMYjWnC19KvFgW/+dzbbnKsnW+5IiY0xRz8lpTStd53xt+lFQg/xFSnPc91mVp8c+3HEtk19U6waQQhSlnfccJlzkhVzLx5Wy3islQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZJta2sP2LC85zJ0Wps8ju/FkO2mf7+jTz9wTDdQsQc=;
 b=bdLDUa6745s5vIySzdmjstzggY9HygVm7/jtnSg4rLpiFhkrFQ+lngMBp9Z8q5ah61zMj93ogep+eHnDmU4ckZj/hGBjLFp2Tk6qgUkFhQ/wmk9i96NiQQso40rj1Dpovi0mOxjhm2oSu4SlKomHBqu4aamwxIYXybsXg9TirSAfmJ1O6rqoJpZhX0YLPTG7DICDgGlzseSuaM9AkJBnN4eum7QgmSoOEo5N1yu/7aZPqPOR8xf2bzPQRAADlPWR5O8Op/KT59ktYThMs/8Mdy2g7q9PAxs4vi6Qb4Jj/8ip4WIXwEamXmuAHWAWmb183ghXFX4q57nUf/2ulFSOlQ==
Received: from BN7PR06CA0061.namprd06.prod.outlook.com (2603:10b6:408:34::38)
 by BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 19:12:35 +0000
Received: from BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::6b) by BN7PR06CA0061.outlook.office365.com
 (2603:10b6:408:34::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Wed, 9 Aug 2023 19:12:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT096.mail.protection.outlook.com (10.13.177.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.19 via Frontend Transport; Wed, 9 Aug 2023 19:12:35 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 9 Aug 2023
 12:12:28 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 9 Aug 2023 12:12:27 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 9 Aug 2023 12:12:26 -0700
Date:   Wed, 9 Aug 2023 12:12:25 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
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
Message-ID: <ZNPlGd4/72dahSs4@Asurada-Nvidia>
References: <BN9PR11MB527690EBAA872A16AE8926F88C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529F4D4DABBE29E9B7BF5C9C30CA@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZNGypUee/U9d68TZ@Asurada-Nvidia>
 <ZNI2O4Upyna5AWDA@nvidia.com>
 <ZNJ+Uv/WJwngosjJ@Asurada-Nvidia>
 <BN9PR11MB5276BFFEC7E12EEBD4503BF08C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529C3646E38542457D7B75DC312A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <BN9PR11MB5276912120F662498910A1D48C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB7529C310FAEA61B6E7988629C312A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZNO92PIx2IQ70+DY@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZNO92PIx2IQ70+DY@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT096:EE_|BN9PR12MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 99fc7610-a36c-4db7-4a87-08db990c9724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iW/59q7wEtzMHTIazVvbPSX0i7aIh0zgxvt1RZk1+nNYeJvNfWbdN2Iefds6q1bSr8Z9dmJK2Ij2nPyAO2c65tzNUuzHxDREltjGA3r2lZJ+m4nXmpksshVL+DONTMxIetDN0zJaj56QMDBHXcBK9IqYFKmFwsf6/cDHzpuRPeKltpbwXV0aWZTN7amh3OSd3gDenEYG7w9IP+6lkxhqyeBpt080j5FKSjWQXMEBX9oKdrujgAIjPi05cyK2+xTk1mjl/bZZK8oR6NhppC0/E08Npb6/EMJlEhGIsXhNf6cuAn3pd+wok79IJikcChNfpn9ABpePK+W4FUeORjS6Zj69GnTNF9/T/TN3mrE5MBpJR9Bef9RRbGN2pC773U6fLrJUMXZsm1+sl4XDnskz1R+01LYpy8ZgC4txiOUPHgZyIIKKLCzw20eNdSLmdtyc+Wh4AtiB2HOQnUGUoFtfVbiaaqcULqzSsD5uqr4TDCKmmmX1b9HzIR7A7qm6jzrDoONflANgAV7My9Ii7vwytxL5e//ImMSlSxkP5eV8quGxdmvNSbkIAmxX146VAxN5puGX2WuR3W5pv2vqW84gGHh434+elVZvm7+gC+0auvb7qQQkSrzWJIEM/1o2l987RPTnAXZbgzc1J//OTr+ejTPE0nB+gS9mdyehtm7f2oDLpuAOVYZYVdJYFpwjtZKoWpLKX10pt10v/Ok+4PK/9SWI9O1jsq8dVJV6ypElNvdysA3rZH4TXPLRg3Jf5WQO
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(82310400008)(186006)(1800799006)(46966006)(40470700004)(36840700001)(9686003)(55016003)(40480700001)(26005)(40460700003)(54906003)(7416002)(86362001)(5660300002)(4326008)(6636002)(2906002)(316002)(70206006)(70586007)(41300700001)(8936002)(8676002)(33716001)(6862004)(478600001)(82740400003)(356005)(7636003)(426003)(36860700001)(83380400001)(47076005)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 19:12:35.5577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fc7610-a36c-4db7-4a87-08db990c9724
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5211
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 09, 2023 at 01:24:56PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 09, 2023 at 09:30:12AM +0000, Liu, Yi L wrote:
> 
> > Yeah, adding new structures to ucmd_buffer may increase the size as
> > well if the new one is larger. While for an array, if there is new entry,
> > it is for sure to increase the size. I remember there is one tricky thing
> > when handling the selftest type. E.g. it is defined as 0xbadbeef, if using
> > it to index array, it would expire. So we have some special handling on
> > it. If defining the things in iommu_ops, it is simpler. Selftest may be
> > not so critical to determining the direction though.
> 
> Maybe we are trying too hard to make it "easy" on the driver.
> 
> Can't we just have the driver invoke some:
> 
> driver_iommufd_invalidate_op(??? *opaque)
> {
> 	struct driver_base_struct args;
> 
>         rc = iommufd_get_args(opaque, &args, sizeof(args),
> 	     offsetof(args, last));

OK. So, IIUIC, the opaque should be:

struct iommu_user_data {
	void __user *data_uptr;
	size_t data_len;
}user_data;

And core does basic sanity of data_uptr != NULL and data_len !=0
before passing this to driver, and then do a full sanity during
the iommufd_get_args (or iommufd_get_user_data?) call.

> The whole point of this excercise was to avoid the mistake where
> drivers code the uapi checks incorrectly. We can achieve the same
> outcome by providing a mandatory helper.

OK. I will rework this part today.

> Similarly for managing the array of invalidation commands.

You mean an embedded uptr inside a driver user data struct right?
Sure, that should go through the new helper too.

Thanks
Nicolin
