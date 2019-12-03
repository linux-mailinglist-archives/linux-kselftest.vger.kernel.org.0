Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0EF210F9B5
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 09:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfLCITR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 03:19:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39548 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfLCITR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 03:19:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id s14so2365713wmh.4;
        Tue, 03 Dec 2019 00:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dVR4fIFnqBj1P8D1zyzrE8lPHinFuQJmdruk8S76xeM=;
        b=BBgi+WWqAttoUkdZsDU5N6LxlC+t8hvemSP8NZWg8F9Dj1P0/4UrRbC9aa5omO1IJQ
         q5XTvMzBWPrKmp486nQgcaLKN04np240K10uGf+ORgU+p4gS/4za7/o0ANKAHNHF4xfm
         eWFiNM4WweY6Lhfn5JLALOTyASRS6tYsf5a8P+cJiZF9b4pC9VWfFMo32+wIP03DqEeu
         1LP0e0+SGrb2nZiwWXq5g6tCj4TS/OvIwctlyMcFZMVEDs18efTR1klq5VL8xrLr7kTo
         dSEMvUZZm8nLUGxfTgotrvQxXJhiNjq9p02rvZM0WOEhjO0X7whASlOy4yuYpCGUIMvz
         bkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dVR4fIFnqBj1P8D1zyzrE8lPHinFuQJmdruk8S76xeM=;
        b=pfF6TI3ZG4eSKxCoorQTdVsRDJtsb35TrlwrYzU26SZO4Gl+Xs3x1Pk0GXVXJwCp+I
         R7c1uzNjBTRwQxmVteU2NVrF6xTCx1gxSkmgPWyfB+TlcvKIukqF4CatVrlnIzgi/2oX
         fzNtEd6NcjhURIIGBzgd25ateCR1RE6cH+hIuepovnQWoU3DqVOTUneigPmy/Eb9zgkN
         1jxkGaxb+VX7hiDzs/U3Pd0Km/oriy8LdZmRuqPR4FIY62skRh9phA8YgjaIuys4dAcD
         MSH59Kp8riQSeogbl4NfQbxoqDIslfyCY73keqGBlfSZrFQPADQLgBqC5+DOC2uMpy6j
         nofw==
X-Gm-Message-State: APjAAAX0aRIVvYM2W4cNOtxb5n+JJr0ZYlmv4tmY/CGLbqm5V+T4dUh+
        Prri6sxEwyP7S84+PXW7P00=
X-Google-Smtp-Source: APXvYqy0tqj03oWE45FyTibwSYi6op8KSBZc9QWMHOxtWPIBnhiU58JJnMP0yJ7VaLJMRRTOpAR5bg==
X-Received: by 2002:a7b:c0d8:: with SMTP id s24mr29443182wmh.30.1575361154886;
        Tue, 03 Dec 2019 00:19:14 -0800 (PST)
Received: from localhost.localdomain (p50991abe.dip0.t-ipconnect.de. [80.153.26.190])
        by smtp.gmail.com with ESMTPSA id 188sm2048197wmz.13.2019.12.03.00.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Dec 2019 00:19:14 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     brendanhiggins@google.com, shuah@kernel.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, sjpark@amazon.de
Subject: [PATCH v2 1/5] docs/kunit/start: Use in-tree 'kunit_defconfig'
Date:   Tue,  3 Dec 2019 17:18:57 +0900
Message-Id: <1575361141-6806-2-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575361141-6806-1-git-send-email-sj38.park@gmail.com>
References: <1575361141-6806-1-git-send-email-sj38.park@gmail.com>
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

