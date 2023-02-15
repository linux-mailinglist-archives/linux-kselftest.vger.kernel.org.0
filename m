Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F6F69773D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 08:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbjBOHQv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 02:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjBOHQu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 02:16:50 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D8C2B617;
        Tue, 14 Feb 2023 23:16:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHk4YYKY/dKLOVjHQL/dVPQfREYNx57Q2hQMAxCQYpSoML9PANlO/7cj3eZEcG8lVLvVf1ezlJiLQy0zLAJH6heGE14/Xt02OL18vWzD7+flax20fI2VhB1KfTsENYWqjCHrDO7tDo4anBcVZtzB6mcRQJR086gx3BTkbvXxSmhksfhvi/I0P1CUdiZmj5OtLXpGQwHcAm26jlE2Kcgng+B3IipKiuK5Ty087aiJS4TWBzynHRY3CR+WZ+IacAu3KVHnR4Xd6K6cMXLMDvk/N5V/SRZ9j0zxrMNIZenvlKtrhGr7ueQ9qMXB7PPrbRUPNRcS0LmWSRP7JA0Dr/5JNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXcwa5yir7vDfBKEW6RIT65j/FKWpz1zt4B4IkdKIV4=;
 b=RID8V/FIGo8q82eiLq0GZAot5BSQurVs7Eaot0bIPTbtwurNP5NnlfsyWgTH63ql0ecCrH8tPOq4I00qvb3j0AV1DNoH8TYG0GUKFrgMSTphciIbyHvwtRnQybx+sUWg8DFCmoSUDBeWTfXTUEnxSCW1zu/N2S/wpqNdKhQ/kWbj7BXMxTHZST8+LbotW+Bd05D0eeclaDLvg0z0DgTnMxR9QDGnrUmVUqpHmoyJ3yWtDUz1nuf2OXxWISvh+F7D2lPZ4usWAfHrLxHjP1NNci5CE3bUXtj2hz7nXpNJ0fNk4Hw7Hu+/QZ1NexbJjeluOQaG+o34bRKC8GbmjnB49w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXcwa5yir7vDfBKEW6RIT65j/FKWpz1zt4B4IkdKIV4=;
 b=Ej6GIfZ/xeGJqn9d1hbWxtqgH5r4MuT2YFJamFzUO5K+rOizaqJ7SWams5AGAHr3TqBT5w4r9WTjj4t/zcb5O63maLZx7RY9EIxwBSal6g4lnANFR8wbScJWjW/FmM5Ax2lKZgzn3oxKWSHQmWgW6lBDfRqvGoskgLW6VecVLa1c7eowgK8AKA1Zogv+FemIRbb8jSnUdzpTlZGd4HncmycZENEQ3/i0PbUGqyvomMlRjGeNMMhAkmxDLH1RgxknJVlGaSJKJUi49Gsp6gLNwTS+VbDdaJs7qtZeevO0idfA3H5SsgALDHekf8qbrY3llIGA1YyfxZ3/1AnT6wut6g==
Received: from DM6PR06CA0082.namprd06.prod.outlook.com (2603:10b6:5:336::15)
 by SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 07:16:46 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::f2) by DM6PR06CA0082.outlook.office365.com
 (2603:10b6:5:336::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Wed, 15 Feb 2023 07:16:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.12 via Frontend Transport; Wed, 15 Feb 2023 07:16:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 23:16:33 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 23:16:32 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 14 Feb 2023 23:16:32 -0800
Date:   Tue, 14 Feb 2023 23:16:30 -0800
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
Subject: Re: [PATCH v2 08/10] iommufd/device: Use iommu_group_replace_domain()
Message-ID: <Y+yGzihpAdj7iP2G@Asurada-Nvidia>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <4653f009c3dacae8ebf3a4865aaa944aa9c7cc7e.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276C1807B710CAD3E5820D78CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+Vh479cDD7LX2x/@Asurada-Nvidia>
 <BN9PR11MB5276268D3ED0360913A05C368CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+tpkpNYil3duTIP@Asurada-Nvidia>
 <BN9PR11MB5276A2CCAB714977F07AD0758CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276A2CCAB714977F07AD0758CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT049:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c9633e5-cdc8-4401-9394-08db0f24989b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 250IkMmreHwkwfSNBNfOBboApt7vtEMOfqB1HFbyImqCSzxANC0gF78ADADwp8vqM+pOzDdrWk+Wmk9e7BZEaQYVHtK0LBtshUCF7u+9ZevyWGabgbWfukGPlZwQKbH7VEbnkj5bhaAWB1VgNJRZkHTxgY6Nu40CN7WaxpKmf7eYytFcRlGt8RwE8t8UlWIDVH5xX5l2q/l5RHuXWOhihqaK2qXKcmXxFSf1SH3+ZehrHT3tENQ0pPO3sMCS6DTN70ZhUeNVxhzUHevriYd9JXeSHALC9aafQyp3lqKvKQGUEjn9lGFkIEY9XmyNTDZ7Hds9ZuRZkZ3P3vY62OhVUP8mHlkSX490nbnV1xjal0HvtW1D7Z+zGtMjPbXEtkrQwx7zF+E60nrKTuCNoY7KUFt42jC6UXuhgjdfKzuS2yAvUuXUwmjbb5vpcqJq/6cWdsnTjooMqtBmsZwY2H2YZtJVghJ+g6IafRAuvMUULVq6BMfGVHHw6Ong2Pq5E6TNh2bolP9RxtqiML5H6AS9i+lY48v25WkRNA7zn+uiTu7sxPcgZ+mSt51zJ7nfykh3zeHQRNC9caDwTyzd0hytI1TWbE0jBx0cF3k1v44daka7+zGOwKN/T+5cvplrZ6RL9Rf84Kg0CE2139Ef7agFajkCAQbR2GPpQu8Ir329izzqusEC3/9al3rb863TYTZaREz0CxMKo/+4gckzi+LPehNpsCVOaziyPEqY/Ju1WpY=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199018)(40470700004)(36840700001)(46966006)(6916009)(478600001)(41300700001)(86362001)(8936002)(356005)(82740400003)(316002)(54906003)(70206006)(8676002)(4326008)(70586007)(7636003)(36860700001)(40460700003)(186003)(7416002)(5660300002)(26005)(9686003)(82310400005)(40480700001)(47076005)(33716001)(55016003)(426003)(83380400001)(336012)(2906002)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 07:16:45.4754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9633e5-cdc8-4401-9394-08db0f24989b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 15, 2023 at 01:38:32AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Tuesday, February 14, 2023 7:00 PM
> >
> > On Fri, Feb 10, 2023 at 02:11:23AM +0000, Tian, Kevin wrote:
> >
> > > My confusion is that we have different flows between detach/attach
> > > and replace.
> > >
> > > today with separate detach+attach we have following flow:
> > >
> > >         Remove device from current hwpt;
> > >         if (last_device in hwpt) {
> > >                 Remove hwpt domain from current iopt;
> > >                 if (last_device in group)
> > >                         detach group from hwpt domain;
> > >         }
> > >
> > >         if (first device in group) {
> > >                 attach group to new hwpt domain;
> > >                 if (first_device in hwpt)
> > >                         Add hwpt domain to new iopt;
> > >         Add device to new hwpt;
> > >
> > > but replace flow is different on the detach part:
> > >
> > >         if (first device in group) {
> > >                 replace group's domain from current hwpt to new hwpt;
> > >                 if (first_device in hwpt)
> > >                         Add hwpt domain to new iopt;
> > >         }
> > >
> > >         Remove device from old hwpt;
> > >         if (last_device in old hwpt)
> > >                 Remove hwpt domain from old iopt;
> > >
> > >         Add device to new hwpt;
> > >
> > > I'm yet to figure out whether we have sufficient lock protection to
> > > prevent other paths from using old iopt/hwpt to find the device
> > > which is already attached to a different domain.
> >
> > With Jason's new series, the detach() routine is lighter now.
> >
> > I wonder if it'd be safer now to do the detach() call after
> > iommu_group_replace_domain()?
> >
> 
> yes, looks so.

Will rebase a v3 once Jason updates his series. Thanks!
