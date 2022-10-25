Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFDC60D320
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 20:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiJYSMl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 14:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbiJYSMg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 14:12:36 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56008B2752;
        Tue, 25 Oct 2022 11:12:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfzolR08eJV3laWYnPy38MIt0rKClcQDkYvwJFNXVkrEPBaSrwU+n7qvMx03M7ZVzWSfvv7mSQQ2gHGL0MzC/9Mxgj93ezMrbXpW7WoNXrKTNIal2cmCofOG1fG4Izg75YQ7/OkEwm6/atFq1o1bIsm1ziz0ANnL5vif5azzlxGqlA4herQhYIiNnbCj160d5RUmXsTRZuTpnppL86BbbYXav7DNGBfyRZoCn0KXVbXVRdWfuRP2C3JNSHwdjVTNT5O4OcaEG8X57yhpigF8hBqABuSxh+r8L2oo6kfE9GL3mqjFJ96xBnhtF/DpFwJkg2Wsht9XAZTMKM29TgYN4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ7qK0BvONbkG8FLSYtgZWHqhx/R/ga/O2fLhFzFOWw=;
 b=iZ2y13kl1zvuVAXn3WjAqPTllmjK2SMYXh88HPbtkz78jXFHnOU9Sw/kIh5t7CUw3BI92GiRX+ZZzdC4RWWjifW4Pj1bV92/8grceJH9kGnU1Kywye0UvXmi4bZdzUjsRy1GMSKZYCw+Tp/+5vkc6EpkvUCVAzwrx+zmh76NIHyARW8Q8zDqIlbUqKVbTyRbWrr5GtN6nzFbw4P7dinoB70g1BfaClAxUxIMIPitMKFXy1s1kXBlybUwXB8MhBEaUZFlkjjYu37iXdGgoXIH5v8VzeojWoxbQej+JKCCU61/5gH6ZSdRWAY2Izz4zcUesdQMseDKlty+gO1xjhIIhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJ7qK0BvONbkG8FLSYtgZWHqhx/R/ga/O2fLhFzFOWw=;
 b=t5uhxmUZq8e/KfRwZDHkorLPEyvFWLj9wDpJCk1DCF1HThC3ulpt/Qy1qnFPddgXfVeW77wnkdUwn9xI21JrDBSDfLNUvQRcTnZNt/ggEzjxuPJ1GJtzlfqZ0voPXQfC1uGOc9o9J6RYfBt/d3aqYZV6S091R4KJQdS8iFkgn/qh8sJh6/rR9jHO9ODkWFqqStUHF74aqzP3APrBweaPCsXVp6CG00iTk4hQcQlsIvcqrgkkZBkEwxxtM6EfLJfPIGXK+VuoSYp990RZe97ozMV88VMzHew/gAWwN4NatiqgRnoMPPuHgLx0Q8bPU/iRHLhpKkwpUpWwaEEn1+7ZHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 25 Oct
 2022 18:12:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 18:12:29 +0000
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
Subject: [PATCH v3 13/15] iommufd: Add kAPI toward external drivers for kernel access
Date:   Tue, 25 Oct 2022 15:12:22 -0300
Message-Id: <13-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0033.namprd12.prod.outlook.com
 (2603:10b6:208:a8::46) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc009ff-2350-4384-c345-08dab6b4787f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FDzHlal/JrvfW+uTnlEchaBCL8en3y7pEWhQaBkwUKTDQRX5S6EXpPA2VfXnLEivwDK7ylTrCKh8l29KpdONgbhiURWuENYSfNCZL9i89mQsUUtwi/m+TVXDAPQ3+SKaY8yFb7MnGjjvrNnhYRUlAr1hGj1uBdHzppvr96DTEVvUh9w1XOiGXMQ97K3Lla0pPBxmX5qNoYCeAsF1CfGjKDGVN9XS76GL7pIc/xcMupXH/3w2pvMb5TKuweujdE6guEY2lmQKJLRTKaKD3peCAEVUAIl3QBHRff9NL/TeFlZ/dYD/0GktSuBPK6u2npVjf22uZZrsmUhsH7RcWrzg3df30+4/yNERNqxksIbxIScALNy9SEHakgU1JlJBv5jS6chAgO0l3cScMbImHn5uBoS+w+I4m+3VCeMrwQtxAM2HE7HLwtv/hjBk2AMmXmalQABxDxl6CzKUMPmiWNqL+xrniCbF+Nzyp/USXi2fSZyHnWY7+7l/d/O63Y/vZp682BmM1z34vQZ1MMyCECLBceyJOqMN9Lj4qiCgzID7rm0dEQ8DTlhi9TFFA0Euq77oUVmDDfemU/U2+1GVz19x/h3Wvv9+LWqEKOx6HIU/Xan7MY6qkBXeka9Bh2sxvpaFQE/PgPhXgo9/65DLtsDm11d3YllgMPUgV3v25IPRyN8x7u3JUw/RJcjTgXDWwpF6SHKcEQzqLlXs2dBUOidSs1CTssudRY0yAIhu+snLLW77iukBPJ0+MSzfxTfSXpZ9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199015)(6666004)(316002)(41300700001)(110136005)(36756003)(2616005)(6506007)(54906003)(7406005)(30864003)(7416002)(8936002)(66476007)(83380400001)(5660300002)(26005)(2906002)(4326008)(186003)(66946007)(8676002)(66556008)(6512007)(921005)(6486002)(38100700002)(86362001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PRBpL4mi7Zjoy/iQOiEP626EIiqYmGDki2pp/GAgnfCRqkm0Tte0kGu28w08?=
 =?us-ascii?Q?K3KulJaYWdVU0pYFpgqqIrMwZGrilfuckTuIRhgMikiCn2YWEFYzJ7A/ifRa?=
 =?us-ascii?Q?x9X84eBYZhuboNKrFCUSxJtZ29lCDxaa7zO98APS5rlU82Iup66oDwI+Xark?=
 =?us-ascii?Q?yc6bqakhqoo9aNu9WDMQo8Iuf56C1fq8FcOpDR6AnxaF2XgsR4YynSO78DtO?=
 =?us-ascii?Q?vj0BGbNmVnmwJl+YuXv4D2/jSO8XrY4UsIRTCUUjom5V8PhcZZD4rAu/Dsbu?=
 =?us-ascii?Q?BRfXBP3evZ7Ic/qzfGEoK1lX56cF2i8xs8JLvAxkDYKN49MbuHa1uBmW6x52?=
 =?us-ascii?Q?JKsAyJWUoOwirDXOZN5gpcPcZYPHSHHw29EIbwwUbNVVtY9phq9N18U5XTv6?=
 =?us-ascii?Q?xUMdksxWMQf4b/zGme4TQMAun8WpZHhNGtdpNSA+2xstEVRAp0Z3iL6/N0qj?=
 =?us-ascii?Q?f4ObrYjASQFySDhTSeV3CEsYlE6rHAQu3TI1t4KUpCSQAeacNOB0qo7iD33B?=
 =?us-ascii?Q?039pIxEsYv3W17P2PenxdTluEZpwdP6yXK6mxTl7uNLS/2AxUtJGJSEboZ/A?=
 =?us-ascii?Q?qbuS6x2k+LleN9pM9kWKo3hfGpNbyog7SGw7MRAPL+I8Jk89nmYNht9Qvc7g?=
 =?us-ascii?Q?3nwLvvg0W9RB8+v+1MnIFKgd869PzWCi4CZndugM8lSFtjuCZ//RyOt1NddO?=
 =?us-ascii?Q?MRQus7jtvFIXY5rP/s0P10ZI1BIebglwQDEBZBYxtsra7R8/D6LODeKxhcQB?=
 =?us-ascii?Q?zG4dA4v28i3B1zQ7FrxVqTDNyAUIDLFZRiOH6DVZ5tFMr7ktm5ClGUtfi0wc?=
 =?us-ascii?Q?yLB9F5idzBMgd7vsazJFQBVv8ZSnbVXQrSJHcRKdJBk3fDhcGyVbCKyTxRPE?=
 =?us-ascii?Q?4rLCBkq68vYcE70ULjNLYya3A0maIT5wOBNZnNmBwE9tC/6FG2iuAcjER5Zv?=
 =?us-ascii?Q?jaYJxddSdIP/TC2HRUcnohOEAzXs8lv/xWZTOrzwS3QlN6lVoiCJIQvT85Wy?=
 =?us-ascii?Q?n0Z1REGAQ2k4kSokujf4ohPh5ni9lcWwiOeBwlIUG2Zf168bJUqWaHQAA3Xh?=
 =?us-ascii?Q?e27X5os8+xMyw7FhlTO1pYgKRMJKh5NUYg4P+hzD0UhWgwxe94XgbgzJOat9?=
 =?us-ascii?Q?vurKJ8aRVkwKJQT3Ff1W4tDd4GRwh2PbpXX+FwdNOAuaIXdyHJ9MYCtM6aSR?=
 =?us-ascii?Q?Az4YXdsw5h1v/wU1RQaP3z1o6gqT/yzw5wiHemyLaX4EVseg+sjeXU1Oj/NC?=
 =?us-ascii?Q?AKbwEpoJJIwRTfgVbxLfilHMm/89HrkHXOqyUesik8cQhYjxvzaNGvpKiOfA?=
 =?us-ascii?Q?5vvHERhD6nGQY8hByy5x9Je4KqzpBsXN/wcYtV5DR842tXUK+ts/yeUkYZUs?=
 =?us-ascii?Q?S6HfjTgHSfT6Wue7wiP3Wf6lKXqttLT3GjdV9ka8U5bOLpjK/DXlcTUyCVL7?=
 =?us-ascii?Q?dLYEo5nTLJtNZ/lKBKGNkjnagTMTnXFpzVc3EqpFFxhyfM2KGjGflk9lLjiK?=
 =?us-ascii?Q?FmT6uYDuXyJbYXMiyMAlpLLH209Sn7m4OtdbVygmsNussDVNj0M5xo2xvPzU?=
 =?us-ascii?Q?qpRqijILpB3M94rsx9w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc009ff-2350-4384-c345-08dab6b4787f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 18:12:26.0384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSZpuW3SOfrDXTumRTM3UcOvLxs2uA3yg3h5UBTqF33aH6dO1oxYHoKKC9LINyBD
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

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 307 ++++++++++++++++++++++++
 drivers/iommu/iommufd/io_pagetable.c    |   7 +-
 drivers/iommu/iommufd/ioas.c            |   2 +
 drivers/iommu/iommufd/iommufd_private.h |   6 +
 drivers/iommu/iommufd/main.c            |   3 +
 include/linux/iommufd.h                 |  42 +++-
 6 files changed, 364 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index b572b01f67b7b5..b4a799b2b41ae3 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -6,6 +6,7 @@
 #include <linux/iommu.h>
 #include <linux/irqdomain.h>
 
+#include "io_pagetable.h"
 #include "iommufd_private.h"
 
 /*
@@ -25,6 +26,15 @@ struct iommufd_device {
 	bool enforce_cache_coherency;
 };
 
+struct iommufd_access {
+	struct iommufd_object obj;
+	struct iommufd_ctx *ictx;
+	struct iommufd_ioas *ioas;
+	const struct iommufd_access_ops *ops;
+	void *data;
+	u32 ioas_access_list_id;
+};
+
 void iommufd_device_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_device *idev =
@@ -397,3 +407,300 @@ void iommufd_device_detach(struct iommufd_device *idev)
 	refcount_dec(&idev->obj.users);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_detach, IOMMUFD);
+
+void iommufd_access_destroy_object(struct iommufd_object *obj)
+{
+	struct iommufd_access *access =
+		container_of(obj, struct iommufd_access, obj);
+
+	WARN_ON(xa_erase(&access->ioas->access_list,
+			 access->ioas_access_list_id) != access);
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
+	obj = iommufd_get_object(ictx, ioas_id, IOMMUFD_OBJ_IOAS);
+	if (IS_ERR(obj)) {
+		rc = PTR_ERR(obj);
+		goto out_abort;
+	}
+	access->ioas = container_of(obj, struct iommufd_ioas, obj);
+	iommufd_put_object_keep_user(obj);
+
+	rc = xa_alloc(&access->ioas->access_list, &access->ioas_access_list_id,
+		      access, xa_limit_16b, GFP_KERNEL_ACCOUNT);
+	if (rc)
+		goto out_put_ioas;
+
+	/* The calling driver is a user until iommufd_access_destroy() */
+	refcount_inc(&access->obj.users);
+	access->ictx = ictx;
+	access->data = data;
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
+ * @iopt - iopt to work on
+ * @iova - Starting iova in the iopt
+ * @length - Number of bytes
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
+	xa_lock(&ioas->access_list);
+	xa_for_each(&ioas->access_list, index, access) {
+		if (!iommufd_lock_obj(&access->obj))
+			continue;
+		xa_unlock(&ioas->access_list);
+
+		access->ops->unmap(access->data, iova, length);
+
+		iommufd_put_object(&access->obj);
+		xa_lock(&ioas->access_list);
+	}
+	xa_unlock(&ioas->access_list);
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
index 27cbb652ee33cd..bc24227100fe22 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -463,6 +463,7 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 	 * is NULL. This prevents domain attach/detatch from running
 	 * concurrently with cleaning up the area.
 	 */
+again:
 	down_read(&iopt->domains_rwsem);
 	down_write(&iopt->iova_rwsem);
 	while ((area = iopt_area_iter_first(iopt, start, end))) {
@@ -491,8 +492,10 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 			area->prevent_access = true;
 			up_write(&iopt->iova_rwsem);
 			up_read(&iopt->domains_rwsem);
-			/* Later patch calls back to drivers to unmap */
-			return -EBUSY;
+			iommufd_access_notify_unmap(iopt, area_first,
+						    iopt_area_length(area));
+			WARN_ON(READ_ONCE(area->num_accesses));
+			goto again;
 		}
 
 		pages = area->pages;
diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index 52ca5776e00b8f..078478a9a7b92f 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -17,6 +17,7 @@ void iommufd_ioas_destroy(struct iommufd_object *obj)
 	rc = iopt_unmap_all(&ioas->iopt, NULL);
 	WARN_ON(rc && rc != -ENOENT);
 	iopt_destroy_table(&ioas->iopt);
+	WARN_ON(!xa_empty(&ioas->access_list));
 	mutex_destroy(&ioas->mutex);
 }
 
@@ -35,6 +36,7 @@ struct iommufd_ioas *iommufd_ioas_alloc(struct iommufd_ctx *ictx)
 
 	INIT_LIST_HEAD(&ioas->hwpt_list);
 	mutex_init(&ioas->mutex);
+	xa_init_flags(&ioas->access_list, XA_FLAGS_ALLOC);
 	return ioas;
 
 out_abort:
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index e982efca161699..5be8983b8524e2 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -64,6 +64,8 @@ int iopt_unmap_iova(struct io_pagetable *iopt, unsigned long iova,
 		    unsigned long length, unsigned long *unmapped);
 int iopt_unmap_all(struct io_pagetable *iopt, unsigned long *unmapped);
 
+void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
+				 unsigned long length);
 int iopt_table_add_domain(struct io_pagetable *iopt,
 			  struct iommu_domain *domain);
 void iopt_table_remove_domain(struct io_pagetable *iopt,
@@ -105,6 +107,7 @@ enum iommufd_object_type {
 	IOMMUFD_OBJ_DEVICE,
 	IOMMUFD_OBJ_HW_PAGETABLE,
 	IOMMUFD_OBJ_IOAS,
+	IOMMUFD_OBJ_ACCESS,
 };
 
 /* Base struct for all objects with a userspace ID handle. */
@@ -195,6 +198,7 @@ struct iommufd_ioas {
 	struct io_pagetable iopt;
 	struct mutex mutex;
 	struct list_head hwpt_list;
+	struct xarray access_list;
 };
 
 static inline struct iommufd_ioas *iommufd_get_ioas(struct iommufd_ucmd *ucmd,
@@ -243,4 +247,6 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
 
 void iommufd_device_destroy(struct iommufd_object *obj);
 
+void iommufd_access_destroy_object(struct iommufd_object *obj);
+
 #endif
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 774c286da04d38..15ffda848741c9 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -352,6 +352,9 @@ void iommufd_ctx_put(struct iommufd_ctx *ictx)
 EXPORT_SYMBOL_NS_GPL(iommufd_ctx_put, IOMMUFD);
 
 static struct iommufd_object_ops iommufd_object_ops[] = {
+	[IOMMUFD_OBJ_ACCESS] = {
+		.destroy = iommufd_access_destroy_object,
+	},
 	[IOMMUFD_OBJ_DEVICE] = {
 		.destroy = iommufd_device_destroy,
 	},
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 31efacd8a46cce..0750df5a7def3e 100644
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
@@ -26,6 +28,10 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id,
 			  unsigned int flags);
 void iommufd_device_detach(struct iommufd_device *idev);
 
+struct iommufd_access_ops {
+	void (*unmap)(void *data, unsigned long iova, unsigned long length);
+};
+
 enum {
 	IOMMUFD_ACCESS_RW_READ = 0,
 	IOMMUFD_ACCESS_RW_WRITE = 1 << 0,
@@ -33,11 +39,24 @@ enum {
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
@@ -47,5 +66,26 @@ static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
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
2.38.0

