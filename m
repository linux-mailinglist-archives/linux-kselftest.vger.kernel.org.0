Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07DD702F10
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 16:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238825AbjEOOAy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 10:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239148AbjEOOAv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 10:00:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFEE10F8;
        Mon, 15 May 2023 07:00:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUsbxoKFOqvbrySvQVKVhG46QlSciHeDtEueazBVLeDf90D9tOhWS3oGYPunyhMDa5srRQ4dNI+Y+LG4s+5/D4UKD4iSh3LCA9pVFftXev1VN3R7+qsD9YNPv+y2ZBGJm1FdJjRJIs3yXBYTHQRNuh543MnxsVdZ3ogmDGpSvxccVsLDl+Gqr2aEs1GVt+LVfHfRrXhaIgMgHXwZ0T43I0Clm5Bbe7CP2XVZHccE1k0ht6J/h/rO3+MMkO7ryTGrgohPhZNN47iN0xiXLDiU9Ddt2NZGdiaxcNDrGxw8NL7zfXNS+TqLPnQ8P3rPmv6dEfpTCyHm0JEcHVwM74gIDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWVwXgaFStTSomMNmDUotkjw1XsLuMadJ32RM9QmCko=;
 b=TaEZejwQuT6tOfdwEG/VIWQ3bwZ8hdwb/8kwFI5GJvqnbjRz273hpDjN7GZYGEgMk5zFhFvpUBiWyBqAMOkpsJDmU1noDWl9acVnqqApbL8guNcHQpA2aoJa4GQE9Ka6kZjWW8SjMpGuGZA1DOvsnf/xI1Fv1y+/DxuUtKefX/lXnYXyUqoZf9xmU6ixO9SSWeh0PvSmxwSZtgcULmKu1/UDfhKW7R8XurU64VyRVr1yDBTE9kpbAIfuImXnfv58TnLvnR8k0L6M3c+IRxDu8rUyIx3OKH15Ni7O62Zx/ogfE5C8WOF8j7tR8pjYrv8K8PHcInme0Y/4AGeD78o9Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWVwXgaFStTSomMNmDUotkjw1XsLuMadJ32RM9QmCko=;
 b=qr/sMmXK+G8b0o3PrW1dTYw5esSME/WpEfmDyKC3vVBs/rNyDwXWxWWTDEZQ53vfYIx3Sj09wtzlj6iaNLtoq2JJlBLKZhw4YjNmLcOWQxg7SDnEGIMvi8J6YpgpOF1p9tTP5AlxjcOK2KvleHeRZu6fnySpNRLY8ombG56iO1nmnh+a63tsf/emQhznZUu9D7tmXtKQ/YMKvEK80BsTkG/zO5UvsXeTYcuLBZIcUyz8cqvEZhymIh4fRYGSuvRtclhNJS/LtuJ4UDtnNKSu9CSxyV69bwWQma361OAxR2IUhWXoKULjLPzshS7hKuWRWdM1Df6mooR5vUb/Jllgpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:00:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:00:42 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v7 15/19] iommufd: Make destroy_rwsem use a lock class per object type
Date:   Mon, 15 May 2023 11:00:30 -0300
Message-Id: <15-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00013E04.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: a83669cd-a5f0-4fab-aa3a-08db554cc1fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DSneXqWRa7pApvCaETCKpKupQdjBdWebQN7tIRnNzfUl5fLYl0F62/aXTiso2038jViMBwLscpQRkMDP4pFP+GlH/v5WeUR1EYN3L7t8NsmXRvldSFp5aPs5wXph4KwUTwVUZhTbXKQwzxWiiJahSyjqINRd7k/LOAD4DyXlg/yWqQZxhGQDR9kDoOy6zZ5KheOVLn+MpnfitdkEsmRdae3sGoLpNbAhes7Xu2t3nKsqOjd6YGbxkwjc3yNTWHJRMB7oNeRS+6tZ4C0bCsBviEEjbYt9S24/cl2yxcTHf3eNcB3IdDmfJIL3ZmbgWDbaZEIqNT/OzM1ITkEOFJtCZPA/hLzqVv0fsUD+Ti96bY39hoEuySAALmWk6qZg81oJX0yJ+h0gqHDNoQc/wU0Eqgp7Q3xSLsEgcMGiOrnSlB6kpf78j78eNM1mpRE25aNPB8/uYkYbYfaDvQ6KChLeS6tbunE3WqXvSFcxMYssmThax0Ve1Stg+iXvLyrq4aE6ArVqDw22rpdflEzGOu0AYT00ENRxfH/ihFqgtjnxTJHea0LM/UflGUuEgjdNSNx6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(6486002)(26005)(6506007)(6512007)(478600001)(54906003)(6666004)(186003)(5660300002)(86362001)(8676002)(8936002)(36756003)(2906002)(316002)(4326008)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O9NqDnbMd9wKd4j7BOtl/nrcYkyUhCqL5Lp5cNHE+DhEWg7KClzjl/1LIXhl?=
 =?us-ascii?Q?Yrex+d/Ek/xDKIcW5fED5KjYUu8cismVghpbf9iIByPQ+pzpxDhp9+CRdWG5?=
 =?us-ascii?Q?Ip7RzqjEfx6ZtCsFpP5z9RyA0L6c2Kdtmp9zhWRXDRXZk5RLw0UXylEw7ZE0?=
 =?us-ascii?Q?J88SeH54UpFyxH0zZvD8GmOiTJLa8W7XmQLanhdQ6ny9/RuSjqxXkUIYc5Zf?=
 =?us-ascii?Q?VYxfC3Mz+9eRfSM77f1bfzweGIX4kEiJcPPQtqgnqsPZYqjq3iwGBEjdRaUy?=
 =?us-ascii?Q?ngrLu5XSKl9VPgz8IKqNcd7ZXWwC5lnmBzE98sHKBHm2YV8cYiFRp6qqB4t4?=
 =?us-ascii?Q?ZU2u94SGeZiiyfX8yVJc5hhTDlEMmwIss1jsnWxkcGCv0vX7aHXMvxPTB9kZ?=
 =?us-ascii?Q?jCN8oLhpsrXdoYEtO7RBnGfXlvfXlH3F4uU6UUBezwq/vtwiJfnTtYond0KV?=
 =?us-ascii?Q?FhjqDhttQiU///gh9F2KJaEhNzyJLAItUou/nGj5kRxmxQEFh/jjDy2UHmnh?=
 =?us-ascii?Q?Yh+ZdCNM3iU1palI0Kbv3ANnVNRjOIiOkixGOZadPb5xveH2L9u9NivdE8+T?=
 =?us-ascii?Q?Huk2cQEThUkcNxH9gcECkQJj0lru148COfH+ekTwNOKPCkMQah+g+1sNmG17?=
 =?us-ascii?Q?E3imfEpZ7UnP4TtxADjv1as5dN93ILa31ZeXu+41CxU6vi3cnyvOaCGXMrYA?=
 =?us-ascii?Q?6KDmYtAkhCszt8x4C5yv4Y2yzb3Q7zWIoqhSH5K3uArjJufYwEWSjjDRWbRJ?=
 =?us-ascii?Q?BITF5/PhBrqJINbT0+6nmScX5+qEfAOKHTZS8H27Fhih31MMiOv7cNzRWOo3?=
 =?us-ascii?Q?ZGKfbWMm8RTB1UcpRfTa1c9QzAxN2S75ndE0y0lQrAD5l5HHPaUowUmqy/aZ?=
 =?us-ascii?Q?1YVrPewJYjO3chVVPy81eSu/PQ4dezvqUFyTtEisxS09sSfTeYil4iNbno+4?=
 =?us-ascii?Q?uNSxkZ8TBEAu4O6HUxGw/lIVbP5zpqrZJ2IY2xNWxyfYV0FCggE6qzJLy1pF?=
 =?us-ascii?Q?XwRi5062NiS0CDxyYajR7pHhKAQSFj6UfAyaLIBGxK1FZXhDTVEi9+DZjAme?=
 =?us-ascii?Q?zCC+HyfBtgeXMHiHymwWMA8OszgIH+JFiwWGnGucZVcqve7hNsslJjmRCRzL?=
 =?us-ascii?Q?ATb+0thuHlLWssLnd3oGrmUlvK633Xb+2pUSvvuFgeBIo4EA3YOcMoQW0ebG?=
 =?us-ascii?Q?Lbh7aPlMK82mAygMFC3pTo55p196xWf3eqpG9nWgtfKsSaESeQH2Kp9li+K5?=
 =?us-ascii?Q?P1kkgCJeFcnbxeNh8iAf56EhM4TB8SqpNRXeVt57eeURlxAAhlIyqUTQ96cq?=
 =?us-ascii?Q?HumYgF4PcV+tI9P5ckhH+eKSJWUEuJ1/ggDlhWyf5Ode7yqm91rgBZVSu+yf?=
 =?us-ascii?Q?EPlXGET3m3/n729kXGovtcDdJBbYSlxq3Mh8KzWtRUC/cg9KZxV0GggQ9tGM?=
 =?us-ascii?Q?kyI7rrsCxVZyYwD7oiIbsbi7lNNPUXzHAwpTVNuRuAJn0vmdjVq8IP6FInzH?=
 =?us-ascii?Q?Hcr/Co9xi5TdB+av3hjhYNq+trgPNS+RkpZhklyDyLwitL6kVBecfnfZ66Ed?=
 =?us-ascii?Q?6B0KqjdpBQ3baJxI8Jh2C169uC+oAyrBT1u/eqob?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a83669cd-a5f0-4fab-aa3a-08db554cc1fd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:00:36.4807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7PQyEICxbOb6ktTVTPpNrIQdqaeMyj7vhBtkzdJ4JGTzRL7md3Q21OcVqpCm7Yu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index 07d60d0640fee3..79942934a4d69a 100644
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
index 5b7f70543adb24..f219e47d882525 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -33,6 +33,7 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 					     size_t size,
 					     enum iommufd_object_type type)
 {
+	static struct lock_class_key obj_keys[IOMMUFD_OBJ_MAX];
 	struct iommufd_object *obj;
 	int rc;
 
@@ -40,7 +41,15 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
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
2.40.1

