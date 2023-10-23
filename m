Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129777D37FB
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Oct 2023 15:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjJWN0T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 09:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjJWNZ0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 09:25:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C742D5E;
        Mon, 23 Oct 2023 06:23:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6AFC433CD;
        Mon, 23 Oct 2023 13:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698067431;
        bh=7YKUNDbMUGXSSUeiwJ4pvwvRXBVAoVFkUMX3lRaprx0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=PWLcOKFhupYV9/bqMkM4lxQOSU/F1PNenDMqUP2nr8ywu6exhRiNukK+uIE+/Zw/c
         iU+iSf44SJ9vy/SBSkqAC+YxOtzhvgKTMBqc7TRBMBfZALr2dZDRuRlBDlB3EMaj/S
         XucKem9LvbMEQhmfOwcurZlACzDVBxyEzVI8wE6X7ANEfKHjtFde5bkUAFu+e3dbOH
         /HqHCchaB0EKA50WNP80jGAxcGnkzWPPKzvkPADrDoU42JXIisU5Qv9UF/x/aGgspD
         OAOuOjyXcNYyk8DnhXrvCRIokWRE/LP0SKZKFLnrLfcQThSCE2rzqmDL2Yrq6xTYCD
         EoRc0h+CkS3sg==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 23 Oct 2023 14:20:43 +0100
Subject: [PATCH RFC RFT 4/5] selftests/clone3: Allow tests to flag if
 -E2BIG is a valid error code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-clone3-shadow-stack-v1-4-d867d0b5d4d0@kernel.org>
References: <20231023-clone3-shadow-stack-v1-0-d867d0b5d4d0@kernel.org>
In-Reply-To: <20231023-clone3-shadow-stack-v1-0-d867d0b5d4d0@kernel.org>
To:     "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1887; i=broonie@kernel.org;
 h=from:subject:message-id; bh=7YKUNDbMUGXSSUeiwJ4pvwvRXBVAoVFkUMX3lRaprx0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlNnPGU1TmRkbNZV+PUcum00dEkiIMDqfUoWpyRl5x
 dSWGE7uJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZTZzxgAKCRAk1otyXVSH0MsuCA
 CBCxQGFxf1wABIz0HrZYeAmZPKrdLDZvInZAqm14LQGGXm+SenttiAoWPxh2g9cS5O0r/b5yDwhRk9
 0kReorlYqDoFBe8QMuSijaS+TIvVfVyx7Izl8FtllIa0TI6F5H3DGnA7gOzdYHO7uKSSTyXXWxCybO
 vepIT1S7c8t51eEQox1oI3oHwxuoz9gZUX6+YvtzKAwvVQZkF72BwHB+Eq3hj4eodzm8Y4tYILokmS
 wKDbliHKE9QXK9IQ8/cxhuoNjpyhf9gmgYjWnfcLfgGUYzJvII30VWOCtWBY4jBF+slAgqS9yLcs5o
 WnIUWfg74tyCf7jv7//409H63hoNrb
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The clone_args structure is extensible, with the syscall passing in the
length of the structure. Inside the kernel we use copy_struct_from_user()
to read the struct but this has the unfortunate side effect of silently
accepting some overrun in the structure size providing the extra data is
all zeros. This means that we can't discover the clone3() features that
the running kernel supports by simply probing with various struct sizes.
We need to check this for the benefit of test systems which run newer
kselftests on old kernels.

Add a flag which can be set on a test to indicate that clone3() may return
-E2BIG due to the use of newer struct versions. Currently no tests need
this but it will become an issue for testing clone3() support for shadow
stacks, the support for shadow stacks is already present on x86.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index afe383689a67..f1802db82e4e 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -39,6 +39,7 @@ struct test {
 	size_t size;
 	size_function size_function;
 	int expected;
+	bool e2big_valid;
 	enum test_mode test_mode;
 	filter_function filter;
 };
@@ -141,6 +142,11 @@ static void test_clone3(const struct test *test)
 	ksft_print_msg("[%d] clone3() with flags says: %d expected %d\n",
 			getpid(), ret, test->expected);
 	if (ret != test->expected) {
+		if (test->e2big_valid && ret == -E2BIG) {
+			ksft_print_msg("Test reported -E2BIG\n");
+			ksft_test_result_skip("%s\n", test->name);
+			return;
+		}
 		ksft_print_msg(
 			"[%d] Result (%d) is different than expected (%d)\n",
 			getpid(), ret, test->expected);

-- 
2.30.2

