Return-Path: <linux-kselftest+bounces-9487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FB98BC3FB
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 23:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02BF1F21E95
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 21:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BFF7D07D;
	Sun,  5 May 2024 21:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XKaLDONy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9037D6BFD2;
	Sun,  5 May 2024 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714944940; cv=fail; b=oOY+22uIFi9v2f4Bs+FXTjXx96uxzutZPtY0CGqBrrn2tqjLdYwEQHI5XtNiEmT3ZYj71juZJwwSMVJ2/NSpHat7KS9rRVvhZynSpoyl+lBBBkIbmRGFI9/19gS9cZFT+DBvCrjIbT2VrlbMK6485dz/0Zf9Khuj0foBxzLZqwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714944940; c=relaxed/simple;
	bh=1RY+zWrw7pcPhN+7E1CJSjN3wBIXsxLamrYnV+7Ub1o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bqzgSAakorrPcHUnqlU8JP6V9DJt/xAlzK44MwZxjL7yW/m3smQi0jlpJ3/Ix0+ZGzrJgzNvblOlliN2vDKxH6uXtdkoWkt/bMlaScucFwxXmhAS2m2vCjKNfQVBmZeBFHqix7B0guJxQgjz/NTHTl0oXAYy56Twn8BXXcESXRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XKaLDONy; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCsWt2VcLu7qpa4qsWLO6DKZM8hyuMvOJLl3IbXICeOv6CjT5qkAu/fZGIQTtku6Zrkmwc4EpFTG7LTprm7PQE8KEq/BZH33C8W52yQQLZqyQioiCeoKFS+z2VPHiZ4w4yZgJATwkmJRfxlR8ULYKnqzbuoHtmMU1ge/Mj0VbMY60kM7EKhQ/Ifq+QMEFTi+ICH846Ds2lIWbQr33Ap27t1vwxhL8M6ogxpAdQhFuTa8a3taL2Ji3KFfiGE6m0LqW8PzKsrpEef/caWfV6iXWZJNpJKsSiilRDzj6j3cN7/RuSuqlwegOs1dsJjHotaCKgeBOyOaMEYApqiOOj4fRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qfc1BG5kr5nwR7ndG+KyYQO2zsUXMJt2sD/zBV2LUN4=;
 b=VLEyijCNb/9vDQIGLQRPOc4IpQ8hrqsnmLhiZhvtsClRUrZHeEbxgJQfAHsZ3ZCIkWGcUuwI9ygjGdG+IJiWVwuEHXCWvUSLyVsUmHgUDZUAJISdsKA2zXYL54KAnwb8lT4JHtYjkJDysHUwT1r4K1nn545w5uyP3wsZqGjkKJGNBC2rE3jOWFpGN9fiTkKmxs2YvR6dSzDjGWyq0fNohio6dyeNfZeJ0EILCEsbRnUE3M8RaUQTn9j4EpfDVXdNq3eMQsSJN54dFojvrZQOe5UuwcbI5Vx2d1aZ2+Qve2W5/0wcxCRTLUUG50c5Bt8M35k/ou9nZF6Rg0NjP1wZDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qfc1BG5kr5nwR7ndG+KyYQO2zsUXMJt2sD/zBV2LUN4=;
 b=XKaLDONyfF7F1TGJP8Hp4+f+8iaLh12do/UbiHFgYAALixWie17DO91xIcP7NHAwabTe2kTBbG9WrM/nju6a6Lr+Fet48e5pTLb0FjtLMgJBS4jWb+FGU12U3V8oseBgzdwpUHR9Bn2eWeVSBlC+DaMCU24zmWEpyj3U8CWTDrES0W7YGl345A3r+2RnFOULLtvsh4tPRZLt7Lg3+FQeRcVuGVwjAjNtn2HfKro0rPwD9RGxZX40MsvQASkW9c7jlUv+0pLP8IAE9Tw2SF8wQVNbRFvPC1fTtWdhlniUu8rZ2TeLdrAYFsG1xv7RgkjAFuhsJsYj4KrhorkadPEyIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CY5PR12MB6647.namprd12.prod.outlook.com (2603:10b6:930:40::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Sun, 5 May
 2024 21:35:36 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.041; Sun, 5 May 2024
 21:35:36 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Brown <broonie@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	sunliming <sunliming@kylinos.cn>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] selftests/user_events: silence a clang warning: address of packed member
Date: Sun,  5 May 2024 14:35:23 -0700
Message-ID: <20240505213523.60492-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0073.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::14) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|CY5PR12MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: b2a5b1d5-9a49-4fb1-edec-08dc6d4b4ce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rxq8zJPrZMa5WaASDZqIVllTWtAkKVfsbIPlcz8hbmTOwdhPOJ9v7YHdj1Pa?=
 =?us-ascii?Q?B5QpABAEarXme7mINvQUZSrrAcQiNS2YWzgqdoBjGDHWSZmBPCqxTpt+vQgA?=
 =?us-ascii?Q?YmKxRlWSAtYmnD2VjOwi8HBrVb7QrY76teH/ERVPv+VvzC9qL8MkF53PBqhx?=
 =?us-ascii?Q?vQyjh17TIeMui4osqkE5IAzHbByYuJPNqjkU4GcFefHlQF5UI/jnVMAu1n9z?=
 =?us-ascii?Q?4X7/uJ6XwlY3kaIlV7ldEu/CS2J47QcHkx6Cldekoy+V+N9rNSDg7kYTIdoM?=
 =?us-ascii?Q?FYFeX+XBOhmcdRzO2w7Pea6vxqE2YJ8pPsVJb56TcGADnggjJHaFcexyDdX5?=
 =?us-ascii?Q?y5PuWU2VCuXu9OPmuONKue0z7f0NSWL+darBQYQfGykRPXoujYP+PjsYVGbQ?=
 =?us-ascii?Q?ZbbidIUEpu/b6/MmkhjiUyOEooV+yx0AUw6bSIjHDf6jcwvo7XirW/voJMW0?=
 =?us-ascii?Q?+ZUOwzQYk3oX1u5Agg+5zpXdtAD4IMVelITwikAn1mg53LfAlB8O/60juwei?=
 =?us-ascii?Q?fhFNUnK8Cv0q1KNh/ZyIPlCtTUfGulXZ9zKgDmpMewnp0cezfuTNfQ+k1E27?=
 =?us-ascii?Q?GaphXSsmDnyjrMofNCoFJbj8ANdjMw9w0KF+kavZIKgUiymh4erMPRudoAlR?=
 =?us-ascii?Q?Z63wM+zLhxY0ZL7aZWMLQzb0mQA2ZL9klgzAzilNwAURnXO2LoTnYltyjY3a?=
 =?us-ascii?Q?FdLH4xfshgRuUx1mxSYnte6+938zXjSguG6tfs2berhWKVMxaKJf4gCTTYvN?=
 =?us-ascii?Q?ig0t4mZCjbyod6ec+dC7uW0gyURXLJ1YqM3fjzKlcj5A1wiUOstaquwdtAdo?=
 =?us-ascii?Q?4b3HKXiSDHeQV1imLbK3lzd8m97me1rOSgQ1Cuk86dcAYHIQ//vE+/mpLeFQ?=
 =?us-ascii?Q?i2Kc0q9XcFGZZBLFChIuZp9et1BKTevBLvHJvt1Wqlhu2+3BqDEV5qAGv0K2?=
 =?us-ascii?Q?y1Ok29zSmPShbgc7PUyS6DEHSRf8kEaCi1ZsGhDA1wIbWt0A0hfZXkH2tUjR?=
 =?us-ascii?Q?/ZS9NkEzCa1GKTE1FE92R4F2UD5gj7KT70YjjppYLkU/xjI/3Xky81SmF66B?=
 =?us-ascii?Q?Q86mZ0KnfkzOBMd+z1iUVVRessJxVZIhD29fnCXHMUctCUbTxBpSfekYwoRg?=
 =?us-ascii?Q?rf/keUYQJKYgZsang/kBhE8fKXVIv2cLJg0tRGpXJFchWxVln0SGDri3SOQs?=
 =?us-ascii?Q?sVbkB42HldYpLUONylue1qFLQR+pQI1Wnh2BfjlFcikEhQi2pcrb0YY6r+Jv?=
 =?us-ascii?Q?UEPPFY5iR8krcy8DcOgA+ilAUZmejYigGMtBeJOWZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rHLjcwbyYuFC/3R5Ido/gfq0VqbtUBYqwqSNgz5UGveLi+JCdUqRcgoABmYa?=
 =?us-ascii?Q?5YU1iInuzuGtXNK+YRAR90D/5N4Olu+k71590EBmalnW0/OhRiZA1WyQOHz6?=
 =?us-ascii?Q?xtYJSCCb6yUsf4KwZbSrP/S86GsFQIoCR7zQ+tmzPtWgN5lrM6rjRsSqFvLo?=
 =?us-ascii?Q?rDmGhEggu5752CA72QPv892u/F+FsKkCU4hJnjqswJuWiHT0yrWt/bDCAzGY?=
 =?us-ascii?Q?bszXNg1xy83edAE3BHaXA4wB21MITJ3g9I3bxd4qR65tzoFSULErlPrFBcpM?=
 =?us-ascii?Q?cv6GH7KduYnkkiiMNsQMHrZgAAYbSlv2sw5ZWdzBYeXxOCixmyuLxWn5HTUP?=
 =?us-ascii?Q?JjuQiagfY3aqZNWylDWKV0GY1P+tqwXuGkNH/Ev4GQsED24OkpUXw+ImhYmr?=
 =?us-ascii?Q?GcXY2QBU0Dmyjd5o6XV3sztGaRIuocvK+xq2WScm6YtWn0/LkZ0uo/Z9JXVu?=
 =?us-ascii?Q?3wlWLZArmhsjUz5CZPUusGL6RpFcOFVCOXAw7T2/1lizvpY/GxodVPe1nC7a?=
 =?us-ascii?Q?1WzDWva2FSyf4LlnCbGhezcL9LytOAzJ9em7p1XIDXUMHHNFFxKfjNdV3BgM?=
 =?us-ascii?Q?/23sg7u/U+9jQvShqSCxFz3cSrCtQ7ZhoOQKtVTv35919dq1ewwM5UM4TBIO?=
 =?us-ascii?Q?X0/5XUjabbg3Mu3XaMacVjwzbvqZ9m0W93k4VcwD8+JRFNunvmPhCcK8wYaI?=
 =?us-ascii?Q?lKVq0JZvDjlxcF9EOr0JTWvBMNOtgNLEoN0pQSrXnRxw9vDMFXtzV+7IgO40?=
 =?us-ascii?Q?+HVJpQOp+SQqfWw1bXoJozs/C5FzIgenRgKV/6G6LP1ZOWIBdTBAbDA0HJQ+?=
 =?us-ascii?Q?/IEpgTuDe79Iz5HALZtlRrttR8AwqlPEAdht8KUZpssRYIpFnljwqbIHVWlU?=
 =?us-ascii?Q?maWOFWdpSCjVHAt93kMZtMbb3FxK5qSVxg4eWQfPkA0TnrirZ21L20jsG0LS?=
 =?us-ascii?Q?8IbgbbZxYd8/43w+O1moFBPnJ/rdS5WeHXZeeIyTjP7u1O/HRBu5O2/1g7pZ?=
 =?us-ascii?Q?xbA1cKYeM1VQkvLTjXvRQdvhaAp4Wd0bf37Usm7Grhm1NkSGVdlr2ojbjlLH?=
 =?us-ascii?Q?LkrDK0FvrefIDOKnw6CUkJSbddeAFjsxISInKFkU4dy5tFOH69e14ZZVGehO?=
 =?us-ascii?Q?DxOopQ/iisFOTUQWUXy6ETzLA5uyn32zm47FL5eNf8vxsyu1X3KsGf566znB?=
 =?us-ascii?Q?fvZbjojW9NT4+5hkFUsCKVWbhcfDRkhQD5sPKiKxQxrBT/da1OtwIrtLQ9Cw?=
 =?us-ascii?Q?qh0lR4FRjSTakIC9tKDWw0BCY3NLW3smViAk94LpcXBz6xTFQHSbKTbrlcZP?=
 =?us-ascii?Q?/MDTdA5SXB8x7bUaIr+beuEfowCG17j81NajRUqnXwrh3bNAGGmvkpRIzSZD?=
 =?us-ascii?Q?VsQ/gSpSdMpMfKCLLOLbhbN3RaIy+DMq3jqtqsAJSms3qgU8nLpTjlcVWDhV?=
 =?us-ascii?Q?fncXNaQ+LC6veiMHhNuLMq/cojWkXyBrOAHSHwkrZ0I4e3uR9F7g98lzZTa8?=
 =?us-ascii?Q?WhZGcs3XZcFvy7FMeGpaYnIiDJl7j/CZhmB+C7w/bnFQ8QZ1DtViWUihpgtm?=
 =?us-ascii?Q?q+fnJa9sLywSjF0EMwzaOkKWQGOjSm8hZvb06xa7Ob/gStCtMW8OjFxrcxka?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a5b1d5-9a49-4fb1-edec-08dc6d4b4ce0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 21:35:36.0757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVR0Sz4NqQoN9hjPaze/E/59a0R1BH7aAo0+BOUGe61mWo1mseUF04d4j/IBIllc8mX4NZQP6EYPdqlb1/2YGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6647

When building with clang, via:

    make LLVM=1 -C tools/testing/selftest

...clang warns about "taking address of packed member 'write_index' ".
This is not particularly helpful, because the test code really wants to
write to exactly this location, and if it ends up being unaligned, then
the test won't work (and may segfault, depending on the CPU type).

If that ever comes up, it will be obvious and can be fixed. But all it's
doing now is prevent a clean clang build, so disable the warning.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/user_events/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/user_events/Makefile b/tools/testing/selftests/user_events/Makefile
index 10fcd0066203..617e94344711 100644
--- a/tools/testing/selftests/user_events/Makefile
+++ b/tools/testing/selftests/user_events/Makefile
@@ -1,5 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
+
+ifneq ($(LLVM),)
+    CFLAGS += -Wno-address-of-packed-member
+endif
+
 LDLIBS += -lrt -lpthread -lm
 
 TEST_GEN_PROGS = ftrace_test dyn_test perf_test abi_test

base-commit: f462ae0edd3703edd6f22fe41d336369c38b884b
prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
-- 
2.45.0


