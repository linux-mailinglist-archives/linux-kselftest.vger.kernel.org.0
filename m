Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2543550AC40
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Apr 2022 01:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442706AbiDUXrl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Apr 2022 19:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442734AbiDUXrh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Apr 2022 19:47:37 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3372B3C73E
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Apr 2022 16:44:46 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 83-20020a630556000000b003aa61747c38so3598413pgf.8
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Apr 2022 16:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=o1jm2ZxrobVfc+EDXZbKA8synQY3urRJFo8ts6M9Cos=;
        b=XNmIj+vh/zg85pOZ7hddsPc4rZoBWgPyUKppuibPQ8HpozXmQF4+KbncIhebNDLW+A
         OaXTK2I3Y4FSfd6Gk2xjKvidVm8LAaC0kUVGEo9TUpGjqdno7WSghhitFdSbSpl49CsV
         tN/y2CDjCmmhUJ5bWM3jDcayzcK/VRUFAN/fq1h0P/eGY5Hy+hXEJyzvjDolAnIyIh8w
         7uodhfP1m0/4SgHnVku88XUlvSW+55VzyEWrQhAUPNeD6F+CC6uOkZE3RyW5PPK9/T9U
         kH6ybVBPt6zTUU/GcTYAtffLbYejeX7CoHq85fV8abFrT+jgJziiU3RQIdVNZSFNsFws
         rRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o1jm2ZxrobVfc+EDXZbKA8synQY3urRJFo8ts6M9Cos=;
        b=4grLz5FDdi0/3E6PQtEmBFV/zH4KUiSLqaNINQH/qoP5jCwFb0xgSdp+WY+JXIXgdt
         b45QaDmKO+CdXjArF5KqnpdaxVSh5vI8VLa9ywdEsIQ0JGmxHTH1O3I+5CHSwkMqpdh9
         5N8m7tLJvepnbLdB9hx+OJ6lsXAj2UwXiiPkw+bAVuHw0Wb1oiIMd8vj1SEMgU3lZmu4
         Q4xux5FFy0e4/4650EwFdDvZ2ZQdQ2J7zEOfR/Op23singujiFN+s2baYe/wdCg2OzWw
         7wiQRCPJaE8edpRCXUMOrr0e7rUgFZ1PHZVZLMwuPYoxo+TUuorCSvOzE8rK0wOYikIU
         Dn/A==
X-Gm-Message-State: AOAM530p5KOc+vMOSaVi1FZ2aAYTsBjoOSHzBe9OPzECi87KZlBeceHk
        Y+oiDqYfAirwVj7+WfgZlqXDNvH8uappeFqt
X-Google-Smtp-Source: ABdhPJxtoageBQNYvSk1VtKpcFUVPUrVFQmq32PJxpSAW3BoTHti1Uz9DhnW0LOQD3FUjL5L64RLR2rvuttIZXXf
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90b:4c85:b0:1d4:bc0b:90eb with SMTP
 id my5-20020a17090b4c8500b001d4bc0b90ebmr2179433pjb.171.1650584685622; Thu,
 21 Apr 2022 16:44:45 -0700 (PDT)
Date:   Thu, 21 Apr 2022 23:44:24 +0000
In-Reply-To: <20220421234426.3494842-1-yosryahmed@google.com>
Message-Id: <20220421234426.3494842-3-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220421234426.3494842-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v4 2/4] selftests: cgroup: return -errno from
 cg_read()/cg_write() on failure
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     David Rientjes <rientjes@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, cg_read()/cg_write() returns 0 on success and -1 on failure.
Modify them to return the -errno on failure.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c | 44 +++++++++-----------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index dbaa7aabbb4a..e6f3679cdcc0 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -19,6 +19,7 @@
 #include "cgroup_util.h"
 #include "../clone3/clone3_selftests.h"
 
+/* Returns read len on success, or -errno on failure. */
 static ssize_t read_text(const char *path, char *buf, size_t max_len)
 {
 	ssize_t len;
@@ -26,35 +27,29 @@ static ssize_t read_text(const char *path, char *buf, size_t max_len)
 
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
-		return fd;
+		return -errno;
 
 	len = read(fd, buf, max_len - 1);
-	if (len < 0)
-		goto out;
 
-	buf[len] = 0;
-out:
+	if (len >= 0)
+		buf[len] = 0;
+
 	close(fd);
-	return len;
+	return len < 0 ? -errno : len;
 }
 
+/* Returns written len on success, or -errno on failure. */
 static ssize_t write_text(const char *path, char *buf, ssize_t len)
 {
 	int fd;
 
 	fd = open(path, O_WRONLY | O_APPEND);
 	if (fd < 0)
-		return fd;
+		return -errno;
 
 	len = write(fd, buf, len);
-	if (len < 0) {
-		close(fd);
-		return len;
-	}
-
 	close(fd);
-
-	return len;
+	return len < 0 ? -errno : len;
 }
 
 char *cg_name(const char *root, const char *name)
@@ -87,16 +82,16 @@ char *cg_control(const char *cgroup, const char *control)
 	return ret;
 }
 
+/* Returns 0 on success, or -errno on failure. */
 int cg_read(const char *cgroup, const char *control, char *buf, size_t len)
 {
 	char path[PATH_MAX];
+	ssize_t ret;
 
 	snprintf(path, sizeof(path), "%s/%s", cgroup, control);
 
-	if (read_text(path, buf, len) >= 0)
-		return 0;
-
-	return -1;
+	ret = read_text(path, buf, len);
+	return ret >= 0 ? 0 : ret;
 }
 
 int cg_read_strcmp(const char *cgroup, const char *control,
@@ -177,17 +172,15 @@ long cg_read_lc(const char *cgroup, const char *control)
 	return cnt;
 }
 
+/* Returns 0 on success, or -errno on failure. */
 int cg_write(const char *cgroup, const char *control, char *buf)
 {
 	char path[PATH_MAX];
-	ssize_t len = strlen(buf);
+	ssize_t len = strlen(buf), ret;
 
 	snprintf(path, sizeof(path), "%s/%s", cgroup, control);
-
-	if (write_text(path, buf, len) == len)
-		return 0;
-
-	return -1;
+	ret = write_text(path, buf, len);
+	return ret == len ? 0 : ret;
 }
 
 int cg_find_unified_root(char *root, size_t len)
@@ -545,7 +538,8 @@ ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t
 	else
 		snprintf(path, sizeof(path), "/proc/%d/%s", pid, item);
 
-	return read_text(path, buf, size);
+	size = read_text(path, buf, size);
+	return size < 0 ? -1 : size;
 }
 
 int proc_read_strstr(int pid, bool thread, const char *item, const char *needle)
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

