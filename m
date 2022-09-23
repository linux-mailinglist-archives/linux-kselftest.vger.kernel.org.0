Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AB05E788D
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Sep 2022 12:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiIWKnn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Sep 2022 06:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiIWKnc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Sep 2022 06:43:32 -0400
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996851129D4
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Sep 2022 03:43:31 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MYpf75bC2zMqBrF;
        Fri, 23 Sep 2022 12:43:27 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MYpf71WHBzMpnPk;
        Fri, 23 Sep 2022 12:43:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1663929807;
        bh=uSg7A5h8Ds8U3JESiel2hWeoIMHZGPIKjv8p4UrWwvg=;
        h=From:To:Cc:Subject:Date:From;
        b=jEVqym8Jnw4LyNOzTSRyROirzSZM4326S4ySqaLhO4Q/w1O3hJXCepNHYNlQjHkqi
         sVgCHGcw0pzAq6tEN2S01B0jYRyZ+Gm4j+R3z2vRXaImC247k91d6q1vAo3Q+uuOxw
         GjHOLZS0Zhd0Wm3s+WgOiCU/piIULJSfcUaNA0h4=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Anders Roxell <anders.roxell@linaro.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock fix for v6.0 #2
Date:   Fri, 23 Sep 2022 12:43:22 +0200
Message-Id: <20220923104322.3182116-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Linus,

This change fixes out-of-tree builds for Landlock tests, which was
initially identified here:
https://lore.kernel.org/r/CADYN=9JM1nnjC9LypHqrz7JJjbZLpm8rArDUy4zgYYrajErBnA@mail.gmail.com

Please pull this Landlock fix for v6.0-rc7 .  This change merged
cleanly with your tree, and have been successfully tested in the latest
linux-next releases for a week.

Regards,
 Mickaël

--
The following changes since commit 80e78fcce86de0288793a0ef0f6acf37656ee4cf:

  Linux 6.0-rc5 (2022-09-11 16:22:01 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.0-rc7

for you to fetch changes up to a52540522c9541bfa3e499d2edba7bc0ca73a4ca:

  selftests/landlock: Fix out-of-tree builds (2022-09-14 16:37:38 +0200)

----------------------------------------------------------------
Landlock fix for v6.0-rc7

----------------------------------------------------------------
Mickaël Salaün (1):
      selftests/landlock: Fix out-of-tree builds

 tools/testing/selftests/landlock/Makefile | 19 ++++++++++---------
 tools/testing/selftests/lib.mk            |  4 ++++
 2 files changed, 14 insertions(+), 9 deletions(-)
