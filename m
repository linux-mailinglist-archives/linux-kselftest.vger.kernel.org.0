Return-Path: <linux-kselftest+bounces-18149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C985497CF8B
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 02:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906AA28637F
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 00:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6362CA2;
	Fri, 20 Sep 2024 00:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X30gUhDn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5636D26AE4;
	Fri, 20 Sep 2024 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726791022; cv=none; b=mOamqmsjNkEL7h2fPwByzGRadMN5Pq9N6UZU+EzTxfm2kZQCDP9yI/3vbc0fT0CtOZW6FDfGIskXYRmo0DNuLih3enj8N8v2sr7sORjo+NLTyN6c1yWP38KSn1qQgc0Isv0pKtN9q2MaQSZNavTFDvj4D6iUYzZcz0Vo/J+6jys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726791022; c=relaxed/simple;
	bh=b7RiFL+EwsKBzpMbYQki80g6DULAZDbVwFsuh7o7zNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AT1jRAIYn47oTkd7Kd2WcQVnsBFlw+nk2MY5ijUyuDpG5VJgubrOx7/4QAEf07GVt9+adsf0MjKsreOtPglICeQJM8DxSi5W7e2LzyYx0+ILijWtWBRuj7Aefo8yVTOeO4rOio0mC4EL0o4wX72Xz8uX1gAdQplFDY7wqlJqd40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X30gUhDn; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JLMWHK026268;
	Fri, 20 Sep 2024 00:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=RC5Ywg5HZDddIw
	iL3OFiNiH6QOj3x6OUEL1SQkFbZAs=; b=X30gUhDnNjkmodF0ChbFWz3g/YB/MV
	t7mA1jYBzOVfPrlyLczv9q7JU8g+6Xj3WBemlks3yIWI7bW6s8t4jiLu0yY25pUQ
	Qz/490rtmZTjK9Au1NdcHwnrxex7HBIVomHMjWGRiQ7Davwax4c2Q8/R1lEFz1Ge
	adfkrtoWQzYZN+yUmvUv+7gXseCkFyWDNultE11kX4HCyiFbYLVj920lEKdqZbk7
	tAAaYpK5LAWcMSfruA+H8PsDKJ81tX38KGGlWEXse39rEtqXKxbshk0jf/ev8Ylx
	0CSprXpkCtZjHkVK2bBE3d44//xv0M1tLuPjB67ZENNSniFwT2ugpUag==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3nfweq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 00:09:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48JMUiMX017868;
	Fri, 20 Sep 2024 00:09:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nyd17egm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 00:09:36 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48K09ZKB022155;
	Fri, 20 Sep 2024 00:09:35 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41nyd17egc-1;
	Fri, 20 Sep 2024 00:09:35 +0000
From: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To: davem@davemloft.net, Liam.Howlett@Oracle.com
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, oleg@redhat.com,
        akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org,
        mhocko@suse.com, alexjlzheng@tencent.com, willy@infradead.org,
        michael.christie@oracle.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, anjali.k.kulkarni@oracle.com,
        peili.io@oracle.com
Subject: [PATCH net-next 0/2] Threads extension for process connector
Date: Thu, 19 Sep 2024 17:09:31 -0700
Message-ID: <20240920000933.185090-1-anjali.k.kulkarni@oracle.com>
X-Mailer: git-send-email 2.45.2
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
X-Proofpoint-GUID: 42kDqGbW0JiOS-AXbnXX27K0RTCHFbiE
X-Proofpoint-ORIG-GUID: 42kDqGbW0JiOS-AXbnXX27K0RTCHFbiE

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

Anjali Kulkarni (2):
  connector/cn_proc: Handle threads for proc connector
  connector/cn_proc: Selftest for threads case

 drivers/connector/cn_proc.c                   | 11 ++-
 include/linux/cn_proc.h                       |  5 +-
 include/uapi/linux/cn_proc.h                  |  4 +-
 kernel/exit.c                                 |  5 +-
 tools/testing/selftests/connector/Makefile    | 23 ++++-
 .../testing/selftests/connector/proc_filter.c |  5 +
 tools/testing/selftests/connector/thread.c    | 87 +++++++++++++++++
 .../selftests/connector/thread_filter.c       | 93 +++++++++++++++++++
 8 files changed, 226 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/connector/thread.c
 create mode 100644 tools/testing/selftests/connector/thread_filter.c

-- 
2.45.2


