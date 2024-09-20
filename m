Return-Path: <linux-kselftest+bounces-18150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E79CD97CF8D
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 02:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D7D1F24D4B
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 00:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F05C3C30;
	Fri, 20 Sep 2024 00:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h4HLuEjo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5634525762;
	Fri, 20 Sep 2024 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726791022; cv=none; b=ot99JtRHQCj2opB+2kUi3/yDJYrUrPD8GbdXmgangHac0odPtETIMK9cmb/bMTkhQ9HP+HmeqaP4qOE9XCrMMeDJl8imqnSNSW1YucjIP8WrYwpiJuNXp1F631X9ZGc+nNRH8RoBf4Aia3z/RU7pETprIJYOAreMYusqUM+43VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726791022; c=relaxed/simple;
	bh=w6ZoeRYq4NE0qD8Q6ShGq7y/9B8DXmqtcNbV31xIMpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JA2vuWJUePStfkc0mxeNFSpU1TmnnaxW5LqBSjf1N5pJcoJen2Y/yTmyW5gZGn6YyjKLwCt4gSfmIImCWCkYaOO0dMwygwg3eg5iJ2JMMOpMef6s3Ba2nsFTPsqCVBm1/9yDmDwfeiiZTAf0ll2H5A/paKHiREE+Wek0CANjNGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h4HLuEjo; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JLMWHL026268;
	Fri, 20 Sep 2024 00:09:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=l
	o1aCkKVS24LAu9IU+eF5diR+sLIf+H3S1/pXqxq35M=; b=h4HLuEjoY6uAJm4m4
	hCH15mN+GCfDy1ebhCYACQ2Q/uXiVtceV6gnI1tYaYL98PJWA4asJ4LdUqINYKyT
	dNfGAw5zv8QjKA9/Q7ECZJqhOJlpxxFLlcMt0JtKoS9JNaK4zrYiQvEddJDGoRv1
	oSn0XJTWTV9reeoLh491pqKLppHQTBTIEuwoRxSeFwStB/DNw3qp3AISM4u8Ernu
	B2sB9X2+hMTk+qsJ56MkeaCcY7MBE2XcSC/bX7LIDzizLh6fxbx9xUOSzRlKFGUg
	b800VhxmjG7sfYZOA9L1LpVYqJt4bhUWBGPQE5vN5Ltcj3dsS0E3PcQ1kKfGbOZp
	3K1Mw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3nfweq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 00:09:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48JM0u8o018399;
	Fri, 20 Sep 2024 00:09:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nyd17egx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 00:09:37 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48K09ZKD022155;
	Fri, 20 Sep 2024 00:09:36 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41nyd17egc-2;
	Fri, 20 Sep 2024 00:09:36 +0000
From: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To: davem@davemloft.net, Liam.Howlett@Oracle.com
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, oleg@redhat.com,
        akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org,
        mhocko@suse.com, alexjlzheng@tencent.com, willy@infradead.org,
        michael.christie@oracle.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, anjali.k.kulkarni@oracle.com,
        peili.io@oracle.com
Subject: [PATCH net-next 1/2] connector/cn_proc: Handle threads for proc connector
Date: Thu, 19 Sep 2024 17:09:32 -0700
Message-ID: <20240920000933.185090-2-anjali.k.kulkarni@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240920000933.185090-1-anjali.k.kulkarni@oracle.com>
References: <20240920000933.185090-1-anjali.k.kulkarni@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-19_23,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409190161
X-Proofpoint-GUID: JlFYRhc6l5tYAudUH6ScXUrCLUeDAiR7
X-Proofpoint-ORIG-GUID: JlFYRhc6l5tYAudUH6ScXUrCLUeDAiR7

Add a new type PROC_CN_MCAST_NOTIFY to proc connector API, which allows a
thread to notify the kernel that it has exited abnormally. Thread can also
send the exit status code it wants returned in the notification with it.
Exiting thread can call this either when it wants to call pthread_exit()
with non-zero value or from signal handler.

Once kernel receives this, it saves this exit status in the thread's
exit_code field of task_struct. This field is then checked when the thread
actually exits, and if non-zero, it is copied to the notification to be
sent.

Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
---
 drivers/connector/cn_proc.c  | 11 +++++++++--
 include/linux/cn_proc.h      |  5 +++--
 include/uapi/linux/cn_proc.h |  4 +++-
 kernel/exit.c                |  5 ++++-
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index 44b19e696176..4c38b9bf4f2f 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -320,7 +320,7 @@ void proc_coredump_connector(struct task_struct *task)
 	send_msg(msg);
 }
 
-void proc_exit_connector(struct task_struct *task)
+void proc_exit_connector(struct task_struct *task, __u32 uexit_code)
 {
 	struct cn_msg *msg;
 	struct proc_event *ev;
@@ -337,7 +337,10 @@ void proc_exit_connector(struct task_struct *task)
 	ev->what = PROC_EVENT_EXIT;
 	ev->event_data.exit.process_pid = task->pid;
 	ev->event_data.exit.process_tgid = task->tgid;
-	ev->event_data.exit.exit_code = task->exit_code;
+	if (task->exit_code == 0)
+		ev->event_data.exit.exit_code = uexit_code;
+	else
+		ev->event_data.exit.exit_code = task->exit_code;
 	ev->event_data.exit.exit_signal = task->exit_signal;
 
 	rcu_read_lock();
@@ -413,6 +416,10 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
 	if (msg->len == sizeof(*pinput)) {
 		pinput = (struct proc_input *)msg->data;
 		mc_op = pinput->mcast_op;
+		if (mc_op == PROC_CN_MCAST_NOTIFY) {
+			current->exit_code = pinput->uexit_code;
+			return;
+		}
 		ev_type = pinput->event_type;
 	} else if (msg->len == sizeof(mc_op)) {
 		mc_op = *((enum proc_cn_mcast_op *)msg->data);
diff --git a/include/linux/cn_proc.h b/include/linux/cn_proc.h
index 1d5b02a96c46..fc1d75897cc7 100644
--- a/include/linux/cn_proc.h
+++ b/include/linux/cn_proc.h
@@ -27,7 +27,7 @@ void proc_sid_connector(struct task_struct *task);
 void proc_ptrace_connector(struct task_struct *task, int which_id);
 void proc_comm_connector(struct task_struct *task);
 void proc_coredump_connector(struct task_struct *task);
-void proc_exit_connector(struct task_struct *task);
+void proc_exit_connector(struct task_struct *task, __u32 uexit_code);
 #else
 static inline void proc_fork_connector(struct task_struct *task)
 {}
@@ -52,7 +52,8 @@ static inline void proc_ptrace_connector(struct task_struct *task,
 static inline void proc_coredump_connector(struct task_struct *task)
 {}
 
-static inline void proc_exit_connector(struct task_struct *task)
+static inline void proc_exit_connector(struct task_struct *task,
+					__u32 uexit_code)
 {}
 #endif	/* CONFIG_PROC_EVENTS */
 #endif	/* CN_PROC_H */
diff --git a/include/uapi/linux/cn_proc.h b/include/uapi/linux/cn_proc.h
index 18e3745b86cd..2b12a24e4651 100644
--- a/include/uapi/linux/cn_proc.h
+++ b/include/uapi/linux/cn_proc.h
@@ -27,7 +27,8 @@
  */
 enum proc_cn_mcast_op {
 	PROC_CN_MCAST_LISTEN = 1,
-	PROC_CN_MCAST_IGNORE = 2
+	PROC_CN_MCAST_IGNORE = 2,
+	PROC_CN_MCAST_NOTIFY = 3
 };
 
 #define PROC_EVENT_ALL (PROC_EVENT_FORK | PROC_EVENT_EXEC | PROC_EVENT_UID |  \
@@ -65,6 +66,7 @@ enum proc_cn_event {
 struct proc_input {
 	enum proc_cn_mcast_op mcast_op;
 	enum proc_cn_event event_type;
+	__u32 uexit_code;
 };
 
 static inline enum proc_cn_event valid_event(enum proc_cn_event ev_type)
diff --git a/kernel/exit.c b/kernel/exit.c
index 7430852a8571..e2698ebe59ea 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -821,6 +821,7 @@ void __noreturn do_exit(long code)
 {
 	struct task_struct *tsk = current;
 	int group_dead;
+	__u32 uexit_code;
 
 	WARN_ON(irqs_disabled());
 
@@ -863,6 +864,8 @@ void __noreturn do_exit(long code)
 		tty_audit_exit();
 	audit_free(tsk);
 
+	uexit_code = tsk->exit_code;
+
 	tsk->exit_code = code;
 	taskstats_exit(tsk, group_dead);
 
@@ -900,7 +903,7 @@ void __noreturn do_exit(long code)
 
 	exit_tasks_rcu_start();
 	exit_notify(tsk, group_dead);
-	proc_exit_connector(tsk);
+	proc_exit_connector(tsk, uexit_code);
 	mpol_put_task_policy(tsk);
 #ifdef CONFIG_FUTEX
 	if (unlikely(current->pi_state_cache))
-- 
2.45.2


