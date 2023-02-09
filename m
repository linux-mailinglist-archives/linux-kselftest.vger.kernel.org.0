Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8DB690E3E
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 17:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjBIQT6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 11:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjBIQTu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 11:19:50 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBCF5CBC1;
        Thu,  9 Feb 2023 08:19:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rssut8R6XR08sLWN9OToOOXDu6xNQx5GC60bI+zFpm5HNz7XPlz/BH8zluv4v9Fuk6A4+IyP32FLBoo5kFMwOszbusMa7F7avantGRu/pjJ+nAR2mqSVo1nYHgB0VlxvsDhYxFb3IJR7gwV1lARAu9F3Xn8k2XGrqBmiQSFRLcWTEWr19Zo1MpbsNTpcxB0A2hlyzqrhf1TuKN1DOYYC0mufaOhICO9XXb5ovadQMP+VoCx4wxU1szEp93TKFpu4o4J6KQ8CRx0sk6aTyqp9l3BrmR9uqja8oTIXyVYQBs9XEaTAY4J8PL4IKA0lPaDiP05fy3RSyE/p0NhMLHg8bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CO/ZXq5XATc6aa6+0Ckd/maHZ/f0WVz/Vql93RopThU=;
 b=KfvF8/B3SYszVEpSOJgDB60ij6jLKLVJFEUjPI5SH/5wnonwtb3GxPB8u6fl4vmIRn2tDCoBRTtCTpSilif4eDitsI27+ZelSF3kNP6M8PEHE9mb3DFCqOHArv2dt6qucFKAlIH29zb4fBU4/fi6EyyWPi/I8kgztnqGf3gMVttW+1opKb/sFljAW2KSyTGA9TwzRYoS7hJSsxdKou4Rn51HjY4q/Zm5hSBj/teQ59MCApZiOgJD109tLMKIzXn0ElW5GkUJ1zRJh8ZMK3NYPEK4AFPelcuyNegOPGCy1Fb8F1SfGJ+572RnZS7uq+PLo6yrRg52anEgfNO5xwS3TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CO/ZXq5XATc6aa6+0Ckd/maHZ/f0WVz/Vql93RopThU=;
 b=YnAnsi8ukxFpy3x5d/Cb/iOAnx8L3Dmk8u0xFSzsWFr2eM7VoJQ9wQUBpZ1mYOwKxhTkfU/yrvDAfvpP/l6/nG1HOWSOvEGBSDw0Lg2whyE/ZSA8nGxCYBTCOcOq43dBsMUGV1UKzFgIn3JzunmV/r5wpGre74KWCwPTZa7ScDAzbFGMpXONpHrAu1V/PShisDCeJN4ExoT6lt9o1qOZm10LSZYokgnY9aMaQG8Z69A9a92FeyEYzWdLfM+x72nc/0ryGMvbpYFlehHIXDpXpq8BeW8US16F42sZ9/rqomA1qv0yBWzISIkHJy516N/wxs+aHZwPfMA38N/ljqDbdw==
Received: from BN9PR03CA0339.namprd03.prod.outlook.com (2603:10b6:408:f6::14)
 by CH3PR12MB8281.namprd12.prod.outlook.com (2603:10b6:610:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 16:19:38 +0000
Received: from BL02EPF000108E9.namprd05.prod.outlook.com
 (2603:10b6:408:f6:cafe::c) by BN9PR03CA0339.outlook.office365.com
 (2603:10b6:408:f6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Thu, 9 Feb 2023 16:19:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF000108E9.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.16 via Frontend Transport; Thu, 9 Feb 2023 16:19:37 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 08:19:21 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 9 Feb 2023 08:19:20 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Thu, 9 Feb 2023 08:19:20 -0800
Date:   Thu, 9 Feb 2023 08:19:18 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
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
Subject: Re: [PATCH v2 10/10] vfio: Do not allow !ops->dma_unmap in
 vfio_pin/unpin_pages()
Message-ID: <Y+UdBvoSb90cCa40@Asurada-Nvidia>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <59e5eeac675172ab1cb07236a3eb3e166553fe71.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB527687E27FC35CD842E4EA7B8CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+T0d9ox3KnqMDIL@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y+T0d9ox3KnqMDIL@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E9:EE_|CH3PR12MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: f76cfd41-2942-48af-186a-08db0ab970f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mmDaQRCo8hzKq/Q3D3iK2e/moQnKq4tsF+VKItaA5fP8LGZWpR5FSg3YVLvxqes6/XKjfXvVUN5kxLfUqjYKIybGQC3VCid54LtRaSk72G1eEDVH3B0xBEFhEst4W/7STJJ3VBmW7MgapHB6eOMDRV1sgqsqU/pjcsTbTHgwUKJ83c4nCTDE+ODk+AL3LTQZ8n8xVPihNfqJsHpveuuH5FheeJcri3BTYvHpYFI46HYqZ0kJbKOimWPVKH2FhFDYL4HdGEphjtfqqOtv1qABcKNyXUJkNzcl01cu6UP45AUUsOdnaTBfl1XeVY0lx5G4kTGVToxkLuPCOVcsHZuPCsNFVk2066f7r13Jgia6Po58zCcsFCFTqVuv0X6/g6pQOtBpL1XdTNZU7tfbLcCLG/STlNQcIUDoFrwPCc3woA6esIwVsoHBWtuaZ1NAjWG0Xqik6+dZT8gBGV5LI/IqtA6ht22nSKI2+oWSk4wQqOthGXhPEzv8OBAp4UW7PM3YoZUKaIriYC2P3/BynKRdQufJZbGAjLsySRPxwKYqWVGlGz9QzRhknhsqQ95xCrhFMn1mGJ9Qy8RBbfE7GWNAk28ir5Dz8LwmlSWhcB71y/2NRcwkFjiMK0WYnjXqnKNfuDOJDIpP0nkDc0knmBHJ9ZXXdlTnbCIqWiXIDF+h2YuDpP9JlzNQqAdYcBi7HWeJoV6OfivediN4m+OGUditg4yG4cJKhcoHcmsycHRngxk=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199018)(46966006)(36840700001)(40470700004)(4326008)(70586007)(70206006)(8676002)(336012)(36860700001)(7636003)(316002)(33716001)(6636002)(40460700003)(83380400001)(54906003)(86362001)(426003)(5660300002)(7416002)(478600001)(356005)(186003)(26005)(9686003)(2906002)(47076005)(82740400003)(41300700001)(82310400005)(8936002)(6862004)(55016003)(40480700001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 16:19:37.7876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f76cfd41-2942-48af-186a-08db0ab970f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8281
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 09, 2023 at 09:26:15AM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 09, 2023 at 04:10:04AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Wednesday, February 8, 2023 5:18 AM
> > > 
> > > A driver that doesn't implement ops->dma_unmap shouldn't be allowed to
> > > do
> > > vfio_pin/unpin_pages(), though it can use vfio_dma_rw() to access an iova
> > > range. Deny !ops->dma_unmap cases in vfio_pin/unpin_pages().
> > > 
> > > Suggested-by: Kevin Tian <kevin.tian@intel.com>
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > ---
> > >  drivers/vfio/vfio_main.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> > > index 8559c3dfb335..c7f3251ad6e5 100644
> > > --- a/drivers/vfio/vfio_main.c
> > > +++ b/drivers/vfio/vfio_main.c
> > > @@ -1543,6 +1543,8 @@ int vfio_pin_pages(struct vfio_device *device,
> > > dma_addr_t iova,
> > > 
> > >  		if (iova > ULONG_MAX)
> > >  			return -EINVAL;
> > > +		if (!device->ops->dma_unmap)
> > > +			return -EINVAL;
> > >  		/*
> > >  		 * VFIO ignores the sub page offset, npages is from the start
> > > of
> > >  		 * a PAGE_SIZE chunk of IOVA. The caller is expected to
> > > recover
> > > @@ -1580,6 +1582,8 @@ void vfio_unpin_pages(struct vfio_device *device,
> > > dma_addr_t iova, int npage)
> > >  	if (device->iommufd_access) {
> > >  		if (WARN_ON(iova > ULONG_MAX))
> > >  			return;
> > > +		if (!device->ops->dma_unmap)
> > > +			return;
> > 
> > IMHO this restriction applies to both iommufd and legacy container.
> 
> Yeah that makes sense

Will move them to the beginning of vfio_pin_pages/vfio_unpin_pages.

Thanks
Nic
