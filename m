Return-Path: <linux-kselftest+bounces-37242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1726B03E6A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 14:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C8947B1098
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 12:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C4F25392C;
	Mon, 14 Jul 2025 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGR6LNpV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBC1252903;
	Mon, 14 Jul 2025 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494684; cv=none; b=Fdu8957e5mhiq/LcEC/+n+cleGGvX3ZXyI+erezK1s2HJljjP9if/SGgBEZCEvfeuy2dCmCMS/9440mRgpYGFzZ+xqYsjDDKHtrPH7ERJ9c/jNR/DLQkw4VsH5y0CEHFmBzAoDER9frwcAnO9TvZ4E+fwTgQ6AK8GRSjcFF9mdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494684; c=relaxed/simple;
	bh=Sb3yv+JqKpM0MAcQFhT2Ve4KM+mgKbcnc9vvK1V9ZZw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRa31I1f5RMa7jOd6tOIXb/MloI5PzYx4GRwAE3/qyhUHuNzsmmyWsj8F7E1l+JDZx2SswoRUt2tz40XYMTNYmuRPPTHgSEBv8SZ+5AwVH+O2EBhwUV+RepdKaT9BfKyEr0QTdNeoqmmNmqaGUJXxNSdsCtFgi/Rjj5EnLZAX+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGR6LNpV; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23636167b30so37096925ad.1;
        Mon, 14 Jul 2025 05:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752494682; x=1753099482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WoQlpGmhS0hNGH57+qjnBbK1O65fEwT14C8Vm4CmUQw=;
        b=OGR6LNpVE43YydCktNlxOjfY5P4O45W4acomV4F/QVmn3+nPPCmrKP9st3jYNh2f6/
         oIogkXJ/xDgQYdEu4ZfAeOuExNR44JdIyLvPcse3t7GKb8GNc23Kbut77ayKy9cBdrjl
         04/ZWt6N6j08VyxdrXW30BMjGJ4uthO/LTTbMh0UaumLLF2NwNuCv0t9V6nxOvxXkTAF
         sliWxPIp03dvMafiv32yv/xBQDzAP2ILSYZXRY+qr6ZVTqlWry4Ezlsrcc8AgTeTWLRk
         1zMFXBl/YZ0WgsS1DpR0zKobFNzerC4iUwU4XblforHhDDOlcPmNs/rN+D/BSnIZpNFi
         P7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752494682; x=1753099482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WoQlpGmhS0hNGH57+qjnBbK1O65fEwT14C8Vm4CmUQw=;
        b=g2PVdl26gJ5yiJYJ/4Utw+TJ6vH5pt4xsFtJxIU5BuSYtVoGQrFoH+yTmJuR2J+jKd
         Rh8slRrspvktHHphDYfpT/LJfoH2dPIq5vzh/imF6HyLkAALAYG3ekIteUiU6wEiKNKP
         EMZ6HnrgaSlxPOlbfbF/t25iyye/dYDIhN4myRndeVZhyJXgrkva5oTWumrrZQzTBXtS
         YPUQTKEhufI8hu/HIy5BQXoi8B3a+jNEvlQeb2571xd0/4gXOL4+QwCFF16+uqaUGfal
         l4XYhvasLjMvjigmsp/Qu7lEosLjSBfdW+POlkQ8iiQSQN6hyjctk8sIxMi3UlWSx8Ad
         J9/A==
X-Forwarded-Encrypted: i=1; AJvYcCWJF89nWGflj2G8Ls/j7dXEGj2NsSa8S3FV8tLynv+p6t/+PSDy0YQAY8OeHF786vnwL1c=@vger.kernel.org, AJvYcCWtY5Vm26F8bJeJbH7Z/PvI43cQCVTMP9hxb2TJzPh6hZjMoa7bpre352ARo/CxGDdQHcTJu+F2gL+gBsCBL7E0@vger.kernel.org, AJvYcCXBjB27GmxUSQp++hARD8yIKE2uo6dbo7bXR8drwlys66pIenumMgsfL73Ld6ABfPMo65Xqya80sTV/cQhG@vger.kernel.org
X-Gm-Message-State: AOJu0Yye8AduixQjdzp8KQHj5fE54AuBDZuoOALMo2U6oSGOFk/efAhs
	mzrvuFydKGbIx0z181drYHgJXDQl+mu9rO+AuRixEzO8zifYnvLBPzKL
X-Gm-Gg: ASbGncuDgdI/q9nvRjmQNYXq/SCEsLrypE9PATzYZ1UHcjrA3KbJZdUOJGOXe2/KSMv
	aSRqyiJck2Cp+pGrUIEFiuqQBagTwbOIOj+QwpQJ9FkaZ19ooQoI6hpro8roLFTC048EqO59ykQ
	weIsgKbq3tXv6twYF+/dlo5+rtv+dujDs6pccZF5T2lh3hz0igyFwvlboU9LxQFIQM3apzCD39Y
	itKltYAw0ww4PVO2UA+qZH4jggTmKIZjUgZKEYQdgAPzl+ulJQjc1pgQFtr8g98AqOwLxfJKf+2
	nwFQ37+VL4DKvtCFxLeR5d0UOfqMHuYiw/kx/1HGykloD9IAWb/0JUBxs9FFVutWIERWgPyKEma
	ETxKxZHEtq88thfWgGdlaOsw=
X-Google-Smtp-Source: AGHT+IG9fCd86FnMGI6fXYzAJXBKuwfwdYzSw1TxcbzID5VsVYmvX6L7vo/Z0i7t7JpsmZR9xGXdEg==
X-Received: by 2002:a17:902:e94c:b0:234:c8f6:1b05 with SMTP id d9443c01a7336-23dee0e01f3mr189181775ad.52.1752494682267;
        Mon, 14 Jul 2025 05:04:42 -0700 (PDT)
Received: from ubuntu2404.. ([125.120.99.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4359e4bsm89612895ad.215.2025.07.14.05.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 05:04:41 -0700 (PDT)
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
	linux-kselftest@vger.kernel.org,
	leon.hwang@linux.dev
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Add selftest for attaching tracing programs to functions in deny list
Date: Mon, 14 Jul 2025 20:04:08 +0800
Message-ID: <20250714120408.1627128-4-mannkafai@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714120408.1627128-1-mannkafai@gmail.com>
References: <20250714120408.1627128-1-mannkafai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reuslt:

  $ tools/testing/selftests/bpf/test_progs --name=tracing_deny
  #467/1   tracing_deny/migrate_disable:OK
  #467     tracing_deny:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: KaFai Wan <mannkafai@gmail.com>
---
 .../selftests/bpf/prog_tests/tracing_deny.c       | 11 +++++++++++
 tools/testing/selftests/bpf/progs/tracing_deny.c  | 15 +++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_deny.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_deny.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_deny.c b/tools/testing/selftests/bpf/prog_tests/tracing_deny.c
new file mode 100644
index 000000000000..460c59a9667f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_deny.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "tracing_deny.skel.h"
+
+void test_tracing_deny(void)
+{
+	/* migrate_disable depends on CONFIG_SMP */
+	if (libbpf_find_vmlinux_btf_id("migrate_disable", BPF_TRACE_FENTRY) > 0)
+		RUN_TESTS(tracing_deny);
+}
diff --git a/tools/testing/selftests/bpf/progs/tracing_deny.c b/tools/testing/selftests/bpf/progs/tracing_deny.c
new file mode 100644
index 000000000000..98ef834f0b6d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_deny.c
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
+__failure __msg("Attaching tracing programs to function 'migrate_disable' is rejected.")
+int BPF_PROG(migrate_disable)
+{
+	return 0;
+}
-- 
2.43.0


