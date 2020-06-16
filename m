Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FBC1FA90C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jun 2020 08:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgFPGrr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jun 2020 02:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgFPGrq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jun 2020 02:47:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19E1C05BD43
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jun 2020 23:47:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y3so24083220ybf.4
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jun 2020 23:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rY8mLmisHjWy1FJ/edCX4pC2W+lemlUit54tKdWmG4c=;
        b=eP6QBUGwa7iE9veBVB488E9XSbW6RgnTJdBxJO+wT6o54RHljVgl+A3CITwHr8gLON
         PfnPz11VeEuGVvisiOQsjLo80bewfSJcEPQAwsHVdXAhPm1/Htb/FYU+vYRW/G/IUVWX
         4SUAcx0wuITm7pk1cCPLMI0iAQmh2Eol4ciJzAgcKPSXWYsp4qLlDrzg2VSUTVjGvDrE
         QLe9mPbjYCgVV8KrUWfqpTEbzRS4facU+WEapKgq5cvNSYZYdamicQVfOGbGm6AV2iSf
         jef5HN7zgUQAjZ4Jq4Gr1gMV9ZJk+Hx1zL87tEETTy5GfPGK5f/43daVz1f7PGjalTAQ
         Rhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rY8mLmisHjWy1FJ/edCX4pC2W+lemlUit54tKdWmG4c=;
        b=YgLfI1gDijfb9XTUcdPeiT+Oq7cfvtq7uT5vulBHTwpzTo2aTe6ktZPrStY2+BF24N
         Z6XRbLXG9jhPfDqUQaxYrEt7YzN8SPjPQruXrH4eXd9O3EsFGm1118J8HuJz2OFCKfb7
         OOkIdSnyO08T6gvtc70haiT/1+h2vbMsz+fltNx+qfKqsTbtkIlDlMlnCERm1jKMte4X
         OVRQfv/cx1PqOYCNdNmDrk+bEXPxXQlcF1rA63BQmldQoF9bgmb91qGFymNgI3SUAnmp
         6MRcFfFdQG4fqQgj9g5ybAOE0FheYb9wgbPBvGskVUpH3Y54R3rAXk1YQFR4Dm1vFub3
         hhYg==
X-Gm-Message-State: AOAM530W09T6HUM6UdHnSj9gJiv48XMgx/+/IN+Ntgf/QEgEzcEGXMcu
        dp6wzVzLdbR43+PSE0yVmeI5T/h1B4WnTw==
X-Google-Smtp-Source: ABdhPJyNOyWelBu1uraSPS7WDyezI/GDjB2D9r6wLSLmxn41Z6buzjfQlhIA8UL0JpC9xH6dNY9wtycb2OVPig==
X-Received: by 2002:a25:c507:: with SMTP id v7mr1841055ybe.306.1592290064202;
 Mon, 15 Jun 2020 23:47:44 -0700 (PDT)
Date:   Mon, 15 Jun 2020 23:47:30 -0700
Message-Id: <20200616064730.123871-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH] kunit: kunit_tool: Fix invalid result when build fails
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When separating out different phases of running tests[1]
(build/exec/parse/etc), the format of the KunitResult tuple changed
(adding an elapsed_time variable). This is not populated during a build
failure, causing kunit.py to crash.

This fixes [1] to probably populate the result variable, causing a
failing build to be reported properly.

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=45ba7a893ad89114e773b3dc32f6431354c465d6

Signed-off-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 787b6d4ad716..f9b769f3437d 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -82,7 +82,9 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
 					request.make_options)
 	build_end = time.time()
 	if not success:
-		return KunitResult(KunitStatus.BUILD_FAILURE, 'could not build kernel')
+		return KunitResult(KunitStatus.BUILD_FAILURE,
+				   'could not build kernel',
+				   build_end - build_start)
 	if not success:
 		return KunitResult(KunitStatus.BUILD_FAILURE,
 				   'could not build kernel',
-- 
2.27.0.290.gba653c62da-goog

