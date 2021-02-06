Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B22A3119AD
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Feb 2021 04:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhBFDPf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Feb 2021 22:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbhBFCtz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Feb 2021 21:49:55 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A15C08EE1E
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Feb 2021 16:09:10 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id e5so7287164qkn.2
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Feb 2021 16:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=KdjKwQSV8R49hhF8YBTPAsSenCKV1XvSoMIimz2f7Lo=;
        b=u8ilAwjsWp1UN91pf1gmxM/49s467/eLrcvHS5yAiHMELI/fEaJ+bctfICqIJTIqQ0
         x2MEI3eltGnZrdyvOIyhn/u8pufdJ/vJg40YGrRTQP9pcn7qBt2H4kCyAFEG4LC70+3d
         QkxEyeeoH1Q6nFYtrGlqM/Ui7oIXkLQRIxExK5IXuSrsBZYrSfSkXszNhmzrugIUEqni
         UYzzZxDDz1Vkz+GsrlaA19tIqwiqyQh6YpntT0tEk6h1VFSt6UwJzVFgHNkeYHQUP6TW
         RVTJa3R9/oIf+sjqsGuH1rnbZo1nMZZdkYZLrDqa5BDKSkksYaPu3e8w5CwhW9y3F2Gi
         hP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KdjKwQSV8R49hhF8YBTPAsSenCKV1XvSoMIimz2f7Lo=;
        b=kc3ztgGq+2mrsrxuVwNK8kluD8pf6wlu7oarpKLrM8MfofvFKLTM1pC1UlTn/bq0bb
         SkqNiqWLtWGTjM3WI2V/4J8uIl41oumSjiozl89tFy3ym2ukNGlvuaqbQ7tLy2E5bsvj
         5ilDoeLTpibX5Mq7+DzJ0alAmO2XbGENj5lHTsA2eL1Fvmpbcr53QRb+nbEDDTgYf9LA
         agEo4hShfUCny+gIDX5fRT0CChGY8CWfVjmLe+CoNj0UByhKrfZSSrNtfr6ukd+qTAw6
         MGkaJxpHHoYcLB0YX1Dtm528IK+95ecvv9LvbH/xPWDmt9fsocC3nxVaGkuHhqQ21T1C
         HZmA==
X-Gm-Message-State: AOAM531wpiDkBhOFEJibex8aj9oMHvJ6Bn+EGZEEQ1Zbu12q576UBq8h
        BJC7D4A5vkW6eiyr49sbGEGEt8Qe6evKmA==
X-Google-Smtp-Source: ABdhPJzuVtOEBEdpMg+xANPjOgnrC323ecoJ6yJGZv45bT7+rm2SAUoHCScRms23l0Pw2ZbX3BaxS/NuT6ttMw==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a8b1:128a:69fa:86fb])
 (user=dlatypov job=sendgmr) by 2002:ad4:47b2:: with SMTP id
 a18mr6953341qvz.1.1612570149583; Fri, 05 Feb 2021 16:09:09 -0800 (PST)
Date:   Fri,  5 Feb 2021 16:08:54 -0800
In-Reply-To: <20210206000854.2037923-1-dlatypov@google.com>
Message-Id: <20210206000854.2037923-4-dlatypov@google.com>
Mime-Version: 1.0
References: <20210206000854.2037923-1-dlatypov@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v4 3/3] kunit: tool: fix unintentional statefulness in run_kernel()
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a bug that has been present since the first version of this
code.
Using [] as a default parameter is dangerous, since it's mutable.

Example using the REPL:
>>> def bad(param = []):
...     param.append(len(param))
...     print(param)
...
>>> bad()
[0]
>>> bad()
[0, 1]

This wasn't a concern in the past since it would just keep appending the
same values to it.

E.g. before, `args` would just grow in size like:
  [mem=1G', 'console=tty']
  [mem=1G', 'console=tty', mem=1G', 'console=tty']

But with now filter_glob, this is more dangerous, e.g.
  run_kernel(filter_glob='my-test*') # default modified here
  run_kernel()			     # filter_glob still applies here!
That earlier `filter_glob` will affect all subsequent calls that don't
specify `args`.

Note: currently the kunit tool only calls run_kernel() at most once, so
it's not possible to trigger any negative side-effects right now.

Fixes: 6ebf5866f2e8 ("kunit: tool: add Python wrappers for running KUnit tests")
Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit_kernel.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 71a5f5c1750b..f309a33256cd 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -203,7 +203,9 @@ class LinuxSourceTree(object):
 			return False
 		return self.validate_config(build_dir)
 
-	def run_kernel(self, args=[], build_dir='', filter_glob='', timeout=None) -> Iterator[str]:
+	def run_kernel(self, args=None, build_dir='', filter_glob='', timeout=None) -> Iterator[str]:
+		if not args:
+			args = []
 		args.extend(['mem=1G', 'console=tty'])
 		if filter_glob:
 			args.append('kunit.filter_glob='+filter_glob)
-- 
2.30.0.478.g8a0d178c01-goog

