Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E41687634
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Feb 2023 08:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjBBHGC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Feb 2023 02:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjBBHFx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Feb 2023 02:05:53 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAFE83485;
        Wed,  1 Feb 2023 23:05:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7z5P8ZRQ+Q7Y3svU42wlLBk7X74fuln98nvYHQSPUtgbQHCZuCibFp06VJwJFm1yb52XQqSvU3H9ZXB5MTP0xxMjbbAlm7A2sfgQJYGSaRvBrphCtAuxe/6htFjQmEK4isvMEZZioJyELfJ0vQlEyt7G44XLvMl5EuDfz+YipdOuOBuvF5OK7Lr05OkRgubbfHXPFwC0Z/olZbwAty94Zes+42tL9VCZv9A7/SpkBVXDmO2LeHeHkCKBsSrdffLucLO/8sEPVREWF/ntVpD0PxYcwKNUJy/IakOIJS/rIPFemhz4X5XKGJJUiZQ3GaVtF+kGhHrYYuzqZzmmDKkrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tICV2SWIk6qWYrwA6OQ0wLv+yeybBZIZnKhYP+k2w74=;
 b=XPj7YiJQEksQxHqSlvplauS4zU/4F05LmStScYqZADV9WQ3K3Myi7dy0t4YKlyY/cHIrahyEmJ/+DeYSZGjnXZGMNfY2FNRoa/PAuktcuuZYEHC+/dutUmLC6AXlTyNrdVbfrJUTm/uYz3sleBKKLXGv5ZWNaCzbj5vmopeIPjW56paH/QfbEXhEQQaMrVnTsZrRDIY4dB1dHMdEXz3ca+pQfnJgfatrEIS7YjU/EsOn8/5TMtl95bMGcUI1YderKE4sKLXwYz8vHKyQl7UIREJ//50+2lbt24JVixWQa5H0WLbQvQtVJ9QdmuuHOmlc83XVKd4mxHI94AvtJcdDAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tICV2SWIk6qWYrwA6OQ0wLv+yeybBZIZnKhYP+k2w74=;
 b=gLFNaFYZ+a4TGAz5dWgYJbWZPXfAMJXOk336emMT9ABNA7wJFnDc0yrfNVuCuj8NAgHGZtIrxKN8lZJLHKrcnyXomomi/ZllsO0wG92NWSZ4+ltjLjb1Qpsu7uJMSVl4ag+x9GEF951CsEkZMD6MaYitLl0NmqBTFkuggsBlvbpAqbH04vw2rtH0pwzdL/UxHWgucbjTcrG1kzY5XPxhXWmoxxgvTJtKvun/L1c1Cr0RrkgkEqNbB+dAcJ2k4JbecWCW5bgQ1Mz/68AgSa+7tgXnNadzeK6rPDyBrOFyjbW9hjEeywOb309l8jTZIIXNFqzX9AjY1mZ/2k5LLgQWNw==
Received: from DS7PR03CA0235.namprd03.prod.outlook.com (2603:10b6:5:3ba::30)
 by DS7PR12MB8323.namprd12.prod.outlook.com (2603:10b6:8:ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Thu, 2 Feb
 2023 07:05:41 +0000
Received: from DS1PEPF0000B077.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::b7) by DS7PR03CA0235.outlook.office365.com
 (2603:10b6:5:3ba::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.43 via Frontend
 Transport; Thu, 2 Feb 2023 07:05:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0000B077.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.17 via Frontend Transport; Thu, 2 Feb 2023 07:05:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 23:05:27 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 23:05:27 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 1 Feb 2023 23:05:26 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v1 5/8] iommufd: Add replace support in iommufd_access_set_ioas()
Date:   Wed, 1 Feb 2023 23:05:09 -0800
Message-ID: <bfe5aed6d354ef547979f0b256c8a3f9bd5b223b.1675320212.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675320212.git.nicolinc@nvidia.com>
References: <cover.1675320212.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B077:EE_|DS7PR12MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: e65e79a0-3fcd-4021-74c4-08db04ebe591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w/UCAU68Hs5WZ4OyJy4AHLRzp0PYDDkhpdZRjQwGDZvfccNPJJI/BYIZ538zfCcGVKRRPBcq5AKuqnh6fMBkRaBRgXnDXQiALYofKhaxTHBzh0SQD7tM9vDWYnbYk3KCGlbNdkV4MlGAsr+cnKu3e2rk2HKuy3DvrIXect4djB4QDCpcsh5ZSj0eYSZ9PQhAOMV4/0cKm9EdwmGh6k7WIsRnayA8KKeuaNwYsK36jvpmtRsvJH8klpNhkLiFHRaAcHpeNWeQS5Rx5jwATvie7Shmf0SY6Ob6UZgkxoxHZUdfdsf6mjQFcMteCRVWFcp7fISIeInICey6Y/aGwcF9VJVzLGlpgiC1O3JNqJ6YMuk8fnN7+NcqlJE35HZ+9JcGMfSNiGzI7eJpbm60snpX4CuJuYQKWR4y0L7W8OvNWk/p0I0DnKzEfEmJ3WuG03bF0sOaO60TzsIq+1FJMMMlZmNl0DFNjpP9YaXcjqKRbkFfgkwNlMonYjt+Y0cJ7679bX3Cj62gjjgPXKqSJ2DuGgEcrnXCD7D/yYsfjZehCJDhmzWMPQxtOCRvfhUH8c4amCsEpJJ1DheK4/LOwX+fzrpaKPftmjkWvucMQDmpaES35BH3pwjbtcUJC8EmJtCfNSu5oXgzBKeCPjSIis6Kf4fB5wUcWA3hKHkkEYw3oYCD94JcLhMVfDc9Xuc/8Ik7EzU2J8o544IcvKxg+KdyzeR4widhaWYh+TuhcIfU6Vg=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199018)(46966006)(36840700001)(40470700004)(40460700003)(2616005)(316002)(110136005)(83380400001)(4326008)(41300700001)(8936002)(54906003)(8676002)(70586007)(70206006)(6666004)(336012)(478600001)(26005)(186003)(426003)(7696005)(47076005)(86362001)(356005)(36756003)(40480700001)(2906002)(36860700001)(5660300002)(7416002)(7636003)(82310400005)(82740400003)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 07:05:41.6835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e65e79a0-3fcd-4021-74c4-08db04ebe591
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B077.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8323
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Support an access->ioas replacement in iommufd_access_set_ioas(), which
sets the access->ioas to NULL provisionally so that any further incoming
iommufd_access_pin_pages() callback can be blocked.

Then, call access->ops->unmap() to clean up the entire iopt. To allow an
iommufd_access_unpin_pages() callback to happen via this unmap() call,
add an ioas_unpin pointer so the unpin routine won't be affected by the
"access->ioas = NULL" trick above.

Also, a vdev without an ops->dma_unmap implementation cannot replace its
access->ioas pointer. So add an iommufd_access_ioas_is_attached() helper
to sanity that.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 28 +++++++++++++++++++++++--
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/vfio/iommufd.c                  |  4 ++++
 include/linux/iommufd.h                 |  1 +
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index f4bd6f532a90..8118d5262800 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -509,11 +509,23 @@ int iommufd_access_set_ioas(struct iommufd_access *access, u32 ioas_id)
 		iommufd_ref_to_users(obj);
 	}
 
+	/*
+	 * Set ioas to NULL to block any further iommufd_access_pin_pages().
+	 * iommufd_access_unpin_pages() can continue using access->ioas_unpin.
+	 */
+	access->ioas = NULL;
+
 	if (cur_ioas) {
+		if (new_ioas) {
+			mutex_unlock(&access->ioas_lock);
+			access->ops->unmap(access->data, 0, ULONG_MAX);
+			mutex_lock(&access->ioas_lock);
+		}
 		iopt_remove_access(&cur_ioas->iopt, access);
 		refcount_dec(&cur_ioas->obj.users);
 	}
 
+	access->ioas_unpin = new_ioas;
 	access->ioas = new_ioas;
 	mutex_unlock(&access->ioas_lock);
 
@@ -527,6 +539,18 @@ int iommufd_access_set_ioas(struct iommufd_access *access, u32 ioas_id)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_set_ioas, IOMMUFD);
 
+bool iommufd_access_ioas_is_attached(struct iommufd_access *access)
+{
+	bool attached;
+
+	mutex_lock(&access->ioas_lock);
+	attached = !!access->ioas;
+	mutex_unlock(&access->ioas_lock);
+
+	return attached;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_access_ioas_is_attached, IOMMUFD);
+
 /**
  * iommufd_access_notify_unmap - Notify users of an iopt to stop using it
  * @iopt: iopt to work on
@@ -587,11 +611,11 @@ void iommufd_access_unpin_pages(struct iommufd_access *access,
 		return;
 
 	mutex_lock(&access->ioas_lock);
-	if (!access->ioas) {
+	if (!access->ioas_unpin) {
 		mutex_unlock(&access->ioas_lock);
 		return;
 	}
-	iopt = &access->ioas->iopt;
+	iopt = &access->ioas_unpin->iopt;
 
 	down_read(&iopt->iova_rwsem);
 	iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova)
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 2f4bb106bac6..593138bb37b8 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -261,6 +261,7 @@ struct iommufd_access {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
 	struct iommufd_ioas *ioas;
+	struct iommufd_ioas *ioas_unpin;
 	struct mutex ioas_lock;
 	const struct iommufd_access_ops *ops;
 	void *data;
diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index 78a8e4641cbf..7e09defbcffe 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -187,6 +187,10 @@ int vfio_iommufd_emulated_attach_ioas(struct vfio_device *vdev, u32 *pt_id)
 	if (!vdev->iommufd_access)
 		return -ENOENT;
 
+	if (!vdev->ops->dma_unmap && pt_id &&
+	    iommufd_access_ioas_is_attached(vdev->iommufd_access))
+		return -EBUSY;
+
 	iommufd_access_set_ioas(vdev->iommufd_access, *pt_id);
 	return 0;
 }
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 0e30f2ce27cd..e8d764b2c14c 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -44,6 +44,7 @@ iommufd_access_create(struct iommufd_ctx *ictx,
 		      const struct iommufd_access_ops *ops, void *data);
 void iommufd_access_destroy(struct iommufd_access *access);
 int iommufd_access_set_ioas(struct iommufd_access *access, u32 ioas_id);
+bool iommufd_access_ioas_is_attached(struct iommufd_access *access);
 
 void iommufd_ctx_get(struct iommufd_ctx *ictx);
 
-- 
2.39.1

