Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1824F8BB7
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 02:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbiDGWpP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Apr 2022 18:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbiDGWpN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Apr 2022 18:45:13 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9CB1546AA
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Apr 2022 15:43:12 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 138-20020a621690000000b004fa807ac59aso4045654pfw.19
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Apr 2022 15:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pAk5rXzYOgjs6QN7PF4DKfEiueSRXqJopL6r+G+SYMg=;
        b=qv/ZfWS96JL8ToxxS9HkzUsNxcgjDjomFpfz2944+t+BaDBFk//TDRRG0EQou1qHv2
         eqtDQoRcsXpquUS0GLLciQ+s6RJpZuc5N56AEikJDuC/RYBBajToGFWwv8SSCf70AJn5
         nAvqvnMqE3DpzvAAnlizcVl8NObJlzGhEZrLv1CqOzM7NbEyFhaP9l17bP/X/kcgXvqH
         Z383gcxcH0YzFx6TkICE9yiq1GpgaghTRTqqOm1KrLlQVkWbnwK1LdgyPxl33cFL/TQS
         APv0PQrKflod2nwRa68HyFfut0wbUsxWxrxhZDN+gvGGIijQIlAlL739L4M7oVvMtwlR
         WQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pAk5rXzYOgjs6QN7PF4DKfEiueSRXqJopL6r+G+SYMg=;
        b=I7uuk/RJgp1Mny4/CDcmt1R+MGZUicSgHDu3HEg5M4min4iYMmJB7MKUoRUzrLnEvG
         XVmNIk//iqEBTHe4C4ERsu03S2ALxgx5rcdyDWYFRwZLqNy6dISkZ8H3FAmDKlmmY4+6
         2JEwm0kMtGpBUdkKJuKs6vY4KSCXxU/l3mqU+iv+BQFTD2H7EGt5xcMhc0pucJehwv4y
         QJFiDUk0lJ4anwxOMdcKh76A1y233z2ojDMbWdPyNS8SLsKL6BqiOuy4L3sfjOxkICNm
         gEiHloEfXi7yXfvM0yf4BSKnlF6E2SIVZLS5UlWLlPOFBY0JRNXa+bc7BzMHHH4d9mzK
         BJzQ==
X-Gm-Message-State: AOAM531i/zJv+2bw/40ReCcPYbdwusUT4OYECPIsenekrv5GMa0HmXye
        YsUVvzc2118q4aJ1GR8cS6Hc+74zfmp9VWLA
X-Google-Smtp-Source: ABdhPJz/m6t1/bLDKPjThB/2Yt1mSc3IiH/+dngiTDVwURy7M/hstiNpOlv5+A8nC+3p1I4e1xSZSGYn6L82YpXb
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:b694:b0:153:1d9a:11a5 with SMTP
 id c20-20020a170902b69400b001531d9a11a5mr16223355pls.151.1649371391903; Thu,
 07 Apr 2022 15:43:11 -0700 (PDT)
Date:   Thu,  7 Apr 2022 22:42:42 +0000
In-Reply-To: <20220407224244.1374102-1-yosryahmed@google.com>
Message-Id: <20220407224244.1374102-3-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220407224244.1374102-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v2 2/4] selftests: cgroup: return the errno of write() in
 cg_write() on failure
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
        Vaibhav Jain <vaibhav@linux.ibm.com>, Huang@google.com,
        Ying <ying.huang@intel.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, cg_write() returns 0 on success and -1 on failure. Modify it
to return the errno of write() syscall on failure.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 tools/testing/selftests/cgroup/cgroup_util.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
index dbaa7aabbb4a..ef76db6026aa 100644
--- a/tools/testing/selftests/cgroup/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/cgroup_util.c
@@ -48,6 +48,8 @@ static ssize_t write_text(const char *path, char *buf, ssize_t len)
 
 	len = write(fd, buf, len);
 	if (len < 0) {
+		/* preserve the errno of write() */
+		len = errno;
 		close(fd);
 		return len;
 	}
@@ -177,17 +179,16 @@ long cg_read_lc(const char *cgroup, const char *control)
 	return cnt;
 }
 
+/* Returns 0 on success, or the errno of write() on failure. */
 int cg_write(const char *cgroup, const char *control, char *buf)
 {
 	char path[PATH_MAX];
-	ssize_t len = strlen(buf);
+	ssize_t len = strlen(buf), ret;
 
 	snprintf(path, sizeof(path), "%s/%s", cgroup, control);
 
-	if (write_text(path, buf, len) == len)
-		return 0;
-
-	return -1;
+	ret = write_text(path, buf, len);
+	return ret == len ? 0 : ret;
 }
 
 int cg_find_unified_root(char *root, size_t len)
-- 
2.35.1.1178.g4f1659d476-goog

