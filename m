Return-Path: <linux-kselftest+bounces-15310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8622B9519A0
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 13:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF931C218F2
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2024 11:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955751AE868;
	Wed, 14 Aug 2024 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kjRyicd5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD7C143878;
	Wed, 14 Aug 2024 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723633864; cv=fail; b=qLYzKE6ZJjJk+IW+22+z9jNYk4ZuWo/Q4m557Rs0xTv2U7naBK86HtRtuDL1rLh0lfVyKFpfCa821GKFHE+0vXzcDAVs83QZMc4M3mDo6gcAU0CyiaeCbuOaIfyrdEy02uePxyR9vUdZ32mc+ZdhgKRC5H/neQJ1X27BVW265K0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723633864; c=relaxed/simple;
	bh=6+Ah8au2Danq2Jq4DWCUfATI6Rh+oeBNbIzGeZCZWvE=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=A2JojC9IEe5L2sHR8VbkNmCkkFbca5YUasly9b9YHVKfAuoiNNa2FBofCxVEtk4i5ed3qW72SUdY1T0KNiEHTizqFehSSzbie+A+t9mzy6P5GJ6jOixyU0ERSQp76CHCizrZng33oMywZc38CFV3N24zD147oXyiTd/cJLu/jQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kjRyicd5; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlJD9wyW1kwGBcw+zaOjeUoJYplrXMlfm+b8QT2rLOdjRQhdEL0jTPBSX1aWoXMFQNZVFQk1KBq0VeRNywQXkPSdjbstzJG4b0md++wPx6SWc716nG1kjQn2Qv0G588UjzxmdLJ09PK3SBAT5AvWQ/zXFZPpPGLMCFy86+t4LeFII1qsFzW9TldKuHCDVRxvfUoWv9kTbSC2qWstML6uRvH1GDjYcgpWEOTNgovl4Hj1KM1auOASfsYb52URQmsLx7VB/lPQBFdjLcjBA75hP7IojFBrFvGmbtas8QFblXW08s+CZoPp834hMivltxJvU9MsEQo78BnH6NK8qN0rSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pASjlHF4Xlwe33AOi8y6A4TtJQ1SJxIrOLk8TctaSrk=;
 b=TiRmGdHyI8SnJJhyT5a74qAjOi1knxkQx7hyUTzdDygIVj0Iyqa3e8YZoP4GgFCamqWnsc6kgMiEx1pN7Lw/tuw/CPnt5FriYGQitaJtHZTjNeLoT2dz/TPblPEPRhAIHZtjEyhpBHZKEL4GxR2xdkhBfQxKpkj7FANKFcH6X8otmsSVCz+WXAkuh2ekBx4/I0fqrKUM1a4vzKfKK3p+Sw1Do5ZHW7RDriuzqaBRHLQcbVQ5YikZOmC0BZPIyqEvmYJHGKofrAeEVcN63AkCsG/S9+OzzGqRzpDbW8+jY0Q57Sbao310DoF+YpbgnJHqP7l+rs9uC3ZI7B6+Qll+4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pASjlHF4Xlwe33AOi8y6A4TtJQ1SJxIrOLk8TctaSrk=;
 b=kjRyicd5fpO3AirS7cOPeLc40tpWCy3d6eglXkXMbjp3ShmI9HcBF4Y47xsYDgh2p/oPqO3XJfnQSlnPh39j9+QfajbKJIuVZa97V7tgcmNSL2smO/92rhBXno7AEpZyE+IsuBj9f6HNKtCXtHaxTyfdBwrDBOZ5WzDvI9wkb88+QNCcI0GCFXkPuXHyahAb6f+vJ6gVXpf0l26/7YwsI7rcjlksnxL2lKbkGxuGmu9KLS6CzWEDi5jFp3ktPKVIVjAIE67oeJbSe2l4XZlb9BO19N7RPbRUUkQrDhiSdAem4lSWCPqVa+xg5iCkucGZp08wz4lSf7lKUL94TlUHqg==
Received: from SJ0PR13CA0239.namprd13.prod.outlook.com (2603:10b6:a03:2c1::34)
 by MW6PR12MB8760.namprd12.prod.outlook.com (2603:10b6:303:23a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Wed, 14 Aug
 2024 11:10:57 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::17) by SJ0PR13CA0239.outlook.office365.com
 (2603:10b6:a03:2c1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Wed, 14 Aug 2024 11:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 11:10:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 04:10:42 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 04:10:36 -0700
References: <20240813183825.837091-1-leitao@debian.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Breno Leitao <leitao@debian.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
	David Wei <dw@davidwei.uk>, Willem de Bruijn <willemb@google.com>, "Petr
 Machata" <petrm@nvidia.com>, open list <linux-kernel@vger.kernel.org>, "open
 list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, "Geliang
 Tang" <geliang@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, "Matthieu
 Baerts" <matttbe@kernel.org>
Subject: Re: [PATCH net-next v2] net: netconsole: selftests: Create a new
 netconsole selftest
Date: Wed, 14 Aug 2024 12:24:46 +0200
In-Reply-To: <20240813183825.837091-1-leitao@debian.org>
Message-ID: <87r0arl5qw.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|MW6PR12MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf7fd93-02df-4168-bb0e-08dcbc51c5a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0ls45XU8by/HYxANVZBPONhWa99YvM+WxxHZx4KzqGXIWBMyzpe7LaoGu4UX?=
 =?us-ascii?Q?7agNjU4d867+nWqaX/H97Fe+vei+1GRGS//B14ZZG5jOr98mkjeGnyS6FhYG?=
 =?us-ascii?Q?+Xqt59Dw+D3UKG17aYKy+c/5sVsL9b57ePCes9ZjNbMPBsIcAkeoh1X2h3IO?=
 =?us-ascii?Q?dCKXm/gGrHutVS8c3Re7zdeq159pG7yB1UnOKmk2IOwnpPFaBL9bddHIt3PO?=
 =?us-ascii?Q?5wY9AuSRcd/6fjZmqUhxK26XyXY6NhdZUkrFooBQVdiTd97dqfFgpG829i4e?=
 =?us-ascii?Q?hfCMXH5VxqfAYGpPm5He0pt+RULmGmwW9HryaSyHcBbH0Yn6Xl9w4n8o1D3i?=
 =?us-ascii?Q?gWNTGqvzBdqJ6rFZFZw8xo4hgv+O20tCtJh31f3HjOwxHVawMMySAHilwl8/?=
 =?us-ascii?Q?YIkili9y1WEdG39boeIR2u+tvY7qLyrsE7cHY88vclk8pU//KhU5gqkPUFwm?=
 =?us-ascii?Q?38YkRqZQ+7gvRjOy3crjrlffaxg9o0hYwniab0r1WlM2W46fHFYcX9+mrVBe?=
 =?us-ascii?Q?uXRh7BIEzVZ8n6+iZb/FGLiddU5eI467STROjndkUhAVhl6qOUvnhdn8WBcU?=
 =?us-ascii?Q?ee/6BoHdxg2phggKJ77jddnjrwP6eisw2M5Tw78e0dbBirhGNfCqXFzFJK47?=
 =?us-ascii?Q?i+PB9ebOV+z0UYxoeG5/TbHPcypUqYNE1nWtsAy6tMa1jVBqnEA1mHCoZOfG?=
 =?us-ascii?Q?t9RDbiuC4dfGb+65h4skfrWWf4m4Tm7i8xAFdvSzVDcmGb2exJepxiCgaHad?=
 =?us-ascii?Q?ko+I5RxH3NiMPeApjT++Z5a0Dbx63HIENO3fvscugr20o42G3QXuv1mfH4K2?=
 =?us-ascii?Q?KAFsVBvPs7kFiGlvFbol+c3tQKd9E/rKzKpH49utK0rRctQBrZ+EvB35zVgB?=
 =?us-ascii?Q?ODhtaPrAe05/Yh/6K+keK8XYGoVt/l6SkgSKseYWxzYsQu/x5OhcF+ZMzgQ2?=
 =?us-ascii?Q?o4hNBVIO8oiHaj7UIcKYZSoUEMSxqpqeQcDrW7gbkodd4SafAkMj3GsOzkgW?=
 =?us-ascii?Q?4qq13nM5jqkfKZGIb4wjoWK+RI77+4KxJzPf64jlNKKvfPPNtG7D5BG6Jbka?=
 =?us-ascii?Q?UKXFYzQRNpQli4v1OJRIx43bW1N+YUlHrwh/aaRikviJnA2gsJQBPPmpsnsQ?=
 =?us-ascii?Q?/PiJtG//aeK4sbVLyMnF/5C0t9NwzD3X13uMsPmr0i6NweoddIJV4+P5tkNf?=
 =?us-ascii?Q?sxa0E9fUJ8zDfXZ6l/Q5h/+ATL9SEvmtnddMXTKbEmgYczZmU1zmAf0Lo+/3?=
 =?us-ascii?Q?Fe6jevQ2ujTPfbAHxjAf3E+tZMfEFeL8H208N1lUHXzxeUwQlh0SGnZUi6Px?=
 =?us-ascii?Q?gFHFNKK/k9V3PIf44ZBSs1yNJ/9rqHsLhGxltqRHp8NESHbNLPHeKow4mYy+?=
 =?us-ascii?Q?eVZELaOKnDavUE1fpAzdDxSR6dfMT5lhMlWVb3WKk+YPBde3hx+MGXs/lW8P?=
 =?us-ascii?Q?J4D+JBnlZVoDhfccnrSaejP+1uButNau?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 11:10:57.3513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf7fd93-02df-4168-bb0e-08dcbc51c5a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8760


Breno Leitao <leitao@debian.org> writes:

> Adds a selftest that creates two virtual interfaces, assigns one to a
> new namespace, and assigns IP addresses to both.
>
> It listens on the destination interface using socat and configures a
> dynamic target on netconsole, pointing to the destination IP address.
>
> The test then checks if the message was received properly on the
> destination interface.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Changelog:
>
> v2:
>  * Change the location of the path (Jakub)
>  * Move from veth to netdevsim
>  * Other small changes in dependency checks and cleanup
>
> v1:
>  * https://lore.kernel.org/all/ZqyUHN770pjSofTC@gmail.com/
>
>  MAINTAINERS                                   |   1 +
>  tools/testing/selftests/drivers/net/Makefile  |   1 +
>  .../selftests/drivers/net/netcons_basic.sh    | 223 ++++++++++++++++++
>  3 files changed, 225 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/netcons_basic.sh
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a9dace908305..ded45f1dff7e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15770,6 +15770,7 @@ M:	Breno Leitao <leitao@debian.org>
>  S:	Maintained
>  F:	Documentation/networking/netconsole.rst
>  F:	drivers/net/netconsole.c
> +F:	tools/testing/selftests/drivers/net/netcons_basic.sh
>  
>  NETDEVSIM
>  M:	Jakub Kicinski <kuba@kernel.org>
> diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
> index e54f382bcb02..928530b26abc 100644
> --- a/tools/testing/selftests/drivers/net/Makefile
> +++ b/tools/testing/selftests/drivers/net/Makefile
> @@ -3,6 +3,7 @@
>  TEST_INCLUDES := $(wildcard lib/py/*.py)
>  
>  TEST_PROGS := \
> +	netcons_basic.sh \
>  	ping.py \
>  	queues.py \
>  	stats.py \
> diff --git a/tools/testing/selftests/drivers/net/netcons_basic.sh b/tools/testing/selftests/drivers/net/netcons_basic.sh
> new file mode 100755
> index 000000000000..e0e58fc7e89f
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
> @@ -0,0 +1,223 @@
> +#!/usr/bin/env bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# This test creates two netdevsim virtual interfaces, assigns one of them (the
> +# "destination interface") to a new namespace, and assigns IP addresses to both
> +# interfaces.
> +#
> +# It listens on the destination interface using socat and configures a dynamic
> +# target on netconsole, pointing to the destination IP address.
> +#
> +# Finally, it checks whether the message was received properly on the
> +# destination interface.  Note that this test may pollute the kernel log buffer
> +# (dmesg) and relies on dynamic configuration and namespaces being configured.
> +#
> +# Author: Breno Leitao <leitao@debian.org>
> +
> +set -euo pipefail
> +
> +SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
> +
> +# Simple script to test dynamic targets in netconsole
> +SRCIF="" # to be populated later
> +SRCIP=192.168.1.1
> +DSTIF="" # to be populated later
> +DSTIP=192.168.1.2
> +
> +PORT="6666"
> +MSG="netconsole selftest"
> +TARGET=$(mktemp -u netcons_XXXXX)
> +NETCONS_CONFIGFS="/sys/kernel/config/netconsole"
> +NETCONS_PATH="${NETCONS_CONFIGFS}"/"${TARGET}"
> +# This will have some tmp values appended to it in set_network()
> +NAMESPACE="netconsns_dst"
> +
> +# IDs for netdevsim
> +NSIM_DEV_1_ID=$((256 + RANDOM % 256))
> +NSIM_DEV_2_ID=$((512 + RANDOM % 256))
> +
> +# Used to create and delete namespaces
> +source "${SCRIPTDIR}"/../../net/lib.sh
> +
> +# Create netdevsim interfaces
> +create_ifaces() {
> +	local NSIM_DEV_SYS_NEW=/sys/bus/netdevsim/new_device
> +
> +	echo "$NSIM_DEV_2_ID" > "$NSIM_DEV_SYS_NEW"
> +	echo "$NSIM_DEV_1_ID" > "$NSIM_DEV_SYS_NEW"
> +	udevadm settle || true
> +
> +	local NSIM_DEV_1_SYS=/sys/bus/netdevsim/devices/netdevsim"$NSIM_DEV_1_ID"
> +	local NSIM_DEV_2_SYS=/sys/bus/netdevsim/devices/netdevsim"$NSIM_DEV_2_ID"
> +
> +	# These are global variables
> +	SRCIF=$(find "$NSIM_DEV_1_SYS"/net -maxdepth 1 -type d ! \
> +		-path "$NSIM_DEV_1_SYS"/net -exec basename {} \;)
> +	DSTIF=$(find "$NSIM_DEV_2_SYS"/net -maxdepth 1 -type d ! \
> +		-path "$NSIM_DEV_2_SYS"/net -exec basename {} \;)
> +}
> +
> +link_ifaces() {
> +	local NSIM_DEV_SYS_LINK="/sys/bus/netdevsim/link_device"
> +	local SRCIF_IFIDX=$(cat /sys/class/net/"$SRCIF"/ifindex)
> +	local DSTIF_IFIDX=$(cat /sys/class/net/"$DSTIF"/ifindex)
> +
> +	exec {NAMESPACE_FD}</var/run/netns/"${NAMESPACE}"
> +	exec {INITNS_FD}</proc/self/ns/net
> +
> +	# Bind the dst interface to namespace
> +	ip link set "${DSTIF}" netns "${NAMESPACE}"
> +
> +	# Linking one device to the other one (on the other namespace}
> +	echo "${INITNS_FD}:$SRCIF_IFIDX $NAMESPACE_FD:$DSTIF_IFIDX" > $NSIM_DEV_SYS_LINK
> +	if [ $? -ne 0 ]; then
> +		echo "linking netdevsim1 with netdevsim2 should succeed"
> +		cleanup
> +		exit ${ksft_skip}
> +	fi
> +}
> +
> +function configure_ip() {
> +	# Configure the IPs for both interfaces
> +	ip netns exec "${NAMESPACE}" ip addr add "${DSTIP}"/24 dev "${DSTIF}"
> +	ip netns exec "${NAMESPACE}" ip link set "${DSTIF}" up
> +
> +	ip addr add "${SRCIP}"/24 dev "${SRCIF}"
> +	ip link set "${SRCIF}" up
> +}
> +
> +function set_network() {
> +	# This is coming from lib.sh. And it does unbound variable access
> +	set +u
> +	setup_ns "${NAMESPACE}"
> +	set -u

It would make sense to fix lib.sh. I think this is what is needed?

modified   tools/testing/selftests/net/lib.sh
@@ -178,7 +178,7 @@ setup_ns()
 		fi
 
 		# Some test may setup/remove same netns multi times
-		if [ -z "${!ns_name}" ]; then
+		if ! declare -p "$ns_name" &> /dev/null; then
 			eval "${ns_name}=${ns_name,,}-$(mktemp -u XXXXXX)"
 		else
 			cleanup_ns "${!ns_name}"

CC'd Geliang Tang <geliang@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>,
Matthieu Baerts (NGI0) <matttbe@kernel.org> who were in the vicinity
in the past.

> +	NAMESPACE=${NS_LIST[0]}
> +
> +	# Create both interfaces, and assign the destination to a different namespace
> +	create_ifaces
> +
> +	# Link both interfaces back to back
> +	link_ifaces
> +
> +	configure_ip
> +}
> +
> +function create_dynamic_target() {
> +	DSTMAC=$(ip netns exec "${NAMESPACE}" ip link show "${DSTIF}" | awk '/ether/ {print $2}')
> +
> +	# Create a dynamic target
> +	mkdir "${NETCONS_PATH}"
> +
> +	echo "${DSTIP}" > "${NETCONS_PATH}"/remote_ip
> +	echo "${SRCIP}" > "${NETCONS_PATH}"/local_ip
> +	echo "${DSTMAC}" > "${NETCONS_PATH}"/remote_mac
> +	echo "${SRCIF}" > "${NETCONS_PATH}"/dev_name
> +
> +	echo 1 > "${NETCONS_PATH}"/enabled
> +}
> +
> +function cleanup() {
> +	local NSIM_DEV_SYS_DEL="/sys/bus/netdevsim/del_device"
> +
> +	# delete netconsole dynamic reconfiguration
> +	echo 0 > "${NETCONS_PATH}"/enabled
> +	# Remove the configfs entry
> +	rmdir "${NETCONS_PATH}"
> +
> +	# Delete netdevsim devices
> +	echo "$NSIM_DEV_2_ID" > "$NSIM_DEV_SYS_DEL"
> +	echo "$NSIM_DEV_1_ID" > "$NSIM_DEV_SYS_DEL"
> +
> +	# this is coming from lib.sh
> +	cleanup_all_ns
> +}
> +
> +function listen_port_and_save_to() {
> +	OUTPUT=${1}

local

> +	# Just wait for 2 seconds
> +	timeout 2 ip netns exec "${NAMESPACE}" socat UDP-LISTEN:"${PORT}",fork "${OUTPUT}"
> +}
> +
> +function validate_result() {
> +	TMPFILENAME="$1"

local

> +
> +	# Check if the file exists
> +	if [ ! -f "$TMPFILENAME" ]; then
> +	    echo "FAIL: File was not generated." >&2
> +	    return ${ksft_fail}

The indentation seems wrong here.

> +	fi
> +
> +	if ! grep -q "${MSG}" "${TMPFILENAME}"; then
> +	    echo "FAIL: ${MSG} not found in ${TMPFILENAME}" >&2
> +	    cat "${TMPFILENAME}" >&2
> +	    return ${ksft_fail}
> +	fi
> +
> +	# Delete the file once it is validated, otherwise keep it
> +	# for debugging purposes
> +	rm "${TMPFILENAME}"

Seeing the removal within the validation function is odd, I would expect
it to be part of cleanup().

> +	return ${ksft_pass}
> +}
> +
> +function check_for_dependencies() {
> +	if [ "$(id -u)" -ne 0 ]; then
> +		echo "This script must be run as root" >&2
> +		exit "${ksft_skip}"
> +	fi
> +
> +	if ! which socat > /dev/null ; then
> +		echo "SKIP: socat(1) is not available" >&2
> +		exit "${ksft_skip}"
> +	fi
> +
> +	if ! which ip > /dev/null ; then
> +		echo "SKIP: ip(1) is not available" >&2
> +		exit "${ksft_skip}"
> +	fi
> +
> +	if ! which udevadm > /dev/null ; then
> +		echo "SKIP: udevadm(1) is not available" >&2
> +		exit "${ksft_skip}"
> +	fi
> +
> +	if [ ! -d "${NETCONS_CONFIGFS}" ]; then
> +		echo "SKIP: directory ${NETCONS_CONFIGFS} does not exist. Check if NETCONSOLE_DYNAMIC is enabled" >&2
> +		exit "${ksft_skip}"
> +	fi
> +
> +	if ip link show "${DSTIF}" 2> /dev/null; then
> +		echo "SKIP: interface ${DSTIF} exists in the system. Not overwriting it."
> +		exit "${ksft_skip}"
> +	fi
> +}
> +
> +# ========== #
> +# Start here #
> +# ========== #
> +modprobe netdevsim || true
> +# The content of kmsg will be save to the following file
> +OUTPUT_FILE="/tmp/${TARGET}"
> +
> +# Check for basic system dependency and exit if not found
> +check_for_dependencies
> +# Remove the namespace, interfaces and netconsole target on exit
> +trap cleanup EXIT
> +# Create one namespace and two interfaces
> +set_network
> +# Create a dynamic target for netconsole
> +create_dynamic_target
> +# Listed for netconsole port inside the namespace and destination interface
> +listen_port_and_save_to "${OUTPUT_FILE}" &
> +
> +# Wait for socat to start and listen to the port.
> +sleep 1
> +# Send the message
> +echo "${MSG}: ${TARGET}" > /dev/kmsg
> +# Wait until socat saves the file to disk
> +sleep 1
> +
> +# Make sure the message was received in the dst part
> +validate_result "${OUTPUT_FILE}"
> +ret=$?
> +
> +exit ${ret}


