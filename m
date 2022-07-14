Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD39575297
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jul 2022 18:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiGNQQq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jul 2022 12:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGNQQp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jul 2022 12:16:45 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0C461B13;
        Thu, 14 Jul 2022 09:16:44 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s206so2002681pgs.3;
        Thu, 14 Jul 2022 09:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zfIj5qyV6W5yq5ox/J/cFoftvvx5vCMig2RVtH35Sq0=;
        b=qBHQS5KPrKzSzz4fy6T9DYMJgzLJNlkHeAEn5yHBzp9NxCz6UhFfzv4tg6UsDM/DdS
         6tmyS/NoJZcPWLEz9WhqiHGAOCsnhKIg+3swRPT2CgDu4l/h52SKR8U/PmzZVF9uEA8M
         7EAOfpgwvf/g8lLvmqVU2kdTccflOzpQyhyjtHo2z+KpOvCXhvpTeODyjsU010zbEH9m
         9imXtC9n1DQC9aKUZ7LPzp5uB0hoyfSSC167M/ozlhZHCdKFnntxxYHMNpKyTZ6gffpb
         hQHaiFnmOePz2wCpRyxzelsoROPFJhDlEyTbZ9Y9M40tpzPdNZJ8pxMm6xKfDNz1UWce
         BUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zfIj5qyV6W5yq5ox/J/cFoftvvx5vCMig2RVtH35Sq0=;
        b=U3Ev80oWYqhdkBdu1/RwtCAsa0EwSWxrqH+o8KkL1LKz7a/5uxkp4Jbmm6pOYdh+Wu
         VaZ7zhHoA9zYW+3uZSh3oNfLeLRXem+qGQCektfK0naDG6uh8WxL1uv7zTbnWluuYsIN
         pC/gPhve0BgTqRYyN3XS3kN5kiwxfHuft538PADsBnLTvlRjLW604zDiSPiCjwIQr0iX
         cLaerxn+nkJmG/OGH3mspbsCzGN//qzg0oiRF+I0oIEfTLzoHLYn7IMTiv9hO7/a1vnw
         hBgclvuYscry7kAMnE8UgbR9CSwACoRhg/OrpfYp6mQOnpc4qqo0FPTbyeRPpUmPZ8Cp
         FQnw==
X-Gm-Message-State: AJIora/uv2esr46ZG19eU66NL55vNysz3aMOkPoIJs3v3oAlBjVIzBYw
        1GZJ5a3at2lgle9gUB8JGEw=
X-Google-Smtp-Source: AGRyM1sbmcRbyKVTh1//ROU61N3Fczq0SjQ7kXeTzNSuebeT5GQeN8KQgtCY2GGlhG/jcEIxLci7nQ==
X-Received: by 2002:a05:6a00:1312:b0:528:2ed8:7e35 with SMTP id j18-20020a056a00131200b005282ed87e35mr8900166pfu.13.1657815403880;
        Thu, 14 Jul 2022 09:16:43 -0700 (PDT)
Received: from fedora.. ([103.230.148.189])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902780a00b0016b68cf6ae5sm1654281pll.226.2022.07.14.09.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 09:16:42 -0700 (PDT)
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     shuah@kernel.org
Cc:     Gautam Menghani <gautammenghani201@gmail.com>,
        linux-kselftest@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/kcmp: Make the test output consistent and clear
Date:   Thu, 14 Jul 2022 21:46:29 +0530
Message-Id: <20220714161629.5488-1-gautammenghani201@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <bdcac68c-e227-6376-9d71-aa667596c4e6@linuxfoundation.org>
References: <bdcac68c-e227-6376-9d71-aa667596c4e6@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In the KCMP test, currently the functions ksft_print_header() and
ksft_set_plan() are not used due to which an error appears in the
output. Also, the result of the tests is being printed multiple times
because the output is printed by both ksft_print_cnts() and
ksft_exit_fail()/ksft_exit_pass(). 
This patch makes the output format of this test consistent. Currently the
output is as follows:

+TAP version 13
+1..1
+# selftests: kcmp: kcmp_test
+# pid1:  45814 pid2:  45815 FD:  1 FILES:  1 VM:  2 FS:  1 SIGHAND:  2 
+  IO:  0 SYSVSEM:  0 INV: -1
+# PASS: 0 returned as expected
+# PASS: 0 returned as expected
+# PASS: 0 returned as expected
+# # Planned tests != run tests (0 != 3)
+# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
+# # Planned tests != run tests (0 != 3)
+# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
+# # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
+ok 1 selftests: kcmp: kcmp_test

With this patch applied the output is as follows:

+TAP version 13
+1..1
+# selftests: kcmp: kcmp_test
+# TAP version 13
+# 1..3
+# pid1:  46330 pid2:  46331 FD:  1 FILES:  2 VM:  2 FS:  2 SIGHAND:  1 
+  IO:  0 SYSVSEM:  0 INV: -1
+# PASS: 0 returned as expected
+# PASS: 0 returned as expected
+# PASS: 0 returned as expected
+# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
+ok 1 selftests: kcmp: kcmp_test


Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
---
Changes in v2:
1. Describe the changes in detail.

 tools/testing/selftests/kcmp/kcmp_test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kcmp/kcmp_test.c b/tools/testing/selftests/kcmp/kcmp_test.c
index 6ea7b9f37a41..25110c7c0b3e 100644
--- a/tools/testing/selftests/kcmp/kcmp_test.c
+++ b/tools/testing/selftests/kcmp/kcmp_test.c
@@ -88,6 +88,9 @@ int main(int argc, char **argv)
 		int pid2 = getpid();
 		int ret;
 
+		ksft_print_header();
+		ksft_set_plan(3);
+
 		fd2 = open(kpath, O_RDWR, 0644);
 		if (fd2 < 0) {
 			perror("Can't open file");
@@ -152,7 +155,6 @@ int main(int argc, char **argv)
 			ksft_inc_pass_cnt();
 		}
 
-		ksft_print_cnts();
 
 		if (ret)
 			ksft_exit_fail();
@@ -162,5 +164,5 @@ int main(int argc, char **argv)
 
 	waitpid(pid2, &status, P_ALL);
 
-	return ksft_exit_pass();
+	return 0;
 }
-- 
2.36.1

