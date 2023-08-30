Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C352878DABF
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 20:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbjH3ShC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 14:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245305AbjH3PHX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 11:07:23 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EB61A2;
        Wed, 30 Aug 2023 08:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1693408036;
        bh=olPyzDhqs26B6z19gSG24nZh7Mf+PO7lwrdSiPrhPtE=;
        h=From:Subject:Date:To:Cc:From;
        b=SKpmIWUzvlvRk9dEn83FkOMSkUs3TYrW78FO8GLvhmrfwIUwK/dCpnlhuGXUaYcXZ
         ZsHtx9tbMpXCFmcFLx+6wGBH4ZQfJeUKL//aGrgGAqVCJuuA1NWGhh1P5TrbG6iBp2
         oF8X4JSlChGPVBvNteMGLs0DO9AiLzUirMhwtbbI=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/2] nolibc: remove reliance on system headers
Date:   Wed, 30 Aug 2023 17:07:11 +0200
Message-Id: <20230830-nolibc-nostdinc-v2-0-c5b1387b4a77@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAB9b72QC/3WNwQrCMBBEf6Xs2Ug2QZt66n9ID5pszIKkkq1VK
 f13Y++ehjcwbxYQKkwCp2aBQjMLj7mC2TXg0yXfSHGoDEYbq51pVR7vfPU1ZAqcvTLadtqh1eH
 YQl09CkV+b8bzUDmxTGP5bAcz/tr/rhmVVl13COgQI0bbv4hFxKdn2meaYFjX9Qv6pE+4swAAA
 A==
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, Yuan Tan <tanyuan@tinylab.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693408035; l=1277;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=olPyzDhqs26B6z19gSG24nZh7Mf+PO7lwrdSiPrhPtE=;
 b=ufe5F1NEctrW0v3T91o1aSX7fwVQ0p9NmtkqxAoAE9yj+RK8h8W+9GfAI/KjxUUV3S8hwnk0C
 4vs8ttn3b7bAp1kz/qvJ2DQoL8MuB6ni9P+ssK8wmSk9oPhRSI5XSS2
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This was prompted by the discussion about output directory support with
O=.
It seems sometimes we were pulling in system headers making testing
annoying and unreliable.

Willy:

I did not implement the '#ifdef va_start` guard that we discussed
before. In my understanding the latest agreement does not need it
anymore. Please let me know if this is incorrect.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Adapt comment in nolibc.h
- <stdarg.h> -> "stdarg.h"
- Link to v1: https://lore.kernel.org/r/20230827-nolibc-nostdinc-v1-0-995d1811f1f3@weissschuh.net

---
Thomas Weißschuh (2):
      tools/nolibc: add stdarg.h header
      selftests/nolibc: use -nostdinc for nolibc-test

 tools/include/nolibc/Makefile           |  1 +
 tools/include/nolibc/nolibc.h           |  4 ++--
 tools/include/nolibc/stdarg.h           | 16 ++++++++++++++++
 tools/include/nolibc/stdio.h            |  3 +--
 tools/include/nolibc/sys.h              |  2 +-
 tools/testing/selftests/nolibc/Makefile |  2 +-
 6 files changed, 22 insertions(+), 6 deletions(-)
---
base-commit: 556fb7131e03b0283672fb40f6dc2d151752aaa7
change-id: 20230827-nolibc-nostdinc-203908130d67

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

