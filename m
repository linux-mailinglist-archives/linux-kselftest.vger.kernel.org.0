Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2E27570EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 02:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGRAaF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 20:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjGRAaE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 20:30:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FA41A8
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jul 2023 17:30:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42980611E4
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 00:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47CBC433CA;
        Tue, 18 Jul 2023 00:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689640202;
        bh=snD0Eo/VYjRjGit1jZ3DB3f+21qBXC5DToerjkMGLGM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=EASJiqi7Ly00yQGpkuE68DknJ2uuk81E+xf84VkP6/LvzK2+EyM2xkKbswtkHeoqa
         tZ0ImiGE0GItbBWGDp6gmalV1wKrmCNt3+5SmOvCENeIQ/HTI6VyX9iaU86Z8QqfUT
         AYfaQTZ2BbRBghwtycDsx4i4xpGQ4bwqBKUBS9v0vkOqUlYnSOPTMMS0IUvSjcG4w8
         7snqjWeGqMXUCraC43lHkm+luQ0BSGEaihe7xxetFzr/ar6+tlrH++gxmGKWV4W/ha
         SqLgCzqeH3ShsHujBZY5lLl3SdNgAstuAl5BGOYfLY9vtnh1rXdadrOdmCYJ9o8roT
         +aT9GnK56QD5Q==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 18 Jul 2023 01:28:44 +0100
Subject: [PATCH v2 3/5] ALSA: Enable build with UML
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-asoc-topology-kunit-enable-v2-3-0ee11e662b92@kernel.org>
References: <20230718-asoc-topology-kunit-enable-v2-0-0ee11e662b92@kernel.org>
In-Reply-To: <20230718-asoc-topology-kunit-enable-v2-0-0ee11e662b92@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1000; i=broonie@kernel.org;
 h=from:subject:message-id; bh=snD0Eo/VYjRjGit1jZ3DB3f+21qBXC5DToerjkMGLGM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBktdz6QD6q9FAILvFmBY8HlF3zn6cc9gUPfjrQS
 OQ9Y5c72fKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLXc+gAKCRAk1otyXVSH
 0GOPB/9bMFYsS1o4LqHp876+Z8FMoLwbWJqrzAD4yRpkJGzYmmvjkgcmEgpoQ8PqIsWLwcS0lhH
 8KiyzGYfeVEPHd7KCfGFlAmYXUkUKdnOBPLJ+Soncc7w6AXIHvULLU+UFtXhbBYpGAmZfHl8Lue
 w1Fz3y2zUFXFwE6PgzipDZ+tKN5rEB4H2Jjzu2Dyk+VDqulT4CiOeOgZPTAvxOXpmOtlOL/pwAc
 QAWOaiK+37tXolRxEiy5fLptJL6lLbSyZr24lY6ptIkT6erfXvRB8fisEkf3eELagl9UHBHKZVE
 1pNTd21Jy4nepcNB44BulWg9iVtFUF2Au/W8kG86TJs4co6a
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order to facilitate testing using KUnit allow ALSA to build with UML,
it's not super useful at runtime but that's a user problem rather than
an actual dependency.  The apparent reason for the dependency was the
widespread use of iomem APIs in ALSA drivers, earlier patches in this
series have provided stubs for these APIs so that there are no build
time issues even without individual drivers having IOMEM dependencies
added.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/Kconfig b/sound/Kconfig
index 0ddfb717b81d..f0e15822e858 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -39,8 +39,6 @@ config SOUND_OSS_CORE_PRECLAIM
 
 source "sound/oss/dmasound/Kconfig"
 
-if !UML
-
 menuconfig SND
 	tristate "Advanced Linux Sound Architecture"
 	help
@@ -103,8 +101,6 @@ source "sound/virtio/Kconfig"
 
 endif # SND
 
-endif # !UML
-
 endif # SOUND
 
 config AC97_BUS

-- 
2.39.2

