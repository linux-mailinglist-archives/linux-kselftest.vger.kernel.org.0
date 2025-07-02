Return-Path: <linux-kselftest+bounces-36251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC62AF0934
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 05:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725E64E12ED
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 03:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548211DE4FC;
	Wed,  2 Jul 2025 03:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Un1ezcQs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013026.outbound.protection.outlook.com [40.107.162.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82021E411C;
	Wed,  2 Jul 2025 03:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751426914; cv=fail; b=LBFT/JUNvOh6TNZf8as/IOfOV9q4j6yroRI0ACkvDFpZUDEvdEFHqCitA/DsQl4qMIZyJao3V5gbaTn2MiHQIDmyYXXcmOTcokKryegz8jebKPqsq3S4Qt7XJQJSgDFpnxanp2lqatgRXX9sTVO/VIH1+R6c3Go/HzLn77a6NB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751426914; c=relaxed/simple;
	bh=2+X08KR2uZR3lBG7SMmOlA758TA2DBF61kuZhVSOjRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JomLPVm0C2he2k4x6MI3ze8OlSr+Rro6vrUB5EW1l6xKbDfKDBVoeTh1Otczjg74CQ4Zp3lGiYzXM2CZZDzDdIvGrFD7bo9cY3UrzVp7vGl0+Tz7fIOlDP3vt+BVNAvUQAzcl236JfI0imsBbkqz0RyRMBxgCs5WGJfS2opSyS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Un1ezcQs; arc=fail smtp.client-ip=40.107.162.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkfDp0lBDfPl/Ht9Aj02aiZT2uGtEZFnK+fbmSPc0gFn0+VOheJYo+o+qeIQRBiOzy95DzvohHNEURFWoOglDvaN0vdmf9FaxnoSrPW6oFiJFM5IeQ+fmdO22gMqaj0rW3oVYwuvWAgkj/te0iPUfSzlZQQNge+B9igQ+1wYsZbV2CDI0DPICPDwT1xBWnNzPcMhcg4Emc1YV2kLFIn8BCfm3Hv3jjz5IgKTs3c2AYWKX7/kJa/51r9jQNhW06sYWx0vxhDmQPsnzEnzHeA6pBtZLSqErD86p6fYlzSL8jguYZa7A+OlL6KKZVFt4oju/2bj9THA72pt0BI2fXKzVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jd+mGTCy4kr9sumObomQ5ywvPw4LhoiRcEi2WA0yrlA=;
 b=r1PHZfXx2BQezDpxMEqp0CMIxM5l6XmgXMBzQ1r7l0+faVMDKrcLoh9rO+rmYO6CGwDZv1IKI1EhHfr5OTUH7qTHC8LtsdyUOcQif2U0G8zCErQb3njO/B31a8Hkwf/eZFfC81b/nnoY/Wp+VrscrSx29q4JrgZ+1HONN8iwucqr1GNIch9g2Awjos99vz2JSG/u/HGEGhd9OK2wMQwkmHFHJ10a0+BX9NcjMdgyWzkqEIsSM8LFgzCycsmA3jeqfjQjTehapQ9xYqwDlppkx/FXyc4kzP/nspY2NZmOJaK4xrgVURo3PduDVbI8gZpu6GtJr9L3FyMy0HuWWzIW+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.240) smtp.rcpttodomain=apple.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd+mGTCy4kr9sumObomQ5ywvPw4LhoiRcEi2WA0yrlA=;
 b=Un1ezcQsm0dnTH5zqbmwET7+PTEX+lKoOEELZt8yVQ1OIMzBkxxXrRIvnKSdeLhBA40VL/CWc2w4x7kKdYrMvfd21JlcjvMDT4ImLH3nPMEPxtWBGAfi3rlp4U7YIKGE6hXj2kjSLoGQ2I6gdJ3d84L817ZUMAa/AY0LXc5S8fJywernxCukALq8SVtgDN+1rPhWdDkJcuxQb05SldF25aN+0hQYV04i6h94rif2z9YHZRpvFMK2TU07wUACXnFitWat0R4D2uuwuYRYfOn8eMQUdZO+QMFdcM10Uw942WZ2fpUXa/P2YI9sPpR6LNckvXdnlSugrONZonPqWb7woQ==
Received: from AM0PR02CA0079.eurprd02.prod.outlook.com (2603:10a6:208:154::20)
 by DB9PR07MB9665.eurprd07.prod.outlook.com (2603:10a6:10:4c5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Wed, 2 Jul
 2025 03:28:28 +0000
Received: from AM4PEPF00025F96.EURPRD83.prod.outlook.com
 (2603:10a6:208:154:cafe::f3) by AM0PR02CA0079.outlook.office365.com
 (2603:10a6:208:154::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Wed,
 2 Jul 2025 03:28:28 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.240) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM4PEPF00025F96.mail.protection.outlook.com (10.167.16.5) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.1 via
 Frontend Transport; Wed, 2 Jul 2025 03:28:27 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 6AA40200B2;
	Wed,  2 Jul 2025 06:28:26 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: alok.a.tiwari@oracle.com,
	pctammela@mojatatu.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	xandfury@gmail.com,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v21 net-next 4/6] selftests/tc-testing: Fix warning and style check on tdc.sh
Date: Wed,  2 Jul 2025 05:28:15 +0200
Message-Id: <20250702032817.13274-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702032817.13274-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250702032817.13274-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F96:EE_|DB9PR07MB9665:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0923d8e5-4b88-45cb-494b-08ddb91882a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?riU7iBqtXfJTIKjix0JqR5jJmV/72ofvNYzAaK5/6foz7C6zaqI3uaXzYQ62?=
 =?us-ascii?Q?yexSlCq+KjZMawY27GvcYU1NZsKKgi41OJU4g1K3qNkdFprq3WXkKlO1Lmaf?=
 =?us-ascii?Q?obLHLkQEgvDc+k3PzrUdPArKeDi6HSH+bGaTjb6aDsPWrQy7EF5QYytiomcW?=
 =?us-ascii?Q?6WuofJHtK3jyEXi76b3hWouYU+roOEEAr4o9dQX/6vzpjfbAIKWCnHZR+rt8?=
 =?us-ascii?Q?6KO/5wLNKbB2QIrbpYNUk+ByY9OTu+gfhaFO2nBytkBYWMUdz/1Vl6nL5CbT?=
 =?us-ascii?Q?dTGZRUzorasBYF05ucTbqNKeLFr8zsSsxRrpQ/f9ioUKbZ2pKWKZ4CFFiurh?=
 =?us-ascii?Q?CMWFR1NvFBDwEgA1MQnfRk1zIezkXbMJmTQMTqY2+0BnIgXY3nJbT937vpuW?=
 =?us-ascii?Q?Y9/HiN/qjTFyeSehNyVrgCGbb2+iKJipqjNyeJzrt1xMc1huFhA1ad9Z9lhx?=
 =?us-ascii?Q?X/0rFerjAzpH8A7dHIn8akv3fYb0PH85Fn3rxAtHC2C6tFmMRSHY5zpOhuyg?=
 =?us-ascii?Q?gy0cxK2+JcFMIfOyyGobzfDO234eXBqXCj50uy2J62qGUbnm8gqRIz+2JWC8?=
 =?us-ascii?Q?EC+Qd+HX+t4DgvpQFfVV3UNZMwbq8p9hmbCESdUK03E7ODC6B8RfB2gby2FJ?=
 =?us-ascii?Q?3eSriKshbMx76uo814OaqILld27HRjB7BCZog52TTGcoPAiWXFf7T6jsb7SQ?=
 =?us-ascii?Q?tXF5ERE2GHnyXYm1bxjo4mcFXcQpGpdBl+8ShfURe1J4X67+yfGN1xzMfQ/k?=
 =?us-ascii?Q?JKxBuksbN2l+npnoYinN8HEm7yB2dgqGNjXp/HQhByeRRF9w3yVVRP3PjN8/?=
 =?us-ascii?Q?1XPoFA5UITl1wbOJmXYbDEsc2kGxDZyUE8poAc0Cfylo5YxLPOqYjDeRXy4Z?=
 =?us-ascii?Q?r9ySpUZ7XpIMXNm9EcXfnGx6HTSv1xHTcPEUG9Od7zAzGv4+XrrnCnG/mhOM?=
 =?us-ascii?Q?jLUFEIshVPQYWyCIHLd34wTyTOO9VgpTXQpHc4KTN12N7NDMqsTibmeX+j6N?=
 =?us-ascii?Q?11coW81ofhaEJc2ApjPD/0FmgH4Dp1WiQvhFEGrTGmYRMhneyi7M3S7r+AK9?=
 =?us-ascii?Q?F1mBceXoUKOdTTF1QMazZ2birNgb34/MQX49kwzdNAgrIYeeyZ7cspDwjCz9?=
 =?us-ascii?Q?QVem0dcfL0SKZ/ZEwqSsEQ4KYpmuuoNYK3MXpUk7tHsk1Z1QI3xXhgKtDBwN?=
 =?us-ascii?Q?OxvelE10xJN2EtVwTKGZNzX8+NTl5+6KBLfGJ0HICgXChjxMzSWI4Eb9wByI?=
 =?us-ascii?Q?Giw6Tf46GcHlYaRJypSl2TT5yC8N5WtUqe9OBRE2LydVS/RrOr8wzH8npsx4?=
 =?us-ascii?Q?5jVGgkPeC7m/zLtx057YytDbMAksqx77447JlzKD3j4edAhXft+fDmLDORSG?=
 =?us-ascii?Q?kuW+lnhkwm24NgrKYDRvMJy2KXv6KjvbAfOujSoXjoS3lilh7eWh4io2V6au?=
 =?us-ascii?Q?DFl4D29w3DcJCXL+l0pqMZnnzTPS5faX+BBD4mJKiLorPhuJ1sVlNiMJXHbr?=
 =?us-ascii?Q?ND7ThUxPWWY1hd7wL9EOc+S9src6+zIu7jhlaGzjjhF098HW5Rx8nqDKxQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 03:28:27.8374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0923d8e5-4b88-45cb-494b-08ddb91882a8
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9665

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Replace exit code check with '! cmd' and add both quote and $(...)
around 'nproc' to prevent warning and issue reported by shellcheck.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 tools/testing/selftests/tc-testing/tdc.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tdc.sh b/tools/testing/selftests/tc-testing/tdc.sh
index 589b18ed758a..7a81088802d1 100755
--- a/tools/testing/selftests/tc-testing/tdc.sh
+++ b/tools/testing/selftests/tc-testing/tdc.sh
@@ -4,8 +4,7 @@
 # If a module is required and was not compiled
 # the test that requires it will fail anyways
 try_modprobe() {
-   modprobe -q -R "$1"
-   if [ $? -ne 0 ]; then
+   if ! modprobe -q -R "$1"; then
       echo "Module $1 not found... skipping."
    else
       modprobe "$1"
@@ -67,4 +66,4 @@ try_modprobe sch_hfsc
 try_modprobe sch_hhf
 try_modprobe sch_htb
 try_modprobe sch_teql
-./tdc.py -J`nproc`
+./tdc.py -J"$(nproc)"
-- 
2.34.1


