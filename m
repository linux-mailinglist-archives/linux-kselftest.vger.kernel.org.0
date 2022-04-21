Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF2B50AC3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Apr 2022 01:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiDUXrn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Apr 2022 19:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442745AbiDUXrk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Apr 2022 19:47:40 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E81047078
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Apr 2022 16:44:47 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id u5-20020a63f645000000b003aa5613d99cso3604642pgj.5
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Apr 2022 16:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zrjgrKYnU6OpMbvPqxH4AMaOafcQPI/dEJCu4TPzq/A=;
        b=R5EgEEFiJLJPylJr1GpRvnGVqN1ompyECMnvFf7eJcNcIBFBfprXXAft0A/RmwaXeD
         sbaE02S2hM0MhJlnoYl4BZ6GwzLLyFeyoaeyfYlebGdZNk2FJqWy0CBTgUDnhS3IZByt
         vQWqicHWsomUI7gHz2Tvt1gFymu5ka/dsdDO3KlmWLi1mH5fKV33sBgHm0V9J9vTRadg
         6MpPFs5NAnuJf5761TBNcYgccwJrkDqvgaOAsSc4lC0uYWWC70kYneQqFgmKZ/IoeuvU
         TVc1vZldKVcLP7xe8H7/pcshpA4uONKuKc7K/n5XrtPuudMkt4mzmX1nR+nSRuafWS5v
         ptTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zrjgrKYnU6OpMbvPqxH4AMaOafcQPI/dEJCu4TPzq/A=;
        b=7UbA1IMI8SGmkxTYe4n9pltREnUVvsBBJCQRqs+QUTNhW9CNtqiFfVgBIp62HWrM31
         PZEwMLJ/kxBaTatdTB+tllmt48NwdicmTbuBP3YYNcwFpT7GZ8EFhyo7NEUy0PzJH6xs
         zjx321Sil36k9IDevUZoyNW2Ot8USRA57NIaVsUwgXUaj3qorSLFBxtdIi3mOxKrbiPX
         m8pgStp6MtC2dl+QEihA/AUGeTdPKEgZY0HW5RummL7djioZLwMq56UJ90Jpe9LQdFeB
         J9vzTQrh3xzaH9cSGAwPCYR2XmXXOnKswTj1IRfJqwzhrGitPcGGIxMgRqakBWuKEFDc
         KY3Q==
X-Gm-Message-State: AOAM531oWVfNprAzI+1UcFjPgZX2UL7ZA6wsFQflBTDPFIfqdA7F4Trf
        XJc/QdTX2wv9v82l9yrqLoqqakbAxSgitz+C
X-Google-Smtp-Source: ABdhPJxkyS9552eyRbp5WO6d5madi5NDuaVaOduz7euoUqf8KeXnSqt/NpxhsWB/Uh+lm1g3ddmKZu3hnmlshvfN
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:f391:b0:158:f1e6:7233 with SMTP
 id f17-20020a170902f39100b00158f1e67233mr1863993ple.133.1650584687052; Thu,
 21 Apr 2022 16:44:47 -0700 (PDT)
Date:   Thu, 21 Apr 2022 23:44:25 +0000
In-Reply-To: <20220421234426.3494842-1-yosryahmed@google.com>
Message-Id: <20220421234426.3494842-4-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220421234426.3494842-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v4 3/4] selftests: cgroup: fix alloc_anon_noexit() instantly
 freeing memory
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

Currently, alloc_anon_noexit() calls alloc_anon() which instantly frees
the allocated memory. alloc_anon_noexit() is usually used with
cg_run_nowait() to run a process in the background that allocates
memory. It makes sense for the background process to keep the memory
allocated and not instantly free it (otherwise there is no point of
running it in the background).

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 36ccf2322e21..f2ffb3a30194 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -211,13 +211,17 @@ static int alloc_pagecache_50M_noexit(const char *cgroup, void *arg)
 static int alloc_anon_noexit(const char *cgroup, void *arg)
 {
 	int ppid = getppid();
+	size_t size = (unsigned long)arg;
+	char *buf, *ptr;
 
-	if (alloc_anon(cgroup, arg))
-		return -1;
+	buf = malloc(size);
+	for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
+		*ptr = 0;
 
 	while (getppid() == ppid)
 		sleep(1);
 
+	free(buf);
 	return 0;
 }
 
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

