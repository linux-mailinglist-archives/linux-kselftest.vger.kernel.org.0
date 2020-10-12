Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6A928C4AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Oct 2020 00:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389276AbgJLWVm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Oct 2020 18:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388999AbgJLWV3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Oct 2020 18:21:29 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A9EC0613D1
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 15:21:28 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id j17so13271701pgj.10
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 15:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2FPAJ4JOdoCzsWC2I93Vw1itU3Hyew78gghPY3DsZ34=;
        b=J/TNk3ROP2i9NV5ARtO1ok14A61R1Sg80iF+SLTzg/Y2GSueMy7/R1Mybj0K4q/eKP
         j8tqmHDAphmeDThQ1XJrwgDIGrRl45hVbeWulOsh9GPzdMbgo6MINccRoxBhfoRnGQr7
         ATQz/SfDmvdTi3ZLxNjtWpBfLGEAEz+W/ANtM51fMq/AjVdC2mIsWX5NSo6XWWid2SVR
         X4fuqgCT5rNIST+KYNTBvo3Aw79QFU1kXh5UdpveLdVZz5YbljpeUkR+VCZoGeqItYrq
         K7JQ7Rhr6jl2bYYYNTiCd/hBjyjY1rd98VNs50mVLh2Us/aKsOX+a/apn3nqyPy+7cql
         jKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2FPAJ4JOdoCzsWC2I93Vw1itU3Hyew78gghPY3DsZ34=;
        b=i6KpG4bMKH/jPpy5h8JM13WU3Ma+PTqoM6DcjG0mTLYaJVKRzjGN0ugE0BCu6vlTuK
         tXBXHy7deZoVUaFJcJQQenLrBkbJjQ4vv2Qh9jQ93n1Ee4R6nLJIwHLb++/jMQTNc3Bi
         1d8ulqM//HsfFMqzI972gguElMqM5yQlvxYKS2u/1Cmg5f3Vkmqo2+lIQNWWCUnxmf/Y
         Gg9MIMvh7qjYFU+gKJWTfHrdyaO4Tp0l9cyKToooLVD7uaO3YrE2/0v8SzpTWXA9x7xN
         v/+Ts7KrkOvMmBVlin1KK4E0LeJLeRpO0VZ+kH1GhNjiTA+YyIqc2n6UV1c7sxXD5KEi
         7kOg==
X-Gm-Message-State: AOAM533LqaOhWQHqKioslX2Cu7ClW3XYHXw0k+NndfsvkbjHeDbALdI4
        sYV5Ybu2UIVX7N5kmoQICsa0Duo4ZnHrxQ==
X-Google-Smtp-Source: ABdhPJzne7N1vHKS4tz8oSTlt6o6aJQMscjj3GawvyrILDpXPgDbP8dhDhW/mzIbUhLC95qpouzc/tRuzHZTcg==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a17:90a:f3d3:: with SMTP id
 ha19mr22246220pjb.58.1602541288393; Mon, 12 Oct 2020 15:21:28 -0700 (PDT)
Date:   Mon, 12 Oct 2020 15:20:44 -0700
In-Reply-To: <20201012222050.999431-1-dlatypov@google.com>
Message-Id: <20201012222050.999431-7-dlatypov@google.com>
Mime-Version: 1.0
References: <20201012222050.999431-1-dlatypov@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [RFC v2 06/12] kunit: expose kunit_set_failure() for use by mocking
From:   Daniel Latypov <dlatypov@google.com>
To:     dlatypov@google.com
Cc:     alan.maguire@oracle.com, brendanhiggins@google.com,
        davidgow@google.com, keescook@chromium.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mcgrof@kernel.org,
        sboyd@kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Being able to fail the test outside of expectations and assertions is a
requirement for new features, e.g. mocking, dynamic analysis, etc.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/test.h | 2 ++
 lib/kunit/test.c     | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 0eb3abb00da4..05330593243d 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -233,6 +233,8 @@ struct kunit {
 
 void kunit_init_test(struct kunit *test, const char *name, char *log);
 
+void kunit_set_failure(struct kunit *test);
+
 int kunit_run_tests(struct kunit_suite *suite);
 
 size_t kunit_suite_num_test_cases(struct kunit_suite *suite);
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 4e8c74c89073..1ccf6dbecd73 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -15,7 +15,7 @@
 #include "debugfs.h"
 #include "try-catch-impl.h"
 
-static void kunit_set_failure(struct kunit *test)
+void kunit_set_failure(struct kunit *test)
 {
 	WRITE_ONCE(test->success, false);
 }
-- 
2.28.0.1011.ga647a8990f-goog

