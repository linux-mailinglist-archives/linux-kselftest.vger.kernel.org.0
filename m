Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2C66C6160
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 09:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjCWIMj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 04:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjCWIMe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 04:12:34 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5E121A36;
        Thu, 23 Mar 2023 01:12:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaId6YBKgzDlcraH5hM9J0SpbAa5ikGNEhAN5hVAax2wHPk/kWqERkn4vXlBdPKzM17qFl3Czn+T/I+/e9zVHB9NTvNWS5aR5VGCJr3Cdk6sIwrApaXXNb7XedVvd2Z1rHisxMwEk9Sp65A/ZCF4FJgtJxgOeCND71pfQcktKK7Mf+bzv2n1mxWoQI8iyv5ibOpxyAFKYOfzK6tcY4oIfMuYgzhx1BuDhEcKALWJ32v1V+Q9CBYrvj4O43R7YhK6QdlLxbtvf+OsWSJXvTgK9mfzXocSYqi5eUFxMED0cb3wniia9VThilWRPok9ov1fTu9pG4BCTp7K94x2PB8BfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ic2Pomu/N1kL13XS8RisnSvfbpskDO10eKprZIe2/E=;
 b=T9NMDXHatvzoBC5nD0oNTcxJ+BFQ6kAa6BLyP9L16YuDC3YO3lz/9h7bB+ZSvkhXFHsxdCsk94YLN/zQo0IXvkTjlwWbjdZnrhUJ/g1W9cgxgcidEJFsh8kJE7z/Jy4UKZznOrUY4pky1dqojSZ336vAjLz/8WeQfvtrmcBJ+59ufs1lY0yT+JoUo0pm/eAH77TwNz1+PNmU9LfPfHinvLE5yCzZuzvyzhUa5mnqlFwpD8jOsAK+B1XRjtEYN7VUw8z512nVZpN8I/shkSr0mLkS+lqe+6IlhpAtrN+/ly29t1NkHBYSS8bhCuMTqBWVVwf/+zbJofQbxQbvr77x2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ic2Pomu/N1kL13XS8RisnSvfbpskDO10eKprZIe2/E=;
 b=hmov7USYAnMv5RqfTU+V//oLNiYUM0EOhm1lSWiphIk86mlY//M+IKzfQrk/8+8mchpuZ26sn+auEe0rwE9fY+oN247CcWqmWLwfTG7Md1VkLdIzSoAdPaC2jQZd2oSpLZFp35Stnm/WK+NZf2r7wG9BOjdPUc4ZMIHzfQiS+Aupjk4jvtv6x+nWrp6jrGdSsrQXW+/jAJmPcK5NToLFbJu5HDvCqbNTHnJQ5tjMDGDR9oiEysZgBjM5YxvC8WorWFmmIypfWCHr6g4h9PIh+PtP+f8VF6Tjt7Yfe0zJh5EkmQYwNVY6fCxBAE7/o+w5Zez5vp8At20ckH+5KeJJ9A==
Received: from BL1P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::12)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 08:12:29 +0000
Received: from BL02EPF0000C402.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::19) by BL1P222CA0007.outlook.office365.com
 (2603:10b6:208:2c7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 08:12:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0000C402.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 23 Mar 2023 08:12:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 23 Mar 2023
 01:12:16 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 23 Mar 2023 01:12:15 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Thu, 23 Mar 2023 01:12:14 -0700
Date:   Thu, 23 Mar 2023 01:12:13 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
CC:     Baolu Lu <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 05/12] iommufd/hw_pagetable: Do not populate user-managed
 hw_pagetables
Message-ID: <ZBwJ3SrTZpM1fW8D@Asurada-Nvidia>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-6-yi.l.liu@intel.com>
 <b0ea86fd-8350-f694-a93a-a8ccecd0c8e7@linux.intel.com>
 <ZArTN9tIDKuvmuje@Asurada-Nvidia>
 <DS0PR11MB7529C74B5A37F745AD822C5FC3879@DS0PR11MB7529.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DS0PR11MB7529C74B5A37F745AD822C5FC3879@DS0PR11MB7529.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C402:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: d0631502-94f7-4417-73b4-08db2b76587d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y1Tiqd/VX55n5sjntkKPiUXnToDtzQkXZ19Qx4ljnM2BQsgjzg3Dxb+I+lghtsxNoAuazMkMl3CWEC1jYECnG65i6HwnSEVrYTwRhJWpjR3IR+7OGHYNZj+sxbOfiEYB6J/PeLKkyAqW35L9U1iOmEKttRJrtWMJDN9VoumVv2iEvMPjKlxmIzcuSk79XYxrs5xqKkT/AEaOuqIq26oFvahBoTFSN5N5yeam1H+kzANRgLZbrTM2B4o6ET2Q3ZO5Mk3+L7MVZ/8TszeTGaMGS/yvUmIu7oHNR7sC1hMzYaVt/unMc86DSDNi+r0b4VUGm6UaIS/GPpKUsnjc+bKBfjk3F34Ay1YtM4P54V3QJWe/pEEfAk5bknaEaNSfuLgA8vcaO10/MnzgTALarW3zF/E95mTH6/lnZcMilXfOtHnITQk+1no/ycnriGMNqH18z5h9fMlcQVdhlFWeDe7o/76QF8TtnhjQGRonoNo5hOEqwPmGritFmRNYCVqAPNq0zRyqKeUdMPh9il9BhrJHMxMYXhYjuJwfGQrfvaV+Hq37iy72Xe99BEl1us7OR1jxJWGv7heM6vpdcBdl1/BSP2mIww7yWRHAiC8UzktBY0qPDpB+mWvOLMWPjXNZOqfGbr5f7eewupM1J5OAELvMQkuJ6LD7H6d3C2qEEv3xW1WTUHgaWongm/JAsJOaY7uG7viSwmvLlsxFVbdDiZzuvTmH3l/zAp6RzGJ43oRKrbCQ69DDa9nxtSB/DvfsiwhI
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199018)(40470700004)(46966006)(36840700001)(55016003)(356005)(40480700001)(2906002)(40460700003)(478600001)(83380400001)(336012)(186003)(9686003)(86362001)(33716001)(82310400005)(316002)(54906003)(36860700001)(6916009)(8676002)(4326008)(70586007)(70206006)(426003)(47076005)(26005)(53546011)(8936002)(7636003)(7416002)(5660300002)(41300700001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 08:12:29.2090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0631502-94f7-4417-73b4-08db2b76587d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C402.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 23, 2023 at 08:06:26AM +0000, Liu, Yi L wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, March 10, 2023 2:51 PM
>  >
> > On Fri, Mar 10, 2023 at 10:25:10AM +0800, Baolu Lu wrote:
> > > External email: Use caution opening links or attachments
> > >
> > >
> > > On 3/9/23 4:09 PM, Yi Liu wrote:
> > > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > >
> > > > A user-managed hw_pagetable does not need to get populated, since it
> > is
> > > > managed by a guest OS. Move the iopt_table_add_domain and
> > list_add_tail
> > > > calls into a helper, where the hwpt pointer will be redirected to its
> > > > hwpt->parent if it's available.
> > > >
> > > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > > > ---
> > > >   drivers/iommu/iommufd/hw_pagetable.c | 20 ++++++++++++++++++--
> > > >   1 file changed, 18 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/iommu/iommufd/hw_pagetable.c
> > b/drivers/iommu/iommufd/hw_pagetable.c
> > > > index 16e92a1c150b..6e45ec0a66fa 100644
> > > > --- a/drivers/iommu/iommufd/hw_pagetable.c
> > > > +++ b/drivers/iommu/iommufd/hw_pagetable.c
> > > > @@ -43,6 +43,23 @@ int iommufd_hw_pagetable_enforce_cc(struct
> > iommufd_hw_pagetable *hwpt)
> > > >       return 0;
> > > >   }
> > > >
> > > > +static int iommufd_hw_pagetable_link_ioas(struct
> > iommufd_hw_pagetable *hwpt)
> > > > +{
> > > > +     int rc;
> > > > +
> > > > +     if (hwpt->parent)
> > > > +             hwpt = hwpt->parent;
> > > > +
> > > > +     if (!list_empty(&hwpt->hwpt_item))
> > > > +             return 0;
> > >
> > > What is above check for? Is it "the hwpt has already been inserted into
> > > the hwpt list of its ioas in another place"?
> > >
> > > If so, is it possible that hwpt will be deleted from the list even when
> > > this user hwpt is still linked to the ioas?
> >
> > It means that the hwpt is already linked to the ioas. And the
> > hwpt_item can be only empty after a destroy().
> >
> > With that being said, after I think it through, perhaps Yi's
> > previous change removing it might be better. So, it could be:
> >
> > -------------------------------------------------------------------------------
> > +     /*
> > +      * Only a parent hwpt needs to be linked to the IOAS. And a hwpt-
> > >parent
> > +      * must be linked to the IOAS already, when it's being allocated.
> > +      */
> >       if (hwpt->parent)
> > -             hwpt = hwpt->parent;
> > -
> > -     if (!list_empty(&hwpt->hwpt_item))
> >               return 0;
> >
> > -------------------------------------------------------------------------------
> >
> > I was concerned about the case where a device gets attached to
> > the nested hwpt without staging at the parent hwpt first.
> 
> I think I was convinced with the reason that this helper may be
> called by allocation for both standalone s2 hwpt and the nested
> hwpt. So my change was not enough. Yours covers both cases.
> 
> > But,
> > the link between the parent hwpt and the IOAS happened inside
> > the allocation function now, not attach() any more.
> 
> Not quite get. This helper is also called in the allocation path. Is
> it? Anyhow, with Jason's comment, this helper may be reworked.
> We can sync later on the next version.

We previously had this link_ioas() in attach() routine so we
needed to make sure hwpt->parent got populated, because the
device could be attached to an S1 HWPT directly. But now this
is in the alloc() routine, so by the time an S1 HWPT is being
allocated, an S2 HWPT must be allocated first and populated
already.

Nic
