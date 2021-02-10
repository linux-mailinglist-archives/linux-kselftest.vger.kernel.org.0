Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC4E31665A
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Feb 2021 13:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhBJMPD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Feb 2021 07:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbhBJMMw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Feb 2021 07:12:52 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F42EC061A86
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Feb 2021 04:04:42 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id f16so1607277wmq.5
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Feb 2021 04:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OSkPPwU1Tuk4mhkI6x3HPNgww1cxj5Q62PGKwYGTKNY=;
        b=NLp2isIeKm3p7bKBYZ+D2qSKM0rJhJ/2WySCYUP3OlU0+xBqJTZLX3aQPLYZSl0V+I
         H8xodj6XFViiqc3kwBVfr8HkmXkbuRDrSn1RFjycwaIFkUpeE5EO7bTho83PSLVbfaP3
         fm0GNWYRYietbSVI6OcmUJOUriEgJFYy4gHUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OSkPPwU1Tuk4mhkI6x3HPNgww1cxj5Q62PGKwYGTKNY=;
        b=N08btsEhpDcO9alNI8+I6yhDyzpzZfXjkL7/2xhiSF3rKNZ2AR1WfMD970hu7B9MlS
         15DfhWe35ncbooUB8hwNHJqmkLya1M2RNXJggHWSrdJsZEboJ+2hvGvoBTyaiWTA2i0V
         u5u/CArtu78/Em3cjPai2IG3ft7kv8DpKI98sDDALKxppr9St7uLoslN1+6mnlBTHIaJ
         FiMj6zlR+rEfvHYtAgjqF7NZEp+8stm82p6CVCF13u0xGvkE8ZZIN254BEEY+aheMFLf
         I90pZxw2aKJZiu3zQPMX6ptaN7vh4TriShpFskXEkWN5tyV4vifSQhkDO+Ot9mjKdL34
         JrdQ==
X-Gm-Message-State: AOAM532mRnBM9gtTLqEMMiMIpkXy0ptDfUNAQfzJeu1r9Y6r7p7vDVoR
        6v8EkZXe/IgTCGHKdtO+zuGWIw==
X-Google-Smtp-Source: ABdhPJz7fgGWTAVn5RiLUsMsBCacdSGGenk55/ibwhftoFqarBpfndNyw/4EicivNQWRIS6xxFeFjw==
X-Received: by 2002:a1c:6487:: with SMTP id y129mr2680722wmb.106.1612958681086;
        Wed, 10 Feb 2021 04:04:41 -0800 (PST)
Received: from antares.lan (c.3.c.9.d.d.c.e.0.a.6.8.a.9.e.c.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:ce9a:86a0:ecdd:9c3c])
        by smtp.gmail.com with ESMTPSA id j7sm2837854wrp.72.2021.02.10.04.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 04:04:40 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf 3/4] tools/testing: add test for NS_GET_COOKIE
Date:   Wed, 10 Feb 2021 12:04:24 +0000
Message-Id: <20210210120425.53438-4-lmb@cloudflare.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210210120425.53438-1-lmb@cloudflare.com>
References: <20210210120425.53438-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Check that NS_GET_COOKIE returns a non-zero value, and that distinct
network namespaces have different cookies.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 tools/testing/selftests/nsfs/.gitignore |  1 +
 tools/testing/selftests/nsfs/Makefile   |  2 +-
 tools/testing/selftests/nsfs/netns.c    | 57 +++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/nsfs/netns.c

diff --git a/tools/testing/selftests/nsfs/.gitignore b/tools/testing/selftests/nsfs/.gitignore
index ed79ebdf286e..ca31b216215b 100644
--- a/tools/testing/selftests/nsfs/.gitignore
+++ b/tools/testing/selftests/nsfs/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 owner
 pidns
+netns
diff --git a/tools/testing/selftests/nsfs/Makefile b/tools/testing/selftests/nsfs/Makefile
index dd9bd50b7b93..93793cdb5a7c 100644
--- a/tools/testing/selftests/nsfs/Makefile
+++ b/tools/testing/selftests/nsfs/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-TEST_GEN_PROGS := owner pidns
+TEST_GEN_PROGS := owner pidns netns
 
 CFLAGS := -Wall -Werror
 
diff --git a/tools/testing/selftests/nsfs/netns.c b/tools/testing/selftests/nsfs/netns.c
new file mode 100644
index 000000000000..8ab862667b45
--- /dev/null
+++ b/tools/testing/selftests/nsfs/netns.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+
+#define NSIO    0xb7
+#define NS_GET_COOKIE   _IO(NSIO, 0x5)
+
+#define pr_err(fmt, ...) \
+		({ \
+			fprintf(stderr, "%s:%d:" fmt ": %m\n", \
+				__func__, __LINE__, ##__VA_ARGS__); \
+			1; \
+		})
+
+int main(int argc, char *argvp[])
+{
+	uint64_t cookie1, cookie2;
+	char path[128];
+	int ns;
+
+	snprintf(path, sizeof(path), "/proc/%d/ns/net", getpid());
+	ns = open(path, O_RDONLY);
+	if (ns < 0)
+		return pr_err("Unable to open %s", path);
+
+	if (ioctl(ns, NS_GET_COOKIE, &cookie1))
+		return pr_err("Unable to get first namespace cookie");
+
+	if (!cookie1)
+		return pr_err("NS_GET_COOKIE returned zero first cookie");
+
+	close(ns);
+	if (unshare(CLONE_NEWNET))
+		return pr_err("unshare");
+
+	ns = open(path, O_RDONLY);
+	if (ns < 0)
+		return pr_err("Unable to open %s", path);
+
+	if (ioctl(ns, NS_GET_COOKIE, &cookie2))
+		return pr_err("Unable to get second namespace cookie");
+
+	if (!cookie2)
+		return pr_err("NS_GET_COOKIE returned zero second cookie");
+
+	if (cookie1 == cookie2)
+		return pr_err("NS_GET_COOKIE returned identical cookies for distinct ns");
+
+	close(ns);
+	return 0;
+}
-- 
2.27.0

