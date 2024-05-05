Return-Path: <linux-kselftest+bounces-9492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F17048BC47D
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2024 00:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3A11F21554
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 22:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74132136E35;
	Sun,  5 May 2024 22:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e9wNgF12"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA6F823D0;
	Sun,  5 May 2024 22:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714948019; cv=fail; b=hIS5PD+DRf8iBBTltQveOAnHiOU5+iDOTMWDI3pvw439myfqm6YN7ArA4zHKEIaBYKj5ffBtR5zwBHr9D3pwvMpdyk1rPLTwrYr5iotVcnk5t3IQGQov26PjHk28jzLVDUFJ3TIemc+yvkNRvc7e7fstVaWlOpwVtYKiVs6RM8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714948019; c=relaxed/simple;
	bh=trq2X18owI9cPkNRw4FX4Rig/lrnE1/P86AIcSaQ6is=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gfHKzKs9bNszr/lBLfmAPRBPvH0AK04BS5EcAgEBuApujlyP1CGDgYJFKH1tA/sdnJNzn0953mA5YmYgXBA+s/zH1qhSo1RaxoN1YDSLXvpp49/OWzT8X7Qx0goavDM45DfdM+YKgurrCB6WDXFgYsyEitl2uc2j08z+STSf1M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e9wNgF12; arc=fail smtp.client-ip=40.107.102.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wp2z3bOoIJAiuw5CkEhD6Zw1F5x8th80U/GnAyXg3pZGn5M5EsGlLGR3NuSmPIlbHTmw/iUFq4upwPDWy3venD3z2ixhcu+NdUdnJIAnmEKp1aCWHhTGMNf1Ob+mMU/7dZhmnrScJlLz7CeZfUDZb5A8ZWmsQu6i833Sntg/3x3cB76sNgXJ3+uA8drE1EBHqsfdBaWvOLmFlMurlxq+pYjgC2dGvoKjhd423ncFQDN4tYoztuENF1jOxoQSLdsOxMuN7bUMQTdq7UdoNFEGgXkcW5Py7ASchS6GNbgvWF0UAm+217i+/2U1DzvAZEDrACxI8ufcOKymtEw2Z5XZmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+6rQ82Asznxuxs1pwuTWwPA2rHPf2EwWRBjGwrBVwA=;
 b=DAedQ02qg0yBNPAombGEqCjkQmvfbnjSKyDyr8j3HXLRHkMw6fzFEImPT7BCKwaIT+ERMyRi4g4/OJLR1ys2aJYh+eXj9gDSJmUGGmD90sGC+svMHR2msE4Z+3AnP+Du5KGmcqOv7rI11D0w+IvJBdHCy/+huhFDcjOHfyVsmhbqewPF8dYUVXUSI3+ZcgUhn4Tos/D6ph50LU9mIdslLNozabtKDulBc1b7yEhwCUcaM/KCx0KfK8U832POEZ+vy141c5bZES0/QOfdie57POERaw67l6bCnfYcMY0WsataB4iOfGiyRcGLtA1hUXLkXCOLZgaYzEACXQbQDr0LHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+6rQ82Asznxuxs1pwuTWwPA2rHPf2EwWRBjGwrBVwA=;
 b=e9wNgF12EG37c+PY7JyXrRB8v4QqGONXVNoavvSZb5cMHDNroiCtIgT8YRol4/53Vlp1hSoDlpO47yHjgBHEHNXSQtbuN4mmWnupTYwvgoroF+x6YAKYzYbnM6dP3CiVfjIeUVxzvVG71wWqVg/qpUQz+2FmKdTO2FpGXetlYuduTfRPIQerNxnK+z+qdD5UbcSty+aACqmPTjiZNSxGgABe6JqrAC8kpJ8muwxZnBzy5ZQQBp5Aj+ePiuXAeu39PUnZibXSnKUahgH5relkYglVF2c6nMjDAvicd5xG7WmRDXCWOXGavQ2X7nkTPjyzugKfDprILU9XrCNZHyLDwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Sun, 5 May
 2024 22:26:52 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.041; Sun, 5 May 2024
 22:26:51 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Pravin B Shelar <pshelar@ovn.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	zhujun2 <zhujun2@cmss.chinamobile.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org,
	mptcp@lists.linux.dev,
	dev@openvswitch.org,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/2] selftests/net: suppress clang's "variable-sized type not at the end" warning
Date: Sun,  5 May 2024 15:26:38 -0700
Message-ID: <20240505222639.70317-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::34) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|LV3PR12MB9265:EE_
X-MS-Office365-Filtering-Correlation-Id: b09bd21b-1e1d-42f3-5ebe-08dc6d5275d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CjaI5GgeGp6NuTwWa+esuIXfke8fvm3a8jCO9Ld4dMSkY32IvD/2yiJS7fZv?=
 =?us-ascii?Q?ovyZ3J1pfns9eYjZP74aONXBR2sVA64J17Zx66h4Q4TkXUzGKrmvq9mzfUzP?=
 =?us-ascii?Q?5GxZ+SfFEA+dfeTwvbUViJnGtYuMUlMQUM9f9kYJgbq6sIFBcySujkYb1S+P?=
 =?us-ascii?Q?pkXWxdWsWIQBQK0XgVn5hOe/77Z7QZhYRt/n64WK0+WxZEV/Rki/+Njt28Yz?=
 =?us-ascii?Q?e5Jk03y2z9ub1Cz58fG324vr37aqsp0oJkaGLfIa9HB3VO/xjtCSL9aZVlvA?=
 =?us-ascii?Q?ku/9ezPM7Yon7U5hmWYLlmi2Dpy5bQTFAVgMk/i8gE8NyC9alxqgw3w1I8Bo?=
 =?us-ascii?Q?6yyMGwZAmVRv0KidCYUZjpyRhLpDUrqvE0NEHCLsOIUy1Fq2Jn/eao89PT29?=
 =?us-ascii?Q?fws1pdaTaztK/wdJ56UQi/jsei6W12bMpJMWwjVEKeG2FFesPV9qYOv0RsW8?=
 =?us-ascii?Q?1GvpL6NCVAd4g871r5+qCetzqN5ytj5ka16HWrCDiNnzNqH//zNHbSqOO3/e?=
 =?us-ascii?Q?Yl4Xqkp/s1wETGwtMwliaFMhtv64RwIT+T4T7/KYxTryrMW3NiJJPEFXfz9v?=
 =?us-ascii?Q?gkraJNfBC/R9Fq0h1qgCk/Ph/WtG4hi+cK/zUOAdPRVhQQs7ndK9pXbMaZI+?=
 =?us-ascii?Q?ftlZbrWq4/NTum1XpZ/KQWvBoyEK+Qw82zZJ710A80gC7L4U5QMKMK/+Dqaz?=
 =?us-ascii?Q?qnuHehSgHi4NfaM3sjYOZrNgTEuU/Xvt+oNw89+hZInx1t32iJ6/ue041wbB?=
 =?us-ascii?Q?kSwvRwaP2ZyH1dI0q6LfW8hJOoNGSxil1vUy2M9e82gAeU1BmaHegVkAWSWh?=
 =?us-ascii?Q?kLPp8R4jKLhMhSa9ugUTNB0RiCunS3OKaKHZwWQZIBplzK1ZcmmJafBgA/vV?=
 =?us-ascii?Q?ro4RsPIIcXXacqtdqbt80gQHRm1kcH4zoKVLAyxZfshLdsIGXx/JdGUCyJcM?=
 =?us-ascii?Q?/WcqCIc7BwkCEEAzoH6nttF3bmD5V7uQ0/0dQFBApKMrZA2ctloW8mdV1npB?=
 =?us-ascii?Q?5gJZeTcUuxf0mc27lR/ngmxsQqH3qiSplMV4Qyt/zidVBdY94IvdvU19/PbO?=
 =?us-ascii?Q?hwLG1SPSeauW72RDcyzoUuQBUO3LBghLn+cifZB0JB209RNPg+VfhDnyBZO1?=
 =?us-ascii?Q?z6/IDgKb9n4n2egXYgK75qSAJBVdLBGZbIkjYaOFVHpHTDPEozm+3exhVeFP?=
 =?us-ascii?Q?VVmCN0kfazxjlYLaH6rRwMeOsV3yvk+7MpyD/G9VFuLsOhVKgIU3J06d8qxC?=
 =?us-ascii?Q?i1MMmqtpa4AGxsT/+qQc6NZmmW0Lg7WQpy392y2MKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4OqZA8n8FWetYkyoP0j8dLnh2Vg0qJP3GVoeojohSz3PKdTOC6iXwdg8YSNm?=
 =?us-ascii?Q?/I8JdW2dQoj5JJL6DqGXhXZNUKnIFFJ17K9NEjYhP8KSEay2oAFcSzDpD905?=
 =?us-ascii?Q?bmD7FMd7gla1BD/NVMKYC1JEbhmz2OUBYrUokN1BUfdnNfq9ob9DjS5KOW+h?=
 =?us-ascii?Q?2entV54m5koNQky47wNViqxDc6x53FZ8KwNmV5JmXJ3n+EAEAQYbr/Tusyb2?=
 =?us-ascii?Q?JrS9gvh5D/GZMaQkCQKcHRMqXSAglBTxVi3Gzg1KdfXB+kgI0nPJ233CKgEG?=
 =?us-ascii?Q?1aDVLjhzexxXqpFpXZSw+JOilndzQ6nS0o8LwW5jIWXlSUbHXiiEorqlElEu?=
 =?us-ascii?Q?bPcp55IJKSA9RBLJLOYFVgayCYyYowxI2TJEevvtgWC06Gjvj4pL30FZmlIY?=
 =?us-ascii?Q?GNcEOZFuv9eGVfw95X6fzdkkt1wDuPq96BvF1d0jjBgqqQtJsczK+1OuozRC?=
 =?us-ascii?Q?wQcgfZugLxYildjThDWCYaMZ8Ppo6v+LYwAUzEcKBE7GbUH4yPhQp0QONzbY?=
 =?us-ascii?Q?CJQQbuJFaX2FelCHZncGtENsINM/Z0zWCuDdaHzCMVFtA4RYgww6tbJ5QGJx?=
 =?us-ascii?Q?av0JjthJb+IPhqcQMtQUB38SNUnMMmKFB/0Agrh0N9ZeynneccfNmkEnV5Uc?=
 =?us-ascii?Q?fgXjKBSMmIc8zots6oimfqz3nqXu9Z+aneOg8graq1hO4CH8SSyeR2W/yX4/?=
 =?us-ascii?Q?Qqftl2hJAtgZO0LYYEI2I+JNr+jJJzV0mCr7af9okf3ZZSH7Psvgre/ba/Aw?=
 =?us-ascii?Q?yY4sMejHuxMYUsCT+BJRiX2WDa9DueKzK5JPhDwyTOg0mzSSwWHAU05OxUo1?=
 =?us-ascii?Q?nIIKPFv5LCsWDceFjVgpWjL3kTlcPbk30syuRwqTlWigk/0cCBUZAlJfwEsN?=
 =?us-ascii?Q?L0b1O7ev/IxKxUe4MWVJ1cLmqxU/mXVZ0T2V4Yfwl/puUVn8nUiBHpXCqA8L?=
 =?us-ascii?Q?KtDW9WSqpimAhwN7sctBIvjLuqVv11dkzX4JKTvvk/90BB/TwZ7x/hyLKVqI?=
 =?us-ascii?Q?iqaj00MuBwcnfTAAcM3JE9VKszFGTm3naT6sUN3G+8NAuUttDmHv+1HJDZm6?=
 =?us-ascii?Q?9SU/DOSMozx316bMjMKbVf3h4xKpyGplDqRBuOCfSB4fwHLk54sSo6ViU6Dr?=
 =?us-ascii?Q?j8zG/9fCyVcBMjOBD2G0OjAlO766JretRzPdVbiIQZDZZr95vFlSXtgPLDzn?=
 =?us-ascii?Q?OQw8onuY7LQtx4WX5Uulg0HN0SgAwUnkYtACml3vc592kHjFfQoV7he2l0oP?=
 =?us-ascii?Q?p26lEcTPm3U2h3vX++JH90xjo3tUalet7GrAMbEKD4FyWsB7vlMeh+QWS2v7?=
 =?us-ascii?Q?F7QsS1QudAb2JvZo6hE3N1XlT3FW2rNt16xILUVRYey7jNaWfIM4+KWLb1/P?=
 =?us-ascii?Q?Xy1JQQIX3aPOLhIyzeyHa7Zzxhq3N+E7qVn8mEDkcUNLZGdbhOFRV4tqSYxK?=
 =?us-ascii?Q?EowLLntk4I/0sFt7hqLxPAVuS1NVjdFxoXsswH9TEAKe129Dv17RHGoohsg2?=
 =?us-ascii?Q?xcsnu6uMzVk6nsWxIaut4+i/+Jkyj/rhS5qzTQzWwjCt65gnxFCxh7/t7c2L?=
 =?us-ascii?Q?9IWWKwtCpoCekA83iVFvJTN0qILn8WjeOt8Gf6IttUA7+IHD4YdkJf91CWlO?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09bd21b-1e1d-42f3-5ebe-08dc6d5275d0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 22:26:51.2072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+i8CCS7lo/5x71hzNprfwQgpxYIWN4z6cEWNEWZ1BNrP/cuO85CZ6B7mwwDuaTUxGZ+gLYLOfn1i+/jUD9feQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9265

When building with clang, via:

    make LLVM=1 -C tools/testing/selftest

...clang warns that "a variable sized type not at the end of a struct or
class is a GNU extension".

These cases are not easily changed, because they involve structs that
are part of the API. Fortunately, however, the tests seem to be doing
just fine (specifically, neither affected test runs any differently with
gcc vs. clang builds, on my test system) regardless of the warning. So,
all the warning is doing is preventing a clean build of selftests/net.

Fix this by suppressing this particular clang warning for the
selftests/net suite.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/net/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 7b6918d5f4af..956481174783 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -6,6 +6,10 @@ CFLAGS += -I../../../../usr/include/ $(KHDR_INCLUDES)
 # Additional include paths needed by kselftest.h
 CFLAGS += -I../
 
+ifneq ($(LLVM),)
+    CFLAGS += -Wno-gnu-variable-sized-type-not-at-end
+endif
+
 TEST_PROGS := run_netsocktests run_afpackettests test_bpf.sh netdevice.sh \
 	      rtnetlink.sh xfrm_policy.sh test_blackhole_dev.sh
 TEST_PROGS += fib_tests.sh fib-onlink-tests.sh pmtu.sh udpgso.sh ip_defrag.sh

base-commit: f462ae0edd3703edd6f22fe41d336369c38b884b
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
-- 
2.45.0


