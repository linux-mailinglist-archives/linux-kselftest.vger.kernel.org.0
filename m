Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4FBD10E3E9
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2019 00:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfLAXZp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 1 Dec 2019 18:25:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46866 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfLAXZp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 1 Dec 2019 18:25:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id z7so38468918wrl.13;
        Sun, 01 Dec 2019 15:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HYMDGCEmGcRSgznIZqiDAqfjbK/Kr8elskjbFdh/a+8=;
        b=kytsNh2AsL4R2YGin9NHm3swj8566Bw36YlupJ91/bJ8mc+KxBt8QR5TXV/bHeP30I
         wV4NEfjSRSshzUTZG0+vnSfqN+OivW1D1lnGhe9MeRUEMTAsmT83J4OncMdik/qt8/KL
         4SzJELjewY70o+mR+BrfzlZ1MgAZUzxw2uywZ8FJAn8Pt4aVqSx+fZywrMwpL0l5Fd/t
         Id+DpLp+0L4UJs+y+9jaXHxMxo2+bdSqg2SJ39XATzcxG589teqqCbWvQRmICQAu6yWk
         oOWZkPX/YSw/QNo9PJyEx6mCrmTXNvYmY9C/82BJgnaSjlfO0BMMHKZv9fmwAGjMYqgH
         19Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HYMDGCEmGcRSgznIZqiDAqfjbK/Kr8elskjbFdh/a+8=;
        b=I1bJQx5JIPrlTdYqdylASEI/cZGntVvIxioJFBq9GK2D2J7tGY7LsuoH7f9W9CC1Bs
         kJYGQ3HLWHPfvvJWVpkuxz7sULscowy5pvIsil9asn+U+e+RBZsCWqDLmcgh5QVv25A3
         dZk45lq3ICq8nFevbPN/z8lCcCSi+une0YeyCnecnceGm9JJtsEqVw5UToOALx98bdQT
         uTqciBf+zSFkCIHlo933PuVE0tzIYdM4fYOudmBJCYbdgq6jZvbekovFa83K2Xb2J/5o
         UP/aJm8CSN5m1KTSleWLMIhpb0oDyP1zo6J67rlC2GJ/uSjCru/fWrDuZWBjIoZcfMFi
         cNcg==
X-Gm-Message-State: APjAAAWcFy7IEcYja8HwX/yc/7GA+n/CRh47pz9ytQ/cpg/8tjNadvGF
        Z2JXif6lsQfI/5HsHE+/9wI=
X-Google-Smtp-Source: APXvYqy1luSgtaDxhS/XlxRiPYxiWqzgWyjAEQaSVT72yqkQysRWTNzVHpAzskZqwnYCVk/CGMQRpg==
X-Received: by 2002:adf:8147:: with SMTP id 65mr65094833wrm.230.1575242742682;
        Sun, 01 Dec 2019 15:25:42 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-100-90.cust.telecolumbus.net. [86.56.100.90])
        by smtp.gmail.com with ESMTPSA id y6sm37450454wrl.17.2019.12.01.15.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Dec 2019 15:25:42 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     brendanhiggins@google.com, shuah@kernel.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 1/6] docs/kunit/start: Use in-tree 'kunit_defconfig'
Date:   Mon,  2 Dec 2019 08:25:19 +0900
Message-Id: <1575242724-4937-2-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575242724-4937-1-git-send-email-sj38.park@gmail.com>
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com>
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

