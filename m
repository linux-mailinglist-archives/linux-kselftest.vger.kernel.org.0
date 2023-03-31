Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192C26D2415
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 17:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjCaPdO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Mar 2023 11:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjCaPdN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Mar 2023 11:33:13 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E73F1DFA1
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 08:33:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEYvWJz+tdp5myoJyTkWyW5xwnl/BrJDlKUrc3OArewBQLoP5v2ovBZGh3NmoJxP5Qqq4DgUrRNATaPJ2/wKvRTJBFk4Qt0cYGHxGvmnjpdcs1ObAGfGK1S5o/zoBSrRoJXyuG1EIsEl5vV932ZhRjXtWbH38xd9A0iqS7HjAPN17HSCcYynmRvdLphtLvTvKW7J0DyKx3xzVTy0qMTLXIQQDrzzO0GJVh25vxk4jYjk7ViFCTrEEYbIF2ywCs/DalryXV/sXOjqLCrwicbu1yt3qu7vEZswQ3HZYejYJGS5kzDADiAzqMM4ilAI3soL/K1YEZ8lo6hDlN/hTzi86Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCETgn10UD9azxn1n4NEWbXkKG7vD/mdwBqtnG3PTsg=;
 b=f+qtmRqCm5d0Qz+7sELBg2qrpl4uEPBEXch0uzEbgmlN6b6TXJPwxfiwtco8LV+D3Cjdi4CUjS6+W87ZWltjrgzpyNalhluwx2u21PNv7LuZLa/SX1U8q8ksjTlO7VsC+pEffqWEDHxhrMEOJnudflEk/EhYf9BolNGXQaHxuj9IU6zuT/4WdI8ZDuKeMMeyrxg+NwgTqvaKFXJ0MLqGCqXpj4izQTfi4GJE3G9d0yvwoZzG9DM1A8t90xB+zDwmhwLyk0HoNcL6SlNBVj0oW7LYBZfVzoqZ2Z9128xIbJO7fU7b5Z/OOshxk9LtXDEva+WC48098P9wBm6BhOb2nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCETgn10UD9azxn1n4NEWbXkKG7vD/mdwBqtnG3PTsg=;
 b=D5mwm306HmpC2VJp/kOMWGZQDAPngljrFJJfaBhNNHLaitMsZi8IazCf5bacgXpLJfrRr+QXh5RaQiy4xPkwTzIxoa4DrJB0Svv3nJRRBu9GMc4V85sty9x+XE2SwKrYCEL4hgLp9Wgb4ieZNcVr84AXVUCTkYr8co7NC4V1nP/E9g+3PL7LljXzGi6zm6JszHVfTz19PXY78Eox7FJgovWo8aEJdD75Spju8jCOe+ZNL6vsZGE1oarlPEQ5NZ55bVBs4nmrhug5H5/dnKGhdjEwkIWcix5ti0by7Mf7bpNwTtLxgrCpMWPFAa4rXRjRtWEbLzpmKOJ6XRY4qV31CQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5093.namprd12.prod.outlook.com (2603:10b6:208:309::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 15:32:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 31 Mar 2023
 15:32:30 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Pengfei Xu <pengfei.xu@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 0/4] Fix three syzkaller splats in iommufd
Date:   Fri, 31 Mar 2023 12:32:23 -0300
Message-Id: <0-v1-ceab6a4d7d7a+94-iommufd_syz_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5093:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2e5dee-1ef4-499c-cb84-08db31fd23a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a0To093sPrD2LEV4H0bayaN3R9ThYItenGxuh5IHmYbn9gHbO8xkEF/+qAo9pIPxc+F9DVL3YvFrwmXT5FAMy7WRgk6AudhuJs8vL7IEBw+BbxkYfr6SH3jRw2kAw22WE3Jhlau1/XjvyRNeph0EvrRLMqyRRWqEwgnINd+vJa49FXr6e8xVRKJXwSXl4JrCo2q5wpwnsMPkTtj3AgFjzTN0nXxXu241pdMOjJFGRonvVDAM9RIppVxTW+SlRfnoW1sO1FhsSK//dSYe4YfK6hCNZkZfaaArIz9ohXYBwFcJKkA6qXmhVhXl3basxMtWxICmhw9SFfHwRAS3nV2x9uKzSXEWfkArjEcp8Z8UTLH7xf3wMuQip7bb8iajl9hFB9VHj9UHsOYcpnYZAeHHni4WQsysHDqwumPw3ydHRk0Ez3W4Car+zwWzxArIUoEaHTcbQeRVe72q4S2cYeZTRlZAMXOyFRb71POI+VyP5gkUqwt+W7yh3G8AtXeYJmCzGaxkN2gY8gy6tO8Y77CXKe6VPR04ZJGTAVxzL3iQknSRPM4Hqp730TTnnBdeMnASub5+vYrCh6tCoYrQxmYK9qfcYu5Mb7bdHxCOIw8Dd4o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(8676002)(54906003)(316002)(6486002)(66556008)(66946007)(66476007)(4326008)(36756003)(6512007)(6506007)(6666004)(26005)(38100700002)(2616005)(186003)(83380400001)(5660300002)(41300700001)(8936002)(478600001)(86362001)(4744005)(2906002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PgGD3wgyLU3zVCe0D6WqYIuKgYeaO4Cs8EV2msNLkOcM+d15O8I/7+ilQ/fX?=
 =?us-ascii?Q?MvGTeEK8o9m2S9znoEOP1wIYtLp0enwxNiyaVKWbsB4kyya8W3905eDWtZaT?=
 =?us-ascii?Q?4Db7E0Q+Rz8l5Lujk1LNlek8/n7Eyw3hnlvX1IkaeELdtk7CMAIByEJTs/iR?=
 =?us-ascii?Q?XKuujNtsIq+ZKHWYIpmOuvL6ZKw5riREbxBri1Vw6Kf+zygMeqiJCjZdTvoD?=
 =?us-ascii?Q?7nnV/47Mh3CIl3L+utMOrcE6+k1aypGYCJT5CC/ueb9I9wM7pjUrE6yCL1l0?=
 =?us-ascii?Q?iZitJeo5D1+RrlYzazHPeoop1NoCl1fqznMMcPxmV3jDLoBckMUVQO84mTsv?=
 =?us-ascii?Q?L/iMvF2HUizmKRpwJTVDqumh0HgA5leHl5FKXiWbYllkZUu0t6vwpgCgP16F?=
 =?us-ascii?Q?s5aXHAkbIEXYU1oReamCgCeieCdlidVlH5XkZ9vKNwKnRux9gfR4Xuaqe5uQ?=
 =?us-ascii?Q?CqZM3TIiKSER9b7bavqkAVIJFZ8T1TXR+Ak0l4pRZG0sdUX/9O9zLbbrpNkZ?=
 =?us-ascii?Q?XG7ly4VxcUERdZlNdJA/YW9fgZJptzrf0Wuml37Nn2imTT+y1kEsUuR83AED?=
 =?us-ascii?Q?ihC9WqAK+S+y+Hs0tD1t1Tx5fjlb3t7i0QgqrMzjahP9qb2OuIAMXJE6Ga63?=
 =?us-ascii?Q?AMyJZEXLmgRqIOlHYZNitBNijkjjYgsHhz4vFXq15Y6cptjobCjLC9HGT1ML?=
 =?us-ascii?Q?P3phdhrUrlHM9bSoYKzvjrR2FLKiK4JyIPQNKCxmA+BeclPdr+IO9qTynx3B?=
 =?us-ascii?Q?nEPGPU5VUQqEOfY9/rGe3mwcRSFiSGYjrVX0xDLpDRIN254PQgTu60r8NeGq?=
 =?us-ascii?Q?pJdZKmvhTCuS9iYtY0WealTzlzy760wQI7iejh9gkZzAS+t9O5b8Ox/qsx8d?=
 =?us-ascii?Q?WtFC0gdKegBMNFn7xunBpLKpW5L0Efq0lKXlfoNujlA77ql5HBa8DNMH+Jw6?=
 =?us-ascii?Q?nfMZ7dtW6hP/7mo/3RamLrc5iqOR5HdltEdKuy4NjToDGGSPERhQcvtgwYTW?=
 =?us-ascii?Q?EptB/Ml1oqBROoP6XwT2xWDLxRjBGHDW7EPkkcQjPuUstG7BNtaf1xOdb+98?=
 =?us-ascii?Q?8PLCipOhAbdv/InAbLbaTQw5ptaUth7BdolfzMplPtG2SV3k6hKiS6bG8g4h?=
 =?us-ascii?Q?b6gcRUUseLIgW3S+THdU4Ww/mnl5NUwUMopazM2s0aYKcy4f2FSBiaiml8a5?=
 =?us-ascii?Q?j5d1Jjk6CWX082V3LdlekIzmPLPzoeKfBS6GaISYiSGQUpQCwlkmrNZwYfDW?=
 =?us-ascii?Q?BPiZ9qS8jJzOoFxdFxrw3N/nVAjMnobwslYV/vFisOh0lhSaqVZkz80p07Gm?=
 =?us-ascii?Q?6w7744ZdeQrNgglEek+DvyN2GHEPcm4uISZus033g+DBT9oPd4PLhM4AWzIy?=
 =?us-ascii?Q?7XwbTBykH/e0IQeIdEvAIlbLP7DNIxA/8VqV3b9qflEQyZKJ9MAyJhctFzYd?=
 =?us-ascii?Q?tXoaBxinQ/jsxzt6Ja3i8e8eyDgbrFFVmgsynxi2L3/QLbxZkxpa8iqYM8sI?=
 =?us-ascii?Q?YWgloGLXs1R3iUw6X2ddRnT/m2bUzoqrBaesUkZoeR0M7hCGPl53AIY4uU7U?=
 =?us-ascii?Q?Wg+VGtbP5ctmAmHj2h4ImzPv2IDUuyScE1v/M8yu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2e5dee-1ef4-499c-cb84-08db31fd23a9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 15:32:29.9280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v533FgWJPK8i+hE8fW9XLRsgK2c4d+/EiOvyIyJ82AM9mPL30blA9026BgC8l/kS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5093
X-Spam-Status: No, score=2.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

All related to the pages code, and the latter are reproducible with a
simple test.

Jason Gunthorpe (4):
  iommufd: Check for uptr overflow
  iommufd: Fix unpinning of pages when an access is present
  iommufd: Do not corrupt the pfn list when doing batch carry
  iommufd/selftest: Cover domain unmap with huge pages and access

 drivers/iommu/iommufd/pages.c           | 16 ++++++++++--
 tools/testing/selftests/iommu/iommufd.c | 34 +++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)


base-commit: 9c7d518b9b71f4d5ca3d12952cda3417ac6126c4
-- 
2.40.0

