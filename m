Return-Path: <linux-kselftest+bounces-27769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E34A4810F
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 15:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4C697A5021
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 14:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2881323315F;
	Thu, 27 Feb 2025 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lb+LpyiI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ADD17BA6;
	Thu, 27 Feb 2025 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666251; cv=fail; b=Y2rmb+yOwmdyMR6QS4JbcUntEg6Wj7ra0lPZ97xrYJOCgB/a9QU/NCyJ2y0gn72Y2mVAuyjKQ05Ix6XsTfRfy+8w+q8Pnj+ONR1nc1UiWxkFdaZRZa8T28SY2uYquThteH7pONR40UvEsPoG5o3eCjhmaIgkFV3niJJ9yi/Df/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666251; c=relaxed/simple;
	bh=cqUbUuX2YmwTYpgIQyE83nkp1mhzKNm+Gu5L62GErRI=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=L3kAwZvqUyIpO4uhNCvanlV9GGz3RUMK3y17f/LF7+DaGtpQ4Tau+ImrrKQWpF17wDKwom1f9duolfQpXnWRNRmA2qiLriXwEq4hM4DP/gb0I01xzNab6mirkBGKMfBGemgoanv2r4wkvfR5jzd1msWJ26HoOTNxARUdJ3u2Gv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lb+LpyiI; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FrHxd9hFdF5zF+YmAzO5dVYy8A7tM5ETGZazLE72I9/aXGIx0lD6hjsWot268+Nfk2FOokbdZ+iw436yoaW1b5ZjO5faxH2V37PdfYYwpbAbiMA9EYFCnEuYLijgNGvyO59ZvZ3HEeCyR0cm/fdxUV46qZz+lGUaNmPrhllxsueCyht7yzDzWncGVAEta+BzwkydFyOD2mO7hmGP0D1iwLs/M1pUFaNZGb2FpC9K6O0eKICVdaxESSulwzeJmOpAyNDnYQS6ryFDZCB5cooF+qRF+R9GmITHOhhhVC16Q90wPnMjG+VZflk24NRf1ZU0T365My/sS9V65zUMaA0kow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NQvUbSznOKs3+qnYuPFrUC9QeP9r0DQ3YoDuhVtN+Y=;
 b=ul8rlA5wgW68Lg+GxO1yb4YUa+L5U4A35CzLHR7msUiSfHrnHrFIlydJ1bsiXOzLzwxnSZ6XW9kgmNIsOM+LM64JaZpeujt3qXW42MSa+LZpLPTDBthi3I83MWr6vx4zHVKJG3kAuIuUAOoM02BP/nKeIPpZmIzVDTNgoiNORFf60w1iPdYnueVoMZpmPKK3AUwpPajU07RCcLbBL6/6UPE7sm9sWVnroYox94t/RxAUKB3I1xX++CuB3dPMFTsQTTGMJFdj4Yg/2w9p/iIr0Wly8cDgKPMeaw6ubqKRIrV+ALqDSt63rbrjFAsBgdl4f6HJIZpRRygLdK/cmULp4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NQvUbSznOKs3+qnYuPFrUC9QeP9r0DQ3YoDuhVtN+Y=;
 b=Lb+LpyiI70yrtCsTFhAvV24LD44og+O+Ap8ow1hKA/zTUxO9DXjAkAOtd0alcI4pUutC4BZYKQQWUgx7HpGA0P1FmfTFbY/vG8uOE6xnvlzZeFv5aIGTv/dFVE/BOqff9fOi6Z0EIyDSj33szY8hWT8dFUo4+5c4/wxf2m+UwL/Ir7IcBamk1hxbv+GYYWMHsYb6qyWl/9MhQTYG5YPjdwsdhuub6BpyCKtH5QXNZM6qO1L/79XVaZGJZCYhMtfenDGmsy37LqXLAxzyFnI8BBcq5H8iNa07VL/RMvlyh1Fg5f7f1gDPKLx4YK//64BkHI85VjRlBU5QXtq+62UYuQ==
Received: from SJ0PR03CA0181.namprd03.prod.outlook.com (2603:10b6:a03:2ef::6)
 by PH0PR12MB7472.namprd12.prod.outlook.com (2603:10b6:510:1e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 14:24:00 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::c6) by SJ0PR03CA0181.outlook.office365.com
 (2603:10b6:a03:2ef::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Thu,
 27 Feb 2025 14:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 14:24:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Feb
 2025 06:23:41 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 27 Feb
 2025 06:23:33 -0800
References: <20250227083717.4307-1-liuhangbin@gmail.com>
 <20250227083717.4307-4-liuhangbin@gmail.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Hangbin Liu <liuhangbin@gmail.com>
CC: <netdev@vger.kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Nikolay Aleksandrov <razor@blackwall.org>, "Simon
 Horman" <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Jarod Wilson
	<jarod@redhat.com>, Steffen Klassert <steffen.klassert@secunet.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 net 3/3] selftests: bonding: add ipsec offload test
Date: Thu, 27 Feb 2025 14:59:08 +0100
In-Reply-To: <20250227083717.4307-4-liuhangbin@gmail.com>
Message-ID: <87a5a7fov2.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|PH0PR12MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 30f7d167-e30c-4e12-2d85-08dd573a6132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?afK7Buw4ZmQeyTk1qxfxNV3oqbqbYUkZaJ/rjh7IC8aZwlqnLbpOc2zgXjzL?=
 =?us-ascii?Q?aAiadFM8HfJcJEhLjJLE2Wi7HZTLg0AfXlg/3SQOyj2adcpNzVzXo6+F78/i?=
 =?us-ascii?Q?pRfYWRojSlkdSKZM2SWYOY8joVAOnSX3LuLgBOCX1gJX6ED8bQxQQbgouXmm?=
 =?us-ascii?Q?v0P8WdtM6Wp1RuzxLLuD0z9uHA8Z4GUee7+39aDNP7DgQ6kQuHUlB130aOjO?=
 =?us-ascii?Q?0njCvwR1FUqVX1rbaR+7g/dil8fAE5ZLVFPmrnAWM8P9jQRr6yyl78L+Bhlp?=
 =?us-ascii?Q?F+e1r1XAWk9t4iJWVEIwM0MDzgRw0aH+DygmEdqNO7u16q250gTvGrmjdFUc?=
 =?us-ascii?Q?01JNYu4PfucYTCnSIrAlPdQVIA+EQ21Vp9apOIic2Lem68YT8MqZOfcf1fpg?=
 =?us-ascii?Q?yvREtwqTm8mvyix+jSf61+sMgYv5n2z0zZMQs9m/NKbFPcxYeIm12mNdO33/?=
 =?us-ascii?Q?rvCqiGJZ7UfFlzL8dy70+WaLD7H7BXGFPRyv3MOR7lPhtAF9h6LAC+d+vhbZ?=
 =?us-ascii?Q?sk93W9RaB7p7upbTIuFaMXKAxjJ+PU5Zn1chxqIPb0LOK8byrrTKthT5nauz?=
 =?us-ascii?Q?9Ejw7VBmKYSFxROZn9hTAN/6sWL1dfxMZ16fRTl197sEuOJ8+D3y6N1Z5BTF?=
 =?us-ascii?Q?mM/p3fHpeJcA9qTxNk1tAn/3MdG0uE3Q5xmrHYtNWFJmSwNvhW9fOqbIhauL?=
 =?us-ascii?Q?x1FMjCU793YAi4e2s+SwNv+8QB6oH5iFzWuXUqbGgmKMynOoujKw4OmP3xUq?=
 =?us-ascii?Q?J06wluL+jWNG8uuw7fajwTY6Jom7h5+oRvKY1qvUuWNeU4botdJ5KgBSL4G/?=
 =?us-ascii?Q?MalwVgdrJGptnhkevdb8P40UojPyuu6iJ0qltk70z+qpfhabaBLEDiCRK+B0?=
 =?us-ascii?Q?eUoadTWGOAQFgy6sLYdRmLCdVHYw0yiMO+2jRsAb2wYXhk72qQzjEmG8l+e4?=
 =?us-ascii?Q?pWh6MQqf90Ny9yxgslklcaCxYv/sEBu3wRcOREQwDoih7bfunpxc/3QtJXDH?=
 =?us-ascii?Q?gT7iOKfeHaYgiUqumuVp5kIYN7BCrHO3fOkwpAMD5hzwy3YJ9bi02EwcML2V?=
 =?us-ascii?Q?KanwnTjQZMnX/JhJVxWDVOnNcx0FYV5oGxjMCl0yFOj/bsT/3vnPNRPZNfUO?=
 =?us-ascii?Q?GiMCVx1JPLWJy5q5EwCUhfcgcMgQcW1ON9qDpasaEF3tcyh4t8oDgh/79UI6?=
 =?us-ascii?Q?dp2aumlnjhEP4tBHVwht4REfGtGa8L+dG8QLnECICaSlQ2LUltOiXo1Dcgey?=
 =?us-ascii?Q?EYSp7JsXTRTEk7Ce5XPiZLEEf6CxHpyfBDJbHkGn4+6EF84XZ0PvK4svBYeu?=
 =?us-ascii?Q?BFuDJZcuJmCxf/ozBl1b1d6J4FXbiLK4gbl8buQk7CWnb6Mfg7FddFVY5clR?=
 =?us-ascii?Q?oyNYToqJaUh4++yFI/d14BH0pC5cDgDCZl7wTJEz+0++4GMjTe1ugunYQcox?=
 =?us-ascii?Q?oQjZrqI0XVnpqpq8XI0WKFKetZeBkN7h3tzBG319d8fW1EHurEtxij37jnf6?=
 =?us-ascii?Q?gI2jntzoRIBHcfc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 14:24:00.5626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f7d167-e30c-4e12-2d85-08dd573a6132
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7472


Hangbin Liu <liuhangbin@gmail.com> writes:

> This introduces a test for IPSec offload over bonding, utilizing netdevsim
> for the testing process, as veth interfaces do not support IPSec offload.
> The test will ensure that the IPSec offload functionality remains operational
> even after a failover event occurs in the bonding configuration.
>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  .../selftests/drivers/net/bonding/Makefile    |   3 +-
>  .../drivers/net/bonding/bond_ipsec_offload.sh | 155 ++++++++++++++++++
>  .../selftests/drivers/net/bonding/config      |   4 +
>  3 files changed, 161 insertions(+), 1 deletion(-)
>  create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh
>
> diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
> index 2b10854e4b1e..d5a7de16d33a 100644
> --- a/tools/testing/selftests/drivers/net/bonding/Makefile
> +++ b/tools/testing/selftests/drivers/net/bonding/Makefile
> @@ -10,7 +10,8 @@ TEST_PROGS := \
>  	mode-2-recovery-updelay.sh \
>  	bond_options.sh \
>  	bond-eth-type-change.sh \
> -	bond_macvlan_ipvlan.sh
> +	bond_macvlan_ipvlan.sh \
> +	bond_ipsec_offload.sh
>  
>  TEST_FILES := \
>  	lag_lib.sh \
> diff --git a/tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh b/tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh
> new file mode 100755
> index 000000000000..169866b47a67
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh
> @@ -0,0 +1,155 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# IPsec over bonding offload test:
> +#
> +#  +----------------+
> +#  |     bond0      |
> +#  |       |        |
> +#  |  eth0    eth1  |
> +#  +---+-------+----+
> +#
> +# We use netdevsim instead of physical interfaces
> +#-------------------------------------------------------------------
> +# Example commands
> +#   ip x s add proto esp src 192.0.2.1 dst 192.0.2.2 \
> +#            spi 0x07 mode transport reqid 0x07 replay-window 32 \
> +#            aead 'rfc4106(gcm(aes))' 1234567890123456dcba 128 \
> +#            sel src 192.0.2.1/24 dst 192.0.2.2/24
> +#            offload dev bond0 dir out
> +#   ip x p add dir out src 192.0.2.1/24 dst 192.0.2.2/24 \
> +#            tmpl proto esp src 192.0.2.1 dst 192.0.2.2 \
> +#            spi 0x07 mode transport reqid 0x07
> +#
> +#-------------------------------------------------------------------
> +
> +lib_dir=$(dirname "$0")
> +source "$lib_dir"/../../../net/lib.sh
> +algo="aead rfc4106(gcm(aes)) 0x3132333435363738393031323334353664636261 128"
> +srcip=192.0.2.1
> +dstip=192.0.2.2
> +ipsec0=/sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
> +ipsec1=/sys/kernel/debug/netdevsim/netdevsim0/ports/1/ipsec
> +ret=0
> +
> +cleanup()
> +{
> +	modprobe -r netdevsim
> +	cleanup_ns $ns
> +}
> +
> +active_slave_changed()
> +{
> +        local old_active_slave=$1
> +        local new_active_slave=$(ip -n ${ns} -d -j link show bond0 | \
> +				 jq -r ".[].linkinfo.info_data.active_slave")
> +        [ "$new_active_slave" != "$old_active_slave" -a "$new_active_slave" != "null" ]
> +}
> +
> +test_offload()
> +{
> +	# use ping to exercise the Tx path
> +	ip netns exec $ns ping -I bond0 -c 3 -W 1 -i 0 $dstip >/dev/null
> +
> +	active_slave=$(ip -n ${ns} -d -j link show bond0 | \
> +		       jq -r ".[].linkinfo.info_data.active_slave")
> +
> +	if [ $active_slave = $nic0 ]; then
> +		sysfs=$ipsec0
> +	elif [ $active_slave = $nic1 ]; then
> +		sysfs=$ipsec1
> +	else
> +		echo "FAIL: bond_ipsec_offload invalid active_slave $active_slave"
> +		ret=1
> +	fi
> +
> +	# The tx/rx order in sysfs may changed after failover
> +	if grep -q "SA count=2 tx=3" $sysfs && grep -q "tx ipaddr=$dstip" $sysfs; then
> +		echo "PASS: bond_ipsec_offload has correct tx count with link ${active_slave}"
> +	else
> +		echo "FAIL: bond_ipsec_offload incorrect tx count with link ${active_slave}"
> +		ret=1
> +	fi

lib.sh got all sorts of logging and checking helpers that were
previously in forwarding/, I think it makes sense to use them. Would the
following make sense to you?

test_offload()
{
	# use ping to exercise the Tx path
	ip netns exec $ns ping -I bond0 -c 3 -W 1 -i 0 $dstip >/dev/null

	active_slave=$(ip -n ${ns} -d -j link show bond0 | \
		       jq -r ".[].linkinfo.info_data.active_slave")

	RET=0

	if [ $active_slave = $nic0 ]; then
		sysfs=$ipsec0
	elif [ $active_slave = $nic1 ]; then
		sysfs=$ipsec1
	else
		check_err 1 "bond_ipsec_offload invalid active_slave $active_slave"
	fi

	# The tx/rx order in sysfs may changed after failover
	grep -q "SA count=2 tx=3" $sysfs && grep -q "tx ipaddr=$dstip" $sysfs
 	check_err $? "incorrect tx count with link ${active_slave}"

	log_test bond_ipsec_offload
}

... etc. below.

> +}
> +
> +if ! mount | grep -q debugfs; then
> +	mount -t debugfs none /sys/kernel/debug/ &> /dev/null

Clean this up at exit?

	defer umount /sys/kernel/debug/

(But then the cleanup trap needs to be registered sooner, and cleanup()
needs to invoke defer_scopes_cleanup.)

> +fi
> +
> +# setup netdevsim since dummy/veth dev doesn't have offload support
> +if [ ! -w /sys/bus/netdevsim/new_device ] ; then
> +	modprobe -q netdevsim
> +	if [ $? -ne 0 ]; then
> +		echo "SKIP: can't load netdevsim for ipsec offload"
> +		exit $ksft_skip
> +	fi

And here you can just schedule a cleanup, as above.

	defer modprobe -r netdevsim

> +fi
> +
> +trap cleanup EXIT
> +
> +setup_ns ns

defer cleanup_ns $ns

And at that point you can drop cleanup altogether, and just have:

trap defer_scopes_cleanup EXIT

> +ip -n $ns link add bond0 type bond mode active-backup miimon 100
> +ip -n $ns addr add $srcip/24 dev bond0
> +ip -n $ns link set bond0 up
> +
> +ifaces=$(ip netns exec $ns bash -c '
> +	sysfsnet=/sys/bus/netdevsim/devices/netdevsim0/net/
> +	echo "0 2" > /sys/bus/netdevsim/new_device
> +	while [ ! -d $sysfsnet ] ; do :; done
> +	udevadm settle
> +	ls $sysfsnet
> +')
> +nic0=$(echo $ifaces | cut -f1 -d ' ')
> +nic1=$(echo $ifaces | cut -f2 -d ' ')
> +ip -n $ns link set $nic0 master bond0
> +ip -n $ns link set $nic1 master bond0
> +
> +# create offloaded SAs, both in and out
> +ip -n $ns x p add dir out src $srcip/24 dst $dstip/24 \
> +    tmpl proto esp src $srcip dst $dstip spi 9 \
> +    mode transport reqid 42
> +
> +ip -n $ns x p add dir in src $dstip/24 dst $srcip/24 \
> +    tmpl proto esp src $dstip dst $srcip spi 9 \
> +    mode transport reqid 42
> +
> +ip -n $ns x s add proto esp src $srcip dst $dstip spi 9 \
> +    mode transport reqid 42 $algo sel src $srcip/24 dst $dstip/24 \
> +    offload dev bond0 dir out
> +
> +ip -n $ns x s add proto esp src $dstip dst $srcip spi 9 \
> +    mode transport reqid 42 $algo sel src $dstip/24 dst $srcip/24 \
> +    offload dev bond0 dir in
> +
> +# does offload show up in ip output
> +lines=`ip -n $ns x s list | grep -c "crypto offload parameters: dev bond0 dir"`
> +if [ $lines -ne 2 ] ; then
> +	echo "FAIL: bond_ipsec_offload SA offload missing from list output"
> +	ret=1
> +fi
> +
> +# we didn't create a peer, make sure we can Tx by adding a permanent neighbour
> +# this need to be added after enslave
> +ip -n $ns neigh add $dstip dev bond0 lladdr 00:11:22:33:44:55
> +
> +# start Offload testing
> +test_offload
> +
> +# do failover
> +ip -n $ns link set $active_slave down
> +slowwait 5 active_slave_changed $active_slave
> +test_offload

Hm, active_slave being overriden in the function is a bit sneaky. But
shifting the assignment out of the function is not great, because then
it would just needs to be done twice. Ho hum. This might just be the
least annoying way to write it after all.

> +
> +# make sure offload get removed from driver
> +ip -n $ns x s flush
> +ip -n $ns x p flush
> +line0=$(grep -c "SA count=0" $ipsec0)
> +line1=$(grep -c "SA count=0" $ipsec1)
> +if [ $line0 -ne 1 -o $line1 -ne 1 ]  ; then
> +	echo "FAIL: bond_ipsec_offload SA not removed from driver"
> +	ret=1
> +else
> +	echo "PASS: bond_ipsec_offload SA removed from driver"
> +fi
> +
> +exit $ret

With log_test this would be. It merges results from individual tests to
get the right exit status.

exit $EXIT_STATUS

> diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
> index dad4e5fda4db..054fb772846f 100644
> --- a/tools/testing/selftests/drivers/net/bonding/config
> +++ b/tools/testing/selftests/drivers/net/bonding/config
> @@ -9,3 +9,7 @@ CONFIG_NET_CLS_FLOWER=y
>  CONFIG_NET_SCH_INGRESS=y
>  CONFIG_NLMON=y
>  CONFIG_VETH=y
> +CONFIG_INET_ESP=y
> +CONFIG_INET_ESP_OFFLOAD=y
> +CONFIG_XFRM_USER=m
> +CONFIG_NETDEVSIM=m


