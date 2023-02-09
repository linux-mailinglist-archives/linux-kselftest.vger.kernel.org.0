Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7F2691210
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 21:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjBIU3G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 15:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBIU3F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 15:29:05 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8576311A;
        Thu,  9 Feb 2023 12:29:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aip7gNfKxXe4NHcU+ray6qO0thR5kazRf1Po9jWOjGtrffOfI3xLsaLHkH00wBDviato6SpXZqBkIAgfy/9Cu5B9FxRngjTJNylQqIgGWW3+m1pQ7w7Q53ThPEhfjkZ85cUBTOhKOVMWKuEdG/vNKozWYCTQrWKkEDVoxTE1iyPI3HBqC2X9rXxJwvSPR9l6iQccBWtpmkINegNnTwzruSTsZWEZeGICEYgApBvXAcZVFc8HjLHbXntWZMO57Z8WbB6Q5VsIk3ZfhBJNgss7EFvKls1vst0LXVqQz40m35hFokHCf9h9s6S1hRUzCOfLHe0wdXwx1iSTXCkSeEaneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sonlHY1cqTCA1UaqbkzKMrVN+/PVDlZRa3iEDrCYyNg=;
 b=A+hkM80s2I/Ll/ioYFii/LuvPWDgXz4HK2qD6DtYdcGCu+u8JpVUFeSbSXAoYEi63PyGLcLju33vBx8uvhiQl8Ug7FY8IVinI54CUHIIrpXXrCGW2HGCC7J1lm1sk2A0TuD43j1y+Hs/J3j1MTUozyCLEe/gu1Fzk8q7EtGw5pk3Cl0Kal5N/7f/5uu2aR6FX9O1h4mJWZvLs/ynMAM1Sd9XBT1bYqU/gF1+lDL1AQYOv4sU5q8jWJWNxfLblubCDHpCMbTbkANGzyTlBx1O08Aa9TF4/eXC9y5xrvGMeTjmjdhX7L/4OobmOOBnytcYAwjQHffT9pVZAsp5g5utxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sonlHY1cqTCA1UaqbkzKMrVN+/PVDlZRa3iEDrCYyNg=;
 b=gzD48ZN9y92Or1JS+Mze9ZU3FPgR+ezEBqd5wl0tX3gGe5/n0mQm9NK98ROKz4QoZZ0WCy4MbMnmJtEKYWrc1Nmi/gFjrcWrSiF/0R1VznC3GV1MCNcFPnCK5oTkXMX7vTzLe9+EzFh2gb8VYqXVRPEDKuMRUUkl9mv8h4qu5tu8zM52r/CzrKJwmo9BLgxftJ9c5g0CD2KXc0KZbykRwYv/P89r0Or4HFso65xwnGiNyJ9E4RjtmF/BTsL1sXYYOueQmuh2K8wXOXUsIhxeFydxBkpRMJgcnRlTJcd5knUFFlRiU09IabzsJRMiC36g/si2Qoy5dQ9JB4JeN+bP9w==
Received: from MW4PR04CA0083.namprd04.prod.outlook.com (2603:10b6:303:6b::28)
 by CY5PR12MB6131.namprd12.prod.outlook.com (2603:10b6:930:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 20:29:02 +0000
Received: from CO1PEPF00001A64.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::50) by MW4PR04CA0083.outlook.office365.com
 (2603:10b6:303:6b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17 via Frontend
 Transport; Thu, 9 Feb 2023 20:29:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF00001A64.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.16 via Frontend Transport; Thu, 9 Feb 2023 20:29:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 12:28:47 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 9 Feb 2023 12:28:47 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Thu, 9 Feb 2023 12:28:47 -0800
Date:   Thu, 9 Feb 2023 12:28:45 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
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
Subject: Re: [PATCH v2 05/10] iommufd: Add replace support in
 iommufd_access_set_ioas()
Message-ID: <Y+VXfQbXakNSHSLw@Asurada-Nvidia>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <931be169ff4a1f4d4f1ed060d722c2dc17ce6667.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276AE27E37866B82A6E03608CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276AE27E37866B82A6E03608CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A64:EE_|CY5PR12MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f56a5a0-ae73-4c90-0926-08db0adc47d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RKXJYAtXcp665dy3pvrF+dHTjYBjtPP+l/b7/4HM2G+gMMPowIknYFW9BjFu21RoeUsRMFfynCXyT8++51DGGqTHxSV9HCSx+VUI6+DaLO47Ds6owLT+qT+GHzUEieBP1JXPjdpuDOagqzdP7dSWU0f8SjZqg6kZc1zqtrZ8TILKynm0co3vZ3RxqDmq44nVZAABxhT3sf9XLtXrGaArz46LCupKjcGwL7/k03MXlShOXrhjYCCTRYEYpg1PZJ/1HcHKWgUxEn4Sw5h3hVCAc0JN5CRXRx/TrNRmmBzxD+kBe4zOBnimiTvC43Z9CzRuWZBwyGLzZGmfE+K43NXWCjYZFW8bE582bLBziYWP+M0VFnodqJkZ6iRjzy+aUCBOOOtNoIbkoCTL1D533i5iLJcEV+cozSfomtn4SEYKiOKcOMlIe9Q70KNroK+dRuPq1TidVdmnc4JMY6S0Zoz45X/6ZFitsaLkBAEUpaxKFL1C174dB9hTiE6xVfLehQEhVMb/xrTf1fUn5vCM4opeeiU5cUOx+sQwVNISM508FYtLYYJMRdOs/axhm8BQtf0g9fatseznc+UL3gdQqezlQ8izMzKgN7IPQKzt06jRO14R9LUp3MbMb61ACHHUdYvC963b7wTqEYfYu+BmXCXn/c/e5hx7HPKLGixGeOYZShPMgN9KT8fFCDUoODkeIGIQMtCFW6JJQlTB8LDMgkNimWKCle0QedxaBEP2TpcEsNU=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199018)(36840700001)(40470700004)(46966006)(26005)(316002)(186003)(356005)(8936002)(9686003)(2906002)(55016003)(40480700001)(83380400001)(54906003)(5660300002)(110136005)(40460700003)(7416002)(86362001)(478600001)(36860700001)(70206006)(70586007)(336012)(33716001)(4326008)(47076005)(426003)(8676002)(41300700001)(82740400003)(82310400005)(7636003)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 20:29:01.6215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f56a5a0-ae73-4c90-0926-08db0adc47d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6131
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 09, 2023 at 03:13:08AM +0000, Tian, Kevin wrote:
 
> > --- a/drivers/iommu/iommufd/device.c
> > +++ b/drivers/iommu/iommufd/device.c
> > @@ -509,11 +509,23 @@ int iommufd_access_set_ioas(struct
> > iommufd_access *access, u32 ioas_id)
> >               iommufd_ref_to_users(obj);
> >       }
> >
> > +     /*
> > +      * Set ioas to NULL to block any further iommufd_access_pin_pages().
> > +      * iommufd_access_unpin_pages() can continue using access-
> > >ioas_unpin.
> > +      */
> > +     access->ioas = NULL;
> > +
> >       if (cur_ioas) {
> > +             if (new_ioas) {
> > +                     mutex_unlock(&access->ioas_lock);
> > +                     access->ops->unmap(access->data, 0, ULONG_MAX);
> > +                     mutex_lock(&access->ioas_lock);
> > +             }
> 
> why does above only apply to a valid new_ioas? this is the cleanup on
> cur_ioas then required even when new_ioas=NULL.
  
Though it'd make sense to put it in the common path, our current
detach routine doesn't call this unmap. If we do so, it'd become
something new to the normal detach routine. Or does this mean the
detach routine has been missing an unmap call so far?

Thanks
Nic
