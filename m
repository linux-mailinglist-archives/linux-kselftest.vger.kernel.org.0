Return-Path: <linux-kselftest+bounces-20441-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892109AC20C
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 10:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45797284A89
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 08:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DB415B0E2;
	Wed, 23 Oct 2024 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y/HT0PBc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4176158845;
	Wed, 23 Oct 2024 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673115; cv=none; b=jJcDuUOZ1YXvHZThh3UfWriIF3akOUViXLJTwXrdEg+7OxGXqJYchLVQqFmL6veqjTNGBPIJhGvB3WswLPERGSuK7h3Y0LJ8Vpv/0K1M3wgBSZLzg3FX+H7P23zDcuOGb0z7LCOTVlTMjjTnoUlgvn8uGv4tmGF/VgvbptJ3oYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673115; c=relaxed/simple;
	bh=ZBWAtf6bkmlOqc2xLU8f1mNrhtoSRukUxEanB6RyJVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ugDXXAoiUQkjVr/+KGxjV8gIvtipFWhyskcu6GKzpzh/0mT4BW7hLw8NKiM5s90+NaZB9mGepiDcF63YEDL2jJpwwHxJbp7t+ZdDeVLcGKH5utcUt2bGZ5CceKkM1jAQujNE0xbzNBjzqftPCl0PCITvU0Y9sX0knYoIN3dOybE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y/HT0PBc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N0NFkP025960;
	Wed, 23 Oct 2024 08:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=AY2eFpVXOhK6re89hX0ozCb+7jTEgDyoEZXwvWllM
	4I=; b=Y/HT0PBceaIcQ4B5O0i1FTYRNbHECB0Yu9wq4dVN1ITwU5SsDThiA0ZIi
	m5wccA7qROfdvMts2Uli8oNzrv2tMJm/VTHvqIQtMdx28iOPysEL1DkBkkiLvs2/
	UvfsA36Zzter4wSx1UPA0kmpUzfNlUSnZQof0RObdHgSd98m2xZhfHOc64X/yLxy
	N7kCK0EjWVsB8gWGm4FaYYRySH0H0rQwTCtmNkBDm8fPvHqUbAkE0jOTWPM34g/X
	N5hFYToKucOIJGAchEPIQhNkbtFofXA4zXvCol85Uci5FuO+mPDBfrr6ARzxvuKM
	1/5Qw2GrgqNaFaL1a11JLIyN1tGPw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emaet2ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 08:45:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49N7RcIj014565;
	Wed, 23 Oct 2024 08:45:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emk7t1dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 08:45:07 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49N8j5JA32899392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 08:45:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C219F2004D;
	Wed, 23 Oct 2024 08:45:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9655520043;
	Wed, 23 Oct 2024 08:45:04 +0000 (GMT)
Received: from vishalc-ibm.ibmuc.com (unknown [9.124.211.29])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Oct 2024 08:45:04 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: linux-kselftest@vger.kernel.org
Cc: tj@kernel.org, linux-kernel@vger.kernel.org,
        Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH] sched_ext: Fix function pointer type mismatches in BPF selftests
Date: Wed, 23 Oct 2024 14:15:00 +0530
Message-ID: <20241023084500.291484-1-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XH5UQOVlePnPF5Mg_zZAqHo_g8m6p9hE
X-Proofpoint-ORIG-GUID: XH5UQOVlePnPF5Mg_zZAqHo_g8m6p9hE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=902
 priorityscore=1501 suspectscore=0 clxscore=1011 impostorscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230052

Fix incompatible function pointer type warnings in sched_ext BPF selftests by
explicitly casting the function pointers when initializing struct_ops.
This addresses multiple -Wincompatible-function-pointer-types warnings from the
clang compiler where function signatures didn't match exactly.

The void * cast ensures the compiler accepts the function pointer
assignment despite minor type differences in the parameters.
---
 .../selftests/sched_ext/create_dsq.bpf.c      |  6 +-
 .../sched_ext/ddsp_bogus_dsq_fail.bpf.c       |  4 +-
 .../sched_ext/ddsp_vtimelocal_fail.bpf.c      |  4 +-
 .../selftests/sched_ext/dsp_local_on.bpf.c    |  8 +--
 .../sched_ext/enq_select_cpu_fails.bpf.c      |  4 +-
 tools/testing/selftests/sched_ext/exit.bpf.c  | 14 ++---
 .../testing/selftests/sched_ext/hotplug.bpf.c |  8 +--
 .../sched_ext/init_enable_count.bpf.c         |  8 +--
 .../testing/selftests/sched_ext/maximal.bpf.c | 58 +++++++++----------
 .../selftests/sched_ext/maybe_null.bpf.c      |  6 +-
 .../sched_ext/maybe_null_fail_dsp.bpf.c       |  4 +-
 .../sched_ext/maybe_null_fail_yld.bpf.c       |  4 +-
 .../selftests/sched_ext/prog_run.bpf.c        |  2 +-
 .../selftests/sched_ext/select_cpu_dfl.bpf.c  |  2 +-
 .../sched_ext/select_cpu_dfl_nodispatch.bpf.c |  6 +-
 .../sched_ext/select_cpu_dispatch.bpf.c       |  2 +-
 .../select_cpu_dispatch_bad_dsq.bpf.c         |  4 +-
 .../select_cpu_dispatch_dbl_dsp.bpf.c         |  4 +-
 .../sched_ext/select_cpu_vtime.bpf.c          | 12 ++--
 19 files changed, 80 insertions(+), 80 deletions(-)

diff --git a/tools/testing/selftests/sched_ext/create_dsq.bpf.c b/tools/testing/selftests/sched_ext/create_dsq.bpf.c
index 23f79ed343f02..2cfc4ffd60e28 100644
--- a/tools/testing/selftests/sched_ext/create_dsq.bpf.c
+++ b/tools/testing/selftests/sched_ext/create_dsq.bpf.c
@@ -51,8 +51,8 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(create_dsq_init)
 
 SEC(".struct_ops.link")
 struct sched_ext_ops create_dsq_ops = {
-	.init_task		= create_dsq_init_task,
-	.exit_task		= create_dsq_exit_task,
-	.init			= create_dsq_init,
+	.init_task		= (void *) create_dsq_init_task,
+	.exit_task		= (void *) create_dsq_exit_task,
+	.init			= (void *) create_dsq_init,
 	.name			= "create_dsq",
 };
diff --git a/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c b/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c
index e97ad41d354ad..37d9bf6fb7458 100644
--- a/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c
+++ b/tools/testing/selftests/sched_ext/ddsp_bogus_dsq_fail.bpf.c
@@ -35,8 +35,8 @@ void BPF_STRUCT_OPS(ddsp_bogus_dsq_fail_exit, struct scx_exit_info *ei)
 
 SEC(".struct_ops.link")
 struct sched_ext_ops ddsp_bogus_dsq_fail_ops = {
-	.select_cpu		= ddsp_bogus_dsq_fail_select_cpu,
-	.exit			= ddsp_bogus_dsq_fail_exit,
+	.select_cpu		= (void *) ddsp_bogus_dsq_fail_select_cpu,
+	.exit			= (void *) ddsp_bogus_dsq_fail_exit,
 	.name			= "ddsp_bogus_dsq_fail",
 	.timeout_ms		= 1000U,
 };
diff --git a/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c b/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c
index dde7e7dafbfbc..dffc97d9cdf14 100644
--- a/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c
+++ b/tools/testing/selftests/sched_ext/ddsp_vtimelocal_fail.bpf.c
@@ -32,8 +32,8 @@ void BPF_STRUCT_OPS(ddsp_vtimelocal_fail_exit, struct scx_exit_info *ei)
 
 SEC(".struct_ops.link")
 struct sched_ext_ops ddsp_vtimelocal_fail_ops = {
-	.select_cpu		= ddsp_vtimelocal_fail_select_cpu,
-	.exit			= ddsp_vtimelocal_fail_exit,
+	.select_cpu		= (void *) ddsp_vtimelocal_fail_select_cpu,
+	.exit			= (void *) ddsp_vtimelocal_fail_exit,
 	.name			= "ddsp_vtimelocal_fail",
 	.timeout_ms		= 1000U,
 };
diff --git a/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c b/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
index efb4672decb41..6a7db1502c29e 100644
--- a/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
+++ b/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
@@ -56,10 +56,10 @@ void BPF_STRUCT_OPS(dsp_local_on_exit, struct scx_exit_info *ei)
 
 SEC(".struct_ops.link")
 struct sched_ext_ops dsp_local_on_ops = {
-	.select_cpu		= dsp_local_on_select_cpu,
-	.enqueue		= dsp_local_on_enqueue,
-	.dispatch		= dsp_local_on_dispatch,
-	.exit			= dsp_local_on_exit,
+	.select_cpu		= (void *) dsp_local_on_select_cpu,
+	.enqueue		= (void *) dsp_local_on_enqueue,
+	.dispatch		= (void *) dsp_local_on_dispatch,
+	.exit			= (void *) dsp_local_on_exit,
 	.name			= "dsp_local_on",
 	.timeout_ms		= 1000U,
 };
diff --git a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
index b3dfc1033cd6a..1efb50d61040a 100644
--- a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
+++ b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
@@ -36,8 +36,8 @@ void BPF_STRUCT_OPS(enq_select_cpu_fails_enqueue, struct task_struct *p,
 
 SEC(".struct_ops.link")
 struct sched_ext_ops enq_select_cpu_fails_ops = {
-	.select_cpu		= enq_select_cpu_fails_select_cpu,
-	.enqueue		= enq_select_cpu_fails_enqueue,
+	.select_cpu		= (void *) enq_select_cpu_fails_select_cpu,
+	.enqueue		= (void *) enq_select_cpu_fails_enqueue,
 	.name			= "enq_select_cpu_fails",
 	.timeout_ms		= 1000U,
 };
diff --git a/tools/testing/selftests/sched_ext/exit.bpf.c b/tools/testing/selftests/sched_ext/exit.bpf.c
index ae12ddaac921b..bf79ccd55f8f0 100644
--- a/tools/testing/selftests/sched_ext/exit.bpf.c
+++ b/tools/testing/selftests/sched_ext/exit.bpf.c
@@ -72,13 +72,13 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(exit_init)
 
 SEC(".struct_ops.link")
 struct sched_ext_ops exit_ops = {
-	.select_cpu		= exit_select_cpu,
-	.enqueue		= exit_enqueue,
-	.dispatch		= exit_dispatch,
-	.init_task		= exit_init_task,
-	.enable			= exit_enable,
-	.exit			= exit_exit,
-	.init			= exit_init,
+	.select_cpu		= (void *) exit_select_cpu,
+	.enqueue		= (void *) exit_enqueue,
+	.dispatch		= (void *) exit_dispatch,
+	.init_task		= (void *) exit_init_task,
+	.enable			= (void *) exit_enable,
+	.exit			= (void *) exit_exit,
+	.init			= (void *) exit_init,
 	.name			= "exit",
 	.timeout_ms		= 1000U,
 };
diff --git a/tools/testing/selftests/sched_ext/hotplug.bpf.c b/tools/testing/selftests/sched_ext/hotplug.bpf.c
index 8f2601db39f37..6c9f25c9bf53e 100644
--- a/tools/testing/selftests/sched_ext/hotplug.bpf.c
+++ b/tools/testing/selftests/sched_ext/hotplug.bpf.c
@@ -46,16 +46,16 @@ void BPF_STRUCT_OPS_SLEEPABLE(hotplug_cpu_offline, s32 cpu)
 
 SEC(".struct_ops.link")
 struct sched_ext_ops hotplug_cb_ops = {
-	.cpu_online		= hotplug_cpu_online,
-	.cpu_offline		= hotplug_cpu_offline,
-	.exit			= hotplug_exit,
+	.cpu_online		= (void *) hotplug_cpu_online,
+	.cpu_offline		= (void *) hotplug_cpu_offline,
+	.exit			= (void *) hotplug_exit,
 	.name			= "hotplug_cbs",
 	.timeout_ms		= 1000U,
 };
 
 SEC(".struct_ops.link")
 struct sched_ext_ops hotplug_nocb_ops = {
-	.exit			= hotplug_exit,
+	.exit			= (void *) hotplug_exit,
 	.name			= "hotplug_nocbs",
 	.timeout_ms		= 1000U,
 };
diff --git a/tools/testing/selftests/sched_ext/init_enable_count.bpf.c b/tools/testing/selftests/sched_ext/init_enable_count.bpf.c
index 47ea89a626c37..5eb9edb1837dc 100644
--- a/tools/testing/selftests/sched_ext/init_enable_count.bpf.c
+++ b/tools/testing/selftests/sched_ext/init_enable_count.bpf.c
@@ -45,9 +45,9 @@ void BPF_STRUCT_OPS(cnt_disable, struct task_struct *p)
 
 SEC(".struct_ops.link")
 struct sched_ext_ops init_enable_count_ops = {
-	.init_task	= cnt_init_task,
-	.exit_task	= cnt_exit_task,
-	.enable		= cnt_enable,
-	.disable	= cnt_disable,
+	.init_task	= (void *) cnt_init_task,
+	.exit_task	= (void *) cnt_exit_task,
+	.enable		= (void *) cnt_enable,
+	.disable	= (void *) cnt_disable,
 	.name		= "init_enable_count",
 };
diff --git a/tools/testing/selftests/sched_ext/maximal.bpf.c b/tools/testing/selftests/sched_ext/maximal.bpf.c
index 00bfa9cb95d38..4d4cd8d966dba 100644
--- a/tools/testing/selftests/sched_ext/maximal.bpf.c
+++ b/tools/testing/selftests/sched_ext/maximal.bpf.c
@@ -131,34 +131,34 @@ void BPF_STRUCT_OPS(maximal_exit, struct scx_exit_info *info)
 
 SEC(".struct_ops.link")
 struct sched_ext_ops maximal_ops = {
-	.select_cpu		= maximal_select_cpu,
-	.enqueue		= maximal_enqueue,
-	.dequeue		= maximal_dequeue,
-	.dispatch		= maximal_dispatch,
-	.runnable		= maximal_runnable,
-	.running		= maximal_running,
-	.stopping		= maximal_stopping,
-	.quiescent		= maximal_quiescent,
-	.yield			= maximal_yield,
-	.core_sched_before	= maximal_core_sched_before,
-	.set_weight		= maximal_set_weight,
-	.set_cpumask		= maximal_set_cpumask,
-	.update_idle		= maximal_update_idle,
-	.cpu_acquire		= maximal_cpu_acquire,
-	.cpu_release		= maximal_cpu_release,
-	.cpu_online		= maximal_cpu_online,
-	.cpu_offline		= maximal_cpu_offline,
-	.init_task		= maximal_init_task,
-	.enable			= maximal_enable,
-	.exit_task		= maximal_exit_task,
-	.disable		= maximal_disable,
-	.cgroup_init		= maximal_cgroup_init,
-	.cgroup_exit		= maximal_cgroup_exit,
-	.cgroup_prep_move	= maximal_cgroup_prep_move,
-	.cgroup_move		= maximal_cgroup_move,
-	.cgroup_cancel_move	= maximal_cgroup_cancel_move,
-	.cgroup_set_weight	= maximal_cgroup_set_weight,
-	.init			= maximal_init,
-	.exit			= maximal_exit,
+	.select_cpu		= (void *) maximal_select_cpu,
+	.enqueue		= (void *) maximal_enqueue,
+	.dequeue		= (void *) maximal_dequeue,
+	.dispatch		= (void *) maximal_dispatch,
+	.runnable		= (void *) maximal_runnable,
+	.running		= (void *) maximal_running,
+	.stopping		= (void *) maximal_stopping,
+	.quiescent		= (void *) maximal_quiescent,
+	.yield			= (void *) maximal_yield,
+	.core_sched_before	= (void *) maximal_core_sched_before,
+	.set_weight		= (void *) maximal_set_weight,
+	.set_cpumask		= (void *) maximal_set_cpumask,
+	.update_idle		= (void *) maximal_update_idle,
+	.cpu_acquire		= (void *) maximal_cpu_acquire,
+	.cpu_release		= (void *) maximal_cpu_release,
+	.cpu_online		= (void *) maximal_cpu_online,
+	.cpu_offline		= (void *) maximal_cpu_offline,
+	.init_task		= (void *) maximal_init_task,
+	.enable			= (void *) maximal_enable,
+	.exit_task		= (void *) maximal_exit_task,
+	.disable		= (void *) maximal_disable,
+	.cgroup_init		= (void *) maximal_cgroup_init,
+	.cgroup_exit		= (void *) maximal_cgroup_exit,
+	.cgroup_prep_move	= (void *) maximal_cgroup_prep_move,
+	.cgroup_move		= (void *) maximal_cgroup_move,
+	.cgroup_cancel_move	= (void *) maximal_cgroup_cancel_move,
+	.cgroup_set_weight	= (void *) maximal_cgroup_set_weight,
+	.init			= (void *) maximal_init,
+	.exit			= (void *) maximal_exit,
 	.name			= "maximal",
 };
diff --git a/tools/testing/selftests/sched_ext/maybe_null.bpf.c b/tools/testing/selftests/sched_ext/maybe_null.bpf.c
index 27d0f386acfb1..cf4ae870cd4e5 100644
--- a/tools/testing/selftests/sched_ext/maybe_null.bpf.c
+++ b/tools/testing/selftests/sched_ext/maybe_null.bpf.c
@@ -29,8 +29,8 @@ bool BPF_STRUCT_OPS(maybe_null_success_yield, struct task_struct *from,
 
 SEC(".struct_ops.link")
 struct sched_ext_ops maybe_null_success = {
-	.dispatch               = maybe_null_success_dispatch,
-	.yield			= maybe_null_success_yield,
-	.enable			= maybe_null_running,
+	.dispatch               = (void *) maybe_null_success_dispatch,
+	.yield			= (void *) maybe_null_success_yield,
+	.enable			= (void *) maybe_null_running,
 	.name			= "minimal",
 };
diff --git a/tools/testing/selftests/sched_ext/maybe_null_fail_dsp.bpf.c b/tools/testing/selftests/sched_ext/maybe_null_fail_dsp.bpf.c
index c0641050271d3..ec724d7b33d18 100644
--- a/tools/testing/selftests/sched_ext/maybe_null_fail_dsp.bpf.c
+++ b/tools/testing/selftests/sched_ext/maybe_null_fail_dsp.bpf.c
@@ -19,7 +19,7 @@ void BPF_STRUCT_OPS(maybe_null_fail_dispatch, s32 cpu, struct task_struct *p)
 
 SEC(".struct_ops.link")
 struct sched_ext_ops maybe_null_fail = {
-	.dispatch               = maybe_null_fail_dispatch,
-	.enable			= maybe_null_running,
+	.dispatch               = (void *) maybe_null_fail_dispatch,
+	.enable			= (void *) maybe_null_running,
 	.name			= "maybe_null_fail_dispatch",
 };
diff --git a/tools/testing/selftests/sched_ext/maybe_null_fail_yld.bpf.c b/tools/testing/selftests/sched_ext/maybe_null_fail_yld.bpf.c
index 3c1740028e3b9..e6552cace020e 100644
--- a/tools/testing/selftests/sched_ext/maybe_null_fail_yld.bpf.c
+++ b/tools/testing/selftests/sched_ext/maybe_null_fail_yld.bpf.c
@@ -22,7 +22,7 @@ bool BPF_STRUCT_OPS(maybe_null_fail_yield, struct task_struct *from,
 
 SEC(".struct_ops.link")
 struct sched_ext_ops maybe_null_fail = {
-	.yield			= maybe_null_fail_yield,
-	.enable			= maybe_null_running,
+	.yield			= (void *) maybe_null_fail_yield,
+	.enable			= (void *) maybe_null_running,
 	.name			= "maybe_null_fail_yield",
 };
diff --git a/tools/testing/selftests/sched_ext/prog_run.bpf.c b/tools/testing/selftests/sched_ext/prog_run.bpf.c
index 6a4d7c48e3f22..00c267626a68f 100644
--- a/tools/testing/selftests/sched_ext/prog_run.bpf.c
+++ b/tools/testing/selftests/sched_ext/prog_run.bpf.c
@@ -28,6 +28,6 @@ void BPF_STRUCT_OPS(prog_run_exit, struct scx_exit_info *ei)
 
 SEC(".struct_ops.link")
 struct sched_ext_ops prog_run_ops = {
-	.exit			= prog_run_exit,
+	.exit			= (void *) prog_run_exit,
 	.name			= "prog_run",
 };
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c
index 2ed2991afafe3..f171ac4709706 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dfl.bpf.c
@@ -35,6 +35,6 @@ void BPF_STRUCT_OPS(select_cpu_dfl_enqueue, struct task_struct *p,
 
 SEC(".struct_ops.link")
 struct sched_ext_ops select_cpu_dfl_ops = {
-	.enqueue		= select_cpu_dfl_enqueue,
+	.enqueue		= (void *) select_cpu_dfl_enqueue,
 	.name			= "select_cpu_dfl",
 };
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
index 4bb5abb2d3690..9efdbb7da9288 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
@@ -82,8 +82,8 @@ s32 BPF_STRUCT_OPS(select_cpu_dfl_nodispatch_init_task,
 
 SEC(".struct_ops.link")
 struct sched_ext_ops select_cpu_dfl_nodispatch_ops = {
-	.select_cpu		= select_cpu_dfl_nodispatch_select_cpu,
-	.enqueue		= select_cpu_dfl_nodispatch_enqueue,
-	.init_task		= select_cpu_dfl_nodispatch_init_task,
+	.select_cpu		= (void *) select_cpu_dfl_nodispatch_select_cpu,
+	.enqueue		= (void *) select_cpu_dfl_nodispatch_enqueue,
+	.init_task		= (void *) select_cpu_dfl_nodispatch_init_task,
 	.name			= "select_cpu_dfl_nodispatch",
 };
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c
index f0b96a4a04b2c..59bfc4f36167a 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch.bpf.c
@@ -35,7 +35,7 @@ s32 BPF_STRUCT_OPS(select_cpu_dispatch_select_cpu, struct task_struct *p,
 
 SEC(".struct_ops.link")
 struct sched_ext_ops select_cpu_dispatch_ops = {
-	.select_cpu		= select_cpu_dispatch_select_cpu,
+	.select_cpu		= (void *) select_cpu_dispatch_select_cpu,
 	.name			= "select_cpu_dispatch",
 	.timeout_ms		= 1000U,
 };
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c
index 7b42ddce0f56c..3bbd5fcdfb18e 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch_bad_dsq.bpf.c
@@ -30,8 +30,8 @@ void BPF_STRUCT_OPS(select_cpu_dispatch_bad_dsq_exit, struct scx_exit_info *ei)
 
 SEC(".struct_ops.link")
 struct sched_ext_ops select_cpu_dispatch_bad_dsq_ops = {
-	.select_cpu		= select_cpu_dispatch_bad_dsq_select_cpu,
-	.exit			= select_cpu_dispatch_bad_dsq_exit,
+	.select_cpu		= (void *) select_cpu_dispatch_bad_dsq_select_cpu,
+	.exit			= (void *) select_cpu_dispatch_bad_dsq_exit,
 	.name			= "select_cpu_dispatch_bad_dsq",
 	.timeout_ms		= 1000U,
 };
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c
index 653e3dc0b4dc8..0fda57fe0ecfa 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dispatch_dbl_dsp.bpf.c
@@ -31,8 +31,8 @@ void BPF_STRUCT_OPS(select_cpu_dispatch_dbl_dsp_exit, struct scx_exit_info *ei)
 
 SEC(".struct_ops.link")
 struct sched_ext_ops select_cpu_dispatch_dbl_dsp_ops = {
-	.select_cpu		= select_cpu_dispatch_dbl_dsp_select_cpu,
-	.exit			= select_cpu_dispatch_dbl_dsp_exit,
+	.select_cpu		= (void *) select_cpu_dispatch_dbl_dsp_select_cpu,
+	.exit			= (void *) select_cpu_dispatch_dbl_dsp_exit,
 	.name			= "select_cpu_dispatch_dbl_dsp",
 	.timeout_ms		= 1000U,
 };
diff --git a/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
index 7f3ebf4fc2ead..e6c67bcf5e6e3 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_vtime.bpf.c
@@ -81,12 +81,12 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(select_cpu_vtime_init)
 
 SEC(".struct_ops.link")
 struct sched_ext_ops select_cpu_vtime_ops = {
-	.select_cpu		= select_cpu_vtime_select_cpu,
-	.dispatch		= select_cpu_vtime_dispatch,
-	.running		= select_cpu_vtime_running,
-	.stopping		= select_cpu_vtime_stopping,
-	.enable			= select_cpu_vtime_enable,
-	.init			= select_cpu_vtime_init,
+	.select_cpu		= (void *) select_cpu_vtime_select_cpu,
+	.dispatch		= (void *) select_cpu_vtime_dispatch,
+	.running		= (void *) select_cpu_vtime_running,
+	.stopping		= (void *) select_cpu_vtime_stopping,
+	.enable			= (void *) select_cpu_vtime_enable,
+	.init			= (void *) select_cpu_vtime_init,
 	.name			= "select_cpu_vtime",
 	.timeout_ms		= 1000U,
 };
-- 
2.47.0


