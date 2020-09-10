Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772C5263DFB
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Sep 2020 09:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbgIJHFV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Sep 2020 03:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730288AbgIJHDo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Sep 2020 03:03:44 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B1CC061786
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Sep 2020 00:03:44 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id e6so3495917qtg.13
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Sep 2020 00:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=W2nrS/kBK4lWw8uYN1BB5WUGx+sqFHBHeS5Oy6sIX6M=;
        b=ecV7GTgPDsG/kApsANDQzCfbg0cEbu4YIiSd36Fb/L+RAwrNpvp/FUFv/nBGuALrML
         pJRzm0dq75dEmTd0SdXVvQC6D1BeKD2mcUuQhJQjWXX7OJKSrRJ3qMBdCbNVTIRPXotv
         vfTA6wz65eudtK2ZmK0w78GFHF05VRyUE/YIEjgBXUVK2aD7YooMd3U0tgjzXetoSLhq
         IdSN+uK8VTaxz2keWnRS6y3jNhlRkR7YnxhzbZocEAaqTtAuNjHa5yQBG2wWFbpEPeCW
         2OLZmM9N0cXkodbwtwpwxmG9DtcYVY9J8vzszCBKAeFO1zVSB+6jHYq2YYs0SPxcbw4B
         olnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=W2nrS/kBK4lWw8uYN1BB5WUGx+sqFHBHeS5Oy6sIX6M=;
        b=DPqKpgoxsK8LwfdeNJvVKGEVCE7eIwLbQZcqCG+RXOQrUy145JNFVWOyoO59Fc9s6L
         6BjnKAegKl3OwVJnJgWlNcBQ+SjXmj1kS8QtWvWN6DMnCTTgqtxgMDUdYhIIdCtca/eY
         Ckbdrw8LvFk+sdRZ546cKZw21Dm27UsgSj+5a608DZ4DAL0odhc5E/97+e3CiP6J7Lmu
         OhrAiiYTgYlDudik50i205MrSUHc1R4DpvpxLEVvfze91I7yIn/uGyKauPO5lbQCpjLl
         CJ22fsJHP6sZIDSx1TPMCX3cW8aEx5VPhFG6eSUmqGnZfTqrWP4Gf4+6Hn1b031QVwX7
         XdDg==
X-Gm-Message-State: AOAM533uKyzCdGEQTgXq4YssH9/A8NctOtw31kaTfTd1kbOQHWNm4T1w
        5bcntyMWZB9WYspR5SKKt9xWkOZ/NB5yRQ==
X-Google-Smtp-Source: ABdhPJzXpkB2ckKT5eUysvFRDlrYdivhKP1T1o74kG0EOhhSSnmL7Z3PI7l2Fxsys3P2CKihUDCs2QOYTTDF7Q==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:42a8:f0ff:fe4d:3548])
 (user=davidgow job=sendgmr) by 2002:ad4:5a53:: with SMTP id
 ej19mr7590337qvb.54.1599721423196; Thu, 10 Sep 2020 00:03:43 -0700 (PDT)
Date:   Thu, 10 Sep 2020 00:03:26 -0700
In-Reply-To: <20200910070331.3358048-1-davidgow@google.com>
Message-Id: <20200910070331.3358048-2-davidgow@google.com>
Mime-Version: 1.0
References: <20200910070331.3358048-1-davidgow@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v13 1/5] Add KUnit Struct to Current Task
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, andreyknvl@google.com,
        shuah@kernel.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Patricia Alfonso <trishalfonso@google.com>

In order to integrate debugging tools like KASAN into the KUnit
framework, add KUnit struct to the current task to keep track of the
current KUnit test.

Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---
 include/linux/sched.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index afe01e232935..9df9416c5a40 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1203,6 +1203,10 @@ struct task_struct {
 #endif
 #endif
 
+#if IS_ENABLED(CONFIG_KUNIT)
+	struct kunit			*kunit_test;
+#endif
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	/* Index of current stored address in ret_stack: */
 	int				curr_ret_stack;
-- 
2.28.0.526.ge36021eeef-goog

