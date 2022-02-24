Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348BB4C23BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Feb 2022 06:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiBXFy0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Feb 2022 00:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiBXFyZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Feb 2022 00:54:25 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FF620E7B6
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 21:53:52 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id e13so814057plh.3
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Feb 2022 21:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X+fhHEd3jlnDXmWsjXWOtvRUtFULIhTMPTR4VyvQoy8=;
        b=RDF4vBClMeC8l7SvlXrKraf+fvZTpJLC/TAm4V/1sh0nrygDDyFA2i7Utje46X2DSF
         dy39/tOwODcZiZpUEVr/EsbgxsrLDy1LhBcJ33c4hxN3d/FTXStTUeOK85tSQ6u2dJsU
         I2qDdml4zKKsUfommEdrkuuECe1qqRkkkrhoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X+fhHEd3jlnDXmWsjXWOtvRUtFULIhTMPTR4VyvQoy8=;
        b=gocC4NPXe3Th61CPFuQWTSSYDfWwDjW5tO3TYQFFbTKUUI5vtsbMop2dRq8kvFJlvJ
         7yrgaX1byM8JGsMQS1hu01XjH6TEK2zmrVQ0fd3LEZLNiUKqPoXVGLVLFWVlLeXEnNCk
         NO3MHNr2sMBPqFKWpaU1rhu5jPUw2xRDNZniQ6iCXyuqdZx02nk9iZTTzaY32pUzGXlD
         QJWeDTJxEqbooSsjj5eSeucBuDo5LpAp13InO0R39p+hkQU7qdWi0LCkB676r89coRce
         e9UeLX8Rxwq7EIKbUZMkilPKK+VqRhuGvijU7pK/2tIOMLlXPOMKItEhMWPMRelRhNYU
         kubQ==
X-Gm-Message-State: AOAM532KzKbUn+RurmQ5pLHmCwaY9k1LlQKWQiiM0u/W8AMO+dZSVLmf
        NL7yMSyie2CZl40QF1c0degZeQ==
X-Google-Smtp-Source: ABdhPJwEk0I9qGNOiW9mqLlsyO3VeOVHZwPgcxgaYSmQnzHzA+2Hw0piO9smF1SXlQFL0Qkr6fggjA==
X-Received: by 2002:a17:90b:4f4b:b0:1b9:3798:85f8 with SMTP id pj11-20020a17090b4f4b00b001b9379885f8mr12952612pjb.139.1645682032347;
        Wed, 23 Feb 2022 21:53:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bd14sm1432528pfb.165.2022.02.23.21.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 21:53:52 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, David Gow <davidgow@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] kunit: tool: Do not colorize output when redirected
Date:   Wed, 23 Feb 2022 21:53:50 -0800
Message-Id: <20220224055350.1854078-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349; h=from:subject; bh=QoKmh1KrreLF9dnMSlur2KZOYmGGj8snN9TMwvzF6pU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiFx1t5TIN4DE+l35lN/t7HqhOYX6R8zXo63qOJpoC XCoeUEuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYhcdbQAKCRCJcvTf3G3AJqwcEA CqhZmOZ6Qk8yoxbUXNU1/AHvyiSmTBFuOuMo2IKLEl0Xc74ZNRR4ooGY321fS1vaxkoro98RWzTh2A 4r6ZWc2CYpeL7EnLnpk0p9ITpiTKm/78pidQv/7CcVM1n7DClAKF6wdcQifUGX10oU1hZKBUhq8pzh hNjMkY8XyO6tZA4GpHuEkcc3NqN2ONxm3AnNouTKnRu0NoUDcGju9gIXgL4bnsSLLLZMEwVkloqQpK LUm0v6txonSYFcX47gDXH5OHIshyz9MiqxwOoBl5Cp/BWK8mF6/WQJvF3iBcKeaKfX0Q1MMB3uL39r fxdLlyIGGIs3Kvo6t5tiiZ8PO70EjjuyaaxcPSTaNGZjMS/UxRKuPdVHiA0dyjnlEZ+n3b3GpraTDl W7Tl47s1biFVmTfO9MjmhIUgLzWAQO0nv5/M1OYDpbDp1ZNs6DlXarv4lSHN5UAwxi35Tnh8fyKNYX YQdDKMqxjXNCXD7PB5sEW/7o9libQ9hX9II6F3S4ZXjDtE3xEd79zuvUJrbqCqlz17C3KdEyFGCv5j /q530KLSfnh9tH7bzZTunL3ZvvZtiAI6MesHFOd29rscBw7VSeadjE/GDoezYVsBMFUs/yq63MpMAj j200GU7aqofMO6INycsdpQk5yp2VeRSvEylF9P2HGjaSuIyd1ieVfCrUClJg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Filling log files with color codes makes diffs and other comparisons
difficult. Only emit vt100 codes when the stdout is a TTY.

Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/kunit/kunit_parser.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 05ff334761dd..807ed2bd6832 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -11,6 +11,7 @@
 
 from __future__ import annotations
 import re
+import sys
 
 import datetime
 from enum import Enum, auto
@@ -503,14 +504,20 @@ RESET = '\033[0;0m'
 
 def red(text: str) -> str:
 	"""Returns inputted string with red color code."""
+	if not sys.stdout.isatty():
+		return text
 	return '\033[1;31m' + text + RESET
 
 def yellow(text: str) -> str:
 	"""Returns inputted string with yellow color code."""
+	if not sys.stdout.isatty():
+		return text
 	return '\033[1;33m' + text + RESET
 
 def green(text: str) -> str:
 	"""Returns inputted string with green color code."""
+	if not sys.stdout.isatty():
+		return text
 	return '\033[1;32m' + text + RESET
 
 ANSI_LEN = len(red(''))
-- 
2.30.2

