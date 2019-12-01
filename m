Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8652B10E3D9
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2019 00:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfLAXZu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 1 Dec 2019 18:25:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40003 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbfLAXZt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 1 Dec 2019 18:25:49 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so17327577wrn.7;
        Sun, 01 Dec 2019 15:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t7zZ15/MkMeD2pktuUDCc/OY3s5R2FWR8O7+ReQTC+I=;
        b=tYIrnVgk9aI1KJvogaeo/QtrReLg6sEsR8L8cs+2Xl/J3ls2POR+IeWuCXCmDIyPFq
         e1E2+9GUTp+jFCOuCntKKlo6UHJgBXPl/9J3iE6p7jrX8zX3PDi2FA4v7a0NnLOgn3bA
         f4DrQJe3ipEYXn3XvzwDkmIvqJWfaFlFmB8jnuPiNKOy3F+2qHDCyQZ45G4vdbqWZKDr
         CD49VPzD129nOo+NrcOAJK3CozFkfsXuzc9C74CtyAxqKc/j/5OVJXK+Af0ZzFZi9gQo
         IdGBd9/hHrxAiBma3/ztHGUQ/O0YyfHWosT+OPEWVbNuP/QZzCgpV58eu4tKrqQgAoML
         E9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t7zZ15/MkMeD2pktuUDCc/OY3s5R2FWR8O7+ReQTC+I=;
        b=cF/rDrgCPSxQXHmcAkgKtywGFLTvd13/8fYi+QmScwyBiULWbfFLcla2SCUeCzRzrp
         hTvv0qUdqyKrvTVKRhq3QTxLkki2JP9B7tQuEjPaLC2YYtTei0lBOUUF5olsAZo3g+wC
         s73ByEp8Ll7sqBQUm7k2HdHhejc9AqggIp2/+zsL4W7gkbHjKvRwuk6xPXGozwhEna/5
         Axe1wUSrLkvFh8k1MiZcQUD6hxMdgWM8KYxGpsQ+hrCWRwRmH9sLOm+hnGxnYId1A6o+
         W0fg8a1EJb6TwSAWZjOdGAFts6FQSNEJtZYEe961DIVGFh2MHFy07sDjD+v3Q4M8KZ7k
         G61w==
X-Gm-Message-State: APjAAAVrzq8jkksjfQKviq0mOty9VjKQ0PyOnSOS5VgAr36IcTIUYWsA
        tD9Ujfm6SLUf1zRT0DSiL/w=
X-Google-Smtp-Source: APXvYqy5HTNhTM5ksfWeN137d3ZVA274K6KE8STUGBol/0GEgl1EaRC7FL3Z5RjSwtlpXho2NrmWdA==
X-Received: by 2002:adf:8bde:: with SMTP id w30mr25729729wra.124.1575242747376;
        Sun, 01 Dec 2019 15:25:47 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-100-90.cust.telecolumbus.net. [86.56.100.90])
        by smtp.gmail.com with ESMTPSA id y6sm37450454wrl.17.2019.12.01.15.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Dec 2019 15:25:46 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     brendanhiggins@google.com, shuah@kernel.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 5/6] kunit: Place 'test.log' under the 'build_dir'
Date:   Mon,  2 Dec 2019 08:25:23 +0900
Message-Id: <1575242724-4937-6-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575242724-4937-1-git-send-email-sj38.park@gmail.com>
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

'kunit' writes the 'test.log' under the kernel source directory even
though a 'build_dir' option is given.  As users who use the option might
expect the outputs to be placed under the specified directory, this
commit modifies the logic to write the log file under the 'build_dir'.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/testing/kunit/kunit_kernel.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index bf38768..b640939 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -143,7 +143,7 @@ class LinuxSourceTree(object):
 	def run_kernel(self, args=[], timeout=None, build_dir=None):
 		args.extend(['mem=256M'])
 		process = self._ops.linux_bin(args, timeout, build_dir)
-		with open('test.log', 'w') as f:
+		with open(os.path.join(build_dir, 'test.log'), 'w') as f:
 			for line in process.stdout:
 				f.write(line.rstrip().decode('ascii') + '\n')
 				yield line.rstrip().decode('ascii')
-- 
2.7.4

