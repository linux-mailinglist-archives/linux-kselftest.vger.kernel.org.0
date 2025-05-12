Return-Path: <linux-kselftest+bounces-32844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB91AB355B
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 12:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317DB1677F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 May 2025 10:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C938268FF2;
	Mon, 12 May 2025 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="KussWAF6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021077.outbound.protection.outlook.com [40.93.199.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53FA268C70;
	Mon, 12 May 2025 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047201; cv=fail; b=CCwEsbBDi9nQTZyTgAaz+rJGvKQ67Fy975kVljtK23sryONevLqp0Zic1Nu2EK+L9OZLB2cpjA7jlRqhMM/ymlo87vgy9L87NCFDmUxYg1kxuRbYdNf/NYsNsEkap+LyJhvuSNOVITTaIuIirwDWxLDfbYhLKmPinNXIuBJb1Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047201; c=relaxed/simple;
	bh=ak4pQ2efvB6Q8XA0nFHTf2irVmHcJIz3aWVhaSkSYnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WIDmzHtKGlm2i3juc2n1eqHZrCMSIHVqwsq51k6qYjhMdJw4pXAiQMfXxeNGs4GyIdtZnqV7vUMdFWN6pvEEIDBxGwIUhE2i07VzGm9XXIhPorllj4zSYasC1Egg6ddsvRiaxPwTcn+mlmrJXcVxo61aJC8c9QEbaJ/AsyrGmos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=KussWAF6; arc=fail smtp.client-ip=40.93.199.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqoOsH008Wpt5M0Q6k1kVS9O52sSZBx/BVSco3dU0avCt05vMohz2DOAY7VyWB5p26vv6UuHD7mc3WfVQLnbPCfkdhC0Qvknn4OkyCaX+NHx341CSVZGxdWWNCX2gf7XNs91JmN5+Ez9Bo8zJokOKlB2I9pxEcyVQuUu1lZaTetXjundO6TVchpWiYBgkugW2SKoKbNhXLohP2hKn1yKQGuKHvtNCU58cVg/ZypajK/hAwURZYnXNR44+QZmWe7zQUzTyS7Xp8PxSzdzdsj3G59bsYDx2Pu5Vpy98bNtjmgPp17s92aDl7I59GpvzLxAnfHmV4FtCCXy4bKWhHrAiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uvv66Gz3RndWUOxsrwl3vrmaGbPK5cp/grmZxuiUips=;
 b=qw15Hremt28SQwQBDgS/IaaSBXS8NMD4kEQcR019WHFvw9ye8XlE3K05Apbps4wOYSEphoBqE2fEhw9Gbdktl+ru04gKu2Q3IEeQs6Lm0xiYz7YY0cvJi1ZHQw0QOmioAMBbhvIQDBZzfVo4da5548t9w2hCTlhAOOOQn+G6MUAB6oC96Y+ssH9uSP9KWAzXLiaIuaXIpG5hgBGfqiGXgz5qgtTh9kUfoT9A8yIxABx4Nu/56N4zyW4RZe5LBoYfMtL3WSdjD7Aj3upcbaVQD14CpYLZk2a2t9fO54ViXphZ+UpRG4VF9ugI7DCtQXQgfTFzJl98SWJC4FhC1ksPvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uvv66Gz3RndWUOxsrwl3vrmaGbPK5cp/grmZxuiUips=;
 b=KussWAF6Aj5bj1mNG7r9OEjNyHb6KbE9uWlbgM9u+zrUWFezN1qkseJBxULi6WeoFJhupnvequiyEUxDOUDU+DEQ7++x7lR7Wz21Ubh1Sxo4MovSG+/KjyH6jBsqxj4dlkDUcxmtcwcz8ii6k5CXyHKMIHCKxPMZRL9uX2khce4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 CH0PR01MB6907.prod.exchangelabs.com (2603:10b6:610:104::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.28; Mon, 12 May 2025 10:53:13 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%6]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 10:53:13 +0000
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	seanjc@google.com,
	darren@os.amperecomputing.com,
	gankulkarni@os.amperecomputing.com
Subject: [RFC PATCH v2 0/9] KVM: Enable Nested Virt selftests
Date: Mon, 12 May 2025 03:52:42 -0700
Message-ID: <20250512105251.577874-1-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR19CA0043.namprd19.prod.outlook.com
 (2603:10b6:930:6::14) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|CH0PR01MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 560e3827-7d42-4194-a090-08dd91433117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RfdETPYqIhr4Wcuozx7O9dReU8GArMgR645Iq/0hFxS8H8mAXggCOurxkLQv?=
 =?us-ascii?Q?w8mGUek+Ok4ikmDjTXCd9VvlrZU2HEepMJnz6eDgS1THjwhs7Z6T8GWIq581?=
 =?us-ascii?Q?jCzEmqHBFcok15HMyOortKmXTgc9pxpJoPpzmQZmqD97EL2PLZ4QwX8gnweI?=
 =?us-ascii?Q?wKDN5B9SVW65KhoeyQbhI3NdjOsLfvyW+Mi0dXtJTarAGVehBlcVabnTo3Rb?=
 =?us-ascii?Q?RxEjAefSDZEmYpKh/FyW3PZO90AJUa/HGMcb+3KHTo/P+kjzNvFDVkzE5iiY?=
 =?us-ascii?Q?ss0AEz6ixiZ4rtnPAlD4D7epJPv4Qvq7B2RlYIGqcu0Gq2ojazv3CsSJMw6Y?=
 =?us-ascii?Q?tR40qnX/6yV1aJcmR+TESmz4cWadUfApP3nrRfJc9SYVg7c4Ot3kXAl6Jeie?=
 =?us-ascii?Q?9t6KN2zxW52zA1mR2ZihcI7A74W7leJo9ENgxr9j5154AGCv07fpAFbicX1o?=
 =?us-ascii?Q?yrb1DXFn7sTE9kZ2joGGLFCSOIwki3IgHu1MuEIXuuHdlYW1T2G2tW6pe1KD?=
 =?us-ascii?Q?QvgSBplXVcW7z3R0oGLKJAOAzoCSfCHdh5puQfsI1XUQsznvnWUNo323t2Vg?=
 =?us-ascii?Q?iZPxLMQFsqUSZxuZGcJf06kZcO9F10/C6X/iEK4gQsDUL1/FkPq3JcjYwDLx?=
 =?us-ascii?Q?/X5FqQ7QhnlpLuq/RCDhmzmItOMohtew/Aet3Fnd3TT2sz1IHXy1Gx90C6uT?=
 =?us-ascii?Q?1tsFT0dlAMnCUKL9S4EwPPVj+64MHZqaK2cHZcRvyifQZpRmt1bF7b8Swnei?=
 =?us-ascii?Q?vnCxPxMEB3frux8fVw19jmKvunAXNvdqK6VhASnWZWlVBZaHp9VJNmW5VxGq?=
 =?us-ascii?Q?6aiwMHl3HrIIDsj+XUlI8+e0Qy60lj+QChkqM50qONUwKqa3uaqp0KdXS7kh?=
 =?us-ascii?Q?1vRzI2Zuw+r+bWFBCThXl5Z7ZOH3vl61tRvxupYxi9eeuor1H3pTXU9ajrmO?=
 =?us-ascii?Q?bi1zbZPbgdzqITQKIUV0qAKhTqzxiUEjX7Ww6WPRNeVbz3BFTQLu6pAVM8Le?=
 =?us-ascii?Q?Ip4L46YFc9zjS49l1lL/lmF5CDK32bBXSqz+47MWlDZ8ckD6giPsz5XWWbp7?=
 =?us-ascii?Q?Dzpdt/4q2F5q4DaiKoZ2OkRKYZ29byH3fH3RXPCEUGQw6RpRfx0Kt8eaeKjK?=
 =?us-ascii?Q?IA175IUi9x7dpzODDvH2ca5pVzgdz8KBHSNL8zjEg0afQY7iRs5tI+sq8emo?=
 =?us-ascii?Q?nMepsPJfnaqWWlzRHdPWjqOX26I6J6+Fhbl0IKnPY9WDSakf+/NXoVWeP9P0?=
 =?us-ascii?Q?9LbJhCCiNcJjkxt9VTV1qAuizSo4GSDFDBxBqZZhNA/I3jKrns4biZ/PHEgi?=
 =?us-ascii?Q?BW13Lc232vKqLvohdvb6c0Q1XtQlJLodXrEi0+4nvPStGtc4gIfxrnwJOkt4?=
 =?us-ascii?Q?9+vcCHERKw8ZZSFB+sAAE0FCIDjogKtB2g4BJueAoZhh0GmJA0kWe7ozBvmw?=
 =?us-ascii?Q?S+kGyi8ztxcWsaJWH2Or/l3NzGYwSpGUCxHpU1F9hK97IPhR+90+gz/9ChEm?=
 =?us-ascii?Q?3fUn1yymrlTj+GU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ljg+9ubfuWr1azr9fJ/3F6+PpssuMQoAXJU/Y+h3X/BjnCN9s77JFMli5smo?=
 =?us-ascii?Q?bVcK9ZkVITcjsyPLhxIm72DqDz1vBHKV6xp2y9eAz7cEKXZiSpE/jPt16Hdp?=
 =?us-ascii?Q?2T9IGPRmOpGuqcABjtQITcX/dThGkoIUefvHLVbCuhCDzWxiunohax4rTLiK?=
 =?us-ascii?Q?yA/OPxN8+Mi/1R5xNERny0vD2zK3gdw3WU87etWku/+eSMlrnCIagglrIaAb?=
 =?us-ascii?Q?3lRESknH0IagtxZ2CUjXj9XX63bqudG6nwIwBC2xRf6MkiVWs0/xbFH6+JSv?=
 =?us-ascii?Q?Fl65EVR18pRPzStRZMG1oJhrtzFXaujbR6qRmtMWcfSsw0xoyyvn+ogOt1Fs?=
 =?us-ascii?Q?NyfwGJ4hTQ3RSi1irivcdWuMebqaVshAFGHHlUFvbY9XM0i+faGC2ZTQvE+4?=
 =?us-ascii?Q?VWh85sjhrtZs6bWibKDHxFd1uxNBAcjg5pqTdHT/UHGt4SqIYkI+yhCwYexw?=
 =?us-ascii?Q?ORzhv9dy9P7xdZ/lVrY+OUOLpB2U00yIzaGLSaeeJUmWVsF3AGDpE+QsgEVM?=
 =?us-ascii?Q?L1D2zjOqcflKrTSZW2gtyt9A9zsrMqdaSvi7ggqhFD0Lixb3RFrZ4umxa+N+?=
 =?us-ascii?Q?tSF18san0hXTN6Kjjy4CYM8K4OroPaKP0bG52P3YiU9VR4JwRVdyl+j3HZdr?=
 =?us-ascii?Q?UCRufZXog6vYicTMaQDwERdQxslcvHoS/+1tCMPLdCt6ZadM2w+m1sU3ny0n?=
 =?us-ascii?Q?zVjXE9FQWg6kakazN05YiW01DeBCaIA4Awq5BtSSFsd05Z8cJw3DZR8BHJOL?=
 =?us-ascii?Q?h5d/cdPKPrEbn0kZNbNcVKNICYdGbL51khEBwsMPA4lA3ioQu1pyN0JgciEN?=
 =?us-ascii?Q?9ZCwanh097yf4CrvkLLUJwbg2VYXef13CoyMiHgj4Bg8Yo7tGoD4/IDMCnUv?=
 =?us-ascii?Q?JduuU7aH4lLao9/IOKeBfQOkR03L/CaMaCK6sszke3S2XzGQX3DYxVIwxOBw?=
 =?us-ascii?Q?OxfOPv0WZyjwDkaIBFjUikAOMRWUELhbOqmZsJzVqEHIxlTpDTbTP7t3VTRJ?=
 =?us-ascii?Q?TC23zR8Gah3pniCP7aVaZ9IbVvsdcVfegvJdkDuIJexD5cKJAM4BfM1DoyQN?=
 =?us-ascii?Q?E6hN6YR9kaVY69Y9DyDHhSn5pbZREaHTYthG0cyQiPaM5An19bwVH6eSQ5l6?=
 =?us-ascii?Q?bTBKlxfGvXXy617wRyYT9VXjgcD0+jDQ38J7ecDF8fzC7m2FGYygP0XN6E0x?=
 =?us-ascii?Q?MGgwygluF00sXj48eZF77IjZLkwd8FhVChe1HM7OdjoQh4+PWh3tBdknP+kL?=
 =?us-ascii?Q?XNLP5ZzDHljJwVYHI6lWbDxJNF1zX+gntflusf2NVl9YAhuc80xtfxTH+phq?=
 =?us-ascii?Q?e3J/ZTW3Bkgw/c8C0//eUqf6b20kCox505aIznYadDIY4A9gYt5daAVcHQ7N?=
 =?us-ascii?Q?+tRW369J5Em2a1e0Cl4/BuN6aH0du7Y3FeMsF+xE0RxfajhtZ6WRNfPlE4qI?=
 =?us-ascii?Q?z0IFyIMcrJWcp0D9mxM/5YcC0CnU5blu3m+msirn0siVIcp6QYX76v7m49DC?=
 =?us-ascii?Q?ShwVPhghpK5Nrk6unKD5YY4MRPotnDCxSYbsgbNjVnk/+zswGq4SpDG8ZHln?=
 =?us-ascii?Q?V/qMk6f9z88QreByIIUkjCe8HMUrxP7VMsNaJaNgkDhbO/73/4V/x/8w2hU9?=
 =?us-ascii?Q?jYEgvLqrq6hb6Qvnx3tXLnEPDBYgJ52UPbqJyLoGPV74?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 560e3827-7d42-4194-a090-08dd91433117
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 10:53:13.0500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSWJvx5U82rQbBapXlqyhRiu2QrErTw6k39xUPtYl4Rul1zTzhuwZ+DAQN+0Mv1sMmmFNRb+kZs6PThe7lRmvADn8sY+nK4WsamK7Cvw/fZ5yhVGbV51K4B7vSYsw9Jt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6907

This patch series makes the selftest work with NV enabled. The guest code
is run in vEL2 instead of EL1. We add a command line option to enable
testing of NV. The NV tests are disabled by default.

Modified around 12 selftests in this series.

Changes since v1:
	- Updated NV helper functions as per comments [1].
	- Modified existing testscases to run guest code in vEL2.

[1] https://lkml.iu.edu/hypermail/linux/kernel/2502.0/07001.html 

Ganapatrao Kulkarni (9):
  KVM: arm64: nv: selftests: Add support to run guest code in vEL2.
  KVM: arm64: nv: selftests: Add simple test to run guest code in vEL2
  KVM: arm64: nv: selftests: Enable hypervisor timer tests to run in
    vEL2
  KVM: arm64: nv: selftests: enable aarch32_id_regs test to run in vEL2
  KVM: arm64: nv: selftests: Enable vgic tests to run in vEL2
  KVM: arm64: nv: selftests: Enable set_id_regs test to run in vEL2
  KVM: arm64: nv: selftests: Enable test to run in vEL2
  KVM: selftests: arm64: Extend kvm_page_table_test to run guest code in
    vEL2
  KVM: arm64: nv: selftests: Enable page_fault_test test to run in vEL2

 tools/testing/selftests/kvm/Makefile.kvm      |   2 +
 tools/testing/selftests/kvm/arch_timer.c      |   8 +-
 .../selftests/kvm/arm64/aarch32_id_regs.c     |  34 ++++-
 .../testing/selftests/kvm/arm64/arch_timer.c  | 118 +++++++++++++++---
 .../selftests/kvm/arm64/nv_guest_hypervisor.c |  68 ++++++++++
 .../selftests/kvm/arm64/page_fault_test.c     |  35 +++++-
 .../testing/selftests/kvm/arm64/set_id_regs.c |  57 ++++++++-
 tools/testing/selftests/kvm/arm64/vgic_init.c |  54 +++++++-
 tools/testing/selftests/kvm/arm64/vgic_irq.c  |  27 ++--
 .../selftests/kvm/arm64/vgic_lpi_stress.c     |  19 ++-
 .../testing/selftests/kvm/guest_print_test.c  |  32 +++++
 .../selftests/kvm/include/arm64/arch_timer.h  |  16 +++
 .../kvm/include/arm64/kvm_util_arch.h         |   3 +
 .../selftests/kvm/include/arm64/nv_util.h     |  45 +++++++
 .../selftests/kvm/include/arm64/vgic.h        |   1 +
 .../testing/selftests/kvm/include/kvm_util.h  |   3 +
 .../selftests/kvm/include/timer_test.h        |   1 +
 .../selftests/kvm/kvm_page_table_test.c       |  30 ++++-
 tools/testing/selftests/kvm/lib/arm64/nv.c    |  46 +++++++
 .../selftests/kvm/lib/arm64/processor.c       |  61 ++++++---
 tools/testing/selftests/kvm/lib/arm64/vgic.c  |   8 ++
 21 files changed, 604 insertions(+), 64 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/arm64/nv_guest_hypervisor.c
 create mode 100644 tools/testing/selftests/kvm/include/arm64/nv_util.h
 create mode 100644 tools/testing/selftests/kvm/lib/arm64/nv.c

-- 
2.48.1


