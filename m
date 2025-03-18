Return-Path: <linux-kselftest+bounces-29300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5F1A663BB
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 853F53B9E3B
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 00:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F5E17A30C;
	Tue, 18 Mar 2025 00:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="HDLc9GpH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0966A81741;
	Tue, 18 Mar 2025 00:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257688; cv=fail; b=Ip2Y82tDaz1kiX51jdxhVWAMKQ+bQ2XRAIAINjlzkBmFM4C5I7SEHNdoCsgPFlin+IEs3uk4HFf/5EDaeQiJdJCGd9C5B7+f8V7dekeiBg/jlJvbFPIuBeK8kKLavo8HpsHEOb08YJ1xygpLevJYKP4EYRLBklAmk3NS9O9BJcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257688; c=relaxed/simple;
	bh=lbD1m6Bf5JVDs6uG5YSX8tUoJRk8XTkiOdk2SGkJnpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lnUImwNEZjvFEle7GlPzMc626TN6K4LvGbGSG6so6Il0eegk/IjN0eYJViiqh0enfpQIS7wvLH6u71fiDe1cozL/QRNJ0+bwmMhUac156HSVeClnCZJmlvW8So8uE/s6I9K5rrmrwMWSJgi8Wc7lQlEHUJJhsc1EO/QRWDqlZxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=HDLc9GpH; arc=fail smtp.client-ip=40.107.21.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JU6MXNQdc/lLh3AoaCC72u+eH4lgsqJ4l79nNCJTsznnX73+EPNPvYIl+5MKCrVBSjt9qOTuKA8KyAD4i4/ESco+GlHC4X1rlqXWrcghQ1tO46MiQLqfgmSn4BXs+3/DXV3ITR6rqfFyT38C8H4JXDs3ZXM0qMhup5aZZySTlPPmGnsMGzZI4zFyre3kkbNEMLle5PWnEDYmgav1xpjSsYibilnkDzAbeyaFuV2KTEz5z66mDGrHVgi90MNYJDX6SLZdz+yHwyyZ8z/xET0iYXNbNekRsaTqQ6fPFeCwNomilHMz9Vd0oND7K0ek9B9GS+ZVf7xH6l1yjXDpcaXGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+c3S3ZKWX7fFFw+ZnK2eOgtBq08riLwt5aOlut6+Pw=;
 b=VSWwRTsfJe0nqMSpUhtP9QY55X/peK9QI1baL/RwtvJeoQaOK34J9ELAlWjCcfgygt1+kAXIiJ68oVOu/H/dFCyDqS9iGK2a2pAypU8Tw5K1BVrfMYaIzMu6UPYXmxQDol+1uJVkjMYOKGwilBiO7EB/ackDLB1JkkXvMHCk35RIWSAJMqABED+A2EXFj65DBBwItglXDnKINXWkLqRkeq68YoxgB/gFWRxaZDWcUQFPqEb+lDSD9iXpA5RD/lNluGtVLJv8Shx3yfNwQwF+OZQAZDQP8B3R50yaKBr6IZsl7vyFzJOrl9x3unWTnPAgYt0ASCwFLo3FrtYuBzn6KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+c3S3ZKWX7fFFw+ZnK2eOgtBq08riLwt5aOlut6+Pw=;
 b=HDLc9GpHTp1vQRqy3LRpVWA3x3mZijpAWXeleFuaqJGcO7c/1AnHL/bh8NNyLkLGlEqADfHItlCwRzRVsWBRqgv6Y8R8XxlY/ywuqvwxcmvIKUZTYuLpPEBhVznl5bvEtdBYXEnZz5HuHsREFWAt9rcl1SYjz5rvsdYGrEG9IIkYRUSBAJsJDhxXgONuPnWqhs+BDOykX8xVFBRANGTAm+1VVHOy7xz0Pk3Dm81/WYVwiHjuDs2+J9y5kT/HcLoLwiYC7AfKJIjan2k3IJxwjog8y25rQtYp7e+unl850zY/LjA29iUzvtF7DqDHwSVIh/c1p4uPLK9LF6Y5TGcC9w==
Received: from CWLP123CA0247.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19e::9)
 by PA4PR07MB8390.eurprd07.prod.outlook.com (2603:10a6:102:2a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 00:28:02 +0000
Received: from AM4PEPF00027A5E.eurprd04.prod.outlook.com
 (2603:10a6:400:19e:cafe::32) by CWLP123CA0247.outlook.office365.com
 (2603:10a6:400:19e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 00:28:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM4PEPF00027A5E.mail.protection.outlook.com (10.167.16.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 00:28:02 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 52I0RNBt024935;
	Tue, 18 Mar 2025 00:28:10 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
        donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v2 net-next 13/15] tcp: accecn: try to fit AccECN option with SACK
Date: Tue, 18 Mar 2025 01:27:08 +0100
Message-Id: <20250318002710.29483-14-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318002710.29483-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250318002710.29483-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5E:EE_|PA4PR07MB8390:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc59d8f-a9cc-4966-c753-08dd65b3be6d
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dkRENHNYRDVXdStwbjFYMmlZbWJiRGdwSTEvcmZnZ1FVWno2VXVWbTVZUS8z?=
 =?utf-8?B?MlAyYXJJcXlvei93SUdlbW5yZ1BmYWc1TlhPNFEwYWc0Z1gxSXVQSDJqbS9Y?=
 =?utf-8?B?dUJEOElpRkNCSFJ2S2E3OVhwNkJwcElrUUhMeVZhVWlxRFF2c29aQzU1Tkt5?=
 =?utf-8?B?QzBrYm1TUEhCOC90OTF6dUw1bm94U0JENzQrLzFZdUU2STlFMUxweGJkNjJk?=
 =?utf-8?B?S3ZiOXhxcjNQeWtXYjE5NS9STjR3Q0J1Mjk1RG41SDM3bGJiOW5BZFJ2MlVS?=
 =?utf-8?B?YU9XUk1rRTdjMGh6WUlXeWVVbm1IY0NCZThCcWhWSXlwdVJGZ2g2YTEvWXUr?=
 =?utf-8?B?Z3cvcVhhREJkWVZvUjZ0d2o2OHN2UjF4eTlNWldwV1kxbHlybW5PZU9HQXE1?=
 =?utf-8?B?MUxYUFFiakJVN2NCampoZS9OWDJPYzVPNUp2V0xycFc2ZHViaGorSldsUHl3?=
 =?utf-8?B?WElPNFM4cVNoeGJDbVVCWFNkbC9ZZXd3R216VUdFYmdZUzlRTERnRVAzSVZa?=
 =?utf-8?B?Sm5BemhJeitkZ0dsSU5CRDhzcXlrZ0o1YnBCZ2ptcWNMb0hIdmNHY3d0Z3Vz?=
 =?utf-8?B?ZzZBS2o5YTBHMENEc0lUMHplbkI5L0hLTnJJeHdtSHdWcmdzMUttZGJKeWJJ?=
 =?utf-8?B?V0RhRW1aRmkxUUFOSUh6SkJuY0FTWm5lNkNORmtqUXFOSnl3WWo5UjE1SWY4?=
 =?utf-8?B?OXpsTVhFUnpOZXNjZlI5V2xWYzd2RXZ4Yk8zbVg3QnhmT1A5T0IwZHhrMyty?=
 =?utf-8?B?SHdESDluRnJmc3p1SjEyZUQ2ZHlhRU5SWGRjb25qaGxXdWVLYzd3bmtRY0Qw?=
 =?utf-8?B?ZTk0MngwbU9zbnQrcnNRRGxtdkxLMEMwRTVNZ2FQNnA3QkJac1ZGOThFMlow?=
 =?utf-8?B?K2NqWVFQb204QmRWSk5EeDYxVkcvd3hkWkJhaCtnRG9xRGI2cjUvcjRJRko3?=
 =?utf-8?B?V2RZcklEUDM5UURkREtUTmYzS09aNWdpU2xiYjBTdVp2azlnaHdVVXB2djds?=
 =?utf-8?B?ejZJY3hBMEVpSVJqOXZVb1JhdG9PbGhlZGpvOTc1bnJwSC9UaWZiU0lZMUJ0?=
 =?utf-8?B?c08yOUFCTUZ6VWowTGpHdnVjK25qcUNiYTZaVDR4NXBCWXpSMk1EUFBnZ2k4?=
 =?utf-8?B?N2xUMHJDQWhZMTVmMXFsdDRpVS96Rm9WWTlIbHhYMDlVMzZOb3FLVWJRMDdw?=
 =?utf-8?B?V0VibUNTZ0RCYStSS2ZvT0kxSHh0M0Q3Z0U1d0djaEEzU0NsSmRxTU1DVlJ1?=
 =?utf-8?B?Q3U5Y045clU2U0JTUTdxR2dhaGZaRld1RTJTZlhQdlJCNGVNREVWb0U3cHBL?=
 =?utf-8?B?NythR0ZMWnk2SlJwWlZ3NjVucFVoY2RwZm9aempDaGNmVTZjTXBkL3M1MGZD?=
 =?utf-8?B?SGVXUzFMTkJrdUZGMmN1L3N4eDlsVXBBQkQyNVdwcjhhSmYyWi80OC93bG1Z?=
 =?utf-8?B?MnlaZ3lHSWVTWnV1YUVOOHhwUUJLMXpCQUZGZUtCVGtBNjVKRHB4bmlrYWxE?=
 =?utf-8?B?QVRCa0VXdUxtZFZnSWFXR2N6bW1OM0xIZzgzR2hNdldYSjRvNnVmZTlLcWJ4?=
 =?utf-8?B?N285U3NEQU5iMWZFUDg0TXA4M1NJSGFNTE1pODZRWVFneVhqNVdkZ1QybXZB?=
 =?utf-8?B?S2t2MWUrdkFuS01FSG1nanJ0Z1AyNEFCd3Z1YWdGUGJZamt1akNXR2k0dStD?=
 =?utf-8?B?Y2VHellVSXVXUFByaUZBSG51d1lUcXFQdnVTdXZMMGJwRk1oWWRicTgrNE5s?=
 =?utf-8?B?NkFqaUdLK1BWUGhwYkNudWswclUzTHFEekZUaHNZUjYvSEgvYjNZS09wcWRV?=
 =?utf-8?B?bHJ1OEZVaG5Bc0sxUFliMXQwV201Ry9aN083YU1WdHU0VzFGeEZIdFU5b05W?=
 =?utf-8?B?cTZGTkFqVzFsbXdwWExkVUxkdGh5L21YTnh4cjB0S1UrMGJ6WVdVVEhCdU4z?=
 =?utf-8?B?Y3BYRW0vdDM0V3FmZG1NZ3BtUkllbTNBWkJtNC9oUWIwemtmNzhqYmp6T3lN?=
 =?utf-8?Q?++KAtUxhIoY5Z2GibhFfysStMMG4m4=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 00:28:02.3957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc59d8f-a9cc-4966-c753-08dd65b3be6d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A5E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB8390

From: Ilpo Järvinen <ij@kernel.org>

As SACK blocks tend to eat all option space when there are
many holes, it is useful to compromise on sending many SACK
blocks in every ACK and try to fit AccECN option there
by reduction the number of SACK blocks. But never go below
two SACK blocks because of AccECN option.

As AccECN option is often not put to every ACK, the space
hijack is usually only temporary.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_output.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 6bee68795b0e..fafca7cd369b 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -981,8 +981,21 @@ static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
 		opts->num_accecn_fields--;
 		size -= TCPOLEN_ACCECN_PERFIELD;
 	}
-	if (opts->num_accecn_fields < required)
+	if (opts->num_accecn_fields < required) {
+		if (opts->num_sack_blocks > 2) {
+			/* Try to fit the option by removing one SACK block */
+			opts->num_sack_blocks--;
+			size = tcp_options_fit_accecn(opts, required,
+						      remaining +
+						      TCPOLEN_SACK_PERBLOCK,
+						      max_combine_saving);
+			if (opts->options & OPTION_ACCECN)
+				return size - TCPOLEN_SACK_PERBLOCK;
+
+			opts->num_sack_blocks++;
+		}
 		return 0;
+	}
 
 	opts->options |= OPTION_ACCECN;
 	return size;
-- 
2.34.1


