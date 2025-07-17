Return-Path: <linux-kselftest+bounces-37522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCED6B09735
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 01:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFED81C21632
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 23:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E334246BCD;
	Thu, 17 Jul 2025 23:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="i83+F1A0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013005.outbound.protection.outlook.com [40.107.162.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E676E241667;
	Thu, 17 Jul 2025 23:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794684; cv=fail; b=GQL1yVxXx37/jhun3GgTmtpwFuGTzMWBO5+fO2B3MdeP1FnxBdaqikukyPcwrNGLaPGnPwoBaRKzTBy1g09x8fCi3rP7AI47FQ3yoGxXLU/JAGTM5+i0wMlK7KJVKXYoQXYFsYY59DdT7M7Ter4x7dQGcNGbgqVGlyiyzirMQtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794684; c=relaxed/simple;
	bh=2+X08KR2uZR3lBG7SMmOlA758TA2DBF61kuZhVSOjRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r07mGNmH4FO/m3KYATYWi6cmr6u7Ho5ekJ8424690Pw1HsQ6Fat+kasG10QikprQ/zFr/mPS4menjSkR70hB4MdY78c7Goox1yVcuq+aun5sQzXiStBBqyJeMW9S8mKg34t/h9ptojt24JAyIuPSCJxTAWv8f8EnL96HNjmMGIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=i83+F1A0; arc=fail smtp.client-ip=40.107.162.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZzG3/Mrp60Vg8abIQlyP1jSXsnpBp4sYLL95q5CHvTugxmL5cxiBmbN4r9uKwj37jubP3S4tQZfg5eHgQ5NEQ4UptZR03gIyt6+XEEb/cBIRrOpopEsgsAGNZFkvyoY7WRjUlrG+alQZEmXD2Ud+T320d1fRO80hLykwQS4VPwNYJe3ILc1gDSJFSs4OSgESDLggc4Uy7mZutb0Y+1BArhk2jtPCJylMiDEEIRi7omyK3ULFkgmfskEKKmo190MwTscjy6zZj4Wd2DEWzVxUaE5pGmr9R6fItcnAl9SQj+vmphGfFAA0in5ZOg3Txja47mUw7Xrq377udC4xjeozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jd+mGTCy4kr9sumObomQ5ywvPw4LhoiRcEi2WA0yrlA=;
 b=I+7RqVqXuvhFkkHZaUtfhwZoQlyC/7J6m9lwfUC8OGFMm1pqyuJZ3PBvai0XX/D8SRpQE6AgNe9nmdJN4LTnqc8K4SmSBsy3rWqim7FBnXCSMQvzBfyun9xC6qXOtP71GR5mEtdXdymwakMiKnyjgUfeYHVtGO4cpbpa77HKDGi3YYzrq9e2mYOrUPy2mdcE6kGq2qsckgPe1R/V6xLApdJpQPGDe55OzxOcZwo7Lo+wQT7yq6ETJ9qKha0ou193Zsc4dOKUi3jhfG9iEt3/TrjKgE1756JLWBundH595rnsFtiaP/2eDx1Rtpg6itCMlhfiRm0bG8o87qkMAj8LPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd+mGTCy4kr9sumObomQ5ywvPw4LhoiRcEi2WA0yrlA=;
 b=i83+F1A0iRLurQwC2ArmelRsGfvl/4cHM1IEBw4cPrkiApuh2wZQQWT5LuxOlvY2hOyvephSMK5by4uR6m6I13KENnT3ygVgoNffOenqpaoxYNU2nsp7ZvkbHgw17PdaAouJm+992FgVGkls6d6rlUlV1ES4PoiPQML9GpI21aiwr8OF0YSo7aezN9O/+IvqdrHjqsSKDryPAvoGHZuqk6Eawm8SWPHtpCfchAyi4BZPh8Ho0gsl4tfPw2Zo7XY5KkOG8A6hZVtha+ipo5Ro1qNOSi9AqCL5CV2xcYqUBxzbJDyZom3AaMT9wYF+aZdKlu6CoBriDAO59IRshKopaw==
Received: from DUZP191CA0012.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::6) by
 OSKPR07MB10446.eurprd07.prod.outlook.com (2603:10a6:e10:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Thu, 17 Jul
 2025 23:24:39 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:10:4f9:cafe::a8) by DUZP191CA0012.outlook.office365.com
 (2603:10a6:10:4f9::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21 via Frontend Transport; Thu,
 17 Jul 2025 23:24:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21
 via Frontend Transport; Thu, 17 Jul 2025 23:24:38 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 611BC68003E;
	Fri, 18 Jul 2025 02:24:37 +0300 (EEST)
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
Subject: [PATCH v24 net-next 4/6] selftests/tc-testing: Fix warning and style check on tdc.sh
Date: Fri, 18 Jul 2025 01:24:25 +0200
Message-Id: <20250717232427.69216-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717232427.69216-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250717232427.69216-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F7:EE_|OSKPR07MB10446:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8df4f8d4-0263-4ecb-7691-08ddc58919c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?129Z8KfbMNf0cyRt9kHt8I8QhkCYtKvuz0ouZJqC7Szq6eziX4YOPHHUK75W?=
 =?us-ascii?Q?XFS7ggKsVlgDqQZCKUWe0Ya+n7LPtKCT6nIRyUIQsSW95Y30Z03IkC15uVBt?=
 =?us-ascii?Q?7XV32fL1lJJP0d53ASbciBFUAdN5+cYe12cY05L/KttbvJ28aDd+z3IHHBos?=
 =?us-ascii?Q?1tTfRw5xK2eTH8C8dlVYvNomCTXMqckA54malpJeY4kAflGtUVE6d+wHdOKR?=
 =?us-ascii?Q?eSlntUGqpzibjGcJ0wJCcT5qLOH6syUDHfOXcINRN7ZH19ur1g2XQ6C2Ky3I?=
 =?us-ascii?Q?gtUvdPNeOuK08o4zvSZGbpCmym3qhLYz7Y1RGQxoR9mUifV4AhhQRTLmDtot?=
 =?us-ascii?Q?ZQt7h5MPUm78l+QR7kPXE6xzVijTJ6mRiW091dTNttnNnDKPtp71NXC4hYgp?=
 =?us-ascii?Q?s7dLMHpjsxiGz9G0DaHl3z0mYGwhFRZtN9ghEce7Xy/4uf6bmOHKP5tXxio7?=
 =?us-ascii?Q?67/OpDML5KAtce+wicqJEQTbCE1pQxZqTscZoc3/xShlclYbLNSPp+Wla201?=
 =?us-ascii?Q?4BwtKewBS2geFJJ62il4yWpubnhlNKlzloyPFkwQuG1/Ztgz+XvodzeGoyPA?=
 =?us-ascii?Q?mxUx6gNt4urxLr4K2rxN7Xp7+U/84H0bleTEuii7o8xxe/FtsZYMuV3Sj/Uc?=
 =?us-ascii?Q?TEqX7daUi3IYAjiwg72FP276HCLnZG02xRHBSv+azSjC+NdFG4sy2jry8CTn?=
 =?us-ascii?Q?N3Chc+UlKOeb0VQdiNy3sSY+8B2YCL977s/qBUIfLAY2EEbiUb/VPRje5d3V?=
 =?us-ascii?Q?lqI+SRLKQn4S9p4H4GNTKTjJNbL20+TT1RzvtDgvIVogz74IlNmVebbFTUnk?=
 =?us-ascii?Q?tihq97AFyf8FrfxYLhUqA5aJkv8QY6dFdEY0ux5ujNsYxLjbVuvQSh3ZsdZR?=
 =?us-ascii?Q?BtpLIUVBhX2S2DDuAxHfaUMMiSpQCewc4yGR4AQw4fgf+GrUrgCAyhR3AtsH?=
 =?us-ascii?Q?CB0j9ZVAXtHz8qjRyX05Va1C+jZAbRp2ruluDWWEhFWS4S6Qy48GzHeuba0c?=
 =?us-ascii?Q?wRNbH9YNDvs/8qIloK6T2RCyMAw2d5rMSxcoR0UqskSF0EIfPMEaMF/zNYXN?=
 =?us-ascii?Q?oxaEJe9K7rbU/0YzSMUzU3FfhZXdD4OTAOfa2rwzS5ilqXY0cIzebQTKDlN3?=
 =?us-ascii?Q?TxbGgx61J9NRFX4v7FyKMqfjPW3UvsgDOxpEp3L384VRcJqwrm6AE+G9ced8?=
 =?us-ascii?Q?9BLw/Nicb8Dh6uU34TS5choRTq8b6IqpWONzIY863hcnoUjWAq97eBkEftLS?=
 =?us-ascii?Q?Vj/vnidXaDiQpPhqWPjlE5NX3wAzj0QsOxQC8ltaSPdX3P7epGgRE7iZLw2R?=
 =?us-ascii?Q?6jLAKQDC3P/5c5yTZVEZqoH+LZ4W1xPFIOYBtdfCa15m2SmlUlNVxy1k/mS+?=
 =?us-ascii?Q?lCeHF9bZL0xT4H3Q5lgE6uCoq7oZtiUncdF/MtfrcGGDkESDH10fX3YYLxiN?=
 =?us-ascii?Q?qPgPZah3bHbVbsOw9jybywbswi1YjJ1NJzcbIoGc5rhbgzatX6L6hLJxNYiC?=
 =?us-ascii?Q?qTQvcVFjb2xIrL5ce3UZaD7mGnCnZZRWNSl+WPgBsBVBaFOB9dK8Py40Ag?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 23:24:38.9484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df4f8d4-0263-4ecb-7691-08ddc58919c4
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR07MB10446

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


