Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C844C2948A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 09:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395140AbgJUHQN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Oct 2020 03:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394593AbgJUHQN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Oct 2020 03:16:13 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CAFC0613D4
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Oct 2020 00:16:13 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id d16so839225qvy.16
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Oct 2020 00:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=o3AeT4jhmaAGtCcg59SA4YDqldF6/B2ILaDP9JPf7io=;
        b=RCz8D3HThvOtGZ7oHWqKITCgloC233W7AgYBP6A27M051XCOx80NCXQTnCvm3Q3ngk
         yGQHJo6cBCjBwo4bjUHmc56X4wkwHCOCuzuVzefr6egIsRBMiff/ugvIPO5bKg+pGGFD
         abM9jGE9NaXHDC3cbDywFqj86xt09c+nCfyagu/tUs3YqvZzYQffMXGA8KrawlJJDGWZ
         fGOVADIn7w8WL2+hPTJEopQ7Vzq5MjXIai0DJvp8GXJB1CCJc4X5wEy+WBljqbYezlDK
         YfP9GnuuSttu4eHkNnP2lhu8/WK3RUTb+3CBdrTQyppIdp3X02rxrlOcf8hRZNXGhfWl
         Mkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=o3AeT4jhmaAGtCcg59SA4YDqldF6/B2ILaDP9JPf7io=;
        b=MM5YsrScrJyVKsUGC9wT2kaYXCwv9hn8144g9xdPKwigenpEXP6VjvVjOMDmPHOkDH
         xIYZfFWZwKpUCCrNkOBQllabKI68acrNGhidpYF9+R/Y9PcQ90WrwySJvcuWDgjAXSWm
         prUtmejZOyxMHmG+p6Cgp0PF1Zp+apYUiO4cTwS4I7oGLne7t4cvyGyOUzDA6KaEOJws
         CDF5LiKGiIDmuUml0QY/NNNDk+5Kte0WjWLz65pBstgJnsKyVpHJlpHBxOEdy9ZHWyGQ
         DKNo+qn1Yo+cVrGFMovwhVn1oq8ltX0rRAn8ZPnSrsq1WHP6l6dg1iHBPgnh4oeXXtJ8
         bQPw==
X-Gm-Message-State: AOAM533LqWnAaVuZ/7N9mVRkN3KTOC06ZuINu7FB68uNf2K8i/OU918y
        8uaiyVeyg6Mh3iH/UsJQGFcI4B9w23z7ww==
X-Google-Smtp-Source: ABdhPJyo2rGxrbCSzrvoNvAO2k2ZRVKy/WYS+Oz08PyWkeaJXHH6Fpe+Rxunm4mPKpUp4gHjFapXkvKpMA1MwQ==
Sender: "davidgow via sendgmr" <davidgow@spirogrip.svl.corp.google.com>
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:42a8:f0ff:fe4d:3548])
 (user=davidgow job=sendgmr) by 2002:ad4:4eaf:: with SMTP id
 ed15mr1702288qvb.40.1603264572501; Wed, 21 Oct 2020 00:16:12 -0700 (PDT)
Date:   Wed, 21 Oct 2020 00:16:03 -0700
Message-Id: <20201021071603.1558098-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH] kunit: Fix kunit.py parse subcommand (use null build_dir)
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Heidi Fahim <heidifahim@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When JSON support was added in [1], the KunitParseRequest tuple was
updated to contain a 'build_dir' field, but kunit.py parse doesn't
accept --build_dir as an option. The code nevertheless tried to access
it, resulting in this error:

AttributeError: 'Namespace' object has no attribute 'build_dir'

Given that the parser only uses the build_dir variable to set the
'build_environment' json field, we set it to None (which gives the JSON
'null') for now. Ultimately, we probably do want to be able to set this,
but since it's new functionality which (for the parse subcommand) never
worked, this is the quickest way of getting it back up and running.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit-fixes&id=21a6d1780d5bbfca0ce9b8104ca6233502fcbf86

Fixes: 21a6d1780d5bbfca0ce9b8104ca6233502fcbf86 ("kunit: tool: allow generating test results in JSON")
Signed-off-by: David Gow <davidgow@google.com>
---

This is a quick fix because kunit.py parse is completely broken: it
appears it was introduced in the rebase of the JSON parser after the
separation of concerns patch.

 tools/testing/kunit/kunit.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index ebf5f5763dee..a6d5f219f714 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -337,7 +337,7 @@ def main(argv, linux=None):
 				kunit_output = f.read().splitlines()
 		request = KunitParseRequest(cli_args.raw_output,
 					    kunit_output,
-					    cli_args.build_dir,
+					    None,
 					    cli_args.json)
 		result = parse_tests(request)
 		if result.status != KunitStatus.SUCCESS:

base-commit: c4d6fe7311762f2e03b3c27ad38df7c40c80cc93
-- 
2.29.0.rc1.297.gfa9743e501-goog

