Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6108463FCFF
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 01:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiLBA0v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 19:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiLBA0W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 19:26:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FFD30569
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 16:21:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15895B8206B
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 00:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1D6C433C1;
        Fri,  2 Dec 2022 00:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669940480;
        bh=fL/6WmOwOcUiyYILwtFYkRkQ5IlKeow+Hdrl+aYodck=;
        h=From:To:Cc:Subject:Date:From;
        b=TM4kWkfkJJyOqzMmsH9drWdcdVvtXIvJ4sjLCJsNHN9Xl/Er9EWen6R9op5lu4Wo1
         WkHROCt/V9Ufgjizkndgi+fwaigDrUPvUV1/VtMFCD0QMhHhYxpi9NVW7/DddW7ndM
         aj8vDF7e1aQoYRKzR23Zt/8y/XSGZULR7StUmqnAl/MeuspMwuUD3RpeHldV7cjLto
         pgyjKgCCgM4X4jkAZHA4ZcHbrMlyepL4dsO8QOvu9udk848T841vCyjCmQGIpokXQO
         WfQjSyJB/QlgCTowo9h6de4BHUhqDulN00q/Hm560VYmaYfKsGvhOCB03jM8Erwcc+
         JolfDPHBovcYQ==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 0/7] kselftest/alsa: pcm-test improvements
Date:   Fri,  2 Dec 2022 00:17:42 +0000
Message-Id: <20221202001749.3321187-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2384; i=broonie@kernel.org; h=from:subject; bh=fL/6WmOwOcUiyYILwtFYkRkQ5IlKeow+Hdrl+aYodck=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjiUQl9GC151uJWADOqctcgBEp0CD5e0lJ4Ihketwg d9M4Cd2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4lEJQAKCRAk1otyXVSH0Og9B/ wMVcAbBcDjoXq7wq31DxAq7AUPXVvvp0LB6/WvzKkgIIF9ZYeNxiR8Vmt3CcxSIyTQaXTiJG4UFicw krxykVVRIQEwhQhslnp+kXDv1WIj99M6gvoQ6r+VWL9VmnwIavglZ3Lr7uqC7g/mmpGrPQvzIW7NEn /PNmPHRE64rs0/62Sx8N+H3A9PuR4925EWZLV0GMNYFDRNP/u/4N+kYH+FDrpByUKSFT3vrmdFwzPs 01ArV/5hRroWuhqHZxovVE7wrziRRhSsqeGOnjj90AdYU89iO/toLAegKBYEPhzMhUqJjHGq00Ioln fryS7Ztm9EQJv/7xYvc/frBhvCmfci
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

This series provides a bunch of quick updates which should make the
coverage from pcm-test a bit more useful, it adds some support for
skipping tests when the hardware/driver is unable to support the
requested configuration, support for providing user visible descriptions
and then expands the set of cases we cover to include more sample rates
and channel counts.  This should exercise switching between 8kHz and
44.1kHz based rates and ensure that clocking doesn't get confused by
non-stereo channel counts, both of which are I expect common real world
errors, at least for embedded cards.

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

Jaroslav Kysela (1):
  kselftest/alsa: pcm - move more configuration to configuration files

Mark Brown (6):
  kselftest/alsa: pcm - Drop recent coverage improvement changes
  kselftest/alsa: pcm - Always run the default set of tests
  kselftest/alsa: pcm - skip tests when we fail to set params
  kselftest/alsa: pcm - Support optional description for tests
  kselftest/alsa: pcm - Provide descriptions for the default tests
  kselftest/alsa: pcm - Add more coverage by default

 tools/testing/selftests/alsa/Makefile         |   2 +-
 tools/testing/selftests/alsa/alsa-local.h     |   3 +
 tools/testing/selftests/alsa/conf.c           |  26 ++-
 .../alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf  |  43 ++--
 tools/testing/selftests/alsa/pcm-test.c       | 205 ++++++++++++------
 tools/testing/selftests/alsa/pcm-test.conf    |  63 ++++++
 6 files changed, 250 insertions(+), 92 deletions(-)
 create mode 100644 tools/testing/selftests/alsa/pcm-test.conf


base-commit: 7d721baea138696d5a6746fb5bce0a510a91bd65
-- 
2.30.2

