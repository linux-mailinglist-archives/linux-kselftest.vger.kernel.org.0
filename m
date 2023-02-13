Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36C3693F18
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Feb 2023 08:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjBMHsz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 02:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBMHsy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 02:48:54 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B8061BA;
        Sun, 12 Feb 2023 23:48:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EY8KrMihI8NkORPVN6wifH0j85Tfm3tk1Y27Ej/IWs55IIdRVvSmqkfUOrsdSqLavjMXWAGoWY2bojo8mZA1n5U/hZ8Z4SiVXf8dC7ycMHy2blhAXc4A8dssV/UXJFYYPIFdaurVskW3tGbbtQYtrMOpGMC9xLAYtrHE5i7hWac0rdRrkZCW1jUI2cPsLEvAQXmeWuLW89ENWfxPNBc3A0nSMprZ5Yut+ujQrAJ8nk31RMokXQ9FhWLEeDEZzSKlq3vxnlRfYwoC4dctSwQ2rcRlLVEJctbj5ZQvvmu1CTJJ/fo4AgKxD76mVFfvvzxyXFgX5RV+EuPcLd9EJyorcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIasQw/9BPO3YM8ZJndjVlpEqmyHeeJBvR0qpaT3+kc=;
 b=eFJqorzydV74IwBtUuSGNvgM9Y00Kbeqw2jvGFQGijj/P+t7k0Wh3yBJXlEHO7KtsVo3kUmhOllXQKGeDZN/LfPEJncnT3B7zJf1sUgzDReFajI1iiJ2hB0XriChwxZPiZlRVx+aEvoiUN/sxpk65FUuSSR54dsOXjZ5e2Z3GvPa25LH8ccCRK1H9+loaRnNVpWavBaw7SdpHyrPHHCMbFiSjZSpN/Vx7obLnSEqagRPP+40Xl2nCRb4H+h3q/GfVwK0YMz3ZL4fZq997WjUcJvupmDP1BLgrHdAhFYLv2RdKBFLetFAAgNqNWT4H/rEXsWVt237pYntdQ5qB2rWug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIasQw/9BPO3YM8ZJndjVlpEqmyHeeJBvR0qpaT3+kc=;
 b=LCl8LRyFqBUA2aM7jGlsp8EyZJvK3vhGWtxHCO3NWJ7L1l3zWwZ3LXAxi9/5La8NS8LqTsJk8Fj874cr3g55DWo2bHrD4zsTQkqI8TBF0b/M0boOmOfCmFr4u/qejh3DY2PoOt678gOLaOD9n2I9HYnP+wCKFEdHVTX713I1geNGhaM1QXnP0EFur5Li2KxlUOAVzAaHf/pbUGSiqCMpw8KHbQ6smLNBzQBvGf23Y/FiP003fE6ndFkZhH6nSFHH0pZUjrGgPg6F1Eop2v0rKAj9vND3m1bzjcZ6+QnsCJcT8gTNVjs6xhEbkBZ5wUSurafHBTzs59VtpEKuy2fmdw==
Received: from CY5PR15CA0079.namprd15.prod.outlook.com (2603:10b6:930:18::15)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 07:48:49 +0000
Received: from CY4PEPF0000C966.namprd02.prod.outlook.com
 (2603:10b6:930:18:cafe::6b) by CY5PR15CA0079.outlook.office365.com
 (2603:10b6:930:18::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Mon, 13 Feb 2023 07:48:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000C966.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.8 via Frontend Transport; Mon, 13 Feb 2023 07:48:49 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 12 Feb
 2023 23:48:33 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 12 Feb 2023 23:48:32 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Sun, 12 Feb 2023 23:48:32 -0800
Date:   Sun, 12 Feb 2023 23:48:30 -0800
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
Message-ID: <Y+nrTsIz2UHH/1lD@Asurada-Nvidia>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <4653f009c3dacae8ebf3a4865aaa944aa9c7cc7e.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276C1807B710CAD3E5820D78CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+Vh479cDD7LX2x/@Asurada-Nvidia>
 <BN9PR11MB5276268D3ED0360913A05C368CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+bc8OrWfw3Fq57n@Asurada-Nvidia>
 <BL1PR11MB5271180A1DE8C739455AD06D8CDD9@BL1PR11MB5271.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BL1PR11MB5271180A1DE8C739455AD06D8CDD9@BL1PR11MB5271.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C966:EE_|MW3PR12MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: 71753e23-94a9-4c55-7424-08db0d96be58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u4RpgPBu19g0NYEOgH6pV5dQc8ln0kvnETrPn/b3MhlGGzVbjRjRgvxwiQqdIzpbG0aRvRawG3Fp2qBbCaZ09Fx+rYqZcc4MGGI1GvihvvDBA3UOaJYJazDwgT7noJpU+Lx+3FvgFbSC+Oc5Q8UsSpUM+IfkMZPzYazmBUcsCGdI1T6+Ca6tLoUuTPnEexnjGXSPTAbi3PfsbvanI97G6++uG2381K0AY6kxQdoxiEnoqsDXEzMbBY7LyB8otp2l3B3YmJ1BvR6tkj3p+oDnqqFesQbh+wG55v0TTnFMUoHBjHbZE6FnmnqTxwdEXRrn3Nkie4F9bh70KueHPsS2f6OTSNPqJZaZc4QT9zbg4JL2xMtC7UdZVzqyX5UY3vnfaKVyt4FduUnoSN8PsczvnP2o3u9clXRoFmMZp865Oaq2AEEvBDJcvm0qV2pi1HnKEytqnHutHXl9V5nBp4YDqoHvXfT+bt8L7AhvzPEpO+9d2i/lSQyWRiCW379BEljd5/zhLdQPlRQjAjCH3qFsJAiMyjshsUu0UpvwuL7TQbHogU4Kcm8XBVYxCajEjCQ7fey5lxR+JFEmv7yytaAWCp6gB4teuiSUn4yNjuup6TOhUu6rzFrSlorMP9pUn2CW2st8+yei+3zQqLKLy7QXtG9IzzicD5E/Qv9rQqdVZdAHQmIVzaifXB+PQp9jrqPpypJ8c+x8uqcLp/4+MsT0bQ==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199018)(46966006)(36840700001)(40470700004)(82310400005)(40460700003)(55016003)(26005)(478600001)(40480700001)(9686003)(70206006)(6916009)(186003)(70586007)(8676002)(4326008)(41300700001)(8936002)(316002)(54906003)(7636003)(82740400003)(86362001)(356005)(47076005)(336012)(426003)(36860700001)(33716001)(5660300002)(7416002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 07:48:49.1530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71753e23-94a9-4c55-7424-08db0d96be58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C966.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 13, 2023 at 02:34:18AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Saturday, February 11, 2023 8:10 AM
> >
> > On Fri, Feb 10, 2023 at 02:11:23AM +0000, Tian, Kevin wrote:
> >
> > > > > > +     if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
> > > > > > +             if (list_empty(&hwpt->devices)) {
> > > > > > +                     iopt_table_remove_domain(&hwpt->ioas->iopt,
> > > > > > +                                              hwpt->domain);
> > > > > > +                     list_del(&hwpt->hwpt_item);
> > > > > > +             }
> > > > >
> > > > > I'm not sure how this can be fully shared between detach and replace.
> > > > > Here some work e.g. above needs to be done before calling
> > > > > iommu_group_replace_domain() while others can be done afterwards.
> > > >
> > > > This iopt_table_remove_domain/list_del is supposed to be done in
> > > > the hwpt's destroy() actually. We couldn't move it because it'd
> > > > need the new domain_alloc_user op and its implementation in ARM
> > > > driver. Overall, I think it should be safe to put it behind the
> > > > iommu_group_replace_domain().
> > > >
> > >
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
> >
> > Oh... thinking it carefully, I see the flow does look a bit off.
> > Perhaps it's better to have a similar flow for replace.
> >
> > However, I think something would be still different due to its
> > tricky nature, especially for a multi-device iommu_group.
> >
> > An iommu_group_detach happens only when a device is the last one
> > in its group to go through the routine via a DETACH ioctl, while
> > an iommu_group_replace_domain() happens only when the device is
> > the first one in its group to go through the routine via another
> > ATTACH ioctl. However, when the first device does a replace, the
> > cleanup routine of the old hwpt is a NOP, since there are still
> > other devices (same group) in the old hwpt. And two implications
> > here:
> > 1) Any other device in the same group has to forcibly switch to
> >    the new domain, when the first device does a replace.
> > 2) The actual hwpt cleanup can only happen at the last device's
> >    replace call.
> >
> > This also means that kernel has to rely on the integrity of the
> > user space that it must replace all active devices in the group:
> >
> 
> Jason suggested to move hwpt cleanup out of the detach path
> in his reply to patch7. Presumably with that fix the major tricky
> point about hwpt in following scenarios would disappear. Let's
> see how it will work out then. 😊

What about point 1? If dev2 and dev3 are already replaced when
doing iommu_group_replace_domain() on dev1, their idev objects
still have the old hwpt/iopt until user space does another two
IOCTLs on them, right?

Should we only call iommu_group_replace_domain() when the last
device in the group gets a replace IOCTL?

Thanks
Nic
