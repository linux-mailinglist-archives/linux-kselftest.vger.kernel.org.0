Return-Path: <linux-kselftest+bounces-44123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F06C0FA54
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 18:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D91AC4E4F71
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 17:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44D7309EFB;
	Mon, 27 Oct 2025 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GmXlYQy+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0C02836A6;
	Mon, 27 Oct 2025 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586274; cv=fail; b=OQn6UMDSLcczI60M3z7wAsmK1xFs5LkKm0textDuAdXgl5kgITQDu3irLhHghOZ0khMEtN25++PF8F83729u2nvkFMEV1pfTxeH+6X07jVXYv6bOam5TEb6aw6JnLM28LgMqRtgyccqMGHhZfHOEmxNxFUlY+4Dq7VJBR4NoDFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586274; c=relaxed/simple;
	bh=0a4v4iUrq8FWHbo5num9j2eYAki0vqI+lhtEghGwHTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uag+1fsuYx5gZJ1ynaZyErcNp3Gk1jWDcGf6VIE+L2OCvNDnOScUWI81f3OlWTOyKLyJZ2AqpCSBXvtdE8mrNMfT23fOEaULriM3+s/iOaCMB2Y7hcq9Ilk0OKIF2PhzxOtJ0r4JDPlNGZxSrJCtJHbeVbRQ7MYidIVOuctZl7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GmXlYQy+; arc=fail smtp.client-ip=52.101.53.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mt3eNA8K8H3VZG8CImXnl+XF0eb5PQNXwuz08UiPsz6So5nOyw6lYiM+ETqBT1HPbKo+/U6aotoMwiLlB1WJ6C9zQvBarJGmVyx+HVvsqXNZRIXoxCdSXrSirpq+IVQAVlfXJj+SB9WYAoDRki0aZeUdtc6UAGe3+Hd3pgbqkXtNAGTte/Ag2U9cR/eFCQPIMBSX2IpR5ebEVX39LxeKHeG1GG9VI1n8fdZKS8DpsvlBfSuqvBe36zEz322OAP8744Dg64u91OB6a9UU98ShmkqDt+GsioiTGg0Wbn8pYaQgjoRmu4Hq813fSKwmvLeKtCHobO637oQaeUFcpNPEMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WPCu2vgluDYQgKFqrrh92nEjRvWaE0YuuC/Clw85hA=;
 b=WANAHy5jyvQgg+vCdgvkD2hWCvha2T0CqvthRp/Q+3ceVsNwB8C75RbOGwP4X1Lo7QZGKXuS8VFDzEj+MmgZd49tZSMpDJJCImoQ/+0SJCkeAufb8ouJftag90qU0Orup49UBXcqUxDJ0cRw3wtv7PlnXIXa/7miRTS6ZM3aGC4OLOqYX1X1zHKxAABpSBLLZIAaXR5rCQm6dWqqKzRtMOqBEHHc2QDKy6iXLZc6rKgiLCw98R5YHOS2lmECNNntmNgCNwXpobjthnInRKSRf8l/pgttU1+EjOIiJtDAScRnRwDJk+z67uHSMdl+WoB5rQztgxLDO/NK27xN904FgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WPCu2vgluDYQgKFqrrh92nEjRvWaE0YuuC/Clw85hA=;
 b=GmXlYQy+aHChJqeTkTqjcPuRAVDsp6K0ufa3IhVOF2zfj5xPsSh4PlGV/U9I2T/uaReZcmzBsPZw4mYD/IUBe9wWBoEO885xiGcwHezlMvRxarcDv1exovlwqfk6rR1EfqZPSNiqtCRre3lFsDlLp35+qluJjzBHqt35m1ygEHr75oTjZU9OreqCchDkVVjNsBN4PhwrV8nTNjRYiVTXlsLktw7WoQsRnjwB/ojcNykZwU0O70My4Q90Cb6sZBZ4n62GdeijpxC4nt5NXJ/RuZgDxMnbOMsXyKD9uooNTcVNdERyC+YbWS47BlIyUcogQyOVjGFEqQLq3uTcCGV5ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by BN5PR12MB9539.namprd12.prod.outlook.com (2603:10b6:408:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 17:31:10 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 17:31:10 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Will Deacon <will@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	patches@lists.linux.dev,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH 5/8] iommufd: Have pfn_reader process DMABUF iopt_pages
Date: Mon, 27 Oct 2025 14:31:04 -0300
Message-ID: <5-v1-64bed2430cdb+31b-iommufd_dmabuf_jgg@nvidia.com>
In-Reply-To: <0-v1-64bed2430cdb+31b-iommufd_dmabuf_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:208:91::37) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|BN5PR12MB9539:EE_
X-MS-Office365-Filtering-Correlation-Id: 00461691-277a-4c88-0924-08de157e9d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aFygjtFKDDrvf6/PgcXC5EVLi3R8yj8Q9xwou8l9uKXzDdyK4XERH5swDQFv?=
 =?us-ascii?Q?xBHj1mRv0XojhS9e7yH5eLJEITJpw8nwl5K7pn5SpXi/w6ZsqYRZY7yecqAh?=
 =?us-ascii?Q?Vo08z/Ajzik+ABnoXqP98rxKpGW7J6OaIQ8MKyoS1+nLGlJkq9K8oB5PVgIS?=
 =?us-ascii?Q?uWxvOUqC7TaQU37nw94w8kRg734JC8p90BxBqM2NvJvjfqcjvaRfSJy6z2LN?=
 =?us-ascii?Q?YQfJzupLMqeH6B6qWxMh5ga2NuuNPElmq189au7NaMlMIjP+GkBuP41UvxRS?=
 =?us-ascii?Q?V5D5BQ1j6fwk7g1iNh9EHJp+CWPq6xHxzzSNXslUhKUXZhBh/UT1myfNB5Mv?=
 =?us-ascii?Q?wV5rv6lff8668DEd/stjMEp+AitsRO9bgMEq3GMk9XL5nR+GSW5xD4YvRl0B?=
 =?us-ascii?Q?3HY2rZvTwCgzvk82LRzMyBDBdCN5ikTO/OGLVgjNaMMHk00bprm2HrIHoT/+?=
 =?us-ascii?Q?ir3cIBy3Lm/SuImnjcBeajvWj66B3msm/3xgD63DwvaiRl/qQEf8nQkhJe6H?=
 =?us-ascii?Q?rZ+pqIIpVTT8HC51OB6NdpKlGGE9q+6Z//RtuCQZS4Ic0RLWaExfpLoqh/JZ?=
 =?us-ascii?Q?FboQRB+fs8xcIn2WHCDsNZqCR+9uvCiy8Kid3U6GnVkWPjpz3d/ffY/lAWdx?=
 =?us-ascii?Q?4zoKZJ896HLPH3Vqiz5GxLop1HGNK92hX3o92i8Cxu6VrAdWqmBFe/VWSKdv?=
 =?us-ascii?Q?++VcbYoqYIQQ9Z6OM//WQs3o3o2khGkiVkDi60zLVxZLEGmV86ZAw4EZUvVz?=
 =?us-ascii?Q?DL90oq3V8afBcqreCHH4uq/emSVynLOvfMFZJhGzJsDLwo9aRNN/2fNjbX/a?=
 =?us-ascii?Q?PbTo2a1ItVecl2dSZ/AZCfpGBXHNIJJe1nMUXp4tZrT/kxDEXDKKpotEFsDG?=
 =?us-ascii?Q?y+QNm9u4oFQxrNbA9eoCUuiysXkVPt6kUo0RwPbo2zK0hd1gjY+PttduPuyd?=
 =?us-ascii?Q?9hBiH5EasB7CKt606LiTOZnEltV8ixNZd/PBqoCN9WwfWJAdKjLFdn5rssmm?=
 =?us-ascii?Q?RpFmbZJU3E4NZ3gp2zhdOSQ/m0lW8eFbJ0vHOZYVn/lNCZWPRuDfSGmtR9UL?=
 =?us-ascii?Q?pfUxFM3BmEcbAbvebqTqX79WsM3byx2nqk7l4QwYAY6oNLalaBzPvzHfhz1M?=
 =?us-ascii?Q?nlmBA29zqdVoGNChwr8L93p9Xew9iTsoNA59NUit2Qc5BrHtQmUGxd0EAgXx?=
 =?us-ascii?Q?V0DzqE/pDFLcor21Zfu5/TaXEITuQcFQMel3KBYkBQYGEaNC9c9Av8sxd2eI?=
 =?us-ascii?Q?LzcIBcd0zho2EVkLye/kYzeCAtuDiUo7tBeijBM3Wr6CCC9g8x2OyMd7idfg?=
 =?us-ascii?Q?1Iwzx3Oi+hapndKby0sUgKEW8bG3JVRAeGCYJBPj9CskZl2yq6vm9Id37W1J?=
 =?us-ascii?Q?zTKeOZi0DQGybzhSzY+PzsZjwuGJUVQPd0dgF4cN6+po2JVbqSLZ/VmKgfCM?=
 =?us-ascii?Q?3+Bzol9CLmdj/CP03VWX5+Sjx5Tme0hauujWYOKB5HhfVLxkPb7Ld5h1XUwJ?=
 =?us-ascii?Q?4pI9HE7SUgahwDc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jk4+MpBlzt6Orba95804ehRXbXMClMBSQGQ9IZpm+gDEcxH0WC1b1lstFmRP?=
 =?us-ascii?Q?C9lHdHneQeHlkkSl/dKrX4UM7/IyNxYKPJtrxYd2Wj5gsXOZ0lEuZyGTgJlp?=
 =?us-ascii?Q?WsvM/wxE+ZBSgwDM9AmWn/4aSr82cTqDSh7qVg6rf/gfqbQ8lGxUnqJJ2Fho?=
 =?us-ascii?Q?GwLKndAu/zECY9hjWZrTokaiCxHaMIT2+T2XBUgA5aZ35Y6XPMgVPnDtnsv9?=
 =?us-ascii?Q?eCd0qnJStfbU/sywQqmkGq0I0vGA+KffBbu1cyGBGhWePlV8FrBJacVAjLvk?=
 =?us-ascii?Q?8iCGhLZFUUWVCmNdo4ilEHda47xkhDSUiNdaqjtOywuKFL2cRKeF+KSDWOn3?=
 =?us-ascii?Q?BW2xFFB0efLdWaJADUyFR04k/QNWlObX7mTjKPjyAG3O4Z676U/RjaGRQ08D?=
 =?us-ascii?Q?3l0UBYmXTIuSGheKa8S/do+le0Nn620+mg3Xind9onDS1whXFtYM6kbyrqfE?=
 =?us-ascii?Q?wtnHpZi7SfB0jgwVvNk6VhBSV1HSUf+BKHkKg05KGaUFYZ3hQ/OYybZD+HkE?=
 =?us-ascii?Q?u+oxryKQPOVUWWhHBq2MS5/a8v2JA9osvexDnpFRt4ElsZjSMgBr1ZcC9ine?=
 =?us-ascii?Q?OtfnZoQ+IOV+G7G9GYnyRQyOqzkKXdfn11HJTjAe3zx3Jwt0vUGaXayG0YVA?=
 =?us-ascii?Q?d8JsW+zMCjBT6+pjRjcei1f4Xb+7cmwHsY/ryyU5xfIwBBQyImpBPZsIwO+m?=
 =?us-ascii?Q?QQx5GSdOMwSlZvwFPuj5/uj8p7AsgtckqWMZdlG3YROzSgHZb5zXvjSwsdwe?=
 =?us-ascii?Q?QtW5VofzI4uDsnH0ZLEvgMopJ5cdOvu0wcifJFYqASNeMPPPwuVbveOjJVaZ?=
 =?us-ascii?Q?RJEGLaBBSLorXU367LFJa28gKChGPeTaPghiu4MroMuvt5SyaoH09AWgBHv4?=
 =?us-ascii?Q?uggJ67Dd17eWnQj9JxeuIiKIgnhPYkBm5a81jZGI6ln5nu7+qP0QtsyF4/y3?=
 =?us-ascii?Q?dgeleuX8SkJnrvxrO7yuRoKEokxGYO+UzlziTkS5xSI07n0Mh/qB/rVSnNmW?=
 =?us-ascii?Q?J5/wyw/d22AdxZvLkK/WuVrKEWmVL5xplBuM6ur5vx2b9WAsTjA/5/OW2G+D?=
 =?us-ascii?Q?rOZhMeTAIXQBHuaijwjWScMarWb6PEHpOUrB6ozPOIxKvzDW1R6CSau6eriY?=
 =?us-ascii?Q?8ZVA0Gw4Unl1xTIQfNEfF/x9N3sEkJB6PQOrfMjBWlEtS5L5B4jVk6ABUPjp?=
 =?us-ascii?Q?pILJeSmEuiVBaGlEmvmcrUAhBEN99LGo4RgugWzhzrr8wUlBS384HL5IMkzH?=
 =?us-ascii?Q?xMXMuEbg74BP5eKyH3lSqF68fVXPMxB8qA2XQB9CjETRXj/H2Iq6Rd/mDxBe?=
 =?us-ascii?Q?e5I2sCAL5LfHgJAJQyB/WypCNthaZNrx6Qn9XOWP+CpOK1KdNF8jAU0k3ezY?=
 =?us-ascii?Q?hBXVcTD8rynPUo377enXcUoDjd9MgFpjF3rB4XieOeEnC6jg0McTFCAwv+x2?=
 =?us-ascii?Q?+6wQK+PYjqOSKH7RIf4wnrsafTv6HVv3o45uuSTiv87ouLjc6QmQj6McwtX5?=
 =?us-ascii?Q?+Tu+gjOgxzlrQmQccowa0e/oqLzkHuFenDLzj6CtLQJUzFFgK+s/bSLHiqx9?=
 =?us-ascii?Q?Xsy2eMc8gAq4SpZRZTw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00461691-277a-4c88-0924-08de157e9d79
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 17:31:09.2803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SIV1RxFvoSoMoTR0HKiambWuWmO9zhnq0qDz4YV23b/rbxF6TscfP/oz6TP8wcPQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9539

Make another sub implementation of pfn_reader for DMABUF. This version
will fill the batch using the struct phys_vec recorded during the
attachment.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/pages.c | 70 +++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index caafb5faf55a12..9c017064322b41 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1076,6 +1076,40 @@ static int pfn_reader_user_update_pinned(struct pfn_reader_user *user,
 	return iopt_pages_update_pinned(pages, npages, inc, user);
 }
 
+struct pfn_reader_dmabuf {
+	struct phys_vec phys;
+	unsigned long start_offset;
+};
+
+static int pfn_reader_dmabuf_init(struct pfn_reader_dmabuf *dmabuf,
+				  struct iopt_pages *pages)
+{
+	/* Callers must not get here if the dmabuf was already revoked */
+	if (WARN_ON(iopt_dmabuf_revoked(pages)))
+		return -EINVAL;
+
+	dmabuf->phys = pages->dmabuf.phys;
+	dmabuf->start_offset = pages->dmabuf.start;
+	return 0;
+}
+
+static int pfn_reader_fill_dmabuf(struct pfn_reader_dmabuf *dmabuf,
+				  struct pfn_batch *batch,
+				  unsigned long start_index,
+				  unsigned long last_index)
+{
+	unsigned long start = dmabuf->start_offset + start_index * PAGE_SIZE;
+
+	/*
+	 * This works in PAGE_SIZE indexes, if the dmabuf is sliced and
+	 * starts/ends at a sub page offset then the batch to domain code will
+	 * adjust it.
+	 */
+	batch_add_pfn_num(batch, PHYS_PFN(dmabuf->phys.paddr + start),
+			  last_index - start_index + 1, BATCH_MMIO);
+	return 0;
+}
+
 /*
  * PFNs are stored in three places, in order of preference:
  * - The iopt_pages xarray. This is only populated if there is a
@@ -1094,7 +1128,10 @@ struct pfn_reader {
 	unsigned long batch_end_index;
 	unsigned long last_index;
 
-	struct pfn_reader_user user;
+	union {
+		struct pfn_reader_user user;
+		struct pfn_reader_dmabuf dmabuf;
+	};
 };
 
 static int pfn_reader_update_pinned(struct pfn_reader *pfns)
@@ -1130,7 +1167,7 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
 {
 	struct interval_tree_double_span_iter *span = &pfns->span;
 	unsigned long start_index = pfns->batch_end_index;
-	struct pfn_reader_user *user = &pfns->user;
+	struct pfn_reader_user *user;
 	unsigned long npages;
 	struct iopt_area *area;
 	int rc;
@@ -1162,8 +1199,13 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
 		return 0;
 	}
 
-	if (start_index >= pfns->user.upages_end) {
-		rc = pfn_reader_user_pin(&pfns->user, pfns->pages, start_index,
+	if (iopt_is_dmabuf(pfns->pages))
+		return pfn_reader_fill_dmabuf(&pfns->dmabuf, &pfns->batch,
+					      start_index, span->last_hole);
+
+	user = &pfns->user;
+	if (start_index >= user->upages_end) {
+		rc = pfn_reader_user_pin(user, pfns->pages, start_index,
 					 span->last_hole);
 		if (rc)
 			return rc;
@@ -1231,7 +1273,10 @@ static int pfn_reader_init(struct pfn_reader *pfns, struct iopt_pages *pages,
 	pfns->batch_start_index = start_index;
 	pfns->batch_end_index = start_index;
 	pfns->last_index = last_index;
-	pfn_reader_user_init(&pfns->user, pages);
+	if (iopt_is_dmabuf(pages))
+		pfn_reader_dmabuf_init(&pfns->dmabuf, pages);
+	else
+		pfn_reader_user_init(&pfns->user, pages);
 	rc = batch_init(&pfns->batch, last_index - start_index + 1);
 	if (rc)
 		return rc;
@@ -1252,8 +1297,12 @@ static int pfn_reader_init(struct pfn_reader *pfns, struct iopt_pages *pages,
 static void pfn_reader_release_pins(struct pfn_reader *pfns)
 {
 	struct iopt_pages *pages = pfns->pages;
-	struct pfn_reader_user *user = &pfns->user;
+	struct pfn_reader_user *user;
 
+	if (iopt_is_dmabuf(pages))
+		return;
+
+	user = &pfns->user;
 	if (user->upages_end > pfns->batch_end_index) {
 		/* Any pages not transferred to the batch are just unpinned */
 
@@ -1283,7 +1332,8 @@ static void pfn_reader_destroy(struct pfn_reader *pfns)
 	struct iopt_pages *pages = pfns->pages;
 
 	pfn_reader_release_pins(pfns);
-	pfn_reader_user_destroy(&pfns->user, pfns->pages);
+	if (!iopt_is_dmabuf(pfns->pages))
+		pfn_reader_user_destroy(&pfns->user, pfns->pages);
 	batch_destroy(&pfns->batch, NULL);
 	WARN_ON(pages->last_npinned != pages->npinned);
 }
@@ -1687,6 +1737,12 @@ static void __iopt_area_unfill_domain(struct iopt_area *area,
 
 	lockdep_assert_held(&pages->mutex);
 
+	if (iopt_is_dmabuf(pages)) {
+		iopt_area_unmap_domain_range(area, domain, start_index,
+					     last_index);
+		return;
+	}
+
 	/*
 	 * For security we must not unpin something that is still DMA mapped,
 	 * so this must unmap any IOVA before we go ahead and unpin the pages.
-- 
2.43.0


