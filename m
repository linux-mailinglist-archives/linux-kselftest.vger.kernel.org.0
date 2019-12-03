Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0ABB10F9A9
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 09:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfLCITV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 03:19:21 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41682 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfLCITV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 03:19:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id b18so2446142wrj.8;
        Tue, 03 Dec 2019 00:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x54qeaA6lnhhJC5TBmsbkdVTvf2Oqp7EQuSTFX3fSbQ=;
        b=EaFrvuF1S5hhmzUC76mTiY3HPdLuj0+RgiKfW7SS45FEHSht+ipE7VedfJlyouwFkx
         FTrD3ciVl6iNEWuF77uTERQ+9JfY2DYRr32N3kI4P6co4RtJO93i4uSmGUYYEOBwgMuX
         2ReZNRt2c+Ycwx66kDdo7PgsFPk9sWR1FczYernokfSnZxUBJA822TfH01GvCEPr7Cli
         qFzwYX3FDLrcKHudyuNyluW0kkraHmoYgoM6ez/FMya7bYzZQ2YeQwQnEqPQEnynnRwg
         0TK6/n3Eg++k2WtnbjoSgGooNH6twRSacTR4/IkAEVYJE7nxnK4kcDjGIseIRUL1OFJu
         LDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x54qeaA6lnhhJC5TBmsbkdVTvf2Oqp7EQuSTFX3fSbQ=;
        b=GYOgIvJ9pchDYvDfysb//MTVWyGK6mOQNoZXH1ADa9s4GOxpLJAs+VVXHq57T/Ylt1
         qm+ZoXnV+NA4Ef+pItGfn9lNeMCfpTRayG7GAGKfJXIBzs55I9kjN/je7fDTFrvEORhx
         nSrlDtkaZa73NsX9E2/vZUgT1cNr95rWXjz8chGoVz7rrsRrFE1BHXInGRD7rzs1+5e+
         ZBIsdrUC8+bFElek7nTgRj9snQhCRxzNjg7qFjUotoBQgfjvrQbrre2rYLvbj48BOVCw
         jfVwrJ96YDOQTicZMOQV/nXWSnQH3YG5m4EM0BAHOZBQsmc6LO0/PUsBVVNrwoMWKs6c
         uDYw==
X-Gm-Message-State: APjAAAXrcv6O9QUdLB9lLLc1lhLkm19TN5XW8/axu9Rep85L2iViWFUi
        tt6PC4teo+VRUuyBFWxfD0wXJicd
X-Google-Smtp-Source: APXvYqxU5z5BUxoGxZV/IuHWZpw1B7M5IxrBog2ie+TwtWqK704jwMpWkyaAZbpQqujW5qknp36PRg==
X-Received: by 2002:adf:fe8c:: with SMTP id l12mr1901628wrr.215.1575361158753;
        Tue, 03 Dec 2019 00:19:18 -0800 (PST)
Received: from localhost.localdomain (p50991abe.dip0.t-ipconnect.de. [80.153.26.190])
        by smtp.gmail.com with ESMTPSA id 188sm2048197wmz.13.2019.12.03.00.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Dec 2019 00:19:18 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     brendanhiggins@google.com, shuah@kernel.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, sjpark@amazon.de
Subject: [PATCH v2 4/5] kunit: Place 'test.log' under the 'build_dir'
Date:   Tue,  3 Dec 2019 17:19:00 +0900
Message-Id: <1575361141-6806-5-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575361141-6806-1-git-send-email-sj38.park@gmail.com>
References: <1575361141-6806-1-git-send-email-sj38.park@gmail.com>
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

