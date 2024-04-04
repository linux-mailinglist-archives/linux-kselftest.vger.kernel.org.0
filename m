Return-Path: <linux-kselftest+bounces-7180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690048985FA
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 13:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9C028B4B0
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 11:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE1B82864;
	Thu,  4 Apr 2024 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fOd42MNN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F845757F8;
	Thu,  4 Apr 2024 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712229806; cv=fail; b=p6tg0/0RjTYXFxC4tFRrT2T/wwVdwVuPw5N7gM5YraSt+bu4GDj/aOigFGopXtXsk3w4AwhS5tysQxX5wzpaNiB4cPzT0F6KMRUwrV+L50ALDjcrBoYiRuDNIltb7XG5E/xahmqkALkZ28yK6ID4PaTgUtcK331c6B+f2VZjzaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712229806; c=relaxed/simple;
	bh=iJkV+5QXOMt/0Qo/4ahXfYzQBbiPa93OAzG+vOrctoo=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=mVbwOy76kamnErTltJQ/0HOJaeRUA0YYnPsUSErf20K15U82uBcNoaLwr63wLNSagPiavZGCrw6bUmd3MPQikz8HBfasfc/bjmsgDqGk//ir+LuknLVSbiYpVdg2f+oBAOgRihj6PyDyotQdug9PVQIzxwhzeI0Te58NmGT8L98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fOd42MNN; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8UA6WWmnWFi3PnxZFS3pnPHe+/102EbYLF8UXYBGh0OQzLY2ZIv/gW0nTFaiWTToPRDl1wan8xBBggijuEyIiTJeIQdTnGIu8NICvMv/xO8BaSXcsiT3vhU4+urY0MPbunkO09aaR0FRG+qS0pw2ScMZ6m6ywi7TKg6JsAuT/krvQgtqGbCWeyCpQfK2/5VT/Pl64ne72Tl38ckEKhSDFWet1sqXJTozf6yneBRTpTCINi8go1s2MEiw1QWFQaQGiOHUN6QQja5kLiZE/zoMh7FAsLzPu1+lNgwVZutcdXKOJUJNeA4XCWjo2Ud/3+oZGNkGbQYvM9jlHZOwvUXpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yD+IdKoIgrnWmIibRwawUw7HFGKsSujic+64NwX7ykI=;
 b=FZC93CkusrfOIoQXniXrFYsHkn/70ZTZNht9M6agaVMAGMyowHXLSBpybVn0CrCwJEfL33BMPgbFkAQNjT+AqQQ37j7H2mm/UuXe/h3CDnqUmyNUqOvCC/G5ES07OS7uzSOllYNIno689LV2idTcndSBXEFqThWSxi752BHbzq685HeYNlCavnJ3WupsVPGIxjOBwGr1eDSAq424b0h5h0OHXKPUVv7rRrubpUW1A52E6lcABmrXP4BNkeIJC9AMMb4ktwfpg4+QZPZewbpDh6nly442fJBEqLSKwCARhbWFWszUXEOG18lsslH0/VtViAnSXUUstbFdMKskseoClQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yD+IdKoIgrnWmIibRwawUw7HFGKsSujic+64NwX7ykI=;
 b=fOd42MNNVJTEr9sgpMf250dXC4efdbmldUX0CNAlLqNRwdLcFHjhjjvsrDIIZ139UelPUNQIx/6ThLiQfPd62sFOcpKvf3Cx7zhmiD8noyDxk85NMD/gGVGr1SOC4WGgzf0UUajlKPpfy+O616+NForIlTYKDs3WEugmNiQ6MsyKWZvblkAccEA/eUuiL1j4yuKihXriHS+OVA7YBEgM3+gW8PUGWVSNIp19ypaCsOC6idHP/sUYAvbPusIAQTdnBl0vEJfDOQLUpJMI5YVwBv0UtDzIzzC2F7rX+U1dZmLczX9QFTvX5tYS+qpjLchL0+h7OEnOLbJQuXLpTX/DJA==
Received: from SA1P222CA0137.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::6)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 11:23:22 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:3c2:cafe::68) by SA1P222CA0137.outlook.office365.com
 (2603:10b6:806:3c2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Thu, 4 Apr 2024 11:23:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 11:23:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Apr 2024
 04:23:11 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 4 Apr
 2024 04:23:07 -0700
References: <20240403023426.1762996-1-kuba@kernel.org>
 <20240403023426.1762996-7-kuba@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <sdf@google.com>,
	<donald.hunter@gmail.com>, <linux-kselftest@vger.kernel.org>,
	<petrm@nvidia.com>
Subject: Re: [PATCH net-next v2 6/7] selftests: drivers: add scaffolding for
 Netlink tests in Python
Date: Thu, 4 Apr 2024 12:42:24 +0200
In-Reply-To: <20240403023426.1762996-7-kuba@kernel.org>
Message-ID: <87zfu9fk2v.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|DS0PR12MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: c9515932-e68d-4cbe-a460-08dc5499a326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aGpM05/pPjtraIv9js5rPOwgtTzOK/oQTiBfvMw7j9izcIU/p9wsePg1ZrMoCjnZPdN1ZX3mNv9tXrNKHRm0o7qDseGc53M6LfYHTLIDcTSa8U4Z6ecMtferkFaam1X6+/OdT9wnCNhPYqquEQ95YKPAhFJ/JXxLkLsov3dKbkmVgo4cagJmf3+coMCz/gPzr34WWcGMaHc4hEDV11ZilpQdf9LftQQ3vFe5EM2YYHXNXs54Ff9skamQ+jnN91q170LwXbhmAAa/UIL84XkAtB6LTxkmVOHVKNVlAzhCZP1JXaOaRO9o3xo0xk0Gc2g6bvRnXrpFmQoWvHzgML8sdPYo2K1ucJOQ4AZ6TJTotRZT8pehX6AKrTq6yEtbBH/aNXUCH1pIbamy53vepk1dBy1SCbCD6ZsDRXC2b8NDeNiMS0EIzN/pWBfSmvvkbctCOpgHcBMBH4SsNFGc/nQTeSuvoV2WrqrvK0JTBnxux6On91CUbN3eQaZ+nJfUrWE/k7uhiDhKYF/LjfcHwIrGIYALt+Vsw7fD5yvwUw1xgd42JhaGqRXA/tBc0ULffPuo87grvQ60E0xgK3cwIO70RH6ZZwbH7Ox5RsZPy8we2iwWPJ27DnSaFvdelEix7NWeqjYc6UzhCza8gFtLXEMJ1bKn6LVm602/KOa2tj/4AoF4RO0wqWdqCl/5f3BPbc1RjFedtz57OcO97eF1YM1dsJYJED4WkOrJBYNhz1uD7JoF4d7gdtGiGdivrEgeCyg/
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 11:23:22.2309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9515932-e68d-4cbe-a460-08dc5499a326
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453


Jakub Kicinski <kuba@kernel.org> writes:

> Add drivers/net as a target for mixed-use tests.
> The setup is expected to work similarly to the forwarding tests.
> Since we only need one interface (unlike forwarding tests)
> read the target device name from NETIF. If not present we'll
> try to run the test against netdevsim.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

However:

> diff --git a/tools/testing/selftests/net/lib/py/nsim.py b/tools/testing/selftests/net/lib/py/nsim.py
> new file mode 100644
> index 000000000000..25ae0d081788
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib/py/nsim.py
> @@ -0,0 +1,118 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import json
> +import os
> +import random
> +import re
> +import time
> +from .utils import cmd, ip
> +
> +
> +class NetdevSim:
> +    """
> +    Class for netdevsim netdevice and its attributes.
> +    """
> +
> +    def __init__(self, nsimdev, port_index, ifname, ns=None):
> +        # In case udev renamed the netdev to according to new schema,
> +        # check if the name matches the port_index.
> +        nsimnamere = re.compile(r"eni\d+np(\d+)")
> +        match = nsimnamere.match(ifname)
> +        if match and int(match.groups()[0]) != port_index + 1:
> +            raise Exception("netdevice name mismatches the expected one")
> +
> +        self.ifname = ifname
> +        self.nsimdev = nsimdev
> +        self.port_index = port_index
> +        self.ns = ns
> +        self.dfs_dir = "%s/ports/%u/" % (nsimdev.dfs_dir, port_index)
> +        ret = ip("-j link show dev %s" % ifname, ns=ns)
> +        self.dev = json.loads(ret.stdout)[0]

I don't think self.ifname, .ns, .dfs_dir, .dev are actually used outside
of this function.

> +
> +    def dfs_write(self, path, val):
> +        self.nsimdev.dfs_write(f'ports/{self.port_index}/' + path, val)
> +
> +
> +class NetdevSimDev:
> +    """
> +    Class for netdevsim bus device and its attributes.
> +    """
> +    @staticmethod
> +    def ctrl_write(path, val):
> +        fullpath = os.path.join("/sys/bus/netdevsim/", path)
> +        with open(fullpath, "w") as f:
> +            f.write(val)
> +
> +    def dfs_write(self, path, val):
> +        fullpath = os.path.join(f"/sys/kernel/debug/netdevsim/netdevsim{self.addr}/", path)
> +        with open(fullpath, "w") as f:
> +            f.write(val)
> +
> +    def __init__(self, port_count=1, ns=None):
> +        # nsim will spawn in init_net, we'll set to actual ns once we switch it the.sre

the.sre?

