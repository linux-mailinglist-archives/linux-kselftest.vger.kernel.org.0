Return-Path: <linux-kselftest+bounces-10008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD19D8C2393
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 13:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2603B1F22CCC
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 11:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9A017084D;
	Fri, 10 May 2024 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cUUKB21O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2059.outbound.protection.outlook.com [40.107.13.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0609016D4F4;
	Fri, 10 May 2024 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340567; cv=fail; b=SDP4/2a8Fp1y68ApTPXLVOvslZlPKkF6Iktpeg5iaVhQTWFdgP7c55V/7RRR+/nGa4aphY/+V93YrwTlt5vLfcUKWzn53n3ZxHO0UW1n4//ZSNhdjLFovhOeuqqBd2QLkSicxSbVEj9wY1abIPLvroP3GLMIz3SeNScdHZOkHS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340567; c=relaxed/simple;
	bh=fEaOMplnFvHvePzmyv6wZGvRWuI3qZH2LyVQwiQyA60=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kZbaMJamBhVYHhXyTJ9EyXHsAlzChwKD9184mTOq03jMCpulZfJsO6gORHy3xc257X3r56oiraNGy5vYYO+V8b588YIJ1Vo9Ryu5C/hj3jw10dccf6u06CGtWN07VszPvR8I/l+CJ1CVb4pr0sWF3C8MiRxTVKVi8Fr2aQarKqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cUUKB21O; arc=fail smtp.client-ip=40.107.13.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idixOJzICBYnPUgmMBoPcmgX8hE4IMZegqGc3XC+B52+Qn5IsODx6hqHXMvVjmhDj9oKGe2N+6utxx88YgGADpO9d21ZGAFjAOHvG7Es502ZeAIxdOVFojDuPl6U+IL2z9sKEA7o1U1P1V0A6BYLR6PEpv79NLp1M4btIDbwQ7GGxvXgmlk/I2/4hf4vw3CpG9Ovh/fccA5n6dpUfyxaAQJ4BuJr9JQZOp6RxTqi6xsDeX4kbi2BTJdpCY0/fmDpvuXad1ttUZtX6a5sR723Mr0IkjqC1Lo6f4NUIUiB/8Pi29JSufjZ0Ckd+XLEKnaSOemsZqAR/E8HKQd0jKfzSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OUZAANm1rWHCM6bqe8eLmHdjpKSQZUgl4N3y+RuEig=;
 b=N7KOJ2YCMncMGs3cLg4foB4VZhbbJvfGPLWb6UCuCISnDJOj9qJx4S/UgtU4LtaAP3MCgHF2F3ER2f942XRWu4QkhJIjQAhFvSz8mtq0WTug/vxZyHKLT7F8jyENahDj2pk9dJY9uCyMizih1yaF/qeLaxj52S66WaVU3kB4DkX4byY8oqep6gSJ+1vZ7sLklW1I9qMbHr+9MplxbWqPSq+sxNeLByz6qU8Ixiq5sGFTGWM8iMufMHR0Jbx5rs7Qg7XIMR25cMTBSjMiNCfewu3LTOc4c6+KwaFpkZAKjEBSNP4T0z7+NGx59ZvBq+q+axb5wSaLDJz5wClReMiGRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OUZAANm1rWHCM6bqe8eLmHdjpKSQZUgl4N3y+RuEig=;
 b=cUUKB21OLLOYitu4IhMUIkeNVOyqoD5vjHa/1ngWOovm9TKww0TM2kE82znpZPO2vCBQcGeKOVaLKW8C4fVE5blC7ZNWf0wTZvKmgYg7G2XP4jVg+RetNuG4ZIpnye0Kx1y8AUJMDoNEtkWcsy1NmoITqIqZp3Fl961v0ix+ChY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBAPR04MB7368.eurprd04.prod.outlook.com (2603:10a6:10:1ad::19)
 by AS8PR04MB8484.eurprd04.prod.outlook.com (2603:10a6:20b:34c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 11:29:20 +0000
Received: from DBAPR04MB7368.eurprd04.prod.outlook.com
 ([fe80::2bba:eb35:9ac6:9884]) by DBAPR04MB7368.eurprd04.prod.outlook.com
 ([fe80::2bba:eb35:9ac6:9884%7]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 11:29:20 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>,
	linux-kselftest@vger.kernel.org,
	Joachim Wiberg <troglobit@gmail.com>
Subject: [PATCH net-next] selftests: net: use upstream mtools
Date: Fri, 10 May 2024 14:28:56 +0300
Message-Id: <20240510112856.1262901-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0123.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::20) To DBAPR04MB7368.eurprd04.prod.outlook.com
 (2603:10a6:10:1ad::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR04MB7368:EE_|AS8PR04MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 82cebe46-6fb3-4758-1054-08dc70e46f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|7416005|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?acKO6vcilJQhqtq5iciT8oIdXX6kDLOzMEVEEv/GyQVk+902srikq6Uavx5S?=
 =?us-ascii?Q?ePjU4ck+73HnMhlAijmnMOzJ5Xvxid+s8AdJU36GcH39NGlBsYL7Crg1WOM/?=
 =?us-ascii?Q?BOXfiqrodptoIQHDrC/CAIdzhW8Y1ZqSTAqB7r1DjbyvrLvG/Azaj3Fuhn3X?=
 =?us-ascii?Q?Nql9L7Bthgn7eyVNMo8tiLEIQxPNTnF0XCx7n09dALT46vfQ/dDRGElegprD?=
 =?us-ascii?Q?xzXrOu7eVqdK+OlHySqCzXSUuvprn41aI1uZgHBdMWgtCxP+0oe5Me6cGHU/?=
 =?us-ascii?Q?G3ItKc6t2gNQuSt8Tw1ScHrld4FN6iipqWXMvZfElgv48M/UEydVJ79BjgdJ?=
 =?us-ascii?Q?FPUipOT1La4IRZyDAqiLUXya6PGukMNwc1JaegvMs0nlFxKyw/BOuUNgEam3?=
 =?us-ascii?Q?1WCz8VBxNN2Yjob5fkyKGeejv45Vjgtnumx188BH1l9MwtKlg0c+V2S5JBfR?=
 =?us-ascii?Q?Zzz7teukQ3o7PwOetC6xm2wfqQ33jpKnZSqIL7KVUOec97gh6L2t9M6hWlQM?=
 =?us-ascii?Q?34xODywD05xVXlUA4gVEn9SFVnyiKeeUgeN2o6wOgwpTNUaHrxz2B8p4jwmD?=
 =?us-ascii?Q?N19SWpZAxI64weG4IAuzDpfh7dLtgKPA2a2V4HzNYWod7fFOIke/FjlF2/xt?=
 =?us-ascii?Q?wBBf/woTTGnpx6RaOd52fB720E56dVh59KzwTNm8gtpentxRZT+B0oOezcur?=
 =?us-ascii?Q?x+IaBqEHCHjIMHxD4aXrEIFUX5XHwrwu7kz2mW5B7o3xdpcdIMWdV3tWAPxQ?=
 =?us-ascii?Q?Adx2ap+U+CfhlBJxQ8OdJxlZBzB6XwuEoiFeC7NPlsXNfQPkfxVVjaPfxSKU?=
 =?us-ascii?Q?lQF4s1nVRdbQDTef6ztv0esQPNk6GOVUrzQb3hdnkNc0PWHAhmF5+r8fFlwx?=
 =?us-ascii?Q?gWRgDSqv9O/qpuwTfLoGJfjcN5RQFEOLBBbyYQCoMSxEb/AwYQR+8lruiguE?=
 =?us-ascii?Q?nyy+vnHg11GHXrp+87l0NgSdp9kkdQIXshJ/KOh3iC9iTnl+5NtnZEfhUrF2?=
 =?us-ascii?Q?ucqX97cFKyfQLVQyK3Ue2xKvtv5cbMOB+laR4rvHuBwkJla4jQl4lB7ZksAZ?=
 =?us-ascii?Q?YgyS8zPcmMJitL5tIKFTY5N09a1xhqSi+LpIcpgB5NNljYOyXi14rP/dukjb?=
 =?us-ascii?Q?bkAPtqDSnZ3EwuZt1taqRnIbt5WJk0SRqcALsyx97KG+X03OFke/rI11X13Q?=
 =?us-ascii?Q?nTzsNDcjIjgWjkfF4xSTGp4yVBtMUbaDt433XR/zwjAucyPnFND+AC2so7oc?=
 =?us-ascii?Q?OdL1H90L7RprZ+JXGy/EScnjIPyY8I7RVP3NrvZBrA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7368.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nHEHZRvrOhXPP0HUrRUcZgsOlUmPGwGqBNhRjEzne1ubfGi9P0JUkJSvCQlF?=
 =?us-ascii?Q?slFRoN9FAjvKRiEEl+3bsn3XU4fDqfxo1cVNaoLDFMY41CQjePH1Sust/XfB?=
 =?us-ascii?Q?/CU3mU9ttPOpWhPqE+Ss8L+EYomMlpuIl+RJhAGmuAdkz3L1j+AXs6Q3Vhbq?=
 =?us-ascii?Q?ivoCDUJWBjPl6Zg6rUI32jt3b9rPGKKg9kVpptH8lQAtn3ytaxH1QUioHRbp?=
 =?us-ascii?Q?SS4RKR56nJYWHeyd2aNXyH1/DpKzUPMHmeaOU5Co/cbI57RfDaEOusC+UANm?=
 =?us-ascii?Q?+7AU84N8NTT35fTTfs82DLK61zs/8+PQiVKoJ2K2PciwdKde7dA6ZZx7SfJG?=
 =?us-ascii?Q?5glOPzuY14cxkYXK3jFBDT83U6UUrqQN2OleScmTEnIGcqmYDKOHVJd2H5ll?=
 =?us-ascii?Q?2cq6cnQ36ZN6KZrUkwd68LDaRuoHiJVb01YCAQZoMY+tUyQVT7YBkVDygpR2?=
 =?us-ascii?Q?yFxRdNdFfwsoCboDXf90nkljlUCrPRggs50td8/Knh7lVOlEttseNxOaPdnA?=
 =?us-ascii?Q?OtulxklDwyGV1781GvCZPg7rBJxZnHPGRQzrdb9ueyFCZmgxc+m5kS60f55z?=
 =?us-ascii?Q?m/vMFYOebQkPoixtu2tePb2Dh4x94NFI9rtq4tL+XLrkUiMocugRq/N5fJHW?=
 =?us-ascii?Q?zWIlDJUhrC7PzAcqUFXcDcsgSh71Ik7S7guLd9lNCsrbyqgTlxGt2AOwqqLg?=
 =?us-ascii?Q?v5z0pMkz/0tjLXqwLzbq/MaZ44LB/rUvuqYj6o5g0HriYgDDmOXct8ICOLoZ?=
 =?us-ascii?Q?jmBAwXE6NlidVT3RmUIsrsLH1Tmh2JNoRo8LS1O7QlZrg+lzqLblsrrExfDY?=
 =?us-ascii?Q?CZ4dmtiSp4/uoLFMkJa5knWXfNoJI700uCzGgOgZuhtDCObtmhEIP0w+1Dwm?=
 =?us-ascii?Q?czLJbK5SaX3ouPKIZ2QXJT3ryuUBMyIVe1Yy9gxE2UyJKYhfScgAsy1sJDOh?=
 =?us-ascii?Q?UaAFR9/9Upozk16C26qj8xv5u5fwUo/2+sbYkr2R6QMXZiDfqzTf+biSoLCE?=
 =?us-ascii?Q?Spd3u4b+2ZIWAyzpuuT6Z87bLZ0fg6+cOdjQNdCrOMtTxQHa8o0DkZdO1ZVn?=
 =?us-ascii?Q?gY6gpaJPxIrGkTkK8m0Kp0zwacWk9N+XBKMeWzD7W5h2ujrgD7X8EkM1Wvug?=
 =?us-ascii?Q?zJDbbVIcAm6PZnTzxNlxAX4hqFxWbLmqudkSxgqvRdaoqXtTig4IX5I+7XHM?=
 =?us-ascii?Q?ovrHfXjB2njbz4VQNsu3NGP+6mSoFfiyz8Uf0AIRNy3vEHu7JHe+czfpHNDE?=
 =?us-ascii?Q?jooplZfEiuxfEPu4u3YEZystRYU/7g1ApWVUdTIelq4M/ljLehQmzKXwUjZV?=
 =?us-ascii?Q?voJD8yhYwbA1xAsYCpa9Pik90bl9bvOHW1eTgdmdSwigljXx2E4oyo/DqsR3?=
 =?us-ascii?Q?cujW9/2nxAugQTCjt2E4jfDQFkdCg3xrhF7LKTyxf9kAPAsOn2TUdS2MAnAl?=
 =?us-ascii?Q?Yif3YKRoC6uQMkhSqNu3vWBFhEl4UZGd+xuPvdWbYNxlrL90XiF3scOasBAJ?=
 =?us-ascii?Q?eMmWc7BcUELXXdrA7fj8aowvu/Plgo+TDpeVzmpFfOe6+FiDeibAD1C0jS1M?=
 =?us-ascii?Q?8ZmzNlJ8bqFGBc0+sNKiPYKaKXm5Mlw1oSpYm6Bq+IxusHY13PYhdVxpOVAW?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82cebe46-6fb3-4758-1054-08dc70e46f4e
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7368.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 11:29:20.3472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mp+pVT4V6JJ2APKcgTSwNUq65pd6J5nTl1KfCCKy4omP+jshE7sAp0Vz96PTHE/hCuFDLOfG1EJtvBG+3mq8UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8484

Joachim kindly merged the IPv6 support in
https://github.com/troglobit/mtools/pull/2, so we can just use his
version now. A few more fixes subsequently came in for IPv6, so even
better.

Check that the deployed mtools version is 3.0 or above. Note that the
version check breaks compatibility with my fork where I didn't bump the
version, but I assume that won't be a problem.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 4fe28ab5d8b9..aa925c0954a5 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -309,6 +309,21 @@ require_command()
 	fi
 }
 
+# IPv6 support was added in v3.0
+check_mtools_version()
+{
+	local version="$(msend -v)"
+	local major
+
+	version=${version##msend version }
+	major=$(echo $version | cut -d. -f1)
+
+	if [ $major -lt 3 ]; then
+		echo "SKIP: expected mtools version 3.0, got $version"
+		exit $ksft_skip
+	fi
+}
+
 if [[ "$REQUIRE_JQ" = "yes" ]]; then
 	require_command jq
 fi
@@ -316,10 +331,10 @@ if [[ "$REQUIRE_MZ" = "yes" ]]; then
 	require_command $MZ
 fi
 if [[ "$REQUIRE_MTOOLS" = "yes" ]]; then
-	# https://github.com/vladimiroltean/mtools/
-	# patched for IPv6 support
+	# https://github.com/troglobit/mtools
 	require_command msend
 	require_command mreceive
+	check_mtools_version
 fi
 
 ##############################################################################
-- 
2.34.1


