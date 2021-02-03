Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189E330E7C3
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Feb 2021 00:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhBCXnC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Feb 2021 18:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbhBCXmq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Feb 2021 18:42:46 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5657EC061793
        for <linux-kselftest@vger.kernel.org>; Wed,  3 Feb 2021 15:41:29 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v7so1457801ybl.15
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Feb 2021 15:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/SVhbM2uQkfhx0nM8S6aEm/0ZcJ7ciNGwmg4LfVvDlo=;
        b=Q+TS3qW6SM6wIum0mxOGE5YURZnsMYYXVSeHKas03nAKV+6CXav4beYt/9wPKkYXU6
         W7jrNlSwqIxTLQK14x0h5aIOha4ZURMIfOSQfORcGG8lxtMT1NLiKJWFCSyrtFKDBLI+
         OBD/YYnJKDCm/OXCc+d2le2RtKUf126s9WMiQHkHe0oSGLf1PwxnmLbyapGx3yC7AIzA
         3iguXBVmPPf1f80hNqk25+6EINJkRiJ6JwMYJpTlrWAxulcRsYIZhjlTu5nPPWpYSS7k
         /uHRc7Xbi186oOVVHyj/z4my/C0QM++n7iTgbkqPXswDLlj70yQViF+QgstB2XfXEsQd
         327g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/SVhbM2uQkfhx0nM8S6aEm/0ZcJ7ciNGwmg4LfVvDlo=;
        b=A/1vmU/LEnUdKQtUH1JzSbtBfIJWje8soaod+uqZBKiIjq8x2zLRByCy4Psf5zdFx4
         xfQdv3HcXmt2og9vRaVq2qsnLfPWsGw5N+TWI9G1cn1Yleb6pE9SKuE96lv5/RvTFcbt
         X9zvuVN09CVQMtEiBXjd0DHjI4btvIjzGq/p592RRoqNXJc1Wieq8eRHwmZ3jW7jLbWd
         cqb6sLEEBI6DOtPG2W3owEhSJ20JGfwjtpQGCK7BE0WNWpn75Z7TannVcLkhvppRrUju
         huLYDLvdlHYFlbO3FsiRPYZrShBlklp12yJ034y+07aaLMcGa0uS20hTpRpddkn/wtLm
         P4UA==
X-Gm-Message-State: AOAM531RaxT2rA8sCvlt26b9FNhJ/BtKWElVJn2NCub70z8YHpxkyGtC
        XMbgCeR050VdgCiCw/ZGMojGFg9YWCSHNQ==
X-Google-Smtp-Source: ABdhPJxW1mSlBMiPe8VFlR0C0NhwCMngW1NOxzWO+d2kKzqhcyVSzN7MogWuLZ/h8WcbhdA1GJCFqxYTIbPQ1g==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:bd7a:7717:5b5b:de27])
 (user=dlatypov job=sendgmr) by 2002:a05:6902:706:: with SMTP id
 k6mr8182212ybt.52.1612395688574; Wed, 03 Feb 2021 15:41:28 -0800 (PST)
Date:   Wed,  3 Feb 2021 15:41:16 -0800
In-Reply-To: <20210203234116.839819-1-dlatypov@google.com>
Message-Id: <20210203234116.839819-4-dlatypov@google.com>
Mime-Version: 1.0
References: <20210203234116.839819-1-dlatypov@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH 3/3] kunit: tool: fix unintentional statefulness in run_kernel()
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
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
---
 tools/testing/kunit/kunit_kernel.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 71b1942f5ccd..6dd3cf6e8efa 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -199,7 +199,9 @@ class LinuxSourceTree(object):
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
2.30.0.365.g02bc693789-goog

