Return-Path: <linux-kselftest+bounces-41660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99292B7CF51
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97811188B178
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 07:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A481F30171A;
	Wed, 17 Sep 2025 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="GgdphCm0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013000.outbound.protection.outlook.com [40.107.44.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780BC3016F6;
	Wed, 17 Sep 2025 07:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758093820; cv=fail; b=uR/u/1j0lc2++vJmvFZgmd+w6CjXKl43WC5LoTceGurvmGvn6HX5twKdG4snheMQVXZGb+/46Uk4Zh9Lc01Q/mbanaObBr/IHSAw7ix17ILZcqANx/QJMD7stgDUoSdySFGxzW+MYRIqQhets9S5A0MC6TPagbA8nhNRUGkDvtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758093820; c=relaxed/simple;
	bh=9+ejYfeAFd83QO7MarSlYXLhZ1fXbTqebkFXCRqiLu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PerMYc4hduPxEBz+02eZPEQpzejQlM+3pDSrt+r8t/0iKFQZTTb5TOlvpSTLJOYR3rIXWOg+Qn8gSZfUEeWWobX9r8rG80R2TGy5YwBJM7j6nmUA/4WYB2i0lxVSSlnhBh8fYCuPDLy0ByY0fWo4hIBc7pSo0cqEvD8sCgOXuiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=GgdphCm0; arc=fail smtp.client-ip=40.107.44.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwccvdfSA+p37tD9DhH9vNFHuEHGq/cenMCdyh08N3CqDpBIPo8ih1fterCJzQMuH9jb3c3zq2ZV0ip97gzCvQvQm1O4hyIxJPVdUMKniZhq/XAdxMuAIWvsNKo/OvpYJnSgokbgqPsm/5CXm2J9b4qcnNQhFF1OY4AZOSb+oxjbwfwVNqq5eXvyJcytFH7oneJwdM7xRvpqQa3uEsJsN+xXryTASNJ2PlexbBHW5ImcYfp40ko+z7RJV4eKvJw/KRTA8qiACh7R9U5IDqNKQ7pDDI1dtg1nkK2qQfeOhAdrlRX74MxSOpQVtu5+Vps4O3GuAmhPnH55EYJ56uQUJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRo19hDr5AtkWZPl/HJOdkMxAMyDEbkSfhGIiamt2+s=;
 b=NtpA1q1uhRqsb13wUk1PvaswqR8wtYDG2vc/s/2LCgb/h4tYKjfF7qMizfXCQMXNthNcLtIbqJD2MDrnHT1En9D6795N7kK2AMCpewuccE+jsQlAhorZ7t5hMITUX4W2TAqavjiIR/tBKD1241OR5iZLhPV/dfrqBTMJdtYqqtQJwSUUCJ0z6U2Ln/MO6l3S4gFohWYZdCy3KIq/6OAWG1o8GnNv3fUJup8I6G/Vl+u+G7vQA2IZqIBe6WY65cOexQTUXh5U/HXDfdjEfUGPXIEYqVEGj6JJCptZGFxU35mWkTNnqAuuVL6EP2F4m1huhp7ej1l+b8ljd3knCdxxkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRo19hDr5AtkWZPl/HJOdkMxAMyDEbkSfhGIiamt2+s=;
 b=GgdphCm0O4sRAX+OMPbaZftcEt4mebAdlKd3k0zlaU54iIKd/iSHKGfO3dNWZn0hYmSiXysXp7r12w8LLYMYMMfFWprTnvgZVbqI7F7srQe43qV7VY6drMN7CMlp1iQvZivohixJBU94BGZAmt4pHib9MDcUGlym4jsfAvis0s7NpFdikRb2hKwHnMTJchxt8oXSLMrpFNG8a2E5XmvFylYL7aVaYGBelSGKj6HRqgOQwsOleuPGhC04u3zNN6MYESLKL6Nm0eokFGx9NLr332K87i/HUhzIcAdDGvglRvj4fdkW6eep160wvicG/ptvHylD4mKhiUCwG9tw/Ucyuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by KL1PR06MB6043.apcprd06.prod.outlook.com (2603:1096:820:d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 07:23:31 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%4]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 07:23:31 +0000
From: Fuyu Zhao <zhaofuyu@vivo.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	haoluo@google.com,
	jolsa@kernel.org,
	eddyz87@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	shuah@kernel.org,
	willemb@google.com,
	kerneljasonxing@gmail.com,
	paul.chaignon@gmail.com,
	chen.dylane@linux.dev,
	memxor@gmail.com,
	martin.kelly@crowdstrike.com,
	zhaofuyu@vivo.com,
	ameryhung@gmail.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: yikai.lin@vivo.com
Subject: [RFC PATCH bpf-next v1 1/3] bpf: Introduce BPF_PROG_TYPE_RAW_TRACEPOINT_OVERRIDE
Date: Wed, 17 Sep 2025 15:22:40 +0800
Message-ID: <20250917072242.674528-2-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917072242.674528-1-zhaofuyu@vivo.com>
References: <20250917072242.674528-1-zhaofuyu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|KL1PR06MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: ad0b585e-2488-4012-6ba6-08ddf5bb1ac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pK9retHz9TnmYYfGJKvuO+bXzK7zKlf6H5TVac86X1EttxwzEMY1/oi5wuwT?=
 =?us-ascii?Q?UwON7dC/iRJKYXVw1yWoYn78AozyOtbz6C+vzoKvpepgkxiX2MHoY7C6ZHxz?=
 =?us-ascii?Q?xEs/cSgS3JQggq1Z6B20x0ExMQAxwxTblSy5PhbU+61IOT7Yg2YoKOuMbQt6?=
 =?us-ascii?Q?2hbRiG+ohmUyxmNbTxdCvfNMgX+gsM+RtrjY8ARGIvjb6V+RUaD6Bmyb+uYZ?=
 =?us-ascii?Q?Ecd1FL85tgQu5nAem98mK2mc2beskFVCILbqc/g3aJ67ibjuYECa1mftQlY6?=
 =?us-ascii?Q?OyEzDBfb3/orJp0dnE463UMG1zA2cxg/lO81rtC4NTtjr1Wq9bCqPCFvlaqC?=
 =?us-ascii?Q?mDCXOcOEetKh2LvjOXeYt8+G9/qS5Lx3mqPiH9r1prUVJvFMYWxsSuCknw4q?=
 =?us-ascii?Q?X6EkSGq8f4cVzVTxrRDN1s49QZrrr5/+ITcm6cy75HWlckZBZh0UIsu24zNy?=
 =?us-ascii?Q?eyCJBvQQo1qCZOdOc9erkVsxjryGlt1DeRBddHsYgSTckwUoUkzb4CrX+vUZ?=
 =?us-ascii?Q?XucwOjIBWpPjOeHegdo3e0V8Dmt9WlSwpY+Vf9DLwwG9bJQp+E3Y+DHLJWUe?=
 =?us-ascii?Q?H/VOk41X2xxmMfIpTx5A0vrjV9zFRqQdjvXnmjkshGWN2JUmywiHg6QT3pZi?=
 =?us-ascii?Q?vODHNhws2aLUmthl50tAv4ac4byTloVphrfTUdYhR6dMDj83Tgu3Q8DrvTIs?=
 =?us-ascii?Q?O/kGRfHSCpW9VGWCWJSMAxTwx+H6RoB9inhX+TVUq7CAEqwFQAsKgyzdEkkM?=
 =?us-ascii?Q?Pv2VWNAcOXh442aAu5ZUUfsmXFtk2YubM5BGGSYTaieZykVW3x67GYEMVCvL?=
 =?us-ascii?Q?Gq7s50NB2R+NLo3AVh0AmfiCMhuxHgo4/40fjFHh65d1XxbuIMDnhX+lBV3Q?=
 =?us-ascii?Q?6YO1EN8FE3ZbLOp724cpdzm9Lq5EvNIN1JURMi1TljFMkKvX+dMqOt+MX/fg?=
 =?us-ascii?Q?VytwMdFlIR0k40KtuAXCZ3tHL0t1Is1zL7QvpgD158zQbpJx/3O7xNquQez3?=
 =?us-ascii?Q?rlw1qKZsk/AomwSdaKYdh8bj7xGK1/VBAT9Q24CPn66zkOsSYTtsSkOXFznu?=
 =?us-ascii?Q?ma57QEDew7cWGrmwuNvWBPCE90vIjzVQT3VC8osfOFp9ItU4L3TuKYFpHEUz?=
 =?us-ascii?Q?lS6XyLre06lQkLILfjCBBjV79RS2wVLurj1bGMuENoFDqs5pMO/Dh8wlevn6?=
 =?us-ascii?Q?iEFQP5fgL1GKHxBGJs7bffRjOQsrO3jE8P8ilkZsh3wi4wlMh0/kE34sDSsg?=
 =?us-ascii?Q?YTufPDi6XeDMbtnEMmBB2LhYKcruwiRAYik3tRAluJOglTaikkni7LQ53ygI?=
 =?us-ascii?Q?wXefyzgzMRaz34sANWuQCtsBd2+okJByBzS0YqR2fsF3nWnYn4WsLnPwgu26?=
 =?us-ascii?Q?0vqcMhLOkWNmEYsth5Az32Rw5OHGNKir7ZBH96jm1MNrraHpzEQvGoFNiBO1?=
 =?us-ascii?Q?G61uTweoElS49NQSgkKPmRqkblcsXdKPqMKd888tlZDeoMWAgeZlqOvhdFRa?=
 =?us-ascii?Q?/zSR+YzxHGaqstA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TEItbHJ0N4IlHLZKRjsBwbD3Ou5T+XyYFERO9pZGws+oixs60vssWfDgjuFp?=
 =?us-ascii?Q?wXmuocFDPOPB8/v+O7v4RKkHbmsgApQxWGtwW9mEx4Y3UnRDm9d2Vyx0rmB5?=
 =?us-ascii?Q?911gtU2w5v+1SgDyZ8U9Omd+6KbV7yklZYuUgnq5gXndkuN42ljezoawUDw7?=
 =?us-ascii?Q?uE78CzYhHKiR7QRzVR8o3KoDuthw5GBe53eXdv/oEzGjR+D2jmhwIMxhY0RF?=
 =?us-ascii?Q?FvarbTUp6glR7gBNhSUJCXVe20V9oF0kxPMKTxVxMoCspJyKf98tqZguQOJA?=
 =?us-ascii?Q?CWyJcyKQ8XjnnkBo8e/qDYixMsqLEZFVe1DuUY5T86X0kpfawr43SAqTnsCi?=
 =?us-ascii?Q?KyoIcvqRkY88Pr9JCVPTgCKc9Ni33Tf53Qhf8WBSgmin1UzCVl/7gqfjQUF8?=
 =?us-ascii?Q?DNE8pWxuxCIp9Hv3dR5T2DrWWW+2OnqgUYwbfAsD4Ts2E6XF0+++TeJD2dge?=
 =?us-ascii?Q?vhLWgePZsoE65g/27jo8TX4/zuMot2lAnKLAZ59DPm6fNvve7ZPKOaXjGJLj?=
 =?us-ascii?Q?MZ6sAdBUb0ieeYd0dLBkxRvH2TRdS3bleJnijSdUii4ErG/B5CgqYLKzQju2?=
 =?us-ascii?Q?QSdgRJI1ayNEXgPWbjSUSuDGEa/pr1nfXk9VAgrBTTdOA6CxOj9ms1PJpyg6?=
 =?us-ascii?Q?tKqXTV/e06NMvF6DVU6wsFLGiozer4cs1jviYP0jcWl93sI9aHRM7YvD0fAo?=
 =?us-ascii?Q?9IDTD8hRA1cjcFOso2mlVWviCeUZdTVtH3RkB+WmyQBv15ILcJTk800tWFnx?=
 =?us-ascii?Q?wHS7o8Np6dMt7w+gNhqZf2lPQwRUyXQX7fLDgvndryIim64RaaglKxhFHRwe?=
 =?us-ascii?Q?F+TuF8qGMQmlCnQLDfAJLVMxAR07oZMPJ4ybIh9KpIF8GNtX2FId3o4X/Jut?=
 =?us-ascii?Q?Zoq+CUD1hP3VXnbJpmbrra1z/C885enrAMCc3CJ+relYbq1F6JWhhatRP6rT?=
 =?us-ascii?Q?wes37ugwvV523YpLlAEzJm8KK7aT20frtNbMrTTIdyuMImZ3o4+WjaicusGR?=
 =?us-ascii?Q?TSbA+lFWGkFda2rI8Xa/aPSBNPXW/hD2B37ePfEU5S2O1PqwsDSWAqEItWp3?=
 =?us-ascii?Q?TrrwL4a/+1+mVIpKmMtCy8PKGeQ6VjCpIyccgMN+iQ6LmtBR1QIWQjLpND5A?=
 =?us-ascii?Q?wkfp/LNztpfYUUooIkfUKZbJPCLflEt4ct4HjiGv3biTYEQlJBbLZO1zZ2lp?=
 =?us-ascii?Q?jvPd8Ubuoaa9AkLPiAGUzDcIknkEd//Qn0htPQdBxiso7JZLXq5KRw/kRh/4?=
 =?us-ascii?Q?NEPpSlCPL9wQHh6zfueGHPuBoz7XQhJoz/kyWGnrTD2/WdLaKStC7eixyeVc?=
 =?us-ascii?Q?OotMIcwqsOonTCJ82q2csAmfs86de6wzARZPQCP60EMj5fc7xpD3dDcjy8+o?=
 =?us-ascii?Q?mpkmVQqtekKcu5yvZ05ZfngCk89ZK87jYE8GHQePJAZGmnwdZ7bPz/ES3MI5?=
 =?us-ascii?Q?VJ6NPptbvdrLnlxJdVzu0zsG38ZmEKNC97MWrJ6COiiJ/TF9IW8yN4Z813c2?=
 =?us-ascii?Q?ec2cxmobnqLTwKbjdURTryDoNml/dxe0cTTo05zT6KOY4kynj9XLt0tq/Fmw?=
 =?us-ascii?Q?uezLRs1sJf4nLnsEq0zIXCE0xFvQ9EshmRPQieHF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0b585e-2488-4012-6ba6-08ddf5bb1ac6
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 07:23:31.5308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lPfSvAaqzmRzse54zjzL/gO0wgRSGUoGsLRluR+dGf6ANuAcg1zJa65GVlFlVokdS9hV0VDDBCCZLD42uZWOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6043

This patch introduces a new program type -- BPF_PROG_TYPE_RAW_TRACEPOINT_OVERRIDE.
Program of this type requires an additional parameter -- probe_name, to locate
the target tracepoint probe function registered by register_trace_* in the kernel.

This type reuses existing RAW_TRACEPOINT infrastructure, and differs
only when probe_name is specified. In that case, the newly attached
RAW_TRACEPOINT_OVERRIDE program and the target probe function are paired
and stored in a snapshot.

When the BPF program is detached, snapshots are consulted to determine
whether restoration of the original probe function is required.

Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
---
 include/linux/bpf_types.h       |   2 +
 include/linux/trace_events.h    |   9 ++
 include/linux/tracepoint-defs.h |   6 +
 include/linux/tracepoint.h      |   3 +
 include/uapi/linux/bpf.h        |   2 +
 kernel/bpf/syscall.c            |  35 ++++--
 kernel/trace/bpf_trace.c        |  31 ++++++
 kernel/tracepoint.c             | 190 +++++++++++++++++++++++++++++++-
 8 files changed, 269 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index fa78f49d4a9a..e5cf8a1af6cd 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -48,6 +48,8 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE, raw_tracepoint_writable,
 	      struct bpf_raw_tracepoint_args, u64)
 BPF_PROG_TYPE(BPF_PROG_TYPE_TRACING, tracing,
 	      void *, void *)
+BPF_PROG_TYPE(BPF_PROG_TYPE_RAW_TRACEPOINT_OVERRIDE, raw_tracepoint_override,
+	      struct bpf_raw_tracepoint_args, u64)
 #endif
 #ifdef CONFIG_CGROUP_BPF
 BPF_PROG_TYPE(BPF_PROG_TYPE_CGROUP_DEVICE, cg_dev,
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 04307a19cde3..fcb2d62d0c9f 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -768,6 +768,9 @@ int perf_event_query_prog_array(struct perf_event *event, void __user *info);
 struct bpf_raw_tp_link;
 int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_raw_tp_link *link);
 int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_raw_tp_link *link);
+int bpf_probe_override(struct bpf_raw_event_map *btp,
+		       struct bpf_raw_tp_link *link,
+		       const char *probe_name);
 
 struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name);
 void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp);
@@ -805,6 +808,12 @@ static inline int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf
 {
 	return -EOPNOTSUPP;
 }
+static inline int bpf_probe_override(struct bpf_raw_event_map *btp,
+				     struct bpf_raw_tp_link *link,
+				     const char *probe_name)
+{
+	return -EOPNOTSUPP;
+}
 static inline struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name)
 {
 	return NULL;
diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
index aebf0571c736..9d7b1710c0aa 100644
--- a/include/linux/tracepoint-defs.h
+++ b/include/linux/tracepoint-defs.h
@@ -29,6 +29,11 @@ struct tracepoint_func {
 	int prio;
 };
 
+struct tracepoint_func_snapshot {
+	struct tracepoint_func orig;
+	struct tracepoint_func override;
+};
+
 struct tracepoint_ext {
 	int (*regfunc)(void);
 	void (*unregfunc)(void);
@@ -45,6 +50,7 @@ struct tracepoint {
 	void *probestub;
 	struct tracepoint_func __rcu *funcs;
 	struct tracepoint_ext *ext;
+	struct tracepoint_func_snapshot *snapshot;
 };
 
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 826ce3f8e1f8..399001e2afca 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -50,6 +50,9 @@ tracepoint_probe_register_may_exist(struct tracepoint *tp, void *probe,
 	return tracepoint_probe_register_prio_may_exist(tp, probe, data,
 							TRACEPOINT_DEFAULT_PRIO);
 }
+extern int
+tracepoint_probe_override(struct tracepoint *tp, void *probe, void *data,
+			  const char *func_replaced);
 extern void
 for_each_kernel_tracepoint(void (*fct)(struct tracepoint *tp, void *priv),
 		void *priv);
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 233de8677382..cd3d889fe634 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1071,6 +1071,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 	BPF_PROG_TYPE_NETFILTER,
+	BPF_PROG_TYPE_RAW_TRACEPOINT_OVERRIDE,
 	__MAX_BPF_PROG_TYPE
 };
 
@@ -1707,6 +1708,7 @@ union bpf_attr {
 		__u32		prog_fd;
 		__u32		:32;
 		__aligned_u64	cookie;
+		__aligned_u64	probe_name;
 	} raw_tracepoint;
 
 	struct { /* anonymous struct for BPF_BTF_LOAD */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3f178a0f8eb1..e360062db34e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4092,14 +4092,16 @@ static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *pro
 #endif /* CONFIG_PERF_EVENTS */
 
 static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
-				  const char __user *user_tp_name, u64 cookie,
+				  const char __user *user_tp_name,
+				  const char __user *user_probe_name,
+				  u64 cookie,
 				  enum bpf_attach_type attach_type)
 {
 	struct bpf_link_primer link_primer;
 	struct bpf_raw_tp_link *link;
 	struct bpf_raw_event_map *btp;
-	const char *tp_name;
-	char buf[128];
+	const char *tp_name, *probe_name;
+	char buf[128], probe[128];
 	int err;
 
 	switch (prog->type) {
@@ -4124,6 +4126,17 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
 		buf[sizeof(buf) - 1] = 0;
 		tp_name = buf;
 		break;
+	case BPF_PROG_TYPE_RAW_TRACEPOINT_OVERRIDE:
+		if (strncpy_from_user(buf, user_tp_name, sizeof(buf) - 1) < 0)
+			return -EFAULT;
+		buf[sizeof(buf) - 1] = 0;
+		tp_name = buf;
+
+		if (strncpy_from_user(probe, user_probe_name, sizeof(probe) - 1) < 0)
+			return -EFAULT;
+		probe[sizeof(probe) - 1] = 0;
+		probe_name = probe;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -4149,7 +4162,10 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
 		goto out_put_btp;
 	}
 
-	err = bpf_probe_register(link->btp, link);
+	if (prog->type == BPF_PROG_TYPE_RAW_TRACEPOINT_OVERRIDE)
+		err = bpf_probe_override(link->btp, link, probe_name);
+	else
+		err = bpf_probe_register(link->btp, link);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
 		goto out_put_btp;
@@ -4162,12 +4178,12 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
 	return err;
 }
 
-#define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.cookie
+#define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.probe_name
 
 static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 {
 	struct bpf_prog *prog;
-	void __user *tp_name;
+	void __user *tp_name, *probe_name;
 	__u64 cookie;
 	int fd;
 
@@ -4180,7 +4196,9 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 
 	tp_name = u64_to_user_ptr(attr->raw_tracepoint.name);
 	cookie = attr->raw_tracepoint.cookie;
-	fd = bpf_raw_tp_link_attach(prog, tp_name, cookie, prog->expected_attach_type);
+	probe_name = u64_to_user_ptr(attr->raw_tracepoint.probe_name);
+	fd = bpf_raw_tp_link_attach(prog, tp_name, probe_name,
+				    cookie, prog->expected_attach_type);
 	if (fd < 0)
 		bpf_prog_put(prog);
 	return fd;
@@ -5565,7 +5583,8 @@ static int link_create(union bpf_attr *attr, bpfptr_t uattr)
 			goto out;
 		}
 		if (prog->expected_attach_type == BPF_TRACE_RAW_TP)
-			ret = bpf_raw_tp_link_attach(prog, NULL, attr->link_create.tracing.cookie,
+			ret = bpf_raw_tp_link_attach(prog, NULL, NULL,
+						     attr->link_create.tracing.cookie,
 						     attr->link_create.attach_type);
 		else if (prog->expected_attach_type == BPF_TRACE_ITER)
 			ret = bpf_iter_link_attach(attr, uattr, prog);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 606007c387c5..1e965517ba05 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1998,6 +1998,14 @@ const struct bpf_verifier_ops raw_tracepoint_writable_verifier_ops = {
 const struct bpf_prog_ops raw_tracepoint_writable_prog_ops = {
 };
 
+const struct bpf_verifier_ops raw_tracepoint_override_verifier_ops = {
+	.get_func_proto  = raw_tp_prog_func_proto,
+	.is_valid_access = raw_tp_writable_prog_is_valid_access,
+};
+
+const struct bpf_prog_ops raw_tracepoint_override_prog_ops = {
+};
+
 static bool pe_prog_is_valid_access(int off, int size, enum bpf_access_type type,
 				    const struct bpf_prog *prog,
 				    struct bpf_insn_access_aux *info)
@@ -2307,6 +2315,29 @@ BPF_TRACE_DEFN_x(10);
 BPF_TRACE_DEFN_x(11);
 BPF_TRACE_DEFN_x(12);
 
+int bpf_probe_override(struct bpf_raw_event_map *btp,
+		       struct bpf_raw_tp_link *link,
+		       const char *probe_name)
+{
+	struct tracepoint *tp = btp->tp;
+	struct bpf_prog *prog = link->link.prog;
+
+	if (!probe_name)
+		return -EINVAL;
+
+	/*
+	 * check that program doesn't access arguments beyond what's
+	 * available in this tracepoint
+	 */
+	if (prog->aux->max_ctx_offset > btp->num_args * sizeof(u64))
+		return -EINVAL;
+
+	if (prog->aux->max_tp_access > btp->writable_size)
+		return -EINVAL;
+
+	return tracepoint_probe_override(tp, (void *)btp->bpf_func, link, probe_name);
+}
+
 int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_raw_tp_link *link)
 {
 	struct tracepoint *tp = btp->tp;
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 62719d2941c9..3b8317306edc 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -14,6 +14,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/task.h>
 #include <linux/static_key.h>
+#include <linux/kallsyms.h>
 
 enum tp_func_state {
 	TP_FUNC_0,
@@ -130,6 +131,121 @@ static void debug_print_probes(struct tracepoint_func *funcs)
 		printk(KERN_DEBUG "Probe %d : %pSb\n", i, funcs[i].func);
 }
 
+static struct tracepoint_func *
+find_func_to_override(struct tracepoint_func *funcs,
+		      unsigned long probe_addr)
+{
+	int iter;
+
+	if (!funcs)
+		return NULL;
+
+	for (iter = 0; funcs[iter].func; iter++) {
+		if ((unsigned long)funcs[iter].func == probe_addr)
+			return &(funcs[iter]);
+	}
+
+	return NULL;
+}
+
+static struct tracepoint_func_snapshot *
+find_func_snapshot(struct tracepoint_func_snapshot **ss,
+		   struct tracepoint_func *func,
+		   bool *is_override)
+{
+	int iter;
+	struct tracepoint_func_snapshot *shots;
+
+	shots = *ss;
+	if (!shots)
+		return NULL;
+
+	for (iter = 0; shots[iter].override.func; iter++) {
+		if (shots[iter].override.func == func->func &&
+		   shots[iter].override.data == func->data) {
+			*is_override = true;
+			return &(shots[iter]);
+		}
+
+		if (shots[iter].orig.func == func->func &&
+		   shots[iter].orig.data == func->data) {
+			*is_override = false;
+			return &(shots[iter]);
+		}
+	}
+
+	return NULL;
+}
+
+static void drop_func_snapshot(struct tracepoint_func_snapshot **ss,
+			       struct tracepoint_func_snapshot *drop)
+{
+	struct tracepoint_func_snapshot *old, *new;
+	int nr_snapshots;	/* Counter for snapshots */
+	int iter;		/* Iterate over old snapshots */
+	int idx = 0;		/* Index of snapshot to drop */
+
+	old = *ss;
+	if (!old)
+		return;
+
+	for (nr_snapshots = 0; old[nr_snapshots].override.func; nr_snapshots++) {
+		if (&(old[nr_snapshots]) == drop)
+			idx = nr_snapshots;
+	}
+
+	if (nr_snapshots == 0) {
+		kfree(old);
+		*ss = NULL;
+		return;
+	}
+
+	new = kmalloc_array(nr_snapshots, sizeof(struct tracepoint_func_snapshot), GFP_KERNEL);
+	if (!new) {
+		for (iter = idx; iter < nr_snapshots - 1; iter++)
+			old[iter] = old[iter + 1];
+		memset(&(old[nr_snapshots - 1]), 0, sizeof(struct tracepoint_func_snapshot));
+	} else {
+		int j = 0;
+
+		for (iter = 0; iter < nr_snapshots; iter++) {
+			if (iter != idx)
+				new[j++] = old[iter];
+		}
+		kfree(old);
+		*ss = new;
+	}
+}
+
+static int save_func_snapshot(struct tracepoint_func_snapshot **ss,
+			      struct tracepoint_func *new_func,
+			      struct tracepoint_func *old_func)
+{
+	struct tracepoint_func_snapshot *old, *new;
+	int nr_shots = 0;	/* Counter for old snapshots */
+	int total;		/* Total count of new snapshots */
+
+	old = *ss;
+	if (old)
+		while (old[nr_shots].override.func)
+			nr_shots++;
+
+	/* + 2 : one for new snapshot, one for NULL snapshot */
+	total = nr_shots + 2;
+	new = kmalloc_array(total, sizeof(struct tracepoint_func_snapshot), GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	memcpy(new, old, nr_shots * sizeof(struct tracepoint_func_snapshot));
+	new[nr_shots].orig = *old_func;
+	new[nr_shots].override = *new_func;
+	new[nr_shots + 1].override.func = NULL;
+
+	*ss = new;
+	kfree(old);
+	return 0;
+}
+
 static struct tracepoint_func *
 func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
 	 int prio)
@@ -412,6 +528,52 @@ static int tracepoint_remove_func(struct tracepoint *tp,
 	return 0;
 }
 
+static int tracepoint_override_func(struct tracepoint *tp,
+				    struct tracepoint_func *func,
+				    struct tracepoint_func *func_override)
+{
+	int ret = tracepoint_remove_func(tp, func);
+
+	return ret ? : tracepoint_add_func(tp, func_override,
+					   func_override->prio, false);
+}
+
+static int tracepoint_restore_func(struct tracepoint *tp,
+				   struct tracepoint_func *func,
+				   struct tracepoint_func *func_restore)
+{
+	int ret = tracepoint_remove_func(tp, func);
+
+	return ret ? : tracepoint_add_func(tp, func_restore,
+					   func_restore->prio, false);
+}
+
+int tracepoint_probe_override(struct tracepoint *tp, void *probe,
+			      void *data, const char *probe_name)
+{
+	struct tracepoint_func tp_func;
+	struct tracepoint_func *target_func;
+	unsigned long probe_addr;
+	int ret;
+
+	probe_addr = kallsyms_lookup_name(probe_name);
+	mutex_lock(&tracepoints_mutex);
+	target_func = find_func_to_override(tp->funcs, probe_addr);
+	if (!target_func)
+		return -ESRCH;
+	tp_func.func = probe;
+	tp_func.data = data;
+	tp_func.prio = target_func->prio;
+	ret = save_func_snapshot(&(tp->snapshot), &tp_func, target_func);
+	if (ret)
+		goto unlock;
+
+	ret = tracepoint_override_func(tp, target_func, &tp_func);
+unlock:
+	mutex_unlock(&tracepoints_mutex);
+	return ret;
+}
+
 /**
  * tracepoint_probe_register_prio_may_exist -  Connect a probe to a tracepoint with priority
  * @tp: tracepoint
@@ -496,12 +658,38 @@ EXPORT_SYMBOL_GPL(tracepoint_probe_register);
 int tracepoint_probe_unregister(struct tracepoint *tp, void *probe, void *data)
 {
 	struct tracepoint_func tp_func;
+	struct tracepoint_func_snapshot *shot;
 	int ret;
+	bool is_override;	/* whether probe is an overriding func */
 
 	mutex_lock(&tracepoints_mutex);
 	tp_func.func = probe;
 	tp_func.data = data;
-	ret = tracepoint_remove_func(tp, &tp_func);
+
+	shot = find_func_snapshot(&(tp->snapshot), &tp_func, &is_override);
+	if (!shot) {
+		ret = tracepoint_remove_func(tp, &tp_func);
+	} else {
+		/* unregister probe rengistered by raw_tracepoint_open,
+		 * restore to original tp_func.
+		 *
+		 * 1. restore orig func from snapshot.
+		 * 2. remove snapshot.
+		 */
+		if (is_override)
+			ret = tracepoint_restore_func(tp, &tp_func, &(shot->orig));
+		/* unregister orig probe registered by register_trace_*.
+		 *
+		 * 1. remove curr probe func(registered by raw_tracepoint_open)
+		 *    from tp->funcs.
+		 * 2. remove snapshot.
+		 */
+		else
+			ret = tracepoint_remove_func(tp, &(shot->override));
+		if (!ret)
+			drop_func_snapshot(&(tp->snapshot), shot);
+	}
+
 	mutex_unlock(&tracepoints_mutex);
 	return ret;
 }
-- 
2.43.0


