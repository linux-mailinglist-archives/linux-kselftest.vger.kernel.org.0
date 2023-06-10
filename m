Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8533B72AC46
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 16:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbjFJO2D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Jun 2023 10:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjFJO2C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Jun 2023 10:28:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C255C0;
        Sat, 10 Jun 2023 07:28:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E70C60BA6;
        Sat, 10 Jun 2023 14:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C98CC433D2;
        Sat, 10 Jun 2023 14:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686407281;
        bh=3Pl5NNj2WQ4a63Fd2+LlFzfDj6G+Cm0dgJqNQzNyZQ8=;
        h=From:Date:Subject:To:Cc:From;
        b=StLs+5sSCfED37rmgsW+raG3Uanrv72zHKlmWZKgPQemF0Mu8zr0/aCo/Bcv6Wwk3
         EBPtwcgKnfYmfvEKmdjW9ByC/rftbzUqJ4dtEW8QEiChxTkTryPBTMujF2fYhEetzR
         WOIGpZlBkjsbrOKYzkhLHU6k7FFRBxJMWT2xmfvQuvujHi7mUATB7U3Yg9G7vc4rkU
         rV4bZ26oxyHN5dN6N8wCcGuJk9ao99UoZGE53ZcC4vn46JNCDtKj+l2q/G8CLG/wXr
         mmByefGRTsM6876KuxvkQYRvxQmxstGc0uhPhkLqDq4N/dUjh5xj7iRwcUFdnB3dny
         SD+VKeOQNZ5vA==
From:   Mark Brown <broonie@kernel.org>
Date:   Sat, 10 Jun 2023 15:27:55 +0100
Subject: [PATCH] selftests/ftace: Fix KTAP output ordering
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230609-ftrace-ktap-order-v1-1-0abf4d0d6922@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGqIhGQC/x2NQQqDMBAAvyJ77kKqVrFfKR42yVoXIZGNqCD+3
 ehxBoY5ILEKJ/gWByivkiSGDO9XAW6k8GcUnxlKU1amMR0Oi5JjnBaaMapnRf+xTU1t7V3bQe4
 sJUarFNx4l1vU6daz8iD7s/r153kBAXYY/HoAAAA=
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bfdf5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1045; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3Pl5NNj2WQ4a63Fd2+LlFzfDj6G+Cm0dgJqNQzNyZQ8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkhIhuaqKU9QXH2Pd0o8iH20hNSB1wgszxiKpcyQG8
 LrJ3CViJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZISIbgAKCRAk1otyXVSH0PZ7B/
 96xG/o6pwehdllnuUNb0odnFd8tIOYO6YiGGQub0HRhsU3Gp6d8FQfkc4DlEXgS0dBSZe+ZQO1Rndo
 D2S094tGQeyYk+Zj1vFmk/K+E1J2GMQhgONIaBovcAqEmOiBn833BY4IBLtPbcRbVi2zyjmkWywpjy
 UXJDmLvQqZEEBBBLKsawcOlc/BNolOirV3IX3CQtBbxN71CAZJHYNjj4g5VLmdKHopSqi9SSwl736o
 +hFfKiX/lk+6Wa74JToobApkYEzwoA0U2o/oEqpvSK25LMfCSiIRny9IO9yZjuA7tKXYnPVyNS/RG4
 tlt+V8Rv3QI1qnrEvQg6meRk3lxFYY
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The KTAP parser I used to test the KTAP output for ftracetest was overly
robust and did not notice that the test number and pass/fail result were
reversed. Fix this.

Fixes: dbcf76390eb9 ("elftests/ftrace: Improve integration with kselftest runner")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/ftrace/ftracetest | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 2506621e75df..cb5f18c06593 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -301,7 +301,7 @@ ktaptest() { # result comment
     comment="# $comment"
   fi
 
-  echo $CASENO $result $INSTANCE$CASENAME $comment
+  echo $result $CASENO $INSTANCE$CASENAME $comment
 }
 
 eval_result() { # sigval

---
base-commit: dbcf76390eb9a65d5d0c37b0cd57335218564e37
change-id: 20230609-ftrace-ktap-order-d5b64a74dc79

Best regards,
-- 
Mark Brown <broonie@kernel.org>

