Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D0C392554
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 May 2021 05:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbhE0DTs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 23:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbhE0DTs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 23:19:48 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49E4C061574
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 20:18:14 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d20so1625418pls.13
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 20:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qm4MPaPjgxt6Wt7O1hXCl4uTGIhUVq8pe5tFWqw47T8=;
        b=IApI7MULqMdbV/c3QU4t8dUPgrxbMVJ1EO9hRH9e/bBQW75OyyL0P+BJkWGvrh7Jlr
         geDpOIgUZRaqa5d2GZCzdCxRO5z8GP3AAgx3CGws37O6oHfCbuwiKMWTS0tVNF340fu5
         lTCBSXL68/fPRrIrg0vbkPh9PR0gsILO+F6Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qm4MPaPjgxt6Wt7O1hXCl4uTGIhUVq8pe5tFWqw47T8=;
        b=Eyfiw9vv5PVLc+cxo8cZVIaPzOuzMT7yHvLCzDpglm/ipvBK76E3Zl7bigdnNse5ZQ
         mRwYley0U7JweDsltUSeuVBdYi2Ul4qE6NWj7UEyEVx/4NDZXwAxXJ8g/kNQcfTII76x
         nb1cVuFglHkkuHkBww9yuCLmbKRdG2xdax37SJINlXVdhZHrcVAfg6Wnn531wMj3W4ON
         psx9mW3uQuVZcOOD213rK3BzSccpdA6i+zIKoZSoNXkcZPQvt2uq19DldTUH3oBp5pyf
         WEn/hxGPcBdyrVnambvWIuhdEH06SyJmF0N395mFWSiKYc7+ZCintG6sujYWlYHzkF9V
         Fklg==
X-Gm-Message-State: AOAM533M4+IgOReIpASSASF/jTSk0eyoMq4l7WMkKFYHD+dwOGJ4+9Hg
        KmpqOXj+XfhMiu1oLjGCS/jHGg==
X-Google-Smtp-Source: ABdhPJwGuMO4GkZzq25uRtBGQg9C93YagPPD0GwnSROAAnh9tVcSlfKeo/cgglMqPxPQERxGY4G/lw==
X-Received: by 2002:a17:90b:33d1:: with SMTP id lk17mr1484840pjb.154.1622085494279;
        Wed, 26 May 2021 20:18:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g13sm537971pfi.18.2021.05.26.20.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 20:18:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: lib.mk: Also install "config" and "settings"
Date:   Wed, 26 May 2021 20:17:54 -0700
Message-Id: <20210527031753.3729663-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=bde6084bfd555742aaf47be0d27afc429f6b4361; i=xpi8zqp3LrE2VaWlX//Wey2rtF1y5nvUA2wZvOpxGVQ=; m=wDveoOB1Q4vREEjZya4mp/PbmZdFoPgUOgy++USArxE=; p=7N26PE2lhk1+zwus22jZblzAFntKKriypdOsBgfRx4U=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmCvD2EACgkQiXL039xtwCbqzRAAgFt 8z83s21nUXgWIPjIVwx4tJlgeufq8tXMxQOC5OGPpR4ogesBZgpbM7zVMwAbTSae4itb64zRA/2T2 JAccB1MdvcjAmJ/XWtm5QlxZasXSC4fuTbgwxJWuFe/hsxCPgCrw1kk5k7s8SPTcywCLabPY/Ncel iYWhwyHnR2/6QS2X9RAYHlBO8q1KaX8lSWhGJS2kWOdAewj8my4zHUIFXl/nYwhqL1rLlo5VqIb9+ jtN1TC+yyT4pAMXaRu0DN5/z721NGHLrH/PBlDIXoSdZ2vvdCajNl183sqkxZ101DfBlRaBsqLoMU PHfV8KhrtObcl1zTqr8haGTPxodzk4tdR2trA0b878aPpneuiwaCIpbBRt9zfQUx089se0Uhi7rms 43eMd30gM4dQc29PM7E+ns+bnA1s+eUrtu5J2QviJ1ujnW84Q5+fUHZ2bEjFZHB3tB4zX2LtslkWV q9RCTviJZ9SaMQVqIUc4lsv5VxXk/oBCvgDZ3Zq2ecr+scETL9vtf54WprVXAGyBlAsmPJ1Yo5/1w 5hEX7jNxRVyiWwuXHBCVawLUlIuOYarO6f16K0wWtNQ4aDSY1BK9BCTjAMeS9ITDtwBmx08I8P/DO buRo44jfB4HqIUaX6SQijboRM554tU/NdFEU5mlCDdjWeqMBFKN9jozEvK7TF2/4=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Installed seccomp tests would time out because the "settings" file was
missing. Install both "settings" (needed for proper test execution) and
"config" (needed for informational purposes) with the other test
targets.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/lib.mk | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 0af84ad48aa7..fa2ac0e56b43 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -100,6 +100,7 @@ define INSTALL_RULE
 	$(eval INSTALL_LIST = $(TEST_CUSTOM_PROGS)) $(INSTALL_SINGLE_RULE)
 	$(eval INSTALL_LIST = $(TEST_GEN_PROGS_EXTENDED)) $(INSTALL_SINGLE_RULE)
 	$(eval INSTALL_LIST = $(TEST_GEN_FILES)) $(INSTALL_SINGLE_RULE)
+	$(eval INSTALL_LIST = $(wildcard config settings)) $(INSTALL_SINGLE_RULE)
 endef
 
 install: all
-- 
2.25.1

