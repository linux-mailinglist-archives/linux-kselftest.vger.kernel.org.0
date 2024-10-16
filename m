Return-Path: <linux-kselftest+bounces-19888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5659A15A1
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 00:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F71D282873
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 22:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AE21D4359;
	Wed, 16 Oct 2024 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NGOzC5q7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640651D414E;
	Wed, 16 Oct 2024 22:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116453; cv=none; b=BB8B2MqA6YL5ZlpPif2joifvDkk3G/AEyUO2L5x6WRhhfoqUhh7FtYqerrl9ZEgt4Ty9Vys2p2PlrVIL2QXjcQ/6RFfAjuvEOebWUcvY7Bij7LQluHQESFtdLFB5f3ZnlmxGaKDQcnCsg3Z/Ft9suT5LSjZN1bFCbTInTmU9oJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116453; c=relaxed/simple;
	bh=zrq0vGZsZxspLRr7c+HGH9BuXVcwibjvq3d4l/eEPLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ViedsGP6OJAkBhFJZh/YF45ydWq2lIlRwxbCiw15GwpjWvmXftJEVm5+Trc2BY2bt/4MkT/6LQDoBFrEh610Lvbl6RgdhMmV3fjP8orXxi5Ves9v3VVDdFffm3NjKLQqURpZZDZVLZMntPgj6cmHYds8thYtMKc2/OTuXg9o5BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NGOzC5q7; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GKw1Nd006318;
	Wed, 16 Oct 2024 22:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=gAeGBhijC3d8lrClXUUFNa1qFYyIa
	uYJiN0HOEWD3dE=; b=NGOzC5q7hUwCYB9dsUqM2yYkRxH3scVAMAQezM9HzKHYH
	W4H9FpC84K9FKYVJEPOD8gB7HnrlO7xMERUN7gMDO3g0ZkhbHNqe9oCGt2pUzZdZ
	cGoxNE4WMNGHSIyQ/72nyUBeXp9HMORaSwbfHW14voJaeOmwiSN631ZbVfKmvCzi
	0qPgKgYvu9zwpmTNGBzGF2uQsCglD0Z9c75kmP6OP4mWKB1MJQF8GL1WwB3LAKrx
	bwyCRqtISr8OFcrGKuWVRGP/0AJygN06BehVDNyT59o7Kgb/AypJiT71A4h1q82V
	zh19dS+YG+6K7NbWNOS0I+VSElJufErnwaVZJ50kg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqt4yx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 22:06:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49GL3P9u010363;
	Wed, 16 Oct 2024 22:06:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjfrmbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 22:06:38 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49GM6bGs027856;
	Wed, 16 Oct 2024 22:06:37 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 427fjfrmap-1;
	Wed, 16 Oct 2024 22:06:37 +0000
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
Subject: [PATCH net-next v3 0/3] Threads support in proc connector
Date: Wed, 16 Oct 2024 15:06:31 -0700
Message-ID: <20241016220634.1469153-1-anjali.k.kulkarni@oracle.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_17,2024-10-16_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410160140
X-Proofpoint-GUID: i84hYQ6FhbhTjxLo0GDG6dJh_bALD3yc
X-Proofpoint-ORIG-GUID: i84hYQ6FhbhTjxLo0GDG6dJh_bALD3yc

Recently we committed a fix to allow processes to receive notifications for
non-zero exits via the process connector module. Commit is a4c9a56e6a2c.

However, for threads, when it does a pthread_exit(&exit_status) call, the
kernel is not aware of the exit status with which pthread_exit is called.
It is sent by child thread to the parent process, if it is waiting in
pthread_join(). Hence, for a thread exiting abnormally, kernel cannot
send notifications to any listening processes.

The exception to this is if the thread is sent a signal which it has not
handled, and dies along with it's process as a result; for eg. SIGSEGV or
SIGKILL. In this case, kernel is aware of the non-zero exit and sends a
notification for it.

For our use case, we cannot have parent wait in pthread_join, one of the
main reasons for this being that we do not want to track normal
pthread_exit(), which could be a very large number. We only want to be
notified of any abnormal exits. Hence, threads are created with
pthread_attr_t set to PTHREAD_CREATE_DETACHED.

To fix this problem, we add a new type PROC_CN_MCAST_NOTIFY to proc connector
API, which allows a thread to send it's exit status to kernel either when
it needs to call pthread_exit() with non-zero value to indicate some
error or from signal handler before pthread_exit().

We also need to filter packets with non-zero exit notifications futher
based on instances, which can be identified by task names. Hence, added a
comm field to the packet's struct proc_event, in which task->comm is
stored.

v2->v3 changes:
- Handled comment by Liam Howlett to set hdev to NULL and add comment on
  it
- Handled comment by Liam Howlett to combine functions for deleting+get
  and deleting into one.
- Handled comment by Liam Howlett to remove extern in the functions
  defined in cn_hash_test.h
- Some nits by Liam Howlett fixed.
- Made threads.c automated, by having an exit.log file created by
  proc_filter.c, which threads.c checks to see if the values reported
  for thread exits are correct. This was for a comment by Liam Howlett to
  make the tests automated.
- Added "comm" field to struct proc_event, to copy the task's name to
  the packet to allow further filtering by packets.
 
v1->v2 changes:
- Handled comment by Peter Zijlstra to remove locking for PF_EXIT_NOTIFY
  task->flags.
- Added error handling in thread.c

v->v1 changes:
- Handled comment by Simon Horman to remove unused err in cn_proc.c
- Handled comment by Simon Horman to make adata and key_display static
  in cn_hash_test.c

Anjali Kulkarni (3):
  connector/cn_proc: Add hash table for threads
  connector/cn_proc: Kunit tests for threads hash table
  connector/cn_proc: Selftest for threads

 drivers/connector/Makefile                    |   2 +-
 drivers/connector/cn_hash.c                   | 221 ++++++++++++++++++
 drivers/connector/cn_proc.c                   |  62 ++++-
 drivers/connector/connector.c                 |  75 +++++-
 include/linux/connector.h                     |  35 +++
 include/linux/sched.h                         |   2 +-
 include/uapi/linux/cn_proc.h                  |   5 +-
 lib/Kconfig.debug                             |  17 ++
 lib/Makefile                                  |   1 +
 lib/cn_hash_test.c                            | 167 +++++++++++++
 lib/cn_hash_test.h                            |  10 +
 tools/testing/selftests/connector/Makefile    |  23 +-
 .../testing/selftests/connector/proc_filter.c |  34 ++-
 tools/testing/selftests/connector/thread.c    | 202 ++++++++++++++++
 .../selftests/connector/thread_filter.c       |  96 ++++++++
 15 files changed, 937 insertions(+), 15 deletions(-)
 create mode 100644 drivers/connector/cn_hash.c
 create mode 100644 lib/cn_hash_test.c
 create mode 100644 lib/cn_hash_test.h
 create mode 100644 tools/testing/selftests/connector/thread.c
 create mode 100644 tools/testing/selftests/connector/thread_filter.c

-- 
2.46.0


