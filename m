Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C895F4401F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Oct 2021 20:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhJ2Sgj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Oct 2021 14:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhJ2Sgi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Oct 2021 14:36:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94D3C061570
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Oct 2021 11:34:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m78-20020a252651000000b005c1f44d3c7bso7970510ybm.22
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Oct 2021 11:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=93iwUDOobBuls+/E5vDDQ4gbsROtaRql+3ZjfJ57cYg=;
        b=QoWnKrdqlxAbjyByCl565yFgv7LbAxVEc9fWHpV7QHaZFLrCfCW0jqXuk1TP6EyGVC
         cYAFFnejyfTMEmIs2d3ZqUbS1lJVfB3UI0Qrg6hCPDLOLWTXr1bD+cefwT8dMsIiTEqU
         UIOOTbDRosaY9j42FqnnygRFjwNTsC1OkJiqjnjmIlH7pJd7oRBBPAZ1upYbctfWZBQj
         eRZ4bzqvdE/T0FHzvkKJg1HQUrOOAO820ygOZqL8zZHIew8BjPFuAdPjp5m67cgN0lMB
         1F+yvzVPmR68OngynN9I3P+R7lal48E3sLDPV8F/+yml38UYWQkSzAS3uiXMHi2bxjvi
         X8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=93iwUDOobBuls+/E5vDDQ4gbsROtaRql+3ZjfJ57cYg=;
        b=iMFiSoEp9GKdupZ80yVngxUl1FkjlWBgn2F9ftANzr0DBzagKPl+AwakzDZRfeJ95l
         BjYrqSFkqOdJbBTccpH1F8LgknnS/8MLgjD+WZ/uRI2WGvkfZhPNqBfiz6vAqT4lmxP+
         H5l7tCQUP7VysINo7pPWqluwR7qqdAfZL2xOs39ftobW/PQYPEzZE+6spajOOEGI1uBg
         fkbGV+FJkqU8BW/psQO6mmPrTQj3OA09VP3YqDGj+x9WDNl0WNqxSr+f/oV7Z9WFD87n
         Epz6B+kSJvXX5OwCrBpjCg9DrjLGghM5+xm/P0NxYi6cKr8AxqJHwK/KiimKGT1DrAsQ
         Civw==
X-Gm-Message-State: AOAM530zKnj8GR41ImxTZu/BVZLrXPzz/kWTQCSaHjRmYzyUohswUC9d
        hOm54tOaAmlttnjyV/PzZNjOhKfUglORHWjnUw==
X-Google-Smtp-Source: ABdhPJyHZxfyrH6eLpocM017hIpzAqnbrDsn4QA+ZJuqOtZZeAOQQ5gqFAXj+xLsHy4p8JwjyIombNa5Rhgjz7XYbw==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:b03:1d88:1cf2:4973])
 (user=kaleshsingh job=sendgmr) by 2002:a25:d393:: with SMTP id
 e141mr327060ybf.244.1635532449020; Fri, 29 Oct 2021 11:34:09 -0700 (PDT)
Date:   Fri, 29 Oct 2021 11:33:28 -0700
In-Reply-To: <20211029183339.3216491-1-kaleshsingh@google.com>
Message-Id: <20211029183339.3216491-3-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20211029183339.3216491-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH 2/4] tracing/histogram: Update division by 0 documentation
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, rostedt@goodmis.org, mhiramat@kernel.org,
        Kalesh Singh <kaleshsingh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If the divisor is a constant and zero, the undeifned case can be
detected and an error returned instead of -1.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 Documentation/trace/histogram.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 66ec972dfb78..859fd1b76c63 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -1766,7 +1766,8 @@ using the same key and variable from yet another event::
 Expressions support the use of addition, subtraction, multiplication and
 division operators (+-\*/).
 
-Note that division by zero always returns -1.
+Note if division by zero cannot be detected at parse time (i.e. the
+divisor is not a constant), the result will be -1.
 
 Numeric constants can also be used directly in an expression::
 
-- 
2.33.1.1089.g2158813163f-goog

