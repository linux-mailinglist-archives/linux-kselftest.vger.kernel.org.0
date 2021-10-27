Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FAE43D361
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 23:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbhJ0VCZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 17:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238798AbhJ0VCZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 17:02:25 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD02C061745
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Oct 2021 13:59:59 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id v14-20020a05620a0f0e00b0043355ed67d1so2531316qkl.7
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Oct 2021 13:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=0GIbMz2nXytWEz1I//ilSEDA+vtJktC6KJwGcIeR3HQ=;
        b=WqC05lhqiNrvpuMTIPv4xuxZe1CYBGBTK/Dju6//MpTCOO3cE9JTJQS8+4MSbiH4ne
         fF+WTJ6eQ9HYI08zSQQERMu3qFzou499RsN2dcG97QC3ryg+rstVgT3ac+cAOsJo4t6/
         fkQ24AbgXBerzeKy1TLX2fSKIjhvUQ05W7ZlSsC2YzKBhwuEikTYo65yhsIJW/OIkznQ
         CwzQP2KjtCDpEQp8Q7JIwoNjguJJDnLF1tnyuR51QARzXnltts3q4KvHf3LUxt1Z2Yl1
         OjHoZEoaw+Mah+eIxDsaxViRL2GifZNf6GUL75xKTN2ftJ+9L4mrz7zsxADz6UnoSgV5
         GytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=0GIbMz2nXytWEz1I//ilSEDA+vtJktC6KJwGcIeR3HQ=;
        b=TwKjA5sbVNLZd8XUJGH0QPvlqdQiH5BbG2hHVJccAXjVYpBULkVIdhO6uUHTUM3aCD
         RHlAhFSE5nTnEbLs2H+6BOt4agDUcwFLa6/4YRgtPj1VQ1ZDPa8UfF+IKMmEAXdgmwTO
         DY001d2FRViDA4nWNkvDYl9XqqcpJy2rV/O4vx39WEYDgjB9HDHCdJCxn2aKsNXhFqEV
         CzDPUj5Fztu86nQr5ixxI96RpozZ0e8Py2k6842/o5o1DpN79NMVFZexepxaHeyyqKp4
         FW1QBPcpty0hOCf+X3yUdwl5gC7jjX/JBlMmPZi0YV3zKpuhqA2Ti2XP4cuqkbFw6yj4
         SXqg==
X-Gm-Message-State: AOAM530fDx+YYzLbRW3ql9L0BfjhvtYwnY1wfdoPi3hh8NWxc2klzLLq
        H/lUJfdsOHXK0sFAy9S4Z8lCM4wUj9qK/7J10Q==
X-Google-Smtp-Source: ABdhPJxDwW2S7YdUya+jCM5lkK9C0VdJjk4Vq1uieuMPS+sXbR9F9YxF+rPyacRwAxu4kvLVzDCY1qBTzybkFJvdvw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:ac51:b6be:9b51:3a7c])
 (user=kaleshsingh job=sendgmr) by 2002:a05:622a:50a:: with SMTP id
 l10mr127848qtx.73.1635368398653; Wed, 27 Oct 2021 13:59:58 -0700 (PDT)
Date:   Wed, 27 Oct 2021 13:59:08 -0700
In-Reply-To: <20211027205919.1648553-1-kaleshsingh@google.com>
Message-Id: <20211027205919.1648553-2-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20211027205919.1648553-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH 1/3] tracing/histogram: Document hist trigger variables
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
---
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

