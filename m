Return-Path: <linux-kselftest+bounces-7179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EDE8985F7
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 13:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9B328AE27
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 11:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA694823B0;
	Thu,  4 Apr 2024 11:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZkRY57Q6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1ED7F7E9;
	Thu,  4 Apr 2024 11:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712229763; cv=fail; b=BOQOfbbKOSTK2Myc3cLr0Dwqy+W0Qj8Vw9IMrNAsfHUhZVkkGqCg5/2Ia+fgiNLtBUQKA9eYV+1F8jE63NBAu5ChonEiGCR+5aKs/QksqYKppq2CMqAAOCEetDohbd/kH0kL4+XnEhaiOZA0MTQKr32IrpZhGSslFE9Rq2UT6vY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712229763; c=relaxed/simple;
	bh=y+zxUaUSxYox4Jee7hrY/vnIgYl83DmedttSXaogbY0=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=PMClB5ip8dY5Bz8jGsfhtf+A8hZFMI5NXHSSlhVWpXHRvEaLIgIeBgQINCTdxramPLfzqAxuzUNYhKKnHnGk1Fas+ouDUN3ZRwLMP9GwN1FB8v3ddPdREGVo41RLLzU+vWLGmZoiaK2iDD9E2rpH8Kt+8oLeX+/+AnstwziVdUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZkRY57Q6; arc=fail smtp.client-ip=40.107.100.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVw5vRQFVrMgqqfuqCyC+4kEczLokpR+gqUmHn6zRqr6EZESC3T3i1mfCPOK1zYSHsFPpOfE5QeJi5sRimX/zD8QZND1GYCK2i7hGavw3DH7IDgBPwKkgDj5H0S7LNA3uySL62MGJ02vuECQ62+StLRmpGubYJVx31XpMeST6zswfxfHNE9XNtGbxW7IYRl3op2W76TecXwN3cUaUtqIkee+/AJCmMiXp7jIcjCweacd1Fc7AFzeoTS95d2yEDDdqtRCH/QlOsLG38pY+vs92qC//9/hctn7im/w2erY74faf6z+7BRJhOhk4pggCMkjJL+Z1n13EJhyk4kj0BqXcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CK//OBcYEd+RI+yU1wl4DulCRuMYqnj8TvDQs8UpaLY=;
 b=M/MefSy7XUXWFg7w4hgymABNUaHzLdl5OD3RBhdqKRKxJMks7PbFaOmDdORGGhW3gb+xEzdUl5/lI3X3zRpXkEpdIvKW+epZUM02E45hdsO7uNUqGgRbum/UZWVq1VjwDa5L7erdObKwv0MTPIZm5kFNdIpkEoy0yScHemx7gcVRf+2/1/fRB+gKhK88rapyEuxiDK7SxXpHuWNlIlBO/ZtfIppp4T8t9a6qaBCSkzVj2AM6w4BXZG94EfoeUxHT2LIzIx2cLHHhEIDJoAaovfNXBGfwOUjF6iajQvC16m6DYHP/hpN/PadKwCbDyoUYTfN7JIZYnLmCRcNdCedUoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CK//OBcYEd+RI+yU1wl4DulCRuMYqnj8TvDQs8UpaLY=;
 b=ZkRY57Q6U1XNTpg1CPFpSi7Wx/91PDysJ2kLPkQCrrxJpmpAINxoDN6jeE3o0hJKb71RZmtTvjNoW995O0uvBdJhGz53PuTcjCBeu7XwrEe8hjGUuM1RiaG1NyyJ0bF26dowg5eo9HtdXM9lmblfaEoq4tc1tqM+pmU8Aq9SqmOpG4mMvG1L7oDdql/PxKbCScV7rVf/OH/tTAqmgHbOGfOZllpfxCL5a9XAa9G23SaK69MxWyzShePWiRcYesg6zFAMZ22UjwYWB0cxJzkdZWcycY5sbDTU52cZX+xNmk0nC0DvXU8Jd9FKew1i4XPQDe3ZF6VSHrP6rg3yBp6Ylw==
Received: from SA9PR13CA0060.namprd13.prod.outlook.com (2603:10b6:806:22::35)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 11:22:36 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:22:cafe::bc) by SA9PR13CA0060.outlook.office365.com
 (2603:10b6:806:22::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Thu, 4 Apr 2024 11:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 11:22:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Apr 2024
 04:22:27 -0700
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 4 Apr
 2024 04:22:23 -0700
References: <20240403023426.1762996-1-kuba@kernel.org>
 <20240403023426.1762996-6-kuba@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <sdf@google.com>,
	<donald.hunter@gmail.com>, <linux-kselftest@vger.kernel.org>,
	<petrm@nvidia.com>
Subject: Re: [PATCH net-next v2 5/7] netdevsim: report stats by default,
 like a real device
Date: Thu, 4 Apr 2024 12:40:04 +0200
In-Reply-To: <20240403023426.1762996-6-kuba@kernel.org>
Message-ID: <874jchgyok.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|MN2PR12MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: c1576a9a-65da-4a8d-8ec8-08dc549987dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AkYspb9No3Ft+teKytLBG4jKQTHYrBDIs6/X6rMS9X8sr5QE7yFWa8B6kGqEtGAWVURcdN7bIlS+ZDY8cd53CO0qflOXMejfHNIvw8MbkZYBCEe7NLDZlVW+G09DmPr1LMBHPBx6ViGdHHRl8m6u5JfaK7Bia8jW2S+TTTtIER1w7pPjBzxnihTYE2reIGPPT5kIXAVsRRAFLA4Qsn3svl+4Fk0d8sWZzXTS39X9mj7jDgYe7YtYY55VCGwLH7I82v4SP+RDLd+J5hxHLueL5u3bsp6Zj6/u6m92YjHDKD0TN5+mO8uzTvpaMFYd5r92rDc3hqPpNLFyb8nOgB6o+rkn9a5I3Nun7urNRwOmXPICZEfUmZJbKSFKB4ue89Wz21sAPXRJT1m80MSdHDb3FUR5IE0NhlIgWpgWA6wn0suPgv8ukk+xEUHeg1Q7nWvDlW13N1pPp0qqitKVxgS0volKQFsl/qhBFp9VYPJOGpKIubivSlC/JcsPdP2XnFyu+zMY7UwYYu60mIKvOtvY993JvTA6UyRDRAaq34pXbz7UF/WAKqGzZOXknTnar7IakdhKzR1PIhM++rCPSC04Fs6THHx5byX/6cyliwWBBYt7bBlv9ZBJMEBmnE6+4WPn93CYXG6pF91sc6KEEoDlsbBKwFUg7BSdjeArrGBoxz+WGYRs1BwUKuX3kkaJzQ2tbzvfvSfmPmEbMchVxfPZec+cML6ZLRsUd0t/HCEcb6KzKhRF6SXz0kS45vV6nLV8
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 11:22:36.4313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1576a9a-65da-4a8d-8ec8-08dc549987dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422


Jakub Kicinski <kuba@kernel.org> writes:

> Real devices should implement qstats. Devices which support
> pause or FEC configuration should also report the relevant stats.
>
> nsim was missing FEC stats completely, some of the qstats
> and pause stats required toggling a debugfs knob.
>
> Note that the tests which used pause always initialize the setting
> so they shouldn't be affected by the different starting value.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Petr Machata <petrm@nvidia.com>

Just:

> @@ -330,6 +331,49 @@ static const struct net_device_ops nsim_vf_netdev_ops = {
>  	.ndo_set_features	= nsim_set_features,
>  };
>  
> +/* We don't have true par-queue stats, yet, so do some random fakery here. */

per

> +static void nsim_get_queue_stats_rx(struct net_device *dev, int idx,
> +				    struct netdev_queue_stats_rx *stats)
> +{
> +	struct rtnl_link_stats64 rtstats = {};
> +
> +	nsim_get_stats64(dev, &rtstats);
> +
> +	stats->packets = rtstats.rx_packets - !!rtstats.rx_packets;

This is just to make sure that per-queue stats are lower than the
overall rtstats I presume?

> +	stats->bytes = rtstats.rx_bytes;
> +}
> +
> +static void nsim_get_queue_stats_tx(struct net_device *dev, int idx,
> +				    struct netdev_queue_stats_tx *stats)
> +{
> +	struct rtnl_link_stats64 rtstats = {};
> +
> +	nsim_get_stats64(dev, &rtstats);
> +
> +	stats->packets = rtstats.tx_packets - !!rtstats.tx_packets;
> +	stats->bytes = rtstats.tx_bytes;
> +}

