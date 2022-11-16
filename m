Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EE162CC1F
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 22:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239191AbiKPVDS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 16:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239166AbiKPVCB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 16:02:01 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E6E68C52;
        Wed, 16 Nov 2022 13:01:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KU7wsJg12WvLEe26d8GY7CK7CLyX3VIbtjnfyW1QzxiPmkr4AwGYprmoCD7OxgiAY/vOpTXHZF7918bcoetbNJ+SifFH/tzUKvMUc8G/i4zw1kNebtypJokd3mBg6SIKcBp33Fm2gInWp3mWbDr/NxEWNUl9mB9pnXHdzvxxVJYbCLosOmFaQkRYTgT2I1aXzTovufsOudDPoSO64LG/4jOt7Z+j81b83UV5MEn1WKOo4CCVGbxxIEzg64+rtlO5kcoQvPVLeyBi9aOdn6dVLvG7M0A0Cn+Bhr073TrjoWOrz3rgtINZY69R4pLWtHAlkCyNu67t4hRQR3nTmB61dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjftuR1xiKeY6lr3Rgj186hI5xcRQEn/DV63httbcLU=;
 b=IZySCoWbqxZoIqtIMjGar8G3cQflDwbplyYvP2oTD9Z50ziCydpz81HbnX9Q3NcEOMhy00lz067Q5dZYWn/HcTNhs1VTEvcUp2lt9NPBt5/f1uCLMrrFmoYETzIL7AdjkGdTEakxQDn/GtqEapj0RgrOvS8BsrgHcrCFj+nyjOKXH/m2N9hMR6lvi5ybWmVnhzBq2op3IiutN4szHpqGYcQcKNpbSngFlKiuLf95mET9pOQXUMPoCMDq3qjtZ+SQvczVp2jLzohYYXpu2MsMlmyHqRa48nmH/RbV2Ubv2yP9pKaO3AdCU9ezehJSLZ5MZhy3F8jV26vCAlygiekFNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjftuR1xiKeY6lr3Rgj186hI5xcRQEn/DV63httbcLU=;
 b=DHksl/22iiIJRUEHQkllD4b0GHH9hEIR/0ChykNasR3XCroEIopgoOn48drLae/EII9nxSv6s8ZxcErCBDYPupsCxncG/7Wnj9KX2JGEKOcgpgma/qFwWvdINe9Q+qw7cU9zPKS/t9JMmsU9mr+t48xfh9R3lZlUualXU6pBc28UNRyh6RteTPA13H1uDmFqeW9PHXPxNscZfEIIplTWxtelic/uuUOPQC4saten3ANyr2svFGZ8hvKHnfO2+u9/CWs8E1mqSTxvShTiyqCCoP5P8HBqAFD6LRxjk0hs35hZBj9nNsgYHie7469+tHCGgXRHMcBbRv1LYyh/PcHXZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 21:00:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 21:00:59 +0000
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
Subject: [PATCH v5 14/19] iommufd: Add kAPI toward external drivers for kernel access
Date:   Wed, 16 Nov 2022 17:00:50 -0400
Message-Id: <14-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0110.namprd02.prod.outlook.com
 (2603:10b6:208:35::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 663a3e81-6193-48ba-47ea-08dac815a856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 65xfO3LQK9/vDTRxuBU+/gdEXKhyY8n/69XsCb+wI6zYycbcBYsRdpRcD9W57C4dRNOltGqZvDAjPuOE3rdCIjpOQaMMj7N41q1DGxXxZ3Du7msucJ/eMdoVEAgETEsIzIHl1MJ67G1K3RXWHv74i4l9hPkma12W7DpRaAeaRSH8tjC2VEg7ZU6G+KF11xiOgPU2uHo8YILmij1HyUvdOCbRbR9D918KGJkHJlJnnKR7dyiPvN4GUxouVYskuHSEptx0TYzXaM9m0mg8P/J+kAfMWvPEYOyAZD+/K3oAUOevwVLcc7XilGoNV9I06m4VKv/R/wha3oI1ybVXWCPtdCjLNcYzweU8pyE7Hf1D35t8tQ6ET0B3B7PXV8Cek7MWxCA/Y0sENjV0nvhPmyLc3EgNq9N0FawJRvGZN+Pju5QNCML63wPab7uc9kItYcyqTcpvCYPQkN013ho4IKKZ0Tgbct8yWXWMED0Hk/AEGkVTGE4TsuKRx/qtuMlGvFFiBSixIKC1Q2OZoT/JL9kBFUcio0XoccG7I0JVBP4yn/wcv6u+Jp/IKEOSUXAuNmVSDsIWeHH25SwHwOPFz8w8XXSNleAbX26EnC4Zj2mzpJrmSQC0zpIZYy66wNhQaVBt/nbrEumYl5tRRzYEjWLbYXVLiuBart64x3aBvxSu7iu3lspsn1Tck8vESFTyc8Tqhl8ohFDmiAFXQBoUHYRs20P3LD8btFhcz1ZrFpYvXED6wRh1T/RKA6iGSAmM7i5S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(38100700002)(2616005)(86362001)(921005)(110136005)(7406005)(6666004)(478600001)(6486002)(7416002)(8936002)(66476007)(8676002)(4326008)(54906003)(66556008)(66946007)(316002)(41300700001)(83380400001)(2906002)(6506007)(186003)(5660300002)(30864003)(6512007)(36756003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I6XLChV/JMgBg2cqHIBebl0m6p/dHFEwb74E0iO+x4AHllOJnoKITzOcYAqw?=
 =?us-ascii?Q?FpgJ61scu+PZFdOjXqEV+eMFk3kb685qLr7eKz6+GEq1iWzOIIxQPSFoqyo5?=
 =?us-ascii?Q?/1j7GebusyNnK/Dmi6ZFh6wJWQJton679RUtTU7A/H46ojy9+mNcCE99Oqq+?=
 =?us-ascii?Q?Mcp/t5ewMCsOCP9NYAgLenssKmVisTdP8XlmxMd8dAsWiTMJ8GipF62CNLfm?=
 =?us-ascii?Q?HABLdqM/rGaPBqqVgkL/5nEFf/H2fLQRJK9qsaVcc+ot/dwlYhTWxn8v0LBK?=
 =?us-ascii?Q?j9CkcT2Km5PlOKz1yT8LnswaJRNs1RirVn/GBEs+FfVsl0LqWAXTgyklcMYT?=
 =?us-ascii?Q?8++x4MyoH/EFsv/BijXPccy5DvFX8C/VfbxRRYTnjGoNCaalBCI5z0/tWjEH?=
 =?us-ascii?Q?IrtTIBOmIPn1TPJeiCRtpQ51ARRynWhih14ySFTZt0xreBbN5ef+zXQojG9A?=
 =?us-ascii?Q?yCYCm9qd0FUv0g0GHUVd9NyRpBe4D17r2gKqOBzHyf16BqKrw1HqZsiMIjqE?=
 =?us-ascii?Q?GpS7pAAgdBa+Hs9eZaJiOcz1HDlA1TFXcF3XmSafymtO+id4i0vK+YPGgdwZ?=
 =?us-ascii?Q?9o3IzJ+35FIpsGBPt2UUtYUB0k2aYVWHdqFO0D74xHdWEe7UNlJrHOd3g8Fq?=
 =?us-ascii?Q?ogxqYIL+26i6tDLi/rzefbRC8c5t+ANFLtSk3tdy39OKv74F14y/jXNDUJrU?=
 =?us-ascii?Q?RGFyhiUOPS72UJrb2jNVZd+XVnLDczw/bPuw5/Ll5NcFklxOpA+icGHBlX8E?=
 =?us-ascii?Q?B01tSeSiulrBKphFdokTXyvW+xq4SILOs3h1YrYKYECa1GD6qHNqcPTJF7kK?=
 =?us-ascii?Q?qP/9Pn+tSbJBk+gzcj7+FtoptZEXGHxP7e1FFFPYxEAR/po/uf2iG8VHTZE9?=
 =?us-ascii?Q?y27kuk2sYZ5kEiGdvEf9e1SjP61pAfoPiR2YcUknSBySHGKC6w3tnJe3K0iJ?=
 =?us-ascii?Q?x5/w/1h39NMHW5XuyZ1nSIQ7Ui8UtqQqVzhc1sToN3+qMlT+S4v/j6WG8D+o?=
 =?us-ascii?Q?N4BHkpL+hU/JhFxH70y00tOjc5q8zmCqOm73Cmk0GfNwOD8XxwYAzW914S4D?=
 =?us-ascii?Q?hmJgJScqEtYQVX9Q8zFSJ/uHBczx736k8ITYJy9bRDyol+x3HFtyTuiwKIrX?=
 =?us-ascii?Q?5J7g2F/ufFG8vU4mUdNvnAHcuNSq1PGV+bHMT4clmsjebjGts+JexRdAOeer?=
 =?us-ascii?Q?YwXO1ieGyVAeXGvypWllu0WzncpUXjd9JuX1/+qh9wdGNhoI4I8uTuUOMCVU?=
 =?us-ascii?Q?jUHFhuvOyatVcqaSYXqeya/2CGZ1YifqysqAhyJqx2v7GBcCLUW0cNHlNisX?=
 =?us-ascii?Q?JGeNlB2bZa4J0PPgY2JHn9Mx7jYKEPZXBeM9xl19QeGDaZGFP+GjAu3T4BjR?=
 =?us-ascii?Q?o/8vB8c9IuBlNhGcRQAOzTN3lHSbKgLkEwpxi/QG7oLh1pFi8Lii1TaiLI6Y?=
 =?us-ascii?Q?hWk0HiB3nSZC18Kg1sCKiyXmOpqw1XHMqgL7f+Qh9MbYcEKStkw+fjHVoGwe?=
 =?us-ascii?Q?QKAF5g5Km8SZfC7hoMXjbyEgZqhz7xi0htZjnK+5DGlnXWuHxb4SCQGvpILX?=
 =?us-ascii?Q?xBq3MS1G5wl82r52w+w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 663a3e81-6193-48ba-47ea-08dac815a856
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:00:57.3890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSqOPR7LiIxkyGKcWzRV++r/TklOyVu07iKgw3ZCeP4zDoIXoTjX/4fCYIF8Roin
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
Tested-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Lixiao Yang <lixiao.yang@intel.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 314 ++++++++++++++++++++++++
 drivers/iommu/iommufd/io_pagetable.c    |   8 +-
 drivers/iommu/iommufd/iommufd_private.h |  10 +
 drivers/iommu/iommufd/main.c            |   3 +
 include/linux/iommufd.h                 |  43 +++-
 5 files changed, 375 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index a71f5740773f84..522469ae7b5770 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -6,6 +6,7 @@
 #include <linux/iommu.h>
 #include <linux/irqdomain.h>
 
+#include "io_pagetable.h"
 #include "iommufd_private.h"
 
 /*
@@ -415,3 +416,316 @@ void iommufd_device_detach(struct iommufd_device *idev)
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
+/**
+ * iommufd_access_create - Create an iommufd_access
+ * @ictx: iommufd file descriptor
+ * @ioas_id: ID for a IOMMUFD_OBJ_IOAS
+ * @ops: Driver's ops to associate with the access
+ * @data: Opaque data to pass into ops functions
+ *
+ * An iommufd_access allows a driver to read/write to the IOAS without using
+ * DMA. The underlying CPU memory can be accessed using the
+ * iommufd_access_pin_pages() or iommufd_access_rw() functions.
+ *
+ * The provided ops are required to use iommufd_access_pin_pages().
+ */
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
+	access->ictx = ictx;
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
+/**
+ * iommufd_access_destroy - Destroy an iommufd_access
+ * @access: The access to destroy
+ *
+ * The caller must stop using the access before destroying it.
+ */
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
+		iopt_area_remove_access(
+			area, iopt_area_iova_to_index(area, iter.cur_iova),
+			iopt_area_iova_to_index(
+				area,
+				min(last_iova, iopt_area_last_iova(area))));
+	up_read(&iopt->iova_rwsem);
+	WARN_ON(!iopt_area_contig_done(&iter));
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_access_unpin_pages, IOMMUFD);
+
+static bool iopt_area_contig_is_aligned(struct iopt_area_contig_iter *iter)
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
+		    !iopt_area_contig_is_aligned(&iter)) {
+			rc = -EINVAL;
+			goto err_remove;
+		}
+
+		if (!check_area_prot(area, flags)) {
+			rc = -EPERM;
+			goto err_remove;
+		}
+
+		rc = iopt_area_add_access(area, index, last_index, out_pages,
+					  flags);
+		if (rc)
+			goto err_remove;
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
+			iopt_area_remove_access(
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
index 756d347948f0ec..4f4a9d9aac570e 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -458,6 +458,7 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 	 * is NULL. This prevents domain attach/detatch from running
 	 * concurrently with cleaning up the area.
 	 */
+again:
 	down_read(&iopt->domains_rwsem);
 	down_write(&iopt->iova_rwsem);
 	while ((area = iopt_area_iter_first(iopt, start, last))) {
@@ -486,8 +487,11 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
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
index 73345886d969e5..e1653b2276dac9 100644
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

