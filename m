Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5DB6973FC
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 02:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjBOB6x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 20:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBOB6w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 20:58:52 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB0C233EC;
        Tue, 14 Feb 2023 17:58:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLCll/x+qCo2kOOdihEUHny0fgmV9XFJveajb3Hj+EhIwqo86/Xq7mVgymcdrBstAJW4lyZxJf6x0la/L25a5cQTx8AkiLGavLd8yKBvqxXOx1RssYOKQUe9qbPwOrLQcf5qaBnCHbH0z3alfYxhTsxiCb5K97+zpcoshciYUD5RoO+ykFPd/1AkWuDGXMOTF/9kSlU1V+QVcnwhRceE5EGy4lwFU1rNxl4732jQ7cNVaUqL3pFqG3e7N28UIdetbpzLYdMVllp0IccNwtXPV7ghhNnYNAgcQWthagWy0phxkEjZ+E3cyGgcsGwo01JYY+hmFFH5h+JK9bXswDQC4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GM3kaH1p6m9JdRsrrZHJ3pJQQZ4TolqQSkfF+bV3ChM=;
 b=efnHwIXVniOaXZoVXDO3FLxCMeKQgw+E3EQCi/Lz233aMW1q04NaA0/Ok/+6aAbjXETkAXXvmnW2mUnHEjOp/eTpbyymeGRBQ3RatrgmddJRiVzOH3XpPI3weY96ACw3M/EYbF4485XtCk73yYocTpLhNbvQzbAX1mbGKTUAyAYkZJn4Z+X61uwk/T1sM5lQw7YpPNCu+mEnJ/xHXjcCX8NqlqFIu4GmMcS35+TwTWDpLolfw83lXcWVQjeeYq2WvZ5dveK+qT9Gl5EbgMMOTEbDb3R4TkzBBZRclEnd+Ad2PC6lGs6MEXczVmcuy+wceB/66kOhvLT9hrOcm1PNVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GM3kaH1p6m9JdRsrrZHJ3pJQQZ4TolqQSkfF+bV3ChM=;
 b=iiiITK6xVdZZF1e8Awsrxzq2uVgmoA8du8k7XPMrjM88T0G4cZ0k0VbleWTpLLKndBL/UCqg0LMygfA7djzJ0KchHkA9GU/gmCvHLZiBSQl1eEK5tTcOQF+WO4eZ/5T0JlD+35NJPG6NEBn+fAvbrXEj2C/I8lDfqfEvClOKP+AeqZEtkyLMUUHJwrfDOO4lnKVXZhkMoZ9U6FPfbufRzpKriVLO05eSiWwz1ajP4Yw6EFGwAe3yGbC7ROUC+/0KtSi7VQ3S4IEBXvhWMoUiGf/lRcXLvktPUFN6MguRFGQn7jMKezQDvEpx4XuF6kWolWIA+1jVZTd1hoLWSWoYSg==
Received: from BN9PR03CA0657.namprd03.prod.outlook.com (2603:10b6:408:13b::32)
 by DM6PR12MB4909.namprd12.prod.outlook.com (2603:10b6:5:1ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 01:58:48 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::eb) by BN9PR03CA0657.outlook.office365.com
 (2603:10b6:408:13b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Wed, 15 Feb 2023 01:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.26 via Frontend Transport; Wed, 15 Feb 2023 01:58:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 17:58:39 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 17:58:38 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 14 Feb 2023 17:58:37 -0800
Date:   Tue, 14 Feb 2023 17:58:36 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>,
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
Message-ID: <Y+w8TJ2jfDATftbr@Asurada-Nvidia>
References: <4653f009c3dacae8ebf3a4865aaa944aa9c7cc7e.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276C1807B710CAD3E5820D78CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+Vh479cDD7LX2x/@Asurada-Nvidia>
 <BN9PR11MB5276268D3ED0360913A05C368CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+bc8OrWfw3Fq57n@Asurada-Nvidia>
 <BL1PR11MB5271180A1DE8C739455AD06D8CDD9@BL1PR11MB5271.namprd11.prod.outlook.com>
 <Y+nrTsIz2UHH/1lD@Asurada-Nvidia>
 <Y+pN/vtO8I/oiMOJ@nvidia.com>
 <Y+toXAUa2Cbwn7I0@Asurada-Nvidia>
 <BN9PR11MB5276CBCF780BD7C61154BF8B8CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276CBCF780BD7C61154BF8B8CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|DM6PR12MB4909:EE_
X-MS-Office365-Filtering-Correlation-Id: 58eb9618-0564-4425-d480-08db0ef82d6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RJV9p4eeS46W0CGVyqyq5N4n9+CYyGWebXse/5+vhKayCBoBAXSWY4iVfVvazNlT1I5N4otDjPtUU9HRKckUx5WbxEsQVHolvVMUymC7eI4g4Hql6X+Bm1eBsQXuefxWIk54ah+/FSBiq805MJ6xiqXEV5aHs0gpbOjhmYUtmMGjb8nNmh/KwMAEMdPCIlffkUqAkQzJRvsHFVy8xXMBqXOzs2i3ZXSbzbm2uvpVkFvQ1P7PGdjOiTgdZmjXBogxSJ4Gi/IAm2sqiZjQP3TbWS9z9y6sfYKdgxmsXS/wEX9Drf1ML9+JGAmgadRsedZIj4YaEs1QKMB+e1SI8tj7vqCCyDgCr6c0/BI6Hao0g5uaXPXlGZx+9AmZcQmsYDT5ecaWq6mmdGsiGUtQ5lhGixCwdxrPR0VnnXM+zQT+YwzjHZauW1mpngfXir4LfxS5IHNtkIfxbmdkiuzc3HcKji/PJ4zPIAHOGvp5yk8iL/R3oWYL4wgL+RNN0iFi9eZV0+WQtOOSTAdiNvpeuZkY9VlQbresHmD1+mejFIWV9PdpmpZ8c93rT6kz8SbKqD06cI/JkC1hASwzzEp6yY0aNsgd0IHlNHRgtbozsaZbUt4yK0/aK1hWuNUotag2/NM0ZiYe49ez0rCpjOELnKLyTmx18G/YA07xGovjkbGFBJh4MdIAPjqjlyIIr54YFIr6MizpH1NQrwRBnHFlk28f4iEKJnZVxUH/i4ePNO27fvc=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199018)(40470700004)(36840700001)(46966006)(316002)(478600001)(7636003)(40480700001)(82740400003)(2906002)(86362001)(55016003)(356005)(82310400005)(9686003)(26005)(40460700003)(7416002)(5660300002)(186003)(426003)(36860700001)(336012)(54906003)(33716001)(83380400001)(47076005)(70586007)(4326008)(41300700001)(8676002)(6916009)(70206006)(8936002)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 01:58:47.8164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58eb9618-0564-4425-d480-08db0ef82d6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4909
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 15, 2023 at 01:37:19AM +0000, Tian, Kevin wrote:
 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Tuesday, February 14, 2023 6:54 PM
> >
> > On Mon, Feb 13, 2023 at 10:49:34AM -0400, Jason Gunthorpe wrote:
> > > On Sun, Feb 12, 2023 at 11:48:30PM -0800, Nicolin Chen wrote:
> > >
> > > > What about point 1? If dev2 and dev3 are already replaced when
> > > > doing iommu_group_replace_domain() on dev1, their idev objects
> > > > still have the old hwpt/iopt until user space does another two
> > > > IOCTLs on them, right?
> > >
> > > We have a complicated model for multi-device groups...
> > >
> > > The first device in the group to change domains must move all the
> > > devices in the group
> > >
> > > But userspace is still expected to run through and change all the
> > > other devices
> > >
> > > So replace should be a NOP if the group is already linked to the right
> > > domain.
> > >
> > > This patch needs to make sure that incosistency in the view betwen the
> > > iommu_group and the iommufd model doesn't cause a functional
> > > problem.
> >
> > Yea, I was thinking that we'd need to block any access to the
> > idev->hwpt of a pending device's, before the kernel finishes
> > the "NOP" IOCTL from userspace, maybe with a helper:
> >       (iommu_get_domain_for_dev(idev->dev) != idev->hwpt->domain)
> >
> 
> I didn't see what would be broken w/o such blocking measure.
> 
> Can you elaborate?

iommu_group { idev1, idev2 }

(1) Attach all devices to domain1 {
	group->domain = domain1;
	idev1->hwpt = hwpt1; // domain1
	idev2->hwpt = hwpt1; // domain1
}

(2) Attach (replace) idev1 only to domain2 {
	group->domain = domain2
	idev1->hwpt = hwpt2; // domain2
	idev2->hwpt == domain1 // != iommu_get_domain_for_dev()
}

Then if user space isn't aware of these and continues to do
IOMMU_IOAS_MAP for idev2. Though IOVA mappings may be added
onto the domain2 correctly, yet domain2's iopt itree won't
reflect that, until idev2->hwpt is updated too, right?

And the tricky thing is that, though we advocate a device-
centric uAPI, we'd still have to ask user space to align the
devices in the same iommu_group, which is also not present
in QEMU's RFC v3 series.

The traditional detach+attach flow doesn't seem to have this
issue, since there's no re-entry so the work flow is always
that detaching all devices first before attaching to another
domain.

Thanks
Nic
