Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D143E765692
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 16:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjG0O66 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 10:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjG0O66 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 10:58:58 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7766B6;
        Thu, 27 Jul 2023 07:58:55 -0700 (PDT)
X-QQ-mid: bizesmtp71t1690469923tm5lzrrx
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 27 Jul 2023 22:58:42 +0800 (CST)
X-QQ-SSF: 01200000002000D0X000B00A0000000
X-QQ-FEAT: PS/N6jJLnDaqPADgID7l82JsHc7nT69du5VrDLrkkBLC6w5tY633bvrsPIV4j
        x4uJbunzn3CMcGecH3VSyM8fZiqEZfuKsDi9KYSt77yOaX3MVdwv8dXKhsrapkJ4ImfR9an
        Zozf9evXbydg0oxFzhsn+eCjvqChRlMIWZPmIz/12/vq0OUKWOmLtYpF3y3dRzlBEmW2Zur
        vW4zslEAlP5D1lC3+ukR18Zyx1qShvJzj6jEb6g/uYm7KkNcgxaUP2TLvaK1S7zb2FwmzaD
        tl8NA4srmM7656PY0VmXmukr5aMZXrZ66HxQ+8MZjPm5vFJMqTeGXZ7ao5Kc7x/ayULBfH7
        9i+UQcoAHXY0Gnh4uJzlMqSu9Ew0ANF/wMUzGyCKZnNwIYfWbmGpnlztNMIOw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11436596048244522817
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v3 0/7] tools/nolibc: add 32/64-bit powerpc support
Date:   Thu, 27 Jul 2023 22:58:38 +0800
Message-Id: <cover.1690468707.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy, Thomas

v3 here is to fix up two issues introduced in v2 powerpc patchset [1].

- One is restore the wrongly removed '\' for a '\$$ARCH'

- Another is add the missing $(ARCH).config for ppc, the default variant
  for powerpc is renamed to ppc in v2 (as discussed with Willy in [2]), but
  ppc.config is missing in v2 patchset, not sure why this happen, may a
  'git clean -fdx .' is required to do a new test, just did it.

Btw, the v3 tinyconfig-part1 for powerpc is ready, I will send it out
soon.

Best regards,
Zhangjin
---
[1]: https://lore.kernel.org/lkml/cover.1690373704.git.falcon@tinylab.org/
[2]: https://lore.kernel.org/lkml/ZL9leVOI25S2+0+g@1wt.eu/

Zhangjin Wu (7):
  tools/nolibc: add support for powerpc
  tools/nolibc: add support for powerpc64
  selftests/nolibc: add extra configs customize support
  selftests/nolibc: add XARCH and ARCH mapping support
  selftests/nolibc: add test support for ppc
  selftests/nolibc: add test support for ppc64le
  selftests/nolibc: add test support for ppc64

 tools/include/nolibc/arch-powerpc.h           | 202 ++++++++++++++++++
 tools/include/nolibc/arch.h                   |   2 +
 tools/testing/selftests/nolibc/Makefile       |  46 +++-
 .../selftests/nolibc/configs/ppc.config       |   3 +
 4 files changed, 246 insertions(+), 7 deletions(-)
 create mode 100644 tools/include/nolibc/arch-powerpc.h
 create mode 100644 tools/testing/selftests/nolibc/configs/ppc.config

-- 
2.25.1

