Return-Path: <linux-kselftest+bounces-41661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06732B7D189
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A8F7A81AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 07:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA21289E21;
	Wed, 17 Sep 2025 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hSvnNj39"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013037.outbound.protection.outlook.com [52.101.127.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9853016F8;
	Wed, 17 Sep 2025 07:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758093822; cv=fail; b=CUwRye8mjkFHdx+kxUdlDrQ6wnMKrVonibqshivnMk6NFbmjWydL4D44GhwlEIDOy8kSXk1nhHfvpK1Uda9pcJgBLoyAw8cgqaMCpNLOR2MDObPNQ/mW18RYxfZfUnFxE2SZZVR1+pyBHHUND/SnqqOzi6JtI6SM+37DhPS7Uoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758093822; c=relaxed/simple;
	bh=Z0gekOetFarjFG0A4pRwAAS2344RzODgv8vdt3u9U+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uVLgPPy9xpptLnP0Z90uPMAOhEFqgM4e65lW+bIvz7d5E1LkBOFcQyKJbL/+5Ioz273SEAXpl31zzmH+H21l2y/d/rIaB6T838FK+2pzE589K4aSZtHO2rPHSmn5SYQU67BxGp3NwDcMRZqfgKRqGpwbSU3fzS9lFeTZ2MZV5to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hSvnNj39; arc=fail smtp.client-ip=52.101.127.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5u+K5r6eaxF1Ggp8N7YZHlhLuHI4gUFo8ynrc1xWqnFSg4Mn+lAYTrolxt+ZA9dG+CcjZeGiH7kx1VQpuR1x/n4q+sFFR/OIKjQZL2xc3gNYc0nWbAUGQhi8gLuGkTa7PxLhSIBan+SJtAzIWEfDfBes7QvDWfGITP99VFGnTjMpH8n0sIDRC1yJihoNnPg67ctRSCuCFMyhkCunF2EqJVslekEz/Fcl2TTCSMKoIu42buwKl5jFZ1HBiKRP7e6LyKz7N3R9o0FKxOrCUjPCxku4uYVyqdJOREaXznllT/R17SNLzve9ydgJkndez8MZS3qbF6y+tGnrds6snoRqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcSEcLty3kVH7KefJKWuN62WrkncK/xny/4DQYNUGaY=;
 b=s52oYm52BIFmPW9lKqb1mWAdz6ylj7P9vMSa5ZW5PWJdpqGmauqfFh74CBpcYJo6VFqxcew4mEUX8sVnhoeq1cchi/GcMmqHbm9Aj5rr2mtKCB2pGxfstQuMe3Aibx18EdiIFN6U3R6PsoVQ6iHT33Li6MEocM2HNfiAMoO1oJ9yibM0b2i6Q4mHgDeBP+abwMjNgIb9RKJu99sEzNZl1E6hsujoYxwQnAzW1dntAZrLNfLWs8htTJdR/LYFdDZ3ffjGGHTCfrhWJcKPIIWjZU2wrDfH/juv4piZ5aTV1sVuNOzWrnXsk20FVpzT26F1fOoOZzYnD/1/yWzrsWXoGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcSEcLty3kVH7KefJKWuN62WrkncK/xny/4DQYNUGaY=;
 b=hSvnNj39WOfMWNPt9TqmuOtoABM2G/pLOf/vgQ6GtzphLvwC4q3IIzYpL0qdscl4YIpqHwgQXD5z4lu9nrKtnSyB69GNU+hoy+0VNM4C+Vysvu2PoViO8PN3AIArBEAeE5/5Y2IpTslxWuIrcyj4MNZE8HYpvkoFOHUzuOgtMYTTFpT0BT3wFNkm2fyvcO6InnuUs+8LzAnup3kJFLTRKSQ2cycH47pkEUcvyFfEbGFYPnzJMdAFzP/AbNwk2beY986I2dwiCzPa+MEO8cC08YbvBbiLJtzLqHZbHfq/KcXULuKE6DjTN4L5yINMK+o/GotmU7aZ10wEbxZyfk3Jmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by PS1PPF56C578557.apcprd06.prod.outlook.com (2603:1096:308::24f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Wed, 17 Sep
 2025 07:23:35 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%4]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 07:23:35 +0000
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
Subject: [RFC PATCH bpf-next v1 2/3] libbpf: Add support for BPF_PROG_TYPE_RAW_TRACEPOINT_OVERRIDE
Date: Wed, 17 Sep 2025 15:22:41 +0800
Message-ID: <20250917072242.674528-3-zhaofuyu@vivo.com>
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
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|PS1PPF56C578557:EE_
X-MS-Office365-Filtering-Correlation-Id: 24256d5e-2c43-4f5a-08b1-08ddf5bb1d11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5T93MRoFK7TrlTc1yhYwCHOaeY480kpByXYQPe8haq6p1g8NxTI3MGzGbQJ3?=
 =?us-ascii?Q?+g2d9+OEHw/bCr50LdTTOVBa6lVXeOOK9VcDvEjKFvZzut+nUJoLtoVnQcCU?=
 =?us-ascii?Q?xmETJpzSCwK4wMb85wAV04eJkM9hWN4xbfhZeAG0Hj8dkjkSR8qQTgDAFTge?=
 =?us-ascii?Q?SFssVQEB9VFJmUgA+KABEe67l4hNzP5nsL1DF9VdGMq647zBOHgFDXgj6kxq?=
 =?us-ascii?Q?dwZ3LiADUgPq0lO1ySZmdbI4dkEhjQe7iC6eI1c0+9yopfg7ArfF8UIN1bDU?=
 =?us-ascii?Q?BHIeexPX/Hd5eZEVGeJp7NXpcRBwnnqaC1ysMA5t2uFZEeH4EN4G6HsXuRZF?=
 =?us-ascii?Q?NNBPW7u35H59P40BfQa8qqLTZpSlIrHq+OJ+sQEBDYtfLit5y2tFEIZEdMfd?=
 =?us-ascii?Q?Tapu3Saqhs+VtDgplq1LZOVSIaILj9cFUkMBRl7OFZNZ8iBAHoTx3MGTRbO+?=
 =?us-ascii?Q?8qih6seRqNgc1uDgeEyOBNwyoTq3Dq08GNP1JICOBS0DUua4RY0qrtCISWUN?=
 =?us-ascii?Q?sx3rpEkgYp5xE1OpwYiOuQKVNU4cLzGqb8AswoBEH0QnXje5C62j9pkuQ7la?=
 =?us-ascii?Q?FlUkYE9OwRnCnYerLRMFvS+3KYR6mY4k1owK+mPu00iciZ/WbckrcLGlTS0B?=
 =?us-ascii?Q?gGChYQraT86ozpHg/3kuhkw4JQL6BUChCxydau2P1M1F/EQ0GGxrs6V5mV4E?=
 =?us-ascii?Q?86jnIpjxXkRSMuIcGqNAJkiw2ws58+LaHrnLrOofMC6jrySKSB/+3mYg0Zxi?=
 =?us-ascii?Q?aOgcGBG9oaxWqzH2bRbGLt+SNUjpu7nF7KQTWeclKvAckjItvpeFoinz/fYV?=
 =?us-ascii?Q?+STUnmZ0ERuW3+1ehcDwJOjrDYwwfMHa4ZYb/Bgc6ojv3DMw2FYrdjy6MPAd?=
 =?us-ascii?Q?UOB1vAqt+sDo9qbP8x9lL72a1al2YJDCQT0cE/NRBMPdPN6m+rY4gfFMO9vz?=
 =?us-ascii?Q?gLbCb4JcxILmZLWiCJ5YGUExTMPImpFsOd5Mp3fYIO96GdXb8TTa7EWRCF1/?=
 =?us-ascii?Q?UBU72UqH7mAMBha381pga+GLSB++y5XJA7DyalM7iyVju4KEpGIR7/tCs8HZ?=
 =?us-ascii?Q?Z2Ar9UFkSY+TWrFX9cTqyb+o6JGn/b4fC9douzSHXvziY/zNfU1tvlAlEqeM?=
 =?us-ascii?Q?PtivBE55KDnAeCDL38hqmIX5rfgVcCCUfKuLfG6HLFEPya5GE4xwZVjOfXoJ?=
 =?us-ascii?Q?9RUU+ykxG4Zbq1HUo6UQ99Lwyd4qBSvdGWn3SrypDqZIFe+lfukGlCG96eqb?=
 =?us-ascii?Q?lmlDGjPpRjAK7NA5d68NVf5xwhDVJG/0CNPWs+m88cHk4xNqDXPWeYie8+XI?=
 =?us-ascii?Q?LLPl8Izh4FAhacr0V9LwGvZR8JvNcC0FhO2BpXQVPRSNFL2A/Egp7h1Qtcdc?=
 =?us-ascii?Q?0/XnyayHtc4ZHq9bZeNaF7hBBCbrID6n5cDz9o/q/3DIilfSHqQw94EewPIs?=
 =?us-ascii?Q?m7F3UngFqC9+e2Ri43xn/Bxu75d53GcI7hkyUyIOkFsKlP2ASnxHw9nwQ7CW?=
 =?us-ascii?Q?HuO0vnAgXsfVM3c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BOZs8lR7f2/OOV7LTxwdgmxg2SDdMeTkfZI96d6fHooDZxS5/pcmU0qdmhr8?=
 =?us-ascii?Q?2/w7kpnObar9VjXLHBFkvjnmC36puFTjCOfwEoOhp2/YGycQQ1s+trEFg5Dz?=
 =?us-ascii?Q?EWoNC1QJtRmJfNA6l1BOJosX9KAfwQydTmVvVUzVe6lVbGdwFMA0eYVo/ZQ8?=
 =?us-ascii?Q?74qw/lrdiAuczrCu7t+4Rf806NYAn0zaYs8XGp5HKR+I8XUzNNkuAH6/vVc5?=
 =?us-ascii?Q?9aJULHpS/I/jbBKw/5LcCS51eg1pjGsQkK4TByCkXyPsYOhn75/DgFJkd796?=
 =?us-ascii?Q?MDlsFwV+iffCJWWfMBdf/u1Ezc4IK/0+haU56p4TDLvS8uPoElVVIWEjbnEa?=
 =?us-ascii?Q?G2ykjbpwfHXNkwy3Nm5xngLyml4PanuYnJfDmsW6olzHLIeVKup4yuD2uzJv?=
 =?us-ascii?Q?15U0hIWe9Y6si8XXuuA08Rwuw7k5xDj5yZTF8vV4lWBJ9okwjvbwcEhLDJNU?=
 =?us-ascii?Q?+bZf0AV6jh56uQmwwTWYN8HUSR5FiS/zw6rYbHMhud/Kd+hpVoon8Iv4EBdk?=
 =?us-ascii?Q?ByD//BBnHHZc6bC87oPs78bHToIGcoDdUlzFVpC6g4haPM0grWE7A3wWlwKW?=
 =?us-ascii?Q?JcFlnC8zSjLuD34cbOXbxQjMxrzqRNeiQKjUNxSxE66mVErq4Ty5zrEcZ4Cn?=
 =?us-ascii?Q?Jp7vw4YgfAYaiSX1FlSK5GTwwUwrECJdqxX6IrxtSF8W2R/gt+TKfc1eDW7B?=
 =?us-ascii?Q?WRju4R8s3+tuKZ5mZNZMVf2voSei9aJtZ+FrP/6kIfzFjNqh2qdriyoGVtzr?=
 =?us-ascii?Q?RqVKJ5GtHXRIvzBni8iB4Cm3bONSknDjCGNCBHIsK6gxciGfOG+HL3erFnoP?=
 =?us-ascii?Q?hO6eb5XfbIjZJ15sDhcwlemxqj3CUzw0a8O5lw41DWCQYas5qrtb00e3P/hG?=
 =?us-ascii?Q?fGHoAf5ytl1wsyy4T8kLoCNlHb5a6dAsvXO3KH14UdfAi394u4dB7USdCE6c?=
 =?us-ascii?Q?ksAL5WpXCQ3GzXHlyK6OJVAQvut3K0BFk6xPDIuifqMe5MMrbnYVTqfk48oO?=
 =?us-ascii?Q?De7RWqMykmSKUAcctsB2MhkJg/UQgiIl/iazXWwqdZXmT1H/x5qDH9my6N0N?=
 =?us-ascii?Q?qYjkcwgs0dNgbHug860kSkds6gUXBCkzMvOpC2UOBkvboJ8tHdVi24KTUMll?=
 =?us-ascii?Q?qW8lZJlKivExNfeEv59POsCCspNO2oZC/Fdlg2j5NZTn+WOg1wmWV36Sje/I?=
 =?us-ascii?Q?iQKKIidWbfDj7cntfMrwNFc8glI4yXsjbiDh1jXIBeebl/pwQWxLy5bqXzaE?=
 =?us-ascii?Q?XU/WsjUsl6ZQh1+MEwrG+KYq1UmLfhIL9RXatYxsSWOtZKN1EFko/K1oQ0oD?=
 =?us-ascii?Q?bkMSpE85qWAexXg0cRNNEia2Bltu41QklVehezQuVWIX7BxS0BPXgZImu+tM?=
 =?us-ascii?Q?75zo8lPZub2p6ujcMPvFEv507KSWFxXgfEk8SWeWwhuVfp7uLCI/VI/jdZOv?=
 =?us-ascii?Q?inlv0Gu3Uc4CCA37DaWQXpib9EPt90cm0tbBvwOQ4SyMQ2URWwYprn3Pi2ty?=
 =?us-ascii?Q?vMZZEx6q1phYa1HM2NdokIrXtLwKyVumeyA0TP9oQsHRBDDRFNIUrZcaqoLU?=
 =?us-ascii?Q?Gu7lzl3ET3cyFMIFDCmTWm9oYs3hR0LcHQAKfvxA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24256d5e-2c43-4f5a-08b1-08ddf5bb1d11
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 07:23:35.4063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XVRpXHmARkNmEzy94q8sWCSRjKk5X2Z/0HJdEb76R87X7ALOnNe0GvqZcxQBka5ND9+yfJBq4Hv/U0xBnTjndw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF56C578557

Extend libbpf to support the new BPF_PROG_TYPE_RAW_TRACEPOINT_OVERRIDE
program type, making it available to user space applications through
the standard libbpf API.

Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
---
 tools/include/uapi/linux/bpf.h |  2 ++
 tools/lib/bpf/bpf.c            |  1 +
 tools/lib/bpf/bpf.h            |  3 ++-
 tools/lib/bpf/libbpf.c         | 27 ++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf.h         |  3 ++-
 5 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 233de8677382..7438836b3e4b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
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
+		__aligned_u64   probe_name;
 	} raw_tracepoint;
 
 	struct { /* anonymous struct for BPF_BTF_LOAD */
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index ab40dbf9f020..95b73f94ce72 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1235,6 +1235,7 @@ int bpf_raw_tracepoint_open_opts(int prog_fd, struct bpf_raw_tp_opts *opts)
 	attr.raw_tracepoint.prog_fd = prog_fd;
 	attr.raw_tracepoint.name = ptr_to_u64(OPTS_GET(opts, tp_name, NULL));
 	attr.raw_tracepoint.cookie = OPTS_GET(opts, cookie, 0);
+	attr.raw_tracepoint.probe_name = ptr_to_u64(OPTS_GET(opts, probe_name, NULL));
 
 	fd = sys_bpf_fd(BPF_RAW_TRACEPOINT_OPEN, &attr, attr_sz);
 	return libbpf_err_errno(fd);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 7252150e7ad3..0ebedbd99fe5 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -630,9 +630,10 @@ struct bpf_raw_tp_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 	const char *tp_name;
 	__u64 cookie;
+	const char *probe_name;
 	size_t :0;
 };
-#define bpf_raw_tp_opts__last_field cookie
+#define bpf_raw_tp_opts__last_field probe_name
 
 LIBBPF_API int bpf_raw_tracepoint_open_opts(int prog_fd, struct bpf_raw_tp_opts *opts);
 LIBBPF_API int bpf_raw_tracepoint_open(const char *name, int prog_fd);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fe4fc5438678..ce67c917ba59 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9557,6 +9557,8 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("raw_tp+",		RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
 	SEC_DEF("raw_tracepoint.w+",	RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
 	SEC_DEF("raw_tp.w+",		RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
+	SEC_DEF("raw_tracepoint.o+",	RAW_TRACEPOINT_OVERRIDE, 0, SEC_NONE, attach_raw_tp),
+	SEC_DEF("raw_tp.o+",		RAW_TRACEPOINT_OVERRIDE, 0, SEC_NONE, attach_raw_tp),
 	SEC_DEF("tp_btf+",		TRACING, BPF_TRACE_RAW_TP, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("fentry+",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("fmod_ret+",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF, attach_trace),
@@ -12684,6 +12686,7 @@ bpf_program__attach_raw_tracepoint_opts(const struct bpf_program *prog,
 
 	raw_opts.tp_name = tp_name;
 	raw_opts.cookie = OPTS_GET(opts, cookie, 0);
+	raw_opts.probe_name = OPTS_GET(opts, probe_name, NULL);
 	pfd = bpf_raw_tracepoint_open_opts(prog_fd, &raw_opts);
 	if (pfd < 0) {
 		pfd = -errno;
@@ -12704,14 +12707,18 @@ struct bpf_link *bpf_program__attach_raw_tracepoint(const struct bpf_program *pr
 
 static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link)
 {
+	LIBBPF_OPTS(bpf_raw_tracepoint_opts, raw_opts);
 	static const char *const prefixes[] = {
 		"raw_tp",
 		"raw_tracepoint",
 		"raw_tp.w",
 		"raw_tracepoint.w",
+		"raw_tp.o",
+		"raw_tracepoint.o",
 	};
 	size_t i;
 	const char *tp_name = NULL;
+	char *dup = NULL, *sep = NULL;
 
 	*link = NULL;
 
@@ -12739,7 +12746,25 @@ static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf
 		return -EINVAL;
 	}
 
-	*link = bpf_program__attach_raw_tracepoint(prog, tp_name);
+	if (prog->type == BPF_PROG_TYPE_RAW_TRACEPOINT_OVERRIDE) {
+		dup = strdup(tp_name);
+		if (!dup)
+			return -ENOMEM;
+
+		sep = strchr(dup, ':');
+		if (!sep) {
+			free(dup);
+			return -EINVAL;
+		}
+		*sep = '\0';
+
+		tp_name = dup;
+		raw_opts.probe_name = sep + 1,
+		*link = bpf_program__attach_raw_tracepoint_opts(prog, tp_name, &raw_opts);
+		free(dup);
+	} else {
+		*link = bpf_program__attach_raw_tracepoint(prog, tp_name);
+	}
 	return libbpf_get_error(*link);
 }
 
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 2e91148d9b44..f4e9cb819b75 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -820,9 +820,10 @@ bpf_program__attach_tracepoint_opts(const struct bpf_program *prog,
 struct bpf_raw_tracepoint_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 	__u64 cookie;
+	const char *probe_name;
 	size_t :0;
 };
-#define bpf_raw_tracepoint_opts__last_field cookie
+#define bpf_raw_tracepoint_opts__last_field probe_name
 
 LIBBPF_API struct bpf_link *
 bpf_program__attach_raw_tracepoint(const struct bpf_program *prog,
-- 
2.43.0


