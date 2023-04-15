Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB2F6E33D9
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Apr 2023 23:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjDOV2x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Apr 2023 17:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjDOV2w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Apr 2023 17:28:52 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7762430D8;
        Sat, 15 Apr 2023 14:28:50 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1681594128;
        bh=ffuzWbsBT4I0Dzm1ac4bREAFCsDITc0shbz2IoN6G7s=;
        h=From:Subject:Date:To:Cc:From;
        b=JQ91D5LOfZi7AADvHsorsBSrap9gQCs8WEn0nMe8bBwPKEMCzeBDCX6OKzrKIRpwt
         xUynC+oE2TFmFmP9/5/2YCcvi7szYJv52lxYwCqzHrYvd+pP8OeOD/lpBii3kO/uaj
         agOxYkduxAOiU+wS4nrfXQDiMUcwL8KNBxewqJq0=
Subject: [PATCH 0/2] tools/nolibc: fork: fix on s390 and add test
Date:   Sat, 15 Apr 2023 23:28:46 +0200
Message-Id: <20230415-nolibc-fork-v1-0-9747c73651c5@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAA4XO2QC/x2NSQrDMAwAvxJ0rsDOTr5SerBdpRExcpBpKYT8v
 aLHGRjmhErKVGFpTlD6cOUiBv7WQNqCvAj5aQytazvX+wGlZI4J16I7xsnNU+j6wY8jWBFDJYw
 aJG3WyDtnk4fSyt//4v64rh8WSOKecgAAAA==
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681594127; l=927;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ffuzWbsBT4I0Dzm1ac4bREAFCsDITc0shbz2IoN6G7s=;
 b=NT6hmRBQG7jQ+hw3g97sTAG6HwkeHoAj7Vr246YpEyxNiOXxpnKGk8rbLG7vK6UPH9v6ByOiZ
 R9vZTgycSdFAY3WiAD5lubtvCE2s1Z96Pu93wFWFKPmTPxnBg1I37Ok
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The generic fork() implementation in nolibc falls back to the clone()
syscall. On s390 the first two arguments to clone() are swapped compared
to other architectures, breaking the implementation in nolibc.

Add a custom implementation of fork() to s390 that works.

While at it also add a testcase for fork().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (2):
      tools/nolibc: s390: provide custom implementation for sys_fork
      tools/nolibc: add testcase for fork()/waitpid()

 tools/include/nolibc/arch-s390.h             |  8 ++++++++
 tools/include/nolibc/sys.h                   |  2 ++
 tools/testing/selftests/nolibc/nolibc-test.c | 20 ++++++++++++++++++++
 3 files changed, 30 insertions(+)
---
base-commit: c1c4f33b6be9b3412d9e0ba01b367f4ffe47c379
change-id: 20230415-nolibc-fork-b7087a345166

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

