Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87256204F2
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 01:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbiKHAtV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 19:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbiKHAtS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 19:49:18 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966941FCD6;
        Mon,  7 Nov 2022 16:49:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuZBDX9SR7DIfolU8jPnfCY7c8qrdnCqBWi0wvtcWqj0DHvwGed+GFoZGzS5Hz6YWogzsUXvfwLvn6EFPTzO7S5lTXvcJw3TNOBBQYjeABk2vwYoKK6lGHHMEy3RodeM3D8sLDv7aqPyFcMLqf25+3HRDU9rPUAPQYQ3bu3Z9Evy/uvznNsxorAGDij8WZAVST+nzeiS7rm1iCPIBadEmZ0tohY3AwDjdsadf1nBZpOpQ4Z2wavrB1MrdnA3vEKjJGiF8cnoImCgmd6Qd3vRUTZhIL3Zm4ey47Le6IDhY/1kannANsfQij2lgriItazFzJA/M1pbqY1QQAzQ2jp/wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDg7F6TfTgVPKaVY/LAM/MW4spRQ6T+Igmhb1mVUwVk=;
 b=KyLEnuKP2g+ZVTe3UcC3EjCrAP1frse96hiXkshPt/8oha9rlSJtl34VVVw7faItEtYqgqQQsZqUHSfw7WBGkEqCqEXktdNogewJe22E6n4FEUTXtZUDZP7coorgGbIgzpCmR2KmomDUVO8QKhb3KQ7D7qR+by79xgqM48MzuaHc7oHDNls8bJ0VngpMFz+gB+vmd1RN3lUrHBY2VYAVh/d77f9FuhR8D3lIuE6g1apcJptcZ42MvqNFJdQs2q/831mxnGxllu6c0PHESEJtuLZ0VaUGLycPj4a9W5KJo49AvBmwXQ/xw3C1T/9PbwnVPv2mvmz7yNfdCJWh4mglFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDg7F6TfTgVPKaVY/LAM/MW4spRQ6T+Igmhb1mVUwVk=;
 b=o0vl0/b2UVYDGAtaaBGj7kPBcUqpl+5PvuIZvG3h+cNPOhnZBw7Ld16Kl7r7uYky8R7ZdCaRcEwOA+c1N6UN8Qbo3ZYWNFqZtPJ16Aq7LcDfiVBpxkMfE3QZLTkoESBfuKhb/oOiSBifYxoVoeLblZB04vSlyz1mSVvUGfOEWXX8aG3YfJQLH+pHqC4oLcKx8fYaG5Eotii1OXSa/NzGY9jhsZIhcGzKUcN6Awe0KiV4111TAhr4ZyVJHRtc12alK9TjklrwUWKBzYp60ojHmWIGnEDfvZfwSGiuRGt0F5LpPPvBpPwaXRjX+xogHrVKxp+AzMfbAhrX/095PTlWmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5212.namprd12.prod.outlook.com (2603:10b6:408:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 00:49:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 00:49:12 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: [PATCH v4 03/17] interval-tree: Add a utility to iterate over spans in an interval tree
Date:   Mon,  7 Nov 2022 20:48:56 -0400
Message-Id: <3-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0027.namprd17.prod.outlook.com
 (2603:10b6:208:15e::40) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: a65ad677-4663-402d-fe9e-08dac1230cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GU79ZTSAZG+vg5pJHkUnygcf7K3YE9WQeiO1qJtg7NTzUNcx4tlkBOOpCfPnHjUFN9x04LGMPUURRnjxBu1h/l1wkKLyFFIyGZ4Om0JLpHm+Kyt2qQ5IQt68HmwXEAL8rYpYjHj+paaF5fZpnqepiLuXRS291mnGdfC6JyNuZoGw9cLjh33KHCwlWFdMUaY44FPANzRPk0oIJkw3rtVeppjJk/pXwbFe4DAgVV7yb+ebW7jYctHwFFIc7O/hGh6XXAL4cscufU1a9MjsXeXEETBIcHeNwN2YmNNEJ+o08Ly9wpeZjZKAqPuWVr4E0fJdgDjJw4tfFq709WzU9pIOJaN2CRFiVrdTSqBVJmd0GiIF+YbKNzh2+T1kCtbxY+xkpz996P5ZM+ocw9j9Pjdnth44ew0gGibyYbV1fXwln2Z9eSKY9gVUpMkzquYKL2w0pELaFfHlrpQQJvyaOUO9z0BI/MhEykgvK/49AiLcnPWkwZx+2IjzKgRZF/UBXxD3AGdFprKlfY0TyYZKlalsAGFdg2g/6gvyEqL3ukMlpYgSAgjrcAhN0TIIXscvzxj0tABt6AnbNAYqZQyeC3bW8FcERwKhq0Poljdbkx0qE42yrAZ9+fD6xO0joK8CppgTDwH8oS0JrDGS0SPeTxSsP4idr9qJh8uxQxR8i2ylu4npytnyIBV7BfH8y7ATsHfyQ+kVXq70aWw8WiENEejXyp2vc6awJq6RCja+kZc8GJW7MYrLl794mW+chrtK5vRMmTE7wkKjKdmH/ET5TT/zzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199015)(83380400001)(36756003)(86362001)(478600001)(2906002)(6486002)(38100700002)(921005)(26005)(186003)(6512007)(2616005)(54906003)(316002)(4326008)(66476007)(6666004)(6506007)(110136005)(41300700001)(8676002)(8936002)(7416002)(7406005)(66946007)(66556008)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CTBP6Al/VIqGjMSIE624m4CvilTurR34IRuoIzTmryzRKSME8RAPY6/qVfKB?=
 =?us-ascii?Q?XgfuRr/6Xy1oUXBTDEExYNAn4XHYgIszY3t7C4LPFuFwUr0AijRthza7SYMj?=
 =?us-ascii?Q?+rTlsOuY9leIE8+FGf3tI8YB7g0EMMQcssF/N4PYfniJQgpyEzyEDy559kN9?=
 =?us-ascii?Q?0dcB+EChp6Ee4ClSAN9b9yJxsK4w8tfQ87O40z0YoYYuURlzbTkkQ17I2dpI?=
 =?us-ascii?Q?bRA2PZ7aeBPG6BRjZ7IxlTDZ505E5HsbcBotMexB8O+vZPiwBXMn0VDY30H2?=
 =?us-ascii?Q?tycKN9KO3KPtJ77GojVYaT6eIxmat6KHDrRs1v8McTUquFmpLkOWOqugtcVQ?=
 =?us-ascii?Q?Lvs2kadj4Otk9bkHK0ou9wYjvo39KBTQFz3MPd4hdzr4mTFg1JwLLK6aouhL?=
 =?us-ascii?Q?APg+M8fN+33iPv8Hw4Ufhs4aeCCw7Np99c6MfQMMxCgk3gZKCSLgyES/hW7d?=
 =?us-ascii?Q?Ys6tQtAHMSwit3uYkNPCwbeV7ZH6Yx8RNFGBzZErjk/336ZM34JvJuAPPyuI?=
 =?us-ascii?Q?B9/g/tqXUhtaCm9o0IYhq4yHZvwlnuSyKjdX+SSPKAcamKwXbVeqJaObf+i2?=
 =?us-ascii?Q?VrsGr56bxLbhv1l3gpJcaKEEUSsSr9hCRgGHP5gBfIaHaVCWG7KSa9pFuq0z?=
 =?us-ascii?Q?WJpZouOcRRdPpPbrX4N6N4zWSrRRynUHHznge5pyyyfVCo486HiJzGuajVeF?=
 =?us-ascii?Q?5GXZQxkVr0UMG9k/OzcspdDeQ+2D8E53jsIllYfV+qJB4+WrKAQoNpQ++lci?=
 =?us-ascii?Q?BGKMEaIPe1CRFEs+aN2UxjUNsCzAQaJ7/uQbJGld3A0qXDLlTLZXtM3XuhME?=
 =?us-ascii?Q?aTKnwFhV1qAvYLBry69YV0GKY4lGOCICL0RnEUxN45oPpAoJpg/oWZVxDwxU?=
 =?us-ascii?Q?OMfOKlAiCVwbqiwdCNYSjy0zHTQL62DA4l8s+fgUattBGvZRWSdsr5wbAzKg?=
 =?us-ascii?Q?OjRHK8HSo6MiBCQJ/6Iy9dFcfwxy2mXzJg2wj+lgr4DfKiukKQ8uLyA5OGX/?=
 =?us-ascii?Q?VCZ+9nalaKnlM1ShegJTvqCnxl8jZCUHT4LiS0E06K6wnV2h2RQ71VHBOfCw?=
 =?us-ascii?Q?om/81qNfLrn925p5tFSqq+7Bfv32jcrFJoxhQl6yyogqzS0tHkcK6FvmQ5OH?=
 =?us-ascii?Q?vOuSe6ni+T5ZxthdnuVlL6h+t0ILFmjKX3GfPOHCGyadXaNWWuwlgsigEZhO?=
 =?us-ascii?Q?u3nExgeHfqSie1BenNMDRyUO0VmkzGNFpL+Ys4cufckQ0wXzkrA7yV/gQ9Ii?=
 =?us-ascii?Q?CiD77RWgK5V6fOGuaQp5GuhrX+/pU9Yjl2MTVYCI0ME4vYQ7jnqoZKNSDoMq?=
 =?us-ascii?Q?cVZHJNrcWAE68m03YDfu0JkG4EV1AgdVrzAXoABOKkTW3J6yQqBonEWVrIIY?=
 =?us-ascii?Q?aD04bRTj0KA33X/ESbT/XYK+CDMuFzHE+mp52zX+YfIH4BnDEoWuAgcWGNMS?=
 =?us-ascii?Q?2urkgV0S6hnDj+suWwTwDbZsREcAdjHzamo5DsX3OeIHP06v35UuP69Cn0Lm?=
 =?us-ascii?Q?hREtPaQf6peXZRZ855S6UHbKRgkd6hQiMUX1Nm6wAPdbESzTVlwO1aUMCZQT?=
 =?us-ascii?Q?kV3AU9yk/mmZRgXNuuU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65ad677-4663-402d-fe9e-08dac1230cd9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 00:49:11.1849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aoWMabZULxy0U4w8keKAsEdrb4O+whG/951rR9u+ZiAMNVjsL3uG/6i7Npw+Y2U7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5212
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The span iterator travels over the indexes of the interval_tree, not the
nodes, and classifies spans of indexes as either 'used' or 'hole'.

'used' spans are fully covered by nodes in the tree and 'hole' spans have
no node intersecting the span.

This is done greedily such that spans are maximally sized and every
iteration step switches between used/hole.

As an example a trivial allocator can be written as:

	for (interval_tree_span_iter_first(&span, itree, 0, ULONG_MAX);
	     !interval_tree_span_iter_done(&span);
	     interval_tree_span_iter_next(&span))
		if (span.is_hole &&
		    span.last_hole - span.start_hole >= allocation_size - 1)
			return span.start_hole;

With all the tricky boundary conditions handled by the library code.

The following iommufd patches have several algorithms for its overlapping
node interval trees that are significantly simplified with this kind of
iteration primitive. As it seems generally useful, put it into lib/.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .clang-format                 |   1 +
 include/linux/interval_tree.h |  58 +++++++++++++++
 lib/Kconfig                   |   4 ++
 lib/interval_tree.c           | 132 ++++++++++++++++++++++++++++++++++
 4 files changed, 195 insertions(+)

diff --git a/.clang-format b/.clang-format
index 1247d54f9e49fa..96d07786dcfb46 100644
--- a/.clang-format
+++ b/.clang-format
@@ -440,6 +440,7 @@ ForEachMacros:
   - 'inet_lhash2_for_each_icsk'
   - 'inet_lhash2_for_each_icsk_continue'
   - 'inet_lhash2_for_each_icsk_rcu'
+  - 'interval_tree_for_each_span'
   - 'intlist__for_each_entry'
   - 'intlist__for_each_entry_safe'
   - 'kcore_copy__for_each_phdr'
diff --git a/include/linux/interval_tree.h b/include/linux/interval_tree.h
index 288c26f50732d7..2b8026a3990645 100644
--- a/include/linux/interval_tree.h
+++ b/include/linux/interval_tree.h
@@ -27,4 +27,62 @@ extern struct interval_tree_node *
 interval_tree_iter_next(struct interval_tree_node *node,
 			unsigned long start, unsigned long last);
 
+/**
+ * struct interval_tree_span_iter - Find used and unused spans.
+ * @start_hole: Start of an interval for a hole when is_hole == 1
+ * @last_hole: Inclusive end of an interval for a hole when is_hole == 1
+ * @start_used: Start of a used interval when is_hole == 0
+ * @last_used: Inclusive end of a used interval when is_hole == 0
+ * @is_hole: 0 == used, 1 == is_hole, -1 == done iteration
+ *
+ * This iterator travels over spans in an interval tree. It does not return
+ * nodes but classifies each span as either a hole, where no nodes intersect, or
+ * a used, which is fully covered by nodes. Each iteration step toggles between
+ * hole and used until the entire range is covered. The returned spans always
+ * fully cover the requested range.
+ *
+ * The iterator is greedy, it always returns the largest hole or used possible,
+ * consolidating all consecutive nodes.
+ *
+ * Use interval_tree_span_iter_done() to detect end of iteration.
+ */
+struct interval_tree_span_iter {
+	/* private: not for use by the caller */
+	struct interval_tree_node *nodes[2];
+	unsigned long first_index;
+	unsigned long last_index;
+
+	/* public: */
+	union {
+		unsigned long start_hole;
+		unsigned long start_used;
+	};
+	union {
+		unsigned long last_hole;
+		unsigned long last_used;
+	};
+	int is_hole;
+};
+
+void interval_tree_span_iter_first(struct interval_tree_span_iter *state,
+				   struct rb_root_cached *itree,
+				   unsigned long first_index,
+				   unsigned long last_index);
+void interval_tree_span_iter_advance(struct interval_tree_span_iter *iter,
+				     struct rb_root_cached *itree,
+				     unsigned long new_index);
+void interval_tree_span_iter_next(struct interval_tree_span_iter *state);
+
+static inline bool
+interval_tree_span_iter_done(struct interval_tree_span_iter *state)
+{
+	return state->is_hole == -1;
+}
+
+#define interval_tree_for_each_span(span, itree, first_index, last_index)      \
+	for (interval_tree_span_iter_first(span, itree,                        \
+					   first_index, last_index);           \
+	     !interval_tree_span_iter_done(span);                              \
+	     interval_tree_span_iter_next(span))
+
 #endif	/* _LINUX_INTERVAL_TREE_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index 9bbf8a4b2108e6..c6c323fd251721 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -479,6 +479,10 @@ config INTERVAL_TREE
 
 	  for more information.
 
+config INTERVAL_TREE_SPAN_ITER
+	bool
+	depends on INTERVAL_TREE
+
 config XARRAY_MULTI
 	bool
 	help
diff --git a/lib/interval_tree.c b/lib/interval_tree.c
index 593ce56ece5050..d2882db8fa2a07 100644
--- a/lib/interval_tree.c
+++ b/lib/interval_tree.c
@@ -15,3 +15,135 @@ EXPORT_SYMBOL_GPL(interval_tree_insert);
 EXPORT_SYMBOL_GPL(interval_tree_remove);
 EXPORT_SYMBOL_GPL(interval_tree_iter_first);
 EXPORT_SYMBOL_GPL(interval_tree_iter_next);
+
+#ifdef CONFIG_INTERVAL_TREE_SPAN_ITER
+static void
+interval_tree_span_iter_next_gap(struct interval_tree_span_iter *state)
+{
+	struct interval_tree_node *cur = state->nodes[1];
+
+	/*
+	 * Roll nodes[1] into nodes[0] by advancing nodes[1] to the end of a
+	 * contiguous span of nodes. This makes nodes[0]->last the end of that
+	 * contiguous span of valid indexes that started at the original
+	 * nodes[1]->start. nodes[1] is now the next node and a hole is between
+	 * nodes[0] and [1].
+	 */
+	state->nodes[0] = cur;
+	do {
+		if (cur->last > state->nodes[0]->last)
+			state->nodes[0] = cur;
+		cur = interval_tree_iter_next(cur, state->first_index,
+					      state->last_index);
+	} while (cur && (state->nodes[0]->last >= cur->start ||
+			 state->nodes[0]->last + 1 == cur->start));
+	state->nodes[1] = cur;
+}
+
+void interval_tree_span_iter_first(struct interval_tree_span_iter *iter,
+				   struct rb_root_cached *itree,
+				   unsigned long first_index,
+				   unsigned long last_index)
+{
+	iter->first_index = first_index;
+	iter->last_index = last_index;
+	iter->nodes[0] = NULL;
+	iter->nodes[1] =
+		interval_tree_iter_first(itree, first_index, last_index);
+	if (!iter->nodes[1]) {
+		/* No nodes intersect the span, whole span is hole */
+		iter->start_hole = first_index;
+		iter->last_hole = last_index;
+		iter->is_hole = 1;
+		return;
+	}
+	if (iter->nodes[1]->start > first_index) {
+		/* Leading hole on first iteration */
+		iter->start_hole = first_index;
+		iter->last_hole = iter->nodes[1]->start - 1;
+		iter->is_hole = 1;
+		interval_tree_span_iter_next_gap(iter);
+		return;
+	}
+
+	/* Starting inside a used */
+	iter->start_used = first_index;
+	iter->is_hole = 0;
+	interval_tree_span_iter_next_gap(iter);
+	iter->last_used = iter->nodes[0]->last;
+	if (iter->last_used >= last_index) {
+		iter->last_used = last_index;
+		iter->nodes[0] = NULL;
+		iter->nodes[1] = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(interval_tree_span_iter_first);
+
+void interval_tree_span_iter_next(struct interval_tree_span_iter *iter)
+{
+	if (!iter->nodes[0] && !iter->nodes[1]) {
+		iter->is_hole = -1;
+		return;
+	}
+
+	if (iter->is_hole) {
+		iter->start_used = iter->last_hole + 1;
+		iter->last_used = iter->nodes[0]->last;
+		if (iter->last_used >= iter->last_index) {
+			iter->last_used = iter->last_index;
+			iter->nodes[0] = NULL;
+			iter->nodes[1] = NULL;
+		}
+		iter->is_hole = 0;
+		return;
+	}
+
+	if (!iter->nodes[1]) {
+		/* Trailing hole */
+		iter->start_hole = iter->nodes[0]->last + 1;
+		iter->last_hole = iter->last_index;
+		iter->nodes[0] = NULL;
+		iter->is_hole = 1;
+		return;
+	}
+
+	/* must have both nodes[0] and [1], interior hole */
+	iter->start_hole = iter->nodes[0]->last + 1;
+	iter->last_hole = iter->nodes[1]->start - 1;
+	iter->is_hole = 1;
+	interval_tree_span_iter_next_gap(iter);
+}
+EXPORT_SYMBOL_GPL(interval_tree_span_iter_next);
+
+/*
+ * Advance the iterator index to a specific position. The returned used/hole is
+ * updated to start at new_index. This is faster than calling
+ * interval_tree_span_iter_first() as it can avoid full searches in several
+ * cases where the iterator is already set.
+ */
+void interval_tree_span_iter_advance(struct interval_tree_span_iter *iter,
+				     struct rb_root_cached *itree,
+				     unsigned long new_index)
+{
+	if (iter->is_hole == -1)
+		return;
+
+	iter->first_index = new_index;
+	if (new_index > iter->last_index) {
+		iter->is_hole = -1;
+		return;
+	}
+
+	/* Rely on the union aliasing hole/used */
+	if (iter->start_hole <= new_index && new_index <= iter->last_hole) {
+		iter->start_hole = new_index;
+		return;
+	}
+	if (new_index == iter->last_hole + 1)
+		interval_tree_span_iter_next(iter);
+	else
+		interval_tree_span_iter_first(iter, itree, new_index,
+					      iter->last_index);
+}
+EXPORT_SYMBOL_GPL(interval_tree_span_iter_advance);
+#endif
-- 
2.38.1

