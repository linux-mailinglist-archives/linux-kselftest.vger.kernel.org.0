Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26461764F25
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 11:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjG0JQd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 05:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjG0JQL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 05:16:11 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E977EE8;
        Thu, 27 Jul 2023 02:07:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYTlP/sNEQ3aZx1tPdxwWQv+nQa0ghpGYlsd0RldKpsvP9/7BOoOKx8tK+Oy+dEYZRWeNZH6EXCQic/5LXXSr5o8TBM9z9iAhe0vYNnjn79MHu1nnPpsdD/kpwf2tCgp8TrPAsNwkXrsEpgjVZhEiunE39IoMOr85TO5fZgTjqrDFD1C4AMP6Zw9XCl+G+kUAABhykndwP1be+tiiJeVe8TIQemSGdhXg3QNeJTro4qOfHEvPzq6zFHpQk4eEF4qCv8PZQ4QWWBfUcQeKHvyE3mzCcRkY3l80wj63kKO5HVe8Wk+qqGDlOjJL9r211b7e6R/ld9tr22LvDq70bo09A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWfI/hAC9YWbb+912WkBvEyVpqKTvN2EATxv5uiLFPY=;
 b=XZRGnxKSgTUB/kgjauSSapncYUeGCX+eiK2bSLqRLm+admptfWy9L/q8DBGBATHRxwcWtF1Tuhb84fZChppZX/IFXbHXCMQXv4k31ommnQv2s7IX07C16i9kRN80uP6dziFq92v1rMVuXLhzp2/5BCXNziIeC70jEFvmZPRusHUiW9lmVmV7/xiVz05hl7BAsmWbiIwNJchdi24IvXKmSRO4bTWAXkGxPQ+97/qamhD8zqPG7Ex1awpbp3Kv6oruexiGd9lYLIfUAcvx4ocdU4DorE5KChgNxNGddbAxlZ6cIepsSI9oJAG9GuLYI4VU2kjO5kJa/kcWg7BghI81CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWfI/hAC9YWbb+912WkBvEyVpqKTvN2EATxv5uiLFPY=;
 b=A0YbxBHHkG/ZZlOwyAP0BaN0pgUMo2nKPdF/TcosU6pvvLawWVolEg0MxeU/WWJydq3vaFpzbyHJljQh8I1RtiVI4cUL3reBVpKudSimP9PRlUuzIco6WIqQmu7csmYHPen0wuOBtpIozUDr09bkCvHtgKBVzBQ47+03gZ//3nMgWwrZuh17Wd9V5VF5isojYZrOAqESwculAOhWyDLD+VDDr3cwqUyqadGxWk3ibRjMC2KfPSwirYxiYxGn9FCMXW7/A+8rQsOYG1EfCvO3TFqmx+4/rEiIYq4i73Y8SHpKf1OJaabte/pfkFmYnX5k2U+YHSp0iA7cCFcB0iznmw==
Received: from MW4PR03CA0035.namprd03.prod.outlook.com (2603:10b6:303:8e::10)
 by DM4PR12MB5842.namprd12.prod.outlook.com (2603:10b6:8:65::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 09:07:15 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::79) by MW4PR03CA0035.outlook.office365.com
 (2603:10b6:303:8e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 09:07:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 09:07:15 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 27 Jul 2023
 02:07:04 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 27 Jul 2023 02:07:04 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 27 Jul 2023 02:07:03 -0700
Date:   Thu, 27 Jul 2023 02:07:02 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>
CC:     <yi.l.liu@intel.com>, <joro@8bytes.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <alex.williamson@redhat.com>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: Re: [PATCH v9 2/6] iommufd: Allow passing in iopt_access_list_id to
 iopt_remove_access()
Message-ID: <ZMIztsEHKjMadomR@Asurada-Nvidia>
References: <cover.1690440730.git.nicolinc@nvidia.com>
 <bb3c6845bc64209ae4dca5ee0dc87464fbc4961e.1690440730.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bb3c6845bc64209ae4dca5ee0dc87464fbc4961e.1690440730.git.nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT112:EE_|DM4PR12MB5842:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e2f306-e444-4573-a0c4-08db8e80df04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9QZOKh8H/ISOVq34GsNKWsYjjY14cqr3Is0pe4/8ylyK5szn2ODt0tNdr4p8GOqA0CcEDqnWmn3RmH2O7rPduJ/CMjDpvy+8C52UaGR8bipnHIGLiLuf8CQh+vgS9fndV5rXB1TXo1s9UWzGpr5uy20/MepoiNY4bHkjlcpvei8haZO8+Pb5MpuLyyshJZYaRas5yuoV4sRQIaOiWOUMF5UMc/xN3a4uyteZCFG1k/S82IHBsy7TpuOy0CU+gOZ1ysGgiLfHkv7vly6w+lFzoZ8VqNXq+qJcV8KMhan+wGsMQXjapQArOjjkGyUsDkrGB5e4dVWHsFPKETHy7YqihpFGnWD+Enj28nUqLNoTtQHAxK7xuyxbc4ITYb27FEyOzXdA/TRz6WuuYOEeFV1/YAZA4YIkMLq3fh6dik6rbXY12zSPYQfH9vc6xCQlEEK5tyiKEw9p8dZflZ2M86rXo3VeD4IziNrzP1Sebx5Sp7GWc3FtyOWERoL6oTQ5RR6pO02r84GIXChV+4LH8N4PkwiA3qtPxpVRiVutRslnBz2B5bHbtIg6Q+oVJHtAh65Ke+Ste8vyVmpy5GA995C1EM+DlupwxDFk1BfXdF7xJeA4reZ2knZECAcWGwycU8F8TFhNWzZkwWG5nb0Lub37imdykBl92//yJor5GKrtfPExNBFtnnWTYFZJ7leBPygazV+uVilK8OGPhTNG65UMy1YOM0T99Gp7f7Mnsw4k+vg=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(336012)(26005)(186003)(4744005)(2906002)(33716001)(55016003)(82740400003)(54906003)(110136005)(8676002)(7416002)(8936002)(9686003)(478600001)(36860700001)(356005)(7636003)(41300700001)(5660300002)(47076005)(70586007)(4326008)(70206006)(83380400001)(40460700003)(426003)(40480700001)(316002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 09:07:15.0544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e2f306-e444-4573-a0c4-08db8e80df04
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5842
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 27, 2023 at 12:23:07AM -0700, Nicolin Chen wrote:
 
> This is a preparatory change for ioas replacement support for access.
> The replacement routine does an iopt_add_access() at a new IOAS first
> and then iopt_remove_access() at the old IOAS upon the success of the
> first call. However, the first call overrides the iopt_access_list_id
> in the access struct, resulting in that id un-erased in the xarray.
> 
> Add an iopt_access_list_id in iopt_remove_access, so the replacement
> routine can save the id before it gets overwritten, and pass the id
> in iopt_remove_access() for a proper cleanup.
> 
> The existing callers should just pass in access->iopt_access_list_id.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Forgot to add:
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
