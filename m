Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D856AFB41
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 01:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjCHAgX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 19:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjCHAgM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 19:36:12 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F259F23D;
        Tue,  7 Mar 2023 16:36:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZpgO0mCjtxa4Qi8CNB9Q/1y2HOUApnVGQhTqTPr4yDwyNw0MNclahBgF8TNi/vsOH+YmKntIngDqak/dwNcLVJeoRIfHKaOwjrmCc0c6ik2sEsGoii7E9xZ+J6z+6k2IQxCnWQ9x6Z/I/27kUU+Yn9BiQ4/kCMSn7X/5uwwKPoucC8cQnlEdDuRUJtScrNLyR+NkRoYIDpV/hv75PtPNKVmvs7ZspVcAs3vnpYwa/smhb0NWLqWvxe0dmYboc/XNC3OOjvHHfQ0SwuS4CVE2cWvaPcVO1uKzdVkzDAocB1cE0asM/kTAWkyiFpL1gPHtVBQkllwOqYkERyvde8RtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RV8l/ak8wlRmNk6ShwOnKqrD+JMedCjmNa0A97+8B0c=;
 b=dqZLV3Azk9Wz4s85dCgUrIN28IwwBTc+y271o7eWT21z6B5tE7vhMfhKAtGRphRnYj9QicIx28yBQ8mMeZBbgJkSfjDMa9gF8+lSn2+U6tg7EF1paSpYeg8MnsDhSiDCLRSK05tlzrevSNcy8nkJUjhP5Nx4oO+kl4A3MKq1sAHUO4kxKKaH12c64BiQtX8V8MtQQKa++2Bbz8O4mXcxywpkbzl+N3Rv1NMCdU03/JobBcQDlFDH5khjwmhO1JIzf+KG3k5u3vnZbibBlbIpeeqxDjB17PWXdtITLALVaMfKoGuPEnel4QZFz/SYXGYXV+mnemZQAEQmqgXuuf82dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RV8l/ak8wlRmNk6ShwOnKqrD+JMedCjmNa0A97+8B0c=;
 b=MvCtmbnwPj3SBYkEw9xL9pgldQNpmQDFwP7DJ9R7U/mkera22DxNetmnNeFP8Ky0BXlaEh4WUaKA0si3hZ+Kdf54lXL6zpEULMydYQoR5kVfCnbSGE/zL5JX44Z2dUG9FY5s81IypJAjW/tKOzwjgPz/s5iUh8QLf6kG01UZ32WvdY5fFvI1WxMdabZ/CzJA+H2i6t/a502SItLXYsywGKxpcfPajY1uP4WwRWtlbQLwjb5BfM6EDdGTCS5qg1LaDLBZ0MSg3b+9VgznAnVh6GiQ3siX36w0wm4WZMZA+RraErgJJ08df8WB778ycDabGe2MLSHSMM3szn3mYT3gSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 00:36:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 00:36:01 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 13/17] iommufd: Make destroy_rwsem use a lock class per object type
Date:   Tue,  7 Mar 2023 20:35:52 -0400
Message-Id: <13-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0300.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: c345664b-a51c-47a3-cc2d-08db1f6d169f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KpghV9MgXdEBDbhIl55O162MC9V0ygO3AnYC0rJGYk6MbsS7n8Nhqn+e8NclGyn41obFZt71Sfd7VXoXeQyOTbQkoCLv3usYmvJGcNfio1k3FggY1Kgazgb2/1hFIMT5Na8aaNL6bRCBVFXddQkhKLWOm61K1r1V8QJEW8fcGLksPrPi22+fDJfFEo70v+MI6a0GQFrK87FFRmQ2g0fChN831+vva0SSzubiu0q0S3I5C4xzt7zJb4ivlrzvqRmvoscu1JPRY+azPnUoEkfeNRbIKirOIBxSIX2KGPbmsrxYXGXYdx9u04OyJO2M4/X8HE8coYsV9VRt2nMLvbxDhUnWyxZki/LWyHYgbRdd7F28uGhC869hS679pGLd4MiE5B8FmgNF1YrHMapNclKeNrG4BNfAmZaRMBoBGhNQa5JqrBaO9gNBE2UmqD7bslkaICuxApUwO/D2DxRNUSElb6nWToUOu3gSVn6YbTFmZfXCKH0i54KjWmF8Jj2HR+iExcSIK2zGU1veCWBR4J1C/qijyhmPIYliS/qJvhyeKamxc3f6wl85TORcSPVzeOkoAkx1NrVoJBH20pamoFYR5cfKDpiPL4bLGbliqjOY9W0fenzy4FfovPtsKgRV5f8XsTTZ4CgHvrBpgYQNDVwanA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199018)(36756003)(41300700001)(66556008)(4326008)(8936002)(8676002)(2906002)(5660300002)(66946007)(86362001)(66476007)(38100700002)(6666004)(478600001)(54906003)(6486002)(316002)(6512007)(83380400001)(6506007)(2616005)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lCwRfi2ELfMoCFOfoqPRicGv6kwJS9U31sTK7RJN9O/g00lYCJFZXPPtUfSG?=
 =?us-ascii?Q?4qlvB8uZBXU6+tsUJyvF+He/Rf1/6NUUbTAP7KUEFdaV95ClxbvR/2JCPMN1?=
 =?us-ascii?Q?LrUVKLuJ1zm4oznXtsKWcKKJANP/NvedlKwOxQ+vZ45bQ0lYo45Z2DgPZlyI?=
 =?us-ascii?Q?w8JjUQ3uvqn+kXy9QoV0HNwY9Qv4KdeHmWdHn9QcaTfRJJJW/4lm6j3LsUUD?=
 =?us-ascii?Q?4a44cbugs7vx8hTUJ4kVsBz4HKeiojj4XNcWfsScYy2rNuXqOd8PrGEr19Ec?=
 =?us-ascii?Q?Dvd70aiVqOouO+dV+WR98CaitBrSaO+Qi2nrBpbkEqnykDuJ0S9VZtBtGeak?=
 =?us-ascii?Q?F2SZwaSylIHX+Ypk3lpEtd0EN9rDgez9zA417YJok9PXDbG5YJo4rFVj4uMV?=
 =?us-ascii?Q?pq9yKmyxtiWHdBjCii3vzqzMmvINhoSqOT49Jw5VYRFR32bYVVKNrthRno0e?=
 =?us-ascii?Q?H3d3voDAFXfHsbKx/R4EH7eRUgViYAr1ewG0Ozpu8zHjiULyAnngkFiGcdGU?=
 =?us-ascii?Q?GtBQr9yfrJ+0YqrumQSdhvKS0kqp/7Szk5e1lkbC94fjGSC7UPz1QEie+TUI?=
 =?us-ascii?Q?hfp77DGyf5hv8dEIuXe5Zb5WhQ/oxnoZf98vdgd8NDXyRyggGVQC42zebv6x?=
 =?us-ascii?Q?Tivm4/UtZRb65JYeXh3J0JfDyvDGXJ6cJpZH6xPIuxIICppt7ai9YMuCk5hu?=
 =?us-ascii?Q?2OrV0KEInyXGvDj2Mrth8fSZdStgLusO+GmukTte6lhoWhC7IwSkvmAhsxLY?=
 =?us-ascii?Q?TUkJV2kftnfLhpHUlwmW+ZY5MY8trjWpcEjXHhY/djMuUMKTAvuqDMvShR1Z?=
 =?us-ascii?Q?9u3UPFtTZ1SspsAqXPak1CNfDLAYTfIRFMK1cRmXyQnpdSQzpcgphanptUAJ?=
 =?us-ascii?Q?4FfVVAstoWZ+e/z/+5Z5u6Mb5EjusukFqXn9DQNa3ceFv2MWXclV5kXGJ1Jq?=
 =?us-ascii?Q?OD8+gZqWuC9Eyr6Bi514UnA2qJo4l1rYcSKbkEyeAFTcW7Mo0YTU2gbwm7oy?=
 =?us-ascii?Q?GLZY377HitRe3xJtqqCrumzQDU7e7FyuagaecUj2zDm9JLeSCJ0stH9qWTuE?=
 =?us-ascii?Q?RGpN5erPNi3BBd+jNq61ncxtLoVxIhZrhc9F7nkULaO0tII2IgxSVyjHx1S4?=
 =?us-ascii?Q?6cJM9C5Y6wn8RNjWILptM5OXa9HHgq5qxfetFFSMImRwitJy7B6DSnD1+CHA?=
 =?us-ascii?Q?4vIx08ooCjhGqhCe2U5GvyTWhy+f82updhzgp2z1he3pnrCb0/NmM8igMAnZ?=
 =?us-ascii?Q?30Jbnb0Dm89DjTZIpC/vMxJ9BixhjRuHZ74e7vK4FMdIauWK5P2KCO5ECKda?=
 =?us-ascii?Q?CMnUnderliw6CVGvK3pwoFikHbwnuAO0FD+ZhGBKOhDGRVM9CCoybGkW3mLn?=
 =?us-ascii?Q?WICshcREFpMIPblZisSBwPZn3VP5rnLCibwoGr+ATg3UsUzdvJbXuEQKp5xn?=
 =?us-ascii?Q?Uimg+jOZhbdTp/GXhC7NoNGGgosw/2mmBu5U4H7V29H48Pib5f6byz8fOf05?=
 =?us-ascii?Q?unXD4N5Br4bUNN/7fgPqd3S0wt8JnQ/5hFjJKFkTbUJ4wA9LGCOinCDOIpgS?=
 =?us-ascii?Q?o+SmNDmT7fRNwF2FfIxC+KWgPi+0tIl71I07gTIX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c345664b-a51c-47a3-cc2d-08db1f6d169f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 00:35:59.6399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: onRLvNSzHojjwfyseDJrj/hMmQmaV6IhecroV7cPoqr0bKb2wR02bafN49UELmQq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The selftest invokes things like replace under the object lock of its
idev which protects the idev in a similar way to a real user.
Unfortunately this triggers lockdep. A lock class per type will solve the
problem.

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
2.39.2

