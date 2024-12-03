Return-Path: <linux-kselftest+bounces-22723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6809E152A
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 09:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF61280C57
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 08:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8011DC182;
	Tue,  3 Dec 2024 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gN8QV2JZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD611AB6EA;
	Tue,  3 Dec 2024 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733213021; cv=fail; b=TaWI9LQh/99X3Wl/azA3RLdkXQaUdEgu8k6Alz065n6pzrhwsZriiNOuU2QlMiWuLaN81KsPBDNgcd+i0OyYqi1dHsBu5JUVh4Nx3f8uxi8C/+q+BGqAgNkPdCqg4D8KjAw3LOlQ8obCxd3ceNyw5jBxWY4YE2FerBzao7VbEnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733213021; c=relaxed/simple;
	bh=57Zo9F7UEx3oOjv0KF+GtYkrvQQN12hV6XT41focfIo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qtRDdYnBBjuDTkZ3QVz8NPTJxQtDYI1TxPhRRAadxb0+o4JD+mLsuIjTKdcPHedy/jfCevTCy5Tn36OpIrLwQ87BLaikRENvaUWdJ05Au52u91s95c2oRq4BTFnUTllAF1AxnokLceTtprCVSv3aBteXo7nmWGjpDS9CUSIxS14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gN8QV2JZ; arc=fail smtp.client-ip=40.107.101.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIqDCLfXs6WIdBzo8XYulBmFPqAMYx44A27JJCxutocxV1WNJvuTh3ZBJqwZbOprkvFk01Mr4sq39ZL+KphZ4xx+MeTEeOQabON6Qe3UP4k7buRT9UcE9e5LMX8U7jcOsChc7xCoBEi3/WCxSjogywyUzMYVoA5i9MhlUKJjKLOymvhP+W8rmuOlzOspmttSUAvpcNXGK+h/+V3yQrySLvrHKS0lgAs1o2rJNKm0RmuooY4SlOEpV2z+T3syFIRXPZZfN+hZvW0SqlEs6OK5E24AXXQm5c8u5EZAwFV21QG9rVyzPSUQLQWrVxAsQLcyKKtD1QJVz/Dh0Wi4ojnZXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2qg4m5l6adCYM0NcX+h2KaFJInKT0xGDxjYB2x1p2g=;
 b=l7yjOytSQ9+HIC3S+KuTgz/tOEVbBaK8NQPsRPF/kLl6YTrl5y+OwecGQsgf68gm+Fqs7COA+3tNTlZGpMmss00qVsajd6QYiLAcplsVbScj8HL0EhxP9L6pK4FCzk6O1xOTUNUts9iJs8v9GFlgR1PQ0+pHr3x2U7OlLRIHz2iDR1ktkAjxB7qRtI87Y/RFL30ozmqAwh6g+B/4Y9DQ2izUCOo0jxX3V2N0uBdoxuK1P0jcuFHnILLAlhBrxHu2E0PfzKNelvQvl1kfELw0ySzkcpgbPxxEy0/hu5+fF+OKGzdVRdFYbgPHzEWbJAPaxLi+4Yk0LdwzhldolwzQ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2qg4m5l6adCYM0NcX+h2KaFJInKT0xGDxjYB2x1p2g=;
 b=gN8QV2JZFYTgKQxZw0G6UkHI78PVwFVR35oh0bXv5631UJd4XMrzhQAkN65H9xJxGomvjVIuenOXVPj+gM0DVEW8SD8UYp8DRS4+0rKfELcSEjn96q+UF3TT2N+La7O7Bx0kJiXj6h6+h5eN2xECv5cgOuaxZq4cEYcjbSqmQWZi+wAeIEVX04Aa5VNAyBCRSIoU8njhZ52WKqiCpenC+h0tHvXDx7SUJHq9YX5cKIK0Pdlaf94aDUhc0eOdK0YyyzU0B33UKv9zvpAy1cW7mP1E2WaNMdHyrDPKs1MfdPM/0LycAik9FaTfPlaGF87QAGihGsCI/soMXu1aKO+TwA==
Received: from PH7PR02CA0020.namprd02.prod.outlook.com (2603:10b6:510:33d::28)
 by SJ0PR12MB6877.namprd12.prod.outlook.com (2603:10b6:a03:47f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Tue, 3 Dec
 2024 08:03:33 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:510:33d:cafe::86) by PH7PR02CA0020.outlook.office365.com
 (2603:10b6:510:33d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 08:03:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 08:03:32 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 00:03:18 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 00:03:18 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 00:03:17 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<shuah@kernel.org>
Subject: [PATCH v1 0/2] iommufd: Fix a small bug in fault.c
Date: Tue, 3 Dec 2024 00:02:53 -0800
Message-ID: <cover.1733212723.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|SJ0PR12MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: 85197c51-f765-4d60-8e7a-08dd1370fb56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gCYluah37Xa3iiV1EuHzo9CZdAdddXvh3dl2Qb3qwIxJzek5Taz2pQjUoQBU?=
 =?us-ascii?Q?EmFbbYpn3oJ7edC6/MS0WHr1XV8i1nlyl/0JBBQhU+zYrtxz08ye89XJ98ke?=
 =?us-ascii?Q?S8ztov56eweDeWBU/TvwYqTeO4cz47PBzXIyBsqItgm+4nMDDnB6azf3+ENL?=
 =?us-ascii?Q?ZrlTx8kulZjHnPNQ0eIaxk18Ubtjfa8mfcUKYzMc1Xn/T4aiFcCm0lpkYoL0?=
 =?us-ascii?Q?dEcRLt7WBYMHT0BSqpfHJCKCqcTdQ+8stAudWIyAJAGllYZgHywVAOSKGrI9?=
 =?us-ascii?Q?tKjJmPSuM5ASaO5+9qV/7dwp/XHx+F68leQBoyl7eCj3d/T3KaEFGbgYZEvP?=
 =?us-ascii?Q?Tw+QL0N5gszf6bkopxnhuY0W6f/NUmt0iU9UNUJqkcQLarMs6LSvuwOVlBAb?=
 =?us-ascii?Q?8eLNgusVsmeRdGX69Lx8Rbig5zT2szpC3dJwLKp6idF08KzmhPaVcj8vb4kU?=
 =?us-ascii?Q?Ga7AVVq6TLj2ro11zRt6FeSO1wz5NzDtmlEy57JoPCIOFx9cE5RO5+EzOa4D?=
 =?us-ascii?Q?6a1T+grVrQAGiSHWrrEQcIzvWrMrUHJujCbK80j0XJHaBVmZ8iIK1J0RcZrj?=
 =?us-ascii?Q?VhB6bxSt8SPaWjwiTz0dbHblLWbHszMb1Fc/C/3BqWs5cMWRe1A66vgCckiu?=
 =?us-ascii?Q?7cT8MPsxK02Z3MO0FLZDr2cMKfmxWc5LBBMgviU6Y1lxyUmvoe65l/7IvYqf?=
 =?us-ascii?Q?iqnXE4ar3bEGGsFtDkUECmnNK4wO6oLM6KI3h9g3cSbLgmXYGZs3HglGxq0T?=
 =?us-ascii?Q?8ym0QSMSH4lvjSb+o9Pv3JTNFT7oRYtSge1yT74B8zPMN5ivSeA9Xu2BPNR4?=
 =?us-ascii?Q?GOLIHBw/VemPPuAwPFGWLca7uPxpItJ5q82N9NQ7RdMQcvkKc4VEnYIogyem?=
 =?us-ascii?Q?3+YhxxanDtPuT3VibkAYHequdCopbWjBU+y6nAUC9NGQ4IPfDW1WvTxZGq7D?=
 =?us-ascii?Q?EtwbrErzTkC+O49GtXFD95xWI0sI7+GTRR/6rCss61OlMRN/8Vh5OlOeaSTO?=
 =?us-ascii?Q?PRrHdB6nIjfXXjVits55q1Fq49GJTrk/kGfD7wdsaGGLHgrV1jSROZ8fLg9z?=
 =?us-ascii?Q?iJ9pEVZCJc3XU8V3RngO9O4naJqxBIoxWiowiCz3E9FmpdSxZGywvL/RbfCZ?=
 =?us-ascii?Q?7hrMDmG9b/akazqTKZ26O/mJ4xn4kbDLKbBHqdRFKbH4EBZhi7D06s9XnjaE?=
 =?us-ascii?Q?EKP48vhHv98rze400dGYIeD4FpHzg+BTvHcENsvivkeczx5lhKk2JA5ubJBh?=
 =?us-ascii?Q?J3wuFdXzaYgLNJZeNe/ZjYqnrjcUrU+f2yxYhacX207eeryaL1qqibqHB9sJ?=
 =?us-ascii?Q?XW7Z21BaThsvb85PixNTRUaA1QrdZ73wamFg5JS3YmnlGlt2KpwtoFEw3Jh8?=
 =?us-ascii?Q?YIOg06ih0H2NXcX0UTZNLNdcMWImPoQZL4CN1DXDXvPGRBo17qL/Oj6PAUYe?=
 =?us-ascii?Q?yvuVY99DR125vzYpK+0v/KeLuomwBgST?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 08:03:32.8934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85197c51-f765-4d60-8e7a-08dd1370fb56
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6877

There are a few patches in vIRQ series that rework the fault.c file. So,
we should fix this before that bigger series touches the same code.

And add missing coverage for IOMMU_FAULT_QUEUE_ALLOC in iommufd_fail_nth.

Thanks!
Nicolin

Nicolin Chen (2):
  iommufd/fault: Fix out_fput in iommufd_fault_alloc()
  iommufd/selftest: Cover IOMMU_FAULT_QUEUE_ALLOC in iommufd_fail_nth

 drivers/iommu/iommufd/fault.c                    |  2 --
 tools/testing/selftests/iommu/iommufd_fail_nth.c | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.43.0


