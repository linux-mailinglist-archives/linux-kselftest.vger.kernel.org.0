Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC3E6A26AF
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 02:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjBYBwv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 20:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjBYBwr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 20:52:47 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE1C688F8;
        Fri, 24 Feb 2023 17:52:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hr8fcrPDAUxqvcV8HKuc9WhEaiVKS5DJTDCqRYa4bwxlkhsJHM9zJqeZcG4JA2VGRFYSAJ0k99zNgafQ/i7tkHv/mEbufjsELi8b8DuqVsRVvvkxd6DR5bLyeu9ma6IAfz/fDrz0M79CUwJukZ21iKd8c7CRCHSJrM5l2xC05bjr3tT3IDHJNkSJpFz88oedOGMhumRV1G10gP/G9p7cb6xG7JCj3TDLGnuDFAJbP1LdiqDvX+JrALPGQt7scO9OIZ7wknxExtubUjmTuwKdwC+IBcCKot512LTW9uq5SaMo1QonGXdTjB9Vs32cCMXtfWVqgrbCtOZFHtC4tQ5Q8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HIe/btDAdM5jsWMfQ1rPEUc6uQmUlvcDqkJ6rXv2Jg=;
 b=emfx2RUkIVdGAZW/B13uv+J2JJRARhTBEt6ORpD/gahf8NMTOLZjf/sMO4Crqb5NsayxXHC7ntuSd5W5lmPzzyboSluJTdvVLsnvVKDxjU2lVWm0EGCDpKdDBdO3BUYQA1O10ohFOGDY4uRIHlUHtuHRnHRM4AZrOWvGoFx0x6MThtwzE9N6DEFNM754mBKdpNAoOIdiw5T4dS8PxVfVUlmuUtJ96ebPa7F0lehazKMnYcdPjB0ETjV61a/F38j7GUudbTMsEp7wZagrDNOPGcUxKe4lcKUxgt2RWPnVQij3z4BTfhkMV+tXBkGgwxlUc7ewuvBLdtbzBNvgh3xqrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HIe/btDAdM5jsWMfQ1rPEUc6uQmUlvcDqkJ6rXv2Jg=;
 b=HDhXE4CVeiovpUaCcRUDjD8Ck/18anROqI1+Jzdon15pcw0TCBpixlSEQFrrHX+NEUKjYhY0R7BxkMZ0wNRYwc4LTxnqlsbGYzRckWlKhEIdtletCqLgsBpYfWifKEYR1K4KsQG/VXlfha5g3gip/Sm+KJThKIJOX38OYrzOV8FahNM/91pIxlkMQE/4//bkZcgNxwu6sJ0mkgGsMCFC4x2sXd3kQFOCx2SJgpanMeoVtEg5dzez9idbKQUlIFtA4welrN0LV5vVZkQU1b7o3QlIlk7LMie/Sz7mvnbJOLiAk6VDNR50OTp0ImxFMO2nrIlH8291nUnLDDumydTKSQ==
Received: from DS7PR03CA0181.namprd03.prod.outlook.com (2603:10b6:5:3b6::6) by
 SJ0PR12MB5501.namprd12.prod.outlook.com (2603:10b6:a03:304::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Sat, 25 Feb
 2023 01:52:42 +0000
Received: from DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::f2) by DS7PR03CA0181.outlook.office365.com
 (2603:10b6:5:3b6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24 via Frontend
 Transport; Sat, 25 Feb 2023 01:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT087.mail.protection.outlook.com (10.13.172.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.12 via Frontend Transport; Sat, 25 Feb 2023 01:52:42 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 17:52:32 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 24 Feb
 2023 17:52:31 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 24 Feb 2023 17:52:30 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v3 4/5] iommufd: Add replace support in iommufd_access_set_ioas()
Date:   Fri, 24 Feb 2023 17:51:41 -0800
Message-ID: <a104b334d3cc148620ac1f2aa465fc14be556e63.1677288789.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1677288789.git.nicolinc@nvidia.com>
References: <cover.1677288789.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT087:EE_|SJ0PR12MB5501:EE_
X-MS-Office365-Filtering-Correlation-Id: 62057d93-7747-4009-ba4e-08db16d2fbdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hw38iuTUgsLJ8o1q4R7hKbyIjIYMxKEL1VnJuefiqU00u4QffYRBf//UEQ8dfVpr/iMEebN77NLn4hB6dh+w9R6hHnEpo4W3heAEd3/936gJp2ICeOiwna6aRf8v2ktfjLJMHjSp9j4s+EwN5cId+pJiPCKzfYqvCGY/ZzjcUvJ/0ok7IhDc79F2a7lH0p/d0D3noDKJ189FTcphRhyYC8m/EWqJJxGd7G2UrRiN7lq5ZQVYBX0460lua3LKBxFWqqQ3XESOU+w4oUjwx7O+/DpWxTEY52I7X0vLpwjYwwXBEpOEMEUy3H31LhOk8KQ+Llm7scLrfT/yvHCqgXC9oNY7hG9WBLuPMDIVPOVA8yps294DCVznzgchCKTwhRGE6JZ3FpFa4gz0YoeN/HWXomI6jyrbAdqZvcVNQqYmk1OKcCUKOdl91c9qR5I83gBhjklWLErlVljFhen4hS1cmNJ1L8UGwVNgOP0agQ+R9XYhDzwzlaux+fV+f7Lw0/FZ35ygnHs83DnjJ2OI99qhvbzIvWTG0FAnDG7lD24lDY+uh2IsDtNJwdZc6hYVWEvEq0VA2Ow4jsXeEBiMkYYRdAbFZjtiA9aBEiSGDA4487nwzDiBuNChgkjEwGZyw6VcIiOOSNt0A+8qEwu0cmhM8sI0OVe2b/swNLbj7dFa3gXCN6WoO3vPRCsbp38m1lg0m2XNF6CyxGmNoKmNV4QaiZrnSAap72EZR2Kv43tKOpQ=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199018)(36840700001)(46966006)(40470700004)(110136005)(2616005)(316002)(82310400005)(86362001)(36756003)(54906003)(40460700003)(26005)(186003)(70206006)(40480700001)(7416002)(36860700001)(2906002)(70586007)(8676002)(41300700001)(47076005)(426003)(6666004)(478600001)(336012)(7696005)(4326008)(356005)(5660300002)(7636003)(34020700004)(82740400003)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 01:52:42.4956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62057d93-7747-4009-ba4e-08db16d2fbdd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5501
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

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 15 +++++++++++++--
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index a955ebd4bd5d..c44d6e7a2ed7 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -712,11 +712,22 @@ int iommufd_access_set_ioas(struct iommufd_access *access, u32 ioas_id)
 		iommufd_ref_to_users(obj);
 	}
 
+	/*
+	 * Set ioas to NULL to block any further iommufd_access_pin_pages().
+	 * iommufd_access_unpin_pages() can continue using access->ioas_unpin.
+	 */
+	access->ioas = NULL;
+
+	mutex_unlock(&access->ioas_lock);
+	access->ops->unmap(access->data, 0, ULONG_MAX);
+	mutex_lock(&access->ioas_lock);
+
 	if (cur_ioas) {
 		iopt_remove_access(&cur_ioas->iopt, access);
 		refcount_dec(&cur_ioas->obj.users);
 	}
 
+	access->ioas_unpin = new_ioas;
 	access->ioas = new_ioas;
 	mutex_unlock(&access->ioas_lock);
 
@@ -790,11 +801,11 @@ void iommufd_access_unpin_pages(struct iommufd_access *access,
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
index 94e88377a7fc..44e77ea9c399 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -311,6 +311,7 @@ struct iommufd_access {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
 	struct iommufd_ioas *ioas;
+	struct iommufd_ioas *ioas_unpin;
 	struct mutex ioas_lock;
 	const struct iommufd_access_ops *ops;
 	void *data;
-- 
2.39.2

