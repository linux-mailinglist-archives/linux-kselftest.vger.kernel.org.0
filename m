Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D110C711FFA
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 08:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjEZGao (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 02:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240106AbjEZGan (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 02:30:43 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A4E194;
        Thu, 25 May 2023 23:30:40 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1685082638;
        bh=RAbYTOkR9A0ym0EzB+gSWyfmDRdU2r2QaEMUXv5iurc=;
        h=From:Subject:Date:To:Cc:From;
        b=gnoTh5vKyLlLdUS2qiq810LTafYxyXFX+dlF8w5OqW6zN+2SQX0p8flOkXMNPr3mj
         UUz3XEIenJN9ySfc30DggfI8yIUPvX0AApdsm3bdoifhHU1yh9dmx2edUkj+YZtj5z
         NLWIcoiDPYfMr/T1JYK7PR/9La0JQ26Ily7auedI=
Subject: [PATCH 0/2] tools/nolibc: avoid coredumps and speed up tests
Date:   Fri, 26 May 2023 08:30:34 +0200
Message-Id: <20230526-nolibc-test-no-dump-v1-0-62e724a96db2@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAApScGQC/x2NSwrDMAwFrxK0riB2cX9XKVn4ozQCVwlWUgohd
 6/o7s2DYXZQakwKj26HRh9WnsXAnTrIU5QXIRdj8L0/98FfUObKKeNKutrGsr0XjC65cg/hWsY
 bmJmiEqYWJU/mylarnUujkb//1HM4jh9x4McoegAAAA==
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685082637; l=723;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=RAbYTOkR9A0ym0EzB+gSWyfmDRdU2r2QaEMUXv5iurc=;
 b=SwsXggUgP3GuJ1UWbF1pa7tdK1xOMZxItaSamgtL3P+K8KMC+BERXafjDp8f0l3zzK9ecf98u
 FcrXpui+iR8CLQ9QnPCPahk9Z2Zogq4uRyNpmXVfo1FXe6BG8lFnuDZ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Small optimization to avoid coredump writing during the stack protector
tests.
Adds prctl() as prerequisite.

This series is based on nolibc/20230524-nolibc-rv32+stkp4

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (2):
      tools/nolibc: add support for prctl()
      selftests/nolibc: prevent coredumps during test execution

 tools/include/nolibc/sys.h                   | 27 +++++++++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  3 +++
 2 files changed, 30 insertions(+)
---
base-commit: 1974a2b5fd434812b32952b09df7b79fdee8104d
change-id: 20230526-nolibc-test-no-dump-a1b1d9557df8

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

