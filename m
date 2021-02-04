Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E1E310063
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Feb 2021 23:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhBDW4V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Feb 2021 17:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhBDW4R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Feb 2021 17:56:17 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDD6C061797
        for <linux-kselftest@vger.kernel.org>; Thu,  4 Feb 2021 14:55:01 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id q191so4838620ybg.4
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Feb 2021 14:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Wkqh1wBZi1KMSWP9n4B3+7R4NMp7xQIbcrZ87gljot4=;
        b=iYbKyTjxF+2utdWW8EqdT/kRukPx6bdkOrTGffBQ3EQrvhGlQhMUHl9GQzbCEjBDRk
         WyU4ioaBh/EghQ4qsB08wQUS+sh9s9/zbXYZUP6fnKZd9xakktG/+CYlj12MKFPFaJC+
         RPm4eTDjCGHR9Eyt6MO6LqsklaY2Wtfft1AJ6oFyvC3cE/eCjZQFNRwwkHXe8Oil1Bk9
         UgfjWtqPaiBO7r4jVqQb77XUeK5LvbHuUEObXh43X63HHx73M6IwvkvgNll9ofNG/huK
         e0PGax3yohgTMXAN7PNdMPkK9359NPAuCHEPOhMt2wENbMkcX49Ce3Lbc1kRA4TTv3S3
         ZfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Wkqh1wBZi1KMSWP9n4B3+7R4NMp7xQIbcrZ87gljot4=;
        b=NBIP9hU/bnsC4O7TGMDNzUuRDjrjJvOcZ0vuVdK3h0lJ4LJL0P8knCNOX8hklkd33+
         e+x92vqHXs+74QNvLcnINU3Oa0stzH5IreIizI8+AePHLuU/0Fvvv31/4epaGP4qDIY3
         wxwtPyov/AxUlWYNjzX3fY5W+ANhsqDW3q0STw45d2FDGhcLI2h3aezgbzMvvCIB2Iyy
         j9KxwsRUn+LFmBppRTia0NC6xG+5YoFWI8SVDuOXUxmfswbUz7dO4l0e5dCbm0s3ox2I
         ileRXtNeTYC2UF4LYTksztEsmHxTfNm9njqHLXZa3OKm7Hcwpv4Iopsduu7Y8Ks1Q6o7
         j4eg==
X-Gm-Message-State: AOAM532XSxaSkQJx9/nmdladFriTCWPz5BFSPK0zvoz/9AphYd8ZIzl4
        UZdldwW7RrIEiMC0zKU4OSQn03FoUewRFQ==
X-Google-Smtp-Source: ABdhPJwoINV61XBqm1+2y6JBPKINVE5ci4YcuQgf9RpZwrWA4UcY6q/lgnsC0tACbu0OUhf3hAuSoOwt1qLA3w==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:bd7a:7717:5b5b:de27])
 (user=dlatypov job=sendgmr) by 2002:a25:d441:: with SMTP id
 m62mr1482057ybf.109.1612479300511; Thu, 04 Feb 2021 14:55:00 -0800 (PST)
Date:   Thu,  4 Feb 2021 14:54:48 -0800
In-Reply-To: <20210204225448.1393741-1-dlatypov@google.com>
Message-Id: <20210204225448.1393741-4-dlatypov@google.com>
Mime-Version: 1.0
References: <20210204225448.1393741-1-dlatypov@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v3 3/3] kunit: tool: fix unintentional statefulness in run_kernel()
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
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
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
2.30.0.478.g8a0d178c01-goog

