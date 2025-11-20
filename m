Return-Path: <linux-kselftest+bounces-46082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6176FC72FE8
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 09:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 70683356828
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 08:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB48C308F23;
	Thu, 20 Nov 2025 08:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a0vqhIMO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245A02E22BF;
	Thu, 20 Nov 2025 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763628899; cv=fail; b=EPLaO/wrfn4cQ9VCBvVBuKaxAv2ptq0bZfv4NiSUss7jou3igQCjtxlA7I464pNDCVLAFfO/As/GsAhrP4gXSl/TD+wxTAkJZPMwkoiwbcewwus7DV3B88uzoFn1dywgqbGN7Fqpvkg9fmEOqcbmH9iZcQgjDGG17YXaeG+p0Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763628899; c=relaxed/simple;
	bh=lngvX/GLXUS2h8ZRwMPm1pUNDpFXSLlqK07ZNN657pI=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=o2kSlEyMMK0uMTpYHObIN57S/PY4EoHlwslpFGpMCJ5gHk1606dbF7Dc1053jtaB86RXgWUgjJL+/9UtdEadksTcD1jK0bVCuPWcJWdRj53JSphUs/LqCQDPdWgzYzBRL1SPJherYMOJGRwhJj4VKfbB/IUeqAlKcl/eVxVeJ9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a0vqhIMO; arc=fail smtp.client-ip=52.101.56.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUQ5TzSJunCIHdy4ZtByTj6YFyrbXxbAIG3OdKzSch1WjWN36wD/j7/1ASK/y/I1zUei9nddYz4NqZVr7WA1GpiYfzGpQxdlh98d/n9M9zNOkgaxamNVGAW07MFxJqL0hfsuVniuH2yGuMvCJCjQm+etNRL3sOboXZE0RXlsVYeRjSmAemyaWVD0YV6LOzmuuoPPIIl4TMVjQHtE+MemzOjtfu/VprrwtFu1e3fsMXgp/coMAqwoxyMktRv1OqS/084HMRs4fV+gMw3EzZW6S62RDBRH2qBnT7Wl1kUFJrR/b0CyIIGa1Tz+G5qcv/Ae5G/nFqT2OcSfyLy0bANJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIYfukcNv14pMjQXVCbxJHMIJ69YElYpVW7tgHDjZtE=;
 b=H80IXWAG5zcxoJFxenRIiAzdC8Mlod6GE64+cJ8XZnHIcgnhc48M7sinNneFogG8W7OlKkVcrwOSYtcGhEIrnKsoqwJz/TooeqYJ4bTmcplTwQ1enlpPreyEpuX7huJ/xSpZ54vRMZrOym508ckKb2psb5GEqb4zZFeaSmlqUtZD2To0etweRicHQLQp7QMq+jUzYIUNckwRaUT2fmN9c8Cm23RKoPwr1ZTetYBB88mUVwaqYLSu7SgI4fPn7feR3F/Na8m8QFMuhaUykgrylata20NheYq0YpCCpYV0h2KXo3rp3N4lGuk+hxia9L0jBVy8UshfjxWxtbGlJP85cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIYfukcNv14pMjQXVCbxJHMIJ69YElYpVW7tgHDjZtE=;
 b=a0vqhIMOu+5d/bvj2narN0D+kNd6eJC/CWES0M8oDenI1Ov7oN573+RiTp0WroQwIJaGqPsb76oz4eTMj+21GEUrQhIFuXIZZeS6OOL5shVpAhZ4gSm9jhO4zoKn5XPUPCMVUuV1lE9HqG1tQzZvl0p1uJEvpvsQcZraVjEqtv7uYQ0fxIwvKwCnuiztkO4HDWw9GzhhMIONnvh26Fjb3x45BhJlRsicTgcafl2VX9H8+hwYPK2tLggetTw4yjK16azWbWLuWc6bdGv2OyG4mjO+Ss87shSmN4kUc4cJBVR3oi2Ux/1dKNqGwGpx0qXKs8pXBJ0m/YnHgAKLq1MQ7w==
Received: from BN9PR03CA0344.namprd03.prod.outlook.com (2603:10b6:408:f6::19)
 by DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 08:54:51 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:f6:cafe::f8) by BN9PR03CA0344.outlook.office365.com
 (2603:10b6:408:f6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 08:54:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.1 via Frontend Transport; Thu, 20 Nov 2025 08:54:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 00:54:36 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 00:54:29 -0800
References: <20251120021024.2944527-1-kuba@kernel.org>
 <20251120021024.2944527-2-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<willemdebruijn.kernel@gmail.com>, <shuah@kernel.org>, <sdf@fomichev.me>,
	<krakauer@google.com>, <linux-kselftest@vger.kernel.org>, <petrm@nvidia.com>,
	<matttbe@kernel.org>, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v3 01/12] selftests: net: py: coding style
 improvements
Date: Thu, 20 Nov 2025 09:54:11 +0100
In-Reply-To: <20251120021024.2944527-2-kuba@kernel.org>
Message-ID: <873469axtr.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: c348aa7c-be48-422f-2cd5-08de281277a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mat2gKibIm5F0F0Ww8Cj5xzB1U+InH6Dmdyov9TCveVGka+FQ9kAfsRmk/q1?=
 =?us-ascii?Q?Fe4/m8P1Lmhgf5EI9qNYgvqx2RfK044Bh3MkM2MnrIGkSDRfHgmK+VLNodcH?=
 =?us-ascii?Q?LXDQbWzktjCGmJhxGxziIetdvhJzPB9W7IA4+guno/SwChF+cW3fKDVdbQTR?=
 =?us-ascii?Q?qBwuF2DFKaH0p70OQoE+6POg5mtO3P7rZjUqxHjSR/n4Gl+dRFX0dv6IpsPr?=
 =?us-ascii?Q?XHmQN9wFjDT2fau/UP5SRL1bXwsjcMlfNYPSgZI7gsBOJyXkUbZC5vIuIPdG?=
 =?us-ascii?Q?5OvU1mSIdbMm23U2p/WxDBrIRJmVOzHFfJTnABLnVXSLATuV8WXCwA4bfqzm?=
 =?us-ascii?Q?a7xRZMg3Y8ywED+t1ouF3O0NipNPqi0po+avQAsi5QfbmRrri8+R4zUd8+ek?=
 =?us-ascii?Q?gSfPkPDQdkiCLcrwO7wJ9L67WQ4+5L3CeNO4MY8EU6wTodN/c023lzEdbjRy?=
 =?us-ascii?Q?YVJsGJRJT9WQS2Mjqahq6k0pYSbNtfZKMWd4Gm/O5eNf2wTdVaMr1SN9c6Tf?=
 =?us-ascii?Q?gmlvMK75UuaBaJUJZeVy85VeZbZF6YqOi/UInyA23NJ9xt5g+w5SPwF2J5bd?=
 =?us-ascii?Q?kl5iI7YgXVDeP1tbCY5NFuh+c+0y4IWcJnm58usko6Ilhs70A2E2GwBmORbi?=
 =?us-ascii?Q?beHKWvGpfZbounxBIy2uTHMqeO+wPsYZ501/LRg5aYASBE1M7XGX2XpB4Pwi?=
 =?us-ascii?Q?+cnZ6nku0u6SoUG70IQlFSQaeIbwjrc2tiSLns9uN6ueNImzvfzCAm+x4h8u?=
 =?us-ascii?Q?bzFx5T8ZX92povY6pWAbFzA6u9D1vmisloQD4zj1OehDi+Psp6InsW0+ZYql?=
 =?us-ascii?Q?SUEJkHxK8VD4MEZezVY5N8UfTccWC8eAo8z6tRBfC3sgT9bAee61qlArCzao?=
 =?us-ascii?Q?3tzwpZaOlixYCVv0YyH7gR2bkHOEVmmSE+jFTp8TENbWQzPtwVSX1mHXja+S?=
 =?us-ascii?Q?QQzWudU+Nn5ztP+mLJKsihjGbOzeavpp1JfUEc7PuO7P9scOKkM5y1DXK0L0?=
 =?us-ascii?Q?N0KuzmcRbO9MM2t+DZcwB14kf8WrQg7slNT3FaglxobdKJWu/y3/7t4DYcW/?=
 =?us-ascii?Q?h2JUZPbTU8KWMQrlRbWs9uUctCM5DtxlX+tV1MJEECI+TYQcfrFQj1Ix8H/R?=
 =?us-ascii?Q?LhqwZdF/oaJosq2vAQlLGMcJ3U+OTrYYgg0TOvSXJD7SBx/C6LWb8ZPbC0St?=
 =?us-ascii?Q?ZKrZononfBSgBqaZ6NQWNeNKegg3BZhq7986vz/2wsgRMAw5EPnu2upP0eUs?=
 =?us-ascii?Q?Xy+1/6F1d6uHVZqvrXWVqaDERaHCv4DuPaXE3DzhrIT+Fvfjh16a32D7SaKk?=
 =?us-ascii?Q?i5QkOweqli7AG4h9gtwbzfXvLbi5Sqj4vkbB3++WdudomGh7eq9oHYR2kCte?=
 =?us-ascii?Q?fH5R/hq/vyVjglyfpCv+hfVoEAFTX/G7aYNKYukTdJhLiT6VZZ9DDPZKiKIr?=
 =?us-ascii?Q?aRQnkzZHuIVNIR+IXbEgdx4GmZBFQV1kohqdZoNwP9UJQPFzcfm19EYzSnOP?=
 =?us-ascii?Q?4l9sm5MuoUXEzo28kvE2tmWsb/TU6RFUSbqRQX4w8/5gqmNssTFr1uYRqODm?=
 =?us-ascii?Q?wu/rqBvisGyL9BGk1Sk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 08:54:51.3161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c348aa7c-be48-422f-2cd5-08de281277a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041


Jakub Kicinski <kuba@kernel.org> writes:

> We're about to add more features here and finding new issues with old
> ones in place is hard. Address ruff checks:
>  - bare exceptions
>  - f-string with no params
>  - unused import
>
> We need to use BaseException when handling defer(), as Petr points out.
> This retains the old behavior of ignoring SIGTERM while running cleanups.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

