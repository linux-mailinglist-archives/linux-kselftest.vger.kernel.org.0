Return-Path: <linux-kselftest+bounces-16538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D62A9626B8
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 14:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7339F1C21327
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 12:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586B91741C9;
	Wed, 28 Aug 2024 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="YZspOejF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2056.outbound.protection.outlook.com [40.107.215.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D70815958D;
	Wed, 28 Aug 2024 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847464; cv=fail; b=qsYHo+Kx1iIPP1/lqy833x9iYW9oxMQgkT4dqKyJMXWByIdEeM0dLnTJqlCbGYGg1M8fbt3je0FvWnWCsRblyD3CHDhX8I1/in2wp96vk6/W44urACnwRCv7ceISSP7pN6tDpbICkFHSryCkOm1ij4s0aVLNuNTP1CIf8izAVXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847464; c=relaxed/simple;
	bh=tPweMOpaYw/emFpZ6oBelFEBsh8bb2X0dSc1qnaav6U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fbXeWNd/22iZ14xK2kyg0huNYgO5+qtjNZRaWrnsRF9YiTJggnJI8YeV2tLd6ZjyoxGMVCOqbDslgNTBJhjckfao6jQlP/5fgNIUAJJ7LEt9LCw2AFB0vzJXMLIXH4iNQdgOcyzkAqJxPS0CPyFV21+3jkET4/n+A2E85y5wukw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=YZspOejF; arc=fail smtp.client-ip=40.107.215.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+E/2lxt66YQMmw/vZ6Bfd+h+0gDHFzIcOO0+EiImGoUIoalNLQoVJ7v+IDaTLM1FE8+oOC2NYsxO5p6IEZ79bXm3Hvquzhy8le5dv9gvNQRYMzEw/7p+mFV0JpwVihZ7XUvGfXRYsLO9I/hfo1/IEkbfxFvJS5QgS5fsjnOXBz5Hzt9UTMNDV7Lbm2IIuX1gobFS4letbNntzoafqUELVzq24uYI+/ugv8QO8Dh8F7YEMzu1FXi23FL1EA8OSJjtTCrasrjw0H/Ts0SoQNeDX7TlP+Eo/m6518KemLMOY781e4MOHLVe0GTc5fGwz05DlVZbBoCDWGKAt5znu/V8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mbxgwd0UgRIDMi3eAhR4Dzg6Go3d7qGQZe6vn/ZonBc=;
 b=RK7PvN9Q9yFoNg/XnP586y1y62qVj3gp/xTKkKoIKzMtlxP3j+CUByOUfBCHouSgqZVXp5cJltQQ1Fbgt+Sk2+6v+lMtBvrxhLlZ1s98laxqHzl6bZ8nFCj+L7ibis5mAOBRHucYUys63R2J12L7f8zz3xT3L6SFdE6f7nF9SXrZwsuAqrfFguHeabDB9f8kNb4BzIG4tAV/kdYuV295dUX4xlxbm4mVOOMpJs7ZZlGhAaordJOS5N4ieXzxfuXafnsJn0prh0JRmeEal+hQTUXd3O+6GBLZqUyk+97G/mr/221GfbShZa/0brwAWmPC0VskVfHUE5kgy5HNY7s0ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mbxgwd0UgRIDMi3eAhR4Dzg6Go3d7qGQZe6vn/ZonBc=;
 b=YZspOejFnWBodZq9q6YRQtz17JQeNtsGox26mE6tC0yAy21IU2XvrHsYef0dLGACYyfARwyj3suXMFEgp/mRvGkUEgkn0r+1JjMyhjvg6tZV5aNzzuQS4R4af7g1ekyhNNcvxyHEXtwzlM/Js94TIJEdifBRrArhbEqknSpuypino3fGtKRQclsvL8H3sIJgsT7WFLaZYGx9j5OlBZXULyDVxlRRDPN8iFbLWbUxfJGTAzbIstbTTxxXqunSv0nrEIp5q5OJKO8luUYu23dSuVzp/WFKbOJBXIZ88NVQrOgEQZ2DbhhpLnam4ODGoLV3tTqDCssgyuNOGCA6KaaRng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB5913.apcprd06.prod.outlook.com (2603:1096:101:da::16)
 by KL1PR06MB5884.apcprd06.prod.outlook.com (2603:1096:820:dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 12:17:25 +0000
Received: from SEYPR06MB5913.apcprd06.prod.outlook.com
 ([fe80::f049:a716:8200:c4a1]) by SEYPR06MB5913.apcprd06.prod.outlook.com
 ([fe80::f049:a716:8200:c4a1%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 12:17:23 +0000
From: Lin Yikai <yikai.lin@vivo.com>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	terrelln@fb.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	yikai.lin@vivo.com
Subject: [PATCH bpf-next v2 0/2] selftests/bpf: Enable vmtest for cross-compile arm64 on x86_64 host, and fix some issues.
Date: Wed, 28 Aug 2024 20:17:04 +0800
Message-Id: <20240828121706.1721287-1-yikai.lin@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::30)
 To SEYPR06MB5913.apcprd06.prod.outlook.com (2603:1096:101:da::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB5913:EE_|KL1PR06MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ae1840-4b0d-4926-d513-08dcc75b5f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GclrOnDFokH740qwnT2vIzZCoprYFEIqDlQlkg91GB47JKh0n1wTP2V2Qdsm?=
 =?us-ascii?Q?mBNYIBx++Ya4qBk6IO349HFgvuag5/lFC1K2m8juVXn1R6+I4c6nhMqbedBT?=
 =?us-ascii?Q?CZpIB4x+s8Hslb7+9VRhEKmwIRWwHsW1C+nwjAegap4xndOsygBKcrq1ckxx?=
 =?us-ascii?Q?wvQVCthF7txcnlvE//JIHfTBsDy4T2KGHt7ts4AYy5RmVaHS0TKnFyVqoxa3?=
 =?us-ascii?Q?glV7ODVOJJBDcOLo9bAgPvdcvEeVcwK0DNP2WKj8Xf+vYXJzaNJFUJ9ypYp6?=
 =?us-ascii?Q?DhzDK89Nz2QYTnBpJgUx3iMnqZDS27a5V1aOtN5qlUiL+ufR086z6AQXO0aJ?=
 =?us-ascii?Q?3qp2CzV7mDBDcLkt0uep71kFoQtnLAw7VrkTdK3BLDNG9+Vy0iDYBXD6CsbK?=
 =?us-ascii?Q?U0ZSZq+TeGXXFjfSzwv761piok0fxuBgib8ipJAnjjto7q3QyJkXGSMmFpNi?=
 =?us-ascii?Q?lUMaZkAUO85R8OzeoshofclHQmDUCx7i2eBtcKkXufh74SPZuBSUUqiKu9mL?=
 =?us-ascii?Q?rxpm2MRH+sOkl7LBgZDMfq6fCdqgSGX9ASbHmz2PM1ukBnzsRcalk/sT77Dz?=
 =?us-ascii?Q?o8wKTLY0VU5M1VKsylqIX30r44DPTmU2G6kk/EhZ6HPSd1fwevpCyWwyH9Yg?=
 =?us-ascii?Q?tAWmxLpp0B8+THcgwM73ezvFjYfpEEHnLe+vLVky+LYfERsPw6VvAyNz9cwW?=
 =?us-ascii?Q?pT4rH+TpRsUvIt4VrCmtl3hon6z3q+F28MDDrMhuzTZfovZkHw9LajhczaYA?=
 =?us-ascii?Q?5nmsftC71tCdXA5QrXJPcOogiF9CWrG99ItBZ+7lPP/OIcbL3+faEY9Gr77Z?=
 =?us-ascii?Q?o8XkvcxbqbB2J+fVCFRch8YGBOUWeyGIeaCVEEbjU8urvyVDuhf87D0tSHHH?=
 =?us-ascii?Q?zqgXNSKBpZ7d4G2HRSJ/HpufALtC4Wkt3EzO2jQj49DDh/RstQQlvF9vrXss?=
 =?us-ascii?Q?8WkzOXTPgqe83y7EdyXY2/vmUEMcLP9GnC0fkA7Qgr4Dn33OCj5MH87tbLU8?=
 =?us-ascii?Q?s0nl25+deHEylQ928O+Q7CkMh6/nNUnfbUBDDgY51atSFSeyiwJDf3i3aq4A?=
 =?us-ascii?Q?VQUyljF+lhWE7PowO+MmKtWMleJsUEpjNwu1bDcR8QQ9ZcKdgqCEnUDIUgu+?=
 =?us-ascii?Q?mdd87Cm4qvxfTLTKWBYyKopVDHl+gbqChUx6w3RahOA790dmpdYlLJx/qrwG?=
 =?us-ascii?Q?pbEwUI3quKFHJ4FK9oN3+TifxDBCyIOttsOqfBDg3NzG52uBBz9yToipeC2X?=
 =?us-ascii?Q?xpytThN6QS/S8Qfujfnajq4XEPvxOZmp7gvteI82YR5MkHWunAgUkF/vzP4Q?=
 =?us-ascii?Q?yHyOLs/m2wkPSmTMHxvzkILtWA1DS9nbGi4Ol5onzH93dV560Aupxxi3B8YA?=
 =?us-ascii?Q?oiKNPEJLMYernacr5SsrJFwVOWIO8iKSMPy0PsmWx7bHe3B9ug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5913.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t7wDCUzodIxt9IzwxtmjkrQdTZNMYm1FBCmO8WBD7qUeJIM/cSCDKFbc/6bZ?=
 =?us-ascii?Q?KNApet+4NtXDHPb4hrXAcXt59sqNWFoK2aOI5iHVUMUMzqikaZFu41blFvEG?=
 =?us-ascii?Q?9/W0Ayggwp80REguHRios7IdBLYJCpMOtCGT3BelBgRFzcTCG62BfKZfQKxY?=
 =?us-ascii?Q?jfCBYLeopOJErwIOOz7xflBrM3amnSnqwzkI0AWA5kLRrMA/2irczjZs6nOd?=
 =?us-ascii?Q?dX3NYJp83QxUB1Olw/4zXUKJUdjF+i9KTEwmGXXp2YAYPtGPSVPFaZ5hdD4y?=
 =?us-ascii?Q?PGRNWQXuFpYpZXdCpwH3c2ZdotnA3GJIz3UVRSlKwmMNG+EM/ZslnQ2c0Qys?=
 =?us-ascii?Q?DfoN8fhdTNbTT7XPzFVQaznxizQm9BppYtFApjrcpR4sFrGmEHM5ReagpU+J?=
 =?us-ascii?Q?zKQeL/vJx/C6+f39vqpLXq+0p16CS3x7T3+QcUG6IIgHscKEZJsoNyeRyYpq?=
 =?us-ascii?Q?FcleHcLcyuGdu7uOd2ghCP5h7k667Yd6Tr5EHQUL7PzeF0QaWVonyVmVNWJf?=
 =?us-ascii?Q?6vtJvf+uaDoN0I856iPchxem/6IjE0mF869BdIKHIaw5d0pi9Pk2HgKBkIAH?=
 =?us-ascii?Q?ABRJfi6XzdCrFavCSMzLyIDKrZEGv7e0vy25XrMpVyd+ZZHPt1Z5082PTaBN?=
 =?us-ascii?Q?tCyA+gTGYCzpqtg8De2haVZsKU1tUEpccWJQXT0zdz0r6wMOOBIHotWmGoI/?=
 =?us-ascii?Q?TkS93Tm6WvZ2VfDKf6GhrJzTBFWMycJgNsKjzqKajEQHautFv8C5jtEwYO5q?=
 =?us-ascii?Q?A1kyZxNbP3Bv/xsSSnguMRn64AtLvAfNv9t8huvIAkqY3lthXlcaX0S86T11?=
 =?us-ascii?Q?iMvMYgwf98b2Z08RaeVTe1vzU+w7cfCAgBFUgbT4FehEOlzq39KqRx4AFPeY?=
 =?us-ascii?Q?cu7Dz0xwfrqINDyC6qvWbYb/JmVhwM0XTEqvYcqVVBSV4oZAyHqBUiswKjcL?=
 =?us-ascii?Q?N9TxI5JYFjBCY7i/mgevel9NOTMcLlrknqD9cGNwyM2MQ1nwtlB2LL1nXcbW?=
 =?us-ascii?Q?vKjQFAtPNhqNSufuJOx3I2ot38fNsOeLlYeb1DbGaC2OCVdK5/lsAr4WjweF?=
 =?us-ascii?Q?I0Rxo/8ameDC6yFsYIQc5cJe6PoLyQtSmbVbjJ3YDApx5LeC8bdsHd9jfviF?=
 =?us-ascii?Q?t5nBc+SPaea/fSvW9TQMwqb7/JF+YP+51H3tQj4U6CSNGux1it2W0L6IHVsE?=
 =?us-ascii?Q?LOQ+s90KEiuqCcuHFCTlpAHez05HmJPPPkWRFvPTTk0xEisIJaK5oaPFt+oN?=
 =?us-ascii?Q?X3ib+csRpi+g77dLiNtS4s4eV3Q6qEyYFyiUeQCjXJJJFHhezawUEJ3d70yI?=
 =?us-ascii?Q?Vu6M1YHxV05h1ng7ak3JUxkZBFIn6jv2RzYRQGyPULPjuRdmEqcWtto7ZuA2?=
 =?us-ascii?Q?JKuAcITVKHHWsg2b3KLYr1Ys2Ep17x9frG3D8J/bE62uiRbDhZpQHH9YTaZ1?=
 =?us-ascii?Q?kuQyHyeXifv1AbIGd1SOsOD3w1D3wBbl9WNk80X4EHnev6VdL6b7ZpAcmo4V?=
 =?us-ascii?Q?3a24TSCAfim32WzRrbto7VGeSDiJNSwgXl2opYxwplkS2aYAqNe1bteQQQJ6?=
 =?us-ascii?Q?A1HR0AAess8/uCGmhxg14VUQWEsdzA5+eYel4Lbi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ae1840-4b0d-4926-d513-08dcc75b5f45
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5913.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 12:17:23.7361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gBBbMFaSzo+tp/jtIA+bZo0MuTLIdolbOvvvoCAuP4oXij7+RnJPthJBQuNV/i2uMMKfoeWMYCgNC8HuSosxJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5884

These two patch enable the use of "vmtest.sh" for cross-compile arm64 on x86_64 host.
This is essential for utilizing BPF on Android (arm64), 
as the compilation server is running on Ubuntu (x86).

Following previous guidance from V1, the two changes are as follow:

V2:
- patch 2:
   - [1/2] In Makefile, use $(SRCARCH) to get target arch's uapi.
           Therefore, there is no longer a need to compile "make headers_install".
   - [2/2] Regard "LDLIBS += -lzstd" as a separate patch for static compile.

v1:
   Link: https://lore.kernel.org/bpf/20240827133959.1269178-1-yikai.lin@vivo.com/
- patch 2:
   - [1/2] Update "vmtest.sh" for cross-compile arm64 on x86_64 host.
   - [2/2] Fix cross-compile issue for some files and a static compile issue for "-lzstd"

Lin Yikai (2):
  selftests/bpf: Enable vmtest for cross-compile arm64 on x86_64 host,
    and fix some related issues.
  selftests/bpf: fix static cross-compile error for liblstd.a linking.

 tools/testing/selftests/bpf/Makefile   |  8 +++++-
 tools/testing/selftests/bpf/README.rst | 11 +++++++-
 tools/testing/selftests/bpf/vmtest.sh  | 37 +++++++++++++++++++++-----
 3 files changed, 48 insertions(+), 8 deletions(-)

-- 
2.34.1


