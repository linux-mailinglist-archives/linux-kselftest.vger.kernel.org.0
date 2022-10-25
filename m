Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BE960D341
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Oct 2022 20:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbiJYSMw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 14:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiJYSMu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 14:12:50 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DC3B7F7F;
        Tue, 25 Oct 2022 11:12:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9rmiW2fTApMXv3zdl3L/VQr2st1VGVqHBvUerJFRd+LxLHEtpHSpagUAeEKAyYmbv3UCWXOLRLpR0k2ogiX1v4oeBVD4C73ey+xX5OIQgORB8Abl0evh3LBGjFuwmg1sD64zUEnZ/q5zfRcG67nfEYQzxxlky/LwpRjRdFam681NGWUeqMXEvLohsUo7Nvc+uIyXLcfwJm11ntNrAxbBIAzbgd6TfUBL5ELzKb9r/9IfTCvrYYz6rFdoilAg/xtdhTH7WD2jXxDodzet64LrVmYaLOcjHm1/07kTXV067o384oeSNrqC2DJp1kjrnecAsf+KHTqvbS/76U0haVzXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Jg9NRQNra0YzTmGiKEIHYK60jhdzknUuUARAKQFdTs=;
 b=cIEzJu8XBshsNNzyRzpdIKxBH1aI1DDlUiuwc1utB4hKP3MnQdwZLXqneog+zddo/SWKsTl94R8gtRSjMrmIiacbzrXWTldo7zgty7JgzoxE4dXfBUchEkbgtbPUNWXek6yMa1Q9eYN3qE62ht4AnueK5l1S3jQBF7SeC5ttEDOBCn4ccN07HVH+P7xhVzan3oovna83I0yAMi6WWXfPnCgxNhNoLnv7VcaBR2JGnfI4GqmTbmG1T7iiErLJsxzCc2TeC9QpG1oskYLMKnECXdD8RhKGqVXpQGUePPa2ahBFTqjIyCMzPm6J+VnhbSk/cKQC3DOKkKlV5u8yyBgSmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Jg9NRQNra0YzTmGiKEIHYK60jhdzknUuUARAKQFdTs=;
 b=Ohtfn4iVZNgL330kz3/O7ciyty8GctA4FlDSQhx9LhYZFIp64P3Ol/m+8QX/aXhtm9KlBYwfZazAfWKeX7G3K3vIkcYL+IaMle9TyInmvW9Zt5fI44y7CuRJHN/1F8LnMb315qQY+8ey03bx7JDPXm1mpPwHaGPShyK7Nti+s3tTbZboB+iMPoQ4qoMUJtLgm3ju/R790aJWHCAOjdkPnrcmZp2Dr7oqe3bXf6R8BOSQk7UvaqzqIO7JqtSB1YPYVTrMAhjbOZKL5wufb3nkh38exw0/OfduD4C0zKQVuOmkyZVdSUc22HK+GpHZEUSavKgQmElUUEMCs78PgvvLwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 18:12:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 18:12:32 +0000
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
Subject: [PATCH v3 14/15] iommufd: vfio container FD ioctl compatibility
Date:   Tue, 25 Oct 2022 15:12:23 -0300
Message-Id: <14-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0395.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL0PR12MB5506:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec4cbc8-d820-408b-c260-08dab6b47970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4pcd2XPbnK1H9Xjm4HN993F63IGLvzDo+fySM9yCVHXz1WMCuf+S/jcM5f6Uyqk9uE8LNibX+Zlv5zHskerKMNxIUVsB9WTfUjD1ui4YtqLmj04CXlHsheta6XwhhEdYCP+KrgPuXxdu8dbay97W6/RmaU95DOxBtT6kI9ziRJy3vK5a+kNpNEMu/lMJVPiOOF3A+5I4lUYt8g3lsgqhTPMqtTnuK+jBRc+7GLU2oilGBsuy/5u63j3xT5vpnpYDp3V/TWlj0fD3Zo9H1MqVHMqJB/CQt/MJ75qBSmbKZ+J6uC3KPbSx8UEOtiJuj8GOfGuvI5XexOLmZyGDJDs3Y9Qp+Xi+IFkZSyKc0P+a1NjgGQmuzLb4Nh/dxFOO5GgvE34Kx/eKeTBQ7OpUyuyCduf/wFLpSHXV/ReevN5tS9/CXWUbY5CPpceUcPCbuTutpk1BF4IgJ86eLE7QCvHqWVZ9FD1O7i1AqzrwPZ2Z96j3XEhxRLIYtS8fgLyeC8qE988thsSoIzU1XKSykJGfe/FQzoa04z6bq2p0eIltSYYLgRk2mzzOG7AgDn42QjIsOf8DBjmXX5iO11b9MczOSCheCdHijrhp48aVXdzqVaQGCpM2280S9Dw1onQ/Mg7U1VtWQSN6RE/sHuJYzrTKHiVhVpdjLZ5lla26GyH9hgMYBgSdnCw0dvlHjAsjrzEomo13zIxwR34lOsWa3fRMOzeQDl+tCy7fSf7i7lB8g9vpr7I/1cqCEpkyqAliuw02ZoHdKZGcTm1kYvutPdgXXVxj66acdATssJmKK8kVYxjYL8E9ZeYQC26MP5uJs6KLFcIKQhJRMLLdTVxQInyCvH1YGebB9G3xqsy7bpNMh2iwz9U8bYyWae+7+7AOKa/i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199015)(7406005)(7416002)(41300700001)(5660300002)(8936002)(66476007)(6506007)(110136005)(66946007)(36756003)(4326008)(8676002)(6512007)(66556008)(6666004)(316002)(26005)(2616005)(921005)(38100700002)(186003)(2906002)(54906003)(30864003)(86362001)(83380400001)(966005)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aWJeJLnTRfYKvd7Gv0GOZ6h8Kox2PtH4q+izedaS1+D1LsQOVCc/L2Fiq2mq?=
 =?us-ascii?Q?ntVuKUSPjWbIdRr410FJoi5XgFm9HMxTTfd5M2oTOpJFfDKzouDG11gUGyLE?=
 =?us-ascii?Q?kw4N2HkOjeLrHa+J1FGerL+f7LrD/GTJNnUJ/3siT/5NvRHYxUaMALEUaEed?=
 =?us-ascii?Q?J1jGtR4B4mrzNFU9ULidroeewUajQYIMWqvBNm+zpb/VjZ3k5oX/e/86uuTu?=
 =?us-ascii?Q?GJSbXqLW/2wagaW/OR54QmKbpKAFtSOLazna3n8kqi1K9FrVkJ/QFi4abKeB?=
 =?us-ascii?Q?heFOTcNywR3LPDHSlPAaviZv0zTYHZeVvMiweb6X141OOjgiK5hs2/1ODR9n?=
 =?us-ascii?Q?lzF+MVu/WBs6BBbcPnf3hhkHrE+oZbqdUy/DapWcs1IymoFbJxYw3zq4GksL?=
 =?us-ascii?Q?7JFPkOniokbcg0zEymkXEihdmweNAIeXEANf+6ytgZHfz4N/ybSMnjZH2ZqH?=
 =?us-ascii?Q?jSjQPB8ffWwk5Y14QKTQUHIhJgrltSk/6evHgjg0qJiqdlIHzMmuE7gYTnaN?=
 =?us-ascii?Q?I7IUGaEeu/r0u2uGzlqSbZUnMwfi62Qfptvoj39dQlA/Lkn13rVSPhLNuVLk?=
 =?us-ascii?Q?ol5rYK94DqUtHubTMhbIW4OpA93x1c1Ha8O15klT8J4lUi9yNmMS8K5yKOh6?=
 =?us-ascii?Q?9jBvF5Eu+S4d8RtmscuVAWsY66ANHuP9Zc9Nc5Ijy3icz5hgAU3xbAw2xLo6?=
 =?us-ascii?Q?RcYRbzZaJVAt9uxduLwV+KfBJi/V2yIJNatOW3r5Fogc3aI2+MKHYdSwPofj?=
 =?us-ascii?Q?amP8/Rgrxz2CG+MOX8TyZ8U3coQUxZAUTHZyxLWUaeLVFaaqSpOpfpjOgTdN?=
 =?us-ascii?Q?326ETh01JIXK3w445qPeP6C9ue5j6VhGvYStCPGFMyWVrIkYkaoLU7SaRqmv?=
 =?us-ascii?Q?ys+i6be+cRqpM8UNLU24IGwUQwXNU/WpCYp2CencuJhjCTWv9xx1A/BtXfaW?=
 =?us-ascii?Q?k0TNbwjoHVbtP6J50NEuL4iM4RwEgobacdg/hvYunQ83IkbDgQ98BatUkuVp?=
 =?us-ascii?Q?RZbB846BJoSxEmPAUrdxJtGeTRkRc2EvPZcJXWWCzwL73SwAKwfZ8tA2CiXh?=
 =?us-ascii?Q?ZnON4uPuW+pOz/kK0P6AH1EeHV0vqM0UUei97K45faUL9z6QFLM9orSuwRAw?=
 =?us-ascii?Q?AT2q6aDadOFZ/ONaAYZBdSoK/uen1oF78mDDpx/QvnyVVyuv5kZrogXoAJZS?=
 =?us-ascii?Q?dzXnxbxa1tQeevN+vd/w3Vnd1fBo6c7e1oD8f4H4Oaz4pQwckyiew7o1eL3Q?=
 =?us-ascii?Q?pnf7kTzSwzHTbf+15kR0HX8h1aA82PzcShPATGNPP1zGwejkFIjADLDyb3Va?=
 =?us-ascii?Q?4nxZ9j+9aOPjVAECojBFsU6V7obPA5xljnBSnC6RTbxfyb9cibJ4bKemDpdP?=
 =?us-ascii?Q?s9BNls1x+QA3UJv2Tl6qs1UVZpOjvD+mmdA79UD/UnoL6D/A2fNUcoi+Edy/?=
 =?us-ascii?Q?YCt3uN9nA6+eWNohOudz9xIc8DWCFghJxJHk/FDlCAYWBLNBC2+JCD9JxbeL?=
 =?us-ascii?Q?9q9jI/ESM4sOlToVS41uF84f7NmMF7HWI4+W/TyIQSG5FhDhkjA5S+F9MU46?=
 =?us-ascii?Q?uL8yhAwQixa/Qu3Kyx0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec4cbc8-d820-408b-c260-08dab6b47970
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 18:12:27.6022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFgx2nsSRd6vkwampKysC9V/LmAa6Vqk4iRd4mr6NpF/x2Ikc5/cIAzUeg8HFTlw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5506
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

iommufd can directly implement the /dev/vfio/vfio container IOCTLs by
mapping them into io_pagetable operations.

A userspace application can test against iommufd and confirm compatibility
then simply make a small change to open /dev/iommu instead of
/dev/vfio/vfio.

For testing purposes /dev/vfio/vfio can be symlinked to /dev/iommu and
then all applications will use the compatibility path with no code
changes. A later series allows /dev/vfio/vfio to be directly provided by
iommufd, which allows the rlimit mode to work the same as well.

This series just provides the iommufd side of compatibility. Actually
linking this to VFIO_SET_CONTAINER is a followup series, with a link in
the cover letter.

Internally the compatibility API uses a normal IOAS object that, like
vfio, is automatically allocated when the first device is
attached.

Userspace can also query or set this IOAS object directly using the
IOMMU_VFIO_IOAS ioctl. This allows mixing and matching new iommufd only
features while still using the VFIO style map/unmap ioctls.

While this is enough to operate qemu, it has a few differences:

 - Resource limits rely on memory cgroups to bound what userspace can do
   instead of the module parameter dma_entry_limit.

 - VFIO P2P is not implemented. The DMABUF patches for vfio are a start at
   a solution where iommufd would import a special DMABUF. This is to avoid
   further propogating the follow_pfn() security problem.

 - A full audit for pedantic compatibility details (eg errnos, etc) has
   not yet been done

 - powerpc SPAPR is left out, as it is not connected to the iommu_domain
   framework. It seems interest in SPAPR is minimal as it is currently
   non-working in v6.1-rc1. They will have to convert to the iommu
   subsystem framework to enjoy iommfd.

The following are not going to be implemented and we expect to remove them
from VFIO type1:

 - SW access 'dirty tracking'. As discussed in the cover letter this will
   be done in VFIO.

 - VFIO_TYPE1_NESTING_IOMMU
    https://lore.kernel.org/all/0-v1-0093c9b0e345+19-vfio_no_nesting_jgg@nvidia.com/

 - VFIO_DMA_MAP_FLAG_VADDR
    https://lore.kernel.org/all/Yz777bJZjTyLrHEQ@nvidia.com/

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/Makefile          |   3 +-
 drivers/iommu/iommufd/iommufd_private.h |   6 +
 drivers/iommu/iommufd/main.c            |  16 +-
 drivers/iommu/iommufd/vfio_compat.c     | 443 ++++++++++++++++++++++++
 include/linux/iommufd.h                 |   7 +
 include/uapi/linux/iommufd.h            |  36 ++
 6 files changed, 505 insertions(+), 6 deletions(-)
 create mode 100644 drivers/iommu/iommufd/vfio_compat.c

diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
index ca28a135b9675f..2fdff04000b326 100644
--- a/drivers/iommu/iommufd/Makefile
+++ b/drivers/iommu/iommufd/Makefile
@@ -5,6 +5,7 @@ iommufd-y := \
 	io_pagetable.o \
 	ioas.o \
 	main.o \
-	pages.o
+	pages.o \
+	vfio_compat.o
 
 obj-$(CONFIG_IOMMUFD) += iommufd.o
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 5be8983b8524e2..87fd127ca5843a 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -18,6 +18,7 @@ struct iommufd_ctx {
 	struct xarray objects;
 
 	u8 account_mode;
+	struct iommufd_ioas *vfio_ioas;
 };
 
 /*
@@ -91,6 +92,9 @@ struct iommufd_ucmd {
 	void *cmd;
 };
 
+int iommufd_vfio_ioctl(struct iommufd_ctx *ictx, unsigned int cmd,
+		       unsigned long arg);
+
 /* Copy the response in ucmd->cmd back to userspace. */
 static inline int iommufd_ucmd_respond(struct iommufd_ucmd *ucmd,
 				       size_t cmd_len)
@@ -221,6 +225,8 @@ int iommufd_ioas_option(struct iommufd_ucmd *ucmd);
 int iommufd_option_rlimit_mode(struct iommu_option *cmd,
 			       struct iommufd_ctx *ictx);
 
+int iommufd_vfio_ioas(struct iommufd_ucmd *ucmd);
+
 /*
  * A HW pagetable is called an iommu_domain inside the kernel. This user object
  * allows directly creating and inspecting the domains. Domains that have kernel
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 15ffda848741c9..dc19723d5832a5 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -134,6 +134,8 @@ bool iommufd_object_destroy_user(struct iommufd_ctx *ictx,
 		return false;
 	}
 	__xa_erase(&ictx->objects, obj->id);
+	if (ictx->vfio_ioas && &ictx->vfio_ioas->obj == obj)
+		ictx->vfio_ioas = NULL;
 	xa_unlock(&ictx->objects);
 	up_write(&obj->destroy_rwsem);
 
@@ -266,27 +268,31 @@ static struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 length),
 	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct iommu_option,
 		 val64),
+	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct iommu_vfio_ioas,
+		 __reserved),
 };
 
 static long iommufd_fops_ioctl(struct file *filp, unsigned int cmd,
 			       unsigned long arg)
 {
+	struct iommufd_ctx *ictx = filp->private_data;
 	struct iommufd_ucmd ucmd = {};
 	struct iommufd_ioctl_op *op;
 	union ucmd_buffer buf;
 	unsigned int nr;
 	int ret;
 
-	ucmd.ictx = filp->private_data;
+	nr = _IOC_NR(cmd);
+	if (nr < IOMMUFD_CMD_BASE ||
+	    (nr - IOMMUFD_CMD_BASE) >= ARRAY_SIZE(iommufd_ioctl_ops))
+		return iommufd_vfio_ioctl(ictx, cmd, arg);
+
+	ucmd.ictx = ictx;
 	ucmd.ubuffer = (void __user *)arg;
 	ret = get_user(ucmd.user_size, (u32 __user *)ucmd.ubuffer);
 	if (ret)
 		return ret;
 
-	nr = _IOC_NR(cmd);
-	if (nr < IOMMUFD_CMD_BASE ||
-	    (nr - IOMMUFD_CMD_BASE) >= ARRAY_SIZE(iommufd_ioctl_ops))
-		return -ENOIOCTLCMD;
 	op = &iommufd_ioctl_ops[nr - IOMMUFD_CMD_BASE];
 	if (op->ioctl_num != cmd)
 		return -ENOIOCTLCMD;
diff --git a/drivers/iommu/iommufd/vfio_compat.c b/drivers/iommu/iommufd/vfio_compat.c
new file mode 100644
index 00000000000000..4566c754856aed
--- /dev/null
+++ b/drivers/iommu/iommufd/vfio_compat.c
@@ -0,0 +1,443 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
+ */
+#include <linux/file.h>
+#include <linux/interval_tree.h>
+#include <linux/iommu.h>
+#include <linux/iommufd.h>
+#include <linux/slab.h>
+#include <linux/vfio.h>
+#include <uapi/linux/vfio.h>
+#include <uapi/linux/iommufd.h>
+
+#include "iommufd_private.h"
+
+static struct iommufd_ioas *get_compat_ioas(struct iommufd_ctx *ictx)
+{
+	struct iommufd_ioas *ioas = ERR_PTR(-ENODEV);
+
+	xa_lock(&ictx->objects);
+	if (!ictx->vfio_ioas || !iommufd_lock_obj(&ictx->vfio_ioas->obj))
+		goto out_unlock;
+	ioas = ictx->vfio_ioas;
+out_unlock:
+	xa_unlock(&ictx->objects);
+	return ioas;
+}
+
+/**
+ * iommufd_vfio_compat_ioas_id - Return the IOAS ID that vfio should use
+ * @ictx - Context to operate on
+ *
+ * The compatibility IOAS is the IOAS that the vfio compatibility ioctls operate
+ * on since they do not have an IOAS ID input in their ABI. Only attaching a
+ * group should cause a default creation of the internal ioas, this returns the
+ * existing ioas if it has already been assigned somehow.
+ */
+int iommufd_vfio_compat_ioas_id(struct iommufd_ctx *ictx, u32 *out_ioas_id)
+{
+	struct iommufd_ioas *ioas = NULL;
+	struct iommufd_ioas *out_ioas;
+
+	ioas = iommufd_ioas_alloc(ictx);
+	if (IS_ERR(ioas))
+		return PTR_ERR(ioas);
+
+	xa_lock(&ictx->objects);
+	if (ictx->vfio_ioas && iommufd_lock_obj(&ictx->vfio_ioas->obj))
+		out_ioas = ictx->vfio_ioas;
+	else {
+		out_ioas = ioas;
+		ictx->vfio_ioas = ioas;
+	}
+	xa_unlock(&ictx->objects);
+
+	*out_ioas_id = out_ioas->obj.id;
+	if (out_ioas != ioas) {
+		iommufd_put_object(&out_ioas->obj);
+		iommufd_object_abort(ictx, &ioas->obj);
+		return 0;
+	}
+	iommufd_object_finalize(ictx, &ioas->obj);
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_vfio_compat_ioas_id, IOMMUFD_VFIO);
+
+int iommufd_vfio_ioas(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_vfio_ioas *cmd = ucmd->cmd;
+	struct iommufd_ioas *ioas;
+
+	if (cmd->__reserved)
+		return -EOPNOTSUPP;
+	switch (cmd->op) {
+	case IOMMU_VFIO_IOAS_GET:
+		ioas = get_compat_ioas(ucmd->ictx);
+		if (IS_ERR(ioas))
+			return PTR_ERR(ioas);
+		cmd->ioas_id = ioas->obj.id;
+		iommufd_put_object(&ioas->obj);
+		return iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+
+	case IOMMU_VFIO_IOAS_SET:
+		ioas = iommufd_get_ioas(ucmd, cmd->ioas_id);
+		if (IS_ERR(ioas))
+			return PTR_ERR(ioas);
+		xa_lock(&ucmd->ictx->objects);
+		ucmd->ictx->vfio_ioas = ioas;
+		xa_unlock(&ucmd->ictx->objects);
+		iommufd_put_object(&ioas->obj);
+		return 0;
+
+	case IOMMU_VFIO_IOAS_CLEAR:
+		xa_lock(&ucmd->ictx->objects);
+		ucmd->ictx->vfio_ioas = NULL;
+		xa_unlock(&ucmd->ictx->objects);
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int iommufd_vfio_map_dma(struct iommufd_ctx *ictx, unsigned int cmd,
+				void __user *arg)
+{
+	u32 supported_flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE;
+	size_t minsz = offsetofend(struct vfio_iommu_type1_dma_map, size);
+	struct vfio_iommu_type1_dma_map map;
+	int iommu_prot = IOMMU_CACHE;
+	struct iommufd_ioas *ioas;
+	unsigned long iova;
+	int rc;
+
+	if (copy_from_user(&map, arg, minsz))
+		return -EFAULT;
+
+	if (map.argsz < minsz || map.flags & ~supported_flags)
+		return -EINVAL;
+
+	if (map.flags & VFIO_DMA_MAP_FLAG_READ)
+		iommu_prot |= IOMMU_READ;
+	if (map.flags & VFIO_DMA_MAP_FLAG_WRITE)
+		iommu_prot |= IOMMU_WRITE;
+
+	ioas = get_compat_ioas(ictx);
+	if (IS_ERR(ioas))
+		return PTR_ERR(ioas);
+
+	/*
+	 * Maps created through the legacy interface always use VFIO compatible
+	 * rlimit accounting. If the user wishes to use the faster user based
+	 * rlimit accounting then they must use the new interface.
+	 */
+	iova = map.iova;
+	rc = iopt_map_user_pages(ictx, &ioas->iopt, &iova, u64_to_user_ptr(map.vaddr),
+				 map.size, iommu_prot, 0);
+	iommufd_put_object(&ioas->obj);
+	return rc;
+}
+
+static int iommufd_vfio_unmap_dma(struct iommufd_ctx *ictx, unsigned int cmd,
+				  void __user *arg)
+{
+	size_t minsz = offsetofend(struct vfio_iommu_type1_dma_unmap, size);
+	/*
+	 * VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP is obsoleted by the new
+	 * dirty tracking direction:
+	 *  https://lore.kernel.org/kvm/20220731125503.142683-1-yishaih@nvidia.com/
+	 *  https://lore.kernel.org/kvm/20220428210933.3583-1-joao.m.martins@oracle.com/
+	 */
+	u32 supported_flags = VFIO_DMA_UNMAP_FLAG_ALL;
+	struct vfio_iommu_type1_dma_unmap unmap;
+	struct iommufd_ioas *ioas;
+	unsigned long unmapped;
+	int rc;
+
+	if (copy_from_user(&unmap, arg, minsz))
+		return -EFAULT;
+
+	if (unmap.argsz < minsz || unmap.flags & ~supported_flags)
+		return -EINVAL;
+
+	ioas = get_compat_ioas(ictx);
+	if (IS_ERR(ioas))
+		return PTR_ERR(ioas);
+
+	if (unmap.flags & VFIO_DMA_UNMAP_FLAG_ALL) {
+		if (unmap.iova != 0 || unmap.size != 0) {
+			rc = -EINVAL;
+			goto err_put;
+		}
+		rc = iopt_unmap_all(&ioas->iopt, &unmapped);
+	} else {
+		if (READ_ONCE(ioas->iopt.disable_large_pages)) {
+			unsigned long iovas[] = { unmap.iova + unmap.size - 1,
+						  unmap.iova - 1 };
+
+			rc = iopt_cut_iova(&ioas->iopt, iovas,
+					   unmap.iova ? 2 : 1);
+			if (rc)
+				goto err_put;
+		}
+		rc = iopt_unmap_iova(&ioas->iopt, unmap.iova, unmap.size,
+				     &unmapped);
+	}
+	unmap.size = unmapped;
+	if (copy_to_user(arg, &unmap, minsz))
+		rc = -EFAULT;
+
+err_put:
+	iommufd_put_object(&ioas->obj);
+	return rc;
+}
+
+static int iommufd_vfio_cc_iommu(struct iommufd_ctx *ictx)
+{
+	struct iommufd_hw_pagetable *hwpt;
+	struct iommufd_ioas *ioas;
+	int rc = 1;
+
+	ioas = get_compat_ioas(ictx);
+	if (IS_ERR(ioas))
+		return PTR_ERR(ioas);
+
+	mutex_lock(&ioas->mutex);
+	list_for_each_entry(hwpt, &ioas->hwpt_list, hwpt_item) {
+		if (!hwpt->enforce_cache_coherency) {
+			rc = 0;
+			break;
+		}
+	}
+	mutex_unlock(&ioas->mutex);
+
+	iommufd_put_object(&ioas->obj);
+	return rc;
+}
+
+static int iommufd_vfio_check_extension(struct iommufd_ctx *ictx,
+					unsigned long type)
+{
+	switch (type) {
+	case VFIO_TYPE1_IOMMU:
+	case VFIO_TYPE1v2_IOMMU:
+	case VFIO_UNMAP_ALL:
+		return 1;
+
+	case VFIO_DMA_CC_IOMMU:
+		return iommufd_vfio_cc_iommu(ictx);
+
+	/*
+	 * This is obsolete, and to be removed from VFIO. It was an incomplete
+	 * idea that got merged.
+	 * https://lore.kernel.org/kvm/0-v1-0093c9b0e345+19-vfio_no_nesting_jgg@nvidia.com/
+	 */
+	case VFIO_TYPE1_NESTING_IOMMU:
+		return 0;
+
+	/*
+	 * VFIO_DMA_MAP_FLAG_VADDR
+	 * https://lore.kernel.org/kvm/1611939252-7240-1-git-send-email-steven.sistare@oracle.com/
+	 * https://lore.kernel.org/all/Yz777bJZjTyLrHEQ@nvidia.com/
+	 *
+	 * It is hard to see how this could be implemented safely.
+	 */
+	case VFIO_UPDATE_VADDR:
+	default:
+		return 0;
+	}
+}
+
+static int iommufd_vfio_set_iommu(struct iommufd_ctx *ictx, unsigned long type)
+{
+	struct iommufd_ioas *ioas = NULL;
+	int rc = 0;
+
+	if (type != VFIO_TYPE1_IOMMU && type != VFIO_TYPE1v2_IOMMU)
+		return -EINVAL;
+
+	/* VFIO fails the set_iommu if there is no group */
+	ioas = get_compat_ioas(ictx);
+	if (IS_ERR(ioas))
+		return PTR_ERR(ioas);
+	if (type == VFIO_TYPE1_IOMMU)
+		rc = iopt_disable_large_pages(&ioas->iopt);
+	iommufd_put_object(&ioas->obj);
+	return rc;
+}
+
+static unsigned long iommufd_get_pagesizes(struct iommufd_ioas *ioas)
+{
+	struct io_pagetable *iopt = &ioas->iopt;
+	unsigned long pgsize_bitmap = ULONG_MAX;
+	struct iommu_domain *domain;
+	unsigned long index;
+
+	down_read(&iopt->domains_rwsem);
+	xa_for_each(&iopt->domains, index, domain)
+		pgsize_bitmap &= domain->pgsize_bitmap;
+
+	/* See vfio_update_pgsize_bitmap() */
+        if (pgsize_bitmap & ~PAGE_MASK) {
+                pgsize_bitmap &= PAGE_MASK;
+                pgsize_bitmap |= PAGE_SIZE;
+        }
+	pgsize_bitmap = max(pgsize_bitmap, ioas->iopt.iova_alignment);
+	up_read(&iopt->domains_rwsem);
+	return pgsize_bitmap;
+}
+
+static int iommufd_fill_cap_iova(struct iommufd_ioas *ioas,
+				 struct vfio_info_cap_header __user *cur,
+				 size_t avail)
+{
+	struct vfio_iommu_type1_info_cap_iova_range __user *ucap_iovas =
+		container_of(cur,
+			     struct vfio_iommu_type1_info_cap_iova_range __user,
+			     header);
+	struct vfio_iommu_type1_info_cap_iova_range cap_iovas = {
+		.header = {
+			.id = VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE,
+			.version = 1,
+		},
+	};
+	struct interval_tree_span_iter span;
+
+	interval_tree_for_each_span(&span, &ioas->iopt.reserved_itree, 0,
+				    ULONG_MAX) {
+		struct vfio_iova_range range;
+
+		if (!span.is_hole)
+			continue;
+		range.start = span.start_hole;
+		range.end = span.last_hole;
+		if (avail >= struct_size(&cap_iovas, iova_ranges,
+					 cap_iovas.nr_iovas + 1) &&
+		    copy_to_user(&ucap_iovas->iova_ranges[cap_iovas.nr_iovas],
+				 &range, sizeof(range)))
+			return -EFAULT;
+		cap_iovas.nr_iovas++;
+	}
+	if (avail >= struct_size(&cap_iovas, iova_ranges, cap_iovas.nr_iovas) &&
+	    copy_to_user(ucap_iovas, &cap_iovas, sizeof(cap_iovas)))
+		return -EFAULT;
+	return struct_size(&cap_iovas, iova_ranges, cap_iovas.nr_iovas);
+}
+
+static int iommufd_fill_cap_dma_avail(struct iommufd_ioas *ioas,
+				      struct vfio_info_cap_header __user *cur,
+				      size_t avail)
+{
+	struct vfio_iommu_type1_info_dma_avail cap_dma = {
+		.header = {
+			.id = VFIO_IOMMU_TYPE1_INFO_DMA_AVAIL,
+			.version = 1,
+		},
+		/* iommufd has no limit, return the same value as VFIO. */
+		.avail = U16_MAX,
+	};
+
+	if (avail >= sizeof(cap_dma) &&
+	    copy_to_user(cur, &cap_dma, sizeof(cap_dma)))
+		return -EFAULT;
+	return sizeof(cap_dma);
+}
+
+static int iommufd_vfio_iommu_get_info(struct iommufd_ctx *ictx,
+				       void __user *arg)
+{
+	typedef int (*fill_cap_fn)(struct iommufd_ioas *ioas,
+				   struct vfio_info_cap_header __user *cur,
+				   size_t avail);
+	static const fill_cap_fn fill_fns[] = {
+		iommufd_fill_cap_iova,
+		iommufd_fill_cap_dma_avail,
+	};
+	size_t minsz = offsetofend(struct vfio_iommu_type1_info, iova_pgsizes);
+	struct vfio_info_cap_header __user *last_cap = NULL;
+	struct vfio_iommu_type1_info info;
+	struct iommufd_ioas *ioas;
+	size_t total_cap_size;
+	int rc;
+	int i;
+
+	if (copy_from_user(&info, arg, minsz))
+		return -EFAULT;
+
+	if (info.argsz < minsz)
+		return -EINVAL;
+	minsz = min_t(size_t, info.argsz, sizeof(info));
+
+	ioas = get_compat_ioas(ictx);
+	if (IS_ERR(ioas))
+		return PTR_ERR(ioas);
+
+	down_read(&ioas->iopt.iova_rwsem);
+	info.flags = VFIO_IOMMU_INFO_PGSIZES;
+	info.iova_pgsizes = iommufd_get_pagesizes(ioas);
+	info.cap_offset = 0;
+
+	total_cap_size = sizeof(info);
+	for (i = 0; i != ARRAY_SIZE(fill_fns); i++) {
+		int cap_size;
+
+		if (info.argsz > total_cap_size)
+			cap_size = fill_fns[i](ioas, arg + total_cap_size,
+					       info.argsz - total_cap_size);
+		else
+			cap_size = fill_fns[i](ioas, NULL, 0);
+		if (cap_size < 0) {
+			rc = cap_size;
+			goto out_put;
+		}
+		if (last_cap && info.argsz >= total_cap_size &&
+		    put_user(total_cap_size, &last_cap->next)) {
+			rc = -EFAULT;
+			goto out_put;
+		}
+		last_cap = arg + total_cap_size;
+		total_cap_size += cap_size;
+	}
+
+	/*
+	 * If the user did not provide enough space then only some caps are
+	 * returned and the argsz will be updated to the correct amount to get
+	 * all caps.
+	 */
+	if (info.argsz >= total_cap_size)
+		info.cap_offset = sizeof(info);
+	info.argsz = total_cap_size;
+	info.flags |= VFIO_IOMMU_INFO_CAPS;
+	if (copy_to_user(arg, &info, minsz))
+		rc = -EFAULT;
+	rc = 0;
+
+out_put:
+	up_read(&ioas->iopt.iova_rwsem);
+	iommufd_put_object(&ioas->obj);
+	return rc;
+}
+
+int iommufd_vfio_ioctl(struct iommufd_ctx *ictx, unsigned int cmd,
+		       unsigned long arg)
+{
+	void __user *uarg = (void __user *)arg;
+
+	switch (cmd) {
+	case VFIO_GET_API_VERSION:
+		return VFIO_API_VERSION;
+	case VFIO_SET_IOMMU:
+		return iommufd_vfio_set_iommu(ictx, arg);
+	case VFIO_CHECK_EXTENSION:
+		return iommufd_vfio_check_extension(ictx, arg);
+	case VFIO_IOMMU_GET_INFO:
+		return iommufd_vfio_iommu_get_info(ictx, uarg);
+	case VFIO_IOMMU_MAP_DMA:
+		return iommufd_vfio_map_dma(ictx, cmd, uarg);
+	case VFIO_IOMMU_UNMAP_DMA:
+		return iommufd_vfio_unmap_dma(ictx, cmd, uarg);
+	case VFIO_IOMMU_DIRTY_PAGES:
+	default:
+		return -ENOIOCTLCMD;
+	}
+	return -ENOIOCTLCMD;
+}
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 0750df5a7def3e..3598292df937d5 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -57,6 +57,7 @@ void iommufd_access_unpin_pages(struct iommufd_access *access,
 				unsigned long iova, unsigned long length);
 int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 		      void *data, size_t len, unsigned int flags);
+int iommufd_vfio_compat_ioas_id(struct iommufd_ctx *ictx, u32 *out_ioas_id);
 #else /* !CONFIG_IOMMUFD */
 static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
 {
@@ -87,5 +88,11 @@ static inline int iommufd_access_rw(struct iommufd_access *access, unsigned long
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int iommufd_vfio_compat_ioas_id(struct iommufd_ctx *ictx,
+					      u32 *out_ioas_id)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_IOMMUFD */
 #endif
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 06608cecbe19e6..fbfc8799881a6d 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -44,6 +44,7 @@ enum {
 	IOMMUFD_CMD_IOAS_MAP,
 	IOMMUFD_CMD_IOAS_UNMAP,
 	IOMMUFD_CMD_OPTION,
+	IOMMUFD_CMD_VFIO_IOAS,
 };
 
 /**
@@ -291,4 +292,39 @@ struct iommu_option {
 	__aligned_u64 val64;
 };
 #define IOMMU_OPTION _IO(IOMMUFD_TYPE, IOMMUFD_CMD_OPTION)
+
+/**
+ * enum iommufd_vfio_ioas_op
+ * @IOMMU_VFIO_IOAS_GET: Get the current compatibility IOAS
+ * @IOMMU_VFIO_IOAS_SET: Change the current compatibility IOAS
+ * @IOMMU_VFIO_IOAS_CLEAR: Disable VFIO compatibility
+ */
+enum iommufd_vfio_ioas_op {
+	IOMMU_VFIO_IOAS_GET = 0,
+	IOMMU_VFIO_IOAS_SET = 1,
+	IOMMU_VFIO_IOAS_CLEAR = 2,
+};
+
+/**
+ * struct iommu_vfio_ioas - ioctl(IOMMU_VFIO_IOAS)
+ * @size: sizeof(struct iommu_vfio_ioas)
+ * @ioas_id: For IOMMU_VFIO_IOAS_SET the input IOAS ID to set
+ *           For IOMMU_VFIO_IOAS_GET will output the IOAS ID
+ * @op: One of enum iommufd_vfio_ioas_op
+ * @__reserved: Must be 0
+ *
+ * The VFIO compatibility support uses a single ioas because VFIO APIs do not
+ * support the ID field. Set or Get the IOAS that VFIO compatibility will use.
+ * When VFIO_GROUP_SET_CONTAINER is used on an iommufd it will get the
+ * compatibility ioas, either by taking what is already set, or auto creating
+ * one. From then on VFIO will continue to use that ioas and is not effected by
+ * this ioctl. SET or CLEAR does not destroy any auto-created IOAS.
+ */
+struct iommu_vfio_ioas {
+	__u32 size;
+	__u32 ioas_id;
+	__u16 op;
+	__u16 __reserved;
+};
+#define IOMMU_VFIO_IOAS _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VFIO_IOAS)
 #endif
-- 
2.38.0

