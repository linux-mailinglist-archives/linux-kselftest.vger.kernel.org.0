Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6435748387
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jul 2023 13:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjGELxp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jul 2023 07:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjGELxo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jul 2023 07:53:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B848A1;
        Wed,  5 Jul 2023 04:53:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33CCD6150F;
        Wed,  5 Jul 2023 11:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94540C433C7;
        Wed,  5 Jul 2023 11:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688558002;
        bh=ieO2X/lBi2r10eqVd5hEK+hSNE8vmZv8+Pqsk4DwJpM=;
        h=From:To:Cc:Subject:Date:From;
        b=gQbr81r4/R+ddRIVgmE0eAMEoagIJLFIX/cjIvoNiy+BHkOfX9g/DqXPDJs5WgKQ5
         mqEMTePBQEugZobzXpsEOWAUs4s0uMc/ZTvfK1DSt/K3UZ+dpetvaskhUjLhDVkh4h
         G7vElXTvtboFmjT/+dRKu392wcxUMv3FbCjL8rllPFjlRm5RCcB76a6LlkFEESn4bK
         lJ4C+BvPwEZQJtjURFUCZ84HNsCByMtWqHYWZU5FoJhLHJiCBh3oPVxNgFXF7MKYgs
         NgU4mhEy/5RPVUlBoElbtyXe7z+THStzPCNIJfIVMz7bNE2I8HA9Yfrze6rMdbxKOx
         1Ubm8Txt+ci7g==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        netdev@vger.kernel.org
Subject: [PATCH] kselftest/runner.sh: Propagate SIGTERM to runner child
Date:   Wed,  5 Jul 2023 13:53:17 +0200
Message-Id: <20230705115317.753182-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

Timeouts in kselftest are done using the "timeout" command with the
"--foreground" option. Without the "foreground" option, it is not
possible for a user to cancel the runner using SIGINT, because the
signal is not propagated to timeout which is running in a different
process group. The "forground" options places the timeout in the same
process group as its parent, but only sends the SIGTERM (on timeout)
signal to the forked process. Unfortunately, this does not play nice
with all kselftests, e.g. "net:fcnal-test.sh", where the child
processes will linger because timeout does not send SIGTERM to the
group.

Some users have noted these hangs [1].

Fix this by nesting the timeout with an additional timeout without the
foreground option.

Link: https://lore.kernel.org/all/7650b2eb-0aee-a2b0-2e64-c9bc63210f67@alu.unizg.hr/ # [1]
Fixes: 651e0d881461 ("kselftest/runner: allow to properly deliver signals to tests")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/kselftest/runner.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 1c952d1401d4..70e0a465e30d 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -36,7 +36,8 @@ tap_timeout()
 {
 	# Make sure tests will time out if utility is available.
 	if [ -x /usr/bin/timeout ] ; then
-		/usr/bin/timeout --foreground "$kselftest_timeout" $1
+		/usr/bin/timeout --foreground "$kselftest_timeout" \
+			/usr/bin/timeout "$kselftest_timeout" $1
 	else
 		$1
 	fi

base-commit: d528014517f2b0531862c02865b9d4c908019dc4
-- 
2.39.2

