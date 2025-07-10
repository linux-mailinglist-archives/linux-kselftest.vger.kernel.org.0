Return-Path: <linux-kselftest+bounces-37023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA973B008A0
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 18:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C9417DCC5
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 16:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9455F2F0C5C;
	Thu, 10 Jul 2025 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcRYN7ZA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110102F0C50;
	Thu, 10 Jul 2025 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164871; cv=none; b=Q9KJbr483Rzm1f8ZCEtt2r387NLvFb1DsCbFsYX+inO/8EIiQr8J7GWG/O3y/q+yNQrkJ/yzhxJrTQZtichI//B+eLb0E8Vq/38wXJ7XI+MsLp1T8s8C6Kph/1Qg7sG+miMEhnruh+y5MzHOiIGv14YV7bgbNqSXkSHxkDPEx3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164871; c=relaxed/simple;
	bh=DvFlR5aW86yPe+1lde5CxO1YM7etXrMOcAvLOufI/eg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pa8TB4RSHpU4yxq6G/heUWzuPC3J/B4scoiQX/pQRg0ioj4hlg9xxh8ol3SD6fJFA25KtuLekyTuUm5qsaRFaUxRIkhlvdM55g46/ct1fYaiwie6U9jLCFZe5VkL2pTWEk2UVJJSdCu64GqH43lf6YlqSUz3Q7ZDoqhQQE2VCN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcRYN7ZA; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-73972a54919so1094078b3a.3;
        Thu, 10 Jul 2025 09:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752164869; x=1752769669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1BYPbCSIwivsMBLKvSdWxmNEsZsKhpWfufy1kkW0+hY=;
        b=mcRYN7ZAqUbcr9vvvg4esU0gS0naRa2tzjAwzuI4lg7F48olUMYSi9U+EJONE0vRPH
         oZT7GHMv9dNkKlkBSUZsC98Vn9opijxC/ASZJgq55FUtyFBvgU3eZ0i2tTRPVjS8/6xe
         XrNWwLCg9nbX52s0LV+zsRz+OAOidOj+3nFV5eBQmfZsnX+xoe9GManWbbS0GlYGz/B3
         8x68tmLVOHextcJ/OYSJtYlZpYxIfFQJYiIGntQSaqBFJDKFt17xeEMosqLwEYREKHzd
         BYSXlKZDFWVWih7F1nv56JJcKOHyh0Fc5QoGsBlx0Y9NFI3xr18EEu0POF8FclKzIeuS
         jTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752164869; x=1752769669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1BYPbCSIwivsMBLKvSdWxmNEsZsKhpWfufy1kkW0+hY=;
        b=MjX0MY7tI/d5gPsoZChmebRQjk8g4Bv7SGnVrlCJ8LwUfGoQ6XEBcu7hLgVbRgCMZI
         xghVHpPs8azAUCF9Pjomdji5sLguG1T3VqeXU2r/QzkU7F1CCy0z/wdDD9sSQYpv0f5b
         3u/G+2+MIKrktNf/8E0o1vuCym/PMSUnOGIU1ZWBqMHmnlT0l8YvkxM+yAljEXdTiRs5
         buefFhmpuyDAFqxloQb1XTdnVCRQcUeOQOg1KRq/bXBbUpNbnE2IkXtPEnT9EiXUjTSD
         5P/dLuPh57TqUe8vzYQePMjxZHWb+KRjH0XpA4/w8opXjlaf6HssKFSg9qubuDxiRwLH
         F2Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUOYBARm5cz7mXf7cDV/MefNATdpMZTihjbQ5ez5otbNRl6FV+KDu41jqYjSN9bynFp6XU=@vger.kernel.org, AJvYcCWOU9QaddXbP5RjDL3YUfZscW7WNUNtChp5sQb5QlRnuvHQa6L7BeF8a7j87hn2Kb17Is3Io6vhTmvUWEGB@vger.kernel.org, AJvYcCXAASunYdoitpMl7Ebs2WucW8ty3RiiV/nWpx52j3AqF4U7j6iLDu/BeSbA3pyowrq7yYovf9bxFqCMYVZo3kn+@vger.kernel.org
X-Gm-Message-State: AOJu0Yys4YHoWef0bUQbWCykBbFytMDDCc2s2Uau45d6jmdF5vyNYm2m
	3ZgwXdpV/up/srfdNZ5vd2GkROUYF86+lxz1IWNaU5GtQUYl1XRCU7sF
X-Gm-Gg: ASbGnctFHpWBIlWmiIdQkTeuQlh79HGU5EX7yNzGIEor3TT1wnXkf827yspmtYvJSyF
	F04POoDkcuObEU9bPy1SlTzD8n16LAllSsPF6kVbBRkw7FSxFdney3ichQJJ+uf/zXZE+CpH/cy
	+XbXUDKXvfL/wYuxX91yJnmGjcY99+PAC9ccrBvjsu5fS0JiRluHTMIrSizuSYxUUYbtTTS9k0d
	wtG6NzZz2E3P2BuqoVc6bdXaPQHEbzOaAZ1etTuUWcEN6K/a2R44triFVwGy9heo5+OrRtaHCr1
	vqG4GP4yKGP+VYPYacXeEh8bIxziUR628fKeFdsy/67zabYk0MefZIw39aRc9l4=
X-Google-Smtp-Source: AGHT+IGORneXs3KPwTzhvEbXdkzIsp6rMKf81/nZyIdT2xkOejVHhvtR6CD5mm+LdSJslhaRrmlUuQ==
X-Received: by 2002:a05:6a00:889:b0:740:6f69:f52a with SMTP id d2e1a72fcca58-74eb8c2c2f2mr5279323b3a.0.1752164869116;
        Thu, 10 Jul 2025 09:27:49 -0700 (PDT)
Received: from ubuntu2404.. ([60.176.129.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f25269sm2690418b3a.107.2025.07.10.09.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:27:48 -0700 (PDT)
From: KaFai Wan <mannkafai@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	mannkafai@gmail.com,
	laoar.shao@gmail.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add selftest for attaching tracing to __btf_id functions
Date: Fri, 11 Jul 2025 00:27:17 +0800
Message-ID: <20250710162717.3808020-4-mannkafai@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710162717.3808020-1-mannkafai@gmail.com>
References: <20250710162717.3808020-1-mannkafai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reuslt:

  $ tools/testing/selftests/bpf/test_progs --name=tracing_btf_ids
  #467/1   tracing_btf_ids/btf_ids:OK
  #467     tracing_btf_ids:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: KaFai Wan <mannkafai@gmail.com>
---
 .../selftests/bpf/prog_tests/tracing_btf_ids.c   | 16 ++++++++++++++++
 .../selftests/bpf/progs/tracing_btf_ids.c        | 15 +++++++++++++++
 2 files changed, 31 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_btf_ids.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_btf_ids.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_btf_ids.c b/tools/testing/selftests/bpf/prog_tests/tracing_btf_ids.c
new file mode 100644
index 000000000000..b45b9ac3630c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_btf_ids.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "tracing_btf_ids.skel.h"
+
+void test_tracing_btf_ids(void)
+{
+	int btf_id;
+
+	// `migrate_disable` depends on `CONFIG_SMP`, may not exists
+	btf_id = libbpf_find_vmlinux_btf_id("migrate_disable", BPF_TRACE_FENTRY);
+	if (btf_id <= 0)
+		return;
+
+	RUN_TESTS(tracing_btf_ids);
+}
diff --git a/tools/testing/selftests/bpf/progs/tracing_btf_ids.c b/tools/testing/selftests/bpf/progs/tracing_btf_ids.c
new file mode 100644
index 000000000000..92a7f2e9fb89
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_btf_ids.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("fentry/migrate_disable")
+__failure __msg("Attaching tracing to __btf_id function 'migrate_disable' is rejected.")
+int BPF_PROG(btf_ids)
+{
+	return 0;
+}
-- 
2.43.0


