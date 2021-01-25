Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9424E3047AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Jan 2021 20:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbhAZF6R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Jan 2021 00:58:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:39526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbhAYMqX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Jan 2021 07:46:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 433DE229EF;
        Mon, 25 Jan 2021 12:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611578740;
        bh=56tdACcGGHFZFmeBO08RKmJkzc4zo0dNrypPmbndIvE=;
        h=From:To:Cc:Subject:Date:From;
        b=ELK6YOHuJmo+Zj67jVaKWqSYNUu9XLe/QuKcN06FLPeeDWAVm/KtFxMcH3iXXgwh4
         9cJVZp2/iBnjGto6GUvby/wMrYKlHbvazXwQEchiOcJ6WrRyVwiqzT1PAUlR+12F3c
         cAKsjT5XPq4omzuUCtXLDy6mt98opSLzdPDlNfKuTMeBS9BNQmrnOPHlbXzBw/PxeQ
         TQzQuWcFlAEFnlXDsVTD95oljHl1253XO0zMWfgnrK4+DpLKMdvw13/ctqyKxSIAk7
         gxWnboyIFHrkbCkmSqJTLNj22GgmrAFA8nuRkiiuUaC9mtgKDOFiknfpO8xHnDRE6u
         23ElbZ+qGaVig==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: [RFC 0/3] kunit vs structleak
Date:   Mon, 25 Jan 2021 13:45:25 +0100
Message-Id: <20210125124533.101339-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

I ran into a couple of problems with kunit tests taking too much stack
space, sometimes dangerously so. These the the three instances that
cause an increase over the warning limit of some architectures:

lib/bitfield_kunit.c:93:1: error: the frame size of 7440 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
drivers/base/test/property-entry-test.c:481:1: error: the frame size of 2640 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
drivers/thunderbolt/test.c:1529:1: error: the frame size of 1176 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

Ideally there should be a way to rewrite the kunit infrastructure
that avoids the explosion of stack data when the structleak plugin
is used.

A rather drastic measure would be to use Kconfig logic to make
the two options mutually exclusive. This would clearly work, but
is probably not needed.

As a simpler workaround, this disables the plugin for the three
files in which the excessive stack usage was observed.

      Arnd

Arnd Bergmann (3):
  bitfield: build kunit tests without structleak plugin
  drivers/base: build kunit tests without structleak plugin
  thunderbolt: build kunit tests without structleak plugin

 drivers/base/test/Makefile   | 1 +
 drivers/thunderbolt/Makefile | 1 +
 lib/Makefile                 | 1 +
 3 files changed, 3 insertions(+)

Cc: Kees Cook <keescook@chromium.org>
Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Vitor Massaru Iha <vitor@massaru.org>
Cc: linux-hardening@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
Cc: linux-kernel@vger.kernel.org
-- 
2.29.2

