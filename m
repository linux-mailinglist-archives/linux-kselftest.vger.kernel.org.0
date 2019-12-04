Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 203CB113652
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2019 21:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfLDUS1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Dec 2019 15:18:27 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34325 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbfLDUS0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Dec 2019 15:18:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id f4so5656482wmj.1;
        Wed, 04 Dec 2019 12:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dVR4fIFnqBj1P8D1zyzrE8lPHinFuQJmdruk8S76xeM=;
        b=Kidwoj0pZ02F2Z9wTxoD/6aiMKB6iUSW2FZMw192bEcryDXtsgmoaZUcxAim/qWzWp
         CoQwaJYZxM7dMFQEvq9vZiHAArhWArgI3r9fozm5tKsG0IaXFvyofF+ES2SNO5mx6W1P
         nGV6iaYhtdM8r5w4q5Xl/jvGftKNDM29tgQRpYXeG+V7PyG31bpBvKuaaBl6jrA5tJvI
         ws8SyUBuKD7Qp3ZGhQGSr3p8zt0OtLwKv9eDFOBS46Vg2FhJAqh2xRBMvLal6PpG8tog
         noIcmVJcQe5INDv0drCL9GRAg/9BtKBOdt98cYkLewyds6IIv42B10w5m1RJfJqWwRUW
         o9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dVR4fIFnqBj1P8D1zyzrE8lPHinFuQJmdruk8S76xeM=;
        b=g5oOJny5BOXg6fmWYw1fLKB7j9F69WpsPk2Neaga0fEBm/2LQlMmVUYEcAt+xGRJsH
         0WOuuJr5IzuFhwUJzig5mK/rRgo0LxAs53dyi1ZB6lNLhkj5wYkK7xQl9YEdepVSzrLu
         MbkBlFzYS6dPXG0BuZe9P9IAr5eP/KCKSKjJDXLE+7SDfofJHG3j0O9pYkl23Dhsnr8G
         kZJkqOaBXSH2O1OTYHGK8GlwZ8sjpHzGDp/v9s2J8GrmgiQjkvGB8N4YDy2R/Y8IQj4g
         dpcWByxeJSzQR2yJHD0HcmcPpAJwrpHnkhIpqNazJfAX4skZy//Zm9qXlXnIOkf0pU1B
         A5Wg==
X-Gm-Message-State: APjAAAUX1foR16VgzUUq2qTeEVptt/dIkD2iCH3oEdnmtDrqXHiVkaEv
        I7kxyOhLe9yp57dCHRYYR4U=
X-Google-Smtp-Source: APXvYqx2zr2ZWEhj/r7wZ1SP4B6kfnZyQENZU7GPI25A32ibqW938EfOwhihc0PiAaKOAb19wq6oIg==
X-Received: by 2002:a7b:cc97:: with SMTP id p23mr1462136wma.89.1575490703908;
        Wed, 04 Dec 2019 12:18:23 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-100-90.cust.telecolumbus.net. [86.56.100.90])
        by smtp.gmail.com with ESMTPSA id f2sm7329254wmh.46.2019.12.04.12.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Dec 2019 12:18:23 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     brendanhiggins@google.com
Cc:     corbet@lwn.net, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        sj38.park@gmail.com, sjpark@amazon.de
Subject: [PATCH v4 1/5] docs/kunit/start: Use in-tree 'kunit_defconfig'
Date:   Thu,  5 Dec 2019 05:17:59 +0900
Message-Id: <1575490683-13015-2-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575490683-13015-1-git-send-email-sj38.park@gmail.com>
References: <1575490683-13015-1-git-send-email-sj38.park@gmail.com>
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

