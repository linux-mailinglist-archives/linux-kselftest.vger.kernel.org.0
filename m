Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35D0C110402
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 19:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfLCSIp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 13:08:45 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43433 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfLCSIo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 13:08:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id d16so261110wre.10;
        Tue, 03 Dec 2019 10:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dVR4fIFnqBj1P8D1zyzrE8lPHinFuQJmdruk8S76xeM=;
        b=ZFR6MePFa1i+dE+IejZsEVQ+ggVuhk+uX1/eyUtgpVLYaLp9cXVcfB5fhq7g4JhtHq
         qh4IsKFVoECDrgukBm+aYjjatsHRlStMekjNLOsDcovS7qemIPa0XeSQWE+PgMLO7qVw
         uE5yvGQ2DkYnLMTvdVswWi/0pxPjv8/oifVwT+hC12FiUDWnpPQT1V0xhVMRpBIT7VkX
         CeA5T44Krb5XUJKG2jO8iSaGi6JeKMiz2f3ySOShCXS0iuEM0SsvEamncWK2XS6dahlW
         s9skNbf4B88DW2UPR6XO263+7WxoGLOBIicDK8nQCNMH6L6AKpjapSyqLGqR3xf2trTW
         6nHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dVR4fIFnqBj1P8D1zyzrE8lPHinFuQJmdruk8S76xeM=;
        b=F+ZuRs0BQATX8zOglSPZwgh+5BTNrpDZGaednYNMeKidxBhPxPbq9RbQHi4sJeWDp+
         AAZlRLl7uoybsp65whZ3utj8uMTDAT/pPFbrCH9YG0m3XqFi7kR3puicZgDdCgu2llt5
         UXJmYi5MKiaOjZITdKaG7wx0o513aB8Ow62OMilVgtcKxwMzwjD+xlKL9ZT8VhbZmGe8
         Ru7rwXjCLf9mrFs+FA58UfL/zaAh3Kd3Fkj5lm1RPEmfgWjc4BSuE2z++PN3zFISWiZM
         fpE1kEg5SnkyqKoq3m04JnBdeAWSIB/+rlMw2m/1pu5mCmyIaEkpuy6h/SH+oJLKWXGX
         rIrw==
X-Gm-Message-State: APjAAAXz2CQjageHOQIflxzdMijCY+lTZlXYEh2S7drOzsRGuqIV+E6K
        0ezgKWViCInwuoT646BZRqM=
X-Google-Smtp-Source: APXvYqykqh6vdQpsd+DKnRDsKk+uqB69pXw67V4k68Eh4ZMPioC4HmgJ/ZPhkcPAbqBeclwUq8gV5A==
X-Received: by 2002:a5d:6ca1:: with SMTP id a1mr6470527wra.36.1575396522250;
        Tue, 03 Dec 2019 10:08:42 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-100-90.cust.telecolumbus.net. [86.56.100.90])
        by smtp.gmail.com with ESMTPSA id f11sm3847641wmc.25.2019.12.03.10.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Dec 2019 10:08:41 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     brendanhiggins@google.com
Cc:     corbet@lwn.net, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        sj38.park@gmail.com, sjpark@amazon.de
Subject: [PATCH v3 1/5] docs/kunit/start: Use in-tree 'kunit_defconfig'
Date:   Wed,  4 Dec 2019 03:08:24 +0900
Message-Id: <1575396508-21480-2-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575396508-21480-1-git-send-email-sj38.park@gmail.com>
References: <1575396508-21480-1-git-send-email-sj38.park@gmail.com>
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
---
 Documentation/dev-tools/kunit/start.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index aeeddfa..78a0aed 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -29,9 +29,8 @@ regular Kernel config, with the specific test targets as well.
 
 .. code-block:: bash
 
-	git clone -b master https://kunit.googlesource.com/kunitconfig $PATH_TO_KUNITCONFIG_REPO
 	cd $PATH_TO_LINUX_REPO
-	ln -s $PATH_TO_KUNIT_CONFIG_REPO/kunitconfig kunitconfig
+	cp arch/um/configs/kunit_defconfig kunitconfig
 
 You may want to add kunitconfig to your local gitignore.
 
-- 
2.7.4

