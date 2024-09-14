Return-Path: <linux-kselftest+bounces-17981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA10978F79
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 11:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70AB284DF9
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 09:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECC71CDA1C;
	Sat, 14 Sep 2024 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="E4tEC3OI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2040.outbound.protection.outlook.com [40.107.255.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E6E43ABD;
	Sat, 14 Sep 2024 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726306090; cv=fail; b=Z2qmis5E8qA//GL+/iCJbW+tC4oqeF4Ld8AfsItKLb4DC6DxqZKccfjfl3HhTNgHxqNENTTjQwXDEl+kHu3wEEsb7MppK59SnNB3Z6DmsrGvF8jL9dybQ+bT0binzVSlFYNhu40w26ck1bU6uN1jiQRkoRwEBY7+aCagHKLC+Bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726306090; c=relaxed/simple;
	bh=eXDJbr5g4JI/xgaQBeA0TBsAhMZFOvY/mOoJWdzdg4I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VbzOUrV8QNyurXNUGqj9EHzJXekC2QjVjHgSixMDrNlGvyv795GnxltUBOpEEy0bOzu4lnON+bwGi5JyvhHDwHUu/yRRWg95hIIpZBjOOYVHyyI3x3HjMxcwYl5yERGntYBJFJygHy6zR8narkqBFZgeSOMtR4n3LYb0KwcB+Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=E4tEC3OI; arc=fail smtp.client-ip=40.107.255.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n59G1pJPHfG5rNmsKEOCAadU2unInybPScUUyJi8og0KXum663yCeleFnjq5Pz0xxp3K6D4HOO/jBKmhO19WuICrgrgD9Isx/DtjkpxpCMGnNGzF8BeE8B+EeXyrTGuNpIL+PtEtLDX3rYYC3OX0BKpdRiE67trWEPW+uXFR+9aWhqrzGsndcH1DAy9hryhhc07PFf5vTO1IBrdTd89GaylpHy5cguUqidwdjdNvUgUGH5WMphVotTkG+VwY37N46bvtEV4SRTXnN06hUBXvzCSLvuQgR/2VIeHm4qv8yi+gEWh6XsYLQH+JYVfwcuwg68Xzh9Y5q6zAb3IHJ2Zf2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IW+M7HjvUg1Raq7NuDqcF8CxX6FR4xivoadKC/Sia6Y=;
 b=wJSiSJqjcR7l2LU8VuJMrj5ub/VQ7JzDVkfrdP9N5UHcDyZ10BYFqZpKDqkUUl9CFc7/BonAIKBS1L3a5hNkhhqIPG7uVO8mmF1sdq0chh1ymUBlj73PnNnJ82k3GsQGFHx0lwglbfGg+wg6SM7XwJXEU+DMHiEehut/tEa7qukdVuC3PGa06SgBiy/wKlGGBTxX61RlMFkyNoPSnkn3pg8UFXAGYyERZhMkA5uBT2Ra1kjzUQTzwbBxQRK2skKmmdwfNQm3vVFGeIPi8GURxodkReFVP6v0Kben1U/uzLetX1ferAqeGfkyTTLvRYg/NCbO89EkEv3QTqy2bjgqmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IW+M7HjvUg1Raq7NuDqcF8CxX6FR4xivoadKC/Sia6Y=;
 b=E4tEC3OI1++iUkQwawcg1CWP+RvAKCSykibnBmpyFjGqW6f8c0c1NB1BC7E1abKtHxGEeCi82ZURK1iQskZ5eTTexnR4uWJjQFKF7plgwzlFB9qPxuNlEbK5tnxBkjm2z1MCTsjftX7SDlgMbsZRGH5pm/6YNuS+8BfxsII45gfzWp4vImH0cZognkYlmwypuTVa3dyWv0+vWo5NNSq6cDSuMwHUT1d3fksAQq+ff4oxYKheEUdFm25tKJcl5sl60jRzLfrBAdfhydTzWkjzV/0chnpIAM42+5KGTwx5yWaep306xdkMvg18R/EQiHiymDueR2S+BQCEqGVpSL7jug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com (2603:1096:820:73::6)
 by TYZPR06MB7316.apcprd06.prod.outlook.com (2603:1096:405:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Sat, 14 Sep
 2024 09:28:04 +0000
Received: from KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202]) by KL1PR0601MB4324.apcprd06.prod.outlook.com
 ([fe80::f8ee:b41e:af25:202%7]) with mapi id 15.20.7962.022; Sat, 14 Sep 2024
 09:28:04 +0000
From: Lin Yikai <yikai.lin@vivo.com>
To: bpf@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	yikai.lin@vivo.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH bpf-next v1] selftests/bpf:Enhance bpf ability to detect ksym read error by libcap
Date: Sat, 14 Sep 2024 17:24:26 +0800
Message-Id: <20240914092426.431066-1-yikai.lin@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0122.apcprd03.prod.outlook.com
 (2603:1096:4:91::26) To KL1PR0601MB4324.apcprd06.prod.outlook.com
 (2603:1096:820:73::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4324:EE_|TYZPR06MB7316:EE_
X-MS-Office365-Filtering-Correlation-Id: dae0d191-a3d0-48e3-0b98-08dcd49f886a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1pzl+CKLrsEyq2wP1HliHS2by1ULvnO/626mrgxJTAJrMprcScbFuAPDmiKO?=
 =?us-ascii?Q?GZ8+LFRJNg3m3wv3WmbeX18LDh8ECMNWmqXbDL9NOUbKKrwBtijXyZRym0Hv?=
 =?us-ascii?Q?jbCQ6YJmyi6y40F/foWcJ7qSKxX/oTJaZxU/Pu1vczAo6ClixYKe53lq0IMO?=
 =?us-ascii?Q?G/G5popdsdXXHpPOodRrFUX4mR58AfFoocUBOSG44iNkrnviHubUFxJzCRA+?=
 =?us-ascii?Q?uSKLXcy+AMkJ2ZzwbbaXBFMiVz779wKAfC4gxOgGmkexWlaO5vCMqv392o5z?=
 =?us-ascii?Q?Lr9rQQNZvnoYHCNBpMGCSXMNcqRZg9B9j99DaxL2mAKIoO14ROOleexJbG7/?=
 =?us-ascii?Q?KbPnUY8HNOxCEQxZ/ydTerwHdDljyU/QzMEmFvh7BguteZvIVJjKQr+rv+br?=
 =?us-ascii?Q?AUmUnZUg88fSbjs/+cKMOOXuV95obDF8BeVO75yVtEX6hSTLggM99FqHYMMo?=
 =?us-ascii?Q?2icmlUQN55zMPNXvpWXS4BzDUK+aM66lFTuLvViBEtkxvrFYQQJni8DnVqdz?=
 =?us-ascii?Q?8ipBVxngvOYv+1Yb/xVGh4bC/pRnOyShRLAfff/Si38Up+GCy4XQIEyDNnKq?=
 =?us-ascii?Q?UYAjD7L0tEk0N7NCvxgtGE+ymRGv7iHKW5odtomWNHsBJTfHokVn/nIk/8wr?=
 =?us-ascii?Q?asq1FqIIDPYRAFjbN+nXH2T3Ec7lu8XWZv5ANb5vqD4VIoeKpFsc1F8/ezOP?=
 =?us-ascii?Q?WAmLk87I7qlpni0BHGKGdOL84nYjNrfwNv+VmqnShNGkuLJBeCZ+mLoW9x+f?=
 =?us-ascii?Q?m3SkpXw1ew6PHPPtz/5lOK4pefxCsdQoPgggv5Gx7tIRy/40F6XS9j4xOm5S?=
 =?us-ascii?Q?OQcIvYXOIFhgTXdvDO+3rstPpEvYdKoDEAQaScYD9eikoMJzjOxOZgLWzsXt?=
 =?us-ascii?Q?rj2GEtTi5yyXa32k1DHaOWaIRJMm1X0y7MdTpyj7j8qaP54f0629wG3ssr15?=
 =?us-ascii?Q?Zki0dpArs6W1e7hyC64ut5znJvyGiitf1H+rWitOX1Mtg6bNCgAHPyshJDeF?=
 =?us-ascii?Q?3xig9Qs7oLVebi2emHEj6769cqWsSNV51+sg+XtEu29v/FpIcmoPi2TG7Zg0?=
 =?us-ascii?Q?TohguZUi+rd0/HIjNmagXz1bx6EHuyAJgrtXg3kME9gSdVvwzxA6yUBq6NC8?=
 =?us-ascii?Q?xnl+Svj1YzvhZsxiVpj6GXbcr5L1rddFiWarTQpIY4si91kJQCSfySFyNGa3?=
 =?us-ascii?Q?3rlzLt7u2Dq7IF+7AupJLWmD59cf+OMZLXrODW17GQUdkZbv0yIAcgRO5M4V?=
 =?us-ascii?Q?RCApVjvCOPdIiEFL/5ju0xY8Q70ktUAICJy0fLZm1jHQ3bJ5PvjmFow8PvWv?=
 =?us-ascii?Q?YE7NLforzDLHP/uhJBbp0+CoUayHtL52xXWN64QsgbQo9yQksnMbq3RnQfhe?=
 =?us-ascii?Q?sfyL13UNPgxX9HN69sYQhqmWmR8IovosExBGm/6mopTA/OKYdA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4324.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AYB0TbEhEHxtgBrt/U0sOfIi/bCi3W6ppnfy8tGhXIJr9e5OF4SZr1g503yv?=
 =?us-ascii?Q?Az2sYS+Wjnd2GumbvjMEqmdOynIwH8X2nzIhiEjtW1AUiiekTFk+WV3uSq7E?=
 =?us-ascii?Q?qEYXnaVOdW5ZOuByWBnsW7lY7Y+OcgLLeiBS16DMRst5JOBp3HgVQJMYQSzT?=
 =?us-ascii?Q?bV9Yc8V1XA35q7c/oHsY30/6+4D3xiCQ5jhrIDAWXiZQWyG0VhM5JzLyPWm1?=
 =?us-ascii?Q?rVyMHPXLYkOlHPCR43FP8gXhU5JrsEWx3ck4Tl4slFIP2iPSaqgQWMmPSCWY?=
 =?us-ascii?Q?/DIE0AGIyr3DRJlHh8yhG4lHhup1tRu/mdwmAh6t2PK/WbNS88Z0EeLWzh/R?=
 =?us-ascii?Q?KimGrLuGlIsPuMXU2Te5yZEM611JL0hN/+oCJ3Pq6fiTcQXU+qE2Z24Kg8Rn?=
 =?us-ascii?Q?Ndscy3U/ET7IIq1JWSPr9OmD2v+7j3RPVaun7cPtyQ/mG5bRDJbiYhifIwSV?=
 =?us-ascii?Q?ZDeN0T3LD91MvgTz6tHbTuilFGCaNd80Q2tsY5E+QID7on8DRtISJCGUrSBO?=
 =?us-ascii?Q?tfhOPP/XMv7mc430yh7v0pqSp22K5KoZizESNoO59Y2USidcnKsK5i20cLq2?=
 =?us-ascii?Q?6dSGtK5SxIU3/3t6vlP4GaflNPksiBKFlJDVbJAU2vmn3UP8LvoxQhy4S3jU?=
 =?us-ascii?Q?AD07aasRp+Fqa49zU8oEruEace1m3kZdhmQKEDDzrXisW/OLLp2QbphnKhBs?=
 =?us-ascii?Q?gWBW8NU3tBdZXTtCkauETq3jCn+HB3iWT7Vjcu+6TLmPUOFPAPgqANXp1QPc?=
 =?us-ascii?Q?PZen1DXVyMxURtLna6Mu/BbmoNsu6NCCFtRXPrfKaJGV0FbzsnFF1JhM1iX9?=
 =?us-ascii?Q?oz4OAtyZQADP6ohFxcAbmDWoEOoNPUvxK2igzNtOBQzvsKmDrqAoCum9+bjo?=
 =?us-ascii?Q?V1aEeQzJDTlzmHuwt22pbE3omVBHIK673dlZuZC0EmpR7Sl3E/hTyVnfBlyu?=
 =?us-ascii?Q?axGTOEIXugx7gEBEgVIHmAXadoxQDx702h5TN4u4Jda0EkAGI6JxjcC8/6vy?=
 =?us-ascii?Q?pG6V4rRsIzR+H2CZs8HH0/VxS2WchIgJVTXRkoEXEv5Yjs6nQ9SwKtH5kanl?=
 =?us-ascii?Q?2eJ0TsLRBiOAaQX7yf9ENfXbGM2VbRgHtXEmpsYFLGMmvjChT97ebUveJI6q?=
 =?us-ascii?Q?7M9LAKIfv+Fa0DumX7yAnhmyOSn2og5AQD3hQ8J/nZak7jy14bKpKwBfqK31?=
 =?us-ascii?Q?cWMzmcZSAB9ziK/NrxbnwveRZp9Y0k2LcWV/xodXnlCwn/C2r8KwlX1mlaXz?=
 =?us-ascii?Q?wZ3DzG2bEvqJDrtZdsqY0GI2o8POFT5qAVgPYZLrM6/h/eJvuuy2CZKIWrj7?=
 =?us-ascii?Q?obxO4SY566+HIzGb3ZYSlNO+U1BHcJmgyLmEgw4WHpuKFID/UVYtwB3x26ca?=
 =?us-ascii?Q?ZsoWCmYxkAVmUswicj5KJf0JRgjyGvUa5QgTTkOOCoJdAL7uI1QrXBuB0zjU?=
 =?us-ascii?Q?pvn/nsyPRXbePTazYX3GiW/qlNJxgAaT6ppU30+2cTw4c1SMVMQ6GdADkXwz?=
 =?us-ascii?Q?a5+VOKrTqf2msPy1DdRa6GRb6dq20YtbubPX80n9NUwML9U+rqRI+MllaFfO?=
 =?us-ascii?Q?dm+XsQC1vQnAdr9CDRMKdQ26o5KKDp88rnubH46i?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae0d191-a3d0-48e3-0b98-08dcd49f886a
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4324.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 09:28:04.1910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmVadC8NH2XIrQvj/Ad4guHlAVb7vzVGq0wDeHWvEBdQh03P+6BcRW7ur8c4dUVM9oxzCYoo4UZBSNrQP2O0GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB7316

Ksym addr access is restricted
by ``kptr_restrict``(/proc/sys/kernel/kptr_restrict).

On some OS systems(like Android),
ksym addr access is not accessed because ``kptr_restrict=2`.
And it took me a long time to find the root case.

-When ``kptr_restrict==0``, addr is accessed.
	# echo 0 > /proc/sys/kernel/kptr_restrict
	# cat /proc/kallsyms | grep bpf_link_fops
	ffffffd6bfd3fb60 d bpf_link_fops
-When ``kptr_restrict==2``, addr is replaced by ZERO.
	# echo 2 > /proc/sys/kernel/kptr_restrict
	# cat /proc/kallsyms | grep bpf_link_fops
	0000000000000000 d bpf_link_fops
-When ``kptr_restrict==1``, addr is accessed for user having CAP_SYSLOG.

So we should perform a check to remind users for these conditions
before reading /proc/kallsyms.

[before]:
	# echo 2 > /proc/sys/kernel/kptr_restrict
	# ./test_progs -t ksyms
	#133     ksyms:FAIL

[after]:
	# echo 2 > /proc/sys/kernel/kptr_restrict
	# ./test_progs -t ksym
	ksyms restricted, please check /proc/sys/kernel/kptr_restrict
	#133     ksyms:FAIL

Signed-off-by: Lin Yikai <yikai.lin@vivo.com>
---
 tools/testing/selftests/bpf/Makefile        |  7 ++-
 tools/testing/selftests/bpf/trace_helpers.c | 63 +++++++++++++++++++++
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 04716a5e43f1..369c5ad8fc4a 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -183,7 +183,7 @@ NON_CHECK_FEAT_TARGETS := clean docs-clean
 CHECK_FEAT := $(filter-out $(NON_CHECK_FEAT_TARGETS),$(or $(MAKECMDGOALS), "none"))
 ifneq ($(CHECK_FEAT),)
 FEATURE_USER := .selftests
-FEATURE_TESTS := llvm
+FEATURE_TESTS := llvm libcap
 FEATURE_DISPLAY := $(FEATURE_TESTS)
 
 # Makefile.feature expects OUTPUT to end with a slash
@@ -208,6 +208,11 @@ ifeq ($(feature-llvm),1)
   LLVM_LDFLAGS += $(shell $(LLVM_CONFIG) --ldflags)
 endif
 
+ifeq ($(feature-libcap), 1)
+  CFLAGS += -DHAVE_LIBCAP_SUPPORT
+  LDLIBS += -lcap
+endif
+
 SCRATCH_DIR := $(OUTPUT)/tools
 BUILD_DIR := $(SCRATCH_DIR)/build
 INCLUDE_DIR := $(SCRATCH_DIR)/include
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 2d742fdac6b9..8d2f951464ff 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -17,6 +17,10 @@
 #include <linux/limits.h>
 #include <libelf.h>
 #include <gelf.h>
+#include <stdbool.h>
+#include <linux/capability.h>
+#include <linux/compiler.h>
+#include <sys/types.h>
 #include "bpf/libbpf_internal.h"
 
 #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
@@ -31,6 +35,55 @@ struct ksyms {
 static struct ksyms *ksyms;
 static pthread_mutex_t ksyms_mutex = PTHREAD_MUTEX_INITIALIZER;
 
+#ifdef HAVE_LIBCAP_SUPPORT
+#include <sys/capability.h>
+static bool bpf_cap__capable(cap_value_t cap)
+{
+	cap_flag_value_t val;
+	cap_t caps = cap_get_proc();
+
+	if (!caps)
+		return false;
+
+	if (cap_get_flag(caps, cap, CAP_EFFECTIVE, &val) != 0)
+		val = CAP_CLEAR;
+
+	if (cap_free(caps) != 0)
+		return false;
+
+	return val == CAP_SET;
+}
+#else
+static inline bool bpf_cap__capable(int cap __maybe_unused)
+{
+	return geteuid() == 0;
+}
+#endif /* HAVE_LIBCAP_SUPPORT */
+
+/* For older systems */
+#ifndef CAP_SYSLOG
+#define CAP_SYSLOG	34
+#endif
+
+static bool ksyms__kptr_restrict(void)
+{
+	bool value = false;
+	FILE *fp = fopen("/proc/sys/kernel/kptr_restrict", "r");
+
+	if (fp != NULL) {
+		char line[8];
+
+		if (fgets(line, sizeof(line), fp) != NULL)
+			value = bpf_cap__capable(CAP_SYSLOG) ?
+					(atoi(line) >= 2) :
+					(atoi(line) != 0);
+
+		fclose(fp);
+	}
+
+	return value;
+}
+
 static int ksyms__add_symbol(struct ksyms *ksyms, const char *name,
 			     unsigned long addr)
 {
@@ -72,6 +125,11 @@ static struct ksyms *load_kallsyms_local_common(ksym_cmp_t cmp_cb)
 	int ret;
 	struct ksyms *ksyms;
 
+	if (ksyms__kptr_restrict()) {
+		printf("ksyms restricted, please check /proc/sys/kernel/kptr_restrict\n");
+		return NULL;
+	}
+
 	f = fopen("/proc/kallsyms", "r");
 	if (!f)
 		return NULL;
@@ -218,6 +276,11 @@ int kallsyms_find(const char *sym, unsigned long long *addr)
 	int err = 0;
 	FILE *f;
 
+	if (ksyms__kptr_restrict()) {
+		printf("ksyms restricted, please check /proc/sys/kernel/kptr_restrict\n");
+		return -EINVAL;
+	}
+
 	f = fopen("/proc/kallsyms", "r");
 	if (!f)
 		return -EINVAL;
-- 
2.34.1


