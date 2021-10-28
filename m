Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8E243E927
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 21:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhJ1UAt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 16:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhJ1UAs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 16:00:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0FDC061745
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Oct 2021 12:58:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v18-20020a25fc12000000b005c1f3933580so3448351ybd.2
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Oct 2021 12:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=aL9ForBXeqIt4axGE+MJntx+0cHbs1gItbc8kj8VTwA=;
        b=iK242DvbTA3vdISimfzLPV0oBXKg5wDnG2LSTdzxQlmZVUx9hkOqy0Phj04oNDpQf0
         f8X0Dj8lEfABj4r3D7lTSImo2f3VnMh/d2v8fVwD3Kv6pFOdI/5qjms/epVDFSs7CTpA
         EITRmLPqOGYHiHJw8bmACSOkRCB9DTBiYY7aETpEsi3+mxbIlnOfPShwLKGL9HODy8w8
         INYuwJPNdgXAiIstfpMv0ZLUq6X797UA3occ+/IT2caEsDvC7XoVH4RfLNNmOr0iqn4o
         lVkOb58XLQEuH6iFAWurtDmcjZWrQSaOUP/JecjxAMYbkTzc67pnx37jIspMMcNvWYwh
         /eKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=aL9ForBXeqIt4axGE+MJntx+0cHbs1gItbc8kj8VTwA=;
        b=reJbPw3uCJtKcZwhtr7NdmZf+3gYvYYZctZGUWjQzpBfNY/HNMvsvzIXsnts4yHoHl
         AgnPQdT6sZ5uweAyk0SSxepL0LH82I1z32As+v+rBUz25zdYHAc8N+pHEX1RQgpWxjhq
         eBXtZYFL4KDXIuE1R7jCEZJdMOrEeagAno84anpLtMu8P0MPvNO4PxwN2JbiCz9em5Bl
         b0ldfk38Hg2DHaOZp9Lq4c+TyYgzrUc5a4v8yskKj0xVheL+CnInpOQ7jNLiQ34oJkAF
         oH3iSbAXjYhPp47M4awL+ebyTrzTvVk59yvcVjkfrb5rXAC3aiQtX0Arshfom7O1ayG6
         jEcA==
X-Gm-Message-State: AOAM5322AlrzHCSqRBtmWBoiFkbwNY7mAkQjL55YGRwCK1i1EqxiW4IC
        WSv/NpE1ANKTfTFUWg+N9XC4Bq/S/TSuUUaWYQ==
X-Google-Smtp-Source: ABdhPJx//FjYoSzF9kQHCnJJLt5scSSG8QbWdBzunL9KbVJ/0PnHskFoUolLtZ1d8SkNtUgtn2Anvkt4Q5C63rP5Cw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:9b57:752f:2f0a:3a13])
 (user=kaleshsingh job=sendgmr) by 2002:a25:880e:: with SMTP id
 c14mr6965833ybl.55.1635451100900; Thu, 28 Oct 2021 12:58:20 -0700 (PDT)
Date:   Thu, 28 Oct 2021 12:57:57 -0700
In-Reply-To: <20211028195805.2684854-1-kaleshsingh@google.com>
Message-Id: <20211028195805.2684854-2-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20211028195805.2684854-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 1/2] tracing/histogram: Document hist trigger variables
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, rostedt@goodmis.org, mhiramat@kernel.org,
        Kalesh Singh <kaleshsingh@google.com>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Update the tracefs README to describe how hist trigger variables
can be created.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
Changes in v2:
  - Add Masami's Acked-by.

 kernel/trace/trace.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bc677cd64224..c41b3786401d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5628,6 +5628,7 @@ static const char readme_msg[] =
 #ifdef CONFIG_HIST_TRIGGERS
 	"      hist trigger\t- If set, event hits are aggregated into a hash table\n"
 	"\t    Format: hist:keys=<field1[,field2,...]>\n"
+	"\t            [:<var1>=<field|var_ref|numeric_literal>[,<var2>=...]]\n"
 	"\t            [:values=<field1[,field2,...]>]\n"
 	"\t            [:sort=<field1[,field2,...]>]\n"
 	"\t            [:size=#entries]\n"
@@ -5639,6 +5640,16 @@ static const char readme_msg[] =
 	"\t            common_timestamp - to record current timestamp\n"
 	"\t            common_cpu - to record the CPU the event happened on\n"
 	"\n"
+	"\t    A hist trigger variable can be:\n"
+	"\t        - a reference to a field e.g. x=current_timestamp,\n"
+	"\t        - a reference to another variable e.g. y=$x,\n"
+	"\t        - a numeric literal: e.g. ms_per_sec=1000,\n"
+	"\t        - an arithmetic expression: e.g. time_secs=current_timestamp/1000\n"
+	"\n"
+	"\t    hist trigger aritmethic expressions support addition(+), subtraction(-),\n"
+	"\t    multiplication(*) and division(/) operators. An operand can be either a\n"
+	"\t    variable reference, field or numeric literal.\n"
+	"\n"
 	"\t    When a matching event is hit, an entry is added to a hash\n"
 	"\t    table using the key(s) and value(s) named, and the value of a\n"
 	"\t    sum called 'hitcount' is incremented.  Keys and values\n"
-- 
2.33.0.1079.g6e70778dc9-goog

