Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2BD6DE130
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 18:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjDKQn0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 12:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjDKQnY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 12:43:24 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27EE4C37;
        Tue, 11 Apr 2023 09:43:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3POoeJEhRXWJKdNbeLbeWQw2GDrsSTf34O/eHNz3yRdGXHSeXlKeor5tEw8E5ZK3FQ8s/UReXcRaGYqHqAtp4uD4qiOYUN13pUdj2cXHP2OV213oJ0NrFuupw2mx9nvXmhw9CuZ3adqSawy4U5DsxazjEQkUlLypZgO7RgHOm+VMJnaop/rzAcJRzDmNXaqzp27Uwl3wNcpeS1OckXIbs6K60TkH+QRq7FS/b44GPxmu7eEezOFrFUrkRlJCBhuRHzBpc+LIEt8URCrry1unXkzd7Ras0t7HhoWnmyeOO3LX850ZwZDHTAf969r+myXvVUek2Ick4ktmXoyOf+5/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CNS2HSmgh3e1COJZn4Kj1NyOKZJ52hw9Q0p1GlmnsY=;
 b=B7Ynt0p9B4uNk2UA7vCpiRWPyRvi6nUgcVCNixhEkg7vZMRbP1PfRTMTSa2CTh0M4BS/wJwMLisbta2v+LSiEBCI7UekotJUjkZmXS9+haF/3CXtDz/d3QBaFuxgJHl9hF+PpHCFGzEKPAGSdB+6w2T3Kc6dQpjOHJ81RbpwDxVd5l8NgoH2LRLRGBLI2COSZ3bPLHWqB70wageUjgMrqk04o0nXCpq81jrJoygcafAyGQpBd2Ssk4M5/rJ7dDxCuK5FM/Q3M4WxALRAi+eXh7dmqJvyqhfuOcn3BjYZTr9dzcz/SUkRfPG57+WQZabePQnfsHNAUmSvJieEXFF/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CNS2HSmgh3e1COJZn4Kj1NyOKZJ52hw9Q0p1GlmnsY=;
 b=XPcRT3V9I69Lm8G/nXWwrrSo+JN2spH7GwU9xQ6/GzeTF3+zUOly7HqDT49j0QJxEZwktvIJRhiReoa3SKBx23ClfdQmxnBgq3IMp4v0D3r+fMOxxqg3kW4pHw1YsdU0NNBskTefcbE0EA0hIt6IutjgNmK/SBubTuXOeeYJ2UazArB/dfi+FM2/pjim5HGAcXPS4Awre7ax0YedpNNcmPz9Q5W4Crnjh86lPjkn5OUBfztroYUQ6jnyF12cSsvrwtdbAs1523nSs2eTdbXltgN0GkKxQfQrNfxWcXNyszlbE5lQPmii3az9vM9bB9lMaEP9kVA8IidBO8hFlk9LJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 16:43:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 16:43:21 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v5 13/17] iommufd: Make destroy_rwsem use a lock class per object type
Date:   Tue, 11 Apr 2023 13:43:14 -0300
Message-Id: <13-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:a03:60::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c88baa4-27a7-415a-71b7-08db3aabdc5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xtyReyKaAd7/tS3//vG2AfbPDS7WK75xisrbaaQzWq4o9uVJNXY7bPP7PS/YzJI9w0AUNrtljp/8DnmSHTHC8sBqA7jRwIshU3eMLcqVhbQk0kNDMGe6g1//JZsE4+rThay4g8gs/5h/gI8KgDXx0ZvEewCSh4o5cXBpaKNr5+9fOR5/u8xUvy9KspM1JzIKXNYkW39tE5RDtQxLJk2UlXSLoVU3gYZyRz1JHfWLE7s1j+b4ht0M5S4aD14OjBe1Ak/ULOx/90AkOHvT+LggyvGcg8HTXCEwKiXPBKsoMxJGG/lZbQddLv2nSfvomayFlwdPP7XBe4NlJUEhx1LGFX4AOEO/LccUExGaDL4ZGNpN8mfcFahUKK7jJOnbE5KCg+BgUOZfg9Kn7yPRWv0jwnKAC9TV8dfKIy8heHFr2XPXd0YdikGHMi89bZCNIHqg8IszFr869uh/6QAdpcp8le02hVIqcAUFq56nimC75jk+1QrkEZSldYwm3n8mXTB/Dk303VWr9e9kV4qryZ6AnKW9wFl92Wo3FR/DmOnIJ210zSnTaL9fYfQ2i6ijXbOu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(2906002)(86362001)(36756003)(6486002)(6666004)(2616005)(83380400001)(186003)(6506007)(26005)(6512007)(478600001)(66556008)(66476007)(66946007)(4326008)(316002)(8936002)(41300700001)(38100700002)(8676002)(5660300002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sBbn2VKsFqHaSOvUXTluWOEWyZl8bjjBeDraG6gx/eNo+0qBHo9bAKVCm29u?=
 =?us-ascii?Q?pt7oo7pO5LUMNX/rLee3IPOhbOKyzVScYvmahw/7ZixmdmqdWtLpjqI+0PYc?=
 =?us-ascii?Q?KxvrXpJwPAa1NxhqUu8YVA4b0JCR6K/bNrK8zpyC4YihPknQPKJewVnP8Jd/?=
 =?us-ascii?Q?CiXsfAb7JYR0QPzkmrxNvJKlLVzuTbkCU4EqutVUozbonOwlfGEQFraICplX?=
 =?us-ascii?Q?w0dIQQFqC0e2FeCq5gvmbVa3ooHplwPf0pP/nt3qeWaGwER4qD7actwICQsz?=
 =?us-ascii?Q?/CI+JFCTEjthcLZtd/1JlQvyoQ6T6DY7PehJyp/gj+8kTDmMHrN1WH/mW2nU?=
 =?us-ascii?Q?ygE/o2dQZiQKP1Z+H8T7Rz6SWvc2zH3yRY4R6JG1EXTsD7xyi8W4W7KaUWcn?=
 =?us-ascii?Q?Qsk9kDos0hIUyIobdfMisgLqSeUL6dxRe9NwtsPMjTSK1iz/Pnm93YpMp5mp?=
 =?us-ascii?Q?C3bEy2NYNxdHNGjWu4yxpbvN9neRAB9H58Fecy1x95EFUMQuiIeFwAdAyH9A?=
 =?us-ascii?Q?kAAZMijLto5jpYQWMj19WL/MbjQZykWToC0J7lNglyxbimGmWFLWXi6SeeoN?=
 =?us-ascii?Q?BhWfjk7B/iV0ItRDgiTqtOXOX/ONO0DW6O/1MDjeJhvpbrBLosG/ojhgksiH?=
 =?us-ascii?Q?Z7kqo49Km3L6wr44QhR42460hwZ0n/FJt7Vn7QxlcUNW8ZsU/T7IP5WeM2T0?=
 =?us-ascii?Q?wQfljie4lyGxNjT801wLiZsKz860CEmkCZQoPHH9yU61b5U+sziiCrvIONSl?=
 =?us-ascii?Q?IAyEUaNlGxBCxqjl3sg/UYqSif4+DrJCd0qPr9PZ9p2VBMFct5VPZ2v/1hQz?=
 =?us-ascii?Q?ojP9XWP/ejVARBZzYYok0xRZ1wvRMnFJyY9sIJfT7wRxqruKEUJ0oaNcj/nw?=
 =?us-ascii?Q?vSB1YYvEQxXc4o8vMwKoPmv53/PzPBiv/ysKXdwol6OJU6NmG6xj2KlplZrw?=
 =?us-ascii?Q?/LLGpfNl30BWHOqkh1coIDG4IQlvhECi2VABQHjkQjLLzrglBX0m+OLys8/H?=
 =?us-ascii?Q?EcsudyOll8JDoCUdn761lWkTkZh606jOFSpqg50cToGWJA1doYGKVCYGfTJX?=
 =?us-ascii?Q?/C1qS8UB9hIg1IUsIsstVgQn+oo5UkCcIUxN2vBegFm7E9YPnn0/PBZmJL5m?=
 =?us-ascii?Q?FS6OeMp4eFqoZq01Lib6WP6pFTOv39SRa0g2u5+zjkg1ZF4M4TnHINCic+u3?=
 =?us-ascii?Q?kNTzK08psmTBggPfeohTuFXhuY9fSIuUTvW0E8YS+HGp16H9W9mlOVMQh8rs?=
 =?us-ascii?Q?bCszSmMZ3/001gwRuCOI6KAwZC9vTwrZHTqDHPeTTkTbBr63wRwexLeFt4s7?=
 =?us-ascii?Q?uTMhFLm5Wq2xTvHLa799rjczF1Si9CJ5AluzJIhA85eUx+kWWCpk6T/uEG+Y?=
 =?us-ascii?Q?ZQDGpAMj7K814X8y9U+Q2IAaWLnT9TCIwIDc1c1uAJS+Xjch8m3Vy6bSQMC9?=
 =?us-ascii?Q?R3yPkfBC1rDsxoPS2zxidbQ/j+UMcqvJiagEqJxM5lVVa4uh68lz5WkeKGYi?=
 =?us-ascii?Q?dKjjCj8tRD+NQfYri7FtG1wQ2qh0kYdmuB7WoySkfwn/pylzt6SHDkQfpHmW?=
 =?us-ascii?Q?RG9hx0HnMV+rsvcgFyyezFRPCvcqS4BqTP+ItsJZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c88baa4-27a7-415a-71b7-08db3aabdc5b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 16:43:21.5578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGIj1sOV6Co6NYhHhZf+ctE5HwKXowjfViNn5XLn50NZ/7A2dvwId+W6D4nA0f4Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The selftest invokes things like replace under the object lock of its
idev which protects the idev in a similar way to a real user.
Unfortunately this triggers lockdep. A lock class per type will solve the
problem.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/main.c            | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 471a3fdff1e0b6..f80b012e1bc200 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -119,6 +119,7 @@ enum iommufd_object_type {
 #ifdef CONFIG_IOMMUFD_TEST
 	IOMMUFD_OBJ_SELFTEST,
 #endif
+	IOMMUFD_OBJ_MAX,
 };
 
 /* Base struct for all objects with a userspace ID handle. */
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 8597f2fb88da3a..9cba592d0482e7 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -32,6 +32,7 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 					     size_t size,
 					     enum iommufd_object_type type)
 {
+	static struct lock_class_key obj_keys[IOMMUFD_OBJ_MAX];
 	struct iommufd_object *obj;
 	int rc;
 
@@ -39,7 +40,15 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 	if (!obj)
 		return ERR_PTR(-ENOMEM);
 	obj->type = type;
-	init_rwsem(&obj->destroy_rwsem);
+	/*
+	 * In most cases the destroy_rwsem is obtained with try so it doesn't
+	 * interact with lockdep, however on destroy we have to sleep. This
+	 * means if we have to destroy an object while holding a get on another
+	 * object it triggers lockdep. Using one locking class per object type
+	 * is a simple and reasonable way to avoid this.
+	 */
+	__init_rwsem(&obj->destroy_rwsem, "iommufd_object::destroy_rwsem",
+		     &obj_keys[type]);
 	refcount_set(&obj->users, 1);
 
 	/*
-- 
2.40.0

