Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8DF7D3F87
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Oct 2023 20:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjJWSts (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 14:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjJWStr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 14:49:47 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE63FD;
        Mon, 23 Oct 2023 11:49:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6xCCOKiAYLd0bdtrSnif/GKcqKdEVy7qnI4Lrj1tjygH6UOkf+i4Wndofq2RVyONKyRqQX3gKZv8MHJtZHiOoZJ2ZmBwCUv+qn+IqNeE+Lxn89C2vTq9URTSaK0CisK7e7rmRzeA5N2eGzAYMQecNMt1eTRhQIzWUQiOs1CjfTUvvygdvUfbAeqSyYZul8ubKVl85JVIjUxiNMxeFx+Xv4+S2+Q320haz/VNzvcuaxI2bmuD3tGYoOi3/qLe/iqRJ73tLm5ST3g+BnBabLr5+Kz54I0Xtmvq5PP3WK1r7J4hLu1FI6jo9BTLJoQ+l7j+0Ey/YjN7zFvvL6NrKK9pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAl5PSEGoZlEZcc34i218lRQ9ZVl6cwd8yOd0bcIzOc=;
 b=IKK6w9m9D3zTWnFuhJ9fX52kscYs6S3JoWkROD8yATl1k/LQLGs5Es1vWuxR965z+nehBcNmriSOWivq6USfT7eyuDAxHycgYUhQeokM26d1ASD3bZHzEwA8mwTlHO94Vn8c9JjqUC0sBTLf269AFGH9nE31LAwDhYYvkwRqqFo7iU9uEp3/WmFWJN315nFQy8IxRl3JNkIFve9dM0OnIG1heFY9DBzynGw60v43rUBRaWzOw/Kp8Uv82GOTRu18r7qMLCVlL9Uei+O2AmMhAGBi8Qdx/BBGkiMUwVcMcy9mtn61+06GDuIO8a8SfbJ4kewCkDMOvE6OQwnZAVP7sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAl5PSEGoZlEZcc34i218lRQ9ZVl6cwd8yOd0bcIzOc=;
 b=Yzft1Yvaxv4qEHKFF8oX6YhNcrRAS4RoJyf+qsx0WRFyftR9yVf2JHQrax8o2wNeCkwUG+mUPVp6Nm+h4LAfrhzpy1c0Oq8sre0I4Vv8zxfpRRFesRYzfAp7ENo8hLxIC6G0q9puEqHv0VOmF5LqZPUWDJ7+znsBzgZEMv4SLrG52jWPIaGEo0gnWbKr89IJQqI7cWndGfiE75ki+R/6CYb55bDhG4vZy/FLcM8XwAwk1VX9UeZ5EKGO1bCUMj6z4xmleL9R/WSmcNlIrLXOLDumANC2QbCiGC6ktl9z+wumn1VlcWKbU9ccDai6dLZsbYRVHSI1IJqBIWQXBcqi2g==
Received: from CH2PR16CA0015.namprd16.prod.outlook.com (2603:10b6:610:50::25)
 by DS7PR12MB6192.namprd12.prod.outlook.com (2603:10b6:8:97::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Mon, 23 Oct 2023 18:49:42 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::f0) by CH2PR16CA0015.outlook.office365.com
 (2603:10b6:610:50::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33 via Frontend
 Transport; Mon, 23 Oct 2023 18:49:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.18 via Frontend Transport; Mon, 23 Oct 2023 18:49:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 23 Oct
 2023 11:49:25 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 23 Oct 2023 11:49:20 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 23 Oct 2023 11:49:19 -0700
Date:   Mon, 23 Oct 2023 11:49:18 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: Re: [PATCH v4 08/17] iommufd: Always setup MSI and anforce cc on
 kernel-managed domains
Message-ID: <ZTbALk+6Qd4Q8TXn@Asurada-Nvidia>
References: <ZS7nb+mKanGFXhZY@Asurada-Nvidia>
 <20231018165113.GB3952@nvidia.com>
 <BN9PR11MB5276B9994AD06E91E07B7EF08CD4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231019235350.GY3952@nvidia.com>
 <BN9PR11MB5276A64DA68586AEFB6561148CDBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231020135501.GG3952@nvidia.com>
 <ZTLOAQK/KcjAJb3y@Asurada-Nvidia>
 <20231021163804.GL3952@nvidia.com>
 <ZTWabb6AbOTFNgaw@Asurada-Nvidia>
 <20231023135935.GW3952@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231023135935.GW3952@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|DS7PR12MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 038f2012-21bb-4bcc-218c-08dbd3f8d158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QWWN4DGzWwY4qHoBM4BEEpErYliPdPVZoRh+oUUlzz1qSVZUUMYGmL9DYMTrCO2qsFvfeCwjUlfG4NNIs/Pr+pQH8XkYJVsL31VBWRDA5PJrCocgEmAZGwihkqQ9d/coNwUoQ205OXcJTb5iaUX5jtBWpecD79RFKKFJa7w172cK44bF7yGGfSCvm0/2EhExiJEIpsq3X/q0RZ5qTDVYzL9w37rsEaNCBHArVzgyQNYy8LDESuRspyq8ndBF6rfjBmwWJ/yjYj1WbVz/kZFGClsICSRciMnl73P6xJwaPZNHrT7m01lh+DcJZqLvpe/PmkehBGAs5KlRJt+WzhS7wEttdtreotFrmqTdpP6BZC+jzdIOqXfN7YAODVrTDb6HY7cVBGoBvcGkreGMMhpWAyRERADye0YjOwmC6ZSmphyDfd+GjzSbc4tj4nLMDCEzfGDUqyjmKVYKWBRMG4j5l2iP6e9A9WRi51JIEO0s0dmfBqNmnr78RQWQnbQr2GtfRh/8RzboUSucHvtGY/NiNaHhAzjEjy5c5DogMTY5VkhS9pWzLqmsKv/9sIh2EldCz4oSZrTbFGrckP3ZNP2xEIEO2cunbsUuZMif/3fTRRhxe6X89ecpfa3wAqwqdCh11m4ihRaVI+g6kntafgjC1L3pOdZz2Qtf7GYygXHaO12ZknzM1izkT/x71fItk9Y4agrddSKptkcxPo+RbOsRc3LDhQ6bLBigHyebId/lVKWzlcFMQkUEerkrfH18vdKn4xAoKk+buB4WYivL8ut+KQ==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(82310400011)(1800799009)(451199024)(186009)(64100799003)(36840700001)(46966006)(40470700004)(26005)(33716001)(41300700001)(2906002)(55016003)(86362001)(40460700003)(6862004)(7416002)(5660300002)(36860700001)(8676002)(8936002)(4326008)(70206006)(478600001)(7636003)(356005)(54906003)(82740400003)(316002)(70586007)(6636002)(40480700001)(9686003)(336012)(426003)(47076005)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 18:49:41.9214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 038f2012-21bb-4bcc-218c-08dbd3f8d158
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6192
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 23, 2023 at 10:59:35AM -0300, Jason Gunthorpe wrote:
> On Sun, Oct 22, 2023 at 05:18:03PM -0700, Nicolin Chen wrote:
> 
> > > > And where should we add this comment? Kdoc of
> > > > the alloc uAPI?
> > > 
> > > Maybe right in front of the only enforce_cc op callback?
> > 
> > OK. How about this? Might be a bit verbose though:
> > 	/*
> > 	 * enforce_cache_coherenc must be determined during the HWPT allocation.
> > 	 * Note that a HWPT (non-CC) created for a device (non-CC) can be later
> > 	 * reused by another device (either non-CC or CC). However, A HWPT (CC)
> > 	 * created for a device (CC) cannot be reused by another device (non-CC)
> > 	 * but only devices (CC). Instead user space in this case would need to
> > 	 * allocate a separate HWPT (non-CC).
> > 	 */
> 
> Ok, fix the spello in enforce_cache_coherenc

Oops.

I also found the existing piece sorta says a similar thing:
         * Set the coherency mode before we do iopt_table_add_domain() as some
         * iommus have a per-PTE bit that controls it and need to decide before
         * doing any maps. 

So, did this and sending v3:
-        * enforce_cache_coherenc must be determined during the HWPT allocation.
+        * The cache coherency mode must be configured here and unchanged later.
