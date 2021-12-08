Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FD146DD7C
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 22:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbhLHVV0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 16:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhLHVV0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 16:21:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43931C061746
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Dec 2021 13:17:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AFC1B822DD
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Dec 2021 21:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18597C00446;
        Wed,  8 Dec 2021 21:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638998270;
        bh=2FpH5VoXr9ueY5bDrwm6B2Tr7onF5v+ChxxrbUuG+c4=;
        h=From:To:Cc:Subject:Date:From;
        b=Yrr3NmueTLsshhKaA0OTAVsBNNaEOqI0SplQLGafRKHlZV9Rg+BWlODz5fkO2qZjx
         shKfp5iTSQ2TrZX0UGSYFvTyexHp2L1p7BaWbxHrmcuoEJpcqo7YBVWCnmZQpfMmO4
         vnyv3Qyipi42SA/NgHxhaI1GYa5X1rP3jY8ycfzuaFYHrUF10+c7QQTnVzS5GzZ/uJ
         Z1F4yc0ORMJY4sJrTwO2p/Aur0yshIJ3awaQoHiIznCs8ca0/NCCvA4np26Ifu5l6A
         hp7dEt4KnenPx8I75oRwlbSi/f+sfRrxEP01AMh7Yb4aMDKyuH4vjO9bOzL8szol+d
         FeNoL9z7fmN5g==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 0/3] kselftest: alsa: Add basic mixer selftest
Date:   Wed,  8 Dec 2021 21:17:42 +0000
Message-Id: <20211208211745.533603-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333; h=from:subject; bh=2FpH5VoXr9ueY5bDrwm6B2Tr7onF5v+ChxxrbUuG+c4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhsSD1HVS5LAtgAeA5KjgYRZbZjE0afMZo56TjpTcw pW5Bls2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYbEg9QAKCRAk1otyXVSH0KBeB/ 0dZ+rG5/EXHfvNPwe4qrkUcWql9pkBALACyp40hoSflqojOri1+5Xn+Mmk92m4uau3QlGZLU/+bxG2 QngGXfYMsBBDF89jj3pxn7fG5mIeCRjnqxx3xxSPy/pPowa/c2IwBGJPsQd/mn1VP144SbkB+Q5Fn5 ov9DQUTEbI5E5M7vv6JqcD0grTwVhdL/tNkUSjKTPrYoZzo0yeB67HPSbltxUW5g/xpSskX5MDqq9G NI+WGJwRqhfrA6KJRkSjl0UfgRjDpkRQJqDL2BcWGZDqpOkFdOuzQ6YXBxNvKVFUOBYeF0N7hs7vKO trA9xVBFAia3mhLmB9fxrMTAovH4WN
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series adds a basic selftest for the mixer interface, as discussed
in the cover letter for the main patch there's plenty of additional
coverage that could be added but this is a good starting point.

v3:
 - Pull in incremental updates adding a fixed library configuration from
   Jaroslav and support for volatile controls from Takashi Sakamoto.
 - Stylistic updates suggested by Shuah.
v2:
 - Use pkg-config to get CFLAGS and LDLIBS for alsa-lib.

Jaroslav Kysela (1):
  kselftest: alsa: Use private alsa-lib configuration in mixer test

Mark Brown (1):
  kselftest: alsa: Add simplistic test for ALSA mixer controls kselftest

Takashi Sakamoto (1):
  kselftest: alsa: optimization for SNDRV_CTL_ELEM_ACCESS_VOLATILE

 MAINTAINERS                               |   8 +
 tools/testing/selftests/Makefile          |   3 +-
 tools/testing/selftests/alsa/.gitignore   |   1 +
 tools/testing/selftests/alsa/Makefile     |   9 +
 tools/testing/selftests/alsa/mixer-test.c | 663 ++++++++++++++++++++++
 5 files changed, 683 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/alsa/.gitignore
 create mode 100644 tools/testing/selftests/alsa/Makefile
 create mode 100644 tools/testing/selftests/alsa/mixer-test.c


base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
-- 
2.30.2

