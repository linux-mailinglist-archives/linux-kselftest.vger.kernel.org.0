Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A4B58F4A0
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Aug 2022 01:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbiHJXDG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Aug 2022 19:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiHJXDF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Aug 2022 19:03:05 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865F36CD26
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Aug 2022 16:03:04 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id f16-20020a17090a4a9000b001f234757bbbso7909139pjh.6
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Aug 2022 16:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=uYLEpBTIpZJpv0FaEI6rNdEwexq1d/LSyw8WrmmMV2Q=;
        b=EbjQ88OHrNXOUss3JIQ65cwuB86Fb8+QBljwPow7CR0FJiguYoO+495FCdQiJt+dCj
         KgbKxjYxbE6/ThqThN/KiNtI+t91YG5SsfWW0uCbBGmFF4K2oj1D4bUX7tmN99L/Wcby
         cdAqO3YaGzHkAlFkLe24DXcHsLnPwYoN1YFkJhBci01kAW8p69lQqP9/l2qO3NHPFUno
         bRZmI0gbdct9zCYpNfmM9wF6A59zVgg43VTpUwCZrQ+tZvBmAPqkDq/mO+VtMGiar1JL
         VOiME/x5ZJGLzgqx9YAWOY3SQOi/HB7n4QabBrpfQhyPbsjppkH+LUF3iM6GK6HN8FSo
         rJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=uYLEpBTIpZJpv0FaEI6rNdEwexq1d/LSyw8WrmmMV2Q=;
        b=4jTZbbnydKgCYKPWAg4SnHsLNTTLDbEQvD3YnbNLO3LNyYUz8cn02x6baAarzpzI/V
         +Fpu57Cs4f+nJ18mWZfPrtOLhWo460TD7TlnAgFj7VYbmgW3Dqjml5WLEm0NA528IPfp
         bvIM1s0MNZuGz0aD+/oCBDPtob2w1l1X3K4E0M1HmLNcoFC4D/BUZR3/6xv+V2Fx2EV9
         YicGNtAgAnNTcepPWIXDQR3h0sxCh9DU8iNzIB/FW4hiWYx0O7mNwk8klzNrzzOUlwcK
         Xf3QTDBP1sSywmbkVXsDqC82SaOSkBT/OCTKE0nIBTsYQ8h1UTiIZ1kCLshaUXfajfTm
         +P6A==
X-Gm-Message-State: ACgBeo3CfslTszWed39EN/jaEtYaaRjy2iENbC/aela9bEBjoKkbhOIP
        qtYOwcaEidecHjwSxQ8+pbahWcPASCO06g==
X-Google-Smtp-Source: AA6agR4yB/U+63MCa2/8ypKnbaxvKM/W/sKRgIv9GU9v0NRchliLy1Z+GjNF1lVTIKEnGaLckJ90xM7XWjRmag==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a17:90a:590e:b0:1f2:2184:6893 with SMTP
 id k14-20020a17090a590e00b001f221846893mr5939523pji.57.1660172584034; Wed, 10
 Aug 2022 16:03:04 -0700 (PDT)
Date:   Wed, 10 Aug 2022 16:02:58 -0700
Message-Id: <20220810230258.3933707-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH] kunit: tool: make --raw_output=kunit (aka --raw_output)
 preserve leading spaces
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

With
$ kunit.py run --raw_output=all ...
you get the raw output from the kernel, e.g. something like
> TAP version 14
> 1..26
>     # Subtest: time_test_cases
>     1..1
>     ok 1 - time64_to_tm_test_date_range
> ok 1 - time_test_cases

But --raw_output=kunit or equivalently --raw_output, you get
> TAP version 14
> 1..26
> # Subtest: time_test_cases
> 1..1
> ok 1 - time64_to_tm_test_date_range
> ok 1 - time_test_cases

It looks less readable in my opinion, and it also isn't "raw output."

This is due to sharing code with kunit_parser.py, which wants to strip
leading whitespace since it uses anchored regexes.
We could update the kunit_parser.py code to tolerate leaading spaces,
but this patch takes the easier way out and adds a bool flag.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit.py        |  2 +-
 tools/testing/kunit/kunit_parser.py | 10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index e132b0654029..161a3b1b0217 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -206,7 +206,7 @@ def parse_tests(request: KunitParseRequest, metadata: kunit_json.Metadata, input
 		if request.raw_output == 'all':
 			pass
 		elif request.raw_output == 'kunit':
-			output = kunit_parser.extract_tap_lines(output)
+			output = kunit_parser.extract_tap_lines(output, lstrip=False)
 		for line in output:
 			print(line.rstrip())
 
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 12d3ec77f427..1ae873e3e341 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -218,7 +218,7 @@ TAP_START = re.compile(r'TAP version ([0-9]+)$')
 KTAP_END = re.compile('(List of all partitions:|'
 	'Kernel panic - not syncing: VFS:|reboot: System halted)')
 
-def extract_tap_lines(kernel_output: Iterable[str]) -> LineStream:
+def extract_tap_lines(kernel_output: Iterable[str], lstrip=True) -> LineStream:
 	"""Extracts KTAP lines from the kernel output."""
 	def isolate_ktap_output(kernel_output: Iterable[str]) \
 			-> Iterator[Tuple[int, str]]:
@@ -244,9 +244,11 @@ def extract_tap_lines(kernel_output: Iterable[str]) -> LineStream:
 				# stop extracting KTAP lines
 				break
 			elif started:
-				# remove prefix and any indention and yield
-				# line with line number
-				line = line[prefix_len:].lstrip()
+				# remove the prefix and optionally any leading
+				# whitespace. Our parsing logic relies on this.
+				line = line[prefix_len:]
+				if lstrip:
+					line = line.lstrip()
 				yield line_num, line
 	return LineStream(lines=isolate_ktap_output(kernel_output))
 

base-commit: aeb6e6ac18c73ec287b3b1e2c913520699358c13
-- 
2.37.1.559.g78731f0fdb-goog

