Return-Path: <linux-kselftest+bounces-23091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABB69E9F31
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 20:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569C8285DBA
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 19:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0F21AB6E9;
	Mon,  9 Dec 2024 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="B9vwEuMU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95AB1AAE08;
	Mon,  9 Dec 2024 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733771014; cv=none; b=eBow8sdEh/iVruOvaUWG8ZZy2etIp5IGzzs3kJ3cWfDDomfmAd8U/PQWtdvHrCvPx9c+5ZuKH7akp9+9GIXIcRshpdAjn0uKM3qY3BXVPJV6QHE1SlzlQgkexF1XVcwKxggwRyCjUwXQ/2KmnrYQC5KBtXj8lK/dLcnIFn5/Ebs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733771014; c=relaxed/simple;
	bh=rJWsvs4U0G6yXgAaGWcQ9pNuvEMrOusrUUu0b1tVjMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utBlWinQDlMdT5GyMXwYX7LdQmuWxdtde3oSTrhDRDkhKm/a4W6LnlsyO2mt/2Rptr4TYW30aEskKRln51if7TLSV3+Fqa1ImBbmcvNE0RHVCy75JYm8UXbsSg0tsxgR3JSAJj0saApZYynYo8ugCim6E/DGEWSmGkK1amDLnUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=B9vwEuMU; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TBV3K6DkdEwWEB8hQ4zHRU1jHPbyqEKzqoNldAknSUo=; b=B9vwEuMUxxGznjfGTin+lFv739
	5W3jBSfwKidqfwLONNFZ+X5Jl+PGIur5G8LKjLPKx+BJ/A5k70PkR2nCphXjCr6QhQvPH3hAi90qs
	VIjq48BWIYFN2FDchKRY2HNHM/+3nkANcWRKiV5fdWMfSbIAirj8opoewx0eRurgI41JmJ1KQY5oo
	2ibcmOI9it6BhU/m2vx5MOCaZLIsUXvoDPjsnhklxMZSFMR+aBiGSoggYllLqVm49curtuNh0ZULb
	HAHRMZW6ebs2vq5goSWhI4fSRu7KfsyBrh3HRYgaHwHkmF9NIWAqFZOmtzShXTiTqh9NFOxzdiiEk
	lwWfVTCg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tKiyc-001Gd5-2x;
	Mon, 09 Dec 2024 12:59:27 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	wine-devel@winehq.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [PATCH v6 16/28] selftests: ntsync: Add some tests for NTSYNC_IOC_WAIT_ANY.
Date: Mon,  9 Dec 2024 12:58:52 -0600
Message-ID: <20241209185904.507350-17-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241209185904.507350-1-zfigura@codeweavers.com>
References: <20241209185904.507350-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test basic synchronous functionality of NTSYNC_IOC_WAIT_ANY, when objects are
considered signaled or not signaled, and how they are affected by a successful
wait.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 .../testing/selftests/drivers/ntsync/ntsync.c | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/tools/testing/selftests/drivers/ntsync/ntsync.c b/tools/testing/selftests/drivers/ntsync/ntsync.c
index 7cd0f40594fd..40ad8cbd3138 100644
--- a/tools/testing/selftests/drivers/ntsync/ntsync.c
+++ b/tools/testing/selftests/drivers/ntsync/ntsync.c
@@ -342,4 +342,123 @@ TEST(mutex_state)
 	close(fd);
 }
 
+TEST(test_wait_any)
+{
+	int objs[NTSYNC_MAX_WAIT_COUNT + 1], fd, ret;
+	struct ntsync_mutex_args mutex_args = {0};
+	struct ntsync_sem_args sem_args = {0};
+	__u32 owner, index, count, i;
+	struct timespec timeout;
+
+	clock_gettime(CLOCK_MONOTONIC, &timeout);
+
+	fd = open("/dev/ntsync", O_CLOEXEC | O_RDONLY);
+	ASSERT_LE(0, fd);
+
+	sem_args.count = 2;
+	sem_args.max = 3;
+	sem_args.sem = 0xdeadbeef;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_SEM, &sem_args);
+	EXPECT_EQ(0, ret);
+	EXPECT_NE(0xdeadbeef, sem_args.sem);
+
+	mutex_args.owner = 0;
+	mutex_args.count = 0;
+	mutex_args.mutex = 0xdeadbeef;
+	ret = ioctl(fd, NTSYNC_IOC_CREATE_MUTEX, &mutex_args);
+	EXPECT_EQ(0, ret);
+	EXPECT_NE(0xdeadbeef, mutex_args.mutex);
+
+	objs[0] = sem_args.sem;
+	objs[1] = mutex_args.mutex;
+
+	ret = wait_any(fd, 2, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_sem_state(sem_args.sem, 1, 3);
+	check_mutex_state(mutex_args.mutex, 0, 0);
+
+	ret = wait_any(fd, 2, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_sem_state(sem_args.sem, 0, 3);
+	check_mutex_state(mutex_args.mutex, 0, 0);
+
+	ret = wait_any(fd, 2, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(1, index);
+	check_sem_state(sem_args.sem, 0, 3);
+	check_mutex_state(mutex_args.mutex, 1, 123);
+
+	count = 1;
+	ret = post_sem(sem_args.sem, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, count);
+
+	ret = wait_any(fd, 2, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_sem_state(sem_args.sem, 0, 3);
+	check_mutex_state(mutex_args.mutex, 1, 123);
+
+	ret = wait_any(fd, 2, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(1, index);
+	check_sem_state(sem_args.sem, 0, 3);
+	check_mutex_state(mutex_args.mutex, 2, 123);
+
+	ret = wait_any(fd, 2, objs, 456, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(ETIMEDOUT, errno);
+
+	owner = 123;
+	ret = ioctl(mutex_args.mutex, NTSYNC_IOC_MUTEX_KILL, &owner);
+	EXPECT_EQ(0, ret);
+
+	ret = wait_any(fd, 2, objs, 456, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EOWNERDEAD, errno);
+	EXPECT_EQ(1, index);
+
+	ret = wait_any(fd, 2, objs, 456, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(1, index);
+
+	/* test waiting on the same object twice */
+	count = 2;
+	ret = post_sem(sem_args.sem, &count);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, count);
+
+	objs[0] = objs[1] = sem_args.sem;
+	ret = wait_any(fd, 2, objs, 456, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+	check_sem_state(sem_args.sem, 1, 3);
+
+	ret = wait_any(fd, 0, NULL, 456, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(ETIMEDOUT, errno);
+
+	for (i = 0; i < NTSYNC_MAX_WAIT_COUNT + 1; ++i)
+		objs[i] = sem_args.sem;
+
+	ret = wait_any(fd, NTSYNC_MAX_WAIT_COUNT, objs, 123, &index);
+	EXPECT_EQ(0, ret);
+	EXPECT_EQ(0, index);
+
+	ret = wait_any(fd, NTSYNC_MAX_WAIT_COUNT + 1, objs, 123, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EINVAL, errno);
+
+	ret = wait_any(fd, -1, objs, 123, &index);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EINVAL, errno);
+
+	close(sem_args.sem);
+	close(mutex_args.mutex);
+
+	close(fd);
+}
+
 TEST_HARNESS_MAIN
-- 
2.45.2


