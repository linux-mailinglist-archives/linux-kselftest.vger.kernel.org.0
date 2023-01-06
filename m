Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F626660711
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Jan 2023 20:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjAFTYk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Jan 2023 14:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjAFTYj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Jan 2023 14:24:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610F314017;
        Fri,  6 Jan 2023 11:24:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1CCA9B81E54;
        Fri,  6 Jan 2023 19:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D00C433D2;
        Fri,  6 Jan 2023 19:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673033075;
        bh=pUhCzZXW5uAhkeucFRyrJOvPIYXPSxjQMSSltvsf5GU=;
        h=From:Date:Subject:To:Cc:From;
        b=Zg7s+fH2r6yDUAXq7LG9zDV6ebrf7mSY33tZ0Wv9vInilOm+PQPBl7YI/pyB1U5r1
         i6OYuslhR+AnFPfzdcIMMIkNJ+HtIAJCqzs21ZJXUmP5R0OA8bDsjBpP3qMVu55s+f
         DrnaN2JuWSGlXo3+hk3R2Cb/j3vYuuF9VmOAInQvLttwvM8X6jnBFMsivq+Uh9mZ/y
         SBj4t9anW09U/WadQFpbIILYOVgtiJpRWwAh5XTVnSlHvrhOnVM7Xx40GTGGDuPWSz
         9YJJrDuwmJ9ixKglReDDYj5XZJUpK43C12eywkDyBi947ntU/hbkRlxp96MChHKxGU
         18my1U1xeiA2Q==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 06 Jan 2023 19:24:19 +0000
Subject: [PATCH] KVM: selftests: Fix build of rseq test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230106-fix-kvm-rseq-build-v1-1-b704d9831d02@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGN1uGMC/x3N3QrCMAyG4VsZOTbQ1vmDtyIepG10QVe3RMdg7
 N7tPHw/ePgWMFZhg0uzgPIkJu9Sw+8aSB2VB6Pk2hBc2DvvjniXGZ9Tj2o8YvzKK2PrKR3OkXwO
 J6gwkjFGpZK6jX76YVsH5Wr/V9fbuv4Apj854XoAAAA=
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Oliver Upton <oliver.upton@linux.dev>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-214b3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2193; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pUhCzZXW5uAhkeucFRyrJOvPIYXPSxjQMSSltvsf5GU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjuHVxdxGpcompwADLK642hJjFryKat+gJATaaaUrJ
 4OqQOO2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY7h1cQAKCRAk1otyXVSH0GxeB/
 41bDW/XmF/u3hghygJer46nez9Uh+ZOg7fBgU9rscLSq41/MoAoXDn+rjn/3v8TmsjvUXopoHL1YCo
 hzVYuH4J8zE68t3nJ0iIrqbCG9W2lCyQD79HTk4nQDzbeYHQ6SLNnP3E8Zo+Oy1O/aUIoF9fE/4X+u
 K3hI1kwXXS4jcqok2ji9NyhAzwJ89fwLhcm2la4juA32a6Hm3dBqo0dVslfHQniYt0yhhX1EHChkOH
 H10Tl1n1TSuulr+dsf+nWZGToPrdF3fuqYRmWQ0JImG8fntrX+IGf0jV9A6Xbnp5cNB+fRt6YbAutL
 w+NZIjpBhYkZYki8wkyEFBwY25d58S
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The KVM rseq test is failing to build in -next due to a commit merged
from the tip tree which adds a wrapper for sys_getcpu() to the rseq
kselftests, conflicting with the wrapper already included in the KVM
selftest:

rseq_test.c:48:13: error: conflicting types for 'sys_getcpu'
   48 | static void sys_getcpu(unsigned *cpu)
          |             ^~~~~~~~~~
In file included from rseq_test.c:23:
../rseq/rseq.c:82:12: note: previous definition of 'sys_getcpu' was here
   82 | static int sys_getcpu(unsigned *cpu, unsigned *node)
          |            ^~~~~~~~~~

Fix this by removing the local wrapper and moving the result check up to
the caller.

Fixes: 99babd04b250 ("selftests/rseq: Implement rseq numa node id field selftest")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
This will need to go via the tip tree due to the breaking change being
there.
---
 tools/testing/selftests/kvm/rseq_test.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index 3045fdf9bdf5..f74e76d03b7e 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -41,18 +41,6 @@ static void guest_code(void)
 		GUEST_SYNC(0);
 }
 
-/*
- * We have to perform direct system call for getcpu() because it's
- * not available until glic 2.29.
- */
-static void sys_getcpu(unsigned *cpu)
-{
-	int r;
-
-	r = syscall(__NR_getcpu, cpu, NULL, NULL);
-	TEST_ASSERT(!r, "getcpu failed, errno = %d (%s)", errno, strerror(errno));
-}
-
 static int next_cpu(int cpu)
 {
 	/*
@@ -249,7 +237,9 @@ int main(int argc, char *argv[])
 			 * across the seq_cnt reads.
 			 */
 			smp_rmb();
-			sys_getcpu(&cpu);
+			r = sys_getcpu(&cpu, NULL);
+			TEST_ASSERT(!r, "getcpu failed, errno = %d (%s)",
+				    errno, strerror(errno));
 			rseq_cpu = rseq_current_cpu_raw();
 			smp_rmb();
 		} while (snapshot != atomic_read(&seq_cnt));

---
base-commit: 469a89fd3bb73bb2eea628da2b3e0f695f80b7ce
change-id: 20230106-fix-kvm-rseq-build-41ac58ba1d27

Best regards,
-- 
Mark Brown <broonie@kernel.org>
