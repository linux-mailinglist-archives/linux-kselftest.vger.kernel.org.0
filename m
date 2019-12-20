Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D73D127502
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2019 06:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLTFOW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Dec 2019 00:14:22 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38742 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfLTFOW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Dec 2019 00:14:22 -0500
Received: by mail-wm1-f65.google.com with SMTP id u2so7869737wmc.3;
        Thu, 19 Dec 2019 21:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mZWHQXNZbjWrCsuUxUN1Y9Qc19tYv4n773phxKWQndE=;
        b=nrU5T60UysGF2YIRLSk3nPP6cbi85Zv2mW4ThA0MXV//JR3YjzosHdwu19Wx4BqX1T
         IWcUVn1EE1JDi+Xplbd7zmCnUkMpcCsGgmCCZ+ZH7VUFOHYNjsS/cPVG5+2aQUzLV1c5
         HIM2pKhzFS6Ylg77RJo2PIdrAA7l39tojwedjAij36Nuc+DcNGU85dPLU81NCZsr2JR+
         99+5mLXAxc8lCEqg5C5ODQqG91Hct4x8ryFZdLpSuSNGS2VG2SFyjSe2KcOylk6taKjN
         kjpW1OCjHLzUN6vkWevuCkG+sYK5ci48GQOXuJ2d8jcApC5DiXb7ZuAKwq3ibIZk8PUS
         D74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mZWHQXNZbjWrCsuUxUN1Y9Qc19tYv4n773phxKWQndE=;
        b=MBjlHZKy2dDeMOev9wnCT4dCdj0RqPU5BF+62PjXqdpJzvbtWHLJnOLoUj7jS+hqMx
         KZ2vOndaSVpSSd5U0nrBHCvrDKm3n/FXFsLe7lNJVrH8UdOssMuzuHF08AQAFba5SdX2
         kMKUEwp+b8lCWJ2jNu9kdisss2MYUh72Eb86D/1qjpf1B4weenU6gaDHSfiULiXAt1Bu
         4i6GRt5pZ1Boz6pFRgvjdTL+ezUbvwj/27QTOH7KhZAccOPHRo16ho7vO1sfioqOg1HM
         53D8bLPgGVSbA1rsNhW9UQMi9q949qxKnnypUyRxhLGtGCXOOsio4y7gZ1CDQVqxNk3D
         UzoQ==
X-Gm-Message-State: APjAAAVDepGARMYIemvwWQvUiLw6H+djxFft8FgWBZLT/Z92GHXjolO+
        echCc2tzDEYmRzMEdQw3iuI=
X-Google-Smtp-Source: APXvYqzaWtnwNBBPRPmZs/K2n1dWihJXuAFPZmbYBp7ZO3xDMfSEP3ovrD0no3EXS4/nHRA/QIUN4A==
X-Received: by 2002:a05:600c:2549:: with SMTP id e9mr14422062wma.6.1576818859888;
        Thu, 19 Dec 2019 21:14:19 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-100-90.cust.telecolumbus.net. [86.56.100.90])
        by smtp.gmail.com with ESMTPSA id j12sm8703863wrt.55.2019.12.19.21.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 21:14:19 -0800 (PST)
From:   sj38.park@gmail.com
X-Google-Original-From: sjpark@amazon.de
To:     shuah@kernel.org
Cc:     brendanhiggins@google.com, corbet@lwn.net,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        sj38.park@gmail.com, sjpark@amazon.com, sjpark@amazon.de
Subject: [PATCH v7 2/6] kunit: Remove duplicated defconfig creation
Date:   Fri, 20 Dec 2019 05:14:04 +0000
Message-Id: <20191220051408.3591-3-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220051408.3591-1-sjpark@amazon.de>
References: <20191220051408.3591-1-sjpark@amazon.de>
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
Tested-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index efe06d621983..f8f26951cd1b 100755
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
2.17.1

