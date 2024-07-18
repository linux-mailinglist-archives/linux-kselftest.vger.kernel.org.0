Return-Path: <linux-kselftest+bounces-13882-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C330934CD1
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 13:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EFE71C20852
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 11:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA8F13B7A3;
	Thu, 18 Jul 2024 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="bjY0t3/G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2080.outbound.protection.outlook.com [40.107.117.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B84513B780;
	Thu, 18 Jul 2024 11:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303599; cv=fail; b=XyF4pvHprbijTgTSi2PUZQ2eqocyjp1o2N2nuxKP3BuyS+ug6bJ24r3xDbRb2MomfFOnAkUvo/98YTwSDwRtHK2qHdQ94rY8tW2cWdw5z9c5+qGMXHveu1JDinByg/PTVtmPqOy3eYDmMmQZA3fL7Rrb5A6PS9nc3fkoAJOWpLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303599; c=relaxed/simple;
	bh=Unb6v1BTZG4AH6DIbwS/DWO0y2UGDc9pn5mTtSE1zO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QIi5rgEW15HeOZHMQoQEkyxbTaHXhooPMHm0H35M8aKfkBXnfytWytbS/lji/yMETIJ8W62hu9JzeRGOJ+Wg3mXa4enypdOAQbldL4O96O8FK1jZhcYznla6sgmscVyoVFuvX/9roO1GQtIXcWXWBojTephg+eX06Z4DMItcpMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=bjY0t3/G; arc=fail smtp.client-ip=40.107.117.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyYN/+PC4l+vXGnIFa4RPJj8laQ3F8VAD51VSM8+EenNUx+mU4Np2xZVHOL/I9thRZ08/iJGClRL4LG26RYLuXKRfiB1SzL7C4JWxCqUzE3kqLRDIbXtxrRif3qRQLsbZYwmWHfUHAfTjUWO4QDP5VlbP3KZL4IivAWm1EpYiiEQxKduckmomd+QikGuMVvEkafL8TtD2hHCk6SU/S1hrjzMQgcMxL/IYCOIP8qhMZu98I00yKyncc0bGmxCZxi3ISqhIp47H9BgZzWfJyXfYUE+pX4pXabh9/QFTZvrBiue2dGVKVxI5KURRiaGJVqQg9tsTkvVEnMqCuw7BEkncA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwsFm2w9kA3VbpErR1R5yMie6b+3mDrA9uzO+BwSfOY=;
 b=c5SzE1J7ugTvOd0W3mzHMjIV1WnMlb5GDx4pvm00fWip2K0RKKCc6FTYBK1BV4iYRJ1fgzkJkbeDwpleAM2ESENUgNBvthAkB7se2gXElsJqVe9YNZzZSD2UDyuel+u8x8fS5wmD00SbfKUh+TY3axfbfC4V6pZMT/WYIWvZYJF29p+bV0O8x8bsqE7ly0uWQ1XPJbIKdHd3CrZ632V4pi5fcaVVOjba4I5OoiNirmaQ5FBTycpYwla3U9h3uoH5IWbHkYqGPUWyRnE8ykGQf4aHR8fJf1+ajPGEOgvBlVTBFb2R0oYns1+LX01P051cL+w++FQ2OF+exe6RE1NjVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwsFm2w9kA3VbpErR1R5yMie6b+3mDrA9uzO+BwSfOY=;
 b=bjY0t3/G4ltwYgWHNPFa1zpy39MmMGf3rsu3W2uXs52cgjgqtqN6O6GZAZ+DF/eGZXheSuJKw/Zvzalcr2gCGQNkmIS8/mZPfErG2jU5sijLPGPtsl2V95BuMgPVJT0WJW/8N735RTI3SF2ugZwWsV9kqLOzylyJEyIrBJiEi4+U3F3Lq5JBSb+TUvAl6iizdEOEbDDKRYehhGoLVtr3XRqqReqWfmb8xqNVMFtGAACSMt8ksngaEls/DLfyebcGdUwcA3+ozBqHB2Zx7eWH/Wg4LOjxT/6urysSRjCj8snzbXv/ZCl08WCCvzwWkctiqnF9RycvHj7pCmq885SLyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB5913.apcprd06.prod.outlook.com (2603:1096:101:da::16)
 by TYUPR06MB6219.apcprd06.prod.outlook.com (2603:1096:400:352::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 11:53:15 +0000
Received: from SEYPR06MB5913.apcprd06.prod.outlook.com
 ([fe80::f049:a716:8200:c4a1]) by SEYPR06MB5913.apcprd06.prod.outlook.com
 ([fe80::f049:a716:8200:c4a1%4]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 11:53:14 +0000
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
Subject: [PATCH bpf-next v1 2/3] selftests/bpf:Adding test for bpf_file_d_path helper
Date: Thu, 18 Jul 2024 19:51:44 +0800
Message-Id: <20240718115153.1967859-3-yikai.lin@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: cbb0247d-416e-4616-3599-08dca72034d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tUUIcQw+6m6QnMXXU7fRZ0WXiYCRkvt2gqcSICEy/xa379KZ8UdG0HT9hzsS?=
 =?us-ascii?Q?qR7/W+mfNEltuvfoXQ/hImaAXRSk0UBaBCcQNZDjoSOBWTKEbIT0Bm3SBKVm?=
 =?us-ascii?Q?BYqO/SQEnFdVGTRnN+mxKPW/oXJ/WZTx2uqH1j1HS+VJU15BR0fXLAFVuKMf?=
 =?us-ascii?Q?atCf6OXi4CbLWBlHpfpCWd0xr8X45fnsuAtqi9za7GoN1zmTGhCJ0SXWRiCP?=
 =?us-ascii?Q?g506YBNyJldAGlAjdHwntVYKPgxfuoMYBU2TlAseY/+rseVaRqPB7tD0pH43?=
 =?us-ascii?Q?1x7io8KJ/VDWH2aKMLQpPialsUXcYOb6T/R7IIew2eyljWpogF1XCVlcqMdu?=
 =?us-ascii?Q?pJvjh7cyAfDnLQKdv1VzeDndZ9AntZiYodLpOQcUZlin8K/KN0rgvPxryVsF?=
 =?us-ascii?Q?jThOsPJTtKl493Sgp+i1O/+m1PjbYIuD1IxKu0Y47btwtm8tQRxOwF7c6ApJ?=
 =?us-ascii?Q?Iryz/uAVJNK/Hl0kG9TGJXC/oc8531GlRqcDoNkV24I7ph36cS2UxlC7NF7F?=
 =?us-ascii?Q?8utlmRXZCbBVu32lKVA85WYEmZW2tZno6OEXsuMqkPNea3Mk35KVe9rO5HV2?=
 =?us-ascii?Q?hMzVVo20lunq7d7+gioysktWyDh48VOLunogHq0XFtIyYVcgBeLxlYE2afgp?=
 =?us-ascii?Q?76G0VL7soyfgubUDBAlSamhjQvCq4/pgAKm9KvncwFOoZ3dDSom2T9wXcnzq?=
 =?us-ascii?Q?IugWGoygQTJaiwH83qHmB0AR8atxXJ7UEpgFULSgM8rp4y/Ho6n18vaqCLJD?=
 =?us-ascii?Q?1QhRdv4HbfJdamihVvRLhR2PTn1by/DBw4DXpCQLvxp+w6zW4sp+381HyH3t?=
 =?us-ascii?Q?wYIqEWnGeYqJH2Kx/S3wOQUQWY2QUoUE3zyprpnqLCBm/UPvHUZy3eQcycm2?=
 =?us-ascii?Q?034/EqiUf63QQ/Lrx9Ov85ItyhdU9SnI/U5NOTm1dxRDiHPs6r6ZdAVcglht?=
 =?us-ascii?Q?NxwGZ4tICayrRTVxiNnRLtXQfHCaiMFUMjLEbXvmD0SRPPVjrsDmZ7AyGYph?=
 =?us-ascii?Q?mdCrZETm5Joi9OPZt9ZrzOPUwXWe5yTU3NoOGiR4wc0UOhANsxcdBpMg77D+?=
 =?us-ascii?Q?vypDsjntLp17Uiey09RAO0C3O9qQk8s6SltLteOqbs5Vd9bioIGzutLaudqu?=
 =?us-ascii?Q?bO/BUxvZce7jT58oqnWjOS4bps8NzDHBbpEq6g3Af47UgrkAD4prLdLL0tKn?=
 =?us-ascii?Q?69cG0S71zcZfZnyzePXR68mZfaovHrh2cM+Kua+IUKQrRDlMYPG7Q+BG5iqp?=
 =?us-ascii?Q?My/NVn7TLwQH/haj9fhat1/6PTQARMJ/9u34dcCD/v38PtL4G3KqNkpJc7pC?=
 =?us-ascii?Q?TaonLsyGwMvqHRvUlUZEmsTSJNJmnFZaHquwCVWrj2swtDj3o1Wiaq9ns9j9?=
 =?us-ascii?Q?+HztyzpKyWBwFasxdH9+PSFQxlpNzQHHxg7QMjKnPxq6ycHNtmbYa/fSehPc?=
 =?us-ascii?Q?u81og0464qU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5913.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3YQE/z2FqtEPgcb9/l++oj9EcrCnF6h9RAm4PieLrTFcVf8KENI6tEdW7510?=
 =?us-ascii?Q?wCmmpB7qmgK15j0xBdNJrn0xfTrrr4z2v5nugFU5FeYGNq+1kjdUUSxCgUfx?=
 =?us-ascii?Q?VYNFVdoq5H2eaWsD+nhJCOElmDJwJDbRFk6SMByzY80CWj7KgRYoLrqj/n+A?=
 =?us-ascii?Q?gSUZArqPbA+GA7DGUEw4UQlW3B5nYtIMDtmvdh2QkEwgKuLuKy9DpFDuNgQ+?=
 =?us-ascii?Q?Mq1IgIiBbaFmTTqzN/vU+5EF/Gj84pDSBi7rdaVj81FzNth0UbWWTdIaCn/8?=
 =?us-ascii?Q?Z7tPF080Ga7ncqDikLNx1tzLbw/ZAQmi+E7/CK57teNcbpvtz8OE0fvXiE8a?=
 =?us-ascii?Q?j4v/R9aVykLNlffAFYt662YVYDbUt+HaVtnp8XEdImzRdWboXp78ZsI4C8C7?=
 =?us-ascii?Q?n1jKCUuF/moBrT7gAUpsf33K62sUhXtcqthxaTgU2zE3bFdnc4v+uY7x5puN?=
 =?us-ascii?Q?+CxM2kXMo17OuF8I3hw15VF168tSd2N7J/YxXqoVF4zURIzqmoopJmooLjwZ?=
 =?us-ascii?Q?H8W5IUZBb8AcZ9WEV3OUa4aZH2xMfrf69gisJ84GimqqJeuzHZk+CG9sSjjV?=
 =?us-ascii?Q?i9YzWtSUQt+exQjVexgbDfFSN4OU7gCcVCR0E4rvRQ+aGJTpHCkS/UcZjKBe?=
 =?us-ascii?Q?cnVCTo+LU6wwQIKHuOKZoSDW2U0VU2xCzNExY8ock7p9nFe2QjIyyTICCcSd?=
 =?us-ascii?Q?2pWlDjjPAzVHVDeiBuI5AZoVg2ErpclxmKzQLDfJQIRTGxIFQ0sP+lUe5YxZ?=
 =?us-ascii?Q?RMzrVFReVlwj26f6qLZcyZ9oJNfnlRKAePYJQOxtyoaZ5ZxsNHPiqP7waBh0?=
 =?us-ascii?Q?9q0ujCkUhopiwIy46xZf01EPQOX3LXa8MopRLxXKFm6aWHQw0+wq3UOT7rgw?=
 =?us-ascii?Q?OFOmGKlB7obFAXg/wTALcD2MJKVILQ7+Qc1v6XvIdbVhYDCILV5hSxbwvGao?=
 =?us-ascii?Q?GDfvSPpKDxihZkzvL7fCOqaZ28zNrtBPFBwztwCn3S8UJ3Jh1G6Emel3CNDj?=
 =?us-ascii?Q?k6GzSeKRFjP7dhb7KFIcwH49TuhstyGiO1u4bsHbKApBR7SU7lQIvra0ql/6?=
 =?us-ascii?Q?6fHezGaiQUGdzFIAk/j1Fb2BeCf5gtoIVK2jioqF3PUWh+aIj7P7qWzgt5yR?=
 =?us-ascii?Q?XQUPSduXnHQGJZ4sxmmXNICtE5uALyy6R1gNtkpYB4DDXCgz+awoiZgJeCD3?=
 =?us-ascii?Q?QceBV3QUpg90INdgT3arzzhovGR0nWv7J7GmZ/7kBoWE0AIDcbrifX9jyaLq?=
 =?us-ascii?Q?wGrMwifZp6oOnWP0ja941EXmdIDKTj3zM7+MtR6/T2WpKMvw0g0ClBwHG3+g?=
 =?us-ascii?Q?lkRmtuXLAyq0wBm8qPxANoPS2XYlEFM3PThNZB/i0CnjtSJJq8fcKeiKrWoK?=
 =?us-ascii?Q?EDyatL1ncmebwabt5YbZ+pVqSDbWFt7V8relBi850ItL8vwI+MXoT56PlZlh?=
 =?us-ascii?Q?kWc/GFkj1F8+97yorlKNRFFDI5QYophb9/MFv6E2ltfTcTf5BeUl+TNBXtPr?=
 =?us-ascii?Q?9MjV5pQ8mcXDTWvrb1Gg21nfn14xn7IRNaoyxQWsVhSNvcXFvrqjtMBseqwK?=
 =?us-ascii?Q?w6dpuJh3Es9mFtHYHTTokMxsmFGJByJ/mbZTxsoA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb0247d-416e-4616-3599-08dca72034d2
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5913.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 11:53:14.8468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCSep7h0tmGammT1W6OaXy2y26Q3XUMveUdUl8hUDUF+QBRNwgp5rwCCSkfmjqC3YpryhIQNLfQ3G5wJ+i+XVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6219

Hi, Adding test for bpf_file_d_path helper.

It passed the test in my environment using QEMU
(./test_progs -t file_d_path)

Below are some partial results:
'''
  + [ -x /etc/rcS.d/S50-startup ]
  + /etc/rcS.d/S50-startup
  ./test_progs -t file_d_path
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
'''

Signed-off-by: Lin Yikai <yikai.lin@vivo.com>
---
 .../selftests/bpf/prog_tests/file_d_path.c    | 115 ++++++++++++++++++
 .../selftests/bpf/progs/test_file_d_path.c    |  32 +++++
 2 files changed, 147 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/file_d_path.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_file_d_path.c

diff --git a/tools/testing/selftests/bpf/prog_tests/file_d_path.c b/tools/testing/selftests/bpf/prog_tests/file_d_path.c
new file mode 100644
index 000000000000..ba76d9467f3e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/file_d_path.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <sys/syscall.h>
+
+#include "test_file_d_path.skel.h"
+
+/* Compatible with older versions of glibc begin */
+#ifndef __NR_close_range
+#ifdef __alpha__
+#define __NR_close_range 546
+#else
+#define __NR_close_range 436
+#endif
+#endif
+
+#define close_fd(fd) syscall(__NR_close_range, fd, fd, 0)
+/* Compatible with older versions of glibc end */
+
+
+#define MAX_PATH_LEN	256
+#define TEST_FILES_NUM		2
+
+static int duration;
+
+static struct {
+	__u32 cnt;
+	char paths[TEST_FILES_NUM][MAX_PATH_LEN];
+} record;
+
+static int set_pathname(int fd, pid_t pid)
+{
+	char buf[MAX_PATH_LEN];
+
+	snprintf(buf, MAX_PATH_LEN, "/proc/%d/fd/%d", pid, fd);
+	return readlink(buf, record.paths[record.cnt++], MAX_PATH_LEN);
+}
+
+static int trigger_filp_close(pid_t pid)
+{
+	int ret = -1;
+	const char *comm_path = "/proc/self/comm";
+	int commfd = -1;
+	const char *tmp_path = "/tmp/test_bpf_file_d_path.txt";
+	int tmpfd = -1;
+
+	/* open file */
+	commfd = open(comm_path, O_RDONLY);
+	if (CHECK(commfd < 0, "test_file_d_path", "open %s failed\n", comm_path))
+		goto fd_close;
+
+	tmpfd = open(tmp_path, O_CREAT | O_RDONLY, 0644);
+	if (CHECK(tmpfd < 0, "test_file_d_path", "open %s failed\n", tmp_path))
+		goto fd_close;
+	remove(tmp_path);
+
+	/* record file */
+	memset(&record, 0, sizeof(record));
+	ret = set_pathname(commfd, pid);
+	if (CHECK(ret < 0, "test_file_d_path", "set_pathname failed for commfd\n"))
+		goto fd_close;
+	ret = set_pathname(tmpfd, pid);
+	if (CHECK(ret < 0, "test_file_d_path", "set_pathname failed for tmpfd\n"))
+		goto fd_close;
+
+	ret = 0;
+	/* close file */
+fd_close:
+	if (commfd != -1)
+		close_fd(commfd);
+	if (tmpfd != -1)
+		close_fd(tmpfd);
+	return ret;
+}
+
+static void test_base(void)
+{
+	int err = -1;
+	struct test_file_d_path__bss *bss;
+	struct test_file_d_path *skel;
+
+	skel = test_file_d_path__open_and_load();
+	if (CHECK(!skel, "open_and_load", "load file_d_path skeleton failed\n"))
+		goto cleanup;
+
+	err = test_file_d_path__attach(skel);
+	if (CHECK(err, "attach", "attach file_d_path failed: %s\n", strerror(errno)))
+		goto cleanup;
+
+	bss = skel->bss;
+	bss->monitor_pid = getpid();
+
+	err = trigger_filp_close(bss->monitor_pid);
+	if (err < 0)
+		goto cleanup;
+
+	if (CHECK(bss->bpf_called_cnt != TEST_FILES_NUM,
+		"bpf_called_cnt",
+		"prog called times diff from with the expectations\n"))
+		goto cleanup;
+
+	for (int i = 0; i < TEST_FILES_NUM; i++) {
+		CHECK(strncmp(record.paths[i], bss->bpf_paths_close[i], MAX_PATH_LEN),
+			"bpf_paths_close",
+			"the paths diff from the expectations: id=[%d], path: %s vs %s\n",
+			i, record.paths[i], bss->bpf_paths_close[i]);
+	}
+
+cleanup:
+	test_file_d_path__destroy(skel);
+}
+
+void test_file_d_path(void)
+{
+	test_base();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_file_d_path.c b/tools/testing/selftests/bpf/progs/test_file_d_path.c
new file mode 100644
index 000000000000..8db2bcd1179f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_file_d_path.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define MAX_PATH_LEN	256
+#define TEST_FILES_NUM		2
+
+pid_t monitor_pid = 0;
+
+__u32 bpf_called_cnt = 0;
+char bpf_paths_close[TEST_FILES_NUM][MAX_PATH_LEN] = {0};
+
+SEC("kprobe/filp_close")
+int test_bpf_file_to_path(struct pt_regs *regs)
+{
+	void *file = NULL;
+	pid_t cur_pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (cur_pid != monitor_pid)
+		return 0;
+
+	if (bpf_called_cnt >= TEST_FILES_NUM)
+		return 0;
+
+	file = (void *)PT_REGS_PARM1(regs);
+	bpf_file_d_path(file, bpf_paths_close[bpf_called_cnt++], MAX_PATH_LEN);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1


