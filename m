Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B57C6C3A25
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 20:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjCUTPs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 15:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCUTPr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 15:15:47 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76392330D;
        Tue, 21 Mar 2023 12:15:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpcPofD/BR8h0UNsZM9V+jQJZQ+NkxYkM89SneSG0Bp4lIlTu21Ydc8daHm3KS8t4oB7q3GmTF1BtkkWifm7+QZ/Mdl+jwL8o29CTzfKvqGtYBHKWfb+vGx6FBsZ8CAs8BtLZGAfpCwm/OJQMq2ldTMDyeELGIlJu3zsu170FMAQE95wE7HcUFdGSf0RK2kwpmsDpMKTSSmrPiCBB+VypoclNO0ZcIKWv88o9KBWbJBdDPYBAaDbO+imrtKTNN6DayjGpoGSerb3Uy7J+8I7mkgXYw95fYlr/rK0zd3EquLZ6iaSEd/9fpTIW9sd5rks/8OhlLzW768Mn/3vXor/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVidevSyosd0gtk6x3lsSnu8JEpKEa/QSkJRo9gBQVY=;
 b=KN5p74W1h53ys8HDX9F4N4xDCl3Xs74xFq82es2CBsQlAXC4QINl/i0r3akIC8kYsZU7L8g+ioh32jSMtvSFjajKY7vxdfrLcD+D2meIiNmNfjZRnxtvxGl3jVNwpV5nYm4mR49M2DWtUB3v924DYPcJoV83Ru+Nhn6x0lmGg5wc60SjHhJ4zkjpxDCEGb3oA1mql7Jk8tTpiepqXNBweCnwkC3p9k6ViaD7yMj06c5RTjO/o0rPO8py6Tf+sYJDahc3hu/NsYBS7uWzv/3GdMEyswcRMDyBcSdZHitJSzencNxwupBItJqdOldqfMU8r9LF8XVq3f11iwFIUCwYrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVidevSyosd0gtk6x3lsSnu8JEpKEa/QSkJRo9gBQVY=;
 b=VrN2vECkSbYqAfzHjEBDQCQt3WPzyzdHWRlwXfWoMEs4gazx07cPrwsy7s431i12JVC29PHwbXPn2AM5naQWJQgrTm5i1/cZKcMtPnPP7zNt5slruwy8m1Xrnw+R2DjJLoFx+spNsDAiwctOfotbCpoeU/yJKnqEQXi4GGTDrxk04ns8orZrCYfUShX5N1yUzbpIri7kZPWfnrk8ScjrvwY7hgEPOIopVwSVzJAjmdJ4uzMbYxZHcBriSNKzBrEVW74zuowRuMWoX3g2OLt9wrwyJLjGY5dD61qGP6rmgrqRXHGflVLdSRqTyJ743XHRQzB6VEFb1IObzICXfs50mQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:14:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:14:54 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 13/17] iommufd: Make destroy_rwsem use a lock class per object type
Date:   Tue, 21 Mar 2023 16:14:47 -0300
Message-Id: <13-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0308.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d202a8c-0d46-4e68-4918-08db2a408cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KtKkKMgKoE7iQEeBkZvV0OrBfACyvNAcHb3JONLMK8ZLTI0hZA2tmdk45A7y16e1s8JyFHZgQPS1I6itK5PNli64zd3yeJGKUHUgPRPblNsYYpibw8ix2KxNASOqq6QYYqrQzd4F1l4EXNw8thrwk8y1c40B23+rOTCmwv3KiJKRU7Tk/G+BvYwdf97+l4vQcejkA1D6s5EEAsoNOnzQ+safbbkejF8jDcEfU94AXquA0AHN4wxezguTWMbubA9hQVf41Mco835K6pksJvQgbG3NUwGP1BhEEXxBUIWAOdczDLJa8tpOCh8sLv0RGXlMkMcJqcE5sFfZfPmsmkLI5KwReSZtdx7++37j5HEpsmj9M33E6cfyWiu1sdIPmfI8DzXFioR21ai+Ejl80ycL4QkoWSclf2ahkGqpKRNUCrkdu/xFwuI6YhIfjfTc3chJ8jaLBlkQOBrjZxx2BjSio4vpwOtHOB3DyGC3kVZOZx9HintLAyeXzgCcFEBuJqvmpdLtc/TwEdVUWv/0Fctkc9WLrd3W/omQk/amhbiAn8fad0XicGWTujRiY1wU97yTMzBvz2oI3CuqyybY1laJbW0gnX2tqFYz7XtmmztBTTBL4SZliyh14NB09PRCsYVy8RqH85Qi37Q6s0d9ukZrMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199018)(478600001)(86362001)(83380400001)(26005)(186003)(54906003)(316002)(6486002)(6666004)(6512007)(8676002)(2616005)(6506007)(38100700002)(2906002)(8936002)(66556008)(66476007)(66946007)(5660300002)(4326008)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TDcYDGdrYU+anlzxlEN4IdHH9BSUSHS74MQT/v1T7FkYbgN2BVukWyyB82qr?=
 =?us-ascii?Q?LvdqkxLBm7nUO8QXATHLrwSMFDT6dCoQoxmaEbzCnLcWjGtMKlNyOvWS1qqL?=
 =?us-ascii?Q?BFvcnSYhn2Da1W/kQk1+fOq0eGDwwbfIZm6aJ5kMlZlmxsuQ2tkZf8aLTW+x?=
 =?us-ascii?Q?7R+OQZx2smRpBnQC10lVkBsGqNcmPm1QNSsvJwSyk8pI1PLGUjB6baRlVwLW?=
 =?us-ascii?Q?ZS0EGzXlt8GSRnidTwksxfW87w1/XRKpFupiS2uCG1EHhh21VP5hpN/Jm5jS?=
 =?us-ascii?Q?Bt+CFHLqzvq+avQkDympO3yayVcyuKWHGdiVvCe90FRcpDlF8DLQ3aJxR+8R?=
 =?us-ascii?Q?VNPuiw++qCptdh/6wgjG5bWlyVKvc1Ps6X252NlMXr06hEypMnIjd8F8Bn/c?=
 =?us-ascii?Q?bz+Vuduue15cW9aatKhwrFhvxH1cZkYK1oLHaqOVbDMcv+JT7JqCVDbPWnrp?=
 =?us-ascii?Q?aArzvbWhBgHjUh6oL9UtomNwRptaxTB+hq2IqlqWGd8xglH8/fkEiqggkWLN?=
 =?us-ascii?Q?A24Gu7OXtKFB++BHMYJXrWDSeI4PC/lz1QHGDn7ON4CB5fEqduyEymwDH3Uy?=
 =?us-ascii?Q?JxfkKaBZqfytJdRaIydwTo4tUhl4W32oIRSXeHV3b1Ju4rsmLy1rPGHxjFCH?=
 =?us-ascii?Q?nJV3Ca9NvgKAI6nNNn2G6/NBOoQatuSYSc52UL/p/QmbtwtLMohPZkIBkoOx?=
 =?us-ascii?Q?ssd3VdxywGXREE9uJf1vnjzQQefsUtL2KClRMvCKFxKKl73l0izNmyCNzLBj?=
 =?us-ascii?Q?O+pVEyoNxCWyBVAUOwykL1pn9zFpfFRLUVc4+Z7BmRzZmYK5Kt4kR6XLlbHb?=
 =?us-ascii?Q?hJ6sgzrpvdsmfCfnQexBQAao+wo/gIEGPdE4SQxf10T4QzSXyYt86uQDm3ut?=
 =?us-ascii?Q?XjPQzdwAsA/N4/6HOXKXjrLLuUknPPiJ5ffkUz3bc0UEPtDFyEspiONapUrf?=
 =?us-ascii?Q?Ru+gxBLuwY2IhM/nv5l8MdeZk7txocryWcsYAOA2viAZE1kEaqIxuV03/VBZ?=
 =?us-ascii?Q?eShHo8UO69hOsVMKkMj2D6GNlY19VO4eEr5W5qV6ZDy+j6PcfKYMhY2vhq59?=
 =?us-ascii?Q?3GA5vAxSBPpBtWKXgNC2u8X2hIJd/dkAWhVm2ynpp4JCuWDbbd8/sgUHbu+u?=
 =?us-ascii?Q?9SScoXQ/esZjD+HXQJG4Rcl0vqORsyjbUHUMqdXPRWi9Mc1GAerb6FYOqX+H?=
 =?us-ascii?Q?J8UB2U4LIIBLjcI61Ubca8Arc6y3IDcF6hrf5erfrUTj/2rvx/SgrocHzn1E?=
 =?us-ascii?Q?O14aoihQ/jpfjdPrV6B+rJiOuqo98imwJnvYZ2BcE8Em+Q/oOrTR7OQL1Oo7?=
 =?us-ascii?Q?7WgpVV1EwiU3EOPH9G19hetOUgLa7DqSMiXqn21AEwPNK6DQqkAuLnuT9qmN?=
 =?us-ascii?Q?aJs0kKWP2l8T4mi/c4sU/5AsmUK++iaD4WJvzCDPIyIMEOGy0iPJbbM3YfGu?=
 =?us-ascii?Q?uDJnHrhMTIEY26Uxvg4p8YTEnUiLgsSGFvA/Udgvv8fxTaC3LV0YeWcT2iHj?=
 =?us-ascii?Q?SKxlOqee9/5MzZVmkNPcbo34tzqWbRzUuHR0j9/zaOuynxxoApG55vD0spAs?=
 =?us-ascii?Q?gvLC+K/4a1SrPjf93p4WMclVzv17npssXlCwYC06?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d202a8c-0d46-4e68-4918-08db2a408cbd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:14:53.2733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBdUQGg3AXlI09FDczRyLurBEx9PzaZApJKBbJYCcyu+WdrIv47GxOVa1c90zi3P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
2.40.0

