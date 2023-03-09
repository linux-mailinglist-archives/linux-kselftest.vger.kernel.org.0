Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8467C6B2816
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 16:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjCIPCd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 10:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjCIPBq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 10:01:46 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F58E3CD8
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Mar 2023 06:58:39 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536c8bcae3bso22364307b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Mar 2023 06:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678373919;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bEFeJ9xyxhy0W7bJZiAq/kKy1WMrrLIg7OiI+XOB/AI=;
        b=AECFctgy1Pb6vzSBgJ5svnQmNInplL1FiLFI2a2aQW8hYY0ThUh2VXXfsjbvTYbuxp
         8bYTu6CJ5iozTv5Q1hZT/09unkP8ISm2HYkFp8SM9xTFypTEUXFmzIS+yWoNWdtpiBRQ
         f20CjjG1vOvbxVh1dWew0Z11D4PAp1XilSYSNoSSJSrRs19Mi8uqELGYfgXwZCjfswiB
         nc+ASgKzk7rzNu8E3BELtDZggkPQ2Mp7dcaGHHoUAeZaxn+HtSuyeFKjFTJCEbOJT2w6
         R6C96lohFpiGLEfxtvwzPM6D2Ox5o45l6dH/w8a/m+X9qtAbR7tlPegUZcOvFr8sj3XO
         G90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678373919;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bEFeJ9xyxhy0W7bJZiAq/kKy1WMrrLIg7OiI+XOB/AI=;
        b=iDVxvQoh48U/YthziQdfh2LOYCLGZAWcF1TYT+nYRMOBbKwSjWYqtxeFtRn0ax/3bH
         AxoFNtbKoknwplif7/WW1PnG/t5l/S7WbXA8eEZb1qnlv66qrrPPOJR9CVxqtlQx/6rd
         9CbC18Y/N2q3uJCBK70rVxhp3ihIBLznVU8MvFqvJE3PLI6tPwLdQ6TJKTAvX0oEc77G
         nn54YJ0ufafHl5nzl/uk+zhjOnj8MTSv4MQ9d3lfE8FFaYw7JXB8/cu0nPJXXxR7DSAG
         8y9n7Q1VLz/Y8y/0OboOMOrmA01AQkXQvttAGfrZTkIbHcaNpEMQAVcXDQOPCEWuQCZF
         rU3A==
X-Gm-Message-State: AO0yUKWTpmvd6lVh81w7eiCeQFKApqbjsAe9wimAs75q0+13TACkIR34
        8jYAPzDAP1kqLqAabeg48CaeFVblqtQkjoJUkw==
X-Google-Smtp-Source: AK7set/l9cs7UWAKSKs9FQRi78JWaUa6FnoB45C4CsKXxl/oHSoKLAbKTacFmQ3+lOqkO4R7DQQ2r7vi/X0tpx7d7w==
X-Received: from peternewman0.zrh.corp.google.com ([2a00:79e0:9d:6:9c2a:d34f:579c:b74e])
 (user=peternewman job=sendgmr) by 2002:a25:9f84:0:b0:8ac:72e3:c743 with SMTP
 id u4-20020a259f84000000b008ac72e3c743mr3566181ybq.9.1678373918808; Thu, 09
 Mar 2023 06:58:38 -0800 (PST)
Date:   Thu,  9 Mar 2023 15:57:57 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230309145757.2280518-1-peternewman@google.com>
Subject: [PATCH] selftests/resctrl: Use correct exit code when tests fail
From:   Peter Newman <peternewman@google.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        eranian@google.com, Peter Newman <peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use ksft_finished() after running tests so that resctrl_tests doesn't
return exit code 0 when tests fail.

Consequently, report the MBA and MBM tests as skipped when running on
non-Intel hardware, otherwise resctrl_tests will exit with a failure
code.

Signed-off-by: Peter Newman <peternewman@google.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index df0d8d8526fc..69ebb0d7fff6 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -77,7 +77,7 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
 
 	ksft_print_msg("Starting MBM BW change ...\n");
 
-	if (!validate_resctrl_feature_request(MBM_STR)) {
+	if (!validate_resctrl_feature_request(MBM_STR) || (get_vendor() != ARCH_INTEL)) {
 		ksft_test_result_skip("Hardware does not support MBM or MBM is disabled\n");
 		return;
 	}
@@ -98,7 +98,7 @@ static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
 
 	ksft_print_msg("Starting MBA Schemata change ...\n");
 
-	if (!validate_resctrl_feature_request(MBA_STR)) {
+	if (!validate_resctrl_feature_request(MBA_STR) || (get_vendor() != ARCH_INTEL)) {
 		ksft_test_result_skip("Hardware does not support MBA or MBA is disabled\n");
 		return;
 	}
@@ -258,10 +258,10 @@ int main(int argc, char **argv)
 
 	ksft_set_plan(tests ? : 4);
 
-	if ((get_vendor() == ARCH_INTEL) && mbm_test)
+	if (mbm_test)
 		run_mbm_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
 
-	if ((get_vendor() == ARCH_INTEL) && mba_test)
+	if (mba_test)
 		run_mba_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
 
 	if (cmt_test)
@@ -272,5 +272,5 @@ int main(int argc, char **argv)
 
 	umount_resctrlfs();
 
-	return ksft_exit_pass();
+	ksft_finished();
 }

base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
-- 
2.40.0.rc1.284.g88254d51c5-goog

