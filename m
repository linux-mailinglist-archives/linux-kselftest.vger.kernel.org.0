Return-Path: <linux-kselftest+bounces-19615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBCA99BA76
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Oct 2024 19:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEA311C20941
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Oct 2024 17:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55DD146D6D;
	Sun, 13 Oct 2024 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N0ALa1Ls"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F089536B;
	Sun, 13 Oct 2024 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728839213; cv=none; b=foBG1knrSQ82sXW0JgeEL8JstSPVHBzazXFGA00CABy61t4wbe9okPt77wudVGmSwP7LsDm9bISWHYVBgFooeZQTgRlZHiR8jQOnlNSr/vHltRsJ31U4lOx8VgknkvyBFNgX4Lsk+mD0YirqH4njhxXlATYmUCiMyTdLu3zoK24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728839213; c=relaxed/simple;
	bh=+qTTH9WwKhkJxWQhdUQYDlDyMYnH13Tjd8rXH14GlrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qVh7V996BeznJSQLU3nnpYaCGJC2Bhyuj3ymZ+VGUPrunTqhvyzGq/qhPKXS4xhr1Co4Y9yiuHxEQWGDNAJgiL+t6mne5Y+qdzi+IV7RNu4+sM8UKgOWBnLVXToUaZ983eSc9DjdFp4llO7M9ym+9PMhnZI9IuDqGCJND7V13NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N0ALa1Ls; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49DDe2Ld003359;
	Sun, 13 Oct 2024 17:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=g11p69EKpHhaO3Quxl2+vQ9MoZTek
	uWlxC1kOJkak/4=; b=N0ALa1Lsk5CBKFzCMBb4GpUSECDy2QUmWxDJZxsSdbAhF
	ILvsOGPABQmHItRIeHPZZxWjop6JbjTc3F/X9RrBieuohs+n7/RavL0FCkSu6gVE
	nzySUfOtEkT9oy/D2IRAxSAuOMPnEpCXUfensWDAo8CEAvR0VM3xIildHHS8GUmC
	DjvgDAhhA8QnIRRJYbRfpP2UZfdSf7JSDzTnEu95AI2dI4c60KUlmSQX3vWHs3Im
	4smkxHA+jQDUzQkHxF0VDzEo24yFodsJVEMSCHf4kEHzUUhQ4J+E3xNNODBDOruW
	2bExddFciUO9l+oOnfwFiMhwivgf4V/Ogm1fDng7A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5c9b90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 13 Oct 2024 17:06:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49DH1VIS026314;
	Sun, 13 Oct 2024 17:06:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj561cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 13 Oct 2024 17:06:22 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49DH6MF8040166;
	Sun, 13 Oct 2024 17:06:22 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 427fj561c0-1;
	Sun, 13 Oct 2024 17:06:22 +0000
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
Subject: [PATCH net-next v1 0/3] Threads support in proc connector
Date: Sun, 13 Oct 2024 10:06:14 -0700
Message-ID: <20241013170617.2139204-1-anjali.k.kulkarni@oracle.com>
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
 definitions=2024-10-13_11,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410130128
X-Proofpoint-ORIG-GUID: npsd6StReTnSDcXr_U6zUq66I1w-iQa7
X-Proofpoint-GUID: npsd6StReTnSDcXr_U6zUq66I1w-iQa7

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

v->v1 changes:
- Handled comment by Simon Horman to remove unused err in cn_proc.c
- Handled comment by Simon Horman to make adata and key_display static
  in cn_hash_test.c

Anjali Kulkarni (3):
  connector/cn_proc: Add hash table for threads
  connector/cn_proc: Kunit tests for threads hash table
  connector/cn_proc: Selftest for threads

 drivers/connector/Makefile                    |   2 +-
 drivers/connector/cn_hash.c                   | 240 ++++++++++++++++++
 drivers/connector/cn_proc.c                   |  58 ++++-
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
 15 files changed, 847 insertions(+), 10 deletions(-)
 create mode 100644 drivers/connector/cn_hash.c
 create mode 100644 lib/cn_hash_test.c
 create mode 100644 lib/cn_hash_test.h
 create mode 100644 tools/testing/selftests/connector/thread.c
 create mode 100644 tools/testing/selftests/connector/thread_filter.c

-- 
2.46.0


