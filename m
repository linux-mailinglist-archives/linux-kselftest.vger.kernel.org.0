Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE4A697735
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 08:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjBOHPh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 02:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjBOHPg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 02:15:36 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129782B2AD;
        Tue, 14 Feb 2023 23:15:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FS99HQmnMAqwOMKhTYU76ZnoS3us5iLk4/lkgIHhF+jNho8Cq52hQpIlFZJtOrYt2QC22huh4+c73KBGq7qxW+789Hu+xGCs5LyydBxE2DZc33APhTZi5y7Uj7pZD1FRILXu9d3J2NXDS0vYSCZi6ZJG17UUhzLEDNC1k8JrQEcPsJKrAff1Nj3J6fh4VYdfTYtNWtwJnRFtEbtavXzmcNGmppZYrWLtQ3kN64wb9aHCShnFOlHreZVhdXW3UuVA7asSwmsYmoxY0yngMpHcy8LBGZKu7Vjh4aEgGjkaIBwhc4YOhhyCatl2x8/XgeYQT5mBD/OrX1H4cuEbKVdS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17L/s8XSEN/eKHlJ0/CR24LrkV5Chr8IY3zFuneBlGw=;
 b=bGb459jOGXlUKOuw8fjGhqWDi3BT41l3qDLMxo4tC4dDpmvA0AKjHlp15qhg7HwRiEk6atODb5+uzoiX7B4Iy5q80UV3w2n70S2wfzkUqk7lr4pDGWThUbEyXLyz4QcDF8J6gkIAkqJvS8FOoG2IdUIXOl1X43hOWXRzbLm1lw2zJZgJxpDhgfsuV4uQ1OZEltnDXlx0dDACjSm1KuNQO8/5mi7YEgVindhcoynWacJmqGnP5M/+ZfgOEahfGPlGp+CdV6UYB4BTNBaZNmNJDC2yLFsn/R86ljVc316U2OT4C7ehrUurQTtzUimNVKoprvnwy6rWDbBvCjlQit53gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17L/s8XSEN/eKHlJ0/CR24LrkV5Chr8IY3zFuneBlGw=;
 b=FThWtUCfOBfozF8EYoApxEZ/AYKo2wqvXfqMfkTbGwtlr6a4wR2gOsB+uca+7r6CgPFvUgVJczoow5eLTHenwD+OXfakS3oKhzHGqrpqUbodrZGPdfBRXMXE6HAMGCtn3ZULAZi54Ys6cqmYzJAUvKwYVJ+pM+bBjKywzaGLiY1DQq3nj6gkOWWY4O0h5+IjHpYoDQnkb47DOBUY+OR7QW11hvQqW9v+/e5+ajglE+nwL5hUPELcOj1ZQMmtN0F8N1yMkLhO+xcH/SNXGhjROUJnVREojFC+s2+kcbRWGLEQYD3VU8RYuFLBN34SbjxoaYm562Wt/Z+jZCIC3brDIw==
Received: from BN1PR12CA0023.namprd12.prod.outlook.com (2603:10b6:408:e1::28)
 by DM4PR12MB5198.namprd12.prod.outlook.com (2603:10b6:5:395::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.28; Wed, 15 Feb
 2023 07:15:26 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::63) by BN1PR12CA0023.outlook.office365.com
 (2603:10b6:408:e1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Wed, 15 Feb 2023 07:15:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.12 via Frontend Transport; Wed, 15 Feb 2023 07:15:25 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 23:15:11 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 23:15:11 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 14 Feb 2023 23:15:10 -0800
Date:   Tue, 14 Feb 2023 23:15:09 -0800
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
Message-ID: <Y+yGfXYlumqOU5xj@Asurada-Nvidia>
References: <Y+Vh479cDD7LX2x/@Asurada-Nvidia>
 <BN9PR11MB5276268D3ED0360913A05C368CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+bc8OrWfw3Fq57n@Asurada-Nvidia>
 <BL1PR11MB5271180A1DE8C739455AD06D8CDD9@BL1PR11MB5271.namprd11.prod.outlook.com>
 <Y+nrTsIz2UHH/1lD@Asurada-Nvidia>
 <Y+pN/vtO8I/oiMOJ@nvidia.com>
 <Y+toXAUa2Cbwn7I0@Asurada-Nvidia>
 <BN9PR11MB5276CBCF780BD7C61154BF8B8CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+w8TJ2jfDATftbr@Asurada-Nvidia>
 <BN9PR11MB5276FA23E61977389D0C1A198CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276FA23E61977389D0C1A198CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT060:EE_|DM4PR12MB5198:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f96024b-ef03-4c7e-a58d-08db0f246922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xljVYnFXBI2/EiAysbSNitCkow+ra4Tu7RkVSKmOFRwfPGGAYJi+hP5PsLTAekSEZzHTpiBGZxxWK2IfxaDLelBH/Lv7odrvqVuzWCppPZIw/rAg5SNKHsIQww9qnf7AEjx4HvVuCm4on5+YWytyaBf2eRe72389RcCIro62UzypYopfRN8tSkJSp7v0+3Kl5b14yUailKoPcnLnllk5R/7MLv75l6qk5zq24KaS8yQLlX2p+jsZNAZghQIzdeUSwaPjBDv8RUBiK7qQLhhcoEoxtJ7OhYHTBPrUVX8CC/wKATpvuGVl6itG7oY+K70iIDYmDwzEZRF4+uZkLcev+FxTfHRKMNQBvpvxi7szuEH3EVVPb6xzz2AzU2aGdYYZdsmIiuzigt9ZaWyRfKuTiq/I93QdLDsUpEDLtK5QkDIukFzfTC5cp+3mAfmEY+VnYDWOKZmbHQNrRXDrta15EX557j6YB/0CrYmpNJJ4733EwotsIRlOZQzXDq0QM8EojPdWJhtvLgpihrF+4D0CKd/IenZv3gmHRouS6IYPt1VcuANjnkXbdPw31n4HavXxnE9Cbt6snQxLb1aHceaQZxAuBM7FlYmlqQZLFDYMl+DnvOIuBjjKTvH3Lz2sspG3vuIO5NiyR17WDjGQ1rQywjW7UT3DLS8ieE0i7Y8+paapnHYocEJg10XNSBDFB2Bj94Kb5rg4ysblTERAM9eyHF81MDfL2L2oqvQfFxXlbeg=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199018)(36840700001)(46966006)(40470700004)(54906003)(316002)(4326008)(426003)(70586007)(47076005)(83380400001)(356005)(5660300002)(8936002)(40480700001)(33716001)(36860700001)(86362001)(55016003)(82740400003)(82310400005)(7416002)(41300700001)(7636003)(70206006)(8676002)(6916009)(2906002)(478600001)(186003)(26005)(9686003)(40460700003)(336012)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 07:15:25.7987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f96024b-ef03-4c7e-a58d-08db0f246922
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5198
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 15, 2023 at 02:15:59AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, February 15, 2023 9:59 AM
> >
> > On Wed, Feb 15, 2023 at 01:37:19AM +0000, Tian, Kevin wrote:
> >
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > > Sent: Tuesday, February 14, 2023 6:54 PM
> > > >
> > > > On Mon, Feb 13, 2023 at 10:49:34AM -0400, Jason Gunthorpe wrote:
> > > > > On Sun, Feb 12, 2023 at 11:48:30PM -0800, Nicolin Chen wrote:
> > > > >
> > > > > > What about point 1? If dev2 and dev3 are already replaced when
> > > > > > doing iommu_group_replace_domain() on dev1, their idev objects
> > > > > > still have the old hwpt/iopt until user space does another two
> > > > > > IOCTLs on them, right?
> > > > >
> > > > > We have a complicated model for multi-device groups...
> > > > >
> > > > > The first device in the group to change domains must move all the
> > > > > devices in the group
> > > > >
> > > > > But userspace is still expected to run through and change all the
> > > > > other devices
> > > > >
> > > > > So replace should be a NOP if the group is already linked to the right
> > > > > domain.
> > > > >
> > > > > This patch needs to make sure that incosistency in the view betwen the
> > > > > iommu_group and the iommufd model doesn't cause a functional
> > > > > problem.
> > > >
> > > > Yea, I was thinking that we'd need to block any access to the
> > > > idev->hwpt of a pending device's, before the kernel finishes
> > > > the "NOP" IOCTL from userspace, maybe with a helper:
> > > >       (iommu_get_domain_for_dev(idev->dev) != idev->hwpt->domain)
> > > >
> > >
> > > I didn't see what would be broken w/o such blocking measure.
> > >
> > > Can you elaborate?
> >
> > iommu_group { idev1, idev2 }
> >
> > (1) Attach all devices to domain1 {
> >       group->domain = domain1;
> >       idev1->hwpt = hwpt1; // domain1
> >       idev2->hwpt = hwpt1; // domain1
> > }
> >
> > (2) Attach (replace) idev1 only to domain2 {
> >       group->domain = domain2
> >       idev1->hwpt = hwpt2; // domain2
> >       idev2->hwpt == domain1 // != iommu_get_domain_for_dev()
> > }
> >
> > Then if user space isn't aware of these and continues to do
> > IOMMU_IOAS_MAP for idev2. Though IOVA mappings may be added
> > onto the domain2 correctly, yet domain2's iopt itree won't
> > reflect that, until idev2->hwpt is updated too, right?
> 
> IOMMU_IOAS_MAP is for ioas instead of for device.
> 
> even w/o any device attached we still allow ioas map.
> 
> also note in case of domain1 still actively attached to idev3 in
> another group, banning IOAS_MAP due to idev2 in transition
> is also incorrect for idev3.

OK. That's likely true. It doesn't seem to be correct to block an
IOMMU_IOAS_MAP.

But things will be out of control, if user space continues mapping
something onto domain1's iopt for idev2, even after it is attached
covertly to domain2's iopt by the replace routine. I wonder how
kernel should handle this and keep the consistency between IOMMUFD
objects and iommu_group.

> > And the tricky thing is that, though we advocate a device-
> > centric uAPI, we'd still have to ask user space to align the
> > devices in the same iommu_group, which is also not present
> > in QEMU's RFC v3 series.
> 
> IMHO this requirement has been stated clearly from the start
> when designing this device centric interface. QEMU should be
> improved to take care of it.

OK. It has to be so...

Thanks
Nic
