Return-Path: <linux-kselftest+bounces-10811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAB38D2AA3
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 04:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FCF41C20FD8
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 02:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C14715B104;
	Wed, 29 May 2024 02:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZN1BOu6P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943A815ADBC;
	Wed, 29 May 2024 02:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716948534; cv=fail; b=V+xUpWhQv9/N1OrrQm3DvdXKF943DpQU4RKw997YfTGLFHgYPSmYFcfcrGZ/O5nvZPN4ogIr96jRiMAW0tBk8lCiuaVCln03G98KTL6wkeSEngJJCUUo2lfGUi27ZSyQO9oEA/qNNXX1Pk1mVuuADA25K8cIBFVtbq5YdUDP02k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716948534; c=relaxed/simple;
	bh=m6StqIIvMC1ualYVakFbzI6brq7UYVnA836S6mnhQJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oxcVhInHrX+J+ku7UVBYVSfZFdpzABbFi9H56SzdWIR/uDaRSYh7on25IVrHuv4tYuDdWuAUPTahrb3jL7u8tPYwp2MnNdodCledMg8LR8svu1LLmlkg5oq3xGd/IgO0PZondGl6eIfb7jXikUsaxpqwohThBPruwFvgVjC9ygo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZN1BOu6P; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfvNgX953zwZ1F5eCN/J9brFXDN/ksAwO6GRGfmGXU2T0fBUYVXeS8lF8sHWm0uZJeYD49GrS1BvssFt4DxVYsW5euewAY5lSWjxTjwF5T4SGNrIxUVpwUg/+TA0GZ/nmSShdBu/QrTkL0Pic/IzeORbc8UEYKjMmn45qUUtx4Q5IzwbgYcDykAU5yXSqMD3GfJrW7hzKDzC99jZdm1BDA/ddYS9GhEb9w/RFa4Nwd6tzcz3nZmH/bShmpckD4JQ209Qdxw+Ewckbbu0m4zEIbjMmMUXdlTekxiIT9CGU9fct2QVUorKTM+U+CdGFYi8XurVe8WR81Kcml39iahKww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBpC1o3AcVkPrvvVeufrvPsYaK2RDTfkmvEJThKwzSY=;
 b=hjRyE4W5ozKeARdolHNP8DYIEj5m0Tj2Y7Z9ACQm+Ksn36sma6RJyD9rY+SQYtNZ6/pQ9Ia4J0d8+HlIgiSw1rV3wafY0/hyoDnWPrNGC/E7YsKgctYpu6VmrxN0UjO+iMguG41kP6ItuWGaEvqnIh2AANJVPS9ko7j51qRsXAvjGYDJ5l7KG1uXu4t/30WdUUd+ySQPy6eCM7eDdSdDKtwhuMzmaci95vDA83g37HKC4VS3EAeJrzk0xjQ5KDjhnowuuLUMbxU5zfYfNIwi6re5NKLHQgbUSag7zAD6dKnBieQuJ80eBQrmEc22BlHqEoQu/b6HdG5ODDw23WWKKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBpC1o3AcVkPrvvVeufrvPsYaK2RDTfkmvEJThKwzSY=;
 b=ZN1BOu6PIAE4XlCht/2GeNFvsYd18pXjgKbAR6pZaqdVaDzsNGzQyKkJHynLjVzJUIQgPNs/ytazolFToPX5fkjQZ5TTws5br+GtTI2QOTRRfZAUoPbi8HGPV/O9bELIj2mal3+QOCMbXZTsfGCqimu24Jw4gJ8BnLdD5z1A/Z6NcvsBTkDLc7weVQJp5VUhSAeJ5c7ZjiCqP8tkj6pV6otaWAO7cCfZTY45A+MSFUlDHBPoDfIIIqNAPwQJp4CMjNV1AmC8AqmLz59iq+nfDqpeoX8iUp+kS1nT2mxBNfGu87RiyCVdOIs0zE2HkvoClIr/ZRXvKvaTDNwBov+30w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 02:08:46 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 02:08:46 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Brown <broonie@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Bill Wendling <morbo@google.com>,
	sunliming <sunliming@kylinos.cn>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 2/2] selftests/lib.mk: silence some clang warnings that gcc already ignores
Date: Tue, 28 May 2024 19:08:42 -0700
Message-ID: <20240529020842.127275-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240529020842.127275-1-jhubbard@nvidia.com>
References: <20240529020842.127275-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0038.namprd17.prod.outlook.com
 (2603:10b6:a03:167::15) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: e0455712-9a38-49e0-260d-08dc7f844597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3xrFqfo+EHqWBE8xBcKYChhEMKyRMbgdQ3o+GRm8AsYTKelHL8/xnfDC6nA0?=
 =?us-ascii?Q?AnetVmPKAy+6I9zPH3sKSjnORaAL0zbqWIDw5ZPKVIlR5SeuNGV2EBa63zV4?=
 =?us-ascii?Q?aOevSNXffOuuvk9oJYXh0JivDz0jhfHJnfh6G4W6RJ731EhYyPoI9kqmEgq3?=
 =?us-ascii?Q?Qh49z2+gKyvTrTJLfYNA4QJ1X/j95ClpNqRQQbpzNXrZWV3vOw2+/+kUpDmi?=
 =?us-ascii?Q?+F01rnU8SmYHkMJSDzWZeQQ1MepGOBISYE2hqjNPxi/waRVlRcLPypZy/9Yz?=
 =?us-ascii?Q?Fweef/Io/EwXUb4AMR99ScAc+Hmbu+/KkNpGnzJ8sQabV42mICyanarqv22n?=
 =?us-ascii?Q?B1POu6DLgXv0N1S1MU838YbOMFTG/765Zj5jTonuxvufgtRXxZEFw/yBzBUI?=
 =?us-ascii?Q?A1jWnUAoY04SooPmwXOFzmqwZWHQq8evjG9UUPuskxsDyD3/93g1gnvbreHD?=
 =?us-ascii?Q?ZNh6l5TYR8y3YXH6EbYjxAb/iwKlAH6thSDatZqlnWXlQ1JafO7L1peywYmp?=
 =?us-ascii?Q?fQQA0FOoF4/oeOItl+7xhtC8MQAQmtrG8+aZp3ckQ5wfugFaYrXZO7OD3cOw?=
 =?us-ascii?Q?xlxgxeKJCR/Ngw90E9EU872w3bBNcVrCOMKVznws+Ci18NztdaDK1r05NUuL?=
 =?us-ascii?Q?hqjm8s0K/2Be6liCjmLWuzSOZnUDRQCOHSNX5UgwednFXbG7rlUqrLO8y8hV?=
 =?us-ascii?Q?wPkQeD5eRW+86jjTPc0QsirhStzRhWwUSvd2sXmfPRF32JMPQY55J0CrMU9d?=
 =?us-ascii?Q?S7k1rLc55ZjiyWVqIXXs1oWVfBuXr85zBaUowv5b81W9Qv8pWjFgg9/vp/kc?=
 =?us-ascii?Q?qIMqlDVvVDk3sJtyEh5sjTTO3WUAnmzGwboV3VcYTsf7+MTjzkC3d6GDgDz2?=
 =?us-ascii?Q?BtPE6Av2FBV/IFgfy2rcUX239TKviW5Nxpp5LY9n5Rbck4EXD3y0vD+BbAKp?=
 =?us-ascii?Q?9KdASVc1xhDSavh6mUXSfJUOCvKptvANPA1N+PzdCLQC4J5JoWQiboq+IYLo?=
 =?us-ascii?Q?k1lEJAMXSpf51L5rzJV433RkVVlUhyWdaXOZgZINYUbqkzIAcq5Z8gysejem?=
 =?us-ascii?Q?l7BpDuTd4NFNzMlgtJhYC7MvXTIZEjTP05aNSJyHwPBCDGoyy86uQqphbWdv?=
 =?us-ascii?Q?cwg+r4nCISlrm9ik9w64ijXcHd+85jIGyapo7lr6lSNKUdGJOvwOxLe8iXz4?=
 =?us-ascii?Q?d+bov4ZPHEAW+TyyNoCKAj/9AVAys7WytwsXJwWdYqa9tNQefK2i6jBK3npG?=
 =?us-ascii?Q?6WUzMc1YUvdI5C6YJemBqqi8VQr5y4cawL/JV+IKPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?43QCE+8VVdJRiJwZXIF4yCohIpTwpweaO38FkdcJ9r0fgAnZY4tR/G7BkxAx?=
 =?us-ascii?Q?q5RmJz3jChq9+dkwz0to38MqQHEg5BxnvS2HaaDC4mtEovKG5wewYaHoh9R0?=
 =?us-ascii?Q?HEINQqoXBHJ5V8ObD14LzAgxERWGrcJT593wPeGHtE7MQHuvAiuCJA4xXC/t?=
 =?us-ascii?Q?pROMHv8CXcb8HHbPBvBQZ+LsDntDXy1cb518o0xRWkUW2CmXBExAY5Zpae5T?=
 =?us-ascii?Q?JIhektR5lqwxqNBAacORP56bEPCY/rL41wMHe2VZ/yXWb6QJW16CcOpMGJn8?=
 =?us-ascii?Q?gh5gN+gJxFAXSnRt6q75XdTd+J+SYoN6hsXLkoaaY4WfDViaGKKh33nKlThD?=
 =?us-ascii?Q?gzhiKRF8chU9LKWMoQZ0vuKk+1WnLeTZPF6KmNMKhvqdewyhjP5aZ0a5Jktr?=
 =?us-ascii?Q?Ms2iI4ukHnaT7FkUUECWjbpQdD703jxRKNfRctMN4aJfbSSpsPxQIfA3adj6?=
 =?us-ascii?Q?WYgzvL3bd64PkYGoNafs1Pe04ZQtvfvWsm2JZ4QmoVAT1WL5Epigy7jBNkmi?=
 =?us-ascii?Q?sa3pxOZNp6WRBLscXBP5avJx/61ybsFVkMCvGkUxNqPtTEwUrq7nqZHb0Oc5?=
 =?us-ascii?Q?SdiIk5E3m0HVuj5bITfphwigG9YuoYhc6kyclIvyo7n8ILHYO99ubF5n67tB?=
 =?us-ascii?Q?PkegxnfDV9pXZ6FpL8mRvYsZsp7A/vu4WTXsipxHAHE4Ove5vjZVChaZ9jj/?=
 =?us-ascii?Q?G4zCqmblYcWC4Cp2LJNzLlUw0SAypXsY5iAVhC15/ZWc0B1u1sA8304YDevx?=
 =?us-ascii?Q?EW36lxDuHrrNB44DH9Qz3APdO24dd47mFFevFZOQD15NEWhlTRYnS8FsnFqE?=
 =?us-ascii?Q?3SZIKdI7mme14YcnvdueNkgh1sk692VzttlxOhtFxxAVXkw6+TuSo4KuA076?=
 =?us-ascii?Q?gYAijcmd4yLiuH2ShfS3V5B8m5KJfO5RMhNNkQtlQo95uLLcGOEOr3S+t0cz?=
 =?us-ascii?Q?fWBBM0QOUzFdY9BxX8mtBeNIBR7IPLfb/TPCA+q73bb7gGd2U3nOkD6yVFHT?=
 =?us-ascii?Q?/be57LL5YlePqo87WZUxZy5KXpogOrpfT8/asNJfCximurrb4Odw6e6sNmBx?=
 =?us-ascii?Q?XIRCunJU0pgAJHrSML/lVkcTd/hnvoDtgVAWb8x28/pan2ovpjGB+l9VV2Lk?=
 =?us-ascii?Q?NJ6n8V6D53SFjMbE0O0IlVwksDpYIgX0wxtbEPFO0T7hqOU6Y2Up5TrsB8Rq?=
 =?us-ascii?Q?oFz1Q32UNjSowrVp3Szo0Je8fDaIihHvn0Z4UK02XzJMxG/59b8GvMB+Tw92?=
 =?us-ascii?Q?vS0nq0ktJ7WxryIiryEDvsTO/iQMc8QQJdGXxPkgpThDH3XkzacMrnumqANX?=
 =?us-ascii?Q?QMknPpFQCtO0/skyh4ZAmQVXHgcjgmvEEqUSSfXRH8jgRFyrXzyjuiGW2UGF?=
 =?us-ascii?Q?aRqOGBFV7Bwt1xGf6hyvMB8VOeTjNoTAuQmniXrxO8QxaeQKHShlpGoqeFb5?=
 =?us-ascii?Q?VN0GKexIimIrkTw6pmB7cBJ/qeFzTeGdm4Yt7MDMLo7RQA8SLJ5yyNKXmG/c?=
 =?us-ascii?Q?HqJXw4clZyPsLleO3YJFJVbhp6Oue7CZpP7hjzHWs/ONaJUxybAjMgqsnAtA?=
 =?us-ascii?Q?QLw717XYafyRwoHso6NXVx+myg0r7VzZ5XXegI3r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0455712-9a38-49e0-260d-08dc7f844597
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 02:08:46.0252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qy7XOTi/1El/f3YjggYpAtygwPLlqa5LVc8rLkmpbtoD5V9Ww61sWjUpXMfxIWtWWhkDMCtRxDIWsYekZfE3TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642

gcc defaults to silence (off) for the following warnings, but clang
defaults to the opposite. These warnings are not useful for kselftests,
so silence them for the clang builds as well:

    -Wno-address-of-packed-member
    -Wno-gnu-variable-sized-type-not-at-end

This eliminates warnings for the net/ and user_events/ kselftest
subsystems, in these files:

    ./net/af_unix/scm_rights.c
    ./net/timestamping.c
    ./net/ipsec.c
    ./user_events/perf_test.c

Cc: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/lib.mk | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 2902787b89b2..41e879f3f8a2 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -50,6 +50,12 @@ else
 CLANG_FLAGS     += --target=$(notdir $(CROSS_COMPILE:%-=%))
 endif # CROSS_COMPILE
 
+# gcc defaults to silence (off) for the following warnings, but clang defaults
+# to the opposite. These warnings are not useful for kselftests, so silence them
+# for the clang builds as well.
+CFLAGS += -Wno-address-of-packed-member
+CFLAGS += -Wno-gnu-variable-sized-type-not-at-end
+
 CC := $(CLANG) $(CLANG_FLAGS) -fintegrated-as
 else
 CC := $(CROSS_COMPILE)gcc
-- 
2.45.1


