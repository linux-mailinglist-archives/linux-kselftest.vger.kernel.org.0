Return-Path: <linux-kselftest+bounces-39848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BDEB344F0
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 17:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E18172EF0
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Aug 2025 15:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D2C302749;
	Mon, 25 Aug 2025 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gdTzak8L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5E1302CC2
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133905; cv=none; b=nCf93TEOj9fWwzEAeXAEJLdUbJ2ZTZhiD6DYhuu/NHzHHhhQpnI3zqWUjC1QZEUUiikZP3jc9GeIsghApgnz8BWbIo69YJnVQvbLe31NinlJTWb8aiwl6D9dB/YK7GQ434/axeUe/AyLEgkU4eu9t/aldhmaDxh+c1xSfbqXffY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133905; c=relaxed/simple;
	bh=dMbxmq897CRXL+9wK5op3TWg0dnVjEE/JIek66Xyqvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P0ZHng1Q61fasImpX8ETy6yQSgSv7eHDnpMqO0D+MiEDhK8ce1wNjFMtpMU1NYyG9W9NUh3IeczeImKyhh1Ml03F0ob21ZlDdINpjtzQBfAdlbPbfd2eNy/b1+/34VVkEpUZdAeAS+kjksj4/2SwHX5D1134mp/ojVlujdI4fPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gdTzak8L; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-770530175a6so906792b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Aug 2025 07:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133904; x=1756738704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frobiiF+V7JXOVqxsCpLilnhoxfx3g4fKn8gApXFwiY=;
        b=gdTzak8L5/5zYLHB7l3xmmQnZLq5/R3UrnP8rtHV74KHAi4DdiYYwQT6Tfa67rBBsn
         wyFZGnbQgXNoCsiMaYEUYPZkOl79bLv2W0ED8euDrZi3Fhppr062iHn02an5oRVDmglX
         nPZPnGOkkXrJAfWcHSPnOI9skhkyzE8bYZOLB/E7ih0CpbqRftb7xs3AxcqmQUR00PbI
         2tZ5Fgkt8izBo3T5XYpKmNUTSsxOik1rVbuimclCvkLWFLyJRQDcMW2kBEWpaOgG9bPq
         t5zVxVxbjdOrosGMXRymoBB1rjAAQd6SnUE/8G8gnpJwlgE7rVLjcNoHgyXN5DRZTIj7
         7F1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133904; x=1756738704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frobiiF+V7JXOVqxsCpLilnhoxfx3g4fKn8gApXFwiY=;
        b=eEo/vYS4X1/RKyuVYSeIawD8oZ3yeMxoYlHd0UI+9kCVhSbmJAxK7Nla5UfR8Q/BcS
         9X0w3HaQHQ4htjYrBKQCND90lpN9vxshPwF0Aq/BhXpm4SjbAZyDQyPT80YpUfaXeA+b
         Er2em6TwZzIplMFKIcve0ZiX/Uz9BhCNmNtgKU83I63jFsMUVlTqyAS0H6nIgs61tudl
         TVozYf8FH7iiKFZVopDgjlW5jOlU4sDmmEdUMAXu4fsb+9QNkLIzVQkkRvgO2btftA+y
         GoS2q9YUwvUo8oBEBH2SrCt0CYrFbbKWAkPJ0uo2KtAGWWQb68S5otPA4G8Cl80Vqpl7
         SZwA==
X-Forwarded-Encrypted: i=1; AJvYcCVS06LvkKzklKOh5KPGvlCb+9t1pfGU2cZCX8rXe7ASsm6OUKHa4if8N0OiUnwwCm3LnHywwcI6yZ7RQo2AqFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYb7iY4oA48xCVbUaVNGaVICwiP0l5cIi4XnaPoEtadgiuJsh7
	GDO4hGT3JWCtf3ervzQCv9iYje0vWkHAmh0YKZY+YYpghUL0zUa8MRGESnE1UUA6HLQ=
X-Gm-Gg: ASbGncsVBMmjoC2fAqy2oHqdASUYKgI2CKPvO2rLsnsYWAHbHFjRMOsgf+R+Jj92cFh
	/6toKQtsKaXU83RGZIn7B119Al/ZseCK8Jx0RiSQW6lndHR5jwaQveAoo7Jhlbk0snjgUGe8dxo
	D3L0ax2XSYr2yr/BYsnAfso7wFMJoRdrOPVsoJ1uG9c7dDqReb34PFIkg6xjiGgp2OEW4U4WbOt
	xXGaKQjNK8RNy4Z9zCrj/bBwHxdZvEDL56s0hcint/tAPTRlwdt340T+QKWzmKlAeABn6sM2pRc
	4P/LFEw00oqROp3Cq3KxNATcvze5ahXtX3GRm4VMuRUoIybkc/i+6DCu8iOAvcEQif4J1JcwWcY
	RaeWJNHjG1PPHJGsocf+gKYuhoUDv5Ixw3vqQ1AlnXRVt9jtGPogpUGssh72k
X-Google-Smtp-Source: AGHT+IG7Oofc5Cp5x58qIccTW/mt1D9LGI3RCFnvY/URUYZhtnINl3UlS8zIeItcw+B6/b2CMeUqrg==
X-Received: by 2002:a05:6a20:3942:b0:240:d14:c7e3 with SMTP id adf61e73a8af0-24340c1475emr19568752637.24.1756133903397;
        Mon, 25 Aug 2025 07:58:23 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.58.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:58:23 -0700 (PDT)
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
Date: Mon, 25 Aug 2025 22:57:17 +0800
Message-Id: <20250825145719.29455-15-linyongting@bytedance.com>
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


