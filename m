Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5CE7A100A
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Sep 2023 23:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjINVvv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Sep 2023 17:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjINVvu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Sep 2023 17:51:50 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AFC270B
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 14:51:46 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59bfccec7f3so10655487b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Sep 2023 14:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694728305; x=1695333105; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f5AmKdq1pRjBoWugao1uMYxjphGEN0AUTFevs+I8FV8=;
        b=DtMkF6B9loTkxqAiL7t9DxXW12XBfzsD5JupOxSD+35qj8/okpJueuqaVxt6qDAA8q
         E1OrM7KA8pZ3YPWjSOXALl+HchfoX4qRVv87qgfA9RzWNtdO6CJ8BGQEwm/mNJ7wzhPt
         enGU8HVrL0b2tlUg5iSagAaqZA1oJJayo5AjfkyXUQMjJAEkdqbXP7aK1OH7t7MlBu2x
         EVg12xfRU/lnVBR2LPWkhlgGtyat0Aqf+G+yzooILGnfEMNoPaBVQ2O5SqrJ3xAgOh1b
         /Y1qTn9wo5TqyjTCT9+k2Ac5I2OO1AdpZaiw1lRGeCagm0F+/N/jNVe+bHsVCwDiETXU
         vdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694728305; x=1695333105;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f5AmKdq1pRjBoWugao1uMYxjphGEN0AUTFevs+I8FV8=;
        b=KS2Rovcez1/opz+AVtaRD0YY/GzNzlE9aSa6OBhOmKabLuB/TVo4JuzuKAkXgfW89x
         OK8P6qywaJ7bPDqh9qufFeo/B34p3DoQce6KyL9vsVUTWBl81ci2o5gp85HjJdwAkAJa
         daPpPybmnXUrQ/mfVKjwpiIXLwAhsNb2r70MPvjtYPoEsRu0bNsnFFSDdUf0NF1VJ4mC
         LRVWQo8IZduXKZ2FmaTNMKx25+eHnSVJlO8JY1CfQlgbfOvZk+qdGCuEpC/7BGusZPUY
         rBNU5CzVygp3eDHEOE7R5eKGQz8vaFXWa+OzQAWnby+vDoBBU3E43jxBzeG/UDOiegxD
         3g/g==
X-Gm-Message-State: AOJu0Ywk4y30sdDbBrtE3KNT/2CXRAWHVB+gTUKXhqr48vEGSFf3H7TZ
        a3eqW/tPQNAYIt8HBH5OQYNlhulieA==
X-Google-Smtp-Source: AGHT+IHC8lDywtd/3DEAcrqeCtnI7BBVZqxz6OQQKZ2Pz6wFZ+PgIiPJP0JXxADfRz+G4oMIAJKsW2usLQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:6902:905:b0:d64:f7ec:6d5d with SMTP id
 bu5-20020a056902090500b00d64f7ec6d5dmr155560ybb.10.1694728305515; Thu, 14 Sep
 2023 14:51:45 -0700 (PDT)
Date:   Thu, 14 Sep 2023 21:51:40 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230914215141.3399584-1-rmoar@google.com>
Subject: [PATCH 1/2] kunit: tool: add parsing of test attributes
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add parsing of attributes as diagnostic data. Fixes issue with test plan
being parsed incorrectly as diagnostic data when located after
suite-level attributes.

Note that if there does not exist a test plan line, the diagnostic lines
between the suite header and the first result will be saved in the suite
log rather than the first test log.

This could be changed to do the opposite if preferred.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 tools/testing/kunit/kunit_parser.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 79d8832c862a..ce34be15c929 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -450,7 +450,7 @@ def parse_diagnostic(lines: LineStream) -> List[str]:
 	Log of diagnostic lines
 	"""
 	log = []  # type: List[str]
-	non_diagnostic_lines = [TEST_RESULT, TEST_HEADER, KTAP_START, TAP_START]
+	non_diagnostic_lines = [TEST_RESULT, TEST_HEADER, KTAP_START, TAP_START, TEST_PLAN]
 	while lines and not any(re.match(lines.peek())
 			for re in non_diagnostic_lines):
 		log.append(lines.pop())
@@ -726,6 +726,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 		# test plan
 		test.name = "main"
 		ktap_line = parse_ktap_header(lines, test)
+		test.log.extend(parse_diagnostic(lines))
 		parse_test_plan(lines, test)
 		parent_test = True
 	else:
@@ -737,6 +738,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 		if parent_test:
 			# If KTAP version line and/or subtest header is found, attempt
 			# to parse test plan and print test header
+			test.log.extend(parse_diagnostic(lines))
 			parse_test_plan(lines, test)
 			print_test_header(test)
 	expected_count = test.expected_count

base-commit: 9076bc476d7ebf0565903c4b048442131825c1c3
-- 
2.42.0.459.ge4e396fd5e-goog

