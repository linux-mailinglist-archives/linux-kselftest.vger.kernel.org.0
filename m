Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C8B2E06DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Dec 2020 08:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgLVHjp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Dec 2020 02:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgLVHjp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Dec 2020 02:39:45 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF98C0613D3
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Dec 2020 23:39:05 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c9so16757601ybs.8
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Dec 2020 23:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=lswzyGh/wqBVBArbTXet9XrVDeOvbwazZ0TIN1WlZU8=;
        b=BVIGhmCp7okmhrxfAv3vg+iTduI+GtEk6bJF9ETLYZOQ/YSDMrE1lnPkdTNJfEvn9G
         2i/G10wdh472dBfa1O013Vb6h2cqloICEwlw46TF73oo4NHvqDBPkajY305Tp3Ot1Agg
         gMWN7q10k/hT6dAO2PMVl1ot0oBb38YSKWVvYk8cvgoOz9vDH4FEFWHnCqQJiUiq+jJ0
         4zWft73Q2r17HtVhc1hP27SX5AWfNJULaILLE/BHWazaVxtLUkipd3wOG79Oj1zp5Wqz
         xOKWxqHE1NCrhwDsNtpfSdLF01dACNj3ZvgHa8IO9N6v31JYmds1vRNnUuwf9luY4Ct/
         bkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=lswzyGh/wqBVBArbTXet9XrVDeOvbwazZ0TIN1WlZU8=;
        b=C+2eLefdwFp50KyTna+NN1dUG2wqz2RltyNZQQdLr0nJ8ZppUeCcYfFPDvVxpejbjG
         2rOWcXD5pxqoBTAiXOuPCcf6vdsIWjwrA7E5FripaFK+I54Ec9HIV3Bx7v15kXr+wbzw
         SRFjG8TuOMWClo44DXKH1XwxA5qobsLO6cX/VZjHRdblrC+oCARZu671MLFDobgX88IR
         PduOxhdKOl+tzEkZP2WZZ5no4Tho5Wc9QApMsZa7r02ClRnMNgHDBLAagj7YbODtLeUH
         SjUivf2XUJWlD1boLlClI9wN/GYaaJ+3kgO723dne4G7q3bAyURL6ci3AhftER46Vx9Q
         IkdQ==
X-Gm-Message-State: AOAM531Kx87Y1tSQ8VM/i1MK79AjdbHR/G49fc+pTNq5dsjymeAMQQZj
        OtVNekn6oludELTmTuO8zMeMwkjhoNTBeA==
X-Google-Smtp-Source: ABdhPJycwxpLxeB7bb5anVq1PShQQNO5DGVwjQfW2TVGdVGvWLpFH7nISnFjv+cCelgfXqhy5ct1pan7Hk7MOw==
Sender: "davidgow via sendgmr" <davidgow@spirogrip.svl.corp.google.com>
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:42a8:f0ff:fe4d:3548])
 (user=davidgow job=sendgmr) by 2002:a25:9902:: with SMTP id
 z2mr27142126ybn.339.1608622744383; Mon, 21 Dec 2020 23:39:04 -0800 (PST)
Date:   Mon, 21 Dec 2020 23:39:00 -0800
Message-Id: <20201222073900.3490607-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH] kunit: tool: Force the use of the 'tty' console for UML
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kunit_tool relies on the UML console outputting printk() output to the
tty in order to get results. Since the default console driver could
change, pass 'console=tty' to the kernel.

This is triggered by a change[1] to use ttynull as a fallback console
driver which -- by chance or by design -- seems to have changed the
default console output on UML, breaking kunit_tool. While this may be
fixed, we should be less fragile to such changes in the default.

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=757055ae8dedf5333af17b3b5b4b70ba9bc9da4e

Signed-off-by: David Gow <davidgow@google.com>
Fixes: 757055ae8ded ("init/console: Use ttynull as a fallback when there is no console")
---
 tools/testing/kunit/kunit_kernel.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 57c1724b7e5d..698358c9c0d6 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -198,7 +198,7 @@ class LinuxSourceTree(object):
 		return self.validate_config(build_dir)
 
 	def run_kernel(self, args=[], build_dir='', timeout=None):
-		args.extend(['mem=1G'])
+		args.extend(['mem=1G', 'console=tty'])
 		self._ops.linux_bin(args, timeout, build_dir)
 		outfile = get_outfile_path(build_dir)
 		subprocess.call(['stty', 'sane'])
-- 
2.29.2.729.g45daf8777d-goog

