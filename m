Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696F7690E1F
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 17:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjBIQP5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 11:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBIQP4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 11:15:56 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B647D241CF;
        Thu,  9 Feb 2023 08:15:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dq3qovFuxifMsTtCTwUjhw+s1yCbClZJ1bokwMUst7HxaBHLz84q0DfdseaT1L8HtoYeg/qKbD7mHiq7Hewb/Fd4GrbtnhcGVQpiGXAfU8V07IUHUKFm6orxgReox348hhB/nc4IrRJH1+yqqUN0BwLpgT390wRZ0osopE+2sh+cIeXSw5mPHMJ5IjFuMEuzfyjrtTzg4m4c9F3/kNRPHcdLohMhzhMWqB0grf2kZCb3mC2lXY0acXGXxXpy4b3ToYiPy9oQuicbgRV17Eq0S0K2dIwiga9t8GHJZQVj7M5ZMNSdR4gAekZHeAokIWV0U+5bSNk2wPIdu3rVLaoU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyrEpQcmjRmHLlrTCLI1VaHoKdJFbIwwG0SuOZcQekI=;
 b=RCxbnBlW2Y8AcVO4yU3Qx0opBtW8ke/AMkHmhGaMwnGIuCVmJK9EGK8+EsZUWWdU9L68QRLYfhHnK2lDcJqyysfk4pIQnswV4fKv2TuFuJqllQJ8/zhzrxaNOti7gwqGy1YLal8haD51JclnxaMyOZX4+T1CpsdFKMTrxe1idVGANsXx5/Nnk2G2XNMX9eEEdAeihDguFVqzF0ptHPmPzyWgTQVeFEhLL5ZV2cmvIbEBrsizPuHs5FN9VT4AHNWP5DYnT6clptqMBim0qarI64/X+inDBUHl5wSxxaeoOOv1XVQCO27UZGIaWYqex8QyW8Hh7BPzVHNx7eibU/Cuow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyrEpQcmjRmHLlrTCLI1VaHoKdJFbIwwG0SuOZcQekI=;
 b=hPV8FNdpoBNPlDbg/5g1TSUfYXK9uwHcMVat3fH0u0S6VXs1uBRFnLc624fmBt72211XAlZMXkMH+5CnypIBlebOqlRDu5rZqEtlfwO6WsjOu5BqCpWWljqguNX77tJd/TYgAET5AGcj3QddnuEsrH67nUTd/MB+4jd0DcjsOEZyt0VTCR+D3b8o3WVr8k0sexEbKXFkm1Cr7ZZlkW/mUeipRwLxNVIIxM/lQkwQkiYsl4lMNjP8JIDzKm99S5B5No0qAWRiX/Jh+YIBOfc1Yyf+2OkcDASbaHiSRBurB0Sy1DtHcQbVcBsuELfLsZxzFw9Cj6iYmYqkjBK6KT5QDg==
Received: from MW4PR04CA0151.namprd04.prod.outlook.com (2603:10b6:303:85::6)
 by CO6PR12MB5476.namprd12.prod.outlook.com (2603:10b6:303:138::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 16:15:52 +0000
Received: from CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::f4) by MW4PR04CA0151.outlook.office365.com
 (2603:10b6:303:85::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Thu, 9 Feb 2023 16:15:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT095.mail.protection.outlook.com (10.13.174.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.19 via Frontend Transport; Thu, 9 Feb 2023 16:15:52 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 08:15:41 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 9 Feb 2023 08:15:40 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Thu, 9 Feb 2023 08:15:40 -0800
Date:   Thu, 9 Feb 2023 08:15:38 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 03/10] iommufd: Create access in
 vfio_iommufd_emulated_bind()
Message-ID: <Y+UcKphXiwhwj1gW@Asurada-Nvidia>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <6083ba9a3c1d92baf1f324d4748333d80d3de830.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB527662B3BCB562D4E0969C878CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527662B3BCB562D4E0969C878CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT095:EE_|CO6PR12MB5476:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b361e7-9001-4de9-170c-08db0ab8ea99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: seQKRRDSn5h/O8s3nl0pfXeUqRqaGCJUjKmEhQ3GXlc5csx4radwZ/wQNhGgYyUCCKBuP10q3H2XOgCCr4HUFPmQOMOz3SH8K2d79yIsBhjoRWaDF+wVOe+thNcgKEEBQAD6Lz5tnLTIfd7kVL+dPf26qBBwZ60IJrSa+kobBz3jG9CgMyblwR8XCHB8AubE0/fWiQu6PURr4vehzaN/WTE2mv+r1V+8kQ4fH2K6E3yoxgzPvfa1yo5CSpo/dnrFyvwFwKpTECOiDhbjDFppaVqt3J2qpKfxgvqHYyghXeg/MPtcrbEpUY9tnyTa7X1XaqGMzKNaUX7js9d1TXNJ7ONWznhZ4JxTlbuE7CJ4DSx9Gnw22htorRU8ldxTheKoP4tvu6F0+ynUICTv2Oh4zL4cu6AMQlPZnYp9bacDKpXdrcT/bClv3vQo24Pk/kthIw971vhR73MpFWNFQ+eRjs9pbDq7vkCqJwvWUr5hbMfMPCrvAg7p+StnzuIL2xYUfCUTD/1aKbPWd9Rr1KrW+VJh3+vezow1aq3xsVoSV9xou4h9QC+jSKw5R0wfl5hC/i6KIXmU3/6RtShvCSQG/kIlUYPE8RDZrVTGzQb9jfPXpQLbF7xXMCIKztSmxWWGoqltLvJN0tw95hgo3HWsDG7ITu7ztp4ZphswwBL+VD0dCFoIhSBtdSSxaIR/LbDFNHR7ZH6E/6Zk3pAlIQoUsd8xpUzIosz3OYzPd0F/xfw=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199018)(36840700001)(40470700004)(46966006)(82310400005)(2906002)(55016003)(478600001)(40480700001)(36860700001)(26005)(336012)(186003)(9686003)(83380400001)(426003)(6916009)(4326008)(47076005)(41300700001)(70206006)(40460700003)(70586007)(4744005)(7416002)(8676002)(86362001)(5660300002)(8936002)(7636003)(82740400003)(316002)(356005)(54906003)(33716001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 16:15:52.8281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b361e7-9001-4de9-170c-08db0ab8ea99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5476
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 09, 2023 at 02:56:39AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, February 8, 2023 5:18 AM
> >
> > @@ -141,10 +141,19 @@ static const struct iommufd_access_ops
> > vfio_user_ops = {
> >  int vfio_iommufd_emulated_bind(struct vfio_device *vdev,
> >                              struct iommufd_ctx *ictx, u32 *out_device_id)
> >  {
> > +     struct iommufd_access *user;
> > +
> >       lockdep_assert_held(&vdev->dev_set->lock);
> >
> > -     vdev->iommufd_ictx = ictx;
> >       iommufd_ctx_get(ictx);
> > +     user = iommufd_access_create(vdev->iommufd_ictx, &vfio_user_ops,
> > vdev);
> > +     if (IS_ERR(user)) {
> > +             iommufd_ctx_put(vdev->iommufd_ictx);
> > +             return PTR_ERR(user);
> > +     }
> > +     iommufd_access_set_ioas(user, 0);
> 
> this is not required since ioas has been NULL after creation.

Will drop it.

> otherwise,
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

And add this too.

Thanks!
Nic
