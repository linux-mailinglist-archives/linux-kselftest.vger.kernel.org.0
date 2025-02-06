Return-Path: <linux-kselftest+bounces-25937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3335A2ADFD
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 17:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42DC3A4D27
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 16:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9242235353;
	Thu,  6 Feb 2025 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="EjV3fgrm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020085.outbound.protection.outlook.com [52.101.61.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3957235342;
	Thu,  6 Feb 2025 16:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738860112; cv=fail; b=QLXPfl9INh0qIr0sGkD3XvsyaDpxm1aVJzGxwqYRXKfQhIBAXBcKPnbfx7z4DC8QkUxXasg2AGve2OWNdHT0yBM5ojAlLcjcUwb3FHCXQDeaahEYZeBGE7cGcqLtM2NmrxZeJpS+X/cHYd0TTArBbB1C6j6doETUtytaTeU4src=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738860112; c=relaxed/simple;
	bh=iLToX4lG567i1W452Jo6BQNqta3odPq4FFPo1SdLAQw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Z04EuxeKhviPG9whSxowvVG9ioBf6DWHbWjQjVAhXKx8lBPIdqMFZN55RiR6avc72ZDVCaQUM1tNi226HfTnKRBmDZUks3XOkjsf4yD2Penc+Yga2rNctskLiQfbR0xjIpIYCa6udU7t2+zoPXMowEpSS2bdA74lQH82/isuqsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=EjV3fgrm; arc=fail smtp.client-ip=52.101.61.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUr2VfZq4cbKjkkNmkEdFtg95ToqJp8qkrJ4C39n5+bAvG2Uwpv31y99BvMu21OmptA/HUDzkNN5h64nxYhDUKv7l5JJw+60nL8LOJFDDFaNzNUCAyEWMoUoEH2bhqwJguBk2P36LDeo8JMkxy/GmZFUqjvR+NgZaK+xUjLtRZFByJOrzBmvVCpj//F4eP0KTpNmP0MWipJPU5yOYJcgUW/CUjI/2Yqo1fm2IQtv9YFWWCJbtIDSa7TnXZAcVJm8n1TrdgCaXzyP/9WP7llBEkC56u1hdDuXpuAQcUx9Hy4teioavb66RCuln32CVhnDhAZUM+QFW6QxsDwhexI1/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfZjuEkl5hKreGBccwioUYaf8qsXah4M8+oqsbjh5os=;
 b=AStbKRCsYzWivL64TIfKZz5e9001rqYQJyVa7PJG60jzfWHrWgI3nZV1xt6+jyFnSyqKp6qpoTb2m2ctKZ02lyD5FSHSBfPTuDnm8zWn9FoHd28miFjaG49AAX1w9WVbCyhifZhI8SO+Za3iRBRq89QiLUiyeDRN4RTNBi8rLeug7n46Uip1edMUBjqKRh6L5U+ZlPPEtcDWFHFLbHCSaXYdjEDIJ0DASFDDfxU2reoC9PtPwWbSydbjqOmUpVKVdUHZiXKgLEerN2K66UNzEGkmCFfT2C0tFwhzCMHcXdVMoV+cq7Sn4eSB9E6ULjA1H5fc3R87TjYDBijiRYzGrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfZjuEkl5hKreGBccwioUYaf8qsXah4M8+oqsbjh5os=;
 b=EjV3fgrmipu8OyekSXwI+x9V7Mc/0MH+axJ876qT+UldHXAN5D6BvuoUtZmFRJ5RiQewpnyhhA/GDGyMoJtYp8oV+uhI/Ypi3Fq34VxKesuw2K5xbu6Qp2NIStdQsIogF8OWD5KN2fEWtcSz60PC3fo+/u6FwCy9N2dDOGAfQ+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 IA0PR01MB8377.prod.exchangelabs.com (2603:10b6:208:48e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.7; Thu, 6 Feb 2025 16:41:47 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%4]) with mapi id 15.20.8445.005; Thu, 6 Feb 2025
 16:41:46 +0000
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To: kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	darren@os.amperecomputing.com,
	scott@os.amperecomputing.com,
	gankulkarni@os.amperecomputing.com
Subject: [RFC PATCH 0/2] Add NV Selftest cases
Date: Thu,  6 Feb 2025 08:41:18 -0800
Message-ID: <20250206164120.4045569-1-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0019.namprd13.prod.outlook.com
 (2603:10b6:610:b1::24) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|IA0PR01MB8377:EE_
X-MS-Office365-Filtering-Correlation-Id: 289ea7b2-5e77-46e5-01cc-08dd46cd24f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TpCKFqyy+fde7SsBYniBAMtsDRGlzcAADO7yStLKroFJNDDJXRybeGPA4p0d?=
 =?us-ascii?Q?YAGiNdTVTijJbGVn7yDFOdx8HCxeLXYiXkeE/1qyz2efrXBzqvcT5vhHcWf5?=
 =?us-ascii?Q?yXoDsY3kqkZkUa5/ZFnrm8++TEuoOClXeTu+IkEocYwPQ9M18SIo8RHrPtRt?=
 =?us-ascii?Q?x5GWiZSpLZmMosOyPJgX+9ewXwXvhZjkLvq+/yZmQSK/kC5AXvvUCJcMSgqj?=
 =?us-ascii?Q?Wla1/wC9Bg6Ef6AjGMkctct17izpt9se8ccw/gUiHzMgo9FzKEjYqX6hgsRU?=
 =?us-ascii?Q?tRmN0HuxWz3R22zXjd2TNE7zeJW6jNlOHLcxGv6ZySj4PWeVDwkqKhb9/4GG?=
 =?us-ascii?Q?Kaxl1PvmH4DNnp+d9pQ/gsYao3OOT7Vg6JuFiW5DUuCz9eldCmWinCicdmRJ?=
 =?us-ascii?Q?4ktnJIanUloPPmQSmduPuLHpbgc1hQqQ5rsDlpSa+DPw3DDgm81mpfxV+At2?=
 =?us-ascii?Q?AwLYHuqUvhLc0jxBMzIgOESLM/mSvox0UDDZ3s2TTJMUkL6sCg/qcXfi14pV?=
 =?us-ascii?Q?64qVHYiRwdIlsAncnJflVdB+YJqvdFM9nSDYSGR8E5myRwyMCTM82MsFPWNp?=
 =?us-ascii?Q?zGHJS/YVcH5bJYAusoENMIUCH/bYtvmrZFUvLVbPPoIN42F4x0gOIdQZ7Pd4?=
 =?us-ascii?Q?swMQax/gEsTd7GRPZs7xFAMJK3JRvdc+9Y4j0tpnuh1dm/W3EdTvhaK0OgPp?=
 =?us-ascii?Q?LHTwddA2y1I1MOjgMXA10slpg/qLwTooGUj9VY+swVpKEuZMmdevE3SznNq5?=
 =?us-ascii?Q?Eoth6BzNcxjhbyUBy/QWrA6cHvrKkzK2y5nqq1znDqGvZ9PqSqt83Z1LmoS9?=
 =?us-ascii?Q?DnK8Fwbsa+Y03cuJRlS05oLmWXZ+VdMegrKxOw7li0e5nQZYykDVXlSjsrVC?=
 =?us-ascii?Q?h83Mhmb9MLk/6V8uACukmR6gbtdVghAJEuS6Fcopktz6QpTcjmTyMzxFDMwF?=
 =?us-ascii?Q?8oVGme+sTlsJIPNSGtHsvLgkMsB1uNjmM2G2P/va1PW0L9u6J3BTBwAadWns?=
 =?us-ascii?Q?QMotOaNK3mtWC67UM1jBfSY3Xv7ZAwZszZj1at6MVIIW7MiqkVJPJnsFnKXs?=
 =?us-ascii?Q?+++nZsp1VsG8rUOfJcXCXZLVC7pQQulACSBbtv/OlPjVUV9Ae2/AJkI7Baqu?=
 =?us-ascii?Q?1FItIJf0IvAWvNunRX5XitIU1GMSiX+sQDJe6pN26E40PP0lCwsVwhc5lCk4?=
 =?us-ascii?Q?TIX7NsWQROLhCNYgy2ceidW4Ijvast9rdwKXr2TObI6SmLCh2gMfJ2B7WOSz?=
 =?us-ascii?Q?spSs0//KB7lsYGwEwCDKi/gi/NZb0H8cSFmEBbp/D/DxLM7BaKj/r7XbH7+a?=
 =?us-ascii?Q?tUS3DSNaVVGQeqD+npJ7RhKGaJ2l5Zm5r794fIeCYxDvRq/SaRciRtWYN0HB?=
 =?us-ascii?Q?ITNDEH5/9ib8cK5+70pV9pBC2qu0+I+fgfw4YUAwo0t/58KQ3ejMbNw58xqH?=
 =?us-ascii?Q?JaNs8Qfxe64vzZVZLbASF7M2zpyC9l6i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8+oe6/zuVwueqw/w79Rp9lA+N+l74+a7WOK2W3HRn7+C9RDyf3QZD78W8SWZ?=
 =?us-ascii?Q?N/tHx0GYmS2Z1vwWTFV+XKz5gIdzlVPaRh+tjvQLHMnqlvAWy5n4C6ffH1v7?=
 =?us-ascii?Q?JxwxtA6GYInsGNLvg1roOWKYy9hqY6T63gpieH6XswP3feRMOoXj0Dxu3ZOp?=
 =?us-ascii?Q?GCiIKGCsRveLqicr2zBDcaDI34SDHPWJUngl8j2kq5uVTmwaA/YyVDvutBKs?=
 =?us-ascii?Q?UV28gGfDJRBkNuf4gMpENKI2Cy5AEsQA0VTlc24U9vAFgHyExphDbs4BQI5l?=
 =?us-ascii?Q?mQmZ+ClLm5Xq7hinASbuB7wOoA5FWQT+A7E89XXDrPuF7xyTsOYdTkF5AqcH?=
 =?us-ascii?Q?yXOIz01hBJiw6kJTZ3jqKyN6T5Xy4JCtHP4D1edbBjgOGKr4AATpVxT+eEPn?=
 =?us-ascii?Q?giXUFkPvMUKVcrW7QmeVxPxomjzY+1ORkI72SOlQNFLhUnWV75PwSw+Fqk1D?=
 =?us-ascii?Q?Umu9ufhYwPWm3fzlwBN1PX7+wa5yqIfrLd3Jp25Ffi9F66Iy/caOOU1PmQR3?=
 =?us-ascii?Q?xJgidflpwX2+zBz/9/q3+AC76q0Id9oCosSrpIo9ZGJ0og2IBhrTQZB2TYDe?=
 =?us-ascii?Q?CQfh/9uMeULQvxZPsvdb6LkPKrBSU3uxfePUHyblydMSGXtZN6rJZfQQ6fF1?=
 =?us-ascii?Q?t+jnFUIm6p6qXKdMT6oKjmgLEFioEVkbesUfWFaSKL+k1bcDrv4jzRSgc2Ic?=
 =?us-ascii?Q?/SlyOTwot0vyv/p0cyrzajDORkS91ir6bU+uiIJTRzM3EJRplS759TROgGFC?=
 =?us-ascii?Q?NYaf//p2nO9KOIHMzHxN8u9nQTr+Qab7p4YViNX8uhm+l5tVZBS1uFHxn8c7?=
 =?us-ascii?Q?x2hw+/VxuIZCwh8ynBUGqpQgOIX3ge5jVHDkIdph5paw5LWCjHBz/5msCBAm?=
 =?us-ascii?Q?uvuCzaqVijau9bQ3MEQfOS6dZF5ar9JkkU9ACh2+YbwIC4DoHVz5v0edW1XN?=
 =?us-ascii?Q?rLo8QLsUfOwbAZGt4NqXhGwDs7/DluNoL2Lt/CCj5nVBh9YjsdlonFE7+hKE?=
 =?us-ascii?Q?WcIlWR7K8SyVCRc2mz85b6WnQqU3S89oaFMI3ej/REkMSdMtY3bKVElzlMOo?=
 =?us-ascii?Q?YYweI9J6mLMVlpzCx+Hu83ExwwYUeksTTdx0xTCzAfeyaxa9KF+0exAawEcW?=
 =?us-ascii?Q?DWgQ9QjqCqpcBGH2FQH+jt2pHdaVu+R0ce9GNLk/iu7xEBvclhiD54MMj3Og?=
 =?us-ascii?Q?m2jyPcOdpIopzV+xrz08SFdWXwKVpV3C1v9PLYKLBVBG39NK70JIRmh4tVUw?=
 =?us-ascii?Q?QXUBNWEZi00pQCim+kR1qh7P2DLvj8QG9fByFLxGWKJz++0xj9ybOT0GX2pp?=
 =?us-ascii?Q?HU3XJrPoakNwHgeJscugABpcRNhAZT5ih7CBv94RL8lvicROO5ZiAZG7KVs7?=
 =?us-ascii?Q?WrwKvHNXbO3mIRtg+TbryIqHsmunTNh3tj0AAscULpLw/petLUHCUYGowQBG?=
 =?us-ascii?Q?v1dp45shmjea21Z/2ks6EbLdi9OQRg0DqMRj8pJlT9pnw43qiIewpKit203q?=
 =?us-ascii?Q?OP+xZ662fF8PuqYSMEYHHybjQGt6ICir4cNg8VKeKsDQNF9QjGv9KVL4duMB?=
 =?us-ascii?Q?/NNzana7YN7ZCXX18I4XoVAwnJ0BPorCG3UicKh1C5nOoeLzHVNdETvMQeGO?=
 =?us-ascii?Q?KSUCwyCp4BuL6lNnh42HIrjDToRf8ecBrlYj3pVIhop7?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 289ea7b2-5e77-46e5-01cc-08dd46cd24f4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 16:41:46.0726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Adj+ucs6ABl1M5CPTA3csD8HdJp9Px8j2KkDW3Sy1ggGcY+pFaiObI9KkpPJwui8LyDsDznGDlyR4sQz70Kwu8WYVUvYLzA5hiQANp3jQRgEPhtpV0bip0KRp4z6NtfA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8377

In this patch seried, modified kvm selftests code to enable
guest code to run in vEL2(As guest Hypervisor).
Also added test cases to test guest code booting in vEL2
and register access of VNCR mapped registers.

This patchset is created as per discussions over ml[1].
Posting RFC patch for the early feedback and to
further explore requirements and test cases.

Ganapatrao Kulkarni (2):
  KVM: arm64: nv: selftests: Add guest hypervisor test
  KVM: arm64: nv: selftests: Access VNCR mapped registers

 tools/testing/selftests/kvm/Makefile.kvm      |   2 +
 .../selftests/kvm/arm64/nv_guest_hypervisor.c |  83 ++++++
 .../selftests/kvm/arm64/nv_vncr_regs_test.c   | 255 ++++++++++++++++++
 .../kvm/include/arm64/kvm_util_arch.h         |   3 +
 .../selftests/kvm/include/arm64/nv_util.h     |  28 ++
 .../testing/selftests/kvm/include/kvm_util.h  |   1 +
 .../selftests/kvm/lib/arm64/processor.c       |  59 +++-
 7 files changed, 417 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/arm64/nv_guest_hypervisor.c
 create mode 100644 tools/testing/selftests/kvm/arm64/nv_vncr_regs_test.c
 create mode 100644 tools/testing/selftests/kvm/include/arm64/nv_util.h

-- 
2.48.1


