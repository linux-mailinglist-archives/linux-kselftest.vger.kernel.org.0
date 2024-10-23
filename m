Return-Path: <linux-kselftest+bounces-20485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E691E9AD00A
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 18:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12AA81C21713
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 16:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF921CEEA2;
	Wed, 23 Oct 2024 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T/oAE+MW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C094436E;
	Wed, 23 Oct 2024 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700447; cv=none; b=hsINLge81Ut00FooUW5URuFI3QZ37qyA25icqkbZcvdoZLYf1DeeAfEj31eSSGsSiJiXKJycy8ARw/jmCnc0Laz+PKxnBRJajRZ3SVrXCxarPKj+mrYN4DqLUjB+MlPKkKedVvvOBF3CZRWNcTuCD47V7Sq8x/uMili9m5rPP1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700447; c=relaxed/simple;
	bh=IS4Gz1r73Dcx1mz4dXW85FrsNU0Miy8dLF27LRadWfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6S19ZZaAA7D4nFk/duU6IQKQL4Lokk2GfZ32zNC8ZuYZmK92o66EO+qSo2Tk1cLWuWh+4q3t4QPKbpQMkxhm9zAyJnUtsT5vtmFv8PmyeA2Swmo2bZV+ExlZK6m/OAAr7BheerPHEOQ8mjyYLI6QdQknAGnHSnru1rUfIKeGF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T/oAE+MW; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfcCs013891;
	Wed, 23 Oct 2024 16:20:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=fQMjc
	Pt3uLjn7zMf+UVWpMC283tPJ0rQ00Gw9A/WCck=; b=T/oAE+MW7EBcxZQMt6OK1
	jKD1fXL53MSb5qwF3bVOXWXJb/rKADKYNcNvXSnAsgtUGVweB31tHYtWFx8OD/t4
	0ZpjDcqJPEaYCvYUjagvh+ivPplXKrGYH1W6zOYbGPb7UNU8Xl1f08EcMwftPJzQ
	R67FhqudES0tvlbPug+8oMpqn3SXOvak+efyvQb5tIu6PCIP8Iwo/gIWWMdXlFDp
	CIC7M7fQdO08w6/anOJMk60JDs+EGPcfzoGzbNMMfb3qc4vNtss7UTZ3SKLs2eVs
	mEFv6RSjeQ4hV537xJL4xJb1JfU3bMCF9ARkmhMO5IMb8yfwvrLOUwV3YFNuoeSv
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55v0hf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:20:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NGIe6p025440;
	Wed, 23 Oct 2024 16:20:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh9r63k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:20:11 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49NGK808012043;
	Wed, 23 Oct 2024 16:20:10 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 42emh9r5x9-2;
	Wed, 23 Oct 2024 16:20:10 +0000
From: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To: davem@davemloft.net, Liam.Howlett@Oracle.com
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, jiri@resnulli.us, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, akpm@linux-foundation.org,
        brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com,
        johannes.berg@intel.com, mic@digikod.net, gnoack@google.com,
        jk@codeconstruct.com.au, kunit-dev@googlegroups.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, anjali.k.kulkarni@oracle.com,
        peili.io@oracle.com
Subject: [PATCH net-next v6 1/3] connector/cn_proc: Add hash table for threads
Date: Wed, 23 Oct 2024 09:20:04 -0700
Message-ID: <20241023162006.1725309-2-anjali.k.kulkarni@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241023162006.1725309-1-anjali.k.kulkarni@oracle.com>
References: <20241023162006.1725309-1-anjali.k.kulkarni@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_13,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230095
X-Proofpoint-GUID: _ZIPjbZu6Mj_Cn-JF3sw5r39ae5wGCRt
X-Proofpoint-ORIG-GUID: _ZIPjbZu6Mj_Cn-JF3sw5r39ae5wGCRt

Add a new type PROC_CN_MCAST_NOTIFY to proc connector API, which allows a
thread to notify the kernel that is going to exit with a non-zero exit
code and specify the exit code in it. When thread exits in the kernel,
it will send this exit code as a proc filter notification to any
listening process.
Exiting thread can call this either when it wants to call pthread_exit()
with non-zero value or from signal handler.

Add a new file cn_hash.c which implements a hash table storing the exit
codes of abnormally exiting threads, received by the system call above.
The key used for the hash table is the pid of the thread, so when the
thread actually exits, we lookup it's pid in the hash table and retrieve
the exit code sent by user. If the exit code in struct task is 0, we
then replace it with the user supplied non-zero exit code.

cn_hash.c implements the hash table add, delete, lookup operations.
mutex_lock() and mutex_unlock() operations are used to safeguard the
integrity of the hash table while adding or deleting elements.
connector.c has the API calls, called from cn_proc.c, as well as calls
to allocate, initialize and free the hash table.

Add a new flag in PF_* flags of task_struct - EXIT_NOTIFY. This flag is
set when user sends the exit code via PROC_CN_MCAST_NOTIFY. While
exiting, this flag is checked and the hash table add or delete calls
are only made if this flag is set.

A refcount field hrefcnt is added in struct cn_hash_dev, to keep track
of number of threads which have added an entry in hash table. Before
freeing the struct cn_hash_dev, this value must be 0.
This refcnt check is added in case CONFIG_CONNECTOR is compiled as a
module. In that case, when unloading the module, we need to make sure
no hash entries are still present in the hdev table.

Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
---
 drivers/connector/Makefile    |   2 +-
 drivers/connector/cn_hash.c   | 176 ++++++++++++++++++++++++++++++++++
 drivers/connector/cn_proc.c   |  81 +++++++++++++---
 drivers/connector/connector.c |  76 +++++++++++++--
 include/linux/connector.h     |  58 ++++++++---
 include/linux/sched.h         |   2 +-
 include/uapi/linux/cn_proc.h  |   4 +-
 7 files changed, 364 insertions(+), 35 deletions(-)
 create mode 100644 drivers/connector/cn_hash.c

diff --git a/drivers/connector/Makefile b/drivers/connector/Makefile
index 1bf67d3df97d..cb1dcdf067ad 100644
--- a/drivers/connector/Makefile
+++ b/drivers/connector/Makefile
@@ -2,4 +2,4 @@
 obj-$(CONFIG_CONNECTOR)		+= cn.o
 obj-$(CONFIG_PROC_EVENTS)	+= cn_proc.o
 
-cn-y				+= cn_queue.o connector.o
+cn-y				+= cn_hash.o cn_queue.o connector.o
diff --git a/drivers/connector/cn_hash.c b/drivers/connector/cn_hash.c
new file mode 100644
index 000000000000..b94f6c461496
--- /dev/null
+++ b/drivers/connector/cn_hash.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Author: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
+ *
+ * Copyright (c) 2024 Oracle and/or its affiliates.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/connector.h>
+#include <linux/mutex.h>
+#include <linux/pid_namespace.h>
+
+#include <linux/cn_proc.h>
+
+struct cn_hash_dev *cn_hash_alloc_dev(const char *name)
+{
+	struct cn_hash_dev *hdev;
+
+	hdev = kzalloc(sizeof(*hdev), GFP_KERNEL);
+	if (!hdev)
+		return NULL;
+
+	snprintf(hdev->name, sizeof(hdev->name), "%s", name);
+	atomic_set(&hdev->hrefcnt, 0);
+	mutex_init(&hdev->uexit_hash_lock);
+	hash_init(hdev->uexit_pid_htable);
+	return hdev;
+}
+
+void cn_hash_free_dev(struct cn_hash_dev *hdev)
+{
+	struct uexit_pid_hnode *hnode;
+	struct hlist_node *tmp;
+	int bucket;
+
+	pr_debug("%s: Freeing entire hdev %p\n", __func__, hdev);
+
+	mutex_lock(&hdev->uexit_hash_lock);
+	hash_for_each_safe(hdev->uexit_pid_htable, bucket, tmp,
+			   hnode, uexit_pid_hlist) {
+		hash_del(&hnode->uexit_pid_hlist);
+		pr_debug("%s: Freeing node for pid %d\n",
+			 __func__, hnode->pid);
+		kfree(hnode);
+	}
+
+	mutex_unlock(&hdev->uexit_hash_lock);
+	mutex_destroy(&hdev->uexit_hash_lock);
+
+	/*
+	 * This refcnt check is added in case CONFIG_CONNECTOR is
+	 * compiled with =m as a module. In that case, when unloading
+	 * the module, we need to make sure no hash entries are still
+	 * present in the hdev table.
+	 */
+	while (atomic_read(&hdev->hrefcnt)) {
+		pr_info("Waiting for %s to become free: refcnt=%d\n",
+			hdev->name, atomic_read(&hdev->hrefcnt));
+		msleep(1000);
+	}
+
+	kfree(hdev);
+	hdev = NULL;
+}
+
+static struct uexit_pid_hnode *cn_hash_alloc_elem(__u32 uexit_code, pid_t pid)
+{
+	struct uexit_pid_hnode *elem;
+
+	elem = kzalloc(sizeof(*elem), GFP_KERNEL);
+	if (!elem)
+		return NULL;
+
+	INIT_HLIST_NODE(&elem->uexit_pid_hlist);
+	elem->uexit_code = uexit_code;
+	elem->pid = pid;
+	return elem;
+}
+
+int cn_hash_add_elem(struct cn_hash_dev *hdev, __u32 uexit_code, pid_t pid)
+{
+	struct uexit_pid_hnode *elem, *hnode;
+
+	elem = cn_hash_alloc_elem(uexit_code, pid);
+	if (!elem) {
+		pr_err("%s: cn_hash_alloc_elem() returned NULL pid %d\n",
+		       __func__, pid);
+		return -ENOMEM;
+	}
+
+	mutex_lock(&hdev->uexit_hash_lock);
+	/*
+	 * Check if an entry for the same pid already exists
+	 */
+	hash_for_each_possible(hdev->uexit_pid_htable,
+			       hnode, uexit_pid_hlist, pid) {
+		if (hnode->pid == pid) {
+			mutex_unlock(&hdev->uexit_hash_lock);
+			kfree(elem);
+			pr_debug("%s: pid %d already exists in hash table\n",
+				 __func__, pid);
+			return -EEXIST;
+		}
+	}
+
+	hash_add(hdev->uexit_pid_htable, &elem->uexit_pid_hlist, pid);
+	mutex_unlock(&hdev->uexit_hash_lock);
+
+	atomic_inc(&hdev->hrefcnt);
+
+	pr_debug("%s: After hash_add of pid %d elem %p hrefcnt %d\n",
+		 __func__, pid, elem, atomic_read(&hdev->hrefcnt));
+	return 0;
+}
+
+int cn_hash_del_get_exval(struct cn_hash_dev *hdev, pid_t pid)
+{
+	struct uexit_pid_hnode *hnode;
+	struct hlist_node *tmp;
+	int excde;
+
+	mutex_lock(&hdev->uexit_hash_lock);
+	hash_for_each_possible_safe(hdev->uexit_pid_htable,
+				    hnode, tmp, uexit_pid_hlist, pid) {
+		if (hnode->pid == pid) {
+			excde = hnode->uexit_code;
+			hash_del(&hnode->uexit_pid_hlist);
+			mutex_unlock(&hdev->uexit_hash_lock);
+			kfree(hnode);
+			atomic_dec(&hdev->hrefcnt);
+			pr_debug("%s: After hash_del of pid %d, found exit code %u hrefcnt %d\n",
+				 __func__, pid, excde,
+				 atomic_read(&hdev->hrefcnt));
+			return excde;
+		}
+	}
+
+	mutex_unlock(&hdev->uexit_hash_lock);
+	pr_err("%s: pid %d not found in hash table\n",
+	       __func__, pid);
+	return -EINVAL;
+}
+
+int cn_hash_get_exval(struct cn_hash_dev *hdev, pid_t pid)
+{
+	struct uexit_pid_hnode *hnode;
+	__u32 excde;
+
+	mutex_lock(&hdev->uexit_hash_lock);
+	hash_for_each_possible(hdev->uexit_pid_htable,
+			       hnode, uexit_pid_hlist, pid) {
+		if (hnode->pid == pid) {
+			excde = hnode->uexit_code;
+			mutex_unlock(&hdev->uexit_hash_lock);
+			pr_debug("%s: Found exit code %u for pid %d\n",
+				 __func__, excde, pid);
+			return excde;
+		}
+	}
+
+	mutex_unlock(&hdev->uexit_hash_lock);
+	pr_debug("%s: pid %d not found in hash table\n",
+		 __func__, pid);
+	return -EINVAL;
+}
+
+bool cn_hash_table_empty(struct cn_hash_dev *hdev)
+{
+	bool is_empty;
+
+	is_empty = hash_empty(hdev->uexit_pid_htable);
+	pr_debug("Hash table is %s\n", (is_empty ? "empty" : "not empty"));
+
+	return is_empty;
+}
diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index 44b19e696176..36241f2d0c14 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -44,6 +44,7 @@ struct local_event {
 	local_lock_t lock;
 	__u32 count;
 };
+
 static DEFINE_PER_CPU(struct local_event, local_event) = {
 	.lock = INIT_LOCAL_LOCK(lock),
 };
@@ -69,12 +70,14 @@ static int cn_filter(struct sock *dsk, struct sk_buff *skb, void *data)
 	if ((__u32)val == PROC_EVENT_ALL)
 		return 0;
 
+	pr_debug("%s: val %lx, what %x\n", __func__, val, what);
+
 	/*
 	 * Drop packet if we have to report only non-zero exit status
 	 * (PROC_EVENT_NONZERO_EXIT) and exit status is 0
 	 */
 	if (((__u32)val & PROC_EVENT_NONZERO_EXIT) &&
-	    (what == PROC_EVENT_EXIT)) {
+	    what == PROC_EVENT_EXIT) {
 		if (exit_code)
 			return 0;
 	}
@@ -187,11 +190,15 @@ void proc_id_connector(struct task_struct *task, int which_id)
 	rcu_read_lock();
 	cred = __task_cred(task);
 	if (which_id == PROC_EVENT_UID) {
-		ev->event_data.id.r.ruid = from_kuid_munged(&init_user_ns, cred->uid);
-		ev->event_data.id.e.euid = from_kuid_munged(&init_user_ns, cred->euid);
+		ev->event_data.id.r.ruid =
+			from_kuid_munged(&init_user_ns, cred->uid);
+		ev->event_data.id.e.euid =
+			from_kuid_munged(&init_user_ns, cred->euid);
 	} else if (which_id == PROC_EVENT_GID) {
-		ev->event_data.id.r.rgid = from_kgid_munged(&init_user_ns, cred->gid);
-		ev->event_data.id.e.egid = from_kgid_munged(&init_user_ns, cred->egid);
+		ev->event_data.id.r.rgid =
+			from_kgid_munged(&init_user_ns, cred->gid);
+		ev->event_data.id.e.egid =
+			from_kgid_munged(&init_user_ns, cred->egid);
 	} else {
 		rcu_read_unlock();
 		return;
@@ -252,8 +259,9 @@ void proc_ptrace_connector(struct task_struct *task, int ptrace_id)
 	} else if (ptrace_id == PTRACE_DETACH) {
 		ev->event_data.ptrace.tracer_pid  = 0;
 		ev->event_data.ptrace.tracer_tgid = 0;
-	} else
+	} else {
 		return;
+	}
 
 	memcpy(&msg->id, &cn_proc_event_id, sizeof(msg->id));
 	msg->ack = 0; /* not used */
@@ -326,9 +334,15 @@ void proc_exit_connector(struct task_struct *task)
 	struct proc_event *ev;
 	struct task_struct *parent;
 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
+	int uexit_code;
 
-	if (atomic_read(&proc_event_num_listeners) < 1)
+	if (atomic_read(&proc_event_num_listeners) < 1) {
+		if (likely(!(task->flags & PF_EXIT_NOTIFY)))
+			return;
+
+		cn_del_get_exval(task->pid);
 		return;
+	}
 
 	msg = buffer_to_cn_msg(buffer);
 	ev = (struct proc_event *)msg->data;
@@ -337,7 +351,26 @@ void proc_exit_connector(struct task_struct *task)
 	ev->what = PROC_EVENT_EXIT;
 	ev->event_data.exit.process_pid = task->pid;
 	ev->event_data.exit.process_tgid = task->tgid;
-	ev->event_data.exit.exit_code = task->exit_code;
+	if (unlikely(task->flags & PF_EXIT_NOTIFY)) {
+		task->flags &= ~PF_EXIT_NOTIFY;
+
+		uexit_code = cn_del_get_exval(task->pid);
+		if (uexit_code <= 0) {
+			pr_debug("%s: err %d returning task's exit code %u\n",
+				 __func__, uexit_code,
+				 task->exit_code);
+			ev->event_data.exit.exit_code = task->exit_code;
+		} else {
+			ev->event_data.exit.exit_code = uexit_code;
+			pr_debug("%s: Reset PF_EXIT_NOTIFY & retrieved exit code %u from hash table, pid %d\n",
+				 __func__,
+				 ev->event_data.exit.exit_code,
+				 task->pid);
+		}
+	} else {
+		ev->event_data.exit.exit_code = task->exit_code;
+	}
+
 	ev->event_data.exit.exit_signal = task->exit_signal;
 
 	rcu_read_lock();
@@ -356,7 +389,7 @@ void proc_exit_connector(struct task_struct *task)
 }
 
 /*
- * Send an acknowledgement message to userspace
+ * Send an acknowledgment message to userspace
  *
  * Use 0 for success, EFOO otherwise.
  * Note: this is the negative of conventional kernel error
@@ -401,7 +434,7 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
 	int err = 0, initial = 0;
 	struct sock *sk = NULL;
 
-	/* 
+	/*
 	 * Events are reported with respect to the initial pid
 	 * and user namespaces so ignore requestors from
 	 * other namespaces.
@@ -413,6 +446,13 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
 	if (msg->len == sizeof(*pinput)) {
 		pinput = (struct proc_input *)msg->data;
 		mc_op = pinput->mcast_op;
+		if (mc_op == PROC_CN_MCAST_NOTIFY) {
+			pr_debug("%s: Received PROC_CN_MCAST_NOTIFY, pid %d\n",
+				 __func__, current->pid);
+			current->flags |= PF_EXIT_NOTIFY;
+			err = cn_add_elem(pinput->uexit_code, current->pid);
+			return;
+		}
 		ev_type = pinput->event_type;
 	} else if (msg->len == sizeof(mc_op)) {
 		mc_op = *((enum proc_cn_mcast_op *)msg->data);
@@ -428,10 +468,12 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
 
 	if (nsp->sk) {
 		sk = nsp->sk;
-		if (sk->sk_user_data == NULL) {
+		if (!sk->sk_user_data) {
 			sk->sk_user_data = kzalloc(sizeof(struct proc_input),
 						   GFP_KERNEL);
-			if (sk->sk_user_data == NULL) {
+			if (!sk->sk_user_data) {
+				pr_err("%s: Alloc fail sk_user_data, pid %d\n",
+				       __func__, current->pid);
 				err = ENOMEM;
 				goto out;
 			}
@@ -442,21 +484,32 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
 		}
 		((struct proc_input *)(sk->sk_user_data))->event_type =
 			ev_type;
+		pr_debug("%s: sk: %p pid: %d event_type: %x\n",
+			 __func__, sk, current->pid, ev_type);
 		((struct proc_input *)(sk->sk_user_data))->mcast_op = mc_op;
 	}
 
 	switch (mc_op) {
 	case PROC_CN_MCAST_LISTEN:
-		if (initial || (prev_mc_op != PROC_CN_MCAST_LISTEN))
+		if (initial || prev_mc_op != PROC_CN_MCAST_LISTEN) {
 			atomic_inc(&proc_event_num_listeners);
+			pr_debug("%s: PROC_CN_MCAST_LISTEN pid %d: Incremented listeners to %d\n",
+				 __func__, current->pid,
+				 atomic_read(&proc_event_num_listeners));
+		}
 		break;
 	case PROC_CN_MCAST_IGNORE:
-		if (!initial && (prev_mc_op != PROC_CN_MCAST_IGNORE))
+		if (!initial && prev_mc_op != PROC_CN_MCAST_IGNORE) {
 			atomic_dec(&proc_event_num_listeners);
+			pr_debug("%s: PROC_CN_MCAST_IGNORE pid %d: Decremented listeners to %d\n",
+				 __func__, current->pid,
+				 atomic_read(&proc_event_num_listeners));
+		}
 		((struct proc_input *)(sk->sk_user_data))->event_type =
 			PROC_EVENT_NONE;
 		break;
 	default:
+		pr_warn("%s: Invalid value for mc_op %d\n", __func__, mc_op);
 		err = EINVAL;
 		break;
 	}
diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
index 4028e8eeba82..2494a443fbd6 100644
--- a/drivers/connector/connector.c
+++ b/drivers/connector/connector.c
@@ -48,8 +48,8 @@ static int cn_already_initialized;
  * one we are expecting then it is a new message.
  *
  * If we receive a message and its sequence number is the same as one
- * we are expecting but it's acknowledgement number is not equal to
- * the acknowledgement number in the original message + 1, then it is
+ * we are expecting but it's acknowledgment number is not equal to
+ * the acknowledgment number in the original message + 1, then it is
  * a new message.
  *
  * If msg->len != len, then additional cn_msg messages are expected following
@@ -121,7 +121,7 @@ EXPORT_SYMBOL_GPL(cn_netlink_send_mult);
 
 /* same as cn_netlink_send_mult except msg->len is used for len */
 int cn_netlink_send(struct cn_msg *msg, u32 portid, u32 __group,
-	gfp_t gfp_mask)
+		    gfp_t gfp_mask)
 {
 	return cn_netlink_send_mult(msg, msg->len, portid, __group, gfp_mask,
 				    NULL, NULL);
@@ -155,7 +155,7 @@ static int cn_call_callback(struct sk_buff *skb)
 	}
 	spin_unlock_bh(&dev->cbdev->queue_lock);
 
-	if (cbq != NULL) {
+	if (cbq) {
 		cbq->callback(msg, nsp);
 		kfree_skb(skb);
 		cn_queue_release_callback(cbq);
@@ -171,7 +171,7 @@ static int cn_call_callback(struct sk_buff *skb)
  */
 static int cn_bind(struct net *net, int group)
 {
-	unsigned long groups = (unsigned long) group;
+	unsigned long groups = (unsigned long)group;
 
 	if (ns_capable(net->user_ns, CAP_NET_ADMIN))
 		return 0;
@@ -271,6 +271,50 @@ static int __maybe_unused cn_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+int cn_del_get_exval(pid_t pid)
+{
+	struct cn_dev *dev = &cdev;
+
+	if (!cn_already_initialized)
+		return 0;
+
+	return cn_hash_del_get_exval(dev->hdev, pid);
+}
+EXPORT_SYMBOL_GPL(cn_del_get_exval);
+
+int cn_add_elem(__u32 uexit_code, pid_t pid)
+{
+	struct cn_dev *dev = &cdev;
+
+	if (!cn_already_initialized)
+		return 0;
+
+	return cn_hash_add_elem(dev->hdev, uexit_code, pid);
+}
+EXPORT_SYMBOL_GPL(cn_add_elem);
+
+int cn_get_exval(pid_t pid)
+{
+	struct cn_dev *dev = &cdev;
+
+	if (!cn_already_initialized)
+		return 0;
+
+	return cn_hash_get_exval(dev->hdev, pid);
+}
+EXPORT_SYMBOL_GPL(cn_get_exval);
+
+bool cn_table_empty(void)
+{
+	struct cn_dev *dev = &cdev;
+
+	if (!cn_already_initialized)
+		return 0;
+
+	return cn_hash_table_empty(dev->hdev);
+}
+EXPORT_SYMBOL_GPL(cn_table_empty);
+
 static int cn_init(void)
 {
 	struct cn_dev *dev = &cdev;
@@ -283,18 +327,35 @@ static int cn_init(void)
 	};
 
 	dev->nls = netlink_kernel_create(&init_net, NETLINK_CONNECTOR, &cfg);
-	if (!dev->nls)
+	if (!dev->nls) {
+		pr_err("%s: netlink_kernel_create failed, connector not initialized\n",
+		       __func__);
 		return -EIO;
+	}
 
 	dev->cbdev = cn_queue_alloc_dev("cqueue", dev->nls);
 	if (!dev->cbdev) {
+		pr_err("%s: Allocation of dev->cbdev failed, connector not initialized\n",
+		       __func__);
 		netlink_kernel_release(dev->nls);
 		return -EINVAL;
 	}
 
+	dev->hdev = cn_hash_alloc_dev("pid hash table");
+	if (!dev->hdev) {
+		pr_err("%s: Allocation of dev->hdev failed, connector not initialized\n",
+		       __func__);
+		netlink_kernel_release(dev->nls);
+		cn_queue_free_dev(dev->cbdev);
+		return -ENOMEM;
+	}
+
+	pr_debug("Connector initialized, allocated hdev %p\n", dev->hdev);
+
 	cn_already_initialized = 1;
 
-	proc_create_single("connector", S_IRUGO, init_net.proc_net, cn_proc_show);
+	proc_create_single("connector", S_IRUGO, init_net.proc_net,
+			   cn_proc_show);
 
 	return 0;
 }
@@ -308,6 +369,7 @@ static void cn_fini(void)
 	remove_proc_entry("connector", init_net.proc_net);
 
 	cn_queue_free_dev(dev->cbdev);
+	cn_hash_free_dev(dev->hdev);
 	netlink_kernel_release(dev->nls);
 }
 
diff --git a/include/linux/connector.h b/include/linux/connector.h
index 70bc1160f3d8..3f0648c886bc 100644
--- a/include/linux/connector.h
+++ b/include/linux/connector.h
@@ -1,14 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * 	connector.h
- * 
+ * connector.h
+ *
  * 2004-2005 Copyright (c) Evgeniy Polyakov <zbr@ioremap.net>
  * All rights reserved.
  */
 #ifndef __CONNECTOR_H
 #define __CONNECTOR_H
 
-
 #include <linux/refcount.h>
 
 #include <linux/list.h>
@@ -18,6 +17,8 @@
 #include <uapi/linux/connector.h>
 
 #define CN_CBQ_NAMELEN		32
+#define HASHT_NAMELEN		32
+#define PID_HASH_TABLE_BITS	10
 
 struct cn_queue_dev {
 	atomic_t refcnt;
@@ -40,11 +41,29 @@ struct cn_callback_entry {
 	struct cn_queue_dev *pdev;
 
 	struct cn_callback_id id;
-	void (*callback) (struct cn_msg *, struct netlink_skb_parms *);
+	void (*callback)(struct cn_msg *, struct netlink_skb_parms *);
 
 	u32 seq, group;
 };
 
+struct uexit_pid_hnode {
+	__u32 uexit_code;
+	pid_t pid;
+	struct hlist_node uexit_pid_hlist;
+};
+
+struct cn_hash_dev {
+	atomic_t hrefcnt;
+	unsigned char name[HASHT_NAMELEN];
+	/*
+	 * This mutex is used to lock the hash table to allow
+	 * multiple threads to add their pid & exit code to it.
+	 * Shared between all threads.
+	 */
+	struct mutex uexit_hash_lock;
+	DECLARE_HASHTABLE(uexit_pid_htable, PID_HASH_TABLE_BITS);
+};
+
 struct cn_dev {
 	struct cb_id id;
 
@@ -52,6 +71,7 @@ struct cn_dev {
 	struct sock *nls;
 
 	struct cn_queue_dev *cbdev;
+	struct cn_hash_dev *hdev;
 };
 
 /**
@@ -62,10 +82,11 @@ struct cn_dev {
  *		in-kernel users.
  * @name:	connector's callback symbolic name.
  * @callback:	connector's callback.
- * 		parameters are %cn_msg and the sender's credentials
+ *		parameters are %cn_msg and the sender's credentials
  */
 int cn_add_callback(const struct cb_id *id, const char *name,
-		    void (*callback)(struct cn_msg *, struct netlink_skb_parms *));
+		    void (*callback)(struct cn_msg *,
+				     struct netlink_skb_parms *));
 /**
  * cn_del_callback() - Unregisters new callback with connector core.
  *
@@ -73,17 +94,16 @@ int cn_add_callback(const struct cb_id *id, const char *name,
  */
 void cn_del_callback(const struct cb_id *id);
 
-
 /**
  * cn_netlink_send_mult - Sends message to the specified groups.
  *
- * @msg: 	message header(with attached data).
+ * @msg:	message header(with attached data).
  * @len:	Number of @msg to be sent.
  * @portid:	destination port.
  *		If non-zero the message will be sent to the given port,
  *		which should be set to the original sender.
  * @group:	destination group.
- * 		If @portid and @group is zero, then appropriate group will
+ *		If @portid and @group is zero, then appropriate group will
  *		be searched through all registered connector users, and
  *		message will be delivered to the group which was created
  *		for user with the same ID as in @msg.
@@ -111,7 +131,7 @@ int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid,
  *		If non-zero the message will be sent to the given port,
  *		which should be set to the original sender.
  * @group:	destination group.
- * 		If @portid and @group is zero, then appropriate group will
+ *		If @portid and @group is zero, then appropriate group will
  *		be searched through all registered connector users, and
  *		message will be delivered to the group which was created
  *		for user with the same ID as in @msg.
@@ -128,7 +148,8 @@ int cn_netlink_send(struct cn_msg *msg, u32 portid, u32 group, gfp_t gfp_mask);
 
 int cn_queue_add_callback(struct cn_queue_dev *dev, const char *name,
 			  const struct cb_id *id,
-			  void (*callback)(struct cn_msg *, struct netlink_skb_parms *));
+			  void (*callback)(struct cn_msg *,
+					   struct netlink_skb_parms *));
 void cn_queue_del_callback(struct cn_queue_dev *dev, const struct cb_id *id);
 void cn_queue_release_callback(struct cn_callback_entry *);
 
@@ -137,4 +158,19 @@ void cn_queue_free_dev(struct cn_queue_dev *dev);
 
 int cn_cb_equal(const struct cb_id *, const struct cb_id *);
 
+struct cn_hash_dev *cn_hash_alloc_dev(const char *name);
+void cn_hash_free_dev(struct cn_hash_dev *hdev);
+struct uexit_pid_hnode *cn_hash_find_pid_node(struct cn_hash_dev *hdev,
+					      pid_t pid);
+int cn_hash_add_elem(struct cn_hash_dev *hdev, __u32 uexit_code, pid_t pid);
+int cn_hash_del_get_exval(struct cn_hash_dev *hdev, pid_t pid);
+int cn_hash_get_exval(struct cn_hash_dev *hdev, pid_t pid);
+
+int cn_add_elem(__u32 uexit_code, pid_t pid);
+int cn_del_get_exval(pid_t pid);
+int cn_get_exval(pid_t pid);
+
+bool cn_table_empty(void);
+bool cn_hash_table_empty(struct cn_hash_dev *hdev);
+
 #endif				/* __CONNECTOR_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e6ee4258169a..a2339ae6208b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1673,7 +1673,7 @@ extern struct pid *cad_pid;
 #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
 #define PF_USER_WORKER		0x00004000	/* Kernel thread cloned from userspace thread */
 #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
-#define PF__HOLE__00010000	0x00010000
+#define PF_EXIT_NOTIFY		0x00010000	/* This thread has sent an exit value to be sent as a notification to listening processes */
 #define PF_KSWAPD		0x00020000	/* I am kswapd */
 #define PF_MEMALLOC_NOFS	0x00040000	/* All allocations inherit GFP_NOFS. See memalloc_nfs_save() */
 #define PF_MEMALLOC_NOIO	0x00080000	/* All allocations inherit GFP_NOIO. See memalloc_noio_save() */
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
-- 
2.46.0


