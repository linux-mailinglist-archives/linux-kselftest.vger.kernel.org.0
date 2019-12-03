Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0318211040A
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 19:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfLCSIt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 13:08:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40864 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfLCSIs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 13:08:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so4879472wrn.7;
        Tue, 03 Dec 2019 10:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x54qeaA6lnhhJC5TBmsbkdVTvf2Oqp7EQuSTFX3fSbQ=;
        b=ekwJ0ErRBR2nGmvyT1ADqbt1ZEI0OsPOrO5QN2jY86mfvc4OUIhxK+HnjPHUQZNyK7
         vq29RaNP1XMXIFz9qZjGdI2MPO6uneY7w5VAH9RxyP5C9PoyeEjcQmnQK2lnpYbzX11A
         g2alW1+y046jgO4LYi3w0XOG9sm+R4XhgpIRSI1DGm1eryLeZQ/upY6QgpH+TXwGcaHT
         ADcKbNa3whGejqSgviTedUkOjqGUMabfak1qDxAOkJztOytZK7JR15POx34CsQO3mKC8
         Oslugs2NaMNj8ZeTOWCIw5ugUKIGR9a80f6auq7x7EZLwKr5uTy1qpEZdMLbfKrHiA1U
         F6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x54qeaA6lnhhJC5TBmsbkdVTvf2Oqp7EQuSTFX3fSbQ=;
        b=gb/1V74JpagK8JejpvySzYmtoVwdvVqlazB/zgE8QCqRLkqWahHfoC0XKMKfOXLuDp
         tua7yIjsuFBdYClCBxFQNXjdvLOmzo68Xv08tY2H2V7e+q8dRR9ACkeA7ylixzId4rXC
         LCayqxyhY/zWLGGOgUEDjDxWcWCfsRizKOLWkDDE7OzbuvA7Sg9+7bOCzgm2xQCUCsJJ
         yk0fb8bo6Ov3w1y+Qii133fZ523X15+zwKmgJm9firKeInzG98fuLIeK8uezo6xxjrKB
         JRmyYEdgbZniHWs3PM7q/EKl3mTg2kHmO58ASFEZWHnty58bUTyfVsoCnbohD+TEPDIQ
         9+dA==
X-Gm-Message-State: APjAAAX63nsmpwsj3NkA0PM2D8gBpHMILcUPJsYJcg7JM4xi1gB1NAEj
        FBOc1Nk9XPPAaxv3fbuQR2k=
X-Google-Smtp-Source: APXvYqxksk1sT2ZZdAJxnzOVW5/5ECpcZrfCYxKcazhIOcGu3CMRqfFJX/Xnh6ZGkKyllyN8vWnwdA==
X-Received: by 2002:a5d:4b47:: with SMTP id w7mr6999917wrs.276.1575396526558;
        Tue, 03 Dec 2019 10:08:46 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-100-90.cust.telecolumbus.net. [86.56.100.90])
        by smtp.gmail.com with ESMTPSA id f11sm3847641wmc.25.2019.12.03.10.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Dec 2019 10:08:46 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     brendanhiggins@google.com
Cc:     corbet@lwn.net, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        sj38.park@gmail.com, sjpark@amazon.de
Subject: [PATCH v3 4/5] kunit: Place 'test.log' under the 'build_dir'
Date:   Wed,  4 Dec 2019 03:08:27 +0900
Message-Id: <1575396508-21480-5-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575396508-21480-1-git-send-email-sj38.park@gmail.com>
References: <1575396508-21480-1-git-send-email-sj38.park@gmail.com>
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
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit_kernel.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index c04a12e..5bec97e 100644
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

