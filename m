Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A2E68E0F3
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 20:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjBGTQy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 14:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjBGTQx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 14:16:53 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B466B747;
        Tue,  7 Feb 2023 11:16:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kG6TJYbUXxSHtncQG22Yem1s2GVE32XvKsampsc0a3Q7q82l8543Z+qHiJHXY8Y4sswfhtrQdMs7v5c5TKM1DAKdzPbE3YKp2ee6zaRWvRbRQPVJXxpbZk9/f/pVEzhPfjndrdp0Q5FXlv912lg28cxiCDioV4KgvHnW6y+RxRbPi3ieG+Cs6pPhRXx8StnHfottQpVG5+uM+MybaRdSg644f5PIucI3+hOUXdVw4GJlJSoc+JsB583PVjQpgNmcg3NOX8Bsvd2TpcWSMZIrYzPDS9YV30vRPyCm6RvIMBLumxvj+HJES+bHhqXl5WJvUq3t0pGc5Z0Jg2Nha9ZSIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsjiSpwU/J0ipeoLCVDoUA18Rmjbe97VN62p99UES5A=;
 b=CjL0EHzNvIX8XUaSd4wREhwi6Qe+fP10bf6JknBFXnoZtT0aZdY7X26bo/4kJdZwfyLICQEJ40BFTrq3GXvLWwhjGy850214fxqUmKWWRONxL9lTHi9Xhd9P2cPmaz8kM0j1QUIKRytH0lE5LfHTf6mcMoIDYWpE19Y4KKH/zA8iZ6mCCWzYNl7/wTWeHNirCDQ2QLIgaBbwEW5lqIgG1ualH6oYGElGgwO1u1PdZMp+DoZqHJ8UJhplBbeqhpKvrW34FBmjVk++tlo0lS/fm8Pt6WxUJH5I9MhExRdfJQW/Jbt+RN6tqKGjENKYb3oXDmi+1q2K1kCgmaa8+ZJs6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsjiSpwU/J0ipeoLCVDoUA18Rmjbe97VN62p99UES5A=;
 b=QDeChHu+s+uIWDEFaUYqi/AFWXW68plGV+vHliSJpMSxsRLumdPeoOEyDReq9/S6o8V0K+zWb3xggzeXVj1wF4p7uvujwjoXFd6oOk7dTrqLOwGBicjXG5MpewrqeYNyxU0EaBwIktt1dxsLkdm1T6bS8H7KQktVZzHTWi2Bou0eg4AbCteIFdMws7w+xTLGcL6O91mpg3VaubkyHuHODUmSEvLa4a44S4jtFAYSabcLYDWIIOP2yGko8OEDIMFu4yt6FDZbfpUBKhL5mAgKUxPiJa94IK/CfLwwFOlMXSmZvGrzdEHAooqmwlQJVhK/KwmlIuwl34O9UixHNjXJdA==
Received: from MN2PR08CA0020.namprd08.prod.outlook.com (2603:10b6:208:239::25)
 by MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 19:16:46 +0000
Received: from BL02EPF0000EE3C.namprd05.prod.outlook.com
 (2603:10b6:208:239:cafe::1c) by MN2PR08CA0020.outlook.office365.com
 (2603:10b6:208:239::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Tue, 7 Feb 2023 19:16:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000EE3C.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.16 via Frontend Transport; Tue, 7 Feb 2023 19:16:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 7 Feb 2023
 11:16:20 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 7 Feb 2023
 11:16:19 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 7 Feb 2023 11:16:18 -0800
Date:   Tue, 7 Feb 2023 11:16:17 -0800
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
Subject: Re: [PATCH v1 2/8] iommu: Introduce a new
 iommu_group_replace_domain() API
Message-ID: <Y+KjgdNd4gi+6R05@Asurada-Nvidia>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <a98e622f41d76b64f5a7d0c758d8bda5e8043013.1675320212.git.nicolinc@nvidia.com>
 <BN9PR11MB5276BB497D32073A1F4CBE238CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y90iOAmnBtqQtmiA@ziepe.ca>
 <BN9PR11MB527689447DD190FECE4FDA158CDA9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+D/vWwRLD27slQz@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y+D/vWwRLD27slQz@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3C:EE_|MW4PR12MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ee4a4c-6bb4-4cc9-e6ad-08db093fda64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dLEWLp4uAko/nzvW7LOZIXXF4WMGrrSq/0F7h+2ol+QYOhvfppi7zR161fz7eJy7ImslXe5y+3lY1ssU4xIfmWPvpI1SdcrF7NCHfsgUBCBQS2CSEpokI0RWQDTrbVveFFwu2GSlUwqAR4GJh0u6FUDi8gRmWx88VtZ9JcZljJ7ovyzs0Y7Xqx4EjSxoQWI1mQhXYDt05zCXM0fqHnHZETIxLDRsOgrawqXaT7BmJ4TngyZthjJNaPl9+bxe4Af94YeUHsV97QfJ8Ec2zADHeyqWtyvGpNVXtprRvMPe9S+V9pjJqPhmsBPHtwRvuTDUR7siJeWou4GzMVhl44YHeCgX37MfCaH/pn1VHdbKh1Bn+DugNXKcljG9nk+NwZd8jTHsywbfgMA4fDZXEY09dhb08dpjOx5YGrN5jLOl5HKAtxFwMxp30aSWEpsExo/1mG8GCJ79F5fuIPeiCV1GDD1ewix6RojurJW/PeSFpmnQqjhS59b0h4sFFejkHnDsptYnpSqpKZNq0t4iiYEYCoTjIbwa/lwNJyQLHIQeIIr36MO5VtZUNXym3A2VU3rYvvZpJHAMg8TNjNlHgOYDmtInynjtq/9GTvE/pLem9jA89JUCovcs14DoPn9nxp4OfL2KW/Merhcx6kC3WMfbD8E/ZnrBDXwxifCnzqKz1SeGOeMZTaSbrzdnOWrrOqc8L0L0C5Hh+a9Zw2KYAzcPBw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(55016003)(54906003)(6636002)(33716001)(186003)(82310400005)(86362001)(66899018)(47076005)(40480700001)(336012)(426003)(40460700003)(7416002)(5660300002)(36860700001)(70586007)(70206006)(8936002)(6862004)(4326008)(41300700001)(8676002)(9686003)(26005)(478600001)(316002)(82740400003)(2906002)(356005)(7636003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 19:16:45.2505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ee4a4c-6bb4-4cc9-e6ad-08db093fda64
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7141
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 06, 2023 at 09:25:17AM -0400, Jason Gunthorpe wrote:

> > > > Can you elaborate the error handling here? Ideally if
> > > > __iommu_group_set_domain() fails then group->domain shouldn't
> > > > be changed.
> > > 
> > > That isn't what it implements though. The internal helper leaves
> > > things in a mess, it is for the caller to fix it, and it depends on
> > > the caller what that means.
> > 
> > I didn't see any warning of the mess and the caller's responsibility
> > in __iommu_group_set_domain(). Can it be documented clearly
> > so if someone wants to add a new caller on it he can clearly know
> > what to do?
> 
> That would be nice..

I'd expect the doc to come with some other patch/series than this
replace series, so I think we should be fine without adding a line
of comments in this patch?

> > btw looking at the code __iommu_group_set_domain():
> > 
> > 	 * Note that this is called in error unwind paths, attaching to a
> > 	 * domain that has already been attached cannot fail.
> > 	 */
> > 	ret = __iommu_group_for_each_dev(group, new_domain,
> > 				iommu_group_do_attach_device);
> > 
> > with that we don't need fall back to core domain in above error
> > unwinding per this comment.
> 
> That does make some sense.
> 
> I tried to make a patch to consolidate all this error handling once,
> that would be the better way to approach this.

Then, I'll drop the core-domain line. Combining my reply above:

+	mutex_lock(&group->mutex);
+	ret = __iommu_group_set_domain(group, new_domain);
+	if (ret)
+		__iommu_group_set_domain(group, group->domain);
+	mutex_unlock(&group->mutex);

Will wrap things up and send v2 today.

Thanks
Nic
