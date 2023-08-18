Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF37D78035C
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 03:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353160AbjHRBaz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 21:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357069AbjHRBad (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 21:30:33 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20618.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::618])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9FAA8;
        Thu, 17 Aug 2023 18:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaWOBsCPXEL1AxhnikNWM7TzTYYCaFSji4Giqabe3NoH8pIRVXFuKwmu5VOzOh+KiCfnPa13fHaQL96a4ml55bNdmbe4eoG4sSLb4qbRrbUVHPbEqc3bsk2bXnaDroV+ClT+M+DqoTx7woZ25vha211JWAKzybIuPbh3ICQzxgC9bdSziqW0tISpgGX2GLDWfBPmUSWLyH77ccvDFG1CIfu+niu9Rp91u+9MSO0FhI4n7g81iuuNX5s2+wW0ilQQNgl2tQOrBcwYY9+WpTcaPb5TKWyKvbRy2+iXfafLkiLHD5n5EMaCaOUqJHjo+N8Zm4uV1Ao8Gz+C3Armp/L86w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfPqkTmprWp837NvwwK6FjXpxze1xz4eKltoMcvqOOo=;
 b=i7hDJPMN1yVv7GzzZyjwq3P/PZsViGwRdrIBe0WZOvMNXiKqYfD49eNL4WneCwT9eiT6c2vBFyMc3oQlFcaeTvB2tnJzVrXie8RPyl464dnj7FF9OS8Jo1XoRQE4pLysCxP8aw8SdC6gSzVTkeCfXIsf5awiTkCK4TTZMTVgOK2b97CYmsHtrPNgvAzwzkibswABvqnD8P/imODqnR80IZu0JY/oSAtDR7w+5tF/eIECgWetiDCZT+7nBXXWZHQ6ozjFEWi14mAhUtXotQgZqYiPsnVyOsRNpyTZjScwIpjcY4e1ABOvJOWyobw/KMWVL+ziBVtZm22cpArOieIf6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfPqkTmprWp837NvwwK6FjXpxze1xz4eKltoMcvqOOo=;
 b=sCMi2I8ikZwliUaXjKiHVUluzE3+cRt75l3FfD2Gn+AL4SsV3GPzxIs3SPafSD/ZDqAz6s8VAhTmNrFz2TDeG+v7+azRZOXg1dXA1Z/UchHIWUefoTkl6Tt35p31gK4ntM0pMD9Zkhir/lnpWEXYTo760TsedEOy5meRarJbtahUEq0ySWaLRr0ojuniBvjHzmCXOU5zfVV7ly7+wO9/Nm+B2vfU30F6ZRJ3+mTAYLWQpypDM6tFdgeiJutWUAoWhWNqwJ0g+894XEqThTxbOjA+f9Iy5NzufbqecYIuGjPozakSOxpQ9F762z5K2eT26TBF1Afjv7N10A7z8c+lPg==
Received: from CY5PR16CA0021.namprd16.prod.outlook.com (2603:10b6:930:10::27)
 by IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 01:30:28 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:10:cafe::f2) by CY5PR16CA0021.outlook.office365.com
 (2603:10b6:930:10::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Fri, 18 Aug 2023 01:30:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 01:30:28 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 17 Aug 2023
 18:30:12 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 17 Aug
 2023 18:30:12 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 17 Aug 2023 18:30:10 -0700
Date:   Thu, 17 Aug 2023 18:30:08 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v8 3/5] iommufd: Add IOMMU_GET_HW_INFO
Message-ID: <ZN7JoITTrWY+AxTM@Asurada-Nvidia>
References: <20230816121349.104436-1-yi.l.liu@intel.com>
 <20230816121349.104436-4-yi.l.liu@intel.com>
 <BN9PR11MB527620AAA752DEFEECF260918C1AA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZN6MKnCOk7ufYnV8@Asurada-Nvidia>
 <DS0PR11MB7529F6CA52479527F7B87B00C31BA@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZN62flrw24cVcMLq@Asurada-Nvidia>
 <ZN65kwqeP04ptyKq@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZN65kwqeP04ptyKq@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 48dac99e-648f-4917-9a96-08db9f8ab457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: azltl3m+07nYYLO9im7nH4VCb6gDy+YdaGHoWs2KD5rASIJp0jyOlIIaqFCrBYIXTGw8q6A9hqOryJdxlElaIZsxp6CSt1vJYQegF04HaLk7Jwxxmv2MvWEepPGQLsmpiofVDMfZ5pOXpmolx5ERN1sQI1YlR6KdzODQe0FF8uqM1dk4DwR7uQJILeREfZgcYLRGdZjZtYNpF137dF6jCEka8TyV3gz8nm9MZL6w4w9BOl4eazIb+pcWkboTIP68/Bom/3q4Nl9UxQnKePnGmaIVhbJciKLIMeU0RnXUcb/LvJ2EX2ucGp+g5DoA7un1wNFZlN4A03zgY1F83LElU4DuGbeoRkiHmzvWaUO52citc9AonZNAmW8y4Wy2vZr7EJCYMOXHqQZ7QOx03xEOi5OaRgloBlZuQYvk/FfOoYv6Fb7TA/WAXQNHKoSYswZUkCEpD0iiEnRSNDP65sMNxDO34Q2dCxOc2t6oFIrbtGgQ9Xla7CG/oQGxesa7yS3vxNushUKDaH2sJ3YBY/TWfkeBwxsgbl++BsIhEbQFUwWT34R7uK+ZTa5XLOL8eS9poW2VPvDu9GCODdQbjQjE+L9rT7SPpPbGTci/fQUYj2tSRWj8hJvqqF+bnQE6ZnjDDWcAteRtK+x6Rw12hhYzgZlppHd/OUCkKzVoioABhlZJwtXtf49DEPf8Pv5MHwj4UNvTt0FRb/qp3b6Imp7/YV7ix42VWm2uW090oKTmmPIbXKqu3nkgJeQBCqe57uLovSlnOpseYSP+2EasNzwbhA2YPQ1pmsO4Ke0PhRNuUC+92ZHOxohEGR+/VRzB848q
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(82310400011)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(55016003)(40480700001)(40460700003)(47076005)(2906002)(426003)(7416002)(83380400001)(4744005)(36860700001)(336012)(478600001)(6916009)(70586007)(70206006)(54906003)(316002)(966005)(5660300002)(26005)(9686003)(41300700001)(8676002)(8936002)(4326008)(86362001)(33716001)(82740400003)(7636003)(356005)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 01:30:28.1594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48dac99e-648f-4917-9a96-08db9f8ab457
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 17, 2023 at 05:21:43PM -0700, Nicolin Chen wrote:
> On Thu, Aug 17, 2023 at 05:08:34PM -0700, Nicolin Chen wrote:
> > On Fri, Aug 18, 2023 at 12:04:29AM +0000, Liu, Yi L wrote:
> > 
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Friday, August 18, 2023 5:08 AM
> > > >
> > > > Looks like Yi's latest code has not addressed these comments.
> > > 
> > > Yeah. Not yet. In progress to incorporate them. 😊
> > 
> > I fixed them all in my local tree. I'm finalizing with alloc_user.
> > Let me send my branch after that, and you can edit upon :)
> 
> https://github.com/nicolinc/iommufd/tree/wip/iommufd_alloc_user-08172023-nic
> Attached two sets of git-diff for the updates that I made to the
> two series. Note that I didn't make any change to the VT-d patch.

>  	} else {
>  		cmd->out_data_type = IOMMU_HW_INFO_TYPE_NONE;
>  		data_len = 0;
> -		data = NULL;

Reverted this one and removed its initialization in my remote
branch, following Jason's latest email.

Thanks
Nic
