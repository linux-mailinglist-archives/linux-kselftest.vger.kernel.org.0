Return-Path: <linux-kselftest+bounces-14948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1B694B034
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 21:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346B51C2290B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 19:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A31D14535E;
	Wed,  7 Aug 2024 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o6q22eMd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72CB145335;
	Wed,  7 Aug 2024 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057252; cv=fail; b=oGq55/rkUXkxgrqA04EHAkpIMvIHLFmPA3IHrXdN+v9sjqYbdkWpGu9hjgtyIef/5rd3w31qAYuOxuLyxPjid+KczAY14KzamksqtrQct1cgbCWo2KT54/MSq7X3mp+S4XoU+NIAl7zkTB1OUCEtKr/AT020NkjJfQIN6fnclg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057252; c=relaxed/simple;
	bh=mOdlJH3zgODyGNLRyFziMxAWxK9msYElR4bNshC3wIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fg4i3YAeiGaaIENA8ULLyBeaYoTAo4fWmsRdYWeCROoSBaSO8FplYGTc7RqnBxBYodGpK5UYO8GHPB4ADEyhb8A7zZkxjpJhqY6fmfXWPQ/RIP94HngN/nmkhHGJJr9sbpsAI40aGjhYxp/dwdMjGL81QSZ933uLCUOeW9uepkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o6q22eMd; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCK95E79lx7j1WotSX+8AYiOaJVv/ENPsrWWod99R0W627hMhVua5hKqpn9T6VTrD4TwAW1kjq7i3twY9l/lgOmk13qvBrABeECtqzVmLK8ajOhEHo0MsRB2TbFKztVZhIxaBVB0orhDVC9zPPE/gmZnoEON/8hf0IZTm6BG6PsmEtDCCXeFrIsrkFNt8O9OhXHZvVkolkxezLmHfHXQZOMcjIEaqG1VYDQm6qGkVUqQ8yQlD6MrtNejo7T2DwP/ByGasZ7Uy4RjNdpP5AxnImN/38TB4M5KE2nQY6MMG7DySJ7aWTKlp37s6iG1ZlsiNhNmZ8L7MYRN5h021330cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFbf211vCxHEKi8m4sGMuBWX+M4+7DN5KLI5+Fcdnec=;
 b=Y6yhRyhGpqk9yJOKmtUk1SCcOrPRB6dEg9E1fltRzWrUiVeJQY8uuSnHNGy73mUI9bcXII+03GqHPHFSwGvldwBf2qQHGUR9LJ+Ix7Mzn0uLk5Ch9+viHh+zu9YNm0WXgVtLvwd+NZVGWYLY5B1WnG9bf7afyw2d17vXnX/Q6WHPKh8dmPnXHALytV8JGYasYHtNCcUOiIqT8m5C2zMAQY20861SE6gtClu0Ohmy5AxDdwqyEGEICV4Bm33JhTQrfJAHYktOVF7mhdlEboOiMR+7FACBTwk/6ZiHXabLHcGIw7tG2Jg8VJYmAMiKmUwAM3Vd/9hP+XsH83Z8OvD29Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFbf211vCxHEKi8m4sGMuBWX+M4+7DN5KLI5+Fcdnec=;
 b=o6q22eMdQdyQYG7q/M2ghkvnNgIJwzuVE5kzno3XSlciuKcMyjEShwtLIZOHfdpBjJJB4Co1dQKicXFmZjaPZCHDk47+FbPl4iVghyr3MKNUExsKCrQvl51+qC4qjKuWGJ79E3k7Cth3zmjzDbCcjC1EC/B6mrqjv/iPErzsLo08nB2O198lI/aXdFtlc2f/zn+6/JYW/NDp7SVyrh5hh5HXVA4clAnW8y6G51zHR+GRLzeYr6xMcPC7Skt7wvIDmFlqDcha7MCOMHOghr6dLHQLoMR2j7afIAG4EevZIz4hc0A6WwqYVtA8pbCsVGtErhhoteux5aHFzI130TPrAQ==
Received: from SJ0PR13CA0003.namprd13.prod.outlook.com (2603:10b6:a03:2c0::8)
 by MN0PR12MB6004.namprd12.prod.outlook.com (2603:10b6:208:380::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 19:00:44 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::12) by SJ0PR13CA0003.outlook.office365.com
 (2603:10b6:a03:2c0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.11 via Frontend
 Transport; Wed, 7 Aug 2024 19:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 19:00:43 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 12:00:23 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 12:00:22 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 12:00:22 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <shuah@kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH v3 4/4] iommu/arm-smmu-v3: Implement arm_smmu_get_msi_mapping_domain
Date: Wed, 7 Aug 2024 12:00:07 -0700
Message-ID: <4fb65d188978955861cc3d3bf665ca83b8debb9b.1723056910.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723056910.git.nicolinc@nvidia.com>
References: <cover.1723056910.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|MN0PR12MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c785ad3-ef6c-4fad-b880-08dcb7133d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yY99LwYhM+h3HkSUSYD6ZieTwEYNg8FvcGTti3hB38kpX0B6/vKXfj2u4O6B?=
 =?us-ascii?Q?sz0nEL6RWGBldcXBLBQ1zE7cEpI05Qi04ELkJharDgQ6aN0E6dz6lMQQNaab?=
 =?us-ascii?Q?gqGTCF2SdU6q7NEZSLedUNLO6o6g+q2b8SRbNDvaiU7+1UwujdO4viUZj4yg?=
 =?us-ascii?Q?JX8W/aMC11CNp7wSgkWOKttfOmbzcUrlVOuDNLjxR2kNQY7WjTpcts4h7WAG?=
 =?us-ascii?Q?aQ3Y2UuTJ6HMQQSi2KbmMjm4ZrjGP5GxoAoLy3keDD5PyEZF5vIMxDJwpHfv?=
 =?us-ascii?Q?KGzfsqa0NP9HEYlyXEICo1RIbedcA8kUCHuWBa1j4ovANdpYdjUsaov16Zwp?=
 =?us-ascii?Q?VbIiBak9Ob4Q+NsJeO2N0FhoECCmYjIBMflMxmP7aOq/GLKgbmH1kaFEpmjF?=
 =?us-ascii?Q?+cx2i+09ydb5KjDOCLjNm9dXPkKflbwZgt7Li82hDMOHllSw1bsaycYtEZ/m?=
 =?us-ascii?Q?9o0mTsUJ1iM18yV5sKgwAwAqFTw4MNdfhtX31mtFfHfIRUxEKgRTzLo5K1fU?=
 =?us-ascii?Q?UmzbOEB3APfoSkwbG9SdmRrtd7XN6DMX98CxXp7h0CVM9AkHmyFl30YCQ3zp?=
 =?us-ascii?Q?IuF15GloQoigL+pdpnkbXNFQS41zp9wjTz8qpkAmfxwcZp7+AUmyIpA7fXcO?=
 =?us-ascii?Q?E+roqUdAHCwLLI5i83watAm6JaYVHonc/5awBlp82ok+RKc4BTBsZ7EUD0uB?=
 =?us-ascii?Q?tT00avKLfyGB45Q6fhViMkhj1kxqclLNZU6DLXLwYd8qPwQiK9W0ytgQ0RLb?=
 =?us-ascii?Q?Hmd6TvBh4TYPXKzDHWD7wRB3dhri94U26GII5k884KXwCg7H7AdrZ77tVATG?=
 =?us-ascii?Q?VfS80GtPJEBffJ6vdzBi83TdMztgWM/gkIp6U2vNNyPGkBtXiZ+eVQSaruM6?=
 =?us-ascii?Q?CHmUxfcNi9vrFUi9oIAxhWtF4rPHaJwso1J70qmWj75FLQd8dFZniGoBAubO?=
 =?us-ascii?Q?UmlE1tnJ/CSgVUERSARn0VYfY3owEgv/BFKWKwM17+UWmZXmDxukzKsvwFH/?=
 =?us-ascii?Q?PyRaKAHHGUDa7DknS/3gHYLY2nbHXXwzYep7hMiCAOpJ30zwiY//wR24soYB?=
 =?us-ascii?Q?ADacWdNwjSEOcjVmeBRKGbD27NezXWXvWDoZq+sRuwMxWxd7LXezWs9YrGgp?=
 =?us-ascii?Q?myoXC2F5ukfw/BWS7MC2c1QDnxMG0L0nbXzPr2/yORJUD1FOEI21jxt8b4A1?=
 =?us-ascii?Q?6nj1BAUlQXPTqP4UmFv323+4q6x9CJXFLW233YHu8X98hslWOWBlP+/E5/Mc?=
 =?us-ascii?Q?wzvp+o+XjOHpBmLlZlMWemATKkOGFnG54KCtrgAQh4k7WGYLu1xIYIJX67az?=
 =?us-ascii?Q?Xs9aKmkOkyjHc+hDtlnC7DH0pnhgXdm8L1Y1hAl8D0YIscnvdxc7+EHYREKN?=
 =?us-ascii?Q?i1nE0inEmQNCUOPnqBHGdaO681xJdPtbJu63hNPvnKGSkOPIGXlRQIUlPeTQ?=
 =?us-ascii?Q?44DkKKdA9BaGMMDRFJCEnE9P7LBXn5+y?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 19:00:43.8451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c785ad3-ef6c-4fad-b880-08dcb7133d32
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6004

In a 1-stage translation setup, a device is attached to a paging domain.
In a 2-stage translation setup, a device is attached to a nested domain,
which does not have the mappings for the MSI page but only an s2_parent
paging domain pointer that holds the mappings.

Add arm_smmu_get_msi_mapping_domain in arm_smmu_nested_ops to return the
correct paging domain.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 24836f3269b3..3962d5a55519 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3305,10 +3305,20 @@ static int arm_smmu_cache_invalidate_user(struct iommu_domain *domain,
 	return ret;
 }
 
+static struct iommu_domain *
+arm_smmu_get_msi_mapping_domain(struct iommu_domain *domain)
+{
+	struct arm_smmu_nested_domain *nested_domain =
+		container_of(domain, struct arm_smmu_nested_domain, domain);
+
+	return &nested_domain->s2_parent->domain;
+}
+
 static const struct iommu_domain_ops arm_smmu_nested_ops = {
 	.attach_dev = arm_smmu_attach_dev_nested,
 	.free = arm_smmu_domain_nested_free,
 	.cache_invalidate_user	= arm_smmu_cache_invalidate_user,
+	.get_msi_mapping_domain	= arm_smmu_get_msi_mapping_domain,
 };
 
 static struct iommu_domain *
-- 
2.43.0


