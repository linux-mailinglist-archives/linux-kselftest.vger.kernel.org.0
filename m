Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70906DCDAB
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 00:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjDJWu2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Apr 2023 18:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDJWu1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Apr 2023 18:50:27 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF751BF1;
        Mon, 10 Apr 2023 15:50:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ib9FxaDTFc/fWukhmfrJWOjy4oA5+39yhkyEHkQ5fZ+KsAEimIBVeT6+nldfhUz7r+wOQ4UiPurYY5Lv/w7bIuNgriAvJ6Fx2QzQg7Xgr1haDO0twAlqO6LeEAhvy7uneNZf4PSS3+8NwYExnPhGaNQrGsbKiSdA2u+iq6H0foLw6HW6bLcPThnNnRnIknNzf27kVbN6tD68GrAOH5kw0qjqmhe3kpCnIoDtxzUMu9O87qSpJuI0WLtd2hnBFUGGQtabrGjNGvETlTT+dV15/jxjKXHr7pLWdYWHlE7W/twVVKQI8vAj241g4iP5mq1T8Y3UiVwwgkbMIWprbqruog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3B4rjUf5998gTKbvClBzrvlQiVBsTqN5JAzGhGz0VeI=;
 b=jTcrtcle+3jTizVO8BIo0nFkRxM5lIhHTuvO+AnU0BFOzUxmCRQBCAJW0f0jHUSLEVp/dxgqvJE0vLRu014XSVKz2zDs5sK9c0URHnOv9IBkz1Md2Jx/7QbsVGYFiOrtkZSJP38Z8Xf3zViVbKLyYGExtWWKsUrK7xAVM7Cpe4HEfdT0x6eDZnFtxMoEja7sLeF9/9Jk9ID4W9SQ+POxG7/zK7SKE9Q8qqZF8z1BExIcLl2+RtePO1v/9kWA//0GVbSyK0ALdx5fuiq/UKSDnCjOYIJjHfipl+BRU/NPBmU2Pomk4CNWaT89QuX/VlayI9bNKKuwQ7ONTTxycN0vcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3B4rjUf5998gTKbvClBzrvlQiVBsTqN5JAzGhGz0VeI=;
 b=hB7SXjwgBzY4nwzNbbr9WqmkKWLvxIPelb9NqO0xI575zE75P8wlciu8McsL8b2/K+LehJC5XPZRgMA/a5iF4kAyuJ7yRb+dKbQB+M7sMbIADqLxFvDAiBr4dsCcHJKLljsZWwaEwyeMJW1Fevjp6dwRa6QU6/mLfs+YmFcyL8l85vyndaY0/iEVyy1+KFqTqMjMhnr1T7VvkagomuSYRUKZ1N66nQzi9yNLRVo7WXPbNKikeqb9xiwtGohjx6GKmaUr21lUMkpZwMLZItbr9UdzD/h9WLD0+NAkl00x/ed11FU0jKEBr8mhJRDugYcaawoC4OUvk3Y4TalRZsk0Uw==
Received: from MW4PR03CA0071.namprd03.prod.outlook.com (2603:10b6:303:b6::16)
 by SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 22:50:24 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::b) by MW4PR03CA0071.outlook.office365.com
 (2603:10b6:303:b6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.39 via Frontend
 Transport; Mon, 10 Apr 2023 22:50:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.28 via Frontend Transport; Mon, 10 Apr 2023 22:50:23 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Apr 2023
 15:50:13 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Apr
 2023 15:50:13 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 10 Apr 2023 15:50:11 -0700
Date:   Mon, 10 Apr 2023 15:50:10 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: Re: [PATCH v6 2/4] iommufd: Add iommufd_access_replace() API
Message-ID: <ZDSSoiMj4fFFmR0j@Asurada-Nvidia>
References: <cover.1679939952.git.nicolinc@nvidia.com>
 <955f7464fafc72984f3ec441671f37948f01d714.1679939952.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <955f7464fafc72984f3ec441671f37948f01d714.1679939952.git.nicolinc@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT065:EE_|SN7PR12MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d405f3e-1272-473d-5aab-08db3a15f862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V6A39LKTH0TdAH56DYLTjwkdK/blzO7T5eb9N6M8TGZvS0Btjw74JbQE6A2yTpsCRzemHnQa/45lnZYdIZLsqdTaA2zyo13+XDMN/VYtdMmfhVW88kRnpVyPy5A2IbLH4YtH7+RaxpbbAWmy7cmr1askWIFrIAXUq+y5M7MoqJt7kwZywg1WsTsN02wS75I4iYMHOq8It27OPu5m9e2AgwNA4BJIAUNYC0Sie+7rcVqXibFQidSfYqET3QSltpCdRy6mvx7hMeMD7eUc0oth/KJ48elr04pqLbG5nIogTjJ6pYbMWbi/NKFFHpEGxNCyxC/FIk7nrJwxHMIDwghEujTgDeipJEsVvH5uy4FoU2j7MroiD6jfmWpW40D8oaL49iuDVrz+N9c68Moe+A7bzSaTAU2rh1FiPpJlMqP5SexXgl+5+BZ2M8rheGB3wcRy63sQnBRtnEUHBRGIjU5/hxeOuqQsh9Q8nVwcd6E1chZwINexye8qsqWKFRVhfFQbohCu7s45nBiisIA/rZwW3rX4MGI37PFiQ5MgJE+zYgDcrrQ1ObbaywqO/Ke1Lf4ZwELQcu2eQvXtpolvbIiBqZ/6psFBKkV3EXWvNntdXV88ZCcUF5YqoA0VedmlhkbTaELvK5JvCWeImpsmJlJjl53d/rPCZOHqpxnGkytCtn9nfrs1BhfbpatbOov6I+a6hOg+jN4Evih9ZMtHqJNG+3jnXuD/ucoEwZnOti27swhDNrOOzeY+2pxGdy4zjJi2
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(40470700004)(36840700001)(46966006)(478600001)(316002)(110136005)(54906003)(9686003)(26005)(186003)(2906002)(4744005)(33716001)(4326008)(70206006)(70586007)(41300700001)(7416002)(5660300002)(8676002)(82310400005)(8936002)(7636003)(356005)(82740400003)(47076005)(40460700003)(55016003)(40480700001)(336012)(36860700001)(426003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 22:50:23.8039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d405f3e-1272-473d-5aab-08db3a15f862
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8059
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 27, 2023 at 11:05:03AM -0700, Nicolin Chen wrote:

>  tools/testing/selftests/iommu/iommfd*.c |  0

> diff --git a/tools/testing/selftests/iommu/iommfd*.c b/tools/testing/selftests/iommu/iommfd*.c
> new file mode 100644
> index 000000000000..e69de29bb2d1

Accidentally included a noise here...

This series is on top of cdev, so I will send a v7 after the
next version of cdev series (or next rc1), and drop this file.

Thanks
Nicolin
