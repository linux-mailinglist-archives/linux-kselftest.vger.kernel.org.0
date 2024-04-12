Return-Path: <linux-kselftest+bounces-7839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0D18A3468
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 19:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0B31C231DF
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 17:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D3F14E2FD;
	Fri, 12 Apr 2024 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fiJYN71m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544C114D2B8;
	Fri, 12 Apr 2024 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941591; cv=fail; b=VsxQINUFABMpCuRwv6CVqqjlQKUkS3uXDpaOf3fDmUN66EHEqf+6WS8Ly9yHvXwcVGzZaBYdiYlnLsoLrEXszoj8Rx+zg38QOfeuvjE6cNZ2vGSR4vrKBJAWcuaRQ99o2kDI5xixcmAZK6AnN7ypuBo2CTKxA4gaeX2Ev7ZB1Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941591; c=relaxed/simple;
	bh=Og6QjflOjmOeoJbUzIPNu1OEQuH2Itk/muhQU/LMNPY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kr1EZOPMTWTGTSj/YeAkszEsx9SaZ8BmYKsxNR26+QRGm3PLvKuy7KQn7aG50oYvVniu1zk00UtFkMqOkJg5XDmJBN42HsEtXhGBH9NNGwvRl5NfnWGs61bgdTaOjogiX5nSZl7rU/p0RNhq5F/OwioXK7MA/XN18jH1w4Gef+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fiJYN71m; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8qIGgU8GU26Z24nc2ym1+azNbH6PDKHDQ4zYaiElxmJPzkaT72DztE21Y4SDVvmpNC9+7ksxcqmZqq8PMPlisG/YbhipGP9G6s+bl7ssaY/xXlIelXS6TbnvmM4hKYjU9mz1A8CAbPHmeyZAsh1eaOXOd4Uss9asIdiYMR3mNAQTApWsX6C/FTst5ojNh0xhRznHdbkVYhDiOxGsTwMn3365Dh3znxLFMi+ika4D/NdQnBpDBxnR1f/iCFXWwbuPTodREikfeKECzpyvh7sUmGXNULZtlHD7bb5kW7+UkiY1Vpz8Bhydhl1WXbMw5kE4zuo9b7SW+KdLO8RHO2NaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XA3AfIu2I2c3AWt7gR+Do+pAAFoeTS109baHHny/clo=;
 b=DxknAZ7Ac6VMB1BG0DMfEm0dyxGv9OTbaA1eS4fGyI1RGRnM8jnLnm1m4Jm5bwDCO72c0He9BCH1/GjF4sr4JfYR18hqGybT+LLEtmoE+JgaB58T4WaBtc43YMURqvr4MlpY2G0iYIBuzpz3aFeTgYltQ5FQIK6zJi/BmE6sLHNm9LaB02HLDqoxu+KGukMT+Kb9kd5lpHtqUKLaIqRFvtRzO0Pr19BpsNYsmbkG3Hhot4THw7AmYbGHOjoOPzNHJQbVfOjt4kGMOyHDb9+onsFFhAwt+hcZzVFTZBHHmR5uaZB4H9Fn82JqfzzzEoAOrXzNymwPYW9ZfeGo18g+3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XA3AfIu2I2c3AWt7gR+Do+pAAFoeTS109baHHny/clo=;
 b=fiJYN71mLVpZpAjxhNkYSA90XyWy7WvlQrC/9eBSeSiZe7zWvcy2KR7NU3m+0T1/D+p4HXEtUT9+6D2N89lyC8e/hpsAKX4Lq0e2V7JZq+6LQsj22+usmokHaWJ25ZKfiNJR1mcPwqBClbncF7G1Ud4zryFXi5ESsA+bSzK6KYHhmpgxFsBueKqO7+0b1S1KVxh7m8p2NfNjeG/h0NpKIsGH+AejkqzDU+8376jxAmAk71AZb0lN1Bb9U9oBYFWRG3RINxqhXsHIgmh0YVDsTg1Fr5WWB8wjfd2q1flMhRQPsmBkB7nggW65EKMhYAJHOgQHmZas6yeAl+rT+oB2WQ==
Received: from MW4PR03CA0186.namprd03.prod.outlook.com (2603:10b6:303:b8::11)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Fri, 12 Apr
 2024 17:06:26 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:b8:cafe::87) by MW4PR03CA0186.outlook.office365.com
 (2603:10b6:303:b8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 17:06:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7495.0 via Frontend Transport; Fri, 12 Apr 2024 17:06:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 10:05:57 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 12 Apr
 2024 10:05:52 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 05/10] selftests: drivers: hw: ethtool.sh: Adjust output
Date: Fri, 12 Apr 2024 19:03:08 +0200
Message-ID: <808d917f83511c89165dd614f0d6a1174c92deb9.1712940759.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712940759.git.petrm@nvidia.com>
References: <cover.1712940759.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|DS7PR12MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: 57ab682e-2096-4e8f-f0ee-08dc5b12e32f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wJNGnuRhX3wGwO3WtUagGgPN5acx2nNeg3wioDEUD9C4SyYWnko7umaJw+ZiI3nt3G0t4JPk5wRKRGj3eRsMnXh2kqKEMNellCXF677TBRTwMd3r4gW/tAI7HnibD5dmvLRj0AmVCOd2iupqm7DQsFkbNony/yUTL0TOMG1wnM59LgWdRlVx9UPToGfa5mYItIT6WOvFv9oI0ec3a4yZa1lQoYYMiauvpgiyUHv/hpqSrdq78OQM1SGq9FYJGYgLWbyB7nlA960ITTf275bhEH5tsfPx1/u7r0TP+QU+AE/tBt9IMFD5pev9DFhH8W4Jcj5RoMKT/YEhUsGCsiUJNB6w6r04ylCiLrO6PFzcWK2H7eBHjUS+fWGCHokbb+W6vWRR4FyLI9uGcYYaJ/8D9Vzh75jZFIc4PRemQyV43lR231mr3+OuURpGBwFTIhx/x6vRLYs+Q8trj925+wbRnL1TF6NZbo/ZmTl/hNDb6HtQHT8ua9WSjPfnaXbQYW9oJJxKQ8c7n/7yo9E2Goe+xP2va5cDDTHz1Ki8HdokQVBHxGqdKVq5S711GY5f43sn98OoAgABzUzO8IrCQOMjO8/WUHBqQaKsfkKOnx25+t5Hh3RQ774iXB8M0TbGjFmACrW1eWvt7oD8iOfWZ3z8//u/7kt9WD4IWIuiTPJuX1GfJdp1XZfYAfs+p29hdf37qH11cJbyVZefWDIyZVKe6jec82+MHQZbfaq5SocTY1q207tfXvotCoFlPJXtOXjx
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 17:06:25.7314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ab682e-2096-4e8f-f0ee-08dc5b12e32f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743

Some log_test calls are done in a loop, and lead to the same log output.
This might prove tricky to deduplicate for automated tools. Instead, roll
the unique information from log_info to log_test, and drop the log_info.
This also leads to more compact and clearer output.

This change prompts rewording the messages so that they are not excessively
long.

Some check_err messages do not indicate what the issue actually is, so
reword them to say it's a "ping with", like is the case in some other
instances in this test.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/drivers/net/hw/ethtool.sh | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ethtool.sh b/tools/testing/selftests/drivers/net/hw/ethtool.sh
index bb12d5d70949..fa6953de6b6d 100755
--- a/tools/testing/selftests/drivers/net/hw/ethtool.sh
+++ b/tools/testing/selftests/drivers/net/hw/ethtool.sh
@@ -65,9 +65,8 @@ same_speeds_autoneg_off()
 		setup_wait_dev_with_timeout $h1
 		setup_wait_dev_with_timeout $h2
 		ping_do $h1 192.0.2.2
-		check_err $? "speed $speed autoneg off"
-		log_test "force of same speed autoneg off"
-		log_info "speed = $speed"
+		check_err $? "ping with speed $speed autoneg off"
+		log_test "force speed $speed on both ends"
 	done
 
 	ethtool -s $h2 autoneg on
@@ -112,9 +111,8 @@ combination_of_neg_on_and_off()
 		setup_wait_dev_with_timeout $h1
 		setup_wait_dev_with_timeout $h2
 		ping_do $h1 192.0.2.2
-		check_err $? "h1-speed=$speed autoneg off, h2 autoneg on"
-		log_test "one side with autoneg off and another with autoneg on"
-		log_info "force speed = $speed"
+		check_err $? "ping with h1-speed=$speed autoneg off, h2 autoneg on"
+		log_test "force speed $speed vs. autoneg"
 	done
 
 	ethtool -s $h1 autoneg on
@@ -207,10 +205,9 @@ advertise_subset_of_speeds()
 		setup_wait_dev_with_timeout $h1
 		setup_wait_dev_with_timeout $h2
 		ping_do $h1 192.0.2.2
-		check_err $? "h1=$speed_1_to_advertise, h2=$speed_2_to_advertise ($speed_value)"
+		check_err $? "ping with h1=$speed_1_to_advertise, h2=$speed_2_to_advertise ($speed_value)"
 
-		log_test "advertise subset of speeds"
-		log_info "h1=$speed_1_to_advertise, h2=$speed_2_to_advertise"
+		log_test "advertise $speed_1_to_advertise vs. $speed_2_to_advertise"
 	done
 
 	ethtool -s $h2 autoneg on
-- 
2.43.0


