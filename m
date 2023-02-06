Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A0168C6A3
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 20:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjBFTS0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 14:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjBFTSY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 14:18:24 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C520B6198;
        Mon,  6 Feb 2023 11:18:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMUaeTj+qmAChgH0T5fjqjdV8VI3JnPkIE0G2iHVnzFy9HB0P6/ujLe/gxqh2WAu3LRkYzf9Z5udqMJMoPY6DLq2Q60deyiSrxpEq9LLgx0TSWOleW8sgcuI3Vmo3wRlrSlyJJy9by/qIxs+nwgPceg0CUBDHucBLxEbaVOK/k78V/O082/1AYtsg9o/cL+RDTHA/Xb3LfAKh4bJZdioR7JktaY812BQcYwyzUfVCywAOSOmr9kjqDAsK2XzMolj2PbFdwtB2D+KrKOGPSP5jZXCmoOhoJaVFe80Cpc6Q3E3Z93xc20B0DK24+wXINEN5Qew46Od61uAw4pVnzP50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAcnrE9RPZcbCqPA7t0lFHOCgOW1cTw9utCy9kBYYFI=;
 b=SIwQDJJa99hEjGuNuI0ioNYbWbD88yvdfLmZOeIMljkAWgYU2fBLRbyzKdryuCM8jNF4BNUno+QcbGTZnKBb4hhzea4Q93KA+SrBF4sJj7r+B6vaBTtlwA6cc4L8jhLZHsL4APrGvUcb2bXdZMjPhLyh6ewO4aIuCRa4UnlhsH1xG9eXYCVrMSPLsBMnjVGKc+3+ZNDP5NhzIfsovfYMPoHwrX+sb1+hW6D+MjEr6XOHqKYSLJJWnrkh0KESowV5feeLRkonCzwNhAGgvpcRrALstcL2KRAO93bz9ouYbNh7m8BailXUK/Aqzh1neQEyWwj19cfJBqIEy9hTiS/CpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAcnrE9RPZcbCqPA7t0lFHOCgOW1cTw9utCy9kBYYFI=;
 b=aElU1tDfmGB4r2d41AoPx+Uw4xH8EBWZgw+QxMMZZjVvoTk2JaRjz9tYwbP0L8bCMACquHs6Y4XkFCrdqmHEtKDnmzVj2mA35a/p4oW/uHskqiAd3nPRZQHRFm7tvyBXpVxfNJUEI+2XrSssYiN4JRAUDnUkvEZffd5Dpksq29C9lioGTHJHo3dz1bNhfaTm+lKXGVSixUyI7T+UG311s2F3Oli3QOf+kmKwkNUIJEZNRMqrVr2Gnc+/H7TGA1Gd6iN2LO3BFVCtS/gwK9eEoLTDu3CoD4zoH2lPXfNUkyAG9SrpxMFnyCv36QwPz1g5hUQPnszOE3a7djGtmkOU4w==
Received: from MW4PR03CA0155.namprd03.prod.outlook.com (2603:10b6:303:8d::10)
 by SA0PR12MB4511.namprd12.prod.outlook.com (2603:10b6:806:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 19:18:00 +0000
Received: from CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::12) by MW4PR03CA0155.outlook.office365.com
 (2603:10b6:303:8d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35 via Frontend
 Transport; Mon, 6 Feb 2023 19:17:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT077.mail.protection.outlook.com (10.13.175.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34 via Frontend Transport; Mon, 6 Feb 2023 19:17:59 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 11:17:45 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 11:17:45 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Mon, 6 Feb 2023 11:17:44 -0800
Date:   Mon, 6 Feb 2023 11:17:42 -0800
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
Subject: Re: [PATCH v1 7/8] iommufd/device: Use iommu_group_replace_domain()
Message-ID: <Y+FSVoRpVguZUmW9@Asurada-Nvidia>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <de1cec7698e9b4e2ad03b7d9414b25d655fe5a6e.1675320212.git.nicolinc@nvidia.com>
 <BN9PR11MB52760BBE37B65AAFA0CDCC708CDA9@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52760BBE37B65AAFA0CDCC708CDA9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT077:EE_|SA0PR12MB4511:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bcd6092-9cb7-4dba-cac8-08db0876dc50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UCQZhbNt+pLb/tk7WOt5n8gJx5bitluiHlaJXJX9bNvbKNKVKR61Elkjt0v7e8jApSUmw+QU9mJ8KReutJB5gRSqGkuxLaWQ6tEMVu5kZX3nS3Tm4RV8pTSZsKm0TMEdZMPvJ1Ugxe+qDGshVWG62OJLwcO5RpwHtvaj6UMsFf3FnZlM8w6POShMWzUe8GrVfYXYB5gFdm38AgnEZXQUGgzVk6jzobXjjKN7ua5u4S2I9i5bv8nQkV+MaTDwsvGimPY04gaQeAhxDbrFebRrdKzJP26llBwZFNkqyf5vw3XdYG8MesbBkR4IvxzcsmSnWh5PcLsqnSodWTI+/7IMcy54BzFXPOPDU/OZRXG8CPsISu6skJGRPrOLu+9paO9qUGi+1tanq0e8gF2K71sf6VjwehEqQC0wvqUqfqxDjz0msw6f05VBYaZwflCQoXJvOkottklsfx2jNyZOIlNp8tnF4cnSQDXxYLa4LtGJLAEXwI5KrMru4PAy53SN/NQq23n/tCv465rTf5c/3Zpk9TzS1IpVwh1LnW5knLX2NIMMFK2yuOnNCPrwMyVVuQVmJO2oUGlZRce7J9zVtPGaFmfqU+9zoiYs0mhgo8GHibBsKUHJ4uWtFOkjjwQiqesNAxNoDVw3rsHprRzUMmV9QMI+0zaSKIpr9G9ZOt8N5+g0zguDBVKi3Vsm+Pko+uln1+9Ov4F6A1n4kBxESYHB+IZiXdnDDeaYU17Vzl6jknE=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199018)(40470700004)(36840700001)(46966006)(82310400005)(47076005)(40460700003)(86362001)(356005)(7636003)(55016003)(40480700001)(82740400003)(26005)(36860700001)(9686003)(426003)(478600001)(33716001)(83380400001)(186003)(336012)(7416002)(8676002)(8936002)(54906003)(316002)(4326008)(70206006)(41300700001)(70586007)(6916009)(5660300002)(2906002)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 19:17:59.6940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bcd6092-9cb7-4dba-cac8-08db0876dc50
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4511
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 06, 2023 at 08:46:04AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Thursday, February 2, 2023 3:05 PM
> >
> > @@ -246,6 +249,18 @@ static int iommufd_device_do_attach(struct
> > iommufd_device *idev,
> >               }
> >       }
> >
> > +     if (cur_hwpt) {
> > +             /* Replace the cur_hwpt */
> > +             mutex_lock(&cur_hwpt->devices_lock);
> > +             if (cur_hwpt->ioas != hwpt->ioas)
> > +                     iopt_remove_reserved_iova(&cur_hwpt->ioas->iopt,
> > +                                               idev->dev);
> > +             list_del(&cur_hwpt->hwpt_item);
> 
> emmm shouldn't this be done only when the device is the last
> one attached to the hwpt? and if it's the last one you should
> also iopt_table_remove_domain() together with list_del, i.e.
> similar housekeeping as done in iommufd_device_detach().

You are right. I had another patch on top of this series,
moving this list_del() and iopt_table_remove_domain() to
the destroy() callback, so I overlooked.

And I just found that the list_add_del(hwpt_item) in the
IOMMUFD_OBJ_HW_PAGETABLE case doesn't seem to call at the
first device's attachment. So, I think that we might need
my previous "symmetric" patch in this series too.

Will fix in v2. Thanks!

Nic
