Return-Path: <linux-kselftest+bounces-9497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AE48BC4A8
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 01:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EBB2B202EC
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 23:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810E3140364;
	Sun,  5 May 2024 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="deTCw+jG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01DC71743;
	Sun,  5 May 2024 23:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714950069; cv=fail; b=b3i4bBk5/qywg61lq9JNsP7h85LP5ZRoJcXxcXLf91cYLSctDcGzyGEO0LD8yeWK/cFGBTQ/6CMAhEnV/VW0GfnE2tbAyU4oY8Ft64dPZQWzZp5xQ3fJX3lPpjz8JH6kkR0czsEcIWflLo6GUsY9iJ/QjeK/wAQHy4pc4n/C5vI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714950069; c=relaxed/simple;
	bh=bVB9gcdSFpwIUK2cXCX3a79YE7961k6s1zoKK0CedMM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Q6qZblt7QQ4/weojApCwjjkfFziI3jFQNlGRfTwb4PBUErt7MUvcR2TOGh0uC6QozGHrySxBvEIbmiQIsYL8rbZnDlxsbPqTgbZIJ0HAZAZB6hfluXZpnh3rmQ+tLVsu4W5S0CJOE0YR9ZyGzftfcsdQrH9XiTmK5bUreQOYZ+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=deTCw+jG; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xw6hs2xbv8HQLc46CdXni8UR5JPe+oAj2dPWtX57b7mL2+Snsc6tFcq50TQ54UMOJduyBt1lpCDDPHbGD/iGYNBjNqMamklsXPJHuUAMvnxPNvZezIoToH1zF+NAj7fpkgKt1qbbpZc5vFjzAw95oxui5yOdi4lq4QHrDHhBLush0es11Lt3C9PArVtmOkxnGzy2Hreq98Ycskz2rCzxJkR/ELObti1AR/CSLGv1Jh+us27nvUrbB6n3e2Q0lerDvnRvWn8MpPRbeE1YoJQss4HIRxP3CAk7Xy1ujr4LtJVB0ih66XgvmgQle1q0PbQo+sen+sSV26+HgK6hkwNs0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8upgPTWfWJrS7qvEoF2TdfJ4vGsMSfkHphdC7PIsoe4=;
 b=bpVJuXj3qYBux6QD8stC3J1qDIud+cCbhXExv30x5Ktz/C4gVpwLmjptBdKv74cLOPUtcT6Xp67dV+nq6toxHqZ7sA0nilYmR6aNUXObjVd1DvMZz+NTyoBJOxNNXF8lrlBpjCkJbnaEqnMpcfLBEB1tCBuuRAQEojzHGIl4X4SVkYORTJun5BLaTwBvYuFJOuNOD0R9PCZs0etHlav8lWcg0nPMt9PmEwoNq5Ei2HmzmR/ltVOyEC7Zbv7/cCoECwvgzwhVBMxm4O7Un+nOgD/usUhPv2PhKdl3kk2JRaCvyQa+vTFl1kfi2MmViV5WJzxHgzXA+vIAgw+fc/cBrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8upgPTWfWJrS7qvEoF2TdfJ4vGsMSfkHphdC7PIsoe4=;
 b=deTCw+jGbOlYcfQC1bbG6Bpha1Tb7PVwPOqXhJLifD2YXA/9OAtUPfhZ3UMQrmycb3x9ZQ373xWu7h2eOju1noAsLiL+nBi86yOQE0nAe/7VftAfll/0Hi1RLCJssEiGBurfUkIEe+Ao/fPSM+XiOe1crMs8AjauOVlNrtBqYRT99kO6xQ01Odfg31G/LJW0OOFjPczJ9ckkcNxaz0ekKDklJE8r3DKW9feRYX9/2wpzYG9aqasd6YGuLPh00HCPxv0PKjz0rllqtmfoYI6hLjqLE0URyVEB+hH2AmplGCW8w2U2Pb1GkAN6N/GhZBLb5xe9Aa6DgehgPVY/3xpdeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MW3PR12MB4444.namprd12.prod.outlook.com (2603:10b6:303:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Sun, 5 May
 2024 23:01:03 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.041; Sun, 5 May 2024
 23:01:03 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Joshua Dickens <joshua@joshua-dickens.com>,
	Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-input@vger.kernel.org,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2] bpftool, selftests/hid/bpf: fix 29 clang warnings
Date: Sun,  5 May 2024 16:00:54 -0700
Message-ID: <20240505230054.13813-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::34) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|MW3PR12MB4444:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6d5d83-e5e0-49f1-6ccd-08dc6d573d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bxXmehM4KH4YuU6JA9lwGh0UQtBtyQ8FHwmbi765YM3INLUTGjEPXqDLNE1L?=
 =?us-ascii?Q?6eGoFkbd9COGrMGyRaW8FYfMYFOPC64MCfVyBTQygyISxZFcr7fyewgFKUJi?=
 =?us-ascii?Q?qZt+cbcpchgjJKJz7w4jbVQJTFxs9Ei8i2dozyeLn62Gwj1LCGZxlxdI0hva?=
 =?us-ascii?Q?v/joUNrZMsYBrRBopdrCjKG+qFr4EvXAp1WPMLeLWRLdhnfzvFjaY5kYd7Xi?=
 =?us-ascii?Q?e+14t/xv1zz+SfHEAyP8A02l+YxikdIDA7WLNk4xyTkUuJ9w6SWHO75kqrlq?=
 =?us-ascii?Q?i7w2+am41Az0taDyg2YHQhL4oQRG905k+3XaDwckgAVsgWLgc9tQzTdLt5nu?=
 =?us-ascii?Q?cUkgiG98857VlTVGtnZPoick8Ly1gceDRETHUcimGWvufWpINHMbPkYZOFwl?=
 =?us-ascii?Q?975uC0uyNg8wlnvgL368ysJZX/ejpzz5X4vq0ayL8r06i4SSwlBPPZejbsL3?=
 =?us-ascii?Q?QdWskstsh0QF/h2h7GoGNS4/xrlXIzRauUBlPK23t0aEkYIpTUvFZg6UzfQi?=
 =?us-ascii?Q?1133EpPltChvsTX5M+/VYaWIHOx7DMyv/2iV97EAUc6PnGvE9W7H3f7/TIXI?=
 =?us-ascii?Q?LVQWItVkZYVaaiaxEbIcXEyjY6sHpPmOjHdjfJYUh2E4spxLiCORF9DR02E/?=
 =?us-ascii?Q?CLiA9dNVtmBJhjH3gMVDtZU73WtzAw8Ou7ZkTIVoLD+8N1VrYDujOdyQen5Q?=
 =?us-ascii?Q?Y0Y9HLrdaWbBtxs7cNpBmJJFjfEZf1256Ub518hDM/mP9LLN/7ZZqYnAB8DT?=
 =?us-ascii?Q?XyIpU7NlHyaMaZUyBptqn1u4jZoLoRFpboKlVhKHHip06ztwxgvm2XCeIHNs?=
 =?us-ascii?Q?ULfDLOHw30H83trFmbKMoSiMrk51CHiHErCk2I9sHGwsuQqwqWdJ9sfIwXHV?=
 =?us-ascii?Q?OmMlTj1CwEYTvxS8ILxL54Y7wNk79AXQ3GNhg9ZHob599Y6beEhBcL/nf44W?=
 =?us-ascii?Q?xnxDkbGsVILLjSj7I6X2Xa2o2uxnkLgW5ZO8UXqZfYi1Seog+2qVD24irEwb?=
 =?us-ascii?Q?EKPnuQmVEDUvKV9kAfqQ7+8aIc1cPtCaUR/VHsuww8YvuU/C3fqH5KJhmMx2?=
 =?us-ascii?Q?zLtkLr2zpggafs7nb9YdlO3OFia8TzjyPvo4ULlWvqX4L3nr85BT2mgo60Pv?=
 =?us-ascii?Q?zXdkGhCG0X0uXVLvWTAha3gVVqkJEFeAckfw8qAfplwipb4NNwjVxTmoVi9t?=
 =?us-ascii?Q?URsSPldCR/0oKR6mNEcTV6npyYtyp23LI7aeTesj/+mlq/VXP+Og63MrZm5h?=
 =?us-ascii?Q?X3m/2L3CLH8jSH0LDHYuWwXbGnK7X0Sy4Cr0NpjoVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jj+qQCRfzqB1+YRDP7zq+ldYI1ePmOotgPfOBkco+2IaqEO0b06UMdTTRwNj?=
 =?us-ascii?Q?8GFXDEKHL4JK40WT2198YNU7VPIkIvIZeWPYykK5KGnraUaK6olTA/zP4quh?=
 =?us-ascii?Q?Vy1k2Bn+Eaijbwx8V/7OeBb+qj4+yTsg3z5MoS0FSAN9a0u8PxRsQh3MNf5X?=
 =?us-ascii?Q?eSmmnnuPxdgjKfrJixluu2BRndNX7+gleYQyNwxkBydtHtFhB4tfkHSJkBxo?=
 =?us-ascii?Q?geITLZ3WcW2UQZQSny+dNCYYgFLxz3x8z12JivlQzg5fGET5XiiLw/LJ8DIp?=
 =?us-ascii?Q?eKgLSi0gJA4tH8Aj6S/YrSzRrOJBf0Sb/H8JTy9eUQIYy5sMVdw56IWHE7oE?=
 =?us-ascii?Q?ToFiOS18tOdiHtczwQ0Fmk9FN6CzwmqkW9h8qECFSjEDITtCO0DnZQfqvmZV?=
 =?us-ascii?Q?1WPuYKyxP5TsZo7MjoHSn9vaPA7juTallPkUWaeFjUnty64H8bCiizCmTBGe?=
 =?us-ascii?Q?pCRDYSamdotGKwKK7mc4mVJoRiQH3ff9QtZF+CP8aa+PcBuJxHdaqnRWwwV0?=
 =?us-ascii?Q?n6Up037bZLtF3v8Ly3l62TAnDTQd6yK196JqSMdq9A3yuLnTM5krvIG6UTww?=
 =?us-ascii?Q?wB7Se85WLkeMi8ABRd2U0gPUPTvX2va0R0WeKPiOls6aIMR/zz8zgLrzgJd9?=
 =?us-ascii?Q?pAya6ACoKzs28iNvbu9uKLziEnfHv6me4fAYbLrd3dmOs+Ko33KcIMcLqG7s?=
 =?us-ascii?Q?KlmTQBGbTXmIxwtWS5K7JNIZ2JaJZn8wF4HxEWur9XlsGtdQ/+Y8YfWIvoLR?=
 =?us-ascii?Q?XMZpoJuSGULj7V5ecaHka64B92HnOIZbZwKb+MXDHDmKI7qEFF7rd5238hkp?=
 =?us-ascii?Q?B0iXBwBsJBCzTUPIjZJHCWo6Sgf5vS8MZwUo8icowXxoHPDFaAmfBLraaeBa?=
 =?us-ascii?Q?MbUzwksb/+T4RB5x7BFQlrf5aHRs5D4OuHAdVvIZwDkd3eRi5vTViWmedgr3?=
 =?us-ascii?Q?/lskAMng2Cozuxn04yV6LzFPs1ogE+10I+ypT0JnreBzPWcvpvo6WaOqSniv?=
 =?us-ascii?Q?QArRUqcfSGViTVD7G0VO4oD9guaSbvI0hC7ALTaO0DKdjEWavBNTLS3j/dst?=
 =?us-ascii?Q?LcmJXPhsblFh4HMAGfNt/k4cdeAcSVaH0+qAPzXFLyrqeTTQT5/ieBbmYj/R?=
 =?us-ascii?Q?5uH8ly0PtCeDw46l7LpnFR6dfaOuL1QcG3dfj6zTT6GHCT9aNNN5OgUEezBI?=
 =?us-ascii?Q?ieFAFkeMvlFkANW/PPlUQ/Jg5zrZK8q9pAyhoOfkEH6Ey/mWo3auO0cR0WiL?=
 =?us-ascii?Q?cEPZFpdsnLhWkWhyM0cHM9H7pqg8ltMme1k/hukmhU4f1b4vGXqfLYAuqi2W?=
 =?us-ascii?Q?v2V8VQCrcrgcWGKd3yzRxhw3StmSCHMHIvICB+Uhct+GCuTSH8qpWA1dV9xl?=
 =?us-ascii?Q?G7I9saT8EbgwYi3GyDjpaCSzM4eTnYDfNaRZSlfwMpPSbwz6ivqBXP6JzNkh?=
 =?us-ascii?Q?Hn24yT17/8iU7pukAsAGu0o1W6bZbrB9XrVtcNon7p3SQtiMVHbxEkgKZZdb?=
 =?us-ascii?Q?OUSbRt6IAz2jV4E2KdFRLXzYYQ2kNfk2ZCRIHfvhHBjnF919XdgECq26M1W3?=
 =?us-ascii?Q?NbIAFAMHg6PwxMoEGmrKh3GoHN7cNGH1jxbubDqz2TQWXK8AlF+TqmeLh5Cn?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6d5d83-e5e0-49f1-6ccd-08dc6d573d3a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 23:01:03.7526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBJcVmialaUCnVzi2QqW5J3DJCvfMWwTlqOuSS+nMNEUKip7cZhIBQXmIeEMi9nNEgxMuq9iT5+FSwyl2SA98g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4444

When building either tools/bpf/bpftool, or tools/testing/selftests/hid,
(the same Makefile is used for these), clang generates many instances of
the following:

    "clang: warning: -lLLVM-17: 'linker' input unused"

Quentin points out that the LLVM version is only required in $(LIBS),
not in $(CFLAGS), so the fix is to remove it from CFLAGS.

Suggested-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/bpf/bpftool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index e9154ace80ff..a5445a422109 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -143,7 +143,7 @@ ifeq ($(feature-llvm),1)
   # If LLVM is available, use it for JIT disassembly
   CFLAGS  += -DHAVE_LLVM_SUPPORT
   LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
-  CFLAGS  += $(shell $(LLVM_CONFIG) --cflags --libs $(LLVM_CONFIG_LIB_COMPONENTS))
+  CFLAGS  += $(shell $(LLVM_CONFIG) --cflags)
   LIBS    += $(shell $(LLVM_CONFIG) --libs $(LLVM_CONFIG_LIB_COMPONENTS))
   ifeq ($(shell $(LLVM_CONFIG) --shared-mode),static)
     LIBS += $(shell $(LLVM_CONFIG) --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))

base-commit: f462ae0edd3703edd6f22fe41d336369c38b884b
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
-- 
2.45.0


