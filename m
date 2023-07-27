Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8679F766038
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 01:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjG0X1G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 19:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjG0X1D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 19:27:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835672D40
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 16:26:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 140FF61EFF
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 23:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE54DC433C7;
        Thu, 27 Jul 2023 23:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690500416;
        bh=lEQyXOw8+L92MbRB3athy5QEg89g9uJHISFyavHR9aI=;
        h=From:Subject:Date:To:Cc:From;
        b=twsT6MNmQjen/bUyX1fjRBMDTuoxN6BS167FbuvkCklv1lytfS/eBka4BOVL2YTnU
         lBIEFB665G2lz5cU5KUInM5ovR+MCsEY+4kVJzfJgETvPVUrbkQsIk6KxXQjjzXryA
         MKz3x9yPWRgGtfpKABTiM4w68TzPLlF1GTFDYbrBtIbKNt/cl078YOsjdBkVan0p8j
         dGfIZvzR5N5NXXHq8d94eenw8ySEKI5Oh53m3+I8NqDL50heMsnr8CiWaKYNRob/Qj
         SmZO7GC7m4fSMw+d7Ny9otiL1dQbXgFmxYoOVJro8mdBBcIJieW1oiIN9ENC01HOG2
         3iZFJ5/6mAFwQ==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 0/6] kselfest/arm64: Fix a SVE memcpy() issue and use
 tools/include
Date:   Fri, 28 Jul 2023 00:26:11 +0100
Message-Id: <20230728-arm64-signal-memcpy-fix-v4-0-0c1290db5d46@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABP9wmQC/4XNQW7CMBAF0KsgrzvVeBwSw6r3qFg49iSxIA4aV
 ykI5e512EBVoS7/aP77N5VZIme139yU8BxznFIJ1dtG+cGlniGGkhUhGazJgpOxriDHPrkTjDz
 68xW6eIEmsGmNt53TqEq7dZmhFZf8sPa/Jzmu57Nw+b4Pfh5KHmL+muR635/1ev1/atagIbSG0
 SBa2vHHkSXx6X2SXq3oTA+o0fQaogJVu6prkLbedfUfyDxBhK8hUyC0jgMZuw21/QUty/IDMa5
 dn2gBAAA=
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2411; i=broonie@kernel.org;
 h=from:subject:message-id; bh=lEQyXOw8+L92MbRB3athy5QEg89g9uJHISFyavHR9aI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkwv05KImut3IlCIcxh3fSlp9GBA0WrG6FKPyzB4rZ
 7tH9TNWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZML9OQAKCRAk1otyXVSH0IFcB/
 4+r5aX8aYQTkN0YPSS/Cgh6Foh/zJEJ63Gpe/TK3Kzfr175JJ7TV2TrLVkLKkCK3FPZ/1cbgQ9uD/X
 xvUIGg0eQVxZ3/E3eieIy5UjLZKBODqoFZq4WkQIqM17IvQCWIEz5qrJNwt89N3t3sXuNosiEGscFM
 sdRjcWwTLvs0KtusiDWnO4Va60Mc7nFVJ8Zjk9yIKyZK9ugQdmkKlUwprxI8ICTE8Iog/aR7S4GUBc
 TFEeduRGweU2FmB1rRpFBfwwofLU3TusTKVrmhku06jIly8rJ5jAo1ROBSlE7FKRmUN98G3dyL7gnX
 bNjmS7GMvJG8A755pDH9wVWQ3Qbjlg
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

Will noticed that with newer toolchains memcpy() ends up being
implemented with SVE instructions, breaking the signals tests when in
streaming mode.  We fixed this by using an open coded version of
OPTIMZER_HIDE_VAR(), but in the process it was noticed that some of the
selftests are using the tools/include headers and it might be nice to
share things there.  We also have a custom compiler.h in the BTI tests.

Update the tools/include headers to have what we need, pull them into
the arm64 selftests build and make use of them in the signals and BTI
tests.  Since the resulting changes are a bit invasive for a fix we keep
an initial patch using the open coding, updating and replacing that
later.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v4:
- Roll in a refactoring to include and use the tools/include headers.
- Link to v3: https://lore.kernel.org/r/20230720-arm64-signal-memcpy-fix-v3-1-08aed2385d68@kernel.org

Changes in v3:
- Open code OPTIMISER_HIDE_VAR() instead of the memory clobber.
- Link to v2: https://lore.kernel.org/r/20230712-arm64-signal-memcpy-fix-v2-1-494f7025caf6@kernel.org

Changes in v2:
- Rebase onto v6.5-rc1.
- Link to v1: https://lore.kernel.org/r/20230628-arm64-signal-memcpy-fix-v1-1-db3e0300829e@kernel.org

---
Mark Brown (6):
      kselftest/arm64: Exit streaming mode after collecting signal context
      tools compiler.h: Add OPTIMIZER_HIDE_VAR()
      tools include: Add some common function attributes
      kselftest/arm64: Make the tools/include headers available
      kselftest/arm64: Use shared OPTIMZER_HIDE_VAR() definiton
      kselftest/arm64: Use the tools/include compiler.h rather than our own

 tools/include/linux/compiler.h                     | 18 +++++++++++++++
 tools/testing/selftests/arm64/Makefile             |  2 ++
 tools/testing/selftests/arm64/bti/compiler.h       | 21 -----------------
 tools/testing/selftests/arm64/bti/system.c         |  4 +---
 tools/testing/selftests/arm64/bti/system.h         |  4 ++--
 tools/testing/selftests/arm64/bti/test.c           |  1 -
 .../selftests/arm64/signal/test_signals_utils.h    | 27 +++++++++++++++++++++-
 7 files changed, 49 insertions(+), 28 deletions(-)
---
base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
change-id: 20230628-arm64-signal-memcpy-fix-7de3b3c8fa10

Best regards,
-- 
Mark Brown <broonie@kernel.org>

