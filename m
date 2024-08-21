Return-Path: <linux-kselftest+bounces-15846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D14959A0C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 13:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE021C20D29
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 11:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADE41A4AAD;
	Wed, 21 Aug 2024 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hlo8sX/e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C481A286B;
	Wed, 21 Aug 2024 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724237476; cv=fail; b=lZkk9SOe9JKuJs8SOe8OnoN3TthDZj0IwNLBLxfGPqtVEI2gm6B4dWcs1MXuCz7pZXKIUVxoxAm5NSyC7eNEThHx2LP3Pz1yn4TXw0q72B+HvM4NfvOIo9tsOe955C8BNCWVjifIkBVqSWV8EL+OIvHPbDnyyRDfaDhMAEw4CMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724237476; c=relaxed/simple;
	bh=vWxbAEJLm7N8ityTl+mOyO8RWoPhL0bICQifSrOlCQw=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=P6MPjCPnvKOgLPfcvBoJ4gcaBf2a7FhZE7DB3mtO47FqmNXof2SyXrS6lOT3M3M3wHYxXoNgbPM6ShPYWzunLHYSx8q33LoECmQ+z4CRXGWsta2A+txnnkBOg5cgLxyvVXzGtptwuE67afGbvEHiZIXO9nEN0aG8env6bV3cLRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hlo8sX/e; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBVkgKfZzaoifLtSNWwfNe4paKNOfeAqUA9DddYErVBqHF1x8OyaTld/40yZA0gqaV627Rsub49BnXJx/yQW8f3dGNNIcq0b5/vPz+BnxeK2+eLF4vD+Z32hOGGtg3fjASmLHfalUqBH06bJ80defERPzDPOL4LbX8fkc2DDazHTyDG6pHzzWIDEWEyOqNlNogkMCEhPiWUBawI3aDk0jmzP9uMmxJbSCMFdt2NIBoleZCvu5ke6RdKqbIcObkxV3NHODMeJKpIYgzlLCBlJggs1uxuZncz3ilHm58vPBJajgEcobwcNoPnASpQ0Zep9xy3+SqcsdsO4ItTkYLM64g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwM+1dla7wlqmft/r+QPWb6x+8JkpzJqqNHyK8wo2/0=;
 b=B1KxcNtA25VPChEum9S5ea3ngRhMCrFvYeHIKvhO8kj2l2G/W43NLi88unKYxl0LrDB+0HbPGZeA2+WxQdt+oGEoqpAJUfH94dONx5DiQ+DCNt2W4yHCri9+sg/khcfCqPKVsLx4sSEhi/UwIOAr9d4uu80+NxQPVtozNWW6NHK9N2ls4OfJcAB/tQFCh9wSS9zZYzRGNl8VP7pjBWDNho1OYPd8A637ljiMlL+WIykJZ8JzRoYn3BADWnM49jmCIYG7Q8O1U7+/GRr50K5zGqJtrpmz6ZT3jDa0urOm2EXjLd6bz3EcPG+JdbZhX7hZMrN9BGCwtkHLVaz21BUCLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwM+1dla7wlqmft/r+QPWb6x+8JkpzJqqNHyK8wo2/0=;
 b=hlo8sX/ePZPgNmVNrd0Bd8SqmH4F41JlPUm6vso6BxWaHY5fKjh3PtwMnLoiNquVZSi6Zslz650R/gSykGIj31iPeCKxms9C2Kd6TyRlyDsKhM7EkhTTSExtdx4rueREs/NibwBgk4i2NkiROYGNkJHt/BFTCdcVUatBazd5yBZfsK2Y+6P9laXnGcSJjCEJS4Mj4RkCYjApQHJ9H4Hil8YsJ/5KmXRktsmDaZdvV41ZE6+Msho/AAFhn7MwSBaRzMMr9TW7UfQhJkhVqzQ0NEhLnZeu4jA1yZ0qk5Um0tsCxEA3qobgg1SxD7nxZOHPkaL+YvCYTX+94u2ViLIQCg==
Received: from MW4PR03CA0303.namprd03.prod.outlook.com (2603:10b6:303:dd::8)
 by MN0PR12MB6080.namprd12.prod.outlook.com (2603:10b6:208:3c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 10:51:11 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::24) by MW4PR03CA0303.outlook.office365.com
 (2603:10b6:303:dd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Wed, 21 Aug 2024 10:51:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 10:51:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 03:50:59 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 Aug
 2024 03:50:52 -0700
References: <20240819090406.1441297-1-leitao@debian.org>
 <20240820160636.7bfc4d5a@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Breno Leitao <leitao@debian.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <liuhangbin@gmail.com>,
	<petrm@nvidia.com>, <matttbe@kernel.org>, Shuah Khan <shuah@kernel.org>,
	<netdev@vger.kernel.org>, Willem de Bruijn <willemb@google.com>, David Wei
	<dw@davidwei.uk>, open list <linux-kernel@vger.kernel.org>, "open list:KERNEL
 SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v5] net: netconsole: selftests: Create a new
 netconsole selftest
Date: Wed, 21 Aug 2024 12:48:08 +0200
In-Reply-To: <20240820160636.7bfc4d5a@kernel.org>
Message-ID: <87ikvukv3s.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|MN0PR12MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: b37ccffd-2273-4f22-ba11-08dcc1cf2b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wkjek3qBYFT9mnhkz4G4uzRAP48RraR51bWwml1QVTmcNIHnJcRft93ETHz3?=
 =?us-ascii?Q?VbSsExeznAL9vkBA6I+iWdoiAuMYPNqmOfzykQ+fEm21uL4vZ/g0xTcrzAeD?=
 =?us-ascii?Q?z+2nJqKrlnG8HWoAt6vB3frMNF25uvRPO7YdCKoBhgplbZDlBSMU46CSLceQ?=
 =?us-ascii?Q?hq1BcCyXID4NH5vm049UMZN6PVqOSuoAsw3rXT5fAqfaQwxFAekEkylXA1JE?=
 =?us-ascii?Q?O1jTurRSdesFHg1EC7ZcQW6Nz48sjB2PjeOo+FvlGYeJVU3uAQoMOCbqWPT6?=
 =?us-ascii?Q?+M14qWcdA0KL++FapPafuKw7kqvXlCC58L7vsQX7QiQn5ldsSemx8L31+1fQ?=
 =?us-ascii?Q?cc/1XU1xjXQG8/i/e5Vjwi2Ve4SwevVWXajTcRjli0f7xhl+jLuZSfOagMeR?=
 =?us-ascii?Q?FCR9tr9Acur6CEwmuBdpCO9I7wEbR7ajXei3V7TvI856KpnmitWasBxPNqqP?=
 =?us-ascii?Q?xNpwYGugoUJcxOLQMtpkGchiCRc4ghZDGbVgqfnyvtwGcoAp4IWt+5ziPEBP?=
 =?us-ascii?Q?hUq/zpqhpxU9se7BWLQiUziDPdtTwRoOlEuYqY7wAa5GQEwgv4WDvjv/VmrG?=
 =?us-ascii?Q?TYI4Lfb9qdLUBvhdtSqnV02/U3HYwoYgmfBcpC+96vitf3lW+k19FK7zccmD?=
 =?us-ascii?Q?nYXL+JJ2cH1LczWkMgdTgS/TngxmjlXlPtfkl8XvSZMlY51piHFN5XWm8EAM?=
 =?us-ascii?Q?tzaKqtXZCR4mHHGjo9Ek4/C8rq5IZdW0MejqZXhyTGmOxPZTdUS8tVq4EhKz?=
 =?us-ascii?Q?vaUDtHf5hy44jLfEZPqHW8PTUqSv7jai0mZkC1SAt/A3g59EQk1kw1KgpXw8?=
 =?us-ascii?Q?7X0s++LIw7obNX7gP2Iy6npUNAW0rPoqLNoFx2keI5lpXS5T2ib0qCQIo4h8?=
 =?us-ascii?Q?3gwkMGNlGQNBORfTuEqKNEsAoOyarWobDHNsypDePXlyQvBEPAowCKNnRNbA?=
 =?us-ascii?Q?B4OeD8B9MA4rGigchHRw30oUYrKT9OkSDFMW/UY5rw71UFOHjFth17eFDipR?=
 =?us-ascii?Q?Q18xYqMx9+2cw53gltPahs97ci+oZRiPS/JUkPQXI3wEEFHyGK0sgZrn/N0x?=
 =?us-ascii?Q?TK6gkjGN0ehx5abdSguNwonDM+Ufxc/8GcLYD8a0kcKsCI9Ltp7/w5USvpeI?=
 =?us-ascii?Q?oIm1bj/ccYMeYi7O8QPI3ePFnqa/czym2UBJnA+fghspYrR5/mR+baLZkXAC?=
 =?us-ascii?Q?KKVuTH5iN10r20sit2d8Y6MjhN9IE4TUtWfhGGtQdCqXHCcFaqmsx/kaXbvq?=
 =?us-ascii?Q?Q0On/y9DRGuRUXWPhZz5x6jsTzKEPIuxrsjNauM9LdGdtxSiTrboF9XBLf1A?=
 =?us-ascii?Q?RY3sDeBxrfGB/ta6btxFX0A+iBJL9X4s/aQ0pbSsCBYA/A/nlySKzNT+0Ubi?=
 =?us-ascii?Q?zy9hDqqTdOEr5IEo9cAVT0eeCoLQmYmxul1tl5pkjaugDVKKf8v0W2yen3Qh?=
 =?us-ascii?Q?u6Nyuhgtq0MFVB+FTLeeU732VoRFJMQb?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 10:51:10.6308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b37ccffd-2273-4f22-ba11-08dcc1cf2b3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6080


Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 19 Aug 2024 02:03:53 -0700 Breno Leitao wrote:
>> +function check_for_dependencies() {
>> +	if [ "$(id -u)" -ne 0 ]; then
>> +		echo "This test must be run as root" >&2
>> +		exit "${ksft_skip}"
>> +	fi
>> +
>> +	if ! which socat > /dev/null ; then
>> +		echo "SKIP: socat(1) is not available" >&2
>> +		exit "${ksft_skip}"
>> +	fi
>> +
>> +	if ! which ip > /dev/null ; then
>> +		echo "SKIP: ip(1) is not available" >&2
>> +		exit "${ksft_skip}"
>> +	fi
>> +
>> +	if ! which udevadm > /dev/null ; then
>> +		echo "SKIP: udevadm(1) is not available" >&2
>> +		exit "${ksft_skip}"
>> +	fi
>> +
>> +	if [ ! -d "${NETCONS_CONFIGFS}" ]; then
>> +		echo "SKIP: directory ${NETCONS_CONFIGFS} does not exist. Check if NETCONSOLE_DYNAMIC is enabled" >&2
>> +		exit "${ksft_skip}"
>> +	fi
>> +
>> +	if ip link show "${DSTIF}" 2> /dev/null; then
>> +		echo "SKIP: interface ${DSTIF} exists in the system. Not overwriting it." >&2
>> +		exit "${ksft_skip}"
>> +	fi
>
> nit: maybe ip addr list to see if the 192.168.1.x network is already in
> use? 

Or alternatively use 192.0.2.0/24 subnet, that shouldn't be used in the
wild.

