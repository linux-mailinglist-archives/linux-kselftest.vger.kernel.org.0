Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531E160D312
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 20:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbiJYSMg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 14:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiJYSMd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 14:12:33 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5F0B1DE3;
        Tue, 25 Oct 2022 11:12:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=La5QNStPWqxXF8M1GdQev90mfoCj2qIFT3QcYcvoz/YV1a0wL5BgavE1VEO1IYGNwU0UXIj/20dMUkGlN+nSL7LembxLAiZ/klxmDAOAGy09ef9T8kd6rMhs5zpotq6IoetRZuXnBuvii2MevHapsMkTCe4G9WpDJvQT68I5+gBk6O7FnUrTNchVrzSSSWtb1J5UFrdkTOSL7ioaiyxSxahJYbLxhX4UaoI2Acptj9Gy2Zz6sR3Kpgz3ch/jn3wrhqD0kwOGcFOOIFyRJPx217zJHAh+FcNxqkxDeFT5h+uijTSpiPzt35dyBvbkm4T17TF6cqHz4I4beTBHeCvxjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWLRqUfk5qLeu1ABpeOCULlhr6vyxlC2X7SSBj2Lon0=;
 b=gFD2DO995KZB2wbBNb+8WIDjk9FynecXmGCYNyrTiQm9m2EeKYI4ITK7asrzATqyqd3Hm8EjsjfZlkFk9Dyj5gYXbendOr320i37y0vhMnPVICAcW6q8OXQMCCzT9y+rdvzOiK29kOW+IOkBob4sa4aogjHViJ4KRl5sC7Xkv0ujMjgi/6hjqIAH5SEew0sfFDu1vI1nCTdxawkzRfBhTnBNSRSTVmDGpxm3x05zlMQSY3C07yeq3rU+fP4Mq7W0JxHMLbbxea25H/ijgBHton7s7W5eDVx36UWaOScC6LuN2+JIaxJsLS6mdJZrcc3Mkr/OfOpIrwUN3UXB25QHrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWLRqUfk5qLeu1ABpeOCULlhr6vyxlC2X7SSBj2Lon0=;
 b=dokB4WvgnUVjBS9LKB992YLeaDXV74bI/+w6Tmf8Ad0HIdQYwoAkBtkcsqhiNQjN3kOBpnXqUg13NF1r9Sf4jFCChsKXibIhubsu8/j0tyByBFu8SUcZ2vKLllAY5pw8Sxm+PcQFbTUv2JI3jx8HnNMZ1eMB6pH/O0RXgQRUZRZy0geSSVc6sTAJ/HXJ8EpgfYRsJLR48BLYwjNmK7GV98Q9DWedVb/2YOqLaV4FLjB4UbVI4LTDeET7fgDuKQLfMiJVCT4K0NyQlVjCi3ebGyOBNA/m6EQiYieUa+TVVjpiku+GJmudvNBbq/yv6qtcKg0OolF6BazOVP66m1fyUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 25 Oct
 2022 18:12:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 18:12:28 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
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
Subject: [PATCH v3 03/15] interval-tree: Add a utility to iterate over spans in an interval tree
Date:   Tue, 25 Oct 2022 15:12:12 -0300
Message-Id: <3-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:208:c0::48) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fbab31b-8f96-45ec-522f-08dab6b4784b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qfZU+lnf/25J+4x8q6ov7+D8vqqwdnqhBp5jPCzP+Jeatx6pxK4cUwasr26dOHuRW4ShctNZrliZabUMSIu3l36j4uIEZJrimJOQsKLUTzKnPLGunCxOqmiNiYvnCKrPb4W8sC4MYfHuyVYmJsDMosUGzuWhm0JkQAeKOPO+CjhfYdJVtSwz95mBemE6zNyTRPjsCrdhTZOevrkxqERUPkoVERSedjFiHHATnNx+1O78RAAXmDQV5cuMe9oSKhMANs599V7O9WeftxHxOzVvfebzxYB1/rKOvPRsENq2KCeKSlY1N1dLBmnZEr561dO5Bj/vczBjqqG78wl+lsj1BJ+R4dEP7kIXkSgg9FAxdXTwZbBEWuqtjXmIPSmgzUMkgY83NqGWP3W3uobg9H/FJvSAAdEp84r75sWJsn6XdciGFG2nGLXibGIXb/3kYFVUcLhLU0T9uAxbRPlVjUPQxYQmy8ijhp3z1hSfyhk/7XoY+mTR8C6/NDZ9EZu4zjkEz7aLUgls+D7G3/njTCdNU7Qq/beC1eoc7dM6njRCQKfKapr5dGIk6G26N9iPmoaWHAJelf4u/NXtUe3qeRoEW/AcbYvsA9SC5vfSb5X8CppvgA3DXqlhDXZJ2q7qZ/2Fs/d788kHNcdvohynqWPBbmlvpUX2oj5Opzp/+5s6jSZbJ9Ob4EJtQdYyRLLbR6xmMHan+FPnfvClLv+IOJitzDFZ/GiXrDpfvZMPnyklOOOGA8/6/46VQf7YH9XtsOEws+GQRIzoerUcV7DlpM2AlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199015)(6666004)(316002)(41300700001)(110136005)(36756003)(2616005)(6506007)(54906003)(7406005)(7416002)(8936002)(66476007)(83380400001)(5660300002)(26005)(2906002)(4326008)(186003)(66946007)(8676002)(66556008)(6512007)(921005)(6486002)(38100700002)(86362001)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4rkW6byTJuCcLgeh5i9XLlodTNnimKoNvQre3LaMsXnABTXUGWRZDX0uph0r?=
 =?us-ascii?Q?Kc/MJ+v3JUlEtCwQabL9islP66fI7X3+TtPZ+nyJb9ADtBWspRTRKhh2vW3R?=
 =?us-ascii?Q?GryUJZn0CGFtqiHqb/6tbyj7YmxIP4QVDtVjP8ABRZb3XNI4819iWHle9HvC?=
 =?us-ascii?Q?1QdpNJaw3l1z69sebs02pqwaf06IY1xOdScmne4XG1EiK0iLxEiI68BXFWfx?=
 =?us-ascii?Q?zW6DD8S0QH7tF78raVuCyuy4Cud8oqGPXQb+guBSRB8k+13TNanIxBE00wgx?=
 =?us-ascii?Q?UHjtr5UADWRBQY4ymTnE18SGpzh7ArmlU8dL0DzscEnmmWmGqnSfgd7wQvVY?=
 =?us-ascii?Q?vu1hm7CN8WuApPSoCkVGyVGcMdZASIEIApo+u4sV66PwO1asH8LYBSk9dlIR?=
 =?us-ascii?Q?5iq9bpl6wv3dVbMPru1YekuZFKlO9QrJTqDcjLU2EGttHYd6jM+s3EhVJUf5?=
 =?us-ascii?Q?kd61o2MyhGRsJdC6YDvTfWW17dmD5PUgsdVXP/30Q38FRjA8c8EDnbAHWgiF?=
 =?us-ascii?Q?I46J4d9ZSaqB8k0MAHUIKPI8QaukB52jg7V/AhcLEnIQRDvfDaxAS5iwB3Rk?=
 =?us-ascii?Q?D6M1N1cafL7TAbHRqnrhlUuWPRukU9tGP4SEkW6IVyGIo5GvFBNXV5R3X4JA?=
 =?us-ascii?Q?TdFlUWEAS9pg/waf2rAezKswsIHddgPrL/ls81hwhAegLRT66rhA9gBBUgZt?=
 =?us-ascii?Q?Ye/dIKTaw0gu/isOIZ+P10+IfrSCvyo1MNDC+oTOsU98KjGv/UVldef4h6xf?=
 =?us-ascii?Q?WqDbmLKfF1UZeEXwHsZuanBxwr8IR0CT97iB215+dprZOpod+4q6z3KRuAQF?=
 =?us-ascii?Q?xfkpWqqE9ww+w1/ozG8+3y94zYuV895RcykcH9qqJBJxSJLN9xdiS+OQvTr7?=
 =?us-ascii?Q?cww0Xo4MbYlyKMgwsCEVt5HI/bDPfiXHAHv102L449JrAt7m5KG75shOtXyI?=
 =?us-ascii?Q?0/R3JqNVFy2sN2Mz5yWfF1TCMC92sjcMucSOVAZ6dVQ+0KfoPs8uuqV37Y9x?=
 =?us-ascii?Q?C7Fwpd/noMVwtcr4bBkJWT+K54sfG0hkADB2ba4Uy472YoYlhi6rk6o4gSlJ?=
 =?us-ascii?Q?BubuZSIDAXjPQpzyKxTkS3oweoek4wzmvWHJtRHTsPorTKHYWGb2oXR+nLOq?=
 =?us-ascii?Q?RyMYacY0N1DdzzBtSmEvnlN1vFjdALQwhblfoZa/ZLaJakdCWkzN8gvsnnTv?=
 =?us-ascii?Q?uba3ulfeRHv1z1NQRr+fOzj5t3gwOBVbvbK7Ns1n2+M9C9SBjSN+bP6APuN0?=
 =?us-ascii?Q?UOMeR2IB9DhKL+aquoOp9rDyMFyUtf0jiqZcgdwporYztKX9ubI1UoIKs6lR?=
 =?us-ascii?Q?012xlNBX+BMP/hNEZ9OAy2mggA0+ScgA3i/IxWYeCFglaDnMV5dEKk8fhH7f?=
 =?us-ascii?Q?ToMzxRXVSPozI6vQW6WEd0emknI82nRqvDTQ6TjcPq1uf8dnxUrl1q1jJLrw?=
 =?us-ascii?Q?zMZOjFG8tJLUtZKEsJ5aRZ4ihqpO9N9zuDEuJiZe+SFSO22HguDLYiaxa06L?=
 =?us-ascii?Q?xwpU+BPfHdzmr1oCvGgxes32NaVArXQcke5ByKuCy6WpCsoUrABHgqmh6pz4?=
 =?us-ascii?Q?eVs13wBPaimQSbB3Gcw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fbab31b-8f96-45ec-522f-08dab6b4784b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 18:12:25.6791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8Jm6wzBV1gJUmbo824KsN2susJX1+QPwXzsRHbn2wYQqlxzN33DIDUPmpG46MHd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .clang-format                 |   1 +
 include/linux/interval_tree.h |  50 +++++++++++++
 lib/Kconfig                   |   4 ++
 lib/interval_tree.c           | 132 ++++++++++++++++++++++++++++++++++
 4 files changed, 187 insertions(+)

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
index 288c26f50732d7..3c803379b83cd8 100644
--- a/include/linux/interval_tree.h
+++ b/include/linux/interval_tree.h
@@ -27,4 +27,54 @@ extern struct interval_tree_node *
 interval_tree_iter_next(struct interval_tree_node *node,
 			unsigned long start, unsigned long last);
 
+/*
+ * This iterator travels over spans in an interval tree. It does not return
+ * nodes but classifies each span as either a hole, where no nodes intersect, or
+ * a used, which is fully covered by nodes. Each iteration step toggles between
+ * hole and used until the entire range is covered. The returned spans always
+ * fully cover the requested range.
+ *
+ * The iterator is greedy, it always returns the largest hole or used possible,
+ * consolidating all consecutive nodes.
+ *
+ * Only is_hole, start_hole/used and last_hole/used are part of the external
+ * interface.
+ */
+struct interval_tree_span_iter {
+	struct interval_tree_node *nodes[2];
+	unsigned long first_index;
+	unsigned long last_index;
+	union {
+		unsigned long start_hole;
+		unsigned long start_used;
+	};
+	union {
+		unsigned long last_hole;
+		unsigned long last_used;
+	};
+	/* 0 == used, 1 == is_hole, -1 == done iteration */
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
index 593ce56ece5050..6edfb83894af8e 100644
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
+	if (new_index == iter->last_index) {
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
2.38.0

