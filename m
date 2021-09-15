Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA8840CD94
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Sep 2021 21:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhIOT52 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Sep 2021 15:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbhIOT52 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Sep 2021 15:57:28 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AF1C061575
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Sep 2021 12:56:08 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id k12-20020a05620a0b8c00b003d5c8646ec2so7118463qkh.20
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Sep 2021 12:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=1D42zcUJP7Yd1OBpScfym6RyYgwjdXqxQ6ExRKg2hiA=;
        b=Qh0v9EKYh48K68psvZw/Otnu1Zajri6jZtVWAmAzRMbjKkXMNn7aUytL84TkGc35Zi
         jQkaUW8s37BO+r9+CjdYmuoh7FtOt1xKAj8a1JzrU3AwROGOoFkD8kB6uemU5my+CBSO
         0OL2auP8TMx/9JFv4TCUyGCUqlM7LRyrHLCDbLHqtr+LLHQvR35GljwU1glAgjF0S83c
         wEoOzRecOUU9v83n0SU2CvxBeDGyTpjnoGaT/ZxSz5gXOEMEpq87pPp5df5kR6VR8dnt
         XyGdFE3sQ8LTIgxkHbltYDGsQ7scPikxhX1P8WIz5ihyIriym9+y4KmX/yrWgllYIoYC
         vjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=1D42zcUJP7Yd1OBpScfym6RyYgwjdXqxQ6ExRKg2hiA=;
        b=0+NXHAp1ofJS69PI93gV12VF2uyGYx11xND6EU4mCqYNROeCwAll1MdhXrc3IfS4W9
         Cn6qPxLiVTpKEjFzL8UKLClLnPaFaQHIPd7R5sdDWp/WiU0wF0Tw4Ysori44ybhv0cwU
         zt9DL4/VSWeabI+7PTKcuKkeTu4xCy19bi1g/VS3X+tlOR88BZbyDlJy1dMwY5/YWZf4
         2CPJuCqv9+XKFeXd15/IHNaOd+Yp1jSH5eE0uo3r73QsEj08Vh39K/97iRg1QgqU/6tu
         /WS1BdjgrcvU9tvew4RORD/GC9ZkQLFyeDA3qgp/61FhUeEp1zbT7a6f2lIA2qiFtPyz
         W0XQ==
X-Gm-Message-State: AOAM531r2VJrvWPkU8EKlpYrWwZbWG9/NFut7JcGE4FY0aO14KwVp5mq
        huHtnxJHgv3/pJevmg3i5sRUxQy01cv+0ZPADw==
X-Google-Smtp-Source: ABdhPJwstirmxKy545qmG+7yGZJ8nD+HM/bCVTLS993GeQPljENqko1YZQK4YfHdcV2F9a4mLCkNhctIjasPMFiD3w==
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6214:1142:: with SMTP id
 b2mr1799508qvt.0.1631735768059; Wed, 15 Sep 2021 12:56:08 -0700 (PDT)
Date:   Wed, 15 Sep 2021 19:52:49 +0000
In-Reply-To: <20210915195306.612966-1-kaleshsingh@google.com>
Message-Id: <20210915195306.612966-6-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20210915195306.612966-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 5/5] tracing/histogram: Document expression arithmetic and constants
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        Kalesh Singh <kaleshsingh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Histogram expressions now support division, and multiplication in
addition to the already supported subtraction and addition operators.

Numeric constants can also be used in a hist trigger expressions
or assigned to a variable and used by refernce in an expression.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 Documentation/trace/histogram.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 533415644c54..e12699abaee8 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -1763,6 +1763,20 @@ using the same key and variable from yet another event::
 
   # echo 'hist:key=pid:wakeupswitch_lat=$wakeup_lat+$switchtime_lat ...' >> event3/trigger
 
+Expressions support the use of addition, subtraction, multiplication and
+division operators (+-*/).
+
+Note that division by zero always returns -1.
+
+Numeric constants can also be used directly in an expression::
+
+  # echo 'hist:keys=next_pid:timestamp_secs=common_timestamp/1000000 ...' >> event/trigger
+
+or assigned to a variable and referenced in a subsequent expression::
+
+  # echo 'hist:keys=next_pid:us_per_sec=1000000 ...' >> event/trigger
+  # echo 'hist:keys=next_pid:timestamp_secs=common_timestamp/$us_per_sec ...' >> event/trigger
+
 2.2.2 Synthetic Events
 ----------------------
 
-- 
2.33.0.309.g3052b89438-goog

