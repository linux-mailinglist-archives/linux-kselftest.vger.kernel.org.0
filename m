Return-Path: <linux-kselftest+bounces-48021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD09ECEBBD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 11:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D98A13022A89
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Dec 2025 10:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F0C318155;
	Wed, 31 Dec 2025 10:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DHHgEUFX";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DHHgEUFX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011050.outbound.protection.outlook.com [40.107.130.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A840B3168E7;
	Wed, 31 Dec 2025 10:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.50
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767175754; cv=fail; b=GPGhfdfr0ZygejBKCx5MIiHuAWRTD92QRcbTeMaWJf025VweTCPC3WdNtvGgr4vwwaU2tVN54YYvfRJV5MbWvv0UZ8i4kIZeUJHjnBjrDi1ztJw1D8W0GWQgCCj1Qt8X48/C7FnaNHrMKkt7NB5Zkh1DLSfKtlsup/0BKUgPgdo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767175754; c=relaxed/simple;
	bh=thITW83S1bmR7d4klZj6x3FjqvIjRbmjIJ+J09EYFjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JSoKpTswfIISdfWM1X5BoOFhFeFjBZtn/wLC4m6MDxGE7O01qeA1FyLGtzdEkH2b669CuQhMOEAcFWJIYcBlNcOClnQDrmp7whl4Qo5MyLkIEpwpdENJoEdmfZEpBHMN4bZmcRLMo05FtncEbzFYFdU9nCGgn5HuiUmrc2ptyaU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DHHgEUFX; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DHHgEUFX; arc=fail smtp.client-ip=40.107.130.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ml4zzm+OIkBUV2807T6gmywg0pD4CYtZjBeaC7hwqs2h9bM1lojEXCgCrDtGU3dAG9PEX7a3eRxOmUq48Q/gfJ+aKKbAHITXphBZg6rLBz7Z0aFxskpqeAhdnq6rftVjZEPKz8dFTQfjLSAGH5rsdFJHGw1ws69jRWf/rsKJm5V6OzcRMIFlsWsaxAEHl+Hoa5DmN1VOdBdgAKLiDSeKf6Nt9VH7c2mad0ANm1WC7EWsBNnbYD6W5VcPhRRTYFrKb1YWbHQe+7dUUPMpCSX8KDIrFcMhBhvR/KgzhdIqhZv0eO+OjRvfDq8rP0uWEiyHztCp841CVkgvBJysVBmqKQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMg6qJwDCLB2FN8tzG1Vgw40LkMGbuxtueq3vNuunhE=;
 b=FHhmekof9D67aJkpx+MK+nR8ugADSuuzpij9xN3ihOAzPhAT+jlWz5pEvZdPANMkS8RpFWvnurPpR0dRpbJbR2iirjAr1zIYtADTYDh8uTiD4koyqx2kT7T3IkbBfwMYJ7ZZwJlgGUTiMbIpQp64NtgP3i5le689T4QadIfPF8Sn3kEnyLzazJwcqVhRPYxGXuimeLl8/6Q5xU6VSz1rdax9q+UkZQUKoCLh8V4ljpnFHo/omH+oRuOUU4qpVI2MXxh4Xh5isrA5SkKFw/+L+zwHvkFj+awym3jSG6J9UVyWnBJAfvroDUEX4exRB87tq0UZtS8H87olANkGuwW68Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMg6qJwDCLB2FN8tzG1Vgw40LkMGbuxtueq3vNuunhE=;
 b=DHHgEUFXQsEMvM/cJzb+VL9vYNMioqIy+didc9DxRWQNm5P1HLP7lcvjidSILpS1zFKM3Z4UKBD771OwGun8WbzqBvTY79s/ie6JR9syoinmFM1C0RZeCorDw+8ALLi/U86IG3BG7Zcxw9eriPW8GXr3haQUNXsWG5jWa5fPXHA=
Received: from DU2PR04CA0155.eurprd04.prod.outlook.com (2603:10a6:10:2b0::10)
 by PAVPR08MB9722.eurprd08.prod.outlook.com (2603:10a6:102:31d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 10:09:05 +0000
Received: from DU2PEPF00028D00.eurprd03.prod.outlook.com
 (2603:10a6:10:2b0:cafe::e7) by DU2PR04CA0155.outlook.office365.com
 (2603:10a6:10:2b0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Wed,
 31 Dec 2025 10:08:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D00.mail.protection.outlook.com (10.167.242.184) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4
 via Frontend Transport; Wed, 31 Dec 2025 10:09:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xk0bKIBEWBn3g6gq+JTbpdnkvXw513vk5EQ2YcE9UOoGZIbQ+9D+6y4YFPAPOyZCo1W27np1thNHx/S+zuhlty1px+0G27uKDguHXlaD061nUWaXZnsAVjHkg0WFRxtawBJdYJgNl1q2dSacwBMhxIjmj6a8Hybu5De0MGm3fiU4R7uEu5ibqpbUrg5Tnqjl3SUCXgEAZOc3oaQAc28g99ZlkjhELh2HZH/XeFlU6oLJUe0JWKgBgApuhO+66Qi6Tij2nFGoVZRkoeo4+eizW45PNt7k/hJodEnFWfcrW5xLVdX/C2QpGx3NZ7BKmyFOfD3+ZwfgEpxxayGeFdEtZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMg6qJwDCLB2FN8tzG1Vgw40LkMGbuxtueq3vNuunhE=;
 b=fCfjfHi8rNkRiUH3rWX3nWI1SGGT8sq/Y8bAFkCGXN6BqO2wKOFKO1lmT+8+KBj1hHAU+JHlI1LvSgtgup81jwo6B7GMR3mDWXZzkM3gOxTg7BqynyibRJqen1CPDMkmhF2y3OdNbUJV9FpCV68bspxFm7z21IfznA4I2fEiXjodzGMDJkyhjnj39acAjapcDjJF96tOuOwgpS9jIuQBpmNawC6Ji0nxnsxN/GyE6AjrMK6gCn0qb+8+93ul0Q++Dwh8Q+RTqthUE4AGlqO1lMm+JB1tO8d67BA2IJkBuYnS4meKJJYoItpeJXV6u7cIHXjUYIEBUK7+0Go/kytf2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMg6qJwDCLB2FN8tzG1Vgw40LkMGbuxtueq3vNuunhE=;
 b=DHHgEUFXQsEMvM/cJzb+VL9vYNMioqIy+didc9DxRWQNm5P1HLP7lcvjidSILpS1zFKM3Z4UKBD771OwGun8WbzqBvTY79s/ie6JR9syoinmFM1C0RZeCorDw+8ALLi/U86IG3BG7Zcxw9eriPW8GXr3haQUNXsWG5jWa5fPXHA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AS8PR08MB8970.eurprd08.prod.outlook.com
 (2603:10a6:20b:5b3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 10:08:02 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%3]) with mapi id 15.20.9456.013; Wed, 31 Dec 2025
 10:08:02 +0000
Date: Wed, 31 Dec 2025 10:07:58 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	broonie@kernel.org, oliver.upton@linux.dev, miko.lenczewski@arm.com,
	kevin.brodsky@arm.com, ardb@kernel.org, suzuki.poulose@arm.com,
	lpieralisi@kernel.org, yangyicong@hisilicon.com,
	scott@os.amperecomputing.com, joey.gouly@arm.com,
	yuzenghui@huawei.com, pbonzini@redhat.com, shuah@kernel.org,
	mark.rutland@arm.com, arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v11 RESEND 0/9] support FEAT_LSUI
Message-ID: <aVT1/vm4RoKydvPY@e129823.arm.com>
References: <20251214112248.901769-1-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214112248.901769-1-yeoreum.yun@arm.com>
X-ClientProxiedBy: LO4P265CA0252.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::18) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AS8PR08MB8970:EE_|DU2PEPF00028D00:EE_|PAVPR08MB9722:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f96d762-5e97-411b-c401-08de4854a0cd
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?oIaoqnQzDO7AmvQbnUzxe0VJxjMXlApDchDVQO/eQ9vb4mF/tlajxw8nPd/N?=
 =?us-ascii?Q?omzgZhziZSVaGw/FygjcMGfVblqZgYAwg9WDovhPhCY+T5tYZSFA2/ow8Yl5?=
 =?us-ascii?Q?sS+SVEfhJdjFQg6eQqaoBGR8rbRP4DDAKrJnZEkoPqnYxqHkd9MfHsOjBZR1?=
 =?us-ascii?Q?Vop///ZWbXZpqAuPR08L6TaKrfMC1171AF3TVmUX47ngfkfhfN9mwT5klyaM?=
 =?us-ascii?Q?VNcOQKq15EbjI67oPfFdjUWjhlOXtuWnpDEIk1FhkQwQLi9URvOW6scgYhvR?=
 =?us-ascii?Q?ZqQS0x0OeCYdSx/3O5I3iyPnhwMuYSBzAvkpNwb7Q1RgqMmqrRwk4cgt58NJ?=
 =?us-ascii?Q?TZyZpGj9iOnpNEhG87c41kzLJSYI5Y3Q9YvPvKy/mUAJVh2oAqxUKegn1zf9?=
 =?us-ascii?Q?mgLZWzTXoPYQAHOftgnrfFrqmQ1v6g7YrLTG2U9RqPzgY4RoNahJa8xAm3Du?=
 =?us-ascii?Q?BQfq2aBMImiyG32W9Y0FnNaVWDjrYV2sGZ3gD+hzu6Zzxeredb+4v/Aib2Db?=
 =?us-ascii?Q?2ZCkAmfI7YsECnq13MeOM4Oj4426Dv4epHfhOazmOO7sVEJ3xWUyIP0tuAgk?=
 =?us-ascii?Q?0FgEounvlAtxGQ98vrqG1FPDSvgP+Q7gAWYGBuIdbPDCu+8+9wONHjf5GBDW?=
 =?us-ascii?Q?NUEHB5TeDSMynYEnXJ/dIRyqtpHU4nCIhQJOJNwF1ZQeqk6PM6c6M4KSmtJp?=
 =?us-ascii?Q?RDdE9UDvXVYLJVlb4jxMT49vw6AeNz5jtn1AIFntgfuMm1NjE1++eXxhtM7y?=
 =?us-ascii?Q?DPvh8zmRUpjfDr9zKd6T4lpuhf7VqeHTSkeeGdtX9KmiVAC7cX08whQguP2b?=
 =?us-ascii?Q?f97rKd9rnMrLMiIjQN0enXKDwUSHu6RRUUr+qMED9ja9fnZq+UNpMAYxHMbW?=
 =?us-ascii?Q?SnoT/I0xRCT7cflTFLV6Sy4wKQfMENs2kONckCj0jsPOj+Ta99b17Ka4MKkf?=
 =?us-ascii?Q?PouJxo0AS6TuXFcKMAAA8UZUfE4P4tF5g8AvBe2OSFTuD3ohDEUJHqtRZf3C?=
 =?us-ascii?Q?fHWuLvD0EMqaOjMUGYB5LpcvBv/tiCoxVV6LlfQXRmwmBvacnmGKJkIfYrC2?=
 =?us-ascii?Q?Mh4PQfK9uUxqxGW6QkXUgqcdY26YeO3bQ1byonduGJtASCHWGjUtdxU3k8Ly?=
 =?us-ascii?Q?62M2qyKB23qoGrzVy/ezoXg4J6XByLNCaLV4CqYzXXmfKjQfLKNhvizkJtYt?=
 =?us-ascii?Q?R0thzZPXlDzb1g/zEhhpJav0+pd8tU2GlLNHH1Z6ELDK2am8U9/cNxTzzlj6?=
 =?us-ascii?Q?M1xWL3C85OyBVk95qAAAx+ru6f/OX2d9zfDCeY/0cM4PRFxTUe08uS95hZgT?=
 =?us-ascii?Q?20Rpx9CnSigPPN0NchgGslqXLoou9vxwsiUxrUztjf9QQz6+r9xhY9xMmfWQ?=
 =?us-ascii?Q?ZOIrSx4AkOcaG84/9FhIZhkvjAI+YtsfiMUztzGF/5Pu61vY1v4gWRYcsLfL?=
 =?us-ascii?Q?GQFFoLXoH9X045OHK/f7OFzbFPgJVuNcY8aMzcwM6v8e8FLeBzGMbBToFF18?=
 =?us-ascii?Q?BInviRk8RyR7crAFT8SJAG3gpo/8TjuQaxBa?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8970
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D00.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	77feb957-4122-4d6f-4c20-08de48547b6a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|35042699022|36860700013|1800799024|82310400026|14060799003|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eUzu/TgDi+Zn4mS3wQeZTxuoB+JCbjBhQZFG3/4JZQ35Fxh3JWH0GaQLrsU4?=
 =?us-ascii?Q?bNBsCCVGdkv/52HCTwd0YLUO+XuRN/03OH3IepGysou84TmVTeWJaJhi+3k4?=
 =?us-ascii?Q?jOyZM9BxlxnAvckc0j9PDe7RFidKUMrMdmdgLI5nMNL2IXacBLvnJ4uu0laZ?=
 =?us-ascii?Q?fms5gw5jfw+iokwOTHp/+B4yHKNEIcbo9NAgK1MtIBGE4ur/1p/vycuSWlT6?=
 =?us-ascii?Q?jHjVU8wdkTbo/q47v/cISYca8Hj9mwAZfWsY9LfRX11bC/TGx9Le+8zjM99l?=
 =?us-ascii?Q?Qmryg/Mj13H7hi6dqfdgLTDTX7iQchSmC1AkgQMGAN3DCLwkCqlxQBWYJIwa?=
 =?us-ascii?Q?qIf8gZhsYe47brSlnIy281VUfvPqQPemK1dxVI4a0Aj2PCdgJC4T/MkXqv5s?=
 =?us-ascii?Q?l0Vx4cdc6PFeukg2q82ZDM5/2yGIA6LN4qfOQsNk8+kOJZfrMRcKXXOy1oJu?=
 =?us-ascii?Q?7tei/d+W2wqxzDk/nAdAKze6FXweaOzlfvyHHQgt1VxcJUmret1zIViQfWVH?=
 =?us-ascii?Q?sdIC81At32v7OhQAOXMwhO0TaOgMb18xOTmMSt2/K0UIz5ATEOKEsy/XspGB?=
 =?us-ascii?Q?01qnxgZtItOBg6GzZ96GWkW0ebC/vfnJ0NzXfEBqYkBfaps8BeUL00CwzTmh?=
 =?us-ascii?Q?nULYO34Cr0OfgVfv7bYTXI47fYb3+Jky2s9f5vFnvPQOJiI+OeHEzhFCPvJg?=
 =?us-ascii?Q?pfKfux25fMnkcSWKaXcyUUmr8r8b1iKHzLIgIV2bLluJs3ecaC9uVP1OpVjG?=
 =?us-ascii?Q?LUlQSHbCLdckdMuLYazdCYERrzs7NG8QdjjujZg4w/fGKAnjv1YkDLwbIxva?=
 =?us-ascii?Q?WhLbcyn0FMHYplNVIvcq05+RZtkL3KgGF0RCGOMXKD5GnkhqY7QARuz8eufO?=
 =?us-ascii?Q?EJ8hl8Nzen2R+bqb0jdY75Gj0tGBMVkpFssDkWZCBRMB4LtfNznAmCVAbXPo?=
 =?us-ascii?Q?vJlN9F7wkaLOMcc3X94wzx9z7J16hdtKqmasM73jJb0wMvd/+pYMvSVSYbRV?=
 =?us-ascii?Q?F0TGLvE3uJ9eL0mEw0Mw4O1SXWPm7W1uE04RuP+KEUC1n/IsobDRfvO++k3B?=
 =?us-ascii?Q?g1eETU6roD/OcSmsoCsPuKg226p9SSjWR8X++PIaHNaVAR6j8AMoIp2qY7MO?=
 =?us-ascii?Q?BplsGmFrizY5HaQ544UVjdKJK1sTZ0opnYGhL5J0QkXYKkeYR+WmFE/yrCgG?=
 =?us-ascii?Q?Jo3nIWWZW4IuWY4Y9cr1GCXSIsEsM+kNoMgts04A8xThYKO4h7wb3efJE8ym?=
 =?us-ascii?Q?9QRugAeowRcgBi0UeMAo+8ykEFKp9aQiA0Z+HbjmZOEv2Ekd/yI8Hn28mTJm?=
 =?us-ascii?Q?R5L8cRWFID+XuC4nYiELSSjMed2YxN7O0IlzLnFrPyFgmqCXkD7gDw2UMpXW?=
 =?us-ascii?Q?rtZ217FbqdvnOJGyqkLj1j/SVt0qpYacfWD/wIvJ2Om96KT6wG4SydGuSp/Q?=
 =?us-ascii?Q?bh5zjNIfS76jK4ibKYcdf0MFSDRmKh9jocqN0wRwpTPBxjaeujboLWUqtnni?=
 =?us-ascii?Q?4+fsuVzXjuhypBMqgEJzcJc8DllaTQ06s27M4/eDIDOKYkaKDIOCA36Tc5VX?=
 =?us-ascii?Q?J9uIzUqoJe4itQn+kmr4d5D9HEHuv45BM6wLTSMv?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(35042699022)(36860700013)(1800799024)(82310400026)(14060799003)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 10:09:04.4512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f96d762-5e97-411b-c401-08de4854a0cd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D00.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9722

Gentle ping in case of forgotten.

On Sun, Dec 14, 2025 at 11:22:39AM +0000, Yeoreum Yun wrote:
> Since Armv9.6, FEAT_LSUI supplies the load/store instructions for
> previleged level to access to access user memory without clearing
> PSTATE.PAN bit.
>
> This patchset support FEAT_LSUI and applies in futex atomic operation
> and user_swpX emulation where can replace from ldxr/st{l}xr
> pair implmentation with clearing PSTATE.PAN bit to correspondant
> load/store unprevileged atomic operation without clearing PSTATE.PAN bit.
>
> This patch based on v6.19-rc1
>
>
> Patch Sequences
> ================
>
> Patch #1 adds cpufeature for FEAT_LSUI
>
> Patch #2-#3 expose FEAT_LSUI to guest
>
> Patch #4 adds Kconfig for FEAT_LSUI
>
> Patch #5-#6 support futex atomic-op with FEAT_LSUI
>
> Patch #7-#9 support user_swpX emulation with FEAT_LSUI
>
>
> Patch History
> ==============
> from v10 to v11:
>   - rebase to v6.19-rc1
>   - use cast instruction to emulate deprecated swpb instruction
>   - https://lore.kernel.org/all/20251103163224.818353-1-yeoreum.yun@arm.com/
>
> from v9 to v10:
>   - apply FEAT_LSUI to user_swpX emulation.
>   - add test coverage for LSUI bit in ID_AA64ISAR3_EL1
>   - rebase to v6.18-rc4
>   - https://lore.kernel.org/all/20250922102244.2068414-1-yeoreum.yun@arm.com/
>
> from v8 to v9:
>   - refotoring __lsui_cmpxchg64()
>   - rebase to v6.17-rc7
>   - https://lore.kernel.org/all/20250917110838.917281-1-yeoreum.yun@arm.com/
>
> from v7 to v8:
>   - implements futex_atomic_eor() and futex_atomic_cmpxchg() with casalt
>     with C helper.
>   - Drop the small optimisation on ll/sc futex_atomic_set operation.
>   - modify some commit message.
>   - https://lore.kernel.org/all/20250816151929.197589-1-yeoreum.yun@arm.com/
>
> from v6 to v7:
>   - wrap FEAT_LSUI with CONFIG_AS_HAS_LSUI in cpufeature
>   - remove unnecessary addition of indentation.
>   - remove unnecessary mte_tco_enable()/disable() on LSUI operation.
>   - https://lore.kernel.org/all/20250811163635.1562145-1-yeoreum.yun@arm.com/
>
> from v5 to v6:
>   - rebase to v6.17-rc1
>   - https://lore.kernel.org/all/20250722121956.1509403-1-yeoreum.yun@arm.com/
>
> from v4 to v5:
>   - remove futex_ll_sc.h futext_lsui and lsui.h and move them to futex.h
>   - reorganize the patches.
>   - https://lore.kernel.org/all/20250721083618.2743569-1-yeoreum.yun@arm.com/
>
> from v3 to v4:
>   - rebase to v6.16-rc7
>   - modify some patch's title.
>   - https://lore.kernel.org/all/20250617183635.1266015-1-yeoreum.yun@arm.com/
>
> from v2 to v3:
>   - expose FEAT_LUSI to guest
>   - add help section for LUSI Kconfig
>   - https://lore.kernel.org/all/20250611151154.46362-1-yeoreum.yun@arm.com/
>
> from v1 to v2:
>   - remove empty v9.6 menu entry
>   - locate HAS_LUSI in cpucaps in order
>   - https://lore.kernel.org/all/20250611104916.10636-1-yeoreum.yun@arm.com/
>
>
> Yeoreum Yun (9):
>   arm64: cpufeature: add FEAT_LSUI
>   KVM: arm64: expose FEAT_LSUI to guest
>   KVM: arm64: kselftest: set_id_regs: add test for FEAT_LSUI
>   arm64: Kconfig: Detect toolchain support for LSUI
>   arm64: futex: refactor futex atomic operation
>   arm64: futex: support futex with FEAT_LSUI
>   arm64: separate common LSUI definitions into lsui.h
>   arm64: armv8_deprecated: convert user_swpX to inline function
>   arm64: armv8_deprecated: apply FEAT_LSUI for swpX emulation.
>
>  arch/arm64/Kconfig                            |   5 +
>  arch/arm64/include/asm/futex.h                | 291 +++++++++++++++---
>  arch/arm64/include/asm/lsui.h                 |  25 ++
>  arch/arm64/kernel/armv8_deprecated.c          | 111 +++++--
>  arch/arm64/kernel/cpufeature.c                |  10 +
>  arch/arm64/kvm/sys_regs.c                     |   3 +-
>  arch/arm64/tools/cpucaps                      |   1 +
>  .../testing/selftests/kvm/arm64/set_id_regs.c |   1 +
>  8 files changed, 381 insertions(+), 66 deletions(-)
>  create mode 100644 arch/arm64/include/asm/lsui.h
>
>
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
>

--
Sincerely,
Yeoreum Yun

