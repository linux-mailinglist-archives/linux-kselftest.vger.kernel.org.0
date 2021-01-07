Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7342EC871
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Jan 2021 04:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbhAGDAN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jan 2021 22:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbhAGC74 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jan 2021 21:59:56 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231C8C0612F5;
        Wed,  6 Jan 2021 18:58:53 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id t22so2973315pfl.3;
        Wed, 06 Jan 2021 18:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rhsYe5i+iNYy2YtWAGiJLiHidT0qmA7DbVaILE+aFTA=;
        b=VRm9JSgBSzgVPjjCYJGgXAD6UVQjArKSLTnOKsw5DqSlNZwSewvVE9uoUHynt0Sbt+
         bzevmoCkg//UhjoQGS0U2dIcSeOoP8BLeqG1tSVL63ZOQ3cqnPYQ64Nv3s7rfa2K9iNX
         /DwFQ1droaVgGSSZ7MEsSgsq56979hkO8O1zo2bB/q0RXQqgYqZ0HzY66gAuttiLl03A
         S9kG3F7Ar5YQ0V6DZe3cuV7BjT3K+B6sqqf/JmDJWfYyJM9NS8Zf2AKhuhVGlK3fUUDs
         20cYqIKPx+Yl4S8bU8TamnZjKE2wLcRXr09ezCm4Sj4jQgUg9q/cIY2yHwMfIylXZrOy
         3B8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rhsYe5i+iNYy2YtWAGiJLiHidT0qmA7DbVaILE+aFTA=;
        b=BMTmD5Tc2kIBM/hWfYch9gYz/1IhX0vigQ3DEd4iL7S1KEq7pPmXSEHcW2ABNixNvl
         JpeYfsTN4PQtE+T7LcjAiDLcPgQRldEpDKOzQY5vlLlJI3J4AeQXoERiJZpvPk/O3vUP
         HwOy6IdYcAnYlQWuj+s5bqw7NZZz//gstCwHOVLbFgqAtopODBfztfuWIzN6C8fZfF8u
         QEY+DYtjjRi4pICUIDhDfJHbJs2eAQDitFhlCOL47r5OpJVQVEXUQRcDC9Zog+1dBmyH
         FlBhbnfqTxkd54EUxr32WdlscHFXXaPuOdVwtJawCEMxC+fEpo/XUY/sSvVVAYVvWXn/
         1xNg==
X-Gm-Message-State: AOAM530WvFjobdnVQ3WwZRJq6ehyOJOLvP1Vdd8Lk/zfDfYBZMWnPXrs
        LDFAvANFyYElbz/9dnLhLevQW9c7ocUHig==
X-Google-Smtp-Source: ABdhPJyLbmfq/o2IRDpU/qf+Riz/s8svMEKKU6Y+OgLDhL2z5itamKyuldh+Up4a09Y8XV2MMHc+WQ==
X-Received: by 2002:a63:2259:: with SMTP id t25mr7540344pgm.395.1609988332400;
        Wed, 06 Jan 2021 18:58:52 -0800 (PST)
Received: from sol.lan (106-69-181-20.dyn.iinet.net.au. [106.69.181.20])
        by smtp.gmail.com with ESMTPSA id x16sm3900120pfp.62.2021.01.06.18.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 18:58:51 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, shuah@kernel.org, bamv2005@gmail.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 4/7] selftests: remove obsolete gpio references from kselftest_deps.sh
Date:   Thu,  7 Jan 2021 10:57:28 +0800
Message-Id: <20210107025731.226017-5-warthog618@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210107025731.226017-1-warthog618@gmail.com>
References: <20210107025731.226017-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

GPIO Makefile has been greatly simplified so remove references to lines
which no longer exist.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 tools/testing/selftests/kselftest_deps.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kselftest_deps.sh b/tools/testing/selftests/kselftest_deps.sh
index bbc04646346b..00e60d6eb16b 100755
--- a/tools/testing/selftests/kselftest_deps.sh
+++ b/tools/testing/selftests/kselftest_deps.sh
@@ -129,13 +129,11 @@ l2_tests=$(grep -r --include=Makefile ": LDLIBS" | \
 		grep -v "VAR_LDLIBS" | awk -F: '{print $1}')
 
 # Level 3
-# gpio,  memfd and others use pkg-config to find mount and fuse libs
+# memfd and others use pkg-config to find mount and fuse libs
 # respectively and save it in VAR_LDLIBS. If pkg-config doesn't find
 # any, VAR_LDLIBS set to default.
 # Use the default value and filter out pkg-config for dependency check.
 # e.g:
-# gpio/Makefile
-#	VAR_LDLIBS := $(shell pkg-config --libs mount) 2>/dev/null)
 # memfd/Makefile
 #	VAR_LDLIBS := $(shell pkg-config fuse --libs 2>/dev/null)
 
-- 
2.30.0

