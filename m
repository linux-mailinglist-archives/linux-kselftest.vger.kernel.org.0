Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298BE2EC869
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Jan 2021 04:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbhAGC75 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jan 2021 21:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbhAGC74 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jan 2021 21:59:56 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0390C0612F3;
        Wed,  6 Jan 2021 18:58:44 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id t8so2956590pfg.8;
        Wed, 06 Jan 2021 18:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2k4vuLcH934gtl9imeNRk7co7OX7sWtFQJP6UXJ/EJg=;
        b=NRFJfGko95osu3oPNpx8pbx/hgB4OBlmU0Ug9WJHdFh/m4f08O0mbHjVgc6Q1dyQb0
         mgoU7DgGCyF5aKs36rDAMcDpR2OII9oHSG6346jz8TUbORQLJObo0JJzYTM6hQ3sCfYE
         wqo9vJOKeWqyIX/B7KSvJvxPSLVg8aMQU0sPORWsXDrHfbWwapCXpbHnybMRtcvB/QLw
         +d+ocN8B2Y0yIM1Bhet88L71MYdnlrxNwSEsXktcL8PLWXi2Bv58QtavA1m+xMkwFV5C
         a7oWJPV/2otA1aWQp8dNq+ol4j9iAEMSH0EWGsUOgFOxZDcxLXuC+ngiXvKmUE0Oi0it
         Gt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2k4vuLcH934gtl9imeNRk7co7OX7sWtFQJP6UXJ/EJg=;
        b=CXUh+VIsCDPRgdeMpbMbovj0wuw1i8CYenMnmno9/buDyykfrmYdPD8fDrRTE02wZF
         muRJDQxs7X6otssfXCfiuTZVfSuigylMnxPCfX1K2+joQemdKCLIM7qqM+7fUh45o6C3
         7m4AVv1gvpYc4ou6V+QnfEYrjuZbNx+W69CdNz2PFQ6TA3rn8d4FRMBHpzIVr80cytdk
         cDLCDJqBAWKGJFw0oXm5g3fT4fi/SKq2gBjdnS1Hez19psXeSuuYnYOB/GJVuvdbzZbO
         04vjNBN0J37YK6F+qID6KjE0D0wAPOEWhZZ682fdbzhst13M8wFbdAoeAk7v6qL7cWSo
         foiA==
X-Gm-Message-State: AOAM533mKQOhjdmLngpBmIi43YHOArApnKPIsyWHD/MRV1zz5L1Ctu7V
        OVhcMf3MWr/K6wuRnFkPTcO+zVTx8DutnA==
X-Google-Smtp-Source: ABdhPJxtE8MHxsT75wQb9WggnxdGVfpT4t/OWOIBe1zX2rIZLSntUGtl0qm3WxzR88lAg4NCvYTyVg==
X-Received: by 2002:a62:7857:0:b029:19d:fe6a:3069 with SMTP id t84-20020a6278570000b029019dfe6a3069mr221596pfc.3.1609988324194;
        Wed, 06 Jan 2021 18:58:44 -0800 (PST)
Received: from sol.lan (106-69-181-20.dyn.iinet.net.au. [106.69.181.20])
        by smtp.gmail.com with ESMTPSA id x16sm3900120pfp.62.2021.01.06.18.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 18:58:43 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, shuah@kernel.org, bamv2005@gmail.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 3/7] selftests: remove obsolete build restriction for gpio
Date:   Thu,  7 Jan 2021 10:57:27 +0800
Message-Id: <20210107025731.226017-4-warthog618@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210107025731.226017-1-warthog618@gmail.com>
References: <20210107025731.226017-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Build restrictions related to the gpio-mockup-chardev helper are
no longer relevant so remove them.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
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

