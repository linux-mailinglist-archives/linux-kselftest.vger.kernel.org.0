Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8946928B0
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 21:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbjBJUuj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 15:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjBJUui (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 15:50:38 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B797F809;
        Fri, 10 Feb 2023 12:50:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KW6iNBYWvh4b0IHTIST/5GnQQF53zxgYdtaDmCxiVw8Hv4zm2plp5i+rNnfLbiQA16pch7GasY9QuvdCDMram2nPSQiGRLCEFY8EHz++wV8PQD9nm6diA5tF5JPKkpE1c0p0gBg+sdtxfsMvBl2FBUMJE/YHF2S/MFenxeLKIrYZa9uOaDtbnHddVuqVk1VcY2bMIAl/tQw89otRpW5szZDPuH/xKGAifS8IufI1aFGMZYnan5eg2+vZnfeNA8ZHwpbrzHbzPPX8kwyjt3ekppUB/ciz61etRnOKOpUrdvZCl4a/Dd0dxo63NTb9jesFpW3uTJA5gt92yL/V12HeJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBn3JN/GtnVoWq9EToCCmHG9tbRgb8Kd6B+VZbmFLuk=;
 b=Gxs7xYp1KGk2BZ65OnuVtwVxAEADzxlaSmQ4G8E/jglEeIdoenmy1bYbzpB0p9qjPzYVpqyEEGZGui95m7/zp43FmtehfrLecHYtB/tEUz++XbMnSH0fjhbbkVm8UFLZb4DauEJO4nC+n6CRWhXFmpjliHqdBAl2Lpvwu0Peb0ZKeahBytVQwj1liFPQdz177+SRCQRjZWW7VMFwwqOjSCX0n9HOsakykRkFWFZ5yW/1zhyaaNNnhmpcHKuwVb1O6DgfNdus3D9ugIhnTGcNEUCc0uEZzFLMtPkOR7wOB1netLUdMQDFVmXv3hzeaFBGgrp8Q4TbbY+WL0dfe9nWvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBn3JN/GtnVoWq9EToCCmHG9tbRgb8Kd6B+VZbmFLuk=;
 b=itHXrJc8fkOUz1aTYWZDDniejUBgkyW+1QAAmJaDF3OmzAmQPo1lESOw2PPDcplYxlJ6qZVql0ClDBPEGw4+ff70AZ68zUCusT9VUs+11XWOG18ZIuajIlzXUsjSvHGWhdaHebyEuvGT+6qdecMVyvHT43mWVa6TNODYoV1UKb4F4Skf9pruQXpGYx1A0CLly0RjQoarEH85d7UN7x1/DN/ar8UkQ890CHNfJtMWnp6etukoaovpGpmWM9kvmkXnXRcBAgnzt+ioESalxy9bUxCxrHNhzqM6/wqkr1HppLKe8+6fRjvS8Fr35ePklh4GXz5XlyjRwYVcc2HStuatkA==
Received: from DM6PR03CA0095.namprd03.prod.outlook.com (2603:10b6:5:333::28)
 by CY5PR12MB6227.namprd12.prod.outlook.com (2603:10b6:930:21::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 20:50:31 +0000
Received: from DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::df) by DM6PR03CA0095.outlook.office365.com
 (2603:10b6:5:333::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21 via Frontend
 Transport; Fri, 10 Feb 2023 20:50:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT110.mail.protection.outlook.com (10.13.173.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.21 via Frontend Transport; Fri, 10 Feb 2023 20:50:30 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 10 Feb
 2023 12:50:17 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 10 Feb
 2023 12:50:17 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Fri, 10 Feb 2023 12:50:16 -0800
Date:   Fri, 10 Feb 2023 12:50:14 -0800
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
Subject: Re: [PATCH v2 08/10] iommufd/device: Use iommu_group_replace_domain()
Message-ID: <Y+auBiug3gIXcZgZ@Asurada-Nvidia>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <4653f009c3dacae8ebf3a4865aaa944aa9c7cc7e.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276C1807B710CAD3E5820D78CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+Vh479cDD7LX2x/@Asurada-Nvidia>
 <Y+WJPH3pbYLIs2iv@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y+WJPH3pbYLIs2iv@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT110:EE_|CY5PR12MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 39df0005-1c60-4360-9d8d-08db0ba872c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kk74UvTg0abQXMCxCCyZe/QbWrUYoLGn7es7V5uoAPyn4S0+IlzQ8H2p7pQFnXBjcYTBl8KkTDmiJEc+uqScK+jb7rvvKICqLna+NQzzUA/XWv33kvcFzvx39TlNkwX5ivpy+uYn1YvUxLZrCeStwApf2vZcgUDY/BENga0sDEFyIyx4AFeCgNTOx2l/iT8fVoxT/eszV86ze+wzfx/IEW7EyxBsVknAxir5SWDC3DF4GRHRWB2itkS9xcECX6pAuV4MJlQ8cC4/ThNxLvEPKQLMIwEB1nS2XDV8hfTKvxSET/BQbLtFUj0TZOCD6oVjCIc/Aivj5w9fcXrERJaI+Knubj225IfylNjhwF2nSlXqBrCmTQoOwyEJWtMvpqacaHh8/0/2SYgGjCpDk33wnTyNNxqDNyi70DlQBKMNlt7/yc173n7+nYvUQE/e+T6A3tXTLdxzsyU5RFeLiqZE7CLBRxaIVao/8YKYW/cQhO0lFF06nH/+U3XG7lLw4ESu3wixGrXvxr3zZiLZzsou6j9hC86bh+sGejgQNMJGNX4WV748IWOS3VhVvZMhWPKxCx/FLiCS+fVoIEs1c46SjHugTc1yFCQtS9LUszIEDKiuWarpIDJ+w+dHxdmbbGUHAlpRZmAd2hcdx42oF6yBmyXgQiZ26fi6d/D9N8j7ltnAagERddIxTR6yGWd4qUbznpn/iBGUQHtuC5hTbHuGO9lICdV+/EOKinbUPf/VDJ8=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(2906002)(82310400005)(55016003)(54906003)(26005)(40480700001)(478600001)(6636002)(186003)(9686003)(336012)(83380400001)(41300700001)(47076005)(4326008)(426003)(70206006)(40460700003)(70586007)(8676002)(7416002)(5660300002)(6862004)(8936002)(7636003)(36860700001)(82740400003)(356005)(316002)(86362001)(33716001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 20:50:30.9459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39df0005-1c60-4360-9d8d-08db0ba872c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 09, 2023 at 08:01:00PM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 09, 2023 at 01:13:07PM -0800, Nicolin Chen wrote:
> > On Thu, Feb 09, 2023 at 04:00:52AM +0000, Tian, Kevin wrote:
> >  
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Wednesday, February 8, 2023 5:18 AM
> > > >
> > > > iommu_group_replace_domain() is introduced to support use cases where
> > > > an
> > > > iommu_group can be attached to a new domain without getting detached
> > > > from
> > > > the old one. This replacement feature will be useful, for cases such as:
> > > > 1) vPASID mode, when a guest wants to replace a single pasid (PASID=0)
> > > >    table with a larger table (PASID=N)
> > > > 2) Nesting mode, when switching the attaching device from an S2 domain
> > > >    to an S1 domain, or when switching between relevant S1 domains.
> > > > as it allows these cases to switch seamlessly without a DMA disruption.
> > > >
> > > > So, call iommu_group_replace_domain() in the iommufd_device_do_attach().
> > > > And add a __iommmufd_device_detach helper to allow the replace routine
> > > > to
> > > > do a partial detach on the current hwpt that's being replaced. Though the
> > > > updated locking logic is overcomplicated, it will be eased, once those
> > > > iopt_table_add/remove_ioas and list_add/del calls are moved to hwpt's
> > > > allocation/destroy() functions in the coming nesting series, as that'll
> > > > depend on a new ->domain_alloc_user op in the iommu core.
> > > 
> > > then why not moving those changes into this series to make it simple?
> > 
> > The simplification depends on the new ->domain_alloc_user op and
> > its implementation in SMMU driver, which would be introduced by
> > the nesting series of VT-d and SMMU respectively.
> 
> Since we are not fixing all the drivers at this point, this argument
> doesn't hold water.
> 
> It is as I said in the other email, there should be no changes to the
> normal attach/replace path when adding manual HWPT creation - once
> those are removed there should be minimal connection between these two
> series.

Yes. I replied here earlier than the discussion with you in
that thread. I think I should just drop this line of commit
messages.

Thanks
Nic
