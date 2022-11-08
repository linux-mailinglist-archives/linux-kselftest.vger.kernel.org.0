Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D24620524
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 01:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiKHAuI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 19:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbiKHAt6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 19:49:58 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9778327152;
        Mon,  7 Nov 2022 16:49:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxDS/iAFBMI8Ykqi/YNQZDr8mQd2kAIwb6Q2tgm0MYHSfMEpcRbkgyVl9N7V3rKZ8kd9n4IhCszJUTuZ+lr+oUPkxFgLwuU0Uqys913iQ8SHNeA2Tv75YFtIGOcHUpJWMzzU4WSb47znY/1A1WCkwuMYXK9hxC+rIHOrKWqdP1wm31pGn8zBxClAh78t9ZmZfA/3Ah3TeBt7io37lTYQ83n3G2swoDU3VzWP0+DtMnOjKHvUiGb3A8iYHcA9OmypHIFmdn4aHrJxxTXuGrBCovBwQtWG03//dePCnpngKFm8Wcr2ILPjx/YCaqrZnU6vsXWHZkFBQdsj/soAIfDAGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrzMpe+wZSehTomQtAXzkpal2ebHA5xxOP6zhOVNyWg=;
 b=Kw3upFFBfgAlm/TmE6VLSdfUjEuNN2w3HVCD6XINWltO9VSGcWJJTVTzVMLheS0RaohHTI73fPxpcKeTokBhbNWaKuoYFJKwzNxOm8oSwOQuSS4oykZmc7Uw528jO0W/SGXjX9qAppxFVNDbAK60N33KNKahCxTH6ytilmPyVYHmkMeH7QE+Tp3NK+uINIitqXQdS5lW1e45/Cfq8ZFZjM5nVeIu0vBFanvr1cSrCwVEMLWQZxlf5RukzeZigbXdDvDh9CiS9DKWgb3tbeuSRkT0X1XOXcAU+LHsMkuPgbspBkqgkAq/FjCnQgrPGJQ+rkOcxTElXkRYB2LTDaIQjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrzMpe+wZSehTomQtAXzkpal2ebHA5xxOP6zhOVNyWg=;
 b=DeHOfAeYAvT4UKX+cXAQvDJKGLAQCdDoFCuwxWoLd0XCZ1cw5Qr2a6azw08rSLYoYx3iJ/P5xdpwDOo+VYjz2DqlLLNwyGWd83iH7gm/msleXCEgOXQ5iACkGkthMo57QupU4WqhjIOzf+E/bdI2HpYgWfpaZVJF/ejPMcYI70RVXq2ytagmM03dIe8hTdWQOedY+RP22HsIZBrZQVNcBiX9ncE4htyEFOlhoMrFDNcS13/tIeEiukC5fpPZ55KSx2eXY1stDUqVJ5YJkgK7kWCY0y7xLaBjWEfNES94oJWKMk/P0jpp2xBqKiA42lUkE+4RIPI2mnLySEzoTW2yEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 00:49:20 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 00:49:20 +0000
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
Subject: [PATCH v4 13/17] iommufd: Add kAPI toward external drivers for kernel access
Date:   Mon,  7 Nov 2022 20:49:06 -0400
Message-Id: <13-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0061.namprd16.prod.outlook.com
 (2603:10b6:208:234::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e01038-64bd-48fd-820e-08dac1230e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rir9oMNeGPnOzXB9Dbafb4f5C39KNpI/y2bpKy0aJy8kxfv7XBYtIeuqoyHouzpPhSxPKhUdt3kq9Wqr43o55DEtECe0hQ7CMVvr73bkuRVtDeJNb0HKKkn1jwQBUzSyBKXI3BnsFncRvf57NFZnAlhQXBzxqgh3eG7ay7WDfWVKDlPdvlftNJ5p/OPXNv1fytAC5Y2ryzu5nUGmcFxSfZji+uZDIpfWIzPKfCrotfjxiHim0uId+hyKpCVQZLWmdPw1tJDhYHkH9uhyrSZl9oLa4v+sNOkuQeJdXnj8BmL9Uw8e0HUNmo7VDYqQw/49q9erKUI28foYjLF8u9BFdy+bgOtL11Kg4pK6qa0V87OZn6hVriznjvyH8TrJdHVa/NnjPWX9cRRf57hvl5jr/wp6pjfVaorw6i4FunK+K8jDQI0MVleOBxOcPGbH+tpjxIJrI6C7rgxNoSS/AlB/iwg09Z7iaAu4cPL38/Y/kDZfGivdh2aAsKcJb19+QSAUC98Lx7n6mpc2DNsSb97WNkjZlWzbZgGoU520RwUPdxB1imM3uODR5owDa7WOETeGroBpm5pScgFd3wJ7ArcJWOmVD2ughey9PhFtXZIn3L6Pmuzr2QHGsV5+SXhf3Nk9dL6GL+6JxGjnDB+ug5TsJRqKCVaXlwJe1dKemkCtTQH71J0DJ21NjhTYuH1mTs6CSEcdZ2XgE6u9hOKNom4nqYPkPxD8Rb2p0fXp82P+V2DyM6OulriLYOoSWsmUl+qi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199015)(30864003)(8676002)(54906003)(110136005)(66476007)(8936002)(7416002)(5660300002)(7406005)(2906002)(38100700002)(316002)(66946007)(41300700001)(66556008)(4326008)(186003)(2616005)(83380400001)(6486002)(478600001)(6512007)(26005)(6666004)(6506007)(86362001)(921005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ol+9iWMUtO0fRAG/Jg5yPTFXB5EyV97nMsOAbt6Iv7t+THUspFHA0nknRc57?=
 =?us-ascii?Q?ZLxEK1gy4XNHLHEWlstTIEaTJI26MJkxxljLqmyyepKtMCBO4bwdtYItcZkS?=
 =?us-ascii?Q?slNrGZYjpLWLO+DBvRgDqDFSURYntdd76rm7Y9sCBRbCzPH1byu+r4FKXsIM?=
 =?us-ascii?Q?uh3KU7Q9gl+aLiXUu04b6x57EbzPJ9UWA1hJGR7gn7Yu0gYSqp2RDWlA1LdQ?=
 =?us-ascii?Q?qU94dprLPdZniRFGCvACEOtOFmDVFHSrdCHMysa+8+rM3kGkfGqQYCnxTBvM?=
 =?us-ascii?Q?YAzcSL/dWbIm/0k+/86rZ+wY1HvNXCnlWomFhjgwTt5yFlkr9USOqesqA/TP?=
 =?us-ascii?Q?wkO8HKsREzNCxlWEdrVvI6AYzh1b7y5wxGTbHpQmbygO+mOtewB4N5Ko9YsD?=
 =?us-ascii?Q?IiCnKtYUiNXjy5LZ2wbYfONRR4w+wXZkS8qzCQ3GoXJq69DXGEDgrwF09x1U?=
 =?us-ascii?Q?Zskv51ckaV2t8w+W45maLmvHQ4ZxShzDgMNz0LIFuISn+EoIep4gqzyOJi4h?=
 =?us-ascii?Q?9dofMsk+mw0xDrOQorS4QHWTOCCTwt6jaX1csNwfoGVjT0NQDJf17CnsySL7?=
 =?us-ascii?Q?rxdXt9obd9yODFCvmHY3eIq3UXwFLqSODRQCB11lnu2wnyoLukYIpbT19ygL?=
 =?us-ascii?Q?41BNKpq60o5iuySXR2l/43hvYcAfgPPiHjOvkkL32IjAdjhbSUl7W7zbj/vH?=
 =?us-ascii?Q?cgyPvlqnookK0DkjKcGQI+wTYn+VQ4f9fMGYN4KzFFPGA+0HjtrcR+srGQtf?=
 =?us-ascii?Q?Iueep0yfr/05IonPRy23XbHlp70aoFmkff94yOozpBR5+UxXD2i7ueo+GnuD?=
 =?us-ascii?Q?mZIRhq0B2XI/lJtAcN8UNN7XwP6pvyY+spT44pd5wf7KZ1+pPLDmKA6bW9tF?=
 =?us-ascii?Q?emFC7YuAY1px5cuBLetXCayAWc6eOha6soF3Ta7i5O3E8EkdXTVw8173Blfd?=
 =?us-ascii?Q?dTudT9aTS8wqAFIy2BKzLuapBSTPZ45SWsU2Sv9pPXNGwL8GxBFDu0CJVA5L?=
 =?us-ascii?Q?OXN1J6HeOn8n2xXUr2YTPAAsnkTkUupABGDTcGl6IBzkz/qVHcQFpSxJ8x0M?=
 =?us-ascii?Q?hI8rYyIJamtmG0jp/qeumPEQHSf0zrsT5H/nW7+EwosKk8qRxWFvJFb5e5op?=
 =?us-ascii?Q?R6QcJA/yYd7DZeFMHZrXPw5K2u3OKhoo7KvTqkHlhzpkcymjL/BZA+72cNiD?=
 =?us-ascii?Q?f0oyMGdvJgJ10HbDR5KiyXY8jmq6o6Nyxwo8K2aQKztK9a+fAbpRbqrNF9i1?=
 =?us-ascii?Q?sVFXGR/xs9tV/I9vck8j85x62/BtPuc0O5Ac15bz5hzFFmKOMNnkeBiImLAq?=
 =?us-ascii?Q?gJ0O7+Kc5eQX8CF1m/aovL3h4wOcCF4mhzwBR1176z4GsNSxLkGCqX06Abpx?=
 =?us-ascii?Q?wlUcVqHESeSn9UlISLiX7j2SLQCgfFTnnSCsWZkOuxUdiIzx2LmnGl/sTu94?=
 =?us-ascii?Q?LNQCcaDwdl/8f03HNZa2yw4xaTfE6WVsGQMYyCKO4aAQSh3JYBHHXdXkXdcp?=
 =?us-ascii?Q?/50PVDVGL8Sx2Xai28tKAwSLsda21F0qjrUgPTjE48zOilijnUKhruL3+JQJ?=
 =?us-ascii?Q?zEIxQjRUCMyv47sPA8Q=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e01038-64bd-48fd-820e-08dac1230e25
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 00:49:13.4189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 543Z4Pgm+3RdSAijHIuHdM1vXZohDBJAwISeUueP5puOd8FTUim6E/AB9CwTXBb+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kernel access is the mode that VFIO "mdevs" use. In this case there is no
struct device and no IOMMU connection. iommufd acts as a record keeper for
accesses and returns the actual struct pages back to the caller to use
however they need. eg with kmap or the DMA API.

Each caller must create a struct iommufd_access with
iommufd_access_create(), similar to how iommufd_device_bind() works. Using
this struct the caller can access blocks of IOVA using
iommufd_access_pin_pages() or iommufd_access_rw().

Callers must provide a callback that immediately unpins any IOVA being
used within a range. This happens if userspace unmaps the IOVA under the
pin.

The implementation forwards the access requests directly to the iopt
infrastructure that manages the iopt_pages_access.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 303 ++++++++++++++++++++++++
 drivers/iommu/iommufd/io_pagetable.c    |   8 +-
 drivers/iommu/iommufd/iommufd_private.h |  10 +
 drivers/iommu/iommufd/main.c            |   3 +
 include/linux/iommufd.h                 |  43 +++-
 5 files changed, 364 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index a3bf3c07d3f800..da365d0cf4cf19 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -6,6 +6,7 @@
 #include <linux/iommu.h>
 #include <linux/irqdomain.h>
 
+#include "io_pagetable.h"
 #include "iommufd_private.h"
 
 /*
@@ -400,3 +401,305 @@ void iommufd_device_detach(struct iommufd_device *idev)
 	refcount_dec(&idev->obj.users);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_detach, IOMMUFD);
+
+void iommufd_access_destroy_object(struct iommufd_object *obj)
+{
+	struct iommufd_access *access =
+		container_of(obj, struct iommufd_access, obj);
+
+	iopt_remove_access(&access->ioas->iopt, access);
+	iommufd_ctx_put(access->ictx);
+	refcount_dec(&access->ioas->obj.users);
+}
+
+struct iommufd_access *
+iommufd_access_create(struct iommufd_ctx *ictx, u32 ioas_id,
+		      const struct iommufd_access_ops *ops, void *data)
+{
+	struct iommufd_access *access;
+	struct iommufd_object *obj;
+	int rc;
+
+	/*
+	 * There is no uAPI for the access object, but to keep things symmetric
+	 * use the object infrastructure anyhow.
+	 */
+	access = iommufd_object_alloc(ictx, access, IOMMUFD_OBJ_ACCESS);
+	if (IS_ERR(access))
+		return access;
+
+	access->data = data;
+	access->ops = ops;
+	access->ictx = ictx;
+
+	obj = iommufd_get_object(ictx, ioas_id, IOMMUFD_OBJ_IOAS);
+	if (IS_ERR(obj)) {
+		rc = PTR_ERR(obj);
+		goto out_abort;
+	}
+	access->ioas = container_of(obj, struct iommufd_ioas, obj);
+	iommufd_ref_to_users(obj);
+
+	if (ops->needs_pin_pages)
+		access->iova_alignment = PAGE_SIZE;
+	else
+		access->iova_alignment = 1;
+	rc = iopt_add_access(&access->ioas->iopt, access);
+	if (rc)
+		goto out_put_ioas;
+
+	/* The calling driver is a user until iommufd_access_destroy() */
+	refcount_inc(&access->obj.users);
+	iommufd_ctx_get(ictx);
+	iommufd_object_finalize(ictx, &access->obj);
+	return access;
+out_put_ioas:
+	refcount_dec(&access->ioas->obj.users);
+out_abort:
+	iommufd_object_abort(ictx, &access->obj);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_access_create, IOMMUFD);
+
+void iommufd_access_destroy(struct iommufd_access *access)
+{
+	bool was_destroyed;
+
+	was_destroyed = iommufd_object_destroy_user(access->ictx, &access->obj);
+	WARN_ON(!was_destroyed);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_access_destroy, IOMMUFD);
+
+/**
+ * iommufd_access_notify_unmap - Notify users of an iopt to stop using it
+ * @iopt: iopt to work on
+ * @iova: Starting iova in the iopt
+ * @length: Number of bytes
+ *
+ * After this function returns there should be no users attached to the pages
+ * linked to this iopt that intersect with iova,length. Anyone that has attached
+ * a user through iopt_access_pages() needs to detatch it through
+ * iommufd_access_unpin_pages() before this function returns.
+ *
+ * The unmap callback may not call or wait for a iommufd_access_destroy() to
+ * complete. Once iommufd_access_destroy() returns no ops are running and no
+ * future ops will be called.
+ */
+void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
+				 unsigned long length)
+{
+	struct iommufd_ioas *ioas =
+		container_of(iopt, struct iommufd_ioas, iopt);
+	struct iommufd_access *access;
+	unsigned long index;
+
+	xa_lock(&ioas->iopt.access_list);
+	xa_for_each(&ioas->iopt.access_list, index, access) {
+		if (!iommufd_lock_obj(&access->obj))
+			continue;
+		xa_unlock(&ioas->iopt.access_list);
+
+		access->ops->unmap(access->data, iova, length);
+
+		iommufd_put_object(&access->obj);
+		xa_lock(&ioas->iopt.access_list);
+	}
+	xa_unlock(&ioas->iopt.access_list);
+}
+
+/**
+ * iommufd_access_unpin_pages() - Undo iommufd_access_pin_pages
+ * @access: IOAS access to act on
+ * @iova: Starting IOVA
+ * @length:- Number of bytes to access
+ *
+ * Return the struct page's. The caller must stop accessing them before calling
+ * this. The iova/length must exactly match the one provided to access_pages.
+ */
+void iommufd_access_unpin_pages(struct iommufd_access *access,
+				unsigned long iova, unsigned long length)
+{
+	struct io_pagetable *iopt = &access->ioas->iopt;
+	struct iopt_area_contig_iter iter;
+	unsigned long last_iova;
+	struct iopt_area *area;
+
+	if (WARN_ON(!length) ||
+	    WARN_ON(check_add_overflow(iova, length - 1, &last_iova)))
+		return;
+
+	down_read(&iopt->iova_rwsem);
+	iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova)
+		iopt_pages_remove_access(
+			area, iopt_area_iova_to_index(area, iter.cur_iova),
+			iopt_area_iova_to_index(
+				area,
+				min(last_iova, iopt_area_last_iova(area))));
+	up_read(&iopt->iova_rwsem);
+	WARN_ON(!iopt_area_contig_done(&iter));
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_access_unpin_pages, IOMMUFD);
+
+static bool iopt_area_contig_is_aligned(struct iopt_area_contig_iter *iter,
+					bool first)
+{
+	if (iopt_area_start_byte(iter->area, iter->cur_iova) % PAGE_SIZE)
+		return false;
+
+	if (!iopt_area_contig_done(iter) &&
+	    (iopt_area_start_byte(iter->area, iopt_area_last_iova(iter->area)) %
+	     PAGE_SIZE) != (PAGE_SIZE - 1))
+		return false;
+	return true;
+}
+
+static bool check_area_prot(struct iopt_area *area, unsigned int flags)
+{
+	if (flags & IOMMUFD_ACCESS_RW_WRITE)
+		return area->iommu_prot & IOMMU_WRITE;
+	return area->iommu_prot & IOMMU_READ;
+}
+
+/**
+ * iommufd_access_pin_pages() - Return a list of pages under the iova
+ * @access: IOAS access to act on
+ * @iova: Starting IOVA
+ * @length: Number of bytes to access
+ * @out_pages: Output page list
+ * @flags: IOPMMUFD_ACCESS_RW_* flags
+ *
+ * Reads @length bytes starting at iova and returns the struct page * pointers.
+ * These can be kmap'd by the caller for CPU access.
+ *
+ * The caller must perform iopt_unaccess_pages() when done to balance this.
+ *
+ * This API always requires a page aligned iova. This happens naturally if the
+ * ioas alignment is >= PAGE_SIZE and the iova is PAGE_SIZE aligned. However
+ * smaller alignments have corner cases where this API can fail on otherwise
+ * aligned iova.
+ */
+int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
+			     unsigned long length, struct page **out_pages,
+			     unsigned int flags)
+{
+	struct io_pagetable *iopt = &access->ioas->iopt;
+	struct iopt_area_contig_iter iter;
+	unsigned long last_iova;
+	struct iopt_area *area;
+	bool first = true;
+	int rc;
+
+	if (!length)
+		return -EINVAL;
+	if (check_add_overflow(iova, length - 1, &last_iova))
+		return -EOVERFLOW;
+
+	down_read(&iopt->iova_rwsem);
+	iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova) {
+		unsigned long last = min(last_iova, iopt_area_last_iova(area));
+		unsigned long last_index = iopt_area_iova_to_index(area, last);
+		unsigned long index =
+			iopt_area_iova_to_index(area, iter.cur_iova);
+
+		if (area->prevent_access ||
+		    !iopt_area_contig_is_aligned(&iter, first)) {
+			rc = -EINVAL;
+			goto err_remove;
+		}
+
+		if (!check_area_prot(area, flags)) {
+			rc = -EPERM;
+			goto err_remove;
+		}
+		first = false;
+
+		mutex_lock(&area->pages->mutex);
+		rc = iopt_pages_add_access(area->pages, index, last_index,
+					   out_pages, flags);
+		if (rc) {
+			mutex_unlock(&area->pages->mutex);
+			goto err_remove;
+		}
+		area->num_accesses++;
+		mutex_unlock(&area->pages->mutex);
+		out_pages += last_index - index + 1;
+	}
+	if (!iopt_area_contig_done(&iter)) {
+		rc = -ENOENT;
+		goto err_remove;
+	}
+
+	up_read(&iopt->iova_rwsem);
+	return 0;
+
+err_remove:
+	if (iova < iter.cur_iova) {
+		last_iova = iter.cur_iova - 1;
+		iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova)
+			iopt_pages_remove_access(
+				area,
+				iopt_area_iova_to_index(area, iter.cur_iova),
+				iopt_area_iova_to_index(
+					area, min(last_iova,
+						  iopt_area_last_iova(area))));
+	}
+	up_read(&iopt->iova_rwsem);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_access_pin_pages, IOMMUFD);
+
+/**
+ * iommufd_access_rw - Read or write data under the iova
+ * @access: IOAS access to act on
+ * @iova: Starting IOVA
+ * @data: Kernel buffer to copy to/from
+ * @length: Number of bytes to access
+ * @flags: IOMMUFD_ACCESS_RW_* flags
+ *
+ * Copy kernel to/from data into the range given by IOVA/length. If flags
+ * indicates IOMMUFD_ACCESS_RW_KTHREAD then a large copy can be optimized
+ * by changing it into copy_to/from_user().
+ */
+int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
+		      void *data, size_t length, unsigned int flags)
+{
+	struct io_pagetable *iopt = &access->ioas->iopt;
+	struct iopt_area_contig_iter iter;
+	struct iopt_area *area;
+	unsigned long last_iova;
+	int rc;
+
+	if (!length)
+		return -EINVAL;
+	if (check_add_overflow(iova, length - 1, &last_iova))
+		return -EOVERFLOW;
+
+	down_read(&iopt->iova_rwsem);
+	iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova) {
+		unsigned long last = min(last_iova, iopt_area_last_iova(area));
+		unsigned long bytes = (last - iter.cur_iova) + 1;
+
+		if (area->prevent_access) {
+			rc = -EINVAL;
+			goto err_out;
+		}
+
+		if (!check_area_prot(area, flags)) {
+			rc = -EPERM;
+			goto err_out;
+		}
+
+		rc = iopt_pages_rw_access(
+			area->pages, iopt_area_start_byte(area, iter.cur_iova),
+			data, bytes, flags);
+		if (rc)
+			goto err_out;
+		data += bytes;
+	}
+	if (!iopt_area_contig_done(&iter))
+		rc = -ENOENT;
+err_out:
+	up_read(&iopt->iova_rwsem);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_access_rw, IOMMUFD);
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 86effe8ed1dce5..a7d16cd14ea200 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -468,6 +468,7 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 	 * is NULL. This prevents domain attach/detatch from running
 	 * concurrently with cleaning up the area.
 	 */
+again:
 	down_read(&iopt->domains_rwsem);
 	down_write(&iopt->iova_rwsem);
 	while ((area = iopt_area_iter_first(iopt, start, end))) {
@@ -496,8 +497,11 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 			area->prevent_access = true;
 			up_write(&iopt->iova_rwsem);
 			up_read(&iopt->domains_rwsem);
-			/* Later patch calls back to drivers to unmap */
-			return -EBUSY;
+			iommufd_access_notify_unmap(iopt, area_first,
+						    iopt_area_length(area));
+			if (WARN_ON(READ_ONCE(area->num_accesses)))
+				return -EDEADLOCK;
+			goto again;
 		}
 
 		pages = area->pages;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 1f8c73aca176e2..d7d606d459d4c8 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -65,6 +65,8 @@ int iopt_unmap_iova(struct io_pagetable *iopt, unsigned long iova,
 		    unsigned long length, unsigned long *unmapped);
 int iopt_unmap_all(struct io_pagetable *iopt, unsigned long *unmapped);
 
+void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
+				 unsigned long length);
 int iopt_table_add_domain(struct io_pagetable *iopt,
 			  struct iommu_domain *domain);
 void iopt_table_remove_domain(struct io_pagetable *iopt,
@@ -106,6 +108,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_DEVICE,
 	IOMMUFD_OBJ_HW_PAGETABLE,
 	IOMMUFD_OBJ_IOAS,
+	IOMMUFD_OBJ_ACCESS,
 };
 
 /* Base struct for all objects with a userspace ID handle. */
@@ -246,6 +249,11 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 void iommufd_device_destroy(struct iommufd_object *obj);
 
 struct iommufd_access {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct iommufd_ioas *ioas;
+	const struct iommufd_access_ops *ops;
+	void *data;
 	unsigned long iova_alignment;
 	u32 iopt_access_list_id;
 };
@@ -253,4 +261,6 @@ struct iommufd_access {
 int iopt_add_access(struct io_pagetable *iopt, struct iommufd_access *access);
 void iopt_remove_access(struct io_pagetable *iopt,
 			struct iommufd_access *access);
+void iommufd_access_destroy_object(struct iommufd_object *obj);
+
 #endif
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 8a114ddbdfcde2..c8cc0953dea13a 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -352,6 +352,9 @@ void iommufd_ctx_put(struct iommufd_ctx *ictx)
 EXPORT_SYMBOL_NS_GPL(iommufd_ctx_put, IOMMUFD);
 
 static const struct iommufd_object_ops iommufd_object_ops[] = {
+	[IOMMUFD_OBJ_ACCESS] = {
+		.destroy = iommufd_access_destroy_object,
+	},
 	[IOMMUFD_OBJ_DEVICE] = {
 		.destroy = iommufd_device_destroy,
 	},
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 31efacd8a46cce..fb9a4c275cca86 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -9,10 +9,12 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/err.h>
-#include <linux/device.h>
 
+struct device;
 struct iommufd_device;
+struct page;
 struct iommufd_ctx;
+struct iommufd_access;
 struct file;
 
 struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
@@ -26,6 +28,11 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id,
 			  unsigned int flags);
 void iommufd_device_detach(struct iommufd_device *idev);
 
+struct iommufd_access_ops {
+	u8 needs_pin_pages : 1;
+	void (*unmap)(void *data, unsigned long iova, unsigned long length);
+};
+
 enum {
 	IOMMUFD_ACCESS_RW_READ = 0,
 	IOMMUFD_ACCESS_RW_WRITE = 1 << 0,
@@ -33,11 +40,24 @@ enum {
 	IOMMUFD_ACCESS_RW_KTHREAD = 1 << 1,
 };
 
+struct iommufd_access *
+iommufd_access_create(struct iommufd_ctx *ictx, u32 ioas_id,
+		      const struct iommufd_access_ops *ops, void *data);
+void iommufd_access_destroy(struct iommufd_access *access);
+
 void iommufd_ctx_get(struct iommufd_ctx *ictx);
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
 struct iommufd_ctx *iommufd_ctx_from_file(struct file *file);
 void iommufd_ctx_put(struct iommufd_ctx *ictx);
+
+int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
+			     unsigned long length, struct page **out_pages,
+			     unsigned int flags);
+void iommufd_access_unpin_pages(struct iommufd_access *access,
+				unsigned long iova, unsigned long length);
+int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
+		      void *data, size_t len, unsigned int flags);
 #else /* !CONFIG_IOMMUFD */
 static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
 {
@@ -47,5 +67,26 @@ static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
 static inline void iommufd_ctx_put(struct iommufd_ctx *ictx)
 {
 }
+
+static inline int iommufd_access_pin_pages(struct iommufd_access *access,
+					   unsigned long iova,
+					   unsigned long length,
+					   struct page **out_pages,
+					   unsigned int flags)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void iommufd_access_unpin_pages(struct iommufd_access *access,
+					      unsigned long iova,
+					      unsigned long length)
+{
+}
+
+static inline int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
+		      void *data, size_t len, unsigned int flags)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_IOMMUFD */
 #endif
-- 
2.38.1

