Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1711C766336
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 06:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjG1EhL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 00:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjG1EhK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 00:37:10 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D112127;
        Thu, 27 Jul 2023 21:37:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNxq/Uxlt0L4bc/qNuJoWetZaIcMQURYwz/sXonkH+sw4RADWb7CEIw1aHQoWQCus2PNPS0TbDMnRb+NYCIZzAxaQPjzaSXDSQQSaiyOyU0MNZ5ujMWzBihlx/EW8gK6o5KxrVGjZIjBszbfRbhN4upWMmfmdCneaLuvJQ9P7od7BGjf0TnMuCqpMYUMsLeo7wIc4eOJ5Xw1PHVBz27xWZyDG7ZmY3+QIyvn/El4db2mBAEsjiPHgkjwx/IY4s+sVgwuoiqaRsnn1XrcWLexSB2BJo1vG1vWfF05vRHJ2KY57QvvbfmN+QznKcYOD3IEJVvdpVDuMuvDF3OJFT6KIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Hp2XSu/Xf7dUeX/wdm9Nd8HI7/TV3RhI52vZU3UysU=;
 b=CRNZBr9FOSKhSp37n3GutKhtBe2Z7vNIgXaI1us5DYh2/cpd+PqakC3MXheckqTJ77WJIHqCS0bGa5YtK5g86iQUHpNjHN5fr6XenNkwUZx01rrSvvDX/zFqSfgkRhEJcetgcgn6XPD3Jd6rPOjfJ6j1BIE478zy0M+x2vaiR37GlXR43bKlQIzyUcihI4aFE1J21pb1AZJ8YtVgwv/Q48mQIMW1LTWqU9jKWIpwGi1fpRm64hTQLDvkBAxO1YXe1CLBoOWFhBumi3UnHOVmu9TtSTyHK+nCSS3nR2wZozZLcwxeU1Iy++SbOHNutKk1TfRBbHQQZ2WRsOql9giJrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Hp2XSu/Xf7dUeX/wdm9Nd8HI7/TV3RhI52vZU3UysU=;
 b=jOqunReJDkDJtAf12cK1FmWhIhvBhB/2WIRGmQpUHhzQaMpeBnQIcT7dZleKpbhrMEvosSbjzpH88f/VhlH1KMLsOpAgeqxSGOmbjlwF6baNe62aLsTVEhYml9Ea8zrKR9HFWB2abN00E4NxIFYSdVwBSh+Pd1mjnoXP6h+tTmWAfJZsY2Wm2ybeZJ7D101l/hgTcvxkZoAHijLal/RADv8g0lefj5AVpfqPKcBj7ccC4uLVDCUlLy2ctSbWH853vlggV3tDvxuLwZR/+ZLXFY53qsWfeW3YH/EaUeOApDYfQSXBECzvF1TZidfehRXX5G4H6myJKIE2HQjRnmxgsQ==
Received: from MW3PR06CA0011.namprd06.prod.outlook.com (2603:10b6:303:2a::16)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 04:37:06 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::8b) by MW3PR06CA0011.outlook.office365.com
 (2603:10b6:303:2a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 04:37:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 04:37:05 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 21:36:57 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 21:36:56 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 21:36:56 -0700
Date:   Thu, 27 Jul 2023 21:36:54 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>
Subject: Re: [PATCH v10 3/6] iommufd: Add iommufd_access_change_ioas(_id)
 helpers
Message-ID: <ZMNF5vTTp2IRMsWH@Asurada-Nvidia>
References: <cover.1690488745.git.nicolinc@nvidia.com>
 <ad75a1f7f0b4d5b6d35238b4ae7b41db1410110c.1690488745.git.nicolinc@nvidia.com>
 <BN9PR11MB527660F2932964A47396D1E88C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527660F2932964A47396D1E88C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT034:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ee3b257-de0d-4f38-12e5-08db8f244bda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99E+DA3hYSp64WIo0RH3LPeM//39nKbWGZXgOdQ7e+46PSvyXQLWXTfbSpos9ZLuwXQVljymvDOVyA8TcKhh5sl6Q5E567f+ni7z9H3MzpyF0CqbAlT8gwItgj+286/jHESWbKSfh/YQXW6uYZkngogWAp80bxSYp/dsDB03XhPYV5lAiExYlBR70KC8I2vnxQSfYKrsscna0uHa8wWMY0m6blzQxBVmlZt0bu+maZPF4knUpERhC2dz41FjUteebV/rLExopZUiDBafwkCXHglrS7uHAjuzFxTOd5NZCbGl01CLrmkjHlmPHNoXCSB7PUS2hXJn/Kb0nSzvd6zvJ925SaB6DWJOt+GqQRL4OP7AUgKytZWhqWrh0M74BbnmnjF3PVdb2gsflJit+W7I8FCGAYLu0yruBUUkn19ei6MS9K88UeHVPjSpUt6BTlqS3f9MX3a3kNh4EajXIbHGGaGePQkKEJ9sBT0V7mwgA4ZhUJHP5VY0eeDRphqDhEyBZXHm9QkIvz858UHCIzVUUcLP/Sv3s1ON5aTeA1ZfeyKZFzJHg/iExlB9SgIODdALcqeNJ+WsDI0F36csJ2c5f2dsB9b7JW+1H281ReM9T6XRyY1CpUIBgdvfW51tS8GL5R7yIw8MisnG/Q2RoArb9+G2agrDOIyjyJWjif9FPnuIyKAcQK3jG2hxdqTkenh7QdY4DvQfbIUTv99QCs2dVhfgn3zyLCc+p7yNyOZF+KQ0F0NnpOvtYl/q2GDCt+f0
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(316002)(2906002)(8936002)(8676002)(7416002)(5660300002)(33716001)(40460700003)(41300700001)(55016003)(86362001)(40480700001)(336012)(426003)(356005)(82740400003)(478600001)(26005)(7636003)(186003)(54906003)(9686003)(70206006)(36860700001)(83380400001)(70586007)(47076005)(6916009)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 04:37:05.6297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee3b257-de0d-4f38-12e5-08db8f244bda
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 28, 2023 at 04:23:03AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, July 28, 2023 4:25 AM
> >
> > +static int iommufd_access_change_ioas(struct iommufd_access *access,
> > +                                   struct iommufd_ioas *new_ioas)
> > +{
> > +     u32 iopt_access_list_id = access->iopt_access_list_id;
> > +     struct iommufd_ioas *cur_ioas = access->ioas;
> > +     int rc;
> > +
> > +     lockdep_assert_held(&access->ioas_lock);
> > +
> > +     /* We are racing with a concurrent detach, bail */
> > +     if (cur_ioas != access->ioas_unpin)
> > +             return -EBUSY;
> > +
> > +     if (IS_ERR(new_ioas))
> > +             return PTR_ERR(new_ioas);
> 
> iommufd_access_change_ioas_id() already checks errors.

I've thought about that: given that iommufd_access_change_ioas
is a standalone API, though it's not used anywhere else at the
moment, it might be safer to have this check again. Otherwise,
we would need a line of comments saying that "caller must make
sure that the input new_ioas is not holding an error code" or
so?

> > +
> >  void iommufd_access_destroy_object(struct iommufd_object *obj)
> >  {
> >       struct iommufd_access *access =
> >               container_of(obj, struct iommufd_access, obj);
> >
> > -     if (access->ioas) {
> > -             iopt_remove_access(&access->ioas->iopt, access,
> > -                                access->iopt_access_list_id);
> > -             refcount_dec(&access->ioas->obj.users);
> > -             access->ioas = NULL;
> > -     }
> > +     mutex_lock(&access->ioas_lock);
> > +     if (access->ioas)
> > +             WARN_ON(iommufd_access_change_ioas(access, NULL));
> > +     mutex_unlock(&access->ioas_lock);
> >       iommufd_ctx_put(access->ictx);
> >  }
> 
> this changes the behavior of destroy. Previously it always removes
> the access w/o detecting race while now it will give up and throw
> out a warning.

You mean the -EBUSY case? That's a good catch..

> While I'm fine with this change from bisec p.o.v.
> it might be good to split this into a separate patch.

Yea, I can do that.

> >  void iommufd_access_detach(struct iommufd_access *access)
> >  {
> > -     struct iommufd_ioas *cur_ioas = access->ioas;
> > +     int rc;
> >
> >       mutex_lock(&access->ioas_lock);
> > -     if (WARN_ON(!access->ioas))
> > -             goto out;
> > -     /*
> > -      * Set ioas to NULL to block any further iommufd_access_pin_pages().
> > -      * iommufd_access_unpin_pages() can continue using access-
> > >ioas_unpin.
> > -      */
> > -     access->ioas = NULL;
> > -
> > -     if (access->ops->unmap) {
> > +     if (WARN_ON(!access->ioas)) {
> >               mutex_unlock(&access->ioas_lock);
> > -             access->ops->unmap(access->data, 0, ULONG_MAX);
> > -             mutex_lock(&access->ioas_lock);
> > +             return;
> >       }
> > -     iopt_remove_access(&cur_ioas->iopt, access,
> > -                        access->iopt_access_list_id);
> > -     refcount_dec(&cur_ioas->obj.users);
> > -out:
> > -     access->ioas_unpin = NULL;
> > +     rc = iommufd_access_change_ioas(access, NULL);
> > +     WARN_ON(rc);
> 
> 'rc' can be removed.
> 
> Just "WARN_ON(iommufd_access_change_ioas(access, NULL));"

Will do that in v11.

> otherwise looks good to me,
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Thanks!
Nic
