Return-Path: <linux-kselftest+bounces-44352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB05C1CF2A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 20:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1861889CA9
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 19:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5D0359F97;
	Wed, 29 Oct 2025 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j59pACI+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A88435A153;
	Wed, 29 Oct 2025 19:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761765179; cv=fail; b=aRrEYXAZvZ59bokxsE8o8HOILmhme1/7AVLgqfwNLqtej6ReEfzNZPOD5XyuBwledao32T7+3kEMO34pxo8ve4/E3PqQ2PKq5Jlw6yyaPf6Gzxcp1tinuZqaqgfBZyngfSvUZ8fR6DPOyVR40RkTXXhc04ZBExO3qeyyUUHegcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761765179; c=relaxed/simple;
	bh=hgyL6Rsc0V6fNIkkU8hMWtMsNRp79qteNYcQ22Vw7uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tatAA7Bc+XnpO89doW8mqjsEFTezgLfz59EKyvwOl2XUnFanWKp5KPNNhyBDgnPHcfaOV+NQty0d7xXCWv12l2DhCLunRmCsjL1h9LUYsHWJX3L2f9/O6+LQBDrhhZNdkk7MClDvMP5Amcsdw+rFRojSbFOBGOpEOtJ5CG+ws9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j59pACI+; arc=fail smtp.client-ip=52.101.56.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBLD3lGtVba4ntp/jEeGMqVptmWz210wuEgY4g0S00Vvxk7DdN31sGKYM0oMalDbM7zZpQcmLFF1TamKZLUchszt3B55c4X7IuEnxLwnVOZILwUKlwU2uueLlOHIjCFMnoGuQm9QAorT6TnJOMxtZ8r7nSIvWOd2oPF0TESKudUje9vVF1jg5tu0Mz2M7A/3g5+uuTRVcRZPrLwIx25zgQyN01OuBi807VjOqWNkk7TfZLLcd+0nPxBpbasV0isosvgI7B7WyifJaP+0Lc6N7JnaMgcCJk+v0hhuylktOt1YUT36mav7Ur2ab32YgN/ldsk6Diilx49SAHrQrxHedw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYW/fy2IFR3++0QEFW3PVbCD+bnxad7q7Ghqp89XWII=;
 b=kE2/YXtjb2ikGURCf4XzOSOefy7aHRI70zTqKUQeRCg2peJ/A7hHfWJzhkgk7VZ8CtMqhrArgYXDMo/jmfM5UgiOimE8ZGJmm2vjdtogPMqTE6nXrWqf6ThEimKiitErveONHXB94r0A2iJV3vlA651mrQGiexmlIUizOY49YyOpbJ0InXZuGWy/BzbpMu8hnbjThwNzXlq4fF2ILUuUNhclhQyjCKPNLyHjJ3YdQIFKRVjWpGhVHgZ7lfkuS+Pa46/6GH3M1LPuAlNJgvyqGalv2YujpcDtAgzzE9vMGMK+ckgs/6S12GIBZvQDlWedveI9BDdjuGW+iqTDiqje9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYW/fy2IFR3++0QEFW3PVbCD+bnxad7q7Ghqp89XWII=;
 b=j59pACI+dLlg4f8fSOxW/MBMqAhW7Rp+nU/tzAOhnFOeaRWBjXt512KPuIFOcPC2jzWM+2LPbW3maXcHeRuYgtBUxPNTQXlLum5UmiVvCWQvh8xCm4ksjLpM6/u208hjq+dHoCHPaym90ltQegn2jjGMrqtXby5VjhH/lRAbBurRUtSnypn/J7Hye/PmSBiSTEsU7JUxCtmBJCfnvXmWNBej1SSalrezXoyc+8J5gyAYWJBw1pZEWckXkZqECH15Ab2yUrTKvJPden1Qup8nM3s2+00LKKmt32cf2E2hrOmN4Bga82daWPvwIrCXeE+Y78GcLRn57UVz8oRJl4T79w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 19:12:51 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9253.017; Wed, 29 Oct 2025
 19:12:51 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] selftests/sched_ext: Add test for sched_ext dl_server
Date: Wed, 29 Oct 2025 20:08:47 +0100
Message-ID: <20251029191111.167537-11-arighi@nvidia.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251029191111.167537-1-arighi@nvidia.com>
References: <20251029191111.167537-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0030.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 59c7a5b1-1922-4dce-12f5-08de171f278e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vKI4oHAFxsFMglDVQdWc1ZdLvCGN/jTGNCGgAZ91N0dsQPxgyS6LBAr9w3mJ?=
 =?us-ascii?Q?cfQAvuXwB51PCRFl+CRXbbUK8valWBB9Hmk0DtHRq/GsKIljXG+8OczI4Bxh?=
 =?us-ascii?Q?4Xbm+X3boVbudL5PUReGJltn6/N2WerwaM4lcvIkPQUGt5ron/e2cgOLztB9?=
 =?us-ascii?Q?a0LzwK/cGwc2fwRD1H92H8xTkQjYn6P/Y6qF5DXhChYeOHyyqjKx6upjH0q1?=
 =?us-ascii?Q?vGvULmHt0OBhDE37JBZWO+HVTFE9Ly6/Uwuwyf32SCGMc9qV09sLDnEvnYrT?=
 =?us-ascii?Q?1lInEgoo36/ZJDuL0Kaetvi86TVjuPLnUkpFvZpcaVFHIKYfFm4qzHgvobDP?=
 =?us-ascii?Q?K/Zf7ojLrf6+KJTrKUQU7yUge7k3h783v+Hom7/zP8HzJCiW/k7DDyeX9MhU?=
 =?us-ascii?Q?YW4e5wDtZzYp+7c5+B6oMUcAUkl/5/9YjFWUq1IsZp+iqNy/ga/zvagHStkI?=
 =?us-ascii?Q?5Hy/dQBfeyXAdzK9Ax2pB5Xn/azpi7CFjKavVKDIOZtv6Bqfh15kaWAaRnIH?=
 =?us-ascii?Q?q05MzdjXea2oGrTcayQNUuts5BBDqNhZp3F+n1Yf1qs/lXHWSZtk8TH4Lt5t?=
 =?us-ascii?Q?XhRdD0ZntHbNqorWtVRQXv6w5k3znMJVT3V5DhVkWEo4PYaRJjYZnkS9cEAq?=
 =?us-ascii?Q?8d1MiE2YgyW32LPNG4Dk1C4TIt6wZTEgii9OeT+iYuNY9TJfYStP17D6qdSr?=
 =?us-ascii?Q?/E5bzKAgt7+LzuhAnu/XWRpj5JGWmLI6Na7wZ1809YjzDxnL3jg8Mde7C4LF?=
 =?us-ascii?Q?lqnq+3jdK1y3dQUDwieHYvWnbNCcjXP0X1hDw6VUgmwWE1sIOgPuENzoL7d5?=
 =?us-ascii?Q?u0YYqxr2nAjddkJr0fl8ArH7g9CfnfFv9JvMmLjbUR7xFmRh8ixyhWtO27mi?=
 =?us-ascii?Q?4S8dyk15XIQGN94if/sIA8CDakxkkwq+VH06nE5RqpWwYpsyASFQ+wxlDABo?=
 =?us-ascii?Q?42/D5zrm7+a00XaTkqRAUXADp0jS8U2RcIZpzCzNabzMOD9bVVML0EAWB4XH?=
 =?us-ascii?Q?hSCp8ogDRuC48/YS9LILKTyIZOueEtnOoc/oP2RIGpOwyIKL5MpJmUy6BsuV?=
 =?us-ascii?Q?4RqiBn8blDUQH67f5Nrdq2Zkx7fQY8XL2Wu6t6LrCj/ERDA+fmM59hxuRrUC?=
 =?us-ascii?Q?vMhwSxLxjWrHTPHAlS51+QPmdCBxXt3CQzwzmQ1j+HII6fTGmWAiph7GAtiJ?=
 =?us-ascii?Q?BZVjVseAfijgJnUVgU6dSaAgQSMX/KudoaOOVFc7Toxj8fUPlqfT7BzMfmaV?=
 =?us-ascii?Q?rRb0ZqxnVGmW++g+od2j8T7seTORvRhmReQh1bZujWHvME9+QdOfasXf9/3M?=
 =?us-ascii?Q?vJk5wwRd6b2I0BHUbMMZKChruErVpuTFxYMKmlo8CS7RX85znBseH2nBEhf8?=
 =?us-ascii?Q?V3X9+v3wgYOmk0X/iADP9MZ3/tLwxN5S5sM+fPhkbKH1TljuQedPt/eOEQW7?=
 =?us-ascii?Q?v2kH4YkOQQ8UibswfrZu7R1eRQTIHl1n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E29+5EpHECPV9rvRtwK9HyO8IwohZmGWzuNP06C33/bVgvvRrTKLk/iXPAJ0?=
 =?us-ascii?Q?JXU99zpl9V6TZ/ZlkiT0ZoXApVZOmlG/bGzJaDJ+wnobGuQP78VigNkBtwEr?=
 =?us-ascii?Q?02Jipje7fse6O+mdU1VVI6V/UfBKiQ5/L1R7E+PZhzMtq8114mxVOuSiqGHn?=
 =?us-ascii?Q?yClZ7U2th6g4rEAQuNMHgW34aSUK7/iPfqk8H+J9EBaWri3VLuWE7/OpgUY1?=
 =?us-ascii?Q?9mkaxrUdHppstD482onHhZvmXY+LKXuqYdopbQC/Ho+aNt3hG0fG35zqWLQZ?=
 =?us-ascii?Q?BL1a0du+m7GZq+hPHJ9spj+EOCptH0Rn7J8ubqblsWSVyt5sTahIoYpbrIgq?=
 =?us-ascii?Q?ul6BWHbMCx0drW/JqBri1SKJlIj+7nBx1rhDnb/Cp4DnhD01nV43m7CtsDmr?=
 =?us-ascii?Q?SDhnoHuLvWpoI4TAw8Fzx/FYWgdRcBIJ9JJbcPcGguEI0ULpIDC0qEJWu5gX?=
 =?us-ascii?Q?FdTBTmV8RFwyYcCEvEEdFZMVVWm4HirXyeX8nc1DQreBgPv8gOjoJ63Hly3H?=
 =?us-ascii?Q?eyHp5d3898C8DPdeaAEfMipIJ28sc4OiryZVa4otgkNgYkFRjSzg5iIbtDil?=
 =?us-ascii?Q?88EOIXmv+ZfE5fTfS5WidsJXn6vZMkxEhiSsChrD1i9dDnsnuqDJr4vLJF7X?=
 =?us-ascii?Q?s4g/ptlmRwQTDr542rSczb/WLbH8qSQQu3vQLn9+szHRC3LA6mm7++YZGlJ0?=
 =?us-ascii?Q?nZxt9+cFw1f3ZILTY4GZADtR/26/CTdagrJ0PiEfsNvWPoCL7JRgsrgBXaYn?=
 =?us-ascii?Q?dMQlVqsEmOP6yQeXhdQJQzkLzji9LmdMkvqoh70NQHkbbd0Vprnu+fhL1gKR?=
 =?us-ascii?Q?/duy9iMRpyDxFmNd9C+j/d3Opufw7S6MvWoDypTj6aMgfIxzoicwSmZwXvFm?=
 =?us-ascii?Q?nXOfkcMGpqEjkj0Trk6jdrqeQbbC3TL8OMBJQrWm1W63s4qlbGqmdAt4h2Vj?=
 =?us-ascii?Q?5okBTAtDVNoQ4lHTNeVX1mysL5PQnnZqmh7wlHhPVT7apfGzbAntl/VHJ/fn?=
 =?us-ascii?Q?NoeyHyW0cmLHlJwKQ2Pja9hoqlkDbzjqlLx6C195IapLkFLGOLDu3OibjYyJ?=
 =?us-ascii?Q?htTzQ/knAy8dkYRKaKww0+re0SnHHp2ddiIr2im1Lxw4Jx9ljcCnBEdq5/i2?=
 =?us-ascii?Q?1xz099AI0U3lbttuoOq8r2090z70YIxEswjeUSIDWaeBeHJ9fC41dk30KufK?=
 =?us-ascii?Q?21AWV6lO6GbupY4JGPVg6l4boW8z3PN5hD4skW7MVDrzwjHUb/ep1uko/hm5?=
 =?us-ascii?Q?aebpIWmShsZ/zpegRIjXWSLz8DcRQztFOWE5eMrDCWedEYzUALY9zwbkW+Om?=
 =?us-ascii?Q?b37RZN3yqnUCT5HdVhKIntsCewu4WDHPxRr9A/nqp7xGOnWlkpeA5L3a8uNN?=
 =?us-ascii?Q?jBjFHCeOB8ctrYEsWoILzeojID/7bk+D+DGT6W2BkRMBjtJn4nEHtRRUXCZ4?=
 =?us-ascii?Q?Axi/aYvgrnjAyrO/DBZeLdM+Rn0qT6SpFk5++v6T+Rcq0fe3JQFgvIF/ukpF?=
 =?us-ascii?Q?xc+5czFuIpohGhwk9mRblPODNJJtr+Zup0h6kpZShZGVXJF3z2g3qVrVfJst?=
 =?us-ascii?Q?qeNcCKHuvi6MfCUZ7fU0IbvwozMk9cR992Xp8nP6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c7a5b1-1922-4dce-12f5-08de171f278e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:12:51.0326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXQ1cQ2IGXAt13qVRcrYLT/MWn/K4aEpjseD1ZMet5hioUr7llp1XenBY81VbDp2NGgIdqclqAP38zZA3DwWjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735

Add a selftest to validate the correct behavior of the deadline server
for the ext_sched_class.

v3: - add a comment to explain the 4% threshold (Emil Tsalapatis)
v2: - replaced occurences of CFS in the test with EXT (Joel Fernandes)

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
 tools/testing/selftests/sched_ext/rt_stall.c  | 222 ++++++++++++++++++
 3 files changed, 246 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 5fe45f9c5f8fd..c9255d1499b6e 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -183,6 +183,7 @@ auto-test-targets :=			\
 	select_cpu_dispatch_bad_dsq	\
 	select_cpu_dispatch_dbl_dsp	\
 	select_cpu_vtime		\
+	rt_stall			\
 	test_example			\
 
 testcase-targets := $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-test-targets)))
diff --git a/tools/testing/selftests/sched_ext/rt_stall.bpf.c b/tools/testing/selftests/sched_ext/rt_stall.bpf.c
new file mode 100644
index 0000000000000..80086779dd1eb
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/rt_stall.bpf.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A scheduler that verified if RT tasks can stall SCHED_EXT tasks.
+ *
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+UEI_DEFINE(uei);
+
+void BPF_STRUCT_OPS(rt_stall_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops rt_stall_ops = {
+	.exit			= (void *)rt_stall_exit,
+	.name			= "rt_stall",
+};
diff --git a/tools/testing/selftests/sched_ext/rt_stall.c b/tools/testing/selftests/sched_ext/rt_stall.c
new file mode 100644
index 0000000000000..d0ffa0e72b37b
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/rt_stall.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 NVIDIA Corporation.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sched.h>
+#include <sys/prctl.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <linux/sched.h>
+#include <signal.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include "rt_stall.bpf.skel.h"
+#include "scx_test.h"
+#include "../kselftest.h"
+
+#define CORE_ID		0	/* CPU to pin tasks to */
+#define RUN_TIME        5	/* How long to run the test in seconds */
+
+/* Simple busy-wait function for test tasks */
+static void process_func(void)
+{
+	while (1) {
+		/* Busy wait */
+		for (volatile unsigned long i = 0; i < 10000000UL; i++)
+			;
+	}
+}
+
+/* Set CPU affinity to a specific core */
+static void set_affinity(int cpu)
+{
+	cpu_set_t mask;
+
+	CPU_ZERO(&mask);
+	CPU_SET(cpu, &mask);
+	if (sched_setaffinity(0, sizeof(mask), &mask) != 0) {
+		perror("sched_setaffinity");
+		exit(EXIT_FAILURE);
+	}
+}
+
+/* Set task scheduling policy and priority */
+static void set_sched(int policy, int priority)
+{
+	struct sched_param param;
+
+	param.sched_priority = priority;
+	if (sched_setscheduler(0, policy, &param) != 0) {
+		perror("sched_setscheduler");
+		exit(EXIT_FAILURE);
+	}
+}
+
+/* Get process runtime from /proc/<pid>/stat */
+static float get_process_runtime(int pid)
+{
+	char path[256];
+	FILE *file;
+	long utime, stime;
+	int fields;
+
+	snprintf(path, sizeof(path), "/proc/%d/stat", pid);
+	file = fopen(path, "r");
+	if (file == NULL) {
+		perror("Failed to open stat file");
+		return -1;
+	}
+
+	/* Skip the first 13 fields and read the 14th and 15th */
+	fields = fscanf(file,
+			"%*d %*s %*c %*d %*d %*d %*d %*d %*u %*u %*u %*u %*u %lu %lu",
+			&utime, &stime);
+	fclose(file);
+
+	if (fields != 2) {
+		fprintf(stderr, "Failed to read stat file\n");
+		return -1;
+	}
+
+	/* Calculate the total time spent in the process */
+	long total_time = utime + stime;
+	long ticks_per_second = sysconf(_SC_CLK_TCK);
+	float runtime_seconds = total_time * 1.0 / ticks_per_second;
+
+	return runtime_seconds;
+}
+
+static enum scx_test_status setup(void **ctx)
+{
+	struct rt_stall *skel;
+
+	skel = rt_stall__open();
+	SCX_FAIL_IF(!skel, "Failed to open");
+	SCX_ENUM_INIT(skel);
+	SCX_FAIL_IF(rt_stall__load(skel), "Failed to load skel");
+
+	*ctx = skel;
+
+	return SCX_TEST_PASS;
+}
+
+static bool sched_stress_test(void)
+{
+	/*
+	 * We're expecting the EXT task to get around 5% of CPU time when
+	 * competing with the RT task (small 1% fluctuations are expected).
+	 *
+	 * However, the EXT task should get at least 4% of the CPU to prove
+	 * that the EXT deadline server is working correctly. A percentage
+	 * less than 4% indicates a bug where RT tasks can potentially
+	 * stall SCHED_EXT tasks, causing the test to fail.
+	 */
+	const float expected_min_ratio = 0.04; /* 4% */
+
+	float ext_runtime, rt_runtime, actual_ratio;
+	int ext_pid, rt_pid;
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	/* Create and set up a EXT task */
+	ext_pid = fork();
+	if (ext_pid == 0) {
+		set_affinity(CORE_ID);
+		process_func();
+		exit(0);
+	} else if (ext_pid < 0) {
+		perror("fork for EXT task");
+		ksft_exit_fail();
+	}
+
+	/* Create an RT task */
+	rt_pid = fork();
+	if (rt_pid == 0) {
+		set_affinity(CORE_ID);
+		set_sched(SCHED_FIFO, 50);
+		process_func();
+		exit(0);
+	} else if (rt_pid < 0) {
+		perror("fork for RT task");
+		ksft_exit_fail();
+	}
+
+	/* Let the processes run for the specified time */
+	sleep(RUN_TIME);
+
+	/* Get runtime for the EXT task */
+	ext_runtime = get_process_runtime(ext_pid);
+	if (ext_runtime == -1)
+		ksft_exit_fail_msg("Error getting runtime for EXT task (PID %d)\n", ext_pid);
+	ksft_print_msg("Runtime of EXT task (PID %d) is %f seconds\n",
+		       ext_pid, ext_runtime);
+
+	/* Get runtime for the RT task */
+	rt_runtime = get_process_runtime(rt_pid);
+	if (rt_runtime == -1)
+		ksft_exit_fail_msg("Error getting runtime for RT task (PID %d)\n", rt_pid);
+	ksft_print_msg("Runtime of RT task (PID %d) is %f seconds\n", rt_pid, rt_runtime);
+
+	/* Kill the processes */
+	kill(ext_pid, SIGKILL);
+	kill(rt_pid, SIGKILL);
+	waitpid(ext_pid, NULL, 0);
+	waitpid(rt_pid, NULL, 0);
+
+	/* Verify that the scx task got enough runtime */
+	actual_ratio = ext_runtime / (ext_runtime + rt_runtime);
+	ksft_print_msg("EXT task got %.2f%% of total runtime\n", actual_ratio * 100);
+
+	if (actual_ratio >= expected_min_ratio) {
+		ksft_test_result_pass("PASS: EXT task got more than %.2f%% of runtime\n",
+				      expected_min_ratio * 100);
+		return true;
+	}
+	ksft_test_result_fail("FAIL: EXT task got less than %.2f%% of runtime\n",
+			      expected_min_ratio * 100);
+	return false;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct rt_stall *skel = ctx;
+	struct bpf_link *link;
+	bool res;
+
+	link = bpf_map__attach_struct_ops(skel->maps.rt_stall_ops);
+	SCX_FAIL_IF(!link, "Failed to attach scheduler");
+
+	res = sched_stress_test();
+
+	SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
+	bpf_link__destroy(link);
+
+	if (!res)
+		ksft_exit_fail();
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *ctx)
+{
+	struct rt_stall *skel = ctx;
+
+	rt_stall__destroy(skel);
+}
+
+struct scx_test rt_stall = {
+	.name = "rt_stall",
+	.description = "Verify that RT tasks cannot stall SCHED_EXT tasks",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&rt_stall)
-- 
2.51.2


