Return-Path: <linux-kselftest+bounces-19720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3158C99E2C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 11:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C85FB21150
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 09:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909D61DD55A;
	Tue, 15 Oct 2024 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tBhsmayT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04961BE854;
	Tue, 15 Oct 2024 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728984540; cv=fail; b=EJ0BOQNLYdWah+c27gUaBftGOW/8QC86sy8/0hBII59ORHSULUf2z8RZJ0zggL0YGd6VG+61xnNzgV/WUJ7SAAP4wWifcrsEKLhOP6zyIyv47pYm+MSw24rSWj4dYf5PVn2CfrzaYkkYbYqrSzWiao4MMKS6h5HtW+J2yXxvbyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728984540; c=relaxed/simple;
	bh=5mNmTQNKi/xUtzV3ZKoy/SwQDQeCmcRJ8+SKT6UdrJk=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=b3OMT9WQ3r/RluJjnRtX6p8mj1f7uF9u/PUx/lgZBTIz/KBub43UJhzRXX66BRAfhIva7rSe/RNQNwnwxYn7+PrrFTwvKU6eymEXX3rizXltqFRuUBC3k6Nlb1MAECs7CHgSF1N+BfIiaiRhZoClStg9O9TfRD+LcUx8zx6ayPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tBhsmayT; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IE4uPDtmYmvUNUNoYZav22V9eNz7hdc+D+C5VfclBRxIrWSXmspt/nX42I1+H7/Mk5O61bF+QToTxhDKHBapTAlTPzsdhb8BiHyH4LRM2+6TBNHqx/DvdqC3+u7XSgRmdkylYGo4rJWGLkjm50i/AhJonu5hfkVQ82icdDZqNMuWw7+m2leJbF69F6826+R4VwwXUZWF2nVAE9YZ4bC42fq3lTD55YcHTUKIx4aIXSwjIPV6L+dKzhsAdEVvmu5zG2sPsxcLToRuoxqRf9BMF9reMz4AjyGkBfs5y3y4BmlzddKSRKR/qWQfHHE2dPQ5RWg+FMubdjA3T4AmOtOf2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaffxhhhBM75lD63YEni2YDY2NbPeRwC+XIE3KGiCrc=;
 b=zQrVmj+MbJbgJv0Z5f7brFWH0PL1tJ0vFyxM+ERV3mcosKmFBY5NCz+ZBuiVqjYuTIUdXK7RLDG5UnpaNPh68YRkDJjCgIJ4HaJr1rQ+ol42lFU4oNwZzJ3RLSceNJ88DwXvv0BUXSEZ/sSEoV9+IEuS/nIS9Ocpuli6FTHLRFe4P3Y4F6M9dDNKlE2ZBRMogVN1K58AED14XCcia4Upo3JZ6yvjJZZoz2SKABZeox6s6xLxEiN3yigLfaxID/G4Fu92zhT6R/WxGNDoOFFCqtPb86r/6HUkupN8c1xydE7dYHawxDGXQ0ihKJ4gkJPJg6sVWqabfPDgRWhyhgsbMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaffxhhhBM75lD63YEni2YDY2NbPeRwC+XIE3KGiCrc=;
 b=tBhsmayTl2LvtsQCjrcBGBBtR5XvMUe3GtszfW4955B1lgu+O/rvMUFnhkThl4noP666nEAaeoBw4tPSWpL+yUzVIxlvaMfZ3Z9IjglseNFjwBPf+2NHNaiijLyUYVUR4Iglo7kNSvmNOhvNYUSRmBJUTORiScIf9zLb4zacmXulWU75Dgjxy+xn8XFFDdC1w8WejvKqXRo1SxJPG5HboTv/qxbbmKPONKnCi+WEhj2zI+61QETbLxMX5M9Q/iCrg3jBN3CBQMZiWIEcbSHwZ1q6sK9rPXEsVDQ9yJiy5wLdCdO8jHMXcuqF9bpUvYD4SZQl2ZP+Ss7CCO6eLsmnGA==
Received: from CH0PR04CA0054.namprd04.prod.outlook.com (2603:10b6:610:77::29)
 by SN7PR12MB8132.namprd12.prod.outlook.com (2603:10b6:806:321::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 09:28:51 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::e8) by CH0PR04CA0054.outlook.office365.com
 (2603:10b6:610:77::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 09:28:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 09:28:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 02:28:39 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 02:28:33 -0700
References: <cover.1728473602.git.petrm@nvidia.com>
 <5c0506e2d1bcdd513b9917716702c9bc5f656198.1728473602.git.petrm@nvidia.com>
 <0b947dd2-5891-457c-8511-52781764857d@redhat.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Shuah Khan
	<shuah@kernel.org>, Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 01/10] selftests: net: lib: Introduce deferred
 commands
Date: Tue, 15 Oct 2024 11:06:35 +0200
In-Reply-To: <0b947dd2-5891-457c-8511-52781764857d@redhat.com>
Message-ID: <87ttddhg03.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|SN7PR12MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc51103-5882-4ed0-dd64-08dcecfbc7e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KOtHuageOaXhjh/ONdlQtYVQ59AzRF8Lx8z9eTUNLqX1ptTfcbd4nl9ZXtPj?=
 =?us-ascii?Q?d3csJknVoETv9Wi+3a7a5PtPOxL/EJb4UWouj6ZHTdZCa8IqZC8EFFogRrsc?=
 =?us-ascii?Q?Hx1VP2it8M7CVGN/KglvtPensPv7DNk3RzNN6MfPFRPYHsaoWz+5b3LbNgF4?=
 =?us-ascii?Q?rU/O9OmNfzi/uL2l2f21dZhZHiJvCI7MGdJMot9Orjisl3iM6rIaV7LchWf4?=
 =?us-ascii?Q?zgG2BQ7Glexi5KNqBanIam5Ql69t+j/VWYJOuKd3G4ZG5nYXFIxm4TmG7Aee?=
 =?us-ascii?Q?2c2RCuvQwVrXXzaIKJqbMDG66RaW8wWJ5L/DKf9vneEDZdnzA4CsaGJ3u+QD?=
 =?us-ascii?Q?mfswKzLXa6pJ4d0nrjC/B3dcKM+9isWjJYpo0dHSdvmHF2T2S96FnbbholPP?=
 =?us-ascii?Q?NB+BCVKo0eAajtZZIzVj9TySYOoq4038N3EwRiNJtzg3LRFRogHKPsmcNneb?=
 =?us-ascii?Q?e/IymCBm15i8Cp/sbfLggyFgFZdK8CIDMEhGh4AHMJra4g79cw6/P/65vA3L?=
 =?us-ascii?Q?LYOrnrbVeY6qEgNOQ0qsfF8TWUVcAbYx0JbkBQuxaeqiEVx8HHrQJj5NfeSJ?=
 =?us-ascii?Q?FHIIZZAgCgLFP3IyIjEadG3JqHkrs3r3EkwcVQuVqwZ1aev40QnOG8+qsf+A?=
 =?us-ascii?Q?KeCIHvcPFNexdWEfD3AX+uF4DRjDxIfFKiV1hXUqf/WjM2qD0OUAIDV40dih?=
 =?us-ascii?Q?hQ4jI3tWpYxnssjJJJh4Pz5n9bpfuklCQzJ3Zyv2renOE3zSr+PX6jDyqThm?=
 =?us-ascii?Q?DyZVdZ0zne8Bic1vQEYIiYbszDhWoWttP88SqVU0G9+lvJXX/Z6rS1UfZhzC?=
 =?us-ascii?Q?pH7gnGJ3j5FSIVxZEyh9GwJe+wfs6dPaxmfXEtopMvkWglw1lpREnxBaXHC1?=
 =?us-ascii?Q?HlFQAk1ZVpoo39SqIL58sy2vc7A5B1vpRuU9q3xaq4tNW7kEOZzyPwk1HQl/?=
 =?us-ascii?Q?32HX64pcNwom8JybuQuFhyH7R//FaWhvBTdz1pUQnztP/UaGKTyliskGaEAj?=
 =?us-ascii?Q?gxO+nej0KBk5Zt6/d4sTxM05nSDEmqIoaMzlqox2DOCD7PvyKh6nijRTt+MS?=
 =?us-ascii?Q?cG9qjey9llTXj19U18sDxTPb6OWPe42dbSM6uM5jqG8WpKAFGVKw6TY6xIij?=
 =?us-ascii?Q?vv1cIg9UJhW7bC8Z67NKI475gQyG0g7xMBx9vgAyVIOxXi7Z1q3TmG2DmHGj?=
 =?us-ascii?Q?mbKEFgIBEo+lVsCscPamAUXDX/QyRETtztIa3MnsjNt0Mc/JCo7fMm0P+MNG?=
 =?us-ascii?Q?zRCYLEkrCBS0NJkeeUaqmmWRU+entY3Smlu1LJ161c4306tEPAwaRau83qOf?=
 =?us-ascii?Q?1L3XyuIoPqqQBOgk68mRkrkR2ip/Cs9fNFTHXSQP2nhPItNFmLHK5ikmZX8a?=
 =?us-ascii?Q?E0nhEncS6vJwLQtVWc9EU9zVlu3Z?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:28:51.2685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc51103-5882-4ed0-dd64-08dcecfbc7e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132


Paolo Abeni <pabeni@redhat.com> writes:

> Hi,
>
> On 10/9/24 14:06, Petr Machata wrote:
>> diff --git a/tools/testing/selftests/net/lib/sh/defer.sh b/tools/testing/selftests/net/lib/sh/defer.sh
>> new file mode 100644
>> index 000000000000..8d205c3f0445
>> --- /dev/null
>> +++ b/tools/testing/selftests/net/lib/sh/defer.sh
>> @@ -0,0 +1,115 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +# map[(scope_id,track,cleanup_id) -> cleanup_command]
>> +# track={d=default | p=priority}
>> +declare -A __DEFER__JOBS
>> +
>> +# map[(scope_id,track) -> # cleanup_commands]
>> +declare -A __DEFER__NJOBS
>> +
>> +# scope_id of the topmost scope.
>> +__DEFER__SCOPE_ID=0
>> +
>> +__defer__ndefer_key()
>> +{
>> +	local track=$1; shift
>
> Minor nit: IMHO the trailing shift is here a bit confusing: it let me
> think about other arguments, which are not really expected.

This is IMHO how a function header should look like:

function()
{
	local foo=$1; shift
	local bar=$1; shift
	local baz=$1; shift

	...
}

Because it lets you reorder the arguments freely just by reordering the
lines, copy argument subsets to other functions without risking
forgetting / screwing up renumbering, etc. It's easy to parse visually
as well. If the function uses "$@" as rest argument, it will contain the
rest by default. It's just a very convenient notation overall. Vast
majority of net/lib.sh and net/forwarding/lib.sh use this.

>> +__defer__schedule()
>> +{
>> +	local track=$1; shift
>> +	local ndefers=$(__defer__ndefers $track)
>> +	local ndefers_key=$(__defer__ndefer_key $track)
>> +	local defer_key=$(__defer__defer_key $track $ndefers)
>> +	local defer="$@"
>> +
>> +	__DEFER__JOBS[$defer_key]="$defer"
>> +	__DEFER__NJOBS[$ndefers_key]=$((${__DEFER__NJOBS[$ndefers_key]} + 1))
>
> '${__DEFER__NJOBS[$ndefers_key]}' is actually '$ndefers', right? If so
> it would be better to reuse the avail variable.

I figured I would leave it all spelled out, because the left hand side
needs to be, and having the same expression on both sides makes it clear
that this is just an X++ sort of a deal.

