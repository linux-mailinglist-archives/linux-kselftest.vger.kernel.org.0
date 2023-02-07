Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA72B68E2C0
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 22:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjBGVUe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 16:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjBGVUc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 16:20:32 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABA217175;
        Tue,  7 Feb 2023 13:20:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEOvPPuZijKc8kKAqtyF3H/N59ckNRtV4yzC+tD4uAcDYuv8HOJtYdtiBmvCOYh675Ivn/O8vg0lUx3Wotle7h5PlIdJJ3gjiE+0WglSH8FoF4sLuPY/y7vPPd8AA2ojfn/+HpGuHC2Urj0db5MKLrg4uWrp7wP6kPRL8E0lOmMvKRC1e+t7wzZXWW5rJscUjjhL5HE9e6bHb/j3Ah3sSjSm0yaey/LN/edjHJxJTNg2gaRM+DRqri8UYoK31OUJHN2rE1BFKX+T4SgB2YOJB5qp8EUv5m1ukcTnbIJmwhoPZIn0qPZS7oZXFjC9lwbF76GgoOcTaCZxOhdOLMTfiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAQQSrKPvcPPwcRqS72ReAZHtW03Jxz+EexB1I0z+O0=;
 b=Ze8NfsEHUdEtPk9MpQii4J0kw17mzDrqe1lR+fu0d6REdKbdkeLgLozgeZb3lYbdgplWCMQRKr7REwQWoJJsPFj1hYqqTRwdvBcn9Sz+suhA8ZMcgX8XrfdapI+ayG48Sof/ceNsf5lQC9aHHwgYL98XFjpGRsDFilPpEBRsX8N9xULtkXvno0JXlclTjT2TzmREFHik4OArffR+FQY7d/s/kIRoQiYIZ7+Zd0WwxCvXSlqAtoseywg4hUEwQaYsOm8PVAI8AWRxdGvSkrBZcJt6WzuAub5ayBf/xVE+14hREtDgFrl3WSyz5EgpbBYh6ig2377LhHWM6pwwi88Ddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAQQSrKPvcPPwcRqS72ReAZHtW03Jxz+EexB1I0z+O0=;
 b=MvwOf8XbN3Fk9++fPGpzl3n2DSt2Dew0lrRI7bdb7dK1kpSxH3AJ1jhtUD3m69P5KI94KyUxtFrOwLXxLoh73sGafB3ycFSGJvqVBo1n9IH4EelwO6YHaAxFZjbv+Rn4ilRPcCEFdvxsjKU/kjSQvzhAKYTZGtUbQp7kRuNjguBJHWbdx6GSH96WujdqEVBmdz2nzlWyLxcIR6zmPrwMFqAYrO4QY5XEwDGyPa4X7V88Y1A6eOfI3aULc52W5DvLg2gm7hMtw5ZK8+D5mWlGa/AHGb4mAPHDars7oTMa3jc0kg1QHgQkoLctl8CMWhVN09Ju1IRNLu3IIkEwVyBjWg==
Received: from DM6PR04CA0016.namprd04.prod.outlook.com (2603:10b6:5:334::21)
 by CH0PR12MB8505.namprd12.prod.outlook.com (2603:10b6:610:193::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 21:20:27 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::bd) by DM6PR04CA0016.outlook.office365.com
 (2603:10b6:5:334::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Tue, 7 Feb 2023 21:20:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.17 via Frontend Transport; Tue, 7 Feb 2023 21:20:27 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 7 Feb 2023
 13:20:19 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 13:20:18 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Tue, 7 Feb 2023 13:20:18 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v2 00/10] Add IO page table replacement support
Date:   Tue, 7 Feb 2023 13:17:52 -0800
Message-ID: <cover.1675802050.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|CH0PR12MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: 8febe473-9fd5-4dcc-7fc9-08db0951226c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: blKk6/qnOhEdY6ww0N9WnCWH6zLQY/cEYt27+MW5bOcUuajJf4IlbjUDQX4szc/C91nL1spswtQIPSpDFkT42DkqssDZgLr3432KbY0YWN5VQHGgo5sCNus1Cl6uADtqYRDCJumBYsyR46pvSB4P47HhzuT2Qs4YNXON690iUMLfFA15Y2GWVRUqCJCnEKKQGpJtHDgErA53SJobhs9toSDHekusjrmKvWRbNcYZnYX6HCu3bMjIQEAD07gGyXIsEHWULhzFsAuVpkikyU8z5B5nRo1hkr+fr5VRvFqUrBKoBU9AVTUWChATtUvKszF8MAtBB+nPdKvQS8wpkgxmGElqCjYK9bzi4T2fdojFRdtSk1qmzMZvMcRngqo1ZBNXqnchA4HKd9B/965mE1Nn1pWcZe6582jR5maiUnaabGYupYu5vvf2cTOEmTd9fuig1SZHHxEPSGHAKLyVVyWn1cHO8t90/Z4RWLyEfDRgGrvjj9r+gayeENpHM5JFXgRZiaEctoiA0/zamYDcMFKCn934XJGbSW5qD+fA2Dfo+ketU9+qpqIgfCYLB7VbjJBV3b0l7Sa4FaWrko7rL56ere0f72ot30SZUQxl6zQEXH/FFwS3kT92OI1VyxujTOVFpBlm2j2OcPJMhkLbihxjVbpKwF0QW4SeJaLN/BpCZBkcP0MgFi0O3mmTWQQ4U1zvWBuwJvfodKL82o1geGcwDrkCXXP+cQPF/f5/zkSDsZaZIQCqEV09qbnltxdHdLwKx5V7vdCLbWa4FskWZhAycegBFWeAJ0IqH6+aJD7Gi1VG1bS2nbO2SMsZXPFGXRnLO7O3+gFOwiDsikj0ASh+Hw==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199018)(36840700001)(40470700004)(46966006)(86362001)(82740400003)(356005)(7636003)(36756003)(36860700001)(82310400005)(5660300002)(70586007)(41300700001)(316002)(8936002)(4326008)(70206006)(54906003)(110136005)(8676002)(40480700001)(2906002)(40460700003)(426003)(7416002)(83380400001)(336012)(2616005)(47076005)(966005)(478600001)(6666004)(26005)(186003)(7696005)(66899018);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 21:20:27.6187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8febe473-9fd5-4dcc-7fc9-08db0951226c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8505
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changelog
v1->v2:
 * Rebased on top of vfio_device cdev v2 series.
 * Update the kdoc and commit message of iommu_group_replace_domain().
 * Dropped revert-to-core-domain part in iommu_group_replace_domain().
 * Dropped !ops->dma_unmap check in vfio_iommufd_emulated_attach_ioas().
 * Added missing rc value in vfio_iommufd_emulated_attach_ioas() from the
   iommufd_access_set_ioas() call.
 * Added a new patch in vfio_main to deny vfio_pin/unpin_pages() calls if
   vdev->ops->dma_unmap is not implemented.
 * Added a __iommmufd_device_detach helper and let the replace routine do
   a partial detach().
 * Added restriction on auto_domains to use the replace feature.
 * Added the patch "iommufd/device: Make hwpt_list list_add/del symmetric"
   from the has_group removal series.

Hi all,

The existing IOMMU APIs provide a pair of functions: iommu_attach_group()
for callers to attach a device from the default_domain (NULL if not being
supported) to a given iommu domain, and iommu_detach_group() for callers
to detach a device from a given domain to the default_domain. Internally,
the detach_dev op is deprecated for the newer drivers with default_domain.
This means that those drivers likely can switch an attaching domain to
another one, without stagging the device at a blocking or default domain,
for use cases such as:
1) vPASID mode, when a guest wants to replace a single pasid (PASID=0)
   table with a larger table (PASID=N)
2) Nesting mode, when switching the attaching device from an S2 domain
   to an S1 domain, or when switching between relevant S1 domains.

This series introduces a new iommu_group_replace_domain() for that. And
add corresponding support throughout the uAPI. So user space can do such
a REPLACE ioctl reusing the existing VFIO_DEVICE_ATTACH_IOMMUFD_PT. This
means that user space needs to be aware whether the device is attached or
not: an unattached device calling VFIO_DEVICE_ATTACH_IOMMUFD_PT means a
regular ATTACH; an attached device calling VFIO_DEVICE_ATTACH_IOMMUFD_PT
on the other hand means a REPLACE.

QEMU with this feature should have the vIOMMU maintain a cache of the
guest io page table addresses and assign a unique IOAS to each unique
guest page table.

As the guest writes the page table address to the HW registers qemu should
then use the 'replace domain' operation on VFIO to assign the VFIO device
to the correct de-duplicated page table.

The algorithm where QEMU uses one VFIO container per-device and removes
all the mappings to change the assignment should ideally not be used with
iommufd.

To apply this series, please rebase on top of the following patches:
1) [PATCH v2 00/14] Add vfio_device cdev for iommufd support
   https://lore.kernel.org/kvm/20230206090532.95598-1-yi.l.liu@intel.com/

Or you can also find this series on Github:
https://github.com/nicolinc/iommufd/commits/iommu_group_replace_domain-v2

Thank you
Nicolin Chen

Nicolin Chen (9):
  iommu: Introduce a new iommu_group_replace_domain() API
  iommufd: Create access in vfio_iommufd_emulated_bind()
  iommufd/selftest: Add IOMMU_TEST_OP_ACCESS_SET_IOAS coverage
  iommufd: Add replace support in iommufd_access_set_ioas()
  iommufd/selftest: Add coverage for access->ioas replacement
  iommufd/device: Make hwpt_list list_add/del symmetric
  iommufd/device: Use iommu_group_replace_domain()
  vfio: Support IO page table replacement
  vfio: Do not allow !ops->dma_unmap in vfio_pin/unpin_pages()

Yi Liu (1):
  iommu: Move dev_iommu_ops() to private header

 drivers/iommu/iommu-priv.h                    |  22 ++
 drivers/iommu/iommu.c                         |  30 +++
 drivers/iommu/iommufd/device.c                | 221 +++++++++++++-----
 drivers/iommu/iommufd/iommufd_private.h       |   4 +
 drivers/iommu/iommufd/iommufd_test.h          |   4 +
 drivers/iommu/iommufd/selftest.c              |  25 +-
 drivers/vfio/iommufd.c                        |  30 ++-
 drivers/vfio/vfio_main.c                      |   4 +
 include/linux/iommu.h                         |  11 -
 include/linux/iommufd.h                       |   3 +-
 include/uapi/linux/vfio.h                     |   6 +
 tools/testing/selftests/iommu/iommufd.c       |  29 ++-
 tools/testing/selftests/iommu/iommufd_utils.h |  22 +-
 13 files changed, 321 insertions(+), 90 deletions(-)
 create mode 100644 drivers/iommu/iommu-priv.h

-- 
2.39.1

