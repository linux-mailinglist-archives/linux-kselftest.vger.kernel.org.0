Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C1E3BC913
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jul 2021 12:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhGFKMf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jul 2021 06:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhGFKMf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jul 2021 06:12:35 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB658C061762
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Jul 2021 03:09:56 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:fd03:2275:4427:8d01])
        by laurent.telenet-ops.be with bizsmtp
        id Rm9u250052pudom01m9u5w; Tue, 06 Jul 2021 12:09:54 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m0i1Z-007CxH-Ii; Tue, 06 Jul 2021 12:09:53 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m0i1Z-00FxWi-1g; Tue, 06 Jul 2021 12:09:53 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Trent Piepho <tpiepho@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/2] math: RATIONAL and RATIONAL_KUNIT_TEST improvements
Date:   Tue,  6 Jul 2021 12:09:43 +0200
Message-Id: <20210706100945.3803694-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

	Hi all,

This patch series makes the RATIONAL symbol tristate, so it is not
forced builtin if all users are modular, and makes the
RATIONAL_KUNIT_TEST depend on RATIONAL, to avoid enabling RATIONAL if
there are no real users.

Changes compared to v1:
  - Drop compile-testing and help text for RATIONAL.
  - Make RATIONAL_KUNIT_TEST depend on RATIONAL.

Thanks for your comments!

[1] https://lore.kernel.org/r/20210705114633.1500710-1-geert@linux-m68k.org/

Geert Uytterhoeven (2):
  math: Make RATIONAL tristate
  math: RATIONAL_KUNIT_TEST should depend on RATIONAL instead of
    selecting it

 lib/Kconfig.debug   | 3 +--
 lib/math/Kconfig    | 2 +-
 lib/math/rational.c | 3 +++
 3 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
