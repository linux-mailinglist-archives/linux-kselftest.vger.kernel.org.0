Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E763696180
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Feb 2023 11:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjBNKyc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Feb 2023 05:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjBNKyb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Feb 2023 05:54:31 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1779020;
        Tue, 14 Feb 2023 02:54:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPPPc29j9yLEKsWGZxelxtucuQRKnq4Ut0x9KooW5S4qMr8a7xHrE/Hr6mqA+SjotFmGYtQhZjyQxeQOL18JD4/cGjbJrO40xv7uoIVI5RrFNwpPg2UvsltM7rSACNzqPxFV1QE5PRxhMJPZ4JpC6XxrxwaWm3c5QXIflk+KePp0FGhXNY7iwRq8gVBtkfxSu98aBPds9dsk6vWGoJKMx+g8OB8z8YChBiGnahU1FWVAQMH6yTTDZPBum2rA15sxuSDmU2wLl18sb7gBoQnafQ97rT7lO7gM8oSVMBr7TIwmHAFbSvfzg5rbxxEqiePV1MumzmcJ/NerOS4lDO2Z+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NpZf++eb13yCkKG32IcG9PGQNPq9yBGI4oaNW5hmnMU=;
 b=MNNhIGDSJj5bMZJJxAIjzKrLuPHMrLqta9a0WWC3jAD4a6+BchUKprzWawi8Te+XJfR2zyNp3xbXREimjOWsqb3hWoeiLY0KPx/9JjzlYIu3ORWlJTouJGhvu4GNKctCpezvktd39y/62ZwjvLTkuOPycxB6pmQjz6CNVMvYr6ECb30Cy3RRDGSXjwk4oVGzV5MZgGIscfZ1GtWRToiC8PHGjR5sxhdm+xVEqUCEDw6sEhN5ur52x6UG2U4WKc+Rcp033EsxGFp+xP7LM0B83DBHwKZQqm5HSbKMwWnmWVf+qncUFEh5ItQflNhdf+drLU7+XNrDZF6l6nxj6gPNUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpZf++eb13yCkKG32IcG9PGQNPq9yBGI4oaNW5hmnMU=;
 b=Jrbl6ySzXyB6rNBG0CBMUDlspNiTOZMnCQaNEKlW6vu3kbkZ3WeMB69bCqEO9O63MnlifpLwCB0Hh1DHYPIYC4YnovAfXMgd1wVidSBcVmZOKoYOQmo09syjQ9qJHIn0/OgbJSUZ+em6Lb/93nUYbAYo9hGrlD354uxDS2l5lAUk3XHe1I6zLI4rGvN7QfDbrtmHPSlQH3mMHhTp7skf3gN1xjsBm4cf1CcYLGzjDs//Mz2emjXvmLQGdxNoRVdG8NzivfozEEHtcma+Y1FRtE2YMeYjO2klyDtR+YU5gKAk7KVa2/gtXWd6wh4URuW3niiX6DCminV0Uisp9F/sFw==
Received: from DM6PR02CA0138.namprd02.prod.outlook.com (2603:10b6:5:1b4::40)
 by PH8PR12MB7374.namprd12.prod.outlook.com (2603:10b6:510:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 10:54:27 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::ab) by DM6PR02CA0138.outlook.office365.com
 (2603:10b6:5:1b4::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Tue, 14 Feb 2023 10:54:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24 via Frontend Transport; Tue, 14 Feb 2023 10:54:26 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 02:54:23 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 02:54:22 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 14 Feb 2023 02:54:22 -0800
Date:   Tue, 14 Feb 2023 02:54:20 -0800
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
Message-ID: <Y+toXAUa2Cbwn7I0@Asurada-Nvidia>
References: <cover.1675802050.git.nicolinc@nvidia.com>
 <4653f009c3dacae8ebf3a4865aaa944aa9c7cc7e.1675802050.git.nicolinc@nvidia.com>
 <BN9PR11MB5276C1807B710CAD3E5820D78CD99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+Vh479cDD7LX2x/@Asurada-Nvidia>
 <BN9PR11MB5276268D3ED0360913A05C368CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+bc8OrWfw3Fq57n@Asurada-Nvidia>
 <BL1PR11MB5271180A1DE8C739455AD06D8CDD9@BL1PR11MB5271.namprd11.prod.outlook.com>
 <Y+nrTsIz2UHH/1lD@Asurada-Nvidia>
 <Y+pN/vtO8I/oiMOJ@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y+pN/vtO8I/oiMOJ@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT024:EE_|PH8PR12MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: f4de8ef2-6348-487a-a892-08db0e79d72a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZZymL69SG+cHpCQT8sSyDKb9IPtrLLaNjkY2/jAmA0RxXNbCFKlW79Q9Lsh12a49VgtgRFjaIwHtj5i8myZIcuQHVjebRqkzZOevSkfWsIbFEO6xqgngbVUT3B4/mw94j891ivu5mCcl6dJXongJd9kHMZE+6JcGL3ApvGQSSTuVH75mQbztsF2gHJXGHNoEyHjdl2mitOWZis7adag/89tRCvTgFNOyPV+V7LJJ6tutXVTSOcUEaMYa6vug+88qsX7Dgu9BZa0Oq77LqgH9jSi5x8UtPufk5mRfut4aMgh4R/QmHQaMvCTNjx5S0m026HCbNgGyR6b+DMyHXnen2rNbUiSQPYOpLFnB5N4QUXecadP3HXhYIvTlVtbnMUkrc4kPgiM1s95De4/2yVtJLD3lU/HEve6i40PmYwIWZJnOYt5Hee1ijiuuxXfBeKNOY5FPOfJPiTl3/2tE6Mo7b8E9tsifT6mz5Z+UX0Jmx+VvvCSPi4442M4f3VPyyFCGbClTKGZSAF0+TNwxDvgCyFqTOIxyJi/VUHz+7IpFYfDjEPu9CtZBS32bNHF8LNxTcPvRQszxEgGFuVIGORnjiH18nf78X9VXjhN6dq8u0SQZcxj9zuTNFEoysLMbSYs0QPiU+PEEA3TbyVAue7JAWP568zaKkZTY/pAUGndVuecM3r4OD+oA9K6hb8+EqjXfRi5bH41jybtt7mQxisGTM5Mhr32qUcEj0sdYaGd/WT8=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199018)(46966006)(40470700004)(36840700001)(5660300002)(26005)(426003)(47076005)(83380400001)(55016003)(186003)(7416002)(2906002)(82310400005)(86362001)(40460700003)(478600001)(41300700001)(40480700001)(7636003)(82740400003)(36860700001)(356005)(9686003)(336012)(8936002)(6862004)(6636002)(316002)(70206006)(33716001)(70586007)(8676002)(54906003)(4326008)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 10:54:26.5223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4de8ef2-6348-487a-a892-08db0e79d72a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 13, 2023 at 10:49:34AM -0400, Jason Gunthorpe wrote:
> On Sun, Feb 12, 2023 at 11:48:30PM -0800, Nicolin Chen wrote:
> 
> > What about point 1? If dev2 and dev3 are already replaced when
> > doing iommu_group_replace_domain() on dev1, their idev objects
> > still have the old hwpt/iopt until user space does another two
> > IOCTLs on them, right?
> 
> We have a complicated model for multi-device groups...
> 
> The first device in the group to change domains must move all the
> devices in the group
> 
> But userspace is still expected to run through and change all the
> other devices
> 
> So replace should be a NOP if the group is already linked to the right
> domain.
> 
> This patch needs to make sure that incosistency in the view betwen the
> iommu_group and the iommufd model doesn't cause a functional
> problem.

Yea, I was thinking that we'd need to block any access to the
idev->hwpt of a pending device's, before the kernel finishes
the "NOP" IOCTL from userspace, maybe with a helper:
	(iommu_get_domain_for_dev(idev->dev) != idev->hwpt->domain)

Thanks
Nic
