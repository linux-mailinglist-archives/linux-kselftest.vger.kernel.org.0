Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A37E2E861A
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Jan 2021 03:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbhABCb2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Jan 2021 21:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbhABCb1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Jan 2021 21:31:27 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729BEC0613ED;
        Fri,  1 Jan 2021 18:30:47 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id 11so13117031pfu.4;
        Fri, 01 Jan 2021 18:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nyvt7pFCSbmO3hBXQ6BbIkgIhUbkWIr3HmW21pocJGE=;
        b=g22l5FbIr+rd3inrzR1bwzDmzw9tnxs4F/ho3pjOUoKRkw0TIOA0XlTys6KSt+7YlM
         X2zdk6Dm0orCwrUTcRPr+Ftel33IpedOEOn6aa//Hem+s6q3QQAc6dCn/51PQZ8xslWY
         T3rgXzLPnzmJx1I6vHgJB/r2gtNhvFNivumRems8mJnkE0eNjIUrDZEAu6n5MZES6A3W
         xl7ftYm9jAgGAb2KBdcmZHjtrNK1zFCWoND33hRCkHX3oiXrEyhOjpQ9pVssGcYkDF61
         3nZ7q5SOv7TFttRq9LaMASwoIV4Z95tTH+ABOd1JSe9Y8Bxklzqt/tqNaSImORoDltRM
         NQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nyvt7pFCSbmO3hBXQ6BbIkgIhUbkWIr3HmW21pocJGE=;
        b=QRrfZPAQni18Ur8t9C/0EPV4C6LZT5pVn/YFjXUzgR/E2r2HRc4Lja81pncwtfVBf/
         +y3LrbF/nEEORLT80ljMpykQUe67Kqz+wbHLIo+g7t/CbLck1NN5irp6VNWAkHNqgjJf
         2GLO5P5L1K4fh0RJ998QMYOn59m/CZIA1VY/a2/sNtuOThIgLdBfRR7Qv2ANEGqi8mg4
         hCav5bMrnMBSbG4mIAayGekzfPu0ExqoAETJ1xH95jcD9heeBWU5n140hkf/kerzXN8S
         rxSBTNU+e+1A2LrLjxW/YtVBk4gFv3A5+OMqtmQodYS8s26doKIS1O+bw2oMH+qxVSol
         eMCQ==
X-Gm-Message-State: AOAM531bicSHezKhQOJcHc9O6BNR3QF1qKPgHLqLkXaBqWvNe/79EH5i
        e31f2kiBLAs5lqdumQW6iYnn7abg+OjJNw==
X-Google-Smtp-Source: ABdhPJxlW03422xwhWlMryeNFqs6RIzhcFGb7ywNsxuVdkDPWS1tiCUlO8JTdDLqUWxblpfrauObvQ==
X-Received: by 2002:a63:e14a:: with SMTP id h10mr44461868pgk.297.1609554646186;
        Fri, 01 Jan 2021 18:30:46 -0800 (PST)
Received: from sol.lan (106-69-181-20.dyn.iinet.net.au. [106.69.181.20])
        by smtp.gmail.com with ESMTPSA id cl23sm13995664pjb.23.2021.01.01.18.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jan 2021 18:30:45 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, shuah@kernel.org, bamv2005@gmail.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 3/7] selftests: remove obsolete build restriction for gpio
Date:   Sat,  2 Jan 2021 10:29:45 +0800
Message-Id: <20210102022949.92304-4-warthog618@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210102022949.92304-1-warthog618@gmail.com>
References: <20210102022949.92304-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Build restrictions related to the gpio-mockup-chardev helper are
no longer relevant so remove them.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 tools/testing/selftests/Makefile | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index d9c283503159..5411041e63a0 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -121,15 +121,6 @@ ARCH           ?= $(SUBARCH)
 export KSFT_KHDR_INSTALL_DONE := 1
 export BUILD
 
-# build and run gpio when output directory is the src dir.
-# gpio has dependency on tools/gpio and builds tools/gpio
-# objects in the src directory in all cases making the src
-# repo dirty even when objects are relocated.
-ifneq (1,$(DEFAULT_INSTALL_HDR_PATH))
-	TMP := $(filter-out gpio, $(TARGETS))
-	TARGETS := $(TMP)
-endif
-
 # set default goal to all, so make without a target runs all, even when
 # all isn't the first target in the file.
 .DEFAULT_GOAL := all
-- 
2.30.0

