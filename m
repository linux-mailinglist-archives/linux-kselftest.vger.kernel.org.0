Return-Path: <linux-kselftest+bounces-19581-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C0899AFB6
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 02:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D131C21A7B
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 00:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27372F4E2;
	Sat, 12 Oct 2024 00:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JSzH/b5A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59D2C2C8;
	Sat, 12 Oct 2024 00:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728693967; cv=none; b=WhjgqLX5Nxpm0Pyx5BJjFNzt07ChyUO1bn1+tIlAi93ini5tqBkDzYBOlYmcO4D3l4h+3kwzm8daxk4TKRAt0Fa3ma+Tw6Fdz3lXtPpFfSX6zLpSHbCeUhPyn9lLOKBvSQAVefU2mIRbZHvq9NLhRLT2LAcBeQg8aNsMZVUKkhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728693967; c=relaxed/simple;
	bh=RXN7Wpwuu3U7MIvqxCUMQ8f+Wv9goj9YYbnDJ4n5yLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IM6QsCigEOIQO5Z1si5LWN9cS2fmXqNQ3zqNYL/c7gPr6jFHOEIfUg53EVDGMYboTW8Uo8HhxfygQIyQ8nvT3lQJahAh0qDWrYUvqfpTNoljY4zRFtNgDsdbjU6xsLjxCBaVJ1Fn0Zi5Yvv+M6D8T2KtzyEFw87a6JXC60i5KPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JSzH/b5A; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BKSSTY010275;
	Sat, 12 Oct 2024 00:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=BYzI5
	pPohSBvLZKXD8SfCRXFG27TbOL5Mgrghx2dhj4=; b=JSzH/b5AZLzrR9xXU0XWA
	2/gpcQh6IonG+sRVzuPgwA/loiGH+QrGy4z7V/RICDPhvsSBvY2C5bHhtOrR+7RX
	Zku+706nAgbX8OCV2DBVz/EP6MSBNsvscyRsTPl94Ib4gbkI/fu9Uvbt/CHcWGk3
	QKmMU52rFaqfPyUZWqAt8Saaex0pwKF7yWx2vYdXIakKw60kuQllluk1GlLlB9tC
	H1CHI+7VD/3YlC/SvFhZ4KlhAuHQsJNxAi92ysqWEGku/eMK9i+GzuOazYr2joll
	28gPU/WyFEcmaefQemeua+vpficUC7Q8fBadaikAPDqN+OtsLFuLjgPe9K63gv5H
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423063wxkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Oct 2024 00:45:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49BNu746005721;
	Sat, 12 Oct 2024 00:45:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwbvtc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Oct 2024 00:45:41 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49C0jbP3017077;
	Sat, 12 Oct 2024 00:45:40 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 422uwbvtat-2;
	Sat, 12 Oct 2024 00:45:40 +0000
From: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To: davem@davemloft.net, Liam.Howlett@Oracle.com
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, jiri@resnulli.us, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, akpm@linux-foundation.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, anjali.k.kulkarni@oracle.com,
        peili.io@oracle.com
Subject: [PATCH net-next 1/3] connector/cn_proc: Add hash table for threads
Date: Fri, 11 Oct 2024 17:45:30 -0700
Message-ID: <20241012004532.2071738-2-anjali.k.kulkarni@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241012004532.2071738-1-anjali.k.kulkarni@oracle.com>
References: <20241012004532.2071738-1-anjali.k.kulkarni@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_21,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410120004
X-Proofpoint-ORIG-GUID: -rO7rLIL0HKNIU77cCq-1WRx8u8k79Wz
X-Proofpoint-GUID: -rO7rLIL0HKNIU77cCq-1WRx8u8k79Wz

Add a new type PROC_CN_MCAST_NOTIFY to proc connector API, which allows a
thread to notify the kernel that it has exited abnormally. Thread can also
send the exit status code it wants returned in the notification with it.
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

Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
---
 drivers/connector/Makefile    |   2 +-
 drivers/connector/cn_hash.c   | 195 ++++++++++++++++++++++++++++++++++
 drivers/connector/cn_proc.c   |  59 +++++++++-
 drivers/connector/connector.c |  83 ++++++++++++++-
 include/linux/connector.h     |  43 ++++++++
 include/linux/sched.h         |   2 +-
 include/uapi/linux/cn_proc.h  |   4 +-
 7 files changed, 379 insertions(+), 9 deletions(-)
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
index 000000000000..a0211cd99132
--- /dev/null
+++ b/drivers/connector/cn_hash.c
@@ -0,0 +1,195 @@
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
+			hnode, uexit_pid_hlist) {
+		hash_del(&hnode->uexit_pid_hlist);
+		pr_debug("%s: Freeing node for pid %d\n",
+				__func__, hnode->pid);
+		kfree(hnode);
+	}
+
+	mutex_unlock(&hdev->uexit_hash_lock);
+	mutex_destroy(&hdev->uexit_hash_lock);
+
+	while (atomic_read(&hdev->hrefcnt)) {
+		pr_info("Waiting for %s to become free: refcnt=%d\n",
+				hdev->name, atomic_read(&hdev->hrefcnt));
+		msleep(1000);
+	}
+
+	kfree(hdev);
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
+void cn_hash_free_elem(struct uexit_pid_hnode *elem)
+{
+	kfree(elem);
+}
+
+int cn_hash_add_elem(struct cn_hash_dev *hdev, __u32 uexit_code, pid_t pid)
+{
+	struct uexit_pid_hnode *elem, *hnode;
+
+	elem = cn_hash_alloc_elem(uexit_code, pid);
+	if (!elem) {
+		pr_err("%s: cn_hash_alloc_elem() returned NULL pid %d\n",
+				__func__, pid);
+		return -ENOMEM;
+	}
+
+	mutex_lock(&hdev->uexit_hash_lock);
+	/*
+	 * Check if an entry for the same pid already exists
+	 */
+	hash_for_each_possible(hdev->uexit_pid_htable,
+				hnode, uexit_pid_hlist, pid) {
+		if (hnode->pid == pid) {
+			mutex_unlock(&hdev->uexit_hash_lock);
+			cn_hash_free_elem(elem);
+			pr_debug("%s: pid %d already exists in hash table\n",
+				__func__, pid);
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
+			__func__, pid, elem, atomic_read(&hdev->hrefcnt));
+	return 0;
+}
+
+int cn_hash_del_elem(struct cn_hash_dev *hdev, pid_t pid)
+{
+	struct uexit_pid_hnode *hnode;
+	struct hlist_node *tmp;
+
+	mutex_lock(&hdev->uexit_hash_lock);
+	hash_for_each_possible_safe(hdev->uexit_pid_htable,
+				hnode, tmp, uexit_pid_hlist, pid) {
+		if (hnode && hnode->pid == pid) {
+			hash_del(&hnode->uexit_pid_hlist);
+			mutex_unlock(&hdev->uexit_hash_lock);
+			kfree(hnode);
+			atomic_dec(&hdev->hrefcnt);
+			pr_debug("%s: After hash_del of pid %d, hrefcnt %d\n",
+					__func__, pid,
+					atomic_read(&hdev->hrefcnt));
+			return 0;
+		}
+	}
+
+	mutex_unlock(&hdev->uexit_hash_lock);
+	pr_err("%s: pid %d not found in hash table\n",
+			__func__, pid);
+	return -EINVAL;
+}
+
+__u32 cn_hash_del_get_exval(struct cn_hash_dev *hdev, pid_t pid)
+{
+	struct uexit_pid_hnode *hnode;
+	struct hlist_node *tmp;
+	__u32 excde;
+
+	mutex_lock(&hdev->uexit_hash_lock);
+	hash_for_each_possible_safe(hdev->uexit_pid_htable,
+				hnode, tmp, uexit_pid_hlist, pid) {
+		if (hnode->pid == pid) {
+			excde = hnode->uexit_code;
+			hash_del(&hnode->uexit_pid_hlist);
+			mutex_unlock(&hdev->uexit_hash_lock);
+			kfree(hnode);
+			atomic_dec(&hdev->hrefcnt);
+			pr_debug("%s: After hash_del of pid %d, found exit code %u hrefcnt %d\n",
+					__func__, pid, excde,
+					atomic_read(&hdev->hrefcnt));
+			return excde;
+		}
+	}
+
+	mutex_unlock(&hdev->uexit_hash_lock);
+	pr_err("%s: pid %d not found in hash table\n",
+			__func__, pid);
+	return 0;
+}
+
+__u32 cn_hash_get_exval(struct cn_hash_dev *hdev, pid_t pid)
+{
+	struct uexit_pid_hnode *hnode;
+	__u32 excde;
+
+	mutex_lock(&hdev->uexit_hash_lock);
+	hash_for_each_possible(hdev->uexit_pid_htable,
+				hnode, uexit_pid_hlist, pid) {
+		if (hnode->pid == pid) {
+			excde = hnode->uexit_code;
+			mutex_unlock(&hdev->uexit_hash_lock);
+			pr_debug("%s: Found exit code %u for pid %d\n",
+					__func__, excde, pid);
+			return excde;
+		}
+	}
+
+	mutex_unlock(&hdev->uexit_hash_lock);
+	pr_debug("%s: pid %d not found in hash table\n",
+			__func__, pid);
+	return -EINVAL;
+}
+
+bool cn_hash_table_empty(struct cn_hash_dev *hdev)
+{
+	return hash_empty(hdev->uexit_pid_htable);
+}
diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index 44b19e696176..8c6e002069d9 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -69,6 +69,8 @@ static int cn_filter(struct sock *dsk, struct sk_buff *skb, void *data)
 	if ((__u32)val == PROC_EVENT_ALL)
 		return 0;
 
+	pr_debug("%s: val %lx, what %x\n", __func__, val, what);
+
 	/*
 	 * Drop packet if we have to report only non-zero exit status
 	 * (PROC_EVENT_NONZERO_EXIT) and exit status is 0
@@ -326,9 +328,16 @@ void proc_exit_connector(struct task_struct *task)
 	struct proc_event *ev;
 	struct task_struct *parent;
 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
+	__u32 uexit_code;
+	int err;
 
-	if (atomic_read(&proc_event_num_listeners) < 1)
+	if (atomic_read(&proc_event_num_listeners) < 1) {
+		if (likely(!(task->flags & PF_EXIT_NOTIFY)))
+			return;
+
+		err = cn_del_elem(task->pid);
 		return;
+	}
 
 	msg = buffer_to_cn_msg(buffer);
 	ev = (struct proc_event *)msg->data;
@@ -337,7 +346,26 @@ void proc_exit_connector(struct task_struct *task)
 	ev->what = PROC_EVENT_EXIT;
 	ev->event_data.exit.process_pid = task->pid;
 	ev->event_data.exit.process_tgid = task->tgid;
-	ev->event_data.exit.exit_code = task->exit_code;
+	if (unlikely(task->flags & PF_EXIT_NOTIFY)) {
+		task_lock(task);
+		task->flags &= ~PF_EXIT_NOTIFY;
+		task_unlock(task);
+
+		uexit_code = cn_del_get_exval(task->pid);
+		if (uexit_code == 0) {
+			pr_debug("%s: Returning with task's exit code %u\n",
+					__func__, task->exit_code);
+			ev->event_data.exit.exit_code = task->exit_code;
+		} else {
+			ev->event_data.exit.exit_code = uexit_code;
+			pr_debug("%s: Reset PF_EXIT_NOTIFY & retrieved exit code %u from hash table, pid %d\n",
+					__func__, task->pid,
+					ev->event_data.exit.exit_code);
+		}
+	} else {
+		ev->event_data.exit.exit_code = task->exit_code;
+	}
+
 	ev->event_data.exit.exit_signal = task->exit_signal;
 
 	rcu_read_lock();
@@ -413,6 +441,15 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
 	if (msg->len == sizeof(*pinput)) {
 		pinput = (struct proc_input *)msg->data;
 		mc_op = pinput->mcast_op;
+		if (mc_op == PROC_CN_MCAST_NOTIFY) {
+			pr_debug("%s: Received PROC_CN_MCAST_NOTIFY, pid %d\n",
+					__func__, current->pid);
+			task_lock(current);
+			current->flags |= PF_EXIT_NOTIFY;
+			task_unlock(current);
+			err = cn_add_elem(pinput->uexit_code, current->pid);
+			return;
+		}
 		ev_type = pinput->event_type;
 	} else if (msg->len == sizeof(mc_op)) {
 		mc_op = *((enum proc_cn_mcast_op *)msg->data);
@@ -432,6 +469,8 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
 			sk->sk_user_data = kzalloc(sizeof(struct proc_input),
 						   GFP_KERNEL);
 			if (sk->sk_user_data == NULL) {
+				pr_err("%s: ENOMEM for sk_user_data, pid %d\n",
+						__func__, current->pid);
 				err = ENOMEM;
 				goto out;
 			}
@@ -442,21 +481,33 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
 		}
 		((struct proc_input *)(sk->sk_user_data))->event_type =
 			ev_type;
+		pr_debug("%s: sk: %p pid: %d event_type: %x\n",
+				__func__, sk, current->pid, ev_type);
 		((struct proc_input *)(sk->sk_user_data))->mcast_op = mc_op;
 	}
 
 	switch (mc_op) {
 	case PROC_CN_MCAST_LISTEN:
-		if (initial || (prev_mc_op != PROC_CN_MCAST_LISTEN))
+		if (initial || (prev_mc_op != PROC_CN_MCAST_LISTEN)) {
 			atomic_inc(&proc_event_num_listeners);
+			pr_debug("%s: PROC_CN_MCAST_LISTEN pid %d: Incremented listeners to %d\n",
+					__func__, current->pid,
+					atomic_read(&proc_event_num_listeners));
+		}
 		break;
 	case PROC_CN_MCAST_IGNORE:
-		if (!initial && (prev_mc_op != PROC_CN_MCAST_IGNORE))
+		if (!initial && (prev_mc_op != PROC_CN_MCAST_IGNORE)) {
 			atomic_dec(&proc_event_num_listeners);
+			pr_debug("%s: PROC_CN_MCAST_IGNORE pid %d: Decremented listeners to %d\n",
+					__func__, current->pid,
+					atomic_read(&proc_event_num_listeners));
+		}
 		((struct proc_input *)(sk->sk_user_data))->event_type =
 			PROC_EVENT_NONE;
 		break;
 	default:
+		pr_warn("%s: Invalid value for mc_op %d\n",
+				__func__, mc_op);
 		err = EINVAL;
 		break;
 	}
diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
index 4028e8eeba82..506e3cbedf85 100644
--- a/drivers/connector/connector.c
+++ b/drivers/connector/connector.c
@@ -271,6 +271,67 @@ static int __maybe_unused cn_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+__u32 cn_del_get_exval(pid_t pid)
+{
+	struct cn_dev *dev = &cdev;
+	__u32 exval;
+
+	if (!cn_already_initialized)
+		return 0;
+
+	exval = cn_hash_del_get_exval(dev->hdev, pid);
+	return exval;
+}
+EXPORT_SYMBOL_GPL(cn_del_get_exval);
+
+int cn_del_elem(pid_t pid)
+{
+	struct cn_dev *dev = &cdev;
+	int ret;
+
+	if (!cn_already_initialized)
+		return 0;
+
+	ret = cn_hash_del_elem(dev->hdev, pid);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cn_del_elem);
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
+__u32 cn_get_exval(pid_t pid)
+{
+	struct cn_dev *dev = &cdev;
+	__u32 exval;
+
+	if (!cn_already_initialized)
+		return 0;
+
+	exval = cn_hash_get_exval(dev->hdev, pid);
+	return exval;
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
@@ -283,18 +344,35 @@ static int cn_init(void)
 	};
 
 	dev->nls = netlink_kernel_create(&init_net, NETLINK_CONNECTOR, &cfg);
-	if (!dev->nls)
+	if (!dev->nls) {
+		pr_err("%s: netlink_kernel_create failed, connector not initialized\n",
+				__func__);
 		return -EIO;
+	}
 
 	dev->cbdev = cn_queue_alloc_dev("cqueue", dev->nls);
 	if (!dev->cbdev) {
+		pr_err("%s: Allocation of dev->cbdev failed, connector not initialized\n",
+				__func__);
 		netlink_kernel_release(dev->nls);
 		return -EINVAL;
 	}
 
+	dev->hdev = cn_hash_alloc_dev("pid hash table");
+	if (!dev->hdev) {
+		pr_err("%s: Allocation of dev->hdev failed, connector not initialized\n",
+				__func__);
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
+				cn_proc_show);
 
 	return 0;
 }
@@ -308,6 +386,7 @@ static void cn_fini(void)
 	remove_proc_entry("connector", init_net.proc_net);
 
 	cn_queue_free_dev(dev->cbdev);
+	cn_hash_free_dev(dev->hdev);
 	netlink_kernel_release(dev->nls);
 }
 
diff --git a/include/linux/connector.h b/include/linux/connector.h
index 70bc1160f3d8..094e1730a4f6 100644
--- a/include/linux/connector.h
+++ b/include/linux/connector.h
@@ -18,6 +18,8 @@
 #include <uapi/linux/connector.h>
 
 #define CN_CBQ_NAMELEN		32
+#define HASHT_NAMELEN		32
+#define PID_HASH_TABLE_BITS	10
 
 struct cn_queue_dev {
 	atomic_t refcnt;
@@ -45,6 +47,19 @@ struct cn_callback_entry {
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
+	struct mutex uexit_hash_lock;
+	DECLARE_HASHTABLE(uexit_pid_htable, PID_HASH_TABLE_BITS);
+};
+
 struct cn_dev {
 	struct cb_id id;
 
@@ -52,6 +67,7 @@ struct cn_dev {
 	struct sock *nls;
 
 	struct cn_queue_dev *cbdev;
+	struct cn_hash_dev *hdev;
 };
 
 /**
@@ -137,4 +153,31 @@ void cn_queue_free_dev(struct cn_queue_dev *dev);
 
 int cn_cb_equal(const struct cb_id *, const struct cb_id *);
 
+struct cn_hash_dev *cn_hash_alloc_dev(const char *name);
+void cn_hash_free_dev(struct cn_hash_dev *hdev);
+struct uexit_pid_hnode *cn_hash_find_pid_node(struct cn_hash_dev *hdev,
+						pid_t pid);
+void cn_hash_free_elem(struct uexit_pid_hnode *elem);
+int cn_hash_add_elem(struct cn_hash_dev *hdev, __u32 uexit_code, pid_t pid);
+int cn_hash_del_elem(struct cn_hash_dev *hdev, pid_t pid);
+__u32 cn_hash_del_get_exval(struct cn_hash_dev *hdev, pid_t pid);
+
+int cn_add_elem(__u32 uexit_code, pid_t pid);
+int cn_del_elem(pid_t pid);
+__u32 cn_del_get_exval(pid_t pid);
+__u32 cn_get_exval(pid_t pid);
+
+struct cn_hash_dev *cn_hash_alloc_dev(const char *name);
+void cn_hash_free_dev(struct cn_hash_dev *hdev);
+struct uexit_pid_hnode *cn_hash_find_pid_node(struct cn_hash_dev *hdev,
+						pid_t pid);
+void cn_hash_free_elem(struct uexit_pid_hnode *elem);
+int cn_hash_add_elem(struct cn_hash_dev *hdev, __u32 uexit_code, pid_t pid);
+int cn_hash_del_elem(struct cn_hash_dev *hdev, pid_t pid);
+__u32 cn_hash_del_get_exval(struct cn_hash_dev *hdev, pid_t pid);
+__u32 cn_hash_get_exval(struct cn_hash_dev *hdev, pid_t pid);
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


