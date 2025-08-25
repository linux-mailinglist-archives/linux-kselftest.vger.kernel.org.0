Return-Path: <linux-kselftest+bounces-39840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FFEB344CC
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 16:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 169E97A92BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 14:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AAF2FE07E;
	Mon, 25 Aug 2025 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JFh7CXIU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986892FDC5A
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133876; cv=none; b=cYCIETM93Vfhhwhj7ASITCXp12Bf0tTjUhzp287O0H6rK1C7B0KNI1gsQ7eZ8KKLWRf4kksykOS7v9Rw8PJMYTeOlxpFYIq9EVdqCrUGKc59Oq2B4i5z6d4rWVLcQpZqWXHTPHFkFE9JaKSVrNkVv16ERlKTgajMqYsnvCaW3HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133876; c=relaxed/simple;
	bh=dMbxmq897CRXL+9wK5op3TWg0dnVjEE/JIek66Xyqvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BLp0AZv1YOt4HF5+++NqWSq7X+cbdczwDI6HQjpiHSdJSq5OsJ9CuE0DPeGfFOQJLDHh1tzkIIjXGinw8A7FkoKNXRRvcKJeRfzEQHHVhMwwPDCLphM5WVd7DDxuryNZYlRPwLTQXBvQLUPCtzRga62QlD2KofL7C9b5eb7xSqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JFh7CXIU; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-770305d333aso2741568b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 07:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133873; x=1756738673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frobiiF+V7JXOVqxsCpLilnhoxfx3g4fKn8gApXFwiY=;
        b=JFh7CXIUbY8pui0NTsgTwytFbIbm4tAWV3790iBfEzgX/TU1fwgocgwl3QOg+xF3ZR
         CAEIhXq81MPbJC24oLO0XA+pmvx727dOpluFx1fFjyf6PrGJV5/DCcjtzK0FPmT38aqh
         NA83lX07wY4F+M//i3nBqOsk/xVyb2eYlDtXiAgcCjJQT9hXMWq1CbA41d62GoyBqqCY
         0dJw5OrBVauUWQR01VYiTvIrnzj28ctCzDN5xCA79yr+kG+bF8Zn4t08r9L0F6LDqKgM
         7IYNXrfb3b6ZbLrhWLSZcQP/mEiBQwunlVb+qDkdf5IxfcokW90A7UIa9jqLx1X8tpUB
         Ravw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133873; x=1756738673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frobiiF+V7JXOVqxsCpLilnhoxfx3g4fKn8gApXFwiY=;
        b=VENcL32NCN/F17j9Ba82N9uuMU8W5urA3+pSF6tH8IsMnDToKQHbDJNtdsa/LLzjiV
         VW8oymUVSEL10NUebX8m+7LBqZHFZjmz/o2OJqaZZHRf4+C1yX2SSsJ9Lbmzz4MmWMZe
         em9tENoYiwT8+vZdDm326TD6BOaUCgawh+TCW2HXhNhvh7RqvCSfaESV8vkXw9aZ1kRQ
         SvIDM0VEFnFplUUU1UDQEhqaNdvsTdP0S8Ny7kThwTyH0fGL5SyWsLQwLOdJVsZqFxza
         1CSMrPThoclvQtd9+K5ASsHao3XhiY+rwQmZ8gM8xwEAI8FXmdNGt27PmNeoeKoU9nAX
         2hBg==
X-Forwarded-Encrypted: i=1; AJvYcCX+91A1iv2SAUM8aVJphqJ3l9ZPFJ20vz89JMupJovaJmAIHsPz+slr+ouhWcTKMmh3wyBmPoXLhi9MkZOwyQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyukMh5JTpOoiq80SXpOerWhc0tqEpHhNAff3kwlee8SdaBnbhq
	kgqMlAEPr6XyBBWPfI7gWxf0GH1AQg2kXIpotWWQdTTlI5HdP76CIsbIZTDWSmcPsno=
X-Gm-Gg: ASbGncu6QZC+sW6ZxYjDMcWN5r/MzAuqejfVlvPOOHU4qyGsQ6pLHK15nZiYRAFzqN/
	Ks4Iku3rG7nA0GycuhB4sBs6Zyh0OThw15Fwp5DwlMbrURatsNeEmyOEb4lzvQLuWLl9SFu7VQO
	HNxFLzG2Z0r7HZn9SgJxgzKaQ/GnR7yiQCsE9YW7Q+YxPolgxF4dhp07n9SFRjxr5zPVG385Iai
	X3QwhHY/soaEBi9zBdmhehkuKna6P6SWbsN8geADNPkO4cMNHihuboWCDVpv06czzMYNnNMiu+P
	nQxvAT+7r7bbYC/zXyWS4QE75Ev6oZTix9NKk36ZW7TB/LQBkQ4341QhA3Lt16TpRLudUufrZ4y
	pvTjCcCZZrAZUo9WhWzyivLa731gbikdrq4MZXQ/fDBmMqbFHqtwYTFE80+DcVCOvS9+xU2k=
X-Google-Smtp-Source: AGHT+IFN3XgZGUydfFw4/mbd3YmT+QXstnE6CrDDlxBYxDb55CdCB22fpDRPMIk2g4/sSsJBoMDeZg==
X-Received: by 2002:a05:6a20:734c:b0:240:1ad8:1821 with SMTP id adf61e73a8af0-24340b5e298mr17551742637.19.1756133872732;
        Mon, 25 Aug 2025 07:57:52 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.57.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:57:52 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org,
	linyongting@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: [PATCH 6/8] mshare: selftests: Add some helper functions for reading and controlling cgroup
Date: Mon, 25 Aug 2025 22:57:09 +0800
Message-Id: <20250825145719.29455-7-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250825145719.29455-1-linyongting@bytedance.com>
References: <20250825145719.29455-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before verify some complicated memory functionalities such as swap memory
and THP, we need add some helper functions to controlling the cgroup
(specifically, memcg).

These helper functions consist:
  Create and destroy individual cgroup for test cases
  attach and dettach the test process to specified cgroup
  Read swap size and thp size from testing cgroup

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/util.c | 128 ++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/tools/testing/selftests/mshare/util.c b/tools/testing/selftests/mshare/util.c
index 75f6ff25aa2c..94fddaea2c56 100644
--- a/tools/testing/selftests/mshare/util.c
+++ b/tools/testing/selftests/mshare/util.c
@@ -121,3 +121,131 @@ int mshare_ioctl_munmap(int fd, size_t size)
 
 	return ioctl(fd, MSHAREFS_UNMAP, &munmap);
 }
+
+/*
+ * Helper functions for cgroup
+ */
+
+#define CGROUP_BASE "/sys/fs/cgroup/"
+#define CGROUP_TEST "mshare-test-XXXXXX"
+
+bool is_cgroup_v2;
+
+__attribute__((constructor))
+void get_cgroup_version(void)
+{
+	if (access(CGROUP_BASE "cgroup.controllers", F_OK) == 0)
+		is_cgroup_v2 = true;
+}
+
+int create_mshare_test_cgroup(char *cgroup, size_t len)
+{
+	if (is_cgroup_v2)
+		snprintf(cgroup, len, "%s/%s", CGROUP_BASE, CGROUP_TEST);
+	else
+		snprintf(cgroup, len, "%s/memory/%s", CGROUP_BASE, CGROUP_TEST);
+
+	char *path = mkdtemp(cgroup);
+
+	if (!path) {
+		perror("mkdtemp");
+		return -1;
+	}
+
+	return 0;
+}
+
+int remove_cgroup(char *cgroup)
+{
+	return rmdir(cgroup);
+}
+
+int write_data_to_cgroup(char *cgroup, char *file, char *data)
+{
+	char filename[128];
+	int fd;
+	int ret;
+
+	snprintf(filename, sizeof(filename), "%s/%s", cgroup, file);
+	fd = open(filename, O_RDWR);
+
+	if (fd == -1)
+		return -1;
+
+	ret = write(fd, data, strlen(data));
+	close(fd);
+
+	return ret;
+}
+
+int attach_to_cgroup(char *cgroup)
+{
+	char pid_str[32];
+
+	snprintf(pid_str, sizeof(pid_str), "%d", getpid());
+	return write_data_to_cgroup(cgroup, "cgroup.procs", pid_str);
+}
+
+/*
+ * Simplely, just move the pid to root memcg as avoid
+ * complicated consideration.
+ */
+int dettach_from_cgroup(char *cgroup)
+{
+	char pid_str[32];
+	char *root_memcg;
+
+	if (is_cgroup_v2)
+		root_memcg = CGROUP_BASE;
+	else
+		root_memcg = CGROUP_BASE "memory";
+
+	snprintf(pid_str, sizeof(pid_str), "%d", getpid());
+	return write_data_to_cgroup(root_memcg, "cgroup.procs", pid_str);
+}
+
+size_t read_data_from_cgroup(char *cgroup, char *file, char *field)
+{
+	char filename[128];
+	FILE *fp;
+	char line[80];
+	size_t size = -1;
+
+	snprintf(filename, sizeof(filename), "%s/%s", cgroup, file);
+	fp = fopen(filename, "r");
+	if (!fp) {
+		perror("fopen");
+		return -1;
+	}
+
+	while (fgets(line, sizeof(line), fp)) {
+		if (!strncmp(line, field, strlen(field))) {
+			char *value = line + strlen(field) + 1;
+
+			size = atol(value);
+			break;
+		}
+	}
+
+	fclose(fp);
+
+	return size;
+}
+
+size_t read_swap_from_cgroup(char *cgroup)
+{
+	if (is_cgroup_v2)
+		return read_data_from_cgroup(cgroup, "memory.stat", "pswpout");
+	else
+		return read_data_from_cgroup(cgroup, "memory.stat", "swap");
+}
+
+size_t read_huge_from_cgroup(char *cgroup)
+{
+	if (is_cgroup_v2)
+		return read_data_from_cgroup(cgroup, "memory.stat", "file_thp")
+		     + read_data_from_cgroup(cgroup, "memory.stat", "anon_thp")
+		     + read_data_from_cgroup(cgroup, "memory.stat", "shmem_thp");
+	else
+		return read_data_from_cgroup(cgroup, "memory.stat", "rss_huge");
+}
-- 
2.20.1


