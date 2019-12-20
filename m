Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E72612750B
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2019 06:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfLTFOW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Dec 2019 00:14:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52184 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfLTFOV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Dec 2019 00:14:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id d73so7629512wmd.1;
        Thu, 19 Dec 2019 21:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cljTni9v+UR/6x17SI6kPpo9aSuUSmuodBBC+WhKsng=;
        b=Y91UTjSCr7XliMIFAnNosZVIuq/vCTHtQRA4omAahL0g7w3eZ1ISL/LQ8dBH/sDWhY
         EwMZpgGApJwb0eP6GbXWqwdDlVOFzcq/JXDGLv0YjjAFTJ9wWwXoQy4mI+cu3cCpO51h
         Y2DCnXoDc8MY6oxa2RsvNYCkNIoRr8B8NfI61kHMn5prJ3Y7XakCTi5s2ixKUwqB0j8G
         xQei0I2Kzba58voWPkcXdbHuVCQQbR/nk9Bu/+SnSA2erjOpLSz5lAvKHh9CDGszuzVe
         r500pKF4uivTnCgg56T8QHFOlaIUqDTonI/LAcVVJlJyQKYQI5132S0QZVVf6Ymj8I8i
         duNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cljTni9v+UR/6x17SI6kPpo9aSuUSmuodBBC+WhKsng=;
        b=J2zMAKGGAuX/jHl9Ob7HVG6Ma1DgB4Rfv+DnwDjW0q7nGuw/Aa4wDHQdxLD9v9BU2Y
         EgviuMcFmNpXVPPosnpSaWYkQT8CucbI0NuFztTHq2Q0hNsaylsPssmFiwZsnjVygokH
         OE9oyIlgqmdChuBGqpQsk3Zh1Ftb8gOS+8cNHzKBwriBzIdtTZ8wKeLmbWLWkCg5v68Z
         iY6rn5UUIIquQDfZEm/653S0Mlw90PTu4BoGU0kTHyVk6fBD6KVibR6Rmid4TbcHVbwk
         6k8MORxoQcKGcepuIKxNA7fhTs/u6yL+vPdcFTnpRbQOVeG96wpUYNUyRIDmM6Tnj4JW
         +U9Q==
X-Gm-Message-State: APjAAAUUVOGeOzEN1EpguT+5AfHNHBHYGg3et9nzCu8Mlrc7Uc+lZILB
        ZE/R2aaZAm7yvf2K0Ga/exU=
X-Google-Smtp-Source: APXvYqxm8la5hKk/hQwczOZ9e76OlFLTr0r2TqThMcqi0DqOfjCeDxXetOFGWfsXUEOLaZY67sIEMg==
X-Received: by 2002:a1c:3c45:: with SMTP id j66mr13522534wma.2.1576818858721;
        Thu, 19 Dec 2019 21:14:18 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-100-90.cust.telecolumbus.net. [86.56.100.90])
        by smtp.gmail.com with ESMTPSA id j12sm8703863wrt.55.2019.12.19.21.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 21:14:18 -0800 (PST)
From:   sj38.park@gmail.com
X-Google-Original-From: sjpark@amazon.de
To:     shuah@kernel.org
Cc:     brendanhiggins@google.com, corbet@lwn.net,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        sj38.park@gmail.com, sjpark@amazon.com, sjpark@amazon.de
Subject: [PATCH v7 1/6] docs/kunit/start: Use in-tree 'kunit_defconfig'
Date:   Fri, 20 Dec 2019 05:14:03 +0000
Message-Id: <20191220051408.3591-2-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220051408.3591-1-sjpark@amazon.de>
References: <20191220051408.3591-1-sjpark@amazon.de>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

The kunit doc suggests users to get the default `kunitconfig` from an
external git tree.  However, the file is already located under the
`arch/um/configs/` of the kernel tree.  Because the local file is easier
to access and maintain, this commit updates the doc to use it.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
---
 Documentation/dev-tools/kunit/start.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 9d6db892c41c..d5197f1a45cb 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -32,9 +32,8 @@ regular Kernel config, with the specific test targets as well.
 
 .. code-block:: bash
 
-	git clone -b master https://kunit.googlesource.com/kunitconfig $PATH_TO_KUNITCONFIG_REPO
 	cd $PATH_TO_LINUX_REPO
-	ln -s $PATH_TO_KUNIT_CONFIG_REPO/kunitconfig kunitconfig
+	cp arch/um/configs/kunit_defconfig kunitconfig
 
 You may want to add kunitconfig to your local gitignore.
 
-- 
2.17.1

