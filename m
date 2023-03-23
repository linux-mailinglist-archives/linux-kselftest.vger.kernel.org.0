Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DB56C61C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 09:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjCWIeH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 04:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjCWIdw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 04:33:52 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0CF49D1;
        Thu, 23 Mar 2023 01:33:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQ9r4/tE7DqV+uYgzGvTwkZG04w5yZdmhCb8cAzfvZRygUHr6cYSoWbl4kzQ4A9pSNTFBG0LCH1jkb8vpi9KNlrBKNFEmfYTmwjgUUUci1Cw6I6XZf052lF6GJHczORi2uPAed9hKWBNrMKYfssyckmGrgupnZ56Nuz28I8KNpY2W5/YcuOUF0/ob03nWWlcYP8r8m3j4136Sdt2ZZy7+Q1bD+FjKr7t6Caeow1BgoipfLkjpa8Rhc8MZLIoZGuLpVsFheGagLYVG3wm1zGd0zGpGNKtpj46ih9PTvg1qDYBc2MjrBNgGPIEMz8grG0tAdA4NMs1dEV80qbjb1KmZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtBi/jtx/KpnB4MrTZ/CvpLfTQ2Oz6+k512U7C6ios4=;
 b=fZilF2pgkpWLZfGG0v72A2cegEjQUzXzDZqv3yZ4yY5Qfbl5pH20op6JQZXxn5kVrD2Bp5qj58fs9eytDlQmfJJz405cYDVO4QA929tKSgJGqwgGLdNfzpm/fw8HGOzbit79HaCpeoIyCpBfEknZiWDfwWiXmdKnwMPCrEPTYu7jG2uHrn+wC5K6Ul5bze6sfCPRKamj1731k1RJ3ZATGoQt9BUylMvrnSexkKN3HDCxTlVFb3BgJlGs+RLBZqluEz0DRKomqLGJDYssYvWAcrj41DtkmWa6xdrjU8Qbjd1fp7B3OHjGcrWu45yqIkJx8228pLP/FTFUTv2jFY3b8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtBi/jtx/KpnB4MrTZ/CvpLfTQ2Oz6+k512U7C6ios4=;
 b=DISbUo2RCtE+Q8h85bhJ7SZn0EO5RI7N1VnqM+ZdZbe9O1EPhFAVxPc+cgXk9KsK4HFRsoXXY9wBDM+yIUeFcPhgnQaMdQ/aN5XEQFFneLIy/7ft7H/qPMLY0hr5u7U4pwGVKBxy8Nc3wKYQrlylwvSzJdoOrp41v8CynqrnLH3/aJx5b9vSoFMNKC/rXrueqkQlT656QtlfWbbaOE/Okt0FZBKlVX0ovnsevq09r9K3h/1FC0DvnQX7wCvgkaK0nABpGEJles2z6gds06aZKskEdG0bgV6R+1S3xGNoypLjlRMuY2tP/HNfpOhXLSDxuiFhjpe2FHD7S9CWtnym7g==
Received: from BN0PR04CA0014.namprd04.prod.outlook.com (2603:10b6:408:ee::19)
 by BL3PR12MB6474.namprd12.prod.outlook.com (2603:10b6:208:3ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Thu, 23 Mar
 2023 08:33:39 +0000
Received: from BL02EPF000108E9.namprd05.prod.outlook.com
 (2603:10b6:408:ee:cafe::de) by BN0PR04CA0014.outlook.office365.com
 (2603:10b6:408:ee::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 08:33:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000108E9.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 23 Mar 2023 08:33:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 23 Mar 2023
 01:33:23 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 23 Mar
 2023 01:33:23 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Thu, 23 Mar 2023 01:33:22 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <jgg@nvidia.com>, <kevin.tian@intel.com>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <alex.williamson@redhat.com>, <shuah@kernel.org>
CC:     <yi.l.liu@intel.com>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <farman@linux.ibm.com>
Subject: [PATCH v5 0/4] cover-letter: Add IO page table replacement support
Date:   Thu, 23 Mar 2023 01:33:01 -0700
Message-ID: <cover.1679559476.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E9:EE_|BL3PR12MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e5ec9e-d6bc-4d90-c7c9-08db2b794d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aUEveUyTldzucnRwTdLzuxcV8vUyMyo6KGsuk7uFbA8wTTGD4t21UR3AYERdnU+alt+fIiG4ce7K9sgnpVZ8wE+boZz3cATUuhYOgCZFsmdxfAwGbw3P62sdJ/6y8GAXCloq6tr7Jvji8QNfq2/BIG25EOgLGcEPumTLCD1ukON7A3rNhLjANIViO4BG0F/7o7F6TAm2mtzGzAGmkZpfH1eMftDPpTo+OQi15MMBScCNE9tzs+32Cd/UaWw2qWeEQRB1s9iU55h9OpuvlGsoDB00NWIDG5qE5yzohTEcLiGdw1uDN580FrnQM05rHRNAsi+22k7rQisITXfqzxSnlBmVwuvY9cPj4MyUE4OwQuZdVScVRVFnPLJDxNHrYTvlYq+FIaChKmIXHVT3oawek14nQpm0DCRXS1o+3LXfz/5UI5yIFD98CUE3yauYa8TMw2m6CkbeuDcHPWa2GKknSv5DcDclCRIA/eGddKfARpk5e0pMmxh7S1kkUszbXrRp1JvVI+yzWvPVYIMqCR2t8Jb8Ms3BihzcKtJw447pwJ/lQTHq+4U7DC+GMmw/QkFQ2NLHBDqLdiBPt8Q+dxQ4lEqms3whgnTNb9fgpj5klI1/f5D/6pn15AZC79F4CV/rEeS+PM+B1arpWSTneNQ09/5pIoViQbEiPAi409P518PQgMsEpWf4t5ewGsYi/r4KZWrsiWHDTlhuLc1KPl7gGAXXMLQFk9xO55mtZLmtDSXAb5spPbY+33vyBVMOQIXZ0OI+qpaHKJP1zJBDhQULKnxQcufmca5ZPYjxcAIOEZ2rtgRI0mKVvKE7JEmHsxe3rSPYRg5ulIx71om6xPn0+Q==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199018)(36840700001)(46966006)(40470700004)(478600001)(36860700001)(2616005)(41300700001)(426003)(966005)(6666004)(82740400003)(82310400005)(7636003)(86362001)(40460700003)(336012)(26005)(186003)(47076005)(83380400001)(36756003)(40480700001)(356005)(8676002)(5660300002)(70586007)(316002)(54906003)(2906002)(4326008)(8936002)(70206006)(7416002)(7696005)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 08:33:38.7171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e5ec9e-d6bc-4d90-c7c9-08db2b794d31
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6474
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[ This series depends on VFIO device cdev series ]

Changelog
v5:
 * Kept the cmd->id in the iommufd_test_create_access() so the access can
   be created with an ioas by default. Then, renamed the previous ioctl
   IOMMU_TEST_OP_ACCESS_SET_IOAS to IOMMU_TEST_OP_ACCESS_REPLACE_IOAS, so
   it would be used to replace an access->ioas pointer.
 * Added iommufd_access_replace() API after the introductions of the other
   two APIs iommufd_access_attach() and iommufd_access_detach().
 * Since vdev->iommufd_attached is also set in emulated pathway too, call
   iommufd_access_update(), similar to the physical pathway.
v4:
 https://lore.kernel.org/linux-iommu/cover.1678284812.git.nicolinc@nvidia.com/
 * Rebased on top of Jason's series adding replace() and hwpt_alloc()
 https://lore.kernel.org/linux-iommu/0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com/
 * Rebased on top of cdev series v6
 https://lore.kernel.org/kvm/20230308132903.465159-1-yi.l.liu@intel.com/
 * Dropped the patch that's moved to cdev series.
 * Added unmap function pointer sanity before calling it.
 * Added "Reviewed-by" from Kevin and Yi.
 * Added back the VFIO change updating the ATTACH uAPI.
v3:
 https://lore.kernel.org/linux-iommu/cover.1677288789.git.nicolinc@nvidia.com/
 * Rebased on top of Jason's iommufd_hwpt branch:
 https://lore.kernel.org/linux-iommu/0-v2-406f7ac07936+6a-iommufd_hwpt_jgg@nvidia.com/
 * Dropped patches from this series accordingly. There were a couple of
   VFIO patches that will be submitted after the VFIO cdev series. Also,
   renamed the series to be "emulated".
 * Moved dma_unmap sanity patch to the first in the series.
 * Moved dma_unmap sanity to cover both VFIO and IOMMUFD pathways.
 * Added Kevin's "Reviewed-by" to two of the patches.
 * Fixed a NULL pointer bug in vfio_iommufd_emulated_bind().
 * Moved unmap() call to the common place in iommufd_access_set_ioas().
v2:
 https://lore.kernel.org/linux-iommu/cover.1675802050.git.nicolinc@nvidia.com/
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
v1:
 https://lore.kernel.org/linux-iommu/cover.1675320212.git.nicolinc@nvidia.com/

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

This series is rebased on top of Jason Gunthorpe's series that introduces
iommu_group_replace_domain API and IOMMUFD infrastructure for the IOMMUFD
"physical" devices. The IOMMUFD "emulated" deivces will need some extra
steps to replace the access->ioas object and its iopt pointer.

You can also find this series on Github:
https://github.com/nicolinc/iommufd/commits/iommu_group_replace_domain-v5

Thank you
Nicolin Chen

Nicolin Chen (4):
  vfio: Do not allow !ops->dma_unmap in vfio_pin/unpin_pages()
  iommufd: Add iommufd_access_replace() API
  iommufd/selftest: Add IOMMU_TEST_OP_ACCESS_REPLACE_IOAS coverage
  vfio: Support IO page table replacement

 drivers/iommu/iommufd/device.c                | 60 +++++++++++++++----
 drivers/iommu/iommufd/iommufd_test.h          |  4 ++
 drivers/iommu/iommufd/selftest.c              | 19 ++++++
 drivers/vfio/iommufd.c                        | 11 ++--
 drivers/vfio/vfio_main.c                      |  4 ++
 include/linux/iommufd.h                       |  1 +
 include/uapi/linux/vfio.h                     |  6 ++
 tools/testing/selftests/iommu/iommfd*.c       |  0
 tools/testing/selftests/iommu/iommufd.c       | 29 ++++++++-
 tools/testing/selftests/iommu/iommufd_utils.h | 19 ++++++
 10 files changed, 135 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/iommu/iommfd*.c

-- 
2.40.0

