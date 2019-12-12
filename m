Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC35E11C341
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2019 03:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfLLC1Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Dec 2019 21:27:25 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38588 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfLLC1X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Dec 2019 21:27:23 -0500
Received: by mail-pg1-f196.google.com with SMTP id a33so328972pgm.5;
        Wed, 11 Dec 2019 18:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tTHS0sAFW9uPlD+AqCNYpUarFLmjwnHqD++0UeSB8hU=;
        b=XQIaEQxpgLBwXmiYR6pgGNgeFnutK6DCycup5orLwxibF5fYc8fMjIopR0VkLtgggt
         KjI5/JWB4bKTxcALCb0rHq8otftnAoxoX3n1GDzGxeu3qVIhu7QuYyv2+Mwp2Bry6GYp
         tRsT+zld0GfIWiO585WuHZA0454yZ0ZgGJs/DWoR+s5cSUaAki86/LKYI3WY7ujV5P/y
         9LeYFUV9ZeR9kqCSfnsA79SVQeHOXx76+b6UUG0MNWlaw0UIpoGkWr+D4dtHkDbATWE3
         HIVIstSxVNQmlB/Xw2ipNa0QI8nimIhCOcMYDhKRxqwf7ry9yk2vEb1cZsQCX7t9K0N3
         6tng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tTHS0sAFW9uPlD+AqCNYpUarFLmjwnHqD++0UeSB8hU=;
        b=PmNkLtEK1wXiG9Ar5308zA+N2V4zsvWXX4rOjIJQY4VOKce84v5ekDAZtxudP8JQ/K
         /3IL0eP+h0CSK/6erqWqcaFMUO02Cf3aoiGK3yUR5xXSh7Z2CSeM5LoM2QbxT8MeVBY7
         FZ7l+S9qPwNbcpy/UKyd53lxbYL+BneIK12NzKBFznXCKJxSsMrLfNkFySRNKFD/SS5B
         1rdn0YP1r04A0Lko2xmT7XVSF7c+BiIVKCWGlaxZI9xU8mbALVkyT+/XdH6Cid5wE+lP
         wVUe1k5kEBPU8KJfO0G2HnPlqZVqu1jOmhvioqUiqojLrTip2ogiEmP5MN3q4zno4dVA
         eVdA==
X-Gm-Message-State: APjAAAUdw+RywvLGleY/vTEJJRYf+nsqqzCKhLMazbcxoFQmnJQJHcKK
        6gI4/CRuT7vbpef30i5Tibs=
X-Google-Smtp-Source: APXvYqyxoOoOHx1Hg7FJQOpMCtLSu31I0G7JyqkADbCfGNxEQhYGyDSTVOGeuddMmJ2QYMjHO14sMA==
X-Received: by 2002:a63:4f59:: with SMTP id p25mr7719374pgl.230.1576117642714;
        Wed, 11 Dec 2019 18:27:22 -0800 (PST)
Received: from localhost.localdomain ([12.176.148.120])
        by smtp.gmail.com with ESMTPSA id d22sm4245173pgg.52.2019.12.11.18.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 18:27:21 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     brendanhiggins@google.com, shuah@kernel.org
Cc:     sjpark@amazon.com, corbet@lwn.net, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, sj38.park@gmail.com,
        sjpark@amazon.de
Subject: [PATCH v6 1/6] docs/kunit/start: Use in-tree 'kunit_defconfig'
Date:   Thu, 12 Dec 2019 02:27:06 +0000
Message-Id: <20191212022711.10062-2-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191212022711.10062-1-sjpark@amazon.de>
References: <20191212022711.10062-1-sjpark@amazon.de>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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

