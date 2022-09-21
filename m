Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8513B5DEA8F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Sep 2022 20:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiIUSRg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Sep 2022 14:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiIUSRf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Sep 2022 14:17:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EDEA3455
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Sep 2022 11:17:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ACDD6273F
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Sep 2022 18:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1958EC433D7;
        Wed, 21 Sep 2022 18:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663784252;
        bh=aBVGz+eB0d+PppDzgEG+bs/DglPpA5TFJNyvW0qmRck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KTftuE5dHlO+zicA9hwG12XhFiQUKuPJoJsKFXJ2rzPZtwueEU1z6JaFVAiRi10lt
         8wagfBekXwZlyHEu9LeQw1lhycxwhVjS//zSaaTavfjKpxPV22/A4SdZsOs84VjfPG
         IKjxVcwV5IK35aHByRO31lAcJN3TCrezz9CT9vWkQ0mPFcSS/GPzMlUaSzVORZzFsW
         SVdOmGQDGYvVVv9e4LkfKIw3PsTZBX4HvA47sO3IbbQsCd9wwfWEEdAYiF0sdeRDsZ
         DgxH/QBJcJTe9Ee6/No0CJLOb7vZ9nEVDDUIRt8EDARVkmq0bWxvNhhxhAq1bD4Nlp
         a/kgmbOHKVpXA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/3] kselftest/arm64: Don't repeat termination handler for fp-stress
Date:   Wed, 21 Sep 2022 19:13:43 +0100
Message-Id: <20220921181345.618085-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220921181345.618085-1-broonie@kernel.org>
References: <20220921181345.618085-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=996; i=broonie@kernel.org; h=from:subject; bh=aBVGz+eB0d+PppDzgEG+bs/DglPpA5TFJNyvW0qmRck=; b=owGbwMvMwMWocq27KDak/QLjabUkhmTtkLCzEUdLFlieSerJfxmUsP7AsawiNfFUicBZLjy9aUzJ YTadjMYsDIxcDLJiiixrn2WsSg+X2Dr/0fxXMINYmUCmMHBxCsBE1p9l/8Mjx64ks4XVvk7EJ/ZXhu iKF9xcGf2eUtGqd18bPXsd1tuvMPNRZKAkz9bEoMk+azcf+lHauFyz79b0lQ3dr9+dvicg23hEeBLD rZVaKu4GSlbZ3Gf35hnsj2zjbTzUIX2sZU31lpA38/4u+XBkTaT9hvzjMtGd+9/uvWorqrgqNOd1pP rSz/J562c5ctzy32Z7dvvetqxaqQgv5ti7myY93yDg0Baje5jfplNomeLRGBbLoOeuXGGt50SdOnxj i85Jn33TI7T+zKyQ7QYnkprquGIs1nIo/N0dvrC2wvpLmW1pcs2MtveyMlVF60XlPmzUUJ20xlj8gd zlp8FZV+c/YtteEbybxynIzX8OAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When fp-stress gets a termination signal it sets a flag telling itself to
exit and sends a termination signal to all the children. If the flag is set
then don't bother repeating this process, it isn't going to accomplish
anything other than consume CPU time which can be an issue when running in
emulation.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-stress.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index a5c0ebef2419..4387c3cacaa7 100644
--- a/tools/testing/selftests/arm64/fp/fp-stress.c
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -255,6 +255,10 @@ static void handle_exit_signal(int sig, siginfo_t *info, void *context)
 {
 	int i;
 
+	/* If we're already exiting then don't signal again */
+	if (terminate)
+		return;
+
 	ksft_print_msg("Got signal, exiting...\n");
 
 	terminate = true;
-- 
2.30.2

