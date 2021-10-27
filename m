Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D766543D363
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 23:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244127AbhJ0VCk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 17:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244148AbhJ0VCj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 17:02:39 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C55FC061745
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Oct 2021 14:00:13 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id z25-20020a637e19000000b002a2d8fce9dcso2132816pgc.14
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Oct 2021 14:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=HUT1jrky2QfADSJBqDyxkAfRQl5Gv0by2m5wgHaMIGI=;
        b=mzwlor0IxbDrHZ832vmIGDKIRLJHzHXUSJ+qdT2DtWDviVCexFW2Qe8impwSet4coq
         S4aBLll36JwfUZ0gqCf5lbUBGExW7TtD/lNHf6y0uehgpOWapnxLldAKOjCrcOePTkm/
         mDL4xvBzxSu+0wFXm6YAi8zdjwMxqyhAQLYU35M4Be/Vmq0iVgdyPxtL6QT4WK/WoyBM
         fs1S5OL+TRwbXL5B71gULUE004KsnUgIC9LhxuM1/IYIu/iBAllYQcad9ifv0hbLwTSJ
         zqGvmhEGGDsWWeG1s+Wp2Slb9lC8V1rxGDo9GPrrnUuTJv6tA+Ts2ht8U7FSzyyTxwx3
         g5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=HUT1jrky2QfADSJBqDyxkAfRQl5Gv0by2m5wgHaMIGI=;
        b=kJ4ZB5cKhuySHTxv2BQxyOHmmefTlcbU6aZSEB9mswP1Cw660NGiN2+jYagPickYXP
         iaAzlp+9S56x7wETjNJYWkLG4rbZTdqA5BHq4dEDrzUutJ12SqJm4AZatMAtXJu5T/zX
         dvgDT35KFr8GIFuFm/V/tz4GFEhIKHsLvJNLCZBY6u9Scj9MvSEuh+CJ2nG3GJr8aaQN
         3ObPkIwcCc+huUzStB6r5kaV2zau3ZOCknJjyZ0NnEx1qqpwZrwmdMLaPhkBiqs3WNnE
         STHCehc7QEto53fzXp2G9e94y6WCdD+nz3bjHxcZ9sSWiXgR/MpMZm3qNfGMAeQ5SqaN
         6tzg==
X-Gm-Message-State: AOAM530zWB/lsaZ2LHapI1CX7CUZKMrtwZaIq/0I6ZF9YP639E2ecgk7
        CxIRPdjlgrCgnoKExFcabPu4hXJIytsm7K3sNA==
X-Google-Smtp-Source: ABdhPJyt1iASH+IucgMJThPeB51NN/4FBps+l+So2s0vMdIMzts3wP5OX9ju5lRJ6tRUzwOJXqQYArg5WvNtJO4qjg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:ac51:b6be:9b51:3a7c])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6a00:2387:b0:47c:134e:4848 with
 SMTP id f7-20020a056a00238700b0047c134e4848mr37555pfc.74.1635368412797; Wed,
 27 Oct 2021 14:00:12 -0700 (PDT)
Date:   Wed, 27 Oct 2021 13:59:09 -0700
In-Reply-To: <20211027205919.1648553-1-kaleshsingh@google.com>
Message-Id: <20211027205919.1648553-3-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20211027205919.1648553-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH 2/3] tracing/kselftests: Remove triggers with references
 before their definitions
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

If an event trigger references a variable defined in another trigger, it
has to be removed before the trigger that defines the variable is
removed.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 tools/testing/selftests/ftrace/test.d/functions | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 000fd05e84b1..bd9e85f4d626 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -22,6 +22,15 @@ reset_trigger_file() {
 	file=`echo $line | cut -f1 -d:`
 	echo "!$cmd" >> $file
     done
+
+    # remove triggers with references next
+    grep -H '\$' $@ |
+    while read line; do
+        cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
+	file=`echo $line | cut -f1 -d:`
+	echo "!$cmd" >> $file
+    done
+
     grep -Hv ^# $@ |
     while read line; do
         cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
-- 
2.33.0.1079.g6e70778dc9-goog

