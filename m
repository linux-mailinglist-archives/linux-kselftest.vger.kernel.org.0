Return-Path: <linux-kselftest+bounces-19580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EB399AFB4
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 02:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26CB1F22F6D
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 00:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5CD8F49;
	Sat, 12 Oct 2024 00:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aj5BmZS9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4C423DE;
	Sat, 12 Oct 2024 00:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728693963; cv=none; b=MFwXnczXDjZJxf1e/9lrL5wAaTrL6eSmtcJwU1vFf/xApV8yROLpYKq1hd/cvovTENMJQHz55rgyhvAgqNbU4/F8j64knCxAbFXEPFXxTHTAEKLfJb/xyBrjq8EahccKK918B/01Bz+g55vU2L1oASnu09c3a31TtsgO+i6z20k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728693963; c=relaxed/simple;
	bh=03mdz6rSQN+mEWSNjENY0OvO4Dq+Ckf7oqc8W6cqYGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fIc78Hq5r4mAJd+g6G6eIXSQ5U8zcgmUZAFSfF9Z4Dkk3H3f6VfDu3m161EnjuC85Zk/r8rkDW25Tl2gJ9Km5WOl1z74PSqdkU+sX4deGTdkb/ZJkhfFFqLpUydQ0kU8LT9gQHo29jZxCzz5G+6nTWOjxlhepCSNetN6DadqYdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aj5BmZS9; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BKSd8x015032;
	Sat, 12 Oct 2024 00:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=401lJvQNKnrERdkGWRcfzv+ewoVPW
	VojqXT3wod/tBs=; b=aj5BmZS9io5t7TFNKoUUe2Pt73Dvcafob1cCqA/di1/W7
	goPPgI2G/3oyd32pFoW5uvAllUGsoANJbSPh+ltwWNks4zgIz8uJ9KvhVXDqnWw7
	8tfzyfOuEGZ5Q47l+viZmWbtQics0mxldl4FLuEXwd/gxeTgOEcrAkT0QG9zOzC0
	DMvkOBRPbkoN03Vv7TN7QfAteTSLC5yPDShztkQmN5EKNyEe4xOPQ9mJ1XfgBCbW
	LptYnHpTyKe9avYs/bDf3GlbIb1gw6F8PU6CxUKKZRm8iksUknen2B4eArBVGuAL
	2VUlnj3UyQq38GVZ+VLfhzHqHLCMBk+nqJwk0y4tg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42300e63ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Oct 2024 00:45:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49BNopYT005686;
	Sat, 12 Oct 2024 00:45:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwbvtbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Oct 2024 00:45:37 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49C0jbP1017077;
	Sat, 12 Oct 2024 00:45:37 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 422uwbvtat-1;
	Sat, 12 Oct 2024 00:45:36 +0000
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
Subject: [PATCH net-next 0/3] Threads support in proc connector
Date: Fri, 11 Oct 2024 17:45:29 -0700
Message-ID: <20241012004532.2071738-1-anjali.k.kulkarni@oracle.com>
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
 definitions=2024-10-11_21,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410120004
X-Proofpoint-GUID: JrgheWxh_3SGgveG80bDl79-3est8sU2
X-Proofpoint-ORIG-GUID: JrgheWxh_3SGgveG80bDl79-3est8sU2

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

Anjali Kulkarni (3):
  connector/cn_proc: Add hash table for threads
  connector/cn_proc: Kunit tests for threads hash table
  connector/cn_proc: Selftest for threads

 drivers/connector/Makefile                    |   2 +-
 drivers/connector/cn_hash.c                   | 240 ++++++++++++++++++
 drivers/connector/cn_proc.c                   |  59 ++++-
 drivers/connector/connector.c                 |  96 ++++++-
 include/linux/connector.h                     |  47 ++++
 include/linux/sched.h                         |   2 +-
 include/uapi/linux/cn_proc.h                  |   4 +-
 lib/Kconfig.debug                             |  17 ++
 lib/Makefile                                  |   1 +
 lib/cn_hash_test.c                            | 167 ++++++++++++
 lib/cn_hash_test.h                            |  12 +
 tools/testing/selftests/connector/Makefile    |  23 +-
 .../testing/selftests/connector/proc_filter.c |   5 +
 tools/testing/selftests/connector/thread.c    |  90 +++++++
 .../selftests/connector/thread_filter.c       |  93 +++++++
 15 files changed, 848 insertions(+), 10 deletions(-)
 create mode 100644 drivers/connector/cn_hash.c
 create mode 100644 lib/cn_hash_test.c
 create mode 100644 lib/cn_hash_test.h
 create mode 100644 tools/testing/selftests/connector/thread.c
 create mode 100644 tools/testing/selftests/connector/thread_filter.c

-- 
2.46.0


