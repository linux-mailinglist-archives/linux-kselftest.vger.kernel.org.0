Return-Path: <linux-kselftest+bounces-16400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4470960C5B
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 15:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96431C2305D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 13:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB241C2DB6;
	Tue, 27 Aug 2024 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="AyFtduH7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2087.outbound.protection.outlook.com [40.107.255.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA431C0DEC;
	Tue, 27 Aug 2024 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766033; cv=fail; b=bkAoKzSsGqiGJNzU5ek17VLDjqN5VTwSf4AktT9aDA7j4FSh5zPYcVzZVFuhblZK68p47oSvqnw2PP/ehRpJ3rB0KJOZX4aSU6CXpM5ipo1CWhBvXjZvSYhLkSfRLHgCcQyWKzLyUqhQA6yP9pz84DrGV824yJY0PI7D0O+V9ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766033; c=relaxed/simple;
	bh=nXfbON76y8qaKlAOQIBOoPq+3UkB6dbrg4rJdq5SCVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EGDreIda6sG6EMj/rs0Yp64LIDlXbzK5xjOeOeUiRQoNRLh7Uz1U981qtpOTID0pmx182jVuc+geeZVIL3GhERBbZFa4HKFaJoOrBWqVNFYmuRXpOz0K34WfUCvanOyZFefUhfX8AJJaafIEHnn9zI2750HYtGVcbJXPAJaz3Es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=AyFtduH7; arc=fail smtp.client-ip=40.107.255.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=boZBeOZRyiCq1zqnPUlrO333U81wHGakbw1K0cgO4K+5cDrPRPFUOkeaNdktyN45SXGtHKL+3nmNzG1gyfJGL3dP8NUAYpAwC/S1FOIFjhnx0SCjO+VMm96Z9WG34gEx43Zy0PAplPgdbb3DtSE/l9w9vHuJ9XcAYWT2c29MK67eAt9MKmlkkh+4VCvAw36d2NSDsBQLRfj+OVj3GYg1N6V6Z0ADBX2vttW67LUVyoH28Lc+Z0VgFkQ287fJ5BbLk4RZznweuiGR96Ay17fm9oWS5lTGI6Ex+1GnohHPI5fA4A6OlDF4vYJsGsDe3qIzfH5RMzu+Prh2PPNf+BDFRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woPyhG9zeCpJnOQ2526b+B6SPQo5v7tKR8fEUkUxouY=;
 b=FY3Zf4rx6XwxZesQlSrWobuPmEVWsCAL6Fqz2ck6AIyzZgEnmh1tE/pzir6wrl5jGXjPfahG9l8ImBY68RGFSa2QpvncwpErn+lNyXYRQI7GbHQFhrrqhmfRxtcRm+UEGOpPr+orUz2aMfBvcPybD5G7TP/wiz21bBZaCMMOn5HaCYobBh3xm99pigLpwJXYyY1IotpR1q0HFag7Wja55fGxsCD3zcqxVuOwH/h1sBgDTeuMlpQgysPGcKO8sxZRmznNqjmGefQ7ZaW4FNgjc3T1/WNcGJNHILzgIfZQOZ2uj3tRbdL0nKcJY/TKTMNjk0m/XFSgUNsg6fAxMih15w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woPyhG9zeCpJnOQ2526b+B6SPQo5v7tKR8fEUkUxouY=;
 b=AyFtduH7Cy/Mt44RkstKNplV7LtFeU2LuMhE9NCUWU9kSy1PtVvuijicZrlfUT4SzBH/65NyDb2nZFw5e8jWxmNhcK7o9Kl0cbT46STJ3dgqRRZVAjZbeuSCuBRFY2l74CMtFyUR7ivvqFZoL2yt7p/1LP7UriYm0AICQ9ZL3Zm4tTSwSrpPpEXZSJc8IqpKyeihn/Ejl0ed6NbJ3ExEyZFen00aK5eMpNJcy3Dpa5xdyKXVXHneuLie73hMqVgmXqf3urv3fjv2sb2+mDS24YeFB5dB2eELlM50vaz2sW/3zb7PGDNTPdccWV3nDotMiN1gZJCIT5Q1QvFe37TxYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB5913.apcprd06.prod.outlook.com (2603:1096:101:da::16)
 by OSQPR06MB7153.apcprd06.prod.outlook.com (2603:1096:604:298::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 13:40:26 +0000
Received: from SEYPR06MB5913.apcprd06.prod.outlook.com
 ([fe80::f049:a716:8200:c4a1]) by SEYPR06MB5913.apcprd06.prod.outlook.com
 ([fe80::f049:a716:8200:c4a1%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 13:40:26 +0000
From: Lin Yikai <yikai.lin@vivo.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Nick Terrell <terrelln@fb.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	yikai.lin@vivo.com
Subject: [PATCH bpf-next v1 1/2] selftests/bpf: Update "vmtest.sh" for cross-compile arm64 on x86_64 host.
Date: Tue, 27 Aug 2024 21:39:58 +0800
Message-Id: <20240827133959.1269178-2-yikai.lin@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827133959.1269178-1-yikai.lin@vivo.com>
References: <20240827133959.1269178-1-yikai.lin@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) To SEYPR06MB5913.apcprd06.prod.outlook.com
 (2603:1096:101:da::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB5913:EE_|OSQPR06MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 75e242fc-9798-41da-98ce-08dcc69dceb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lyBmDDofcy3uS94w5/wUM0M12JCYOsXlHHktst7fLH1wnXgu3kAv807Zy2N6?=
 =?us-ascii?Q?YPIiMh0pPFtDcW1PTJ62cNXTCo0nvQsC3Ky64nNp4qOSRidLyF+C14PxLDzG?=
 =?us-ascii?Q?vjy19VAenW6U4BJMcRxQGopxni7DLH8/0gyxzPGoG03PZrf9sEukYwjNfqDO?=
 =?us-ascii?Q?sQ4HRJKfyWr7gjxsDVX4u/NLeiCXUqUdEcl+4XRrGdoZPGtGYR6XKtXhs01Q?=
 =?us-ascii?Q?upnd8+1Guxdmh4lVGdpDxvoZys781E59f7AxORXeG3E6lx4LPL+1FrNkvtKw?=
 =?us-ascii?Q?7HnSE+SlMD2TU4A1DREfRLYYF543E5UY/vN9cLM36EZL2dSxkHRUSrbJMQVQ?=
 =?us-ascii?Q?RGlzHawJSFLle4ulfFkZQ0KA2Rh5dQi0D7ltB1ug77yYKDbgScbfrKvPnrmV?=
 =?us-ascii?Q?wvsO0nWE4Lcu0anCrRAxHMtauFTpvY3HYoP4+CqX2i66MsFIvbOp4QX92+mn?=
 =?us-ascii?Q?hXSM810rVZZl4PS3jcfj65760ar+CmA5bVyq9Oj3BV8+dQYbnHvzqDZrPebP?=
 =?us-ascii?Q?zCIR4vmq2lY8GtsGK2asAQavCLkV2UMAzIs4YSq4ugaqbEFKyDvNZXcvtxTa?=
 =?us-ascii?Q?7HY+PO9jmZaOZRqhfYuavTcI6XyebA3avAGu4qPEPgJN9sQh6Vk8mPh4s17P?=
 =?us-ascii?Q?bJzEvwStSva+oRSHb/wIVwe1aOS3XX4Lm8Tf+pAltukKB4lTEZZT7tnsmKbB?=
 =?us-ascii?Q?bhwwkkcxIaqsHCVcKAjRy00FV6F4hsFEwNDHgysE6e9cMzVbExSdZAMst/Sb?=
 =?us-ascii?Q?zjvwSHsjunHsPZ/dT0Lr3yv/j6BlUJ6F7RMIrr621IRbZtEjE6Qme1BHZ/Zm?=
 =?us-ascii?Q?dRtM90WP3HoSvERD9eUsfOJUPfZPLgj5rbd1T0fnRG9Cr6um6LgwB79vhssV?=
 =?us-ascii?Q?AAeMmgEbVwsW8CQtDX5ycekW/EXsr54Mx6g9ir9kbNSmo0MJn64BgJou6Hqi?=
 =?us-ascii?Q?1Xd7VoGI0fURRc2s20NOhnp9a4VSpezl60yE5r5qL2GUjMIOlJ3yj0uW01Py?=
 =?us-ascii?Q?aY4ULXasdBXwoE9OdtlnnzqBTOUVKK+ZxmTnPtGhP0cbjbxeLxoHsOJrKa0U?=
 =?us-ascii?Q?Ux75uOtO+qS771Nx6++oBBATnBVvklir9qqdlugVsp/0gFqgolooy+/Ks2gp?=
 =?us-ascii?Q?yGrdnFszcH0DxiV784zdbjFHe+60u7mv0V4Kcun1Owx4c6NS77KDUbhxSRQj?=
 =?us-ascii?Q?0cEFGITOWV1+CPi9d5Iipn06QtaYhyo26VtUawZ9mNAlZpePh+GtizBabPss?=
 =?us-ascii?Q?EkIMdToEGwrFDJ40/N6BWCSVDVXXVULioi992STVe+FUc/pC0NrASKI8HwFK?=
 =?us-ascii?Q?VmkQBhnaCx6T7QnAvc1HqM2FNaqXUhE3d8pNoy9WKUCLZlHdhZf0lzS//EDn?=
 =?us-ascii?Q?EVPTl4E1ELAV+x2SBJLlp9FWWk1P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5913.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?utaaIGpUnzyKdQgCmsoOJEaBTHfdMSEdHrmn6VPsNFTt9LW6Rk7dRgsai7xO?=
 =?us-ascii?Q?bYWtN8/ejo3NNCuk1QpWSlBaIunMwGQ16mVxISdjPrmUy6hqX/J0P1D/Athw?=
 =?us-ascii?Q?ZuB8/4Kcy9axBUx0BytogYZpzFfrsYiQcGfgu34CHXO2soFVXRcYQe3sLYi3?=
 =?us-ascii?Q?vpKcrcmPSlL1IPDImztdABc3V25BMY9AIhVeJMi4ap4HZNOxh9cjePbXH7eW?=
 =?us-ascii?Q?CBuzzwWJ5z5DKISQYA12n6wRUnHSf4A5HFz4cd5q+uyJCXPgGO46iqQ/UAg0?=
 =?us-ascii?Q?AHqXoXt8nMn52IIbH/XgWFAQh7EKMr97/OKhatE2vIsb2t6CLmfaw3RKezkB?=
 =?us-ascii?Q?yOGzWsFTDMZ/NMwur/LSXslklgGbtroWBg6VMo18ZM0yrFXiTY+WNpMSH3xy?=
 =?us-ascii?Q?OD6o8X00HrXU82XEnY9vuqqhSeTfW5V+mlGweRwhZmvPcVB1A7mfHqZYgIs+?=
 =?us-ascii?Q?ewQKgIYLXWEREIC05Z5HVfir3G/czFQK6CjTkvH/UCoV3KEbCg0hilW2ZIpR?=
 =?us-ascii?Q?cjiWRowxbK1omwpKDHh6m8MkNbI73kpmodXKdNsJtKlH+giInxdRRZf4IpO/?=
 =?us-ascii?Q?+ctywUA4R1jAKSANgnWIchDMZzkjsS42wF30wG5bpO0njKAxTuUTzsWDnK7e?=
 =?us-ascii?Q?AVsHW+AhQCHQZ8FiKjXZBHZWKf5GLNaFL2IZXmI1LmGGwqTtm5+XoYMFGb/u?=
 =?us-ascii?Q?m1p2EqM4mypZHpz80Ibto+86rAOxbyA5+oBo/n8WFTpa7gffDoJLwqV73S1I?=
 =?us-ascii?Q?kgdFoq0wYpigwdAzjB98R6C7uMvDXVc5ETKTOtVfl3sXKhCGzvNN1UTgYtj7?=
 =?us-ascii?Q?Z6y1Wz76P/p6NH9V3sOo4C1vLK3rp5pxs6dfxsKGUdCdGh1kXSsftUU5Ajhd?=
 =?us-ascii?Q?Zri28P2CpsYoq5omfD7EWxwuc2gw40SS1jPmFvfn0JrOQ9DMbUQoQpONLCsC?=
 =?us-ascii?Q?fq6WF2nyIBIj4LXBAZqBey+MNdDsM3YVBCSwpoFOKLx3oGmmNybZIPtUBfS6?=
 =?us-ascii?Q?4QUQ6xZBp0YbEF52rVYXfbrxEI1Yc6pkxd/UvXe97tP/3aw9HpB/Gb7iyNmV?=
 =?us-ascii?Q?hibDkBSpLq/a0Z7MCV3oSNhqa2hWG5yxQ2H1nGEa4puBzbBSaBc+C83EV7lh?=
 =?us-ascii?Q?piayNcVTXY7w+uPP8vY5f5Vlv64FbGFhEWolVh3xNL+C2f2Y9znOYAORl6E5?=
 =?us-ascii?Q?qiEPinywpA5rhGUEHjKxUIQpQbAx9Hh1nn2db/vmEy7XXWD2Ct3MLlBKBbyw?=
 =?us-ascii?Q?h2exAHrYRL6Uu2IpIXKkgpT2BO3ZqrTJeHB2HGAb7LORP8W5vJ+CzQ4MnXyb?=
 =?us-ascii?Q?jcDuT1W0cd/5PsgYrJgJtGFs/77EZHmIoW/rGxY7ocsR+jzaNd9veOmE2eSh?=
 =?us-ascii?Q?JqmQobiMCWUxpRzz8hbGm0bKosio7YxTRJ075miNGTvCmkTp8cPIQVrIvmZ9?=
 =?us-ascii?Q?47oVusf4RdgYgfXU1EEcsLhWtEl6Vv7EXFy0hZuXZuRp6wPOxVLwby7I0mtR?=
 =?us-ascii?Q?//RQMUZ09fhU0CU4MeZiSNpNKMEFMLkowlN6t+e78psYS3TO4BPKCNjqslqe?=
 =?us-ascii?Q?u7m6rp8BlVxKQbceyKgJZv04AcklycZ9wIoX7CLY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e242fc-9798-41da-98ce-08dcc69dceb5
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5913.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 13:40:26.1533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DgkAcrb6wrx/y+NHYBwC4aTDOq7ejxndjCpGHX5y4MXQGenUbts0bfN7xFbh/luzGNtTU+p6yi549bdibwfOSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7153

Identify "$CROSS_COMPILE" to enable vm_test for cross-compile situation.
Additionally, use "-cpu cortex-a57" flag to accommodate the majority of QEMU CPU lists,
avoiding using "-cpu host," which can cause qemu_system_aarch64 start failure on x86_64 host.

Signed-off-by: Lin Yikai <yikai.lin@vivo.com>
---
 tools/testing/selftests/bpf/README.rst | 12 ++++++++-
 tools/testing/selftests/bpf/vmtest.sh  | 37 +++++++++++++++++++++-----
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
index 9b974e425af3..c8e6eb8f299d 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -79,13 +79,23 @@ In case of linker errors when running selftests, try using static linking:
 
   $ LDLIBS=-static PKG_CONFIG='pkg-config --static' vmtest.sh
 
+If you want to make corss-compile, such as compile arm64 on x86_64, you can try:
+
+.. code-block:: console
+
+  $ make headers_install
+  $ export PATH=$PATH:{The corss-compile's path}/bin
+  $ export ARCH=arm64
+  $ export CROSS_COMPILE=aarch64-linux-gnu-
+  $ LDLIBS=-static vmtest.sh
+
 .. note:: Some distros may not support static linking.
 
 .. note:: The script uses pahole and clang based on host environment setting.
           If you want to change pahole and llvm, you can change `PATH` environment
           variable in the beginning of script.
 
-.. note:: The script currently only supports x86_64 and s390x architectures.
+.. note:: The script currently only supports x86_64, s390x and arm64 architectures.
 
 Additional information about selftest failures are
 documented here.
diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index 65d14f3bbe30..c7461ed496ab 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -4,11 +4,11 @@
 set -u
 set -e
 
-# This script currently only works for x86_64 and s390x, as
+# This script currently only works for x86_64, s390x and arm64, as
 # it is based on the VM image used by the BPF CI, which is
 # available only for these architectures.
-ARCH="$(uname -m)"
-case "${ARCH}" in
+HOST_ARCH="$(uname -m)"
+case "${HOST_ARCH}" in
 s390x)
 	QEMU_BINARY=qemu-system-s390x
 	QEMU_CONSOLE="ttyS1"
@@ -32,13 +32,38 @@ aarch64)
 	exit 1
 	;;
 esac
+
+# process CROSS_COMPILE setting to enable cross-compilation
+process_cross_compile() {
+	if [ -z "${CROSS_COMPILE+x}" ]; then
+		return
+	fi
+	case "$1" in
+		x86_64)
+			#Cross-compiling for arm64 on an x86_64 host
+			if [[ $CROSS_COMPILE == *aarch64* ]]; then
+				VM_ARCH=aarch64
+				QEMU_CONSOLE="ttyAMA0,115200"
+				QEMU_BINARY=qemu-system-aarch64
+				QEMU_FLAGS=(-M virt,gic-version=3 -cpu cortex-a57 -smp 8)
+				BZIMAGE="arch/arm64/boot/Image"
+				echo "Setting VM_ARCH from $HOST_ARCH to $VM_ARCH as specified by CROSS_COMPILE"
+			fi
+			;;
+	esac
+}
+
+VM_ARCH=${HOST_ARCH}
+process_cross_compile "$VM_ARCH"
+
+
 DEFAULT_COMMAND="./test_progs"
 MOUNT_DIR="mnt"
 ROOTFS_IMAGE="root.img"
 OUTPUT_DIR="$HOME/.bpf_selftests"
 KCONFIG_REL_PATHS=("tools/testing/selftests/bpf/config"
 	"tools/testing/selftests/bpf/config.vm"
-	"tools/testing/selftests/bpf/config.${ARCH}")
+	"tools/testing/selftests/bpf/config.${VM_ARCH}")
 INDEX_URL="https://raw.githubusercontent.com/libbpf/ci/master/INDEX"
 NUM_COMPILE_JOBS="$(nproc)"
 LOG_FILE_BASE="$(date +"bpf_selftests.%Y-%m-%d_%H-%M-%S")"
@@ -109,7 +134,7 @@ newest_rootfs_version()
 {
 	{
 	for file in "${!URLS[@]}"; do
-		if [[ $file =~ ^"${ARCH}"/libbpf-vmtest-rootfs-(.*)\.tar\.zst$ ]]; then
+		if [[ $file =~ ^"${VM_ARCH}"/libbpf-vmtest-rootfs-(.*)\.tar\.zst$ ]]; then
 			echo "${BASH_REMATCH[1]}"
 		fi
 	done
@@ -126,7 +151,7 @@ download_rootfs()
 		exit 1
 	fi
 
-	download "${ARCH}/libbpf-vmtest-rootfs-$rootfsversion.tar.zst" |
+	download "${VM_ARCH}/libbpf-vmtest-rootfs-$rootfsversion.tar.zst" |
 		zstd -d | sudo tar -C "$dir" -x
 }
 
-- 
2.34.1


