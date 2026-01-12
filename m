Return-Path: <linux-kselftest+bounces-48738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DACD11F2C
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 11:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3600300A7B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 10:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11892D0C9A;
	Mon, 12 Jan 2026 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QouRIW2m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010055.outbound.protection.outlook.com [52.101.85.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5840F2C21C2;
	Mon, 12 Jan 2026 10:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214318; cv=fail; b=l++c96u3SGAFuWRWEDYQydKLr0PVyvxp+bMuGuFgIMtlLOutZxdxN/3ZGEu0ukPerklGkzz5CyzqN4+mt3iUwljjub22+FVDNDcQxPgdZPY2Uw3jKbIh4EnIGKsZvb0ai1hZsjxDfzkVioeZswreb+aEIciIx9Eu9ufBWci9uy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214318; c=relaxed/simple;
	bh=IXm30fGUmo8eo14QhLVaMnAFShrPgOkSLzMpioRLVVs=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Pb7xNCfJZhi83v9oQZSBCEa3SOOQZyR5UhGiLAjEXtziRb3Nhc0OlMNV+J8Ww2HTuliQKPjHuzlyd2dz8SB0pnnnttb5V4KcQV4Vqflff9gcfuvsGp6UuIVaa/lOYMr14dhS2xpLJl8hr0G4kWO1oRpE0BqiBsq+vuOA0dadT78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QouRIW2m; arc=fail smtp.client-ip=52.101.85.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMGJ0PSAu0ir51+VpzVykhj4604ASXzuFYChAXlRNi/61Ldme00+g4jgLUJux6/dyQpmDxfqWdbmNRTybuIGRanDLSPqEi97hm4PhE2SJ7YFbMP5yW3k93NoWvd4TU/dohjT+bbXp709lHLCDvVuuMvW7cYGi9R4+WU6lFsIdfi7yUY79Doek0GKDOlsLqsR903Yis+uW/sdK4iahEn70Ki0Y8y6JpAtjzIKCv3kMhCZyOoCuLosotwJIgwGB01+1DZFO7O1viCsH+q/kUiYZMHLZu2xAIpldVQjLZZj5ZRlIX/DSQ/OW9MfGyAUbMVlMiMHTHmTx+K7VRF4hWFiqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joeWtUxGn5/MW0LnNuGZLfxYIMBRc5ze7CMWpAj2ZWI=;
 b=QSqllT2yrccxdArWUxUpWJWzbS/q9ixDGDVuhQE4I1QaB1GPNaDDkHapPDNtTxOvRdzmI6QQJiClg5d0Nkqdp89zWxlBJTfzeN9KSSB3Wr5YbbLSRuVDqw54G1lA5+yobhfS0WS6CyHx6qcNV7j0jQSt3SzCB/MeLQKElhreR0sepYA2N1IWJU16MF9J3SfcPVuNJs1Ack5uvAYu2YS0bfJ3G+84tEzk5BMWdCAlYhm9BFKsBqYCFpkKCH+qV++757AG36VbiOlaYZS+HKuU/OOYwYgh31qAgTAa3hn+/WfbMw3TwniIstcLDSmnQCW2VmzfZS/2nkjB2GQTHpwbOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joeWtUxGn5/MW0LnNuGZLfxYIMBRc5ze7CMWpAj2ZWI=;
 b=QouRIW2mBZ0obJUuUTml4uiChU4Oj/FPv/3sfnqo5N4q5i2jA3hxNhCSIjcY8vPbes7IsFe8c9mF8siertFF+ZSqSaHdhXpXWL4LrtCXTiAJb8TlkPHZCVr4rTZ0EVsUY9sNvy0ODpwqYyqrj5qBTLZ0dP7xiW7y03Tm4crt2uyvZU/Rzkk7BbpBZIZ9bdU1/c2kJISvd/JBOzo0H2Lmg9yPu8MwtjjJc9U5FkYvvVHjYCBXLVkw7fmKbxBizyzuymipzNUNB3aVD9J/gFPEclxQpN0aT1waZpdSoOOBVoDOeJY/Er25Pd/tYyTMF+BiNaRs3CwMIzq5GLHQRXQOcA==
Received: from BYAPR05CA0057.namprd05.prod.outlook.com (2603:10b6:a03:74::34)
 by CH1PPF711010B62.namprd12.prod.outlook.com (2603:10b6:61f:fc00::614) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 10:38:34 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:74:cafe::c3) by BYAPR05CA0057.outlook.office365.com
 (2603:10b6:a03:74::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Mon,
 12 Jan 2026 10:38:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 10:38:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 02:38:18 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 02:38:12 -0800
References: <20260110005121.3561437-1-kuba@kernel.org>
 <20260110005121.3561437-4-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, <sdf@fomichev.me>,
	<willemb@google.com>, <petrm@nvidia.com>
Subject: Re: [PATCH net-next v2 3/6] selftests: drv-net: gro: use cmd print
Date: Mon, 12 Jan 2026 11:37:56 +0100
In-Reply-To: <20260110005121.3561437-4-kuba@kernel.org>
Message-ID: <87h5sr3ylw.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|CH1PPF711010B62:EE_
X-MS-Office365-Filtering-Correlation-Id: db816ca0-b03e-49b1-7623-08de51c6bc50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uEUqNhlPounmril31qxTKF4uGTWW4LHRXvC303m0/DxkfA7YTsk+7yAk4WhE?=
 =?us-ascii?Q?fJfXfno3iqppud8DLmWe4Kgne2hmBlRuTCHjeJOqJCccx+aIhBLtAqF5+oqo?=
 =?us-ascii?Q?qQvBlU4IouGryoJ3jKum/L42jkJFxTuj+5u6BvODjfgXerYItX2z0oH+PFc8?=
 =?us-ascii?Q?TkGnFEFvNFgQ981nvIJqdOlpW9DOTaIW3C+wd42jb0KhMqVWC2KeRoAMfBij?=
 =?us-ascii?Q?hklqrBgAHhIR3dK/8ZAYtvK3ZfiQNZjpwoODLYXB6AAx3oSKXpPalNg0w7rA?=
 =?us-ascii?Q?402lmAc53tMSNCn4gG0eMQVPJVWgj/pAeID7D6NIhBrUAhKOVfkSLgEd/Q0J?=
 =?us-ascii?Q?b9i/2PsF2NUk+t6doS2c8kxd/JPdJrrwy/t/XLyUcrlhjNXphHd4SzvSpQpr?=
 =?us-ascii?Q?AIrGvRjiMePJX57HeXt7sOD7qY6mkeMach7UGvo45xHM1dYjesuQZ97g8/W/?=
 =?us-ascii?Q?VGBVhB96YaYUR18IW3cPItT6Z4aX2xnD33FkkRrA2tdP5Dj1UdT2r4grusZJ?=
 =?us-ascii?Q?OltT87K4tUrEh/oFxMKiztarm9vVbCVKRpihT2jTukmNR3li5jTQ/nflOzqL?=
 =?us-ascii?Q?J57xFSkre6o09MVvSx/OgPZvJtgp4sQ1Tz5jJ3mGN0GAwjxoVgXSh3nI1O8+?=
 =?us-ascii?Q?iO8IN5VptVHgCaa1tqi6IAjGMqnly4e77kqvp3bfdy8S/PJS0nz0EOprF2wF?=
 =?us-ascii?Q?OEeODGrR9iV2n52VyiHSgQwIf6V0fIMf3sJVicl4keYuQKdDP//SX/vb3ucs?=
 =?us-ascii?Q?xzUR3BvmZXlxB3YZRAQd6HCIBXpCPyV48rg5lQlkOiwsRdhNeEwjvYurdkRk?=
 =?us-ascii?Q?q7ryouCa0vCf6C6ftddtK2gPWDs8BSzto8Y1Um7o6Pd35EZaW5QGesqHRoiW?=
 =?us-ascii?Q?wLzpeZWs7Wl/Cg/tAzHd5rDd9MJ3s86mxaSICZ3CJqXtdNWdDBqWYrCMaTEA?=
 =?us-ascii?Q?GcdqdQKdc7DE1AHFwqKodOO/KkMq8sY4WWrgswldZ7DOgRhDl3W1+RgtLOXi?=
 =?us-ascii?Q?bIEg4RsnuMY7BC1+JZ0wgRXS5tFBVDiGl4lPoIZrIfDzucIE2teSfByHvEyC?=
 =?us-ascii?Q?RBh6ATeBDp9XkflNp7R2V+mLl188Cb7kH9E73VVVLP6luMfEr4GxgUJkEuUV?=
 =?us-ascii?Q?4S4hxz9WxGevm5y4vpuwtIGHOnpjQykQY8sUE1zYG6kOemRGz/Hm2t784rBZ?=
 =?us-ascii?Q?mm0I00BTDOr0KDRBcUBcmWuKWG6CmU4+E1gXmu8PsvjbJ/ai+2FWhfnjKV1M?=
 =?us-ascii?Q?kEb7MjcG5FpFYfSBQqFsnqVCHrekNDreP46tkI1mafJXyKqJ+3HEAOqHu9m+?=
 =?us-ascii?Q?PDhGBP5GRi6IJugbz+/1mHVkFbwkLzA9hF8F/Pz2jps6H4K4L/fkyaVg2aO1?=
 =?us-ascii?Q?TfSpYN3UQMz/Zw5CQnD8T0/gLiA2U5zF9H5BgdbH1HwY07glt4rULOS+iMD/?=
 =?us-ascii?Q?1wonOqa403dTUmriMFa8f757h3/rOJXWwXLyuBfp6TMpLC1hX8EE4q2s6lSS?=
 =?us-ascii?Q?FDgmRFTlTuW19h6qEoJL4f9TV2KeAm64KndJxLbFFBddt3cuf/m+1qxY9t2G?=
 =?us-ascii?Q?oKIIe0lO+gSbqmaKOuQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 10:38:33.6642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db816ca0-b03e-49b1-7623-08de51c6bc50
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF711010B62


Jakub Kicinski <kuba@kernel.org> writes:

> Now that cmd() can be printed directly remove the old formatting.
>
> Before:
>
>   # fragmented ip6 doesn't coalesce:
>   # Expected {200 100 100 }, Total 3 packets
>   # Received {200 100 }, Total 2 packets.
>   # /root/ksft-net-drv/drivers/net/gro: incorrect number of packets
>
> Now:
>
>   # CMD: drivers/net/gro --ipv6 --dmac 9e:[...]
>   #   EXIT: 1
>   #   STDOUT: fragmented ip6 doesn't coalesce:
>   #   STDERR: Expected {200 100 100 }, Total 3 packets
>   #           Received {200 100 }, Total 2 packets.
>   #           /root/ksft-net-drv/drivers/net/gro: incorrect number of packets
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

