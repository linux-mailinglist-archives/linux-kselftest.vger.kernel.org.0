Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F3420717D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jun 2020 12:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388652AbgFXKuF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jun 2020 06:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388197AbgFXKuE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jun 2020 06:50:04 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C68A42084D;
        Wed, 24 Jun 2020 10:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592995804;
        bh=7SIVgdLspMOVhiyY9xHIIBtZsP5kIploqroQ6cBqhnk=;
        h=From:To:Cc:Subject:Date:From;
        b=C7SSUgDgre68HsE/hxu+gYfyDwBamN2/pADGzh0wQx9lNvOx/k6lR98mOjvgZ0egY
         wKlg9NeexiMqA0pk37eN4HhXFhTqWIqsMdm23yus3eSRJFO6vGmVV4V4KKzAx72kX8
         DLwlJOkMfL2SfHtFQWV5+ojSsRbv44YYQpTGBQ/c=
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] kselftest: arm64: Remove redundant clean target
Date:   Wed, 24 Jun 2020 11:49:33 +0100
Message-Id: <20200624104933.21125-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The arm64 signal tests generate warnings during build since both they and
the toplevel lib.mk define a clean target:

Makefile:25: warning: overriding recipe for target 'clean'
../../lib.mk:126: warning: ignoring old recipe for target 'clean'

Since the inclusion of lib.mk is in the signal Makefile there is no
situation where this warning could be avoided so just remove the redundant
clean target.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/arm64/signal/Makefile b/tools/testing/selftests/arm64/signal/Makefile
index b497cfea4643..ac4ad0005715 100644
--- a/tools/testing/selftests/arm64/signal/Makefile
+++ b/tools/testing/selftests/arm64/signal/Makefile
@@ -21,10 +21,6 @@ include ../../lib.mk
 $(TEST_GEN_PROGS): $(PROGS)
 	cp $(PROGS) $(OUTPUT)/
 
-clean:
-	$(CLEAN)
-	rm -f $(PROGS)
-
 # Common test-unit targets to build common-layout test-cases executables
 # Needs secondary expansion to properly include the testcase c-file in pre-reqs
 .SECONDEXPANSION:
-- 
2.20.1

