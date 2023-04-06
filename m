Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795FD6D9D65
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 18:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjDFQUB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 12:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239465AbjDFQTt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 12:19:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DC1900C;
        Thu,  6 Apr 2023 09:19:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC43664768;
        Thu,  6 Apr 2023 16:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD67C433A0;
        Thu,  6 Apr 2023 16:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680797988;
        bh=++zNwcSvxuvcUruv0Gya29HZho1aCqvr9WTM7oScMPk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=KHX9RlDeOcOSZPjOEdA39fogBMLXNJUCWUwoeXThX1YV9iAO+6fchFnoB/LoP8WwI
         w+0tbpzOa5q2/lBrCIaBlI87IJ+3/vcf/h9gGAxsKUepkSy691HM+vckt7ZkKICgxW
         03K9RpGL3JEsZG54jXV+E1pxZfCSJwcRKJoC06SYPa2re3c2C61IBK8GbZEwgXeO0m
         sU0CrQTC7D/jbA43E1zD35szpsQaKuRKH+sex0fUENsp0yaO3YTaB14T+a7YBe9g63
         w+S1VoPkwF9LY0PizFIEA4RgkLyDLxnik2Q1Chpk2XGCufWvzDfhMtAd1AuekTDBJn
         AGkSvq8q7E8KA==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 06 Apr 2023 17:19:11 +0100
Subject: [PATCH v2 2/3] kselftest: Support nolibc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-kselftest-nolibc-v2-2-2ac2495814b5@kernel.org>
References: <20230405-kselftest-nolibc-v2-0-2ac2495814b5@kernel.org>
In-Reply-To: <20230405-kselftest-nolibc-v2-0-2ac2495814b5@kernel.org>
To:     Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, Willy Tarreau <w@1wt.eu>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350; i=broonie@kernel.org;
 h=from:subject:message-id; bh=++zNwcSvxuvcUruv0Gya29HZho1aCqvr9WTM7oScMPk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkLvEbGBPMa+8eLFOunlnQO2Bnog/OzyRVZ8UQpN5/
 cpoY/2CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZC7xGwAKCRAk1otyXVSH0A6WB/
 95MDc2pK0/NSwOlf16ZLbXjyO1/x6E8GByQsIfG/binvjX22FR0u8nWSBDyo63QrXGXH8LgGnpG/dX
 iLs7g3al8Sg/EZKYhaDKelNiyEXjBmwp81lbdGUM/C+dS0a5Qhrg1SUo5sF0VgLoQs4tyAEJdb6d+N
 keUQZ5kKSjlfjpqKtX8JS71GF3ayw6MWD5T2OuvUHG2KT1XY5BPjQ7o7eiEsFJ2SI1oZBKnyyHOgzd
 bsXE89JxwbQIKULckk9wX0qEbX7kVHSpffbGHuxGxtihh126yHgG0njGnRC60W/gJ6bNZtjOM/cxnW
 bq0o1cqUpBow8nCFce74tvFQhztkI0
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rather than providing headers for inclusion which replace any offered by
the system nolibc is provided in the form of a header which should be added
to the build via the compiler command line. In order to build with nolibc
we need to not include the standard C headers, especially not stdio.h where
the definitions of stdout, stdin and stderr will actively conflict with
nolibc.

Add an include guard which suppresses the inclusion of the standard headers
when building with nolibc, allowing us to build tests using the nolibc
headers.  This allows us to avoid open coding of KTAP output for
selftests that need to use nolibc in order to test interfaces that are
controlled by libc.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kselftest.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 33a0dbd26bd3..829be379545a 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -43,11 +43,13 @@
 #ifndef __KSELFTEST_H
 #define __KSELFTEST_H
 
+#ifndef NOLIBC
 #include <errno.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <stdarg.h>
 #include <stdio.h>
+#endif
 
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))

-- 
2.30.2

