Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4A468A0E2
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Feb 2023 18:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjBCRxV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Feb 2023 12:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjBCRxU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Feb 2023 12:53:20 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1513725952;
        Fri,  3 Feb 2023 09:53:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGecZPgIqr103gFUz+xPR7x8d5QF2fnmCP1kinmEg6eN12COitHAESJQGPlB9gqQZZSnmPy+Wf+7XMYomuhfGmE517EKOh87ZWQHt+Jktdtadhmj5xWNGsWAAOt0BIi6MgTNex+ULIz4PnKK26oOtxNeol+6UNnxLwvpKKJbYFrZXIFiMA76/kfVYYC3KeRsu7dJWmN4uhHPleXSFc4uJZVcfj26Dz7TKjPLvH2VEr/06soDgSsLKJfP5TOLH7fpRg4GDHUI21m24UMjNMfGAwhHvEjQtRsqGeMPhwFQz7U8g6SXnFZ5hZaDNnCBdoeARXGkMRFQRyO7vn9huEaDSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgUuY8vcE8F2ZzbsE+TE7PDo41+oKeTWt6CgfbQ6tYE=;
 b=Z0GkRt693UTaukH3xrGkLE6oplYhL2LkN9AyDIwVkjiwW6oVmaHqm782l928+LgGQyQySxdMUQCKLqZdqxZju+k7qr5uh06WKRYWcAymTGqWtOXxEv++KdiPUQrChKcXdRQsjR/ntI1tR2+E6JGnJAiOItRx/+KLsyyFIDuY8qmjHh0NW1yPTdfp8HXDZsYk+CMHM+Q3/+9GwgfHhm+07LbOpI+JmVfy1eKNVLHx5ytIg3S9hmCq8J0vNp6w8VDE4KJd6eT0RZTjxp4Kz0CallFOX0jSJrz95dsuTpFPuJYFj+6N85LD6RKMlLY5HV25PtDllePQqaKcVVbjp5v1iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgUuY8vcE8F2ZzbsE+TE7PDo41+oKeTWt6CgfbQ6tYE=;
 b=atqTjwfa+VU06tO2lQbeISR370elxESfnvCEQnb/iTZxNkguNNdTSTGPDzbbHGyOxWd5eV8nvFjxDdTCZq2v1JsC3S/xU6E+7tjKBZMlfT+iV93pvSROKF34I06r7iVZ8QFxQqLle21HisTHrdSULSJOqvORylJ1CLXe2Eo4njR1FYwGPpEkuI7zZa61PI9LM9xfunEc79sxlfBI+dca6a0zbAGdmVVwB0RWsupSAfRo5ExdeIxTMnxPGDEzKPGqmLLTvRkBnJQMS+8+255NjszWVFrg2msLrLsmV58rnfExIUlMNyB7qxd/ut/XlPXnZ+KfxVwHyVD+zYwwUEcm9A==
Received: from DS7PR07CA0023.namprd07.prod.outlook.com (2603:10b6:5:3af::28)
 by SN7PR12MB7323.namprd12.prod.outlook.com (2603:10b6:806:29a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Fri, 3 Feb
 2023 17:53:17 +0000
Received: from DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::42) by DS7PR07CA0023.outlook.office365.com
 (2603:10b6:5:3af::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 17:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT111.mail.protection.outlook.com (10.13.173.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.31 via Frontend Transport; Fri, 3 Feb 2023 17:53:16 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 3 Feb 2023
 09:53:06 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 3 Feb 2023
 09:53:06 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Fri, 3 Feb 2023 09:53:05 -0800
Date:   Fri, 3 Feb 2023 09:53:04 -0800
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
Message-ID: <Y91KAHxQIDnaGbYs@Asurada-Nvidia>
References: <cover.1675320212.git.nicolinc@nvidia.com>
 <a98e622f41d76b64f5a7d0c758d8bda5e8043013.1675320212.git.nicolinc@nvidia.com>
 <BN9PR11MB5276BB497D32073A1F4CBE238CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y90iOAmnBtqQtmiA@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y90iOAmnBtqQtmiA@ziepe.ca>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT111:EE_|SN7PR12MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: bdd2463a-acc0-447a-e285-08db060f874c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iCXKWHzrRBVfB0nlsR31YXJMyRM6a7SZoPCMIsllhiqy/fudK1zoDP1RUAMnOSC4AxOnBoYFRvYA3QXsqwZyQtop61KxhlpG3EKKDtaj6Xxdw70jaXSwFN6xMx3L2ZQ6HXUjR0KF+0MMMhYiHD9tIVbMsVjJ9s4n+QclOXjmHIqvAAidYLAg7RvPAIryVxwBX9d0TptQX6jNrCT40m5W9bq2tQPbS9nnINrB60ENRK9VIqqwJylRGwApsbZoO7AlD5Ke8WvE/qH+VG86vuEaa04bV24+ugvkS+xA9oHwvPjjhQZ1NQX1luduge+gUas4SKctMedsNy5FOlawXrmtNwAxvwca1lOxib9EENdPigZVMZzF+0b60iccphg2AXu9GfLeAyuuEzd9c5JOO1nX7ounCs1XUSeU5Oal8uwNn17P/V54HVZqnW4AIMdpw3XqkcL1zjP/hK/Q81rKLfMRxt4ftKLGeUE5OM18aZvL6GfA48xvXa6sX1boeEYX8PfEnlqZxlx02UGQvnzfLkJ33DfVsRrxq1wpmfM/B/C2rPfUxD/MlYqRpn7hEo9g5lVPzUJs4b/wcH5COROJP+QXS1MKf1HoR0yJHBSCeHAI04P5UVt2ten93gUfV6GnRzVeIGiFeYBDi944U1PpCJ9q0uk9ORcgEi5LCbs4cGjtCr3hcrnFBh/+OyPjUsHWQskeC3Avv0QsDQosQMTyxD0uIQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199018)(46966006)(36840700001)(40470700004)(4326008)(8676002)(82740400003)(82310400005)(83380400001)(6636002)(54906003)(40480700001)(336012)(2906002)(316002)(356005)(70206006)(55016003)(70586007)(40460700003)(478600001)(47076005)(7636003)(426003)(9686003)(26005)(186003)(8936002)(36860700001)(6862004)(7416002)(41300700001)(86362001)(33716001)(5660300002)(66899018);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 17:53:16.5733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd2463a-acc0-447a-e285-08db060f874c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7323
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 03, 2023 at 11:03:20AM -0400, Jason Gunthorpe wrote:
> > > + */
> > > +int iommu_group_replace_domain(struct iommu_group *group,
> > > +			       struct iommu_domain *new_domain)
> > 
> > what actual value does 'replace' give us? It's just a wrapper of
> > __iommu_group_set_domain() then calling it set_domain is
> > probably clearer. You can clarify the 'replace' behavior in the
> > comment.
> 
> As the APIs are setup:
> 
> attach demands that no domain is currently set (eg the domain must be blocking)
> 
> replace permits the domain to be currently set
> 
> 'set' vs 'attach' is really unclear what the intended difference is.
> 
> We could also address this by simply removing the protection from
> attach, but it is not so clear if that is safe for the few users.

I can add a couple of lines to the commit message to make things
clear.

> > > +{
> > > +	int ret;
> > > +
> > > +	if (!new_domain)
> > > +		return -EINVAL;
> > > +
> > > +	mutex_lock(&group->mutex);
> > > +	ret = __iommu_group_set_domain(group, new_domain);
> > > +	if (ret) {
> > > +		if (__iommu_group_set_domain(group, group->domain))
> > > +			__iommu_group_set_core_domain(group);
> > > +	}
> > 
> > Can you elaborate the error handling here? Ideally if
> > __iommu_group_set_domain() fails then group->domain shouldn't
> > be changed. 
> 
> That isn't what it implements though. The internal helper leaves
> things in a mess, it is for the caller to fix it, and it depends on
> the caller what that means.
> 
> In this case the API cannot retain a hidden reference to the new
> domain, so it must be purged, one way or another.

Considering it is a bit different than the existing APIs like
iommu_attach_group(), perhaps I should add a line of comments
in the fallback routine.

Thanks
Nic
