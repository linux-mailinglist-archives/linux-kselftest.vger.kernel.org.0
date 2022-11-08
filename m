Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BAB620500
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 01:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbiKHAtZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 19:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbiKHAtV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 19:49:21 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C231FCD6;
        Mon,  7 Nov 2022 16:49:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUMegDzMNkP/vVaan057Q9rArK0es9+SO10EbEpVk6WYhP/CQ6TN8dIQ/gXIWox1Ipxqh162uwOa5eBrW8y15X2bNPEuCJxXVPxqy7RkD/p9t4SNwebxBbj00SaMnuSgzZ14BLtnefTIgfufQZHI93gvDht1jDPvDb9HHbfm4YHnF+JQUMclVBepCnRqHPyhsMS/r7sgl0dzpHMNEZdxwGssvph5t/c13U9mx/7sHfc5G44IHuCUEy8WWJNpk0Q9kY5A84sexAWMYLT7Ah+crqeIQ0/lRM9T7vaLOu8YrId8/R5S+9LjccjtyMrqNV+qCJH1RgUYVNeYqn0Xhf99zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erhNTT36cVHP9qVPvlSR5bLnah50gaVzviiQpk3hf2A=;
 b=DQAA+JawYbEKhWXqGx3NeJUxRdetidT1H9uEEv5p7ORk8LWDWRp3lGfSsS4rHtrXjb1eoLricpDeAlCptQ2RBuefAuscCj22n4Df3Cla5rwhZ4E5dyRJ8yXF726z7YuZwg8saGC+S/czIa+OkkvlsPQsXtlDeNpg58oGDUcSdvSQXMCd6KKOB8Xhkz4O4xLyCBQQ7RZz6V/RZDrbqLSS0s+abhfhBzyZWhBagAr0iLVyux5o+XmI7X3TJxIkjfmWCNCs4szgeI2kowi3VqvaX+zx/0WtdyU8enY5uN4LFWnMDBfYZO6x6QbPLwqUJfVYCx+hyCrkDydr2cL67ecOew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erhNTT36cVHP9qVPvlSR5bLnah50gaVzviiQpk3hf2A=;
 b=TqXjV5V9mLNAzxR7e38KUUoGu+xNEkvQHMiMn0aLOT+qySQ/FXrFEDH//H5mO2FjgDwRA9aapvyatf6U4MdGLQ+SVKcLYa2gtjmM1DY92wZJbHEXBrUEGvbd1X6jwGH3XuKB2QkMlNmuDeIDv2nzL9VcQqIbCehjnrhMl3cjIkBe0Vo/Eg3u0CVoqsWANwGvwkWHY4B7rZDmYxfwnQ/hrXpW8FgFFyFc+cwVjGblaSpzLaYWl+17BJvWHushV+k56MaLymfBObLp3leyEZigPY3kBIZUUPb6wFe5xN7EMl3uk1RqS4x1+zY2VTCDbV9ShCg2Ya6xFLzQCFJvYKJ9jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 00:49:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 00:49:15 +0000
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
Subject: [PATCH v4 14/17] iommufd: vfio container FD ioctl compatibility
Date:   Mon,  7 Nov 2022 20:49:07 -0400
Message-Id: <14-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:207:3c::38) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: b7138042-3a14-4c21-3456-08dac1230d13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2jH1Se4pAuRiRDCHm1gtVY2SVgoCwlK+iEvZV/m4/XIXIWi6+ispqPn64T5aPgvdTNDtLExK3YgJp/uy1my4J306hNtWM13A+hDdhUP+aeei27+RBoR9xLU2ZnT4BbN+t/KwTkuf9HDKBJ+IBltYhbb205eAOBac7HFK5G52cYHm3xzc5vR2G8CeHW8NrhxONT18X0YPEr4wqzA/F7dOfPaCFMJ7tI7kC9jT0fRPssO9p9AeQ6h1EvMRbTkhPTk0waBg3yatUQcHTo6tzmuAWV5fF2ZuB1tP7JDSVP/QEGUMv8oaHGOx6PXbbNuJWNe/IPOjDsPzz689MlEkbYFciRoRTdi9MJo7tcE+s91ZP36E+TLgXyxd2fBjpmfPGSYLCqf3nZjBMtdGhPPnbcg1Ii0cB91eCmb4mG57UsRYIhYPrhV7OUrj3tc/2nnm7q80BEIe1mFogLR+ygPFuYBo8BhNyE7ebgudcjN0sB+Kyl0PgX4DrGKZwCmAQi9yRFG10AZpfJK6MpY22ZP5yk459ReA/3aaL8VYVOHmaBmp/bjIohv7oYF6ihrRq4xGqlexyjXQMI8fvjLtYNRQmmKgIRSuLdHbq7lVcIktK06LbneUsUpNvDxEjufVHjjNbS+Rmz11pF0pBKkb3rPk/tO70SqO8cb45ovDKi6p6xybsF5/YpHtlYzPpu28q7AHrgAYuHDAoidylkBIH7I1cOmg7XMEmQlRwHx1AZ6XX9iy7F6kCAqRDAD9xZkRuR1KEB382qvUa+qwAXjfl5bp6KpVjfJfj3F7i9oQHN/3mNZssh8VWkkgCj+btr6Z+dnXrZa0KzvuYG9yQuUrlCNjETW9OiNpTg16vtYBymWugh22ImPrY1z22iKJtJRpADzYc0lm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199015)(30864003)(8676002)(54906003)(110136005)(66476007)(8936002)(7416002)(5660300002)(7406005)(2906002)(38100700002)(316002)(66946007)(41300700001)(66556008)(4326008)(186003)(2616005)(83380400001)(966005)(6486002)(478600001)(6512007)(26005)(6666004)(6506007)(86362001)(921005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0wGcrElyWbfUAdk8pD1I4F6tKlwNT5yS3ZrfLduCqLuoTCJcx7K8NDylpFYM?=
 =?us-ascii?Q?WeMYg8L0qBmbEWmMhh8hNkUBIUBTTTqVKkdCvq4UFZDCeqNP9pm5X3p7q70s?=
 =?us-ascii?Q?KFNkYbNu0lMj4brjYwPzGy/7WcVMXbIvjD/HJAnelXZ2TVv1/tY/zFV0nISJ?=
 =?us-ascii?Q?umPwCmpAOlcwl6+UElLNzgx2C0v0CEHD4Sa7DnLpjFrU7bVcf0llXzFSKcjh?=
 =?us-ascii?Q?GVTRXiuBla4rXTBAMLNs5b+mzND+ZVbpykQAb2vbk4RyIytYB3usnHfdtAYZ?=
 =?us-ascii?Q?XjAr19BxhY+ybly2gMvTYQxae5H+A5VmgdnX9y2EIZaK/Jx8145qQcmircf3?=
 =?us-ascii?Q?+Qo5I6Vy3FVRP0qO60EydQtf/JY1MX82l/0mcKGAaywdpzYrvhsofwNjliXT?=
 =?us-ascii?Q?MFAU8pImNnwWcSsOTabcDAPNE6DFDanhNNDm9WQWLvgwBcSdKP5tk11Dgmg8?=
 =?us-ascii?Q?4rq9ELLXIXUIRg2o5kXLF+nsSSP2FfEtBougqEJ4afx0QIvQNRkAiWj4kMyp?=
 =?us-ascii?Q?UcW9qyfHPGm13VgftYi9cXWhYDhQwSSqowkcc7rtQrkjTuAg+EnPXIoz893l?=
 =?us-ascii?Q?3ApSzSr1yQC0ywgm50ROM3HVEaU5LaceTpqk+0+GjvC/l5p3beO/nAxCrEJu?=
 =?us-ascii?Q?7vCtJMqn75Z2WXooxCHqPTxVFd+eMmqiNcqnkXWMrrdYAUUtxjWOEVIzmi7s?=
 =?us-ascii?Q?EIW53UKl315MB8UQy6MmlLCdnytee9Cc+QnJkL7r5P7h7fNiblF6xBqfPN2I?=
 =?us-ascii?Q?d24cI2WcAyHW+B32eU+59Ppx4LMReGGsZkDfb5nnVwibDUA2DWm70+4MJSUJ?=
 =?us-ascii?Q?9LNeSjFmLYFYy9Qy9cm41Bpv9NU3nonJZdSPbuFoVD4i6zuaj8FitQijmW7T?=
 =?us-ascii?Q?0jV01Jtmm7gEl8LZ3cOoVwNtqij4Wlnxy3KiTRGm5j0Z4mPNJnlBNaUML+ZX?=
 =?us-ascii?Q?esu2GtviDgKjxQZlt6oSRCoRc4IWEW4Il0G6hx2gyYJXY1VTilBKFl0dLOUW?=
 =?us-ascii?Q?4ZTKIUCIb1+dHEbxBzhjmVvAhsVBF3UF8Xiqg4Y5F+dG+HlfxN0/bHLaUmZB?=
 =?us-ascii?Q?toXmlo9QMeTMXIiEbEItz0tA5Q3T2dC/Pn51+ONnZ15twRu08tIA9BxpzG7X?=
 =?us-ascii?Q?8elQ5nEJmRpLISS798UHsehOiO3QeVX3u+Qzaei7vPuYfZizwlHA694SJCk9?=
 =?us-ascii?Q?sLWv3g5cqLYsnEPQzVshgJ+pqb3Ah2vHPDXT3nXfky7tubLrt7WKD/f0BLtG?=
 =?us-ascii?Q?3mfUShDwlafJJs+/K2UPHc50rtGQpnFhPS8SvJrrmq9+LcH8ZVGHVeQ5+O7K?=
 =?us-ascii?Q?U0pjzrsaxcbEwoGapZb9FtVcHgEa1FiNhEjCl9sOI1/FehqOLuBlYgvptQ6y?=
 =?us-ascii?Q?40Y61CDgCX+HE5Vc+SVq1+Zx3I+vSRNHOAOGpqENy/nMiWjqWgnoEBza+eIZ?=
 =?us-ascii?Q?KDoS+mSlycUlwvFR4gQqkOcVYGn7P5Ww3b1I5u8dr0tXGh/wwJ1SgdFK1FXU?=
 =?us-ascii?Q?ikGZcOd7j/h54bjbsdWm8JxeX98FLvFcXUKkzo0i5gUE4XwgMIcZmosP616F?=
 =?us-ascii?Q?nvGVlTaI4q2bQdgQmpA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7138042-3a14-4c21-3456-08dac1230d13
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 00:49:11.6224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0sw0q6Xn6dxfAOVpzhYVDO11Lqt6l7xj1HQuTBYWr4TVl6eWF7v6iBRYGoUpbRa
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

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/Makefile          |   3 +-
 drivers/iommu/iommufd/iommufd_private.h |   6 +
 drivers/iommu/iommufd/main.c            |  16 +-
 drivers/iommu/iommufd/vfio_compat.c     | 452 ++++++++++++++++++++++++
 include/linux/iommufd.h                 |   7 +
 include/uapi/linux/iommufd.h            |  36 ++
 6 files changed, 514 insertions(+), 6 deletions(-)
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
index d7d606d459d4c8..5bb9788fc5aef1 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -18,6 +18,7 @@ struct iommufd_ctx {
 	struct xarray objects;
 
 	u8 account_mode;
+	struct iommufd_ioas *vfio_ioas;
 };
 
 /*
@@ -92,6 +93,9 @@ struct iommufd_ucmd {
 	void *cmd;
 };
 
+int iommufd_vfio_ioctl(struct iommufd_ctx *ictx, unsigned int cmd,
+		       unsigned long arg);
+
 /* Copy the response in ucmd->cmd back to userspace. */
 static inline int iommufd_ucmd_respond(struct iommufd_ucmd *ucmd,
 				       size_t cmd_len)
@@ -222,6 +226,8 @@ int iommufd_ioas_option(struct iommufd_ucmd *ucmd);
 int iommufd_option_rlimit_mode(struct iommu_option *cmd,
 			       struct iommufd_ctx *ictx);
 
+int iommufd_vfio_ioas(struct iommufd_ucmd *ucmd);
+
 /*
  * A HW pagetable is called an iommu_domain inside the kernel. This user object
  * allows directly creating and inspecting the domains. Domains that have kernel
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index c8cc0953dea13a..f76b2c8dcde8e5 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -133,6 +133,8 @@ bool iommufd_object_destroy_user(struct iommufd_ctx *ictx,
 		return false;
 	}
 	__xa_erase(&ictx->objects, obj->id);
+	if (ictx->vfio_ioas && &ictx->vfio_ioas->obj == obj)
+		ictx->vfio_ioas = NULL;
 	xa_unlock(&ictx->objects);
 	up_write(&obj->destroy_rwsem);
 
@@ -266,27 +268,31 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
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
 	const struct iommufd_ioctl_op *op;
 	struct iommufd_ucmd ucmd = {};
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
index 00000000000000..dbef3274803336
--- /dev/null
+++ b/drivers/iommu/iommufd/vfio_compat.c
@@ -0,0 +1,452 @@
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
+ * @ictx: Context to operate on
+ * @out_ioas_id: The ioas_id the caller should use
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
+	/*
+	 * An automatically created compat IOAS is treated as a userspace
+	 * created object. Userspace can learn the ID via IOMMU_VFIO_IOAS_GET,
+	 * and if not manually destroyed it will be destroyed automatically
+	 * at iommufd release.
+	 */
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
+	if (pgsize_bitmap & ~PAGE_MASK) {
+		pgsize_bitmap &= PAGE_MASK;
+		pgsize_bitmap |= PAGE_SIZE;
+	}
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
+		iommufd_fill_cap_dma_avail,
+		iommufd_fill_cap_iova,
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
+	info.flags = VFIO_IOMMU_INFO_PGSIZES;
+	info.iova_pgsizes = iommufd_get_pagesizes(ioas);
+	info.cap_offset = 0;
+
+	down_read(&ioas->iopt.iova_rwsem);
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
+	if (copy_to_user(arg, &info, minsz)) {
+		rc = -EFAULT;
+		goto out_put;
+	}
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
index fb9a4c275cca86..d57b044acca4cb 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -58,6 +58,7 @@ void iommufd_access_unpin_pages(struct iommufd_access *access,
 				unsigned long iova, unsigned long length);
 int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 		      void *data, size_t len, unsigned int flags);
+int iommufd_vfio_compat_ioas_id(struct iommufd_ctx *ictx, u32 *out_ioas_id);
 #else /* !CONFIG_IOMMUFD */
 static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
 {
@@ -88,5 +89,11 @@ static inline int iommufd_access_rw(struct iommufd_access *access, unsigned long
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
index a872a50d800a41..c7109d7e5e09a9 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -44,6 +44,7 @@ enum {
 	IOMMUFD_CMD_IOAS_MAP,
 	IOMMUFD_CMD_IOAS_UNMAP,
 	IOMMUFD_CMD_OPTION,
+	IOMMUFD_CMD_VFIO_IOAS,
 };
 
 /**
@@ -293,4 +294,39 @@ struct iommu_option {
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
2.38.1

