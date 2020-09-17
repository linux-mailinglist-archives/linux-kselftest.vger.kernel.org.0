Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD82026D262
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Sep 2020 06:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgIQEW7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Sep 2020 00:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgIQEW7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Sep 2020 00:22:59 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71889C06174A;
        Wed, 16 Sep 2020 21:16:16 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BsNtv1s87z9sSn; Thu, 17 Sep 2020 14:15:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1600316167;
        bh=E4XTRIY2Yg5zL9/EFXMuDBdNiIOZtiHl+cuCUmjJXGw=;
        h=From:To:Cc:Subject:Date:From;
        b=dnMJXdBQiQhKQ4LlvkTFq7q1SWmi7Eb4zYRGEE9QQcaZauuZnnT20J4dFS2U/Fzi+
         GZL3ChfHLiOflz3xxaPzo4gxvBDzXYh6+HeaSkYEh7IsF5//BOq438Rc0DwZufsa8X
         s8mn7sZfXaMhyNEqA9re1rC/d8sEycbRwpOI2TFRMFPLBYZ/ij34H/KB5+vKps8Ph0
         Yrxqzr5ki4lWVaA/vjkdj0eao/gTxUmZVdKw5aD8nv5GJhkl65Q8MtVQW//x/n/bS6
         cNE9Ew0z9EL18ZIAj0GG5K4MxRkLjshyC5B5bNJdEhsmcbuIErvZbstSHE+BgFPAmT
         4ywo/8iLBpXUA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     keescook@chromium.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jcmvbkbc@gmail.com
Subject: [PATCH] selftests/harness: Flush stdout before forking
Date:   Thu, 17 Sep 2020 14:15:19 +1000
Message-Id: <20200917041519.3284582-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test harness forks() a child to run each test. Both the parent and
the child print to stdout using libc functions. That can lead to
duplicated (or more) output if the libc buffers are not flushed before
forking.

It's generally not seen when running programs directly, because stdout
will usually be line buffered when it's pointing to a terminal.

This was noticed when running the seccomp_bpf test, eg:

  $ ./seccomp_bpf | tee test.log
  $ grep -c "TAP version 13" test.log
  2

But we only expect the TAP header to appear once.

It can be exacerbated using stdbuf to increase the buffer size:

  $ stdbuf -o 1MB ./seccomp_bpf > test.log
  $ grep -c "TAP version 13" test.log
  13

The fix is simple, we just flush stdout & stderr before fork. Usually
stderr is unbuffered, but that can be changed, so flush it as well
just to be safe.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/kselftest_harness.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 4f78e4805633..f19804df244c 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -971,6 +971,11 @@ void __run_test(struct __fixture_metadata *f,
 
 	ksft_print_msg(" RUN           %s%s%s.%s ...\n",
 	       f->name, variant->name[0] ? "." : "", variant->name, t->name);
+
+	/* Make sure output buffers are flushed before fork */
+	fflush(stdout);
+	fflush(stderr);
+
 	t->pid = fork();
 	if (t->pid < 0) {
 		ksft_print_msg("ERROR SPAWNING TEST CHILD\n");
-- 
2.25.1

