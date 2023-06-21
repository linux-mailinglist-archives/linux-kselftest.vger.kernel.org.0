Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2052773898C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 17:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbjFUPgm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 11:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjFUPg3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 11:36:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADF32682;
        Wed, 21 Jun 2023 08:36:02 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9875c2d949eso762944966b.0;
        Wed, 21 Jun 2023 08:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687361755; x=1689953755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLXTp0RUGgA+Jc/sbfJseOldAYLgzR9TekxbeG05s8o=;
        b=RyrImiepPCrpOmy1ozaSxyvcEDzp9MhE3T2S32+bcXkS1ZJzt1kFvryEHapCuclisn
         FsMnBcnAgFvVbz6oHOnhjon9AzlNuRq2CeT9VGoekE8V0UMz5c+VXoFvg4jFkTzdqk+l
         zCxPPRFEFfvNeWQrQn5XGRP/ts+3BrdZOvhFYBqSf2BgPLY203kPTKllyM0/471/aFL6
         OcKfCwkc99LlwRgxgbKjREL2XCJLiI2GiJPwbCb8Ov09ctVU+UVoYc1tsiL8jr9oJbck
         eM4hcz2ZMDYQzQKIyt7/dhp1et0FiNe5SSxnxPrYJdLkUyWmVoqzfZgwgMyqsMdkeBUk
         Evnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361755; x=1689953755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLXTp0RUGgA+Jc/sbfJseOldAYLgzR9TekxbeG05s8o=;
        b=NgIxnYh3jn3fqjFOCf3dk6fmAcmsq8qqnhyG8ofPw00cz1ovTjvqbLq0mtKaycZeyL
         soILkTWTXOnkfZg/QPqJW/hwL8ItaDO07neun99EPNViSmbsSL2Rz4V+TBlA8JMb7MH7
         GYusPIDEAH4MxIvo0TQgK8XMUUyjcp6gMeSS5fnCdLrX9Flkr+EouOVtYuFOJMwYTJwN
         92IjIy+Vw/PckS7URNSMrckvbdEWDGs0mV201ejelhIjjIlYgsUb6V1Lz1vkJYhc/IyT
         fR+FIZnkzH4kPkwpC7R95bvF8B3fgzcm1BB9bW1dS/dSVqsxyp42iRH+Oh3B9+WAI6zX
         SfOQ==
X-Gm-Message-State: AC+VfDxei1eYtnW6fh5Y9YvJMg95psxgPTnd2dtjoRG16RZQg+qX+mJk
        39bwJbKyoCMlWdzrQmrzUIo=
X-Google-Smtp-Source: ACHHUZ6LSkSHPtNkaElIDiUTVzr5C7JOcAg3hjTOWDFm9i+huA6Tb3z15NTdVZiCr2IHhaJwnVmi4A==
X-Received: by 2002:a17:907:161e:b0:989:3f05:b391 with SMTP id hb30-20020a170907161e00b009893f05b391mr4661181ejc.17.1687361754973;
        Wed, 21 Jun 2023 08:35:54 -0700 (PDT)
Received: from lelloman-5950.homenet.telecomitalia.it (host-87-21-158-222.retail.telecomitalia.it. [87.21.158.222])
        by smtp.gmail.com with ESMTPSA id r3-20020a170906c28300b00988acf24f9csm3266123ejz.97.2023.06.21.08.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:35:54 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        shuah@kernel.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, riel@surriel.com,
        nphamcs@gmail.com
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH 1/3] selftests: cgroup: add test_zswap program
Date:   Wed, 21 Jun 2023 17:35:46 +0200
Message-Id: <20230621153548.428093-2-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621153548.428093-1-cerasuolodomenico@gmail.com>
References: <20230621153548.428093-1-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add empty cgroup-zswap self test scaffold program, test functions to be
added in the next commits.

Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 tools/testing/selftests/cgroup/.gitignore   |  1 +
 tools/testing/selftests/cgroup/Makefile     |  2 +
 tools/testing/selftests/cgroup/test_zswap.c | 62 +++++++++++++++++++++
 3 files changed, 65 insertions(+)
 create mode 100644 tools/testing/selftests/cgroup/test_zswap.c

diff --git a/tools/testing/selftests/cgroup/.gitignore b/tools/testing/selftests/cgroup/.gitignore
index c4a57e69f749..4d556df4f77b 100644
--- a/tools/testing/selftests/cgroup/.gitignore
+++ b/tools/testing/selftests/cgroup/.gitignore
@@ -5,4 +5,5 @@ test_freezer
 test_kmem
 test_kill
 test_cpu
+test_zswap
 wait_inotify
diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index 3d263747d2ad..27dbdd7bb4bb 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -12,6 +12,7 @@ TEST_GEN_PROGS += test_core
 TEST_GEN_PROGS += test_freezer
 TEST_GEN_PROGS += test_kill
 TEST_GEN_PROGS += test_cpu
+TEST_GEN_PROGS += test_zswap
 
 LOCAL_HDRS += $(selfdir)/clone3/clone3_selftests.h $(selfdir)/pidfd/pidfd.h
 
@@ -23,3 +24,4 @@ $(OUTPUT)/test_core: cgroup_util.c
 $(OUTPUT)/test_freezer: cgroup_util.c
 $(OUTPUT)/test_kill: cgroup_util.c
 $(OUTPUT)/test_cpu: cgroup_util.c
+$(OUTPUT)/test_zswap: cgroup_util.c
diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
new file mode 100644
index 000000000000..001533667322
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <linux/limits.h>
+#include <unistd.h>
+#include <stdio.h>
+
+#include "../kselftest.h"
+#include "cgroup_util.h"
+
+#define T(x) { x, #x }
+struct zswap_test {
+	int (*fn)(const char *root);
+	const char *name;
+} tests[] = {
+};
+#undef T
+
+static bool zswap_configured(void)
+{
+	return access("/sys/module/zswap", F_OK) == 0;
+}
+
+int main(int argc, char **argv)
+{
+	char root[PATH_MAX];
+	int i, ret = EXIT_SUCCESS;
+
+	if (cg_find_unified_root(root, sizeof(root)))
+		ksft_exit_skip("cgroup v2 isn't mounted\n");
+
+	if (!zswap_configured())
+		ksft_exit_skip("zswap isn't configured\n");
+
+	/*
+	 * Check that memory controller is available:
+	 * memory is listed in cgroup.controllers
+	 */
+	if (cg_read_strstr(root, "cgroup.controllers", "memory"))
+		ksft_exit_skip("memory controller isn't available\n");
+
+	if (cg_read_strstr(root, "cgroup.subtree_control", "memory"))
+		if (cg_write(root, "cgroup.subtree_control", "+memory"))
+			ksft_exit_skip("Failed to set memory controller\n");
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		switch (tests[i].fn(root)) {
+		case KSFT_PASS:
+			ksft_test_result_pass("%s\n", tests[i].name);
+			break;
+		case KSFT_SKIP:
+			ksft_test_result_skip("%s\n", tests[i].name);
+			break;
+		default:
+			ret = EXIT_FAILURE;
+			ksft_test_result_fail("%s\n", tests[i].name);
+			break;
+		}
+	}
+
+	return ret;
+}
-- 
2.34.1

