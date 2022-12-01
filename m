Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744C763F5F5
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 18:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiLARKw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 12:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiLARKw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 12:10:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EBAA897B
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 09:10:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10B6462095
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 17:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A77C433D6;
        Thu,  1 Dec 2022 17:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669914650;
        bh=4P1OLKqn7MEyXJREvUvZOjiyLHEARCRdaDxzVt3dJw0=;
        h=From:To:Cc:Subject:Date:From;
        b=ZjHG9JnEdHwUAntAgA1QQcfj/qXN2VzzTvK4oOifait2ONvOQTnI2peiRxpVb8BUE
         +ZCw6lh7sd9b+ypHaKKZtIfmLlLK1A+3y1Vkmo9SYbrXf+62NjQQW/BVVSRTkVZ7DO
         IU8AGddDxTw+RLJ84Ae7JRjiqIzeDWyCRM55IE26QcpsubOWTJEYPmM9d/Sdj766pp
         MaqndX0JhyVECWdP3XAqulbveA7qAqwtTn9UiIqRRx5CEzaciY2JfR89QYB8qA3hRc
         HWUlPCw9pgUnp2gwJucEaiFX4jEwzbDdvM2iusRfGXDTn7PrJr+NyKRm9dCsav9R6C
         Zn7jDyJJikF6g==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 0/6] kselftest/alsa: pcm-test improvements
Date:   Thu,  1 Dec 2022 17:07:39 +0000
Message-Id: <20221201170745.1111236-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1578; i=broonie@kernel.org; h=from:subject; bh=4P1OLKqn7MEyXJREvUvZOjiyLHEARCRdaDxzVt3dJw0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjiN9bww8um6NZydnGG5sorVUm7m+rnEclQ+vSFJr6 lbAYyfaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4jfWwAKCRAk1otyXVSH0FxUB/ 9Euf2H6ndJuq2UJUTOJ31PfZ/zMDyjrSbntrThjHfj/F84K/FPcC+SgXXZnFeC9C4MtO59ThtK0yte E/Yz+EtaioW+Uvrwy968Ir6nGWaSBh4AdNvy3fijse6wtJEp4oI1Tw3nx0Ux1sozQD2rBEn/qseBYT QuOt+FhYLE+RyFUfkxhKVvKtshIv8PY7x81opuiZwEF6M4AJjHK9N4nSl6dxRGjE1LVkKaYVfTLtww ekX2hu5DlzNWBjO2WQ8Gzi6DD8LeOvjxfdx/fEtDmm6KYxSlJ19EUKMPwQoCafEAAgKSINpKaVxZeL +fV0N5S21HtNNd1iWGq5RyNUvrIWTa
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
requested configuration and then expands the set of cases we cover to
include more sample rates and channel counts.  This should exercise
switching between 8kHz and 44.1kHz based rates and ensure that clocking
doesn't get confused by non-stereo channel counts, both of which are I
expect common real world errors, at least for embedded cards.

v2:
 - Rebase onto Takashi's current tree.
 - Tweak the buffer sizes for the newly added cases, don't be quite
   so ambitious in how big a buffer we request for 96kHz and don't
   go quite so small for 8kHz since some devices start hitting lower
   limits on period size and struggle to deliver accurate timing.

Mark Brown (6):
  kselftest/alsa: Refactor pcm-test to list the tests to run in a struct
  kselftest/alsa: Report failures to set the requested sample rate as
    skips
  kselftest/alsa: Report failures to set the requested channels as skips
  kselftest/alsa: Don't any configuration in the sample config
  kselftest/alsa: Provide more meaningful names for tests
  kselftest/alsa: Add more coverage of sample rates and channel counts

 .../alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf  | 35 ++++----
 tools/testing/selftests/alsa/pcm-test.c       | 88 +++++++++++++------
 2 files changed, 81 insertions(+), 42 deletions(-)


base-commit: 2133dc91d6658242009177b564ac47c49e08668a
-- 
2.30.2

