Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE03641CE09
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 23:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346941AbhI2V3F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 17:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346925AbhI2V3D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 17:29:03 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19979C061767
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 14:27:22 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id j19-20020a05620a411300b0045dc3262e59so11122516qko.22
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 14:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GBgRPmylRP0XaI5E/LihaXT2Ir7X1xpw3ZInKRc4R50=;
        b=WHFQA+g25qkYPYFpep7vNNJTNwmmqsk9uHkMIXOXNnU9O5BPIQRfnn5cf/mGs1NaL+
         ogKT12Uh8k7K5urhYrNFdvA4MuqXpUSda3nB7WGcM7+TmYrb/KYXzXGlDr9DjrUV16I0
         rHwXYiunO8+vv1D/AhHbPY96DW0Dfw4rFl3WW3/Ie+sLyrSpeG+6nYS6+7KwC3QaTDAy
         kvG8F8Pay8skbykgIct0kmcVyTHUENlCleH7rnpjrTRQd1yF+nB+oZnvHiXisnyqj5hF
         B7JP6NY+hXsfKoG5gBkQZLzz+ZbQt1dS3slr7Wa8EFv5hkH1pcrphEZcixGC7BD/sLiC
         7jgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GBgRPmylRP0XaI5E/LihaXT2Ir7X1xpw3ZInKRc4R50=;
        b=iSkp7uD1zBy2odVAcBf2yd8aEDiUIYWCfuu9cTi5D4AtPnCRfOrK6CaHLhvweUXERv
         moxYwrlETIY1/eWw1sFsmYCerX2DQzcar2F9e7Sy3cxKZuFYGRX1YsL9OeKLP5MxQY3t
         homxFwcaBw5bydDXVyxH3As98jqnik8e5kE9OZPsQKYQuH3ZFQ6XmTOUgVBywSKWB7rK
         3ZCFNmiFrO+k4hucm/rFceUvEj0C0Lqk56TovhJNbMxrQaXbX5ds504bZiOyxHZ7RSsW
         tZqOmBIO4RQodydVjTWFwp2vukhYgzfNKhlaVPhoNUPZXkQSKhXq98o/1pfoQMwJzzjt
         ZDkw==
X-Gm-Message-State: AOAM531BDkptLht0t9MJrze1AzoEjW7Z3Rj0ipotiZer99wplQPRmSio
        e5mUIv4M07AIXr3aRBShZc+8ZjoIAVJyuzpGtUuuWw==
X-Google-Smtp-Source: ABdhPJyf4SNenqCX/qG/XKTasyzdp9ORUzCCpdL0aIBEMr9txfgQG0Tiw87AG132HGgvqre40Hvbdjn6vQZh3WqzsjyZdQ==
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:83f4:ff43:90d6:efd3])
 (user=brendanhiggins job=sendgmr) by 2002:a05:6214:362:: with SMTP id
 t2mr642333qvu.64.1632950841307; Wed, 29 Sep 2021 14:27:21 -0700 (PDT)
Date:   Wed, 29 Sep 2021 14:27:09 -0700
In-Reply-To: <20210929212713.1213476-1-brendanhiggins@google.com>
Message-Id: <20210929212713.1213476-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20210929212713.1213476-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v2 1/5] gcc-plugins/structleak: add makefile var for disabling structleak
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com, arnd@arndb.de,
        keescook@chromium.org, rafael@kernel.org, jic23@kernel.org,
        lars@metafoo.de, ulf.hansson@linaro.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KUnit and structleak don't play nice, so add a makefile variable for
enabling structleak when it complains.

Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
Changes since last revision:
 - None
---
 scripts/Makefile.gcc-plugins | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index 952e46876329a..4aad284800355 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -19,6 +19,10 @@ gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF)		\
 		+= -fplugin-arg-structleak_plugin-byref
 gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL)	\
 		+= -fplugin-arg-structleak_plugin-byref-all
+ifdef CONFIG_GCC_PLUGIN_STRUCTLEAK
+    DISABLE_STRUCTLEAK_PLUGIN += -fplugin-arg-structleak_plugin-disable
+endif
+export DISABLE_STRUCTLEAK_PLUGIN
 gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK)		\
 		+= -DSTRUCTLEAK_PLUGIN
 
-- 
2.33.0.685.g46640cef36-goog

