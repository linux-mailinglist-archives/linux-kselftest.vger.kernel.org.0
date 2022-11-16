Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AFA62CBEB
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 22:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiKPVCu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 16:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238876AbiKPVBz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 16:01:55 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6766322506;
        Wed, 16 Nov 2022 13:00:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWVcCmVBnlxW37h+G3m95MHwmxy0+uKveqB2YDOTRQWL5MvuAXH1lb3xq7VpkLk5IJYrDNvy4UudOYMjiR3yupHDsQIYfmnvJG/B6JfgIgmy72/1PjomjC6akJi8wVWsWJEFj/RyUXRzjN34XCyxJ7m6nz9hLhRL0D/haKFkSR+nkiLJIkFKWSDc5Fr6ydfo3cDNYlvI8ZpvZCMLtQH4NyoshW5PYNchC1kPDB4ZjfVJz95gGU7L9WM3qAC+NHbcnDJkEx6vcT4GmJk0MthDT/d3Xw35PtkcmP9O1MSZcmI+X2Uk4TbGn+JAtece43n4LGdDMHQLJ2KsZpzi7kqzWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nferIdE5hEyQVrK+uXaRn9YN26fsfcsmwb7nmE0obQ4=;
 b=UrOpn1N7B+qH6eXZKM/s7oeZ+EaQhtscvrK6TI9qYJ31E10CMTqe61mxMHlcvF7cqkLpb4TFPbUWBDsoYR+3bq6K0TVL+mRNx606zhBhYdPZv5upLkd2bTpbEPYnjp/uBOsZSkkHSfj5Jc2oN7v7dp2OQSghjy9d0gQeLqhvED7ZFUJPQs+vzfSflAjG6fCmj+KhmR9Ee44dDaeGiTZUmsd9E4qMVBMHmio/egckRTjnhIPfKwTxp6CQjkP9j/oKZm1S6cZjqg9MxcaThJJp4vMe6NPnPjqduTq6jC+6OQBAM41x/8HqOwi3F4d756WGnsWGA/BXIqzm2o6HnKWGSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nferIdE5hEyQVrK+uXaRn9YN26fsfcsmwb7nmE0obQ4=;
 b=avD8aSF5umEkH33UQSn2278uTXsXu8BR/s2toK05oBvYGbQcm3FxqTwbeQ5+oVh2tAoAUsykGJ3I4TvWwj/48+/e9ozkIfLRLXjxZwdBnCU+9GWPnKs0qZmQw0qnBNKdjvHKNHhsKbGir8RAnaYlr/Nuig0qmZF26dtiCTceim/OtuRrxO+5Ho9CV4teT9Sma+WDSq7EjaM3dntKO5tKjIj7XHSGGNRLyqGbNXKKPOWfp3ndMb0ex+gsGNe4Axp20Tmqf6/Ag09r9FBaTG8UA3CPLFVf214ATpckhJbOilUoUWpww5NVY+gocWfYeyL4+NpschpwhLalV0mr/EQDOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 21:00:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 21:00:57 +0000
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
Cc:     Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: [PATCH v5 03/19] interval-tree: Add a utility to iterate over spans in an interval tree
Date:   Wed, 16 Nov 2022 17:00:39 -0400
Message-Id: <3-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0013.namprd19.prod.outlook.com
 (2603:10b6:208:178::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 6070305a-1231-4b61-2a00-08dac815a7f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SVShoWeQn1pReU5lwnS2tQ6SOCrzA2axKrbGFJG/Z+X6PwdMiiEAdeGQEZWxKOI4zvz8K+Lr3O/Us3NLt2NFiRszN28f2ktLKmGkd3bH+MwD8wl6A7t9Q1Uhm/xIawMjPVrV8BEolmsnmWjeZBkBiuhziLE1FkvdZbJ817Ql6bnNhmSArO8lx1m3HOmfAnaSOQhswTrq12eTKR1mErSlQqBe3tdASJ3qCbRZ+OZg9Aemp42b5/75RrxLEc3U1OiJ8KqxaVGicZmxEcgDopb9szikA7r7/nqdbhxH4nNtLbIS4/37QMr/sUl9RuwjfS+zGt9uVhebwkYp2wKt6TvyK1oLQvlP8mDaquQUz1lWcU3cQXeY72/FWPBtyGTH0ey7kuxKJ7rUyv+akci/9tELk48rLI2yX90uhoFmeleuPplFzSfDNmjGr+ObJ/Xu/IgejlJGoV8qZsZGUXjWp5vhn5LnnUkyWfBQxKHaDc2DYor1GuzLqF6Prwj8Ai8ttYIkXgrzIbW1XrV/vZl4r08TjcyDloplHWuDaTxDae7gJLsr6N27Oq5L9mnBVgjLtBXNoIlWsKuZpVeaYBKqplfoHjORJBiRxtmwNmXqNa1qA4CSZpB01vBPSlYLdce7cbTK5Rzht16ra4dOYqC+wqdKdRaXwXgwIAfTcRsDRmSOzGW7+YBDmIflz5KKIBhfjWaAYvPW3DwnSFfdoJf66Ky/6ufsgkuWPu26ftTTxWJ/S5eN1I40JtsEChOG68aeLw6vBwfvKi5kJu8WC3ClcRypJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(38100700002)(2616005)(86362001)(921005)(110136005)(7406005)(6666004)(478600001)(6486002)(7416002)(8936002)(66476007)(8676002)(4326008)(54906003)(66556008)(66946007)(316002)(41300700001)(83380400001)(2906002)(6506007)(186003)(5660300002)(6512007)(36756003)(26005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fhuRNx7PGu9FqRm2usYXOgUgCP7PCLA3w4xSYUdOu05TT5SjnrrUJzlG3YNe?=
 =?us-ascii?Q?sWclKkHEJlhzqbNXpgcS8hCcfg+KAfVhBf3bCY2QGK1nGad/NefEwvR8U1L/?=
 =?us-ascii?Q?lqTQrY/aDCPZ3fR7xrbNmP0LKIs077qH9IllxXXmjn4T6iuMwkQD0mH1DJD0?=
 =?us-ascii?Q?kEuoWvwv+Yq4Aiweln1M6EjlNTm1+lGpKNCqyYwBT5vVWXjFIhh3ISZD/1M+?=
 =?us-ascii?Q?5LNtWdAkpQfA8WLgoJbln89B4tE2C5XfJrkEKaVTn1ttJZLhXZGjfsB1Rw+d?=
 =?us-ascii?Q?1xiqm6r0DUPoRpIfkCB8frh4X4PTodbG3MeB7XzeBL4iC3z8xXdlMYmPsN90?=
 =?us-ascii?Q?9FIWefSA1hdOYLO/m3JgFETYyhJBVkZWcsJ4NbHYQwSZA/vtEFBRpSlTZf+m?=
 =?us-ascii?Q?Sl6Ey4tQh0AYlSYeOJLB/DQCrL8+J3j7JaQMsq1XJVSB7r100M4rYpRvz1cI?=
 =?us-ascii?Q?dHhl+pMZLwZS7VONCXejXtYT2oTSZ1WufQAf5qnq30VaPxWQOiJbonhEsp8A?=
 =?us-ascii?Q?jm9hmbDuTcaA+ey7HSfSNnZ01djMb3qibOsqET4zuNxD6/Y7TlP0wE2vOzPh?=
 =?us-ascii?Q?YZi2CvO91CxSrcrw1eozKSTVXw4+jKlqhotomSs8RANByni7sgMCItreq/1z?=
 =?us-ascii?Q?TqMZA2IgvYBcvBSvT1A3dKc3LGHB2bIJeQxrj6t1x2b5oknYzttH3iVryyUX?=
 =?us-ascii?Q?gPEwOgzBvKkU9sE91CtzQCBhDX62W8qpwbwf8+2nj43VwvYCJL7LaE6SouUZ?=
 =?us-ascii?Q?chPlatvhk6sDYDqNSfZOm8hgnWmaNc6zh6yVqEXULG2mpgJjW4VsYVO2vD+s?=
 =?us-ascii?Q?H+LJHKwneTgOZmbMVPm4liEuPVNLEAr0G/7DRUsuOE177Ead9Vbgt8QCe4jp?=
 =?us-ascii?Q?ThDOzhhWbAnTr1mIh3wLK04S1yN1zvB4IVT4+NeJ2oaSo7ZPFCnxsEZGaGK0?=
 =?us-ascii?Q?cMGwr2WqI2k4KB120fWwVZ7tP2f+UkV1rFZHRA5V9pzZWdwi/Tf2iVSgRcWa?=
 =?us-ascii?Q?xlBVFyPRsExsDPExJfBeacIurlRBCuMci4rJ1DWgsTOpfTJQOGxKH5NmnQqg?=
 =?us-ascii?Q?H+YThr6cQ/gMXDFthSqhc5ZYWfwVB2ovNdjFchNwhkri4XHg/6SSuwN37rPl?=
 =?us-ascii?Q?NbW3amE27LDnQM5VVc3OXbQaWMY8SuUJEi6NrbJOlXPUdWNkM21Vk5IHhCMe?=
 =?us-ascii?Q?fMlxq0V/UX5AfRcC4pJPXbgg/XvrVknTin0mb+/NsfQVtM+tSZ3RNFeHWCex?=
 =?us-ascii?Q?AkhOuQyrJ7ZlHpB6VDrw7Y2rbPYhAIflpXEDcMWVOjpopOGL575zh/A8BIIp?=
 =?us-ascii?Q?auHo97gDN1AZXNWWVt6/DAguAR9MFJj4P32aP/vgtZY7rp4szHvuK8Kna0sL?=
 =?us-ascii?Q?Xjy56QVu/2vpCwmLh6YHfwvJMr7EECSkciSL79AybtazntJ9r1Xq77PErwt8?=
 =?us-ascii?Q?JCCsQBufF+nudcXVO6+7Ww0hSTKs1AI8zNgeBTuDofH0lyaQ835UvU8TJsnJ?=
 =?us-ascii?Q?NLb/hE3hYsQMsp2xftzm+uSeQAXzSj4IcDVGSUdQpX5PMnJ1C8C6wiIFcSYw?=
 =?us-ascii?Q?+blw8RUukxDyNZ6aEnk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6070305a-1231-4b61-2a00-08dac815a7f2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:00:56.7317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9L1EXU5Izq0gXqQg1VxPahuGSbA8oeRiaYL8TRgxJyopRdagCy+gp1zMfRO38AH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682
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
Tested-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Lixiao Yang <lixiao.yang@intel.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
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
index 593ce56ece5050..3412737ff365ec 100644
--- a/lib/interval_tree.c
+++ b/lib/interval_tree.c
@@ -15,3 +15,135 @@ EXPORT_SYMBOL_GPL(interval_tree_insert);
 EXPORT_SYMBOL_GPL(interval_tree_remove);
 EXPORT_SYMBOL_GPL(interval_tree_iter_first);
 EXPORT_SYMBOL_GPL(interval_tree_iter_next);
+
+#ifdef CONFIG_INTERVAL_TREE_SPAN_ITER
+/*
+ * Roll nodes[1] into nodes[0] by advancing nodes[1] to the end of a contiguous
+ * span of nodes. This makes nodes[0]->last the end of that contiguous used span
+ * indexes that started at the original nodes[1]->start. nodes[1] is now the
+ * first node starting the next used span. A hole span is between nodes[0]->last
+ * and nodes[1]->start. nodes[1] must be !NULL.
+ */
+static void
+interval_tree_span_iter_next_gap(struct interval_tree_span_iter *state)
+{
+	struct interval_tree_node *cur = state->nodes[1];
+
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

