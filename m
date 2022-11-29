Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434CC63B63E
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 01:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbiK2AEZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 19:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbiK2AEX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 19:04:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBB51CB0A
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Nov 2022 16:04:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F41F4B80FE9
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 00:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42698C433D6;
        Tue, 29 Nov 2022 00:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669680259;
        bh=6fYUZD2RptItW3UVKDYdkWeoAqLeFrxsCToo0H2e0ow=;
        h=From:To:Cc:Subject:Date:From;
        b=Qk056jvqmTCsl/VkerZMwxnJB+bTy6TgrHURejL6X9epgA7vI4wWM50U8Ij9fiVVf
         kBVlIKtaj06ijJmgkzy8j0CYjCmqGKJbdXIeYDwq0HgGltrfaANsqkxvDitT8X+0Vl
         L2glh12TWjVv0OCWMqiKoLwQHsWAF0oQqaIs6ZpqK0C3wSveLcXL5VkB8O2CxhoM4N
         sOFqdxMcmOwFIyBcUpVuWsUTDxzmrfVoag4g7SNNRHVI7jrOGVbso9eCSeoehgOsOg
         X+R3w3IzChsQwXj3OkmEizHza5DxqjMqzkR1OIsj+m4qxGW3rEqkXw+Z5r8KPm4NMC
         8ACBhuqk2Q5nQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 0/3] kselftest/arm64: fp-stress performance improvements
Date:   Tue, 29 Nov 2022 00:03:52 +0000
Message-Id: <20221129000355.812425-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=866; i=broonie@kernel.org; h=from:subject; bh=6fYUZD2RptItW3UVKDYdkWeoAqLeFrxsCToo0H2e0ow=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjhUxnlrSVw0nHjdG1sw6QBHEX3PjZQMIwpIek+J3k HPpGb3SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4VMZwAKCRAk1otyXVSH0MbaB/ 97o0XoQqOm0As2MZZxe971Ht67Q8d5D02qJ99f6V/zsbaf2knfBeNBi4eAeuhivJdwGAVwo1nI3gfH 9cSKvFK/pNGU5klp8tSVbgAqkpHUxQ+CXG3TFLMBHx3LQsjL+BIzg06SAkBp4HueFVS2TdKeSd8ZPp NOx67yt3Pg/qis0UtbPCEMc6y5ggJRpxsQZPGZ7bnroEOb2oTUdqDaBDksX+u0LCpSjfvVz9+sZ0G0 fY4gEU+eG5z+FMXSSYZOKP2LAI14uKBJojex+/BR3KaJxGtzLsbPpHFR12X6p9GkcKahzKpf6fifFm 3QPepivJAjmjPUs0ogIfpeoPwku9RM
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

This series contains a few improvements to fp-stress performance, only
noticable on emulated platforms which both run more slowly and are
stressed far more by fp-stress due to supporting more VLs for SVE and
SME.  The bulk of the improvement comes from the first patch which
reduces the amount of time the main fp-stress executable is swamped by
load from the child processes during startup, the other two patches are
much more marginal.

Mark Brown (3):
  kselftest/arm64: Hold fp-stress children until they're all spawned
  kselftest/arm64: Don't drain output while spawning children
  kselftest/arm64: Allow epoll_wait() to return more than one result

 tools/testing/selftests/arm64/fp/fp-stress.c | 74 +++++++++++++++-----
 1 file changed, 57 insertions(+), 17 deletions(-)


base-commit: a711987490a1784c3e3fd6d752a63501c11eb80b
-- 
2.30.2

