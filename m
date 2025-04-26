Return-Path: <linux-kselftest+bounces-31708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A458BA9DB8E
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 16:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C0C37B650F
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 14:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F4025DB15;
	Sat, 26 Apr 2025 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g1H1ALOv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F9B25D919;
	Sat, 26 Apr 2025 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745678970; cv=fail; b=a0bVUalXQ7e/1ahkBKbJdIkjMrqZuuAi41Lrs2o9KL2wc3OUaR5RAhKqBfDohArc5lFz5RKTzF4hRzFLup59xg1kfklRDfe4MEjusSM5ERsUhZ+HtPBYSCmDF7tpfhDVe9HyF7GlW3f/S4fD16csHr5gbxmybp/Tq1VmiEUqS84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745678970; c=relaxed/simple;
	bh=+e6AuJjrx3ZDLr97n5WDNrPLiH+XRMV23zALVxL4quQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JcOZituF2W5/E9U6m5JUW1KE0K/4AC2i/oZJvV8W+ILZjRDQi/8CJsVWfvp2wNObdFyMx4s+AJYkVgOgKGr6Le+WEllYpNW6Orl+pRXh7255fKl4zCi653e8zktKaPIioRfVk/2BSzmV9heZlQi0FhBK+1hQ5l37u5Xk+4WGKfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g1H1ALOv; arc=fail smtp.client-ip=52.101.69.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSWGJEgpDPzHeovExWOJVObuenb9fZR/MYirMJeDX8sJRKNiEie8RXq7IMQbntWfN+bX/NVKTqrMIXj4qXDW6ASx8JGJGnobAHkEZSc5go1ghI14rZki2VEXFs+NtoDR1lRXCBTqkn55ajfxoTJoYb0ZPx6MYpoZZY4ha21jQNkAUD1vBFZFCE0iHfw+sejwfG+cp5yqJr+74KB7OccWYbQFDGy/6QevxcRNqjpLD+NMtsLsYl2tEfxTB0FHf1eweAfiepqaxETN8ZKqOUatd5ih+NQXBsgXWvtoqotzjEtInX6VwQdc23Dgcv/MOwF679yo4LM95Q0H56EeQ7WwBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uj3UcCUW7uNCYJrRwVmo4Y+IWy1fEcYNqQRLQUzyQVI=;
 b=WtZ2++35kK7RHJXJMTVsPi2/h5gBy4dKyKETyK6zo5Oeyl/8ps4iOubuw+6rWSV07bARHB9vUTR2EQ2chs83Z9pl1n6jycXQ4sa2mKz/xzs4PKVUMsJHLJis0+sVVtDUG/O2S+Ie3LE+rkFWzJnBlYgowa+gJyCoT6sW8Yq8AF3Ghs9IZMUwlzbtnorO4CC0hjxbAFojz+LliKrrV/wpCcpso3qVWeFqGcV1CV5BWZNFySDR96VF6Zb2TFpnJtgLF0h013WHRBnVpArzAXmZNZ/mD8L49deOQVMUScXhqEHrb6S2kJHfjqgCA+gMyH46vGb64Rt7JZajnjqoBlQcWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uj3UcCUW7uNCYJrRwVmo4Y+IWy1fEcYNqQRLQUzyQVI=;
 b=g1H1ALOvhM6+OoaXBNIo4DudrXDS5Wjhp/r0+8a9DTlmMFv27MyijLMnibh3mpYd+PJ/q2MEMgwYP9QelGyMBS9zDSOuiSP9525grgiyMhCVhDWmB3ge8XKc7XaltzyNGj/h8ueTdBWiA87XXOhd3tg8/n3/K7pJ25FMh1eud41acm45WMTVBhzDug31NhzyGEeHejfrpW+R73hsBqBa7t4+CUPWFmKdKmJAtw7AeltdX9PVKgByVehUz7blZHQO/5jBJwGmnrSki9PHbaagj86MbrAGOUbG15Ua7zB8WT3ZgZwb7w1v1Je3NFfn5pLVsL1ZmGhrLZD5Zqqd/rUIXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU2PR04MB9019.eurprd04.prod.outlook.com (2603:10a6:10:2d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Sat, 26 Apr
 2025 14:49:16 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8678.028; Sat, 26 Apr 2025
 14:49:16 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Richie Pearn <richard.pearn@nxp.com>,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 4/4] selftests: net: tc_taprio: new test
Date: Sat, 26 Apr 2025 17:48:58 +0300
Message-ID: <20250426144859.3128352-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250426144859.3128352-1-vladimir.oltean@nxp.com>
References: <20250426144859.3128352-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0055.eurprd04.prod.outlook.com
 (2603:10a6:802:2::26) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU2PR04MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: e947cd5f-a0eb-468d-789d-08dd84d1848f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0NRmU/E2byY3ZhZM9U5wd3mvs11vt4hLGucN4NWhEAGY2AHIDzfvANq/8TPa?=
 =?us-ascii?Q?eOBZj+y70k6stECYd1vbNosrTteT96BKykK83VJLaaPMHSSr34kduSR/txTz?=
 =?us-ascii?Q?XuWFTT0VIgLJ1X+lbbApxX82T9VJ/WsgPb6FHEbJ5ZfQ8jEoq3AuYC+yEcEa?=
 =?us-ascii?Q?foCKcojc5o/EXNx82D5GUiXNKTWOImYdu57DbDuKbqHG3F21fmPh8RcUbARo?=
 =?us-ascii?Q?sKDcIjujEcpkhRkZeFRbWPCqIVelIWvvOVonQHLsnD+aP6N6sr6xR4z/2UuT?=
 =?us-ascii?Q?CumWMaqcCJVpB17JT4bD0Ww7wzWA5AU/7eVab8O+IV5ecQakdMRYQTuBtw9Y?=
 =?us-ascii?Q?z1G09HXAlY99xGteT8LRifavfwPZv8mkygwfZEFidpVmIUuTDm03rnH2XmKV?=
 =?us-ascii?Q?IXALSxRHEJf661Htfeqoz6lbt5sfMGNVJbeOlHr2v/PHnxYF+zgenpQXswDI?=
 =?us-ascii?Q?OqjsK+HYATPpFM6FQqk4kj4MzqiaFgU46K9xJMA60T9xbExjyQKLBmKYnE9W?=
 =?us-ascii?Q?D5oqNgyWduCC7E6fkdul097Vm+4xaeer7SAgCsrAVswiNpEWgYzS3N6evFsy?=
 =?us-ascii?Q?WYQHxw4oGjGgCnKLrpohpgd0mGeKfdxdN2lD+jOE3BqPrDbGkA66fHp6gAgM?=
 =?us-ascii?Q?BVujRfmdRjrAC6sQm/H+JdrIY7BDKWYAwVYSGY27MwfYrg2Mf4WkDs0yZFOr?=
 =?us-ascii?Q?6Y8VXQ9bn0XJfmCcT5Ht/HEKlWkVP6Y8kEul7k84yvLUjMfiD9QdOFqMo9zX?=
 =?us-ascii?Q?KGLzZGWPB1xMoU4D2dQF5q8dZz2fqnhJ9i3+mA1iGAiHdMW2B3Digwopq+25?=
 =?us-ascii?Q?8g1v704vdojKQ/70jbL9qYljpQj9peBrqxet3/uW4kd9NYlIOAH1pZ9IDnln?=
 =?us-ascii?Q?W/1nX793tcmbFVMoam0W/wTTDsbHBIESazdIhqwVC/Hvbwo0Dr1Hcf4oCMnn?=
 =?us-ascii?Q?pDb04W4kWcDx5cZIMBH/odc4jAfTieorrIzd7XQJE2I1M2ndxMIoEeVt9UYm?=
 =?us-ascii?Q?Kdf2eYKKAogjIpFAXkVBS9v9+Z8bFkji1H+lfjvysKpv+U7Q8rQBXysTFVGf?=
 =?us-ascii?Q?f5bhmEqrG2MxHBM8XAVZwD6g1Rx2y21Y88UBGApr5T1KADEs2h41UrAdWM3b?=
 =?us-ascii?Q?krojsadkt+4qqO9WGZiocDZQhLHt0neWmhlhtKWv6Ktkdn+GEAYDMql274FX?=
 =?us-ascii?Q?hSOLO2CCPPzagI8G06YsOD5YLLBiH0hqvnIMO4DeEgOLFViLDj6cnqY4MHXM?=
 =?us-ascii?Q?M14MC2zAX6Adb8XIRsCANC3RZoW5H5GtyjDWuBRE2bdk3/EzIPLjpSRnjNGX?=
 =?us-ascii?Q?7+TrdDdXf7wGHkTDHF8EoUuk7j1X5vKZ4ZQDm84J/cMkPKWPe5C+L9Px2eJ9?=
 =?us-ascii?Q?18zPNXcWHZTkkGzwYaAyXv4UllGg2FOTf1dYuQ2hUJYR9p2bKDKdjrjmKMP4?=
 =?us-ascii?Q?5UH2mz1zbWiXiGvlOCBU/bPkue4Xwaf17mN54DQAs6MA44Y7c3on7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7awUrjQob0YBSPQa/ElLFhLX49rEwH+C2qHisWLx9J637LOsSAFo2s+xsS4O?=
 =?us-ascii?Q?VIfAM93MqAtSfvGu75F0mtPPqrR/acawsXvsPRgD2bfuACFExuHfR36Alfjx?=
 =?us-ascii?Q?NM6uwUwgcu3wTEsfIE31XIzpIbczd7LmD1d1TuC7dnLfQZR8w0PiwDHvoZnh?=
 =?us-ascii?Q?ebxq+hMLPC9Rkvj92TlfvwOtmlTDNG2CYaA6Fo0tLIHAB/4OoyQlnCn1JQwc?=
 =?us-ascii?Q?XG4RVGOyDZgbNGcW9C8BQ3PnhM1sx5Kq88TKOpDNC0rvivPOy+eKa5vPsBYT?=
 =?us-ascii?Q?DrqDdI3Ofc17jGTOd+7GpYyL+VpitAGvAPR7oKq7RobTvEB8SRGn/19LrA0/?=
 =?us-ascii?Q?VFdNpOKi/C+VmREY2nlkVQwy39ho3w3ktvrytzVIAupdFe0zm9O8APcnOlwZ?=
 =?us-ascii?Q?CY+MYyQE0olyoA/lektxul4UA/GI6tx3ik/PST7oPTXjvP2yebvXdGbqUrwu?=
 =?us-ascii?Q?UadfNUCzVM9r9Ll1P1+YJn/udujSrx4NQo5y2Hlx6fOoisg+uCAm5liaOXZc?=
 =?us-ascii?Q?/q8vizQ5CPymqA0AD7agE0gMNXg60VJPPjb9Dvl4LuPPhYuLWh62L2+nH2Pw?=
 =?us-ascii?Q?2QAf2WCq3sMDoe61a2aDlgLLb1wY43OGQs4YvJFpcrjEGPyO21G+OttDv8dd?=
 =?us-ascii?Q?oAsOjE+puFpsONMyXZERUylVm15RFohc2OCELdWDIoe8tc90bcPBNIW00Z6Y?=
 =?us-ascii?Q?LMdQch60qCC0Vw/VZY4k6DyHtu/2W3tzfu+zEZPyS5Hck/2NrRcpp6w4HyMS?=
 =?us-ascii?Q?v92Jf19iJ2OokBj3rv/WaYNe4Zp/zjPSAP2iyF19yh4xiPZ6fFaMsalWGJ1i?=
 =?us-ascii?Q?OGXDs9RisV5f8unemVxlTYoUosdNMPXr1hbHrQOITPLE+BRUVzpoOjAurjMa?=
 =?us-ascii?Q?tHcWVC092hfoNvq5zWl9DfD7GjBz11NuJPlGqnuDCNOzyd4BY3oc/x59QU+X?=
 =?us-ascii?Q?9YEybORkEhBb/L8OjHIutui0HnIHvaahQDYxByk7pmGAZW/HyxWCGMap+M7I?=
 =?us-ascii?Q?WkkwYfdDKb0fp5hjGr/v/797bHPZoYWn7jh1ykATneiYQ9PZbX4MpLnO8isj?=
 =?us-ascii?Q?nC3oZGQ0ksvdczOIGeWLtWT8bFgZtOke+wZBEy3WNU+gbWv/sVic/bcwzzuP?=
 =?us-ascii?Q?ocCPmlNOrKP+VfUpK0nwIMUjZkP8cEx5VSkdzPyrVfG5pZbb6QZYm4OdQmXj?=
 =?us-ascii?Q?h8esbQYGufNGEqbdBcF/GZUXyqjVZ0iDfkBpP/gNHj9wWiDCg98+O1jjeGam?=
 =?us-ascii?Q?b8s3TwraflrVuC4MCBNsWoVoVXgeCJhpn9x4WfSNMuUVdq5hRFmVCkZ1Rq4J?=
 =?us-ascii?Q?KqX9TbL5v9PHFA3RL/rVSDxoldfe6gWQAGnNz31vEOc8uAppsqLdeR4j6uKW?=
 =?us-ascii?Q?t60ba76qfQHTCc8lzyXRT1n8hUS+am+5b6f/TghWo9Yu6+E2Ghte8ezHZk07?=
 =?us-ascii?Q?ti9uGdWrgnrYo5aCR2iokwFsQCYW/p81plnCzNLB94dTt2aLwGYJGJ72I9Hi?=
 =?us-ascii?Q?d5PFTyJGR6c9XSgdLV4ja2DcKQs44ByWYZwfPGn48tPvD+BgRyrFbb765bv1?=
 =?us-ascii?Q?sP3INU1bYCawhqdbqidiTAmqPfAzb9REuVRHLm+gHJjaSEGMrhjm7jcw7YPW?=
 =?us-ascii?Q?fw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e947cd5f-a0eb-468d-789d-08dd84d1848f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 14:49:16.4982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: borLN0gh1d0L6VWrFkm+mlmrzAUddfzZX8TI4RJRldfuMQfuhw5LjpUrxuc1W/wQPC9IlqY9zlbBUFHnLLNYIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9019

Add a forwarding path test for tc-taprio, based on isochron. This is
specifically intended for NICs with an offloaded data path (switchdev/DSA)
and requires taprio 'flags 2'. Also, $h1 and $h2 must support hardware
timestamping, and $h1 tc-etf offload, for isochron to work.

Packets received by a switch while the egress port has a taprio schedule
with an open gate for the traffic class must be sent right away.

Packets received by the switch while the traffic class gate must be
delayed until it opens.

Packets received by the switch must be dropped if the gate for the
traffic class never opens.

Packets should pass if the maximum SDU for the traffic class allows it,
and should be dropped otherwise.

The schedule should auto-update itself if clock jumps take place while
taprio is installed. Repeat most of the above tests after forcing two
clock jumps, one backwards (in Jan 1970) and one back into the present.

Symlink it from tools/testing/selftests/drivers/net/dsa, because usually
DSA ports have the same MAC address, and we need STABLE_MAC_ADDRS=yes
from its forwarding.config for the test to run successfully.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../selftests/drivers/net/dsa/tc_taprio.sh    |   1 +
 .../selftests/net/forwarding/tc_taprio.sh     | 421 ++++++++++++++++++
 .../selftests/net/forwarding/tsn_lib.sh       |  10 +
 3 files changed, 432 insertions(+)
 create mode 120000 tools/testing/selftests/drivers/net/dsa/tc_taprio.sh
 create mode 100755 tools/testing/selftests/net/forwarding/tc_taprio.sh

diff --git a/tools/testing/selftests/drivers/net/dsa/tc_taprio.sh b/tools/testing/selftests/drivers/net/dsa/tc_taprio.sh
new file mode 120000
index 000000000000..d16a65e7595d
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/dsa/tc_taprio.sh
@@ -0,0 +1 @@
+run_net_forwarding_test.sh
\ No newline at end of file
diff --git a/tools/testing/selftests/net/forwarding/tc_taprio.sh b/tools/testing/selftests/net/forwarding/tc_taprio.sh
new file mode 100755
index 000000000000..8992aeabfe0b
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/tc_taprio.sh
@@ -0,0 +1,421 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+ALL_TESTS=" \
+	test_clock_jump_backward \
+	test_taprio_after_ptp \
+	test_max_sdu \
+	test_clock_jump_backward_forward \
+"
+NUM_NETIFS=4
+source tc_common.sh
+source lib.sh
+source tsn_lib.sh
+
+require_command python3
+
+# The test assumes the usual topology from the README, where h1 is connected to
+# swp1, h2 to swp2, and swp1 and swp2 are together in a bridge.
+# Additional assumption: h1 and h2 use the same PHC, and so do swp1 and swp2.
+# By synchronizing h1 to swp1 via PTP, h2 is also implicitly synchronized to
+# swp1 (and both to CLOCK_REALTIME).
+h1=${NETIFS[p1]}
+swp1=${NETIFS[p2]}
+swp2=${NETIFS[p3]}
+h2=${NETIFS[p4]}
+
+UDS_ADDRESS_H1="/var/run/ptp4l_h1"
+UDS_ADDRESS_SWP1="/var/run/ptp4l_swp1"
+
+H1_IPV4="192.0.2.1"
+H2_IPV4="192.0.2.2"
+H1_IPV6="2001:db8:1::1"
+H2_IPV6="2001:db8:1::2"
+
+# Tunables
+NUM_PKTS=100
+STREAM_VID=10
+STREAM_PRIO_1=6
+STREAM_PRIO_2=5
+STREAM_PRIO_3=4
+# PTP uses TC 0
+ALL_GATES=$((1 << 0 | 1 << STREAM_PRIO_1 | 1 << STREAM_PRIO_2))
+# Use a conservative cycle of 10 ms to allow the test to still pass when the
+# kernel has some extra overhead like lockdep etc
+CYCLE_TIME_NS=10000000
+# Create two Gate Control List entries, one OPEN and one CLOSE, of equal
+# durations
+GATE_DURATION_NS=$((CYCLE_TIME_NS / 2))
+# Give 2/3 of the cycle time to user space and 1/3 to the kernel
+FUDGE_FACTOR=$((CYCLE_TIME_NS / 3))
+# Shift the isochron base time by half the gate time, so that packets are
+# always received by swp1 close to the middle of the time slot, to minimize
+# inaccuracies due to network sync
+SHIFT_TIME_NS=$((GATE_DURATION_NS / 2))
+
+path_delay=
+
+h1_create()
+{
+	simple_if_init $h1 $H1_IPV4/24 $H1_IPV6/64
+}
+
+h1_destroy()
+{
+	simple_if_fini $h1 $H1_IPV4/24 $H1_IPV6/64
+}
+
+h2_create()
+{
+	simple_if_init $h2 $H2_IPV4/24 $H2_IPV6/64
+}
+
+h2_destroy()
+{
+	simple_if_fini $h2 $H2_IPV4/24 $H2_IPV6/64
+}
+
+switch_create()
+{
+	local h2_mac_addr=$(mac_get $h2)
+
+	ip link set $swp1 up
+	ip link set $swp2 up
+
+	ip link add br0 type bridge vlan_filtering 1
+	ip link set $swp1 master br0
+	ip link set $swp2 master br0
+	ip link set br0 up
+
+	bridge vlan add dev $swp2 vid $STREAM_VID
+	bridge vlan add dev $swp1 vid $STREAM_VID
+	bridge fdb add dev $swp2 \
+		$h2_mac_addr vlan $STREAM_VID static master
+}
+
+switch_destroy()
+{
+	ip link del br0
+}
+
+ptp_setup()
+{
+	# Set up swp1 as a master PHC for h1, synchronized to the local
+	# CLOCK_REALTIME.
+	phc2sys_start $UDS_ADDRESS_SWP1
+	ptp4l_start $h1 true $UDS_ADDRESS_H1
+	ptp4l_start $swp1 false $UDS_ADDRESS_SWP1
+}
+
+ptp_cleanup()
+{
+	ptp4l_stop $swp1
+	ptp4l_stop $h1
+	phc2sys_stop
+}
+
+txtime_setup()
+{
+	local if_name=$1
+
+	tc qdisc add dev $if_name clsact
+	# Classify PTP on TC 7 and isochron on TC 6
+	tc filter add dev $if_name egress protocol 0x88f7 \
+		flower action skbedit priority 7
+	tc filter add dev $if_name egress protocol 802.1Q \
+		flower vlan_ethtype 0xdead action skbedit priority 6
+	tc qdisc add dev $if_name handle 100: parent root mqprio num_tc 8 \
+		queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
+		map 0 1 2 3 4 5 6 7 \
+		hw 1
+	# Set up TC 5, 6, 7 for SO_TXTIME. tc-mqprio queues count from 1.
+	tc qdisc replace dev $if_name parent 100:$((STREAM_PRIO_1 + 1)) etf \
+		clockid CLOCK_TAI offload delta $FUDGE_FACTOR
+	tc qdisc replace dev $if_name parent 100:$((STREAM_PRIO_2 + 1)) etf \
+		clockid CLOCK_TAI offload delta $FUDGE_FACTOR
+	tc qdisc replace dev $if_name parent 100:$((STREAM_PRIO_3 + 1)) etf \
+		clockid CLOCK_TAI offload delta $FUDGE_FACTOR
+}
+
+txtime_cleanup()
+{
+	local if_name=$1
+
+	tc qdisc del dev $if_name clsact
+	tc qdisc del dev $if_name root
+}
+
+taprio_replace()
+{
+	local if_name="$1"; shift
+	local extra_args="$1"; shift
+
+	# STREAM_PRIO_1 always has an open gate.
+	# STREAM_PRIO_2 has a gate open for GATE_DURATION_NS (half the cycle time)
+	# STREAM_PRIO_3 always has a closed gate.
+	tc qdisc replace dev $if_name root stab overhead 24 taprio num_tc 8 \
+		queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
+		map 0 1 2 3 4 5 6 7 \
+		sched-entry S $(printf "%x" $ALL_GATES) $GATE_DURATION_NS \
+		sched-entry S $(printf "%x" $((ALL_GATES & ~(1 << STREAM_PRIO_2)))) $GATE_DURATION_NS \
+		base-time 0 flags 0x2 $extra_args
+	taprio_wait_for_admin $if_name
+}
+
+taprio_cleanup()
+{
+	local if_name=$1
+
+	tc qdisc del dev $if_name root
+}
+
+probe_path_delay()
+{
+	local isochron_dat="$(mktemp)"
+	local received
+
+	log_info "Probing path delay"
+
+	isochron_do "$h1" "$h2" "$UDS_ADDRESS_H1" "" 0 \
+		"$CYCLE_TIME_NS" "" "" "$NUM_PKTS" \
+		"$STREAM_VID" "$STREAM_PRIO_1" "" "$isochron_dat"
+
+	received=$(isochron_report_num_received "$isochron_dat")
+	if [ "$received" != "$NUM_PKTS" ]; then
+		echo "Cannot establish basic data path between $h1 and $h2"
+		exit $ksft_fail
+	fi
+
+	printf "pdelay = {}\n" > isochron_data.py
+	isochron report --input-file "$isochron_dat" \
+		--printf-format "pdelay[%u] = %d - %d\n" \
+		--printf-args "qRT" \
+		>> isochron_data.py
+	cat <<-'EOF' > isochron_postprocess.py
+	#!/usr/bin/env python3
+
+	from isochron_data import pdelay
+	import numpy as np
+
+	w = np.array(list(pdelay.values()))
+	print("{}".format(np.max(w)))
+	EOF
+	path_delay=$(python3 ./isochron_postprocess.py)
+
+	log_info "Path delay from $h1 to $h2 estimated at $path_delay ns"
+
+	if [ "$path_delay" -gt "$GATE_DURATION_NS" ]; then
+		echo "Path delay larger than gate duration, aborting"
+		exit $ksft_fail
+	fi
+
+	rm -f ./isochron_data.py 2> /dev/null
+	rm -f ./isochron_postprocess.py 2> /dev/null
+	rm -f "$isochron_dat" 2> /dev/null
+}
+
+setup_prepare()
+{
+	vrf_prepare
+
+	h1_create
+	h2_create
+	switch_create
+
+	txtime_setup $h1
+
+	# Temporarily set up PTP just to probe the end-to-end path delay.
+	ptp_setup
+	probe_path_delay
+	ptp_cleanup
+}
+
+cleanup()
+{
+	pre_cleanup
+
+	isochron_recv_stop
+	txtime_cleanup $h1
+
+	switch_destroy
+	h2_destroy
+	h1_destroy
+
+	vrf_cleanup
+}
+
+run_test()
+{
+	local base_time=$1; shift
+	local stream_prio=$1; shift
+	local expected_delay=$1; shift
+	local should_fail=$1; shift
+	local test_name=$1; shift
+	local isochron_dat="$(mktemp)"
+	local received
+	local median_delay
+
+	RET=0
+
+	# Set the shift time equal to the cycle time, which effectively
+	# cancels the default advance time. Packets won't be sent early in
+	# software, which ensures that they won't prematurely enter through
+	# the open gate in __test_out_of_band(). Also, the gate is open for
+	# long enough that this won't cause a problem in __test_in_band().
+	isochron_do "$h1" "$h2" "$UDS_ADDRESS_H1" "" "$base_time" \
+		"$CYCLE_TIME_NS" "$SHIFT_TIME_NS" "$GATE_DURATION_NS" \
+		"$NUM_PKTS" "$STREAM_VID" "$stream_prio" "" "$isochron_dat"
+
+	received=$(isochron_report_num_received "$isochron_dat")
+	[ "$received" = "$NUM_PKTS" ]
+	check_err_fail $should_fail $? "Reception of $NUM_PKTS packets"
+
+	if [ $should_fail = 0 ] && [ "$received" = "$NUM_PKTS" ]; then
+		printf "pdelay = {}\n" > isochron_data.py
+		isochron report --input-file "$isochron_dat" \
+			--printf-format "pdelay[%u] = %d - %d\n" \
+			--printf-args "qRT" \
+			>> isochron_data.py
+		cat <<-'EOF' > isochron_postprocess.py
+		#!/usr/bin/env python3
+
+		from isochron_data import pdelay
+		import numpy as np
+
+		w = np.array(list(pdelay.values()))
+		print("{}".format(int(np.median(w))))
+		EOF
+		median_delay=$(python3 ./isochron_postprocess.py)
+
+		# If the condition below is true, packets were delayed by a closed gate
+		[ "$median_delay" -gt $((path_delay + expected_delay)) ]
+		check_fail $? "Median delay $median_delay is greater than expected delay $expected_delay plus path delay $path_delay"
+
+		# If the condition below is true, packets were sent expecting them to
+		# hit a closed gate in the switch, but were not delayed
+		[ "$expected_delay" -gt 0 ] && [ "$median_delay" -lt "$expected_delay" ]
+		check_fail $? "Median delay $median_delay is less than expected delay $expected_delay"
+	fi
+
+	log_test "$test_name"
+
+	rm -f ./isochron_data.py 2> /dev/null
+	rm -f ./isochron_postprocess.py 2> /dev/null
+	rm -f "$isochron_dat" 2> /dev/null
+}
+
+__test_always_open()
+{
+	run_test 0.000000000 $STREAM_PRIO_1 0 0 "Gate always open"
+}
+
+__test_always_closed()
+{
+	run_test 0.000000000 $STREAM_PRIO_3 0 1 "Gate always closed"
+}
+
+__test_in_band()
+{
+	# Send packets in-band with the OPEN gate entry
+	run_test 0.000000000 $STREAM_PRIO_2 0 0 "In band with gate"
+}
+
+__test_out_of_band()
+{
+	# Send packets in-band with the CLOSE gate entry
+	run_test 0.005000000 $STREAM_PRIO_2 \
+		$((GATE_DURATION_NS - SHIFT_TIME_NS)) 0 \
+		"Out of band with gate"
+}
+
+run_subtests()
+{
+	__test_always_open
+	__test_always_closed
+	__test_in_band
+	__test_out_of_band
+}
+
+test_taprio_after_ptp()
+{
+	log_info "Setting up taprio after PTP"
+	ptp_setup
+	taprio_replace $swp2
+	run_subtests
+	taprio_cleanup $swp2
+	ptp_cleanup
+}
+
+__test_under_max_sdu()
+{
+	# Limit max-sdu for STREAM_PRIO_1
+	taprio_replace "$swp2" "max-sdu 0 0 0 0 0 0 100 0"
+	run_test 0.000000000 $STREAM_PRIO_1 0 0 "Under maximum SDU"
+}
+
+__test_over_max_sdu()
+{
+	# Limit max-sdu for STREAM_PRIO_1
+	taprio_replace "$swp2" "max-sdu 0 0 0 0 0 0 20 0"
+	run_test 0.000000000 $STREAM_PRIO_1 0 1 "Over maximum SDU"
+}
+
+test_max_sdu()
+{
+	ptp_setup
+	__test_under_max_sdu
+	__test_over_max_sdu
+	taprio_cleanup $swp2
+	ptp_cleanup
+}
+
+# Perform a clock jump in the past without synchronization running, so that the
+# time base remains where it was set by phc_ctl.
+test_clock_jump_backward()
+{
+	# This is a more complex schedule specifically crafted in a way that
+	# has been problematic on NXP LS1028A. Not much to test with it other
+	# than the fact that it passes traffic.
+	tc qdisc replace dev $swp2 root stab overhead 24 taprio num_tc 8 \
+		queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 map 0 1 2 3 4 5 6 7 \
+		base-time 0 sched-entry S 20 300000 sched-entry S 10 200000 \
+		sched-entry S 20 300000 sched-entry S 48 200000 \
+		sched-entry S 20 300000 sched-entry S 83 200000 \
+		sched-entry S 40 300000 sched-entry S 00 200000 flags 2
+
+	log_info "Forcing a backward clock jump"
+	phc_ctl $swp1 set 0
+
+	ping_test $h1 192.0.2.2
+	taprio_cleanup $swp2
+}
+
+# Test that taprio tolerates clock jumps.
+# Since ptp4l and phc2sys are running, it is expected for the time to
+# eventually recover (through yet another clock jump). Isochron waits
+# until that is the case.
+test_clock_jump_backward_forward()
+{
+	log_info "Forcing a backward and a forward clock jump"
+	taprio_replace $swp2
+	phc_ctl $swp1 set 0
+	ptp_setup
+	ping_test $h1 192.0.2.2
+	run_subtests
+	ptp_cleanup
+	taprio_cleanup $swp2
+}
+
+tc_offload_check
+if [[ $? -ne 0 ]]; then
+	log_test_skip "Could not test offloaded functionality"
+	exit $EXIT_STATUS
+fi
+
+trap cleanup EXIT
+
+setup_prepare
+setup_wait
+tests_run
+
+exit $EXIT_STATUS
diff --git a/tools/testing/selftests/net/forwarding/tsn_lib.sh b/tools/testing/selftests/net/forwarding/tsn_lib.sh
index bcee7960a39f..08c044ff6689 100644
--- a/tools/testing/selftests/net/forwarding/tsn_lib.sh
+++ b/tools/testing/selftests/net/forwarding/tsn_lib.sh
@@ -2,6 +2,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright 2021-2022 NXP
 
+tc_testing_scripts_dir=$(dirname $0)/../../tc-testing/scripts
+
 REQUIRE_ISOCHRON=${REQUIRE_ISOCHRON:=yes}
 REQUIRE_LINUXPTP=${REQUIRE_LINUXPTP:=yes}
 
@@ -18,6 +20,7 @@ fi
 if [[ "$REQUIRE_LINUXPTP" = "yes" ]]; then
 	require_command phc2sys
 	require_command ptp4l
+	require_command phc_ctl
 fi
 
 phc2sys_start()
@@ -263,3 +266,10 @@ isochron_report_num_received()
 		--printf-format "%u\n" --printf-args "R" | \
 		grep -w -v '0' | wc -l
 }
+
+taprio_wait_for_admin()
+{
+	local if_name="$1"; shift
+
+	"$tc_testing_scripts_dir/taprio_wait_for_admin.sh" "$(which tc)" "$if_name"
+}
-- 
2.43.0


