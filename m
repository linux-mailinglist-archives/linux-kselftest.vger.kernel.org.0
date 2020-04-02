Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B422C19CBE0
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Apr 2020 22:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388822AbgDBUqy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Apr 2020 16:46:54 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:57301 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388698AbgDBUqw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Apr 2020 16:46:52 -0400
Received: by mail-pf1-f202.google.com with SMTP id s8so3999501pfd.23
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Apr 2020 13:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=onaohHgaOvnldbVkQ7ukvTTvpY4LJI7aLjqWlCpDam4=;
        b=uLkmlZPnWV4hIizE3xdRyl/uYalR5pRcYYHR1n6kg8gpU9EfdCTxwDlYMTffAMRXpb
         51ZQ5abBrghVfVMjA65lfSSDa209mCM92O4D3d08fkulyUxqEny+g1MFcNKteeOHVsiX
         9ZolEaJqGlMMdjefGrRQTwgAcBixIiJE3IpV5mP1/7QJS/hxZ1BuTcknj8lVmnr1p85B
         rmLZKzuu5i3ad24BnwGhykb1GhGV/iqfu+9/FMIYPYEnEOGTgTxNhMI6HK/vGPL+QTJy
         0uMZPhALmfH3QQFJk9WdxHXCC1Mbp7k8KekCafO7ur+8Oob5VaeXIgbPBaHdhhMP1+XP
         FphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=onaohHgaOvnldbVkQ7ukvTTvpY4LJI7aLjqWlCpDam4=;
        b=LFTQqDf8A1eLQaKXItd8HcQJBZuPMbNtBciJjVF2BpU76M8WOdH7B18tlecsEN/rZX
         hMGenPDfWrgXwQy0Wy2E6li5ItuHvk7Yb5ZQ4u0PEFDHAi4FDbVeCbYVdY67mbTNL0LK
         jkDrMnqTipnnKLTNY5yD8AoBCr73OFi09lzl7t1MUNd1cqGJx5zmQvK+imRW8RQQdCoM
         KDUuoNWIoRkt7HUCjA/0Yv+xuqzAspRwCxhYn/4Yl+ahK4NtG3fGcrbh7TmxCpfKW2W3
         1YRjJhfyr7rubfbiNXvrxuiCEyrktDb09Li0eEFYarABf7vAmkYRbmxmAVj7WZ9sfRtZ
         VsHw==
X-Gm-Message-State: AGi0PuYLmAF4HazdbBv0bN+VvqZryV/qmEWdkxliIfu7GrAzryLhpkr5
        Vsrms2bkQcQulqNx+EtYD79kCy1Unkidql/b8iM=
X-Google-Smtp-Source: APiQypL6WJEPfVj8ECTyT+JSoqDa473N80tBf6hRWZ7qWqp2yq3gnBihUQDEqfd0Gm/MAfHVuwI7Bl06FiAE8BCbCV8=
X-Received: by 2002:a17:90a:d3c7:: with SMTP id d7mr5575934pjw.169.1585860410527;
 Thu, 02 Apr 2020 13:46:50 -0700 (PDT)
Date:   Thu,  2 Apr 2020 13:46:38 -0700
In-Reply-To: <20200402204639.161637-1-trishalfonso@google.com>
Message-Id: <20200402204639.161637-4-trishalfonso@google.com>
Mime-Version: 1.0
References: <20200402204639.161637-1-trishalfonso@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v4 1/4] Add KUnit Struct to Current Task
From:   Patricia Alfonso <trishalfonso@google.com>
To:     davidgow@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Patricia Alfonso <trishalfonso@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order to integrate debugging tools like KASAN into the KUnit
framework, add KUnit struct to the current task to keep track of the
current KUnit test.

Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
---
 include/linux/sched.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 04278493bf15..7ca3e5068316 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1180,6 +1180,10 @@ struct task_struct {
 	unsigned int			kasan_depth;
 #endif
 
+#if IS_ENABLED(CONFIG_KUNIT)
+	struct kunit			*kunit_test;
+#endif
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	/* Index of current stored address in ret_stack: */
 	int				curr_ret_stack;
-- 
2.26.0.292.g33ef6b2f38-goog

