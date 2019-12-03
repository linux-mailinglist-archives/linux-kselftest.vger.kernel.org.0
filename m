Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 362D5110411
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 19:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfLCSJA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 13:09:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38962 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfLCSIp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 13:08:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so4891722wrt.6;
        Tue, 03 Dec 2019 10:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fspx7bIXXs0k8mMRF6gpjQkO0Aw1T/BQQAXOr83Gdx0=;
        b=hKyaRaxtc9iaT45IweuHESVDA4caCMdb7T+Bl1ZoEQFIDVQgv2OARPq3JfRa03Q192
         9InfjsvAfjiqt/tLV+H+pC2aSWfpiUNEZIRbflt25FMjU7iJHCDqp+nkdVU2fgA449WF
         Fsaa4iCWFLL6I6OKI3cViC3jIRyO+p/5+oVbHNNVrRHPPgRKs/G0YIdCtteldfv1bxJP
         TWS3VANBwEqvldoIp38N48uM4PUw7VUGssv0D15HYtw5FvBeXN6S08byGRl6Rq+GNklY
         +QpDyL2nowooD2FyfsBYd5MV3mHZGNkr5/DZlUewlwP7ublaINeg09j3ok3JdbS6Qb/d
         rpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fspx7bIXXs0k8mMRF6gpjQkO0Aw1T/BQQAXOr83Gdx0=;
        b=MJiD4C5OOrBgwsHFRR8eVtR8bhPZnwkWQIUPxnir5QCmt3d4ocxa1E1eowi2x7r2fw
         Ev4IVnvg4gKDfF31Re94UchVlkZeZoyFWUGdRSw43E305H3r/uHmAVVgV0q9F3PAhFej
         jzAWvyPEbnn2TqDVilY+eQWbDILwav6MFDRdLJjrf6lbgx7YtHJo3Er9Vk+pRA/H9jvv
         g1BvnvDW2v0wL0KIUSEkdiNHFW79zvtQkhr+Lde30yhADqYppiGAMjSZ6U6GjZpmNpaF
         8cttwet1dtkIRXVhNt6ENqT8owMupyuzR+41A2mUuYb08/GE/6ub/CqcF6SyfPS+jWHD
         3eig==
X-Gm-Message-State: APjAAAUOtr2qPM11nPvJxF3OHHZmIBB7hFpiAD34CMVrD8rOLDaATaCW
        z8Ma/ceYw9vs1ld10s00pXk=
X-Google-Smtp-Source: APXvYqxwVeda6AJH+unoZ0ri/RM91nuhADVTjGSRVMc86r3Jhdn9f0i+Kl1S+MwTlxxIOjvXgzOitQ==
X-Received: by 2002:adf:f606:: with SMTP id t6mr6450005wrp.85.1575396523754;
        Tue, 03 Dec 2019 10:08:43 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-100-90.cust.telecolumbus.net. [86.56.100.90])
        by smtp.gmail.com with ESMTPSA id f11sm3847641wmc.25.2019.12.03.10.08.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Dec 2019 10:08:42 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     brendanhiggins@google.com
Cc:     corbet@lwn.net, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        sj38.park@gmail.com, sjpark@amazon.de
Subject: [PATCH v3 2/5] kunit: Remove duplicated defconfig creation
Date:   Wed,  4 Dec 2019 03:08:25 +0900
Message-Id: <1575396508-21480-3-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575396508-21480-1-git-send-email-sj38.park@gmail.com>
References: <1575396508-21480-1-git-send-email-sj38.park@gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

'--defconfig' option is handled by the 'main() of the 'kunit.py' but
again handled in following 'run_tests()'.  This commit removes this
duplicated handling of the option in the 'run_tests()'.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index efe06d6..f8f2695 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -37,9 +37,6 @@ def create_default_kunitconfig():
 
 def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
-	if request.defconfig:
-		create_default_kunitconfig()
-
 	config_start = time.time()
 	success = linux.build_reconfig(request.build_dir)
 	config_end = time.time()
-- 
2.7.4

