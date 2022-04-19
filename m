Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59478507A9A
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 22:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238819AbiDSUHm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 16:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353459AbiDSUHl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 16:07:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5280526E2
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 13:04:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3140B81BE5
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 20:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA44C385AD;
        Tue, 19 Apr 2022 20:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650398692;
        bh=niTA8yGMk6C4xgjH095qVgtFQfGX5ZsTIZzuU2FMXv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cmoiAeVJQLpEEO1xoBGc+MggPwsq+kaIj4CQps+oRe3pNr6onqbu4cO+tAPEMxK0z
         Vd78pGt+WdYxAZreW8uu/5XXx0gyE2Z5TTP9y8Qv313UQYzXteQfP8JXr+kJARbg9I
         59E7J1QyZ3YrE4gkq6u7lhv5VLn0zOfKhFQwaTE/tnYJXQ6yW11/d0jwinRlCfpibn
         EYwx+ST333cjYz8/AKB9+lWANv2lrqcQc4J0cNYLgpywhjIM5+hfxsPxqmHli5zFYH
         d9CbbOfHALf9rFDBpfViuntY2p2bV/vpTppQNdYkfqpaWErcyNUoTZmhYZeSOdVZKW
         WlmgXDejvdAxg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/4] selftests/arm64: Use TEST_GEN_PROGS_EXTENDED in the FP Makefile
Date:   Tue, 19 Apr 2022 21:04:39 +0100
Message-Id: <20220419200442.1374548-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419200442.1374548-1-broonie@kernel.org>
References: <20220419200442.1374548-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1191; h=from:subject; bh=niTA8yGMk6C4xgjH095qVgtFQfGX5ZsTIZzuU2FMXv8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXxXXEfHRkox3RJIBu/7fbWnH2l7INwpX/OiKMaPF WTHZ5J2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl8V1wAKCRAk1otyXVSH0C1TB/ 9w0toICpb9ncpkP6RjijQOYWHz6puq5CkBW0Ucba1gBnW2AyLFr03nsrPJ7euQ2TPbVCzLfHpe+tsY wXYYYVaCUQQkp68gapJwjehjGrcEHkpw9gInBlVEW/zr82Re4FZAR1iHTOHs4NXVpBjvpJoEIA0+4H WGFIvGE/oVdWf9rAdr76NO34UBj4wDS3X3gXzDCaY8QV0xKOco7kZWun1OP1oSMBrm0rqVr9WJhCiN dIueHk9XiS0wAofTpvXL7esfpsSP0fr3RaVYX5/upEfT2cW345NKxfnSDjhR2mRWJxCVFYjCpgMsz2 xULFIk3ToXIj6y7KuXXl4mcJ3ttWA9
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kselftest lib.mk provides a default all target which builds additional
programs from TEST_GEN_PROGS_EXTENDED, use that rather than using
TEST_PROGS_EXTENDED which is for programs that don't need to be built like
shell scripts. Leave fpsimd-stress and sve-stress there since they are
scripts.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/Makefile | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index 95f0b877a060..774c38cee317 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -2,12 +2,11 @@
 
 CFLAGS += -I../../../../../usr/include/
 TEST_GEN_PROGS := sve-ptrace sve-probe-vls vec-syscfg
-TEST_PROGS_EXTENDED := fp-pidbench fpsimd-test fpsimd-stress \
+TEST_GEN_PROGS_EXTENDED := fp-pidbench fpsimd-test \
 	rdvl-sve \
-	sve-test sve-stress \
+	sve-test \
 	vlset
-
-all: $(TEST_GEN_PROGS) $(TEST_PROGS_EXTENDED)
+TEST_PROGS_EXTENDED := fpsimd-stress sve-stress
 
 fp-pidbench: fp-pidbench.S asm-utils.o
 	$(CC) -nostdlib $^ -o $@
-- 
2.30.2

