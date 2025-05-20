Return-Path: <linux-kselftest+bounces-33401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A39FCABD8B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 15:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731F71B61028
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 13:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C70E22D792;
	Tue, 20 May 2025 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="WdcEY+pt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CF622C35D
	for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747746105; cv=none; b=ZjP/QaA2sF1ssiq3xVWLhzE9O53MaUpq+oEh1QWP+wErIInLfMSUpwkMp1TveTb1RG96XLBl5d7XggVSQxsamOFsLkEbh0TJaJqClj9E/YYeglFL7/j1e8gongTMkdccB3TZwRh47+kw7W65VJoLMibJc0YgZm5IsWkjxKdIrBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747746105; c=relaxed/simple;
	bh=onxYhud+KbP9G92KrrkVXhWhrAZjMw6PhcWJrcxgw9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AIELKuDzDHOGYy8MmbitQeJMRUbnbJYCbVdi3bFFlc0Z0v5fTQHGFenluK4TWDAtq1fC+AZNgWvABTnsKrFBBOdGbOVAF5H6Z7mGtaYC4WrI75obkiKXUWJPHkwXCgLKIPuQ7GicLnIIvcEAwqyJc5x8oEQ1AEYlCra52k6MR6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=WdcEY+pt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-442f4a3a4d6so36220685e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 May 2025 06:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1747746102; x=1748350902; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLk5G4Cel/wWxbE0AJcynDwZLLJtlvvXRoNS6jKTq6M=;
        b=WdcEY+pt4w0MfM0DuCLDEk0pdk8ZtsWlU+dYfUHpPY0R64urNJ+Jn+4izTxIb9V8D1
         6WSc47jK1IzN4+S5pFL2nlXaIaje39BYGKZygYPXo+hJiKJOUpdKcolX9FB0D1SuWcig
         KG6Vn6N3wSSXj/IfhXiQFloqx8VSqzxiLsqi8mXNojtgU0lDahICt/+tXzlexKysapR4
         SQRMRupfrKoepgAo8w2VFSOqlFeLzmFCZKdtSdceqcuaUEnarwi3I56Qw4Ob0qKYCS4j
         /AC0tNJVJI0DVGDdgwewiX1nU59j1p1qxieokBPx1Kfb2h+dF9DG6Af3J/F54tAxtvFa
         a/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747746102; x=1748350902;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLk5G4Cel/wWxbE0AJcynDwZLLJtlvvXRoNS6jKTq6M=;
        b=s33WlN7eeO5ZiUEmYqxa/wdN7G0VrXnDJq5GyFBltHTlqcBFEoPPAo6/m0384lb8TG
         JHFjJMjSQmv6/g5uvWPUpY2o+Vyeh15HIJeRKp1xG9Qg5geiZtc8OgkFGwkzX1w5EZus
         kUUVGGhg1bm5r8CR1xb5nWASV/Ld+4eJDgk5v4gHlnGRgb1F5ZG1UXBa1jv4I3cq6uL/
         tKo990paQn+GAyY1XnENLhB8YJ743sQAfXmJRPqavRQqpqsSeLVLLZjfuAeINAWPefID
         Y17AB/MKpZxlJRWnI9ZV96xHewn4LI/WhmiO6mDWgleweWoh/SFP4O5E/K/G/er3oQ0b
         ZKLg==
X-Forwarded-Encrypted: i=1; AJvYcCXuUuvIwoUEq0o/Xh/gIEdBMoBlgeBE9iKiG6FmiegZRIE0ipvwniCri7gIroEAU5ot7KilxPlKsS+JZ6Qs42Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGTpwC8yUguzJIUHZtwJaDsSaIQmzVqMowI/B3Pb9YnmSx+6UN
	IAL/ojNmGZg4BPSwZLabnv+YOLbpAESVDMb+l2D8SGGoX9klsOzDo0IXLOYSV4F9Ihg=
X-Gm-Gg: ASbGncvd6tAUeBRJCRJT2gS1NDfu/1zFEYTM/rWTSA59xiAH/asGVWQe1y5tUiaZJ4d
	M+GBcm9p8npb0hwi9XWo0oqIH1TzZogsJnfho9J7xaJpaRAmF4vN/wGEi8r0Tjh6bB4nxg+rNXA
	+sclgjOH04BQGz+76MrfvfXEfSZVNxYINQBUvn6m/F6C9n81n6VX0fW52v2wPEio0kgBhbcd0rv
	rddpOuqiK6lS2rFA2NStJjPfde8Nqg/8B3+5DrAL6WXBXpnwYZyzGTehT8SavASMt+EI8yJQFzZ
	ZLm/GwWZ6Sq43B6QeyAHDDM2yugCvp5R9HN9JMYkqSn1AaGMPP5pERsgtuxI//8gXfHwrI/vttZ
	kvpit5EBuGOmyPq8JZ16YgHDUlxFPUZCn6zSeTLsOQacL3is=
X-Google-Smtp-Source: AGHT+IF+zmD+H27RSz/G+4dMOqhg+dz+ihe+221W/uu8LbDrI30vQwAeUCggEu1LDpdjLTvtZ+WKVw==
X-Received: by 2002:a05:600c:5295:b0:43c:f3e1:a729 with SMTP id 5b1f17b1804b1-442f8514e9emr189410795e9.12.1747746101310;
        Tue, 20 May 2025 06:01:41 -0700 (PDT)
Received: from [192.168.1.240] (0.0.6.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::600])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a8cfsm16538095f8f.37.2025.05.20.06.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 06:01:40 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Tue, 20 May 2025 14:01:18 +0100
Subject: [PATCH bpf-next v5 2/3] selftests: bpf: add a test for mmapable
 vmlinux BTF
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-vmlinux-mmap-v5-2-e8c941acc414@isovalent.com>
References: <20250520-vmlinux-mmap-v5-0-e8c941acc414@isovalent.com>
In-Reply-To: <20250520-vmlinux-mmap-v5-0-e8c941acc414@isovalent.com>
To: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Lorenz Bauer <lmb@isovalent.com>, Alan Maguire <alan.maguire@oracle.com>
X-Mailer: b4 0.14.2

Add a basic test for the ability to mmap /sys/kernel/btf/vmlinux.
Ensure that the data is valid BTF and that it is padded with zero.

Tested-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 tools/testing/selftests/bpf/prog_tests/btf_sysfs.c | 81 ++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c b/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
new file mode 100644
index 0000000000000000000000000000000000000000..3923e64c4c1d0f1dfeef2a39c7bbab7c9a19f0ca
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright (c) 2025 Isovalent */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+static void test_btf_mmap_sysfs(const char *path, struct btf *base)
+{
+	struct stat st;
+	__u64 btf_size, end;
+	void *raw_data = NULL;
+	int fd = -1;
+	long page_size;
+	struct btf *btf = NULL;
+
+	page_size = sysconf(_SC_PAGESIZE);
+	if (!ASSERT_GE(page_size, 0, "get_page_size"))
+		goto cleanup;
+
+	if (!ASSERT_OK(stat(path, &st), "stat_btf"))
+		goto cleanup;
+
+	btf_size = st.st_size;
+	end = (btf_size + page_size - 1) / page_size * page_size;
+
+	fd = open(path, O_RDONLY);
+	if (!ASSERT_GE(fd, 0, "open_btf"))
+		goto cleanup;
+
+	raw_data = mmap(NULL, btf_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	if (!ASSERT_EQ(raw_data, MAP_FAILED, "mmap_btf_writable"))
+		goto cleanup;
+
+	raw_data = mmap(NULL, btf_size, PROT_READ, MAP_SHARED, fd, 0);
+	if (!ASSERT_EQ(raw_data, MAP_FAILED, "mmap_btf_shared"))
+		goto cleanup;
+
+	raw_data = mmap(NULL, end + 1, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (!ASSERT_EQ(raw_data, MAP_FAILED, "mmap_btf_invalid_size"))
+		goto cleanup;
+
+	raw_data = mmap(NULL, end, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (!ASSERT_OK_PTR(raw_data, "mmap_btf"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(mprotect(raw_data, btf_size, PROT_READ | PROT_WRITE), -1,
+	    "mprotect_writable"))
+		goto cleanup;
+
+	if (!ASSERT_EQ(mprotect(raw_data, btf_size, PROT_READ | PROT_EXEC), -1,
+	    "mprotect_executable"))
+		goto cleanup;
+
+	/* Check padding is zeroed */
+	for (int i = btf_size; i < end; i++) {
+		if (((__u8 *)raw_data)[i] != 0) {
+			PRINT_FAIL("tail of BTF is not zero at page offset %d\n", i);
+			goto cleanup;
+		}
+	}
+
+	btf = btf__new_split(raw_data, btf_size, base);
+	if (!ASSERT_OK_PTR(btf, "parse_btf"))
+		goto cleanup;
+
+cleanup:
+	btf__free(btf);
+	if (raw_data && raw_data != MAP_FAILED)
+		munmap(raw_data, btf_size);
+	if (fd >= 0)
+		close(fd);
+}
+
+void test_btf_sysfs(void)
+{
+	test_btf_mmap_sysfs("/sys/kernel/btf/vmlinux", NULL);
+}

-- 
2.49.0


