Return-Path: <linux-kselftest+bounces-47665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5E6CC8647
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 16:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF8D130575B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 15:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3FB31A570;
	Wed, 17 Dec 2025 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q5sXNUBh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD96730DEDD;
	Wed, 17 Dec 2025 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984515; cv=fail; b=hRKtzyaAVftHOCZGvP4qU9d3KQNmwGYytsAs/PPS38zZK9l73t9NMEhprEzQn3LWGruTrn2JOUPZ7Qe15Vmm5De8iF1LMMpr7ZaOcOF0IUvfo/QfetL+HTrF3ZNWwIx0IA/wpTx4sQNdWWFdlDeCAa/kyuJMUXde0AiFZjtY3j8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984515; c=relaxed/simple;
	bh=PiE42TOYg+zOarxj39tTWCfmA2K8E0nAkpQ3REJhDFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=avmFOIa/YheiIlTJwmwtazf6ZoGRXyj7/4/HngIjAI/aoIpWzcj0FFyiIpxexyo+BA/VS1VMsGo8wcFVm2ebohpuKaqUNEcd4nITuMTJcgL6h8C5xuOpDGxnPw9UvpmJKIt31fkcarpf9ZSv9yVsDi+qRTEALYN6vkKXt49vNuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q5sXNUBh; arc=fail smtp.client-ip=52.101.52.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVEupWyCOuOf/fwD0+/bVSMshKrGsKwf04SouZQ4beA+TLULYMtwkxQOeInOKTdPpm/YjBpopMXnZyJKhr144lN3TnP5sFM/OgV1+T67pRzMQ5b+pPa18xfqzmVmvMazPaoqFu6d81Y1m3koUGmqG5Uu/3fnTmhfJWY/3EJSS9Vr2jZz7vBahUsbVXZPz484RGVLsiC1FhMjkgT+VwKDq64HsegjRb54rJd3RntWsROXjTvAUJEDyYtHoQRRmAVnzS4wtY9anANkdajrA9emTxABe8O7qHFswz7ezczrRPiR/HRGoXs7Z2hiF8G/+U+a72oQ6pPJZazIuvMBS6kaiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTQ15wdg5b9mffX1GSkaEm6FG85PtyPOechoyJI03t4=;
 b=JgcPk1rr3fK7u50csIU8HrEkem5qx8w7XnFOncnRdDdLF09OqpXO0dvq9/nEI8rF6Av/ndzbQi5lwD4eiK52Kwfixh8XmmSkd31NPoA83jD6tuKbe4G/iqCu47gH+2Jj1LAWx7nPLrGobWbCM98vfJgo2UKa8K3cc2vguTRlFP3hUQHZNs4X/lh1Y9didcnY14ilUXBWAdhrqdL1YvIg8WHAmkgEwYhf/qJc+OTBth/roXoSzAPnLw9mSyIAx/jqcUkDos4IqMpcNAkxY6gD0fzH+zeuVBYZitKfK317qhUiD2sDJ+wL/V9yiha730gr8TQg818Kon2yoArV61GsHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTQ15wdg5b9mffX1GSkaEm6FG85PtyPOechoyJI03t4=;
 b=q5sXNUBhwGFwLy1WwbKzwB88oZ9IOfOWeHXRRGQ1F6FFRa3FNmPt0cwg7wSPvveWloGlE531rHmf5azGrVg8AnjgtbnUfpO/vQHS6WqWRVpyfrjY1/SPOw3CGLRCfM28LR3OAikCA0g7Xw71hsC4lbXQpxbNaFHI9gtOb1P61K5MqKjMrpP5LrVbgY2ex9CPOBEbWVMgrGE0CyiMDSfJlOjGw3NB19TLWkBCM49O8/FdZLp5teXgxXqN8S9FU8ysK6BaGPJXThYRlmhKyJ+U4P+FDOJtdkTy4zTe1vrCSeed+PiIa+AqOiQPTr7InR0OsV7kj1g8o+oZSJ6cmfRXGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 09:40:05 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 09:40:05 +0000
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
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] selftests/sched_ext: Add test for sched_ext dl_server
Date: Wed, 17 Dec 2025 10:35:44 +0100
Message-ID: <20251217093923.1556187-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217093923.1556187-1-arighi@nvidia.com>
References: <20251217093923.1556187-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::7) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: 3826f95f-5da4-4dcd-e957-08de3d50428f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RLmhD2S9hhWfoD+yqJastV5NxJO3+AvSz5O/t+7HhMQghe/CgDPUB1cpeDSg?=
 =?us-ascii?Q?hLvTbusZ+EUZGiJvg4GMjNxn+r8UIkqn01rY5KwMpB9T1f836ZdlFkeKHT8p?=
 =?us-ascii?Q?61mnQXOXaPRbmRB+soAxIBtb+FwAlaAV9ACFV+lo1jkYU6GRaLXuux/E0Mu+?=
 =?us-ascii?Q?jeL4SWfNCzjleSzNDX6PhirYqG8kcfSzN6fxa9qdQ8ZZyWUx2jfkCn36h98f?=
 =?us-ascii?Q?e/8cLGG01g5E2J3IK/VpOEfDd5+q6pKfu2kU829fYNalAVL/za7PpXPSrd7G?=
 =?us-ascii?Q?H0sIO70vjVCzxicZ+QxBhHMQdeuXAOFJ6uXUzCwpemFNVVOhPHC95AqPN3zO?=
 =?us-ascii?Q?nL+MNvPh3Lx5TyjM+81i7I7bWbHHonFKE3eBxepi/MLqmojyv0Ckh+lbiFpn?=
 =?us-ascii?Q?6BtcbzXJMZONa0Pu4XScLEqtukRbpiRcIAsx14/z9Gmz1Ne3XHQ7mEz6e9v1?=
 =?us-ascii?Q?o5yArycRot/G+NcNOTWmtJW40XcR9mZq3Opm4DCotMq50Wgr6NBsEE+ci/TL?=
 =?us-ascii?Q?UKhrsO4h6fA1NjdsQvuv8aX15ehL+MsI18sVvaJmvX5yKSDHVZbuYkrZtulJ?=
 =?us-ascii?Q?LDYJJAFo1iTYU46wGH/REhjHmcqq/l4wDaIAKh9+mWm1Z7u9f/144v7SOhom?=
 =?us-ascii?Q?RLoyF2uGVdKIcFdHSUZ5SnIBfi2/dU73hQiXxbwp6+MsSwg2V4yLFVkpFPLS?=
 =?us-ascii?Q?pyAJocSbK5zjPFoy7zw/Zmdhr6tO4zhRFRVbIMdOkidI1PZdCzk5IsSJQSi/?=
 =?us-ascii?Q?JvZQxcCCh4B5Dtb5j0OZCZzHDFG35WEAqrgr4drvSVu0z8hW+mDLvyMq4a8p?=
 =?us-ascii?Q?DpOsF7LRRgRns3zGMROO7shN+n75pK9Rn/qQqNEq7u1hqmS1TiYbEjGImypG?=
 =?us-ascii?Q?0ZYB7KEDBcJIkXKuvITzMyMi9dI21jEK3kMdEXRQg4NabkHMfoXP9A+nPEk0?=
 =?us-ascii?Q?CcD9jJUagBTBovr57qRKzyxj4pQc5Efzpf28ofuF5O8dca7S0uPwNRUnpSGp?=
 =?us-ascii?Q?Xk9x1eOQwISvdHfaKr0oq/MZvg96Trdha14fjxEUk/eoXalhBJa2Ur1C27/Q?=
 =?us-ascii?Q?Zryl7hOyorn9pttTuCjgbR7emAnVl7pMRTraJa/P2C050drwNIPplkzuvXYp?=
 =?us-ascii?Q?ltiG1VVDyQFY8Gp310SQf7OtcwMzk/wxPZ/LXn8nJx0DuzNN/BGbEP+os3D/?=
 =?us-ascii?Q?+jk19c2ITq7s7YAlX/uzwtyPGXcpBRWXwcybHD+X16MGOm7FACNVL6O78N2/?=
 =?us-ascii?Q?g6+bPrIW9qpYn0T1dJ3lyznmEiXl3MIgnPC7lw8k03b7J0QxE8rIBQiarlyt?=
 =?us-ascii?Q?OIC/mfCUjx6oUTfLrRKwZPeZ3o/Zoxm4hDSz+VVy/Fk32czZrM98CH7WO6UZ?=
 =?us-ascii?Q?wFVvx/zo+T6Ovih76EqSCxEzoLJ3CY/iZoT4bITJ1k0sryjnffFqolGJBRSy?=
 =?us-ascii?Q?++3vK9c/2MJktc0IsoWUjNXWF64mOaa4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ioTWcQ87tGDLgYhY82wxTdBWaFEQrSNeTlqx+gb8ASY4ZEirqxcp+vCQIf51?=
 =?us-ascii?Q?jBD7dwk3HVVyNU4heyl2hv+++W7mPRxOBRA5nVUlNVcUICB8HV0Ith7sSD+o?=
 =?us-ascii?Q?2Tx0k6yyY5fD02y8b+15RU+AMtbmlnzow4/APatAEuaPHpsGyS3/ayBocgCv?=
 =?us-ascii?Q?l89cybaDNxsXc3+N9uhNjrNI53//2Omg74rZEREiprWSANw4jGaq0KP0DoKH?=
 =?us-ascii?Q?FdLfJm3FuxOp1rOe75N9RTWxWfvKFbEYNSddMFBrAmn5c4RE7Jk4tLLzLsDa?=
 =?us-ascii?Q?ouONqdvb4InWstSBOCHyofSyKjPg4RcN8sVhj3FqMSWP8xf5R7wjIJvU3pby?=
 =?us-ascii?Q?JKK5zQXINI8cGgc+klmEI0U0Ww0De5HzHghxtDgeUWgYZXfyNPkkI56w5yyy?=
 =?us-ascii?Q?pySMvYs7MnmsayIXoOwUQkDCnZhoJTYrTUjXgDFTMR4vr1Mte66uiiymhDo1?=
 =?us-ascii?Q?cyHCfz4e+QF+qICgAC/4S4iBZQYjlYEmdBjpMG65EPddousga8n/Q7Jn4pLH?=
 =?us-ascii?Q?2eYTvqIbwVbvN83KSjmlDd9u7bY3uRBjTN4Z/FG8vGAloqqRieX+wtbj8GlK?=
 =?us-ascii?Q?ruKBZU4DcIl1dEkW3a1CjuOHSvlDB/UWWUsO+WtzkghWdLmyBzSStvCGfrXc?=
 =?us-ascii?Q?XD4yphd+/v/sQWfLBqJEyEGKGG9sicqoLT24vjzu+GDwnge9r/Essknn5Ytn?=
 =?us-ascii?Q?IpNisQIDk9jidbyphWh1IKlVGESV8u+jPe2cFBAcRMT0BqN/f3KrJkEiQcdS?=
 =?us-ascii?Q?Qyv5MoF2SfLliDvnJ3ZrP4svYOVw1Tr3fQgbIEWQkCkAPPKCA46fDv6iEjJn?=
 =?us-ascii?Q?j7xQiNJQ7+SAsKIilPGPAeeUFMnOiNpkPOD6fuP5yUHG3QDTVxm7BAZo7Xp3?=
 =?us-ascii?Q?kFQxwMTsq2HxaVeo0NFpCqwvxVmoq0a8odDaprUCwMa/WhFW/MFiqNVTDSAF?=
 =?us-ascii?Q?6bLPCfM347VRrly6kgSNp2nvOVSfIvFfnkoSSfLXxw6lMigHO8Rvlv7xV/cw?=
 =?us-ascii?Q?EXi+FjeOtw9kqPakvHQNm+Oir253bOwgy1kXTeWDJSa7xDdZFyC7qRZcnqHP?=
 =?us-ascii?Q?ox4/osTqUp+gRIrfpZNL4XAIjCDcZsysUbUKryBhaRrmEC2p+mu2XivEu7PP?=
 =?us-ascii?Q?dWTxLixsHkHrjqIfvBaCJW8h2Pb6ayy2K73oN3B4BX6aQnN3LMBLo0Ie8wS3?=
 =?us-ascii?Q?B44SQCM9fgvNg67bljRv6Z6+UVC/x/+OU1wBDICoJv2iyRyo/b0Z5QxQtEVs?=
 =?us-ascii?Q?mPDLuuaKlsbzBBM6k/7eO0yxY5ZmLJLesSRkGTeEJL8C+e1Lf3oE83iwIzen?=
 =?us-ascii?Q?OEb7bi+9SlEr1GOzBI4+nM9oM9qVIbbYIGzkGFEkxXEsPvoNHktqIaE+kWBe?=
 =?us-ascii?Q?gl+PfVn5WPEwQPPVmtacYlpM9XzVlpMQZLmQEBzPIQ5raDiWoKC2Er/Eej+j?=
 =?us-ascii?Q?a3N0n96fkDSPyB5MX7NiQgwjy2aeNJFmJjT02wrkTvAK2UqeeGDbVzPU3Qq3?=
 =?us-ascii?Q?2CCYIZNRm/onvDF2CM/PyD+C8+rY8ofpANOWf+ydUGRzInBreVWM42bdjQej?=
 =?us-ascii?Q?rKzZDHTflHRzLzJ1ZouJZTlj+eP+iJjt1zmPmTBU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3826f95f-5da4-4dcd-e957-08de3d50428f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 09:40:05.7972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2CeujBjLpRq1cr6vsiDphSgD6gVzjciOWzsUnbzCffOH923sp2/u2W4hAsq7DtFz5n/ka6D7WwGL2elcH1N7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6413

Add a selftest to validate the correct behavior of the deadline server
for the ext_sched_class.

v4: - cover full cycle: fair stop, ext start, ext stop, fair start
      (Christian Loehle)
v3: - add a comment to explain the 4% threshold (Emil Tsalapatis)
v2: - replaced occurences of CFS in the test with EXT (Joel Fernandes)

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
 tools/testing/selftests/sched_ext/rt_stall.c  | 240 ++++++++++++++++++
 3 files changed, 264 insertions(+)
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
index 0000000000000..015200f80f6e2
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/rt_stall.c
@@ -0,0 +1,240 @@
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
+static bool sched_stress_test(bool is_ext)
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
+	const char *class_str = is_ext ? "EXT" : "FAIR";
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
+		perror("fork task");
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
+		ksft_exit_fail_msg("Error getting runtime for %s task (PID %d)\n",
+				   class_str, ext_pid);
+	ksft_print_msg("Runtime of %s task (PID %d) is %f seconds\n",
+		       class_str, ext_pid, ext_runtime);
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
+	ksft_print_msg("%s task got %.2f%% of total runtime\n",
+		       class_str, actual_ratio * 100);
+
+	if (actual_ratio >= expected_min_ratio) {
+		ksft_test_result_pass("PASS: %s task got more than %.2f%% of runtime\n",
+				      class_str, expected_min_ratio * 100);
+		return true;
+	}
+	ksft_test_result_fail("FAIL: %s task got less than %.2f%% of runtime\n",
+			      class_str, expected_min_ratio * 100);
+	return false;
+}
+
+static enum scx_test_status run(void *ctx)
+{
+	struct rt_stall *skel = ctx;
+	struct bpf_link *link = NULL;
+	bool res;
+	int i;
+
+	/*
+	 * Test if the dl_server is working both with and without the
+	 * sched_ext scheduler attached.
+	 *
+	 * This ensures all the scenarios are covered:
+	 *   - fair_server stop -> ext_server start
+	 *   - ext_server stop -> fair_server stop
+	 */
+	for (i = 0; i < 4; i++) {
+		bool is_ext = i % 2;
+
+		if (is_ext) {
+			memset(&skel->data->uei, 0, sizeof(skel->data->uei));
+			link = bpf_map__attach_struct_ops(skel->maps.rt_stall_ops);
+			SCX_FAIL_IF(!link, "Failed to attach scheduler");
+		}
+		res = sched_stress_test(is_ext);
+		if (is_ext) {
+			SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
+			bpf_link__destroy(link);
+		}
+
+		if (!res)
+			ksft_exit_fail();
+	}
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
2.52.0


