Return-Path: <linux-kselftest+bounces-45127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D200C40EE1
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 17:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C395A3BB46D
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 16:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81744334695;
	Fri,  7 Nov 2025 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L/xuHZRi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010042.outbound.protection.outlook.com [52.101.85.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27AD333758;
	Fri,  7 Nov 2025 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762534192; cv=fail; b=GnjPsYkEGO5rUM7dUPMW3RMtvu2xTRWW056blwFQ9yMzJb4pb3Y+BGQZ0gKba+cTBmF1UeelGswtfQD51QIFZk1nnMaddIje7/eAam9oY55dfmAaaMvIsY7xYdKCBMK/cFlJRhcMpe7Uz42PSOEJteTUfrwHXXLQQ8z+Hp3azyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762534192; c=relaxed/simple;
	bh=IdYuxwrnhWF9XujI903Z3Wu/cfig2xCNdyAHcyXV9NY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NEHc+vT+yKCF5U+5ksR4XoWuaZPxSZWv7stpJcN9qODtM/K49yhcm8Bz4WkLFpez5JKEQs2//jUPVEX+/D4mV/PDUKGAZXrTh5pI9EYRUWk1uQBYMVRoKcEkwAPStpvfkmMpHaKwbcyPmM4n/HrYdU9vpqJxWM37aQNJZWhoOnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L/xuHZRi; arc=fail smtp.client-ip=52.101.85.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSneNa7H1gZlNoxkCU0hqkb0qZn96tmfx1h5dgqQmsqNhX8iU/tXvzA785FNzJ2aUbZmzGxfn1nq9jJwFY1ij78dOno+yaj16aAlP1FXcHsb94Cmzjzawkub2zH5FbboYD2i0pYRhGtIwfmU5MfLgF1FDHlrXMvpnxyQITeSMJZggpV1QfA/O4VwO/fLV9F9/o8i/cXMNEQGzcEi78oAoBYoSG/xTKkjZmc8Kmg37to/DICWRil/jnHdQpKatIHdNLn2UzzBW4HwPreaguYPMMVY/KCjRFZlMat0VHJf3X+RhJ0l16XXd+qhymxYle//DgwaIh4oxOFTOOPNM97+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6KeiFGkRyyqrLVU4eykJQqtzKuZZmCXzldIW/aqcl8=;
 b=YDAvrQlU1BkphyvhKMObOLoFRpYkbFJ7nIGBV8qc/sm2OEY2cqauEccYPT5IvZzrFRNjGmltB0NpeRHXExgYJ8+AIDqoalGXsmv/jelBkr/n+l0RhFAkpWMT+jZxSRwUU7ookz4bXOuVXFwWs7e8QsWR4hGsM41o0+qQgIujdJDt9V5Dz4Xjja6ou4gfXZYJRTujk8D39NJ3eleC1ecThAZaoXMTbbR5xylAbU53TQ0Cux6EF+ZOAiDiDiaV7AnLlxvpMdYYqaqzXeEJ7OFIvCpk+F+eT2ZLCVj0kKEMCkL/J60SLCBk3LFVeGEZoYRLHQkqShwi7klseORCPxtGZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6KeiFGkRyyqrLVU4eykJQqtzKuZZmCXzldIW/aqcl8=;
 b=L/xuHZRiGJ1xqZr+WbEojIEyDuKLWzemyJ7FsSjHRvchZ390f+XSPZNhMGS9gppxAPkhEntpCnkK3aP593fPG/1fcjntartDS3h16pUff4F+Bmbtsh//jJgOqkne5UCzyoV8tibP4dSz+dX1AgdiAXtr8OtZcod7DsvbmPbWq5c4ExNFF+nJQEfLIulaOFC9VGHGvJSG41rH/A5meve8LL7LXgNjXnzbsVJ/N/DM968+DyUwQLoI6QbEDMPZWPuZwOdm6E41y94lxswjuxeUGWRG+C1XeYTEwjfcSkvxdJi0Od1M+1K/73q/wISUgVSmecmMGmjSQDsOa78SGqiurg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SN7PR12MB8771.namprd12.prod.outlook.com (2603:10b6:806:32a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 16:49:47 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Fri, 7 Nov 2025
 16:49:47 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	=?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Will Deacon <will@kernel.org>
Cc: Krishnakant Jaju <kjaju@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Matt Ochs <mochs@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH 0/9] Initial DMABUF support for iommufd
Date: Fri,  7 Nov 2025 12:49:32 -0400
Message-ID: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0124.namprd03.prod.outlook.com
 (2603:10b6:208:32e::9) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SN7PR12MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: d0313afc-d139-4116-2347-08de1e1da814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hjgnPWdiG4WMoT1ccRh8axhABqssSQQ3i8dJSM+WPcfrRZBaEwuBpuZTxAbJ?=
 =?us-ascii?Q?lYWRR6URkqY/F0cV1N9qIgege3mTdSYDTeLlFySKAh0LkgESy2tYAYmUG2fu?=
 =?us-ascii?Q?a+BSwRWWAqMvgwwGERLGfMsxDh4g0jP8D8uzUOMYcfTNMPNWhLH4FWg0++Zc?=
 =?us-ascii?Q?ea20NcZViRLPbv72bjG8PmfIH7bfVUETFzHN6vOplg0mKKLqVA/P6rMCm6Cb?=
 =?us-ascii?Q?MEEt3OCFc5ePOFcTOVP8avAnKduu8i0fyiGMv1wsYLREzLMpvZlUMX+lWtLL?=
 =?us-ascii?Q?+Dgq9Lp20AwVCSxL6iHFxBbSptHoGTLtQKH06CavaT5nCSit420z+oxfAGcH?=
 =?us-ascii?Q?A7ocnL27hYOlH9WmccXYwdSk8CcmONBVMHAyUhCPNX2jY9FvXoRRDHwPQMGN?=
 =?us-ascii?Q?VvWzvYA37tDMCQPUN+F2bRjO+NI39rXON0BCncpmt3lPu9unEGIAzhjcTt7I?=
 =?us-ascii?Q?cu6AQEMGE5wzr9rbl1ALzYRPgCISYw2Xe1MUGDQSXj1XZF68zg44j5eMh4HU?=
 =?us-ascii?Q?e/MckiGu4fyUp+guOxTCJY/xm0HoeOxALvtJDI/Gd3I09DaEpzpl0hUJSx1y?=
 =?us-ascii?Q?QWNiS7gzqlZVdaCTVFBQT4lLJTZ1JoR8PzDsrkdjhz8xGodlrnnt1QigVHXY?=
 =?us-ascii?Q?lnasASeHOY8RO1+iRfCiAB0Lb4ObIALZMc3xOje4uPLZluqmGkAJyeSGmP/x?=
 =?us-ascii?Q?rpFKqrLwIgKV0rBIBaQrQHfGqfK+z74BqSu69H8Ii3SRxdCQIjrMUTUBf8mY?=
 =?us-ascii?Q?9aQr6v3L5trT4R+naOBWMHHfo3/37qWCRhpNl9O75zka6pKFLL0okZsXwcPv?=
 =?us-ascii?Q?LF+jwCZtwlPE5b+2rJTtSyuhzzFGbKWG9IjMS9FtegV9S1ZR6zutHWg+s83F?=
 =?us-ascii?Q?0SOQ/EosUVy5fWoG8nv075pei2rpj1F5lEHnjFjm/fB995CkNRa2KBfq9K8P?=
 =?us-ascii?Q?7pZTLekdoimWlJI3eW6xPIB/iCePSL9ZtAtxzN+BZjylLr4qXbkK8OUhvEPy?=
 =?us-ascii?Q?1pSS4JVJOCR1Lpt0ub0jVizUlirv7NGCuFUNrqkbegdemWA6nHU0CEstus22?=
 =?us-ascii?Q?Rkvlaclzqq9Q/0s2gYwKcpV4KB1BXi13AOw2/QbPUMHQeIIS/WaoKdJjgSV+?=
 =?us-ascii?Q?9ZYjps44PVLeH3yYj/w8BGxbSWpSMyCertNr7ahUyAnJOhvVJQlAVhOqTyKQ?=
 =?us-ascii?Q?YlK28Wc+I8Kv+LjwErspQ9fcPgZFAiKMarKVjRyrIrme5LG56ughNLAk1Cgj?=
 =?us-ascii?Q?j2AsZzT5Bk6iTI2FYjzPBTkv8JKR+QiPJCqveU0ezcXRDmR8vwkiLMlvwmGT?=
 =?us-ascii?Q?6Hi732UBabJqmwoYjN86PX6bgvG7pg4p7J9LDOIcZuNw7R0ecfR9V9mWEwLr?=
 =?us-ascii?Q?ABM6KXkfM41nL7J+B0RkgN+YcarFS9sURU8yT7ftaEdF52YvHPVGu0dfOQij?=
 =?us-ascii?Q?XFFRwoouFZ52tRufsAmNhB1ok/mcUAHcvhTpRqlz9ekGxq3gqOEkCaWtsDIY?=
 =?us-ascii?Q?WHm5Yrm9chjlhlSqISosmNgYPDpZV5ubKhzI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PuLxaO5ChaW8IWFVmTcySVVXEDrPE8yw6vndABf8OAFDMw1w9pNC8mTzqORN?=
 =?us-ascii?Q?HrqnEhJlNZn4h76fQzqHNlVUJZ89/f5o1opMRA2jnHFjPSzZ58tLCE/MOFtW?=
 =?us-ascii?Q?jNJByqDk7ngVrUfZNSdvveuZ4Hk55O0WJOIr+bgVKYWtqKNdfQ8Jeu7R1tTz?=
 =?us-ascii?Q?bWYCpZiW8cMY5OGv8VNw5SYCQC56YPjkn568N6yxcQA12ePKE628/f5wqDiw?=
 =?us-ascii?Q?t8EeeKVUHHcW4BecXbgXONDo23gfahCDPCc+yqxp6Hjwmw6n8FwVKBAttRa+?=
 =?us-ascii?Q?rKEWkbc7GwUp0l71RsQHxq8ExdzAk6yvAEN3RJWL8s7rTkEn11OxEomYfcwc?=
 =?us-ascii?Q?ELoXQVKMxbcvPA5w1hnbg/99gY+N8QmZY04D0jcAnnRFw8Oq0ODAQlCkqkvU?=
 =?us-ascii?Q?u+1QfknCa2lGU8Cows8KFcd15CeeLzPD59tam3n2q1gTnFicxILwsOaeudht?=
 =?us-ascii?Q?8ETYNtn5xqALsewPfNnRMQ+Yn+UCgwcTlREJ3gA04jZe9L3rZfv+5BJxfzpl?=
 =?us-ascii?Q?sUbQuD5OJQUde/MoGcq+7mOb4nycYljRTEA93oKyWo+9XObBwXXW9g3lGAf/?=
 =?us-ascii?Q?S/NFLu6PvcdcRMdH60ikjWTwP85P3OnNF1xtRmZcC7anrNWj1tUetK9FSzNu?=
 =?us-ascii?Q?uzhdpT+e+9ei5msBSaFP9Vp1Z6ZSqguHpXOEyiHN0BN/4lhBH1ZbMaWisYf6?=
 =?us-ascii?Q?hYxT1vxUUY5MlvKBi0lY0rL80UU/HsqYYHh26h4UO8RqNL9+zQ/ys299Wn+F?=
 =?us-ascii?Q?9Lbo2CuhGYp9oiU91TfdCiLwb8/hQywBr/Dcf++yf0VpD42+Sb6rx1y2nXy4?=
 =?us-ascii?Q?U8Ok+Lri+DZqAwtYmRkBuQNxqhKR6STqwjXXMuU9seVYtrqq0hhddbcAc/CA?=
 =?us-ascii?Q?5UHwchP+fJ7FlKxVA+a72n+HvS+rS6x0P6KhGfCEuqnGvxbmxyR7TDYGg5Bq?=
 =?us-ascii?Q?0P5kygVpIUtwEviioAaLV5TSbwynv5LWQ+sktH5mGd2ljDf6Uk+NkzaIipLT?=
 =?us-ascii?Q?mCm2E1nBJvkDI+5tQR8TwfYx0+8kFtZwphqleMKO/IUz8f4McJo0+R/+hDW5?=
 =?us-ascii?Q?IUXVEribtIp1bTrmWYXArNpKOf2dz050xckk9QQp2EfhNFWVrRppkWviiLVk?=
 =?us-ascii?Q?nIpZLLc/Odi8nlEx3Vw8tbEq5AJWzQo8PgtlwKZcko/QTWiR6YoHXPUSKLXg?=
 =?us-ascii?Q?IxeCSLKPTefKEGULhGSPHaceQm4Pcr7eb+V35NbA1y9ynVNJPCRwNcBPCP6a?=
 =?us-ascii?Q?p/At2T6hYhKZY+RkCBHjBCW+DGIjSKKJAwDSn3eAxDVzsehOWsyHK0RzR87s?=
 =?us-ascii?Q?9+wHPiPYj9Dvtv0h26d9oREmrPRxAkkNXu77facSBbfI/dJhxPS3GO8NLDy+?=
 =?us-ascii?Q?LjG//VTSkGzzD0iJsEcTDopaQ5QtZZXrJf8RP3OPgGoNVvTm+S9Dlg0aheC5?=
 =?us-ascii?Q?mv01w6l18g8D+kLHWv7BlXtNubGcjiMslx8VNgWfRmgJijAZVFzME4lIqkBW?=
 =?us-ascii?Q?MaMG4j24UMhYkLjT8T61WRMzuHmGs2Mq8NCA69KL19Cd0gfju7rC0PwXNdir?=
 =?us-ascii?Q?31fsOURLPtO8Q1ps+Bc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0313afc-d139-4116-2347-08de1e1da814
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:49:45.7219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFX0ZpeTaYAbRtdDvH0x8JXkl4/bjdcYkTEW+2uJcbYcuzZtaeG0ydvrzWEA4lLR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8771

This series is the start of adding full DMABUF support to
iommufd. Currently it is limited to only work with VFIO's DMABUF exporter.
It sits on top of Leon's series to add a DMABUF exporter to VFIO:

  https://lore.kernel.org/r/20251106-dmabuf-vfio-v7-0-2503bf390699@nvidia.com

The existing IOMMU_IOAS_MAP_FILE is enhanced to detect DMABUF fd's, but
otherwise works the same as it does today for a memfd. The user can select
a slice of the FD to map into the ioas and if the underliyng alignment
requirements are met it will be placed in the iommu_domain.

Though limited, it is enough to allow a VMM like QEMU to connect MMIO BAR
memory from VFIO to an iommu_domain controlled by iommufd. This is used
for PCI Peer to Peer support in VMs, and is the last feature that the VFIO
type 1 container has that iommufd couldn't do.

The VFIO type1 version extracts raw PFNs from VMAs, which has no lifetime
control and is a use-after-free security problem.

Instead iommufd relies on revokable DMABUFs. Whenever VFIO thinks there
should be no access to the MMIO it can shoot down the mapping in iommufd
which will unmap it from the iommu_domain. There is no automatic remap,
this is a safety protocol so the kernel doesn't get stuck. Userspace is
expected to know it is doing something that will revoke the dmabuf and
map/unmap it around the activity. Eg when QEMU goes to issue FLR it should
do the map/unmap to iommufd.

Since DMABUF is missing some key general features for this use case it
relies on a "private interconnect" between VFIO and iommufd via the
vfio_pci_dma_buf_iommufd_map() call.

The call confirms the DMABUF has revoke semantics and delivers a phys_addr
for the memory suitable for use with iommu_map().

Medium term there is a desire to expand the supported DMABUFs to include
GPU drivers to support DPDK/SPDK type use cases so future series will work
to add a general concept of revoke and a general negotiation of
interconnect to remove vfio_pci_dma_buf_iommufd_map().

I also plan another series to modify iommufd's vfio_compat to
transparently pull a dmabuf out of a VFIO VMA to emulate more of the uAPI
of type1.

The latest series for interconnect negotation to exchange a phys_addr is:
 https://lore.kernel.org/r/20251027044712.1676175-1-vivek.kasireddy@intel.com

And the discussion for design of revoke is here:
 https://lore.kernel.org/dri-devel/20250114173103.GE5556@nvidia.com/

This is on github: https://github.com/jgunthorpe/linux/commits/iommufd_dmabuf

v2:
 - Rebase on Leon's v7
 - Fix mislocking in an iopt_fill_domain() error path
v1: https://patch.msgid.link/r/0-v1-64bed2430cdb+31b-iommufd_dmabuf_jgg@nvidia.com

Jason Gunthorpe (9):
  vfio/pci: Add vfio_pci_dma_buf_iommufd_map()
  iommufd: Add DMABUF to iopt_pages
  iommufd: Do not map/unmap revoked DMABUFs
  iommufd: Allow a DMABUF to be revoked
  iommufd: Allow MMIO pages in a batch
  iommufd: Have pfn_reader process DMABUF iopt_pages
  iommufd: Have iopt_map_file_pages convert the fd to a file
  iommufd: Accept a DMABUF through IOMMU_IOAS_MAP_FILE
  iommufd/selftest: Add some tests for the dmabuf flow

 drivers/iommu/iommufd/io_pagetable.c          |  78 +++-
 drivers/iommu/iommufd/io_pagetable.h          |  53 ++-
 drivers/iommu/iommufd/ioas.c                  |   8 +-
 drivers/iommu/iommufd/iommufd_private.h       |  14 +-
 drivers/iommu/iommufd/iommufd_test.h          |  10 +
 drivers/iommu/iommufd/main.c                  |  10 +
 drivers/iommu/iommufd/pages.c                 | 407 ++++++++++++++++--
 drivers/iommu/iommufd/selftest.c              | 142 ++++++
 drivers/vfio/pci/vfio_pci_dmabuf.c            |  34 ++
 include/linux/vfio_pci_core.h                 |   4 +
 tools/testing/selftests/iommu/iommufd.c       |  43 ++
 tools/testing/selftests/iommu/iommufd_utils.h |  44 ++
 12 files changed, 781 insertions(+), 66 deletions(-)


base-commit: bb04e92c86b44b3e36532099b68de1e889acfee7
-- 
2.43.0


