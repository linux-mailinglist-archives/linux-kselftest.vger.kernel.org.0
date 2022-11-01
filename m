Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7285615269
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 20:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiKATjF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 15:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiKATjA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 15:39:00 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF0463A7;
        Tue,  1 Nov 2022 12:38:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4ntZlNgLyTjCvcvgYKmfoItaJPLxifB/FY3uQP4OmUMjfxg4xMtp262VpdBSrKIBMlxFCmuKCsok9m7D+AdQsHozOK92yEoYWlHGsjsgQtStBY49QDvFBTkTBwY5kfRz397xe6RYda7sfOqymTA4JdoXuhmEnRnp8YG3V3V4FGkY4cdQl0hIeAyHhMx1rcGfjCZmcppIc+nzt9f7bJ6ft5mvl5HbTKPYPxaIRA/myXnyyMuBWSmeIIsThpAHsh41tM3VTJoHjpQfZfh5/X3nZpjIfzLOH1UuqWEgY024TNfFZ8vNZZfz5PvQZBcOW0gDNjqcpHa12RLClLGwwF5Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/Mdhej9zJbt6GBu5KeLfadq1Q7S2KUvgzn8Po53DWA=;
 b=N80fNE6Bj3FjG0LfBUL26jkUK0O83B9eMnb7grfGNRr7kAf1fwGwMDhJXfi7NTimCega8gbxDYzdxsWFADg93pj/Xhw7lRoqyHeErfu3DvpR5RLPM5aQ/9zSStGSABmInK3kYAv4yA3ZR3CuAhyKUjAJ+/pe2bKTfFz0xic4CQNwQ/bVxbLbNZQSvsNfayOrlFxU04blSJHEZduwrEIiMml/YaiFP/YpgDBpiHutzNMB/Ssf1/1HZzyTwc3ipIGhTX2T1pIAM89+eqkuMeAZmtBgro0TqEDOMqlGtKjMhcGGWjHOxQLqaAuE1xMcCWSVpyjPXGGfXnSndKzwAWGNCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/Mdhej9zJbt6GBu5KeLfadq1Q7S2KUvgzn8Po53DWA=;
 b=bwBhHuw+8ZlYIVbed8naZY0P2OUE6IkveH+6NdXNSMUBP9cGm8mS2yqFNNPCBEhG2PVLRvGYq5Qff/1EnODWCTRT4nmjF9Kx0C8cUs5mwlk9q+3Lwpb+9K5fElA7zUzeDKIfLZsh+GkLoWfR9OixxnRlgFmdbICUvBLLdgEg39+Bczq//2BFwYdgVSvL2g7Gfk/Ymk1AWJF+ekf5WVlE1zm4sC5sSxg6KTLcWrRJNwJ8uaE42mKTVwCKjWB5Am2IMUHL2ptFClvdQU302tT9suE21IYkfWZQLFK56Y75EPKCh9weiex+EwkLV8J2Rt49kGbzb4BhEKmFDgUb65B/Pg==
Received: from MW4PR03CA0288.namprd03.prod.outlook.com (2603:10b6:303:b5::23)
 by DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.16; Tue, 1 Nov 2022 19:38:57 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::a5) by MW4PR03CA0288.outlook.office365.com
 (2603:10b6:303:b5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Tue, 1 Nov 2022 19:38:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Tue, 1 Nov 2022 19:38:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 1 Nov 2022
 12:38:51 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 1 Nov 2022 12:38:51 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Tue, 1 Nov 2022 12:38:49 -0700
Date:   Tue, 1 Nov 2022 12:38:48 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Lu Baolu <baolu.lu@linux.intel.com>, <bpf@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, <linux-doc@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        "Jason Wang" <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        <kvm@vger.kernel.org>, "Matthew Rosato" <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Keqian Zhu" <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 07/15] iommufd: PFN handling for iopt_pages
Message-ID: <Y2F1yBnFpv8jhosS@Asurada-Nvidia>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <7-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT043:EE_|DS7PR12MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bbdbb85-790c-48e0-2151-08dabc40b7bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vf+oLm3YM3z7XMiULJkGTB/HWnasLmpDgC62pt5fqTbMV5urbiR+UDY2J2mYUMp7QFMh2Srl+iE2MwVEnyl1R4DL7C2o5+zCnYHjmSK4Phszig26Liy9F708B2mKpbIAZ6Qk+QP7bYRL1WxaiXPuvHEXAUoG7Yj9IdGSCQGj3meQrk/xg0PJkVkaTh+bkyDN5orWwkUp5jfvwLjZrvYyGWd4CY738iThiU0iNaMcIAXNBKdrxfzvKBqq97CNDFkz7mJ8pb2HlgAcZA+P7bFH5bM5P+ksx02YSR0H6IA02Nzcg9oMIKFumj8pcFojediiYAgvXDuhq9qsR2kqr8CxgWE7OBeOMGfRHCy6jNfupxL54Ne+xVQaBr36WdyGw18ZVdjRJLyjwetQvWlZsZdZLzL1RXWr1fXsbQZXQvrVA1B0HXzMt6hq8EELJv+ltKTmhpjyZbjuj/2kVbL/OqP37KbKgvn+NocxuZhQL9wJYkrMnAFmY3D2kN+lupJVcBoBMa0F34YGrCOkIC1x0ReJ7YN5Ak6zWBmgAuU3ry+SuN+537F2+Z+F98powV75UHB38IZU99bNKma3acfEJSsrb/B4IvxYLxmWSbUh9Th5xOS6SfU8WJgGexdeIkiaYIWhs2e3b5o/+pbD6Qp3xFwqZ8+ByjsW1nd1Suu3YWe1k4xoCtCteW9IZQ1hrGSsx5FbQRmCNRZpWlWfGucx3tqeJ1oI4OyCQKGBaTzT5Lm/qKJE1Y4k26oeyBj6amh15sLA0MC5e0/5ow2Edr2vWIU8Qg==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199015)(36840700001)(40470700004)(46966006)(41300700001)(8936002)(7416002)(478600001)(40480700001)(5660300002)(316002)(54906003)(6862004)(7406005)(70206006)(8676002)(70586007)(83380400001)(6636002)(356005)(7636003)(82740400003)(336012)(36860700001)(55016003)(426003)(9686003)(186003)(26005)(40460700003)(4326008)(47076005)(86362001)(33716001)(82310400005)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 19:38:57.1897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbdbb85-790c-48e0-2151-08dabc40b7bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 25, 2022 at 03:12:16PM -0300, Jason Gunthorpe wrote:

> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c

> +static int pfn_reader_user_pin(struct pfn_reader_user *user,
> +			       struct iopt_pages *pages,
> +			       unsigned long start_index,
> +			       unsigned long last_index)
> +{
> +	bool remote_mm = pages->source_mm != current->mm;
> +	unsigned long npages;
> +	uintptr_t uptr;
> +	long rc;
> +
> +	if (!user->upages) {
> +		/* All undone in pfn_reader_destroy() */
> +		user->upages_len =
> +			(last_index - start_index + 1) * sizeof(*user->upages);
> +		user->upages = temp_kmalloc(&user->upages_len, NULL, 0);
> +		if (!user->upages)
> +			return -ENOMEM;
> +	}
> +
> +	if (user->locked == -1) {
> +		/*
> +		 * The majority of usages will run the map task within the mm
> +		 * providing the pages, so we can optimize into
> +		 * get_user_pages_fast()
> +		 */
> +		user->locked = 0;
> +		if (remote_mm) {
> +			if (!mmget_not_zero(pages->source_mm)) {
> +				kfree(user->upages);
> +				user->upages = NULL;

Coverity reports BAD_FREE at user->upages here.

In iopt_pages_fill_xarray and iopt_pages_fill_from_mm, user->upages
is assigned by shifting the out_pages input of iopt_pages_add_access
that could be originated from vfio_pin_pages, I am not sure if the
remote_mm and mmget_not_zero value checks can prevent this though.
