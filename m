Return-Path: <linux-kselftest+bounces-46011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A48C7062E
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 18:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A22913C57E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 17:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1793081DA;
	Wed, 19 Nov 2025 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E02hMbT5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011040.outbound.protection.outlook.com [40.93.194.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2912D2E8B66;
	Wed, 19 Nov 2025 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571655; cv=fail; b=es9RzG/M1H1Df7j2cApZxkJe2M/oftL2T3PCDX4mLTmefxlq9Y4ZmQFtcVWVwTuAz46xcR8xuSw/xxPogpbTut92KlFQhsE4Yr/IpmJsPBTIPuJpvp4pL1p12Zim1sQJwXmiMeZTYqBHMsdf/E5zbRjcioXTBX7XBpfLeixh77A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571655; c=relaxed/simple;
	bh=JIlfRoxp+4omHCblGeNkOtq8XzM1Wg05EIcWXrokc1M=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Nrgx6FnJ+Cbp0q+0JW76aJc8+2R0thaA5G4fZafHYztUXcqpeEbqCbrEnSqQFIkFLtVUdWf+xKAbw8NOlnn0/vEiiFfVy6oY+vBZ/oU1vo7OOj2moMLJgKKxurcYPUUugnXOLw1whu5g792UF1WhfxxRfrZ52jKQ6Yuffsgy+CA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E02hMbT5; arc=fail smtp.client-ip=40.93.194.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+PWjpaTt/bpYNkfuvhVQhJWMHRm9nTYFUooYuJ3rv4MoMVWvrihdQm5OfWL4gtUQukeCNu+pJz241BB94KL0R166PBNr08vX9uvMImXApYBcW5Ay4BiUlcGp8E75L8qUc+0aPGtLP7+3mnK/1iwwRpooBi6WuNs15xkcrEW3X+ojKHPU8YIgE6Oz9wGyTNsUxavd9Onf1u55+1KCD3jGgIVdpUPiko8MvoeM6ob7BI+h2/Yr/vgvCGHaf8z8GH3XgUHEz9NWKYep9/P8uiR+bM9+SgzQgeH4O7yIHOOXapo2yXzFUQybXNCkxJsA3Jsds7XypySs+u0CywZi6EOAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3igZpjbMBS1YbunztfnHZGPh7i1TN/8cprvfMNWnMBI=;
 b=p+BGEInvqWo5UaF/Y5Cki9Tu1vtWwk9JaTalaEKjjjnVDRWXaX3OpSvy89Bv+ExTYeRnWkoIDAJzOPyEjmHDDZotJ771aeWbSbREgapRZqL3PKKhLVyg7yeJ3q+0uaGT4XvGiiGyq+S/66oC3UYNfhX2ZCD2L77SQK9yQGCnsqa3zy4eMRoAi9heRhFLxeFWdpUbLdPId6LDl5AWebcELUZ+SY/YCPGR4yzJBf8HrzOungLYVb+mtyIn4M/kBwsfQ/W3L/5jVh0FrHleEVsZGvGxDuYrJPu02B6TWoufnAmnucrOCrgzviXfYTfsNj2o7ftawiNOiTLYG7n8RmoXTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3igZpjbMBS1YbunztfnHZGPh7i1TN/8cprvfMNWnMBI=;
 b=E02hMbT50FmlUxn4oMLdtnmhc6ybixOQVEPGwAl7zbD3Jk68qhTfMHPo4WHL1QcPm3ZVUykE5+ok56OEK3FK2Nem2KJlNZ7ewz3uD5ykKnodeoyYKXfPvSFcEeqmFGd1E6IPxstdOro/HTHa0Yq4px0JcBYQgqkMr3r1XtlHp+xYhOTRy7YTASjK9e0Hv48L+Adoy2LFC9gwwsmMAXe6lMSktgmoewvPoiNov4sZo3cZ2XIwFJZ4LqO1yX6BZxc6C0e2IaZ5Dg8bjMCE3ZXXTzJ5Lu0RQyLRVEEAzlV7LFbNrTyRSZ976bKDPsaPgBMxUAKh9wVW8pDQ4Lc/MjJUQw==
Received: from BYAPR08CA0022.namprd08.prod.outlook.com (2603:10b6:a03:100::35)
 by CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 17:00:41 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::68) by BYAPR08CA0022.outlook.office365.com
 (2603:10b6:a03:100::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 17:00:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 17:00:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 09:00:15 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 09:00:09 -0800
References: <20251118215126.2225826-1-kuba@kernel.org>
 <20251118215126.2225826-11-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<willemdebruijn.kernel@gmail.com>, <shuah@kernel.org>, <sdf@fomichev.me>,
	<krakauer@google.com>, <linux-kselftest@vger.kernel.org>, <petrm@nvidia.com>,
	<matttbe@kernel.org>
Subject: Re: [PATCH net-next v2 10/12] selftests: drv-net: hw: convert the
 Toeplitz test to Python
Date: Wed, 19 Nov 2025 17:39:46 +0100
In-Reply-To: <20251118215126.2225826-11-kuba@kernel.org>
Message-ID: <87fraaarfv.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|CH3PR12MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc9638e-7a4c-4319-6cf5-08de278d2c0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UtuS+nb6SVPT8at8vCoDIgZcfUp/T6jSjEImAuFyGaRwmWl1zHkgMWFoeOgq?=
 =?us-ascii?Q?IfCee5Mit4QKXnqXG5ejBOsvERMJWAx2qKmtwd7WJkZOikKBU2sH2ghWXJ5V?=
 =?us-ascii?Q?9l72xorkE+Uua6G/vAY3PPO0XwgqDQyPSaSkn4bUXcO+vsvol8MrXONWEnZw?=
 =?us-ascii?Q?CBR2G2sAs/p1byz/NRreDG69cVd8tawe2wOWjtCWyNg1EzYcUO3PXbIkc9DT?=
 =?us-ascii?Q?0g0xw82o93V4szy6FvfAvm/+0vjP1LnYIxHK/lWA2ODc5Yncx5Js4YEylO+o?=
 =?us-ascii?Q?dIZvVJwTEezJ+9FKiecrDskzcXan0aE/F5zlQpqCTB623TLhQXaddD82IdL9?=
 =?us-ascii?Q?7zLPxs72wYTXsH9N2uOdLeAakJ7kflkenJIHW5Bk1ndV66APb0y7p4eqR13k?=
 =?us-ascii?Q?FRg+eBqF5c0KDImhp+oeMBMLq7OeqFk4ySjmZve1PTpJOWpYPdn63Scl4kLh?=
 =?us-ascii?Q?InEcsBddqf3TJfU32ahAyCULxHhEMwr8foF5O4BYPJ/yJMsKXd6GEnc3pn7D?=
 =?us-ascii?Q?xtXZGYILzEN2DcCe8gqN1RyZakSJ5umpMrAgQcv9Tgva1A61jcX4UjGbBU3U?=
 =?us-ascii?Q?zfBw8YegEyCKI+FJB2KkgpsKUCBAfAp3KsW2BZyDPvHZ0N7EQEglkhtt8b76?=
 =?us-ascii?Q?22xR2tNhAJ1Ny/0e4wv7Hz7GLG4AF91wJa/dgsM1KaZp7vamiy88M/zacaMo?=
 =?us-ascii?Q?9dZy1Ra9KPK1OJryHPnJdb8lZ/hO/DGDNqe0sTmt0wBEfbxGl8BNaXVzRTpi?=
 =?us-ascii?Q?xv7znORkGnLVylE0c1og4j7j3IqvHCkJuaYAmoCQIrDyaZ8W397LWnLAu5TT?=
 =?us-ascii?Q?SLMGINxrbeXfrcaw0PfYeH3r2XJHqHyhbfEmudaJIQBsvfSQVb6COwCypD2s?=
 =?us-ascii?Q?35FTKagq6nfJys/Qsy02LxZDMTuU51U4uLXFoJtuOV6Vqbjbm7F+pJd5PZ8n?=
 =?us-ascii?Q?E2gTRTyaJaIC66VI8L1Anww4wryY1jbbfC9A1u80AMNcZqf/rJ3mJIT56kyz?=
 =?us-ascii?Q?lv1mFPGTWe2vVtuApRF2TmQT58mPj+XTJeckxFZsBWtyaBC0Kz97RIOt8lQk?=
 =?us-ascii?Q?DyIDaptT2nsdP/0zJBpQRwpP8z7vTGc8TOvvuER47/um/xOmq9UgPbnLLY/I?=
 =?us-ascii?Q?rFfgO4Pz3sVbvb/jvXDvbnvjP5xgwn4ageCENZsQTzTNPjUFQucSXV44h/0m?=
 =?us-ascii?Q?NiIRtyNHqP/QPooCDkbwVXaigEbpXof4a6+WAEzNIYuqW+R1u2rNBhF3zNXc?=
 =?us-ascii?Q?qfdN+jjO7qBBzaZi8vDXUAPCoNvT0MTSMADBUWhjldeCiMm5uHdo+FM9JqPV?=
 =?us-ascii?Q?jnJ24iowfcozbFBbzboa+/5rCqFl+19jzhGCt2OLVMKy0miS5HtzimCswfoj?=
 =?us-ascii?Q?XPTXT89SsAsmeBcXEA0NgOjHhfWKv+hJqY7K955HRRCzU2QAGyns3v5dg6Ym?=
 =?us-ascii?Q?xBjaXHZ+SxqNaqH6erF4gSRe/QLhvCC8OQfmvTQYQZ1rE11oQECN1UOgNQbW?=
 =?us-ascii?Q?bCN1OekwFRzTf9MDUaBvkMA7VzapaSbiVnRa0mRbG3UtcOupSixGT6zMUGci?=
 =?us-ascii?Q?bdPz66M/i+AlVDq3ZCk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 17:00:41.4828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc9638e-7a4c-4319-6cf5-08de278d2c0c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7763


Jakub Kicinski <kuba@kernel.org> writes:

> Rewrite the existing toeplitz.sh test in Python. The conversion
> is a lot less exact than the GRO one. We use Netlink APIs to
> get the device RSS and IRQ information. We expect that the device
> has neither RPS nor RFS configured, and set RPS up as part of
> the test.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

> +    # Set RPS bitmap for all rx queues
> +    for rps_file in glob.glob(f"/sys/class/net/{cfg.ifname}/queues/rx-*/rps_cpus"):
> +        cmd(f"echo {mask} > {rps_file}", shell=True)

A bit odd to use echo like this, the other test does this through open /
write. Unless I'm missing something and this actually runs remotely...?

Anyway, not important. Just that maybe eventually some helpers that
support this sysfs-based configuration might be handy.

> +    return mask
> +
> +
> +def _send_traffic(cfg, proto_flag, ipver, port):
> +    """Send 20 packets of requested type."""
> +
> +    # Determine protocol and IP version for socat
> +    if proto_flag == "-u":
> +        proto = "UDP"
> +    else:
> +        proto = "TCP"
> +
> +    baddr = f"[{cfg.addr_v['6']}]" if ipver == "6" else cfg.addr_v["4"]
> +
> +    # Run socat in a loop to send traffic periodically
> +    # Use sh -c with a loop similar to toeplitz_client.sh
> +    socat_cmd = f"""
> +    for i in `seq 20`; do
> +        echo "msg $i" | socat -{ipver} -t 0.1 - {proto}:{baddr}:{port};
> +        sleep 0.001;
> +    done
> +    """

Yeah, what with the remote execution, this probably makes sense.

> +    cmd(socat_cmd, shell=True, host=cfg.remote)

