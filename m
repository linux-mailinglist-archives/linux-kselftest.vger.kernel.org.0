Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694EA3F0A7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Aug 2021 19:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhHRRtp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Aug 2021 13:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhHRRtn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Aug 2021 13:49:43 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A865CC0617AD
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Aug 2021 10:48:59 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id x4so3020199pgh.1
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Aug 2021 10:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1mY5RIBDNgWagktFsZEnudEN0wbyGTHt9HsdseVRFKY=;
        b=lkw1GFxei+c9lM+dD9uJpW8DM95igP4b7m/SJ7F/1vBejrYpTKSFtUAf3aWrxF9tWn
         v3DYj1UCk0uC+7Q+ySeP9w4Dqm+X0sdsz10+2CKJn1O3ZCId95GoWlD32iRwVx3YbYba
         OYFJhccVe20gKZQT0LbD8pl3H/rCi0S73uBvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1mY5RIBDNgWagktFsZEnudEN0wbyGTHt9HsdseVRFKY=;
        b=fXqVyZZ1r2jPI5oA0WKRV1aDRAXXwyinRIeWdnjkD/p+BIu9volpLHSlKYw6D0f34g
         DXO6aK3sWOEPhdIlxzLcQKVPBoLNWMpV1WTLr0hBBCUatdzh0VyoUjpQcRQIRAtmvTZw
         8T2uvhu3VEbGBxjp4DptVdMClCY08ueFJjafWDx53fnJA/r/eX+oflHrjoXOEL/ay7Z+
         TfDauQOtqyHTwJ4FCg6f+trkON4xtScs0sucMU2SQHvqaXu/dYOayo6Gshns3H7cCPaN
         8/hQ3g1txhXwSUMDwuZz9PC3xtroAkuxLYjxPGNKOktjTPG7WUaSKbzBlzXZ54XiG+63
         IRRw==
X-Gm-Message-State: AOAM532YwLtHoC2D337yITSKguIS71sNUn0JcYWAaiNNacMGbTekKMKO
        VerR7wkYwCpXtT2v9k3kSb7i3g==
X-Google-Smtp-Source: ABdhPJyFeBuwLVlU9TC3ZBx/6QU/4sy4LObAs/CpUDROrocaJs575Va38mcJ2sxKx6dEOTi/qL/Slg==
X-Received: by 2002:a65:690c:: with SMTP id s12mr10069880pgq.401.1629308939206;
        Wed, 18 Aug 2021 10:48:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q3sm455504pgf.18.2021.08.18.10.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 10:48:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        kernelci@groups.io,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 3/4] lkdtm: Add kernel version to failure hints
Date:   Wed, 18 Aug 2021 10:48:54 -0700
Message-Id: <20210818174855.2307828-4-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818174855.2307828-1-keescook@chromium.org>
References: <20210818174855.2307828-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3259; h=from:subject; bh=PtEIiImPUmgrshOeUImaqyYgtJBgocXjAnTdV62YVWE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHUgGpLo07w7JG+djZ75yRYafgXtPwCynK3PTDlkt e7AJbVOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYR1IBgAKCRCJcvTf3G3AJo2GD/ 44EkwrK4hbubbr73YxDXfIpSvaWKhnl8gYOa0sDntMqcNRIYzJmGYpNhEHdFQfkZjk1RJ1SR7n2O4X JN1krgFSEuHeAYQaLTMI81W0lhwr3PnOG2qyVGSS7z9qW/1yxUixQiX9lnQDmHfV3aIdB6bYAnKyOR pcJsx8ZdvhfYBahlY8W5jKhVlBZfYoIJKSmdYG12t02WmGwmz3Kou0uHoq1PBRTwDI0QTdbuToTBmJ n7H+N/4owQAe/L5GbyL+UnU2xQYvhwRRMotH02KzigIHfWeGYlrJdAdQOca9igIJ2g7Inlv3AcTlqE Gq3PQikM0G91IIYlsUngDHXmEbCRgyxB4KnA0CbQ4UsNmGhwBZdfvy4WJXixFYcykknjenN4HikXd4 e1EyGxr0t637X4e47h8JP77RqCA3+WA8PGAGnAiRZZalJBUk7rM0BqagmQTpxkiHFIbA+oLY63qu1y IJ9OypOASHrlhwGXhMe4WNOFN2JIXnct8NgPVRDdUDm5lIP0DWOim/w09zhVdd4tDn0madmZKXHsbF cbHznNBjFl8ghq0XtkLQkBJJW5xkTAu2B5Qu74FoKqtd/polUqitIbEi/ijp+2bJ0F45jjO4Bi3KDH Xz7QoPaVowJvl6NaDr4lP0U3vp231xWWZYgeL8KPCjBTjHdG1JDBxPRyPxaA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In an effort to keep as much information in once place as possible in
CI logs, report the kernel version and architecture in the failure hints.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: kernelci@groups.io
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/lkdtm.h | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index f2e61581c1ae..d7d64d9765eb 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -5,13 +5,17 @@
 #define pr_fmt(fmt) "lkdtm: " fmt
 
 #include <linux/kernel.h>
+#include <generated/compile.h>
+#include <generated/utsrelease.h>
+
+#define LKDTM_KERNEL "kernel (" UTS_RELEASE " " UTS_MACHINE ")"
 
 #define pr_expected_config(kconfig)				\
 {								\
 	if (IS_ENABLED(kconfig)) 				\
-		pr_err("Unexpected! This kernel was built with " #kconfig "=y\n"); \
+		pr_err("Unexpected! This " LKDTM_KERNEL " was built with " #kconfig "=y\n"); \
 	else							\
-		pr_warn("This is probably expected, since this kernel was built *without* " #kconfig "=y\n"); \
+		pr_warn("This is probably expected, since this " LKDTM_KERNEL " was built *without* " #kconfig "=y\n"); \
 }
 
 #ifndef MODULE
@@ -21,24 +25,24 @@ int lkdtm_check_bool_cmdline(const char *param);
 	if (IS_ENABLED(kconfig)) {				\
 		switch (lkdtm_check_bool_cmdline(param)) {	\
 		case 0:						\
-			pr_warn("This is probably expected, since this kernel was built with " #kconfig "=y but booted with '" param "=N'\n"); \
+			pr_warn("This is probably expected, since this " LKDTM_KERNEL " was built with " #kconfig "=y but booted with '" param "=N'\n"); \
 			break;					\
 		case 1:						\
-			pr_err("Unexpected! This kernel was built with " #kconfig "=y and booted with '" param "=Y'\n"); \
+			pr_err("Unexpected! This " LKDTM_KERNEL " was built with " #kconfig "=y and booted with '" param "=Y'\n"); \
 			break;					\
 		default:					\
-			pr_err("Unexpected! This kernel was built with " #kconfig "=y (and booted without '" param "' specified)\n"); \
+			pr_err("Unexpected! This " LKDTM_KERNEL " was built with " #kconfig "=y (and booted without '" param "' specified)\n"); \
 		}						\
 	} else {						\
 		switch (lkdtm_check_bool_cmdline(param)) {	\
 		case 0:						\
-			pr_warn("This is probably expected, as kernel was built *without* " #kconfig "=y and booted with '" param "=N'\n"); \
+			pr_warn("This is probably expected, as this " LKDTM_KERNEL " was built *without* " #kconfig "=y and booted with '" param "=N'\n"); \
 			break;					\
 		case 1:						\
-			pr_err("Unexpected! This kernel was built *without* " #kconfig "=y but booted with '" param "=Y'\n"); \
+			pr_err("Unexpected! This " LKDTM_KERNEL " was built *without* " #kconfig "=y but booted with '" param "=Y'\n"); \
 			break;					\
 		default:					\
-			pr_err("This is probably expected, since this kernel was built *without* " #kconfig "=y (and booted without '" param "' specified)\n"); \
+			pr_err("This is probably expected, since this " LKDTM_KERNEL " was built *without* " #kconfig "=y (and booted without '" param "' specified)\n"); \
 			break;					\
 		}						\
 	}							\
-- 
2.30.2

