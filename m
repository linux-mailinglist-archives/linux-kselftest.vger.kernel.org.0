Return-Path: <linux-kselftest+bounces-15358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A8995268A
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 02:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69DC8282A69
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 00:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E9118D630;
	Thu, 15 Aug 2024 00:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NjoGRNqx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2708BEE;
	Thu, 15 Aug 2024 00:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723680576; cv=fail; b=mLNnPsMFxTi/O2J6sF+AK1ISX+uu14fRKcAOjLSJ7AXyU+aKJ4RHfKuO+mdxJxX0OaWoP11USICFptFwq/188H60GyQ18ZQf7aZqewadmx8tArr7wwR4lfDzfYClDI4msqEJ86mmf9qAoGC1PmYy7DrHcZ/NF3oTOwdejv8pJEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723680576; c=relaxed/simple;
	bh=7Zsh2xze+PBiVnfngp6e2xCuNcT+TlnxJ7uJHX3tI0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rq4qVIsIzV7/Cc7qfZd1LAu9K6CYal/77Ti/gYG/l2/8IomKFehQG/BGFnV6MK6HvaZ/ZA6jsdn3AMNZowHXBXFeWGh7+X5WFb6OMI7inRQpx/pAYu/e+lm2IUVpk9JgfVf31A3NrGlvAbW64OjuJz/hge1GD2VGL+HOy32tMA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NjoGRNqx; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHh67d2HQ3qHaAC3zfgLkj0Xjp/IHP96Dhv1p3XTbm+ePt2uC7VWAfWqUWerDuXfzTNCXk3/VxX3GVZ8uIliIelaLllNfP5F1WmvpJQAcYqKGS6eIuMrmAxSJnbSEE60PR8KLgrJdKMymVckJKdXI44dkQE5h14s3U8Vk+Zldu/GcMSmobEtVCpgXTpmUaQgcAML9gIVr6YuXCfKVH0PoxCb2kN6JISJ7s22Bib+Dnf2nY1l+m5IaKMcgBbkC2dQzgMpFArHbfLLN1iZVevvkDsDK+OJbo72TPnyAGFQp5qdCODWHHjyjjUyQ3H6EOFmviMbWY0zTMEWc2LuPYfu1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/T9HoCwDQUtLtIclI7JKLweByU386jJHwAnfPaEDP1I=;
 b=X6qxX1rwT4fzHSjK3/Zmcyxy8TtluhpLWytBdDXxtFYomE5xGJNVWGlU1dPD6ElVkqg+dcuBsWKFhV65d6sFWv4MRJDaReIqgF1siNNUrf5cI8I0YhPf5Y9LwbUKs95p1/oK3dzqql3OshEFcTQ/rEzAhmhu7wh/E+YsFS30ymkvAO3KGtk86sJG4zSGolfOuxYia6ECBYzx5DvA+SAeqAagHvbQK0253FxV6kUCgBd0JzC62UKEbSHMqi0Eyy6vh0jHT8AR45sklTVzrtskbde5AHuJdu/f7Gdiu4qRolKfpK9FosD92uBGTHrU6wzOCr7klp9oGOjDBm/UlLlS2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/T9HoCwDQUtLtIclI7JKLweByU386jJHwAnfPaEDP1I=;
 b=NjoGRNqxyUxjg1wOzkIl1/YLKhaD+BI15k2WHP4JQ5lwYgA7R5ZOy4nlSOTNPsMXOtJtyV3lbQ65NUYydDhx3yTgOJo249Nj6oZeopz3qwzqJy/hlM1qr/mv01OmqioKjt1ZeCQqDlSibYiVWp2jaAEgu0cVs7/Wf7B6CeldNvH1h6NSBWMUOtnU323OeHdpWqecZ29gtVMGjEKdr0Bfl0lK5bymiOzB+Y+Rnkcm3cpDZR8YYZvwdfWbjcM8L1WMQtGX8dVWKQ0R86irgMmT7dUXVvzPPz1T/U8jwbviqUdINydFfrGuItrUvg41xg+1rkbB5AcmznaE/RW/dGYFDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10285.eurprd04.prod.outlook.com (2603:10a6:800:21e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 00:09:30 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 00:09:29 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Antoine Tenart <atenart@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Hongbo Wang <hongbo.wang@nxp.com>,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Colin Foster <colin.foster@in-advantage.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 03/14] selftests: net: local_termination: parameterize test name
Date: Thu, 15 Aug 2024 03:06:56 +0300
Message-Id: <20240815000707.2006121-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815000707.2006121-1-vladimir.oltean@nxp.com>
References: <20240815000707.2006121-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR06CA0143.eurprd06.prod.outlook.com
 (2603:10a6:7:16::30) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB10285:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e37a3d-8cc4-48d6-7f4f-08dcbcbe885e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1qFdxZzwS6/Y+r68ybq0GG3Vu9uv3R6/8voZhqVvujVINeuxOuyPxzndmeeQ?=
 =?us-ascii?Q?QRpwR3icpi+CYx5xZrw0BWhXcHW5YmxTVgwFnmERhxud0+HpV5HQmZQ8iKNR?=
 =?us-ascii?Q?E7K7blvm+mHvU+PwmDcZ7ScxuOroxtM4wDtwPGmHtrB+OzvSoO/pYjbnxvpM?=
 =?us-ascii?Q?wCGwpQUBYqJedX+3aa/64zF+NVgnFzIVXMVHpML1XE4XmeOFXqowz1klwbx0?=
 =?us-ascii?Q?fO9vY5PR+RyiUOKfw2JHwn5D4Q83VN04Lp+RpgZ4LmSHtX0A+x2je/UJFNcp?=
 =?us-ascii?Q?t34YAY/xZNxT/0gHAYVT+S208W36r33N1HwXxXFIpSxjlt6MTScqxD/8FGLZ?=
 =?us-ascii?Q?rVfjT42cuvHFaIIKLfpotb8BGDA6Rpw2Cj8VKs/tM2GKcwO/cJ+PONLk4YR4?=
 =?us-ascii?Q?ew4db5tlcKVN10ifbU//sUP+FYRwG4N99aatWIp6Up0wcl1KMPriIGudX3VP?=
 =?us-ascii?Q?BfN1aHIPB+/pO0gghNz8qyGSmqkExcMvsjGp1Jh3WIOj6r7SRchDd/wGu0JB?=
 =?us-ascii?Q?rb+JbiDuNJe+HPIJI7yEb2CZpfG5PEZdKZG2sd7JJ4B63fIQZR5PlHpPb3Q/?=
 =?us-ascii?Q?+g3l+qowxdX7vmG8L83DBQlOpJK1rFwGfUxJ+jt7mlhvfVIN5BtY5ZYpEVmW?=
 =?us-ascii?Q?0I5ATFedBMRqpICDHh3PcZi9e7J/MtVl+qrR9VxeqOgA6juvS+OT4G7NsdCt?=
 =?us-ascii?Q?BwPHp0IRFRiO1EWHtBR1fYCm1ZrR86w+aMP43nQa2nqVTHZCvaH+Uonecxb2?=
 =?us-ascii?Q?GyYo/432saP+ab2IiKyG0H2w347TU3HKt9Q1DBNJgrAjP4ssEaEBEu5z8nJT?=
 =?us-ascii?Q?YR97P3hbRhDbMuMFOTmMOd9K3BXJ5uGuS0VhAO2Zz8r/GnclfXPLXiAfTmaB?=
 =?us-ascii?Q?wrccp2a1oM6vhCmHSXtYFIv+nl1eM7CO2Mlt5N+TJSYc21jLn4rUCb90h7ri?=
 =?us-ascii?Q?V1oVj+bBtdcUvajX8fYFc9sJ7VlZjgMAE5gIdhreDd3kw379k/n9ksrDB0MM?=
 =?us-ascii?Q?SPlE6FnCoz83nKCMAdNn7CuP3S8q5311e4bHrU3zGFrjGj5WUK0unkiQRETZ?=
 =?us-ascii?Q?kJjWyEFJ5Je31lF75M4OxTBP+mel6wPr3W83tWQBmRe8UGJ2At2lV29IwsW6?=
 =?us-ascii?Q?D1RIZ7GEtsGG5owjyO2E3TlF4Hlvw8HNNIueR7sUGSXwjLrSvXWoc56SzVAm?=
 =?us-ascii?Q?bExheLfsiaDUPw+ZU3fY01bgabaX8Y/grMCGPIgJHRGTlLaCXcA6HGgAjvmQ?=
 =?us-ascii?Q?RzCQynJsO0BMpb+D74vTeV79zR+h6JOlxDhloJXXAxPXOq2LhiQsGDdfrlcN?=
 =?us-ascii?Q?oqJC3nIRrkWLOK+l6GlGwlf/2ii4va9UkbKv5UGXNAiwGa/NMuyKpjk28kn2?=
 =?us-ascii?Q?Y285WtiA7PIZgQQlBXvYpRwFvBsWVBaIMjmHu2TWZAHjahHKAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OpY5CMSJoGO+20rtkfk6WjcSYCzAeXvRurVvOHwRLu92nD76OlX9xlnRn/kJ?=
 =?us-ascii?Q?VDzZu4A8rwNwu7wUyd8bzuEeyUyeXHq2VCL9Wl8M1Zo1sI3dWf8jkCOdu4YJ?=
 =?us-ascii?Q?AlGEkb+DjCyK0DwF7m/H0X5YlmO05tndY/Bs1j+H1hH5FULPCjlxWmqHMD0q?=
 =?us-ascii?Q?5M/asKdXd16VpztryamuoSkshrCi+JaCpVw2yZsIr9BpPVJx//nxSVqoCtrA?=
 =?us-ascii?Q?5QSbMDKOpMILc2FOgZUFFrCj4Q4SOsd12scXVay4/HrBKhteKPsSbkeyBLeb?=
 =?us-ascii?Q?eegcOD/1i6ivw8JTOFDSzkbHfAGZxlkBTtFKr+bTS36pM/pHg2O8DjH0t4xj?=
 =?us-ascii?Q?inTk8Jvdi3tKuR9QbbLgsYSoWjQpAfnwMYvPORtPuL5C/F3SE5JrH8uuEY/o?=
 =?us-ascii?Q?wlV5o8NEaBw3gYoecV22JPLtaTmjmzTFhWeNx0vFZAVccx+F+tZ3WXcfpQKE?=
 =?us-ascii?Q?GnGsbVhou3EHiTUN0jsrJOZhmSrULqLnr2P8S85oQJ/Nh+qJjqCGh6ryTAbu?=
 =?us-ascii?Q?g47Kp2kEOMN1l10U4PrkBwyKNTXGiYA7LhMQXxT7mT3v0bhWS0FZnU0FNuXS?=
 =?us-ascii?Q?SyM0NpCWtgJHC2Xg9vs0iMLBAZwcrBxKxdM0gy1DPNdY88As5IZ1rW+ERTAp?=
 =?us-ascii?Q?3PHUODd0egi98CZvvzSd4Tj2Lv27GSAfE9dVcNv7pXlZvqXN7YsEMUy+Jyp2?=
 =?us-ascii?Q?eBCVgqJE+kNfhC1ekLdcAVXOU4axCcNsxubwdNb242TQpJiJLNcmZOxPhq6d?=
 =?us-ascii?Q?v8t/8eziJQ3Jb6ZfzB3yElhfZcboNyYJa4WVRpNg0Gs8/PAXGqQP79igjoLb?=
 =?us-ascii?Q?iLO5gT7XYS6ZNP0mbgpunhnn32lvNqHuSHZbBjgq7yYCLZz4zMf8d4Yr1n/8?=
 =?us-ascii?Q?yPMijK7NN+NBGTSzrzA8kFqKZCnwYdx6TiZBQ2U2w48zZPWcRzK8z+gAwC54?=
 =?us-ascii?Q?pJjHUVfcyTajx8h3toiHU/6q96HB4GaCcfaDrQhLDsIMN/kGA9mnVn5V2BQj?=
 =?us-ascii?Q?E62Njm7wCuBMgtEZPj5WkIai+Da8RE31Jr+bOn0fNGqsiMNq0t6EovRw4Hmr?=
 =?us-ascii?Q?wBgcxj8i2RI7LBcqAykZ4kB41EUT7PX60GhQIqRxBKEaGG2Gic8912LcMiL2?=
 =?us-ascii?Q?BWBpZcEIAbRVoGHlnpEsFsEu8EzeXdEOOh/AToCHg9QKmO0Tj1W0L6CuN5JY?=
 =?us-ascii?Q?zzsbCPBQzQxjsnt+LSqErHl2xkZRuY2zLBnGMuGJM97yOrJlAe+YBFggKzy0?=
 =?us-ascii?Q?5jy+ZHc2oDhziooJpRUEvkz1G7Qg7VtfR+iITEK3X5AnDoY/Mesq9EBgqEoR?=
 =?us-ascii?Q?mcjGR7gyvFQOc29MusqnDarzXPHgUZIJvSAgvMflwgCaDs4U4vCP/20Tx7x5?=
 =?us-ascii?Q?rq5ARXDTBtax6k7hzw9KBezo0EF+Ehqz+G3sV6swJuggPEriDviewrflSpCh?=
 =?us-ascii?Q?DeZ1PrArT4f4asgE0oYiWJVjubaftQtPPtNKNvIMuEoJpsBo2yySS1RfWMZS?=
 =?us-ascii?Q?0u3GMS3JjIg7GhG2lvaYUFtNmDBUFugb4wQ7ilrB3F4PD4JHIRp1z/yHRnkQ?=
 =?us-ascii?Q?T7ENNRaab2etcLNhBi/xw0M4zFNOB/iU5EZ2PVHp+YnJcrpWxpk7ixYX1PNR?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e37a3d-8cc4-48d6-7f4f-08dcbcbe885e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:09:29.9052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SU7nn/w2BVYxrCtGYz48QFcTESlfRZJAqvld90szbuDwIQTBCADQhVxQr4yEusKkntYunnUCPfHZ/QbGg92Ggw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10285

There are upcoming tests which verify the RX filtering of a bridge
(or bridge port), but under differing vlan_filtering conditions.
Since we currently print $h2 (the DUT) in the log_test() output, it
becomes necessary to make a further distinction between tests, to not
give the user the impression that the exact same thing is run twice.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../net/forwarding/local_termination.sh       | 38 ++++++++++---------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/local_termination.sh b/tools/testing/selftests/net/forwarding/local_termination.sh
index 92f0e242d119..af284edaf401 100755
--- a/tools/testing/selftests/net/forwarding/local_termination.sh
+++ b/tools/testing/selftests/net/forwarding/local_termination.sh
@@ -68,10 +68,11 @@ send_uc_ipv4()
 
 check_rcv()
 {
-	local if_name=$1
-	local type=$2
-	local pattern=$3
-	local should_receive=$4
+	local if_name=$1; shift
+	local type=$1; shift
+	local pattern=$1; shift
+	local should_receive=$1; shift
+	local test_name="$1"; shift
 	local should_fail=
 
 	[ $should_receive = true ] && should_fail=0 || should_fail=1
@@ -81,7 +82,7 @@ check_rcv()
 
 	check_err_fail "$should_fail" "$?" "reception"
 
-	log_test "$if_name: $type"
+	log_test "$test_name: $type"
 }
 
 mc_route_prepare()
@@ -106,6 +107,7 @@ run_test()
 {
 	local send_if_name=$1; shift
 	local rcv_if_name=$1; shift
+	local test_name="$1"; shift
 	local smac=$(mac_get $send_if_name)
 	local rcv_dmac=$(mac_get $rcv_if_name)
 
@@ -150,61 +152,61 @@ run_test()
 
 	check_rcv $rcv_if_name "Unicast IPv4 to primary MAC address" \
 		"$smac > $rcv_dmac, ethertype IPv4 (0x0800)" \
-		true
+		true "$test_name"
 
 	check_rcv $rcv_if_name "Unicast IPv4 to macvlan MAC address" \
 		"$smac > $MACVLAN_ADDR, ethertype IPv4 (0x0800)" \
-		true
+		true "$test_name"
 
 	xfail_on_veth $h1 \
 		check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address" \
 			"$smac > $UNKNOWN_UC_ADDR1, ethertype IPv4 (0x0800)" \
-			false
+			false "$test_name"
 
 	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address, promisc" \
 		"$smac > $UNKNOWN_UC_ADDR2, ethertype IPv4 (0x0800)" \
-		true
+		true "$test_name"
 
 	xfail_on_veth $h1 \
 		check_rcv $rcv_if_name \
 			"Unicast IPv4 to unknown MAC address, allmulti" \
 			"$smac > $UNKNOWN_UC_ADDR3, ethertype IPv4 (0x0800)" \
-			false
+			false "$test_name"
 
 	check_rcv $rcv_if_name "Multicast IPv4 to joined group" \
 		"$smac > $JOINED_MACV4_MC_ADDR, ethertype IPv4 (0x0800)" \
-		true
+		true "$test_name"
 
 	xfail_on_veth $h1 \
 		check_rcv $rcv_if_name \
 			"Multicast IPv4 to unknown group" \
 			"$smac > $UNKNOWN_MACV4_MC_ADDR1, ethertype IPv4 (0x0800)" \
-			false
+			false "$test_name"
 
 	check_rcv $rcv_if_name "Multicast IPv4 to unknown group, promisc" \
 		"$smac > $UNKNOWN_MACV4_MC_ADDR2, ethertype IPv4 (0x0800)" \
-		true
+		true "$test_name"
 
 	check_rcv $rcv_if_name "Multicast IPv4 to unknown group, allmulti" \
 		"$smac > $UNKNOWN_MACV4_MC_ADDR3, ethertype IPv4 (0x0800)" \
-		true
+		true "$test_name"
 
 	check_rcv $rcv_if_name "Multicast IPv6 to joined group" \
 		"$smac > $JOINED_MACV6_MC_ADDR, ethertype IPv6 (0x86dd)" \
-		true
+		true "$test_name"
 
 	xfail_on_veth $h1 \
 		check_rcv $rcv_if_name "Multicast IPv6 to unknown group" \
 			"$smac > $UNKNOWN_MACV6_MC_ADDR1, ethertype IPv6 (0x86dd)" \
-			false
+			false "$test_name"
 
 	check_rcv $rcv_if_name "Multicast IPv6 to unknown group, promisc" \
 		"$smac > $UNKNOWN_MACV6_MC_ADDR2, ethertype IPv6 (0x86dd)" \
-		true
+		true "$test_name"
 
 	check_rcv $rcv_if_name "Multicast IPv6 to unknown group, allmulti" \
 		"$smac > $UNKNOWN_MACV6_MC_ADDR3, ethertype IPv6 (0x86dd)" \
-		true
+		true "$test_name"
 
 	tcpdump_cleanup $rcv_if_name
 }
-- 
2.34.1


