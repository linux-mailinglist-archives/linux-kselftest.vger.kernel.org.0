Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2586687627
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Feb 2023 08:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjBBHFs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Feb 2023 02:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjBBHFq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Feb 2023 02:05:46 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE6C83250;
        Wed,  1 Feb 2023 23:05:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYHe7qgfbSsa8cLNmvV2VYvZT5nifnIq9NfHb48eJkm1HqzmUXr3H1ZVOQJ2CVAl1bQOgERyu60u2ykaliIXfBSFZ8FgsedwmJn2oT+sNIfsao4srEt1agvIFyUXB1DjbCY2SXZHCVXmvjyQVaVjIWob/gX7iDAbYuQf/wl1nCXvu3soR1K5LFL44QrlAVZb6u2F0bk+5oVRrLcL96HIbe2ZypFVfh6zQn+W0vuj4I/M58XEZBGYa6ey9U63eL6NokisFqDJo2SvFCM9bfuT/uzknrD4GuGYlAOvl8CRiZ4U1R9o6gZxBMZKwz2mdCkoyRlARS3de7MjFNNqHC4HFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ye1wN8cFHiGTSXUF2sslNCoGjmKybMVGEjFtXax04xs=;
 b=ijn1pKdMgWdFbya52d+U4ytjhF1wlKfChOBwBjsyh7Ifop5yasCDadoEFk9JecJI1lBfi9DXd3/DmJIVHdsopp9OnsHJ8/OrvxPcvE9eiEBERJ9QCJycKoheX4bdzDJlPq3CUAEBKb9KK8uSjoZR0g/22vPpci5AKkjIhUvpEA5zxTSsKwEiXh7620uA+TEjoiBIN3wOn65PffVv7t9q69VAFyLYe6mWBoSaj2dXJDkKJDqJvGB+kt/OOulVgFuN3hiJ9x5zi/HCfvvYkP0ZLMlfoP7jYzfE8N75Uoegfj1DrLLU50luVCuPg9XdQ3JuKEh3dP74GFQZ+T2gSTvUrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ye1wN8cFHiGTSXUF2sslNCoGjmKybMVGEjFtXax04xs=;
 b=bVAx6BLWrhhxdkehfLhWjYlnGAjaN9qb79M3sAjV4WvldTHhLcukvmoTx2qjmPjjFAbOYgyelM7YWDiImZZTbWRRSgeCtE1MnP3FOGud2L2hCPb/5hotq0PdY7Xa0IURD2NDcd09CFwfuyVI05Nu7RN1TZICvMX0xA3FPFkps7B2/qNBxmFvT/l0fWizqdh0u7eNj67N6RJEVALvtTpFKhI32zLTGuf1HNM11UvWBfDFEwfzg0V1iHoFBdgGUqYV5NMpANQPYiWcuJETOrIc6me99i4wdMPScMkhXKdyC8ZR6zmVjhsAMXDl0xcx4oIVV87BA2r0qzvsIzHutT7ZYQ==
Received: from DS7PR03CA0213.namprd03.prod.outlook.com (2603:10b6:5:3ba::8) by
 DM4PR12MB6422.namprd12.prod.outlook.com (2603:10b6:8:b9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.36; Thu, 2 Feb 2023 07:05:32 +0000
Received: from DS1PEPF0000B077.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::9) by DS7PR03CA0213.outlook.office365.com
 (2603:10b6:5:3ba::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24 via Frontend
 Transport; Thu, 2 Feb 2023 07:05:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0000B077.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.17 via Frontend Transport; Thu, 2 Feb 2023 07:05:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 23:05:21 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 23:05:20 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 1 Feb 2023 23:05:20 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <baolu.lu@linux.intel.com>
Subject: [PATCH v1 0/8] Add IO page table replacement support
Date:   Wed, 1 Feb 2023 23:05:04 -0800
Message-ID: <cover.1675320212.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B077:EE_|DM4PR12MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: 88df83b5-0b37-49fd-3701-08db04ebdf99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uFN+QM7PCB7kJ4KasO5/Glnr5zuspnK1Py14XTfcSE8i46Xb2AHYuxQxwqSJzFbGsqTW5TCVXGJXuQxCevvnMfCM1q76n66LaJmNSZbUfjcdrycnEV1XWdthaCzlVKeqb93cge3EdzZJljOCJvGp04s1/VE3v3+tkW1Cx6KxaVHm2ZRO+pm3Dfnaxi5L0wRyFUZsbJ93jiwBj0OHmuc7MQyGJbwHJ7y97y+aNSBAmRh+z9U8rqOTQrV1sua8n6kVf98jMtdZ7IYNqfQeM9ZmnozwFx4J2QU4XXpKuOzhMlLZNRuGiob2RmjzG7GB6gSp+81P6JH86W87sTJU05+DgaSyM3qDVPIIbYIAC2tUOO/I0ArIRmjrDNd5xxsUSPeiXyDJTKLywOor7J2EkU+oCNbfYJHx235D5v2O5qqlt88BbfpQvu0xAClPUfcsbecOLzOse34CYWunuM0T+X1LHR2ymotcjQw3z1jY7o6pZJlJCiyr7DHlgVzFYTNXqcK4Xi+FmhQfBJeHgyiC2n1uRBDyValXKBW603OKPS49bQGvmWHSey9eB83PLn8tXWB2IU5Qgy/hhTkc+94f7Dr/xhJzvsRS7cIpPxXIbZWrcp0kXyPDboK4PT55+iLI4dB5ER/ZLz6gzuFRosO8fa6nBcn3tTBvbrdOed2UMJCMEpYNa9P9WGY+iHRzkaPxVoiyMBXjematZw38UON0QUWOONdEh6Hugk/87I0idoMsFz+2K9fevx2MT/0Q3p/w4KPo2dvrbxRW38d16NOJXaz89vVge+vttryYBFkXCytxs4tL9LdC5+BK6uzkf3gfb0M+sU8tFqmKeG49EZ958sWLcw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199018)(46966006)(40470700004)(36840700001)(41300700001)(47076005)(426003)(83380400001)(54906003)(70586007)(110136005)(316002)(82740400003)(86362001)(36756003)(8936002)(82310400005)(7416002)(40480700001)(356005)(70206006)(8676002)(5660300002)(4326008)(2906002)(36860700001)(7636003)(40460700003)(66899018)(7696005)(478600001)(966005)(186003)(26005)(2616005)(336012)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 07:05:31.6523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88df83b5-0b37-49fd-3701-08db04ebdf99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B077.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6422
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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
1) [PATCH 00/13] Add vfio_device cdev for iommufd support
   https://lore.kernel.org/kvm/20230117134942.101112-1-yi.l.liu@intel.com/
2) (Merged) [PATCH v5 0/5] iommu: Retire detach_dev callback
   https://lore.kernel.org/linux-iommu/20230110025408.667767-1-baolu.lu@linux.intel.com/
3) (Merged) [PATCH] selftests: iommu: Fix test_cmd_destroy_access() call in user_copy
   https://lore.kernel.org/lkml/20230120074204.1368-1-nicolinc@nvidia.com/

Or you can also find this series on Github:
https://github.com/nicolinc/iommufd/commits/iommu_group_replace_domain-v1

Thank you
Nicolin Chen

Nicolin Chen (7):
  iommu: Introduce a new iommu_group_replace_domain() API
  iommufd: Create access in vfio_iommufd_emulated_bind()
  iommufd/selftest: Add IOMMU_TEST_OP_ACCESS_SET_IOAS coverage
  iommufd: Add replace support in iommufd_access_set_ioas()
  iommufd/selftest: Add coverage for access->ioas replacement
  iommufd/device: Use iommu_group_replace_domain()
  vfio-iommufd: Support IO page table replacement

Yi Liu (1):
  iommu: Move dev_iommu_ops() to private header

 drivers/iommu/iommu-priv.h                    |  22 +++
 drivers/iommu/iommu.c                         |  32 ++++
 drivers/iommu/iommufd/device.c                | 150 +++++++++++++++---
 drivers/iommu/iommufd/iommufd_private.h       |   4 +
 drivers/iommu/iommufd/iommufd_test.h          |   4 +
 drivers/iommu/iommufd/selftest.c              |  25 ++-
 drivers/vfio/iommufd.c                        |  33 ++--
 include/linux/iommu.h                         |  11 --
 include/linux/iommufd.h                       |   4 +-
 tools/testing/selftests/iommu/iommufd.c       |  29 +++-
 tools/testing/selftests/iommu/iommufd_utils.h |  22 ++-
 11 files changed, 273 insertions(+), 63 deletions(-)
 create mode 100644 drivers/iommu/iommu-priv.h

-- 
2.39.1

