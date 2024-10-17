Return-Path: <linux-kselftest+bounces-19899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 826CA9A171C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 02:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04AE51F26133
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 00:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823A1C139;
	Thu, 17 Oct 2024 00:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c04r7fEf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B937814F98;
	Thu, 17 Oct 2024 00:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124864; cv=none; b=BaXs8OPGxhGLyWaaPdhKqPIxpMh8Yq35/YgTG/89pGkFtuCpj6pJJfxoHH8QDCHOHDtrovPy426xGA6yf4zA3r5KeFezgFI9bvHYO1r5vAnc8BpgpB4xyH2HqH8pAceD+Y+Yer0fDe9PTonOIcRoaMTqZJas7OfTvbYupeoB9c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124864; c=relaxed/simple;
	bh=7aMdOaVKt3zUrLgkHFQERTjmkDTm/+ILFnx/LuPYj8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SVW680AKN4oT9Nh5htHTt75KMnampOTlAN6nzxgh4gdj06VEMgrJIGCVywzGNn+FdXTbrMZ07yjZC7+mESjVOox+gcgihzxcBkyUysVQXHFcXzLvrbnHCODgz4ZZAWRc7kG+DbazomuciYH4O51IrdgmM0m4ySZL6qKAf7W165E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c04r7fEf; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GKthjI001239;
	Thu, 17 Oct 2024 00:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=1POkC200/ke2im258VNhPla1zXqrb
	+D628vnHkCzD8c=; b=c04r7fEfFBguOD8L1+GFi+scpEmheSeszNrEvC9nNdBZc
	1E3W7xVdI/FlVj912tU5gKHEdjlBg+xNsHX/sjeNjL79UPIlOWdcnHhpLr96PVos
	guaPGJhksZcyKbV+Ysl91g4ipMJDzNB7/Biw53EtdtapMqVzxfM7Nrzuah40bZXT
	zFkvWGN0hNBUKVcRwEFF4C+NOV4ybuS+qLWOjhdgq5XmetCXUz2buoalD413lBjg
	k/lh+GFZeCLxauuf3appV0CbHYuiqYdeWi1BfJc8FBkfOZ2U4XkFuQU/ftXRnOns
	sxN1ImTVp3F5O/WIu+268+3hKC0xNHEtrJ/WwDeAQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h09mknc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 00:26:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49GNedJo027269;
	Thu, 17 Oct 2024 00:26:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjg433w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 00:26:56 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49H0QtHW013579;
	Thu, 17 Oct 2024 00:26:55 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 427fjg4337-1;
	Thu, 17 Oct 2024 00:26:55 +0000
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
Subject: [PATCH net-next v4 0/3] Threads support in proc connector
Date: Wed, 16 Oct 2024 17:26:49 -0700
Message-ID: <20241017002652.1474358-1-anjali.k.kulkarni@oracle.com>
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
 definitions=2024-10-16_18,2024-10-16_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170001
X-Proofpoint-GUID: featopHk-On2DiJrxrzlQ0Y6HcHfx9ip
X-Proofpoint-ORIG-GUID: featopHk-On2DiJrxrzlQ0Y6HcHfx9ip

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

v3->v4 changes:
- Reduce size of exit.log by removing unnecessary text.

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


