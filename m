Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C85756B73
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 20:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjGQSNT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 14:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjGQSNH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 14:13:07 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F691BCD;
        Mon, 17 Jul 2023 11:12:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6eW8wu5JKP47on6GxUgy6X3OlvZjnCrhtyUrH85zU7LVBQVknc8eS0Bz6gA3MuXMpOQelKqwdOZlSAMk9SKA0pIoflqFU4UP/LI989NyqFQ+D07AJciebiUCY9MelAprDcrTtJz1aNd/djKaI5QHetukeAc9joLNZYWlP6cb0TmOjsXA5jXS/2DsX6KgjwSYrsuijw8uOfOo0RYBA6Ugjv3iHECBEQVg4sihIvv9EC2EScoMAvqEe5+BPDYjb5D0UoFbsA09KLd/py67cB8VdmuE/NuAtSYxRe4NTjCaGSUF3TKfmCAT2EBcN8I3UiC6xKcot/6J5ZKQvamkAHYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pU82gALeUAkqIlXVzIpG958Sk5xxwixtATcq9aO/03k=;
 b=jf8Q6rpmHNdTwFIeIWM3RyN0lMYmITtB2Y7d1xy5jFyQcmeJxuz9gJov9cmMChEKGnixD22fa4Ou0uAu/QjMAXmklOPyvosnTkqi4NWEYej83ErN15uwqL6aD4IJMILg8ExZ6G9s1zry0BdTLqmjC1wXOULa4arfV5oXUyUbE2p+uWYDfqNIrzP8QF1bE/9Jd4xMoxjDittN0sb+WmoBhtXy1ZqrRHCVJGgoHtk5V5GPMsfr9ga68nPWC+SKLUggdzv2fMiMBGbW3R0uJX/adLoBVDmPxcDBUgqdn/8+i3gO79OycQ+qcLdGGyipA+B3oQlJ0S/I/wndSe0C0+30FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pU82gALeUAkqIlXVzIpG958Sk5xxwixtATcq9aO/03k=;
 b=bt5A1WLFh4HkLul58T80IxLcp0teAw/0xhmomjY3D8UoHf0Nj7RAfV7HPlIu3mt/aZjBFQRMK0MOtH4iHopW7k4tiM10yjSx9jhc5DVKhb6bd8hR4AoFoipQ+kQXxZ+ZiBhwlVpHQoCovdnYsY/ygHhcdz1lS6NAfHRQRs/uvZao3PAfURSfv4oMn0k+L/JjRzqYDG+ShDDYE6XhcmueK2VkXDfqoJsT9bS+do7gpkibSAODu7Ggmp+6Ze0DAOCbEYLReW2iL+sPEqDovZmmxMenJNRM3tz9NB3rHB+ACOGcWh2GoN2DYtAk0iTnyETV4Lu1pFZxN8Dt4lLxkJMjpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9137.namprd12.prod.outlook.com (2603:10b6:a03:562::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 18:12:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 18:12:18 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v8 15/19] iommufd: Make destroy_rwsem use a lock class per object type
Date:   Mon, 17 Jul 2023 15:12:11 -0300
Message-ID: <15-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9137:EE_
X-MS-Office365-Filtering-Correlation-Id: 3119e1e7-5df0-45c9-b253-08db86f15b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pBTCERWOAe1LTNOg4YXvYQ2SCICiX+21BCwZ/2FoZP49JhFCzfn+xf1sR6aA6e1y4bSZ8CYT7h3P4Lsog1CXJfRw6oZoCOndCERJR+riH+tBX0+do7mnR6wzlVEgGKpuJ3yDKHw+acY5sJa2mYpBOG1vOBeuIR+fyxQqsKumvEsoc0cv72YdufCNpE3zJLPyMZRsaFSYiKv4bT1gvMYg9Z/SCB5OiBRxhniPr5xsw/uDfsyWnFkhc6XI4yofsfjYQoo3dZVS43J6rcSrxUaPztmgQ4YkRxnscf+UZbuU26b0e2biOlFf57nLVT1LVrUyLRh/zBX2892kQGBmphYhdfN6pBIGu7Ieh96XRC5Gc5u+g7hR8fe2Gi4TvzflOKqBRy6weQnjkg6TgzLidYV2wE3B7EkHlTgDb6Oe+t8ZEDtc2tAs8DqHL91HfKWlHM/6tR7bDJhTCeyXI0Ndm/ppY/7Y2WPSE0pWYZn2pD7w30u/Y5I+QzKOOh1GtKXsWmvUnynPj5Go6depw+/BN3VwnrK37ndkSnoIYTQr1XCDqA6yni0KyUzVvdfRHqv6KJJ1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(86362001)(2906002)(36756003)(6512007)(186003)(83380400001)(6506007)(26005)(38100700002)(6666004)(6486002)(54906003)(316002)(5660300002)(66476007)(66946007)(66556008)(2616005)(4326008)(478600001)(41300700001)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q3Prk92mOEH48mtFE/RnXID5ffdKagW16bEg/m6AZFwylCk/1Oqr2NSlou89?=
 =?us-ascii?Q?ICSJvnqKdGU1EYlZJgK3IUPW+LSi8fKVI2ljjRhQuFhn7aszbf00re0bAt9h?=
 =?us-ascii?Q?0NqeeQWaJK/GSYESClNSZwY/7ef2qy9Xznn1DhHdJXxC4iA0KKAMk9sQBxnE?=
 =?us-ascii?Q?9KtzCLBKDau3nBuHz3mdM2aap8kWr8KPX0fuJXcDQapNiFRh+p7AEfWXDAgd?=
 =?us-ascii?Q?zANDL/kljOd1pbRjBv56TTb3dZvssjMp69/Vsh7b1RYhbHvsBRE02ueEsdhG?=
 =?us-ascii?Q?m0sA+Fq7fXSiY2XqvHj3XCpjHZawJPJI5PFYnWQkLpbbv1VNbDeIUvppNGFH?=
 =?us-ascii?Q?EmY8ZU7qPtCr2YElmOTrhpnzHsGeghjuEOJ47Lce3vubxOe/NGP4VZOWCyBo?=
 =?us-ascii?Q?k2MMGBcuvqFI2KqwSgNfdJW76qruBbYANRHOB45z9YE0R+N+fv1eHJUNHVfe?=
 =?us-ascii?Q?0cPetxykXKj3+G03+65vEsHssUzbgtHdVeu0lgDFacV8s/TDvfHBAtJNjaqs?=
 =?us-ascii?Q?IjGQClspJIPuociK5Mc+Culi/DMNR1lVankial2hXDjXiUzlJxkStT2tafuU?=
 =?us-ascii?Q?SPvhH+mYfvkP5utyUPUfBhJRJToRz26+gzYjrMaX2Nl+GnVvQzq7n1D6xa2L?=
 =?us-ascii?Q?HNLkzHHzEORqEpuJpsc1L03mR2sn06v9fQ6j/WF+ia1USW8zHWx5Ij9DpGYv?=
 =?us-ascii?Q?4XvSfDP13TXIIINdTmZD5Y0j59SLviQsaY4PsSsqiuzQE55gBz8CFfHC8omE?=
 =?us-ascii?Q?eGCrW7huXZq5koCCd+t1Od5+j2XPlIC8UQu3ZnUKtg71EPvxQF5JTh8f9ggx?=
 =?us-ascii?Q?QU6dEginLvYTf7Kfc4t9xtFJNhLwyj0yyli5d+9iUijVa9lF5TTthq0Sokyt?=
 =?us-ascii?Q?3SqvEw7nTqY64vgLE9qmfFZ4ifcio2gfc6LnVMhDBtUhIfYOSDjqKh8aSt+2?=
 =?us-ascii?Q?cTLmeHZvSh+LbnRudB16/oe3bpQeV5DClj9prlfxi8kd110iqTKVX37bDbDY?=
 =?us-ascii?Q?5uisl33S1L7w3G4d6CWDNlwVlSc29mN/i+gYQkyWUMeKibM5rF5gFfRiHkzC?=
 =?us-ascii?Q?STqWSjCK5zqF9sybWVLL2qDgJEWiO6G1Ipw4BNjshICIYJdK/QcZ3ogxHVJv?=
 =?us-ascii?Q?PAj8E9adIj8RWZBzFK+d//g4fSjzBFnDmlIW4eoiKxjcKT5o7mSU4zCpzsXj?=
 =?us-ascii?Q?knBnS0hdBym3Xb1+dNC9/rKYJR6x4muhRpmTRuJ9NC4Jw6N8M+jxzpJZOK7j?=
 =?us-ascii?Q?jbRWHYbN7EAq3WvHToTdWMD+kpG/8dEpQkBRmsDDldEme8EFXKA6NEHO4rLY?=
 =?us-ascii?Q?A+Uat4pIGeUgpyHaIDfAdRyMMi17WIwixQL4dq6c8Jgh2deW3CaDiOOFfio5?=
 =?us-ascii?Q?OtQWq9fNyr2530QM9j3nndt/oycyEnbm+BecyjraOPVNDSod+Nbg1OocF8tJ?=
 =?us-ascii?Q?HpllKo7aO7tZf9hQhnLzAUUoSigCHs33r7eNdhZOgqqaq/nPrr1jjZiWyy4N?=
 =?us-ascii?Q?6aIgwhcAk+7glCX04x57sp/F6o0tHjLvb2rNJW9tmVH9o/CFNXwwSAlMv7Ad?=
 =?us-ascii?Q?54+icSvs4SLR9bTVBxJxOU1ZZH+53KxSq2MaJT7k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3119e1e7-5df0-45c9-b253-08db86f15b56
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 18:12:18.1909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4S1cVPKX49+vEmSjBbKcqAjevjRE8Iopp5Gl87AqApBVZ4+VGdjP3rdLeCEN9xe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9137
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
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
2.41.0

