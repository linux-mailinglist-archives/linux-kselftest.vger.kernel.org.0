Return-Path: <linux-kselftest+bounces-20486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711639AD00E
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 18:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9E4283421
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 16:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECFD1CF7A0;
	Wed, 23 Oct 2024 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cWf/+PiU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7911CEAD6;
	Wed, 23 Oct 2024 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700449; cv=none; b=M8A7Wb3gjkbwFJOQhBGbFV/a9K+Kwo5eSrdjmIHj6Xv14cfuyA63Xn2tlAw4xdT1CZxhYaFMwfdYBMo1ZsM3QklIscX3WUxkFhns6BhpBef7T1nS8aP0/rYTWyobphi+2G3swImvr0OHFI7YSwKZtbRlEkfIXhMGmwbNxcrjYpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700449; c=relaxed/simple;
	bh=Pn3rJmBLq1HGpNcrl+o3sbHFF1B6dvkI9lDvNfA6M0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tDYRer9jZAiYcspXIWZCv0QmUwa+b3Y+PgbxeEAs8V9DcaDDsv3+z5D4SOeFRXbTrwZAwDAe8m3JnxTorifT4Bw1bMa3VHcdmecQTe/M39GNvOX3Xc10ma3BTiXf/lTwDkriRUiRtaKEoysPNYQQ6iDjcqQUqXZkc/V6rD8HiJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cWf/+PiU; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfgcp026687;
	Wed, 23 Oct 2024 16:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=H9Zg5eI/Dt021rWIPx2FQaeuIAOFM
	/5+rL6MVlkWz2g=; b=cWf/+PiU0hBpaJdp2n1YAFBW+53HQwH05HrqTsx2Er9Gg
	ToRjjHA2iEz0YaMHkdD2i9l0z1RDgL2PAnFgIhZ6LAO0W1nJfnp4+ZXYkoBHDruA
	jqxcbHu0WZ9b7ESjJOadej3up6juTag01PfBwbymCaKiP2yNviPKmB1gZyUMpynl
	Xmlm3koC8J7AaZgtms+Q8UrqH4YyWPIm3YGdHJAbPIRbo/rbsC5/r6Ji20Y3k9LA
	EX35/3cHft6hiHqDNs67GjRIZO3Z1HzTugpoAiBzUEIVaZgi7kI0henCb7Yl7cRT
	IZVfpPQtTXlL7w0wI9vmdS63IQQtM/MxmCv9tqsZw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55egesd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:20:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFikaP025386;
	Wed, 23 Oct 2024 16:20:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh9r60r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:20:09 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49NGK806012043;
	Wed, 23 Oct 2024 16:20:08 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 42emh9r5x9-1;
	Wed, 23 Oct 2024 16:20:08 +0000
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
Subject: [PATCH net-next v6 0/3] Threads support in proc connector
Date: Wed, 23 Oct 2024 09:20:03 -0700
Message-ID: <20241023162006.1725309-1-anjali.k.kulkarni@oracle.com>
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
 definitions=2024-10-23_13,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=966 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230095
X-Proofpoint-ORIG-GUID: H_SQJyJHY3MEIhHQAjdQtvXUt8LmyYpS
X-Proofpoint-GUID: H_SQJyJHY3MEIhHQAjdQtvXUt8LmyYpS

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

v5->v6 changes:
- As suggested by Simon Horman, fixed style issues (some old) by running
  ./scripts/checkpatch.pl --strict --max-line-length=80
- Removed inline functions as suggested by Simon Horman
- Added "depends on" in Kconfig.debug as suggested by Stanislav Fomichev
- Removed warning while compilation with kernel space headers as
  suggested by Simon Horman
- Removed "comm" field, will send separate patch for this.
- Added kunit configs in tools/testing/kunit/configs/all_tests.config
  with it's dependencies.

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
 drivers/connector/cn_hash.c                   | 216 ++++++++++++++++
 drivers/connector/cn_proc.c                   |  81 ++++--
 drivers/connector/connector.c                 |  88 ++++++-
 include/linux/connector.h                     |  62 ++++-
 include/linux/sched.h                         |   2 +-
 include/uapi/linux/cn_proc.h                  |   4 +-
 lib/Kconfig.debug                             |  19 ++
 lib/Makefile                                  |   1 +
 lib/cn_hash_test.c                            | 169 +++++++++++++
 lib/cn_hash_test.h                            |  10 +
 tools/testing/kunit/configs/all_tests.config  |   5 +
 tools/testing/selftests/connector/Makefile    |  25 ++
 .../testing/selftests/connector/proc_filter.c |  63 +++--
 tools/testing/selftests/connector/thread.c    | 238 ++++++++++++++++++
 .../selftests/connector/thread_filter.c       |  96 +++++++
 16 files changed, 1027 insertions(+), 54 deletions(-)
 create mode 100644 drivers/connector/cn_hash.c
 create mode 100644 lib/cn_hash_test.c
 create mode 100644 lib/cn_hash_test.h
 create mode 100644 tools/testing/selftests/connector/thread.c
 create mode 100644 tools/testing/selftests/connector/thread_filter.c

-- 
2.46.0


