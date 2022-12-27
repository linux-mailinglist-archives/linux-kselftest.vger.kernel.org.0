Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CB8656D35
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 18:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiL0RHW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Dec 2022 12:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiL0RHV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Dec 2022 12:07:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87F4BD0;
        Tue, 27 Dec 2022 09:07:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AD0D611BC;
        Tue, 27 Dec 2022 17:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53395C433EF;
        Tue, 27 Dec 2022 17:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672160839;
        bh=3ZqYhqiXtAyvi8Q7fMoUgAIsy3lZvzcW6OONX2fXOhU=;
        h=From:Subject:Date:To:Cc:From;
        b=CCaknGvMXwN9QPnEKLEEYTIwoZwLOm9b/S+FyHjOECokpkK0ktvN8jfx4ZrVqBEkg
         iVyOyOBZTsEPkc3ve9nShbJYvTdmhb++em+HvtH3DJQUt5AGI3o/fwmTV+zdOFnHD8
         8vM9bYrho0EGxPWpooiY6ssBZLGO2qDgufloiTERqC4YBYGDGFxu3y2aiVT+/665sw
         A3xSCmLkr0mD8bVUCm1s08NA5te/fzcewn8afPl8eMHJXmXhmrvUwV48oNEY86bvJN
         8fA8ePdI99cg0L6se1tvYsmp3tcq11KCNEY+yuEdoVBiEoVDB5gj3dt6gL+lEC3feW
         7VmMA28ef6c+Q==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 0/7] kselftest/alsa: pcm-test improvements
Date:   Tue, 27 Dec 2022 17:06:46 +0000
Message-Id: <20221208-alsa-pcm-test-hacks-v4-0-5a152e65b1e1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACcmq2MC/02NQQ6CMBBFr0K6tkgHAujKexgXQxloA7RkhhgTw
 t0trly+/Pz3diXEnkTds10xvb34GBJUl0xZh2Ek7fvECgoAA0WrcRbUq130RrJph3YSPdTWIDZ1
 14NV6dmhkO4Yg3XnN7IffbguKBvxua9Mg//8qs9X4oFj8jkm/G9BUZimuuVlCca0jYakjDF4ekz
 EgeY88qiO4ws7P+6+wwAAAA==
To:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-7ab1d
X-Developer-Signature: v=1; a=openpgp-sha256; l=2778; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3ZqYhqiXtAyvi8Q7fMoUgAIsy3lZvzcW6OONX2fXOhU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjqyY/pbutDd6Y4yp8LnfxN6ot/hPhK5ehtPpAM1Fe
 kTbDSymJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY6smPwAKCRAk1otyXVSH0DnMB/
 9fT47XsKKQjVBcOm90UZTpz+kJQzTrKRetYFtwZIAFYJpitsPVIsv1KCVjdTj0q6ZWdSrujaA5YXWG
 lngOh4K+/ZebTNX6G8fcIY2KkCa8PunjSCofxyDiNwZn8vdV7zXgWzCI4ahbapQkzqJHdSLm5qOrKI
 Yd9swXb65dLOI1KxcsO/hD+MhMLFTX2UsFcn5Y7+9T6oDb2KBbPJB7Ozs7dBLLNbxwzq8DvDxm6drJ
 1AQtVOpkUe7n5lQRYqtrz6WmwnR/LXIXy+VAeOxEKA1tLiYwuLya+WHhGycrrQXgTWNC+C/7F3sOEb
 wBf0bUiB/9vOa8fX+/IKZNV3fQyE+G
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series provides a bunch of quick updates which should make the
coverage from pcm-test a bit more useful, it adds some support for
skipping tests when the hardware/driver is unable to support the
requested configuration, support for providing user visible descriptions
and then expands the set of cases we cover to include more sample rates
and channel counts.  This should exercise switching between 8kHz and
44.1kHz based rates and ensure that clocking doesn't get confused by
non-stereo channel counts, both of which are I expect common real world
errors, at least for embedded cards.

v4:
 - Rebase onto v6.2-rc1.
v3:
 - "Rebase" onto Takashi's current tree (with a revert).
 - Include Jaroslav's changes to specify all tests in the configuration
   file parsing.
 - Add a new "description" field to the configuration instead of trying
   to name the tests.
 - Always run both default and per-system tests, logging our success at
   setting the per-system configurations as a separate test since they
   shouldn't fail.
v2:
 - Rebase onto Takashi's current tree.
 - Tweak the buffer sizes for the newly added cases, don't be quite
   so ambitious in how big a buffer we request for 96kHz and don't
   go quite so small for 8kHz since some devices start hitting lower
   limits on period size and struggle to deliver accurate timing.

To: Takashi Iwai <tiwai@suse.com>
To: Jaroslav Kysela <perex@perex.cz>
To: Shuah Khan <shuah@kernel.org>
Cc: alsa-devel@alsa-project.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

---
Jaroslav Kysela (1):
      kselftest/alsa: pcm - move more configuration to configuration files

Mark Brown (6):
      kselftest/alsa: pcm - Drop recent coverage improvement changes
      kselftest/alsa: pcm - Always run the default set of tests
      kselftest/alsa: pcm - skip tests when we fail to set params
      kselftest/alsa: pcm - Support optional description for tests
      kselftest/alsa: pcm - Provide descriptions for the default tests
      kselftest/alsa: pcm - Add more coverage by default

 tools/testing/selftests/alsa/Makefile              |   2 +-
 tools/testing/selftests/alsa/alsa-local.h          |   3 +
 tools/testing/selftests/alsa/conf.c                |  26 ++-
 .../alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf       |  43 +++--
 tools/testing/selftests/alsa/pcm-test.c            | 205 ++++++++++++++-------
 tools/testing/selftests/alsa/pcm-test.conf         |  63 +++++++
 6 files changed, 250 insertions(+), 92 deletions(-)
---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20221208-alsa-pcm-test-hacks-f6c1aa76bd2c

Best regards,
-- 
Mark Brown <broonie@kernel.org>
