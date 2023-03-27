Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052B76CAD35
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 20:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjC0Siz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 14:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbjC0Siv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 14:38:51 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D0544A3;
        Mon, 27 Mar 2023 11:38:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAZmOHKGvFGImtDtUMaPhLeatEDopDSYgj0CmsqIMXW/EXsw44NICxSG8FAYrmO33wuwrDBQum69AqvVWZEJ/jkve5/dpPO80qPnVvlpXHnUn6D2JiHY0040qVHwtu2ZM4gmLqCD2ViIT0KBdjSEhXQtrEZAOI1XpU/qbAsbzQAu4HcVY15B4QlfHUFC+asQ0Hsp9KMAWL/wk4qO+X8khz9pIZc8ghxcVVK0O78LZnJ9qUPOvtBBhho1aeUz3i9yRsCgey8gDG019X468mbrKQWDBlY8UuM9YXHESD1gy4ZQz0010BlvyfMQs2I4mHjhexCpGv/oh07ynJCa1NgUXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFhH+VMaXLDWwRmCU+TbUC9YfLiad4RolEiHONxioxs=;
 b=eZvIAHVIm4OoX2pc8gPWyHKTEEaDNAwf/sX1+Z55dLVnjSrO+nR4yIFPrLFITfMhJCYdBbjax59SNlB038R8TDuTVkumVGq+XUixt7Xpq0RhIVo3yNOde/O+Qu+kT76JElh18ACEvupHWYNx3106YP/L3h/xXD6aRfbhMIiapVRoeLWByvVWkXFvyKl3dqAxMk3qperO+eUUjnYOzc4PFSbjiOoZ0/CYJ5BuiMWfbyvFb8IZZj06H2HdB+snAw2jDU7RmyrDPg2PYz1yGKnDTa8jPDmekFzU2YmNmf3YAav7KUZ2X/ZcqhqUqjqOXScdZyQcvo4Moio66RRzhWVtsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFhH+VMaXLDWwRmCU+TbUC9YfLiad4RolEiHONxioxs=;
 b=GtHJbodQKFLOInR4qdpOY4sBqbCGD36d5XooTssrkHDouO1RpcbxP/6qoRH9YVgE0IzRwVGD5rQ7KJUVivoejxSnDUCIPfqC6u/0VzsZBVHYfQDhuHnM22TfKJDd4qyq9SPRYvm39w/gdZ3JfQWhuqwk9udOW02234NGU+M7iizwajqB/6yf8pqp5bMnV6jzghCCOxa/DVHsBBt30194Z1j1oLBUx6unUq9tuYVjd18oSkYHCIvbuj9SA+id/g65c1rF+7QmKCiWeljzkEEX8xHK/lrCbmKYaRF9YTtwLLGY9qIXZjTiFlZX4x2hSynkPpBIb9pKpbeCVwMe3vnyCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 18:38:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 27 Mar 2023
 18:38:15 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v4 11/17] iommu: Introduce a new iommu_group_replace_domain() API
Date:   Mon, 27 Mar 2023 15:38:05 -0300
Message-Id: <11-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0478.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 980f5705-c891-44d0-7041-08db2ef26ba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yfL/xJMVhubeNXuDUfFhFo9/6RE6oSCuksWu/bxUj4rKyhRqcG5v7ExRtCvZfzGIjYf6XAo5/gcwZlwFSRVCJbpcZGwd1YnjcvERYk24/kp9/TS5liMSRA3+NG49XOMGD8qdczoQsaW3a5kjt9f+CdE0QTcHTRnbjnXUoauzRncUE6Rkj+agfit3RaH2qR/OQu1/a8LS4oTzVAFMAHQT4TXUwJL87Yz45lPwkE+gblXEhCLbBYoDbn/VxuEHFr+qqAynOVZvZiECRczZciqr13nELf7I9jgGUnMXwJDqXzawOJRtLstRNnI9xS7VT1tomxGCIl66Ox7d5dfU+l/5eE4hy6pYZZLnxdQR8hGoCLzxM0lSnT6L3rmShXgZkk11pXUvCIulOI7A7b1mesLVdooxmqiYd6EGqj2ljvla3PfeaRq6PK55PHEUAwIn3lIjldfz3LeP5X24rx1QwWxoyLSWDFXNrXze+hZWdWK7rUBhEf7/VbVH0t12MQEwqKVJFYsebrGg7spbQUOyZFSNSDrlW3zn+nGJIS5EO/Hspi4qF1Uf6CF9yw5M7n3ymHl/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(6512007)(6506007)(26005)(54906003)(6486002)(316002)(6666004)(4326008)(186003)(66476007)(66556008)(66946007)(8676002)(478600001)(41300700001)(86362001)(5660300002)(38100700002)(2906002)(83380400001)(36756003)(2616005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1vnevkU00dJuFj9BGSTFnCygNJ5iDgIwxIH45+4nxdPPl6t4QwJKfOa1CfA1?=
 =?us-ascii?Q?+QkGDGrchweTMzF8AIjWfQeHMnsuEyNDEsyyfCwwIQM9xmhDobLoPFJxHXeX?=
 =?us-ascii?Q?h8Qfv+sBvVlS10Yw4Gl83+XCuuge3etW6kRn4LxohKXUek3x0nqvtVrYJPWo?=
 =?us-ascii?Q?NTt6EwWyeKs5vbSBQ2MsOZF0/RLkV90nw98UmkYIuSqIzKU9kKIEQU81yIk2?=
 =?us-ascii?Q?ybkyd+9ydl7IZXf/eahkoxt5guxerSNVS4EbqXVffcHJuYtaVWmmvDXZN08t?=
 =?us-ascii?Q?hsrg+3XOVT1DVWkpSK1L6t/OJVMfYN+uWbcrlWlITsshi2ZLzOqOM0ks4Fg9?=
 =?us-ascii?Q?TvOjn3I9/PTNrmhtlvhYYnYSSZEuxA6N4fx127ycaTXoXKq3OyWW3/3P8iis?=
 =?us-ascii?Q?Rd7Jid1tukGo3DCokeCE4SnYnl4XsULl/K5iu9h5PHH1li6EbvOKr80/Xd5P?=
 =?us-ascii?Q?F8QnGa+pD3Y6vLRS39Y0wwIsPo2ywYtjS/bbB2Q0c8t7GmFswUrIeNzAXfsn?=
 =?us-ascii?Q?iXYXy5uV575B9DohLY9iYcL86pkitIbkpFXw4Dj8tsIgmu3Q5JVGFdqdIXXY?=
 =?us-ascii?Q?8o884kBpFGt0JK6xKfgYJ0krtSs7Kkhw1JcIo8xwVAg6r0bcnGzpDWYPKOOC?=
 =?us-ascii?Q?wDJxg2OQAuL7V2B3HHhPp4+O0AzZMVMahwzvq4C83EfLTsosHBU0NJhzYo1E?=
 =?us-ascii?Q?e7i+29Bu9jT+vpXsRv11AXf4a/uZflTEwQNRIuCBlsDQXFxCU9jjxV+ZX2c6?=
 =?us-ascii?Q?amvTP/iegO66cJLXEzFQRXsMm6V3psH3bY0zrs+34Lhw0qCGslJfNczqLvm7?=
 =?us-ascii?Q?z6jnhtYkDoSJqavMTjay8ZqT6T2AXvQW0uZd4RWB1C5qo+hH9+dgo/RUbgva?=
 =?us-ascii?Q?H7/RJIDkAWmUlc5L01R4VbBoH9kFt/5WLwCEXNEZbHlJ74VX5agdcTiEv7S7?=
 =?us-ascii?Q?4Exk6dCl9R3TIkzlFgn8J7fyVGf9styramqS4AteBnB23Sofx6XThz5xn6k3?=
 =?us-ascii?Q?CodzQRcxz4CUnm3s518EOpgDYR6bumXII0uLD5l6ynrK7UBsPKtzPZVwcpn+?=
 =?us-ascii?Q?9HoJDKyuzVHlBwX5Yw3zBv3lQbaL3WWmNeEsgI2hmECeQgRJ+4NMV9jcxF3l?=
 =?us-ascii?Q?GAEWEVbpMvONwmDBXs6cisqUTnPhLqZwE8ZO8ImzpAMpp1m+I589UvzFFDjo?=
 =?us-ascii?Q?pJYpAMq5aFjhib4kEA0Bp8iib08ekiTGQsSI3ldztM3ccEkkxXebG3XurcKY?=
 =?us-ascii?Q?xCqD0yWyrh0buWCEGEls0kR+eGZC13skp1nCaj8/gmrHeRo+PDeytF6aOLxw?=
 =?us-ascii?Q?DLXAlAC7tsgTdtwhapHlUQwFumIo7WMLozGRndFIPPtaLnAjmuXtIJI4cV/B?=
 =?us-ascii?Q?PsuBtnGco/JYjJtf4VLk7mgfRU2HCglsc9UtmwQ41rOkHvJLY4WHLKuU+tuE?=
 =?us-ascii?Q?LwIaT131wFjGKYVJYwjar0e9plgNfHC5zwCwNzb1YNzLoCQOXa2epidLcPQ6?=
 =?us-ascii?Q?POuUykThrwAvqeikZ4l+LiGB1uWoyK6XNt71vfWF63m3t36sw+fAIiYvZRl2?=
 =?us-ascii?Q?BRefbLp5mJl4Mij+y2YXR/0edlPaOW6WzUdGK7Vg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980f5705-c891-44d0-7041-08db2ef26ba9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:38:12.7380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBCpDi7EDYoV3HIMmUnjR/YDA/vxde/js+twdjF6g+BAyEBksVbhz5XcDC6VquzM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Nicolin Chen <nicolinc@nvidia.com>

qemu has a need to replace the translations associated with a domain
when the guest does large-scale operations like switching between an
IDENTITY domain and, say, dma-iommu.c.

Currently, it does this by replacing all the mappings in a single
domain, but this is very inefficient and means that domains have to be
per-device rather than per-translation.

Provide a high-level API to allow replacements of one domain with
another. This is similar to a detach/attach cycle except it doesn't
force the group to go to the blocking domain in-between.

By removing this forced blocking domain the iommu driver has the
opportunity to implement a non-disruptive replacement of the domain to the
greatest extent its hardware allows. This allows the qemu emulation of the
vIOMMU to be more complete, as real hardware often has a non-distruptive
replacement capability.

It could be possible to address this by simply removing the protection
from the iommu_attach_group(), but it is not so clear if that is safe for
the few users. Thus, add a new API to serve this new purpose.

All drivers are already required to support changing between active
UNMANAGED domains when using their attach_dev ops.

This API is expected to be used only by IOMMUFD, so add to the iommu-priv
header and mark it as IOMMUFD_INTERNAL.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu-priv.h | 10 ++++++++++
 drivers/iommu/iommu.c      | 30 ++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 drivers/iommu/iommu-priv.h

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
new file mode 100644
index 00000000000000..7c8011bfd15374
--- /dev/null
+++ b/drivers/iommu/iommu-priv.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __LINUX_IOMMU_PRIV_H
+#define __LINUX_IOMMU_PRIV_H
+
+#include <linux/iommu.h>
+
+int iommu_group_replace_domain(struct iommu_group *group,
+			       struct iommu_domain *new_domain);
+
+#endif /* __LINUX_IOMMU_PRIV_H */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 76969904b93af4..91a948a76db5ee 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -33,6 +33,7 @@
 #include <linux/msi.h>
 
 #include "dma-iommu.h"
+#include "iommu-priv.h"
 
 #include "iommu-sva.h"
 
@@ -2191,6 +2192,35 @@ int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_group);
 
+/**
+ * iommu_group_replace_domain - replace the domain that a group is attached to
+ * @new_domain: new IOMMU domain to replace with
+ * @group: IOMMU group that will be attached to the new domain
+ *
+ * This API allows the group to switch domains without being forced to go to
+ * the blocking domain in-between.
+ *
+ * If the currently attached domain is a core domain (e.g. a default_domain),
+ * it will act just like the iommu_attach_group().
+ */
+int iommu_group_replace_domain(struct iommu_group *group,
+			       struct iommu_domain *new_domain)
+{
+	int ret;
+
+	if (!new_domain)
+		return -EINVAL;
+
+	mutex_lock(&group->mutex);
+	ret = __iommu_group_set_domain(group, new_domain);
+	if (ret)
+		__iommu_group_for_each_dev(group, group->domain,
+					   iommu_group_do_attach_device);
+	mutex_unlock(&group->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(iommu_group_replace_domain, IOMMUFD_INTERNAL);
+
 static int iommu_group_do_set_platform_dma(struct device *dev, void *data)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
-- 
2.40.0

