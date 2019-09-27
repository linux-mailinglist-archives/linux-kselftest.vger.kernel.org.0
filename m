Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA26BFCA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2019 03:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfI0BQo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Sep 2019 21:16:44 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44619 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfI0BQo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Sep 2019 21:16:44 -0400
Received: by mail-io1-f66.google.com with SMTP id j4so11747409iog.11
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2019 18:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H2GyEMBjk27THtCkzskXmMVgGtiHssCWYkVZJhAzOdg=;
        b=BY3eP8mGIkLH/kjnNmwFxxobZiK8CoYQi9lyd2yXukK5S/NAvSa5KF4f8hpeLfkQuM
         hHoxaOV2Pa6GF2CZECb3AqZAjQ8p/pS1vAuURM2Totchz2gfdi/b/I0AjYAv0jGL0aKX
         552gq4qW4lMnHWn2Ek2jKIBttdf8IHEWRQcnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H2GyEMBjk27THtCkzskXmMVgGtiHssCWYkVZJhAzOdg=;
        b=E8fkQFsw62OYIhpGSB80VkZHfm4t5Td5CrHjjBdoCaJtENoWVc668OmVc8rRfQfKRQ
         arjoOtQHZDRNMPeYdCo6h97MhIS907i+juwyoHcuEoOqTSdD1tnV4896i1oaLlDqOJSI
         twl1mnqyuYajV08xNGyH8c/ysVt/6vLldGmkj32AlzwptYbug4umPPiSn6cigHDvLHYm
         aELxs9hXhXZJxhhEdIhinIEysX7/ptSdEqrBLc0GRK5aUENrl8jSWJ8/Qbf7FaArqSx+
         4GfkDP4h6WzVWXRMCiX2vBigNMCsBQoNxwBymKohkS5LJA/D5vq+2atrBM4A5ga1eFt8
         0uAw==
X-Gm-Message-State: APjAAAXyeaLu+SbdZxboQgNv7jTnIXswYrp3a79naewLBh1h2HsrHnOO
        y+IRrPT5Lq7wmEnzjN0YuAIAJw==
X-Google-Smtp-Source: APXvYqw4JUFgbiVAQSuDwJ3BV44jJ7VB5OKgmirW3uvkHAOBn1S/AOu+UhOVLSlxzghLpFiI9P2BvQ==
X-Received: by 2002:a6b:fa07:: with SMTP id p7mr6298691ioh.164.1569547003964;
        Thu, 26 Sep 2019 18:16:43 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x2sm1652121iob.74.2019.09.26.18.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 18:16:43 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH RESEND] tools: gpio: Use !building_out_of_srctree to determine srctree
Date:   Thu, 26 Sep 2019 19:16:41 -0600
Message-Id: <20190927011641.4858-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

make TARGETS=gpio kselftest fails with:

Makefile:23: tools/build/Makefile.include: No such file or directory

When the gpio tool make is invoked from tools Makefile, srctree is
cleared and the current logic check for srctree equals to empty
string to determine srctree location from CURDIR.

When the build in invoked from selftests/gpio Makefile, the srctree
is set to "." and the same logic used for srctree equals to empty is
needed to determine srctree.

Check building_out_of_srctree undefined as the condition for both
cases to fix "make TARGETS=gpio kselftest" build failure.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
Rsending with corrected address for linux-kselftest@vger.kernel.org

 tools/gpio/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/gpio/Makefile b/tools/gpio/Makefile
index 6ecdd1067826..1178d302757e 100644
--- a/tools/gpio/Makefile
+++ b/tools/gpio/Makefile
@@ -3,7 +3,11 @@ include ../scripts/Makefile.include
 
 bindir ?= /usr/bin
 
-ifeq ($(srctree),)
+# This will work when gpio is built in tools env. where srctree
+# isn't set and when invoked from selftests build, where srctree
+# is set to ".". building_out_of_srctree is undefined for in srctree
+# builds
+ifndef building_out_of_srctree
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 endif
-- 
2.20.1

