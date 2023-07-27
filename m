Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13BB765BD3
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 21:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjG0TEb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 15:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjG0TEa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 15:04:30 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9A830FB;
        Thu, 27 Jul 2023 12:04:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTMMPb32Ch8dnItP849KRTrv7fOHJCLrLMyTpjrx8H9kS0k89zJyi1dUd7J4IQrb71vwUta2/wMt+1JTuMv9Kbtwb5ZwEdjrDKTBOZ5r/Enls9gaLHlqjmie3cjtxrs5bq4wU6QTyu1gXxlOVnTcp/5PQO+28WGfZ2D4Ba1A6PA9Sj6/h9Rg6DL14XkGhNYMvk55XUae14FK3nyp+E4jExDujj0N23lTPOMN/CwBGZYpfyCjyLp0rj7py4KxT8FRzlGxea8+92PXFjwPVx1bPsPZc0amrrKX9c+SFv3yUtmq0JDfFhxbG7uVFGm6D/zmkbvZliStrUfqtNTl9isdSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRRXd/e6Yz0GbO3AfaovNHOustiyT79PwQ1bjXoRG04=;
 b=iojsFMUQbBDxl8bnE+VXweFcRA1MXFZBJwgv7yqEY/gkLD3gipyC+Rbn6ZO+ne3TSlqXoug9GfsQAoviy3YtBTOx8iwsMS3Ms9KbUj/882SGn9TDDnfErCZYTxeCE7hvia9FpZcEaElft1jY4Gi6CwHnDPrS5LEi8YgkrYWSbDXvlWtrbKC/moqWQ4uzvpJQkx6y8S7SsElmvo/bPCJukKCev6LEd9Eknk9TN6I4rTwglRhckQeJXcYhPxQ4C9Qgursut/zKHzuru2JTeGt8r2y17RAGPxA9U7q9MeoWkNMC8vpNP5QT5Ai7RCJEttp/gy8LCK4wcIqXm8JYBQjYzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRRXd/e6Yz0GbO3AfaovNHOustiyT79PwQ1bjXoRG04=;
 b=j9aFEfo14uppPBfZAE3KaXIPvFikV6t8c40pUk+IVunLcSNmNotj5cKu25ffSXgDnQBZs+wvhGYN9f7ib66/AOFxSFpnNU4PA0zNaVHBytEwA6r8O/t/gbak3t3I5DUXqaNVv9QcblHiuafTahzRfmpwPpL4J5wUNYFV7TojmMKsL2As3/Fr59VAWVqMxviyVMsL/4ltvZodg7qR691sF/6oRE2rb2TNNNxwQg70Q8ri4nHT2gMjFSybZ5i7VfhW/+fLoJk4Zr/beUaBSq7OgWbTlpQ7Y/TaUL+rg8w2vqAzpZHvF3YTe0SiRxyewRswtB0UMHF/gpITFb33N98vFg==
Received: from BN9PR03CA0566.namprd03.prod.outlook.com (2603:10b6:408:138::31)
 by LV3PR12MB9093.namprd12.prod.outlook.com (2603:10b6:408:19d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 19:04:16 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::7c) by BN9PR03CA0566.outlook.office365.com
 (2603:10b6:408:138::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 19:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 19:04:15 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 12:04:02 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 12:04:02 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 12:04:01 -0700
Date:   Thu, 27 Jul 2023 12:04:00 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <kevin.tian@intel.com>, <alex.williamson@redhat.com>,
        <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <shuah@kernel.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <farman@linux.ibm.com>
Subject: Re: [PATCH v8 2/4] iommufd: Add iommufd_access_replace() API
Message-ID: <ZMK/oN6EUdQnKd6i@Asurada-Nvidia>
References: <cover.1690226015.git.nicolinc@nvidia.com>
 <5dfe3e9a9d511919cb105459ca9d96f013daadb4.1690226015.git.nicolinc@nvidia.com>
 <ZMEt+SMFBMKT3AoT@nvidia.com>
 <ZMGHFI4KB4XTG9EH@Asurada-Nvidia>
 <ZMGt/4CCCmUB85HX@nvidia.com>
 <ZMHdfycdAdmqB2VB@Asurada-Nvidia>
 <ZMJc9elDILpHaKP6@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZMJc9elDILpHaKP6@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT005:EE_|LV3PR12MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 977bf219-0445-4681-382a-08db8ed44572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OHKQ0b5f2Rnk5AP02TQFPSfXLRh0HDstAzWYQD1TDPx4WdAMYsxFkH1H5OHMJx4Fc5w55lFRgdYOSs0qLgKE4FfIsmsZKcNlhkvnPtf3PApq2Jda8m8xgraIsh9273PKx/Mrzy8k3nCxXdSQoc76aRJrWzvOww3FEUv7Z12Je+Aqck6FvkkbD9H2ZEcfZWzLI55UjoUx8xj5N3tRcF/kFrG9cfV5zyXpabdzWxL6qihsO54ujc4kAriH9X66NmvBBct3n425xth6jTxthSxV3I3RtyGkelsGPgUyWBUS3PKRUiyaUEyKl13mPmAXl/bT6ki1BV+R78e9mZ6TscNru+YmdU0M/ElvTS9Qx0aWSeRfq+TaXSfyOWKp56Qqq0bnZVjKKGjTtMYuqrAThSRo4nafCv3gKo6Z8tJVKywdCv/wHU7yicjmUv4qNfb37S0Y9JVsgTcXAzPuzXfTwhEXwbCNCyQ9cilfaquAW+hHjQd1FpbW0oaOsRU9quCjKPhtbDIwNr07umZA9HqM+MwBS0OROFbfjapruBfd3gY8GUGV7y85KtOWrKtw+BluRpiL4if1PihGG2bPd0ZYmJJFj6kw1wU47+cuFcCQVuRANjp4xEURKlmnvW97Zha2xrtF7qDyMZBfIidfpRCaZ3Am/SIj+y152LKBPn0UpgchiN5AeOuT1Jt64HzEo7/sGZbLt5r7/1gemcI+7iHwAPk1EswrRSg02UI4YOuc9CCSGhko+Mv9JGcWHZEuemy2IQYh
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(33716001)(4744005)(2906002)(47076005)(426003)(83380400001)(40480700001)(70586007)(186003)(70206006)(336012)(54906003)(9686003)(26005)(478600001)(7636003)(86362001)(356005)(36860700001)(55016003)(40460700003)(6636002)(4326008)(8676002)(8936002)(316002)(6862004)(7416002)(41300700001)(82740400003)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 19:04:15.0506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 977bf219-0445-4681-382a-08db8ed44572
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9093
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 27, 2023 at 09:03:01AM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 26, 2023 at 07:59:11PM -0700, Nicolin Chen wrote:
> 
> > I just realized that either my v8 or your version calls unmap()
> > first at the entire cur_ioas. So, there seems to be no point in
> > doing that fallback re-add routine since the cur_ioas isn't the
> > same, which I don't feel quite right...
> 
> The point is to restore the access back to how it should be on failure
> so future use of the accesss still does the right thing.
> 
> We already have built into this a certain non-atomicity for mdevs,
> they can see a pin failure during replace if they race an access
> during this unmap window. This is similar to the real HW iommu's
> without atomic replace.

I was concerned about, after the replace, mdev losing all the
mappings due to the unmap() call, which means the fallback is
not really a status quo. Do you mean that they could pin those
lost mappings back?
