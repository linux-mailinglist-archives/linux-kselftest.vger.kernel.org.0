Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C36C498757
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jan 2022 18:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbiAXR41 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 12:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244557AbiAXR4Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 12:56:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA8FC06173B
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 09:56:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F1FB6134F
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 17:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531B9C340E5;
        Mon, 24 Jan 2022 17:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046983;
        bh=j/gEX77Ep/TFQTQE/l5vF5wpUw8sbrtrlFYG2lJTUgk=;
        h=From:To:Cc:Subject:Date:From;
        b=fsL65306k2CREcI8NZIzUTAiUNp22F0dkTi3Qiv1yl8l3JqWzWwsDlgO425iirYX3
         D7Jv6bgJ+2zsCjF5S9BEhAr2B3rjzUyDuz/nG1pcBi1J2DLoTvH1uMeF0EyerGXrph
         jNDQNAU1YGgKP1fW7vuc7nQLsc+iHSCHBNszIFL1IFts704gJw2S1bDWU9Vi5acoq+
         Ptu6uzgfQLilArC1fEp8HWtjBUrAti5QSkl4jXXZK/uFviqlXGFPZTpiMvk5H99pVZ
         Va1S/g/RTCeqJ96VkpHqKqOnqZEc3j+dISJDQ6OiQTr8g22U3wifQHUsaa3JIwi1at
         c/ort46cbNI/g==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 0/2] kselftest/arm64: Small fixes for sve-ptrace test
Date:   Mon, 24 Jan 2022 17:55:25 +0000
Message-Id: <20220124175527.3260234-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=493; h=from:subject; bh=j/gEX77Ep/TFQTQE/l5vF5wpUw8sbrtrlFYG2lJTUgk=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh7ugMkejbcjCcRxfKqPQbP+o9W3l1O0SQTqhWAUy2 q7R4VOWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYe7oDAAKCRAk1otyXVSH0HoIB/ wNhw9b43Pz7waCRSStQ4le4n8alkjpSIB0NBGoSpmTOLspiF8f//OpbDIftEaLg5vaRu/KGuYs2Rsg 05wWzaI4MYKO/Nh3hnM+5/hpia8ueAcmRR71B4i6Wu05Q5N5g6bi4mA8fjm4ZwerFu/OlhbmXw5SSe coTgi2cDyxh5injirFR2Yp13brPgaiaY7DfypG1CA0sDL2ivpsot++LaLv67F6pTl9Qaha7/bP646r khNbSdkAguJuNND/vEChdvfgNqm43FjP4mhMF9Xtv5DgCv8zSS1rP3eYAcgRUtYoxl4889xfAIiElq FKyrAAJWm/h97pgqIcKPsE+yFol0E2
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A couple of fairly minor fixes for the sve-ptrace test, one output thing
and one for an issue which would generate spurious false positives.

Mark Brown (2):
  kselftest/arm64: Skip VL_INHERIT tests for unsupported vector types
  kselftest/arm64: Correct logging of FPSIMD register read via ptrace

 tools/testing/selftests/arm64/fp/sve-ptrace.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)


base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
-- 
2.30.2

