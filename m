Return-Path: <linux-kselftest+bounces-20733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A57439B137F
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Oct 2024 01:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 349E11F22490
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 23:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC44921A4B9;
	Fri, 25 Oct 2024 23:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RhslQlC3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BF5215C44;
	Fri, 25 Oct 2024 23:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729900243; cv=fail; b=qfpqpXhAv4dKAmPE1KpAWKaqLNX0gqxvrbrl9jhTKQCnB1gmGQNqcHGoyTx+Z7LUt1iNLFnNsOdlwK07qlN2ZVmujV7we1vZlrxOsLXHzuIWla/U14/Rfkfl2UU1Iu2X3cWNPwwosQbB69MSrm4aiOaa6/foQYD3aVku7b/5oj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729900243; c=relaxed/simple;
	bh=tACMf93DPlJe6+rpGq9bSNVgXBRV+1/bvmb2A2Az8bE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nRTD0L8ZAhZJm4nWyo3CxnBJ1loPf8iOak5iqmi6GgGGsEZQu1rg9MzmjjblySo/hRzv4M+vnFVVXJaAVSGUkBL88OjzHfWDSNQUNLsLieCaMiWH4C9MhXD/GGmT3oFgQu6nMXpoPPlMNneH8CQsG1lt/rxZiI5g4U6oU9yLYgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RhslQlC3; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKaC3P55mDlkE/5AMtsA0qCnOEwnP3BZAVMyInemD8h0zvtk5KkaVyKXS3AiskXJ/zHjPIJAdK/62JM58bVa7w69u5cSg8P0UPjF27X0pAdyIHvxVyee4yWSqR2B67YaaoUNXE1R5RJ4BIVW7pkrUpgTurEFFmOohzZ2tidEZgXIy8GSaoEv9O2Ebb7tajrT9zNDhgppJuue0hKXpIFqhHQsxALol9UTuAa93w0KhtFRfV4LdSVEKBo8A8AB66JAp/pwHMfbk5x+b67SEs/Wc4f9aQTcbHYvfyE03Anq9JtbvmXg+hbq2xu+TDBPfg9zEDAxT0ouxqh5EdWUtPE25Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCBFx0ERk6OM8PDHX+pEr0P8NCclVWghOo3ge0DujSk=;
 b=nHUJ8tzpxX6tp6LH+aO1u9E+ldB9pgWrLqT2nhFNnoyu0JVEwIbiU+PmvJLeQTEApmJPuoH1pGzfdqWuHvsqeuaM7nklYABHCxzHJioil5/V2pQamf0H+NJDHiwrnDAVx+6tWp2pzoHc2flN1sCrTsIw9/cFTwFwV9vBxjuSgHyvQ5+I3jIU4+v2UZlptxPA7DQ8xLENygBqCSUARofqUQS9hg2e/LLNYb+08OPeMyOWx8iAuPJcH1ATEH+YNVKIqXPXRdM6CJd7cTmFZWHad38yvqT41/V7U+gosW8Fb8LTZq/XMm7fo7sSXXIf/afDI0wUu9BDhJ/UHDhYQfFQ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCBFx0ERk6OM8PDHX+pEr0P8NCclVWghOo3ge0DujSk=;
 b=RhslQlC38+r5FjCb49jIzrsYiVg/jQ6VGJfBoY5MsHuGKw43okxU/IcfvBM4cf0ZZIhhO2DIGdsQxHa4z/CQhbmX5OYL3jh6OniVJfGvlHtCQQrB7IMunGCOayUkzVlKNc9h8B5OEcucAyMMlnvFnNWzzdbE6BS+77paZeBawDL6hXYBAtbAjJD3raq14JQrEx1kTF/pyeLV2F6ekjN23bYQgiaVu0UoZytEGkq9E5FRug3/OlAYEs3bbYOaYO7OpgnTZHTj6PA/FXAkDHeyB8RYSXn8raVtgJonO5dneMFkoUbI0+WfeR69l8vC9gzAf6RvBdieBxHGbknWqImToQ==
Received: from MW4PR03CA0213.namprd03.prod.outlook.com (2603:10b6:303:b9::8)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 23:50:17 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::b7) by MW4PR03CA0213.outlook.office365.com
 (2603:10b6:303:b9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 23:50:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 23:50:16 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 16:50:06 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 25 Oct 2024 16:50:06 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 25 Oct 2024 16:50:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>
CC: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
	<shuah@kernel.org>, <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<zhangfei.gao@linaro.org>, <patches@lists.linux.dev>
Subject: [PATCH v5 03/13] iommufd: Add iommufd_verify_unfinalized_object
Date: Fri, 25 Oct 2024 16:49:43 -0700
Message-ID: <e99946ea0128370349373c94339d465397946137.1729897352.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729897352.git.nicolinc@nvidia.com>
References: <cover.1729897352.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|DM6PR12MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d1f966d-b989-433a-9aed-08dcf54fc6dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V+x+T3H3Qdq/ogAcOOE3vH9UAbizX9X1G47KTbAjIw05Y3Z+uWeO6OagwMpG?=
 =?us-ascii?Q?/4GOacLP4YJmGYAM+hU4hylVxn30kmamBW8BU/fppZxQYM7hgpVeWSWVsAl4?=
 =?us-ascii?Q?W1kUh2rbMZlLLWx6q6+7o9KD6d3Y6c+1hpatPec2DbdQ9hcAgs6T5X+ekXK7?=
 =?us-ascii?Q?9RH/7YfAVewgz7LadcVl4G/yJUzxUMj7+FOX9fspua8ZScj2E1bOh2yA3byK?=
 =?us-ascii?Q?uA1i1BqS0RxTGqMsIHF2KQV0LO6+Od/uRyQxX0lS6YaTj1kV8Op8Aw+gA7tF?=
 =?us-ascii?Q?I8UVQR9M7/E7z90oMcTL2hz23cVZXQzGutbmhsaG3BxYlaVRL1IRlLJ2Ap7w?=
 =?us-ascii?Q?0zmHiGR+mu1b6D1JlzTU1psOHpKbP6OWnxdFFL4S2Nr4iRIiOXYFIqCkMTs6?=
 =?us-ascii?Q?ZdSbvHMPJ8Ro7plGbTpJqGTmCyd0U0t/x9qV8D4Xu8PJk8eHP7d5dqV9jacP?=
 =?us-ascii?Q?gLsGfUgJ6bkrIUFN8jSG9ybU2qtgPfzRs8WlEkRhPC1fCPMe0H0k2ft6xfGy?=
 =?us-ascii?Q?jM1FcOBGWxosd+dGaeJxLkAmYq9v0P8B5h+8L/uLEE9BAOFMT7Gv1uq1fSTH?=
 =?us-ascii?Q?vb/v4cdAtgEU8YPtJzwyEkhdi+w7zzzSBXAGDf8lNrLR8yU+XS6+czboy4s2?=
 =?us-ascii?Q?UubxXSderL7u7RucYP2kXzquqcFdQNX1A2rM03DSggYomuPbpe/PuEOcgJUE?=
 =?us-ascii?Q?LSDNoskQBsyNnWhwtzpkqkqK/rycWCXE/Cu8tJOjn7j/msfHGSj1yW/TQHoX?=
 =?us-ascii?Q?x7Bk+3kv0R+gM1HM7+XjjOs+UjjwPkJxoTIGsLIqafHYQnBWeWf+3jlYUhQj?=
 =?us-ascii?Q?B5dPB+F4rCEqIMYZlychrjbW3gVIANcwKJ9JKTCNsHudcZhPK9ARs4Yot9CD?=
 =?us-ascii?Q?zX5Y7MtR2NeZu2diUNrjpaflPGYwInLmDbv5MOi/Ibya/4h0eSWcn4tFS2/4?=
 =?us-ascii?Q?PhGPJplC7CZ4omSTguYtZEgeCVvUnmqhH5GniVCbbNN1jGiiBbHBVpDQestT?=
 =?us-ascii?Q?K1BMkQNPl9LSSd3Ab5whdGOfyqy/soZgcJMmHva/Rzsq7Yyz/84MKDpumF7G?=
 =?us-ascii?Q?2aH49rmbd/sWkQB9NNSHVAobt+0hPzw4aRLvTdeG5Kod20A8Qtdy/bepQBQo?=
 =?us-ascii?Q?GHAUprrNqF8H5o0mSltFifkaZ7u8vz2pkp7n/0bWe0I7EQphD/D59zr0D2Nr?=
 =?us-ascii?Q?FtjVpZYouFd8aGvIPBNcjs6Le5Lq1vu81PH0+gVSsUUZRVbR0y0dc08mrVdU?=
 =?us-ascii?Q?1v7GHw6IwdBzr7syCO9ngDxAOZXrg4K3UCrTyuypHLktBueEMrXgzcO8jkUR?=
 =?us-ascii?Q?9lq834mm8/jSaxflpZvWEo8IcbvTvdnx3veXqRTj8qEezQ59K8L1okfB7lpk?=
 =?us-ascii?Q?lQhA5Mq3TIK8HQSc8SSjcaVuzEamkE6GsWySPN5bPkVwq5scgA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 23:50:16.6463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1f966d-b989-433a-9aed-08dcf54fc6dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483

To support driver-allocated vIOMMU objects, it's suggested to call the
allocator helper in IOMMU dirvers. However, there is no guarantee that
drivers will all use it and allocate objects properly.

Add a helper for iommufd core to verify if an unfinalized object is at
least reserved in the ictx.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  3 +++
 drivers/iommu/iommufd/main.c            | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 5bd41257f2ef..d53c1ca75532 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -152,6 +152,9 @@ static inline void iommufd_put_object(struct iommufd_ctx *ictx,
 		wake_up_interruptible_all(&ictx->destroy_wait);
 }
 
+int iommufd_verify_unfinalized_object(struct iommufd_ctx *ictx,
+				      struct iommufd_object *to_verify);
+
 void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj);
 void iommufd_object_abort_and_destroy(struct iommufd_ctx *ictx,
 				      struct iommufd_object *obj);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 92bd075108e5..e244fed1b7ab 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -89,6 +89,26 @@ struct iommufd_object *iommufd_get_object(struct iommufd_ctx *ictx, u32 id,
 	return obj;
 }
 
+int iommufd_verify_unfinalized_object(struct iommufd_ctx *ictx,
+				      struct iommufd_object *to_verify)
+{
+	XA_STATE(xas, &ictx->objects, 0);
+	struct iommufd_object *obj;
+	int rc = 0;
+
+	if (!to_verify || !to_verify->id)
+		return -EINVAL;
+	xas.xa_index = to_verify->id;
+
+	xa_lock(&ictx->objects);
+	obj = xas_load(&xas);
+	/* Being an unfinalized object, the loaded obj is a reserved space */
+	if (obj != XA_ZERO_ENTRY)
+		rc = -ENOENT;
+	xa_unlock(&ictx->objects);
+	return rc;
+}
+
 static int iommufd_object_dec_wait_shortterm(struct iommufd_ctx *ictx,
 					     struct iommufd_object *to_destroy)
 {
-- 
2.43.0


