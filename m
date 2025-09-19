Return-Path: <linux-kselftest+bounces-41951-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A3EB899AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 15:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770E25A4E97
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 13:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6D93093B2;
	Fri, 19 Sep 2025 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AUS08XtA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009043112DE
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287212; cv=none; b=BYom7hhLAjsZPvgvIxspdni72spbvviOGjvpgZvAkkO5xMhqDlf50JkFsbLEGRTElngUs8b41+5LHWd0plH1uwbKOsaFqkXV8j2gTac82ZFXoF9A5WHrK5BJ37tfld6gsCWDbvOMPihEKVILKyu2042Ar8Eymr924kgPaMyIGIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287212; c=relaxed/simple;
	bh=G4hWA+cTSaVeYPpghA4z9vtC6hi4kszdoPGfJgSFtRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YgLA456qE1DXIldekZ7kQWi042e/KR2s8JV3yaqPlBgkDiF4hiMG+zu/T/MlnB2sP6eQ2YkHLChkGYBokWxOJNIpn183rYJrXRNncpRoFak+73Gg/I08ZYrjUk2kRTFpkSSlhsBUBbHXoHvX+AXQ4BLsakAHwJj7K79kdUjjUOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AUS08XtA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-266fa7a0552so21182565ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 06:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758287210; x=1758892010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wqd2OsumqXvM1qmIAqFhFCxL6bjWOH+kistJRYcEtxM=;
        b=AUS08XtApgZe93P/1lGF3p+rDcH3FkJRWKvFcooM2N5DuppUwjJl5blryXNys/dYRK
         0TqYtMS0gRWe6h4FgWuyCQqESN91ZdpdMixtlcDyZaK8O0AzmxcpVFEBEbvPGYrqKtre
         u9vYwmvQO9w2XNCdZmSATK+sWGA3WCxPhYxNa9k1saVJmNbxLjZxZsmaowtBTBJZGIqy
         Ks29tZ0ilF2GozhhGnVvYefJ6vVyb2PLZsqaZAJPCUj7yggjXLNrui/BIH9pHwt5GDaS
         9lZaCSGOZryvzM+yRBl6OlKOnob34lqE8iUR1t2tNG14f2VEiYVbknWAD6LOuW2LVTTR
         4iiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758287210; x=1758892010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wqd2OsumqXvM1qmIAqFhFCxL6bjWOH+kistJRYcEtxM=;
        b=rRR+FXT0YflrxQj5JVmlBq7EQyHTPWp8jMpGq+W6/y9r6uaAHr4KEvplWZ5OjvVCxX
         KljwXKe40zOYnYezd5CvZ9bbt7y5fI5SGuvQZBo+30YqWwxIIy7dw8VxtBriLAxFeAot
         2+bN4Sy/HGzQMU3XrImjnk1ZRo6Ij47lM5bSd0P9v7drTHbdvGTO4n4WuqKJPl8ZViPx
         COpSOYMBBbc5wMjwi1U3WC3ls8Dco8zfwXW7VTYQBfOpAu2wAkw98+gPILo9B2reHCu4
         DRgTuMETotljM2eBDCaeUn7d6huq+OyQDwmYqcIa+2v1NX122PnqDVYf1U8a926BmrW9
         Ufdg==
X-Forwarded-Encrypted: i=1; AJvYcCU/fxE0fi/zu67fgDJYfXk+HaxkfGTWQrkDIiqrSNoKBSh1cMV8KoG2Bra40ROKI+wGmEclqOC2mYnzrRwN4fI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP3zLAu5RdeMhqMfYclEgsSCgsPKTKcl8geM0ZM1LWnj9brWqb
	dbXbVHHQeQGLqYt4tpaesrbWONE35qfkPkv10iTvNLL2NbOYaUETURfFH3mLxRYgbfQ=
X-Gm-Gg: ASbGnctP3gMhYla5EDwf49m6YWU0iyO5PO93sP8/jfovRCdABZW6TRnDo+FzOQGKPn3
	KtFs9ddv1XM8xa5i1spAgi25Trdmk8WiVGOVPxTIFIUvk9sPzDzUqeTzRdOTMteWhNfu30Ijz4l
	utJ+DOCNkEayOJrqlQVZvBgKh2cAKlpsFRleZQkQ2D5O8bKC2P05kOl0hpZBVWIQPOEyveJTEJz
	kDcqQ/9ONVAegEZg8N99Dtn7GQyVG8QiRXuHIM/JL5jfuMbIEsMY6kL6Ug6qtNAGEoecLrO9VAs
	kJ9HZ0KAd8FA7xuthF+4gprEjHvRdRxnIvAvntAtoUPAMIb8z/C53sJWUsNJTbq1VWUtUFq4wky
	4Oi3+Hc2NGFNauDoOUW8GWbIlBrHSDeho1UIPAWSzRa9rN3lsidW5+8Lhkw==
X-Google-Smtp-Source: AGHT+IGsQX4qqfvNoPwWJFUjplN/lur0/YcnCiwcw0BLRN5WPXUAW75RvKgSRYlc7901m8WomTeIKw==
X-Received: by 2002:a17:902:e946:b0:24b:4a9a:703a with SMTP id d9443c01a7336-269ba42b2a8mr46562425ad.17.1758287210016;
        Fri, 19 Sep 2025 06:06:50 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([2001:c10:ff04:0:1000::d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm54732065ad.90.2025.09.19.06.06.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 06:06:49 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	libo.gcs85@bytedance.com,
	Yongting Lin <linyongting@bytedance.com>
Subject: [PATCH V2 6/8] mshare: selftests: Add some helper functions for configuring and retrieving cgroup
Date: Fri, 19 Sep 2025 21:06:18 +0800
Message-Id: <20250919130620.56518-6-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250919130620.56518-1-linyongting@bytedance.com>
References: <20250919130620.56518-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before verify some complicated memory functionalities such as swap memory
and THP, we need add some helper functions to configure and retrieve cgroups
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
index a3c3896bd507..f1db4eb3cd8f 100644
--- a/tools/testing/selftests/mshare/util.c
+++ b/tools/testing/selftests/mshare/util.c
@@ -124,3 +124,131 @@ int mshare_ioctl_munmap(int fd, size_t size)
 
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


