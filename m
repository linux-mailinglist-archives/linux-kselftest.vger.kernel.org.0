Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE5A1CDB00
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 May 2020 15:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbgEKNOx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 May 2020 09:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730198AbgEKNOs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 May 2020 09:14:48 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9377EC061A0C
        for <linux-kselftest@vger.kernel.org>; Mon, 11 May 2020 06:14:47 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w20so9432995ljj.0
        for <linux-kselftest@vger.kernel.org>; Mon, 11 May 2020 06:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hd5CEiw3xAmj+Qu84GZ/dMO9hkSOA6ixaeeAM/KiNHU=;
        b=t/q/Xu2Wsk1cQP379bqb7AKPnMVYlzvnTZ2iToF9D09oipRJWynKJ+gRR+xoVRGhom
         6pD/9G8cClGfg/m8k9yWgDTlOIQbm9Ixb6cWlOWc6rC7qy407QUS0Rka78Hf+0F+RzNM
         Ujd1KPanQ5orj9cBzjrZfDRy5lLAxw1jJCOqjN4grijylK/LSWTGqs2BjeJWF8qPKUAy
         SqwMRZfnwvux94TcbbUvcFI2qJKwwB2+W0O7QQA+5+IjPMogtRBJae4RHVct7pW7Obgz
         z3gIn0kYZs/dFBbBaETQJRSXt/eQ7otP//1WDRZgjNOexrXZffr+COFscNImDd2SZgMA
         uJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hd5CEiw3xAmj+Qu84GZ/dMO9hkSOA6ixaeeAM/KiNHU=;
        b=drUWdTOgWNgr96gYjhx3Axj38hwZuKWtGsQuHkAPFZ3/des9bMYHnIY+TQ6e45BG14
         LRkujLGWNQaqEVM80xkbOtYI0eA7mzEAVVujJRKo3c1lSYkLu5X2wgrT/c3T2AgEz8fu
         o4kiTomk8W3d8CHl9HOx1esCNezEkVXQUvJYES8gGz7EBvcbs1v9kWiCdWG+kHKYDceF
         HVScsn8lJWzyvMA3sgm2yJU4ugVPvywautFVdeEfr9/6Brj50VDyU16L8ojtcZhkbBl3
         p1KFF9B5Xsqg+F5OPHUHr1MIVi98UlmXrxrVijWvQCCjmm6cdWhNUrIn2DfmV9qIQamx
         D6iA==
X-Gm-Message-State: AOAM530cvis9gyaxMHHOoZRAoLBd5PwFCiTMD975+QGqXmEAbYTAtIY1
        fJhjzcz1qIr/k4DKufwrBRGbug==
X-Google-Smtp-Source: ABdhPJyoLfetCr2ckH+XHqfj73a09MRKqeRqRgsIHcO5n6iFQ2egpeSzjj4Oiamdu1pt1MeA5mVJZg==
X-Received: by 2002:a2e:920e:: with SMTP id k14mr10674436ljg.288.1589202886078;
        Mon, 11 May 2020 06:14:46 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id h11sm10223074lfp.22.2020.05.11.06.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:14:45 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com
Cc:     gregkh@linuxfoundation.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, akpm@linux-foundation.org,
        brendanhiggins@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-security-module@vger.kernel.org,
        elver@google.com, davidgow@google.com,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v3 6/6] security: apparmor: default KUNIT_* fragments to KUNIT_ALL_TESTS
Date:   Mon, 11 May 2020 15:14:42 +0200
Message-Id: <20200511131442.30002-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This makes it easier to enable all KUnit fragments.

Adding 'if !KUNIT_ALL_TESTS' so individual tests can not be turned off.
Therefore if KUNIT_ALL_TESTS is enabled that will hide the prompt in
menuconfig.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 security/apparmor/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
index 0fe336860773..03fae1bd48a6 100644
--- a/security/apparmor/Kconfig
+++ b/security/apparmor/Kconfig
@@ -70,8 +70,9 @@ config SECURITY_APPARMOR_DEBUG_MESSAGES
 	  the kernel message buffer.
 
 config SECURITY_APPARMOR_KUNIT_TEST
-	bool "Build KUnit tests for policy_unpack.c"
+	bool "Build KUnit tests for policy_unpack.c" if !KUNIT_ALL_TESTS
 	depends on KUNIT=y && SECURITY_APPARMOR
+	default KUNIT_ALL_TESTS
 	help
 	  This builds the AppArmor KUnit tests.
 
-- 
2.20.1

