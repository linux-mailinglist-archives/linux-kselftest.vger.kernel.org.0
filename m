Return-Path: <linux-kselftest+bounces-13881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A43BA934CCE
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 13:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F281F22DA7
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 11:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3B013AD12;
	Thu, 18 Jul 2024 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jLQsHj7h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2050.outbound.protection.outlook.com [40.107.215.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3CC136E0E;
	Thu, 18 Jul 2024 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303588; cv=fail; b=n2+gtBIikeaiVpTVSXJqSpoJMb6fXFcFES8oXd+RTDerN6xr7MDV6XZHrHRLP9IqoPtylkN8p/8jzRiMk1uu3Sre3HNxSU7OGc/yr9P5Q0ATs9seZrb+aE4qrv/M9ASI5RiKdc/jOHH31fSvCkU4sYRjguAWAplJh6dV+JFzW+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303588; c=relaxed/simple;
	bh=AmacMSQYZ1CIgXDwF6411MztTDsZbl53fFoYAh/Uh50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ONucHUaYaXLM39i2YrQkQgAiwj15jIcPkTFXPaGTsZNn6KNTSSp8Fk5IVCDTdeaTL9DlHUiAoGENpiWdQtOO7sW+3+lnuMuN5MGZRI3da4NgiwLpV60piOnwoo+UuGTNSLbV4ZdX0VzB+t/OMqmTa04RAaY5p0kDfuSBYkXTfmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jLQsHj7h; arc=fail smtp.client-ip=40.107.215.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtX7tUQM50yQanyG/rM8tta4MDJGa5iIQKlLkmlyInC1SePEU7EG3DPI/TA31sLODfdBbbwo4VHSNvFU3+MIPCc/vyECmlPn81sw5E2H1in5TY0etnvxOna7D8zK9AVAL64HXju2lFynNdJh1KfPA0FkKXlO1eA3WT/JB+8tGimPTrLNKvhQuaW3CfWLo2Qsd01Y9BIs8wyu1qhncV6Y1ufz7RJuJLsXCp5B5TIc0+6eqV0tZI4BGtjFGAey5OArhnTeBcyrlLxAOMupcx7Vhokg1oUXlUZ2ErNUKvelSd8LjPe75sDEh09yYpcE8bWi2IYfLjf479IhXJePsK1dSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMgfvdG1IZifbSPrt7P8WxcsOKbDbgQXUspwl0xYOhY=;
 b=RFv6qdvagVXv1S+L7X9RMP/Esf/AP97lq4o/yqdsY7Bj3x2uOkJV1GBT819GeI1UGdgu64kZ0LZhQd2qa9hp94UWs/8wvQ0tihTQnpvzW+pgkcVWltzXPQ4361VfJ1NUZU9eM6X+ycJpXZse2/M/h/rYsdgyQjBrHR1Z1/PGa6unDR0924vmSlTuciNkEHV3epJGGiuBZTussUxjrTSR2vDMRc32Awuw355Xd6IHVNuVIefNNVEaUWgwHUK+81B2YF19WlEdZ/0SZcJL3Zq5haK8qROZrMcGQI1LgQBHexcKIucHUxLA4jm586QEASnmdpLDkGGXq2xvsQUOICFIRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMgfvdG1IZifbSPrt7P8WxcsOKbDbgQXUspwl0xYOhY=;
 b=jLQsHj7h/GlU9EkqV5lU+DK9dWM2pXukFU5foaOLIuC8Z085Xh5OIc91cvyU53USlZN0HEkG8KZuCpjhWsyh4dYmn1wZAUIQeAg21FBJDgcD1jatpwwN3Nfk7Vl7RVnoFodGAFx7p32kah77Cps7Hte46YMB5qRNi/cJq5MhAcd3Hp+yBbhPEJSX1yatXbCyry2W2a1yJAlt22/7LOfMcw+7wHDK7861SFvo8oz/HYsApksDaiMK7QvNVTRLf5hd1B8UVpu5QNxHw2Z8Zxzv/OOgxwhRnf39kbKxckcklv4K145aV5yvDZQ+bXj5L79xmFniUScnirZy33v3DeW6/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB5913.apcprd06.prod.outlook.com (2603:1096:101:da::16)
 by TYUPR06MB6219.apcprd06.prod.outlook.com (2603:1096:400:352::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 11:53:02 +0000
Received: from SEYPR06MB5913.apcprd06.prod.outlook.com
 ([fe80::f049:a716:8200:c4a1]) by SEYPR06MB5913.apcprd06.prod.outlook.com
 ([fe80::f049:a716:8200:c4a1%4]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 11:53:02 +0000
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
	Matt Bobrowski <mattbobrowski@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Lin Yikai <yikai.lin@vivo.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH bpf-next v1 1/3] bpf: Add bpf_file_d_path helper
Date: Thu, 18 Jul 2024 19:51:43 +0800
Message-Id: <20240718115153.1967859-2-yikai.lin@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718115153.1967859-1-yikai.lin@vivo.com>
References: <20240718115153.1967859-1-yikai.lin@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To SEYPR06MB5913.apcprd06.prod.outlook.com
 (2603:1096:101:da::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB5913:EE_|TYUPR06MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: 615feb20-b6cb-4ab8-8f10-08dca7202d7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eH3bll8Q1auprBq9UcTe8xtc2M000lp4VLch3iOwskJTW9MsFrrbHJUFRMzO?=
 =?us-ascii?Q?GrdOV1S1DAhj65Lgo9D1SqNwcL/JdDAtvoOJKp49QqGgOYssJOgJE7UgsHgY?=
 =?us-ascii?Q?6WB0p1vDqGxMsg/v4C2BK3BpLfwicpLS4/Wc6Yd9j76Im37leE62aR91O3Il?=
 =?us-ascii?Q?rp/sBxXjO4GQ9VemiAKfD/LwAXQXc4sb6WcUF1cxd2BJmV2OOyxrfvKC8BwI?=
 =?us-ascii?Q?f7iHO4C3ZFPgDbxCExTJyrDP6o8PtfQvgGTZPL94Z2WqOJHSqnxelKG1eD1h?=
 =?us-ascii?Q?uDZdxKysZAB7b90poK4HrpcN42QxwRXGuECkaaiLqAX5jSssEvz9TihIbw0M?=
 =?us-ascii?Q?A/yywMYefX0LevWRXOiulPfmiwmENqlhBejQbyLhSiLqPqRHF1UcSCxvsVjJ?=
 =?us-ascii?Q?KuW8v1rTFn0pp3NPFcsYKlAS+84YPGMgYKwPkhjUxGb1D6+xY1Uay1ZD2Zt7?=
 =?us-ascii?Q?l8Dyf/QNUBJ3zHsyABUK32Sfn03PGUnfk01944YgwFRv1EPIUBxcsGvyWHlT?=
 =?us-ascii?Q?2xUHBQowLcOx1lhVbnigydbLL1HpYeFkbPAqhhQmf1xgBCXmaYtxm/Ik/i/a?=
 =?us-ascii?Q?YD4YTMgpFSMgK1T9IQSTXOrG9z8irX3rKooX4XRCZh7XgtLTwSoxccSF28mv?=
 =?us-ascii?Q?nwylf9f6lNuZ0dlMNOMU5bG1HurKrJ4sUNApD4uq4nGfnKuBeXu/ak/EBHI4?=
 =?us-ascii?Q?cxExAthG/S0SeelVMYF2YIrpD0KnISRYFfbSav8US/JpICfgltLCz0BTraKg?=
 =?us-ascii?Q?4C5Tn/NemeMT0ZG1Ev7MvI+c7xcNEtm4QFheX67UtJmOMbyQ67EXGM3HHUwQ?=
 =?us-ascii?Q?5aiqfyI59/OXw6P7edK1z+cP4JlS1CKLIOK0ckwFvZpYSb0HcdClvVxa717b?=
 =?us-ascii?Q?XomWmeLpa1FBR3poVm2kdco+bYO4aDam+R84VwgyMVzlRkk/AaxSxiV0FZBd?=
 =?us-ascii?Q?gnjzRQcurVZvhjF1s6HV69ZNb7+MReSmSCvjVIfu5L+0WkEp5PTMa20e5KIt?=
 =?us-ascii?Q?PtkFfP7YbjEgFENgcOA6VKQHxQN3CLWemq/VHeEsei3czKkK+UBXhq/NvZ4w?=
 =?us-ascii?Q?pC4ISrSA3Sc8JnO2Od+XrTtg0eEeZXvfW/8+JaV+W2zBDeTGeLVVmi65tIC2?=
 =?us-ascii?Q?kNf2+YxCX6XxszEAVmoozBI5kbwV6RHJmWHAqy4WWlONP0R0suQkKdbldIj7?=
 =?us-ascii?Q?yQaWvUN2jKAGZvsLm3SBaygAstx+KnZlFZTKsvePOwC/POnDl/K7dxcfO7FL?=
 =?us-ascii?Q?PNnvvSv+tfL2r9MhLxymtFtl5F/N6QrpxglVToO3WU7bUSuoMRbbb0N1sZft?=
 =?us-ascii?Q?UQFOb0tI6oVsnlWKIwgPbikW+RXKnoSdvBj8zDrsgDb7TFIA7uOV+T/7NNw+?=
 =?us-ascii?Q?63X3VoajjcuOSBS3qEpBkx/VRthd38C/f/+kJprnUtqp/Mxsa80j4b88OOkv?=
 =?us-ascii?Q?V+we/DwfV7U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5913.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5gTDV2GkMRoHKd5WV4kaY0vKV0/KDIbY1Z7XyV4ijsQSw5uS/aEl11ifV9Q0?=
 =?us-ascii?Q?9H+5+xqL9h17QPEqL/OinfHM692M0JPcaQRMTrFUfP9ZSHlUVIphQiwRkl3L?=
 =?us-ascii?Q?F2qkVyVgXOdGV8ezhdd/U+9SJ2lxepidV8IMZ6pJp5lIrIgpM8BJsQqee+sa?=
 =?us-ascii?Q?QvuvLyKGYtF7nEu9NLVoIbR8AHGVso0G3xw8kr7bO9fom3WUqXEt9Na+/oFK?=
 =?us-ascii?Q?CQ0XdDzv+vborO1gqfuUVy8NMKddszbfFmNqHj3q5L0HWaAtGoN40jVNWAA+?=
 =?us-ascii?Q?Pyr9A9NXrMZPg4iO3NYLn7b01c7WDx0PG9wG7SocMkGNo9PkbrBjWZA73Frb?=
 =?us-ascii?Q?X9G1h/PJBIrviZCN6XSg3jNU9Z3s5G3CZQwNgRdBKVX3RubsmaqZ38KK9BPe?=
 =?us-ascii?Q?OGN1Vp/V0b32cMSl8lKDmPNli51dHa6NhweXEKl3oG1SXNOAM2K1hopQz0A9?=
 =?us-ascii?Q?zboe+aHMZoFtukliOWvOnNgsuO/igxi6DeshrQJIf8EmBDvv4uyGV7XLtLls?=
 =?us-ascii?Q?Qxx1jwhw51ginrnITEtcbONxwA3WFJXttL/fhySGWKsqZLiqrgpMzSNDq+l3?=
 =?us-ascii?Q?mtyfytibE0f9jGe63jc5SnXxQjlR++ZOoHIwHsqUVPhfshTcdloDcnYYV3fz?=
 =?us-ascii?Q?cyuBUMVeIeWa2FqYN6wVZqQuvdcXeN55q2LyuxA5BadMl4CrGxES4xGPS+2D?=
 =?us-ascii?Q?zE4ekCEyfSSbQ4YFekQ+IHKNtzIqcMGCAV6Wm7DB1ANW9n7ZS8Wnuy6i+WR7?=
 =?us-ascii?Q?77sI48+VSe9KufDQRpVU3B6hj66x89N/dycYLI+ksnkbUHance8XGbOzoT5u?=
 =?us-ascii?Q?0dbkpJMDy2RLMcCI5sfsqvkfMRdOqdOZQMvO5v7vJUMHa/qo4TPn5GWgCK0O?=
 =?us-ascii?Q?gLCTdCAP/xgBxrwororoePx8YdqKVbY9AsNx9tDEH8x/gpjquAqDMT97zYPG?=
 =?us-ascii?Q?FC1JHNFKvmpbCygDUoIrnD43ubVCwhFKJWLJZgLTk60GL0QZJocsm2Ie4iVi?=
 =?us-ascii?Q?EBt7NOB4LwQmiy0G38FNZyQCWRIHgzSYhnuVrgv1K1GYoYvH3W1tD7Nu06Yy?=
 =?us-ascii?Q?7/zelq77amtf2ta66ZAkUP15AyMG1xARfSms2wVu4Gr/Gck29lGqIsjmDBZe?=
 =?us-ascii?Q?JJhZYC8pBSKKJOgJqpd7jGfpGskVxbTe5+LmMt8unCHN5FpwiXh01wEPdtcl?=
 =?us-ascii?Q?HcU1jx6W2V8VG3NyevBlZ4ARHE87786ZV40pTr4gXLf6ydCEIfT/pUADUnSr?=
 =?us-ascii?Q?SR3nBQ2teRj7W5g6mS4k7fuvM4Ygqco0Q6GZmgrHqKkl/BBa1K0VJrVxPhxg?=
 =?us-ascii?Q?zwGxTM+ga/U6WUWR2tsvfhpXm8E/E5clA0NKvTwb71bmbKzJdlHv+odpxuOt?=
 =?us-ascii?Q?+IlR3puV4xikh+4gDozfMWAQmVRrTb7lsixhrHw0UyLQCQiyL4ffeF+ThL/g?=
 =?us-ascii?Q?BIOWupHkKGTi0MlfjZAd71bcN298+bdjwSECMsKfffACEW9o+/Js+xyk8jX6?=
 =?us-ascii?Q?bqX+obCSMRY/GlHFnPDCOYDTooD5pFnYDCV72zkb7Dp0p13Sq7IIZuo4Ytor?=
 =?us-ascii?Q?sbvDXSzvl+gLzcTbgMqScOX3QV3uA8cFmjnkTRrt?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615feb20-b6cb-4ab8-8f10-08dca7202d7b
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5913.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 11:53:02.5436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yisgghx2IDcYeLsEYefNgLNN3K8/RSjUwHWCooWqWNH6IjyYSBtz/wzhm0Q0To6UkcMUY2GAokW3oxFD/n2nBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6219

Add the "bpf_file_d_path" helper function
to retrieve the path from a struct file object.
But there is no need to include vmlinux.h
or reference the definition of struct file.

Additionally, update the bpf.h tools uapi header.

Signed-off-by: Lin Yikai <yikai.lin@vivo.com>
---
 include/uapi/linux/bpf.h       | 20 ++++++++++++++++++++
 kernel/trace/bpf_trace.c       | 34 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 20 ++++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 35bcf52dbc65..7e5cec61a877 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5792,6 +5792,25 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_file_d_path(void *file, char *dst, u32 size)
+ *	Description
+ *		Return full path for the given *file* object.
+ *
+ *		In order to solve issues where certain eBPF programs can not include
+ *		the definition of struct file or vmlinux.h
+ *		due to their complexity and conflicts on some operating system,
+ *		the variable *file* here is declared as type void*
+ *		instead of the traditional struct file*.
+ *		It will be forcibly converted into type struct file* later.
+ *
+ *		If the path is larger than *size*, then only *size*
+ *		bytes will be copied to *dst*
+ *
+ *	Return
+ *		On success, the strictly positive length of the string,
+ *		including the trailing NULL character. On error, a negative
+ *		value.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -6006,6 +6025,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(file_d_path, 212, ##ctx)			\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index cd098846e251..70fde7f20e97 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1257,6 +1257,38 @@ static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
 	.arg1_type	= ARG_PTR_TO_CTX,
 };
 
+BPF_CALL_3(bpf_file_d_path, void *, file, char*, dst, u32, size)
+{
+	long len;
+	struct file copy;
+	char *ptr;
+
+	if (!size)
+		return 0;
+
+	len = copy_from_kernel_nofault(&copy, (struct file *)file, sizeof(struct file));
+	if (len < 0)
+		return len;
+
+	ptr = d_path(&(copy.f_path), dst, size);
+	if (IS_ERR(ptr)) {
+		len = PTR_ERR(ptr);
+	} else {
+		len = dst + size - ptr;
+		memmove(dst, ptr, len);
+	}
+	return len;
+}
+
+const struct bpf_func_proto bpf_file_d_path_proto = {
+	.func		= bpf_file_d_path,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+};
+
 #ifdef CONFIG_KEYS
 __bpf_kfunc_start_defs();
 
@@ -1629,6 +1661,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_find_vma_proto;
 	case BPF_FUNC_trace_vprintk:
 		return bpf_get_trace_vprintk_proto();
+	case BPF_FUNC_file_d_path:
+		return &bpf_file_d_path_proto;
 	default:
 		return bpf_base_func_proto(func_id, prog);
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 35bcf52dbc65..7e5cec61a877 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5792,6 +5792,25 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_file_d_path(void *file, char *dst, u32 size)
+ *	Description
+ *		Return full path for the given *file* object.
+ *
+ *		In order to solve issues where certain eBPF programs can not include
+ *		the definition of struct file or vmlinux.h
+ *		due to their complexity and conflicts on some operating system,
+ *		the variable *file* here is declared as type void*
+ *		instead of the traditional struct file*.
+ *		It will be forcibly converted into type struct file* later.
+ *
+ *		If the path is larger than *size*, then only *size*
+ *		bytes will be copied to *dst*
+ *
+ *	Return
+ *		On success, the strictly positive length of the string,
+ *		including the trailing NULL character. On error, a negative
+ *		value.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -6006,6 +6025,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(file_d_path, 212, ##ctx)			\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
-- 
2.34.1


