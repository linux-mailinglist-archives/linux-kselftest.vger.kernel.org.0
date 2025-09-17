Return-Path: <linux-kselftest+bounces-41659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CEDB7CE56
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB8F04E313E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 07:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BCC3016EE;
	Wed, 17 Sep 2025 07:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="eIZjr0wp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013000.outbound.protection.outlook.com [40.107.44.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA3D27AC41;
	Wed, 17 Sep 2025 07:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758093817; cv=fail; b=FrMO1fWr5Ghdd9gDT0XV8RFQe8BdesAuO1G0exg2ypJDRKX0KGWd2y+dKlu8RmVWsuuCpIK6r6w5aMaWMCZIhgsdc25kZq7yQ6zusYCX0KINcQRnjz2ujOiGC05gOjXN1tIdDxBpRCR40bf984nxrqCVb4jf0/z/NIWcMKwMCZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758093817; c=relaxed/simple;
	bh=0FxnngNjyBdTV6Tcf2EnHHMLAWWN5FtWHR2mbWkk4iM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZkTwgfCH1ONqkUXsZnOjaskiqS48WROJp7/62NkJptQ7iZE5JmQDSZB0yz3yuH6KafQ4MJfRmJijTxu/gWJcPfDVZF3dXzmKdhSHviOXnPI56GNFWxsrC+bA8fqWAtUQMvbwj05Hd8d9OYGUvgQpr3tRBkgZ25r6mk1gluWk7jY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=eIZjr0wp; arc=fail smtp.client-ip=40.107.44.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PS93NAvqDvk4T5pX/3uXU4IbjA21r612nhKKrKC6NMziEcNFLECsmCE6Pr/iheiYgPQ1RYJIkoBTwvyPrKd/KrYT1vmcZY44N/cb3fuyT+v+ESXwtIKklWxCdrQ2JMKbA4y+3GnXDiC+3bQzsfcFWux0uRCuLcnkvOR4Lsj6+omBbjbJOdblElMqJ+SxJjrtK+xeT/REG49qBPxpuTK65UvzRbOy0w5FDu7AHZHEG7xKjiLilpq8O8rHpcVdHGQtm+aKIp2TFHaVmv0uVlaNZoyR8e84aoVj6KrYLvLO+3tx9FC1iSxXB3/iXDLTlWUJfijP/jE09PiI0EK60Kx1rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kMjQ//aytmUsVOT96ZknqMmVLVUk8goFOHUmHe6rkA=;
 b=zPPUUomcyTTIRIIMu1iN/bM5qETa4qKu4n7WFLJ9ywcEXy+gxLkliI2g07Skjjo8d/z5DB38C7S1UAZnjlL29Q4sYW2l3f0AJ4x20TSb1bxHoe2XKweRtCr3jePZ7nJ3rHPev0Ze7D1PXttindTdA6hmNu2WrSiQCuhlPKZhis7cHR79sANMbZFYfIZoCJMfH6ou3gWyK2HxGgD51W9LF3u8FVdBg6zsgMr6S0ZNm3eUdVx6F0LBAY6+wf1rJhVHByBb3aLSlVP+/W9Im10gCxQpmy+ubtT6De01gWvFCsvWwFam9oTQ8iTS0shWwDRhVklvzPlJ/BrrbpWWGPOBLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kMjQ//aytmUsVOT96ZknqMmVLVUk8goFOHUmHe6rkA=;
 b=eIZjr0wptcdlgfeFA4KpTMnwIY1QhI18IF7UgCFGwFEO49EKKZVOlt0lyfLbNM0RsRIm7ckYZCqJvCKKp9SG+JsnSjedvPBMCJGK5lint90bXKNeDLSBCLE1axcodo4XFFEx8g0MN4ru4a8ymTM/zvl3LCErvYW3argWqymZ4+c1axyuQQy8pe4xlpn21PYdKEzTMS5cOnYX8WaRHovN8GS2Sb1zmxsGFg7pKDqGvW75P+eGLExCPJ8G3EgokO7yqcyJTdiLmctOoqBH0Yk9b9Rpl4EtVsIfQ+ukmGacr3a8Zcu9UICr2w5Gthmze0Pi/6I+nMz4jrCf5KZfDazKRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by KL1PR06MB6043.apcprd06.prod.outlook.com (2603:1096:820:d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 17 Sep
 2025 07:23:28 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%4]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 07:23:27 +0000
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
Subject: [RFC PATCH bpf-next v1 0/3] bpf: Add BPF program type for overriding tracepoint probes
Date: Wed, 17 Sep 2025 15:22:39 +0800
Message-ID: <20250917072242.674528-1-zhaofuyu@vivo.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-Office365-Filtering-Correlation-Id: 0c71d168-3b19-4853-525b-08ddf5bb1861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eIIl6QPhAWFPbwxIEp7aJZaTxoQekuMEvqNCLotmIOCdT+MvPPrNSG6R35do?=
 =?us-ascii?Q?tutgW0nqtCeUa+XYtoZ13UACbrceKdOn3VStxN2UqoQQF2tVMwcFHtd+bRRB?=
 =?us-ascii?Q?JV7uyrBICaX4aiqm5In1b9+IJrpNBUbA1TCHQ1eNxypet4BdbGXEj6M5X4YB?=
 =?us-ascii?Q?xtQHV4jTnt2q8WTwT7moI91MRBdMJo96sR6WzGThW+RORxwcKdiRI1CBySnB?=
 =?us-ascii?Q?deSvT3fBGPSfGEkyzXSIBYLqBjdIIaxKUyFcBaHv0Auw/L2KlOV8k3ADsXky?=
 =?us-ascii?Q?fYpSHRwtz/jrvUyd1hW+Jp8f0FRf8ClPutASJ7ZMp3nSqLpR1Hye/zkcdP5D?=
 =?us-ascii?Q?xLsLLCrmRA241TeOi0+mDq2CINWbptvxBiDP/XFV8T1bW5z5/DP3Ff/v+Rfm?=
 =?us-ascii?Q?f6J1es5i/cLALv/uwJAKJGi+tNhMZA1auY5emQSJOf4bPogWDgakD/KzPvzw?=
 =?us-ascii?Q?qkU1sh/nMzua8YZBKWb15wSpGh75iqfsxoEi5E9xx7zYH2LzX5YK+pCU1N+2?=
 =?us-ascii?Q?xV4pI+gQ4IIk4M+OLe2fRMSibM68fxfG+atKeSpmF5y7b+GOD+jb1JPGa+aZ?=
 =?us-ascii?Q?ciPwRAcPaMggdVqUV6RX2G3xHAvEjEIygSy6VLyHLpbZ1I6pQtocRX9g7qo2?=
 =?us-ascii?Q?5rIJup2riaQSfG/PD/uTry9vDnUXAJgJcrXpJe+wbiX+mNs9SKOnez00F9wj?=
 =?us-ascii?Q?xQ6XfJ5uEKebaOqZ22P2BkDsJaCw70grJLR8aYuZx7BUjYtrg7LJuapNWbVO?=
 =?us-ascii?Q?KHvM7atvy6G8BovsXmXCGt9ZbdxC4HKBBPUL0Q2S/s9B5+sbyiygJTjmyRqE?=
 =?us-ascii?Q?G+0hKcVS1zsNNaA030oqeXKIuvNZ4TQYt90QcYH/q6J00Up0vszPRi6PoGb3?=
 =?us-ascii?Q?KCz5cC+CGiAW3n1Lf+wWL3NOk7N6Z1Ah0zWnbOen9fwH2TeWfbFzc8bHCvIs?=
 =?us-ascii?Q?1Otnd+2PH8morz2oO82Xiu2gdHnHobL8j6fx4lmCW2PyE6WMbvW9Ece2wt2K?=
 =?us-ascii?Q?t0B1btbnDB3nbgSwdU1ELcyg55SJ1YloLN06Otbch5fJP8TZMJjxdPJcibz1?=
 =?us-ascii?Q?h8lxXAz2d+rLIAoZZj/+17qox9VBS5ixGY7lPoMwU4EXbJGA9w0hPz7QcR1C?=
 =?us-ascii?Q?/rtTrdF3KnHV/bgmaVckiHmuGpP18vPbW+V6aw2tLdUZkikhFdf4ftJqLwKP?=
 =?us-ascii?Q?6KePtoFRdS7xzcRGFJ9XMbKaS1zO9GQeiRhMudlGxpxUzkzF0yrQ+dHCxAAL?=
 =?us-ascii?Q?nkihxsFGAKLU+X7euU+/FLHSxRo5YN/xCc3vsTKwYJ5btYSvmI6AFhgehS/H?=
 =?us-ascii?Q?k16neBQ4FCKA7GUodxDTrI/LOY+Dtd/9bGoaKZ/bYqiC5G9Ajx6BCPD+HMmQ?=
 =?us-ascii?Q?MwzyL/1I4sTp7hMVnBHCbNsbbY6Xw8b65GeT0zECUH5fHvFjlxGz49ZZYmdC?=
 =?us-ascii?Q?u/UkRYNc5XnPttzwJqYeFCHUn4tSmdiVRXs8oSwYf8hgcKEQZfDKjcI47xiz?=
 =?us-ascii?Q?vouuaFxSeBS/WIo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9IwFyHy7ZWC4VLU4Ud1mUSap/tTV1M+aN6PIWo6a3DV+iwkcMgR1IKRPEK/u?=
 =?us-ascii?Q?5JE8heg7bcfNGQ3g9JM5mNudpt51fj4BYPpw8ESEbWS8qPFXqqtI3IFiz3Xp?=
 =?us-ascii?Q?XsjGmjRCVgRW9xl75KZK0TM9M4LdbmNetWapbnC6NAwSuKguM9DfBZ8ZGyKB?=
 =?us-ascii?Q?d4w4UAomA786HOSQjk/b9JY/ttcSYaUObDmgjYFtvvFjv9OuM0HDhHIwrXFe?=
 =?us-ascii?Q?lvNJnq7TjCXk+C5c4DyjFYVh9HCa8HVjkEktXdBQ6sGSe0A8qRXS4kcp9exg?=
 =?us-ascii?Q?BEJ5Ew73Y+5SW7fRPcJPh1ucuVGQXOHSvb2QtmObuZiDXmxNl7CkEwaOnw3V?=
 =?us-ascii?Q?5SCfRBGosaKY/ElW4a8Z9oK2Nd25OgcdkC7YJKKgAvm9oJx6jbJ/4fyea3bv?=
 =?us-ascii?Q?iQ8VvX69gf0FkMZnGJbBFxbEDIFizEwBaJJ3TxzBYBUIp/UMRQ0HCc/zuiIg?=
 =?us-ascii?Q?I5PZbkKCROEdogqGVTVCjTv9ebC0AoIHP/n52WA9Eq7UcORmUYyxgQ7oqxby?=
 =?us-ascii?Q?OSJLtVcsMpNxNpINIbePXsmmMePW7rbHBqV6Z3cyLXLJP8TdswByihoVWd46?=
 =?us-ascii?Q?+sdDEuo6DjbLSXl+IQlWKgUngsyETLFXXJVuUn2W4+MGLly76ABkH7IpZr7B?=
 =?us-ascii?Q?ifua0hRpHYFJENRc+FBgKJ8qepqOjf44/BkwlzWv/KvdlOCnJI4FIBhB8k1p?=
 =?us-ascii?Q?h8nKXXMu/qvKhWUpP+i7CPXXqgEmPsl3OGuZMAs0lnDhSB4Bl76X/ozLIRxE?=
 =?us-ascii?Q?6KUquXv+noCcFBXLQd3NFIS4cGDXPFol1g1U6xJFl7lP30sZBP7dd5JR54Gx?=
 =?us-ascii?Q?0wZFEbH3N6obzh+d5MwsY5ADHH2AJBkRmBgzTWAnUcp4F2E7xiHFfnu8kTST?=
 =?us-ascii?Q?QHQTF7HzM8d9+luhcuPgLKpIuBMp48eksJSM9JRrDTWKwiocc1Vy/cDNyGRY?=
 =?us-ascii?Q?2NemaNTN1bokolQzjN19nnXcEzzLNqTCzFATPFWUfJxXDV6MzxbK+q3Tt/wX?=
 =?us-ascii?Q?ebNfPv2hMYtLEeDEuthUTXtVoWskW8n2s8fjMOJt+9CDrfOJ61dVpY7iIzZG?=
 =?us-ascii?Q?20RWw7Rl2FSK5ZrN+OdLhJm/9rSNo0LQlT3msBP0mAzxLpAllVbVrKXRODU0?=
 =?us-ascii?Q?d9K0X4/B4VpdIVelhWWyk1CcYnrvb3OuCAyTlH+bif9mFoMfLi6THTHa2eg3?=
 =?us-ascii?Q?glTGrkFsa7qtWf3rygX8cNsgH4KTP+Sz7Ki8vn6XOVTs1DbXzp8URnjSvAfo?=
 =?us-ascii?Q?dH2Bsxb5bYPLNe0rA2K/mZR9ysIQnRlKhpk54FcppCypqFQrc6bCqZShwy3/?=
 =?us-ascii?Q?mQT2wv31tuP80nFxrgECIJSyLpzDrCatnoZBIfNTVmhbF8iKZo0SbQhDSx0H?=
 =?us-ascii?Q?yoHzpZ286nXAryQvSKUE2W5ANiHwQgzdWjSq3WZXZLD4Z7/Qvw5sol+m+dkz?=
 =?us-ascii?Q?2iDXWwIAg5DLMWq37TbQmC2VYr0ElETrwPnktMjASICMAJWY6ybFAUlTKmdK?=
 =?us-ascii?Q?T1+khQVJJv/1AEcTbU0haK66XvQ/HTc9yUlVT1AYxvVqhlosHKUmg0JZuB4X?=
 =?us-ascii?Q?zFJHUCCpAWPfNdYiB/1Z8uy69bp9h6ufbAt8XIXa?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c71d168-3b19-4853-525b-08ddf5bb1861
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 07:23:27.6253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UsxrZEKU6y4n4Ms5ZyncZYB9MWDu0hwUYjj4vqh3/RxHUiNaAdYZqNFhPPB7ABEfghWQlXRL0Bad1IU2Vh7qQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6043

Hi everyone,

This patchset introduces a new BPF program type that allows overriding
a tracepoint probe function registered via register_trace_*.

Motivation
----------
Tracepoint probe functions registered via register_trace_* in the kernel
cannot be dynamically modified, changing a probe function requires recompiling
the kernel and rebooting. Nor can BPF programs change an existing
probe function.

Overiding tracepoint supports a way to apply patches into kernel quickly
(such as applying security ones), through predefined static tracepoints,
without waiting for upstream integration.

This patchset demonstrates the way to override probe functions by BPF program.

Overview
--------
This patchset adds BPF_PROG_TYPE_RAW_TRACEPOINT_OVERRIDE program type.
When this type of BPF program attaches, it overrides the target tracepoint
probe function.

And it also extends a new struct type "tracepoint_func_snapshot", which extends
the tracepoint structure. It is used to record the original probe function
registered by kernel after BPF program being attached and restore from it
after detachment. 

Critical steps
--------------

1. Attach: Attach programs via the raw_tracepoint_open syscall.
2. Override: 
   (a) Locate the target probe by `probe_name`.
   (b) Override target probe with the BPF program.
   (c) Save the BPF program and target probe function into "tracepoint_func_snapshot".
3. Restore: When the BPF program is detached, automatically restore
   the original probe function from earlier saved snapshot.

Future work
-----------
This patchset is intended as a first step toward supporting BPF programs
that can override tracepoint probes. The current implementation may not yet
cover all use cases or handle every corner case.

I welcome feedback and suggestions from the community, and will continue to
refine and improve the design based on comments and real-world requirements.

Thanks!
Fuyu

Fuyu Zhao (3):
  bpf: Introduce BPF_PROG_TYPE_RAW_TRACEPOINT_OVERRIDE
  libbpf: Add support for BPF_PROG_TYPE_RAW_TRACEPOINT_OVERRIDE
  selftests/bpf: Add selftest for "raw_tp.o"

 include/linux/bpf_types.h                     |   2 +
 include/linux/trace_events.h                  |   9 +
 include/linux/tracepoint-defs.h               |   6 +
 include/linux/tracepoint.h                    |   3 +
 include/uapi/linux/bpf.h                      |   2 +
 kernel/bpf/syscall.c                          |  35 +++-
 kernel/trace/bpf_trace.c                      |  31 +++
 kernel/tracepoint.c                           | 190 +++++++++++++++++-
 tools/include/uapi/linux/bpf.h                |   2 +
 tools/lib/bpf/bpf.c                           |   1 +
 tools/lib/bpf/bpf.h                           |   3 +-
 tools/lib/bpf/libbpf.c                        |  27 ++-
 tools/lib/bpf/libbpf.h                        |   3 +-
 .../bpf/prog_tests/raw_tp_override_test_run.c |  23 +++
 .../bpf/progs/test_raw_tp_override_test_run.c |  20 ++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |   7 +
 16 files changed, 352 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/raw_tp_override_test_run.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_raw_tp_override_test_run.c

-- 
2.43.0


