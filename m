Return-Path: <linux-kselftest+bounces-31706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19547A9DB85
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 16:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94774A3C25
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Apr 2025 14:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F9D25D52F;
	Sat, 26 Apr 2025 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lMPWlMTv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09F725D1F4;
	Sat, 26 Apr 2025 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745678965; cv=fail; b=qoOfpb+PDXa7whak7fION0IB40isZ4UE2owPxLDWNyNnLGCmIcUQhl29vfGHvZxM8cMj0X1J+vc62uhuejAdfWQAfywadQM8YVGVtXdc4kBtBHjhZdDBQ7npZjObmd/qqfquT1l+R2tFtX2uWVHvBnt9d7YFtzr3E065q4Fy3iY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745678965; c=relaxed/simple;
	bh=lnEMYSc0uDmo4TYzWBvxcB+hsw7KI4jBaQWAWHBsfp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fMFFUGUj/btWpcLe4iRuA2frS9v1S/BdiPvJhSpgOISZA+3w2JXvTZCKXIydn4EU5413kWNXt4JQdlNWtNRI+rjGK0az5DpU7oZn2t452/G6vMjEeGyOFNVEMUyk93LKcUZNYFcUYInLwnenzr/9qKbuVWWWIj47lu+vGbJEWkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lMPWlMTv; arc=fail smtp.client-ip=52.101.69.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpncSCGN9mK5J1aJN3md46voKRkrdha3z46sCL8sIulkslaV/aglC7u6GQ0EutoiexDdndP6WOI7rRjMMFLlGal7/NjlbnTj0tJ8V9R9y/ejyDGHo6dXY0Gzcdee4Bw2sjvkMTvltY5LuAOsGELstGymArH0gfYRuYFmWcnG0QQsF8iEy18EO4c6k+jZC0dXHndDwQDXJ4Bwf+dGA9wvDYub5NofXBOVa5d2CkWZQD418/JstNIFi4Qur0hlXjcOO9rOs+aKWLbMCF+AxSBa3Wky80pD1pKHLuA5RcAjnTrm2HHmxPy34A+m3+KmR9WC1zE8sYqv2vViyJpsPVi6Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWIVsqB58uE+ixZgtvNd9dmIfy01pHPSY6r4cvgYMyI=;
 b=Vzm74ZhitC0tzqMV3xpnZ+kscRdYKvlK6V07OyONzfYvGuWJWLxVZALWrr3Y5z4iVuGSosgxhH6NhXic66XM6TqxWyw3NE1XBfl4+EeWwv9krGhArs5YVmzx70Qi2Kp4sB2whYpDjAg853QOv55DwbRgENTHecyeKdoASG0l409d3ZAupkqZu1k6kmtC76mc1Vn7fnXSWZZAfL3CeYZY/3Fznt+za7Y2648sweVsLUuHC3WKCi24DqEh6ZHoXZbTumnMq7s7WHgZMVkImBo9g6AcNfbO1oxtzpvvdnEhseibPMHoNMV4yPzZionK6Xioz0V9sH2K1qwinWIJn3Dgjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWIVsqB58uE+ixZgtvNd9dmIfy01pHPSY6r4cvgYMyI=;
 b=lMPWlMTvGvEXhAaz7y6nWESBTyaSfEP5Xz+WOCUaL/w1JxZzFc/HlGfF0Sv792pC8ktYyea2ppbd6hMeP+hMpXx6y/f+vsZ53laJIVKDzPe/Lh14nCAYhAncI7viMOEzVjVEnd/xTXxX238Bc/OIKdZ5pU51N630O1LD34GXLxbs7TxiB6kLTh1ZakLbbUfKuzKtv1GncQKWA5OCxxgdbx43Lkw28Uf9V+HLNAOr1yGLfJFPyiE8IWJU7W2+/Dk+gr0E6e3PXBpOwakyVTRfRh0/LCaPxIithAEffv81I6GpLmWNtldc6mAuRedVQW11tSwrI9XxY/2HFpghxTYjrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU2PR04MB9019.eurprd04.prod.outlook.com (2603:10a6:10:2d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Sat, 26 Apr
 2025 14:49:14 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8678.028; Sat, 26 Apr 2025
 14:49:14 +0000
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
Subject: [PATCH net 2/4] selftests: net: tsn_lib: create common helper for counting received packets
Date: Sat, 26 Apr 2025 17:48:56 +0300
Message-ID: <20250426144859.3128352-3-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9d39d643-83a2-45a9-7dc2-08dd84d18323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DYBJW+RHMmpEvXAvlSUbK62NwykeUoe+4G24gOU2AW+D7CT+QZgwlC44cg/x?=
 =?us-ascii?Q?GEkUmr+abIq56RWLiYJRFk12xbWlX4G10v3JTGFYfY/yBhczM4GuFUf1vciW?=
 =?us-ascii?Q?URXzZVQ2Ic/oxeJlxSEujUNTAEstjrGzrPUvu4JnmfXD6pkA4/2Yyx1wNEyD?=
 =?us-ascii?Q?4mQriREgWObU4xw3ma1+0XMxOdvWNMN8kaz/HSHe8ZgK8MliwGrIVaUku8HE?=
 =?us-ascii?Q?z1J3yJ4QXd5mw1oPSkvak5Ga7WCSVdro8yD5GwZs6sBmIRXtaMNLzD1Qpkuc?=
 =?us-ascii?Q?d6ci5xuYviHrCNSp8BYEGAAyWsxkLFDCOxGP+fo6C47gZezhhuD+RsKoUTAS?=
 =?us-ascii?Q?KFflkv3mnTqmngusBdZ+VfVX/WlcNWGFXVz8KEIjBhTkNjMuXyYiBtHEfiwB?=
 =?us-ascii?Q?qEqWXxt/kOWdAcz62UZcSe0XZkELRmv2y0W+287nbZB+1+GM4v8aQ1Oe7BKz?=
 =?us-ascii?Q?5O64qNIFilQyh1SBNEKrpTPBRbxt5FAxwJoXTI1IfRtKCLPJgClW71mMc4fA?=
 =?us-ascii?Q?Z365kGG5OEN+e1yh5pOb1ean1Dx/aXAcRM6aI2ECRe6g5ZPWbqAE4F9RtaYg?=
 =?us-ascii?Q?vB/XXAXUXkAWit4GWHOeLeGUqqFNnYswi5W7wxoRqbOzydVDKkNL8cfbk+m1?=
 =?us-ascii?Q?uXSPBYPO1ZNQtUVPmQjGoI7igeVySwyzPmBT7D081BTF2XbpZ0aqTZ60iXYz?=
 =?us-ascii?Q?h8L3FmBkfxswhH4Msp7lMAjdNenvqEGH5xuebwQ3Z2gStvWJX5y4hpWCAjhl?=
 =?us-ascii?Q?sFTBbVs3+ClVMXyQzvZCYgeoiVye4riL5I/Xa9pJGgb9HUp/L9GtwTSfT8ep?=
 =?us-ascii?Q?Hrb36flL3XoQd2UPnI6bPqBtpLIhipAVnmjzQpsfID/0fBFVMcf2rPSy4kEK?=
 =?us-ascii?Q?wG88iD9jEkATY8eNehok3dla3FaVzYJspnVglkR9DKSMe7Wu3mQhmbfKa3jd?=
 =?us-ascii?Q?KW7M4tFvq5CnqZGcAnJp9ZpLYaS2eq10gNfGf11POB8RnFhrX+GCnVknRqTZ?=
 =?us-ascii?Q?Cxu2cUzJsKJZx47MWDUuT8kvuFNAd1LCdMFUWf6gRKFZoTjSVlz2+3q8bS0/?=
 =?us-ascii?Q?6o1hcUbuImHlykkPymag6iw1Ofz1UmaTB5GOTqjRR0ALE+AhpWoOf17gYzRc?=
 =?us-ascii?Q?S0b/u+sisVPDX81HagZgkWfFSABioxA/Hl+TJiZDolJCL6J8TXf0uB3bL7Ys?=
 =?us-ascii?Q?l4WKJnwlRVEExQStjwpCCNGyZ5PGsOgaP8uFjvBaj6OsofiQmGgWvP3WKvPr?=
 =?us-ascii?Q?c5Hwm+oB3MjidmAZu5+JPwYifhrFt89orI6AUmFnBJv2jZJeZQWplDLgNw6i?=
 =?us-ascii?Q?S1yiTBMwP01/Q+YrYyNtHJyp83C9H/TmZ3OZje7SuwhKkcv2xFuTRSWXUbjZ?=
 =?us-ascii?Q?wlJ0gQ/z3da1g2pkgVhJgFvpSMX+qWOKUalx/XO4DLzSTEHBGB318adteD8F?=
 =?us-ascii?Q?UbguSvqj5qcKQdhKHczBqRTNOoQ/wg4v0dbBmb1KnrOgIgBVwnldcw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GexYAHzEXwy1SX6EX/f8bWSXQ/XPrXQJRiB5wjA+Y1I/IwtYOEAPmbtF+12I?=
 =?us-ascii?Q?8SOxR2T2RrI7jLVdU2JUj9BadsLbybFtmr7FYlIUCGCLRQMOoPqhGikQ6Up/?=
 =?us-ascii?Q?lT7O6RzmOKzo6479HjhgwZhkGnM5QEVAaXA2b7hzncFf1M8gccoTub5KELF+?=
 =?us-ascii?Q?UBqtGTH0yq80hGCMWATjupiedGtB5B6bfEzCNtZ0oVLYwwqq9KyL0e0OclJJ?=
 =?us-ascii?Q?TA3noMsiKwO22lD7cwhFMgcDjUOmOKpfDH7lL6pu4lFBVKXWIeXABbiE5PHd?=
 =?us-ascii?Q?bJFeK8GzGUw5gna7aGqE9FygM5urJyh9ViyfF9f8gjPzSo/mv7RhhWvH9K+0?=
 =?us-ascii?Q?eePhw1nL9CguSBPEwz95LxqSZ8HVGpyyfLkYIrQBpf9U3MOoDEGXs+jZlF9r?=
 =?us-ascii?Q?BwsD/nYByxSOYt07CVNPaCrufbnOKS1op4YVcDFhFKi8Uymsz/zA8d7289FT?=
 =?us-ascii?Q?mpJ2jlMRd6oIspJ0i+5FbalS6m97hCg9eYfQdZHndM3o74MbFnVxze09SZGg?=
 =?us-ascii?Q?5wu6EOwc0+CubrnopBBDo+ZkM3tGR7H/NdZmhuA/vGI1wyip5NWjFaID+QF/?=
 =?us-ascii?Q?Q/sQ6+IBzP8zL+2Jj1D2S4LD8T99D0iTKQQv11R7tTWrNrz0xTRDzyrDNmM1?=
 =?us-ascii?Q?xLUUGg9JbqCZDAHP4zDnL/wjodsXIPtjvrB45ke6XfEH3wTBdVsxlHi39Ys/?=
 =?us-ascii?Q?pAtaPwWyu1MamXwgk4cLObGGajisiRRUynDq2o+Tdpz3HbEyhgJpo7Xa74Pl?=
 =?us-ascii?Q?fDSx0GCiw9Y24s0EpWf6XAp7A06vcwWcQhWo8Ewhjj0ahVGOLopPf/+u+9VG?=
 =?us-ascii?Q?nBNrI8YInsDr1oxH4wufGHD2a4Bqe+DjXKm4N5jNbJF7pfbaPArqHqUpc/It?=
 =?us-ascii?Q?tnF1NTfJg8Hf7XblCcaGj9IBUyrpJ1yyYfc/f1G5qJ2+e65N2m2HwyuQyVgd?=
 =?us-ascii?Q?4NV4PArxNSAr/RrJkI3eFNmVwa0NON+K+p6WAosbsA1CyC5f9z1gf+cvMGqb?=
 =?us-ascii?Q?pB6F8hzBe2NHXOVF/FQ5ii9Nomm57Q+vvrndY8z+pB8GdoHFpwpUYj8/SKJz?=
 =?us-ascii?Q?5Xd8HNZThSGYdrPqNh0PHYcHMFGb+kiaZyS1mKwTchMAHl6shHcmlzqPx9J5?=
 =?us-ascii?Q?I6lVMblN8fphtTE+B3B7RcGmF8daOuu4elh9+HHKtRslh+aZFCwFsZx16eY0?=
 =?us-ascii?Q?tG4oOkuimtV6e4juL4G82Dop28/gkAuShyta5yyEiO2tORhctrtfSh+ItiPw?=
 =?us-ascii?Q?oI6SkKReIqkRPEuj2uef2sLVxwzce2hjKGEXiRUs7Z1vpgDg2YpNrncna8Os?=
 =?us-ascii?Q?G6BPI/fcy3eHU8uOa1MPa8TMvFxIuWM8fcWzmMBLD0kZpUiYr10c2Lk+h4Y1?=
 =?us-ascii?Q?YNjSErANL/eHPyY8klOfoSjYupBsFQxVqMUf3u7jirJ6HZ0X+2BaaqAH6SIX?=
 =?us-ascii?Q?FplbZ13XcPmYsDb+31wzSuNopYBb6j5hm4N/NUuidsbW2JjZvbo883I3sUGp?=
 =?us-ascii?Q?/LGP5RllMCPNYRfmWBYPh/82Iv2vBlwQ9paPmphUvccwr1ggjC5zuBfG1gkI?=
 =?us-ascii?Q?uPfu5n0SXKUXI2SOGX82aQ7XWLHjchM59GQyv0N7QVYbf43G7fWUbRUTb3YV?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d39d643-83a2-45a9-7dc2-08dd84d18323
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 14:49:14.1469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgu0cYFoGh8obezO8H0GLECmmb0NvYZwuNfLT/aqYQG63etKTlRAEuc/d4vUPvBVLTrxFBWdgLYjm/CSc3MliA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9019

This snippet will be necessary for a future isochron-based test, so
provide a simpler high-level interface for counting the received
packets.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 tools/testing/selftests/drivers/net/ocelot/psfp.sh |  7 +------
 tools/testing/selftests/net/forwarding/tsn_lib.sh  | 11 +++++++++++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/ocelot/psfp.sh b/tools/testing/selftests/drivers/net/ocelot/psfp.sh
index bed748dde4b0..f96a4bc7120f 100755
--- a/tools/testing/selftests/drivers/net/ocelot/psfp.sh
+++ b/tools/testing/selftests/drivers/net/ocelot/psfp.sh
@@ -272,12 +272,7 @@ run_test()
 		"" \
 		"${isochron_dat}"
 
-	# Count all received packets by looking at the non-zero RX timestamps
-	received=$(isochron report \
-		--input-file "${isochron_dat}" \
-		--printf-format "%u\n" --printf-args "R" | \
-		grep -w -v '0' | wc -l)
-
+	received=$(isochron_report_num_received "${isochron_dat}")
 	if [ "${received}" = "${expected}" ]; then
 		RET=0
 	else
diff --git a/tools/testing/selftests/net/forwarding/tsn_lib.sh b/tools/testing/selftests/net/forwarding/tsn_lib.sh
index b91bcd8008a9..19da1ccceac8 100644
--- a/tools/testing/selftests/net/forwarding/tsn_lib.sh
+++ b/tools/testing/selftests/net/forwarding/tsn_lib.sh
@@ -247,3 +247,14 @@ isochron_do()
 
 	cpufreq_restore ${ISOCHRON_CPU}
 }
+
+isochron_report_num_received()
+{
+	local isochron_dat=$1; shift
+
+	# Count all received packets by looking at the non-zero RX timestamps
+	isochron report \
+		--input-file "${isochron_dat}" \
+		--printf-format "%u\n" --printf-args "R" | \
+		grep -w -v '0' | wc -l
+}
-- 
2.43.0


