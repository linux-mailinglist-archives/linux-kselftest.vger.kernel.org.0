Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C8C498759
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jan 2022 18:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbiAXR4a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 12:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244618AbiAXR42 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 12:56:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F38EC06173B
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 09:56:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C751A61342
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 17:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA1EC340E8;
        Mon, 24 Jan 2022 17:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046987;
        bh=A4dTcxdiMEpob7Qjo6ALcqtb9i+y7Qv74WWLMA3iZLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l5nCZE08xeto5ZmnoZ/9pryHAT0mJVqZqBLoDZGibJpBEdcjmsvp/uTdpYxkKWCfT
         RNh4FQeph+JiGr9hH+GtiCmBIuS1LUIeondAXk7gTI0HStxmBoEYupJPxIM+IxYIbn
         YE7Z0DOHoTG4VkqvaU12zL/UOTbqPunHP7kV6jrpXSX+Hc+f3bH3pAwM3w5PkZWvgW
         jg89CgjiX4uqdntTitbJWoyvCJbOqJlSTer7Kqyc7UVP8Miz4wQW6od1XUDRuIyBmk
         aE0yAwkVJa+Kd/66ejMpEDxPCKqvYLl1HNeVuzSRRMFjl2SwYmirRzyL6+gxx7AX1U
         t6bgPpOiS5yZg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/2] kselftest/arm64: Correct logging of FPSIMD register read via ptrace
Date:   Mon, 24 Jan 2022 17:55:27 +0000
Message-Id: <20220124175527.3260234-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124175527.3260234-1-broonie@kernel.org>
References: <20220124175527.3260234-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=942; h=from:subject; bh=A4dTcxdiMEpob7Qjo6ALcqtb9i+y7Qv74WWLMA3iZLU=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh7ugOqKrONxgzpSuS/PO069iwpnfj7MvwdzEI5KK6 bYAYF/+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYe7oDgAKCRAk1otyXVSH0MRJB/ 9kgYGlNtHXmC6I+1cmXJSZs0opRewqELV7HzZBaE1QeWK9TkFL17BeDxPU7ZdBf6gsrYt3Q1yAkmxA L3wTeKAE6CJ4EegrxvUnQoJO7vvcEGpOP6wOdvRo6U2tG93t1Rd0lfMhaZc7EKnFfMIDmlf96nCkjx OyTaz0Jmtb3ER+4GxBSrdTjeOkX0UxXx9Gb8lFXW9OuOFFxku+v4L0ti4H9VRYfGM5zUPflB76DuaX N6DaI4/f/1uvoPt5zINz2W1lAASia3P0I2SZwg5Olw5S/kP7f0wbXS8UC7eb47CdChr3jvQhbeOSiL gL6LwT3u1hePySGM+5/qBNdwy1jDZP
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There's a cut'n'paste error in the logging for our test for reading register
state back via ptrace, correctly say that we did a read instead of a write.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index 0cf78360c5bc..a3c1e67441f9 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -261,7 +261,7 @@ static void ptrace_sve_fpsimd(pid_t child, const struct vec_type *type)
 	}
 
 	ksft_test_result((sve->flags & SVE_PT_REGS_MASK) == SVE_PT_REGS_FPSIMD,
-			 "Set FPSIMD registers via %s\n", type->name);
+			 "Got FPSIMD registers via %s\n", type->name);
 	if ((sve->flags & SVE_PT_REGS_MASK) != SVE_PT_REGS_FPSIMD)
 		goto out;
 
-- 
2.30.2

