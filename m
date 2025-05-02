Return-Path: <linux-kselftest+bounces-32159-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EA3AA6F67
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5606717C6F2
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 10:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828A3241131;
	Fri,  2 May 2025 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="iFrMq2Kr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8436423C4E7
	for <linux-kselftest@vger.kernel.org>; Fri,  2 May 2025 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181237; cv=none; b=t10uIiNwU1zh8kaF72h3q/KX5rWO+xSRRO0roaMPXFiHoiNtnYN2v8CzHPuflsaJw4afTCsUvh+Nqu7wDTDffTWIC/hDrsqiUTmp+aehUuRsWYQ6M2QKE3GnYxIk3N2PibyO/eHU88O+D526bS5Y0mWrOOxVsdpnz/9zIC3fkBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181237; c=relaxed/simple;
	bh=ychg/Ta4S8UTx4Xf2MItnvBeDG7XnCP0C93pzW0Ay8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mFIhtz0SET1I5ryQUeCZzcGUd36K/78RupFXlWIGAQT6m7Yudm1HZ/qMwFy0f4IhRn1RZiGtAWmPyTssoiK3IMuKrGXfWamqTj82QsJ8QIAt4TvHqyCUvE4zZflj1tXW2RAoJIbLJzYSnQozY4m7u3t+RXeZ16XwfU+GUdRDUI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=iFrMq2Kr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so14160865e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 02 May 2025 03:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746181234; x=1746786034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BATcMPOI1ZCFC5PD+E37IaicFbjrMSjSWMu+X6OAJY=;
        b=iFrMq2KrEzxnqYfZpYrSkDcrZmSXTm2R2EtCbbwmyYKFjKSIIsFU86nA4vmhJg6ZuN
         DvnbFMh03gM6vDLUU/Hmo/dk5sY4h3QaiDpLxQYREkUU5q4XMgP2SSaeathVg5CFyQhe
         avLEtw4z9At7ELVDylYmj2FmgylcgBbpFIxe3PYfv4BHUaggnYgEw//Dmb7Oy26hGvd8
         3vUVhp8UTwb+b/38pMJui3OOujpePmtCAXWne/Mf9FGfNca2qzWipt2HbaLAlnthB9tg
         al9xKIId2v4KV1OijFmaGFnsGNufdTC+8q/DRLEL4csL3IbuuJcUHDlwEyL/gLncbGsn
         j/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746181234; x=1746786034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BATcMPOI1ZCFC5PD+E37IaicFbjrMSjSWMu+X6OAJY=;
        b=S0SKdP/3CY9H8sGO1GgEh4T2oBRNsM415kM1TKdtQiaBOgsqBtGuomlHeeE6eaTN1P
         9/wRfr5VCkd5NFJN2Xg2m76S2TQatm4fRf0QBv+JJFOhbbAdSF5pX1vMNvOQkr7keunX
         5urcHHWJMbrZklezzRf0BqA4u0MI+pbGzrnzkXI2ihs86PQFDkc42XQ1k0QXBcNJOz9U
         NEXDbxP2fU2mAAVoI8gA4ko8tMocZBu4E22F2g9AYZ6gu0FKvd3e4HX0voVwKTJeLXoE
         171xaiyiOs/G4n/29hCUkJ+myzKF47VpIDItVjEMMjvQx8nrRiMdSow2ov7O2cabiqfY
         PDiA==
X-Forwarded-Encrypted: i=1; AJvYcCUvE7fFV4KNidjbdFnoh8BFkYD14s/EWxw+27iYDicg3sJuYA0XdsAXorMHins3J2oQtFLp9sX00nhpANY4Zvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq3IcZoqG//5CSynQOz0lPzfXfX0dyRskboEy/pxiRlPHy76Ho
	dG4FE8xhC0mKHPtfyHwzub2+Ox5SMuT0O8PVA3mqB3DxsApCehEWEyhf6v/9Ou0=
X-Gm-Gg: ASbGncvjW2SaGvUuSodETOFrIPQMK1u6di+KFIMXVP3U7VrHNKVymfGLmaaFu2j9c9W
	hCTSI3mduABLwgtnGoBHOYc+nJa78KrNZ6PcJINCZhVPQNYK3HLuwEUQORwlQFtFEPu5ClwdDPK
	XPB1x+D/Cp19doKdQG5MdQosBuOxCx0nJI6qeqMxc+z4VRJQKOL7sylxvGGXhLRKWWx9FgMMSUe
	aOAQ12W6KEv0g6IKHw6aFGZnLbVxc+jdSqwMTHomJFH648RhweJQjZlENfKeDyISLdvWifhtYat
	5PzhGEsa5YqIWr5QPIXpEz6q0BV4SRNpNLZ3C2c1VNNsMvXkDrgXlSUpOtSVcTOYhq7D+ClLUYp
	czwcbWOi3hCB/8BAC2zJupDLyw9uEiOElcZQM
X-Google-Smtp-Source: AGHT+IFUHkTtc0DcElXRacw231nP94ZA8KvkgC+j1gjYc5WSrObc75yVcLMxn3UnSEc1kGWDOkoudA==
X-Received: by 2002:a05:600c:1e88:b0:43c:fd72:f039 with SMTP id 5b1f17b1804b1-441bbeb3813mr16937805e9.11.1746181233840;
        Fri, 02 May 2025 03:20:33 -0700 (PDT)
Received: from [192.168.1.240] (0.0.6.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::600])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b17017sm1742342f8f.92.2025.05.02.03.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 03:20:33 -0700 (PDT)
From: Lorenz Bauer <lmb@isovalent.com>
Date: Fri, 02 May 2025 11:20:06 +0100
Subject: [PATCH bpf-next v2 2/3] selftests: bpf: add a test for mmapable
 vmlinux BTF
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-vmlinux-mmap-v2-2-95c271434519@isovalent.com>
References: <20250502-vmlinux-mmap-v2-0-95c271434519@isovalent.com>
In-Reply-To: <20250502-vmlinux-mmap-v2-0-95c271434519@isovalent.com>
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
 tools/testing/selftests/bpf/prog_tests/btf_sysfs.c | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c b/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
new file mode 100644
index 0000000000000000000000000000000000000000..5c8095bedb0517930aabdecc17ca7043f80f3692
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
@@ -0,0 +1,82 @@
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
+	struct btf *btf = NULL;
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
+	/* Check padding is zeroed */
+	for (int i = 0; i < trailing; i++) {
+		if (((__u8 *)raw_data)[btf_size + i] != 0) {
+			PRINT_FAIL("tail of BTF is not zero at page offset %d\n", i);
+			goto cleanup;
+		}
+	}
+
+	btf = btf__new(raw_data, btf_size);
+	if (!ASSERT_NEQ(btf, NULL, "parse_btf"))
+		goto cleanup;
+
+cleanup:
+	if (raw_data && raw_data != MAP_FAILED)
+		munmap(raw_data, btf_size);
+	if (btf)
+		btf__free(btf);
+	if (fd >= 0)
+		close(fd);
+}

-- 
2.49.0


