Return-Path: <linux-kselftest+bounces-32084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B09DAA6000
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 16:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20A7F4A0B71
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 14:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7260B20296A;
	Thu,  1 May 2025 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="buCczSth"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735F31F151E
	for <linux-kselftest@vger.kernel.org>; Thu,  1 May 2025 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746109711; cv=none; b=LsanCRbzWdKye05ZrFeIvXXJSBkqocT+mZxlYCcIrrBfOzeYLJU2Ro6k1vD8riSDt+jvzeScfCmMX9/WivP1XXSjHnTWSLThzIradItz2eG+PsN7CYsmaWz1eNScBx2w8r9FHxvFtOxWJ/gSwdN5mz5Dv6sBDZxJfYD5vz/EkqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746109711; c=relaxed/simple;
	bh=UHf0Gnh8ksl5dQCn2tzgemavr4ewEn7RVYTj5JxtNW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HqV09UZPECWIW55BE8rX7+Z0XK049Zg88Ghn99CeU8Bhkqfm75msCYAs5kovm+1eyNEcTZtrB+Qq4w/Loxo5nNHI2aJK2Fmf/1J3udAzuGfEX8g+Iz/yrs5kwRecfaCfK9C2nawKpBSNzzphWRmsFW60ZInAW6rg4ehC2Al7Nic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=buCczSth; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c0dfad22aso632608f8f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 01 May 2025 07:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746109708; x=1746714508; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6DcGQefvvptQYw7ehSGQN9HwujMvdj5ehwVheaE79Vw=;
        b=buCczSth0/Yuz7dl0yp9Y3lXiuguynm+Hqk4NgKbCgX595+O1a6Ga6BXpWzCHwvzTR
         qN3TylHzcwBzJHvEQR8qwFd4W8uLAgJCmafR4J2Ny6HNGQsNTqTpgacx6cYAKECMxV4T
         oopaCoCpiTZRi0OFJG9bTeXVPnPtQUbTm/p92ib2VfOoOPYB8iuELWyuXLRqWc5gtmKn
         4A5+vA3S8R8GI5S2Kp23rGn0rLi2oO0x4Fg4HbekbeTLg8AQH6SOC6tY0yO1FtVn7cMV
         aKxB11yvnJhrqbxHsiyV4G17jevIZgdgB9MAsASsccVpBkPw0E9Z1SvucqQO43DWNnYl
         kFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746109708; x=1746714508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DcGQefvvptQYw7ehSGQN9HwujMvdj5ehwVheaE79Vw=;
        b=VYGB/yBPqzu+JPwron2ab0kFhJ0X0wergw+F3G8js7xjZN/e3e5TaT6zrN3MsNIqPa
         cnzYXWgIqGoBjMYEgwP/pVggGVC73o7COGrRdDbYbNGvkIJsfPPKz8DB3tqO1PloLdDC
         PcasRrU6Y85KWGzcAe+M8ICa9PdtOVZIidtBJqfNjSoJjVUEOfJcc8Kv62b4KUSexCjo
         FrIixwEHUzDpQITqXcZV1OTqsJR8N76pEgJgGymkBS7XRHYAXoe4PJy/03EtPvAhFL+r
         5+lTQqkFnjD8z+4RyIe3VwGnrXhr+67MkqRUZWB6M5YOURKRkxWd5vm5Y2aCve5VEwKs
         FyOA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ+zQwLHQmsPTbAGrn/PabU3xtjqOV77jdsGE0xI8awnuqsJR3o8X8bAPKKspaYe/8UoBNkY4OayAlazB+ki0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7jJEtZwbZUE9kPWf2UQhcCKtynjAvCluvPD7imItmZcakd6OH
	w+IFOOtt50M036jRRhNCK9TXpfEmjQu2rXp/7mt2CGSfGzwCeXGAa6WB++pzfZI=
X-Gm-Gg: ASbGncvDkwTqO2L4jQ/RAYZzNvOMZ8pVcU7tmssNCio04F/yqYrUuvNmJoeDTpccg+m
	Nbm76EPNEZb3x5/OJUuVOupC2pR2gODrOj6gC2WyMkOQvvz/UKHusEqn4HfyTvVGCeoRC4x/Mnj
	ymbWvi4NyW720uDieUj3DDxALxp5VrqHtUvPL6zNrkjSKgFShS9Wtda+BI0xOVHzRafbYoBmglt
	3cSJXmJi1rmm4TRSFsNmXELLWb//mmcP9PwI9nS0tQ+sAbs7fQAMnt43/sCHiV5rrUvgjCeok+h
	2jCzQEdw/DlZFh2PgGiNygDZno525/rQ3Fyy/NDJ1CcDH+Pl57kl0Xl1ZGagaq1AgTeLrKavONu
	KTm8SW+7Wiwh2FEa/qiKFrjc1Lv0Gcm0HPJzd
X-Google-Smtp-Source: AGHT+IGYI7eWshvOXOMSQIj5XTh7ey/sDlfBCCJhBg/3GXyALEfYIYT/c6FPdhLIsltARyEhoSfGtw==
X-Received: by 2002:a05:6000:2af:b0:3a0:7f85:1905 with SMTP id ffacd0b85a97d-3a094003b65mr2315851f8f.0.1746109707752;
        Thu, 01 May 2025 07:28:27 -0700 (PDT)
Received: from [192.168.1.240] (0.0.6.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::600])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89d15dasm13908445e9.16.2025.05.01.07.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 07:28:27 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Thu, 01 May 2025 15:28:22 +0100
Subject: [PATCH bpf-next 2/2] selftests: bpf: add a test for mmapable
 vmlinux BTF
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-vmlinux-mmap-v1-2-aa2724572598@isovalent.com>
References: <20250501-vmlinux-mmap-v1-0-aa2724572598@isovalent.com>
In-Reply-To: <20250501-vmlinux-mmap-v1-0-aa2724572598@isovalent.com>
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
 Lorenz Bauer <lmb@isovalent.com>
X-Mailer: b4 0.14.2

Add a basic test for the ability to mmap /sys/kernel/btf/vmlinux. Since
libbpf doesn't have an API to parse BTF from memory we do some basic
sanity checks ourselves.

Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
---
 tools/testing/selftests/bpf/prog_tests/btf_sysfs.c | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c b/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
new file mode 100644
index 0000000000000000000000000000000000000000..8dffed136b4757779028ec0971b56ff541f2218c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright (c) 2025 Isovalent */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+#define BTF_MAGIC 0xeB9F
+
+static const char *btf_path = "/sys/kernel/btf/vmlinux";
+
+void test_btf_sysfs(void)
+{
+	struct stat st;
+	__u64 btf_size;
+	void *raw_data = NULL;
+	int fd = -1;
+	size_t trailing;
+	long page_size;
+
+	page_size = sysconf(_SC_PAGESIZE);
+	if (!ASSERT_GE(page_size, 0, "get_page_size"))
+		goto cleanup;
+
+	if (!ASSERT_OK(stat(btf_path, &st), "stat_btf"))
+		goto cleanup;
+
+	btf_size = st.st_size;
+	trailing = page_size - (btf_size % page_size) % page_size;
+
+	fd = open(btf_path, O_RDONLY);
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
+	raw_data = mmap(NULL, btf_size + trailing + 1, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (!ASSERT_EQ(raw_data, MAP_FAILED, "mmap_btf_invalid_size"))
+		goto cleanup;
+
+	raw_data = mmap(NULL, btf_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (!ASSERT_NEQ(raw_data, MAP_FAILED, "mmap_btf"))
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
+	/* Check BTF magic value */
+	if (!ASSERT_EQ(*(__u16 *)raw_data, BTF_MAGIC, "btf_magic"))
+		goto cleanup;
+
+	/* Check padding is zeroed */
+	for (int i = 0; i < trailing; i++) {
+		if (((__u8 *)raw_data)[btf_size + i] != 0) {
+			PRINT_FAIL("tail of BTF is not zero at page offset %d\n", i);
+			goto cleanup;
+		}
+	}
+
+cleanup:
+	if (raw_data && raw_data != MAP_FAILED)
+		munmap(raw_data, btf_size);
+	if (fd >= 0)
+		close(fd);
+}

-- 
2.49.0


