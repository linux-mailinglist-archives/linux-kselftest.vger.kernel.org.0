Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769661C5334
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 May 2020 12:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgEEK1Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 May 2020 06:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728751AbgEEK1Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 May 2020 06:27:16 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86386C061A0F
        for <linux-kselftest@vger.kernel.org>; Tue,  5 May 2020 03:27:15 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z22so931885lfd.0
        for <linux-kselftest@vger.kernel.org>; Tue, 05 May 2020 03:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jihPcHqZJxL0w4uFWCdf0HGMcvBOKxr0NZgIqhD7lxo=;
        b=OVBthVSECWKCBn2KnlD3uQIl5WfCHuggSsbUuiKGbM3X9Ykk9Q8K/5AJ6iG1wO0nri
         kQjdWqQgxq/JydpWOmrzUfhmVq+eU6pZEQlp6lZIZCwrUWVBJNBX4mJV25R927HluQIZ
         71XMOkY2QloMubs3C1Ws0N0b0/dEf70e2Tf/waWzCgeOY+jAndgJFIftAxVFBSwTLcNc
         G/szc2j4nA7/pbCFBqNW89aqlpDMbJrV8GghavXxQwz2avBk3ot0j38xwF9kRyC8ZW7J
         WrHnHSm6DQrQsYqc4xZL7Rf8RzQSUweD+vxYnlA7GbGcT6oAg66sAty1n2WDzZPFPBfA
         /4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jihPcHqZJxL0w4uFWCdf0HGMcvBOKxr0NZgIqhD7lxo=;
        b=iT++/8maGSv0HUW6D+Y4/Kx1vMMd5wuaHIz72Rg9jzzC0v1zFzLYX5mKqSXmVesCGE
         kTNs4eej4bSSlMW2mJEsFNYSiRz2m9AHpuBqT4RTFRnBLud1g/9pB1VvPVCr4bFpJJIy
         6RNitNJj5BOBaYx7hG6jPvKA2+NUQ1bYkqBEScZMOZCE0R2gUnsOUqu63I90e9A5kyrE
         zJW/BUHHlnpp2TjCwqswENZ2g6DsXaE7TBLgVzmikdwi6MNH36Yy7nvgRtZZ5P/GnO1J
         ykw+RCFqU3prJDYxtIO8lejvpFIBIxA1i3INR7aRS8D16cVl4IbzRpSgEAzEu9cxH2eS
         zsJw==
X-Gm-Message-State: AGi0PuZOMDZw4dKikwCzi6eutF4z56TtsfiQ6N9Ml3uApX3xIH36Rpvj
        CfES53BKub/nChica/uXAHZD8w==
X-Google-Smtp-Source: APiQypKpdW8hKetp8Jqgh6uRz+2gEnfGkBOL+DStJXzeg0o3+FfpgqQ+sY3l4YkxKS0l1jMXnbGmaw==
X-Received: by 2002:a19:505c:: with SMTP id z28mr1245732lfj.174.1588674433983;
        Tue, 05 May 2020 03:27:13 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id e16sm1878000lfc.63.2020.05.05.03.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 03:27:13 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     brendanhiggins@google.com
Cc:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-security-module@vger.kernel.org, elver@google.com,
        davidgow@google.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2 2/6] kunit: default KUNIT_* fragments to KUNIT_RUN_ALL
Date:   Tue,  5 May 2020 12:27:09 +0200
Message-Id: <20200505102709.7964-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This makes it easier to enable all KUnit fragments.

Adding 'if !KUNIT_RUN_ALL' so individual test can be turned of if
someone wants that even though KUNIT_RUN_ALL is enabled.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 lib/kunit/Kconfig | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 537f37bc8400..e6a60391fa6b 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -15,7 +15,8 @@ menuconfig KUNIT
 if KUNIT
 
 config KUNIT_DEBUGFS
-	bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation"
+	bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation" if !KUNIT_RUN_ALL
+	default KUNIT_RUN_ALL
 	help
 	  Enable debugfs representation for kunit.  Currently this consists
 	  of /sys/kernel/debug/kunit/<test_suite>/results files for each
@@ -23,7 +24,8 @@ config KUNIT_DEBUGFS
 	  run that occurred.
 
 config KUNIT_TEST
-	tristate "KUnit test for KUnit"
+	tristate "KUnit test for KUnit" if !KUNIT_RUN_ALL
+	default KUNIT_RUN_ALL
 	help
 	  Enables the unit tests for the KUnit test framework. These tests test
 	  the KUnit test framework itself; the tests are both written using
@@ -32,7 +34,8 @@ config KUNIT_TEST
 	  expected.
 
 config KUNIT_EXAMPLE_TEST
-	tristate "Example test for KUnit"
+	tristate "Example test for KUnit" if !KUNIT_RUN_ALL
+	default KUNIT_RUN_ALL
 	help
 	  Enables an example unit test that illustrates some of the basic
 	  features of KUnit. This test only exists to help new users understand
-- 
2.20.1

