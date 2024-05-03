Return-Path: <linux-kselftest+bounces-9326-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 369148BA604
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 06:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54ABB1C220E1
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 04:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4753653372;
	Fri,  3 May 2024 04:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BODXZAs9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10E02E827;
	Fri,  3 May 2024 04:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714709935; cv=fail; b=DAo54sr4K/E2BhYgGBcrxtpJeKsj6+2hvUAIMFS8nBg58rObj0HKN48LBAsz73nobWc82XDK0tOpxakjhMUWaVx5WXzKAwybWAL/rkE9/UVBVNNA6A2SzQTTSGJymN97YNEJwn4kM2ZLXO0uj0XQF7RdP/8NRzQWoroD5i2PD4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714709935; c=relaxed/simple;
	bh=CmbSrZ28SsnUkmIsNzHPPipai7Ixu0t+gZuIWV28b+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IooK1eawViSY+9KfbTqbyU4l01zUBynADPzbWYVXnP87ca7hDJIkNNId4xNS2UznAV0R44CVdKknzgpeeRQ2Lm6xO+viNAjnrtkjKYMuFweg6hew1vL+ZKqmEIfn+RPBTPiRj2TXCJars4VkPUV6I1Xl4eQD988ZVPupnVfNUl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BODXZAs9; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/dIstoZBBKhbLaz5p+OhArKc+zNDS6zfgwkdfvtJjcHqgzMs6yc1ZWqk7ANltmRwDDBGG1COoC/9FIKELg6Qm7vKS6fIIyAZg31Ua94AEyqBkvbGz4GGIHElefKIzN2vIxvg2omXjLQDBG5nSufY1oxuC7xlW2rk8PbwMysnWfC+JjJAMdpoaIbU0waMwjcChZRLiqpC15DtOFuwV2LDI2jYFGOnbYsprnOLwka05srVzYQijCfU/hZYdp5zG42APLbDBCSQYvRKBVcfI6OvkGeCBYH36gLPQhl6HJurqzn/RyBwVatERVHhAVmPJun7RQnBtrfoKfGSU+/EaJ+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaOTjLI1jNgKfQtVwtbmXuBMpmygEJj+O6pPRmqs1hE=;
 b=jEHx1eVXFWzlVfzqb0Vjq38uKrSQRL2z9OLW2jHj5Eek261JR/AFtMA3Pva6ca/5rioxYHdMTd92UFH7CzKNFwOThzJrStvr9dXJ80vvQm9V9YAgV3qmb/bomzCWq4zXhNR8yPhmxwn66GzodK1443dEgTsLFAp786C5qrqCFq7dcak2ZZP7h28G+OLL0DUPU9Pg3n/sd64U5yNN+UH5CB9Aj8rg9ePI9IsTODPnlWCcnUxtI/QvFQHvzjMlloSBF2JydlwQ/juHXBSBl/xrKcsuNfC5xe1cZ/tEMvN4uuAInlUZaWIlqI/vK7WkNdYbHrexoOmCtoaySAbZOfax7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaOTjLI1jNgKfQtVwtbmXuBMpmygEJj+O6pPRmqs1hE=;
 b=BODXZAs9LOW52+TFAroFwkiWdsvoKEG19LmoWZl53qWPPMB3yxrWKa0N0IlJO+kW57YCVA9ewE+PfR6N8qtgnm2iPgek8YA/XDa5XnNlRLtVjOF4Sug2gEQTVC8nPprRuSmGgliBXIa4mSLLQ79VWge28gCZcTqIaQlCBqLPCkeuqQFhd7AuhS6lPM2MxZe269Id6eos1Xki7P9ZmKyrMoMwv6tPsuY3FYQQuYZVUTLw41Hp61cds5GijzRWMEqVuo5UsM6AK8amXmim+G3BBctV4XE2rY/3OETNp8CH15uExgSQXdBdHDNuDwongFkI8Q8Uo3IwbAuN0L9CQro33Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 04:18:48 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7519.035; Fri, 3 May 2024
 04:18:48 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	"Nysal Jan K . A" <nysal@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 3/3] selftests/futex: pass _GNU_SOURCE without a value to the compiler
Date: Thu,  2 May 2024 21:18:43 -0700
Message-ID: <20240503041843.99136-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240503041843.99136-1-jhubbard@nvidia.com>
References: <20240503041843.99136-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0078.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::19) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH8PR12MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 5facd09e-63a8-463f-2ac2-08dc6b282165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FQSwzkqnS4e9EzYfiCiu7coi+4wmfkkqt3zTmPvB7+wTtuTEhS+Nliv0xQsc?=
 =?us-ascii?Q?EJq0E2rtYty2BvmUIDLL7BOWvgOume6w609nFOR6In8gsv7wIC7D25qhJ3fG?=
 =?us-ascii?Q?S5OrwgnXoiQnE8bkXYC7qw/IzVDeaSqLhKwiqPBmQppX29e18Vr6xinS07c5?=
 =?us-ascii?Q?N5/jOyXjMeci4+0DN2LL0MpgD3+t5j6j5Shmh+sZzASDCumMhNxzM/KQEDL4?=
 =?us-ascii?Q?/NbOmQHn2bAcd0jgn00QTxJAgB40BWVb33vy930SEzRP9kKWOByQUvRQIK7K?=
 =?us-ascii?Q?Jj0cHPGiqc4GsKrcGOnhaaYdxLHTvnD7XX1ZwZCBqpvr834MaB7usy0DkgGf?=
 =?us-ascii?Q?tImMqd0orD4+wYBnBQWAxC5wrlb/9lEmGpuXRHlnXrJ43arU6vZDi3k4MR8K?=
 =?us-ascii?Q?TmlUznQ/+pnwerq2KFzeh9zs8kcqVpUw9VrOaCFEl95EAKcWZ/9Gq6qzKUP0?=
 =?us-ascii?Q?cbuMKxhXckvHnU8DoZ+vZF69EWfEDG3vwyRrgj7FTF7HYGQRxHj1wvCJ2b8K?=
 =?us-ascii?Q?6SHb9IrnQNpdsz0idiEyA6CynkcCtf9Cu5OKJR2ou9Xeht11rv70KDJpaoS7?=
 =?us-ascii?Q?JNtTaayJ/gGK/KlgpSQGB19Vd1JhdZH45V8D8ix2npnOsv3ILX4kuVQWN6Ko?=
 =?us-ascii?Q?a45nDkOSwQKQD7kEp85EgBh5LCYMU2wQwHE+0+bH625vWsf/Wu+QnSgTAJ4W?=
 =?us-ascii?Q?vGDHysvkuBAKJc5KyuixU4uDK/3VVnm89axXbD5/tWB4fdb8NLu3Le8jpZn2?=
 =?us-ascii?Q?ALGCMVC5fXk5wKJgrn7ow0o/eoVikKSr7WBmnCQYHBhHafAQRDZzOsXDAOVY?=
 =?us-ascii?Q?ADzV5kPj0N1zIqn2iav2N0sOvHmSonbCp4L232+ebPhaOGE0/mY9vuz6EgC+?=
 =?us-ascii?Q?5nQAMDVIYmx0Sx2n2kCLj6YpPGSsl1//q9NEcxoZLqJCHw6ORTSl/+n/2I22?=
 =?us-ascii?Q?3CA83mCOMwNasneS7IKC0Tm6s6pFfT82fVWO829Chzger7kU5B9hNKBrEp8V?=
 =?us-ascii?Q?zIsBr09rNw77xtjiurIddbZFvfW4Vfs+tM7or6RJND/yiEEER0pftOy5sFWl?=
 =?us-ascii?Q?+IKJxb3kJIfesn7bkBeL6/tq6t3vsj6PaPz5eCUJnK4P0ov2wpYSdAKQmwzd?=
 =?us-ascii?Q?b1I+uZfAMM2bVVc5r4puTIfTElTVWReuvJHTX/gtrlFg3rAIe2oHojHsrKeo?=
 =?us-ascii?Q?HloNtCj8cPhnfP1vQ/FDwKsXEXuUVrY+mZpfSw33P+CyQ1qSvOEe9jq2+cas?=
 =?us-ascii?Q?Ve58x1NOvl48vwGjl057nPVxw8xLuKx3GDChT9slKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L56CKwNkQfocUrymVLFMAKPBFHBVY8WAURciW37cLVMZxMarkyeprjXS12kB?=
 =?us-ascii?Q?UzwOxlzxkukpmQNYsCeMJgm9J+rzQkXa5muMTZvNlK53ACvW/x3tpU/f+9xV?=
 =?us-ascii?Q?cnUHklYaRCCP6eALeCxYMuLR74Q+cl0xyfI0zy391rUMFrIcEe/w6qMTljsm?=
 =?us-ascii?Q?2JYw665EcWIAJPVhfPABYXoqXymTpS6zHR8en1JuMBXSn3K/DfVnEccfZQD8?=
 =?us-ascii?Q?8cRbLhTduimvE8eH2EAf0lj6RhyBU8S1aLzYs93nh0umFp9+36SfUSnKD3HA?=
 =?us-ascii?Q?MGcphyfJEEw1kUWEQoOrzxFKoBqyCu8WlOlqPRgszlL80AbIoVizBr3SbQfU?=
 =?us-ascii?Q?dEqvu1tC/RkZ57g0F9Gzx4OWt9CIqcSgzdaAYmOzPRTNSheLveje/Lils7qv?=
 =?us-ascii?Q?bGVgMtcWk5AtcSlUz8JW70M2QkIMkROlxFnsVA1VF0/kP6g/S8xa/hF4bliq?=
 =?us-ascii?Q?KKDOd/uu+gxUbFJr1PxNSp8CSJYv4r2cp4q0t5m5UJ0dDQOfzc4v4T03xDAa?=
 =?us-ascii?Q?rEI9Ew9Psxrz07yyGBdaEVoAxxvSSf6wIRPckPRgczTbuCmC0kfk9HXBoBAw?=
 =?us-ascii?Q?8mca3/9q+puJJaNmLgVM4hO3yg4rLKmPXoSrf1yZ+lyj5TLRsh1N1biCPYqQ?=
 =?us-ascii?Q?czOtuWh6Gg8QCfedtLyVrTKKU12Z6bLUZBB+iKGHNbUvCdseEyUeDhIelzo6?=
 =?us-ascii?Q?bpmrJl7fOQMJca9RnA5WUu614aVvyiLlYXYeQBPvbMEzwGHmjcaZRM19NKpb?=
 =?us-ascii?Q?GzYcBt81rlyDtmtZ5ZokQSWKReH8Mw/EpqeCNQkXScDecltIHdHsGS18hPgb?=
 =?us-ascii?Q?xgyrN5785OAFcKV0J/I6lt6u35gvQJoODh2UuOFdp13+lNTI+KS1dN+EeiPv?=
 =?us-ascii?Q?jYC5tJZ+AGLnpu7HZoa/3DqgcgWTs+n0UkEox8gqUAu5QOmE6TsUvafcpVwS?=
 =?us-ascii?Q?NwJ21vXq87aFeqULoUu5DvbWCcgVMSwXSZCCIzSY/cqYXDSRTV0V2fDAftaa?=
 =?us-ascii?Q?H8VZen4pWBYucOF9+qOZ5W+zMa5zck/I1d3Lzb1Sqjxnfws5G4pIpVp6ZgnS?=
 =?us-ascii?Q?VxT9jm9zRZI0u3WbUiPNfMqzu8ZxETzcY4Owg8b2zRqrKbspxLPC/+dLKgbC?=
 =?us-ascii?Q?QKOyZqcx5Fyw9R3FnnWLZGxU3QAiBwA3jEFvG/T7nTdfsQLOpzUuadjB7nvz?=
 =?us-ascii?Q?0+i8Qk1Es7QiqBBt+9eSluei/qMCZvXakbaRjDUvc74POorsIN2Ayj9rbm/N?=
 =?us-ascii?Q?8AZvXXM9r5oJaod9pdJW5wnQ1OiyxSC/VJLfRj7oBQ40pRLBRbmtJ9R2P62p?=
 =?us-ascii?Q?GYWQYItlzvYzhRdChNk8BnUkDSi1Cjrci2as/ZSz7b6YiHNx7jg54nabLFI/?=
 =?us-ascii?Q?r9uzoumpgLSWVu1owmBEQ1MKAJn0SRwBjsnD+5nV5E0bIoguug0Dlcq6nWMv?=
 =?us-ascii?Q?U8YneuxAsEO1U249Q1cOo7QyOqdaSBstLuktY4fWi9L/zxU5ocWmtxMgrOxI?=
 =?us-ascii?Q?20DNNMIXRMM5oQmyAKJ8GiFQ3cUfm2gt6oFOP7wkbQO91eqKkDkEHqTihlwt?=
 =?us-ascii?Q?Z6pkNLS0ILLA5BIcp/zXKXdVucaFUkl/iwyEgfkZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5facd09e-63a8-463f-2ac2-08dc6b282165
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 04:18:48.3900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BHXq2/P9k1GM5A0HDeuprddrAFQcn+5GcE8r8otcSjzKpZ17Vo91oJkLf48VtHhd9Lx7h8drelzsWkbPGoihw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445

It's slightly better to set _GNU_SOURCE in the source code, but if one
must do it via the compiler invocation, then the best way to do so is
this:

    $(CC) -D_GNU_SOURCE=

...because otherwise, if this form is used:

    $(CC) -D_GNU_SOURCE

...then that leads the compiler to set a value, as if you had passed in:

    $(CC) -D_GNU_SOURCE=1

That, in turn, leads to warnings under both gcc and clang, like this:

    futex_requeue_pi.c:20: warning: "_GNU_SOURCE" redefined

Fix this by using the "-D_GNU_SOURCE=" form.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/futex/functional/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index a392d0917b4e..994fa3468f17 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
-CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE -pthread $(INCLUDES) $(KHDR_INCLUDES)
+CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE= -pthread $(INCLUDES) $(KHDR_INCLUDES)
 LDLIBS := -lpthread -lrt
 
 LOCAL_HDRS := \
-- 
2.45.0


