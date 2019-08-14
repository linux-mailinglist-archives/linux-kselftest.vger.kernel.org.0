Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC00C8D1EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2019 13:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfHNLQ6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Aug 2019 07:16:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37921 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfHNLQ6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Aug 2019 07:16:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id r9so104422016ljg.5
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Aug 2019 04:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mM+lOG3uuaZKO9SiLPdJ+4deUlKV/b5HbUdj3Mc9GeI=;
        b=DyZlW9rEyj+EVzbT42xD4GrOCx8/nZME5s1x9ubtqPvmzO3OboHv2sJX6yUbEIHv8I
         VJeZOl5WCXgmjaoXlMtr+GU4OSoVo9m2HdDGg6ma9v7dv79kZXAa4eHOQPkPavbyFn+Z
         LmVee68sPKqFRaEehadGBa9OSzLoWu7goRFs3nf90Wxg/kHBHrXxSYTK2wndU3zORTkC
         UOX8E2oWqHFTJiazrI7Xv40sqBbRdSViRNeSDBSnoVsXQ7AQPJetvC21HTDU5G1LhGog
         +VaFBgwg0tdww7ZnKwLqt5Xh0O3zHbQuTmDdkfFTDpbkiN7jrd14O5xaxAP3SkOnv2MU
         pBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mM+lOG3uuaZKO9SiLPdJ+4deUlKV/b5HbUdj3Mc9GeI=;
        b=hEYG6ZSlu7DcsD+2WIX60co1Pj/PYWekyZiWTpo2FszCwDtd8TDEHYpt17khz+N1S5
         FbtkBUum3jacD/i4RpVvFQBD0qScTXYfwJhejWg7mZFX5nE503vFoNYC7ddvrnETEfDt
         GunJYeCpJhnRcGef2To1vFeVx5RCH25vZSm/PPfz9rQ0OfnadkkrLccfN7Sw49wG4RbK
         i9BllFgne/mXRmi9WHBxgrluWEXlpaY+GNHu8FUz/fZThl7Fyiw8FrRBjMf7pu3f1iVU
         DxFFMMgYlEnQqzLNNq1HtAesKQkHOH8/ptzrxdGy4KkgRwFsRXV11FiycEuLc6AwPmGn
         uuKA==
X-Gm-Message-State: APjAAAU1/6arVYbecY2YXtpwTyA8HTj1b0HxHIEYcwnzKxEIq3z20sko
        lYFROKz39kNh8Z0CJ7mbUmpnRg==
X-Google-Smtp-Source: APXvYqyE6JOL4CkL17m8OpVNbigSqpiZyVfokme8qoKLjA4Eav66jqxj/Jm39QFjJRx7gKdhbyUEew==
X-Received: by 2002:a2e:9e81:: with SMTP id f1mr24935605ljk.29.1565781416360;
        Wed, 14 Aug 2019 04:16:56 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id q24sm2004302ljc.72.2019.08.14.04.16.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 04:16:55 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org, pmladek@suse.com, mbenes@suse.cz,
        jikos@kernel.org, jpoimboe@redhat.com
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: livepatch: add missing fragments to config
Date:   Wed, 14 Aug 2019 13:16:51 +0200
Message-Id: <20190814111651.28433-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When generating config with 'make defconfig kselftest-merge' fragment
CONFIG_TEST_LIVEPATCH=m isn't set.

Rework to enable CONFIG_LIVEPATCH and CONFIG_DYNAMIC_DEBUG as well.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/livepatch/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/livepatch/config b/tools/testing/selftests/livepatch/config
index 0dd7700464a8..ad23100cb27c 100644
--- a/tools/testing/selftests/livepatch/config
+++ b/tools/testing/selftests/livepatch/config
@@ -1 +1,3 @@
+CONFIG_LIVEPATCH=y
+CONFIG_DYNAMIC_DEBUG=y
 CONFIG_TEST_LIVEPATCH=m
-- 
2.20.1

