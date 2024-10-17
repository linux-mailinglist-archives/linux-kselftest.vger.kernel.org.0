Return-Path: <linux-kselftest+bounces-20017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B3E9A2C1A
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 20:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C626B21EA4
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 18:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C411E0E0B;
	Thu, 17 Oct 2024 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DY1D3kmF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C5B1E0DF2;
	Thu, 17 Oct 2024 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188905; cv=none; b=XuWbKySKNJz/E0sbXTgumrJGFysKH80KvlXevqi4YXn1O/hXuGA6j8PyIFqFMKb1B5zD8+Z47x+FJC7OuektZO1PXNfFX45Zj1BpyT4Ot7JpHKpQoqCx1xy+LOm8VFuiQM6VNd32v90X56vfgxAkdwMcVDP2myUsOO9NmpyuNYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188905; c=relaxed/simple;
	bh=kL6ufmsuF1LkuMi/JU1HenRVwYUJQLqcPqSWOhF5/Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iRdq37L6EElF8k5r6ssL6tFXGlMfKTmtTf8OH4aPHSLtJjMVxJqJTXA3BfumG/5JS2bN2/MLzLKwqh+tYlK2/6vixAuLCTj9mZ1LloPtqnvSfdd6L1PX2+kfVgwBpW2UlK2bOBX/bhpTDuCHUnz+Ps5Ur7Z1dbZMAIV7d3QUm44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DY1D3kmF; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBoAc019283;
	Thu, 17 Oct 2024 18:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=mjXp9PPRWcvNO+lk2JvrDJUVe9249
	DfZRO3UWKWLLwE=; b=DY1D3kmFyfv23UwlN75E0Hg0t1uK9EF1bLOiId8/uGRRn
	zdFnWIXpVj1pu+8e9A2w72FLEQJwbFpbKS88liqPuDg1EFzBFngLiRuSlrDOLki9
	jnRR3JQta79CbmA57hL9fOH3vWJTM9QCfxcWgeu4shCayCpyWXOKjmNN/zzjP6/x
	Yk+tj5Us4AUM5OIIB8M3fmKv8hYPFpkEICRj+qF9W5i1NpCa+IbUnZVDu3js/Oit
	sne+0RYqo3EqgEoGhRm5THjN7DFHWvfdIz/kEttuaBTTNzVo66feKmj4LKFfeTCK
	fDEV70OA/utVbcsp20VG1jGuWjtT6SQiYpTO5dEdQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5cqgnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 18:14:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HGl56I011131;
	Thu, 17 Oct 2024 18:14:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjgxkrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 18:14:40 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49HIA0bL039328;
	Thu, 17 Oct 2024 18:14:40 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 427fjgxkpk-1;
	Thu, 17 Oct 2024 18:14:40 +0000
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
Subject: [PATCH net-next v5 0/3] Threads support in proc connector
Date: Thu, 17 Oct 2024 11:14:33 -0700
Message-ID: <20241017181436.2047508-1-anjali.k.kulkarni@oracle.com>
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
 definitions=2024-10-17_20,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170124
X-Proofpoint-ORIG-GUID: _ZO5FwFOgnGDf2l_3REdYVL_a3UJ7Lf4
X-Proofpoint-GUID: _ZO5FwFOgnGDf2l_3REdYVL_a3UJ7Lf4

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

v4->v5 changes:
- Handled comment by Stanislav Fomichev to fix a print format error.
- Made thread.c completely automated by starting proc_filter program
  from within threads.c.
- Changed name CONFIG_CN_HASH_KUNIT_TEST to CN_HASH_KUNIT_TEST in
  Kconfig.debug and changed display text.
 
v3->v4 changes:
- Reduce size of exit.log by removing unnecessary text.

v2->v3 changes:
- Handled comment by Liam Howlett to set hdev to NULL and add comment on
  it.
- Handled comment by Liam Howlett to combine functions for deleting+get
  and deleting into one in cn_hash.c
- Handled comment by Liam Howlett to remove extern in the functions
  defined in cn_hash_test.h
- Some nits by Liam Howlett fixed.
- Handled comment by Liam Howlett to make threads test automated.
  proc_filter.c creates exit.log, which is read by thread.c and checks
  the values reported.
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
 drivers/connector/cn_hash.c                   | 221 +++++++++++++++++
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
 tools/testing/selftests/connector/thread.c    | 232 ++++++++++++++++++
 .../selftests/connector/thread_filter.c       |  96 ++++++++
 15 files changed, 967 insertions(+), 15 deletions(-)
 create mode 100644 drivers/connector/cn_hash.c
 create mode 100644 lib/cn_hash_test.c
 create mode 100644 lib/cn_hash_test.h
 create mode 100644 tools/testing/selftests/connector/thread.c
 create mode 100644 tools/testing/selftests/connector/thread_filter.c

-- 
2.46.0


