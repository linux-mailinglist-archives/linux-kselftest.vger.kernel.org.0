Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB4C249C8E
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Aug 2020 13:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgHSLvo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Aug 2020 07:51:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728394AbgHSLu5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Aug 2020 07:50:57 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1B0C2063A;
        Wed, 19 Aug 2020 11:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597837856;
        bh=0KUG667BqBQH7R9oDKcdtnatIv4iRLCgQg18W5V0byE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a8yiAoi3MVExPC3bB3m7UWr2qdJDvGZOjIL+Dysx6DQB+wgTERcwWZEEH47v/VO+3
         WZRvQB1+WllGJTlUlE7OnPtvk3ifCd4DmEM71CyFXi1gseIqFyCjK6zj+BhzlGT79W
         mU7OSbWFlFHe/V3o/OOWof+ZnrPuAdqE/vsXhC2o=
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 4/6] selftests: arm64: Add utility to set SVE vector lengths
Date:   Wed, 19 Aug 2020 12:48:35 +0100
Message-Id: <20200819114837.51466-5-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200819114837.51466-1-broonie@kernel.org>
References: <20200819114837.51466-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

vlset is a small utility for use in conjunction with tests like the sve-test
stress test which allows another executable to be invoked with a configured
SVE vector length.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/vlset.c | 155 +++++++++++++++++++++++
 1 file changed, 155 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/fp/vlset.c

diff --git a/tools/testing/selftests/arm64/fp/vlset.c b/tools/testing/selftests/arm64/fp/vlset.c
new file mode 100644
index 000000000000..308d27a68226
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/vlset.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2015-2019 ARM Limited.
+ * Original author: Dave Martin <Dave.Martin@arm.com>
+ */
+#define _GNU_SOURCE
+#include <assert.h>
+#include <errno.h>
+#include <limits.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <getopt.h>
+#include <unistd.h>
+#include <sys/auxv.h>
+#include <sys/prctl.h>
+#include <asm/hwcap.h>
+#include <asm/sigcontext.h>
+
+static int inherit = 0;
+static int no_inherit = 0;
+static int force = 0;
+static unsigned long vl;
+
+static const struct option options[] = {
+	{ "force",	no_argument, NULL, 'f' },
+	{ "inherit",	no_argument, NULL, 'i' },
+	{ "max",	no_argument, NULL, 'M' },
+	{ "no-inherit",	no_argument, &no_inherit, 1 },
+	{ "help",	no_argument, NULL, '?' },
+	{}
+};
+
+static char const *program_name;
+
+static int parse_options(int argc, char **argv)
+{
+	int c;
+	char *rest;
+
+	program_name = strrchr(argv[0], '/');
+	if (program_name)
+		++program_name;
+	else
+		program_name = argv[0];
+
+	while ((c = getopt_long(argc, argv, "Mfhi", options, NULL)) != -1)
+		switch (c) {
+		case 'M':	vl = SVE_VL_MAX; break;
+		case 'f':	force = 1; break;
+		case 'i':	inherit = 1; break;
+		case 0:		break;
+		default:	goto error;
+		}
+
+	if (inherit && no_inherit)
+		goto error;
+
+	if (!vl) {
+		/* vector length */
+		if (optind >= argc)
+			goto error;
+
+		errno = 0;
+		vl = strtoul(argv[optind], &rest, 0);
+		if (*rest) {
+			vl = ULONG_MAX;
+			errno = EINVAL;
+		}
+		if (vl == ULONG_MAX && errno) {
+			fprintf(stderr, "%s: %s: %s\n",
+				program_name, argv[optind], strerror(errno));
+			goto error;
+		}
+
+		++optind;
+	}
+
+	/* command */
+	if (optind >= argc)
+		goto error;
+
+	return 0;
+
+error:
+	fprintf(stderr,
+		"Usage: %s [-f | --force] "
+		"[-i | --inherit | --no-inherit] "
+		"{-M | --max | <vector length>} "
+		"<command> [<arguments> ...]\n",
+		program_name);
+	return -1;
+}
+
+int main(int argc, char **argv)
+{
+	int ret = 126;	/* same as sh(1) command-not-executable error */
+	long flags;
+	char *path;
+	int t, e;
+
+	if (parse_options(argc, argv))
+		return 2;	/* same as sh(1) builtin incorrect-usage */
+
+	if (vl & ~(vl & PR_SVE_VL_LEN_MASK)) {
+		fprintf(stderr, "%s: Invalid vector length %lu\n",
+			program_name, vl);
+		return 2;	/* same as sh(1) builtin incorrect-usage */
+	}
+
+	if (!(getauxval(AT_HWCAP) & HWCAP_SVE)) {
+		fprintf(stderr, "%s: Scalable Vector Extension not present\n",
+			program_name);
+
+		if (!force)
+			goto error;
+
+		fputs("Going ahead anyway (--force):  "
+		      "This is a debug option.  Don't rely on it.\n",
+		      stderr);
+	}
+
+	flags = PR_SVE_SET_VL_ONEXEC;
+	if (inherit)
+		flags |= PR_SVE_VL_INHERIT;
+
+	t = prctl(PR_SVE_SET_VL, vl | flags);
+	if (t < 0) {
+		fprintf(stderr, "%s: PR_SVE_SET_VL: %s\n",
+			program_name, strerror(errno));
+		goto error;
+	}
+
+	t = prctl(PR_SVE_GET_VL);
+	if (t == -1) {
+		fprintf(stderr, "%s: PR_SVE_GET_VL: %s\n",
+			program_name, strerror(errno));
+		goto error;
+	}
+	flags = PR_SVE_VL_LEN_MASK;
+	flags = t & ~flags;
+
+	assert(optind < argc);
+	path = argv[optind];
+
+	execvp(path, &argv[optind]);
+	e = errno;
+	if (errno == ENOENT)
+		ret = 127;	/* same as sh(1) not-found error */
+	fprintf(stderr, "%s: %s: %s\n", program_name, path, strerror(e));
+
+error:
+	return ret;		/* same as sh(1) not-executable error */
+}
-- 
2.20.1

