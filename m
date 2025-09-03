Return-Path: <linux-kselftest+bounces-40705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B8BB42845
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 19:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0489E683A7E
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 17:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF8B3376AE;
	Wed,  3 Sep 2025 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QY2YTqxp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C8732C336;
	Wed,  3 Sep 2025 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921633; cv=fail; b=TukQZ/kP2vmLF4s6N7vW2GBvz53K6jq6T4yvTWsHroU4tXkHm+voVac68YMKUlFvpOxSTfKAiB64n/YDTx5JODXJ8m/2SP6q4KAq9u6F6NDsIbUlRwo+fUaS0PcY8cuP5o6JvRUi9M+DIWm0UoVERJ7d3MoT0Wx9XphNKwpbIzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921633; c=relaxed/simple;
	bh=Pyeq9uLlVINMfliqRvj3xOTm8if+TuuQbhxRLJbfObg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FqldEkwEoNYNFcYUiX3lO3ao+TRyw5anoy54B5PPr+9YcK8D3IVTp9a278B7FAW8qRy73BGlcTs0NzPlo18juYUIqdZe4rpByOvFrU1QiozQ475YNJ4eaugFQ6bpDEEYPDiwc8Y42Gw3ZH4nS6fubZSxiAvt24L6y8OMddX1zw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QY2YTqxp; arc=fail smtp.client-ip=40.107.223.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBwAP4ls666TR5X5VquOmaoCT5yI5hhBrNoQuRnzBTDSkmEm97V09mfppLSOK3bzE14uDt65tZO6TRxJUzdKjpxcmtjlba/M5uS8JnrE/38+HkbUX1HJs0tdNHZXkfn6dhJcFTwa3N3a7rCTaMJpPUZD+LWkw2KHv1wAgXJHplZ4taI9Vgqx05RE0q5O1ReOm4cntpKb8/xfKpWoHCA/Z2QVmQP0zNyHzO2DGzFpZ3UNJJUB8NStH3a4RytR5TebjJU7JlapGw13Emon7lUfvkD6Rmjj1awm/1YX1sPRyPFDjQsqhFlbwsyyFnAuSkQDvdpaOTxNY1hxmn4X03ilIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vyf+RTm8bUlZw72Ti0leFvUO/63mCGEWHdjCiU8ULEI=;
 b=dwIa9n0Mxtrlf6cfm2qWqbyB0YPfaSAl9vYMUjjojWKVao51NQRSiTatzSIK4XV4z5m5dpl5tOqrPfDRL3saVT2PzwA3KBPKq2rHXO1PwiIJUsG5+A85r4y0Ip61AwXvUZfNTyP+RiCtWABzxtA6S1oUkZwzp4Ve7nXadQXRs9rUnZhSBgk7lbBY/O0cYMfoSHs3+EpCe1Cdt75ZehQflx/sxYhTwg1aUNRxM6IYZx8P6qLDtqrSo8aJmZlbiQ9YUbhQnxWQ2JW+NClxvvrlkX1LBDWLJKL6aZyRIL/GSLoiTuUSvC/eGqLNCFUDbWq9qlKnpnQZj8hPGqxedxMNiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vyf+RTm8bUlZw72Ti0leFvUO/63mCGEWHdjCiU8ULEI=;
 b=QY2YTqxpI+XJJVq9O0j/Bjh+HkuLsEMjbk1ncMXIAx/v4oXiAlRAleezVbnw4bFT8IbFOJFzrJB27fXN4Me6rJA4tXTf/fMEZ+vcdeeYs5GqhxTt2oRRsc1AYloH3e7CL9dtjjaQ8GpC389E6KRufKq1aflOdK5FYMhXDU3px/rVe58Pi3iNg4CZ1ZOf0CIptiknX8hip1Xn0/XbVhCazFh3Ppo/pTkpzdlUViCF7eWPoT8fvQ9io1XYopzE0Qu4lDk3AJrWDhApgcuilumyXJ/24ePa31GszUOsvzM6v6PRvPTlz95pm3epSajGeNEP5r47WsZX5kqjZaJVn3wyRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Wed, 3 Sep
 2025 17:46:49 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 17:46:49 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	patches@lists.linux.dev
Subject: [PATCH v5 14/15] iommu/amd: Remove AMD io_pgtable support
Date: Wed,  3 Sep 2025 14:46:41 -0300
Message-ID: <14-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0377.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::26) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: fd96eb4a-0531-4e91-239f-08ddeb11d913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Vnu0ZeAul7fthjshofvtlmHtfhfyMBiDQxihYflZ4ZOaoitAMrWQCxfVolR?=
 =?us-ascii?Q?IWnZl+e/acd3MPQge01uZooyydumcJOCngIp84RPL28Dw1IWyCFB1vrdDaLj?=
 =?us-ascii?Q?HY74UwcgCPhT8qmDmYrObjsYjlwKwzLyOJKmL1zqUm3SCv6rmyHZdYVPNYMC?=
 =?us-ascii?Q?utnhJ8Ag5++hVbN/kOcsHz935BacHOzwzH3/tr/m9iESLwPvTyqN2ZJYMr5K?=
 =?us-ascii?Q?PlWxhCjSkgJ+DHFCEzjGOGg8HvenJyhnygts8yYLQDMF5/BC/V9YEo3cqzr0?=
 =?us-ascii?Q?V9pNE1b+ICPyRtDP4K8yAqu2tTnY92i60WxRJSRKjgEmcpkADzjX6htg5tkT?=
 =?us-ascii?Q?ObmXtgxlaYiObBDqjcVFL0ihZwD8HHv2JNxgRYAmqfimc1lD/YQmqxCOLfbT?=
 =?us-ascii?Q?wkHRK0ZTFdOxJzy4+CiayLSMEt4+6XY0OQLqeiQyoF2GQ1IgEa9nWUTGhHtX?=
 =?us-ascii?Q?uvzYr2K58iJOAdpCs3yD+43QTakksCg04+YTpQZutlW3wv1yBY+rcLMWs4Br?=
 =?us-ascii?Q?PqDKNwn/yCS1s8Uz4Hf1yjV+HUCajDhZO6LksW29aYTdlbQYQj3F9kZz/XvM?=
 =?us-ascii?Q?4kLahz/HOIfNvpbNmE/Xt6bgEU06Ctfg989xPm17A/5+/CXwKarq08JvONQj?=
 =?us-ascii?Q?dIY6eVgK2gvy/SHIGF33fsFiGVceYGTynSEt7hDI2oAV/Z9lC0/tlmyo6qGx?=
 =?us-ascii?Q?aQwcfFfnBNoS+BDY6ZmgJoGoye8Q16+xaNMJejnT/GNVQvu6Lyv92HqVSlGD?=
 =?us-ascii?Q?nLg4rbsh5kzYFlZafOzGvZVQ2Gd7M9dZbB6pDXpBPsjwPE3YqPeQ3M4QXMfc?=
 =?us-ascii?Q?peKHUrzA/k3/mdTbLrLUXse5SSCr9GHDvTlxoVTXRG4RdYB/1I9+mKesbOFk?=
 =?us-ascii?Q?MDmaUablbg5M9PKIefd2LMJE8ejOvsfPNl3TTB5OZz3XTyfqZ+65eieMHkia?=
 =?us-ascii?Q?7Q6i8qTd78venaTzIpqZpYkmQn80VEK4xyoccYLJvVkA7vaQ69lTANTEAW/q?=
 =?us-ascii?Q?TgeM1qSsbfM2xMOlqi/HVb7qsXF8C6saLmUbpaaGyCjg1zziXlbSqNm0upGQ?=
 =?us-ascii?Q?OwX7gTpG/PximNCe3F161RO9QEtV/cG31Qcar3z+hqeMDTj0FfCkwlJqitKw?=
 =?us-ascii?Q?tHp/Gwcw2bw8QCTt29+1O2HY/QXTE/7P+NpXezYR9doCE2O1grsUHIMAl3ZA?=
 =?us-ascii?Q?mxnofaYwaOqfsxoKyPKXej21VEu7rbdit5cW2jx9BzReMJNt9kgY5eOIt52b?=
 =?us-ascii?Q?t1ldwUxgMcC6mtNNy7Z14SR/uGyLF/5Tse7H9dd0MB5GKYiKouyi6BuUtIx3?=
 =?us-ascii?Q?WFlkEhSHsRKQC9JzDIDm+UK29JLsJfmVgtBdUdZD5RhWjbNhwaloFf83txcU?=
 =?us-ascii?Q?RmD5rXyW/Ns6M66BoFRrCgZ7HBRJ0Ze9sAHRyxf4OU42h+7vZAGcZkI+DOpw?=
 =?us-ascii?Q?+6WLz+2IB0T2/JKEmZRfjQ70dxNOFZMNfYEWbehfSi3vYOCfZ79g2Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4Xl0v/+8bC7FuM75Kyr2//XvG49csXdaC63/1c0ZkHIgYo3+EeFRsMAlKIaC?=
 =?us-ascii?Q?ckva0+5HpQ1omWEWvHRbw9/5+q+6eIvpaF1jY+4DsxdPrgWqx9ME2vKACDQJ?=
 =?us-ascii?Q?iVwgAJ2IFgPZgKeyB3/i8GEtiNzUEcxn/W8szL5LwcNYyBno0TODTQuON7S1?=
 =?us-ascii?Q?/19xBPAtmTIpk/Y70xEpvJLNOsbEeQ+jr52njG3T0CSbJrwbOkQwSe+AXSWi?=
 =?us-ascii?Q?V7eODfwloYV2g3HyyimZiM5YgwrsyQHsUyeDTblF3pOUTRXbe6JFfgOgpDBl?=
 =?us-ascii?Q?Mxejqcpsj2XhWy4NLRjKo90QbAyM0KvbFT6Xw9A9lJc1C+BxInTM4g8L6HR4?=
 =?us-ascii?Q?6Jz0ahoTTHjnk+SMm4ItnxM/b6ZKrZ1YzV0m6H5HOCQHFkLT5sW9jeprvSuU?=
 =?us-ascii?Q?pG93wuDtWxLGAkkM+NjDtL5vgTK+sIPzu4kRzjJzULy0Q1uYEuSCxpD8fY5a?=
 =?us-ascii?Q?7nmgw6yH4zS3Y2hxZ2W0B+UkQBiSH3Mz0NEJjUR9cHdoVEP4VMqhFMsBXVgU?=
 =?us-ascii?Q?ldVPy+9WMJhSSt6igxh908IdHTcW9tV6a3VmVpYy52xYPCuEiIZA1mmPlh7K?=
 =?us-ascii?Q?y7aDVnWU4lNvLeP9rLo630iSI2ZxgxfzcI+OVyBIr6KnKADMh5USMosy2g8B?=
 =?us-ascii?Q?WoU0/k2Hfr5SelmEa7e0qP9ahV1yj8nc9coDSWnqwfvdnLulzyafLz0dmHoR?=
 =?us-ascii?Q?3RrLHHFu2145ko/bxwit8YNexftNkNGU8sHXkG3nRXnMy4tQR5Pjsw4qLApV?=
 =?us-ascii?Q?fZidTOtXc66VGUpd76Gdw5eEyZwnQAwTsVMxeJ82gYpiGTPCmthXUja4ds4V?=
 =?us-ascii?Q?7ZsDGveU7Z+5PNEWPVR7yEld+DA4X0r5edvMRyNyMbzXi7ATlMuH5754KUE6?=
 =?us-ascii?Q?pxGFOIbsDruDQCUdI9WUhPp9QTEkp8fyYeqmFlnGKqnSLpbWjz9K/SboAtBC?=
 =?us-ascii?Q?he6XS+JjVT5wVg8RmvQZgOJXtpz24FQ0MRZkE6cnaXoLcnLiteCoEwHKF9AP?=
 =?us-ascii?Q?6D+uY2Ts3OMnKIjjsirHE+5TJe6pelVk+usb8ii7lfjBJU2bYUsG9D4hvJS/?=
 =?us-ascii?Q?Kd1qWvOz4FE1YmKnHhg6SluKXFb71xIszWx63DkRxkXQNky1y5AMKRBACw/u?=
 =?us-ascii?Q?3PEdd+w0TtVku5tx6WulNYoOUggb9vDYVZlHQ5KQTw7pEHTttdMe7Fe/b3DC?=
 =?us-ascii?Q?oow46Y6vA96seEYfTp/6JPdpB398BXLBxh3EgnMoH0HNaTf6HmQci/bI5xUw?=
 =?us-ascii?Q?1bdTpWvGBB87NAln5C1P6r9Oo1eJduKWtpGGQYmxjLkhl9vFlecQbZ4VJXdD?=
 =?us-ascii?Q?uqcehRTtvU4ZYo72R7RgY8bfeWKBlpn8S8dwbj8P7T9JGJ6EOh2JJY8pKY4O?=
 =?us-ascii?Q?QDs2yPVphILh9s7sK3BxCMKR+IiLN8QprG9ny8GIQRsVF1MHQ+KFwsiXij8s?=
 =?us-ascii?Q?7cqvBK+egR7bA/JTcWbb7rgE8li8R828dC4vueO/XLH0WJf0HNtxyS6mjc3q?=
 =?us-ascii?Q?cxZZ+/vVj/L0TpL+hk0gueN7B7K5kkZFdTQS+p7LladB1wgUBdzv/yyjzaS7?=
 =?us-ascii?Q?foAYOsrzdbUVJTLVZJM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd96eb4a-0531-4e91-239f-08ddeb11d913
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:46:44.8152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aR3XSTqcMMqPSbSPVtcFb/kL3uAHtwhEO8yxLKR0+UD+/DCFwvUQpCsYPTdgTH6i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

None of this is used anymore, delete it.

Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu_types.h |  97 -----
 drivers/iommu/amd/io_pgtable.c      | 559 ----------------------------
 drivers/iommu/amd/io_pgtable_v2.c   | 370 ------------------
 drivers/iommu/io-pgtable.c          |   4 -
 include/linux/io-pgtable.h          |   2 -
 6 files changed, 1 insertion(+), 1033 deletions(-)
 delete mode 100644 drivers/iommu/amd/io_pgtable.c
 delete mode 100644 drivers/iommu/amd/io_pgtable_v2.c

diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index 59c04a67f39825..5412a563c6979c 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o ppr.o pasid.o
+obj-y += iommu.o init.o quirks.o ppr.o pasid.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 90cf2bc4e14528..dde3d8f5b822b9 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -18,7 +18,6 @@
 #include <linux/spinlock.h>
 #include <linux/pci.h>
 #include <linux/irqreturn.h>
-#include <linux/io-pgtable.h>
 #include <linux/generic_pt/iommu.h>
 
 /*
@@ -338,76 +337,7 @@
 #define GUEST_PGTABLE_4_LEVEL	0x00
 #define GUEST_PGTABLE_5_LEVEL	0x01
 
-#define PM_LEVEL_SHIFT(x)	(12 + ((x) * 9))
-#define PM_LEVEL_SIZE(x)	(((x) < 6) ? \
-				  ((1ULL << PM_LEVEL_SHIFT((x))) - 1): \
-				   (0xffffffffffffffffULL))
-#define PM_LEVEL_INDEX(x, a)	(((a) >> PM_LEVEL_SHIFT((x))) & 0x1ffULL)
-#define PM_LEVEL_ENC(x)		(((x) << 9) & 0xe00ULL)
-#define PM_LEVEL_PDE(x, a)	((a) | PM_LEVEL_ENC((x)) | \
-				 IOMMU_PTE_PR | IOMMU_PTE_IR | IOMMU_PTE_IW)
-#define PM_PTE_LEVEL(pte)	(((pte) >> 9) & 0x7ULL)
-
-#define PM_MAP_4k		0
 #define PM_ADDR_MASK		0x000ffffffffff000ULL
-#define PM_MAP_MASK(lvl)	(PM_ADDR_MASK & \
-				(~((1ULL << (12 + ((lvl) * 9))) - 1)))
-#define PM_ALIGNED(lvl, addr)	((PM_MAP_MASK(lvl) & (addr)) == (addr))
-
-/*
- * Returns the page table level to use for a given page size
- * Pagesize is expected to be a power-of-two
- */
-#define PAGE_SIZE_LEVEL(pagesize) \
-		((__ffs(pagesize) - 12) / 9)
-/*
- * Returns the number of ptes to use for a given page size
- * Pagesize is expected to be a power-of-two
- */
-#define PAGE_SIZE_PTE_COUNT(pagesize) \
-		(1ULL << ((__ffs(pagesize) - 12) % 9))
-
-/*
- * Aligns a given io-virtual address to a given page size
- * Pagesize is expected to be a power-of-two
- */
-#define PAGE_SIZE_ALIGN(address, pagesize) \
-		((address) & ~((pagesize) - 1))
-/*
- * Creates an IOMMU PTE for an address and a given pagesize
- * The PTE has no permission bits set
- * Pagesize is expected to be a power-of-two larger than 4096
- */
-#define PAGE_SIZE_PTE(address, pagesize)		\
-		(((address) | ((pagesize) - 1)) &	\
-		 (~(pagesize >> 1)) & PM_ADDR_MASK)
-
-/*
- * Takes a PTE value with mode=0x07 and returns the page size it maps
- */
-#define PTE_PAGE_SIZE(pte) \
-	(1ULL << (1 + ffz(((pte) | 0xfffULL))))
-
-/*
- * Takes a page-table level and returns the default page-size for this level
- */
-#define PTE_LEVEL_PAGE_SIZE(level)			\
-	(1ULL << (12 + (9 * (level))))
-
-/*
- * The IOPTE dirty bit
- */
-#define IOMMU_PTE_HD_BIT (6)
-
-/*
- * Bit value definition for I/O PTE fields
- */
-#define IOMMU_PTE_PR	BIT_ULL(0)
-#define IOMMU_PTE_HD	BIT_ULL(IOMMU_PTE_HD_BIT)
-#define IOMMU_PTE_U	BIT_ULL(59)
-#define IOMMU_PTE_FC	BIT_ULL(60)
-#define IOMMU_PTE_IR	BIT_ULL(61)
-#define IOMMU_PTE_IW	BIT_ULL(62)
 
 /*
  * Bit value definition for DTE fields
@@ -437,12 +367,6 @@
 /* DTE[128:179] | DTE[184:191] */
 #define DTE_DATA2_INTR_MASK	~GENMASK_ULL(55, 52)
 
-#define IOMMU_PAGE_MASK (((1ULL << 52) - 1) & ~0xfffULL)
-#define IOMMU_PTE_PRESENT(pte) ((pte) & IOMMU_PTE_PR)
-#define IOMMU_PTE_DIRTY(pte) ((pte) & IOMMU_PTE_HD)
-#define IOMMU_PTE_PAGE(pte) (iommu_phys_to_virt((pte) & IOMMU_PAGE_MASK))
-#define IOMMU_PTE_MODE(pte) (((pte) >> 9) & 0x07)
-
 #define IOMMU_PROT_MASK 0x03
 #define IOMMU_PROT_IR 0x01
 #define IOMMU_PROT_IW 0x02
@@ -535,19 +459,6 @@ struct amd_irte_ops;
 
 #define AMD_IOMMU_FLAG_TRANS_PRE_ENABLED      (1 << 0)
 
-#define io_pgtable_to_data(x) \
-	container_of((x), struct amd_io_pgtable, pgtbl)
-
-#define io_pgtable_ops_to_data(x) \
-	io_pgtable_to_data(io_pgtable_ops_to_pgtable(x))
-
-#define io_pgtable_ops_to_domain(x) \
-	container_of(io_pgtable_ops_to_data(x), \
-		     struct protection_domain, iop)
-
-#define io_pgtable_cfg_to_data(x) \
-	container_of((x), struct amd_io_pgtable, pgtbl.cfg)
-
 struct gcr3_tbl_info {
 	u64	*gcr3_tbl;	/* Guest CR3 table */
 	int	glx;		/* Number of levels for GCR3 table */
@@ -555,13 +466,6 @@ struct gcr3_tbl_info {
 	u16	domid;		/* Per device domain ID */
 };
 
-struct amd_io_pgtable {
-	struct io_pgtable	pgtbl;
-	int			mode;
-	u64			*root;
-	u64			*pgd;		/* v2 pgtable pgd pointer */
-};
-
 enum protection_domain_mode {
 	PD_MODE_NONE,
 	PD_MODE_V1,
@@ -596,7 +500,6 @@ struct protection_domain {
 		struct pt_iommu_x86_64 amdv2;
 	};
 	struct list_head dev_list; /* List of all devices in this domain */
-	struct amd_io_pgtable iop;
 	spinlock_t lock;	/* mostly used to lock the page table*/
 	u16 id;			/* the domain id written to the device table */
 	enum protection_domain_mode pd_mode; /* Track page table type */
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
deleted file mode 100644
index ba61869b23857a..00000000000000
--- a/drivers/iommu/amd/io_pgtable.c
+++ /dev/null
@@ -1,559 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * CPU-agnostic AMD IO page table allocator.
- *
- * Copyright (C) 2020 Advanced Micro Devices, Inc.
- * Author: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
- */
-
-#define pr_fmt(fmt)     "AMD-Vi: " fmt
-#define dev_fmt(fmt)    pr_fmt(fmt)
-
-#include <linux/atomic.h>
-#include <linux/bitops.h>
-#include <linux/io-pgtable.h>
-#include <linux/kernel.h>
-#include <linux/sizes.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <linux/dma-mapping.h>
-
-#include <asm/barrier.h>
-
-#include "amd_iommu_types.h"
-#include "amd_iommu.h"
-#include "../iommu-pages.h"
-
-/*
- * Helper function to get the first pte of a large mapping
- */
-static u64 *first_pte_l7(u64 *pte, unsigned long *page_size,
-			 unsigned long *count)
-{
-	unsigned long pte_mask, pg_size, cnt;
-	u64 *fpte;
-
-	pg_size  = PTE_PAGE_SIZE(*pte);
-	cnt      = PAGE_SIZE_PTE_COUNT(pg_size);
-	pte_mask = ~((cnt << 3) - 1);
-	fpte     = (u64 *)(((unsigned long)pte) & pte_mask);
-
-	if (page_size)
-		*page_size = pg_size;
-
-	if (count)
-		*count = cnt;
-
-	return fpte;
-}
-
-static void free_pt_lvl(u64 *pt, struct iommu_pages_list *freelist, int lvl)
-{
-	u64 *p;
-	int i;
-
-	for (i = 0; i < 512; ++i) {
-		/* PTE present? */
-		if (!IOMMU_PTE_PRESENT(pt[i]))
-			continue;
-
-		/* Large PTE? */
-		if (PM_PTE_LEVEL(pt[i]) == 0 ||
-		    PM_PTE_LEVEL(pt[i]) == 7)
-			continue;
-
-		/*
-		 * Free the next level. No need to look at l1 tables here since
-		 * they can only contain leaf PTEs; just free them directly.
-		 */
-		p = IOMMU_PTE_PAGE(pt[i]);
-		if (lvl > 2)
-			free_pt_lvl(p, freelist, lvl - 1);
-		else
-			iommu_pages_list_add(freelist, p);
-	}
-
-	iommu_pages_list_add(freelist, pt);
-}
-
-static void free_sub_pt(u64 *root, int mode, struct iommu_pages_list *freelist)
-{
-	switch (mode) {
-	case PAGE_MODE_NONE:
-	case PAGE_MODE_7_LEVEL:
-		break;
-	case PAGE_MODE_1_LEVEL:
-		iommu_pages_list_add(freelist, root);
-		break;
-	case PAGE_MODE_2_LEVEL:
-	case PAGE_MODE_3_LEVEL:
-	case PAGE_MODE_4_LEVEL:
-	case PAGE_MODE_5_LEVEL:
-	case PAGE_MODE_6_LEVEL:
-		free_pt_lvl(root, freelist, mode);
-		break;
-	default:
-		BUG();
-	}
-}
-
-/*
- * This function is used to add another level to an IO page table. Adding
- * another level increases the size of the address space by 9 bits to a size up
- * to 64 bits.
- */
-static bool increase_address_space(struct amd_io_pgtable *pgtable,
-				   unsigned long address,
-				   unsigned int page_size_level,
-				   gfp_t gfp)
-{
-	struct io_pgtable_cfg *cfg = &pgtable->pgtbl.cfg;
-	struct protection_domain *domain =
-		container_of(pgtable, struct protection_domain, iop);
-	unsigned long flags;
-	bool ret = true;
-	u64 *pte;
-
-	pte = iommu_alloc_pages_node_sz(cfg->amd.nid, gfp, SZ_4K);
-	if (!pte)
-		return false;
-
-	spin_lock_irqsave(&domain->lock, flags);
-
-	if (address <= PM_LEVEL_SIZE(pgtable->mode) &&
-	    pgtable->mode - 1 >= page_size_level)
-		goto out;
-
-	ret = false;
-	if (WARN_ON_ONCE(pgtable->mode == amd_iommu_hpt_level))
-		goto out;
-
-	*pte = PM_LEVEL_PDE(pgtable->mode, iommu_virt_to_phys(pgtable->root));
-
-	pgtable->root  = pte;
-	pgtable->mode += 1;
-
-	pte = NULL;
-	ret = true;
-
-out:
-	spin_unlock_irqrestore(&domain->lock, flags);
-	iommu_free_pages(pte);
-
-	return ret;
-}
-
-static u64 *alloc_pte(struct amd_io_pgtable *pgtable,
-		      unsigned long address,
-		      unsigned long page_size,
-		      u64 **pte_page,
-		      gfp_t gfp,
-		      bool *updated)
-{
-	unsigned long last_addr = address + (page_size - 1);
-	struct io_pgtable_cfg *cfg = &pgtable->pgtbl.cfg;
-	int level, end_lvl;
-	u64 *pte, *page;
-
-	BUG_ON(!is_power_of_2(page_size));
-
-	while (last_addr > PM_LEVEL_SIZE(pgtable->mode) ||
-	       pgtable->mode - 1 < PAGE_SIZE_LEVEL(page_size)) {
-		/*
-		 * Return an error if there is no memory to update the
-		 * page-table.
-		 */
-		if (!increase_address_space(pgtable, last_addr,
-					    PAGE_SIZE_LEVEL(page_size), gfp))
-			return NULL;
-	}
-
-
-	level   = pgtable->mode - 1;
-	pte     = &pgtable->root[PM_LEVEL_INDEX(level, address)];
-	address = PAGE_SIZE_ALIGN(address, page_size);
-	end_lvl = PAGE_SIZE_LEVEL(page_size);
-
-	while (level > end_lvl) {
-		u64 __pte, __npte;
-		int pte_level;
-
-		__pte     = *pte;
-		pte_level = PM_PTE_LEVEL(__pte);
-
-		/*
-		 * If we replace a series of large PTEs, we need
-		 * to tear down all of them.
-		 */
-		if (IOMMU_PTE_PRESENT(__pte) &&
-		    pte_level == PAGE_MODE_7_LEVEL) {
-			unsigned long count, i;
-			u64 *lpte;
-
-			lpte = first_pte_l7(pte, NULL, &count);
-
-			/*
-			 * Unmap the replicated PTEs that still match the
-			 * original large mapping
-			 */
-			for (i = 0; i < count; ++i)
-				cmpxchg64(&lpte[i], __pte, 0ULL);
-
-			*updated = true;
-			continue;
-		}
-
-		if (!IOMMU_PTE_PRESENT(__pte) ||
-		    pte_level == PAGE_MODE_NONE) {
-			page = iommu_alloc_pages_node_sz(cfg->amd.nid, gfp,
-							 SZ_4K);
-
-			if (!page)
-				return NULL;
-
-			__npte = PM_LEVEL_PDE(level, iommu_virt_to_phys(page));
-
-			/* pte could have been changed somewhere. */
-			if (!try_cmpxchg64(pte, &__pte, __npte))
-				iommu_free_pages(page);
-			else if (IOMMU_PTE_PRESENT(__pte))
-				*updated = true;
-
-			continue;
-		}
-
-		/* No level skipping support yet */
-		if (pte_level != level)
-			return NULL;
-
-		level -= 1;
-
-		pte = IOMMU_PTE_PAGE(__pte);
-
-		if (pte_page && level == end_lvl)
-			*pte_page = pte;
-
-		pte = &pte[PM_LEVEL_INDEX(level, address)];
-	}
-
-	return pte;
-}
-
-/*
- * This function checks if there is a PTE for a given dma address. If
- * there is one, it returns the pointer to it.
- */
-static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
-		      unsigned long address,
-		      unsigned long *page_size)
-{
-	int level;
-	u64 *pte;
-
-	*page_size = 0;
-
-	if (address > PM_LEVEL_SIZE(pgtable->mode))
-		return NULL;
-
-	level	   =  pgtable->mode - 1;
-	pte	   = &pgtable->root[PM_LEVEL_INDEX(level, address)];
-	*page_size =  PTE_LEVEL_PAGE_SIZE(level);
-
-	while (level > 0) {
-
-		/* Not Present */
-		if (!IOMMU_PTE_PRESENT(*pte))
-			return NULL;
-
-		/* Large PTE */
-		if (PM_PTE_LEVEL(*pte) == PAGE_MODE_7_LEVEL ||
-		    PM_PTE_LEVEL(*pte) == PAGE_MODE_NONE)
-			break;
-
-		/* No level skipping support yet */
-		if (PM_PTE_LEVEL(*pte) != level)
-			return NULL;
-
-		level -= 1;
-
-		/* Walk to the next level */
-		pte	   = IOMMU_PTE_PAGE(*pte);
-		pte	   = &pte[PM_LEVEL_INDEX(level, address)];
-		*page_size = PTE_LEVEL_PAGE_SIZE(level);
-	}
-
-	/*
-	 * If we have a series of large PTEs, make
-	 * sure to return a pointer to the first one.
-	 */
-	if (PM_PTE_LEVEL(*pte) == PAGE_MODE_7_LEVEL)
-		pte = first_pte_l7(pte, page_size, NULL);
-
-	return pte;
-}
-
-static void free_clear_pte(u64 *pte, u64 pteval,
-			   struct iommu_pages_list *freelist)
-{
-	u64 *pt;
-	int mode;
-
-	while (!try_cmpxchg64(pte, &pteval, 0))
-		pr_warn("AMD-Vi: IOMMU pte changed since we read it\n");
-
-	if (!IOMMU_PTE_PRESENT(pteval))
-		return;
-
-	pt   = IOMMU_PTE_PAGE(pteval);
-	mode = IOMMU_PTE_MODE(pteval);
-
-	free_sub_pt(pt, mode, freelist);
-}
-
-/*
- * Generic mapping functions. It maps a physical address into a DMA
- * address space. It allocates the page table pages if necessary.
- * In the future it can be extended to a generic mapping function
- * supporting all features of AMD IOMMU page tables like level skipping
- * and full 64 bit address spaces.
- */
-static int iommu_v1_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
-			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
-			      int prot, gfp_t gfp, size_t *mapped)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	struct iommu_pages_list freelist = IOMMU_PAGES_LIST_INIT(freelist);
-	bool updated = false;
-	u64 __pte, *pte;
-	int ret, i, count;
-	size_t size = pgcount << __ffs(pgsize);
-	unsigned long o_iova = iova;
-
-	BUG_ON(!IS_ALIGNED(iova, pgsize));
-	BUG_ON(!IS_ALIGNED(paddr, pgsize));
-
-	ret = -EINVAL;
-	if (!(prot & IOMMU_PROT_MASK))
-		goto out;
-
-	while (pgcount > 0) {
-		count = PAGE_SIZE_PTE_COUNT(pgsize);
-		pte   = alloc_pte(pgtable, iova, pgsize, NULL, gfp, &updated);
-
-		ret = -ENOMEM;
-		if (!pte)
-			goto out;
-
-		for (i = 0; i < count; ++i)
-			free_clear_pte(&pte[i], pte[i], &freelist);
-
-		if (!iommu_pages_list_empty(&freelist))
-			updated = true;
-
-		if (count > 1) {
-			__pte = PAGE_SIZE_PTE(__sme_set(paddr), pgsize);
-			__pte |= PM_LEVEL_ENC(7) | IOMMU_PTE_PR | IOMMU_PTE_FC;
-		} else
-			__pte = __sme_set(paddr) | IOMMU_PTE_PR | IOMMU_PTE_FC;
-
-		if (prot & IOMMU_PROT_IR)
-			__pte |= IOMMU_PTE_IR;
-		if (prot & IOMMU_PROT_IW)
-			__pte |= IOMMU_PTE_IW;
-
-		for (i = 0; i < count; ++i)
-			pte[i] = __pte;
-
-		iova  += pgsize;
-		paddr += pgsize;
-		pgcount--;
-		if (mapped)
-			*mapped += pgsize;
-	}
-
-	ret = 0;
-
-out:
-	if (updated) {
-		struct protection_domain *dom = io_pgtable_ops_to_domain(ops);
-		unsigned long flags;
-
-		spin_lock_irqsave(&dom->lock, flags);
-		/*
-		 * Flush domain TLB(s) and wait for completion. Any Device-Table
-		 * Updates and flushing already happened in
-		 * increase_address_space().
-		 */
-		amd_iommu_domain_flush_pages(dom, o_iova, size);
-		spin_unlock_irqrestore(&dom->lock, flags);
-	}
-
-	/* Everything flushed out, free pages now */
-	iommu_put_pages_list(&freelist);
-
-	return ret;
-}
-
-static unsigned long iommu_v1_unmap_pages(struct io_pgtable_ops *ops,
-					  unsigned long iova,
-					  size_t pgsize, size_t pgcount,
-					  struct iommu_iotlb_gather *gather)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	unsigned long long unmapped;
-	unsigned long unmap_size;
-	u64 *pte;
-	size_t size = pgcount << __ffs(pgsize);
-
-	BUG_ON(!is_power_of_2(pgsize));
-
-	unmapped = 0;
-
-	while (unmapped < size) {
-		pte = fetch_pte(pgtable, iova, &unmap_size);
-		if (pte) {
-			int i, count;
-
-			count = PAGE_SIZE_PTE_COUNT(unmap_size);
-			for (i = 0; i < count; i++)
-				pte[i] = 0ULL;
-		} else {
-			return unmapped;
-		}
-
-		iova = (iova & ~(unmap_size - 1)) + unmap_size;
-		unmapped += unmap_size;
-	}
-
-	return unmapped;
-}
-
-static phys_addr_t iommu_v1_iova_to_phys(struct io_pgtable_ops *ops, unsigned long iova)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	unsigned long offset_mask, pte_pgsize;
-	u64 *pte, __pte;
-
-	pte = fetch_pte(pgtable, iova, &pte_pgsize);
-
-	if (!pte || !IOMMU_PTE_PRESENT(*pte))
-		return 0;
-
-	offset_mask = pte_pgsize - 1;
-	__pte	    = __sme_clr(*pte & PM_ADDR_MASK);
-
-	return (__pte & ~offset_mask) | (iova & offset_mask);
-}
-
-static bool pte_test_and_clear_dirty(u64 *ptep, unsigned long size,
-				     unsigned long flags)
-{
-	bool test_only = flags & IOMMU_DIRTY_NO_CLEAR;
-	bool dirty = false;
-	int i, count;
-
-	/*
-	 * 2.2.3.2 Host Dirty Support
-	 * When a non-default page size is used , software must OR the
-	 * Dirty bits in all of the replicated host PTEs used to map
-	 * the page. The IOMMU does not guarantee the Dirty bits are
-	 * set in all of the replicated PTEs. Any portion of the page
-	 * may have been written even if the Dirty bit is set in only
-	 * one of the replicated PTEs.
-	 */
-	count = PAGE_SIZE_PTE_COUNT(size);
-	for (i = 0; i < count && test_only; i++) {
-		if (test_bit(IOMMU_PTE_HD_BIT, (unsigned long *)&ptep[i])) {
-			dirty = true;
-			break;
-		}
-	}
-
-	for (i = 0; i < count && !test_only; i++) {
-		if (test_and_clear_bit(IOMMU_PTE_HD_BIT,
-				       (unsigned long *)&ptep[i])) {
-			dirty = true;
-		}
-	}
-
-	return dirty;
-}
-
-static int iommu_v1_read_and_clear_dirty(struct io_pgtable_ops *ops,
-					 unsigned long iova, size_t size,
-					 unsigned long flags,
-					 struct iommu_dirty_bitmap *dirty)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	unsigned long end = iova + size - 1;
-
-	do {
-		unsigned long pgsize = 0;
-		u64 *ptep, pte;
-
-		ptep = fetch_pte(pgtable, iova, &pgsize);
-		if (ptep)
-			pte = READ_ONCE(*ptep);
-		if (!ptep || !IOMMU_PTE_PRESENT(pte)) {
-			pgsize = pgsize ?: PTE_LEVEL_PAGE_SIZE(0);
-			iova += pgsize;
-			continue;
-		}
-
-		/*
-		 * Mark the whole IOVA range as dirty even if only one of
-		 * the replicated PTEs were marked dirty.
-		 */
-		if (pte_test_and_clear_dirty(ptep, pgsize, flags))
-			iommu_dirty_bitmap_record(dirty, iova, pgsize);
-		iova += pgsize;
-	} while (iova < end);
-
-	return 0;
-}
-
-/*
- * ----------------------------------------------------
- */
-static void v1_free_pgtable(struct io_pgtable *iop)
-{
-	struct amd_io_pgtable *pgtable = container_of(iop, struct amd_io_pgtable, pgtbl);
-	struct iommu_pages_list freelist = IOMMU_PAGES_LIST_INIT(freelist);
-
-	if (pgtable->mode == PAGE_MODE_NONE)
-		return;
-
-	/* Page-table is not visible to IOMMU anymore, so free it */
-	BUG_ON(pgtable->mode < PAGE_MODE_NONE ||
-	       pgtable->mode > amd_iommu_hpt_level);
-
-	free_sub_pt(pgtable->root, pgtable->mode, &freelist);
-	iommu_put_pages_list(&freelist);
-}
-
-static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_cfg_to_data(cfg);
-
-	pgtable->root =
-		iommu_alloc_pages_node_sz(cfg->amd.nid, GFP_KERNEL, SZ_4K);
-	if (!pgtable->root)
-		return NULL;
-	pgtable->mode = PAGE_MODE_3_LEVEL;
-
-	cfg->pgsize_bitmap  = amd_iommu_pgsize_bitmap;
-	cfg->ias            = IOMMU_IN_ADDR_BIT_SIZE;
-	cfg->oas            = IOMMU_OUT_ADDR_BIT_SIZE;
-
-	pgtable->pgtbl.ops.map_pages    = iommu_v1_map_pages;
-	pgtable->pgtbl.ops.unmap_pages  = iommu_v1_unmap_pages;
-	pgtable->pgtbl.ops.iova_to_phys = iommu_v1_iova_to_phys;
-	pgtable->pgtbl.ops.read_and_clear_dirty = iommu_v1_read_and_clear_dirty;
-
-	return &pgtable->pgtbl;
-}
-
-struct io_pgtable_init_fns io_pgtable_amd_iommu_v1_init_fns = {
-	.alloc	= v1_alloc_pgtable,
-	.free	= v1_free_pgtable,
-};
diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
deleted file mode 100644
index b47941353ccbb8..00000000000000
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ /dev/null
@@ -1,370 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * CPU-agnostic AMD IO page table v2 allocator.
- *
- * Copyright (C) 2022, 2023 Advanced Micro Devices, Inc.
- * Author: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
- * Author: Vasant Hegde <vasant.hegde@amd.com>
- */
-
-#define pr_fmt(fmt)	"AMD-Vi: " fmt
-#define dev_fmt(fmt)	pr_fmt(fmt)
-
-#include <linux/bitops.h>
-#include <linux/io-pgtable.h>
-#include <linux/kernel.h>
-
-#include <asm/barrier.h>
-
-#include "amd_iommu_types.h"
-#include "amd_iommu.h"
-#include "../iommu-pages.h"
-
-#define IOMMU_PAGE_PRESENT	BIT_ULL(0)	/* Is present */
-#define IOMMU_PAGE_RW		BIT_ULL(1)	/* Writeable */
-#define IOMMU_PAGE_USER		BIT_ULL(2)	/* Userspace addressable */
-#define IOMMU_PAGE_PWT		BIT_ULL(3)	/* Page write through */
-#define IOMMU_PAGE_PCD		BIT_ULL(4)	/* Page cache disabled */
-#define IOMMU_PAGE_ACCESS	BIT_ULL(5)	/* Was accessed (updated by IOMMU) */
-#define IOMMU_PAGE_DIRTY	BIT_ULL(6)	/* Was written to (updated by IOMMU) */
-#define IOMMU_PAGE_PSE		BIT_ULL(7)	/* Page Size Extensions */
-#define IOMMU_PAGE_NX		BIT_ULL(63)	/* No execute */
-
-#define MAX_PTRS_PER_PAGE	512
-
-#define IOMMU_PAGE_SIZE_2M	BIT_ULL(21)
-#define IOMMU_PAGE_SIZE_1G	BIT_ULL(30)
-
-
-static inline int get_pgtable_level(void)
-{
-	return amd_iommu_gpt_level;
-}
-
-static inline bool is_large_pte(u64 pte)
-{
-	return (pte & IOMMU_PAGE_PSE);
-}
-
-static inline u64 set_pgtable_attr(u64 *page)
-{
-	u64 prot;
-
-	prot = IOMMU_PAGE_PRESENT | IOMMU_PAGE_RW | IOMMU_PAGE_USER;
-	prot |= IOMMU_PAGE_ACCESS;
-
-	return (iommu_virt_to_phys(page) | prot);
-}
-
-static inline void *get_pgtable_pte(u64 pte)
-{
-	return iommu_phys_to_virt(pte & PM_ADDR_MASK);
-}
-
-static u64 set_pte_attr(u64 paddr, u64 pg_size, int prot)
-{
-	u64 pte;
-
-	pte = __sme_set(paddr & PM_ADDR_MASK);
-	pte |= IOMMU_PAGE_PRESENT | IOMMU_PAGE_USER;
-	pte |= IOMMU_PAGE_ACCESS | IOMMU_PAGE_DIRTY;
-
-	if (prot & IOMMU_PROT_IW)
-		pte |= IOMMU_PAGE_RW;
-
-	/* Large page */
-	if (pg_size == IOMMU_PAGE_SIZE_1G || pg_size == IOMMU_PAGE_SIZE_2M)
-		pte |= IOMMU_PAGE_PSE;
-
-	return pte;
-}
-
-static inline u64 get_alloc_page_size(u64 size)
-{
-	if (size >= IOMMU_PAGE_SIZE_1G)
-		return IOMMU_PAGE_SIZE_1G;
-
-	if (size >= IOMMU_PAGE_SIZE_2M)
-		return IOMMU_PAGE_SIZE_2M;
-
-	return PAGE_SIZE;
-}
-
-static inline int page_size_to_level(u64 pg_size)
-{
-	if (pg_size == IOMMU_PAGE_SIZE_1G)
-		return PAGE_MODE_3_LEVEL;
-	if (pg_size == IOMMU_PAGE_SIZE_2M)
-		return PAGE_MODE_2_LEVEL;
-
-	return PAGE_MODE_1_LEVEL;
-}
-
-static void free_pgtable(u64 *pt, int level)
-{
-	u64 *p;
-	int i;
-
-	for (i = 0; i < MAX_PTRS_PER_PAGE; i++) {
-		/* PTE present? */
-		if (!IOMMU_PTE_PRESENT(pt[i]))
-			continue;
-
-		if (is_large_pte(pt[i]))
-			continue;
-
-		/*
-		 * Free the next level. No need to look at l1 tables here since
-		 * they can only contain leaf PTEs; just free them directly.
-		 */
-		p = get_pgtable_pte(pt[i]);
-		if (level > 2)
-			free_pgtable(p, level - 1);
-		else
-			iommu_free_pages(p);
-	}
-
-	iommu_free_pages(pt);
-}
-
-/* Allocate page table */
-static u64 *v2_alloc_pte(int nid, u64 *pgd, unsigned long iova,
-			 unsigned long pg_size, gfp_t gfp, bool *updated)
-{
-	u64 *pte, *page;
-	int level, end_level;
-
-	level = get_pgtable_level() - 1;
-	end_level = page_size_to_level(pg_size);
-	pte = &pgd[PM_LEVEL_INDEX(level, iova)];
-	iova = PAGE_SIZE_ALIGN(iova, PAGE_SIZE);
-
-	while (level >= end_level) {
-		u64 __pte, __npte;
-
-		__pte = *pte;
-
-		if (IOMMU_PTE_PRESENT(__pte) && is_large_pte(__pte)) {
-			/* Unmap large pte */
-			cmpxchg64(pte, *pte, 0ULL);
-			*updated = true;
-			continue;
-		}
-
-		if (!IOMMU_PTE_PRESENT(__pte)) {
-			page = iommu_alloc_pages_node_sz(nid, gfp, SZ_4K);
-			if (!page)
-				return NULL;
-
-			__npte = set_pgtable_attr(page);
-			/* pte could have been changed somewhere. */
-			if (!try_cmpxchg64(pte, &__pte, __npte))
-				iommu_free_pages(page);
-			else if (IOMMU_PTE_PRESENT(__pte))
-				*updated = true;
-
-			continue;
-		}
-
-		level -= 1;
-		pte = get_pgtable_pte(__pte);
-		pte = &pte[PM_LEVEL_INDEX(level, iova)];
-	}
-
-	/* Tear down existing pte entries */
-	if (IOMMU_PTE_PRESENT(*pte)) {
-		u64 *__pte;
-
-		*updated = true;
-		__pte = get_pgtable_pte(*pte);
-		cmpxchg64(pte, *pte, 0ULL);
-		if (pg_size == IOMMU_PAGE_SIZE_1G)
-			free_pgtable(__pte, end_level - 1);
-		else if (pg_size == IOMMU_PAGE_SIZE_2M)
-			iommu_free_pages(__pte);
-	}
-
-	return pte;
-}
-
-/*
- * This function checks if there is a PTE for a given dma address.
- * If there is one, it returns the pointer to it.
- */
-static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
-		      unsigned long iova, unsigned long *page_size)
-{
-	u64 *pte;
-	int level;
-
-	level = get_pgtable_level() - 1;
-	pte = &pgtable->pgd[PM_LEVEL_INDEX(level, iova)];
-	/* Default page size is 4K */
-	*page_size = PAGE_SIZE;
-
-	while (level) {
-		/* Not present */
-		if (!IOMMU_PTE_PRESENT(*pte))
-			return NULL;
-
-		/* Walk to the next level */
-		pte = get_pgtable_pte(*pte);
-		pte = &pte[PM_LEVEL_INDEX(level - 1, iova)];
-
-		/* Large page */
-		if (is_large_pte(*pte)) {
-			if (level == PAGE_MODE_3_LEVEL)
-				*page_size = IOMMU_PAGE_SIZE_1G;
-			else if (level == PAGE_MODE_2_LEVEL)
-				*page_size = IOMMU_PAGE_SIZE_2M;
-			else
-				return NULL;	/* Wrongly set PSE bit in PTE */
-
-			break;
-		}
-
-		level -= 1;
-	}
-
-	return pte;
-}
-
-static int iommu_v2_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
-			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
-			      int prot, gfp_t gfp, size_t *mapped)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	struct io_pgtable_cfg *cfg = &pgtable->pgtbl.cfg;
-	u64 *pte;
-	unsigned long map_size;
-	unsigned long mapped_size = 0;
-	unsigned long o_iova = iova;
-	size_t size = pgcount << __ffs(pgsize);
-	int ret = 0;
-	bool updated = false;
-
-	if (WARN_ON(!pgsize || (pgsize & cfg->pgsize_bitmap) != pgsize) || !pgcount)
-		return -EINVAL;
-
-	if (!(prot & IOMMU_PROT_MASK))
-		return -EINVAL;
-
-	while (mapped_size < size) {
-		map_size = get_alloc_page_size(pgsize);
-		pte = v2_alloc_pte(cfg->amd.nid, pgtable->pgd,
-				   iova, map_size, gfp, &updated);
-		if (!pte) {
-			ret = -ENOMEM;
-			goto out;
-		}
-
-		*pte = set_pte_attr(paddr, map_size, prot);
-
-		iova += map_size;
-		paddr += map_size;
-		mapped_size += map_size;
-	}
-
-out:
-	if (updated) {
-		struct protection_domain *pdom = io_pgtable_ops_to_domain(ops);
-		unsigned long flags;
-
-		spin_lock_irqsave(&pdom->lock, flags);
-		amd_iommu_domain_flush_pages(pdom, o_iova, size);
-		spin_unlock_irqrestore(&pdom->lock, flags);
-	}
-
-	if (mapped)
-		*mapped += mapped_size;
-
-	return ret;
-}
-
-static unsigned long iommu_v2_unmap_pages(struct io_pgtable_ops *ops,
-					  unsigned long iova,
-					  size_t pgsize, size_t pgcount,
-					  struct iommu_iotlb_gather *gather)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	struct io_pgtable_cfg *cfg = &pgtable->pgtbl.cfg;
-	unsigned long unmap_size;
-	unsigned long unmapped = 0;
-	size_t size = pgcount << __ffs(pgsize);
-	u64 *pte;
-
-	if (WARN_ON(!pgsize || (pgsize & cfg->pgsize_bitmap) != pgsize || !pgcount))
-		return 0;
-
-	while (unmapped < size) {
-		pte = fetch_pte(pgtable, iova, &unmap_size);
-		if (!pte)
-			return unmapped;
-
-		*pte = 0ULL;
-
-		iova = (iova & ~(unmap_size - 1)) + unmap_size;
-		unmapped += unmap_size;
-	}
-
-	return unmapped;
-}
-
-static phys_addr_t iommu_v2_iova_to_phys(struct io_pgtable_ops *ops, unsigned long iova)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	unsigned long offset_mask, pte_pgsize;
-	u64 *pte, __pte;
-
-	pte = fetch_pte(pgtable, iova, &pte_pgsize);
-	if (!pte || !IOMMU_PTE_PRESENT(*pte))
-		return 0;
-
-	offset_mask = pte_pgsize - 1;
-	__pte = __sme_clr(*pte & PM_ADDR_MASK);
-
-	return (__pte & ~offset_mask) | (iova & offset_mask);
-}
-
-/*
- * ----------------------------------------------------
- */
-static void v2_free_pgtable(struct io_pgtable *iop)
-{
-	struct amd_io_pgtable *pgtable = container_of(iop, struct amd_io_pgtable, pgtbl);
-
-	if (!pgtable || !pgtable->pgd)
-		return;
-
-	/* Free page table */
-	free_pgtable(pgtable->pgd, get_pgtable_level());
-	pgtable->pgd = NULL;
-}
-
-static struct io_pgtable *v2_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
-{
-	struct amd_io_pgtable *pgtable = io_pgtable_cfg_to_data(cfg);
-	int ias = IOMMU_IN_ADDR_BIT_SIZE;
-
-	pgtable->pgd = iommu_alloc_pages_node_sz(cfg->amd.nid, GFP_KERNEL, SZ_4K);
-	if (!pgtable->pgd)
-		return NULL;
-
-	if (get_pgtable_level() == PAGE_MODE_5_LEVEL)
-		ias = 57;
-
-	pgtable->pgtbl.ops.map_pages    = iommu_v2_map_pages;
-	pgtable->pgtbl.ops.unmap_pages  = iommu_v2_unmap_pages;
-	pgtable->pgtbl.ops.iova_to_phys = iommu_v2_iova_to_phys;
-
-	cfg->pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
-	cfg->ias           = ias;
-	cfg->oas           = IOMMU_OUT_ADDR_BIT_SIZE;
-
-	return &pgtable->pgtbl;
-}
-
-struct io_pgtable_init_fns io_pgtable_amd_iommu_v2_init_fns = {
-	.alloc	= v2_alloc_pgtable,
-	.free	= v2_free_pgtable,
-};
diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
index 8841c1487f0048..843fec8e8a511c 100644
--- a/drivers/iommu/io-pgtable.c
+++ b/drivers/iommu/io-pgtable.c
@@ -28,10 +28,6 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
 #ifdef CONFIG_IOMMU_IO_PGTABLE_ARMV7S
 	[ARM_V7S] = &io_pgtable_arm_v7s_init_fns,
 #endif
-#ifdef CONFIG_AMD_IOMMU
-	[AMD_IOMMU_V1] = &io_pgtable_amd_iommu_v1_init_fns,
-	[AMD_IOMMU_V2] = &io_pgtable_amd_iommu_v2_init_fns,
-#endif
 };
 
 static int check_custom_allocator(enum io_pgtable_fmt fmt,
diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 138fbd89b1e633..75fd67cc2b7a46 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -15,8 +15,6 @@ enum io_pgtable_fmt {
 	ARM_64_LPAE_S2,
 	ARM_V7S,
 	ARM_MALI_LPAE,
-	AMD_IOMMU_V1,
-	AMD_IOMMU_V2,
 	APPLE_DART,
 	APPLE_DART2,
 	IO_PGTABLE_NUM_FMTS,
-- 
2.43.0


